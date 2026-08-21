module('buildBase.BuildBasePowerPlantView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("buildBase/BuildBasePowerPlantView.prefab")
panelType = 2
isBlur = 1
destroyTime = 0
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
    self:setTxtTitle("快速充能")
end
-- 析构  
function dtor(self)
end

function initData(self)
    self.mStaminaHelper = 0
    self.mRate = sysParam.SysParamManager:getValue(5004) or 5
    self.max = sysParam.SysParamManager:getValue(5003) or 200
    self.mStrHelper = {}
    self.m_itemList = {}
    
end
-- 设置货币栏

-- 初始化
function configUI(self)
    self.mBtnConfirm = self:getChildGO("mBtnConfirm")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mTxtDroneNum = self:getChildGO("mTxtDroneNum"):GetComponent(ty.Text)
    self.mTxtStamina = self:getChildGO("mTxtStamina"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
    self.LyNumberStepper = self:getChildGO("LyNumberStepper"):GetComponent(ty.LyNumberStepperLongPress)
end

-- 激活
function active(self)
    super.active(self)
    buildBase.BuildBaseManager:addEventListener(buildBaseEvent.ON_CONVERT_UAV, self.onUpdateInfo, self)

    self:__updateItemList()
    self.LyNumberStepper:Init(self.max, 0, self.mRate, -1, self.onStepChange, self)
    self:setStepperMax()
    self:refreshTxt()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    buildBase.BuildBaseManager:removeEventListener(buildBaseEvent.ON_CONVERT_UAV, self.onUpdateInfo, self)
    self:recoverItemList()
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    local propsVo1 = props.PropsManager:getTypePropsVoByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID)
    local propsVo2 = props.PropsManager:getTypePropsVoByTid(MoneyTid.UAV_TID)
    self.mTxtName1.text = propsVo1:getName()
    self.mTxtName2.text = propsVo2:getName()
end



-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnConfirm, self.onClickConfirm)
    self:addUIEvent(self.mBtnCancel, self.onClickClose)
end

--MoneyBar
function __updateItemList(self)
    self:recoverItemList()
    local list = { MoneyTid.ANTIEPIDEMIC_SERUM_TID,MoneyTid.UAV_TID}
    for i = 1, #list do
        local item = MoneyItem:poolGet()
        item:setData(self.base_childTrans["MoneyBar"], { tid = list[i], frontType = self.frontType })
        item:getChildGO("mBtnGet"):SetActive(false)
        item:getChildGO("mBtnArea"):GetComponent(ty.Button).enabled = false
        table.insert(self.m_itemList, item)
    end
end

--回收MoneyBar
function recoverItemList(self)
    if next(self.m_itemList) then
        for _, item in pairs(self.m_itemList) do
            item:poolRecover()
            item = nil
        end
    end
    self.m_itemList = {}
end

function setStepperMax(self)
    local mUavCount = MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID)
    if mUavCount < self.max then
        self.LyNumberStepper.MaxCount = mUavCount > 0 and self.max - mUavCount or self.max
    else
        gs.Message.Show("无人机已达最大值")
    end

end


--计数器回调
function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        gs.Message.Show(_TT(4018))
        return
    elseif cusType == 2 then
        gs.Message.Show(_TT(4019))
        return
    end
    self.sum = cusCount + MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID) 

    if self.sum == self.max then 
        self.flag =true 
    else 
        self.flag =false 
    end 

    if self.flag == false then 
        if cusCount % self.mRate ~= 0 then 
            self.LyNumberStepper.CurrCount =  self.LyNumberStepper.CurrCount + (   self.mRate - cusCount % self.mRate )
        end
    end 

    self:refreshTxt()
end


function onUpdateInfo(self)
    self.LyNumberStepper.CurrCount = 0
    self:setStepperMax()
    self:refreshTxt()
    --gs.Message.Show("购买成功~")
end


function refreshTxt(self)
    self.mStaminHelper = math.ceil(self.LyNumberStepper.CurrCount / self.mRate)
    if self.mStaminHelper > MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID) then
        self.mStrHelper = {
            "X",
            "<color=#fa3a2b> ",
            self.mStaminHelper,
            "</color> "
        }
        self.mTxtStamina.text = table.concat(self.mStrHelper)
    else
        self.mTxtStamina.text = "X" .. self.mStaminHelper
    end
    self.mTxtDroneNum.text = "X" .. self.LyNumberStepper.CurrCount
    self.mTxtTips.text = _TT(76200,HtmlUtil:color( self.mStaminHelper,"d53529ff"), HtmlUtil:color(self.LyNumberStepper.CurrCount,"d53529ff"))
end

function onClickConfirm(self)
    local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID, self.mStaminHelper, true, false)
    if result then
        local all = self.LyNumberStepper.CurrCount + MoneyUtil.getMoneyCountByTid(MoneyTid.UAV_TID)
        if all > self.max then
            UIFactory:alertMessge(_TT(76026), true, function()
                GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_BUY_PRODUCE, { num = self.mStaminHelper })
                self:onClickClose()
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
            )
        end
        if all <= self.max then
            GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_BUY_PRODUCE, { num = self.mStaminHelper })
            self:onClickClose()
        else
            -- gs.Message.Show("超过无人机上限")
            self:onClickClose()
        end
    else
        UIFactory:alertMessge(tips, true, function()
            GameDispatcher:dispatchEvent(EventName.OPEN_ADD_STAMINA_PANEL, { isByProps = true, needCost = 0, callFun = nil, callObj = nil })
            self:onClickClose()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
        )
    end
end

-- 点击关闭
function onClickClose(self)
    self:close()
end

-- 关闭所有UI
function closeAll(self)

end
return _M
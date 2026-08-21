--[[ 
    主线关卡章节item
]]
module("stamina.AddStaminaPropsItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("stamina/AddStaminaPropsItem.prefab")

EVENT_ADD = "EVENT_ADD"
EVENT_CUT = "EVENT_CUT"

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mIsSelect = false
    self.mPropsVo = nil
    self.mPropsGrid = nil

end

function configUI(self)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mBtnConvert = self:getChildGO("mBtnConvert")
    self.mGroupProps = self:getChildTrans("mGroupProps")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtCurNum = self:getChildGO("mTxtCurNum"):GetComponent(ty.Text)
    self.mNumberStepper = self:getChildGO('mNumberStepper'):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(1, 1, 1, -1, self.onStepChange, self)
    self.mGroupItem = self:getChildGO("mGroupItem")

end

-- 由MonoBehaviour Start 调用
function onStart(self)
    self:showDOTween()
end

function showDOTween(self)
    local tween = self.UIObject:GetComponent(ty.UIDoTween)
    if not gs.GoUtil.IsCompNull(tween) and self:getTweenIndex() then
        if self.mGroupItem then
            self.mGroupItem:SetActive(false)
            self:onTweenStart(self:getTweenIndex())
        end
    end
end
-- 缓动顺序
function getTweenIndex(self)
    if type(self.mPropsVo) ~= "table" then
        return nil
    end
    return self.mPropsVo.tweenId
end

function onTweenStart(self, time)
    local function callTween()
        if (not gs.GoUtil.IsCompNull(self.UIObject:GetComponent(ty.UIDoTween))) then
            if self.mGroupItem then
                self.mGroupItem:SetActive(true)
                self.UIObject:GetComponent(ty.UIDoTween):BeginTween()
            end
        end
    end
    self.tweenTimeSn = LoopManager:addFrame(time, 1, self, callTween)
end
function active(self)
    super.active(self)
    self.mNumberStepper.CurrCount = 1
end

function deActive(self)
    super.deActive(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnConvert, self.onClickConvertHandler)
end

function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        -- '最大值'
        gs.Message.Show(_TT(26317))
    elseif cusType == 2 then
        -- '最小值'  
        gs.Message.Show(_TT(4019))
    end
    self:updatePrice(self.mNumberStepper.CurrCount * self.mPropsVo.effectList[1])
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mPropsVo = cusData

    if self.mPropsVo.count >= 1 then
        local ownNum = math.ceil(MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) / self.mPropsVo.effectList[1])
        local curSum = self.mPropsVo.count + ownNum
        local sumNum = math.floor(sysParam.SysParamManager:getValue(SysParamType.MAX_STAMINA) / self.mPropsVo.effectList[1])
        local max = curSum > sumNum and sumNum - ownNum or self.mPropsVo.count
        self.mNumberStepper.MaxCount = (max > 0) and max or 0
        self.mBtnConvert:GetComponent(ty.Image):SetImg(UrlManager:getCommon5Path("common_0163.png"), false)
        if max <= 0 then
            self.mNumberStepper.CurrCount = 0
            self:updatePrice(self.mPropsVo.effectList[1])
        end
    end
    if (not self.mPropsGrid) then
        self.mPropsGrid = PropsGrid:poolGet()
    end
    self.mPropsGrid:setData(self.mPropsVo, self.mGroupProps)
    self.mPropsGrid:setClickEnable(false)
    self.mTxtName.text = self.mPropsVo:getName()

    self:updatePrice(self.mPropsVo.effectList[1])
end

function onClickConvertHandler(self)
    if self.mNumberStepper.CurrCount > 0 then
        local list = {}
        local pt_use_tid_info = { tid = self.mPropsVo.tid, count = self.mNumberStepper.CurrCount, target = 0 }
        table.insert(list, pt_use_tid_info)
        GameDispatcher:dispatchEvent(EventName.USE_MORE_PROPS_BY_TID, list)
    else
        gs.Message.Show(_TT(26308))
    end
end

function updatePrice(self, curPrice)
    self.mTxtCurNum.text = "(" .. HtmlUtil:color("+" .. curPrice, "038008ff") .. _TT(26326) .. ")"
end
-- 移除
function destroy(self, isAuto)
    LoopManager:removeFrameByIndex(self.tweenTimeSn)
    if (self.mPropsGrid) then
        self.mPropsGrid:poolRecover()
        self.mPropsGrid = nil
    end
    super.destroy(self, isAuto)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
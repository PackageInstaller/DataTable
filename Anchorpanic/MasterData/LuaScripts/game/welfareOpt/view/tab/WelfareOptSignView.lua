--[[ 
-----------------------------------------------------
@filename       : WelfareOptSignView
@Description    : 出勤津贴(体力补给) (每日补给) 
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.welfareOpt.view.tab.WelfareOptSignView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/tab/WelfareOptSignView.prefab")

function ctor(self)
    super.ctor(self)
    --奖励item
    self.mPropsItems = {}
    --状态
    self.mStates = {}
    --配置信息
    self.mSupplyConfig = {}
    --初始化标记
    self.isInit = true
    --Timer下标记
    self.mSn = nil

end

-- 析构
function dtor(self)

end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mImgExpired_01 = self:getChildGO("mImgExpired_01")
    self.mImgExpired_02 = self:getChildGO("mImgExpired_02")
    self.mBtnReciveAll_01 = self:getChildGO("mBtnReciveAll_01")
    self.mBtnReciveAll_02 = self:getChildGO("mBtnReciveAll_02")
    self.mTxtTile_01 = self:getChildGO("mTxtTile_01"):GetComponent(ty.Text)
    self.mTxtTile_02 = self:getChildGO("mTxtTile_02"):GetComponent(ty.Text)
    self.mTextTimePeriod_01 = self:getChildGO("mTextTimePeriod_01"):GetComponent(ty.Text)
    self.mTextTimePeriod_02 = self:getChildGO("mTextTimePeriod_02"):GetComponent(ty.Text)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReciveAll_01, function()
        if welfareOpt.WelfareOptManager:checkGroupisInTimeSpan(1) then
            GameDispatcher:dispatchEvent(EventName.REQ_GAIN_STRANGTH_REWARD, 1)
        else
            gs.Message.Show(_TT(48134))
            self:updatePanel()
        end
    end)
    self:addUIEvent(self.mBtnReciveAll_02, function()
        if welfareOpt.WelfareOptManager:checkGroupisInTimeSpan(2) then
            GameDispatcher:dispatchEvent(EventName.REQ_GAIN_STRANGTH_REWARD, 2)
        else
            gs.Message.Show(_TT(48134))
            self:updatePanel()
        end
    end)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    --午间补给
    self.mTxtTile_01.text = _TT(27607)
    --晚 间补给
    self.mTxtTile_02.text = _TT(27608)
    --00:00 -00:00 可以领取
    self.mTextTimePeriod_01.text = _TT(48135, self.mSupplyConfig[1].beginHour, self.mSupplyConfig[1].endHour) .. _TT(40023)
    self.mTextTimePeriod_02.text = _TT(48135, self.mSupplyConfig[2].beginHour, "0" .. self.mSupplyConfig[2].endHour) .. _TT(40023)

end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    self.isInit = true
    self.mSupplyConfig = welfareOpt.WelfareOptManager:getStrengthSupplyDic()
    self.mDicLength = table.nums(self.mSupplyConfig)
    GameDispatcher:addEventListener(EventName.UPDATE_SIGNIN_PANEL, self.updatePanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_STRANGTH_REWARD_PANEL, self.updatePanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SIGN_STATE_CHANGE, self.updateStateChange, self)
    self:updatePanel()
    self:updateGuide()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverSn()
    GameDispatcher:removeEventListener(EventName.UPDATE_SIGNIN_PANEL, self.updatePanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_STRANGTH_REWARD_PANEL, self.updatePanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SIGN_STATE_CHANGE, self.updateStateChange, self)
end

function updateGuide(self)
    self:setGuideTrans("guide_WelfareOpt_Sign", self.mBtnReciveAll_01.transform)
end

function updatePanel(self)
    if self.isInit then
        for idx, supplyVo in pairs(self.mSupplyConfig) do
            local awardList = supplyVo:getAwardList()
            self:getChildGO("mTxtPropNum_0" .. idx):GetComponent(ty.Text).text = "x" .. awardList[1].num
            self:getChildGO("mTxtPropName_0" .. idx):GetComponent(ty.Text).text = props.PropsManager:getName(awardList[1].tid)
            self:getChildGO("mIconProp_0" .. idx):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(awardList[1].tid), true)
            self:updateStateChange({ idx = idx, state = welfareOpt.WelfareOptManager.supplySateDic[idx] })
        end
        self.isInit = false
    end
    self:updateCheckState()
end

-- 每秒检查状态
function updateCheckState(self)
    local checkStatePerMin = function()
        if not self.mDicLength then
            self.mDicLength = table.nums(self.mSupplyConfig)
        end
        for i = 1, self.mDicLength do
            welfareOpt.WelfareOptManager:checkWelfareSupply(i)
        end
        welfareOpt.WelfareOptManager:updateStrengthSupplyBubble()
    end
    checkStatePerMin()
    self:recoverSn()
    self.mSn = LoopManager:addTimer(1, 0, nil, checkStatePerMin)
end

--状态改变刷新体力领取状态
function updateStateChange(self, args)
    if next(args) == nil then
        return
    end
    if args.idx > self.mDicLength then
        return
    end
    self:getChildGO("mImgTileBg_0" .. args.idx):SetActive(args.state == welfareOpt.WelfareOptConst.SUPPLY_REIVED or args.state == welfareOpt.WelfareOptConst.SUPPLY_EXPIRE)
    self:getChildGO("mBtnRecived_0" .. args.idx):SetActive(args.state == welfareOpt.WelfareOptConst.SUPPLY_REIVED)
    self:getChildGO("mImgExpired_0" .. args.idx):SetActive(args.state == welfareOpt.WelfareOptConst.SUPPLY_EXPIRE)
    self:getChildGO("mBtnReciveAll_0" .. args.idx):SetActive(args.state == welfareOpt.WelfareOptConst.SUPPLY_CANREIVE)
end

function recoverSn(self)
    if self.mSn then
        LoopManager:removeTimerByIndex(self.mSn)
        self.mSn = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
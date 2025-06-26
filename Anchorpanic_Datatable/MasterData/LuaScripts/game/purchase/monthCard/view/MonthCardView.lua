--[[ 
-----------------------------------------------------
@filename       : MonthCardView
@Description    : 月卡
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("purchase.MonthCardView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("purchase/MonthCardView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mTabType = nil
end

-- 关闭所有UI
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
end

-- 玩家点击关闭
function onClickClose(self)
    self:__playerClose()
    super.onClickClose(self)
end

function __playerClose(self)
    self:initData()
end

function configUI(self)
    self.mBtnDes = self:getChildGO('BtnDes')
    self.mBtnBuy = self:getChildGO('BtnBuy')
    self.mBuyAwardTrans = self:getChildTrans("mBuyAwardTrans")
    self.mDailyAwardTrans = self:getChildTrans("mDailyAwardTrans")
    self.mTxtBuyDes = self:getChildGO("mTxtBuyDes"):GetComponent(ty.Text)
    self.mTxtDailyDes = self:getChildGO("mTxtDailyDes"):GetComponent(ty.Text)
    self.mTxtTitleDes = self:getChildGO("mTxtTitleDes"):GetComponent(ty.Text)
    self.mTxtRemainDay = self:getChildGO('mTxtRemainDay'):GetComponent(ty.Text)
    self.mTxtRemainDes = self:getChildGO("mTxtRemainDes"):GetComponent(ty.Text)
    self.mTxtBuysDes = self:getChildGO("mTxtBuysDes"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:dispatchEvent(EventName.REQ_MONTH_CARD_INFO)
    GameDispatcher:addEventListener(EventName.UPDATE_MONTH_CARD_INFO, self.__onUpdateViewHandler, self)
    self.mTabType = args.type
    self:updateView(true)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_MONTH_CARD_INFO, self.__onUpdateViewHandler, self)
    self:closeAllitemList()
end

function initViewText(self)
    self.mTxtBuyDes.text = _TT(50053)
    self.mTxtDailyDes.text = _TT(50052)
    self.mTxtTitleDes.text = _TT(50054)
    self.mTxtRemainDes.text = _TT(50056)
    self.mTxtBuysDes.text = _TT(50055)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onClickBuyHandler)
end

function onClickBuyHandler(self)
    if (purchase.MonthCardManager:getHadBuyTimes() < sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_LIMIT_BUY_TIMES)) then
        recharge.sendRecharge(recharge.RechargeType.MONTH_CARD, nil, nil)
    else
        gs.Message.Show(_TT(50028))
    end
end

function __onUpdateViewHandler(self)
    self:updateView()
end

function updateView(self)
    self:closeAllitemList()
    self.mTxtRemainDay.text = _TT(50057, purchase.MonthCardManager:getLeftDays())
    self.mTxtRemainDay.gameObject:SetActive(purchase.MonthCardManager:getLeftDays() > 0)
    self.mPropsList[1] = PropsGrid:create(self.mBuyAwardTrans, { sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_QUICKLY_MONEY_ID), sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_QUICKLY_GET) }, 1, true)
    self.mPropsList[2] = PropsGrid:create(self.mDailyAwardTrans, { sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_MONEY_TID), sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_DAILY_GET) }, 1, true)
    self.mPropsList[3] = PropsGrid:create(self.mDailyAwardTrans, { sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_EXTRAGIFT_TID), sysParam.SysParamManager:getValue(SysParamType.MONTY_CARD_EXTRAGIFT_NUM) }, 1, true)
    local rechargeVo = recharge.RechargeManager:getRechargeVoByDetail(recharge.RechargeType.MONTH_CARD, nil, nil)
    if (rechargeVo) then
        self:setBtnLabel(self.mBtnBuy, -1, rechargeVo.RMB, rechargeVo.RMB)
    else
        self:setBtnLabel(self.mBtnBuy, -1, "NONE")
    end
end

function closeAllitemList(self)
    if self.mPropsList then
        for i, _ in pairs(self.mPropsList) do
            self.mPropsList[i]:poolRecover()
            self.mPropsList[i] = nil
        end
    end
    self.mPropsList = {}
end

return _M

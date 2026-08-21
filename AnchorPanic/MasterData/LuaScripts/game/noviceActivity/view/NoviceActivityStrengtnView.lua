module('noviceActivity.NoviceActivityStrengtnView', Class.impl(TabSubView))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("noviceActivity/NoviceActivityStrengtnView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.mDayItemList = {}
end
-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mImgIcon1 = self:getChildGO("mImgIcon1"):GetComponent(ty.AutoRefImage)
    self.mImgIcon2 = self:getChildGO("mImgIcon2"):GetComponent(ty.AutoRefImage)
    self.mTxtTips1 = self:getChildGO("mTxtTips1"):GetComponent(ty.Text)
    self.mTxtTips2 = self:getChildGO("mTxtTips2"):GetComponent(ty.Text)
    self.mTxtTips1Info = self:getChildGO("mTxtTips1Info"):GetComponent(ty.Text)
    self.mTxtTips2Info = self:getChildGO("mTxtTips2Info"):GetComponent(ty.Text)

    self.mDayItem = self:getChildGO("mDayItem")
    self.mContent1 = self:getChildTrans("mContent1")
    self.mContent2 = self:getChildTrans("mContent2")

    self.mBtnRecive = self:getChildGO("mBtnRecive")
    self.mTxtMoney = self:getChildGO("mTxtMoney"):GetComponent(ty.Text)

    self.mImgRecived = self:getChildGO("mImgRecived")
    self.mTxtMoneyDes = self:getChildGO("mTxtMoneyDes"):GetComponent(ty.Text)
    self.mTxtRecived = self:getChildGO("mTxtRecived"):GetComponent(ty.Text)

    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_NOVICE_STRENGTH_AWARD, self.showPanel, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_NOVICE_STRENGTH_AWARD, self.showPanel, self)
    self:clearDayItemList()
end

function initViewText(self)
    self.mTxtTips.text = _TT(138202)
    self.mTxtTips1.text = _TT(138203)
    self.mTxtTips2.text = _TT(138205)
    self.mTxtTips1Info.text = _TT(138204)
    self.mTxtTips2Info.text =  _TT(138206)
    self.mTxtMoneyDes.text = "￥             " .. _TT(9)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRecive, self.onClickGet)
end

function onClickGet(self)
    recharge.sendRecharge(recharge.RechargeType.STRENGTH_CARD, nil, nil)
end

function showPanel(self)
    local buyTimes = purchase.MonthCardManager:getStrengthBuyTimes()
    local curDay = noviceActivity.NoviceActivityManager:getStrengthDay()
    local isAct = noviceActivity.NoviceActivityManager:getStrengthIsAct()

    local rechargeVo = recharge.RechargeManager:getRechargeVoByDetail(recharge.RechargeType.STRENGTH_CARD, nil, nil)
    local chargeVlaue = rechargeVo and rechargeVo.RMB or "NONE"
    self.mTxtMoney.text = chargeVlaue

    self.mBtnRecive:SetActive(not isAct)
    self.mImgRecived:SetActive(isAct)

    self:clearDayItemList()
    local list = noviceActivity.NoviceActivityManager:getNoviceStrengthData()
    for i = 1, #list do
        local par = i < 7 and self.mContent1 or self.mContent2
        local dayItem = SimpleInsItem:create(self.mDayItem, par, "strengthDayItem")
        dayItem:getChildGO("mTxtDay"):GetComponent(ty.Text).text = i < 10 and "0" .. i or i
        local tid = list[i].reward[1]
        local count = list[i].reward[2]
        dayItem:getChildGO("mPropsIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(tid), false)
        dayItem:getChildGO("mTxtCount"):GetComponent(ty.Text).text = count

        local isGet = noviceActivity.NoviceActivityManager:getRewardIsGeted(i)
        dayItem:getChildGO("mImgGeted"):SetActive(isGet)
        dayItem:getChildGO("mTxtNextDay"):GetComponent(ty.Text).text = _TT(138207)

        local isCanGet = i <= curDay and not isGet
        dayItem:getChildGO("mCanRec"):SetActive(isCanGet)
        
        dayItem:getChildGO("mImgNextDay"):SetActive(i == curDay + 1)
        dayItem:addUIEvent(nil, function()
            self:onClickDayItem(i)
        end)

        table.insert(self.mDayItemList, dayItem)
    end

     
    local curActivityOverTime =  noviceActivity.NoviceActivityManager:getStrengthEndTime()
    --local remainingTime = curActivityOverTime-GameManager:getClientTime()
    local md, hm = TimeUtil.getMDHByTime2(curActivityOverTime)
    self.mTxtTimer.text = _TT(121009,md .. " " .. hm) 
end

function onClickDayItem(self, id)
    if noviceActivity.NoviceActivityManager:getStrengthIsAct() == false then
        gs.Message.Show(_TT(138208))
        return
    end

    if id > noviceActivity.NoviceActivityManager:getStrengthDay() then
        gs.Message.Show(_TT(138209))
        return
    end

    local isGet = noviceActivity.NoviceActivityManager:getRewardIsGeted(id)
    if isGet then
        gs.Message.Show(_TT(266))
        return
    end

    GameDispatcher:dispatchEvent(EventName.REQ_NOVICE_STRENGTH_AWARD, {
        id = id
    })
end

function clearDayItemList(self)
    for i = 1, #self.mDayItemList, 1 do
        self.mDayItemList[i]:poolRecover()
    end
    self.mDayItemList = {}
end

return _M

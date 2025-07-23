module('purchase.GrowthFundPanel', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath('purchase/GrowthFundPanel.prefab')
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
    -- self:setTxtTitle(_TT(52119))
    -- self:setBg("common_bg_015.jpg", true)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mBtnGetAll = self:getChildGO("mBtnGetAll")
    self.mTxtBtn = self:getChildGO("mTxtBtn"):GetComponent(ty.Text)
    self.mTxtTitleLeft = self:getChildGO("mTxtTitleLeft"):GetComponent(ty.Text)
    self.mTxtTitleRight = self:getChildGO("mTxtTitleRight"):GetComponent(ty.Text)

    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(purchase.GrowthFundItem)
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_GROWTH_FUND, self.updateView, self)
    GameDispatcher:addEventListener(EventName.UPDATE_GROWTH_FUND_ITEM, self.updateView, self)
    self:updateView()
    self.mLyScroller:SetItemIndex(purchase.GrowthFundManager:getCurReciveIndex(), 0, 0, 0.1)
    self:actionSound()
end

function actionSound(self)
    local OpenSoundPath = self:getOpenSoundPath()
    if not string.NullOrEmpty(OpenSoundPath) then
        AudioManager:playSoundEffect(OpenSoundPath)
    end
end

function getOpenSoundPath()
    return UrlManager:getUIBaseSoundPath("ui_event_award.prefab")
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_GROWTH_FUND, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GROWTH_FUND_ITEM, self.updateView, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
    self:updateBubble(false)
end

function initViewText(self)
    super.initViewText(self)
    self.mTxtTitleLeft.text = _TT(50041)--初级奖励
    self.mTxtTitleRight.text = _TT(50042)--高级奖励
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onClickBuyHandler)
    self:addUIEvent(self.mBtnGetAll, self.onClickReciveAllHandler)
end

function updateView(self)
    self.mBtnGetAll:SetActive(purchase.GrowthFundManager:getGrowthFundCanReciveNum() >= 1)
    self:updateBubble(purchase.GrowthFundManager:getGrowthFundCanReciveNum() >= 1)
    self.mBtnBuy:SetActive((not purchase.GrowthFundManager:getIsGrowthFundMoney()))
    local rechargeVo = recharge.RechargeManager:getRechargeVoByDetail(recharge.RechargeType.GROWTH_FUND_BUY, nil, nil)
    self.mTxtBtn.text = rechargeVo and rechargeVo.RMB or 18
    local list = purchase.GrowthFundManager:getGrowthFundList()
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end

function onClickReciveAllHandler(self)
    if purchase.GrowthFundManager:getGrowthFundCanReciveNum() >= 1 then
        GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_ALL_GROWTH_FUND)
    end
end

function onClickBuyHandler(self)
    recharge.sendRecharge(recharge.RechargeType.GROWTH_FUND_BUY, nil, nil)
    -- local rechargeVo = recharge.RechargeManager:getRechargeVoByDetail(recharge.RechargeType.GROWTH_FUND_BUY, nil, nil)
    -- if (rechargeVo) then
    --     GameDispatcher:dispatchEvent(EventName.REQ_RECHARGE, { type = recharge.RechargeType.GROWTH_FUND_BUY, subType = nil, itemId = rechargeVo.itemId, itemTitle = _TT(50026), itemName = _TT(50002), itemDes = _TT(50027) })
    -- else
    --     print("无对应充值数据")
    -- end
end

function updateBubble(self, isBubble)
    if isBubble then
        RedPointManager:add(self.mBtnGetAll.transform, nil, 136, 30)
    else
        RedPointManager:remove(self.mBtnGetAll.transform)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
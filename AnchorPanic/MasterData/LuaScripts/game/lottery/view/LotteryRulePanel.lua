-- @FileName:   RoundPrizeRulePanel.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-12-20 17:42:57
-- @Copyright:   (LY) 2024 锚点降临
module("lottery.LotteryRulePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("lottery/LotteryRulePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle(_TT(121201))
end

function initData(self)
    self.mParentItemList = {}
    self.m_itemList = {}
    self.m_propsList = {}
    self.curPage = 1
    self.maxPage = 1
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    -- self.mItemGrid = self:getChildTrans("mItemGrid")
    -- self.mItem = self:getChildGO("mItem")

    self.mRuleInfoScroll = self:getChildGO("mRuleInfoScroll"):GetComponent(ty.LyScroller)
    self.mRuleInfoScroll:SetItemRender(lottery.LotteryParentItem)
    --self.mParentItem = self:getChildGO("mParentItem")

    self.mPageContent = self:getChildGO("mPageContent")
    self.mPretBtn = self:getChildGO("mPretBtn")
    self.mNextBtn = self:getChildGO("mNextBtn")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtTitle.text = _TT(138111)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPretBtn, self.onPreClick)
    self:addUIEvent(self.mNextBtn, self.onNextClick)
end

function onPreClick(self)
    if self.curPage > 1 then
        self.curPage = self.curPage - 1
    else
        gs.Message.Show(_TT(149153))
        return
    end
   self:updatePageInfo()
end

function onNextClick(self)
    if self.curPage < self.maxPage then
        self.curPage = self.curPage + 1
    else
        gs.Message.Show(_TT(149154))
        return
    end
    self:updatePageInfo()
end

function updatePageInfo(self)
    self:showPanel()
end
-- 激活
function active(self, args)
    super.active(self, args)
    self.curPage = lottery.LotteryManager:getCurRound()
    self.maxRound = lottery.LotteryManager:getMaxLotteryRound()
    if self.curPage > self.maxRound then
        self.curPage = self.maxRound
    end

    self:showPanel()
end

function showPanel(self)
    self:clearItem()
    local dic = lottery.LotteryManager:getLotteryDataVo()
    local list = {}
    for k, v in pairs(dic) do
        if k == self.curPage then
            table.insert(list, v)
        end

        if k > self.maxPage then
            self.maxPage = k
        end
    end

    table.sort(list, function(a, b)
        return a.id < b.id
    end)


    self.mTxtNum.text = self.curPage
    if self.mRuleInfoScroll.Count <=0 then
        self.mRuleInfoScroll.DataProvider = list
    else
        self.mRuleInfoScroll:ReplaceAllDataProvider(list)
    end
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearItem()
end

function clearItem(self)
    if self.m_itemList then
        for k, v in pairs(self.m_itemList) do
            v:poolRecover()
        end
    end

    self.m_itemList = {}

    if self.m_propsList then
        for k, v in pairs(self.m_propsList) do
            v:poolRecover()
        end
    end

    self.m_propsList = {}

    if self.mParentItemList then
        for k, v in pairs(self.mParentItemList) do
            v:poolRecover()
        end
    end

    self.mParentItemList = {}
end

return _M

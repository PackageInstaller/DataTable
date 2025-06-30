module('guild.GuildSweepLogPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('guild/GuildSweepLogPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 540)
    self:setTxtTitle(_TT(94553))
    --self:setTxtTitle(_TT(94553))
end

-- 初始化数据
function initData(self)
    self.mCurPage = 1
    self.mMaxPage = 1

    self.mPlayerList = {}
end

-- 初始化
function configUI(self)
    self.mText_1 = self:getChildGO("mText_1"):GetComponent(ty.Text)
    self.mText_2 = self:getChildGO("mText_2"):GetComponent(ty.Text)
    self.mText_3 = self:getChildGO("mText_3"):GetComponent(ty.Text)
    self.mText_4 = self:getChildGO("mText_4"):GetComponent(ty.Text)

    self.mPretBtn = self:getChildGO("mPretBtn")
    self.mNextBtn = self:getChildGO("mNextBtn")
    self.mTxtNum = self:getChildGO("mTxtNum"):GetComponent(ty.Text)

    self.mImgNo = self:getChildGO("mImgNo")
    self.mPageContent = self:getChildGO("mPageContent")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.mScrollerContent = self:getChildTrans("mScrollerContent")
    self.mItem = self:getChildGO("mItem")
    self.mItem:SetActive(false)
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(566) -- "暂无记录"

    self.mText_1.text = _TT(94575)
    self.mText_2.text = _TT(100008)
    self.mText_3.text = _TT(3003)
    self.mText_4.text = _TT(158)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mPretBtn, self.onPretPage)
    self:addUIEvent(self.mNextBtn, self.onNextPage)
end

-- 激活
function active(self, args)
    super.active(self, args)
   
    self:updatePageShow()
end

function udpateView(self)
    self.mLogData = guild.GuildManager:getGuildSweepLogInfo()

    self.mMaxPage = math.ceil(#self.mLogData / 5)

    local logList = {}
    for i = 1 + (self.mCurPage-1) * 5, self.mCurPage * 5 do
        if self.mLogData[i] then
            table.insert(logList, self.mLogData[i])
        end
    end

    local isEmpty = table.empty(logList)
    self.mImgNo:SetActive(isEmpty)
    self.mPageContent:SetActive(not isEmpty)

    self:clearPlayerList()
    self:clearItem()
    for i = 1, #logList do
        local item = SimpleInsItem:create(self.mItem, self.mScrollerContent, "SweepLogPanel_item")
        item:getChildGO("mTxtRank"):GetComponent(ty.Text).text = logList[i].rank
        item:getChildGO("mTextName"):GetComponent(ty.Text).text = logList[i].player_name
        item:getChildGO("mTxtTimes"):GetComponent(ty.Text).text =logList[i].time
        item:getChildGO("mTxtDamage"):GetComponent(ty.Text).text = logList[i].damage
        local playTrans = item:getChildTrans("mHeadContent")
        local playerGrid = PlayerHeadGrid:create(playTrans, logList[i].avatar_id, 0.5, false)
        playerGrid:setHeadFrame(logList[i].avatar_frame_id)

        table.insert(self.mPlayerList, playerGrid)
        table.insert(self.mItemList, item)
    end
end

function clearPlayerList(self)
    for i = 1, #self.mPlayerList do
        self.mPlayerList[i]:poolRecover()
    end
    self.mPlayerList = {}
end

function clearItem(self)
    if not table.empty(self.mItemList) then
        for _, v in pairs(self.mItemList) do
            v:poolRecover()
        end
    end

    self.mItemList = {}
end

function onPretPage(self)
    if self.mCurPage <= 1 then
        return
    end
    self.mCurPage = self.mCurPage - 1

    self:updatePageShow()
end

function onNextPage(self)
    if self.mCurPage >= self.mMaxPage then
        return
    end
    self.mCurPage = self.mCurPage + 1

    self:updatePageShow()
end

-- 更新页码显示
function updatePageShow(self)
    self.mTxtNum.text = self.mCurPage
    self:udpateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:clearPlayerList()
    self:clearItem()
end

return _M

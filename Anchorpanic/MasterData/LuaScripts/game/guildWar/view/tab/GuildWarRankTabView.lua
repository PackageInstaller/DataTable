--[[ 
-----------------------------------------------------
@Description    : 联盟团战排名页
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("guildWar.GuildWarRankTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("guildWar/tab/GuildWarRankTabView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mCreateItemList = {}
end

function configUI(self)
    super.configUI(self)
    self.mScrollReward = self:getChildGO("mScrollReward"):GetComponent(ty.LyScroller)
    self.mScrollReward:SetItemRender(guildWar.GuildWarRankItem)

    self.mTxtCurrent = self:getChildGO("mTxtCurrent"):GetComponent(ty.Text)
    self.mIconDown = self:getChildGO("mIconDown")
    self.mIconUp = self:getChildGO("mIconUp")

    self.mItemRoot = self:getChildGO("mItemRoot")
    self.mItemRootTrans = self:getChildTrans("mItemRoot")

    self.mItemScroll = self:getChildGO("mItemScroll"):GetComponent(ty.ScrollRect)

    self.mCreateItem = self:getChildGO("mCreateItem")

    self.mBtnSeason = self:getChildGO("mBtnSeason")
    self.mBtnHideSeason = self:getChildGO("mBtnHideSeason")

    self.mLogNo = self:getChildGO("mLogNo")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.mTxtRemTimeInfo = self:getChildGO("mTxtRemTimeInfo"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mTxtTitleRank = self:getChildGO("mTxtTitleRank"):GetComponent(ty.Text)
    self.mTxtCurrentRank = self:getChildGO("mTxtCurrentRank"):GetComponent(ty.Text)
    self.mTxtCurrentGuildName = self:getChildGO("mTxtCurrentGuildName"):GetComponent(ty.Text)
    self.mTxtCurrentGuildLeaderName = self:getChildGO("mTxtCurrentGuildLeaderName"):GetComponent(ty.Text)
    self.mTxtCurrentPoint = self:getChildGO("mTxtCurrentPoint"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    self.mItemScroll.gameObject:SetActive(false)
    self.curSeason = guildWar.GuildWarManager:getGuildWarSeasonId()
    local state = guildWar.GuildWarManager:getGuildWarState()
    if state == guildWar.GuildWarState.GuildWarSignUp then
        self.curSeason = math.max(1, self.curSeason - 1)
    end
    self.mTxtCurrent.text = _TT(149106, self.curSeason)
    self.mIconDown:SetActive(true)
    self.mIconUp:SetActive(false)
    self.mBtnHideSeason:SetActive(false)

    GameDispatcher:addEventListener(EventName.UPDATE_GUILD_WAR_RANK_DATA, self.updatePanel, self)
    GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_RANK_DATA, {
        seasonId = self.curSeason
    })
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GUILD_WAR_RANK_DATA, self.updatePanel, self)
    if self.mWarSn then
        LoopManager:removeTimerByIndex(self.mWarSn)
        self.mWarSn = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtEmptyTip.text = _TT(149134)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSeason, self.onBtnSeasonClick)
    self:addUIEvent(self.mBtnHideSeason, self.onBtnHideSeasonClick)
end

function onBtnHideSeasonClick(self)
    self:updateCreateItemInfo()
end

function onBtnSeasonClick(self)
    self.mIconDown:SetActive(false)
    self.mIconUp:SetActive(true)
    self.mItemRoot:SetActive(true)
    self.mBtnHideSeason:SetActive(true)
    self:clearCreateItemList()
    local seasonId = guildWar.GuildWarManager:getGuildWarSeasonId()
    if seasonId > 5 then
        self.mItemScroll.gameObject:SetActive(true)
    end

    for i = seasonId, 1, -1 do
        local parentTran = self.mItemRootTrans
        if seasonId > 5 then
            parentTran = self.mItemScroll.content
        end

        local item = SimpleInsItem:create(self.mCreateItem, parentTran, "mGuildWarCreateItem")
        item:getChildGO("mDefTxt"):GetComponent(ty.Text).text = _TT(149106, i)
        item:getChildGO("mSelectTxt"):GetComponent(ty.Text).text = _TT(149106, i)

        item:getChildGO("mSelect"):SetActive(self.curSeason == i)

        item:addUIEvent("mBtnClick", function()
            self.curSeason = i
            self:updateCreateItemInfo()
            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_RANK_DATA, {
                seasonId = self.curSeason
            })
        end)

        table.insert(self.mCreateItemList, item)
    end
end

function clearCreateItemList(self)
    for i = 1, #self.mCreateItemList, 1 do
        self.mCreateItemList[i]:poolRecover()
    end
    self.mCreateItemList = {}
end

function updateCreateItemInfo(self)
    self.mIconDown:SetActive(true)
    self.mIconUp:SetActive(false)
    self.mTxtCurrent.text = _TT(149106, self.curSeason)
    self.mItemRoot:SetActive(false)
    self.mBtnHideSeason:SetActive(false)
    self.mItemScroll.gameObject:SetActive(false)
end

function updatePanel(self)
    if self.mWarSn then
        LoopManager:removeTimerByIndex(self.mWarSn)
        self.mWarSn = nil
    end
    if guildWar.GuildWarManager:getGuildWarSeasonId() == self.curSeason then
        self:refreshWarTime()
        self.mWarSn = self:addTimer(1, 0, self.refreshWarTime)
    else
        self.mTxtRemTimeInfo.gameObject:SetActive(false)
    end

    -- self.mTxtCurrentRank.text = 
    local rank, point, warName, leaderName = guildWar.GuildWarManager:getGuildWarRankInfoData()

    -- self.mTxtTitleRank.text = rank
    self.mTxtCurrentRank.text = rank == 0 and _TT(161) or rank
    self.mTxtCurrentRank.fontSize = rank == 0 and 22 or 48
    self.mTxtCurrentGuildName.text = warName
    self.mTxtCurrentGuildLeaderName.text = leaderName
    self.mTxtCurrentPoint.text = point

    local list = guildWar.GuildWarManager:getGuildWarRankList()
    table.sort(list, function(a, b)
        return a.rank < b.rank
    end)
    self.mLogNo:SetActive(#list == 0)
    if self.mScrollReward.Count <= 0 then
        self.mScrollReward.DataProvider = list
    else
        self.mScrollReward:ReplaceAllDataProvider(list)
    end
end

function refreshWarTime(self)
    local clientTime = GameManager:getClientTime()
    local endTime = guildWar.GuildWarManager:getGuildWarEndTime()
    if clientTime < endTime then
        self.mTxtRemTimeInfo.gameObject:SetActive(true)
        self.mTxtRemTimeInfo.text = _TT(149204)
        self.mTxtTime.text = TimeUtil.getNewRoleShowTime(endTime - clientTime)
    else
        self.mTxtRemTimeInfo.gameObject:SetActive(false)
    end
end

return _M

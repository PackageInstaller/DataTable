--[[ 
-----------------------------------------------------
@filename       : ArenaHellWeekAwardTabView
@Description    : 巅峰竞技场周结算奖励界面
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("arenaEntrance.ArenaHellWeekAwardTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("arenaEntrance/tab/ArenaHellWeekAwardTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mPropsGrids = {}
end

function configUI(self)
    super.configUI(self)
    self.mGrouplist = self:getChildTrans("list")
    self.mGroupRankAward = self:getChildGO("mGroupRankAward")
    self.mDanAwardContent = self:getChildTrans('mDanAwardContent')
    self.mTxtDanDec = self:getChildGO("mTxtDanDec"):GetComponent(ty.Text)
    self.mTxtCurDan = self:getChildGO("mTxtCurDan"):GetComponent(ty.Text)
    self.mTxtTitleLeft = self:getChildGO("mTxtTitleLeft"):GetComponent(ty.Text)
    self.mTxtCurDanBig = self:getChildGO("mTxtCurDanBig"):GetComponent(ty.Text)
    self.mImgCurDan = self:getChildGO("mImgCurDan"):GetComponent(ty.AutoRefImage)
    self.mTxtPlayerSorce = self:getChildGO("mTxtPlayerSorce"):GetComponent(ty.Text)
    self.mScrollReward = self:getChildGO("mScrollReward"):GetComponent(ty.LyScroller)
    self.mScrollReward:SetItemRender(arenaEntrance.ArenaHellAwardItem)
    self.mTxtRank = self:getChildGO("mTxtRank_02"):GetComponent(ty.Text)
    self.mTxtTile_01 = self:getChildGO("mTxtTile_01"):GetComponent(ty.Text)
    self.mTxt_01 = self:getChildGO("mTxt_01"):GetComponent(ty.Text)
end


function active(self, args)
    super.active(self, args)

    --GameDispatcher:addEventListener(EventName.UPDATE_ARENA_HELL_INFO, self.onGetEndTime, self)
    --GameDispatcher:dispatchEvent(EventName.UPDATE_CURPAGE_INFO, arenaEntrance.ArenaEntaceAwadType.SEASON)
    self:updateRewardView()
    -- if arenaEntrance.ArenaEntranceManager:getSeasonEndTime() then
    --     GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_INFO)
    -- else
    --     self:onGetEndTime()
    -- end

end


function deActive(self)
    super.deActive(self)
    --GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_HELL_INFO, self.onGetEndTime, self)
    self:clearProps()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitleLeft.text = "当前名次" --_TT(1108)--"当前"
    self.mTxtTile_01.text = "名次"
    self.mTxt_01.text = _TT(98002) --"(每周一5：00结算邮件发送)"
end

function updateRewardView(self)
    if not self.mPropsGrids then
        self.mPropsGrids = {}
    end
    self:clearProps()

    local rewardList = arenaEntrance.ArenaEntranceManager:getSegmentAwardList(arenaEntrance.ArenaEntaceAwadType.WEEK_AWARD)
    for i, vo in ipairs(rewardList) do
        rewardList[i].type = arenaEntrance.ArenaEntaceAwadType.WEEK_AWARD
    end
    for i = 1, 4 do
        rewardList[i].tweenId = i * 2
    end
    if self.mScrollReward.Count <= 0 then
        self.mScrollReward.DataProvider = rewardList
    else
        self.mScrollReward:ReplaceAllDataProvider(rewardList)
    end
    self.mImgCurDan.gameObject:SetActive(false)
    self.mGroupRankAward:SetActive(true)
    self.mTxtPlayerSorce.gameObject:SetActive(false)


    self.m_childGos["mTxtScore_02"]:SetActive(false)
    --self.m_childGos["mTxtRank_02"]:SetActive(false)
    self.m_childGos["mTxtCurDan"]:SetActive(true)
    local rank = arenaEntrance.ArenaEntranceManager:getMySeasonRank()
    self.mTxtCurDan.gameObject:SetActive(rank > 3 or rank <= 0)
    self.mTxtCurDanBig.gameObject:SetActive(rank <= 3 and rank > 0)
    if rank <= 0 then
        self.mTxtCurDan.text = "<size=26>" .. _TT(161) .. "</size>"
    elseif rank <= 3 then
        self.mTxtCurDanBig.text = rank
    else
        self.mTxtCurDan.text = rank --#arenaEntrance.ArenaManager:getAwardListByStyle(filterType) > 0 and arenaEntrance.ArenaManager:getArenaRankAwardsByRanks(rank):getRankDifference() or "<size=26>" .. _TT(62220) .. "</size>"
    end

    local playerList = arenaEntrance.ArenaEntranceManager:getWeekAwardList(arenaEntrance.ArenaEntranceManager:getMySeasonRank())
    if #playerList > 0 then
        for _, vo in ipairs(playerList) do
            local propsGrid = PropsGrid:createByData({ tid = vo.tid, num = vo.num, parent = self.mDanAwardContent, scale = 1.4, showUseInTip = true })
            table.insert(self.mPropsGrids, propsGrid)
        end
    end
end

--删除预制体
function clearProps(self)
    if #self.mPropsGrids > 0 then
        for i, _ in ipairs(self.mPropsGrids) do
            self.mPropsGrids[i]:poolRecover()
        end
        self.mPropsGrids = {}
    end
end

return _M
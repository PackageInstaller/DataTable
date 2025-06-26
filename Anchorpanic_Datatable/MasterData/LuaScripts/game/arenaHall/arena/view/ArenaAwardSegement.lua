module("arenaHall.arena.view.ArenaAwardSegement", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaAwardTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)

end

-- 初始化数据
function initData(self)

    -- self.m_propsGridList = {}
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
    self.mScrollReward:SetItemRender(arena.ArenaAwardItem)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtRank = self:getChildGO("mTxtRank_02"):GetComponent(ty.Text)
    self.mTxtTile_01 = self:getChildGO("mTxtTile_01"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_RANK, self.updateView, self)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CURPAGE_INFO, arena.ArenaAwardType.SEASON)
    self:updateRewardView()
    if arena.ArenaManager:getSeasonEndTime() == nil then
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_ALL_INFO)
    else
        self:onGetEndTime()
    end

end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_RANK, self.updateView, self)
    self:clearProps()
    if self.mScrollReward then
        self.mScrollReward:CleanAllItem()
    end
    self:recoverTimer()
end
--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitleLeft.text = "当前段位" --_TT(1108)--"当前"
    self.mTxtTile_01.text = "段位"
end

function getType(self)
    return arena.ArenaAwardType.SEASON
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end



--获取赛季结束时间
function onGetEndTime(self)
    self.mEndTime = arena.ArenaManager:getSeasonEndTime()
    self:recoverTimer()
    self:updateTime()
    self.endTimeSign = LoopManager:addTimer(1, 0, self, self.updateTime)
end

--定时器
function updateTime(self)
    local clientTime = GameManager:getClientTime()
    local remainTime = self.mEndTime - clientTime
    if (remainTime < 0) then
    else
        self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_1(remainTime)
    end
end

function updateRewardView(self)
    local filterType = self:getType()
    if not self.mPropsGrids then
        self.mPropsGrids = {}
    end
    self:clearProps()
    local rewardList = arena.ArenaManager:getSegmentAwardList(filterType)
    for i, vo in ipairs(rewardList) do
        rewardList[i].type = filterType
    end
    for i = 1, 4 do
        rewardList[i].tweenId = i * 2
    end
    if self.mScrollReward.Count <= 0 then
        self.mScrollReward.DataProvider = rewardList
    else
        self.mScrollReward:ReplaceAllDataProvider(rewardList)
    end
    self.mImgCurDan.gameObject:SetActive(filterType ~= arena.ArenaAwardType.RANKAWARD)
    self.mGroupRankAward:SetActive(filterType == arena.ArenaAwardType.RANKAWARD)
    self.mTxtPlayerSorce.gameObject:SetActive(filterType ~= arena.ArenaAwardType.RANKAWARD)

    if filterType ~= arena.ArenaAwardType.RANKAWARD then
        self.mTxtPlayerSorce.text = arena.ArenaManager.myScore
        self.mImgCurDan:SetImg(arena.ArenaManager:getAwardList(arena.ArenaManager.mysegment):getRankIcon(), false)
        self.m_childGos["mTxtRank_02"]:SetActive(true)
        self.m_childGos["mTxtCurDan"]:SetActive(false)
        self.mTxtRank.text = _TT(arena.ArenaManager:getAwardList(arena.ArenaManager.mysegment).rankName)
        self.m_childGos["mTxtScore_02"]:SetActive(true)
    else
        self.m_childGos["mTxtScore_02"]:SetActive(false)

        self.m_childGos["mTxtRank_02"]:SetActive(false)
        self.m_childGos["mTxtCurDan"]:SetActive(true)
        self.mTxtCurDan.gameObject:SetActive(arena.ArenaManager.mySeasonRank > 3 or arena.ArenaManager.mySeasonRank <= 0)
        self.mTxtCurDanBig.gameObject:SetActive(arena.ArenaManager.mySeasonRank <= 3 and arena.ArenaManager.mySeasonRank > 0)
        if arena.ArenaManager.mySeasonRank <= 0 then
            self.mTxtCurDan.text = "<size=26>" .. _TT(161) .. "</size>"
        elseif arena.ArenaManager.mySeasonRank <= 3 then
            self.mTxtCurDanBig.text = arena.ArenaManager.mySeasonRank
        else
            self.mTxtCurDan.text = #arena.ArenaManager:getAwardListByStyle(filterType) > 0 and arena.ArenaManager:getArenaRankAwardsByRanks(arena.ArenaManager.mySeasonRank):getRankDifference() or "<size=26>" .. _TT(62220) .. "</size>"
        end
    end

    local playerList = arena.ArenaManager:getAwardListByStyle(filterType)
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

function recoverTimer(self)
    if self.endTimeSign then
        LoopManager:removeTimerByIndex(self.endTimeSign)
        self.endTimeSign = nil
    end
end
return _M
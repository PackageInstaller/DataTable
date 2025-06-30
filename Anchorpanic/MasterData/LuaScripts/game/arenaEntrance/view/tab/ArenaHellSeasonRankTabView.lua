--[[ 
-----------------------------------------------------
@filename       : ArenaHellSeasonRankTabView
@Description    : 巅峰竞技场排行界面
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]

module("arenaEntrance.ArenaHellSeasonRankTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("arenaEntrance/tab/ArenaHellSeasonRankTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)

end

function configUI(self)
    super.configUI(self)
    self.mTxtInfoRankBig = self:getChildGO("mTxtInfoRankBig"):GetComponent(ty.Text)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.Text)
    self.mHeadGridNode = self:getChildGO("mHeadGridNode").transform
    self.mTxtRankDec = self:getChildGO("mTxtRankDec"):GetComponent(ty.Text)
    self.mImgSeasonDan = self:getChildGO("mImgSeasonDan"):GetComponent(ty.AutoRefImage)
    self.mTxtSeasonDan = self:getChildGO("mTxtSeasonDan"):GetComponent(ty.Text)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(arenaEntrance.ArenaEntranceRankItem)
    self.mTxtTilte_02 = self:getChildGO("mTxtTilte_02"):GetComponent(ty.Text)

    self.mTxtWin = self:getChildGO("mTxtWin"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)
end


function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_HELL_RANK_PANEL,self.updateView,self)
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HELL_TOP_PLAYER)
   
    --self:updateView()
end


function deActive(self)
    super.deActive(self)

    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end

    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_HELL_RANK_PANEL,self.updateView,self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtRankDec.text = _TT(159)
    self.mTxtTilte_02.text = "当前排行"
    self.mTxtTips.text = _TT(98004)
end

function updateView(self)

    self.mTxtWar.text = arenaEntrance.ArenaEntranceManager:getArenaWarTxt()
    local list = arenaEntrance.ArenaEntranceManager:getArenaHellTopPlayer()

    table.sort(list,function (a,b)
        return a.rank < b.rank
    end)

    for i = 1, 4 do
        list[i].tweenId = i
    end

    if (self.mScroller.Count <= 0) then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.mPlayerHeadGrid:setData(role.RoleManager:getRoleVo():getAvatarId())
    self.mPlayerHeadGrid:setParent(self.mHeadGridNode)
    self.mPlayerHeadGrid:setHeadFrame(role.RoleManager:getRoleVo():getAvatarFrameId())
    self.mPlayerHeadGrid:setScale(1)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)

    local myRank = arenaEntrance.ArenaEntranceManager:getMySeasonRank()

    self.m_childGos["mImgColor2"]:SetActive(myRank < 4)
    self.mTxtInfoRankBig.gameObject:SetActive(myRank <= 10 and myRank ~= 0)
    self.mTxtRank.gameObject:SetActive(myRank > 10)
    self.m_childGos["mTxtRank_02"]:SetActive(myRank <= 0)
    self.mTxtInfoRankBig.text = myRank
    if myRank <= 0 then
        self.m_childGos["mTxtRank_02"]:GetComponent(ty.Text).text = _TT(161)
    elseif myRank <= 3 and myRank > 0 then
        self.mTxtRank.text = ""
    elseif myRank <= 100 then
        self.mTxtRank.text = myRank
    else
        self.mTxtRank.text = "<size=24>" .. myRank  .. "</size>"
    end
    self.mTxtName.text = role.RoleManager:getRoleVo():getPlayerName()
    self.mTxtScore.text = arenaEntrance.ArenaEntranceManager:getMyScore()
    self.mTxtWin.text = arenaEntrance.ArenaEntranceManager:getMyWinCount()
    --self.mTxtSeasonDan.text = _TT(arena.ArenaManager:getAwardList(arena.ArenaManager.mysegment).rankName)
    --self.mImgSeasonDan:SetImg(arena.ArenaManager:getAwardList(arena.ArenaManager.mysegment):getRankIcon(), false)
end

--段位不同显示图片
function onClickHeadHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = role.RoleManager:getRoleVo().playerId })
end

return _M
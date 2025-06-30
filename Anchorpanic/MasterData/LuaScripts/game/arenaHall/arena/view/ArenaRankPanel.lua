module("arena.ArenaRankPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaRankPanel.prefab")
panelType = 1-- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(62203))
    self:setSize(0, 0)
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
    self.mScroller:SetItemRender(arena.ArenaRankItem)
    self.mTxtTilte_02 = self:getChildGO("mTxtTilte_02"):GetComponent(ty.Text)
    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)
end


function initViewText(self)
    self.mTxtRankDec.text = _TT(159)
    self.mTxtTilte_02.text = "当前排行"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_RANK, self.updateView, self)
    -- 请求竞技场面板内容
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_PANEL_INFO, {})
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_RANK, {})
    self:addTimer(sysParam.SysParamManager:getValue(SysParamType.ARENA_REFRESH_TIME), 0, function()
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_RANK, {})
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_PANEL_INFO, {})
    end)
    -- self:updateView()
end

function deActive(self)
    super.deActive(self)
    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_RANK, self.updateView, self)
end

function updateView(self)

    self.mTxtWar.text = arena.ArenaManager:getArenaWarTxt()
    local list = arena.ArenaManager:getRankList()

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
    local myRank = arena.ArenaManager:getMyRank()
    -- local url = UrlManager:getArenaRankIconUrl(myRank)
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
        local cur = math.floor(myRank / arena.ArenaManager.zonePlayerNum * 100)
        self.mTxtRank.text = "<size=24>" .. cur .. "%" .. "</size>"
    end
    self.mTxtName.text = role.RoleManager:getRoleVo():getPlayerName()
    self.mTxtScore.text = arena.ArenaManager.myScore
    self.mTxtSeasonDan.text = _TT(arena.ArenaManager:getAwardList(arena.ArenaManager.mysegment).rankName)
    self.mImgSeasonDan:SetImg(arena.ArenaManager:getAwardList(arena.ArenaManager.mysegment):getRankIcon(), false)
end
--段位不同显示图片
function SetShowDanImg(self, pathNum)

end

--段位不同显示图片
function onClickHeadHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = role.RoleManager:getRoleVo().playerId })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
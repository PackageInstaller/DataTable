module("vision.VisionRankPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("vision/VisionRankPanel.prefab")
panelType = 1
destroyTime = 0
isBlur = 1
isAdapta = 0

function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(62203))
    self:setSize(0, 0)
    self:setBg("Infinitycity_bg_01.jpg", false, "vision")
end

function initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)
    self.mTxtMyRankBig = self:getChildGO("mTxtMyRankBig"):GetComponent(ty.Text)
    self.mTxtMyRank = self:getChildGO("mTxtMyRank"):GetComponent(ty.Text)
    self.mTxtMyName = self:getChildGO("mTxtMyName"):GetComponent(ty.Text)
    self.mTxtMyScore = self:getChildGO("mTxtMyScore"):GetComponent(ty.Text)
    self.mTxtMyGuild = self:getChildGO("mTxtMyGuild"):GetComponent(ty.Text)
    self.mMyHeadGridNode = self:getChildTrans("mMyHeadGridNode")
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(vision.VisionRankItem)
    self.mTxtTilte_02 = self:getChildGO("mTxtTilte_02"):GetComponent(ty.Text)
    self.mTxtMyLayer = self:getChildGO("mTxtMyLayer"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtTilte_02.text = "当前排行"
end

function addAllUIEvent(self)
end

function active(self)
    super.active(self)
     MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_VISION_MIRROR_RANK_PANEL, self.updateView, self)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_VISION_MIRROR_RANK_PANEL, self.updateView, self)
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if self.mScroller then
        self.mScroller:CleanAllItem()
    end
end

function updateView(self)
    local rankVo = vision.VisionManager:getVisionMirrorRankPanelVo()
    if not rankVo then
        return
    end

    self.mTxtWar.text = "永境战线"
    local list = rankVo:getRankList()
    for i = 1, 4 do
        if list[i] then
            list[i].tweenId = i
        end
    end
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end

    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    self.mPlayerHeadGrid:setData(role.RoleManager:getRoleVo():getAvatarId())
    self.mPlayerHeadGrid:setParent(self.mMyHeadGridNode)
    self.mPlayerHeadGrid:setHeadFrame(role.RoleManager:getRoleVo():getAvatarFrameId())
    self.mPlayerHeadGrid:setScale(1)
    self.mPlayerHeadGrid:setCallBack(self, self.onClickHeadHandler)

    local myRank = rankVo.myRank or 0
    self.m_childGos["mImgColor2"]:SetActive(myRank < 4 and myRank > 0)
    self.mTxtMyRankBig.gameObject:SetActive(myRank <= 10 and myRank > 0)
    self.mTxtMyRank.gameObject:SetActive(myRank > 10)
    self.m_childGos["mTxtMyRank_02"]:SetActive(myRank <= 0)
    self.mTxtMyRankBig.text = myRank
    if myRank <= 0 then
        self.m_childGos["mTxtMyRank_02"]:GetComponent(ty.Text).text = _TT(161)
    elseif myRank <= 3 then
        self.mTxtMyRank.text = ""
    elseif myRank <= 100 then
        self.mTxtMyRank.text = myRank
    end

    local roleVo = role.RoleManager:getRoleVo()
    local myRankInfo = nil
    for i = 1, #list do
        if list[i].playerId == roleVo.playerId then
            myRankInfo = list[i]
            break
        end
    end
    self.mTxtMyName.text = roleVo:getPlayerName()
    self.mTxtMyGuild.text = myRankInfo and FilterWordUtil:filterTemp(myRankInfo.guildName == "" and _TT(97053) or myRankInfo.guildName) or _TT(97053)
    self.mTxtMyLayer.text = rankVo.layer or (myRankInfo and myRankInfo.layer or 0)
    self.mTxtMyScore.text = rankVo.myRankVal or 0
end

function onClickHeadHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = role.RoleManager:getRoleVo().playerId })
end

return _M

module("dup.DupCodeHopeRankItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.m_imgBg = self:getChildGO("ImgBg"):GetComponent(ty.Image)
    self.m_iconRankGo = self:getChildGO("IconRank")
    self.m_iconRank = self.m_iconRankGo:GetComponent(ty.AutoRefImage)
    self.m_textRank = self:getChildGO("TextRank"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("TextName"):GetComponent(ty.Text)
    self.m_textScore = self:getChildGO("TextScore"):GetComponent(ty.Text)

    self.m_headNode = self:getChildTrans("HeadGridNode")

    self.mGroup = self:getChildGO("mGroup")
end

function setData(self, param)
    super.setData(self, param)
    -- if table.nums(self.data) == 0 then
    --     -- 尾部补充item
    --     self.mGroup:SetActive(false)
    --     return
    -- end
    self.mGroup:SetActive(true)

    local rankData = self.data

    if (not self.m_playerHeadGrid) then
        self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
    end

    local url = UrlManager:getArenaRankIconUrl(rankData.rank)
    if (url) then
        self.m_iconRankGo:SetActive(true)
        self.m_iconRank:SetImg(url, false)
        self.m_textRank.text = ""
    else
        self.m_iconRankGo:SetActive(false)
        self.m_textRank.text = rankData.rank
    end
    -- if rankData.isRobot then
    --     local robotVo = arena.ArenaManager:getRobotData(rankData.playerId)
    --     self.m_playerHeadGrid:setData(robotVo:getHeadIcon())
    --     self.mTxtName.text = robotVo:getName()
    -- else
    self.m_playerHeadGrid:setData(rankData.avatarId)
    self.mTxtName.text = rankData.playerName
    -- end
    self.m_playerHeadGrid:setHeadFrame(rankData.avatarFrame)
    self.m_playerHeadGrid:setParent(self.m_headNode)
    self.m_playerHeadGrid:setScale(0.35)
    self.m_playerHeadGrid:setCallBack(self, self.__onClickHeadHandler)

    self.m_textScore.text = TimeUtil.getMSByTime(rankData.passTime)

    self.m_imgBg.color = gs.ColorUtil.GetColor(rankData.rank % 2 == 0 and "474d56FF" or "2a2d33FF")
end

function __onClickHeadHandler(self, args)
    -- if (not self.data.isRobot) then
    GameDispatcher:dispatchEvent(EventName.SHOW_OTHER_ROLE_INFO, self.data.playerId)
    -- end
end

function deActive(self)
    super.deActive(self)
    if (self.m_playerHeadGrid) then
        self.m_playerHeadGrid:poolRecover()
        self.m_playerHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

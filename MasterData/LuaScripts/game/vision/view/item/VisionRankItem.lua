module("vision.VisionRankItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mIconRank = self:getChildGO("mImgColor2"):GetComponent(ty.Image)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.Text)
    self.mTxtGuild = self:getChildGO("mTxtGuild"):GetComponent(ty.Text)
    self.mTxtLayer = self:getChildGO("mTxtLayer"):GetComponent(ty.Text)
    self.mTxtRankBig = self:getChildGO("mTxtRankBig"):GetComponent(ty.Text)
    self.mHeadGridNode = self:getChildTrans("mHeadGridNode")
    self.mGroup = self:getChildGO("mGroupItem")
end

function setData(self, param)
    super.setData(self, param)

    if table.nums(self.data) == 0 then
        self.mGroup:SetActive(false)
        return
    end
    self.mGroup:SetActive(true)

    local rankData = self.data
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    self.mIconRank.gameObject:SetActive(rankData.rank < 4)

    if rankData.rank <= 3 then
        local color = "ffc66d00"
        if rankData.rank == 1 then
            color = "ffc66dff"
        elseif rankData.rank == 2 then
            color = "D376f9ff"
        elseif rankData.rank == 3 then
            color = "6dbcffff"
        end
        self.mIconRank.color = gs.ColorUtil.GetColor(color)
        self.m_childGos["mTop"]:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
        self.m_childGos["mTop1"]:SetActive(rankData.rank == 1)
        self.m_childGos["mTop2"]:SetActive(rankData.rank == 2)
        self.m_childGos["mTop3"]:SetActive(rankData.rank == 3)
    end
    self.mTxtRankBig.gameObject:SetActive(rankData.rank < 4)
    self.mTxtRank.gameObject:SetActive(rankData.rank > 3)
    self.mTxtRank.text = rankData.rank
    self.mTxtRankBig.text = rankData.rank
    self.mPlayerHeadGrid:setData(rankData.avatarId)
    self.mTxtName.text = FilterWordUtil:filterTemp(rankData.playerName)
    self.mPlayerHeadGrid:setParent(self.mHeadGridNode)
    self.mPlayerHeadGrid:setScale(1)
    self.mPlayerHeadGrid:setCallBack(self, self.__onClickHeadHandler)
    if rankData.playerId == role.RoleManager:getRoleVo().playerId then
        self.mPlayerHeadGrid:setHeadFrame(role.RoleManager:getRoleVo():getAvatarFrameId())
    else
        self.mPlayerHeadGrid:setHeadFrame(rankData.avatarFrame)
    end
    self.mTxtScore.text = rankData.rankVal
    self.mTxtGuild.text = FilterWordUtil:filterTemp(rankData.guildName == "" and _TT(97053) or rankData.guildName)
    self.mTxtLayer.text = rankData.layer
end

function __onClickHeadHandler(self)
    if self.data.playerId ~= role.RoleManager:getRoleVo().playerId then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.playerId })
    end
end

function deActive(self)
    super.deActive(self)
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M

module("seabed.SeabedRankItem", Class.impl("lib.component.BaseItemRender"))

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
    -- self.mTxtRankCurDan = self:getChildGO('mTxtRankCurDan'):GetComponent(ty.Text)
    -- self.mImgRankCurDan = self:getChildGO('mImgRankCurDan'):GetComponent(ty.AutoRefImage)
    self.mGroup = self:getChildGO("mGroupItem")
end

function setData(self, param)
    super.setData(self, param)

    self.mGroup:SetActive(true)

    local rankData = self.data
    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.mIconRank.gameObject:SetActive(self.data.rank < 4)
    -- self.mTxtRankBig.color = gs.ColorUtil.GetColor("202226ff")

    if (self.data.rank <= 3) then
        --self.mTxtRankBig.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(self.data.rank))

        local color = "ffc66d00"
        if self.data.rank == 1 then
            color = "ffc66dff"
        elseif self.data.rank == 2 then
            color = "D376f9ff"
        elseif self.data.rank == 3 then
            color = "6dbcffff"
        end
        self.mIconRank.color = gs.ColorUtil.GetColor(color)
        self.m_childGos["mTop"]:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
        self.m_childGos["mTop1"]:SetActive(self.data.rank == 1)
        self.m_childGos["mTop2"]:SetActive(self.data.rank == 2)
        self.m_childGos["mTop3"]:SetActive(self.data.rank == 3)
    end
    self.mTxtRankBig.gameObject:SetActive(self.data.rank < 4)
    self.mTxtRank.gameObject:SetActive(self.data.rank > 3)
    --self.mImgRankCurDan:SetImg(arena.ArenaManager:getAwardList(self.data.segment):getRankIcon(), false)
    self.mTxtRank.text = rankData.rank
    self.mTxtRankBig.text = rankData.rank

    self.mPlayerHeadGrid:setData(rankData.avatar_id)

    self.mTxtName.text = FilterWordUtil:filterTemp(rankData.player_name)

    self.mPlayerHeadGrid:setParent(self.mHeadGridNode)
    self.mPlayerHeadGrid:setScale(1)
    self.mPlayerHeadGrid:setCallBack(self, self.__onClickHeadHandler)
    if rankData.player_id == role.RoleManager:getRoleVo().playerId then
        self.mPlayerHeadGrid:setHeadFrame(role.RoleManager:getRoleVo():getAvatarFrameId())
    else
        self.mPlayerHeadGrid:setHeadFrame(rankData.avatar_frame)
    end
    self.mTxtScore.text = rankData.rank_val
    self.mTxtGuild.text = FilterWordUtil:filterTemp(rankData.guild_name == "" and _TT(97053) or rankData.guild_name)
    --self.mTxtLayer.text = doundless.DoundlessManager:getDupLayer(rankData.dup_id)
    --self.mTxtRankCurDan.text = _TT(arena.ArenaManager:getAwardList(rankData.segment).rankName)
end

function __onClickHeadHandler(self, args)
    if (self.data.player_id ~= role.RoleManager:getRoleVo().playerId) then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = self.data.player_id })
    end
end

function deActive(self)
    super.deActive(self)
    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
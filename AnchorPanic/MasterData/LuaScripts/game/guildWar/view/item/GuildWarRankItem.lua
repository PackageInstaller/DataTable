module("guildWar.GuildWarRankItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mContent = self:getChildTrans("mContent")
    self.mGroupRank = self:getChildGO("mGroupRank")
    self.mGroupAward = self:getChildGO("mGroupAward")
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtRankBig = self:getChildGO("mTxtRankBig"):GetComponent(ty.Text)
    -- self.mTxtRankDec = self:getChildGO("mTxtRankDec"):GetComponent(ty.Text)
    -- self.mTxtInterval = self:getChildGO("mTxtInterval"):GetComponent(ty.Text)
    -- self.mImgIcon = self:getChildGO("mImgIcon_01"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
   
    self.mTxtGuildName = self:getChildGO("mTxtGuildName"):GetComponent(ty.Text)
    self.mTxtGuildLeaderName = self:getChildGO("mTxtGuildLeaderName"):GetComponent(ty.Text)
    self.mTxtPoint = self:getChildGO("mTxtPoint"):GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)
    --self:recoverAllGrid()
    local list = {}

    local isTop = self.data.rank <= 3
    self.m_childGos["mTxtRank"]:SetActive(not isTop)
    self.mTxtRank.gameObject:SetActive(not isTop)
    self.mTxtRankBig.gameObject:SetActive(isTop)
    self.mImgColor.gameObject:SetActive(isTop)
    if isTop then
        self.mTxtRankBig.text = self.data.rank
        self.m_childGos["mTop"]:SetActive(true)
        local color
        for i = 1, 3 do
            self.m_childGos["mTop" .. i]:SetActive(self.data.rank == i)
        end

        if self.data.rank == 1 then
            color = "ffc66dff"
        elseif self.data.rank == 2 then
            color = "D376f9ff"
        elseif self.data.rank == 3 then
            color = "6dbcffff"
        end

        self.mImgColor.color = gs.ColorUtil.GetColor(color)
    else
        self.m_childGos["mTop"]:SetActive(false)
    end

    self.mTxtGuildName.text = self.data.name
    self.mTxtGuildLeaderName.text = self.data.leader_name
    self.mTxtPoint.text = self.data.point
    self.mTxtRank.text = self.data.rank
    -- self.mTxtName.text = FilterWordUtil:filterTemp(self.data.name)

    -- self.mTxtPower.text = self.data.rank_val
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end


return _M

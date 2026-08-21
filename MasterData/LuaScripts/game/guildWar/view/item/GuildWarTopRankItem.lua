module("guildWar.GuildWarTopRankItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mContent = self:getChildTrans("mContent")
    self.mGroupRank = self:getChildGO("mGroupRank")
    self.mGroupAward = self:getChildGO("mGroupAward")
    --self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    --self.mTxtRankBig = self:getChildGO("mTxtRankBig"):GetComponent(ty.Text)
    -- self.mTxtRankDec = self:getChildGO("mTxtRankDec"):GetComponent(ty.Text)
    -- self.mTxtInterval = self:getChildGO("mTxtInterval"):GetComponent(ty.Text)
    -- self.mImgIcon = self:getChildGO("mImgIcon_01"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
   
    self.mTxtGuildName = self:getChildGO("mTxtGuildName"):GetComponent(ty.Text)
    self.mTxtGuildLeaderName = self:getChildGO("mTxtGuildLeaderName"):GetComponent(ty.Text)
    self.mTxtPoint = self:getChildGO("mTxtPoint"):GetComponent(ty.Text)

    self.mTop = self:getChildGO("mTop")
    self.mTop1 = self:getChildGO("mTop1")
    self.mTop2 = self:getChildGO("mTop2")
    self.mTop3 = self:getChildGO("mTop3")
    self.mTop4 = self:getChildGO("mTop4")
end

function setData(self, param)
    super.setData(self, param)
    --self:recoverAllGrid()
    local list = {}

    local isTop = self.data.rank <= 8
    self.mTop1:SetActive(self.data.rank == 1)
    self.mTop2:SetActive(self.data.rank == 2)
    self.mTop3:SetActive(self.data.rank >= 3 and self.data.rank <= 4)
    self.mTop4:SetActive(self.data.rank >= 5 and self.data.rank <= 8)

  local color = "ffc66dff"
        if self.data.rank == 1 then
            color = "ffc66dff"
        elseif self.data.rank == 2 then
            color = "D376f9ff"
        elseif self.data.rank >= 3 and self.data.rank <= 4 then
            color = "6dbcffff"
        elseif self.data.rank >= 5 and self.data.rank <= 8 then
            color = "37ce93ff"
        end

    self.mImgColor.gameObject:SetActive(isTop)
    self.mImgColor.color = gs.ColorUtil.GetColor(color)
    --self.m_childGos["mTxtRank"]:SetActive(not isTop)
    --self.mTxtRank.gameObject:SetActive(not isTop)
    --self.mTxtRankBig.gameObject:SetActive(isTop)
    --self.mImgColor.gameObject:SetActive(isTop)
    -- if isTop then
    --     --self.mTxtRankBig.text = self.data.rank
    --     self.m_childGos["mTop"]:SetActive(true)
    --     local color
    --     for i = 1, 3 do
    --         self.m_childGos["mTop" .. i]:SetActive(self.data.rank == i)
    --     end

    --     if self.data.rank == 1 then
    --         color = "ffc66dff"
    --     elseif self.data.rank == 2 then
    --         color = "D376f9ff"
    --     elseif self.data.rank == 3 then
    --         color = "6dbcffff"
    --     end

    --     self.mImgColor.color = gs.ColorUtil.GetColor(color)
    -- else
    --     self.m_childGos["mTop"]:SetActive(false)
    -- end

    self.mTxtGuildName.text = self.data.name
    self.mTxtGuildLeaderName.text = self.data.leader_name
    self.mTxtPoint.gameObject:SetActive(false)
    --self.mTxtRank.text = self.data.rank
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

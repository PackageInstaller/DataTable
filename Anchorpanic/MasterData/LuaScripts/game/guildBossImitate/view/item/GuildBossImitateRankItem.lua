-- @FileName:   GuildBossImitateRankItem.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-04-12 10:25:25
-- @Copyright:   (LY) 2024 锚点降临

module("game.guildBossImitate.view.GuildBossImitateRankItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

     self.mIconRank = self:getChildGO("mImgColor2"):GetComponent(ty.Image)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDamage = self:getChildGO("mTxtDamage"):GetComponent(ty.Text)
    self.mTxtRankBig = self:getChildGO("mTxtRankBig"):GetComponent(ty.Text)

    self.mTop = self:getChildGO("mTop")
    self.mTop1 = self:getChildGO("mTop1")
    self.mTop2 = self:getChildGO("mTop2")
    self.mTop3 = self:getChildGO("mTop3")

    self.mGroup = self:getChildGO("mGroupItem")

    self.mHeadGridNode = self:getChildTrans("mHeadGridNode")
end

function setData(self, data)
    super.setData(self, data)

    self.mIconRank.gameObject:SetActive(self.data.rank < 4)

    if (self.data.rank <= 3) then
        local color = "ffc66d00"
        if self.data.rank == 1 then
            color = "ffc66dff"
        elseif self.data.rank == 2 then
            color = "D376f9ff"
        elseif self.data.rank == 3 then
            color = "6dbcffff"
        end
        self.mIconRank.color = gs.ColorUtil.GetColor(color)
        self.mTop:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
        self.mTop1:SetActive(self.data.rank == 1)
        self.mTop2:SetActive(self.data.rank == 2)
        self.mTop3:SetActive(self.data.rank == 3)
    end
    self.mTxtRankBig.gameObject:SetActive(self.data.rank < 4)
    self.mTxtRank.gameObject:SetActive(self.data.rank > 3)
    self.mTxtRank.text = self.data.rank
    self.mTxtRankBig.text = self.data.rank
    self.mTxtName.text = self.data.player_name
    self.mTxtDamage.text = self.data.damage

    if (not self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    end
    self.mPlayerHeadGrid:setData(self.data.avatar_id)
    self.mPlayerHeadGrid:setParent(self.mHeadGridNode)
    self.mPlayerHeadGrid:setHeadFrame(self.data.avatar_frame_id)
    self.mPlayerHeadGrid:setScale(1)
end

function deActive(self)
    super.deActive(self)

    if (self.mPlayerHeadGrid) then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

-- @FileName:   GuildBossRankItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-08 14:17:04
-- @Copyright:   (LY) 2023 雷焰网络

module("guild.GuildBossRankItem", Class.impl("lib.component.BaseItemRender"))

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
end

function setData(self, param)
    super.setData(self, param)

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
    self.mTxtName.text = ""--FilterWordUtil:filterTemp(self.data.guild_name)
    self.mTxtDamage.text = self.data.damage
end

function deActive(self)
    super.deActive(self)

end

function onDelete(self)
    super.onDelete(self)
end

return _M

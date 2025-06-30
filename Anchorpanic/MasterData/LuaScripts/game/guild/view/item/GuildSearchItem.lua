module("guild.GuildSearchItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mBg = self:getChildGO("mBg")
    self.mIsSelect = self:getChildGO("mIsSelect")
    self.mTxtGuildName = self:getChildGO("mTxtGuildName"):GetComponent(ty.Text)
    self.mImgFree = self:getChildGO("mImgFree")
    self.mImgReq = self:getChildGO("mImgReq")
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtActive = self:getChildGO("mTxtActive"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBg, self.onBgClick)
end

function onBgClick(self)
    GameDispatcher:dispatchEvent(EventName.ONCLICK_GUILD_SEARCHITEM, self.mData)
end

function setData(self, data)
    super.setData(self, data)
    self.mData = data

    self.mIsSelect:SetActive(self.mData.isSelect)

    self.defColor = self.mData.isSelect and gs.ColorUtil.GetColor("202226ff") or gs.ColorUtil.GetColor("c6d4e1ff")

    self.mTxtGuildName.color = self.defColor
    self.mTxtCount.color = self.defColor
    self.mTxtLv.color = self.defColor
    self.mTxtActive.color = self.defColor

    self.mImgFree:SetActive(data.apply_type == 1)
    
    self.isReq = false
    for i = 1,#data.apply_list do
        if data.apply_list[i].player_id == role.RoleManager:getRoleVo().playerId then--
            self.isReq = true
            break
        end
    end
    --self.isReq = table.indexof01(data.apply_list, role.RoleManager:getRoleVo().playerId) > 0

    self.mImgReq:SetActive(self.isReq and data.apply_type ~= 1)

    self.mTxtGuildName.text = data.name

    self.localData = guild.GuildManager:getGuildData(data.lv)

    self.mTxtCount.text = #data.members .. "/" .. self.localData.peopleNum
    self.mTxtLv.text = data.lv
    self.mTxtActive.text = data.activation
    local url = guild.GuildManager:getIconDataById(data.icon).icon
    self.mImgIcon:SetImg(UrlManager:getIconPath(url), false)
end

function onDelete(self)
    super.onDelete(self)
end

return _M

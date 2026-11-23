FriendPlayerInfoBadgeItem = {}

FriendPlayerInfoBadgeItem.__index = FriendPlayerInfoBadgeItem
local objs = {
    imgSelectBg = {path = "imgSelectBg",type = "GameObject"},
    imgSelect = {path = "imgSelect",type = "GameObject"},
    badgeSprite = {path = "badge",type = "Image"},
    badgeRect = {path = "badge",type = "RectTransform"},
    avatarIcon = {path = "badge/bg/icon",type = "RawImage"},
    avatarFrameIcon = {path = "badge/bg/frame",type = "Image"},
    levelText = {path = "badge/bg/Level",type = "Text"},
    nameText = {path = "badge/textName",type = "Text"},
    teamNameText = {path = "badge/Team/bg/name",type = "Text"},
    teamIcon = {path = "badge/Team/bg/icon",type = "Image"},
    clickBtn = {path = "imgFrame",type = "Button"},
    imgLock = {path = "badge/imgLock",type = "GameObject"},
    goRed={path="badge/Red",type="GameObject"},
}

function FriendPlayerInfoBadgeItem.New()
    local self = {}
    setmetatable(self, FriendPlayerInfoBadgeItem)
    return self
end

function FriendPlayerInfoBadgeItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        local key = DataMgr.Player.uid .. "_FriendChatBadge_" .. self.data.id
        PlayerPrefs.SetInt(key,1)
        PlayerPrefs.Save();
        SetActive(self.goRed, false)
        self.func(self.data.id)
    end
    LuaMgr.AddClick(self.clickBtn,self.getCommand)
end

function FriendPlayerInfoBadgeItem:SetData(data)
    self.data = data
    self.index = data.index
    self.isSelect = self.data.isSelect
    self.func = self.data.func

    SetActive(self.imgSelectBg,self.isSelect)
    SetActive(self.imgSelect,self.isSelect)
    SetActive(self.imgLock,self.data.lock)
    self.badgeRect.anchoredPosition = self.isSelect and Vector2(164, -82) or Vector2(181, -82);

    self.avatarIcon.texture = self.data.avatar
    PlayerAvatarFrameTool.SetAvatarFrame(self.avatarFrameIcon, self.data.avatarFrameId)
    self.levelText.text = self.data.level
    self.nameText.text = self.data.name
    self.teamNameText.text = self.data.teamName
    self.teamIcon.sprite = self.data.teamIcon
    
    SetActive(self.goRed, FriendChatMgr.IsShowBadgeRedIcon(self.data.id))
    self.gameObject:SetActive(true)
end

function FriendPlayerInfoBadgeItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrameIcon)
    self.data = nil
    self.gameObject:SetActive(false)
end

function FriendPlayerInfoBadgeItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrameIcon)
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.getCommand)
        self.getCommand = nil
    end
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
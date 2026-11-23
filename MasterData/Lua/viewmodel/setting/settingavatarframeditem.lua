SettingAvatarFramedItem = {}

SettingAvatarFramedItem.__index = SettingAvatarFramedItem

local objs = {
    bg = { path = "bg", type = "Button" },
    icon = { path = "icon", type = "RawImage" },
    iconGo =  { path = "icon", type = "GameObject" },
    defaultIconGo = { path = "defaultIcon", type = "GameObject" },
    redIcon = { path = "redIcon", type = "RedIconListener" },
    lock = { path = "lock", type = "GameObject" },
    frame = { path = "frame", type = "Image" },
    select = { path = "select", type = "GameObject" },
    dynamicAvatar = { path = "DynamicAvatar", type = "GameObject" },
    playerDynamicAvatar = { path = "DynamicAvatar", type = "PlayerDynamicAvatar" },
}

function SettingAvatarFramedItem.New(prefab, parent)
    local self = {}
    setmetatable(self, SettingAvatarFramedItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    
    self.OnClickBg = function()
        self.data.OnClickBg(self.data.index)
    end
    LuaMgr.AddClick(self.bg, self.OnClickBg)
    return self
end

function SettingAvatarFramedItem:SetData(data)
    self.data = data
    if data.isAvatar then
        if data.imgType == 2 and not data.lock then
            self.playerDynamicAvatar:AppointAvatar(data.avatarID)
        else
            self.icon.texture = data.avatar
            self.icon.color = data.color
        end
        local isShow = data.isAvatar and data.imgType == 2 and not data.lock
        SetActive(self.dynamicAvatar,isShow)
        SetActive(self.iconGo, not isShow)
    else
        SetActive(self.iconGo, false)
        SetActive(self.dynamicAvatar,false)
    end
    
    SetActive(self.defaultIconGo, not data.isAvatar)
    SetActive(self.lock, data.lock)
    SetActive(self.select, data.select)

    PlayerAvatarFrameTool.SetAvatarFrame(self.frame, data.frameID or data.frameId)
    self.redIcon.RedId = data.redId

    RedMgr.Singleton:Refresh()
    SetActive(self.gameObject, true)
end

function SettingAvatarFramedItem:Clear()
    PlayerAvatarFrameTool.ClearImage(self.frame)
    self.data = nil
    SetActive(self.gameObject, false)
end

function SettingAvatarFramedItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.frame)
    if (self.OnClickBg ~= nil) then
        LuaMgr.RemoveClick(self.bg, self.OnClickBg)
        self.OnClickBg = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end











SSYXPlayerItem = {}
SSYXPlayerItem.__index = SSYXPlayerItem

local objs = {
    avatar = {path = "Group/Avatar", type = UITool.RawImage},
    avatarFrame = {path = "Group/AvatarFrame", type = UITool.Image},
    dynamicAvatar = {path = "Group/DynamicAvatar", type = UITool.PlayerDynamicAvatar},
    visitBtn = {path = "Group/VisitBtn", type = UITool.Button},
    waterCount = {path = "Group/WaterCount", type = UITool.Text},
    name = {path = "Group/Name", type = UITool.Text},
    managementLevel = {path = "Group/ManagementLevel", type = UITool.Text}
}

SSYXPlayerItem.New = function()

    local self = {}
    setmetatable(self, SSYXPlayerItem)
    return self
end

function SSYXPlayerItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickVisitBtn = function()
        if self.data.OnClickVisitPlayer ~= nil then
            self.data.OnClickVisitPlayer(self)
        end
    end
    LuaMgr.AddClick(self.visitBtn, self.OnClickVisitBtn)
end

function SSYXPlayerItem:SetData(data)
    self.data = data.data
    self.waterCount.text = tostring(self.data.WateringCount)
    self.name.text = self.data.Name
    self.managementLevel.text = tostring(self.data.Level)
    self:SetPlayerAvatar()
end

function SSYXPlayerItem:SetPlayerAvatar()
    local avatarTexture, imgTye = SSYXData.GetPlayerAvatar(self.data.Avatar)
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine)
        self.coroutine = nil
    end
    if imgTye == 1 then
        self.avatar.texture = avatarTexture
        SetActive(self.dynamicAvatar.gameObject, false)
    else
        self:SetDynamicAvatar()
    end
    SetActive(self.avatar.gameObject, imgTye == 1)
    PlayerAvatarFrameTool.SetAvatarFrame(self.avatarFrame, self.data.AvatarFrame)
end

function SSYXPlayerItem:SetDynamicAvatar()
    self.dynamicAvatar:AppointAvatar(self.data.Avatar)
    SetActive(self.dynamicAvatar.gameObject, false)
    local onDelay = function()
        coroutine_runner.wait(0.1)
        SetActive(self.dynamicAvatar.gameObject, true)
    end
    self.coroutine = coroutine_runner.start(onDelay)
end

function SSYXPlayerItem:ClearItems()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrame)
end

function SSYXPlayerItem:Clear()
    self:ClearItems()
end

function SSYXPlayerItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrame)
    LuaMgr.RemoveClick(self.visitBtn, self.OnClickVisitBtn)
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
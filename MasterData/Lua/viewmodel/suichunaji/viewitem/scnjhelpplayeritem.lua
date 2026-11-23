







SCNJHelpPlayerItem = {}
SCNJHelpPlayerItem.__index = SCNJHelpPlayerItem

local objs = {
    helpBtn = {path = "Group/HelpBtn", type = UITool.Button},
    playerName = {path = "Group/PlayerName", type = UITool.Text},
    fireSpeed = {path = "Group/FireSpeed", type = UITool.Text},
    maxFireCount = {path = "Group/MaxFireCount", type = UITool.Text},
    avatar = {path = "Group/Avatar", type = UITool.RawImage},
    avatarFrame = {path = "Group/AvatarFrame", type = UITool.Image},
    dynamicAvatar = {path = "Group/DynamicAvatar", type = UITool.PlayerDynamicAvatar}
}

SCNJHelpPlayerItem.InitFramesDic = function()
    if SCNJHelpPlayerItem.avatarFramesConfigDic == nil then
        SCNJHelpPlayerItem.avatarFramesConfigDic = {}
        for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
            SCNJHelpPlayerItem.avatarFramesConfigDic[v.id] = v
        end
    end
end

SCNJHelpPlayerItem.New = function()
    SCNJHelpPlayerItem.InitFramesDic()

    local self = {}
    setmetatable(self, SCNJHelpPlayerItem)
    self.goodsItems = {}
    return self
end

function SCNJHelpPlayerItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickHelp = function()
        if self.data.helpCallback ~= nil then
            self.data.helpCallback(self)
        end
    end
    LuaMgr.AddClick(self.helpBtn, self.OnClickHelp)
end

function SCNJHelpPlayerItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetItem()
end

function SCNJHelpPlayerItem:SetItem()
    self:SetPlayerAvatar()
    self.playerName.text = self.data.Name
    self.fireSpeed.text = self.data.Diff
    self.maxFireCount.text = tostring(self.data.Damage)
    self:RefreshHelpStatus(self.data.IsBeHelp)
end

function SCNJHelpPlayerItem:RefreshHelpStatus(isBeHelp)
    self.data.IsBeHelp = isBeHelp
    SetActive(self.helpBtn.gameObject, isBeHelp == false)
end

function SCNJHelpPlayerItem:GetPlayerAvatar()
    local avatarConfig = SCNJHelpPlayerItem.avatarFramesConfigDic[self.data.Avatar]
    if avatarConfig == nil then
        return nil
    end
    local avatarPath = ConfigHelper.GetHeadIconPath(avatarConfig.img, avatarConfig.imgId)
    return LuaMgr.GetTexture(avatarPath), avatarConfig.imgType
end

function SCNJHelpPlayerItem:GetPlayerFrame()
    local frameConfig = SCNJHelpPlayerItem.avatarFramesConfigDic[self.data.AvatarFrameIcon]
    if frameConfig == nil then
        return nil
    end
    return frameConfig.id
end

function SCNJHelpPlayerItem:SetPlayerAvatar()
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine)
        self.coroutine = nil
    end
    local avatarTexture, imgType = self:GetPlayerAvatar()
    if imgType == 1 then
        self.avatar.texture = avatarTexture
        SetActive(self.dynamicAvatar.gameObject, false)
    else
        self:SetDynamicAvatar()
    end
    SetActive(self.avatar.gameObject, imgType == 1)
    PlayerAvatarFrameTool.SetAvatarFrame(self.avatarFrame, self:GetPlayerFrame())
end

function SCNJHelpPlayerItem:SetDynamicAvatar()
    self.dynamicAvatar:AppointAvatar(self.data.Avatar)
    SetActive(self.dynamicAvatar.gameObject, false)
    local onDelay = function()
        coroutine_runner.wait(0.1)
        SetActive(self.dynamicAvatar.gameObject, true)
    end
    self.coroutine = coroutine_runner.start(onDelay)
end

function SCNJHelpPlayerItem:ClearItems()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrame)
end

function SCNJHelpPlayerItem:Clear()
    self:ClearItems()
end

function SCNJHelpPlayerItem:Destroy()
    PlayerAvatarFrameTool.ClearImage(self.avatarFrame)
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.data = nil
end
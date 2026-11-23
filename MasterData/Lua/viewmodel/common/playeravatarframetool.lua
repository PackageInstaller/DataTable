PlayerAvatarFrameTool = PlayerAvatarFrameTool or {}
PlayerAvatarFrameTool.__index = PlayerAvatarFrameTool

local staticAtlasName = "AvatarFrame"
local effectPrefabPathFormat = "Assets/_RefResources/Effect/Prerfabs/FrameEffect/%s.prefab"

local frameConfigCache = {}
local effectPathCache = {}
local imageControllerCache = setmetatable({}, { __mode = "k" })

local function cacheFrameConfig(frameId, frameConfig)
    if frameConfig == nil then
        return
    end

    frameConfigCache[frameId] = frameConfig
    if not IsNullOrEmpty(frameConfig.id) then
        frameConfigCache[frameConfig.id] = frameConfig
    end
    if not IsNullOrEmpty(frameConfig.img) then
        frameConfigCache[frameConfig.img] = frameConfig
    end
end

local function getFrameConfig(frameId)
    if IsNullOrEmpty(frameId) then
        return nil
    end

    if frameConfigCache[frameId] ~= nil then
        return frameConfigCache[frameId]
    end

    if ConfigHelper ~= nil and ConfigHelper.GetAvatarFrame ~= nil then
        local frameConfig = ConfigHelper.GetAvatarFrame(frameId)
        cacheFrameConfig(frameId, frameConfig)
        return frameConfig
    end

    local avatarFrames = ConfigMgr.Config.avatarFrames
    local len = #avatarFrames
    for i = 1, len do
        if avatarFrames[i].id == frameId or avatarFrames[i].img == frameId then
            cacheFrameConfig(frameId, avatarFrames[i])
            return avatarFrames[i]
        end
    end
    return nil
end

local function getEffectName(frameId)
    local frameConfig = getFrameConfig(frameId)
    if frameConfig ~= nil then
        return frameConfig.img
    end
    return frameId
end

local function getEffectPrefabPath(frameId, frameConfig)
    if IsNullOrEmpty(frameId) then
        return nil
    end

    local effectName = frameConfig ~= nil and frameConfig.img or getEffectName(frameId)
    if IsNullOrEmpty(effectName) then
        return nil
    end

    if effectPathCache[effectName] == false then
        return nil
    end

    if type(effectPathCache[effectName]) == "string" then
        return effectPathCache[effectName]
    end

    local path = string.format(effectPrefabPathFormat, effectName)
    if LuaMgr.HasAsset(path) then
        effectPathCache[effectName] = path
        return path
    end

    effectPathCache[effectName] = false
    return nil
end

function PlayerAvatarFrameTool.New(image)
    local self = {}
    setmetatable(self, PlayerAvatarFrameTool)
    self.image = image
    self.frameId = nil
    self.effectPath = nil
    self.effectGo = nil
    return self
end

function PlayerAvatarFrameTool.Bind(image)
    return PlayerAvatarFrameTool.New(image)
end

function PlayerAvatarFrameTool.SetAvatarFrame(image, frameId)
    if IsObjectNull(image) then
        return false
    end

    local controller = imageControllerCache[image]
    if controller == nil then
        controller = PlayerAvatarFrameTool.New(image)
        imageControllerCache[image] = controller
    end
    return controller:AppointAvatarFrame(frameId)
end

function PlayerAvatarFrameTool.ClearImage(image)
    if image == nil then
        return
    end

    local controller = imageControllerCache[image]
    if controller ~= nil then
        controller:Dispose()
        imageControllerCache[image] = nil
    end
end

function PlayerAvatarFrameTool.HasDynamicAvatarFrame(frameId)
    return getEffectPrefabPath(frameId) ~= nil
end

function PlayerAvatarFrameTool.GetStaticSprite(frameId, frameConfig)
    frameConfig = frameConfig or getFrameConfig(frameId)
    local spriteName = TableIsNull(frameConfig) and frameId or frameConfig.img
    if IsNullOrEmpty(spriteName) then
        return nil
    end
    return LuaMgr.GetSprite(staticAtlasName, spriteName)
end

function PlayerAvatarFrameTool:SetStaticFrame(frameId, frameConfig)
    if IsObjectNull(self.image) then
        return
    end

    local sprite = PlayerAvatarFrameTool.GetStaticSprite(frameId, frameConfig)
    if not IsObjectNull(sprite) then
        self.image.enabled = true
        self.image.sprite = sprite
    end
end

function PlayerAvatarFrameTool:ClearEffect()
    if not IsNullOrEmpty(self.effectPath) then
        LuaMgr.RemovePrefabRefCount(self.effectPath)
    end
    self.effectPath = nil

    if not IsObjectNull(self.effectGo) then
        LuaMgr.DestroyImmediateGO(self.effectGo)
    end
    self.effectGo = nil
end

function PlayerAvatarFrameTool:ShowEffect(prefabPath)
    if IsObjectNull(self.image) then
        return false
    end

    if IsNullOrEmpty(prefabPath) then
        self:ClearEffect()
        return false
    end

    if self.effectPath == prefabPath and not IsObjectNull(self.effectGo) then
        return true
    end

    self:ClearEffect()
    self.effectGo = LuaMgr.GetPrefab(prefabPath)
    if IsObjectNull(self.effectGo) then
        return false
    end

    LuaMgr.AddPrefabRefCount(prefabPath)
    self.effectPath = prefabPath

    local effectTransform = self.effectGo.transform
    effectTransform:SetParent(self.image.transform, false)
    effectTransform.localPosition = Vector3.zero
    effectTransform.localScale = Vector3(0.35,0.35,0.35)
    SetActive(self.effectGo, true)
    self.image.enabled = false
    return true
end

function PlayerAvatarFrameTool:AppointAvatarFrame(frameId)
    self.frameId = frameId

    if IsObjectNull(self.image) then
        return false
    end

    if IsNullOrEmpty(frameId) then
        self:Clear()
        return false
    end

    local frameConfig = getFrameConfig(frameId)
    if self:ShowEffect(getEffectPrefabPath(frameId, frameConfig)) then
        return true
    else
        self:SetStaticFrame(frameId, frameConfig)
        return false
    end
    
end

function PlayerAvatarFrameTool:Clear()
    self:ClearEffect()
    if not IsObjectNull(self.image) then
        self.image.sprite = nil
    end
    self.frameId = nil
end

function PlayerAvatarFrameTool:Dispose()
    self:Clear()
    self.image = nil
end

return PlayerAvatarFrameTool
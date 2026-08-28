------------ import ------------
local ResourceModule   = CS.Engine.Modules.ResourceModule
local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local Animator        = CS.UnityEngine.Animator
---@type CriWareUtils
local CriWareUtils    = import('Game.Entry.CriWareUtilsFix')
---@type GachaponUtils
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
local Yielders        = CS.Engine.Lib.Yielders
-- local GameObject       = CS.UnityEngine.GameObject
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParameters = CS.Engine.Modules.LuaParameters
------------ import ------------

------------ define ------------
local isNull         = isNull
local yield_return   = cs_coroutine.yield_return
local AnimatorType   = typeof(Animator)
local PlayableDirectorType  = typeof(CS.UnityEngine.Playables.PlayableDirector)
local CustomLightDirRelativeCameraType = typeof(CS.CustomLightDirRelativeCamera)
local PlaneShadowType = typeof(CS.PlaneShadow)
local EnterLobbyHash = Animator.StringToHash("enter_lobby")
local CustomLightDirection = Vector3.New(25, 17, 0)
-- local IDLE_SWITCH_LOBBY = "isSwitch"
------------ define ------------

---@class CardProgressionControllerRoleLoad
local CardProgressionControllerRoleLoad = Class('CardProgressionControllerRoleLoad')


function CardProgressionControllerRoleLoad:__init()
    self._roleSkinId           = nil  --- 人物皮肤id
    self._roleGo               = nil  --- 人物实例
    self._roleTlGo             = nil  --- 人物timeline实例
    self._roleBindingList      = nil  --- 人物timeline 动态绑定的列表
    self._rolePlayableDirector = nil  --- 人物timeline

    self._catSkinId            = nil  --- 猫皮肤id
    self._catGo                = nil  --- 猫实例

    self._isActiveRoleRoot     = nil ---是否激活人物root
    self._isActiveCatRoot      = nil ---是否激活猫root

    self._isShowDefineScene     = true
end


function CardProgressionControllerRoleLoad:__delete()
    self:__ClearExtraPrefab()
    self:ClearRole()
    self:ClearCat()
    -- self:__ClearCache(self._skinId2Go,    self._skinId2Loader)
    -- self:__ClearCache(self._skinId2CatGo, self._skinId2CatLoader)
    self._skinId2Go        = nil
    self._skinId2Loader    = nil
    self._skinId2CatGo     = nil
    self._skinId2CatLoader = nil

    self._defineScene = nil

end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionControllerRoleLoad:Init(locationNode, roleRoot, catRoot, sceneInstance, extraSceneRoot)
    if isNull(locationNode) then return end
    self._roleRoot = roleRoot
    self._catRoot  = catRoot
    self._extraSceneRoot  = extraSceneRoot
    
    ---@type UnityEngine.GameObject
    local MainScene = sceneInstance:GetCacheObjectByName(CardProgressionConstants.SceneDefine.Main_Scene)
    self._defineScene = nil
    if isNotNull(MainScene) then
        self._defineScene = MainScene.transform:Find(CardProgressionConstants.SceneDefine.Scene)
    end
    -- self:SetRoleRootShowState(true)
    -- self:SetCatRootShowState(true)
end

--- CreateRoot
---@param parent UnityEngine.Transform
---@param rootName string
function CardProgressionControllerRoleLoad:CreateRoot(parent, rootName)
    local rootNode = parent:Find(rootName)
    if isNull(rootNode) then
        return KTool.CreateEmptyGameObject(parent.gameObject, rootName, false)
    else
        return rootNode.gameObject
    end
end

---------------------------------------------------
--- init end --
---------------------------------------------------

---------------------------------------------------
--- role begin --
---------------------------------------------------

--- LoadRole
--  加载人物
---@param skinId number 皮肤id
---@param cardSkinVo CardSkinVo 
---@param isPreviewSkin boolean | nil
function CardProgressionControllerRoleLoad:LoadRole(skinId, cardSkinVo, isPreviewSkin)
    self._roleSkinId = skinId
    local isInstanceExtraGo = self:InitExtraLoader(cardSkinVo)
    self:InitRoleLoader(cardSkinVo, isPreviewSkin)
    self:InitExtraPrefab(cardSkinVo, isInstanceExtraGo) 
    self:InstanceRole(skinId, cardSkinVo)

end

function CardProgressionControllerRoleLoad:InitExtraLoader(cardSkinVo)
    local skinScene = cardSkinVo.skinScene
    if string.isEmpty(cardSkinVo.skinScene) then
        -- self._skinScene = skinScene
        return
    end
    if self._skinScene == skinScene then
        return false
    end
    self._skinScene = skinScene
    local extraPrefabPath = string.format(CardProgressionConstants.PrefabPath.RuntimeItemPath, cardSkinVo.skinScene)
    self._extraLoader = self:CreateLoader(extraPrefabPath)
    return true
    
end

function CardProgressionControllerRoleLoad:InitRoleLoader(cardSkinVo, isPreviewSkin)
    ---预览皮肤 通过配表isHarmonious 是否使用正常检查
    local lobbyMode = isPreviewSkin == true and cardSkinVo:CheckAndGetLobbyMode() or cardSkinVo.lobbyMode
    local prefabPath   = string.format(CardProgressionConstants.PrefabPath.CardLobbyPath, lobbyMode)
    self._roleLoader  = self:CreateLoader(prefabPath)
end

---InitExtraPrefab
---@param cardSkinVo CardSkinVo
function CardProgressionControllerRoleLoad:InitExtraPrefab(cardSkinVo, isInstanceExtraGo)
    if isNull(self._extraLoader) or not isInstanceExtraGo then
        -- self:FreshDefineSceneShowState(true)
        return
    end
    self._extraGo = CardProgressionUtils.CustomInstantiate(self._extraLoader, self._extraSceneRoot)
    -- if isNotNull(self._extraGo) then
    --     local transform = self._extraGo.transform
    --     local position = cardSkinVo:GetSkinScenePosition() 
    --     local rotation = cardSkinVo:GetSceneRotation()
    --     if position then
    --         transform.localPosition = position
    --     end
    --     if rotation then
    --         transform.localRotation = rotation
    --     end
    -- end
    self:InitExtraSceneTrans(cardSkinVo)
    self:FreshDefineSceneShowState(false)
    
end

function CardProgressionControllerRoleLoad:InitExtraSceneTrans(cardSkinVo)
    if isNotNull(self._extraGo) then
        local transform = self._extraGo.transform
        local position = cardSkinVo:GetSkinScenePosition() 
        local rotation = cardSkinVo:GetSceneRotation()
        if position then
            transform.localPosition = position
        end
        if rotation then
            transform.localRotation = rotation
        end
    end
end

--- InstanceRole
--- 实例化人物
---@param skinId number 皮肤id
function CardProgressionControllerRoleLoad:InstanceRole(skinId, cardSkinVo)
    if isNull(self._roleLoader) then
        return
    end
    local roleGo = CardProgressionUtils.CustomInstantiate(self._roleLoader, self._roleRoot)
    self._roleGo = roleGo
    -- local roleGo = GameUtils.LoadBundleAsync(prefabPath, self._roleRoot, false, true)
    -- self._roleGo = roleGo

    self:InitialRole(roleGo, skinId, cardSkinVo)

end

function CardProgressionControllerRoleLoad:InitialRole(roleGo, skinId, cardSkinVo)
    -- roleGo.name = skinId
    -- roleGo.transform:

    ---@type CustomLightDirRelativeCamera
    local relativeCamera = KTool.GetOrAddComponent(roleGo, CustomLightDirRelativeCameraType)
    relativeCamera.UsrCustomLightColor = false
    local lightDirection = cardSkinVo:GetLightDirection()
    relativeCamera.CustomLightDirection = lightDirection ~= nil and lightDirection or CustomLightDirection
    relativeCamera.DelayUpdate = true
    relativeCamera.RelativeRole = false

    -- ---@type PlaneShadow
    -- local planeShadow = KTool.GetComponent(roleGo, PlaneShadowType)
    -- if isNotNull(planeShadow) then
    --     planeShadow.shadowInvLen = 0
    -- end

    -- 关掉 role 阴影:
    local roleLuaParams = KTool.GetComponent(roleGo, typeof(LuaParameters)) -- maybe nil

    local isCloseShadow = false
    if isNotNull(roleLuaParams) then 
        isCloseShadow = LuaParametersReader.Read(roleLuaParams, "isCloseShadow", LuaParametersReader.Type.Bool)
    end 
    local planeShadow = KTool.GetComponent(roleGo, PlaneShadowType)
    if isNotNull(planeShadow) then
        planeShadow.shadowInvLen = isCloseShadow and 1 or 0 -- 写1为关掉
    end
    

    local transform = roleGo.transform
    transform:ResetLocalPosition()
    transform:ResetLocalRotation()

    self._roleFaceForward = UICommonUtils.GetFaceForward(roleGo)
    KTool.SetActive(roleGo, false)
end

function CardProgressionControllerRoleLoad:StopTimeLine()
    self:__StopTimeLine(self._rolePlayableDirector, self._roleBindingList, self._roleTlGo, self._roleGo)
end

--- ClearRole
--- 清理人物
function CardProgressionControllerRoleLoad:ClearRole()
    self:__StopTimeLine(self._rolePlayableDirector, self._roleBindingList, self._roleTlGo, self._roleGo)
    
    self:__ClearCache(self._roleGo)

    self._roleLoader  = nil
    self._roleGo               = nil
    self._roleTlGo             = nil
    self._roleBindingList      = nil
    self._rolePlayableDirector = nil
    self._roleFaceForward      = nil

end

--- PlayRoleEnter
---@param carSkinVo CardSkinVo 卡牌皮肤表数据
---@param isDisableEnter boolean 是否禁止入场播放
function CardProgressionControllerRoleLoad:PlayRoleEnter(carSkinVo, isDisableEnter)
    if isDisableEnter then
        self:PlayRoleIdle(self._roleGo)
        return 
    end

    ---@type UnityEngine.GameObject
    local roleGo = self._roleGo
    local enterTimeLine = carSkinVo.enterTimeLine
    if string.isEmpty(enterTimeLine) then
        self:__PlayAnimatorEnter(roleGo)
        
    else
        self:__PlayTimeLineEnter(roleGo, enterTimeLine, carSkinVo.enterSound)
            
    end
end

function CardProgressionControllerRoleLoad:__PlayAnimatorEnter(roleGo)
    KTool.SetActive(roleGo, true)
    local animator = KTool.GetComponent(roleGo, AnimatorType)
    if not isNull(animator) then
        cs_coroutine.yield_return(animator:PlayAndWait(EnterLobbyHash))
    end
end

function CardProgressionControllerRoleLoad:__PlayTimeLineEnter(go, enterTimeLine, soundId)
    self._tlCo = cs_coroutine.start(function()
        local path     = string.format('Timeline/EnterPrefab/%s.prefab', enterTimeLine)
        local tlGo     = GameUtils.LoadBundleAsync(path, self._roleRoot, false, true)
        local playableDirector = tlGo:GetComponentInChildren(PlayableDirectorType)
        playableDirector.playOnAwake = false
        self._roleTlGo             = tlGo
        self._roleBindingList      = GachaponUtils.BindTimeline(playableDirector, 'role', go)
        self._rolePlayableDirector = playableDirector
        KTool.SetActive(go, true)
        playableDirector:Play()
    
        self:__PlaySound(soundId)
    
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(playableDirector.duration))
    
        self:__StopTimeLine(self._rolePlayableDirector, self._roleBindingList, self._roleTlGo, self._roleGo)
    end)
    
end

function CardProgressionControllerRoleLoad:FreshDefineSceneShowState(isShow)
    CfUtils.SetActive(self._defineScene, isShow)
    
end

---------------------------------------------------
--- role end --
---------------------------------------------------


---------------------------------------------------
--- cat begin --
---------------------------------------------------

--- LoadCat
--  加载猫
---@param skinId number 皮肤id
---@param prefabPath string 预制件路径
function CardProgressionControllerRoleLoad:LoadCat(skinId, cardSkinVo, cardId)
    self._catSkinId = skinId

    local isInstanceExtraGo = self:InitExtraLoader(cardSkinVo)
    self:InitCatLoader(cardSkinVo)
    self:InitExtraPrefab(cardSkinVo, isInstanceExtraGo) 
    self:InstanceCat(skinId, cardId)

end

function CardProgressionControllerRoleLoad:InitCatLoader(cardSkinVo)
    local prefabPath   = string.format(CardProgressionConstants.PrefabPath.CatLobbyPath, cardSkinVo.catPrefab)
    self._catLoader  = self:CreateLoader(prefabPath)
end

--- InstanceCat
--- 实例化猫
---@param prefabPath string 猫路径
function CardProgressionControllerRoleLoad:InstanceCat(skinId, cardId)
    if isNull(self._catLoader) then
        return
    end
    local go = CardProgressionUtils.CustomInstantiate(self._catLoader, self._catRoot)
    self._catGo = go
    -- ---@type UnityEngine.GameObject
    -- local go    = GameUtils.LoadBundleAsync(prefabPath, self._catRoot, false, true)
    -- self._catGo = go
    self:InitialCat(go, cardId, skinId)
   
end

function CardProgressionControllerRoleLoad:InitialCat(go, cardId, skinId)
    ---@type CardPositionVo
    local positionVo = CardConfMgr:GetInstance():GetCardPosByCardId(cardId, skinId)
    local catPosition, catRotation = positionVo:GetCatPositionAndRotation()
    local transform = go.transform
    if catPosition then
        transform.localPosition = catPosition
    else
        transform:ResetLocalPosition()
     end
    if catRotation then
        transform.localRotation = catRotation
    else
        transform:ResetLocalRotation()
     end
end

function CardProgressionControllerRoleLoad:ReInitialCat(cardId, skinId)
    self:InitialCat(self._catGo, cardId, skinId)
end

--- ClearCat
--- 清理猫
function CardProgressionControllerRoleLoad:ClearCat()
    self._weapons = nil
    self:__ClearCache(self._catGo)

    self._catLoader = nil
    self._catGo = nil
    
end


---------------------------------------------------
--- cat end --
---------------------------------------------------


---------------------------------------------------
--- extra scene begin --
---------------------------------------------------

function CardProgressionControllerRoleLoad:LoadExtraScene(skinId, cardSkinVo)
    self._extraSceneSkinId = skinId
    local isInstanceExtraGo = self:InitExtraLoader(cardSkinVo)
    self:InitExtraPrefab(cardSkinVo, isInstanceExtraGo) 
end

---------------------------------------------------
--- extra scene end --
---------------------------------------------------

---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionControllerRoleLoad:__ClearCache(go)
    self:__ClearGo(go)
end

function CardProgressionControllerRoleLoad:__ClearGo(go)
    KTool.SafeDelete(go)
end

--function CardProgressionControllerRoleLoad:__ClearLoader(key2Loader, key)
--    ---@param v Engine.Modules.AssetBundleLoader
--    for k, v in pairs(key2Loader) do
--        if key ~= k and not isNull(v) then
--            v:Release()
--        end
--    end
--end

function CardProgressionControllerRoleLoad:__StopTimeLine(playableDirector, bindingList, tlGo, go)
    if not isNull(self._tlCo) then
        cs_coroutine.stop(self._tlCo)
        self._tlCo = nil
    end
    ---1. clear bind
    local res = not isNull(playableDirector)
    if not isNull(playableDirector) then
        GachaponUtils.StopAndEvaluateSpecifyTime(playableDirector)
        GachaponUtils.ClearTimelineBinding(playableDirector, bindingList)
        self._rolePlayableDirector = nil

    end

    --- 2. 设置完成标记

    --- 3. 删除timeline
    if not isNull(tlGo) then
        KTool.SafeDelete(tlGo.gameObject, true)
    end

    
    ---4. 重置Animator 为 idle
    self:PlayRoleIdle(go)

end

function CardProgressionControllerRoleLoad:__PlaySound(soundId)
    if string.isEmpty(soundId) then return end

    CriWareUtils.PlaySeById(soundId)
    self._soundId = soundId
end
function CardProgressionControllerRoleLoad:StopSe()
    local soundId = self._soundId
    if self._soundId then return end
    CriWareUtils.StopById(soundId)
    self._soundId = nil

end

function CardProgressionControllerRoleLoad:PlayRoleIdle(go)
    -- if not isNull(go) then
    --     KTool.SetActive(go, true)
        
    --     local animator = KTool.GetComponent(go, AnimatorType)
    --     if not isNull(animator) then
    --         animator:SetTrigger(IDLE_SWITCH_LOBBY)
    --     end
    -- end
    CardProgressionUtils.PlayRoleIdle(go)
end

function CardProgressionControllerRoleLoad:ClearExtraPrefab(isForce, newSkinScene, cardSkinVo)
    if isForce then
        self:__ClearExtraPrefab()
        return
    end

    local isSameSkin = newSkinScene == self._skinScene
    if string.isEmpty(newSkinScene) or not isSameSkin then
        self:__ClearExtraPrefab()
    elseif isSameSkin then
        if cardSkinVo then
            self:InitExtraSceneTrans(cardSkinVo)
        end
        self:FreshExtraPrefabShowState(true)
    end

end

function CardProgressionControllerRoleLoad:FreshExtraPrefabShowState(isShow)
    CfUtils.SetActive(self._extraGo, isShow)
    self:FreshDefineSceneShowState(not isShow)
end

function CardProgressionControllerRoleLoad:__ClearExtraPrefab()
    self:FreshDefineSceneShowState(true)
    KTool.SafeDelete(self._extraGo, true)
    -- self:__ClearCache(self._extraGo)
    self._skinScene = nil
    self._extraGo = nil
    self._extraLoader = nil
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionControllerRoleLoad:CreateLoader(prefabPath)
    if string.isEmpty(prefabPath) then return  end
    return ResourceModule.LoadBundleAsync(prefabPath, nil, true)
end

function CardProgressionControllerRoleLoad:GetRoleSkinId()
    return self._roleSkinId
end

function CardProgressionControllerRoleLoad:GetCatSkinId()
    return self._catSkinId
end
function CardProgressionControllerRoleLoad:SetCatSkinId(catSkinId)
    self._catSkinId = catSkinId
end

function CardProgressionControllerRoleLoad:GetRole()
    return self._roleGo
end

function CardProgressionControllerRoleLoad:GetCat()
    return self._catGo
end

function CardProgressionControllerRoleLoad:GetIsActiveRoleRoot()
    return self._isActiveRoleRoot

end

function CardProgressionControllerRoleLoad:IsChangeActiveRoleRoot(isActive)
    return self._isActiveRoleRoot ~= isActive
end

---SetRoleRootShowState
---@return boolean 是否改变显示隐藏
function CardProgressionControllerRoleLoad:SetRoleRootShowState(isActive)
    if self._isActiveRoleRoot ~= isActive then
        self._isActiveRoleRoot = isActive
        if not isNull(self._roleRoot) then
            KTool.SetActive(self._roleRoot.gameObject, isActive)
        end
        return true
    end
    return false
end

function CardProgressionControllerRoleLoad:GetIsActiveCatRoot()
    return self._isActiveCatRoot

end

---SetCatRootShowState
---@return boolean 是否改变显示隐藏
function CardProgressionControllerRoleLoad:SetCatRootShowState(isActive)
    if self._isActiveCatRoot ~= isActive then
        self._isActiveCatRoot = isActive
        if not isNull(self._catRoot) then
            KTool.SetActive(self._catRoot.gameObject, isActive)
        end
        return true
    end
    return false

end

function CardProgressionControllerRoleLoad:GetRoleFaceForward()
    return self._roleFaceForward
end

function CardProgressionControllerRoleLoad:GetSkinScene()
    return self._skinScene
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------

return CardProgressionControllerRoleLoad


------------ import ------------
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type Engine.Lib.KCookie
local KCookie                  = CS.Engine.Lib.KCookie
local sceneManagement          = SceneManagement:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
local cs_coroutine             = require "XLua.cs_coroutine"
local DOTween                  = CS.DG.Tweening.DOTween
local CatTouchController      = import("Game.Behaviours.CatTouchController")
------------ import ------------


------------ define ------------
local isNull       = isNull
local ExclusiveWeaponControllerType    = typeof(CS.Game.Native.Common.ExclusiveWeaponController)

local ControllerType = {
    Role   = 1,
    Camera = 2,
}
------------ define ------------

---@class CardProgressionControllerRole
local CardProgressionControllerRole = Class('CardProgressionControllerRole')

function CardProgressionControllerRole:__init()
    self._controllerComp = {}
    self._isInit         = false 
    self._skinId         = nil
    self._catPrefab      = nil
    self._cameraForward  = nil
    self._cameraState    = nil
    self._showCardDojo   = nil

    ---@type CatTouchController
    self._touchController = CatTouchController.New()
end


function CardProgressionControllerRole:__delete()
    self._touchController:Delete()
    self._touchController = nil
    for k, v in pairs(self._listenerConf) do
        Events.RemoveListener(k, v)
    end
    for k, controller in pairs(self._controllerComp) do
        controller:Delete()
    end
end


function CardProgressionControllerRole:Awake()
    -- self:InitNode()
    self:InitListener()
    
end


-- function CardProgressionControllerRole:Start()
-- end


function CardProgressionControllerRole:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionControllerRole:InitNode(isShowGrowScene)
    if self._isInit then return end

    local sceneId = KCookie.Get(Constants.UICacheDataKeys.MainSceneID)
    ---@type SceneInstance
    local sceneInstance = sceneManagement:GetSceneInstance(sceneId)
    if sceneInstance == nil then
        return
    end

    ---@type UnityEngine.GameObject
    local roleLocation      = sceneInstance:GetCacheObjectByName(CardProgressionConstants.SceneDefine.Cultivate_loc)
    local cultivateLocationTrans = roleLocation.transform
    local homeLocation      = cultivateLocationTrans:Find(CardProgressionConstants.SceneDefine.LocationUp)
    local cultivateLocation = cultivateLocationTrans:Find(CardProgressionConstants.SceneDefine.LocationDown)
    local uiRoleLocation = cultivateLocationTrans:Find(CardProgressionConstants.SceneDefine.LocationUiRole)
    local locationNode      = isShowGrowScene and cultivateLocation or homeLocation
    self._homeLocation      = homeLocation
    self._cultivateLocation = cultivateLocation
    self._uiRoleLocation = uiRoleLocation

    local extraSceneRoot        = self:CreateRoot(locationNode, CardProgressionConstants.SceneDefine.ExtraSceneRoot)
    local roleRoot              = self:CreateRoot(locationNode, CardProgressionConstants.SceneDefine.RoleRoot)
    local exclusiveWeaponTarget = self:CreateRoot(roleRoot.transform, CardProgressionConstants.SceneDefine.ExclusiveWeaponTarget)
    local catRoot               = self:CreateRoot(locationNode, CardProgressionConstants.SceneDefine.CatRoot)
    ---@type CustomLightDirRelativeCamera
    local relativeCamera = KTool.GetOrAddComponent(catRoot.gameObject, CardProgressionConstants.CompType.CustomLightDirRelativeCameraType)
    relativeCamera.UsrCustomLightColor = false
    relativeCamera.CustomLightDirection = Vector3.New(25, 17, 0)
    relativeCamera.DelayUpdate = false
    self._relativeCamera = relativeCamera
    
    self._extraSceneRoot = extraSceneRoot
    self._roleRoot       = roleRoot
    self._catRoot        = catRoot
    local rootTrans            = sceneInstance:GetCacheObjectByName(CardProgressionConstants.SceneDefine.VirtualCameraRoot).transform
    local homeCameraTrans      = rootTrans:Find(CardProgressionConstants.SceneDefine.HomeCamera)
    local cultivateCameraTrans = homeCameraTrans
    --local cultivateCameraTrans = rootTrans:Find(CardProgressionConstants.SceneDefine.CultivateCamera)
    -- KTool.SetActive(cultivateCameraTrans.gameObject, t)

    KTool.SetActive(homeCameraTrans.gameObject, true)
    self._cultivateCameraTrans  = cultivateCameraTrans
    self.cameraForward     = cultivateCameraTrans.forward
    
    self:InitRoleLoadController(locationNode, roleRoot, catRoot, sceneInstance, self._extraSceneRoot)
    self:InitCameraController(homeCameraTrans, cultivateCameraTrans, roleRoot, catRoot, exclusiveWeaponTarget, homeLocation)
    self._isInit = true
end

function CardProgressionControllerRole:InitRoleLoadController(...)
    ---@type CardProgressionControllerRoleLoad
    local controller = import(CardProgressionConstants.EnvPath.CardProgressionControllerRoleLoad).New()
    controller:Init(...)
    self._controllerComp[ControllerType.Role] = controller
end

function CardProgressionControllerRole:InitCameraController(homeCameraTrans, cultivateCameraTrans, roleRoot, catRoot, exclusiveWeaponTarget, homeLocation)
    ---@type CardProgressionControllerCamera
    local controller = import(CardProgressionConstants.EnvPath.CardProgressionControllerCamera).New()
    controller:Init(homeCameraTrans, cultivateCameraTrans, roleRoot, catRoot, exclusiveWeaponTarget, homeLocation)
    self._controllerComp[ControllerType.Camera] = controller
end

function CardProgressionControllerRole:InitListener()
    local listenerConf = {
        [Constants.EventNames.MainHomeRoleActive]                         = Bind(self, self.OnEventRoleActiveAction),
        [Constants.EventNames.HomeSceneCheckExtraSceneShowState]          = Bind(self, self.OnEventHomeSceneCheckExtraSceneShowStateAction),
        [Constants.EventNames.HomeSceneRoleActive]                        = Bind(self, self.OnEventCultivateRoleActiveAction),
        [CardProgressionConstants.EventNames.RotationRole]                = Bind(self, self.OnEventRotationRoleAction),
        [CardProgressionConstants.EventNames.MoveCameraUp]                = Bind(self, self.OnEventMoveCameraUpAction),
        [CardProgressionConstants.EventNames.MoveCameraForward]           = Bind(self, self.OnEventMoveCameraForwardAction),
        -- [CardProgressionConstants.EventNames.SwitchCatTouchState] = Bind(self, self.OnEventSwitchCatTouchState),
    }

    for eventName, action in pairs(listenerConf) do
        Events.AddListener(eventName, action)
    end

    self._listenerConf = listenerConf

end

--- CreateRoot
---@param parent UnityEngine.Transform
---@param rootName string
---@return UnityEngine.GameObject
function CardProgressionControllerRole:CreateRoot(parent, rootName)
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
--- logic begin --
---------------------------------------------------

---@param skinId integer
---@param isDisableEnter boolean
---@param cameraParams table
---@param isStopTL boolean
---@param dojo CardDojo
---@param isPreviewRole boolean | nil
---@param isPreviewSkin boolean | nil
function CardProgressionControllerRole:LoadRole(skinId, isDisableEnter, cameraParams, isStopTL, dojo, isPreviewRole, isPreviewSkin)
    skinId = checkNumber(skinId)
    if skinId == 0 then
        skinId = self:GetSignboardId()
    end
    ---@type CardSkinVo
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    if skinId == self._skinId then
        ---@type CardProgressionControllerCamera
        local cameraController = self._controllerComp[ControllerType.Camera]
        cameraController:SetCardId(cardSkinVo.roleId)
        cameraController:SetSkinId(skinId)
        self:LoadExtraSceneBySkinVo(cardSkinVo)
        if isStopTL then
            self:StopLoaderRoleCo()
        end
        self:SetWeaponShowStateByDojo(dojo, isPreviewRole)
        
        self:FreshCameraStateByParams(cameraParams, true)
        if KTool.IsActiveInHierarchy(self._roleRoot.gameObject) then
            self:ActiveRoleEnter(true)
        end
        return 
    end
    self:ClearExtraScene(cardSkinVo)
    self._skinId = skinId
    self:StopLoaderRoleCo()
    
    ---@type CardProgressionControllerRoleLoad
    local loadController = self._controllerComp[ControllerType.Role]
    loadController:ClearRole()
    -- loadController:ClearExtraPrefab(false, cardSkinVo.skinScene)

    ---@type CardProgressionControllerCamera
    local cameraController = self._controllerComp[ControllerType.Camera]
    cameraController:SetCardId()
    cameraController:SetSkinId()
    cameraController:SetRoleAndCat()
    self._loaderRoleCo = cs_coroutine.start(function() 
        ---@type CardSkinVo
        local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
        
        loadController:LoadRole(skinId, cardSkinVo, isPreviewSkin)
        cameraController:SetCardId(cardSkinVo.roleId)
        cameraController:SetSkinId(skinId)
        self:SetWeaponShowStateByDojo(dojo, isPreviewRole)
        
        self:FreshCameraStateByParams(cameraParams)
        
        local isDisable = isDisableEnter or self._cameraState == CardProgressionConstants.CameraState.ExclusiveWeapon
        self._roleEnterCo = cs_coroutine.start(function()
            while isNull(self._roleRoot) or not KTool.IsActiveInHierarchy(self._roleRoot.gameObject) do
                CoYield(0.1)
            end
            --CS.UnityEngine.Debug.Break()
            self:ActiveRoleEnter(isDisable)
            
            Events.Broadcast(Constants.EventNames.RoleLoadComplete, skinId)
            --loadController:PlayRoleEnter(cardSkinVo, isDisable)
            self._roleEnterCo = nil
        end)
        
        self._loaderRoleCo = nil
    end)    
end

---LoadRoleUIShow 在主界面加载一个UI模型
---@param skinId number 模型皮肤ID路径
---@param cameraState CardProgressionConstants.CameraState
---@param camPos table 主界面相机位置
---@param camRot table 主界面相机旋转
---@param rolePos table 角色位置
---@param roleRot table 角色旋转
function CardProgressionControllerRole:LoadRoleUIShow(skinId, cameraState, camPos, camRot, rolePos, roleRot)
    ---@type CardSkinVo
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    if not isNull(cardSkinVo) then
        self:ClearExtraScene(cardSkinVo)
        self._skinId = skinId
        ---@type CardProgressionControllerCamera
        local cameraController = self._controllerComp[ControllerType.Camera]
        cameraController:SetCardId(cardSkinVo.roleId)
        cameraController:SetSkinId(skinId)
        local prefabPath   = string.format(CardProgressionConstants.PrefabPath.CardLobbyPath, cardSkinVo.lobbyMode)
        if not isNull(prefabPath) then
            local loader = CS.Engine.Modules.ResourceModule.LoadBundleAsync(prefabPath, function(_loader, isOk, resultObject)
                if isOk then
                    local roleGo = _loader:Instantiate()
                    _loader:Release()
                    roleGo.transform.localPosition = Vector3.New(rolePos[1], rolePos[2], rolePos[3])
                    roleGo.transform.localRotation = Quaternion.Euler(roleRot[1], roleRot[2], roleRot[3])
                    roleGo.transform.localScale = Vector3.New(1,1,1)
                    ---@type CustomLightDirRelativeCamera
                    local relativeCamera = KTool.GetOrAddComponent(roleGo, typeof(CS.CustomLightDirRelativeCamera))
                    relativeCamera.CustomLightDirection = Vector3.New(25, 5.6, 0)
                    KTool.SetParent(roleGo,self._uiRoleLocation.gameObject,false)
                    self.uiRoleGo = roleGo
                    self:FreshCameraState(cameraState, camPos, Vector3.New(camRot[1], camRot[2], camRot[3]))
                end
            end, true)

            while not loader.IsCompleted do
                coroutine.yield()
            end
        end
    end
end

function CardProgressionControllerRole:CleanUiRole()
    if not isNull(self.uiRoleGo) then
        KTool.SafeDelete(self.uiRoleGo)
    end
end

---SetWeaponShowStateByDojo
---@param dojo CardDojo
function CardProgressionControllerRole:SetWeaponShowStateByDojo(dojo, isPreviewRole, isPreviewWeapon)
    if dojo == nil then
        return
    end
    self._showCardDojo = dojo
    
    local ids = cardConfMgr:GetRoleCardExclusiveWeaponIds(dojo.cardId)
    if ids == nil then
        return
    end

    local roleGo = self:GetRoleBySkinId(isPreviewRole and self._skinId or checkNumber(dojo.cardSkin))
    if isNull(roleGo) then
        return
    end
    
    local maxLv = cardConfMgr:GetMaxCardExclusiveWeaponLv(dojo.cardId)
    self:SetWeaponShowState(roleGo, (checkNumber(dojo.weaponUnlocked) >= maxLv and maxLv > 0) or isPreviewWeapon == true)
end

---@return CardDojo
function CardProgressionControllerRole:GetWeaponShowStateByDojo()
    return self._showCardDojo
end

function CardProgressionControllerRole:GetRoleShowState()
    return self._isShowRole
end

---SetWeaponShowState
---@param roleGo UnityEngine.GameObject
---@param isShow boolean
function CardProgressionControllerRole:SetWeaponShowState(roleGo, isShow)
    if isNull(roleGo) then
        return
    end
    ---@type Game.Native.Common.ExclusiveWeaponController
    local controller = roleGo:GetComponent(ExclusiveWeaponControllerType)
    if not isNull(controller) then
        local oldIsShow = controller.IsShow
        controller.IsShow = isShow
        if oldIsShow ~= isShow and not isShow  then
            controller:ResetInfo()
        end
    end

end

function CardProgressionControllerRole:StopLoaderRoleCo()
    if not self:IsLoadRoleComplete() then
        cs_coroutine.stop(self._loaderRoleCo)
        self._loaderRoleCo = nil
    end

    self:StopTimeLine()
end

function CardProgressionControllerRole:IsLoadRoleComplete()
    return self._loaderRoleCo == nil
end

---@param skinId integer
---@param params table
function CardProgressionControllerRole:LoadCat(skinId, params, isDisableStopLoaderRole)
    skinId = checkNumber(skinId)
    if skinId == 0 then 
        return 
    end
    
    self._catSkinId = skinId
    ---@type CardProgressionControllerRoleLoad
    local loadController = self._controllerComp[ControllerType.Role]
    ---@type CardSkinVo
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    if self._catPrefab == cardSkinVo.catPrefab then
        ---@type CardProgressionControllerCamera
        local cameraController = self._controllerComp[ControllerType.Camera]
        cameraController:SetCardId(cardSkinVo.roleId)
        cameraController:SetSkinId(skinId)
        loadController:SetCatSkinId(skinId)
        self:LoadExtraSceneBySkinVo(cardSkinVo)
        loadController:ReInitialCat(cardSkinVo.roleId, skinId)
        self:FreshCameraStateByParams(params)
        local catGo = loadController:GetCat()
        if isNull(self._catEnterCo) and isNotNull(catGo) and KTool.IsActiveInHierarchy(catGo) then
            self:ActiveCatEnter(true)
        end
        return 
    end
    self._catPrefab = cardSkinVo.catPrefab
    self:ClearExtraScene(cardSkinVo)
    if not isDisableStopLoaderRole then
        self:StopLoaderRoleCo()
    end
    self:StopCatCo()
    
    loadController:ClearCat()
    -- loadController:ClearExtraPrefab(false, cardSkinVo.skinScene)

    ---@type CardProgressionControllerCamera
    local cameraController = self._controllerComp[ControllerType.Camera]
    cameraController:SetCardId()
    cameraController:SetSkinId()
    cameraController:SetRoleAndCat()

    self._loaderCatCo = cs_coroutine.start(function()
        loadController:LoadCat(skinId, cardSkinVo, cardSkinVo.roleId)
        Events.Broadcast(Constants.EventNames.RoleLoadComplete, skinId)
        cameraController:SetCardId(cardSkinVo.roleId)
        cameraController:SetSkinId(skinId)
        self:FreshCameraStateByParams(params)
        if not isNull(self._relativeCamera) then
            self._relativeCamera:GetMeshRender()
            self._relativeCamera:ResetLightDir()
        end
        
        --- 播放猫初始动画 
        -- self._catEnterCo = cs_coroutine.start(function()
        --     while isNotNull(self._catRoot) and not KTool.IsActiveInHierarchy(self._catRoot.gameObject) do
        --         CoYield(0.1)
        --     end
        --     self:ActiveCatEnter()
        --     self._catEnterCo = nil
        -- end)
        
        --self._isCanPlayCatEnter = true
        --self:ActiveCatEnter()
        
        
        self._loaderCatCo = nil
    end)
end

function CardProgressionControllerRole:IsLoadCatComplete()
    return self._loaderCatCo == nil
end
function CardProgressionControllerRole:StopCatCo()
    if not isNull(self._catEnterCo) then
        cs_coroutine.stop(self._catEnterCo)
        self._catEnterCo = nil
    end
    if not isNull(self._loaderCatCo) then
        cs_coroutine.stop(self._loaderCatCo)
        self._loaderCatCo = nil
    end
end

function CardProgressionControllerRole:LoadExtraScene(skinId)
    skinId = checkNumber(skinId)
    if skinId == 0 then 
        return 
    end

    ---@type CardSkinVo
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)

    ---@type CardProgressionControllerCamera
    local cameraController = self._controllerComp[ControllerType.Camera]
    cameraController:SetCardId(cardSkinVo.roleId)
    cameraController:SetSkinId(skinId)
    self:LoadExtraSceneBySkinVo(cardSkinVo)
end

---@param cardSkinVo CardSkinVo
function CardProgressionControllerRole:LoadExtraSceneBySkinVo(cardSkinVo)
    self:StopExtraSceneCo()
    ---@type CardProgressionControllerRoleLoad
    local loadController = self._controllerComp[ControllerType.Role]
    self:ClearExtraScene(cardSkinVo)

    if not string.isEmpty(cardSkinVo.skinScene) then
        self._loaderExtraCo = cs_coroutine.start(function()
            loadController:LoadExtraScene(cardSkinVo.skinId, cardSkinVo)
            self._loaderExtraCo = nil
        end)
    end

end



---ClearExtraScene
---@param cardSkinVo CardSkinVo
function CardProgressionControllerRole:ClearExtraScene(cardSkinVo)
    ---@type CardProgressionControllerRoleLoad
    local loadController = self._controllerComp[ControllerType.Role]
    local skinScene = cardSkinVo.skinScene
    return loadController:ClearExtraPrefab(false, skinScene, cardSkinVo) 
    
end

---FreshExtraPrefabShowState
function CardProgressionControllerRole:FreshExtraPrefabShowState(isShow)
    ---@type CardProgressionControllerRoleLoad
    local loadController = self._controllerComp[ControllerType.Role]
    return loadController:FreshExtraPrefabShowState(isShow)
    
end

function CardProgressionControllerRole:StopExtraSceneCo()
    if not isNull(self._loaderExtraCo) then
        cs_coroutine.stop(self._loaderExtraCo)
        self._loaderExtraCo = nil
    end
end


--- FreshCameraStateByParams
---@param params table{
---    [1] = cameraState : CardProgressionConstants.CameraState
---}
function CardProgressionControllerRole:FreshCameraStateByParams(params, isCheckState, isForceStop)
    if params == nil then
        return
    end
    
    local cameraState = table.remove(params, 1)
    local isCatCameraState = self:IsCatCameraState(cameraState)
    if isForceStop or (isCheckState and cameraState == CardProgressionConstants.CameraState.ExclusiveWeapon or isCatCameraState ) then
        self:StopTimeLine()
    end
    
    self:FreshCameraState(cameraState, SafeUnpack(params))
end

--- FreshCameraState
---@param cameraState CardProgressionConstants.CameraState
function CardProgressionControllerRole:FreshCameraState(cameraState, ...)
    if cameraState ~= CardProgressionConstants.CameraState.CultivateLookAtFace and cameraState ~= CardProgressionConstants.CameraState.CultivateCatAwakenSuccess then
        self:ResetRootRotation()
    end
    
    local oldCameraState = self._cameraState
    self._lastCameraState = oldCameraState
    self._cameraState = cameraState
    
    ---@type CardProgressionControllerRoleLoad
    local loadController = self._controllerComp[ControllerType.Role]
    ---@type FaceForward
    local roleFaceForward = loadController:GetRoleFaceForward()
    ---@type CardProgressionControllerCamera
    local cameraController = self._controllerComp[ControllerType.Camera]
    cameraController:SetRoleAndCat(loadController:GetRole(), loadController:GetCat())
    local newCameraState = cameraController:FreshCameraState(cameraState, oldCameraState, roleFaceForward, ...)
    if newCameraState then
        self._cameraState = newCameraState
        cameraController:FreshCameraState(newCameraState, cameraState, roleFaceForward, ...)
    end
end


---@return CardProgressionConstants.CameraState
function CardProgressionControllerRole:GetCameraState()
    return self._cameraState
end

function CardProgressionControllerRole:ResetRootRotation()
    ---@type UnityEngine.Transform
    local transform = self._catRoot.transform
    transform:ResetLocalRotation()
    transform:ResetLocalPosition()

    transform = self._roleRoot.transform
    transform:ResetLocalRotation()

    transform = self._extraSceneRoot.transform
    transform:ResetLocalRotation()
    transform:ResetLocalPosition()

end

function CardProgressionControllerRole:StopTimeLine()
    self:StopRoleEnterCo()
    
    ---@type CardProgressionControllerRoleLoad
    local loadController = self._controllerComp[ControllerType.Role]
    if loadController then
        loadController:StopTimeLine()
    end

end

function CardProgressionControllerRole:StopRoleEnterCo()
    if self._roleEnterCo then
        cs_coroutine.stop(self._roleEnterCo)
        self._roleEnterCo = nil
    end
end


---StoreRoleState
---存储当前人物状态
function CardProgressionControllerRole:StoreRoleState()
    self._oldRoleSkinId    = self:GetRoleSkinId()
    self._oldCameraState   = self:GetCameraState()
    self._oldShowCardDojo  = self:GetWeaponShowStateByDojo()
    self._oldRoleShowState = self:GetRoleShowState()
end
---RecoveryRoleState
---恢复人物状态
function CardProgressionControllerRole:RecoveryRoleState()
    if self._oldRoleShowState ~= nil then
        self:OnEventRoleActiveAction({isShowCultivate = self.oldRoleShowState_ })
    end
    if self._oldRoleSkinId ~= self:GetRoleSkinId() then
        --- 进入改界面前如果人物是隐藏状态 则不在播放入场timeLine
        self:LoadRole(self._oldRoleSkinId, not self._oldRoleShowState, { self._oldCameraState, true}, false, self._oldShowCardDojo)
    end
    self._oldRoleSkinId    = nil
    self._oldCameraState   = nil
    self._oldShowCardDojo  = nil
    self._oldRoleShowState = nil
end

function CardProgressionControllerRole:ActiveRoleEnter(isDisable)
    local skinId = self._skinId
    ---@type CardProgressionControllerRoleLoad
    local loadController = self._controllerComp[ControllerType.Role]
    ---@type CardSkinVo
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    loadController:PlayRoleEnter(cardSkinVo, isDisable)

end

function CardProgressionControllerRole:ActiveCatEnter(isForce)
    local lastCameraState  = self._lastCameraState
    local cameraState      = self._cameraState
    local isCatCameraState = self:IsCatCameraState(cameraState)
    local isCanTouch = cameraState == CardProgressionConstants.CameraState.HomeRoleToCat or cameraState == CardProgressionConstants.CameraState.SignboardRoleToCat
    local skinId = checkInt(self._catSkinId)
    if skinId == 0 then return end

    local catGo  = self:GetCatBySkinId(skinId)
    self._touchController:InitCatTouchController(skinId, catGo, isCanTouch, isForce or self:IsCatCameraState(lastCameraState) ~= isCatCameraState)
    if not isCanTouch then
        if not isNull(catGo) then
            ---@type UnityEngine.Animator
            local animator    = KTool.GetComponent(catGo.gameObject, CardProgressionConstants.CompType.AnimatorType)
            if not isNull(animator) then
                animator:SetInteger(CardProgressionConstants.AnimatorHash.AnimHash, 0)
            end
        end
    end

end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionControllerRole:GetRoleSkinId()
    ---@type CardProgressionControllerRoleLoad
    local controller = self._controllerComp[ControllerType.Role]
    return controller:GetRoleSkinId()
end

function CardProgressionControllerRole:GetRoleBySkinId(skinId)
    skinId = checkNumber(skinId)
    ---@type CardProgressionControllerRoleLoad
    local controller = self._controllerComp[ControllerType.Role]
    if controller:GetRoleSkinId() ~= skinId then
        return nil
    end
    return controller:GetRole()
end


function CardProgressionControllerRole:GetCatSkinId()
    ---@type CardProgressionControllerRoleLoad
    local controller = self._controllerComp[ControllerType.Role]
    return controller:GetCatSkinId()
end

function CardProgressionControllerRole:GetCatBySkinId(skinId)
    skinId           = checkNumber(skinId)
    ---@type CardProgressionControllerRoleLoad
    local controller = self._controllerComp[ControllerType.Role]
    if controller:GetCatSkinId() ~= skinId then
        return nil
    end
    return controller:GetCat()
end

function CardProgressionControllerRole:GetSignboardId()
    ---@type PlayerComponent
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type CardDojo
    local cardDojo        = playerComponent:GetSignboardCardDojo()
    return checkNumber(cardDojo.cardSkin)
end


function CardProgressionControllerRole:GetHomeLocation()
    return self._homeLocation
end

function CardProgressionControllerRole:GetCultivateLocation()
    return self._cultivateLocation
end

function CardProgressionControllerRole:GetIsActiveRoleRoot()
    ---@type CardProgressionControllerRoleLoad
    local controller = self._controllerComp[ControllerType.Role]
    return controller:GetIsActiveRoleRoot()
end

function CardProgressionControllerRole:GetIsActiveCatRoot()
    ---@type CardProgressionControllerRoleLoad
    local controller = self._controllerComp[ControllerType.Role]
    return controller:GetIsActiveCatRoot()
end

function CardProgressionControllerRole:GetCultivateCameraTrans()
    return self._cultivateCameraTrans
end

function CardProgressionControllerRole:GetCardAwakenEffect(effectPath)
    ---@type CardProgressionControllerCamera
    local cameraController = self._controllerComp[ControllerType.Camera]
    return cameraController:GetCatAwakeEffect(effectPath)
end

function CardProgressionControllerRole:IsCatCameraState(cameraState)
    cameraState = cameraState or self._cameraState
    local CameraState = CardProgressionConstants.CameraState
    return     CameraState.CultivateCatAwakenFull    == cameraState 
            or CameraState.CultivateCatAwakenSuccess == cameraState
            or CameraState.CultivateCatFull          == cameraState
            or CameraState.HomeRoleToCat             == cameraState
            or CameraState.SignboardRoleToCat        == cameraState
end

function CardProgressionControllerRole:GetRoleEnterCallback(loadController, cardSkinVo, isDisable)
    return function()
        loadController:PlayRoleEnter(cardSkinVo, isDisable)
    end
end

function CardProgressionControllerRole:GetTouchController()
    return self._touchController
end

---GetCatRoot
---获取人物根节点
function CardProgressionControllerRole:GetRoleRoot()
    return self._roleRoot
end

---GetCatRoot
---获取猫根节点
function CardProgressionControllerRole:GetCatRoot()
    return self._catRoot
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


function CardProgressionControllerRole:OnEventRoleActiveAction(t)
    local isShowHomeRole      = t.isShow
    local isShowCultivateRole = t.isShowCultivate
    local isShowRole = checkBool(isShowHomeRole or isShowCultivateRole)
    if self._isShowRole ~= isShowRole then
        if not isShowRole then
            self:StopTimeLine()
            self:FreshExtraPrefabShowState(false)
        else
            self:OnEventHomeSceneCheckExtraSceneShowStateAction()
        end
        self._isShowRole = isShowRole
        KTool.SetActive(self._cultivateLocation.gameObject, isShowRole)

    end

end

function CardProgressionControllerRole:OnEventHomeSceneCheckExtraSceneShowStateAction(skinId)
    if self._skinId == nil and self._catSkinId == nil then
        return
    end

    if skinId == nil then
        local isCatCameraState = self:IsCatCameraState()
        skinId = isCatCameraState and self._catSkinId or self._skinId
        
    end
    ---@type CardSkinVo
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    if cardSkinVo == nil then
        return
    end
    self:FreshExtraPrefabShowState(not string.isEmpty(cardSkinVo.skinScene))
end

function CardProgressionControllerRole:OnEventCultivateRoleActiveAction(isShowRole, isShowCat, isForce, isShowPortrait, skinId)
    isForce = isForce == true

    ---@type CardProgressionControllerRoleLoad
    local controller = self._controllerComp[ControllerType.Role]
    if controller:IsChangeActiveRoleRoot(isShowRole) or isForce then
        if not isShowRole then
            self:StopTimeLine()
        end
        controller:SetRoleRootShowState(isShowRole)

    end

    if controller:SetCatRootShowState(isShowCat) or isForce then
        if isShowCat then
            self:ActiveCatEnter(isForce)
        end

    end
    if (isShowRole == false and isShowCat == false and not isShowPortrait) then
        self:FreshExtraPrefabShowState(false)
    else
        self:OnEventHomeSceneCheckExtraSceneShowStateAction(skinId)
    end
   
end

function CardProgressionControllerRole:OnEventRotationRoleAction(direction)
    if DOTween.TotalPlayingTweens() > 0 then
        return
    end
    
    local isActiveCat = KTool.IsActive(self._catRoot)
    ---@type UnityEngine.GameObject
    local root
    if isActiveCat then
        root = self:GetCatBySkinId(self._catSkinId)
    elseif KTool.IsActive(self._roleRoot) then
        root = self._roleRoot
    end
    if isNull(root) then
        return
    end

    local isCat = self:IsCatCameraState()
    local skinId = isCat and self._catSkinId or self._skinId
    ---@type CardSkinVo
    local cardSkinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    local positionVo = cardConfMgr:GetCardPosByCardId(cardSkinVo.roleId, skinId)
    local limit1, limit2 
    if not isActiveCat then
        limit1, limit2  = positionVo:GetRoleRotationLimit()
    end

    ---@type UnityEngine.Transform
    local transform = root.transform

    if limit1 and limit2 then
        local eulerAngles = transform.localEulerAngles
        local y = (eulerAngles.y >= (limit1.y + 360)) and (eulerAngles.y - 360) or eulerAngles.y
        y = checkInt(y)
        y = Mathf.Clamp(y + direction, limit1.y, limit2.y)
        
        eulerAngles.y = y
        transform.localEulerAngles = eulerAngles
    else
        local eulerAngles = Vector3.New(0, direction, 0)
        transform:Rotate(eulerAngles)

    end
    
    local extraSceneRoot = self._extraSceneRoot
    if isNotNull(extraSceneRoot ) and not isActiveCat then
        extraSceneRoot.transform.localRotation = transform.localRotation
        
    end
end

function CardProgressionControllerRole:OnEventMoveCameraUpAction(y)
    if DOTween.TotalPlayingTweens() > 0 then
        return
    end
end

function CardProgressionControllerRole:OnEventMoveCameraForwardAction()
    if DOTween.TotalPlayingTweens() > 0 then
        return
    end
end

-- function CardProgressionControllerRole:OnEventSwitchCatTouchState(catTouchState)
--     ---@type CatTouchController
--     local touchController = self:GetTouchController()
--     if touchController == nil then
--         return
--     end
--     if catTouchState == 2 then
--         touchController:EnterSit()
--     elseif catTouchState == 3 then
--         CfUtils.ConditionAppend("CatTouchStatus.DeepInteraction")
--         CoStart(function()
--             touchController:QuitDeepInteraction()
--             CoYield()
--             touchController:EnterSit()
--             CfUtils.ConditionRemove("CatTouchStatus.DeepInteraction")
--         end)
--     end
-- end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionControllerRole

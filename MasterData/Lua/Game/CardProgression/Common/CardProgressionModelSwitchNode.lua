
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local import    = import
--endregion

--region import
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CardSkinComponent
local cardSkinComponent        = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
--endregion

--region define
local ModelType     = CardProgressionConstants.ModelType
local AnimationName = "UI_CommonCellShowAlpha"
--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFashion.prefab > name: MiddlePanel
---@class CardProgressionModelSwitchNode
---@field Env                           	CardProgressionModelSwitchNode          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnLabelNode1                 	UnityEngine.RectTransform               	@ 0    
---@field BtnLabelNode2                 	UnityEngine.RectTransform               	@ 1    
---@field BtnLabelNode3                 	UnityEngine.RectTransform               	@ 2    
---@field DrawingNode                   	Game.Native.Common.DrawingNode          	@ 3    
---@field DrawingNodeAnim               	UnityEngine.Animation                   	@ 4    
local CardProgressionModelSwitchNode = Class('CardProgressionModelSwitchNode')

function CardProgressionModelSwitchNode:__init()
    self._isInitialize = true
    self._selectedLabelType = ModelType.Role
    self._labelType2Env = {}
end


function CardProgressionModelSwitchNode:__delete()

end


function CardProgressionModelSwitchNode:Awake()
    self._labelType2Node = {
        [ModelType.Role]     = self.BtnLabelNode1,
        [ModelType.Cat]      = self.BtnLabelNode2,
        [ModelType.Portrait] = self.BtnLabelNode3,
    }

    ---@type CardProgressionControllerRole
    self._controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
end


-- function CardProgressionModelSwitchNode:Start()

-- end


function CardProgressionModelSwitchNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 

function CardProgressionModelSwitchNode:Initialize(selectedLabelType)
    if self._isInitialize then
        return
    end
    self._selectedLabelType = selectedLabelType or self._selectedLabelType
    self._isInitialize = true
end

--endregion 


--region logic 

function CardProgressionModelSwitchNode:FreshUI(...)
    self:InitData(...)
    self:FreshLabelNodes()
    self:FreshFashion(true)
end

function CardProgressionModelSwitchNode:InitData(skinId, cardDojo, isPreviewMode)
    ---@type CardSkinVo
    local skinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
    self._skinVo = skinVo
    self._isUnlock = cardSkinComponent:IsHasSkin(skinVo.skinId)
    if isPreviewMode then
        self._isUnlock = true
    end
    self._cardDojo = cardDojo
end

function CardProgressionModelSwitchNode:FreshLabelNodes()
    for labelType, node in pairs(self._labelType2Node) do
        self:FreshLabelNode(labelType)
    end
    self._isInitialize = false
end

function CardProgressionModelSwitchNode:FreshLabelNode(labelType)
    ---@type CardProgressionFashionLabelNode
    local env = self:GetEnvByLabelType(labelType)
    if isNull(env) then return end
    
    local isUnlock
    if labelType == ModelType.Role then
        isUnlock = true
    else
        isUnlock = self._isUnlock
    end
    
    local isSelected = self._selectedLabelType == labelType
    env:FreshUI(isUnlock)
    env:FreshSelectState(isSelected, self._isInitialize)
    env:SetCallback(Bind(self, self.OnClickLabelNodeAction, labelType))
end

function CardProgressionModelSwitchNode:FreshLabelNodeSelectState(labelType, isSelect)
    local node = self._labelType2Node[labelType]
    ---@type CardProgressionFashionLabelNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionFashionLabelNode)
    if isNull(env) then return end
    env:FreshSelectState(isSelect)
end

function CardProgressionModelSwitchNode:FreshFashion(isEnter)
    ---@type CardSkinVo
    local skinVo   = self._skinVo
    local labelType = self._selectedLabelType
    CfUtils.SetActive(self.DrawingNode, labelType == ModelType.Portrait)

    if isNull(self._controllerEnv) then return end
    if labelType == ModelType.Role then
        ---@type CardDojo
        local cardDojo = self._cardDojo
            
        self._controllerEnv:LoadRole(skinVo.skinId, true, {CardProgressionConstants.CameraState.CultivateRoleFull, not isEnter}, false, cardDojo, true)

    elseif labelType == ModelType.Cat then
        self._controllerEnv:LoadCat(skinVo.skinId, {CardProgressionConstants.CameraState.CultivateCatFull, not isEnter})
        
    elseif labelType == ModelType.Portrait then
        self._controllerEnv:FreshCameraStateByParams({CardProgressionConstants.CameraState.CultivateRoleAndCatHide})
        self:FreshDrawingNode(skinVo.skinId)

    end
    
end


function CardProgressionModelSwitchNode:FreshDrawingNode(skinId)
    self.DrawingNodeAnim:Play(AnimationName)
    self.DrawingNode:Execute(skinId)

end

--endregion 


--region get/set 

function CardProgressionModelSwitchNode:GetEnvByLabelType(labelType)
    local env = self._labelType2Env[labelType]
    if isNull(env) then
        local node = self._labelType2Node[labelType]
        env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionFashionLabelNode)
        self._labelType2Env[labelType] = env
    end
    return env
end

function CardProgressionModelSwitchNode:SetCallback(callback)
    self._callback = callback
end

function CardProgressionModelSwitchNode:GetLabelType()
    return self._selectedLabelType
end

function CardProgressionModelSwitchNode:SetIsInitialize(isInitialize)
    self._isInitialize = isInitialize
end

---endregion 


--region handler 

function CardProgressionModelSwitchNode:OnClickLabelNodeAction(labelType)
    if self._selectedLabelType == labelType then
        return
    end
    if not self._isUnlock then
        GameUtils.Toast(localize("尚未解锁"))
        return
    end
    ---@type CardProgressionFashionLabelNode
    local env = self:GetEnvByLabelType(labelType)
    self:FreshLabelNodeSelectState(self._selectedLabelType, false)
    self._selectedLabelType = labelType
    env:FreshSelectState(true)
    self:FreshFashion(true)

    if self._callback then
        self._callback()
    end
end

---endregion 


return CardProgressionModelSwitchNode

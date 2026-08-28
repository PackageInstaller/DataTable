
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils = import("Game.UI.Club.GVG.ClubGVGUtils")
--endregion

--region define
local SetActive = CfUtils.SetActive
local GVGConstants = ClubGVGUtils.Constants
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseNode.prefab > name: OverseaClubGvgGroupBaseNode
---@class ClubGVGGroupBaseNode
---@field Env                           	ClubGVGGroupBaseNode                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImportantNode                 	UnityEngine.RectTransform               
---@field NormalNode                    	UnityEngine.RectTransform               
local ClubGVGGroupBaseNode = Class('ClubGVGGroupBaseNode')

function ClubGVGGroupBaseNode:__init()
    self._effectRoot         = nil
    self._safetyShieldEffect = nil
    self._rebirthEffect      = nil
    self._fireFightEffect     = nil
    self._isShowEffect       = true
end


function ClubGVGGroupBaseNode:__delete()

end


function ClubGVGGroupBaseNode:Awake()
    self._transform = self.controller.transform
    self._isActive = true
end


function ClubGVGGroupBaseNode:Start()
    SetButtonAction(self.controller, function ()
        if not self._isActive then
            return
        end
        if self._buildingVo == nil or self._buildingInfo == nil then
            return
        end
        ---@type ClubGVGMgr
        local mgr = ClubGVGUtils.GetMgr()
        ---是主基地 并且 在保护期 并且 不是我工会的主基地
        ---则 不能前往 不能打 不能看里面的情况（选中飘字
        if self._buildingVo.isMainBuild and mgr:GetIsProtectionPeriod() and checkNumber(self._buildingInfo.clubId) ~= mgr:GetClubId() then
            GameUtils.Toast(localize("保护期内，无法查看其他社团的大本营"))
            return
        end
        if self._callback then
            self._callback(self._buildingId)
        end
    end)
end


function ClubGVGGroupBaseNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupBaseNode:FreshUI(buildingId)
    SetActive(self.controller, true)

    self._buildingId = checkNumber(buildingId)
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    local buildingInfo = mgr:GetBuildInfo(buildingId)
    self._buildingInfo = buildingInfo
    
    ---@type ClubGVGBuildingVo
    local buildingVo = ClubGVGUtils.GetBuildingVoById(buildingInfo.type)
    self._buildingVo = buildingVo
    local buildingClubId = checkNumber(buildingInfo.clubId)
    local clubId = mgr:GetClubId()
    local isSelfClubBuilding = buildingClubId == clubId

    local importantNodeEnv = self:GetImportantNodeEnv()
    if isNotNull(importantNodeEnv) then
        importantNodeEnv:FreshUI(buildingInfo, buildingVo, buildingClubId, isSelfClubBuilding)
    end
    local normalNodeEnv = self:GetNormalNodeEnv()
    if isNotNull(normalNodeEnv) then
        normalNodeEnv:FreshUI(buildingInfo, buildingVo, buildingClubId, isSelfClubBuilding)
    end

    local isBase = buildingVo.isMainBuild
    if isBase and mgr:GetIsProtectionPeriod() then
        local safetyShieldEffect = self:GetSafetyShieldEffect()
        SetActive(safetyShieldEffect, true)
    else
        SetActive(self._safetyShieldEffect, false)
    end

    local isFighting = ClubGVGUtils.IsFighting(buildingInfo)
    if isFighting then
        local effect = self:GetFireFightEffect() 
        SetActive(effect, true)
    else
        SetActive(self._fireFightEffect, false)
    end
end

function ClubGVGGroupBaseNode:UpdatePosition(uiPos)
    self._transform.anchoredPosition = uiPos
end

function ClubGVGGroupBaseNode:UpdateSiblingIndex(idx)
    self._transform:SetSiblingIndex(idx)
end


function ClubGVGGroupBaseNode:FreshSelectStatus(isSelect)
    local importantNodeEnv = self:GetImportantNodeEnv()
    if isNotNull(importantNodeEnv) then
        importantNodeEnv:FreshSelectStatus(isSelect)
    end
    
end


function ClubGVGGroupBaseNode:FreshBuildingProgress()
    local normalNodeEnv = self:GetNormalNodeEnv()
    if isNotNull(normalNodeEnv) then
        normalNodeEnv:FreshProgress()
    end
end

function ClubGVGGroupBaseNode:FreshRebirthEffectShowStatus(isShow)
    local rebirthEffect = self:GetRebirthEffect()
    SetActive(rebirthEffect, isShow)
end

function ClubGVGGroupBaseNode:RemoveProtectionPeriod()
    SetActive(self._safetyShieldEffect, false)
    
end

function ClubGVGGroupBaseNode:FreshEffectShowStatus(isShow)
    self._isShowEffect = isShow
    SetActive(self._effectRoot, isShow)
end


function ClubGVGGroupBaseNode:Reset()
    SetActive(self.controller, false)
    SetActive(self._safetyShieldEffect, false)
    SetActive(self._rebirthEffect, false)
    SetActive(self._fireFightEffect, false)
    
    if isNotNull(self._effectRoot) then
        self._effectRoot:SetParent(self._effectContainerTrans, false)
        self._pool:Free(self._effectRoot)
    end
    self._effectRoot = nil
    self._safetyShieldEffect = nil
    self._rebirthEffect = nil
    self._fireFightEffect = nil
end

--endregion 


--region get/set 

---@return ClubGVGGroupBaseImportantNode
function ClubGVGGroupBaseNode:GetImportantNodeEnv()
    if isNull(self._importantNodeEnv) then
        self._importantNodeEnv = CfUtils.GetLuaScr(self.ImportantNode, GVGConstants.LuaPath.ClubGVGGroupBaseImportantNode)
    end

    return self._importantNodeEnv

end

---@return ClubGVGGroupBaseNormalNode
function ClubGVGGroupBaseNode:GetNormalNodeEnv()
    if isNull(self._normalNodeEnv) then
        self._normalNodeEnv = CfUtils.GetLuaScr(self.NormalNode, GVGConstants.LuaPath.ClubGVGGroupBaseNormalNode)
    end

    return self._normalNodeEnv

end

function ClubGVGGroupBaseNode:SetCallback(callback)
    self._callback = callback
end

---@param effectContainerTrans UnityEngine.Transform
---@param pool Pool
function ClubGVGGroupBaseNode:SetEffectContainerAndPool(effectContainerTrans, pool)
    self._effectContainerTrans = effectContainerTrans
    self._pool = pool
end

function ClubGVGGroupBaseNode:GetEffectRoot()
    if isNull(self._effectRoot) then
        self._effectRoot = self._pool:Obtain()
        self._effectRoot:ResetLocalPosition()
        self._effectRoot:SetParent(self.controller.transform, false)
        SetActive(self._effectRoot, self._isShowEffect)
    end
    return self._effectRoot
end

function ClubGVGGroupBaseNode:GetSafetyShieldEffect()
    if isNull(self._safetyShieldEffect) then
        local root = self:GetEffectRoot()
        self._safetyShieldEffect = root:Find(GVGConstants.Name.UIFX_SafetyShield)
    end
    return self._safetyShieldEffect
    
end

function ClubGVGGroupBaseNode:GetRebirthEffect()
    if isNull(self._rebirthEffect) then
        local root = self:GetEffectRoot()
        self._rebirthEffect = root:Find(GVGConstants.Name.UIFX_Rebirth)
    end
    return self._rebirthEffect

end

function ClubGVGGroupBaseNode:GetFireFightEffect()
    if isNull(self._fireFightEffect) then
        local root = self:GetEffectRoot()
        self._fireFightEffect = root:Find(GVGConstants.Name.UIFX_FireFight)
    end
    return self._fireFightEffect

end

function ClubGVGGroupBaseNode:SetClickEventActiveState(isActive)
    self._isActive = isActive

end

---endregion 


--region handler 


---endregion 


return ClubGVGGroupBaseNode

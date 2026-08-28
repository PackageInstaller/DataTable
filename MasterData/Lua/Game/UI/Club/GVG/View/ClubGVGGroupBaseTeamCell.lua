
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
local SetActive        = CfUtils.SetActive
local GVGConstants     = ClubGVGUtils.Constants
local LabelType        = GVGConstants.BuildingStatusLabelType

--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseTeamStatusPopup.prefab > name: Cell
---@class ClubGVGGroupBaseTeamCell
---@field Env                           	ClubGVGGroupBaseTeamCell                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field StatusIdle                    	UnityEngine.RectTransform               
---@field StatusProgress                	UnityEngine.RectTransform               
local ClubGVGGroupBaseTeamCell = Class('ClubGVGGroupBaseTeamCell')

function ClubGVGGroupBaseTeamCell:__init()

end


function ClubGVGGroupBaseTeamCell:__delete()

end


-- function ClubGVGGroupBaseTeamCell:Awake()
-- end


-- function ClubGVGGroupBaseTeamCell:Start()
-- end


function ClubGVGGroupBaseTeamCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupBaseTeamCell:FreshUI(data, buildingInfo, position, labelType, isInCurrentBuilding)
    self._labelType = labelType
    SetActive(self.StatusIdle, labelType ~= LabelType.Battling)
    SetActive(self.StatusProgress, labelType == LabelType.Battling)

    if labelType == LabelType.Battling then
        self:FreshStatusProgress(data, buildingInfo, position)
    else
        self:FreshStatusIdle(data, position, isInCurrentBuilding)
    end

end

function ClubGVGGroupBaseTeamCell:FreshStatusProgress(data, buildingInfo, position)
    ---@type ClubGVGGroupBaseTeamCellProgress
    local env = self:GetStatusProgressEnv()
    if isNull(env) then return end
    env:FreshUI(data, buildingInfo, position)

end

function ClubGVGGroupBaseTeamCell:FreshStatusIdle(data, position, isInCurrentBuilding)
    ---@type ClubGVGGroupBaseTeamCellIdle
    local env = self:GetStatusIdleEnv()
    if isNull(env) then return end
    env:FreshUI(data, position, isInCurrentBuilding)

end

function ClubGVGGroupBaseTeamCell:FreshCountdown(currentSeconds)
    if self._labelType ~= LabelType.Battling then
        return
    end
    ---@type ClubGVGGroupBaseTeamCellProgress
    local env = self:GetStatusProgressEnv()
    if isNull(env) then return end
    return env:FreshCountdown(currentSeconds)
end


--endregion 


--region get/set 

function ClubGVGGroupBaseTeamCell:GetStatusProgressEnv()
    if isNull(self._statusProgressEnv) then
        self._statusProgressEnv = CfUtils.GetLuaScr(self.StatusProgress, GVGConstants.LuaPath.ClubGVGGroupBaseTeamCellProgress)
    end
    return self._statusProgressEnv
end

function ClubGVGGroupBaseTeamCell:GetStatusIdleEnv()
    if isNull(self._statusIdleEnv) then
        self._statusIdleEnv = CfUtils.GetLuaScr(self.StatusIdle, GVGConstants.LuaPath.ClubGVGGroupBaseTeamCellIdle)
    end
    return self._statusIdleEnv
end

---endregion 


--region handler 


---endregion 


return ClubGVGGroupBaseTeamCell

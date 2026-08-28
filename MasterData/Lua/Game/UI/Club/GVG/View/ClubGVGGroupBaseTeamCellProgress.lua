
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
local GetTimeHMS2      = CfUtils.GetTimeHMS2
local GVGConstants     = ClubGVGUtils.Constants
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseTeamStatusPopup.prefab > name: StatusProgress
---@class ClubGVGGroupBaseTeamCellProgress
---@field Env                           	ClubGVGGroupBaseTeamCellProgress        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field PlayerInfo1                   	UnityEngine.RectTransform               	@ 0    
---@field BaseInfo                      	UnityEngine.RectTransform               	@ 1    
---@field ImgIcon                       	Engine.UI.ImageAlterable                	@ 2    
---@field TextName                      	CustomText                              	@ 3    
---@field TextClub                      	CustomText                              	@ 4    
---@field PlayerInfo2                   	UnityEngine.RectTransform               	@ 5    
---@field TextNumberTimer               	UnityEngine.RectTransform               	@ 6    
local ClubGVGGroupBaseTeamCellProgress = Class('ClubGVGGroupBaseTeamCellProgress')

function ClubGVGGroupBaseTeamCellProgress:__init()

end


function ClubGVGGroupBaseTeamCellProgress:__delete()

end


-- function ClubGVGGroupBaseTeamCellProgress:Awake()
-- end


-- function ClubGVGGroupBaseTeamCellProgress:Start()
-- end


function ClubGVGGroupBaseTeamCellProgress:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param data {endTime:number, attackPlayerInfo:table, defensePlayerInfo:table|nil}
---@param buildingInfo {icon:string, name:string, clubName:string}
---@param position number
function ClubGVGGroupBaseTeamCellProgress:FreshUI(data, buildingInfo, position)
    self._data = data

    local attackPlayerInfo  = data.attackPlayerInfo
    ---@type ClubGVGGroupBaseTeamCellPlayerInfo
    local attackPlayerInfoEnv = self:GetAttackPlayerInfoEnv()
    if isNotNull(attackPlayerInfoEnv) then
        attackPlayerInfoEnv:FreshUI(attackPlayerInfo.playerInfo)
    end

    local defensePlayerInfo = data.defensePlayerInfo
    local isBuilding        = defensePlayerInfo == nil or next(defensePlayerInfo) == nil
    SetActive(self.BaseInfo, isBuilding)
    SetActive(self.PlayerInfo2, not isBuilding)
    if not isBuilding then
        ---@type ClubGVGGroupBaseTeamCellPlayerInfo
        local defensePlayerInfoEnv = self:GetDefensePlayerInfoEnv()
        if isNotNull(defensePlayerInfoEnv) then
            defensePlayerInfoEnv:FreshUI(defensePlayerInfo.playerInfo)
        end
    else
        if self._icon ~= buildingInfo.icon then
            self._icon = buildingInfo.icon
            self.ImgIcon:LoadSprite(buildingInfo.icon)
        end
        self.TextName.text = buildingInfo.name
        self.TextClub.text = buildingInfo.clubName

    end

    
end

function ClubGVGGroupBaseTeamCellProgress:FreshCountdown(currentSeconds)
    local data = self._data
    if data == nil then
        return
    end

    local endTime     = data.endTime
    local leftSeconds = endTime - currentSeconds
    self.TextNumberTimer.text = GetTimeHMS2(leftSeconds)
    return leftSeconds > 0
end

--endregion 


--region get/set 

---@return ClubGVGGroupBaseTeamCellPlayerInfo
function ClubGVGGroupBaseTeamCellProgress:GetAttackPlayerInfoEnv()
    if isNull(self._attackPlayerInfoEnv) then
        self._attackPlayerInfoEnv = CfUtils.GetLuaScr(self.PlayerInfo1, GVGConstants.LuaPath.ClubGVGGroupBaseTeamCellPlayerInfo)
    end
    return self._attackPlayerInfoEnv
end

---@return ClubGVGGroupBaseTeamCellPlayerInfo
function ClubGVGGroupBaseTeamCellProgress:GetDefensePlayerInfoEnv()
    if isNull(self._defensePlayerInfoEnv) then
        self._defensePlayerInfoEnv = CfUtils.GetLuaScr(self.PlayerInfo2, GVGConstants.LuaPath.ClubGVGGroupBaseTeamCellPlayerInfo)
    end
    return self._defensePlayerInfoEnv
end

---endregion 


--region handler 


---endregion 


return ClubGVGGroupBaseTeamCellProgress

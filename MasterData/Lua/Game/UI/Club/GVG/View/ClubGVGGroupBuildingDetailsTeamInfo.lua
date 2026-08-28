
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
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseDetailsPopup.prefab > name: RaidTeam
---@class ClubGVGGroupBuildingDetailsTeamInfo
---@field Env                           	ClubGVGGroupBuildingDetailsTeamInfo     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Empty                         	UnityEngine.RectTransform               	@ 0    
---@field PlayerHeadGroup               	UnityEngine.RectTransform               	@ 1    
---@field Content                       	UnityEngine.RectTransform               	@ 2    
---@field HeadNode                      	UnityEngine.RectTransform               	@ 3    
---@field Area                          	UnityEngine.RectTransform               	@ 4    
---@field BtnArrow                      	UnityEngine.RectTransform               	@ 5    
local ClubGVGGroupBuildingDetailsTeamInfo = Class('ClubGVGGroupBuildingDetailsTeamInfo')

function ClubGVGGroupBuildingDetailsTeamInfo:__init()

end


function ClubGVGGroupBuildingDetailsTeamInfo:__delete()

end


-- function ClubGVGGroupBuildingDetailsTeamInfo:Awake()
-- end


function ClubGVGGroupBuildingDetailsTeamInfo:Start()
    SetButtonAction(self.Area, Bind(self, self.OnClickAreaAction))
    SetButtonAction(self.BtnArrow, Bind(self, self.OnClickAreaAction))
end


function ClubGVGGroupBuildingDetailsTeamInfo:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupBuildingDetailsTeamInfo:FreshUI(playerIds, battingPlayerIdMap, labelType)
    self._labelType = labelType
    playerIds = checkTable(playerIds)
    local isEmpty = next(playerIds) == nil
    SetActive(self.Empty, isEmpty)
    SetActive(self.PlayerHeadGroup, not isEmpty)
    if not isEmpty then
        local playerInfos = ClubGVGUtils.GetPlayerInfosByIds(playerIds, battingPlayerIdMap)
        GameUtils.ResizeContent(self.Content, self.HeadNode, math.min(#playerInfos, 4), function (index, node) 
            local data = playerInfos[index]
            ---@type ClubGVGGroupHeadNode
            local headNode = CfUtils.GetLuaScr(node, GVGConstants.LuaPath.ClubGVGGroupHeadNode)
            if isNotNull(headNode) then
                headNode:FreshUI(data)
            end
        end)
    end
end

--endregion 


--region get/set 

function ClubGVGGroupBuildingDetailsTeamInfo:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function ClubGVGGroupBuildingDetailsTeamInfo:OnClickAreaAction()
    if self._callback then
        self._callback(self._labelType)
    end
end

---endregion 


return ClubGVGGroupBuildingDetailsTeamInfo

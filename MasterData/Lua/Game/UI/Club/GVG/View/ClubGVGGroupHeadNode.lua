
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

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupHeadNode.prefab > name: OverseaClubGvgGroupHeadNode
---@class ClubGVGGroupHeadNode
---@field Env                           	ClubGVGGroupHeadNode                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               	@ 0    
---@field StatusMarching                	UnityEngine.RectTransform               	@ 1    
---@field StatusSuspend                 	UnityEngine.RectTransform               	@ 2    
---@field StatusSuccessiveVictory       	UnityEngine.RectTransform               	@ 3    
---@field TextName                      	CustomText                              	@ 4    
---@field ImgCampIcon                   	UnityEngine.UI.Image                    	@ 5    
local ClubGVGGroupHeadNode = Class('ClubGVGGroupHeadNode')

function ClubGVGGroupHeadNode:__init()

end


function ClubGVGGroupHeadNode:__delete()

end


function ClubGVGGroupHeadNode:Awake()
    local PlayerStatus = GVGConstants.PlayerStatus
    self._status2Node = {
        [PlayerStatus.Marching] = self.StatusMarching,
        [PlayerStatus.Suspend] = self.StatusSuspend,
        [PlayerStatus.SuccessiveVictory] = self.StatusSuccessiveVictory,
    }
end


function ClubGVGGroupHeadNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param data {playerInfo:table, playerStatus: ClubGVGConstants.PlayerStatus}
function ClubGVGGroupHeadNode:FreshUI(data)
    local playerStatus = data.playerStatus
    for status, node in pairs(self._status2Node) do
        local isShow = status == playerStatus
        SetActive(node, isShow)
    end

    local playerInfo = data.playerInfo
    ---@type CommonPlayerHeadNode
    local headEnv    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    if isNotNull(headEnv) then
        headEnv:FreshAvatarFrame( playerInfo.avatar, playerInfo.avatarFrame)
    end

    local clubId2Color = ClubGVGUtils.GetClubId2Color()
    local color = clubId2Color[playerInfo.clubId]
    if color then
        self.ImgCampIcon.color = color
        
    end

    self.TextName.text = data.playerInfo.name
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ClubGVGGroupHeadNode

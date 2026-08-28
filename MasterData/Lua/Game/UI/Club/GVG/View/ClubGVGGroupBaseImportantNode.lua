
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

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseImportantNode.prefab > name: OverseaClubGvgGroupBaseImportantNode
---@class ClubGVGGroupBaseImportantNode
---@field Env                           	ClubGVGGroupBaseImportantNode           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BaseInfo                      	UnityEngine.RectTransform               	@ 0    
---@field MainBuildingInfo              	UnityEngine.RectTransform               	@ 1    
---@field ImgIcon                       	Game.Native.Common.UISwitchImage        	@ 2    
---@field TextName                      	CustomText                              	@ 3    
---@field TeamHeadGroup                 	UnityEngine.RectTransform               	@ 4    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 5    
---@field ImgArrow                      	UnityEngine.RectTransform               	@ 6    
---@field PlayerHeadItem                	UnityEngine.RectTransform               	@ 7    
---@field PointNode                     	UnityEngine.RectTransform               	@ 8    
local ClubGVGGroupBaseImportantNode = Class('ClubGVGGroupBaseImportantNode')

function ClubGVGGroupBaseImportantNode:__init()

end


function ClubGVGGroupBaseImportantNode:__delete()

end


function ClubGVGGroupBaseImportantNode:Awake()
    local points = {}
    local PointNode = self.PointNode

    for i = 0, PointNode.childCount - 1, 1 do
        local node = PointNode:GetChild(i)
        table.insert(points, node)
    end
    self._points = points

    self._playerHeadItems = {self.PlayerHeadItem.gameObject}
    self._headNodes       = {self.PlayerHeadItem:Find("CommonPlayerHeadNode")}

    local node = self.PlayerHeadItem:Find("ImgCampIcon")
    local image = node:GetComponent(typeof(CS.UnityEngine.UI.Image))
    self._imgCampIcons    = {image}

    self:FreshSelectStatus(false)
end


-- function ClubGVGGroupBaseImportantNode:Start()
-- end


function ClubGVGGroupBaseImportantNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupBaseImportantNode:FreshUI(buildingInfo, buildingVo, buildingClubId, isSelfClubBuilding)
    
    self._buildingInfo = buildingInfo
    self._buildingVo = buildingVo

    local isOccupy = buildingClubId > 0
    local isShowMainBuildingInfo = isOccupy and buildingVo.id == GVGConstants.MainBuildingId
    SetActive(self.MainBuildingInfo, isShowMainBuildingInfo)
    if isShowMainBuildingInfo then
        self.ImgIcon.Status = isSelfClubBuilding and 1 or 2 
    end


    self:FreshPlayerHeads()
end

function ClubGVGGroupBaseImportantNode:FreshSelectStatus(isSelect)
    SetActive(self.ImgArrow, isSelect)
end

function ClubGVGGroupBaseImportantNode:FreshPlayerHeads()
    local playerIds = self._buildingInfo.playerIds
    local count = math.min(#playerIds, 3)

    SetActive(self.ImgBg, count > 0)
    SetActive(self.PointNode, count > 0)

    for index, node in ipairs(self._points) do
        SetActive(node, count >= index)

        local playerHeadItem = self._playerHeadItems[index]

        local playerId = playerIds[index]
        local isShow = playerId ~= nil

        if isShow then
            
            local headNode = self._headNodes[index]
            local imgCampIcon  = self._imgCampIcons[index]
            if isNull(playerHeadItem) then
                playerHeadItem = self.TeamHeadGroup.gameObject:AddChild(self._playerHeadItems[1])
                local transform = playerHeadItem.transform
                transform.localScale = self.TeamHeadGroup.localScale
                table.insert(self._playerHeadItems, playerHeadItem)

                headNode = transform:Find("CommonPlayerHeadNode")
                table.insert(self._headNodes,       headNode)
                
                local node = transform:Find("ImgCampIcon")
                imgCampIcon = node:GetComponent(typeof(CS.UnityEngine.UI.Image))
                table.insert(self._imgCampIcons,   imgCampIcon)
            end
            SetActive(playerHeadItem, true)

            ---@type ClubGVGMgr
            local mgr = ClubGVGUtils.GetMgr()
            local playerInfo = mgr:GetPlayerInfoById(playerId)
            if playerInfo then
                ---@type CommonPlayerHeadNode
                local headEnv    = CfUtils.GetLuaScr(headNode, Constants.UILuaTablePath.ComPlayerHead)
                if isNotNull(headEnv) then
                    headEnv:FreshAvatarFrame( playerInfo.avatar, playerInfo.avatarFrame)
                end
    
                if isNotNull(imgCampIcon) then
                    local clubId = playerInfo.clubId
                    local color = ClubGVGUtils.GetClubColor(clubId)
                    if color then
                        imgCampIcon.color = color
                        
                    end
                end
            end


        else
            SetActive(playerHeadItem, false)

        end

    end

end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ClubGVGGroupBaseImportantNode

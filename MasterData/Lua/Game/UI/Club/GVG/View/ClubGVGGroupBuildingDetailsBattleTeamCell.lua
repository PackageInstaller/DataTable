
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
local GetTimeHMS2 = CfUtils.GetTimeHMS2
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseDetailsPopupCell.prefab > name: OverseaClubGvgGroupBaseDetailsPopupCell
---@class ClubGVGGroupBuildingDetailsBattleTeamCell
---@field Env                           	ClubGVGGroupBuildingDetailsBattleTeamCell
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CommonPlayerHeadNode1         	UnityEngine.RectTransform               	@ 0    
---@field ImgCampIcon1                  	UnityEngine.UI.Image                    	@ 1    
---@field CommonPlayerHeadNode2         	UnityEngine.RectTransform               	@ 2    
---@field ImgCampIcon2                  	UnityEngine.UI.Image                    	@ 3    
---@field TextNumber                    	TMPro.TextMeshProUGUI                   	@ 4    
local ClubGVGGroupBuildingDetailsBattleTeamCell = Class('ClubGVGGroupBuildingDetailsBattleTeamCell')

function ClubGVGGroupBuildingDetailsBattleTeamCell:__init()

end


function ClubGVGGroupBuildingDetailsBattleTeamCell:__delete()

end


-- function ClubGVGGroupBuildingDetailsBattleTeamCell:Awake()
-- end


function ClubGVGGroupBuildingDetailsBattleTeamCell:Start()
end


function ClubGVGGroupBuildingDetailsBattleTeamCell:OnDestroy()
    -- self:unRegCountdown()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupBuildingDetailsBattleTeamCell:FreshUI(data, buildingType)
    local attachPlayerInfo  = data.attackPlayerInfo
    self:FreshHeadNode1(attachPlayerInfo.playerInfo)

    local defensePlayerInfo = data.defensePlayerInfo or {}
    self:FreshHeadNode2(defensePlayerInfo.playerInfo, buildingType)

    self._endTime = data.endTime
    self:FreshCountdown()
    
end

function ClubGVGGroupBuildingDetailsBattleTeamCell:FreshHeadNode1(...)
    local env = self:GetHeadEnv1()
    self:FreshHeadNode(env, self.ImgCampIcon1, ...)
end

function ClubGVGGroupBuildingDetailsBattleTeamCell:FreshHeadNode2(...)
    local env = self:GetHeadEnv2()
    self:FreshHeadNode(env, self.ImgCampIcon2, ...)
end

---@param headEnv CommonPlayerHeadNode
function ClubGVGGroupBuildingDetailsBattleTeamCell:FreshHeadNode(headEnv, image, playerInfo, buildingType)
    if isNull(headEnv) then return end

    SetActive(image, playerInfo ~= nil)
    if playerInfo then
        if isNotNull(image) then
            image.color = ClubGVGUtils.GetClubColor(playerInfo.clubId)
        end
        headEnv:FreshAvatarFrame( playerInfo.avatar, playerInfo.avatarFrame )
    else
        ---@type ClubGVGBuildingVo
        local vo = ClubGVGUtils.GetBuildingVoById(buildingType)
        headEnv:FreshCustomHead(vo.icon)
    end

end

function ClubGVGGroupBuildingDetailsBattleTeamCell:FreshCountdown(curSeconds)
    curSeconds = curSeconds or GameUtils.GetServerTime()
    local leftSeconds = self._endTime - curSeconds
    if leftSeconds > 0 then
        self.TextNumber.text = GetTimeHMS2(leftSeconds)
    else
        -- self:unRegCountdown()
        SetActive(self.controller, false)
    end
end


--endregion 


--region get/set 

---@return CommonPlayerHeadNode
function ClubGVGGroupBuildingDetailsBattleTeamCell:GetHeadEnv1()
    if isNull(self._headEnv1) then
        ---@type CommonPlayerHeadNode
        self._headEnv1    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode1, Constants.UILuaTablePath.ComPlayerHead)
        
    end
    return self._headEnv1
    
end

---@return CommonPlayerHeadNode
function ClubGVGGroupBuildingDetailsBattleTeamCell:GetHeadEnv2()
    if isNull(self._headEnv2) then
        ---@type CommonPlayerHeadNode
        self._headEnv2    = CfUtils.GetLuaScr(self.CommonPlayerHeadNode2, Constants.UILuaTablePath.ComPlayerHead)
        
    end
    return self._headEnv2
    
end

---endregion 


--region handler 

function ClubGVGGroupBuildingDetailsBattleTeamCell:OnChangeCountDownAction(curSeconds)
    
end

---endregion 


return ClubGVGGroupBuildingDetailsBattleTeamCell

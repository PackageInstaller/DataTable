
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define
local TeamNodeLuaPath             = "Game.UI.Club.GVG.View.ClubGVGTeamNode"
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupEditTeamPopup.prefab > name: Team
---@class ClubGVGTeamGroup
---@field Env                           	ClubGVGTeamGroup                        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgBg                         	UnityEngine.UI.Extensions.ReorderableList	@ 0    
---@field LayoutTeam                    	UnityEngine.RectTransform               	@ 1    
local ClubGVGTeamGroup = Class('ClubGVGTeamGroup')

function ClubGVGTeamGroup:__init()
    self._isAddDropListener = false
    self._teamNodeEnv = {}
end


function ClubGVGTeamGroup:__delete()

end


function ClubGVGTeamGroup:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param questId number isCanFormation == true 必传
function ClubGVGTeamGroup:FreshUI(teamMembers, isCanFormation, questId, scale)
    self._isCanFormation = isCanFormation
    -- self._isCanDrop = isCanDrop
    if isCanFormation then
        self._questId = questId
    end
    local count = self:GetTeamNodeCount()
    local parent = self.LayoutTeam
    for index = 1, count do
        ---@type ClubGVGTeamNode
        local env = self:GetTeamNodeEnv(parent, index)
        if isNotNull(env) then
            env:FreshUI(teamMembers[index], isCanFormation, scale, questId, index)
        end
    end

    if isCanFormation and not self._isAddDropListener then
        self._isAddDropListener = true
        self.ImgBg.OnElementDropped:AddListener(Bind(self, self.OnReorderTeam))
    end
end

--endregion 


--region get/set 

function ClubGVGTeamGroup:GetTeamNodeCount()
    if self._teamNodeCount == nil then
        local parent = self.LayoutTeam
        self._teamNodeCount = parent.childCount
    end
    return self._teamNodeCount
end

---@return ClubGVGTeamNode
function ClubGVGTeamGroup:GetTeamNodeEnv(parent, index)
    local env = self._teamNodeEnv[index]
    if isNull(env) then
        local node = parent:GetChild(index - 1)
        env = CfUtils.GetLuaScr(node, TeamNodeLuaPath)
        self._teamNodeEnv[index] = env
    end
    return env
end


---endregion 


--region handler 

function ClubGVGTeamGroup:OnReorderTeam(arg)
    local teamNodeEnv        = self._teamNodeEnv
    local fromIndex, toIndex = arg.FromIndex + 1, arg.ToIndex + 1
    teamNodeEnv[fromIndex], teamNodeEnv[toIndex] = teamNodeEnv[toIndex], teamNodeEnv[fromIndex]

    teamNodeEnv[fromIndex]:FreshIndex(fromIndex)
    teamNodeEnv[toIndex]:FreshIndex(toIndex)

    if self._isCanFormation then
        ---@type TeamComponent
        local teamComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.TeamComponent)
        teamComponent:SwapTeam(self._questId, fromIndex, toIndex)
        
    end

end

---endregion 


return ClubGVGTeamGroup

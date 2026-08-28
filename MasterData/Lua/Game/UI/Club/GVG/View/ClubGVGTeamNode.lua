
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils = import("Game.UI.Club.GVG.ClubGVGUtils")
--endregion

--region define
local GVGConstants = ClubGVGUtils.Constants
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupEditTeamPopup.prefab > name: TeamNode1
---@class ClubGVGTeamNode
---@field Env                           	ClubGVGTeamNode                         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field UITeamMembersNode             	Engine.Modules.LuaBehaviour             
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
---@field BtnMove                       	UnityEngine.RectTransform               
---@field ImgMask                       	UnityEngine.RectTransform               
local ClubGVGTeamNode = Class('ClubGVGTeamNode')

function ClubGVGTeamNode:__init()

end


function ClubGVGTeamNode:__delete()

end


-- function ClubGVGTeamNode:Awake()
-- end


-- function ClubGVGTeamNode:Start()
-- end


function ClubGVGTeamNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---@param index number
---@param teamMember {members:table, combatValue:number}
function ClubGVGTeamNode:FreshUI(teamMember, isCanFormation, scale, questId, index)
    -- print("teamMember", table.toString(teamMember))
    self.TextNumber.text = teamMember.combatValue

    local cardsInfo = teamMember.cardsInfo 
    scale = scale or 0.63
    UICommonUtils.FillUITeamMemberNode(self.UITeamMembersNode, false, cardsInfo, false, scale, function() 
        if isCanFormation then
            Events.Broadcast(GVGConstants.EventNames.ControlBuildingEff, false)
            CfUtils.DialogOpen(Constants.UITypeIds.UIFightTeamChoose, { levelId = questId, teamIndex = index }, {UIArgs(Constants.UITypeIds.ClubGvgGroupEditTeamPopup)})
            
        end
    end, false, nil, false, questId)

    self:FreshIndex(index)
end

function ClubGVGTeamNode:FreshIndex(index)
    self.TextDesc.text = localize("队伍_num_", {_num_ = index})
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ClubGVGTeamNode

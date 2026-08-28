
--region global define
local isNull    = isNull
local isNotNull = isNotNull
---@type ClubGVGUtils
local ClubGVGUtils = import("Game.UI.Club.GVG.ClubGVGUtils")
--endregion

--region import

--endregion

--region define
local GetTimeHMS2 = CfUtils.GetTimeHMS2
local GVGConstants = ClubGVGUtils.Constants
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupRebornDetailsNode.prefab > name: OverseaClubGvgGroupRebornDetailsNode
---@class ClubGVGGroupRebornDetailsNode
---@field Env                           	ClubGVGGroupRebornDetailsNode           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextTime                      	TMPro.TextMeshProUGUI                   	@ 0    
---@field TextNumber                    	TMPro.TextMeshProUGUI                   	@ 1    
---@field Root                          	UnityEngine.Animation                   	@ 2    
local ClubGVGGroupRebornDetailsNode = Class('ClubGVGGroupRebornDetailsNode')

function ClubGVGGroupRebornDetailsNode:__init()
    self._isShow = false
end


function ClubGVGGroupRebornDetailsNode:__delete()

end


-- function ClubGVGGroupRebornDetailsNode:Awake()
-- end


-- function ClubGVGGroupRebornDetailsNode:Start()
-- end


function ClubGVGGroupRebornDetailsNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupRebornDetailsNode:FreshUI(leftRebirthSeconds, leftRebirthTimes)
    if leftRebirthSeconds < 0 then
        return
    end
    self.TextTime.text = GetTimeHMS2(leftRebirthSeconds)
    if self._leftRebirthTimes ~= leftRebirthTimes then
        self._leftRebirthTimes = leftRebirthTimes
        -- self.TextNumber.text = leftRebirthTimes
    end
    self:PlayAniEntry()
end

function ClubGVGGroupRebornDetailsNode:PlayAniEntry()
    if self._isShow then
        return 
    end
    self._isShow = true
    self.Root:Play(GVGConstants.AniName.OverseaClubGvgGroupRebornDetailsNode_Entry)
end

function ClubGVGGroupRebornDetailsNode:PlayAniOut()
    if not self._isShow then
        return 
    end
    self._isShow = false
    self.Root:Play(GVGConstants.AniName.OverseaClubGvgGroupRebornDetailsNode_Out)
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ClubGVGGroupRebornDetailsNode

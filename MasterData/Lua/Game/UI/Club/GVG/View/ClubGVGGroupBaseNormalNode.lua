
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
--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupBaseNormalNode.prefab > name: OverseaClubGvgGroupBaseNormalNode
---@class ClubGVGGroupBaseNormalNode
---@field Env                           	ClubGVGGroupBaseNormalNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BaseInfo                      	UnityEngine.RectTransform               	@ 0    
---@field ImgBg                         	Game.Native.Common.UISwitchImage        	@ 1    
---@field TextName                      	CustomText                              	@ 2    
---@field Slider                        	UnityEngine.UI.Slider                   	@ 3    
---@field ImgFill                       	Game.Native.Common.UISwitchImage        	@ 4    
---@field SliderTextNumber              	TMPro.TextMeshProUGUI                   	@ 5    
---@field ImgSymbol                     	Game.Native.Common.UISwitchImage        	@ 6    
---@field TextNumber                    	Game.Native.Common.UISwitchTextMeshPro  	@ 7    
---@field ClubNameNode                  	UnityEngine.RectTransform               	@ 8    
---@field ClubName                      	Game.Native.Common.UISwitchText         	@ 9    
local ClubGVGGroupBaseNormalNode = Class('ClubGVGGroupBaseNormalNode')

function ClubGVGGroupBaseNormalNode:__init()

end


function ClubGVGGroupBaseNormalNode:__delete()

end


function ClubGVGGroupBaseNormalNode:Awake()
end


function ClubGVGGroupBaseNormalNode:Start()
end


function ClubGVGGroupBaseNormalNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupBaseNormalNode:FreshUI(buildingInfo, buildingVo, buildingClubId, isSelfClubBuilding)
    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    -- local buildingInfo = mgr:GetBuildInfo(buildId)
    -- ---@type ClubGVGBuildingVo
    -- local buildingVo = ClubGVGUtils.GetBuildingVoById(buildingInfo.type)
    self._buildingInfo = buildingInfo
    self._buildingVo = buildingVo

    -- local buildingClubId = checkNumber(buildingInfo.clubId)
    -- local clubId = mgr:GetClubId()
    local buildingId = checkNumber(buildingInfo.buildingId)
    self.TextName.text = ClubGVGUtils.GetBuildingName(buildingVo, buildingId)

    self:FreshProgress()

    local status = isSelfClubBuilding and 1 or 2
    self.ImgSymbol.Status = status
    self.ImgBg.Status = status
    self.ImgFill.Status = status
    
    self.TextNumber.Status = buildingVo.id == 2 and 2 or 1
    self.TextNumber.text = buildingVo.score
    
    local isShow = buildingClubId > 0
    SetActive(self.ClubNameNode, isShow)
    if isShow then
        local clubInfo = mgr:GetClubInfoById(buildingClubId)
        self.ClubName.text = clubInfo.name
        self.ClubName.Status = status
    end
    

end

function ClubGVGGroupBaseNormalNode:FreshProgress()
    local buildingInfo = self._buildingInfo 
    local buildingVo = self._buildingVo 
    local leftHp = buildingInfo.leftHp
    local life = buildingVo.life
    self.Slider.value = leftHp / life
    self.SliderTextNumber.text = string.format("%s/%s", leftHp, life)
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ClubGVGGroupBaseNormalNode

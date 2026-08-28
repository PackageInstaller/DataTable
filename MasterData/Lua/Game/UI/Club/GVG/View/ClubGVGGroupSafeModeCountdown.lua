
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type ClubGVGUtils
local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
local GVGConstants = ClubGVGUtils.Constants

--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupSafeModeCountdownPopup.prefab > name: OverseaClubGvgGroupSafeModeCountdownPopup
---@class ClubGVGGroupSafeModeCountdown
---@field Env                           	ClubGVGGroupSafeModeCountdown           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
---@field TextDesc                      	CustomText                              
local ClubGVGGroupSafeModeCountdown = Class('ClubGVGGroupSafeModeCountdown')

function ClubGVGGroupSafeModeCountdown:__init()

end


function ClubGVGGroupSafeModeCountdown:__delete()
    self._closeCb = nil
end


function ClubGVGGroupSafeModeCountdown:Awake()
    self.TextDesc.text = localize("尽量抢占地块，获得更多积分！")
    self._streamerDurationSeconds = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.StreamerDurationSeconds)
end


-- function ClubGVGGroupSafeModeCountdown:Start()
-- end


function ClubGVGGroupSafeModeCountdown:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ClubGVGGroupSafeModeCountdown:FreshUI(stageLeftSeconds)
    local isShow = stageLeftSeconds > 0
    if not isShow then
        CfUtils.SetActive(self.controller, false)
        if self._closeCb then
            self._closeCb()
        end
    else
        self.TextNumber.text = stageLeftSeconds
    end

end

--endregion 


--region get/set 

function ClubGVGGroupSafeModeCountdown:SetCloseCb(cb)
    self._closeCb = cb
end

---endregion 


--region handler 


---endregion 


return ClubGVGGroupSafeModeCountdown

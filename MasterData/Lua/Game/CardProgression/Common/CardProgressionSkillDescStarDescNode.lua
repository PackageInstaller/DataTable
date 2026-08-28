
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Common/CommonCardSkillDesc.prefab > name: DescNode
---@class CardProgressionSkillDescStarDescNode
---@field Env                           	CardProgressionSkillDescStarDescNode    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDescSwitch                	UnityEngine.RectTransform               
---@field TextDesc                      	CustomText                              
---@field ImgStar                       	Game.Native.Common.UISwitchImage        
---@field TextNumber                    	Game.Native.Common.UISwitchTextMeshPro  
local CardProgressionSkillDescStarDescNode = Class('CardProgressionSkillDescStarDescNode')

function CardProgressionSkillDescStarDescNode:__init()

end


function CardProgressionSkillDescStarDescNode:__delete()

end


-- function CardProgressionSkillDescStarDescNode:Awake()
-- end


-- function CardProgressionSkillDescStarDescNode:Start()
-- end


function CardProgressionSkillDescStarDescNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CardProgressionSkillDescStarDescNode:FreshUI(data)
    local desc   = data.desc
    local lv     = data.lv
    local status = data.status

    self.TextNumber.text = lv
    self.TextNumber.Status = status

    self.ImgStar.Status = status

    self.TextDesc.text = desc
    self.TextDescSwitch.Status = status

end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CardProgressionSkillDescStarDescNode

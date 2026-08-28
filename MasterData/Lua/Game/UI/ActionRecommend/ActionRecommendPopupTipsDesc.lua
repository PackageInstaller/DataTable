
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Action/ActionRecommendPopup.prefab > name: TitleDesc
---@class ActionRecommendPopupTipsDesc
---@field Env                           	ActionRecommendPopupTipsDesc            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtTile                       	UnityEngine.UI.Text                     
---@field TxtDesc                       	UnityEngine.UI.Text                     
local ActionRecommendPopupTipsDesc = Class('ActionRecommendPopupTipsDesc')

function ActionRecommendPopupTipsDesc:__init()

end


function ActionRecommendPopupTipsDesc:__delete()

end


-- function ActionRecommendPopupTipsDesc:Awake()
-- end


-- function ActionRecommendPopupTipsDesc:Start()
-- end


function ActionRecommendPopupTipsDesc:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function ActionRecommendPopupTipsDesc:FreshUI(desc, title)
    print("desc, title", desc, title)
    if title then
        self.TxtTile.text = title
    end

    self.TxtDesc.text = desc
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return ActionRecommendPopupTipsDesc

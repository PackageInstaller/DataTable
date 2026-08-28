
------------ import ------------

------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/Cultivate/UICultivateEquipReclaimDialog.prefab
---@class UICultivateEquipReclaimQualityNode
---@field Env                           	UICultivateEquipReclaimQualityNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
---@field ImgQuality                    	Game.Native.Common.UISwitchImage        
local UICultivateEquipReclaimQualityNode = Class('UICultivateEquipReclaimQualityNode')

function UICultivateEquipReclaimQualityNode:__init()

end


function UICultivateEquipReclaimQualityNode:__delete()

end


function UICultivateEquipReclaimQualityNode:Awake()
end


function UICultivateEquipReclaimQualityNode:Start()
end


function UICultivateEquipReclaimQualityNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function UICultivateEquipReclaimQualityNode:FreshUI(quality, count)
    self.ImgQuality.Status = quality
    self.TextNumber.text = count
end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return UICultivateEquipReclaimQualityNode

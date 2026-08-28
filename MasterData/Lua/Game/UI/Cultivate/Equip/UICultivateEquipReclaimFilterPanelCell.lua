
------------ import ------------

------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/Cultivate/UICultivateEquipReclaimDialog.prefab
---@class UICultivateEquipReclaimFilterPanelCell
---@field Env                           	UICultivateEquipReclaimFilterPanelCell                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ToggleCell                    	UnityEngine.RectTransform               
---@field TitleText                     	UnityEngine.UI.Text                     
local UICultivateEquipReclaimFilterPanelCell = Class('UICultivateEquipReclaimFilterPanelCell')

function UICultivateEquipReclaimFilterPanelCell:__init()
    self.ToggleCells = {}
end


function UICultivateEquipReclaimFilterPanelCell:__delete()

end


function UICultivateEquipReclaimFilterPanelCell:Awake()
end


function UICultivateEquipReclaimFilterPanelCell:Start()
end


function UICultivateEquipReclaimFilterPanelCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function UICultivateEquipReclaimFilterPanelCell:FreshUI(screenVo, title, selectRule)
    self.TitleText.text = title
    local id            = screenVo.id
    local condition     = screenVo.condition
    local conditionName = screenVo.conditionName


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


return UICultivateEquipReclaimFilterPanelCell

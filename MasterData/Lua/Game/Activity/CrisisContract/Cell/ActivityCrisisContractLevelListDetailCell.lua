--- from: Assets/BundleResources/Prefabs/ActivityCrisisContract120015/ActivityCrisisContractLevelListDialog.prefab > name: Cell
---@class ActivityCrisisContractLevelListDetailCell
---@field Env                           	ActivityCrisisContractLevelListDetailCell
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtTile                       	UnityEngine.RectTransform               	@ 0    
---@field ImgSel                        	UnityEngine.RectTransform               	@ 1    
---@field Icon                          	UnityEngine.RectTransform               	@ 2    
---@field TxtTime                       	UnityEngine.RectTransform               	@ 3    
---@field TagTxtTile                    	UnityEngine.RectTransform               	@ 4    
local ActivityCrisisContractLevelListDetailCell = Class('ActivityCrisisContractLevelListDetailCell')


function ActivityCrisisContractLevelListDetailCell:__init()
end


function ActivityCrisisContractLevelListDetailCell:__delete()
end


function ActivityCrisisContractLevelListDetailCell:Awake()
    
end


function ActivityCrisisContractLevelListDetailCell:Start()
end


function ActivityCrisisContractLevelListDetailCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityCrisisContractLevelListDetailCell

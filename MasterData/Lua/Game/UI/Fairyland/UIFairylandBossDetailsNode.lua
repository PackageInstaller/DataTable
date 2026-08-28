---
--- 乱流幻境关卡界面 Boss 详情节点
--- Authro: dawanfan
--- Date: 2024-1-22 15:44:55
---

local FairylandUtils = import("Game.Fairyland.FairylandUtils")

--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandBossDetailsNode.prefab > name: ActionFairylandBossDetailsNode
---@class UIFairylandBossDetailsNode
---@field Env                           	UIFairylandBossDetailsNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ProgressText                  	UnityEngine.RectTransform               
---@field Description                   	UnityEngine.RectTransform               
---@field Root                          	UnityEngine.RectTransform               
local UIFairylandBossDetailsNode = Class("UIFairylandBossDetailsNode")


function UIFairylandBossDetailsNode:__init()

end

function UIFairylandBossDetailsNode:__delete()
    
end

function UIFairylandBossDetailsNode:FillSelf()
    ---@type FairylandComponent
    local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
    local secretInfo = FairylandComponent.dojo.secretInfo[FairylandUtils.CurrentEnterQuestId]
    CfUtils.FillText(self.ProgressText, tostring(secretInfo.energy / 10) .. "%")

    if secretInfo.energy >= 1000 then
        CfUtils.SetActive(self.Root, false)
    end
end

function UIFairylandBossDetailsNode:UpdatePosition(position)
    self.Root.position = position
end


function UIFairylandBossDetailsNode:OnDestroy()
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

return UIFairylandBossDetailsNode

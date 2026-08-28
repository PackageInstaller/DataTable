---
--- 烹饪玩法，厨具倒计时节点 UI
--- Author: dawanfan
--- Date: 2024-3-14 19:45:00
---

---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()

--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityOperateMainFillNode.prefab > name: ActivityOperateMainFillNode
---@class ActivityCookingCountdownNode
---@field Env                           	ActivityCookingCountdownNode            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field FillImage                     	UnityEngine.RectTransform               	@ 0    
---@field TxtTime                       	UnityEngine.RectTransform               	@ 1    
local ActivityCookingCountdownNode = Class("ActivityCookingCountdownNode")

function ActivityCookingCountdownNode:__init()
    self.totalTime = 0
    self.remainTime = 0
    self.targetTime = 0
end

function ActivityCookingCountdownNode:__delete()
    
end

function ActivityCookingCountdownNode:Awake()
    CfUtils.SetActive(self.controller.gameObject, false)
end

function ActivityCookingCountdownNode:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

function ActivityCookingCountdownNode:Init(targetTime, type)
    self.totalTime = targetTime - ActivityCookingGame.data.currentTime
    self.targetTime = targetTime
    self.remainTime = self.totalTime

    if type == nil then
        type = 1
    end

    CfUtils.SetImageFillAmount(self.FillImage, self.remainTime / self.totalTime)
    CfUtils.FillText(self.TxtTime, math.round(self.remainTime))
    CfUtils.SetUISwitchImage(self.FillImage, type)

    CfUtils.SetActive(self.controller.gameObject, true)
end


function ActivityCookingCountdownNode:Update()
    self.remainTime = self.targetTime - ActivityCookingGame.data.currentTime

    CfUtils.SetImageFillAmount(self.FillImage, self.remainTime / self.totalTime)
    CfUtils.FillText(self.TxtTime, math.round(self.remainTime))

    -- CfUtils.SetActive(self.controller.gameObject, false)
end


return ActivityCookingCountdownNode
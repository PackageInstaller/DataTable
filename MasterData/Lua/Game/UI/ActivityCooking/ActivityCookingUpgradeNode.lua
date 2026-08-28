---
--- 烹饪玩法升级界面节点
--- Author: dawanfan
--- Date: 2024-3-18 10:39:27
---


local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')


---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")


--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityCakeShopFightBuffNode.prefab > name: ActivityCakeShopFightBuffNode
---@class ActivityCookingUpgradeNode
---@field Env                           	ActivityCookingUpgradeNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 0    
---@field ImgStar1                      	UnityEngine.RectTransform               	@ 1    
---@field ImgStar2                      	UnityEngine.RectTransform               	@ 2    
---@field ImgStar3                      	UnityEngine.RectTransform               	@ 3    
---@field ImgSelect                     	UnityEngine.RectTransform               	@ 4    
---@field TextDecorate                  	UnityEngine.RectTransform               	@ 5    
---@field Root                          	UnityEngine.RectTransform               	@ 6    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 7    
---@field redPoint                      	UnityEngine.RectTransform               	@ 8    
local ActivityCookingUpgradeNode = Class("ActivityCookingUpgradeNode")

function ActivityCookingUpgradeNode:__init()
    self._cb = nil
    self._index = -1
    self._isSelect = false
    ---@type {id:number, type:number}
    self._data = nil
end

function ActivityCookingUpgradeNode:__delete()
    self._cb = nil
    self._index = -1
    self._isSelect = false
    self._data = nil
end

function ActivityCookingUpgradeNode:Awake()
    SetButtonAction(self.Root, Bind(self, self.OnBtnClick))
    self.__OnCookingUpgrade = Bind(self, self.OnItemUpgrade)
    Events.AddListener(Constants.EventNames.ActivityCookingUpgrade, self.__OnCookingUpgrade)
end

function ActivityCookingUpgradeNode:OnDestroy()
    Events.RemoveListener(Constants.EventNames.ActivityCookingUpgrade, self.__OnCookingUpgrade)

    self.controller = nil
    self:Delete()
    self = nil
end

function ActivityCookingUpgradeNode:Refresh(data, selectIndex, cb)
    self._index = data.index
    self._data = data.input
    self._isSelect = data.index == selectIndex
    self._cb = cb
    
    self:FillSelf()
end

function ActivityCookingUpgradeNode:Select(select)
    if self._isSelect == select then
        return
    end

    self._isSelect = select
    CfUtils.SetActive(self.ImgSelect, self._isSelect)
end

function ActivityCookingUpgradeNode:FillSelf()
    local stars = {1, 1, 1}
    local level = ActivityCookingComponent.dojo:GetItemLevel(self._data.id, self._data.type)
    if level ~= nil then
        for i = 1, level do
            stars[i] = 2
        end
    end

    CfUtils.SetUISwitchImage(self.ImgStar1, stars[1])
    CfUtils.SetUISwitchImage(self.ImgStar2, stars[2])
    CfUtils.SetUISwitchImage(self.ImgStar3, stars[3])
    CfUtils.SetUISwitchText(self.TextDecorate, self._data.type)
    CfUtils.SetUISwitchImage(self.ImgBg, self._data.type)
    CfUtils.FillImage(self.ImgIcon, ActivityCookingComponent.dojo:GetItemIconPath(self._data.id, self._data.type), true)
    CfUtils.SetActive(self.ImgSelect, self._isSelect)

    CfUtils.SetActive(self.redPoint, self:CanUpgrade())
end

function ActivityCookingUpgradeNode:OnBtnClick()
    if self._isSelect then
        return
    end

    if self._cb ~= nil then
        self._cb(self._index)
    end
end

function ActivityCookingUpgradeNode:OnItemUpgrade(id, type)
    if self._data == nil then
        return
    end
    
    if self._data.type == type and self._data.id == id then
        self:FillSelf()
    else
        CfUtils.SetActive(self.redPoint, self:CanUpgrade())
    end

end

---@return boolean
function ActivityCookingUpgradeNode:CanUpgrade()
    return ActivityCookingComponent.dojo:CanItemUpgrade(self._data.id, self._data.type)
end

return ActivityCookingUpgradeNode

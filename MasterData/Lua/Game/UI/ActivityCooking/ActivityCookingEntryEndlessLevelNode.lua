---
--- 烹饪玩法入口界面，无尽关卡节点
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



--- from: Assets/BundleResources/Prefabs/ActivityMountain/11300302/ActivityMountainFightDialog.prefab > name: EndlessStatus
---@class ActivityCookingEntryEndlessLevelNode
---@field Env                           	ActivityCookingEntryEndlessLevelNode    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextStarNum                   	UnityEngine.RectTransform               	@ 0    
---@field StatusLock                    	UnityEngine.RectTransform               	@ 1    
---@field SelectNode                    	UnityEngine.RectTransform               	@ 2    
---@field Root                          	UnityEngine.RectTransform               	@ 3    
---@field TextTitle                     	UnityEngine.RectTransform               	@ 4    
---@field ImgTitle                      	UnityEngine.RectTransform               	@ 5    
---@field ImgBg4                        	UnityEngine.RectTransform               	@ 6    
---@field ImgLock                       	UnityEngine.RectTransform               	@ 7    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 8    
local ActivityCookingEntryEndlessLevelNode = Class("ActivityCookingEntryEndlessLevelNode")

function ActivityCookingEntryEndlessLevelNode:__init()
    self._cb = nil
    self._index = -1
    self._isSelect = false
    self._data = nil
end

function ActivityCookingEntryEndlessLevelNode:__delete()
    self._cb = nil
    self._index = -1
    self._isSelect = false
    self._data = nil
end

function ActivityCookingEntryEndlessLevelNode:Awake()
    SetButtonAction(self.Root, Bind(self, self.OnBtnClick))
end

function ActivityCookingEntryEndlessLevelNode:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

---@param data {index: number, input: ActivityCookingLevelVo}
---@param selectIndex number
---@param cb function
function ActivityCookingEntryEndlessLevelNode:Refresh(data, selectIndex, cb)
    self._index = data.index
    self._data = data.input
    self._isSelect = data.index == selectIndex
    self._cb = cb
    
    self:FillSelf()
end

function ActivityCookingEntryEndlessLevelNode:FillSelf()
    local stars = {1, 1, 1}
    local levelInfo = ActivityCookingComponent.dojo.levelInfo[self._data.id]
    if levelInfo ~= nil then
        for i = 1, levelInfo.star do
            stars[i] = 2
        end
    end

    local unlock = ActivityCookingComponent.dojo:IsLevelUnlock(self._data.id)

    CfUtils.SetActive(self.StatusLock, unlock == false)
    CfUtils.SetUISwitchImage(self.ImgStar1, stars[1])
    CfUtils.SetUISwitchImage(self.ImgStar2, stars[2])
    CfUtils.SetUISwitchImage(self.ImgStar3, stars[3])
    CfUtils.FillText(self.TextStarNum, "≥  " .. tostring(self._data.unlockStarNum))
    CfUtils.FillText(self.TextLevel, tostring(self._data.id))
    CfUtils.SetActive(self.SelectNode, self._isSelect)
end

function ActivityCookingEntryEndlessLevelNode:Select(select)
    if self._isSelect == select then
        return
    end

    self._isSelect = select
    CfUtils.SetActive(self.SelectNode, self._isSelect)

    local idx = self._isSelect and 2 or 1
    CfUtils.SetUISwitchText(self.TextStarNum, idx)
    CfUtils.SetUISwitchText(self.TextTitle, idx)
    CfUtils.SetUISwitchImage(self.ImgTitle, idx)
    CfUtils.SetUISwitchImage(self.ImgBg4, idx)
    CfUtils.SetUISwitchImage(self.ImgLock, idx)
    CfUtils.SetUISwitchImage(self.ImgBg, idx)
end

function ActivityCookingEntryEndlessLevelNode:OnBtnClick()
    if self._isSelect then
        return
    end

    if self._cb ~= nil then
        self._cb(self._index)
    end
end

return ActivityCookingEntryEndlessLevelNode

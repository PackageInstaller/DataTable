---
--- 烹饪玩法入口界面，普通关卡节点
--- Author: dawanfan
--- Date: 2024-3-18 10:44:07
---


local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)


--- from: Assets/BundleResources/Prefabs/ActivityMountain/11300302/ActivityMountainFightDialog.prefab > name: Cell
---@class ActivityCookingEntryNormalLevelNode
---@field Env                           	ActivityCookingEntryNormalLevelNode     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgStar1                      	UnityEngine.RectTransform               	@ 0    
---@field ImgStar2                      	UnityEngine.RectTransform               	@ 1    
---@field ImgStar3                      	UnityEngine.RectTransform               	@ 2    
---@field TextLevel                     	UnityEngine.RectTransform               	@ 3    
---@field TextDecorate                  	UnityEngine.RectTransform               	@ 4    
---@field ImgBg4                        	UnityEngine.RectTransform               	@ 5    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 6    
---@field StatusLock                    	UnityEngine.RectTransform               	@ 7    
---@field SelectNode                    	UnityEngine.RectTransform               	@ 8    
---@field Root                          	UnityEngine.RectTransform               	@ 9    
local ActivityCookingEntryNormalLevelNode = Class("ActivityCookingEntryNormalLevelNode")

function ActivityCookingEntryNormalLevelNode:__init()
    self._cb = nil
    self._index = -1
    self._isSelect = false
    self._data = nil
end

function ActivityCookingEntryNormalLevelNode:__delete()
    self._cb = nil
    self._index = -1
    self._isSelect = false
    self._data = nil
end

function ActivityCookingEntryNormalLevelNode:Awake()
    SetButtonAction(self.Root, Bind(self, self.OnBtnClick))
end

function ActivityCookingEntryNormalLevelNode:SetDelegate(_delegate)
    self.delegate = _delegate
end

function ActivityCookingEntryNormalLevelNode:OnDestroy()

    if self._co then
        cs_coroutine.stop(self._co)
        self._co = nil
    end

    self.controller = nil
    self:Delete()
    self = nil
end

---@param data {index: number, input: ActivityCookingLevelVo}
---@param selectIndex number
---@param cb function
function ActivityCookingEntryNormalLevelNode:Refresh(data, selectIndex, cb)
    self._index = data.index
    self._data = data.input
    self._isSelect = data.index == selectIndex
    self._cb = cb
    
    self:FillSelf()
    self:FillSelect()
end

function ActivityCookingEntryNormalLevelNode:FillSelect()
    local dialogName = self.delegate.controller.gameObject.name
    if self._isSelect then
        CfUtils.PlayDelayShowAnimation(self.Root, 1, string.format("%s_Cell_Selected",dialogName), string.format("%s_Cell_Selecting",dialogName))
    else
        CfUtils.PlayAnimation(self.Root, string.format("%s_Cell_UnSelect",dialogName))
    end

    local idx = self._isSelect and 2 or 1
    CfUtils.SetUISwitchImage(self.ImgBg4, idx)
    CfUtils.SetUISwitchText(self.TextLevel, idx)
    CfUtils.SetUISwitchText(self.TextDecorate, idx)
    CfUtils.SetUISwitchImage(self.StatusLock, idx)
    CfUtils.SetUISwitchImage(self.ImgBg, idx)
end

function ActivityCookingEntryNormalLevelNode:FillSelf()
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
    CfUtils.FillText(self.TextLevel, tostring(self._data.name))

    self._co = CfUtils.PlayAnimation(self.controller.gameObject, "UI_Common_List_Cell_Idle")
end

function ActivityCookingEntryNormalLevelNode:Select(select)
    if self._isSelect == select then
        return
    end

    self._isSelect = select
    self:FillSelect()
end

function ActivityCookingEntryNormalLevelNode:OnBtnClick()
    if self._isSelect then
        return
    end

    if self._cb ~= nil then
        self._cb(self._index)
    end
end

return ActivityCookingEntryNormalLevelNode

---
--- 烹饪活动，操作指南界面
--- Author: dawanfan
--- Date: 2024-4-22 10:41:24
---

local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()
local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")


--- from: Assets/BundleResources/Prefabs/ActivityMountain/11300302/ActivityMountainInstructionDialog.prefab > name: ActivityMountainInstructionDialog
---@class ActivityCookingInstructionDialog
---@field Env                           	ActivityCookingInstructionDialog        
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnArrowLeft                  	UnityEngine.RectTransform               	@ 0    
---@field BtnArrowRight                 	UnityEngine.RectTransform               	@ 1    
---@field Pages                         	UnityEngine.RectTransform               	@ 2    
---@field ClickClose                    	UnityEngine.RectTransform               	@ 3    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 4    
local ActivityCookingInstructionDialog = Class("ActivityCookingInstructionDialog")

function ActivityCookingInstructionDialog:__init()
    self.currentIndex = 1
    ---@type ActivityCookingInstructionPage[]
    self.pageScrs = {}
    self.pageSize = 0
end

function ActivityCookingInstructionDialog:__delete()
    self.pageScrs = nil
end

function ActivityCookingInstructionDialog:Awake()
    local initParams = self.controller.Argument.parameters or {}
    local levelId = checkNumber(initParams.levelId)
    self.onClose = initParams.onClose

    if levelId > 0 then
        local levelVo = ActivityCookingUtils.GetCookingLevelVo(levelId)
        if levelVo then
            local guideIndex = checkNumber(levelVo.guidePic)
            if guideIndex > 0 then
                self.currentIndex = guideIndex
            else
                self.currentIndex = 1
            end
        end
    end

    SetButtonAction(self.BtnArrowLeft, Bind(self, self.OnPreClick))
    SetButtonAction(self.BtnArrowRight, Bind(self, self.OnNextClick))
    SetButtonAction(self.ClickClose, Bind(self, self.Close))
    if self.BtnClose ~= nil then
        SetButtonAction(self.BtnClose, Bind(self, self.Close))
    end
end

function ActivityCookingInstructionDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    end))
    return coWait
end

function ActivityCookingInstructionDialog:OnFocus()
    
end

function ActivityCookingInstructionDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()
                
                local childCount = self.Pages.childCount
                for i = 1, childCount do
                    local go = self.Pages:Find("Page" .. tostring(i))
                    if go then
                        local luaScr = CfUtils.GetLuaScr(go, "Game.UI.ActivityCooking.ActivityCookingInstructionPage")
                        if luaScr then
                            table.insert(self.pageScrs, luaScr)
                            luaScr:Init(i, self.currentIndex)
                            self.pageSize = self.pageSize + 1
                        end
                    end
                end

            end
        )
    )

    return coWait
end

function ActivityCookingInstructionDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function ActivityCookingInstructionDialog:OnNextClick()
    local index = self.currentIndex + 1
    if index > self.pageSize then
        index = index % self.pageSize
    end

    self:ChangePage(index)
end

function ActivityCookingInstructionDialog:OnPreClick()
    local index = self.currentIndex - 1
    if index <= 0 then
        index = index + self.pageSize
    end

    self:ChangePage(index)
end

function ActivityCookingInstructionDialog:ChangePage(nextIndex)
    local prePage = self.pageScrs[self.currentIndex]
    prePage:Select(false)
    
    self.currentIndex = nextIndex
    local currentPage = self.pageScrs[self.currentIndex]
    currentPage:Select(true)
end

function ActivityCookingInstructionDialog:Close()
    UIModule.CloseDialog(self.controller)
    if self.onClose then
        self.onClose()
    end
end

return ActivityCookingInstructionDialog

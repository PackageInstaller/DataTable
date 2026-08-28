---
--- 烹饪玩法界面
--- Author: dawanfan
--- Date: 2024-3-12 11:33:39
---


local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

local Vector3 = CS.UnityEngine.Vector3
local GameObject = CS.UnityEngine.GameObject
local Time = CS.UnityEngine.Time
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")
local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)

--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityOperateMainDialog.prefab > name: ActivityOperateMainDialog
---@class ActivityCookingDialog
---@field Env                           	ActivityCookingDialog                   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TxtTime                       	UnityEngine.RectTransform               	@ 0    
---@field Slider                        	UnityEngine.RectTransform               	@ 1    
---@field TxtNum1                       	UnityEngine.RectTransform               	@ 2    
---@field TxtNum2                       	UnityEngine.RectTransform               	@ 3    
---@field TxtNum3                       	UnityEngine.RectTransform               	@ 4    
---@field ImgStar1                      	UnityEngine.RectTransform               	@ 5    
---@field ImgStar2                      	UnityEngine.RectTransform               	@ 6    
---@field ImgStar3                      	UnityEngine.RectTransform               	@ 7    
---@field BtnSuspend                    	UnityEngine.RectTransform               	@ 8    
---@field CookNodeParent                	UnityEngine.RectTransform               	@ 9    
---@field GuestNodeParent               	UnityEngine.RectTransform               	@ 10   
---@field Trash                         	UnityEngine.RectTransform               	@ 11   
---@field ParticleBoom                  	UnityEngine.RectTransform               	@ 12   
---@field ParticleBoomMove              	UnityEngine.RectTransform               	@ 13   
---@field ParticleAdd                   	UnityEngine.RectTransform               	@ 14   
---@field Particles                     	UnityEngine.RectTransform               	@ 15   
local ActivityCookingDialog = Class("ActivityCookingDialog")

function ActivityCookingDialog:__init()
    self.nodeKitchenwareIndex = {}
    self.nodeFoodIndex = {}
    self.coUpdate = nil

    self.updateDeltaTime = 0.1
    self.WaitForSec = Yielders.GetWaitForSeconds(self.updateDeltaTime)

    ---@type table<number, ActivityCookingNode>
    self.nodeScrs = {}

    ---@type table<number, ActivityCookingGuest>
    self.guestScrs = {}

    self.particleFlyCos = {}
    self.coIndex = 1
end

function ActivityCookingDialog:__delete()
    
end

function ActivityCookingDialog:Awake()
    SetButtonAction(self.BtnSuspend, Bind(self, self.OnBtnSuspendClick))
    self._OnSellFood = Events.AddListener(Constants.EventNames.ActivityCookingSellFood, Bind(self, self.OnSellFood))
    self._OnToBg = Events.AddListener(Constants.EventNames.ONAPP_TO_BG, Bind(self, self.OnAppToBgHandler_))
    self._OnToFg = Events.AddListener(Constants.EventNames.ONAPP_TO_FG, Bind(self, self.OnAppToFgHandler_))
end

function ActivityCookingDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self.coUpdate ~= nil then
            cs_coroutine.stop(self.coUpdate)
        end

        CfUtils.FillText(self.TxtTime, second_toMMSS(math.round(ActivityCookingGame.data.totalTime - ActivityCookingGame.data.currentTime)))
        GameUtils.HideBlack()

    
        --- init node script
        for i = 1, self.CookNodeParent.transform.childCount do
            local go = self.CookNodeParent:GetChild(i - 1)
            if go ~= nil then
                local nodeScr = CfUtils.GetLuaScr(go, "Game.UI.ActivityCooking.ActivityCookingNode")
                if nodeScr ~= nil then
                    nodeScr:Init(self)
                    table.insert(self.nodeScrs, nodeScr)
                end
            end
        end
        
        --- init Guest
        for i = 1, 4 do
            local go = self.GuestNodeParent.transform:Find("GuestNode" .. tostring(i))
            if go ~= nil then
                local guestScr = CfUtils.GetLuaScr(go, "Game.UI.ActivityCooking.ActivityCookingGuest")
                if guestScr ~= nil then
                    self.guestScrs[i] = guestScr
                    self.guestScrs[i]:Init()
                end
            end
        end

        --- fill ui element
        if ActivityCookingGame.data.gameMode == ActivityCookingConstants.GameMode.Normal then
            for i = 1, 3 do
                CfUtils.FillText(self["TxtNum" .. tostring(i)], ActivityCookingGame.data.ratingParam[i])
                CfUtils.SetUISwitchImage(self["ImgStar" .. tostring(i)], 2)
            end
        else
            CfUtils.SetActive(self.TxtNum1, false)
            CfUtils.SetActive(self.TxtNum2, false)
            CfUtils.SetActive(self.ImgStar3, false)
            CfUtils.SetActive(self.Slider, false)
        end

        CfUtils.SetSliderPercent(self.Slider, 0)
        CfUtils.SetActive(self.Trash, ActivityCookingGame.data.trashEnable)
        if ActivityCookingGame.data.trashEnable then
            SetButtonAction(self.Trash, Bind(self, self.OnTrashClick))
        end

        local levelVo = ActivityCookingUtils.GetCookingLevelVo(ActivityCookingGame.currentLevel)
        if levelVo.guidePic > 0 then
            local config = ActivityCookingConstants.CookingUIConfigs[ActivityCookingComponent.dojo.config.id]
            UIModule.OpenDialog({id=config.InstructionDialog, parameters={
                levelId=ActivityCookingGame.currentLevel,
                onClose=Bind(self, self.StartGame)
            }})
        else
            self:StartGame()
        end
        
    end))
    return coWait
end

function ActivityCookingDialog:StartGame()
    self.coUpdate = cs_coroutine.start(function ()
        while ActivityCookingGame.inGame do
            if not ActivityCookingGame.stopped then
                if ActivityCookingGame:CheckIsGameEnd() then
                    printInfo("CookingGameFinish")
                    ActivityCookingGame:CookingEnd(function ()
                        for _, nodeScr in pairs(self.nodeScrs) do
                            nodeScr:OnCookingEnd()
                        end
                    end)
                    break
                end

                self:Update(self.updateDeltaTime)
                cs_coroutine.yield_return(self.WaitForSec)
            else
                cs_coroutine.yield_return()
            end
        end
    end)
end

function ActivityCookingDialog:OnFocus()
    
end

function ActivityCookingDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()

            end
        )
    )

    return coWait
end

function ActivityCookingDialog:RefreshDialog()
    
end

function ActivityCookingDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        if self.coUpdate ~= nil then
            cs_coroutine.stop(self.coUpdate)
        end

        for _, co in pairs(self.particleFlyCos) do
            cs_coroutine.stop(co)
        end

        Events.RemoveListener(Constants.EventNames.ActivityCookingSellFood, self._OnSellFood)
        Events.RemoveListener(Constants.EventNames.ONAPP_TO_BG, self._OnToBg)
        Events.RemoveListener(Constants.EventNames.ONAPP_TO_FG, self._OnToFg)
        
        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function ActivityCookingDialog:OnRegisterCookingNode(nodeId)
    
end

function ActivityCookingDialog:Update(deltaTime)

    CfUtils.FillText(self.TxtTime, second_toMMSS(math.round(ActivityCookingGame.data.totalTime - ActivityCookingGame.data.currentTime)))
    for _, nodeScr in pairs(self.nodeScrs) do
        nodeScr:Update()
    end

    --- 判断是否有新到顾客
    ---@type ActivityCooking.ViewGuest
    if ActivityCookingGame.data.guestQueue:Size() > 0 then
        local guest, time = ActivityCookingGame.data.guestQueue:Peek()
        while ActivityCookingGame.data.guestQueue:Size() > 0 and time <= ActivityCookingGame.data.currentTime and self:HasEmptyGuestPosition() do
            ActivityCookingGame.data.guestQueue:Dequeue()
            if guest.location ~= 0 and checkTable(self.guestScrs[guest.location]):CanEnterGuest() then
                guest.enterTime = ActivityCookingGame.data.currentTime
                self.guestScrs[guest.location]:GuestEnter(guest)
            else
                for _, guestScr in pairs(self.guestScrs) do
                    if guestScr:CanEnterGuest() then
                        guest.enterTime = ActivityCookingGame.data.currentTime
                        guestScr:GuestEnter(guest)
                        break
                    end
                end
            end

            --- 无尽模式客人数据循环
            if ActivityCookingGame.data.gameMode == ActivityCookingConstants.GameMode.Endless then
                ActivityCookingGame.data.guestQueue:Enqueue(guest, ActivityCookingGame.data.currentTime + guest.survivalTime)
            end
            guest, time = ActivityCookingGame.data.guestQueue:Peek()
        end
    end

    for _, guestScr in pairs(self.guestScrs) do
        guestScr:Update()
    end

    ActivityCookingGame:Update(deltaTime)
end

function ActivityCookingDialog:OnSellFood(position)
    local percent = 0
    if ActivityCookingGame.data.gameMode == ActivityCookingConstants.GameMode.Normal then
        --- 普通模式
        local percentPerRating = 1 / #ActivityCookingGame.data.ratingParam
        for i = 1, #ActivityCookingGame.data.ratingParam do
            local rating = ActivityCookingGame.data.ratingParam[i]
            local rating1 = checkNumber(ActivityCookingGame.data.ratingParam[i - 1])
            local diff = rating - rating1
            percent = percent + math.max(0, math.min(ActivityCookingGame.data.selledPrice - rating1, diff)) / diff * percentPerRating
        end
    end

    local price = ActivityCookingGame.data.selledPrice
    local boom = GameObject.Instantiate(self.ParticleBoom, position, self.controller.transform.rotation, self.Particles)
    local boomMove = GameObject.Instantiate(self.ParticleBoomMove, position, self.controller.transform.rotation, self.Particles)

    local co = cs_coroutine.start(function ()
        local time = 0
        local startPosition = position
        local targetPosition = self.Slider.transform.position

        while time <= 0.4 do
            boomMove.transform.position = Vector3.Lerp(startPosition, targetPosition, time / 0.4)
            time = time + Time.deltaTime
            cs_coroutine.yield_return()
        end

        self:RefreshSellPrice(price, percent)

        while time <= 0.75 do
            time = time + Time.deltaTime
            cs_coroutine.yield_return()
        end

        GameObject.Destroy(boom.gameObject)
        GameObject.Destroy(boomMove.gameObject)
    end)

    self.particleFlyCos[self.coIndex] = co
    self.coIndex = self.coIndex + 1
end

function ActivityCookingDialog:RefreshSellPrice(price, percent)
    CriWareUtils.PlaySe(UISheets.SFX_COOKING.path, UISheets.SFX_COOKING.sfx_cooking_sell)
    if ActivityCookingGame.data.gameMode == ActivityCookingConstants.GameMode.Normal then
        --- 普通模式
        CfUtils.SetSliderPercent(self.Slider, percent)
        CfUtils.SetActive(self.ParticleAdd, false)
        CfUtils.SetActive(self.ParticleAdd, true)
        for i = 1, 3 do
            if price >= ActivityCookingGame.data.ratingParam[i] then
                CfUtils.SetUISwitchImage(self["ImgStar" .. tostring(i)], 1)
                local fx = self["TxtNum"..tostring(i)].transform:Find("UIFX_Star")
                CfUtils.SetActive(fx, true)
            end
        end
    else
        --- 无尽模式
        CfUtils.FillText(self.TxtNum3, price)
    end
end

function ActivityCookingDialog:OnBtnSuspendClick()
    ActivityCookingGame:GameStop(true)
    UIModule.OpenDialog({id=Constants.UITypeIds.ActivityOperateSuspendDialog})
end

function ActivityCookingDialog:HasEmptyGuestPosition()
    for _, guestScr in pairs(self.guestScrs) do
        if guestScr:CanEnterGuest() then
            return true
        end
    end

    return false
end

function ActivityCookingDialog:OnTrashClick()
    if ActivityCookingGame.data.isTrash then
        ActivityCookingGame.data.isTrash = false
        CfUtils.PlayAnimation(self.Trash, "ActivityOperateMainDialog_Trashcan_Close")
    else
        ActivityCookingGame.data.isTrash = true
        CfUtils.PlayAnimation(self.Trash, "ActivityOperateMainDialog_Trashcan_Open")
    end
end

function ActivityCookingDialog:DropFood()
    if ActivityCookingGame:DropFood() then
        CfUtils.PlayAnimation(self.Trash, "ActivityOperateMainDialog_Trashcan_Close")
        return true
    end

    return false
end

function ActivityCookingDialog:OnAppToBgHandler_()
    self.startToBgTime = GameUtils.GetServerTime()
end

function ActivityCookingDialog:OnAppToFgHandler_()
    if ActivityCookingGame.stopped then
        return
    end

    local time = GameUtils.GetServerTime() - self.startToBgTime
    self:Update(time)
end

return ActivityCookingDialog

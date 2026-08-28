-------------------------------------------------------------------------------
-- PVP猜拳先后手弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-10-09 19:48:18
-------------------------------------------------------------------------------

local util         = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine'
local CoWait       = CS.Engine.Lib.CoWait
local Animation    = CS.UnityEngine.Animation

---@type Engine.Modules.CDTimerModule
local CDTimerModule = CS.Engine.Modules.CDTimerModule:GetInstance()

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/FingerGuess/FingerGuessDialog.prefab
---@class PvpFingerGuessingDialog
---@field Env                           	PvpFingerGuessingDialog                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field FinalResultOrderImg           	UnityEngine.RectTransform               
---@field FinalResultShadowText         	UnityEngine.RectTransform               
---@field FinalResultText               	UnityEngine.RectTransform               
---@field OthersGuessFinger2Img         	UnityEngine.RectTransform               
---@field OthersGuessFingerImg          	UnityEngine.RectTransform               
---@field OthersGuessLetterImg          	UnityEngine.RectTransform               
---@field OthersPowerText               	UnityEngine.RectTransform               
---@field MyselfGuessFinger2Img         	UnityEngine.RectTransform               
---@field MyselfGuessFingerImg          	UnityEngine.RectTransform               
---@field MyselfGuessLetterImg          	UnityEngine.RectTransform               
---@field MyselfPowerText               	UnityEngine.RectTransform               
---@field GuessNode3BtnNode             	UnityEngine.RectTransform               
---@field GuessNode3AnimRoot            	UnityEngine.RectTransform               
---@field GuessNode2BtnNode             	UnityEngine.RectTransform               
---@field GuessNode2AnimRoot            	UnityEngine.RectTransform               
---@field GuessNode1BtnNode             	UnityEngine.RectTransform               
---@field GuessNode1AnimRoot            	UnityEngine.RectTransform               
---@field Root                          	UnityEngine.RectTransform               
local PvpFingerGuessingDialog = Class('PvpFingerGuessingDialog')


local TakeResultTimeoutTime   = 3
local GuessNodeEnterAnimName  = 'FingerGuessDialogGuessGo'
local GuessNodeChooseAnimName = 'FingerGuessDialogGuessChoose'
local GuessNodeCancelAnimName = 'FingerGuessDialogGuessCancel'
local GuessType = {
    SCISSORS = 1,  -- 剪刀
    ROCK     = 2,  -- 石头
    PAPER    = 3,  -- 布
}


function PvpFingerGuessingDialog:__init()
    ---@type Engine.Lib.CoWait
    self.doAnimationCo_  = nil
    self.matchedRoomId_  = nil
    self.sendResultId_   = nil
    self.takeResultId_   = nil
    self.sendCancelId_   = nil
    self.takeCancelId_   = nil
    ---@type fun(selectType:integer):void
    self.sendResultCb_   = nil
    ---@type fun(guessResult:integer, isFinalWin:boolean):void
    self.takeResultCb_   = nil
    ---@type fun(isSilence:boolean):void
    self.sendCancelCb_   = nil
    ---@type fun():void
    self.takeCancelCb_   = nil
    self.isGuessResult_  = false
    self.isControllable_ = true
end


function PvpFingerGuessingDialog:__delete()
    self.doAnimationCo_  = nil
    self.matchedRoomId_  = nil
    self.sendResultId_   = nil
    self.takeResultId_   = nil
    self.sendCancelId_   = nil
    self.takeCancelId_   = nil
    self.sendResultCb_   = nil
    self.takeResultCb_   = nil
    self.sendCancelCb_   = nil
    self.takeCancelCb_   = nil
    self.isControllable_ = nil
    self.isGuessResult_  = nil
    self.controller      = nil
end


function PvpFingerGuessingDialog:Awake()
end


function PvpFingerGuessingDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local initParams    = self.controller.Argument.parameters or {}
        self.matchedRoomId_ = initParams.matchedRoomId
        self.sendResultId_  = initParams.sendResultId
        self.takeResultId_  = initParams.takeResultId
        self.sendCancelId_  = initParams.sendCancelId
        self.takeCancelId_  = initParams.takeCancelId
        self.sendResultCb_  = initParams.sendResultCb
        self.takeResultCb_  = initParams.takeResultCb
        self.sendCancelCb_  = initParams.sendCancelCb
        self.takeCancelCb_  = initParams.takeCancelCb

        -- bind listener
        SetButtonAction(self.GuessNode1BtnNode, Bind(self, self.OnClickGuessRockButtonHandler_))
        SetButtonAction(self.GuessNode2BtnNode, Bind(self, self.OnClickGuessScissorsButtonHandler_))
        SetButtonAction(self.GuessNode3BtnNode, Bind(self, self.OnClickGuessPaperButtonHandler_))
        self.receivePacketSuccessCB_ = Events.AddListener(Constants.EventNames.ReceivePacketSuccess, Bind(self, self.OnReceivePacketSuccessHandler_))
        self.fingerGuessingFinishCb_ = Events.AddListener(Constants.EventNames.PVPFingerGuessingFinish, Bind(self, self.OnFingerGuessingFinishHandler_))
        self.fingerGuessingCancelCb_ = Events.AddListener(Constants.EventNames.PVPFingerGuessingCancel, Bind(self, self.OnFingerGuessingCancelHandler_))
    end))
    return coWait
end


function PvpFingerGuessingDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.ReceivePacketSuccess, self.receivePacketSuccessCB_)
        Events.RemoveListener(Constants.EventNames.PVPFingerGuessingFinish, self.fingerGuessingFinishCb_)
        Events.RemoveListener(Constants.EventNames.PVPFingerGuessingCancel, self.fingerGuessingCancelCb_)

        if not isNull(self.doAnimationCo_) then
            cs_coroutine.stop(self.doAnimationCo_)
            self.doAnimationCo_ = nil
        end

        self:ClearTimeoutCountdown_()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end))
    return coWait
end


function PvpFingerGuessingDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        CfUtils.PlayAnimation(self.GuessNode1AnimRoot, GuessNodeEnterAnimName)
        CfUtils.PlayAnimation(self.GuessNode2AnimRoot, GuessNodeEnterAnimName)
        CfUtils.PlayAnimation(self.GuessNode3AnimRoot, GuessNodeEnterAnimName)
    end))
    return coWait
end


function PvpFingerGuessingDialog:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local animTime = 0
        if self.isGuessResult_ then
            CfUtils.PlayAnimator(self.Root, 'Exit')
            animTime = CfUtils.GetAnimatorTime(self.Root, 'FingerGuessDialogResultExit')
        else
            CfUtils.PlayAnimator(self.Root, 'Break')
            animTime = CfUtils.GetAnimatorTime(self.Root, 'FingerGuessDialogResultBreak')
        end
        coroutine.yield(CS.UnityEngine.WaitForSeconds(animTime))
    end))
    return coWait
end


-------------------------------------------------
-- get / set

function PvpFingerGuessingDialog:GetSelectGuessType()
    return self.selectGuessType_
end
function PvpFingerGuessingDialog:SetSelectGuessType(guessType)
    self.selectGuessType_ = checkInt(guessType)
    self:UpdateSelectGuessType_()
end


-------------------------------------------------
-- private

function PvpFingerGuessingDialog:UpdateSelectGuessType_()
    local isChoose1 = self:GetSelectGuessType() == GuessType.ROCK
    local isChoose2 = self:GetSelectGuessType() == GuessType.SCISSORS
    local isChoose3 = self:GetSelectGuessType() == GuessType.PAPER
    CfUtils.PlayAnimation(self.GuessNode1AnimRoot, isChoose1 and GuessNodeChooseAnimName or GuessNodeCancelAnimName)
    CfUtils.PlayAnimation(self.GuessNode2AnimRoot, isChoose2 and GuessNodeChooseAnimName or GuessNodeCancelAnimName)
    CfUtils.PlayAnimation(self.GuessNode3AnimRoot, isChoose3 and GuessNodeChooseAnimName or GuessNodeCancelAnimName)
end


function PvpFingerGuessingDialog:DoTakeGuessResult_(data)
    self:ClearTimeoutCountdown_()

    -- update result
    local isFinalWin  = checkInt(data.isWin) == 1
    local guessResult = checkInt(data.guessingResult)
    local resultText  = isFinalWin and localize('先手') or localize('后手')
    CfUtils.FillText(self.FinalResultShadowText, resultText)
    CfUtils.FillText(self.FinalResultText, resultText)
    
    -- update powerNum
    local myselfPowerNum = checkInt(data.selfCombatValue)
    local othersPowerNum = checkInt(data.opponentCombatValue)
    CfUtils.FillText(self.MyselfPowerText, tostring(myselfPowerNum))
    CfUtils.FillText(self.OthersPowerText, tostring(othersPowerNum))

    -- update orderImg
    CfUtils.SetUISwitchImage(self.FinalResultOrderImg, isFinalWin and 1 or 2)

    -- update myself / others guess result
    local RockIndex     = 1
    local ScissorsIndex = 2
    local PaperIndex    = 3
    local isRock        = self:GetSelectGuessType() == GuessType.ROCK
    local isScissors    = self:GetSelectGuessType() == GuessType.SCISSORS
    local isPaper       = self:GetSelectGuessType() == GuessType.PAPER
    local myselfIndex   = 0
    local othersIndex   = 0
    if isRock then
        myselfIndex = RockIndex
        othersIndex = guessResult == 1 and ScissorsIndex or guessResult == 2 and RockIndex or PaperIndex
    elseif isScissors then
        myselfIndex = ScissorsIndex
        othersIndex = guessResult == 1 and PaperIndex or guessResult == 2 and ScissorsIndex or RockIndex
    elseif isPaper then
        myselfIndex = PaperIndex
        othersIndex = guessResult == 1 and RockIndex or guessResult == 2 and PaperIndex or ScissorsIndex
    end
    CfUtils.SetUISwitchImage(self.MyselfGuessFingerImg, myselfIndex)
    CfUtils.SetUISwitchImage(self.MyselfGuessLetterImg, myselfIndex)
    CfUtils.SetUISwitchImage(self.MyselfGuessFinger2Img, myselfIndex)
    CfUtils.SetUISwitchImage(self.OthersGuessLetterImg, othersIndex)
    CfUtils.SetUISwitchImage(self.OthersGuessFingerImg, othersIndex)
    CfUtils.SetUISwitchImage(self.OthersGuessFinger2Img, othersIndex)

    if self.takeResultCb_ then
        self.takeResultCb_(guessResult, isFinalWin)
    end

    -------------------------------------------------
    -- do animation flow
    
    local animTime = 0
    if guessResult == 1 then  -- 猜拳-赢
        CfUtils.PlayAnimator(self.Root, 'Win')
        animTime = CfUtils.GetAnimatorTime(self.Root, 'FingerGuessDialogResultWin')
        
    elseif guessResult == 3 then  -- 猜拳-输
        CfUtils.PlayAnimator(self.Root, 'Lose')
        animTime = CfUtils.GetAnimatorTime(self.Root, 'FingerGuessDialogResultLose')

    elseif guessResult == 2 then  -- 猜拳-平
        if isFinalWin then
            CfUtils.PlayAnimator(self.Root, 'Draw_Win')
            animTime = CfUtils.GetAnimatorTime(self.Root, 'FingerGuessDialogResultDraw_Win')
        else
            CfUtils.PlayAnimator(self.Root, 'Draw_Lose')
            animTime = CfUtils.GetAnimatorTime(self.Root, 'FingerGuessDialogResultDraw_Lose')
        end
    end

    self.isGuessResult_ = true
    self.doAnimationCo_ = cs_coroutine.start(function()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(animTime))

        self.doAnimationCo_ = nil

        self.controller:Close()
    end)
end


function PvpFingerGuessingDialog:DoTakeGuessCancel_(data)
    self:ClearTimeoutCountdown_()
    
    if data.roomId == self.matchedRoomId_ then
        if self.takeCancelCb_ then
            self.takeCancelCb_()
        end

        self.controller:Close()
    end
end

function PvpFingerGuessingDialog:DoSendGuessResult_()
    AppService:GetInstance():SendTcpData(self.sendResultId_, {roomId = self.matchedRoomId_, guessing = self:GetSelectGuessType()})

    if self.sendResultCb_ then
        self.sendResultCb_(self:GetSelectGuessType())
    end

    CfUtils.DelCompoent(self.GuessNode1BtnNode, typeof(Animation))
    CfUtils.DelCompoent(self.GuessNode2BtnNode, typeof(Animation))
    CfUtils.DelCompoent(self.GuessNode3BtnNode, typeof(Animation))
    self.isControllable_ = false

    self:StartTimeoutCountdown_()
end


function PvpFingerGuessingDialog:DoSendGuessCancel_(isSilence)
    AppService:GetInstance():SendTcpData(self.sendCancelId_, {roomId = self.matchedRoomId_})

    if self.sendCancelCb_ then
        self.sendCancelCb_(isSilence)
    end

    self:ClearTimeoutCountdown_()

    self.controller:Close()
end


function PvpFingerGuessingDialog:StartTimeoutCountdown_()
    self:ClearTimeoutCountdown_()
    self.timeoutCdHandler_ = CDTimerModule:AddCD(1, function(countTimes, timerId)
        if countTimes <= 0 then
            self:DoSendGuessCancel_()
        end
    end, TakeResultTimeoutTime, true, true)
end


function PvpFingerGuessingDialog:ClearTimeoutCountdown_()
    if not isNull(self.timeoutCdHandler_) then
        CDTimerModule:RemoveCD(self.timeoutCdHandler_)
        self.timeoutCdHandler_ = nil
    end
end


-------------------------------------------------
-- handler

function PvpFingerGuessingDialog:OnClickGuessRockButtonHandler_()
    if not self.isControllable_ then return end
    self:SetSelectGuessType(GuessType.ROCK)
end


function PvpFingerGuessingDialog:OnClickGuessScissorsButtonHandler_()
    if not self.isControllable_ then return end
    self:SetSelectGuessType(GuessType.SCISSORS)
end


function PvpFingerGuessingDialog:OnClickGuessPaperButtonHandler_()
    if not self.isControllable_ then return end
    self:SetSelectGuessType(GuessType.PAPER)
end


function PvpFingerGuessingDialog:OnFingerGuessingFinishHandler_()
    -- check selectGuessType
    if not self:GetSelectGuessType() then
        local typeList  = table.values(GuessType)
        local guessType = typeList[math.random(1, #typeList)]
        self:SetSelectGuessType(guessType)
    end

    self:DoSendGuessResult_()
end


function PvpFingerGuessingDialog:OnFingerGuessingCancelHandler_()
    self:DoSendGuessCancel_(true)
end


function PvpFingerGuessingDialog:OnReceivePacketSuccessHandler_(packetId, data)
    if packetId == self.takeResultId_ then
        self:DoTakeGuessResult_(data)

    elseif packetId == self.takeCancelId_ then
        self:DoTakeGuessCancel_(data)
    end
end


return PvpFingerGuessingDialog

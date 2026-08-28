-- 跑酷主游戏 中断窗口, 显示三个按钮

--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourSuspendDialog12001801.prefab > name: OverseaParkourSuspendDialog12001801
---@class ParkourGameSuspendDialog
---@field Env                           	ParkourGameSuspendDialog                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnContinue                   	UnityEngine.RectTransform               	@ 0    
---@field BtnExit                       	UnityEngine.UI.Button                   	@ 1    
---@field BtnInstruction                	UnityEngine.RectTransform               	@ 2    
---@field Root_Suspend                  	UnityEngine.RectTransform               	@ 3    
---@field Root_PCTips                   	UnityEngine.RectTransform               	@ 4    
---@field Root_GameplayDes              	UnityEngine.RectTransform               	@ 5    
---@field EmptyClose                    	UnityEngine.RectTransform               	@ 6    
local ParkourGameSuspendDialog = Class("ParkourGameSuspendDialog")


---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local GameUtils = import('Game.Utils.GameUtils')

---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()

--- funtoy:
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Canvas = CS.UnityEngine.Canvas

-- ====================================

---@class ParkourGameSuspendDialog.InputData

function ParkourGameSuspendDialog:__init()
    self.controller = nil
    self.mode = ParkourGameUtil.SuspendDialogMode.SuspendPanel
    self.active = false
end

function ParkourGameSuspendDialog:__delete()
    self.controller = nil
end

function ParkourGameSuspendDialog:Init( mainDialog, exit )
    -- ==============================
    -- 绑定 Update() 函数:
    local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.UpdateAction = function(behaviourAction)
            self:Update()
        end
    end
    -- ================== self ================:

    self.mainDialog = mainDialog

    self.canvas = KTool.GetComponent(self.controller.gameObject, typeof(Canvas))
    self.canvas.enabled = true

    SetButtonAction(self.EmptyClose, function() 
        if self.mode == ParkourGameUtil.SuspendDialogMode.GamePlayDesc then 
            self:ToSuspendPanel()
        elseif self.mode == ParkourGameUtil.SuspendDialogMode.PCTipsPanel  then
            self.mainDialog:BackToMainDialog()
        end 
    end)

    -- 继续游戏
    SetButtonAction(self.BtnContinue, function()
        self.mainDialog:BackToMainDialog()
    end)

    -- 退出关卡
    SetButtonAction(self.BtnExit, function()
        GameUtils.ShowBlackOverlay(nil,function()
            exit()

            self.canvas.enabled = false
            ---
            --cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.2 )) -- 先等待下
            while (Mgr.isMainlineDialogFocus==true and Mgr.isParkourDialogFocus==false) == false do 
                coroutine.yield(Yielders.EndOfFrame)
            end 
            -- while Mgr.isCallParkourGradeReachEnd ~= true  do 
            --     coroutine.yield(Yielders.EndOfFrame)
            -- end
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 1 ))
        end)
    end)

    -- 查看游戏说明
    SetButtonAction(self.BtnInstruction, function() 
        self.mainDialog.pause = true
        self:Show( ParkourGameUtil.SuspendDialogMode.GamePlayDesc )
        self.mainDialog.gameRunner:PauseGame()
    end)
end



function ParkourGameSuspendDialog:Update()
    if self.active == true and (Input.GetKeyDown(KeyCode.P) or Input.GetKeyDown(KeyCode.Escape)) then 
        if self.mode == ParkourGameUtil.SuspendDialogMode.PCTipsPanel  then 
            self.mainDialog:BackToMainDialog()
        elseif self.mode == ParkourGameUtil.SuspendDialogMode.SuspendPanel  then
            self.mainDialog:BackToMainDialog()
        elseif self.mode == ParkourGameUtil.SuspendDialogMode.GamePlayDesc  then
            self:ToSuspendPanel()
        end
    end 
end



function ParkourGameSuspendDialog:Show( mode_ )
    assert( mode_==ParkourGameUtil.SuspendDialogMode.SuspendPanel or mode_ == ParkourGameUtil.SuspendDialogMode.PCTipsPanel or mode_ == ParkourGameUtil.SuspendDialogMode.GamePlayDesc )
    self.mode = mode_
    self.active = true
    CfUtils.SetActive(self.controller.gameObject, true)
    CfUtils.SetActive( self.Root_Suspend.gameObject,  mode_ == ParkourGameUtil.SuspendDialogMode.SuspendPanel )
    CfUtils.SetActive( self.Root_PCTips.gameObject, mode_ == ParkourGameUtil.SuspendDialogMode.PCTipsPanel )
    CfUtils.SetActive( self.Root_GameplayDes.gameObject, mode_ == ParkourGameUtil.SuspendDialogMode.GamePlayDesc )
end


function ParkourGameSuspendDialog:Hide()
    self.active = false
    CfUtils.SetActive(self.controller.gameObject, false)
end




function ParkourGameSuspendDialog:ToSuspendPanel()
    self.active = true
    self.mode = ParkourGameUtil.SuspendDialogMode.SuspendPanel
    CfUtils.SetActive(self.controller.gameObject, true)
    CfUtils.SetActive( self.Root_Suspend.gameObject,  true )
    CfUtils.SetActive( self.Root_PCTips.gameObject, false )
    CfUtils.SetActive( self.Root_GameplayDes.gameObject, false )
end


function ParkourGameSuspendDialog:ToPCTipsPanel()
    self.active = true
    self.mode = ParkourGameUtil.SuspendDialogMode.PCTipsPanel
    CfUtils.SetActive(self.controller.gameObject, true)
    CfUtils.SetActive( self.Root_Suspend.gameObject,  false )
    CfUtils.SetActive( self.Root_PCTips.gameObject, true )
    CfUtils.SetActive( self.Root_GameplayDes.gameObject, false )
end

function ParkourGameSuspendDialog:ToGamePlayPanel()
    self.active = true
    self.mode = ParkourGameUtil.SuspendDialogMode.GamePlayDesc
    CfUtils.SetActive(self.controller.gameObject, true)
    CfUtils.SetActive( self.Root_Suspend.gameObject,  false )
    CfUtils.SetActive( self.Root_PCTips.gameObject, false )
    CfUtils.SetActive( self.Root_GameplayDes.gameObject, true )
end






return ParkourGameSuspendDialog
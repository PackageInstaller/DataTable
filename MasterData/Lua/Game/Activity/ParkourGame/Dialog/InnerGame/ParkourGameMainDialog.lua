---@type ParkourGameMgr
local Mgr = import("Game.Activity.ParkourGame.ParkourGameMgr"):GetInstance()
---@type ParkourGameUtil
local ParkourGameUtil = import("Game.Activity.ParkourGame.ParkourGameUtil")

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

local Mathf = CS.UnityEngine.Mathf
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Time = CS.UnityEngine.Time
local Application = CS.UnityEngine.Application
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local KTool = CS.Engine.Lib.KTool

local Parkour_Loader = import('Game.Activity.ParkourGame.Parkour_Loader')

---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule

local BehaviourAction = CS.Engine.Lib.BehaviourAction
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local UIEventProxy = CS.Engine.UI.UIEventProxy
---@type Engine.Modules.CDTimerModule
local CDTimerModule = CS.Engine.Modules.CDTimerModule.GetInstance()
---@type ParkourInput
local parkourInput = import("Game.Activity.ParkourGame.MainGame.ParkourInput"):GetInstance()


local Physics = CS.UnityEngine.Physics
local LayerMask = CS.UnityEngine.LayerMask
local defaultLayer = LayerMask.NameToLayer("Default")
local roleLayer = LayerMask.NameToLayer("role")
local bulletLayer = LayerMask.NameToLayer("Layer_31")

local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

local GameUtils = import('Game.Utils.GameUtils')


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourMainDialog12001801.prefab > name: OverseaParkourMainDialog12001801
---@class ParkourGameMainDialog
---@field Env                           	ParkourGameMainDialog                   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnRun                        	UnityEngine.RectTransform               	@ 0    左下按钮, 滑铲
---@field UIFX_ClickGlow                	UnityEngine.RectTransform               	@ 1    run 按钮 单击特效
---@field UIFX_ClickLoopGlow            	UnityEngine.RectTransform               	@ 2    run 按钮 持续按下特效
---@field BtnSkill                      	UnityEngine.RectTransform               	@ 3    左下2按钮, 隐身
---@field Progress                      	UnityEngine.RectTransform               	@ 4    
---@field ProgressSlider                	UnityEngine.UI.Slider                   	@ 5    
---@field BtnJump                       	UnityEngine.RectTransform               	@ 6    
---@field Jump_UIFX_ClickGlow           	UnityEngine.RectTransform               	@ 7    jump 按钮 单击特效
---@field Jump_UIFX_ClickLoopGlow       	UnityEngine.RectTransform               	@ 8    jump 按钮 持续按下特效
---@field CatLifeDisplay                	UnityEngine.RectTransform               	@ 9    
---@field MonsterEyesLose               	UnityEngine.RectTransform               	@ 10   
---@field MonsterEyesCountdown          	UnityEngine.RectTransform               	@ 11   
---@field TextTime_MonsterCountdown     	UnityEngine.RectTransform               	@ 12   
---@field MonsterNextCome               	UnityEngine.RectTransform               	@ 13   下一次八哥来袭
---@field TextTime_MonsterNextCome      	UnityEngine.RectTransform               	@ 14   
---@field BtnSuspend                    	UnityEngine.RectTransform               	@ 15   
---@field TextScore                     	UnityEngine.RectTransform               	@ 16   活动货币 数量
---@field EndlessMode                   	UnityEngine.RectTransform               	@ 17   
---@field TextScore_EndlessMode         	UnityEngine.RectTransform               	@ 18   
---@field MonsterComeRemind             	UnityEngine.RectTransform               	@ 19   
---@field MonsterLeaveRemind            	UnityEngine.RectTransform               	@ 20   
---@field DestinationRemind             	UnityEngine.RectTransform               	@ 21   "抵挡终点"
---@field PCBtn                         	UnityEngine.RectTransform               	@ 22   pc 按键提示
---@field ImgGoodsIcon                  	UnityEngine.RectTransform               	@ 23   活动货币 图标
local ParkourGameMainDialog = Class("ParkourGameMainDialog")



---@class ParkourGameMainDialog.InputData
---@field levelId number
---@field gameType number

function ParkourGameMainDialog:__init()
    self.controller = nil
    self.isInit = false
end

function ParkourGameMainDialog:__delete()
    CoStop(self.co_1)
    CoStop(self.co_2)
    self.controller = nil
end


function ParkourGameMainDialog:Awake()
    SetButtonAction(self.BtnSuspend, Bind(self, self.PauseGame))
    self.isInit = false

    UIEventProxy.Create(self.BtnJump.gameObject).onPointerDown = function()
        --printError("jump")
        if self.gameRunner:IsStartGame() ~= true then 
            print("尚未开始跑酷, 点击无效")
            return
        end 
        parkourInput.jumpEvent = 1
        ---
        CoStop(self.co_1)
        self.co_1 = ParkourGameUtil.HandleBtnUIFXClick( self.Jump_UIFX_ClickGlow.gameObject, 2 )
    end

    UIEventProxy.Create(self.BtnJump.gameObject).onPointerUp = function()
        parkourInput.jumpEvent = 3
    end
    
    UIEventProxy.Create(self.BtnRun.gameObject).onPointerDown = function()
        --printError("run down")
        if self.gameRunner:IsStartGame() ~= true then 
            print("点击无效")
            return
        end 
        parkourInput.slideEvent = 1
        CfUtils.SetActive(self.UIFX_ClickLoopGlow,true)
        CoStop(self.co_2)
        self.co_2 = ParkourGameUtil.HandleBtnUIFXClick( self.UIFX_ClickGlow.gameObject, 2 )
    end
    UIEventProxy.Create(self.BtnRun.gameObject).onPointerUp = function()
        --printError("run up")
        parkourInput.slideEvent = 3
        CfUtils.SetActive(self.UIFX_ClickLoopGlow,false)
    end
    
    local behaviourAction = CfUtils.GetOrAddComponent(self.controller,typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.UpdateAction = Bind(self,self.Update)
    end
    ---
end


function ParkourGameMainDialog:RegisterGameEvent()
    self.events = CfUtils.EventsDecorated({
        --[ParkourGameUtil.Events.PlayerTakeDamage] = Bind(self, self.PlayerTakeDamageHandler),
        --[ParkourGameUtil.Events.BossTakeDamage]        = Bind(self, self.BossTakeDamageHandler),
        [ParkourGameUtil.Events.BossCountDownStart]     = Bind(self, self.BossCountDownStartHandler),
        [ParkourGameUtil.Events.BossCountDownPause]     = Bind(self, self.BossCountDownPauseHandler),
        [ParkourGameUtil.Events.BossCome]               = Bind(self, self.BossComeHandler),
        [ParkourGameUtil.Events.BossLeave]              = Bind(self, self.BossLeaveHandler),
        [ParkourGameUtil.Events.GameSuccessShowPanel]   = Bind(self, self.GameSuccessShowPanelHandler),
        [ParkourGameUtil.Events.GameSuccess]            = Bind(self, self.GameSuccessHandler),
        [ParkourGameUtil.Events.RoleDead]               = Bind(self, self.RoleDeadHandler),
    })
end


function ParkourGameMainDialog:_InitPhysics()
    --添加碰撞
    self.isLayerIgnore_Role_Default = ParkourGameUtil.SetLayerCollision( roleLayer, defaultLayer, true )
    self.isLayerIgnore_D_D          = ParkourGameUtil.SetLayerCollision( defaultLayer, defaultLayer, false )
    self.isLayerIgnore_Bullet_Role  = ParkourGameUtil.SetLayerCollision( bulletLayer, roleLayer, true )
    self.isLayerIgnore_Bullet_D     = ParkourGameUtil.SetLayerCollision( bulletLayer, defaultLayer, true )
    Physics.autoSimulation = true
end



function ParkourGameMainDialog:_InitForNormalType()

    
    -- 主线跑酷 进入游戏
    local isSuccess = false 
    GameUtils.Request("activityTinyWorld/parkourAt", { activityUuid = Mgr.activityUuid, questId = self.inData.levelId }, function(request, response)
        if checkNumber(response.errCode) == 0 then
            --local data = checkTable(response.data)
            isSuccess = true
        end
    end)
    ---
    while isSuccess == false do
        coroutine.yield(Yielders.EndOfFrame)
    end
    -- =================================
    self:_InitPhysics()
    local parkour_Loader = Parkour_Loader.GetInstance()

    local mainlineVO = ParkourGameUtil.GetMiniWorldParkourLevelVo( self.inData.levelId ) -- 主线关卡表

    self.testGo = parkour_Loader:TryInstanceGO("gameTest")
    if isNotNull(self.testGo) then 
        -- 
        local PlayerRootTF = self.testGo.transform:Find("Track3/PlayerRoot")
        local roleTF, roleEnv = parkour_Loader:InstanceRole( PlayerRootTF )
        roleEnv:Init()
        Mgr.player = roleEnv
        self.player = roleEnv
    
        ---@type ParkourGameRunner
        self.gameRunner = CfUtils.GetLuaScr(self.testGo, "Game.Activity.ParkourGame.MainGame.ParkourGameRunner")
        Mgr.gameRunner = self.gameRunner
        Mgr.gameRunner:InitForNormal( self.inData.gameType, mainlineVO.prefabId )
    end 
    
    

end


function ParkourGameMainDialog:_InitForInfiniteType()

    -- 无尽跑酷 进入游戏
    

    local isSuccess = false 
    GameUtils.Request("activityTinyWorld/freeParkourAt", { activityUuid = Mgr.activityUuid }, function(request, response)
        if checkNumber(response.errCode) == 0 then
            --local data = checkTable(response.data)
            isSuccess = true
        end
    end)
    ---
    while isSuccess == false do
        coroutine.yield(Yielders.EndOfFrame)
    end

    
    

    -- =================================
    self:_InitPhysics()
    local parkour_Loader = Parkour_Loader.GetInstance()

    self.testGo = parkour_Loader:TryInstanceGO("gameTest")
    if isNotNull(self.testGo) then 
        -- 
        local PlayerRootTF = self.testGo.transform:Find("Track3/PlayerRoot")
        local roleTF, roleEnv = parkour_Loader:InstanceRole( PlayerRootTF )
        roleEnv:Init()
        Mgr.player = roleEnv
        self.player = roleEnv
    
        ---@type ParkourGameRunner
        self.gameRunner = CfUtils.GetLuaScr(self.testGo, "Game.Activity.ParkourGame.MainGame.ParkourGameRunner")
        Mgr.gameRunner = self.gameRunner
        Mgr.gameRunner:InitForInfinity( self.inData.gameType, self.inData.mapVos )

    end 
end



function ParkourGameMainDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        ---@type ParkourGameMainDialog.InputData
        self.inData = self.controller.Argument.parameters

        -- ====
        CfUtils.SetActive( self.ProgressSlider.gameObject, self.inData.gameType == ParkourGameUtil.GameType.Normal )

        -- ==========================
        Mgr:ClearScores()
        CriWareUtils.StopAll()
        CriWareUtils.PlayMusic("Audio/bgm_miniworld_parkour", "fight_story_activity_12001801" )


        -- =======================
        if self.inData.gameType == ParkourGameUtil.GameType.Normal then 
            cs_coroutine.yield_return(self:_InitForNormalType())
        else 
            cs_coroutine.yield_return(self:_InitForInfiniteType())
        end 

        --- ========================
        ---@type ParkourGameHp
        self.playerHp = CfUtils.GetLuaScr(self.CatLifeDisplay, "Game.Activity.ParkourGame.Dialog.InnerGame.ParkourGameHp")
        ---@type ParkourGameHp
        self.bossHp = CfUtils.GetLuaScr(self.MonsterEyesLose, "Game.Activity.ParkourGame.Dialog.InnerGame.ParkourGameHp")
        ---
        self.playerHp:RefreshData({
            hpName = "role",
            maxHp = checkInt(Mgr.player.health), 
            hp = checkInt(Mgr.player.health),
            loseHpEventName = ParkourGameUtil.Events.PlayerTakeDamage, 
            animationName = "OverseaParkourMainDialog_CatLifeDisplay_DeadGlow"})
        ---
        self.bossHp:RefreshData({
            hpName = "boss",
            maxHp =checkInt(Mgr.boss.health), 
            hp = checkInt(Mgr.boss.health),
            loseHpEventName = ParkourGameUtil.Events.BossTakeDamage, 
            animationName = "OverseaParkourMainDialog_DisplayNode_DeadGow"})

        self:RegisterGameEvent()
        self:RefreshUI()

        Mgr.isMainDialogInitDone = true

        self.isInit = true

    end))
    return coWait
end


function ParkourGameMainDialog:OnFinalize()

    CriWareUtils.StopAll()
    CriWareUtils.PlayMusic("Audio/bgm_instance_tinyworld", "bgm_story_activity_120001801" )

    ParkourGameUtil.SetLayerCollision( roleLayer, defaultLayer, not self.isLayerIgnore_Role_Default )
    ParkourGameUtil.SetLayerCollision( defaultLayer, defaultLayer, not self.isLayerIgnore_D_D )
    ParkourGameUtil.SetLayerCollision( bulletLayer, roleLayer, not self.isLayerIgnore_Bullet_Role )
    ParkourGameUtil.SetLayerCollision( bulletLayer, defaultLayer, not self.isLayerIgnore_Bullet_D )
    Physics.autoSimulation = false

    CfUtils.EventsUndecorated(self.events)
    GameObject.Destroy(self.testGo)
    self:Delete()
end



function ParkourGameMainDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --printError("---2---")
        if Mgr.isBackFromMainDialogForResume == true then 
            Mgr.isBackFromMainDialogForResume = false 
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.3 ))
            GameUtils.HideBlack( 1 ) ------------------------- 黑幕淡出 ---------------------------------
        end


        if Mgr.isBackFromMainDialogForResumeForInfinity == true then 
            Mgr.isBackFromMainDialogForResumeForInfinity = false 
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.3 ))
            GameUtils.HideBlack( 1 ) ------------------------- 黑幕淡出 ---------------------------------
        end

    end))
end



function ParkourGameMainDialog:OnFocus(focus)
    Mgr.isParkourDialogFocus = (focus==true)
end



function ParkourGameMainDialog:RefreshUI()
    --CfUtils.SetActive(self.MonsterNextCome, false) -- "下次八哥来袭" 不再显示
    CfUtils.SetActive(self.DestinationRemind, false)
    CfUtils.SetActive(self.PCBtn.gameObject, KTool.IsMobile() == false )
    --- 活动货币 icon
    local activityGoodsIconPath = ParkourGameUtil.GetActivityGoodsVO().icon
    CfUtils.FillImage( self.ImgGoodsIcon.gameObject, activityGoodsIconPath )

    
    ---@type ParkourGameInvisibleSkill
    self.invisibleSkill = CfUtils.GetLuaScr(self.BtnSkill, "Game.Activity.ParkourGame.Dialog.InnerGame.ParkourGameInvisibleSkill")
    self.invisibleSkill:RefreshData({energy = 0})
end

function ParkourGameMainDialog:Update()
    if self.isInit == false then 
        return
    end     

    -- if self:_GetSuspendDialog().active == true and self:_GetSuspendDialog().mode == ParkourGameUtil.SuspendDialogMode.PCTipsPanel then 
    --     if Input.GetKeyDown(KeyCode.P) then 
    --         self:BackToMainDialog()
    --     end
    -- end 

    -- ======================================================
    if self.pause then
        return
    end

    if Input.GetKeyDown(KeyCode.Escape) then 
        self:PauseGame()
    elseif Input.GetKeyDown(KeyCode.P) then 
        self:_ShowPCTips()
    end 

    --- 显示 活动货币数量 
    local activityGoodsNum = Mgr:GetActivityGoodsNum()
    CfUtils.FillText( self.TextScore.gameObject, tostring(activityGoodsNum) )

    if Mgr.boss.showState == ParkourGameUtil.BossShowState.CountDown then 
        CfUtils.FillText(self.TextTime_MonsterCountdown,  Mathf.Floor(Mathf.Max(0,Mgr.boss.appearTimer)) )
        CfUtils.FillText(self.TextTime_MonsterNextCome,  Mathf.Floor(Mathf.Max(0,Mgr.boss.appearTimer)) )

    elseif Mgr.boss.showState == ParkourGameUtil.BossShowState.Show then 
        CfUtils.FillText(self.TextTime_MonsterCountdown,  Mathf.Floor(Mathf.Max(0,Mgr.boss.attackTimer)) )
        CfUtils.FillText(self.TextTime_MonsterNextCome,  Mathf.Floor(Mathf.Max(0,Mgr.boss.attackTimer)) )
    end 

    if self.inData.gameType == ParkourGameUtil.GameType.Normal then 
        self.ProgressSlider.value = Mgr.gameRunner:Progress()
    end

    self.invisibleSkill:Update()
end

-- ============================================================

function ParkourGameMainDialog:_GetSuspendDialog()
    if isNull(self.suspendDialog) then
        local suspendDialogGO = Parkour_Loader.GetInstance():TryInstanceGO("suspendDialog")
        assert( isNotNull(suspendDialogGO) )
        ParkourGameUtil.SetUIParent( suspendDialogGO.transform, self.controller.transform ) -- 这个 go 会跟着 parent 一起被销毁, 所以不用管它
        ---@type ParkourGameSuspendDialog
        self.suspendDialog = CfUtils.GetLuaScr(suspendDialogGO, "Game.Activity.ParkourGame.Dialog.InnerGame.ParkourGameSuspendDialog")
        self.suspendDialog:Init(self, Bind(self, self._InterruptGame) )
    end
    return self.suspendDialog
end



function ParkourGameMainDialog:PauseGame()
    if self.gameRunner:IsStartGame() ~= true then 
        print("尚未开始跑酷, 点击无效")
        return
    end 
    self.pause = true
    self:_GetSuspendDialog():Show( ParkourGameUtil.SuspendDialogMode.SuspendPanel )
    --self:_ShowInstruction()
    Mgr.gameRunner:PauseGame()
end



function ParkourGameMainDialog:_ShowPCTips()
    if self.gameRunner:IsStartGame() ~= true then 
        print("尚未开始跑酷, 点击无效")
        return
    end 
    self.pause = true
    self:_GetSuspendDialog():Show( ParkourGameUtil.SuspendDialogMode.PCTipsPanel )
    Mgr.gameRunner:PauseGame()
end



-- 从某个 suspend dialog 回到本页面
function ParkourGameMainDialog:BackToMainDialog()
    self.pause = false
    self:_GetSuspendDialog():Hide()
    self.gameRunner:ResumeGame()
end


-- 调用后端结算
function ParkourGameMainDialog:_GradeGame( isPassed_, endCB_ )
    local isPassed = (isPassed_ == true and 1 or 0)

    if self.inData.gameType == ParkourGameUtil.GameType.Infinite then 
        printError("异常.... GradeGame")
        return
    end 

    if isPassed_ then 
        local mainlineVO = ParkourGameUtil.GetMiniWorldParkourLevelVo( self.inData.levelId ) -- 主线关卡表
        -- 成功时消耗的道具:
        GoodsUtils.ConsumeGoods({
            { goodsId = checkInt(mainlineVO.costItem), num = checkInt(mainlineVO.costNum) }
        }, false)
    end

    Mgr:SumUpScores()
    --printError(" 统计得分: " .. table.dump( Mgr.scores ))
    GameUtils.Request("activityTinyWorld/parkourGrade", { activityUuid = Mgr.activityUuid, isPassed = isPassed, questData = table.serialize(Mgr.scores) }, function(request, response)
        local responseData = nil
        if checkNumber(response.errCode) == 0 then
            responseData = checkTable(response.data)
            Mgr.homeDojo.mainQuestId = responseData.newMainQuestId
        end
        --
        if type(endCB_) == "function" and isNotNull(endCB_) then 
            endCB_( responseData ) 
        end 
    end)
end



-- 调用后端结算 (无限模式)
function ParkourGameMainDialog:_GradeGameForInfinity( endCB_ )

    -- !!!!!!!!!!! doing

    Mgr:SumUpScores()
    --printError(" 统计得分: " .. table.dump( Mgr.scores ))
    GameUtils.Request("activityTinyWorld/freeParkourGrade", { activityUuid = Mgr.activityUuid, isPassed = false, questData = table.serialize(Mgr.scores) }, function(request, response)
        local responseData = nil
        if checkNumber(response.errCode) == 0 then
            responseData = checkTable(response.data)
            Mgr.homeDojo.mainQuestId = responseData.newMainQuestId
        end
        --
        if type(endCB_) == "function" and isNotNull(endCB_) then 
            endCB_( responseData ) 
        end 
    end)
end



-- 中断然后离开关卡, 挑战失败, 不会结算到奖励
function ParkourGameMainDialog:_InterruptGame()

    Mgr.isCallParkourGradeReachEnd = false

    if self.inData.gameType == ParkourGameUtil.GameType.Normal then 
        self:_GradeGame( false, function()
            Mgr.isCallParkourGradeReachEnd = true
            CfUtils.DialogBack()
        end)
    else 
        self:_GradeGameForInfinity( function()
            Mgr.isCallParkourGradeReachEnd = true
            CfUtils.DialogBack()
        end)
    end 
end



-- 死亡or胜利导致的离开:
function ParkourGameMainDialog:_ExitGame()
    --printError("_ExitGame")
    CfUtils.DialogBack()
end



function ParkourGameMainDialog:_ReStartGame()
    
    if self.inData.gameType == ParkourGameUtil.GameType.Normal then 

        local mainlineVO = ParkourGameUtil.GetMiniWorldParkourLevelVo( self.inData.levelId ) -- 主线关卡表
        if ParkourGameUtil.IsHaveEnoughGoods( mainlineVO.costItem, mainlineVO.costNum ) == false then  
            printError("kkk")
            return
        end 

        GameUtils.ShowBlack( 0 )  ------------------------ 黑幕淡入 ----------------------------------
        Mgr.isBackFromMainDialogForResume = true
        CfUtils.DialogBack()

    else 
        -- !! 判断是否还能进入 无限挑战, 未实现... 

        GameUtils.ShowBlack( 0 )  ------------------------ 黑幕淡入 ----------------------------------
        Mgr.isBackFromMainDialogForResumeForInfinity = true
        CfUtils.DialogBack()
    end 
end



function ParkourGameMainDialog:BossCountDownStartHandler(duration)
    CfUtils.SetActive(self.MonsterEyesCountdown,false)
    CfUtils.SetActive(self.MonsterNextCome, true)
end

--倒计时暂停
function ParkourGameMainDialog:BossCountDownPauseHandler()
    CfUtils.SetActive(self.MonsterNextCome,false)
    CfUtils.SetActive(self.MonsterEyesCountdown, true)
    --CfUtils.FillText(self.TextTime_MonsterCountdown,Mathf.Floor(Mgr.boss.appearTimer))
end

function ParkourGameMainDialog:BossComeHandler()
    CfUtils.SetActive(self.MonsterLeaveRemind, false)
    CfUtils.SetActive(self.MonsterComeRemind, true)
    CfUtils.SetActive(self.MonsterNextCome,false)
    CfUtils.SetActive(self.MonsterEyesLose, true)
    self.bossHp:SetHp(Mgr.boss.health)
end

function ParkourGameMainDialog:BossLeaveHandler()
    CfUtils.SetActive(self.MonsterComeRemind, false)
    CfUtils.SetActive(self.MonsterEyesLose, false)
    CfUtils.SetActive(self.MonsterLeaveRemind, true)
end


-- ============================================================


function ParkourGameMainDialog:GameSuccessShowPanelHandler()
    CfUtils.SetActive(self.DestinationRemind, true)
    self.pause = true
    Mgr.gameRunner:PauseGame()
end


function ParkourGameMainDialog:GameSuccessHandler()
    self:_GradeGame( true, function( responseData_ )
        self:_ShowNormalFinishDialog( responseData_ )
    end)
end


function ParkourGameMainDialog:RoleDeadHandler()
    self.pause = true
    Mgr.gameRunner:PauseGame()


    if self.inData.gameType == ParkourGameUtil.GameType.Normal then 
        self:_GradeGame( false, function( responseData_ )
            self:_ShowNormalFinishDialog( responseData_ )
        end)

    else 
        --printError("施工中 ... RoleDeadHandler")
        self:_GradeGameForInfinity( function( responseData_ )
            self:_ShowInfinityFinishDialog( responseData_ )
        end)
    end    
end




function ParkourGameMainDialog:_ShowNormalFinishDialog( responseData_ )
    if isNull(self.normalFinishDialog) then
        self.normalFinishDialogGO = Parkour_Loader.GetInstance():TryInstanceGO("normalFinishDialog")
        if isNotNull(self.normalFinishDialogGO) then 
            ParkourGameUtil.SetUIParent( self.normalFinishDialogGO.transform, self.controller.transform ) -- 这个 go 会跟着 parent 一起被销毁, 所以不用管它
            ---@type ParkourGameNormalFinishDialog
            self.normalFinishDialog = CfUtils.GetLuaScr(self.normalFinishDialogGO, "Game.Activity.ParkourGame.Dialog.InnerGame.ParkourGameNormalFinishDialog")
            self.normalFinishDialog:Init( Bind(self, self._ReStartGame), Bind(self, self._ExitGame), responseData_ )
            self.normalFinishDialog:Show()
        end 
    else
        printError("异常, 不该来这")
        self.normalFinishDialog:Show()
    end
end



function ParkourGameMainDialog:_ShowInfinityFinishDialog( responseData_ )

    if isNull(self.infiniteFinishDialog) then
        self.infiniteFinishDialogGO = Parkour_Loader.GetInstance():TryInstanceGO("infiniteFinishDialog")
        if isNotNull(self.infiniteFinishDialogGO) then 
            ParkourGameUtil.SetUIParent( self.infiniteFinishDialogGO.transform, self.controller.transform ) -- 这个 go 会跟着 parent 一起被销毁, 所以不用管它
            ---@type ParkourGameInfiniteFinishDialog
            self.infiniteFinishDialog = CfUtils.GetLuaScr(self.infiniteFinishDialogGO, "Game.Activity.ParkourGame.Dialog.InnerGame.ParkourGameInfiniteFinishDialog")

            self.infiniteFinishDialog:Init( Bind(self, self._ReStartGame), Bind(self, self._ExitGame), responseData_ )
            
            self.infiniteFinishDialog:Show()
        end 
    else
        printError("异常, 不该来这")
        self.infiniteFinishDialog:Show()
    end
end





return ParkourGameMainDialog
---
--- Created by zou hanjie.
--- DateTime: 2023-10-21 18:02:11
---
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = import('XLua.cs_coroutine')
local Yielders = CS.Engine.Lib.Yielders -- 协程

local UIModule = CS.Engine.UI.UIModule

local IdolLive3D_TalkNode = 'Game.IdolLive3D.Tools.IdolLive3D_TalkNode'
                                                 

--- from: Assets/BundleResources/Prefabs/IdolLive3D_MainUI_V2.prefab > name: IdolLive3D_MainUI_V2
---@class IdolLive3D_UIMainV2
---@field Env                           	IdolLive3D_UIMainV2                     
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnHdMode                     	UnityEngine.UI.Button                   	@ 0    切换画质按钮
---@field 3DTouchDetails                	UnityEngine.RectTransform               	@ 1    动作 成就列表
---@field BtnInteraction                	UnityEngine.RectTransform               	@ 2    右上角, 互动总按钮
---@field Root                          	UnityEngine.RectTransform               	@ 3    
---@field Container                     	UnityEngine.RectTransform               	@ 4    
---@field TalkNode                      	UnityEngine.RectTransform               	@ 5    对话 字幕
---@field BtnHide                       	UnityEngine.RectTransform               	@ 6    隐藏 ui 按钮
---@field Interaction                   	UnityEngine.RectTransform               	@ 7    qte 对战功能
---@field Touch                         	UnityEngine.RectTransform               	@ 8    中节点, 内涵多个按钮
---@field whitePanel                    	UnityEngine.RectTransform               	@ 9    白色全屏面片, 用来修复 特效过场 无法遮盖场景物体的问题
---@field Hand                          	UnityEngine.RectTransform               	@ 10   手部 ui
---@field JumpBtn_Pos                   	UnityEngine.RectTransform               	@ 11   stageJump btn pos
---@field JumpBtn_Cam                   	UnityEngine.RectTransform               	@ 12   stageJump btn cam
---@field switch2                       	UnityEngine.RectTransform               	@ 13   JumpBtn_1, JumpBtn_2 的父级
---@field IKHand                        	UnityEngine.RectTransform               	@ 14   
---@field RightBtns                     	UnityEngine.RectTransform               	@ 15   右侧按钮栏
local IdolLive3D_UIMainV2 = Class("IdolLive3D_UIMainV2")
-- ==================================


local Image = CS.UnityEngine.UI.Image
local Color = CS.UnityEngine.Color
local Transform = CS.UnityEngine.Transform
local Time = CS.UnityEngine.Time
local CanvasGroup = CS.UnityEngine.CanvasGroup
local Animation = CS.UnityEngine.Animation
local Mathf = CS.UnityEngine.Mathf
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode

local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local CinemachineBlendDefinition = CS.Cinemachine.CinemachineBlendDefinition
local GameUtils = import('Game.Utils.GameUtils')

local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

local IdolLive3D_Loader = import('Game.IdolLive3D.IdolLive3D_Loader')

local IdolLive3D_Utils = import('Game.IdolLive3D.IdolLive3D_Utils')

---@type IdolLive3D_GraphicSetting
local IdolLive3D_GraphicSetting = import('Game.IdolLive3D.IdolLive3D_GraphicSetting')

---@type IdolLive3D_States
local IdolLive3D_States = import('Game.IdolLive3D.IdolLive3D_States')
local InteractiveStateType = IdolLive3D_States.InteractiveStateType
local NodeShowType = IdolLive3D_States.NodeShowType

local IdolLive3D_UISmoothShowEnt = import('Game.IdolLive3D.IdolLive3D_UISmoothShowEnt')

local IdolLive3D_UITouchTips = import('Game.IdolLive3D.IdolLive3D_UITouchTips')

---@type IdolLive3D_UIHand
local IdolLive3D_UIHand = import('Game.IdolLive3D.IdolLive3D_UIHand')

---@type IdolLive3D_UIQTE
local IdolLive3D_UIQTE = import('Game.IdolLive3D.IdolLive3D_UIQTE')

---@type IdolLive3D_UISwitchV2
local IdolLive3D_UISwitchV2 = import('Game.IdolLive3D.V2.IdolLive3D_UISwitchV2')

---@type Live3D_UIKey
local Live3D_UIKey = import('Game.IdolLive3D.Interactive.Customs.Live3D_UIKey')

---@type IdolLive3D_UIIKHande
local IdolLive3D_UIIKHande = import('Game.IdolLive3D.V2.IdolLive3D_UIIKHande')

---@type IdolLive3D_UIRightBtnsPanel
local IdolLive3D_UIRightBtnsPanel = import('Game.IdolLive3D.V2.IdolLive3D_UIRightBtnsPanel')

------------------------------------- 

local animationName_HighOpen   = "IdolLive3D_MainUI_High_Open"
local animationName_HighClosed = "IdolLive3D_MainUI_High_Closed"
local animationName_ButtonPressed = "UI_Common_ButtonPressed"


---
local Touch_fadeInTime = 0.8
local Touch_fadeOutTime = 0.1

local saveDeepTimes = "OverseaCard/saveDeepTimes"


-- ==================================
function IdolLive3D_UIMainV2:__init()
    self.isGraphicHD = false -- 画质高低档
    self.cardSkinId = nil

    self.isPlayingTimelineOrIdleSwitch = false 
    self.hideBtnShowState = true -- true:显示全部ui; false:隐藏所有ui
    self.isHideInteraction = true --- 是否隐藏 qte 对战系统:

    self.isIdle100To200 = true
    self.isInit = false
end

function IdolLive3D_UIMainV2:__delete()
    self.cardSkinId = nil
end

function IdolLive3D_UIMainV2:OnFocus(focus)
    if focus then
    else 
        ---@type IdolLive3D_Sounds
        local IdolLive3D_Sounds = import('Game.IdolLive3D.IdolLive3D_Sounds'):GetInstance()
        IdolLive3D_Sounds.StopAll()
    end
end

function IdolLive3D_UIMainV2:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    end))
    return coWait
end


function IdolLive3D_UIMainV2:Awake()
    self.EventNavigatorBack = Events.AddListener(Constants.EventNames.EventUINavigatorBackBar, Bind(self, self.OnNavigatorBack))

    self.EventNewInteractiveState  = Events.AddListener(IdolLive3D_States.EventNewInteractiveState, function(iState)
        self:_OnEventNewInteractiveState(iState)
    end)

    self.BtnHdModeAnimationTF = self.BtnHdMode.transform:Find("Animation")
    SetButtonAction(self.BtnHdMode, Bind(self, self.OnClickBtnHdMode))
end




function IdolLive3D_UIMainV2:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument = checkTable(self.controller.Argument.parameters)
        -- if not argument then
        --     return
        -- end
        -- ...
        self.cardSkinId = checkNumber(argument.skinId)
        self.isDemo = (argument.isDemo == true)

        ---@type IdolLive3D_BaseParamsJsonData
        self.baseJson = argument.baseJson
        assert( isNotNull(self.baseJson) )

        -- ==============================
        -- 绑定 Update() 函数:
        local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
        if behaviourAction then
            behaviourAction.UpdateAction = function(behaviourAction)
                self:Update()
            end
        end

        self.uiHandEnv = IdolLive3D_UIHand.New( self.Hand, false )
        self.uiQTEEnv = IdolLive3D_UIQTE.New( self.Interaction, false )

        self.lastUIMgr = nil 

        self:_InitTouchTips()

        --- switch 按钮: 
        self.uiSwitchBtnEnv = IdolLive3D_UISwitchV2.New( self, self.switch2, self.JumpBtn_Pos, self.JumpBtn_Cam ) 
        CfUtils.SetActive( self.switch2, true )

        ---
        self.uiRightBtnsPanel = IdolLive3D_UIRightBtnsPanel.New( self, self.RightBtns )


        self.ikHandEnv = IdolLive3D_UIIKHande.New(self, self.IKHand )


        self.smoothShow_Touch = IdolLive3D_UISmoothShowEnt.New( self.Touch.gameObject, true, false, false, 0.8, 3 )
        self.smoothShow_fullPanel = IdolLive3D_UISmoothShowEnt.New( self.whitePanel.gameObject, true, false, false, 1, 3 )

        ---
        self.EventShowUIFullPanel = Events.AddListener(IdolLive3D_States.EventShowUIFullPanel, function( isShow_, duration_, color_ )
            if isNotNull(color_) then 
                CfUtils.SetColor( self.whitePanel.gameObject, color_ )
            end
            self.smoothShow_fullPanel:SetShowOrHide( isShow_, duration_ )
        end)

        self.EventSetUIFullPanel = Events.AddListener(IdolLive3D_States.EventSetUIFullPanel, function( color_ )
            if isNotNull(color_) then 
                CfUtils.SetColor( self.whitePanel.gameObject, color_ )
            else 
                printError("IdolLive3D_States.EventSetUIFullPanel: 参数 color_ 为空")
            end
        end)


        --- 为了能让 IdolLive3D_MainForRuntime 拿到自己:
        self.EventGetUIMain = Events.AddListener(IdolLive3D_States.EventGetUIMain, function( retTable_ )
            retTable_.uiMain = self
        end)


        SetButtonAction(self.BtnHide, function()
            self.hideBtnShowState = not self.hideBtnShowState
            self:ShowOrHideAllUI()
            self.uiSwitchBtnEnv:Show( self.hideBtnShowState )
        end)

        
        self:ShowOrHideAllUI()

        self.idolLive3D_GraphicSetting = IdolLive3D_GraphicSetting.New()
        -- ---@type CardSkinVo
        -- local skinVo = CardConfMgr:GetInstance():GetCardSkinBySkinId(self.cardSkinId)
        ---@type IdolLive3D_TalkNode
        local env = CfUtils.GetLuaScr(self.TalkNode.gameObject, IdolLive3D_TalkNode)
        if env then
            env:Init(self.cardSkinId)
        end

        --- 
        IdolLive3D_States.isUIMainInited = true -- !!! Must
        self.isInit = true
    end))
    return coWait
end


function IdolLive3D_UIMainV2:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        print("!!!!!! 离开 idol !!!!!! ")

        -- 存档:
        GameUtils.Request( saveDeepTimes, {skinId = self.cardSkinId, times = tostring(self:_GetToucTipsDataString()) }, function(request, response)
        end)

        if isNotNull(self.uiHandEnv) then 
            self.uiHandEnv:Delete()
        end
        if isNotNull(self.ikHandEnv) then 
            self.ikHandEnv:Delete()
        end
        if isNotNull(self.uiQTEEnv) then 
            self.uiQTEEnv:Delete()
        end
        if isNotNull(self.uiRightBtnsPanel) then 
            self.uiRightBtnsPanel:Delete()
        end 
    
        if isNotNull(self.uiSwitchBtnEnv) then 
            self.uiSwitchBtnEnv:Delete()
        end

        if isNotNull(self.idolLive3D_UITouchTips) then 
            self.idolLive3D_UITouchTips:Delete()
        end 

        if isNotNull(self.idolLive3D_GraphicSetting) then 
            self.idolLive3D_GraphicSetting:Delete()
        end
        self.idolLive3D_GraphicSetting = nil

        if self.EventNavigatorBack then
            Events.RemoveListener(Constants.EventNames.EventUINavigatorBackBar, self.EventNavigatorBack)
        end

        if self.EventShowUIFullPanel then
            Events.RemoveListener(IdolLive3D_States.EventShowUIFullPanel, self.EventShowUIFullPanel)
        end

        if self.EventSetUIFullPanel then
            Events.RemoveListener(IdolLive3D_States.EventSetUIFullPanel, self.EventSetUIFullPanel)
        end

        if self.EventGetUIMain then
            Events.RemoveListener(IdolLive3D_States.EventGetUIMain, self.EventGetUIMain)
        end

        if self.EventNewInteractiveState then
            Events.RemoveListener(IdolLive3D_States.EventNewInteractiveState, self.EventNewInteractiveState)
            self.EventNewInteractiveState = nil
        end

        IdolLive3D_Loader.DeleteInstance()

        self.co = nil
        ---
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end



function IdolLive3D_UIMainV2:OnNavigatorBack()
    --printError("koko == 按下返回键 ")

    -- 下方的操作会导致场景中的 地面反射突然消失, 先播一个黑幕遮一遮:
    GameUtils.ShowBlackDuration(0, 0.2, 1)

    -- 先 强制关闭 爱豆3D场景的 PlanarReflections
    IdolLive3D_Utils.SetPlanarReflections( false )

    -- !!! Must; 先执行本处切换, 然后 vcam brain 瞬切到 主场景相机, 然后调用 本class OnFinalize(), 进而调用 IdolLive3D_Loader:ResetVCamBlendMode()
    IdolLive3D_Utils.SetVCamBlendMode( CinemachineBlendDefinition.Style.Cut, 0.0 ) 
end



function IdolLive3D_UIMainV2:Update()
    if self.isInit ~= true then 
        return
    end 

    local deltaTime = Time.deltaTime

    self.uiSwitchBtnEnv:SelfUpdate()
    self.smoothShow_Touch:SelfUpdate()
    self.smoothShow_fullPanel:SelfUpdate()

    --self.ikHandEnv:SetUpdate()
    
    if isNotNull(self.uiQTEEnv) then 
        self.uiQTEEnv:SelfUpdate(deltaTime)
    end
end


-- =======================================================================


function IdolLive3D_UIMainV2:_InitTouchTips()
    -- 读取配表 和 后端数据, 得知当前是否要显示 touchTips 功能     
    self.touchTipDatas = IdolLive3D_Utils.GetLive3DTouchTipsDojosBySkinId(self.cardSkinId)
    ---
    self.TouchTips = self.Touch.transform:Find("TouchTips")
    self.idolLive3D_UITouchTips = IdolLive3D_UITouchTips.New( self.TouchTips, self.BtnInteraction, self )
end



function IdolLive3D_UIMainV2:OnClickBtnHdMode()

    self.isGraphicHD = not self.isGraphicHD
    if self.isGraphicHD == true then

        if isNotNull(self.idolLive3D_GraphicSetting) then
            self.idolLive3D_GraphicSetting:TurnOn()
        end
        CfUtils.PlayAnimation( self.BtnHdModeAnimationTF, animationName_HighOpen )

        IdolLive3D_Utils.SetPlanarReflections( false )
        IdolLive3D_Utils.SetPlanarReflections( true )
    else 
        if isNotNull(self.idolLive3D_GraphicSetting) then 
            self.idolLive3D_GraphicSetting:TurnOff()
        end
        CfUtils.PlayAnimation( self.BtnHdModeAnimationTF, animationName_HighClosed )

        IdolLive3D_Utils.SetPlanarReflections( false )
        IdolLive3D_Utils.SetPlanarReflections( true )

    end 
    CfUtils.PlayAnimation( self.BtnHdMode, animationName_ButtonPressed )
end



-- 
function IdolLive3D_UIMainV2:ShowOrHideAllUI() 

    local isShow = self.hideBtnShowState
    if self.isPlayingTimelineOrIdleSwitch then 
        isShow = false
    end
    --- 
    KTool.SetActive( self.BtnHide.gameObject, self.isPlayingTimelineOrIdleSwitch == false )
    self.smoothShow_Touch:SetShowOrHide( isShow, isShow==true and Touch_fadeInTime or Touch_fadeOutTime )    
    -- !! self.uiQTEEnv 不受 本全局开关管理 

    self.uiRightBtnsPanel:SetShow( isShow )
end 




function IdolLive3D_UIMainV2:_OnEventNewInteractiveState( iState )
    --printError( "add to queue: " .. tostring(iState.name) )

    if self.isInit ~= true then 
        printError("异常, IdolLive3D_UIMainV2 自己都没 Init 完, 深度互动已经在运行了, 这会导致漏接 event 进而 ui 层显示异常;")
        self.uiSwitchBtnEnv:Show( false )
        return
    end 


    self.isPlayingTimelineOrIdleSwitch =    
            iState.stateType == InteractiveStateType.Timeline 
        or  iState.stateType == InteractiveStateType.SuperTimeline 
        or  (iState.stateType == InteractiveStateType.IdleSwitch or iState.stateType == InteractiveStateType.StageSmoothSwitch or iState.stateType == InteractiveStateType.StageJump)


    self:ShowOrHideAllUI()
    
        
    local isActive = false
    local isShow = true
    local isGray = true
    if  iState.stateType == InteractiveStateType.Timeline or iState.stateType == InteractiveStateType.SuperTimeline or 
        iState.stateType == InteractiveStateType.IdleSwitch or iState.stateType == InteractiveStateType.StageSmoothSwitch or iState.stateType == InteractiveStateType.StageJump
    then 
        isActive = false
        isShow = false
        isGray = true
    elseif iState.stateType == InteractiveStateType.Idle then 
        isActive = true
        isShow = true
        isGray = false
    end 

    self.uiSwitchBtnEnv:SetActive( isActive )
    self.uiSwitchBtnEnv:Show( isShow )
    self.uiSwitchBtnEnv:SetGray( isGray )

    
end



function IdolLive3D_UIMainV2:_GetToucTipsDataString()
    local str = ""
    for i=1, table.count(self.touchTipDatas) do
        local tip = self.touchTipDatas[i]
        str = str .. tostring(tip.key) .. "=" .. tostring(tip.touchedNum)
        if i ~= table.count(self.touchTipDatas) then 
            str = str .. "&"
        end 
    end
    return str
end



function IdolLive3D_UIMainV2:IntoNewState( newUIMgr_ )
    --printError("ui IntoNewState")

    self.uiRightBtnsPanel:IntoNewState_Before()

    -- pos stageJumpBtn img 切换:
    if isNotNull(newUIMgr_.posStageJumpBtnImgIdx) and type(newUIMgr_.posStageJumpBtnImgIdx) == "number" then 
        Events.Broadcast(IdolLive3D_States.EventChangeUIPosStageJumpBtnImg, newUIMgr_.posStageJumpBtnImgIdx )
    end 
    -- cam stageJumpBtn txt 修改:
    if isNotNull(newUIMgr_.camStageJumpBtnImgTxt) and type(newUIMgr_.camStageJumpBtnImgTxt) == "string" then 
        Events.Broadcast(IdolLive3D_States.EventChangeUICamStageJumpBtnTxt, newUIMgr_.camStageJumpBtnImgTxt )
    end

    --- uiNodes:
    if isNotNull(self.lastUIMgr) then

        --printError("uiNodes num = " ..tostring(#self.lastUIMgr.uiNodes))

        for i=1,#self.lastUIMgr.uiNodes do -- 确保每次读取的顺序都是相同的
            local uiNode = self.lastUIMgr.uiNodes[i]
            local key = string.lower(uiNode.key)
            if IdolLive3D_Utils.IsKeyValid(key) then 

                -- !! 目前版本中, isCurrentActive 直接用来 显示/隐藏 uiNode
                if uiNode.nodeShowType == NodeShowType.T_Hide_Open and uiNode.isCurrentActive == true then 
                    --printError("old show - " ..tostring(key))
                    Events.Broadcast(IdolLive3D_States.EventSetUICustomShow, key, true, 0.1, true )
                     
                elseif uiNode.nodeShowType == NodeShowType.T_Open_Hide or uiNode.isCurrentActive == false then
                    --printError("old hide - " ..tostring(key))
                    Events.Broadcast(IdolLive3D_States.EventSetUICustomShow, key, false, 0.1, true )

                end 

                if uiNode.nodeNotGrayType == NodeShowType.T_Hide_Open then 
                    --printError("old notGray - " ..tostring(key))
                    Events.Broadcast(IdolLive3D_States.EventSetUICustomGray, key, false, true )
                elseif uiNode.nodeNotGrayType == NodeShowType.T_Open_Hide then 
                    --printError("old Gray - " ..tostring(key))
                    Events.Broadcast(IdolLive3D_States.EventSetUICustomGray, key, true, true )
                end 
            else 
                printError("ui node key 异常:" .. tostring(key))
            end 
        end 
    end

    for i=1, #newUIMgr_.uiNodes do -- 确保每次读取的顺序都是相同的
        local uiNode = newUIMgr_.uiNodes[i]
        local key = string.lower(uiNode.key)
        if IdolLive3D_Utils.IsKeyValid(key) then 

            if (uiNode.nodeShowType == NodeShowType.T_Open or uiNode.nodeShowType == NodeShowType.T_Open_Hide) and uiNode.isCurrentActive == true then 
                --printError("new show - " ..tostring(key))
                Events.Broadcast(IdolLive3D_States.EventSetUICustomShow, key, true, 0.1, true )

            elseif (uiNode.nodeShowType == NodeShowType.T_Hide or uiNode.nodeShowType == NodeShowType.T_Hide_Open) or uiNode.isCurrentActive == false then 
                --printError("new hide - " ..tostring(key))
                Events.Broadcast(IdolLive3D_States.EventSetUICustomShow, key, false, 0.1, true )

            end

            if uiNode.nodeNotGrayType == NodeShowType.T_Open or uiNode.nodeNotGrayType == NodeShowType.T_Open_Hide then 
                --printError("new notGray - " ..tostring(key))
                Events.Broadcast(IdolLive3D_States.EventSetUICustomGray, key, false, true )
            elseif uiNode.nodeNotGrayType == NodeShowType.T_Hide or uiNode.nodeNotGrayType == NodeShowType.T_Hide_Open then 
                --printError("new Gray - " ..tostring(key))
                Events.Broadcast(IdolLive3D_States.EventSetUICustomGray, key, true, true )
            end
        else 
            printError("ui node key 异常:" .. tostring(key))
        end 
    end 

    self.uiRightBtnsPanel:IntoNewState_After()

    ---
    self.lastUIMgr = newUIMgr_
end


return IdolLive3D_UIMainV2

------------ import ------------
local util = require "XLua.util"
local cs_coroutine = require("XLua.cs_coroutine")
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
local CoWait = CS.Engine.Lib.CoWait
local KTool = CS.Engine.Lib.KTool
local RectTransform = CS.UnityEngine.RectTransform
local LuaBehaviour = CS.Engine.Modules.LuaBehaviour
local DOTween = CS.DG.Tweening
local Yielders = CS.Engine.Lib.Yielders
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local Input = CS.UnityEngine.Input
local Physics = CS.UnityEngine.Physics
local UIModule = CS.Engine.UI.UIModule
local EasyTouch = CS.HedgehogTeam.EasyTouch.EasyTouch
local UIEventProxy = CS.Engine.UI.UIEventProxy
local EventDragProxy = CS.Engine.UI.EventDragProxy
local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
local CanvasGroup = CS.UnityEngine.CanvasGroup
local UILuaDialog = CS.Engine.UI.UILuaDialog
local GraphicRaycaster = CS.UnityEngine.UI.GraphicRaycaster
local Canvas = CS.UnityEngine.Canvas
local RawImageAlterable = CS.Engine.UI.RawImageAlterable
local ImageAlterable = CS.Engine.UI.ImageAlterable
local NonDrawingGraphic = CS.UnityEngine.UI.Extensions.NonDrawingGraphic
local KCookie = CS.Engine.Lib.KCookie
local UISwitchImage = CS.Game.Native.Common.UISwitchImage
local Image = CS.UnityEngine.UI.Image
local Ease = CS.DG.Tweening.Ease
local AppEngine = CS.Engine.Lib.AppEngine
local GameObject = CS.UnityEngine.GameObject
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local CameraExtensions = CS.UnityEngine.Camera
local teamComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.TeamComponent)
local AnnihilationUtils = import('Game.UI.FightReady.UIMainChapter.AnnihilationUtils')
------------ import ------------
local DoubleRateTipsPath = "Game.UI.UIBattling.DoubleRateTips"
local ContinuousFightBtnPath = "Game.UI.UIBattling.UIBattlingContinuousFightBtn"
------------ define ------------
local ORDER_IN_LAYER_IN_GUIDE = 48 --引导关卡 是 中途退出 按钮的渲染层级
local LIST_ANIMATION_UNIT_SKILL = {
    Dark = "Dark",
    Activate = "Activate",
}
local Type_Interaction = {
    Click = 1,
    PressStart = 2,
    PressFinish = 3,
    Drag = 4,
    None = 5,
}
local Type_Click = {
    None = 0,
    ChooseAttackTarget = 1,
    ChooseBuffTarget = 2,
}
local Click_Fault_Tolerance = 40
local TIME_LENGTH_2_PRESS = 0.2
local DEFAULT_PRESS_DETECTION_TIME = 0.5
local SkillPoolAutoShowTime = 0.75
------------ define ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/UIBattlingDialog.prefab > name: UIBattlingDialog
---@class UIBattlingDialog
---@field Env                           	UIBattlingDialog                        
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RT_CatFather                  	UnityEngine.RectTransform               
---@field RT_CatBallSkillTipsPanel      	UnityEngine.RectTransform               
---@field RT_SkillCatNode               	UnityEngine.RectTransform               
---@field RT_SpeedBtnLock               	UnityEngine.RectTransform               
---@field RT_UIBattlingCharactorBattleInfoNode	UnityEngine.RectTransform
---@field RT_RootTrainFieldBattleData   	UnityEngine.RectTransform
---@field RT_LeftUpLayoutGroup          	UnityEngine.RectTransform
---@field RT_ContinuousFight            	UnityEngine.RectTransform
---@field LB_TreasureRoot               	Engine.Modules.LuaBehaviour
---@field RT_AutoBtnLock                	UnityEngine.RectTransform
---@field RightPanel                    	UnityEngine.RectTransform
---@field RootDrag                      	UnityEngine.RectTransform
---@field AttributeBtn                  	UnityEngine.RectTransform
---@field Root_PTC                      	UnityEngine.RectTransform
---@field BattleRoundRoot               	Engine.Modules.LuaBehaviour
---@field AttributeCircleBtn            	UnityEngine.RectTransform
---@field TipsBtnRoot                   	UnityEngine.RectTransform
---@field BtnIcon                       	Game.Native.Common.UISwitchImage
---@field DoubleRateBtnTipsDialog       	UnityEngine.RectTransform
---@field DoubleRateBtn                 	Engine.Modules.LuaBehaviour
---@field AutoBtn                       	Engine.Modules.LuaBehaviour
---@field UIBattlingDialog              	UnityEngine.CanvasGroup
---@field TopPanel                      	UnityEngine.RectTransform
---@field SettingBtn                    	UnityEngine.RectTransform
---@field ProtectGraphic                	UnityEngine.RectTransform
---@field BottomTipsOnSkillShowPanel    	UnityEngine.RectTransform
---@field SkillNameTxt                  	UnityEngine.UI.Text
---@field SkillTipsRoot                 	UnityEngine.RectTransform
---@field SkillCardsSequene             	UnityEngine.RectTransform
---@field ReStartSelectCardBtn          	UnityEngine.RectTransform
---@field BottomLeftPanel               	UnityEngine.CanvasGroup
---@field BottomRightPanel              	Engine.Modules.LuaBehaviour
---@field SkillCardsPool                	UnityEngine.RectTransform
---@field BossInfoBtnRoot               	UnityEngine.RectTransform
---@field ElementBreakRoot              	UnityEngine.RectTransform
---@field TrainingTargetRoot            	UnityEngine.RectTransform
---@field SkillCardInstance             	UnityEngine.RectTransform
---@field RoundPassBtn                  	UnityEngine.RectTransform
---@field SkipCGBtn                     	UnityEngine.RectTransform
---@field RT_MultiStageGroup            	UnityEngine.RectTransform               
---@field RT_OnlinePVEPlaceHolder       	UnityEngine.RectTransform               
---@field RT_BackInteractable           	UnityEngine.RectTransform
local UIBattlingDialog = Class("UIBattlingDialog")

------------------------------------------------DataVo
---@class SkillCardSequenceVo
---@field cardData table
---@field targetId integer
---@field sequenceId integer
---@field isLock boolean
local SkillCardSequenceVo = {}
---@return SkillCardSequenceVo
function SkillCardSequenceVo.New(cardData, targetId, index, isLock)
    ---@type SkillCardSequenceVo
    local this = {}
    setmetatable(this, { __index = SkillCardSequenceVo })
    this.cardData = cardData
    this.targetId = targetId
    this.sequenceId = index
    this.isLock = isLock
    return this
end
------------------------------------------------DataVo

------------------------------------------------Lifecycle
function UIBattlingDialog:__init()
    self:CleanField()
end

function UIBattlingDialog:__delete()
    self:CleanField()
    self.controller = nil
    self = nil
end

function UIBattlingDialog:InitField()
    self.booleanUpdateRunning = true -- Update保险值
    self.booleanPlayerRoundIsStart = false -- 玩家回合是否开始
    self.playerLogicMsgSequence = {} -- 玩家逻辑消息队列
    self.skillSequencePoolBgImgArr = {} -- 技能顺序池 BG Arr
    self.roundPlayerTeamAliveNum = -1 -- 当前战斗 存活队员人数
    self.skillSequenceList = {} -- 技能序列牌LB集合
    self.showSkillSequenceList = {} -- 需要展示的技能序列
    self.curSequenceId = 0 -- 最新需要展示的 技能序列Id
    self.curActionPointUsed = 0 -- 当前已使用的行动点
    self.characterAddBuffSkillCardPosData = nil -- 添加 Buff 指令的 PosData
    self.timeInputFinish = 0
    self.boolMineTurnRunning = false
    self.switchGameOverIn = 0
    self.anySkillSequenceInput = false
    self.isSkillPoolShow = false
    self.showingCanUnitTipAnimation = false
    self.campWaveChanged = {}
    self.isMultiStage = false       -- 是否是多阶段boss
end

function UIBattlingDialog:CleanField()
    self.doubleRateEnv = nil
    self.booleanUpdateRunning = nil -- Update保险值
    self.booleanPlayerRoundIsStart = nil -- 玩家回合是否开始
    self.booleanPassRound = nil -- 手动跳过回合判断值
    self.curAttTargetId = nil -- 当前玩家选择 的目标
    self.curAttRoleView = nil
    self.attTargetSign = nil -- 选择攻击目标图标
    self.btnLBAutoGame = nil -- 自动战斗开关
    self.btnLBDoubleRate = nil -- 两倍速开关
    self.btnLBTips = nil
    self.btnLBElement = nil
    self.coDoSequence = nil -- 玩家队伍执行逻辑协程
    self.coReSelect = nil -- 玩家重新选择逻辑协程
    self.coBroadToLogic = nil
    self.coDelayInputFinish = nil    -- 延迟向逻辑发送输入结束的消息（检查卡池里面的表现全部完成以后再发送）
    self.coDragEndProtected = nil -- dragEnd保护
    self.coShowForceTurn = nil -- 展示 势力回合 协程
    self.coShowTips = nil
    self.playerLogicMsgSequence = nil -- 玩家逻辑消息队列
    self.skillSequencePoolBgImgArr = nil -- 技能顺序池 BG Arr
    self.roundPlayerTeamAliveNum = nil -- 当前战斗 存活队员人数
    self.skillSequenceList = nil -- 技能序列牌LB集合
    self.eventGetSelectSkillCardPosData = nil -- 在技能卡 OnDrag 时的位置信息
    self.eventOnCurSkillCardDragEnd = nil -- 技能卡 拖拽结束 事件
    self.eventSetSequenceSkillCard = nil -- 点击出卡 事件
    self.eventSkillCardInfoShow = nil -- 长按显示 技能卡信息
    self.eventBattleBossCutInStart = nil -- BossCutIn
    self.eventShowSkillCutInStart = nil
    self.eventBattleTurnStartShow = nil -- 敌我回合
    self.eventBattleUIShowState = nil -- 战中面板显示状态
    self.eventUIBattlingChangeLongIdleCamera = nil -- 长镜头推送
    self.eventGameOver = nil -- 游戏结束 事件
    self.eventBattleWavesChange = nil -- 战中波次切换
    self.eventShowSkipCGBtn = nil   -- 显示跳过大招CG按钮的事件
    self.eventHideSkipCGBtn = nil   -- 隐藏跳过大招CG按钮的事件
    self.eventAllCampInputFinish = nil
    self.eventBattleDropTreasureShow = nil
    self.eventOnCountDownFinish = nil
    self.eventBattleDeleteRoleShow = nil
    self.eventBattleBossShowStart = nil
    self.showSkillSequenceList = nil -- 需要展示的技能序列
    self.curSequenceId = nil -- 最新需要展示的 技能序列Id
    self.curActionPointUsed = nil -- 当前已使用的行动点
    self.showSkillSequencePanelLB = nil
    self.characterAddBuffSkillCardPosData = nil -- 添加 Buff 指令的 PosData
    self.numCanUseByLogic = nil -- 从逻辑获取的出牌数量
    self.eventBattleMyCard = nil
    self.eventBattleRequireInput = nil
    self.eventShowGameStart = nil   -- 游戏开始事件
    self.eventBattleRoleEnterEnd = nil  -- 角色入场结束
    self.eventBattleFinalDamageShow = nil   -- 尾刀UI展示
    self.goWaterMark = nil -- 水印游戏物体
    self.longTapSign = nil -- 长按显示游戏物体
    self.btnPassRound = nil -- 回合跳过功能按钮
    self.typeTouchListener = nil -- 当前 TouchScreen 的监听类型
    self.longTapCharacterData = nil -- 长按人物数据
    self.luaTableDialogSkillPool = nil --玩家 可选择技能卡 区域的 LuaTable
    self.luaTableWaveInfo = nil -- 波次/回合信息 luaTable
    self.canvasGroupSkillPoolRoot = nil --玩家 可选择技能卡 区域的 CanvasGroup 组件
    self.curReselectSkillLuaTable = nil  -- 需要重新选择技能目标的序列的 luaTable
    self._behaviourAction = nil
    self.timeInputFinish = nil
    self.siReselectBtn = nil
    self.stReselectBtn = nil
    self.coShowAddBuffSign = nil
    self.coShowLongTapSign = nil
    self.listRefSignGO = nil
    self.coAutoHideSkillPool = nil
    self.boolMineTurnRunning = nil -- todo _New_Field_
    self.switchGameOverIn = nil -- 判断是否进入GameOver函数的开关值
    self.btnSaveRecord = nil
    self.signWaveChange = nil
    self.rectTransform = nil
    self.isShowSkillTips = nil
    self.coInteractive = nil
    self.posPointerD = nil
    self.boolGuideRoundFinish = nil
    self.refBtnAreaRefreshSkillPool = nil
    self.isInput = nil
    self.anySkillSequenceInput = nil    -- 判断是否有任何的卡牌操作已经记录到技能序列里面了，用于技能序列面板的缩放（有卡牌的时候放大，没卡牌的时候缩小）
    self.isSkillPoolShow = nil          -- 技能卡池是否显示
    self.LT_CardTipsNode = nil          -- 玩家输入提示节点的lua table
    self.showingCanUnitTipAnimation = nil   -- 可以合卡的提示动画是否已经在播放了
    self.coShowRival = nil
    self.coBossShow = nil
    self.coShowWaveStart = nil
    self.coShowWorldBossWaveStart = nil
    self.coShowBattlingCharacterUI = nil
    self.coRequireInput = nil

    self.LT_BattlingTreasureGroup = nil -- 战中宝箱UI

    self.campWaveChanged = nil          -- 记录阵营波次是否已经切换了
    self.funOnClick = nil               -- 点击的响应事件
    self.shiledDrag = nil               -- 屏蔽拖拽
    self.passRoundDefaultScale = nil
    self.restartDefaultScale = nil
    self.RT_MultiStageGroup = nil       -- 多阶段boss的UI
    self.isMultiStage = nil

    self.LT_SkillCatNode = nil          -- 猫卡技能按钮节点
    self.coWaitVoice = nil

    self.levelTipsManager = nil         -- 关卡提示管理器

    self.tipsCard = nil                 -- 展示卡牌提示的那张卡牌
end

function UIBattlingDialog:Awake()
    self:InitField()
    if not IsNull(CS.Game.Native.ScreenTouchEffectModule) then
        KTool.SetActive(CS.Game.Native.ScreenTouchEffectModule.Instance.gameObject, false)
    end
    if not IsNull(EasyTouch) then
        EasyTouch.SetEnabled(true)
        EasyTouch.instance.longTapTime = 0.2
        EasyTouch.instance.enable2FingersGesture = false
    end
    Input.multiTouchEnabled = false
    UIBattlingCtrlMgr:GetInstance():SetBattleMsgSequence(self.coDoSequence) -- 设置 Dialog 消息队列引用到 GamePlayGuideMgr
    UIBattlingCtrlMgr:GetInstance():SetBattlingDialog(self.controller.Env) -- 设置 Dialog 引用
    ---@type SkillPoolOperationMgr
    SkillPoolOperationMgr = import("Game.UI.UIBattling.Manager.SkillPoolOperationMgr")
    SkillPoolOperationMgr:Init()

    self.UIBattlingDialog.interactable = false
    self.UIBattlingDialog.blocksRaycasts = false

    -- KTool.SetActive(self.RightPanel.gameObject, false)
    self.shiledDrag = false
    local chatTrans = self.TopPanel.transform:Find("BtnChat")
    if chatTrans
    and not BattleInfo.isSimulator then
        local social = AppService:GetInstance():GetSocialLine()
        if social then
            local isHave = social:IsHaveUnreadMsgByPlayerId()
            GameUtils.BindRedPoint(Constants.RedPointConst.OverseaChat, chatTrans.gameObject, true)
            if isHave then
                GameUtils.SetRedPointNum(Constants.RedPointConst.OverseaChat , 1)
                GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.OverseaChat)
            end
            SetButtonAction(chatTrans.gameObject, function()
                ---聊天功能
                UIModule.OpenDialog(UIArgs(Constants.UITypeIds.OverseaChatMainDialog))
            end)
        end
    end

    self.levelTipsManager = import("Game.UI.UIBattling.UIBattlingDialogLevelTipsManager")
end

function UIBattlingDialog:OnInitialize()
    xTry(function()
        UIBattlingCtrlMgr:GetInstance():SetBattlingDialog(self)
        --- 玩家战斗设置状态更新
        UIBattleSettingMgr:SetPlayerPrefs()
        self:InitComponent()
        self:InitListener()
        self:InitPlayerSettingBtns()
    end)
end

function UIBattlingDialog:OnShow()
    xTry(function()
        local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
        if behaviourAction then
            behaviourAction.UpdateAction = function()
                self:Update()
            end
            behaviourAction.OnApplicationFocusAction = function(ba, isFocus)
                -- windows平台截图的时候，需要手动取消卡牌的长按的效果
                if not isFocus and isNotNull(self.tipsCard) then
                    self.tipsCard.Env:ActionOnPointerUp()
                    -- self:SkillCardOnPress(false, self.tipsCard)
                end
            end
            self._behaviourAction = behaviourAction
        end
        self.booleanPassRound = UIBattleSettingMgr.canManualEnd
        local questType = UIBattlingDataMgr:GetQuestType()
        if AnnihilationUtils.QuestTypeIsAnnihilation(questType) then
            self.booleanPassRound = false
            local node = self.TopPanel:Find("Layout/Placeholder")
            if isNotNull(node) then
                CfUtils.SetActive(node, true)
            end
        end
        ---设置 Dialog 节点的状态
        self:SetDialogRootState()
        --- 设置对战回合数
        if UIBattlingTools:ShowRoundNum() then
            self.luaTableWaveInfo:SetBattleRoundsValue(1)
        end
        --- 查看是否为 引导关
        if GamePlayGuideMgr and GamePlayGuideMgr.dataPlay then
            --- 引导关 关闭 属性克制节点交互
            if self.AttributeCircleBtn.gameObject then
                local receiver = self.AttributeCircleBtn.gameObject:GetComponent(typeof(CS.UnityEngine.UI.Extensions.NonDrawingGraphic))
                if not IsNull(receiver) then
                    receiver.enabled = false
                end
            end
        end
        if UIBattlingCtrlMgr:GetInstance().isShowRootSkillProcess then
            self:LoadShowSkillProcess()
        end
    end, function()
        printError("%s", debug.traceback());
    end)
end

function UIBattlingDialog:OnHide()
    xTry(function()
        if not isNull(self._behaviourAction) then
            self._behaviourAction.UpdateAction = nil
            self._behaviourAction = nil
        end
    end)
end

function UIBattlingDialog:OnFinalize()
    xTry(function()
        self:RemoveListener()
        self.levelTipsManager:Clear()
        if not IsNull(EasyTouch) then
            EasyTouch.instance.longTapTime = 1
        end
        self:StopCo()
        if not IsNull(self.goWaterMark) then
            KTool.SafeDelete(self.goWaterMark)
        end
        if BattleInfo and (not BattleInfo.isSimulator) then
            GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.OverseaChat)
        end
        Input.multiTouchEnabled = true
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end)
end

---Update
function UIBattlingDialog:Update()
    ---玩家回合未开始 不用执行逻辑
    if not self.booleanUpdateRunning or not self.boolMineTurnRunning then
        return
    end
    if self.curAttTargetId then
        self:SetATCSignPos()
    end
end

function UIBattlingDialog:StopCo()
    if not IsNull(self.coShowForceTurn) then
        cs_coroutine.stop(self.coShowForceTurn)
    end
    if not IsNull(self.coBroadToLogic) then
        cs_coroutine.stop(self.coBroadToLogic)
    end
    if not IsNull(self.coDelayInputFinish) then
        cs_coroutine.stop(self.coDelayInputFinish)
    end
    if not IsNull(self.coDoSequence) then
        cs_coroutine.stop(self.coDoSequence)
    end
    if not IsNull(self.coReSelect) then
        cs_coroutine.stop(self.coReSelect)
    end
    if not IsNull(self.coDragEndProtected) then
        cs_coroutine.stop(self.coDragEndProtected)
    end
    if not IsNull(self.coShowTips) then
        cs_coroutine.stop(self.coShowTips)
    end
    if not IsNull(CS.Game.Native.ScreenTouchEffectModule) then
        KTool.SetActive(CS.Game.Native.ScreenTouchEffectModule.Instance.gameObject, true)
    end
    if not IsNull(self.coShowAddBuffSign) then
        cs_coroutine.stop(self.coShowAddBuffSign)
        self.coShowAddBuffSign = nil
    end
    if not IsNull(self.coAutoHideSkillPool) then
        cs_coroutine.stop(self.coAutoHideSkillPool)
    end
    if not IsNull(self.coShowRival) then
        cs_coroutine.stop(self.coShowRival)
        self.coShowRival = nil
    end
    if not IsNull(self.co_bossShow) then
        cs_coroutine.stop(self.co_bossShow)
        self.co_bossShow = nil
    end
    if not IsNull(self.coShowWaveStart) then
        cs_coroutine.stop(self.coShowWaveStart)
        self.coShowWaveStart = nil
    end
    if not IsNull(self.coShowWorldBossWaveStart) then
        cs_coroutine.stop(self.coShowWorldBossWaveStart)
        self.coShowWorldBossWaveStart = nil
    end
    if not IsNull(self.coShowBattlingCharacterUI) then
        cs_coroutine.stop(self.coShowBattlingCharacterUI)
        self.coShowBattlingCharacterUI = nil
    end
    if not isNull(self.coRequireInput) then
        cs_coroutine.stop(self.coRequireInput)
        self.coRequireInput = nil
    end
    self:CleanCoShowLongTap()
    self:StopCardWaitVoiceCo()
end
------------------------------------------------Lifecycle

------------------------------------------------ResourceLoad

function UIBattlingDialog:LoadTrainFieldBattleData()
    local goPanel = UIBattlingCtrlMgr:GetInstance():GetSingleGameObject(Constants.UIResLoadGameObjectInConditionPath.TrainFieldBattleData)
    if IsNull(goPanel) then
        return
    end
    local rt = KTool.GetComponent(goPanel.gameObject, typeof(RectTransform))
    rt.offsetMin = Vector2.zero
    rt.offsetMax = Vector2.zero
    KTool.SetParent(goPanel, self.RT_RootTrainFieldBattleData.gameObject)
    local lbTrainFieldData = GetLuaBehaviour(goPanel, Constants.UIBattlingLuaTablePath.TrainFieldBattleData)
    if lbTrainFieldData then
        lbTrainFieldData:Init()
    end
    local ltTrainFieldData = lbTrainFieldData.Env
    self.ltTrainFieldBattleData = ltTrainFieldData
    return self.ltTrainFieldBattleData
end

---LoadTrainingTargetPanel
---加载 新手训练 节点
function UIBattlingDialog:LoadTrainingTargetPanel()
    if self.ltTrainingTargetPanel then
        return self.ltTrainingTargetPanel
    end
    local goPanel = UIBattlingCtrlMgr:GetInstance():GetSingleGameObject(Constants.UIResLoadGameObjectInConditionPath.UIBattlingTrainingTargetPanel)
    if IsNull(goPanel) then
        return
    end
    KTool.SetParent(goPanel, self.TrainingTargetRoot.gameObject)
    KTool.SetActive(self.TrainingTargetRoot, true)
    local lbTrainingTargetPanel = GetLuaBehaviour(goPanel, Constants.UIBattlingLuaTablePath.UIBattlingTrainingTargetPanel)
    goPanel.transform.anchoredPosition = Vector3.zero
    if lbTrainingTargetPanel then
        lbTrainingTargetPanel:Init()
    end
    local ltTrainingTargetPanel = lbTrainingTargetPanel.Env
    self.ltTrainingTargetPanel = ltTrainingTargetPanel
    return self.ltTrainingTargetPanel
end

--- 加载 玩家输入提示节点
function UIBattlingDialog:LoadCardTipsNode()
    local cardTipsNode = UIBattlingCtrlMgr:GetInstance():GetSingleGameObject(Constants.UIResLoadGameObjectPath.CardTipsNode)
    cardTipsNode.transform.localPosition = Vector3.New(228, -460, 0)
    KTool.SetParent(cardTipsNode, self.UIBattlingDialog.gameObject)
    local LB_CardTipsNode = GetLuaBehaviour(cardTipsNode, Constants.UIBattlingLuaTablePath.UIBattlingCardTipsNode)
    LB_CardTipsNode:Init()
    self.LT_CardTipsNode = LB_CardTipsNode.Env
end

---LoadPassRoundBtn
---加载跳过回合按钮预制体
function UIBattlingDialog:LoadPassRoundBtn()
    -- local btnGO = UIBattlingCtrlMgr:GetInstance():GetSingleGameObject(Constants.UIResLoadGameObjectPath.PassRoundBtn)
    -- btnGO.name = "Btn_RoundPass"
    -- KTool.SetParent(btnGO, self.RightPanel.gameObject, false)
    -- local t = btnGO:GetComponent(typeof(RectTransform))
    -- t:SetAsLastSibling()
    -- t.anchoredPosition = Vector2.New(-19, 79.5)
    local btnPassRoundLB = GetLuaBehaviour(self.RoundPassBtn.gameObject, Constants.UIBattlingLuaTablePath.UIBattlingBtnNode)
    btnPassRoundLB:Init()
    self.btnPassRound = btnPassRoundLB.Env
end

---CreateAttTargetSign
---创建 攻击目标 游戏物体
function UIBattlingDialog:LoadAttTargetSign()
    self.attTargetSign = UIBattlingCtrlMgr:GetInstance():GetSingleGameObject(Constants.UIResLoadGameObjectPath.AttackTarget)
    KTool.SetParent(self.attTargetSign, self.UIBattlingDialog.gameObject, false)
    KTool.SetActive(self.attTargetSign, false)
    self.attTargetSign.transform:SetAsFirstSibling()
    local t = self.attTargetSign:GetComponent(typeof(RectTransform))
    t.localPosition = Vector3.zero
    t.localScale = Vector3.one
end

---LoadLongTapSign
---创建 长按提示 游戏物体
function UIBattlingDialog:LoadLongTapSign()
    local goLongTapSign = UIBattlingCtrlMgr:GetInstance():GetSingleGameObject(Constants.UIResLoadGameObjectPath.LongTapSign)
    KTool.SetParent(goLongTapSign, self.controller.gameObject, false)
    local lbLongTapSign = GetLuaBehaviour(goLongTapSign, Constants.UIBattlingLuaTablePath.LongTapSign)
    lbLongTapSign:Init()
    self.longTapSign = lbLongTapSign.Env
end

function UIBattlingDialog:LoadShowSkillProcess()
    local goSkillProcess = UIBattlingCtrlMgr:GetInstance():GetSingleGameObject(Constants.UIBattleShowSkillProcess)
    if not IsNull(goSkillProcess) then
        KTool.SetParent(goSkillProcess, self.UIBattlingDialog.gameObject, false)
        local lbSkillProcess = KTool.GetComponent(goSkillProcess, typeof(LuaBehaviour))
        lbSkillProcess:Init()
        local rectTrans = KTool.GetComponent(goSkillProcess, typeof(RectTransform))
        rectTrans.anchoredPosition = Vector3.New(0, 300)
        KTool.SetActive(goSkillProcess, false)
        UIBattlingCtrlMgr:GetInstance():SetRefRootSkillProcess(lbSkillProcess.Env)
    end
end

------------------------------------------------ResourceLoad

------------------------------------------------Component
function UIBattlingDialog:InitComponent()
    self.rectTransform = KTool.GetComponent(self.controller.gameObject, typeof(RectTransform))
    self.catFather = IsNull(self.RT_CatFather) and self.rectTransform or self.RT_CatFather
    local btnAutoGameLB = GetLuaBehaviour(self.AutoBtn.gameObject, Constants.UIBattlingLuaTablePath.UIBattlingBtnNode)
    btnAutoGameLB:Init()
    self.btnLBAutoGame = btnAutoGameLB.Env
    local btnDoubleRateLB = GetLuaBehaviour(self.DoubleRateBtn.gameObject, Constants.UIBattlingLuaTablePath.UIBattlingBtnNode)
    btnDoubleRateLB:Init()
    self.btnLBDoubleRate = btnDoubleRateLB.Env

    -- 初始化关卡提示
    self.levelTipsManager:Init(self.TipsBtnRoot, self.RT_LeftUpLayoutGroup)
    
    -- 属性按钮
    local btnLBElement = GetLuaBehaviour(self.AttributeBtn.gameObject, Constants.UIBattlingLuaTablePath.UIBattlingBtnNode)
    btnLBElement:Init()
    self.btnLBElement = btnLBElement.Env
    KTool.SetActive(btnLBElement.gameObject, false)

    if UIBattleTrainFieldMgr then
        self:SwitchImgBtnAttribute(UIBattleTrainFieldMgr.indexSelected)
    end
    --- 加载 攻击目标选择标识 游戏物体
    self:LoadAttTargetSign()
    -- 手动结束回合的按钮
    self:LoadPassRoundBtn()
    local questType = UIBattlingDataMgr:GetQuestType()
    if AnnihilationUtils.QuestTypeIsAnnihilation(questType) then
        KTool.SetActive(self.RoundPassBtn, false)
    end
    self:LoadLongTapSign()
    --- 对 展示技能面板 LB 赋值
    self.showSkillSequencePanelLB = self.BottomTipsOnSkillShowPanel:GetComponent(typeof(LuaBehaviour))
    if isNull(self.showSkillSequencePanelLB.Env) then
        self.showSkillSequencePanelLB:Init()
    end
    self:FillSkillCardComponent()
    self.canvasGroupSkillPoolRoot = self.BottomRightPanel.gameObject:GetComponent(typeof(CanvasGroup))
    if not IsNull(self.BottomRightPanel) then
        self.BottomRightPanel:Init()
        ---@type UIBattlingSkillPoolPanel
        self.luaTableDialogSkillPool = self.BottomRightPanel.Env
    end
    -- 多阶段boss的UI
    local showMultiStage = false
    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(UIBattlingDataMgr.questId)
    if questVo then
        self.isMultiStage = isNotNull(questVo.isMultiStage) and questVo.isMultiStage == 1
        if self.isMultiStage then
            local waveNum = checkNumber(UIBattlingDataMgr:GetBattleFieldWaveMax())
            if waveNum > 1 then
                self.LB_MultiStageGroup = GetLuaBehaviour(self.RT_MultiStageGroup.gameObject, "Game.UI.UIBattling.UIBattlingMultiStagePanel").Env
                KTool.SetActive(self.RT_MultiStageGroup, true)
                self.LB_MultiStageGroup:InitNodes(waveNum)
                self.LB_MultiStageGroup:SetStage(1)
                showMultiStage = true
            end
        end
    end
    -- 回合数和波次数
    if not IsNull(self.BattleRoundRoot) then
        self.BattleRoundRoot:Init()
        self.luaTableWaveInfo = self.BattleRoundRoot.Env
        KTool.SetActive(self.BattleRoundRoot, false)
        if UIBattlingTools:ShowWaveNum() and not showMultiStage then
            KTool.SetActive(self.BattleRoundRoot, true)
        else
            self.luaTableWaveInfo:SetWaveInfoState(false)
        end
        if UIBattlingTools:ShowRoundNum() then
            KTool.SetActive(self.BattleRoundRoot, true)
        else
            self.luaTableWaveInfo:SetRoundInfoState(false)
        end
    end
    --- 加载玩家提示节点
    if UIBattleSettingMgr.showInputTips then
        self:LoadCardTipsNode()
    end
    -- 重新出牌的按钮
    if UIBattleSettingMgr.showUndoBtn then
        self:InitBtnReselectComp()
    else
        KTool.SetActive(self.ReStartSelectCardBtn.gameObject, false)
    end
    --TODO 保存战报
    local transBtnSaveRecord = self.controller.transform:Find("Btn_SaveBattleRecord")
    if not IsNull(transBtnSaveRecord) then
        KTool.GetOrAddComponent(transBtnSaveRecord.gameObject, typeof(UIEventProxy)).onPointerClick = function()
            --UIModule.OpenDialog({ id = Constants.UITypeIds.UIGamePlayGuideBookDialog })
            if RecordMgr then
                local rs = RecordMgr:SaveRecord()
                CS.UnityEngine.GUIUtility.systemCopyBuffer = checkString(RecordMgr:GetRecordString())
                GameUtils.Toast(localize("战报数据已复制到粘贴版"))
            end
        end
        self.btnSaveRecord = transBtnSaveRecord.gameObject
    end
    xTry(function()
        if not isNull(UIBattleTrainFieldMgr) then
            self:LoadTrainFieldBattleData()
            self.ltTrainFieldBattleData:InitDataNode()
            KTool.SetActive(self.RT_RootTrainFieldBattleData, true)
        end
    end)

    -- 计算一下按钮的默认大小，后面缩放parent的时候，要保持子按钮的大小不变
    local parentScale = self.BottomLeftPanel.transform.localScale.x
    local restartBtnScale = self.ReStartSelectCardBtn.transform.localScale.x
    local passRoundBtnScale = self.RoundPassBtn.transform.localScale.x
    self.passRoundDefaultScale = parentScale * restartBtnScale
    self.restartDefaultScale = parentScale * passRoundBtnScale

    -- 连续作战按钮
    if not BattleInfo.isSimulator then
        local questId = UIBattlingDataMgr:GetQuestId()
        if teamComponent:CanUseContinueFight(questId) then
            KTool.SetActive(self.RT_ContinuousFight, true)
            if teamComponent:GetCurContinueState() then
                -- 每连续作战一场就+1
                teamComponent:AddCurContinueNum(1)

                -- 判断是否有首通奖励
                local isPass = QuestConfMgr:GetInstance():IsPassQuest(questId)
                if not isPass then
                    teamComponent:SetHasFirstRewards(true)
                end

                -- 自动战斗
                if not UIBattleSettingMgr.isAutoBattle then
                    self:SetBattleAutoRunningState(true, false)
                end
            end
            local LB_ConFightBtn = GetLuaBehaviour(self.RT_ContinuousFight.gameObject, ContinuousFightBtnPath)
            LB_ConFightBtn.Env:SetBtnState(teamComponent:GetCurContinueState(), false)
            LB_ConFightBtn.Env:SetFightTimes(teamComponent:GetCurContinueNum(), teamComponent:GetContinueNum(), teamComponent:GetContinueType())
            SetButtonAction(LB_ConFightBtn.Env.Btn_Root, function(e)
                -- teamComponent:SetIsOpenContinue(true)
                if teamComponent:GetCurContinueNum() < 1 then
                    teamComponent:SetCurContinueNum(1)
                    teamComponent:SetContinueType(Constants.ContinueBattleType.NoLimit)
                    LB_ConFightBtn.Env:SetFightTimes(teamComponent:GetCurContinueNum(), teamComponent:GetContinueNum(), teamComponent:GetContinueType())
                    -- 判断是否有首通奖励
                    local isPass = QuestConfMgr:GetInstance():IsPassQuest(questId)
                    if not isPass then
                        teamComponent:SetHasFirstRewards(true)
                    end
                end
                teamComponent:SetCurContinueState(not teamComponent:GetCurContinueState())
                LB_ConFightBtn.Env:SetBtnState(teamComponent:GetCurContinueState(), true)
            end)
        end
    end

    -- 总伤害UI
    local t = self.RT_LeftUpLayoutGroup:Find("TotalDamageNode")
    if isNotNull(t) and isNotNull(questVo) then
        local openTotalDamage = checkNumber(questVo.damageTotal)
        KTool.SetActive(t, openTotalDamage == 1)
    end
end

---FillSkillCardComponent
---填充技能卡背景的ImageAlterable和LuaBehaviour
function UIBattlingDialog:FillSkillCardComponent()
    local questType = UIBattlingDataMgr:GetQuestType()
    local skillCardNum = 4
    if AnnihilationUtils.QuestTypeIsAnnihilation(questType) then
        skillCardNum = 6
    elseif questType == Constants.IDType.QuestWorldBoss then
        skillCardNum = 5
    end
    -- skillCardNum = 6
    for i = 1, skillCardNum, 1 do
        -- 填充技能池背景的 ImageAlterable
        local skillCard = KTool.Instantiate(self.BottomLeftPanel.gameObject, self.SkillCardInstance.gameObject)
        KTool.SetActive(skillCard, true)
        local switchImg = skillCard:GetComponent(typeof(UISwitchImage))
        if not IsNull(switchImg) then
            table.insert(self.skillSequencePoolBgImgArr, switchImg)
        end
        -- 找寻填充 SkillSequeneSkillCard LuaBehavior
        local transSkillCardMB = skillCard.transform:Find("SkillCardNodeSmall")
        if not IsNull(transSkillCardMB) then
            local luaB = GetLuaBehaviour(transSkillCardMB.gameObject, Constants.UIBattlingLuaTablePath.SkillCardsSmall)
            if luaB then
                luaB:Init()
                table.insert(self.skillSequenceList, luaB)
            end
            local canvas = transSkillCardMB:GetComponent(typeof(Canvas))
            if not isNull(canvas) then
                GameObject.Destroy(canvas)  -- 行动点这里的卡牌不需要canvas组件，反而会打断合批，去掉它
            end
        end
        local RT_Num = skillCard.transform:Find("ImgNumberBg/TxtNum")
        if RT_Num then
            local Txt_Num = RT_Num:GetComponent(typeof(CS.TMPro.TextMeshProUGUI))
            if Txt_Num then
                Txt_Num.text = tostring(i)
            end
        end
    end
end
------------------------------------------------Component

------------------------------------------------Event
function UIBattlingDialog:InitListener()
    self.eventBattleMyCard = Events.AddListener(Constants.EventNames.BattleMyCard, Bind(self, self.InsertPlayerMsgSequence))
    self.eventGameSpeedChange = Events.AddListener(Constants.EventNames.UIBattlingDoubleRateRunning, Bind(self, self.OnGameSpeedChange))
    self.eventBattleRequireInput = Events.AddListener(Constants.EventNames.BattleRequireInput, Bind(self, self.BattleRequireInputFun))
    self.eventOnCurSkillCardDragEnd = Events.AddListener(Constants.EventNames.UIBattlingDialogOnCurSkillCardDragEnd, Bind(self, self.OnDragEndOfSkillCard))
    self.eventSetSequenceSkillCard = Events.AddListener(Constants.EventNames.UIBattlingDialogSetSequenceSkillCard, Bind(self, self.OnSkillCardClick))
    self.eventSkillCardInfoShow = Events.AddListener(Constants.EventNames.UIBattleSkillCardOnPress, Bind(self, self.SkillCardOnPress))
    self.eventGameOver = Events.AddListener(Constants.EventNames.BattleGameOverShow, Bind(self, self.ActionWhenGameOver))
    self.eventGetSelectSkillCardPosData = Events.AddListener(Constants.EventNames.UIBattlingDialogGetSelectSkillCardPos, Bind(self, self.OnDragOfSkillCard))
    self.eventBattleBossCutInStart = Events.AddListener(Constants.EventNames.BattleBossCutInStart, Bind(self, self.ShowBossCutIn))
    self.eventBattleBossShowStart = Events.AddListener(Constants.EventNames.BattleBossShowStart, Bind(self, self.BossShowAndRival))
    self.eventBattleRivalEnd = Events.AddListener(Constants.EventNames.BattleBeforeRivalEnd, Bind(self, self.OnBattleRivalEnd))
    self.eventShowSkillCutInStart = Events.AddListener(Constants.EventNames.BattleCutInStart, Bind(self, self.ShowSkillCutIn))
    self.eventBattleTurnStartShow = Events.AddListener(Constants.EventNames.BattleTurnStartShow, Bind(self, self.ShowForceTurn))
    self.eventBattleUIShowState = Events.AddListener(Constants.EventNames.UIBattlingDialogShowState, Bind(self, self.SetBattleUIState))
    self.eventUIBattlingChangeLongIdleCamera = Events.AddListener(Constants.EventNames.UIBattlingChangeLongIdleCamera, Bind(self, self.ShowStateForLongIdleCamera))
    self.eventBattleWavesChange = Events.AddListener(Constants.EventNames.BattleWaveChangeShow, Bind(self, self.BattleWavesChange))
    self.eventShowSkipCGBtn = Events.AddListener(Constants.EventNames.BattleTimelineStart, Bind(self, self.ShowSkipCGBtn))
    self.eventHideSkipCGBtn = Events.AddListener(Constants.EventNames.BattleTimelineEnd, Bind(self, self.HideSkipCGBtn))
    self.eventAllCampInputFinish = Events.AddListener(Constants.EventNames.BattlePlayerInputFinish, Bind(self, self.ActionOnAllCampInputFinish))
    self.eventBattleDropTreasureShow = Events.AddListener(Constants.EventNames.BattleDropTreasureShow, Bind(self, self.OnTreasureDroped))
    self.eventOnCountDownFinish = Events.AddListener(Constants.EventNames.UIBattlingCountDownFinish, Bind(self, self.OnBtnAutoClick))
    self.eventShowGameStart = Events.AddListener(Constants.EventNames.BattleStartGameShow, Bind(self, self.ShowGameStart))
    self.eventBattleRoleEnterEnd = Events.AddListener(Constants.EventNames.BattleRoleEnterEnd, Bind(self, self.OnBattleRoleEnterEnd))
    self.eventBattleFinalDamageShow = Events.AddListener(Constants.EventNames.BattleFinalDamageShow, Bind(self, self.OnBattleFinalDamageShow))
    self.eventBattleInitSkillCat = Events.AddListener(Constants.EventNames.BattleInitSkillCat, Bind(self, self.OnBattleInitSkillCat))
    self.eventBackHandler = Events.AddListener("ANDROID_NATIVE_BACK_ACTION", Bind(self,self.GameOver))
    --- 右上角
    KTool.GetOrAddComponent(self.SettingBtn.gameObject, typeof(UIEventProxy)).onPointerClick = function()
        UIBattlingTools.PlayAudio(UISheets.UI_Menu.ui_menu_click, UISheets.UI_Menu.path)
        self:GameOver()
    end
    KTool.GetOrAddComponent(self.AttributeCircleBtn.gameObject, typeof(UIEventProxy)).onPointerClick = function()
        UIBattlingTools.PlayAudio(UISheets.UI_Menu.ui_menu_click, UISheets.UI_Menu.path)
        self:OnAttriCircleBtnPress()
    end
    -- 关卡提示按钮
    self.levelTipsManager:InitListener()

    --SetButtonAction(self.btnLBTeach:ButtonComponent(), function()
    --    UIBattlingTools.PlayAudio(UISheets.UI_Menu.ui_menu_click, UISheets.UI_Menu.path)
    --    UIModule.OpenDialog({ id = Constants.UITypeIds.UIGamePlayGuideBookDialog })
    --end)
    SetButtonAction(self.btnLBElement:ButtonComponent(), function()
        UIBattlingTools.PlayAudio(UISheets.UI_Menu.ui_menu_click, UISheets.UI_Menu.path)
        UIModule.OpenDialog({ id = Constants.UITypeIds.TrainFieldChooseAttributePopup })
    end)

    KTool.SetActive(self.RootDrag, false)
    local dragProxy = EventDragProxy.Create(self.RootDrag.gameObject)
    local uiEventProxy = UIEventProxy.Create(self.RootDrag.gameObject)
    --dragProxy.onPointerBeginDrag = function (eventData)
    --    Events.Broadcast(Constants.EventNames.UIBattlingCameraSwipeStart, eventData)
    --end
    --dragProxy.onPointerDrag = function (eventData)
    --    Events.Broadcast(Constants.EventNames.UIBattlingCameraSwipe, eventData)
    --end
    uiEventProxy.onPointerDown = Bind(self, self.ActionOnPointerDown)
    dragProxy.onPointerDrag = Bind(self, self.OnDragFun)
    uiEventProxy.onPointerUp = Bind(self, self.ActionOnPointerUp)
    --self.controller.gameObject:AddComponent(typeof(CS.Engine.UI.UIRaycastBlocker))

    self.funOnClick = Bind(self, self.SelectSkillCardTarget)
    --- 卡牌重选 点击函数
    if UIBattleSettingMgr.showUndoBtn then
        local area = self.ReStartSelectCardBtn:Find("area")
        UIEventProxy.Create(area.gameObject).onPointerClick = Bind(self, self.OnReStartSelectCardBtnClick)
    end
    --- 回合跳过点击事件
    SetButtonAction(self.btnPassRound:ButtonComponent(), function()
        self.PassRound(self)
    end)

    -- 初始化跳过大招CG按钮的事件
    self:InitSkipCGBtn()
end

function UIBattlingDialog:RemoveEvent(key, ref)
    if not isNull(ref) then
        Events.RemoveListener(checkString(key), ref)
    end
end

function UIBattlingDialog:RemoveListener()
    self:RemoveEvent(Constants.EventNames.UIBattlingDialogOnCurSkillCardDragEnd, self.eventOnCurSkillCardDragEnd)
    self:RemoveEvent(Constants.EventNames.UIBattlingDialogSetSequenceSkillCard, self.eventSetSequenceSkillCard)
    self:RemoveEvent(Constants.EventNames.BattleMyCard, self.eventBattleMyCard)
    self:RemoveEvent(Constants.EventNames.BattleRequireInput, self.eventBattleRequireInput)
    self:RemoveEvent(Constants.EventNames.UIBattleSkillCardOnPress, self.eventSkillCardInfoShow)
    self:RemoveEvent(Constants.EventNames.BattleGameOverShow, self.eventGameOver)
    self:RemoveEvent(Constants.EventNames.UIBattlingDialogGetSelectSkillCardPos, self.eventGetSelectSkillCardPosData)
    self:RemoveEvent(Constants.EventNames.BattleBossCutInStart, self.eventBattleBossCutInStart)
    self:RemoveEvent(Constants.EventNames.BattleBossShowStart, self.eventBattleBossShowStart)
    self:RemoveEvent(Constants.EventNames.BattleBeforeRivalEnd, self.eventBattleRivalEnd)
    self:RemoveEvent(Constants.EventNames.BattleCutInStart, self.eventShowSkillCutInStart)
    self:RemoveEvent(Constants.EventNames.BattleTurnStartShow, self.eventBattleTurnStartShow)
    self:RemoveEvent(Constants.EventNames.UIBattlingDialogShowState, self.eventBattleUIShowState)
    self:RemoveEvent(Constants.EventNames.UIBattlingChangeLongIdleCamera, self.eventUIBattlingChangeLongIdleCamera)
    self:RemoveEvent(Constants.EventNames.BattleWaveChangeShow, self.eventBattleWavesChange)
    self:RemoveEvent(Constants.EventNames.BattleTimelineStart, self.eventShowSkipCGBtn)
    self:RemoveEvent(Constants.EventNames.BattleTimelineEnd, self.eventHideSkipCGBtn)
    self:RemoveEvent(Constants.EventNames.BattlePlayerInputFinish, self.eventAllCampInputFinish)
    self:RemoveEvent(Constants.EventNames.BattleDropTreasureShow, self.eventBattleDropTreasureShow)
    self:RemoveEvent(Constants.EventNames.UIBattlingCountDownFinish, self.eventOnCountDownFinish)
    self:RemoveEvent(Constants.EventNames.BattleDeleteRoleShow, self.eventBattleDeleteRoleShow)
    self:RemoveEvent(Constants.EventNames.UIBattlingDoubleRateRunning, self.eventGameSpeedChange)
    self:RemoveEvent(Constants.EventNames.BattleStartGameShow, self.eventShowGameStart)
    self:RemoveEvent(Constants.EventNames.BattleRoleEnterEnd, self.eventBattleRoleEnterEnd)
    self:RemoveEvent(Constants.EventNames.BattleFinalDamageShow, self.eventBattleFinalDamageShow)
    self:RemoveEvent(Constants.EventNames.BattleInitSkillCat, self.eventBattleInitSkillCat)
    self:RemoveEvent("ANDROID_NATIVE_BACK_ACTION", self.eventBackHandler)
    self.levelTipsManager:RemoveListener()
    -- 表情事件
    if self.eventSelectEmoji then
        Events.RemoveListener(Constants.EventNames.UIBattlingSelectEmoji, self.eventSelectEmoji)
    end
    if self.eventReceiveEmoji then
        Events.RemoveListener(Constants.EventNames.BattleReceiveEmoji, self.eventReceiveEmoji)
    end
end
------------------------------------------------Event

------------------------------------------------OpenDialog
---OnAttriCircleBtnPress
---长按显示属性克制详情
function UIBattlingDialog:OnAttriCircleBtnPress()
    local panelIsActive = false
    local dialogs = UIModule.CurrentScreen.dialogs
    for i, v in pairs(dialogs) do
        if v.Argument.id == Constants.UITypeIds.UIBattlingAttributeCircleDialog then
            panelIsActive = true
        end
    end
    if not panelIsActive then
        UIBattlingCtrlMgr:GetInstance():SetBooleanOpenDetection(false)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingAttributeCircleDialog })
    end
end

---ShowBossCutIn
---展示 Boss CutIn
---@param data table @ CutInData
function UIBattlingDialog:ShowBossCutIn(data)
    local enemyId = UIBattlingDataMgr:GetCharacterRefIdById(BattleInfo.otherCamp, data.roleId)
    local roleId = data.roleId
    --UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingCutInDialog, parameters = { showType = 1, data = { bossId = enemyId, roleId = roleId } } })
end

---ShowSkillCutIn
---SkillCutIn 展示
---@param data table @ CutInData
function UIBattlingDialog:ShowSkillCutIn(data)
    UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingCutInDialog, parameters = { showType = 2, data = data } })
end

---ShowCharactorInfoDialog
---展示人物信息界面
function UIBattlingDialog:ShowCharacterInfoDialog()
    -- 引导中return
    -- local guideIsRunning = GamePlayGuideMgr and GamePlayGuideMgr.guideIsRunning
    -- if guideIsRunning then
    --     return
    -- end
    -- 自动战斗return
    local isAutoBattle = UIBattleSettingMgr.isAutoBattle
    if isAutoBattle then
        return
    end
    -- 没有长按数据return
    if isNull(self.longTapCharacterData) then
        return
    end

    local characterId = self.longTapCharacterData.id
    local campType = self.longTapCharacterData.camp
    -- 关闭战中屏幕操作检测
    UIBattlingCtrlMgr:GetInstance():SetBooleanOpenDetection(false)
    self:SetBattleUIState(false)
    UIBattlingCtrlMgr:GetInstance():GetBattlingInfoDialogCanvasGroup().alpha = 0
    UIBattlingCtrlMgr:GetInstance():GetBattleBossInfoPanel():SetBossInfoCanBeClicked(false)
    local _funcCallBack = function()
        self:SetBattleUIState(true)
        self:SetSkillCatBtnState(true)
        self:CleanCoShowLongTap(self:SetLongTapSignShowState())
        --BattleViewMgr:StopCharacterCamera()
        UIBattlingCtrlMgr:GetInstance():GetBattlingInfoDialogCanvasGroup().alpha = 1
        UIBattlingCtrlMgr:GetInstance():GetBattleBossInfoPanel():SetBossInfoCanBeClicked(true)
        local unitCat = BattleViewMgr.unitCat
        if unitCat then
            unitCat:SyncUIPosititon()
        end
    end
    UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingCharactorInfoDialog, parameters = { id = characterId, camp = campType, callBack = _funcCallBack } })
    self:CleanCoShowLongTap(self:SetLongTapSignPos(true))
    self.longTapCharacterData = nil
    self.coShowLongTapSign = cs_coroutine.start(function()
        self.longTapSign:ChangeAnim(true)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))
        self:SetLongTapSignShowState()
        self.coShowLongTapSign = nil
    end)
    UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_battle_tips)
end

function UIBattlingDialog:CleanCoShowLongTap(cb)
    if not isNull(self.coShowLongTapSign) then
        cs_coroutine.stop(self.coShowLongTapSign)
        if cb then
            cb()
        end
        self.coShowLongTapSign = nil
    end
end

---ShowLongTapSign
---@param boolean boolean
function UIBattlingDialog:SetLongTapSignShowState(boolean)
    local isAutoBattle = UIBattleSettingMgr.isAutoBattle
    --local isAutoBattle = UIBattlingCtrlMgr:GetInstance().isAutoBattle
    if isAutoBattle then
        return
    end
    local isShow = boolean and not IsNull(self.longTapCharacterData)
    self:SetLongTapSignPos(isShow)
    if isNotNull(self.longTapSign) then
        self.longTapSign:SetProcessState(isShow)
    end
end

function UIBattlingDialog:SetLongTapSignPos(isShow)
    local _GetV3 = function(roleView)
        local goTrans = roleView.transform
        local scale = goTrans.localScale
        local vPosY = roleView.centerY * scale.y
        return UIBattlingTools.WorldPointToUIPoint(Vector3.New(goTrans.position.x, vPosY, goTrans.position.z), self.Root_PTC)
    end
    if isNotNull(self.longTapSign) then
        self.longTapSign:SetNodePosition(isShow and _GetV3(self.longTapCharacterData) or Vector3.New(9999, 9999, 0))
    end
end

---GetRayCastCharacterAction
---获取点击的战场人物执行函数
function UIBattlingDialog:GetRayCastCharacterAction()
    Physics.SyncTransforms()    -- （现在物理的自动更新关掉了）射线检测前先刷新碰撞器位置
    local ray = UIBattlingTools.GetMainCamera():ScreenPointToRay(Input.mousePosition)
    local bool = Physics.Raycast(ray)
    if bool then
        local rayCastHit = KTool.GetRaycastHitByTouch(ray)
        local roleViews = BattleViewMgr.roleViews
        for i = 1, #roleViews do
            local roleView = roleViews[i]
            if not IsNull(roleView) and (not roleView:IsDead()) then
                if roleView.transform == rayCastHit.transform then
                    self.longTapCharacterData = roleView
                    return true
                end
            end
        end
        return false
    end
end

--- 点击boss头像，显示boss详情
function UIBattlingDialog:OnBossHeadBtnClicked()
    local bossId = UIBattlingDataMgr:GetBossId()
    local roleViews = BattleViewMgr.roleViews
    for i = 1, #roleViews do
        local roleView = roleViews[i]
        if not IsNull(roleView) and (not roleView:IsDead()) then
            if roleView.id == bossId then
                self.longTapCharacterData = roleView
                self:ShowCharacterInfoDialog()
                return
            end
        end
    end
end

---GameOver
---游戏中途退出
function UIBattlingDialog:GameOver()
    local IsOpenOp = AppEngine.GetConfig("Engine.Dev", "IsOpenOp")
    local curOp = QuestConfMgr:GetInstance():GetCurOpId()
    if checkNumber(IsOpenOp) > 0 and curOp ~= 0 then
        return
    end
    if checkNumber(KCookie.Get("IsClickUIBattlingDialogQuit")) == 1 then
        return
    end
    KCookie.Set("IsClickUIBattlingDialogQuit", 1)

    local typeQuest = UIBattlingDataMgr:GetQuestType() -- 关卡类型
    if typeQuest == Constants.IDType.QuestLadderStruggle then
        -- UIModule.AddUIPage({ id = Constants.UITypeIds.LadderStruggleBattleAbstractDialog, parameters = {directShowBattleEnd = false}})
        -- GameUtils.OpenLoadingPanel(nil, nil, Constants.LoadingType.MainHome)
        cs_coroutine.start(function()
            local result = LadderStruggleMgr:GetCurrentRoundResult()
            BattleViewMgr:GameOver(result, {})
            KCookie.Set("IsClickUIBattlingDialogQuit", 0)
        end)
    else
        UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingBackToFightReadyDialog })
    end
end
------------------------------------------------OpenDialog

------------------------------------------------PlayerSet

function UIBattlingDialog:InitPlayerSettingBtns()
    self:OnGameSpeedChange(UIBattleSettingMgr.nowGameSpeed)
    if isNull(self.doubleRateEnv) then
        self.doubleRateEnv = CfUtils.GetLuaScr(self.DoubleRateBtnTipsDialog.gameObject, DoubleRateTipsPath)
    end
    self.doubleRateEnv:SetGameSpeed(UIBattleSettingMgr.nowGameSpeed, false)
    self:SetBattleAutoRunningState(UIBattleSettingMgr.isAutoBattle, false)
    -- self:SetSkillSkipState(UIBattleSettingMgr.isSkillSkip)

    -- self.btnLBDoubleRate:ChangeBtnState(UIBattleSettingMgr.isDoubleRate)
    -- self.btnLBAutoGame:ChangeBtnState(UIBattleSettingMgr.isAutoBattle)

    -- self.btnLBDoubleRate:SetBtnInteractableState(UIBattleSettingMgr.canSpeedBtnInteractive)
    SetButtonAction(self.btnLBDoubleRate:ButtonComponent(), function()
        UIBattlingTools.PlayAudio(UISheets.UI_Menu.ui_menu_click, UISheets.UI_Menu.path)
        self.OnBtnDoubleRateClick(self)
    end)

    -- self.btnLBAutoGame:SetBtnInteractableState(UIBattleSettingMgr.canAutoBattleInteractive)
    SetButtonAction(self.btnLBAutoGame:ButtonComponent(), function()
        UIBattlingTools.PlayAudio(UISheets.UI_Menu.ui_menu_click, UISheets.UI_Menu.path)
        self.OnBtnAutoClick(self)
    end)

    -- 不可交互时打开小锁头的图标
    if not UIBattleSettingMgr.canAutoBattleInteractive
            or not UIBattlingCtrlMgr:GetInstance():CheckUnLockStateOfPlayerSetting() then
        KTool.SetActive(self.RT_AutoBtnLock, true)
    else
        KTool.SetActive(self.RT_AutoBtnLock, false)  
    end
    if not UIBattleSettingMgr.canSpeedBtnInteractive
            or not UIBattlingCtrlMgr:GetInstance():CheckUnLockStateOfPlayerSetting() then
        KTool.SetActive(self.RT_SpeedBtnLock, true)
    else
        KTool.SetActive(self.RT_SpeedBtnLock, false)
    end

    -- 大乱斗模式，暂停按钮替换成进入快战斗按钮
    local typeQuest = UIBattlingDataMgr:GetQuestType() -- 关卡类型
    if typeQuest == Constants.IDType.QuestLadderStruggle then
        local RT_Icon = self.SettingBtn:Find("BtnIcon")
        if not isNull(RT_Icon) then
            local SImg_icon = RT_Icon:GetComponent(typeof(CS.Game.Native.Common.UISwitchImage))
            if not isNull(SImg_icon) then
                SImg_icon.Status = 2
            end
        end
    end
end

---SetPlayerPrefsBtnInteractable
---控制 玩家选项 交互状态
---@param boolean boolean
function UIBattlingDialog:SetPlayerPrefsBtnInteractable(boolean)
    self.btnLBAutoGame:SetBtnInteractableState(boolean)
    self.btnLBDoubleRate:SetBtnInteractableState(boolean)
end

function UIBattlingDialog:OnGameSpeedChange(speed)
    if speed ~= 1 then
        self.btnLBDoubleRate:ChangeBtnState(true)
    else
        self.btnLBDoubleRate:ChangeBtnState(false)
    end

    CfUtils.SetUISwitchImage(self.BtnIcon, speed)
end

---OnBtnDoubleRateClick
---两倍速按钮点击事件
function UIBattlingDialog:OnBtnDoubleRateClick()
    if not UIBattlingCtrlMgr:GetInstance():CheckUnLockStateOfPlayerSetting() then
        GameUtils.Toast(Constants.BATTLING_SETTING_DESCRIPTION())
        return
    end
    if not UIBattleSettingMgr.canSpeedBtnInteractive then
        GameUtils.Toast(localize("此关卡锁定倍速"))
        return
    end

    if isNull(self.doubleRateEnv) then
        self.doubleRateEnv = CfUtils.GetLuaScr(self.DoubleRateBtnTipsDialog.gameObject, DoubleRateTipsPath)
    end

    if self.doubleRateEnv.isShow then
        return
    end
    self.doubleRateEnv:OnEntry()
    --if not UIBattleSettingMgr.canSpeedBtnInteractive then 
    --    GameUtils.Toast(localize("关卡锁定按钮状态"))
    --    return 
    --end
    --self.btnLBDoubleRate:SetBtnInteractableState(false)
    --local unlockState = UIBattlingCtrlMgr:GetInstance():CheckUnLockStateOfPlayerSetting()
    --if not unlockState then
    --    GameUtils.Toast(Constants.BATTLING_SETTING_DESCRIPTION)
    --else
    --    local playerUID = UIBattlingCtrlMgr:GetInstance():GetPlayerUID()
    --    local doubleRateBeforeInt = PlayerPrefsUtility.GetEncryptedInt(playerUID .. Constants.PlayerPrefsType.BattleDoubleRateState, 0)
    --    local isDoubleBeforeClick = doubleRateBeforeInt == 1
    --    self:SetDoubleRateState(not isDoubleBeforeClick)
    --    GameUtils.Toast((not isDoubleBeforeClick) and Constants.BATTLING_SETTING_DOUBLE_RATE_ON  or Constants.BATTLING_SETTING_DOUBLE_RATE_OFF)
    --end
    --CoWait.Start():WaitForSeconds(0.15):Next(
    --        function()
    --            self.btnLBDoubleRate:SetBtnInteractableState(true)
    --        end)
end

---SetDoubleRateState
---两倍速状态改变
---@param isDouble boolean 两倍速状态
function UIBattlingDialog:SetDoubleRateState(isDoubleNow)
    --TODO 根据当前速度设置那个图标
    ---- if not UIBattleSettingMgr.canSpeedBtnInteractive then return end
    --UIBattleSettingMgr:SetDoubleRateState(isDoubleNow)
    --self.btnLBDoubleRate:ChangeBtnState(isDoubleNow)
    --Events.Broadcast(Constants.EventNames.UIBattlingDoubleRateRunning, isDoubleNow and 1 or 0)
end

function UIBattlingDialog:OnCountDownAuto()
    local autoBattleStateBeforeClick = UIBattleSettingMgr.isAutoBattle -- 点击前的自动战斗状态
    if not autoBattleStateBeforeClick then
        self:OnBtnAutoClick()
    end
end

---OnBtnAutoClick
---自动战按钮点击事件
function UIBattlingDialog:OnBtnAutoClick()
    if not UIBattlingCtrlMgr:GetInstance():CheckUnLockStateOfPlayerSetting() then
        GameUtils.Toast(Constants.BATTLING_SETTING_DESCRIPTION())
        return
    end
    if not UIBattleSettingMgr.canAutoBattleInteractive then
        GameUtils.Toast(localize("此关锁定自动状态"))
        return
    end
    self.btnLBAutoGame:SetBtnInteractableState(false)
    local autoBattleStateBeforeClick = UIBattleSettingMgr.isAutoBattle -- 点击前的自动战斗状态
    -- print("->UIBattlingDialog:OnBtnAutoClick_UIBattleSettingMgr.isAutoBattle:", UIBattleSettingMgr.isAutoBattle)
    GameUtils.Toast((not autoBattleStateBeforeClick) and Constants.BATTLING_SETTING_BATTLE_AUTO_ON() or Constants.BATTLING_SETTING_BATTLE_AUTO_OFF())
    self:SetBattleAutoRunningState(not autoBattleStateBeforeClick, true)
    CoWait.Start():WaitForSeconds(0.15):Next(
            function()
                self.btnLBAutoGame:SetBtnInteractableState(true)
            end)
end

---SetBattleAutoRunningState
---设置自动战斗状态
function UIBattlingDialog:SetBattleAutoRunningState(autoBattleNow, save)
    -- if not UIBattleSettingMgr.canAutoBattleInteractive then return end
    self.btnLBAutoGame:ChangeBtnState(autoBattleNow)
    self.btnLBAutoGame:ChangeBtnShow(autoBattleNow)
    UIBattleSettingMgr:SetAutoBattleState(autoBattleNow, save)
    -- print("->UIBattlingDialog:SetBattleAutoRunningState_autoBattleNow:", autoBattleNow)
    if autoBattleNow then
        --- 执行自动战斗
        self:SelectAddBuffCharacterBackToDialogLogic() -- 清理 buff 选择中的状态
        -- print("->UIBattlingDialog:SetBattleAutoRunningState_booleanPlayerRoundIsStart:", self.booleanPlayerRoundIsStart)
        if self.isInput then
            KTool.SetActive(self.ProtectGraphic.gameObject, autoBattleNow)
            self:SetBtnRefreshSkillPoolInteractive(not checkBool(autoBattleNow))
            self:BroadcastCanUseSkillCard2Logic() -- 玩家回合需要发送自动战斗消息给逻辑
        end
    else
        local actionUsed = self.curActionPointUsed
        local roundPlayerTeamAliveNum = UIBattlingCtrlMgr:GetInstance():GetMyPlayerActionPoint() -- 当前队伍行动点
        if actionUsed > 0 and actionUsed < roundPlayerTeamAliveNum then
            self:UpdateBtnReselectStatus(true)
        end
    end
end

------------------------------------------------PlayerSet

------------------------------------------------MSG_Sequence
---GetTypeMsgFromLogic
---获取 MsgTypeFun 并 分类执行
---@param data table
function UIBattlingDialog:GetTypeMsgFromLogic(data)
    if data.r == Constants.RecordType.PushCard then
        -- 卡牌补充
        cs_coroutine.yield_return(self:PushSkillCardToSkillCardPool(data))
    elseif data.r == Constants.RecordType.MoveCard then
        -- 卡牌位移
        cs_coroutine.yield_return(self:SkillCardExchangePos(data))
    elseif data.r == Constants.RecordType.UnitCard then
        -- 卡牌合成
        cs_coroutine.yield_return(self:SkillCardUnit(data))
    elseif data.r == Constants.RecordType.UseCard then
        -- 卡牌使用
        cs_coroutine.yield_return(self:SkillCardUsed(data))
    elseif data.r == Constants.RecordType.SyncCard then
        --卡牌同步
        cs_coroutine.yield_return(self:PlayerRoundStart(data))
    elseif data.r == Constants.RecordType.DeleteCard then
        --卡牌移除
        cs_coroutine.yield_return(self:SkillCardDelete(data))
    elseif data.r == Constants.RecordType.ChangeCard then
        --卡牌变换
        cs_coroutine.yield_return(self:SkillCardChange(data))
    elseif data.r == Constants.RecordType.PushCatCard then
        -- 改变猫卡状态
        print("[猫卡] push card", table.dump(data, nil, 3))
        if self.LT_SkillCatNode then
            self.LT_SkillCatNode:RefreshState(data.cc, false)
        end
    end
end

---PlayerRoundStart
---玩家操作开始 并 填充卡池 原始数据(卡牌重新选择使用)
---@param data table
function UIBattlingDialog:PlayerRoundStart(data)
    --Events.Broadcast(Constants.EventNames.UIBattleGuideRoundStart, true)
    self.luaTableDialogSkillPool:FillSkillCardOriginData(data)
    self.luaTableDialogSkillPool:SetAbandonData((data.a))
    self.luaTableDialogSkillPool:AbandonSkillCard()

    if self.LT_SkillCatNode then
        self.LT_SkillCatNode:RefreshState(data.cc, true)
    end
end

---PushSkillCardToSkillCardPool
---从逻辑层获取 补牌序列
---@param logicData table
function UIBattlingDialog:PushSkillCardToSkillCardPool(logicData)
    if IsNull(self.luaTableDialogSkillPool) then
        return
    end
    self:AutoShowHideSkillPool(SkillPoolAutoShowTime, function()
        self.showSkillSequencePanelLB.Env:SetPanelShow(1)       -- 显示技能说明面板
    end, function()
        self.showSkillSequencePanelLB.Env:SetPanelShow(2)       -- 隐藏一下技能展示面板，不隐藏的话会和卡池重叠
    end)
    self.luaTableDialogSkillPool:FillSkillCardShowSequence(logicData)
    self.luaTableDialogSkillPool:ReloadSkillCardPoolListData()
    UIBattlingCtrlMgr:GetInstance():CleanElementRestrainSign()
    cs_coroutine.yield_return(self.luaTableDialogSkillPool:ShowSkillCardsPool())
    UIBattlingCtrlMgr:GetInstance():SetElementRestrainSign(self.curAttTargetId)
    self.luaTableDialogSkillPool:AbandonSkillCard()
    -- print("->UIBattlingDialog:PushSkillCardToSkillCardPool")
end

---SkillCardDelete
---卡牌移除
function UIBattlingDialog:SkillCardDelete(data)
    if #data.pa == 0 then
        return
    end
    --- pa=0的时候表示要删的牌已经没了，其实不用删了
    self:AutoShowHideSkillPool(SkillPoolAutoShowTime, function()
        self.showSkillSequencePanelLB.Env:SetPanelShow(1)       -- 显示技能说明面板
    end, function()
        self.showSkillSequencePanelLB.Env:SetPanelShow(2)       -- 隐藏一下技能展示面板，不隐藏的话会和卡池重叠
    end)
    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))
    -- print("->UIBattlingDialog:SkillCardDelete:", table.dump(data))
    self.luaTableDialogSkillPool:SkillCardDelete(data)
    cs_coroutine.yield_return()
end

---SkillCardChange
---卡牌变换
function UIBattlingDialog:SkillCardChange(data)
    self:AutoShowHideSkillPool(SkillPoolAutoShowTime, function()
        self.showSkillSequencePanelLB.Env:SetPanelShow(1)       -- 显示技能说明面板
    end, function()
        self.showSkillSequencePanelLB.Env:SetPanelShow(2)       -- 隐藏一下技能展示面板，不隐藏的话会和卡池重叠
    end)
    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))
    self.luaTableDialogSkillPool:SkillCardChange(data)
    UIBattlingCtrlMgr:GetInstance():SetElementRestrainSign(self.curAttTargetId)
    cs_coroutine.yield_return()
end

---SkillCardUsed
---卡牌使用消息
function UIBattlingDialog:SkillCardUsed(data)
    if self:IsCatCard(data.d) then
        print("[猫卡] use card", table.dump(data, nil, 3))
        local roleCat = BattleViewMgr:FindRoleView(data.ri)
        local skillCardData = {
            roleId = data.ri,
            skillId = roleCat.finalSkillId,
            star = data.s,
            skillLv = 1,
            skillIndex = data.si,
            catId = roleCat.catId,
        }
        local targetId = data.ti
        local position = self.LT_SkillCatNode:GetWorldPos()
        self:ActionOnSkillCardUsed(skillCardData, targetId, false, position, false)
        UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_skill_card_use)
        if self.LT_SkillCatNode then
            self.LT_SkillCatNode:OnUse()
        end
        return
    end
    local playerId = data.pId
    if UIBattlingTools.IsMyPlayerId(playerId) then
        -- print("[流程] UI use card")
        local line = data.d[2]
        local pos = data.d[1]

        local skillCardData = self.luaTableDialogSkillPool:GetSkillCardData(line, pos)
        if IsNull(skillCardData) then
            return
        end
        local skillCardLocal = self.luaTableDialogSkillPool:GetSkillCardLocal(line, pos)
        local isLock
        if not IsNull(skillCardLocal) then
            -- print("[办卡] 出牌:", skillCardLocal.Env.skillCardRoleId, skillCardLocal.Env.skillIndex, skillCardLocal.Env, skillCardLocal.Env.isLocked)
            isLock = skillCardLocal.Env.isLocked
        end

        self.luaTableDialogSkillPool:SkillCardUsed(line, pos)

        local position = self.luaTableDialogSkillPool:GetSkillCardWorldPos(line, pos)   --- 这个获取position是让卡池里的卡，飞到出卡序列的位置上
        local targetId = data.ti
        local isTeammeat = UIBattlingTools.GetIsInvited(playerId) == 0  -- 是否是队长
        ---出牌序列 数据赋值
        self:ActionOnSkillCardUsed(skillCardData, targetId, isLock, position, isTeammeat)
        UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_skill_card_use)
        self.luaTableDialogSkillPool:SkillCardArrange(line, pos)
        ---卡牌池规整
        --cs_coroutine.yield_return(self.luaTableDialogSkillPool:SkillCardArrange(line, pos))
        ---SP点变化
        -- if self.booleanPlayerRoundIsStart and data.p then
        Events.Broadcast(Constants.EventNames.UIBattlingCharactorBattleInfoDialogCharactorSPAdd, data)

        -- 出牌时，变更临时点数
        local roleId = skillCardLocal.Env.skillCardRoleId
        UIBattlingCtrlMgr:GetInstance():RoleAddTempSP(roleId)

        -- 更新ban卡
        self.luaTableDialogSkillPool:AbandonSkillCard()

        -- end
        if self.booleanPlayerRoundIsStart then
            Events.Broadcast(Constants.EventNames.UIBattlingUseSkillCard, data)
        end
    else
        -- 不是我的角色，是我队友的角色
        local isLockFake = false
        local d = UIBattlingDataMgr:GetSkillIdByCamp(BattleInfo.myCamp, data.ri, data.si)
        local skillCardData = {
            roleId = data.ri,
            skillId = d.skillId,
            star = data.s,
            skillLv = d.SkillLv or 1,
            skillIndex = data.si,
        }
        local targetId = data.ti
        local isTeammeat = UIBattlingTools.GetIsInvited(playerId) == 0  -- 是否是队长
        self:ActionOnSkillCardUsed(skillCardData, targetId, isLockFake, nil, isTeammeat)
    end
    local isAuto = UIBattleSettingMgr.isAutoBattle
    if isAuto then
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.35))
    end
end

---SkillCardUnit
---卡牌合成
---@param data table @ LuaTable
function UIBattlingDialog:SkillCardUnit(data)

    local guideWait = GamePlayGuideMgr and GamePlayGuideMgr.battlingDialogIsWait
    while guideWait do
        cs_coroutine.yield_return()
        guideWait = GamePlayGuideMgr and GamePlayGuideMgr.battlingDialogIsWait
    end
    self:AutoShowHideSkillPool(SkillPoolAutoShowTime, function()
        self.showSkillSequencePanelLB.Env:SetPanelShow(1)       -- 显示技能说明面板
    end, function()
        self.showSkillSequencePanelLB.Env:SetPanelShow(2)       -- 隐藏一下技能展示面板，不隐藏的话会和卡池重叠
    end)
    self.luaTableDialogSkillPool:SkillCardUnit(data)
    local isPlayerMoveAndUnitSameCard = data.im
    if isPlayerMoveAndUnitSameCard then
        self:OnSkillCardMoveFinish() -- 移动卡牌 出现占位牌
        self:SetDefaultStateByInteractionSkillCard()
    end
    UIBattlingCtrlMgr:GetInstance():SetElementRestrainSign(self.curAttTargetId)
    -- if self.booleanPlayerRoundIsStart then
    Events.Broadcast(Constants.EventNames.UIBattlingCharactorBattleInfoDialogCharactorSPAdd, data)
    -- end
end

---SkillCardExchangePos
---技能卡交换位置
---@param data table
function UIBattlingDialog:SkillCardExchangePos(data)
    self.luaTableDialogSkillPool:SkillCardExchangePos(data)
    self:OnSkillCardMoveFinish() -- 移动卡牌 出现占位牌
    self:SetDefaultStateByInteractionSkillCard() -- 重置卡牌池信息
    UIBattlingCtrlMgr:GetInstance():SetElementRestrainSign(self.curAttTargetId) -- 设置克制图标状态
    ---SP点变化
    -- if self.booleanPlayerRoundIsStart then
    Events.Broadcast(Constants.EventNames.UIBattlingCharactorBattleInfoDialogCharactorSPAdd, data)
    -- end
end

--- 显示卡池，time时间后再自动隐藏卡池
---@param time number @ 多长时间后隐藏
---@param mutexPanelShow fun():void @ 显示与卡池互斥的界面
---@param mutexPanelHide fun():void @ 隐藏与卡池互斥的界面
function UIBattlingDialog:AutoShowHideSkillPool(time, mutexPanelShow, mutexPanelHide)
    -- print("[流程] 自动显隐卡池")
    if not isNull(self.coShowRival) then
        return
    end     -- 做战力比拼的时候不自动显示

    if not IsNull(self.coAutoHideSkillPool) then
        cs_coroutine.stop(self.coAutoHideSkillPool)
        self.coAutoHideSkillPool = nil
    end
    -- if not self.boolMineTurnRunning then        -- 当前不在我的操作回合时才显示，我的回合不要显示，可能会导致界面提前出现
    self:SetBottomRightPanelShowState(1, false)
    if not IsNull(mutexPanelHide) then
        mutexPanelHide()
    end
    -- end
    self.coAutoHideSkillPool = cs_coroutine.start(function()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(time))
        if not self.boolMineTurnRunning then
            -- print("->UIBattlingDialog:PushSkillCardToSkillCardPool_coAutoHideSkillPool")
            self:SetBottomRightPanelShowState(2, false)
            if not IsNull(mutexPanelShow) then
                mutexPanelShow()
            end
        end
        self.coAutoHideSkillPool = nil
    end)
end

---DoPlayerLogicSequence
---玩家队伍 执行 逻辑表现
---@param logicMsg table
function UIBattlingDialog:DoPlayerLogicSequence(logicMsg)
    if not IsNull(self.coDoSequence) then
        return
    end
    -- print("[流程] 执行卡牌消息", table.dump(logicMsg, nil ,5))
    self.coDoSequence = cs_coroutine.start(
            function()
                cs_coroutine.yield_return()
                cs_coroutine.yield_return(self:GetTypeMsgFromLogic(logicMsg))
                table.remove(self.playerLogicMsgSequence, 1)
                self.coDoSequence = nil
                cs_coroutine.yield_return()
                --cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.2))
                self:CheckPlayerLogicSequence()
            end)
end

---CheckPlayerLogicSequence
---检查 逻辑消息队列是否有消息未完成
function UIBattlingDialog:CheckPlayerLogicSequence()
    if table.count(self.playerLogicMsgSequence) > 0 then
        self:SetProtectGraphicActiveState(true)
        self:DoPlayerLogicSequence(self.playerLogicMsgSequence[1])
    else
        --- 添加技能卡池当前卡牌情况判断
        --- 有即将合成的卡牌增加延时
        --- 在延时完成后看表现队列，有否有元素
        --- 无元素 解开保护
        --- 有元素 不解开保护
        if self.luaTableDialogSkillPool then
            local hasSkillCardsCanUnite = self.luaTableDialogSkillPool:CheckSkillPoolCanUnite()
            if hasSkillCardsCanUnite then
                for i = 1, 3 do
                    cs_coroutine.yield_return()
                end
                --cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.3))
            end
        end
        if self.booleanPlayerRoundIsStart and table.count(self.playerLogicMsgSequence) < 1 then
            self:SetProtectGraphicActiveState(false)
        end
    end
end

---InsertPlayerMsgSequence
--- 将 logicMsg 加入执行队列
---@param logicMsg table
function UIBattlingDialog:InsertPlayerMsgSequence(logicMsg)
    local myMsg = UIBattlingTools.IsMyPlayerId(logicMsg.pId)
    if myMsg then
        self:AddMyPlayerActionPoint(logicMsg)
    end
    -- 只关注我自己的消息和其他人的使用卡牌消息
    if myMsg or logicMsg.r == Constants.RecordType.UseCard then
        table.insert(self.playerLogicMsgSequence, logicMsg)
        self:CheckPlayerLogicSequence()
        if not myMsg then
            -- print("test InsertPlayerMsgSequence")
        end
    end
end

function UIBattlingDialog:AddMyPlayerActionPoint(logicMsg)
    if logicMsg.r == Constants.RecordType.UseCard or logicMsg.r == Constants.RecordType.MoveCard then
        self.curActionPointUsed = self.curActionPointUsed + 1-- 更新当前已使用行动点
    end
    if logicMsg.r == Constants.RecordType.UnitCard then
        local isPlayerMoveAndUnitSameCard = checkBool(logicMsg.im)
        if isPlayerMoveAndUnitSameCard then
            self.curActionPointUsed = self.curActionPointUsed + 1-- 更新当前已使用行动点
        end
    end
end

------------------------------------------------MSG_Sequence

------------------------------------------------UpgradePlayerTeamAliveState

---UpgradeSkillCardSequenceBGState
--- 更新出牌板 BG 状态
function UIBattlingDialog:UpgradeSkillCardSequenceBGState()
    local roundPlayerTeamAliveNum = UIBattlingCtrlMgr:GetInstance():GetMyCampActionPoint()
    for i = 1, #self.skillSequencePoolBgImgArr do
        self.skillSequencePoolBgImgArr[i].Status = (i > roundPlayerTeamAliveNum) and 2 or 1
    end
end
------------------------------------------------UpgradePlayerTeamAliveState

------------------------------------------------OnBuffSkillCardClick

---OnBuffSkillCardClick
---适用本方单体 Buff
---@param skillCardData XLua.LuaTable
---@param skillCardPosData XLua.LuaTable
function UIBattlingDialog:OnBuffSkillCardClick(skillCard, skillCardPosData, params)
    --- 显示选择角色tips    
    self:ShowInputTips(1)
    --- 隐藏 底部界面
    -- self:SetBottomPanelShowState(2)
    -- self:SwitchFunOnClick(Type_Click.ChooseBuffTarget)
    -- BattleViewMgr:OpenSelectBuffCamera()
    -- self.shiledDrag = true
    if UIBattlingCtrlMgr:GetInstance().tableBattlingBattleInfoDialog then
        UIBattlingCtrlMgr:GetInstance().tableBattlingBattleInfoDialog:SetSelectBuffIconState(true, Bind(self, self.OnSelectAddBuffCharactorLogic))
        self:SetBottomLeftPanelInteractable(false)
        self:SetRootSkillPoolInteractable(false)
        if self.LT_SkillCatNode then
            self.LT_SkillCatNode:SwitchInteractiveState(false)
        end
    end

    -- Events.Broadcast(Constants.EventNames.UIBattleBuffSkill, Bind(self, self.OnSelectAddBuffCharactorLogic), function()
    --     self:SelectAddBuffCharacterBackToDialogLogic()
    --     --if skillCard then
    --     --    skillCard:SetEventReceiverEnableState(true)
    --     --end
    --     UIBattlingCtrlMgr:GetInstance():SetAllSkillCardReceiverActive()
    -- end, skillCard)
    --self:SetSelectCharacterSign(Constants.UIBattlingCharacterType.PlayerTeam, Bind(self, self.OnSelectAddBuffCharactorLogic))
    --- 对本地字段 赋值
    self.characterAddBuffSkillCardPosData = skillCardPosData
    self.characterAddBuffSkillCardPosData.params = params
    KTool.SetActive(self.AttributeCircleBtn.gameObject, false)
end

---SelectAddBuffCharacterBackToDialogLogic
---当没有选中添加目标时的逻辑
function UIBattlingDialog:SelectAddBuffCharacterBackToDialogLogic(cb)
    if isNull(self.characterAddBuffSkillCardPosData) then
        return
    end
    if cb then
        cb()
    end
    --- 显示底部玩家操作栏
    if self.booleanPlayerRoundIsStart then
        self:HideInputTips()
        if not self.anySkillSequenceInput then
            self:ShowInputTips(2)
        end
    end
    KTool.SetActive(self.AttributeCircleBtn.gameObject, true)
    --- 显示玩家选定攻击目标标识
    if checkBool(self.isInput) and (not isNull(self.curAttTargetId)) then
        KTool.SetActive(self.attTargetSign, true)
    end
    --- 对本地字段清空
    self.characterAddBuffSkillCardPosData = nil
    if not IsNull(self.curReselectSkillLuaTable) then
        self.curReselectSkillLuaTable:SetShowStateFinish()
    end
    self.curReselectSkillLuaTable = nil
    -- self:SetBottomPanelShowState(1)
    -- self:SwitchFunOnClick(Type_Click.ChooseAttackTarget)
    -- BattleViewMgr:CloseSelectBuffCamera()
    -- self.shiledDrag = false
    if UIBattlingCtrlMgr:GetInstance().tableBattlingBattleInfoDialog then
        UIBattlingCtrlMgr:GetInstance().tableBattlingBattleInfoDialog:SetSelectBuffIconState(false)
        self:SetBottomLeftPanelInteractable(true)
        self:SetRootSkillPoolInteractable(true)
        if self.LT_SkillCatNode then
            self.LT_SkillCatNode:SwitchInteractiveState(true)
        end
    end
    UIBattlingCtrlMgr:GetInstance():SetAllSkillCardReceiverActive()
end

---OnSelectAddBuffCharactorLogic
---当选择到 添加 Buff 标识
---@param targetId integer @ 目标Id
function UIBattlingDialog:OnSelectAddBuffCharactorLogic(targetId)
    if isNull(self.characterAddBuffSkillCardPosData) then
        return  -- 不知道什么情况下这里会导致这里为空，先保护一下吧
    end
    if not IsNull(targetId) then
        self.characterAddBuffSkillCardPosData.targetId = targetId
    end
    local data2Logic = clone(self.characterAddBuffSkillCardPosData)
    self:SelectAddBuffCharacterBackToDialogLogic()
    --self:AddBuffSignShow(targetId)
    Events.Broadcast(Constants.EventNames.BattleInputUse, data2Logic)
end

---AttackAndAddSelfSkillLogic
---self.skillClickType == 2,3,4（1 友方 2敌方 3全体4自身）的技能处理逻辑
---@param skillCardData table
---@param skillCardPosData table
---@param params table
function UIBattlingDialog:AttackAndAddSelfSkillLogic(skillCardData, skillCardPosData, params)
    if self:FiltrateEnemyTarget(skillCardData.skillId, skillCardData.star) then
        skillCardPosData.targetId = self.curAttTargetId
    end
    skillCardPosData.params = params
    Events.Broadcast(Constants.EventNames.BattleInputUse, skillCardPosData)
end

---FiltrateEnemyTarget
---筛选剔除 队友类型技能  
---@param skillId integer @ 技能牌信息
---@param star integer @ 技能牌信息
function UIBattlingDialog:FiltrateEnemyTarget(skillId, star)
    return UIBattlingTools.GetSkillCardInfoByTwoParam(skillId, star).clickType == 2
end
------------------------------------------------OnBuffSkillCardClick

------------------------------------------------SkillCardInteractable
---OnSkillCardClick
---@param skillCard table @ 技能牌信息
---@param skillCardPosData table @ 技能牌位置信息
function UIBattlingDialog:OnSkillCardClick(skillCard, skillCardPosData)
    local skillCardData = skillCard.skillCardData -- 技能卡数据
    local skillCardVo = UIBattlingTools.GetSkillCardInfoByTwoParam(skillCardData.skillId, skillCardData.star) -- 技能卡配表数据
    local cardBehavior = skillCardVo.cardBehavior --出牌行为
    --local skillClickType = skillCardVo.clickType --技能点选规则（1、友方；2、敌方；3、全体；4、自身）
    --local isEveryone = skillCardVo.isEveryone --是否无需点选（0、需点选；1、不需点选）
    local cardBehaviorParam = skillCardVo.cardBehaviorParam
    if cardBehavior == Constants.CardBehavior.Swallow then
        --卡牌吞噬
        SkillPoolOperationMgr:EatCardOnClick(skillCard)
    elseif cardBehavior == Constants.CardBehavior.Choose and cardBehaviorParam and #cardBehaviorParam > 0 then
        --卡牌抉择
        SkillPoolOperationMgr:PickCardOnClick(skillCard)
    elseif cardBehavior == Constants.CardBehavior.Search then
        --卡牌发现
        SkillPoolOperationMgr:DiscoverCardOnClick(skillCard, skillCardPosData, cardBehaviorParam)
    elseif cardBehavior == Constants.CardBehavior.Upgrade then
        --卡牌升星
        SkillPoolOperationMgr:UpgradeCardOnClick(skillCard)
    else
        self:OnSkillCardClickCommon(skillCard, skillCardPosData)
    end
end

function UIBattlingDialog:OnSkillCardClickCommon(skillCard, skillCardPosData, params)
    local skillCardData = skillCard.skillCardData -- 技能卡数据
    local skillCardVo = UIBattlingTools.GetSkillCardInfoByTwoParam(skillCardData.skillId, skillCardData.star) -- 技能卡配表数据
    local skillClickType = skillCardVo.clickType --技能点选规则（1、友方；2、敌方；3、全体；4、自身）
    local isEveryone = skillCardVo.isEveryone --是否无需点选（0、需点选；1、不需点选）
    if skillClickType == 1 and (not isEveryone) then
        -- 友方 Buff 技能
        self:OnBuffSkillCardClick(skillCard, skillCardPosData, params)
    else
        -- 其他技能
        self:AttackAndAddSelfSkillLogic(skillCardData, skillCardPosData, params)
    end
end

---OnDragOfSkillCard
---技能卡 拖动中
---@param pos Vector3 技能卡位置
---@param curLB table 技能卡 luaTable
function UIBattlingDialog:OnDragOfSkillCard(pos, curLB)
    --if UIBattlingTools.GetSkillCardPosOutOfRange(pos) then
    --    return self:SetDefaultStateByInteractionSkillCard()
    --end
    self:ShowSkillInfo(true, curLB)
    self.luaTableDialogSkillPool:OnDragOfSkillCard(pos, curLB)

    --- 如果有相同的卡，在出牌序列里面展示可以合成的提示
    if not self.showingCanUnitTipAnimation then
        local sameCardArray = self.luaTableDialogSkillPool:GetSkillCardsSameAsSelected(curLB)
        if #sameCardArray > 0 then
            self:OnSkillCardCanUnit()
        end
    end
end

---OnDragEndOfSkillCard
---技能卡 拖动完成
---@param skillCardGO UnityEngine.GameObject
function UIBattlingDialog:OnDragEndOfSkillCard(skillCardGO)
    if self.luaTableDialogSkillPool then
        self.luaTableDialogSkillPool:SetFakerSkillCardShowState(false)
    end
    self:SetProtectGraphicActiveState(true)
    self.coDragEndProtected = cs_coroutine.start(
            function()
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.2))
                if table.count(self.playerLogicMsgSequence) < 1 and self.booleanPlayerRoundIsStart then
                    self:SetProtectGraphicActiveState(false)
                end
            end
    )
    --- 拖动完成逻辑 返回 是否完成卡牌交换
    local isFinishPosExchange = self.luaTableDialogSkillPool:SkillCardDragEnd(skillCardGO)
    --- 如果完成交换
    if not isFinishPosExchange then
        self:SetDefaultStateByInteractionSkillCard()
    end

    --- 如果在播放合卡提示动画，停掉
    if self.showingCanUnitTipAnimation then
        self:OnSkillCardCanUnitCancle()
    end
end
------------------------------------------------SkillCardInteractable

------------------------------------------------RayCast

---ResetAddBuffSkillCardReceiver
---还原点击卡牌的交互
function UIBattlingDialog:ResetAddBuffSkillCardReceiver()
    if self.characterAddBuffSkillCardPosData and self.characterAddBuffSkillCardPosData.pos and self.luaTableDialogSkillPool then
        local dataLine = self.characterAddBuffSkillCardPosData.pos[2]
        local dataPos = self.characterAddBuffSkillCardPosData.pos[1]
        if dataLine and dataPos then
            --- 技能卡牌池 位置对象
            local skillPoolLocal = self.luaTableDialogSkillPool:GetSkillCardByPos(dataLine, dataPos)
            if skillPoolLocal then
                --- 目标位置的 luaBehaviour
                local aimLB = skillPoolLocal.luaBehaviour
                if aimLB and aimLB.Env then
                    local aimLuaTable = aimLB.Env
                    --- 解锁 点击限制
                    aimLuaTable:SetEventReceiverEnableState(true)
                end
            end
        end
    end
end

--- 选择 buff技能 目标（友方）
function UIBattlingDialog:SelectBuffTarget()
    if isNull(self.longTapCharacterData) then
        return
    end
    local roleView = self.longTapCharacterData
    self.longTapCharacterData = nil
    if not BattleInfo:IsUserCamp(roleView.camp) then
        return
    end
    local cantSelect = UIBattlingCtrlMgr:GetInstance():GetRoleFriendInNotClickList(roleView.id)
    if not cantSelect then
        self:OnSelectAddBuffCharactorLogic(roleView.id)
    end
end

---SelectSkillCardTarget
---选择 技能攻击 目标
function UIBattlingDialog:SelectSkillCardTarget()
    self.longTapCharacterData = nil
    Physics.SyncTransforms()    -- -- （现在物理的自动更新关掉了）射线检测前先刷新碰撞器位置
    local ray = UIBattlingTools.GetMainCamera():ScreenPointToRay(Input.mousePosition)
    local bool = Physics.Raycast(ray) -- 模型获取射线
    if bool then
        local enemyTeamDataList = UIBattlingDataMgr:GetTeamListByCamp(BattleInfo.otherCamp)
        local raycastHit = KTool.GetRaycastHitByTouch(ray)
        for i = 1, #enemyTeamDataList do
            local roleId = enemyTeamDataList[i].id -- 角色 Id
            local rolesCanNotBeSelect = UIBattlingCtrlMgr:GetInstance():GetRoleEnemyInNotClickList(roleId) -- 角色不可被点击状态
            if enemyTeamDataList[i].aliveState and not rolesCanNotBeSelect then
                local enemyBattleTable = BattleViewMgr:FindRoleView(roleId)
                if enemyBattleTable then
                    local enemyPos = enemyBattleTable
                    if not IsNull(enemyBattleTable) and enemyPos.transform == raycastHit.transform then
                        self:SetAttackSignState(roleId, enemyPos)
                        break
                    end
                end
            end
        end
    end
end

---SetAttackSignState
---设置选定攻击目标游戏物体状态
---@param characterId number 角色战场唯一ID
---@param characterPos UnityEngine.RectTransform 角色 RectTransform
function UIBattlingDialog:SetAttackSignState(characterId, characterPosInfo)
    --TODO Refactoring
    local enemyPos
    local enemyCenterY
    if characterPosInfo then
        enemyPos = characterPosInfo.transform
        enemyCenterY = characterPosInfo.centerY
    end
    --- 添加 波次 添加 luaTable 的 判空
    local characterPos = IsNull(enemyPos) and BattleViewMgr:FindRoleView(characterId).transform or enemyPos
    if not IsNull(characterPos) then
        if self.curAttTargetId == characterId and self.attTargetSign.gameObject.activeSelf then
            --- 选中取消
            self.curAttTargetId = nil
            self.curAttRoleView = nil
            KTool.SetActive(self.attTargetSign, false)
            UIBattlingCtrlMgr:GetInstance():CleanElementRestrainSign()
        else
            --- 选中
            self.curAttTargetId = characterId
            self.curAttRoleView = BattleViewMgr:FindRoleView(characterId)
            self:SetATCSignPos()
            KTool.SetActive(self.attTargetSign, true)
            UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_battle_select)
            UIBattlingCtrlMgr:GetInstance():SetElementRestrainSign(self.curAttTargetId)
        end
    end
    Events.Broadcast(Constants.EventNames.UIBattlingSelectAttackTarget, self.curAttTargetId or 0)
end

function UIBattlingDialog:SetATCSignPos()
    if isNull(self.curAttRoleView) or isNull(self.attTargetSign) or isNull(self.Root_PTC) or isNull(self.curAttRoleView.transform) then
        return
    end
    local scale = self.curAttRoleView.transform.localScale
    local vPosY = self.curAttRoleView.centerY * scale.y
    local rolePos = self.curAttRoleView.transform.position
    self.attTargetSign.transform.anchoredPosition = UIBattlingTools.WorldPointToUIPoint(Vector3.New(rolePos.x, vPosY, rolePos.z), self.Root_PTC)
end

--function UIBattlingDialog:SetAttackSignPos(roleId)
--    local roleView = BattleViewMgr:FindRoleView(roleId)
--    local roleTrans = roleView.transform
--    local scale = roleView.transform.localScale
--    local vPosY = roleView.centerY * scale.y
--    self.attTargetSign.transform.anchoredPosition = UIBattlingTools.WorldPointToUIPoint(Vector3.New(roleTrans.position.x, vPosY, roleTrans.position.z), self.Root_PTC)
--end

------------------------------------------------RayCast

---SetProtectGraphicActiveState
---设置 Graphic 激活状态
---@param boolean boolean
function UIBattlingDialog:SetProtectGraphicActiveState(boolean)
    local isAutoBattle = UIBattleSettingMgr and UIBattleSettingMgr.isAutoBattle
    if isAutoBattle then
        KTool.SetActive(self.ProtectGraphic.gameObject, true)
        self:SetBtnRefreshSkillPoolInteractive(false)
    else
        KTool.SetActive(self.ProtectGraphic.gameObject, boolean)
        self:SetBtnRefreshSkillPoolInteractive(not checkBool(boolean))
    end
end

---ShowForceTurn
---展示 势力 回合开始
---@param data table
function UIBattlingDialog:ShowForceTurn(data)
    local isMineTurn = data.isMyTurn
    if isMineTurn then
        self.boolMineTurnRunning = true
        UIBattlingCtrlMgr:GetInstance():SetPlayerTeamRoundsNum(data.turn + 1)
        if UIBattlingTools:ShowRoundNum() then
            local curPlayerTeamRoundsNum = UIBattlingCtrlMgr:GetInstance():GetPlayerTeamRoundsNum()
            self.luaTableWaveInfo:SetBattleRoundsValue(curPlayerTeamRoundsNum)
        end
        --- 引导关每回合 引导开始 事件
        -- if GamePlayGuideMgr and GamePlayGuideMgr:IsChapterZero() then
        --     Events.Broadcast(Constants.EventNames.BattleGuideStart)
        -- end
    else
        local curEnemyTeamRoundsNum = UIBattlingCtrlMgr:GetInstance():GetEnemyTeamRoundsNum()
        UIBattlingCtrlMgr:GetInstance():SetEnemyTeamRoundsNum(curEnemyTeamRoundsNum + 1)
    end
    -- self.showSkillSequencePanelLB.Env:ResetPanelCurData() --重置技能卡数据
    self.showSkillSequencePanelLB.Env:SetPanelShow(2) --隐藏技能卡释放队列节点
    -- print("->UIBattlingDialog:ShowForceTurn", table.dump(data))
end

--- 设置PVP界面显隐状态
---@param state any
function UIBattlingDialog:SetPVPInfoUIState(state)
    if UIBattlingPVPMgr then
        local ltPVPDialog = UIBattlingPVPMgr:GetPVPDialog()
        if ltPVPDialog then
            ltPVPDialog:SetPanelState(state)
            -- KTool.SetActive(ltPVPDialog.controller.gameObject, boolean)
        end
    end
end

--- 设置血条界面的显示状态
---@param state any
function UIBattlingDialog:SetBattleInfoUIState(state)
    local infoDialog = UIBattlingCtrlMgr:GetInstance():GetBattlingInfoDialog()
    if not isNull(infoDialog) then
        infoDialog:ChangeCanvasGroupState(state and 0 or 1)
        if state then
            infoDialog:ShowAllCharactorInfoNode()
        else
            infoDialog:HideAllCharactorInfoNode()
        end
    end
end

---SetBattleUIState
--- 设置 UI 面板显示状态
---@param boolean boolean @ 是否显示
function UIBattlingDialog:SetBattleUIState(boolean)
    if not IsNull(self.UIBattlingDialog) then
        if isNotNull(self.luaTableDialogSkillPool) then
            if boolean then
                if not IsNull(self.canvasGroupSkillPoolRoot) and self.canvasGroupSkillPoolRoot.alpha == 1 then
                    self.luaTableDialogSkillPool:SetSPSkillCardPTCShowState(true)
                end
            else
                self.luaTableDialogSkillPool:SetSPSkillCardPTCShowState(false)
            end
        end
        self.UIBattlingDialog.alpha = boolean and 1 or 0
        self.UIBattlingDialog.blocksRaycasts = boolean
        self.UIBattlingDialog.interactable = boolean
        -- print("[流程] SetBattleUIState", boolean, debug.traceback())
        KTool.SetActive(self.Root_PTC.gameObject, boolean)
        self:SetPVPInfoUIState(boolean)
        local dialogBubble = self:GetBattleBubbleDialog()
        if not IsNull(dialogBubble) then
            dialogBubble:SetBubbleState(boolean)
        end
        if not boolean then
            self.levelTipsManager:CloseAllTips()
        end
        self.RightPanel.anchoredPosition = boolean and Vector2.zero or Vector2.New(9999, 9999)
        self.RT_LeftUpLayoutGroup.anchoredPosition = boolean and Vector2.New(320.155, -224.92) or Vector2.New(9999, 9999)
        -- 为了防止猫球特效漏光，关闭UI的时候也关闭猫球按钮
        -- 但是猫球按钮不一定和UI界面整体一起显示，可能会延迟显示，所以会在其他的地方控制激活
        if boolean == false then
            self:SetSkillCatBtnState(false)
        end
    end
end

function UIBattlingDialog:GetBattleBubbleDialog()
    local dialogs = UIModule.CurrentScreen.dialogs
    for i, v in pairs(dialogs) do
        if v.Argument.id == Constants.UITypeIds.UIBattlingBubble then
            return v.Env
        end
    end
end

---BroEventForBackUI
---返回 UI 操作
function UIBattlingDialog:BroEventForBackUI()
    Events.Broadcast(Constants.EventNames.UIBattlingChangeLongIdleCamera, 0)
    if not IsNull(self.UIBattlingDialog) then
        -- print("[流程] BroEventForBackUI", debug.traceback())
        --- 隐藏 面板
        self.UIBattlingDialog:DOFade(1, 0.25)
        --- 面板交互关闭
        self.UIBattlingDialog.interactable = true
        self.UIBattlingDialog.blocksRaycasts = true
        --- 打开射线检测
        UIBattlingCtrlMgr:GetInstance():SetBooleanOpenDetection(true)
        --- 显示所有 Sp 特效
        self.luaTableDialogSkillPool:SetSPSkillCardPTCShowState(true)
    end
end

---ShowStateForLongIdleCamera
---展示长镜头呼吸的界面状态
---@param state integer @ 状态值 1: 启用
function UIBattlingDialog:ShowStateForLongIdleCamera(state)
    local isHide = state == 1
    if not IsNull(self.UIBattlingDialog) then
        --- 隐藏 面板
        self.UIBattlingDialog:DOFade(0, 0.25)
        --- 面板交互关闭
        self.UIBattlingDialog.interactable = not isHide
        self.UIBattlingDialog.blocksRaycasts = not isHide
        --- 打开射线检测
        UIBattlingCtrlMgr:GetInstance():SetBooleanOpenDetection(not isHide)
    end
    --- 关闭所有 Sp 特效显示
    self.luaTableDialogSkillPool:SetSPSkillCardPTCShowState(not isHide)
    --- 控制 玩家选定攻击目标标识状态
    if not IsNull(self.curAttTargetId) then
        KTool.SetActive(self.attTargetSign, not isHide)
    end
end

function UIBattlingDialog:BattleRequireInputFun(logicData)
    if not BattleInfo:IsUserCamp(logicData.camp) then
        return
    end
    if not UIBattlingTools.IsMyPlayerId(logicData.playerId) then
        return
    end

    -------- 从syncCard里面移动过来的流程 --------------
    self.booleanPlayerRoundIsStart = true
    --- 回合开始检测是否有攻击 ID 显示图标 && 更新图标
    if self.curAttTargetId then
        self:SetATCSignPos()
        --self:SetAttackSignPos(self.curAttTargetId)
        UIBattlingCtrlMgr:GetInstance():SetElementRestrainSign(self.curAttTargetId)
        KTool.SetActive(self.attTargetSign, true)
    end
    self:UpdateBtnReselectStatus(false)
    KTool.SetActive(self.Root_PTC.gameObject, true)

    self:StartCardWaitVoiceCo()
    --------------------------------------------------

    self.coRequireInput = cs_coroutine.start(function()
        -- print("[流程] BattleRequireInputFun", logicData.camp, logicData.playerId, table.dump(logicData, nil, 3))
        if GamePlayGuideMgr then
            -- 如果有引导的话，提前打开引导的遮罩，防止玩家点到卡池里的牌
            KTool.SetActive(GamePlayGuideMgr.refGuideDialog.Container.gameObject, true)
            KTool.SetActive(GamePlayGuideMgr.refGuideDialog.Layer_ShowElement.gameObject, true)
            GamePlayGuideMgr.refGuideDialog:SetRaycastReceiverShowState(true)
        end

        --- 重置技能出牌序列
        self:DoWhenClearSkillSequence()
        UIBattlingCtrlMgr:GetInstance():SetMyPlayerActionPoint(logicData.actionPoint)
        UIBattlingCtrlMgr:GetInstance():SetMyCampActionPoint(logicData.campActionPoint)
        --- 从逻辑获取的备选牌数量
        if logicData and logicData.num then
            self.numCanUseByLogic = logicData.num   -- （旧功能用的了，以前lock的牌不能出，所以需要知道可以出的牌的数量，有可能小于行动点数）
        end

        -- 等待开场UI展示结束
        while not isNull(self.coShowBattlingCharacterUI)
                or not isNull(self.coShowWaveStart) do
            cs_coroutine.yield_return()
        end
        -- KTool.SetActive(self.RightPanel.gameObject, true)
        self:SetBattleUIState(true)
        -- cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))

        KTool.SetActive(self.RootDrag.gameObject, true)
        self:UpgradeSkillCardSequenceBGState()
        self.timeInputFinish = 0
        self.isInput = true

        self:SetBattleInfoUIState(true)

        -- 等补牌合卡等动画播放完
        self:CheckLogicMsgSequence()
        Events.Broadcast(Constants.EventNames.UIBattlingViewRequireInput)

        -- 自动显示当前波次配置的关卡提示
        if checkBool(self.signWaveChange) then
            local waveNum = UIBattlingCtrlMgr:GetInstance():GetBattleWave(Constants.Camp.Two) -- 设置战局波次信息
            self.levelTipsManager:AutoShowTips(waveNum)
        end

        --- 引导关每回合 引导开始 事件
        if GamePlayGuideMgr then
            Events.Broadcast(Constants.EventNames.BattleGuideStart)
        end

        --- 自动战斗开启状态下 发送消息到逻辑
        local isAuto = UIBattleSettingMgr.isAutoBattle
        if isAuto then
            self:BroadcastCanUseSkillCard2Logic()
        end
        self:SetSkillCatBtnState(true)
        self:SetBottomPanelShowState(1)
        self:ShowInputTips(2)
        self:SetPassRoundBtnState(true)
        self:SetProtectGraphicActiveState(false)    -- 把保护打开，如果在自动中，那么不会打开
        if self.LT_SkillCatNode then
            self.LT_SkillCatNode:SwitchInteractiveState(true)
        end

        if UIBattleSettingMgr.showUndoBtn
        and self.timeInputFinish == 0 then  -- 托管的时候代码在上面等补牌合卡等动画播放完的时候，牌就已经出完了，这里就不能再打开reset按钮了
            KTool.SetActive(self.ReStartSelectCardBtn.gameObject, true)     -- pvp模式玩家输入完成以后会隐藏重置按钮，这里再打开
        end

        self.coRequireInput = nil
    end)
end

---ActionWhenGameOver
---当 GameOver 时关闭 Update 进程
function UIBattlingDialog:ActionWhenGameOver()
    self.booleanUpdateRunning = false
end

function UIBattlingDialog:SkillCardOnPress(bool, skillCardLB)
    -- print("--->SkillCardOnPress:", checkString(bool), skillCardLB)
    self:ShowSkillInfo(bool, skillCardLB)
    if self.luaTableDialogSkillPool then
        self.luaTableDialogSkillPool:ListSkillCardsShowWBU(bool, skillCardLB)
    end

    if not bool then
        self:SetDefaultStateByInteractionSkillCard()
    end

    -- 黑色半透明遮罩
    self.RT_BackInteractable:GetComponent(typeof(Image)):DOFade(bool and 0.2 or 0, 0.2)

    -- 调整卡牌的layer，让他变的比黑色遮罩高
    skillCardLB.Env:SetCanvasLayer(bool and 4 or -1)
    
    self.tipsCard = bool and skillCardLB or nil -- 记录当前正在展示的卡牌
end

---ShowSkillInfo
---长按显示技能信息
---@param boolean boolean 展示状态
---@param data table
function UIBattlingDialog:ShowSkillInfo(boolean, skillCardLB)
    boolean = checkBool(boolean)
    if boolean then
        if (not checkBool(self.isShowSkillTips)) then
            KTool.SetActive(self.SkillTipsRoot.gameObject, true)
            if not IsNull(skillCardLB) then
                local tipPanelLB = self.SkillTipsRoot:GetComponent(typeof(LuaBehaviour))
                local skillCard = skillCardLB.Env
                if not IsNull(tipPanelLB) and skillCard then
                    local data = {
                        roleId = skillCard.skillCardRoleId,
                        skillId = skillCard.skillCardSkillId,
                        star = skillCard.skillCardStarLevel,
                        skillLv = skillCard.cardSkillLv }
                    tipPanelLB.Env:SetPanelInfo(data)
                end
            end
        end
    else
        KTool.SetActive(self.SkillTipsRoot.gameObject, false)
    end
    self.isShowSkillTips = boolean
end

---OnReStartSelectCardBtnClick
---重置出牌序列点击点击事件
function UIBattlingDialog:OnReStartSelectCardBtnClick()
    ---如果 出牌序列第一个占位牌未使用就不用执行了
    ---如果协程未执行完
    if not self.skillSequenceList[1].Env:GetCardUseState() or not IsNull(self.coReSelect) then
        return
    end
    --- 检测表现队列是否执行完
    self:SetProtectGraphicActiveState(true)
    self:UpdateBtnReselectStatus(false)
    self.coReSelect = cs_coroutine.start(
            function()
                ---向 BattleLogic 广播重置卡牌消息
                Events.Broadcast(Constants.EventNames.BattleInputReset)
                UIBattlingCtrlMgr:GetInstance():CleanElementRestrainSign()
                self.luaTableDialogSkillPool:SetFakerSkillCardShowState(false)
                self.luaTableDialogSkillPool:SetSkillCardPoolDataListDefault()
                self.luaTableDialogSkillPool:ResetSkillCardPushSequence()
                self.luaTableDialogSkillPool:ReloadSkillCardPoolListData()
                --- 重置技能出牌序列
                self:DoWhenClearSkillSequence()
                if self.LT_SkillCatNode then
                    self.LT_SkillCatNode:ResetState()   -- 重置猫球按钮
                end

                cs_coroutine.yield_return(self.luaTableDialogSkillPool:ShowSkillCardsPool())
                UIBattlingCtrlMgr:GetInstance():SetElementRestrainSign(self.curAttTargetId)
                self.luaTableDialogSkillPool:AbandonSkillCard()
                self:SetProtectGraphicActiveState(false)
                self:SetRootSkillPoolInteractable(true) -- 设置玩家技能卡池为可交互状态
                self.coReSelect = nil
            end
    )
end

---FillShowSkillSequenceList
---在玩家操作完成时对 SkillCardSequencePool 的操作
function UIBattlingDialog:FillShowSkillSequenceList()
    if isNull(self.showSkillSequenceList) then
        self.showSkillSequenceList = {}
    end
    if #self.showSkillSequenceList > 0 then
        self.showSkillSequenceList = nil
        self.showSkillSequenceList = {}
    end
    for i = 1, table.count(self.skillSequenceList) do
        if self.skillSequenceList[i].Env:GetSkillCardSequenceType() == 1 then
            table.insert(self.showSkillSequenceList, self.skillSequenceList[i].Env:GetSkillCardData())
        end
    end
end

---ReSetSkillSequence
--- 重置技能出牌序列
function UIBattlingDialog:ReSetSkillSequence()
    for i = 1, table.count(self.skillSequenceList) do
        self.skillSequenceList[i].Env:SetSequeneSkillCardDefaut()
    end
    self.curActionPointUsed = 0
    self.curSequenceId = 0 --- 重置 当前出牌序列 Id
end

---ActionOnSkillCardUsed
---卡牌使用 需要的操作
---@param skillCardData table
---@param targetId integer
---@param isLock boolean
---@param position Vector3 出卡的位置
function UIBattlingDialog:ActionOnSkillCardUsed(skillCardData, targetId, isLock, position, isTeammeat)
    -- 判断是否有任何的卡牌操作已经记录到技能序列里面了，用于技能序列面板的缩放（有卡牌的时候放大，没卡牌的时候缩小）
    if not self.anySkillSequenceInput then
        self.anySkillSequenceInput = true
        self:ScaleSkillCardSequenecePanel(0.9)
        self:HideInputTips()
    end
    self.curSequenceId = self.curSequenceId + 1-- 更新 出牌序列 Id
    for i = 1, table.count(self.skillSequenceList) do
        local skillCardBottom = self.skillSequenceList[i].Env
        if skillCardBottom and (not skillCardBottom:GetCardUseState()) then
            local useCardData = SkillCardSequenceVo.New(skillCardData, targetId, self.curSequenceId, isLock) -- 设置 出牌显示牌
            skillCardBottom:ShowSequeneSkillCard(useCardData, position)
            skillCardBottom:SetTeammeatIconState(isTeammeat)
            break
        end
    end
    self:CheckBroadcastInfoToLogic(self.curActionPointUsed)-- 检查 出牌触发时机
end

---OnSkillCardMoveFinish
---在完成 交换卡牌后 出现占位牌
function UIBattlingDialog:OnSkillCardMoveFinish()
    for i = 1, table.count(self.skillSequenceList) do
        local skillCardBottom = self.skillSequenceList[i].Env
        if skillCardBottom and (not skillCardBottom:GetCardUseState()) then
            skillCardBottom:ShowSequeneSkillCardMove()
            break
        end
    end
    self:CheckBroadcastInfoToLogic(self.curActionPointUsed)
    -- 判断是否有任何的卡牌操作已经记录到技能序列里面了，用于技能序列面板的缩放（有卡牌的时候放大，没卡牌的时候缩小）
    if not self.anySkillSequenceInput then
        self.anySkillSequenceInput = true
        self:ScaleSkillCardSequenecePanel(0.9)
        self:HideInputTips()
    end
end

--- 当技能卡可以合并升星的时候
function UIBattlingDialog:OnSkillCardCanUnit()
    for i = 1, table.count(self.skillSequenceList) do
        local skillCardBottom = self.skillSequenceList[i].Env
        if skillCardBottom and (not skillCardBottom:GetCardUseState()) then
            skillCardBottom:ShowSequeneSkillCardCanUnit()
            break
        end
    end
end

--- 当取消操作的时候
function UIBattlingDialog:OnSkillCardCanUnitCancle()
    for i = 1, table.count(self.skillSequenceList) do
        local skillCardBottom = self.skillSequenceList[i].Env
        if skillCardBottom and (not skillCardBottom:GetCardUseState()) then
            skillCardBottom:HideSequeneSkillCardCanUnit()
            break
        end
    end
end

---CheckBroadcastInfoToLogic
---检查 广播 出牌完成
---@param index integer @ 出牌的次数 last
function UIBattlingDialog:CheckBroadcastInfoToLogic(index)
    -- print("[流程] UI check input finished")
    --- 是否是自动战斗
    --local isAuto = UIBattlingCtrlMgr:GetInstance().isAutoBattle
    local isAuto = UIBattleSettingMgr.isAutoBattle
    local ctrlMgr = UIBattlingCtrlMgr:GetInstance()
    local myPlayerActionPoint = ctrlMgr:GetMyPlayerActionPoint()
    local numLogic = isAuto and self.numCanUseByLogic or myPlayerActionPoint
    local numActionLimit = numLogic < myPlayerActionPoint and numLogic or myPlayerActionPoint
    index = checkInt(index)
    if isAuto then
        --- 自动战斗分支
        if index >= numActionLimit then
            -- self:ActionOnAllCampInputFinish(Constants.InputFinishType.AutoBattle)
            self:ActionOnMyPlayerInputFinish(Constants.InputFinishType.AutoBattle)
        else
            Events.Broadcast(Constants.EventNames.UIBattlingPlayerInteractablePermission)
        end
    else
        --- 手动战斗分支
        if index >= myPlayerActionPoint then
            if self.booleanPassRound then
                self:SetRootSkillPoolInteractable(false) -- 玩家技能卡池关闭交互
            else
                -- self:ActionOnAllCampInputFinish(Constants.InputFinishType.HandleBattle)
                self:ActionOnMyPlayerInputFinish(Constants.InputFinishType.HandleBattle)
            end
        end
        if index > 0 and index < myPlayerActionPoint then
            self:UpdateBtnReselectStatus(true)
        end
    end
end

function UIBattlingDialog:ActionOnMyPlayerInputFinish(type)
    if self.timeInputFinish > 0 then
        return
    end
    self.timeInputFinish = self.timeInputFinish + 1

    -- print("[流程] my input finished")
    if BattleInfo:IsPVP() and UIBattlingPVPMgr then
        local ltPVPDialog = UIBattlingPVPMgr:GetPVPDialog()
        if ltPVPDialog then
            ltPVPDialog:SetWaittingNodeState(true)
        end
    end

    -- 一旦输入完成，就不能再重置了。服务器目前也不支持在finish之后再重置
    KTool.SetActive(self.ReStartSelectCardBtn.gameObject, false)

    self:SetRootSkillPoolInteractable(false)
    self:StopCardWaitVoiceCo()
    self.coDelayInputFinish = cs_coroutine.start(function()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))
        self:CheckLogicMsgSequence()    -- 等卡池表现全部完成，再发送输入完成的消息，不然逻辑收到输入完成直接开打，没给卡池表现留时间了
        -- print("[流程] broadcast input finished")
        Events.Broadcast(Constants.EventNames.BattleInputFinished, type)    -- 联机托管的时候，服务器下发回合结束消息，直接开打，不会等这里的事件
        self.coDelayInputFinish = nil
    end)
end

---ActionOnAllCampInputFinish
---选牌完成
function UIBattlingDialog:ActionOnAllCampInputFinish()
    while self.coRequireInput do        -- 歼灭战里，我自己的角色全部阵亡，只剩下ai队友的时候，出牌会非常快，可能requireInput还没走完，就到这里了
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))
    end

    local _conditionsGuide = GamePlayGuideMgr and GamePlayGuideMgr.listPlayStepSequence and table.count(GamePlayGuideMgr.listPlayStepSequence) > 0
    if checkBool(_conditionsGuide) then
        self.boolGuideRoundFinish = true
        -- return 
    end
    Events.Broadcast(Constants.EventNames.UIBattleGuideRoundStart, false)
    KTool.SetActive(self.RootDrag.gameObject, false)
    -- print("UIBattlingDialog:ActionOnAllCampInputFinish")

    if BattleInfo:IsPVP() and UIBattlingPVPMgr then
        local ltPVPDialog = UIBattlingPVPMgr:GetPVPDialog()
        if ltPVPDialog then
            ltPVPDialog:SetWaittingNodeState(false)
        end
    end

    self.isInput = false
    self.boolMineTurnRunning = false
    self:ClearSkillTargetInfo()
    self:SetRootSkillPoolInteractable(false)
    self:SetBottomLeftPanelInteractable(false)
    KTool.SetActive(self.SkillTipsRoot.gameObject, false)
    self:SetPassRoundBtnState(false)
    self:AutoHidePassRound()
    self:ResetAddBuffSkillCardReceiver()
    self:SetProtectGraphicActiveState(true)

    self:UpdateBtnReselectStatus(false)

    self:HideInputTips()    -- 隐藏出牌提示
    self:SetBottomPanelShowState(2) -- 隐藏底部 panel   -- 加入玩家最后一手操作是合卡，会先触发卡池的自动显隐，卡池隐藏后才到下面的协程里隐藏出牌序列，这样表现很奇怪。所以把这个隐藏的动作从下面的协程里拿上来，尽快执行。
    self:SetSkillCatBtnState(false)
    if self.LT_SkillCatNode then
        self.LT_SkillCatNode:SwitchInteractiveState(false)
    end

    self:FillShowSkillSequenceList() -- 填充需要展示的技能卡
    if #self.showSkillSequenceList > 0 then
        self.showSkillSequencePanelLB.Env:InitShowData(self.showSkillSequenceList)
        self.showSkillSequencePanelLB.Env:SetPanelShow(1)   -- 显示技能说明面板
    end
    self.signWaveChange = nil
    self.campWaveChanged = {}
    self.coBroadToLogic = cs_coroutine.start(
            function()
                if isNull(GamePlayGuideMgr) then
                    self:CheckLogicMsgSequence()
                end
                UIBattlingCtrlMgr:GetInstance():SetAbandonData({})
                self.booleanPlayerRoundIsStart = false
                KTool.SetActive(self.Root_PTC.gameObject, false)

                --- 清空卡牌使用数量
                if self.numCanUseByLogic then
                    self.numCanUseByLogic = nil
                end
                UIBattlingCtrlMgr:GetInstance():SetBooleanPlayerInput(false)
                --- 重置技能出牌序列
                self:DoWhenClearSkillSequence()

                self.levelTipsManager:CloseAllTips()
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))  -- 等关卡说明按钮的动画和特效关闭以后，再隐藏按钮
                
                xTry(function()
                    if not IsNull(UIBattlingCtrlMgr:GetInstance():GetEleBreakLuaTable()) then
                        if not isNull(UIBattlingCtrlMgr:GetInstance():GetEleBreakLuaTable().luaTableElementBreakInfo) then
                            UIBattlingCtrlMgr:GetInstance():GetEleBreakLuaTable().luaTableElementBreakInfo:ShowPanel(false)
                        end
                    end
                end)
            end
    )
end

---CheckLogicMsgSequence
---检查后续 表现队列 是否执行完
function UIBattlingDialog:CheckLogicMsgSequence()
    if not IsNull(self.playerLogicMsgSequence) then
        if #self.playerLogicMsgSequence > 0 then
            while #self.playerLogicMsgSequence > 0 do
                cs_coroutine.yield_return()
            end
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))  -- 这个时间不知道为什么要等那么久，先改短一点看看会不会有问题
            self:CheckLogicMsgSequence()
        else
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))
        end
    end
end

---SetBottomPanelShowState
---设置 BottomPanel (Left and Right) ShowState
---@param state integer @ 1:Show 2:Fade
function UIBattlingDialog:SetBottomPanelShowState(state)
    if BattleInfo.playMode == Constants.PlayMode.Replay
            and state == 1 then
        -- 回放模式播战报太快了，就不显示卡池了，会混乱
        return
    end
    -- print("[流程] 卡池和行动槽显隐", state)
    self:SetBottomLeftPanelShowState(state)
    self:SetBottomRightPanelShowState(state, true)
end

---SetBottomLeftPanelShowState
---设置 BottomLeftPanel
---@param state integer @ 1:Show 2:Fade
function UIBattlingDialog:SetBottomLeftPanelShowState(state)
    if state == 1 then
        if self.BottomLeftPanel.alpha ~= 1 then
            self:SetBottomLeftPanelInteractable(true)
            self.BottomLeftPanel:GetComponent(typeof(CS.UnityEngine.Animation)):Play("BottomLeftPanel_Entry")
            -- self.BottomLeftPanel:DOFade(1, 0.3):SetEase(DOTween.Ease.InOutQuad):OnComplete(
            -- function()
            --     self:SetBottomLeftPanelInteractable(true)
            --     self.BottomLeftPanel:GetComponent(typeof(CS.UnityEngine.Animation)):Play("BottomLeftPanel_Entry")
            -- end)
        else
            self:SetBottomLeftPanelInteractable(true)
        end
    end
    if state == 2 then
        self.BottomLeftPanel:DOFade(0, 0.3):SetEase(DOTween.Ease.InOutQuad)
        self:SetBottomLeftPanelInteractable(false)
        self.BottomLeftPanel:GetComponent(typeof(CS.UnityEngine.Animation)):Play("BottomLeftPanel_Done")
        for i = 1, table.count(self.skillSequenceList) do
            local skillCardBottom = self.skillSequenceList[i].Env
            if skillCardBottom and skillCardBottom:GetCardUseState() then
                skillCardBottom:PlayAnimationMove()
            end
        end
    end
end

---SetBottomRightPanelShowState
---设置 BottomRightPanel
---@param state integer @ 1:Show 2:Fade
function UIBattlingDialog:SetBottomRightPanelShowState(state, withInteractable)
    if state == 1 then
        -- print("[流程] 显示卡池")
        self.isSkillPoolShow = true
        self.SkillCardsPool.anchoredPosition = Vector2.New(11, -4)
        self.canvasGroupSkillPoolRoot:DOFade(1, 0.3):SetEase(DOTween.Ease.InOutQuad):OnComplete(
                function()
                    if self.UIBattlingDialog.alpha == 1 then
                        self.luaTableDialogSkillPool:SetSPSkillCardPTCShowState(true)
                    end
                    if withInteractable and self.curActionPointUsed < UIBattlingCtrlMgr:GetInstance():GetMyPlayerActionPoint() then
                        self:SetRootSkillPoolInteractable(true)
                    end
                end
        )
    end
    if state == 2 then
        -- print("[流程] 隐藏卡池")
        self.isSkillPoolShow = false
        self.luaTableDialogSkillPool:SetSPSkillCardPTCShowState(false)
        self:SetRootSkillPoolInteractable(false)
        self.canvasGroupSkillPoolRoot:DOFade(0, 0.3):SetEase(DOTween.Ease.InOutQuad):OnComplete(
                function()
                    self.SkillCardsPool.anchoredPosition = Vector2.New(9999, 9999)
                end
        )
    end
end

---SetDefaultStateByInteractionSkillCard
---还原交互卡牌的状态
function UIBattlingDialog:SetDefaultStateByInteractionSkillCard()
    self.luaTableDialogSkillPool:SetDefaultStateByInteractionSkillCard()
    ---关闭技能描述 Panel
    KTool.SetActive(self.SkillTipsRoot.gameObject, false)
end

---PassRound
---玩家跳过回合
function UIBattlingDialog:PassRound()
    local isAuto = UIBattleSettingMgr.isAutoBattle
    if isAuto then
        GameUtils.Toast(localize("自动战斗中，不能手动结束回合"))
        return
    end
    if checkNumber(self.timeInputFinish) > 0 then
        return
    end
    local roundPlayerTeamAliveNum = UIBattlingCtrlMgr:GetInstance():GetMyPlayerActionPoint()
    if self.booleanPassRound and self.curActionPointUsed >= roundPlayerTeamAliveNum then
        --- 当前行动点用尽 直接 转换到技能表现阶段
        self:ActionOnMyPlayerInputFinish(Constants.InputFinishType.HandleBattleClickBtn)
    else
        self:SetPassRoundBtnState(false)
        --- 通常流程
        UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingPassRoundDialog, parameters = { sureFun = function()
            self:ActionOnMyPlayerInputFinish(Constants.InputFinishType.HandleBattleClickBtnWithSecondConfirm)
        end, cancelFun = function()
            self:SetPassRoundBtnState(true)
        end, nodePosition = self.RoundPassBtn.position } })
    end
end

function UIBattlingDialog:AutoHidePassRound()
    local dialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.UIBattlingPassRoundDialog)
    if isNotNull(dialog) then
        UIModule.CloseDialog(dialog)
    end
end

---ActionAtTouchEnd
---手指离开屏幕时 执行函数
function UIBattlingDialog:ActionAtTouchEnd()
end

---BroadcastCanUseSkillCard2Logic
---发送出牌许可给逻辑
function UIBattlingDialog:BroadcastCanUseSkillCard2Logic()
    local isAuto = UIBattleSettingMgr.isAutoBattle
    local roundPlayerTeamAliveNum = UIBattlingCtrlMgr:GetInstance():GetMyPlayerActionPoint()
    local numLogic = isAuto and self.numCanUseByLogic or roundPlayerTeamAliveNum
    local numActionLimit = numLogic < roundPlayerTeamAliveNum and numLogic or roundPlayerTeamAliveNum
    if self.curActionPointUsed < numActionLimit then
        Events.Broadcast(Constants.EventNames.UIBattlingPlayerInteractablePermission)
    else
        self:ActionOnMyPlayerInputFinish(Constants.InputFinishType.ClickAutoWhenOpenHandlePass)
    end
end

---GetSkillCardSequenceByRoleId
---通过角色 ID 获取出卡序列示意卡列表
---@param roleId number
function UIBattlingDialog:GetSkillCardSequenceByRoleId(roleId)
    local listSkillCards = {}
    for i = 1, #self.skillSequenceList do
        local curLBSkillCard = self.skillSequenceList[i]
        ---技能卡对象的 LuaBehaviour
        if curLBSkillCard then
            ---技能卡的 LuaTable
            local curLTSkillCard = curLBSkillCard.Env
            if curLTSkillCard then
                local cardRoleId = curLTSkillCard:GetSkillCardRoleId()
                if cardRoleId == roleId then
                    table.insert(listSkillCards, curLTSkillCard)
                end
            end
        end
    end
    return listSkillCards
end

---ChangeSkillCardsAttributeTypeByRoleId
---改变当前角色相关技能卡属性
---@param roleId number 战场角色 ID
---@param attributeType number 属性类型
function UIBattlingDialog:ChangeSkillCardsAttributeTypeByRoleId(roleId, attributeType)
    local aimSkillCards = self.luaTableDialogSkillPool:GetSkillCardsByRoleId(roleId)
    local aimSkillCardSequences = self:GetSkillCardSequenceByRoleId(roleId)
    for i = 1, #aimSkillCards do
        aimSkillCards[i]:ResetCardAttributeType(attributeType)
    end
    for i = 1, #aimSkillCardSequences do
        aimSkillCardSequences[i]:ResetCardAttributeType(attributeType)
    end
end

---BattleWavesChange
---战场波次变化展示
---@param data table @ {waveNum, comp, maxEnterFrame}
function UIBattlingDialog:BattleWavesChange(data)
    -- print("[流程] BattleWavesChange ", data.camp, data.waveNum)
    local camp = data.camp -- 阵营
    local waveNum = data.waveNum --波次数值
    local listCondition = BattlingCombatLevelMgr:GetQuestMissionData(UIBattlingDataMgr.questId, waveNum)
    if listCondition and #listCondition > 0 then
        local panel = self:LoadTrainingTargetPanel()
        panel:SetMissionList(listCondition)
    end
    UIBattlingCtrlMgr:GetInstance():SetBattleWave(waveNum, camp) -- 设置战局波次信息

    --- 在波次切换时刷新 UI 节点显示
    self.showSkillSequencePanelLB.Env:SetPanelShow(2)
    -- self:DoWhenClearSkillSequence()
    self.signWaveChange = true
end

--- 角色入场结束，开始显示UI
---@param waveNum any
function UIBattlingDialog:OnBattleRoleEnterEnd(waveNum, hasBoss)
    -- print("[流程] 角色入场结束", waveNum)
    if waveNum == 1 then
        self:ShowBattlingCharacterUI()
    else
        if hasBoss then
            -- 有boss展示的话，跳过波次展示，直接设置波次
            if self.luaTableWaveInfo and UIBattlingTools:ShowWaveNum() then
                self.luaTableWaveInfo:SetWaveInfo(waveNum)
            end
            -- 如果是多阶段boss，设置阶段数
            if self.isMultiStage then
                self.LB_MultiStageGroup:SetStage(waveNum)
            end
        else
            -- 没有boss播放波次展示
            self:ShowWaveStart(waveNum)
        end
    end
end

--- boss秀和战力比拼
---@param bossView any
---@param useBossShow any
function UIBattlingDialog:BossShowAndRival(useBossShow, useRival)
    if useBossShow == 0 and useRival == 0 then
        Events.Broadcast(Constants.EventNames.BattleBossEnterEnd)
        return
    end
    self.co_bossShow = cs_coroutine.start(function()
        -- 获取角色数据
        local data = UIBattlingDataMgr:GetBossData()
        if isNull(data) then
            data = UIBattlingDataMgr:GetRoleDataByIndex(BattleInfo.otherCamp, 1)
        end
        local bossView = BattleViewMgr:FindRoleView(data.id)

        -- 隐藏战中UI
        self:SetBattleUIState(false)
        self:SetBattleInfoUIState(false)

        -- boss秀
        local cameraGO
        if useBossShow == 1 then
            -- print("[流程] 开始boss秀")
            -- local bossShowDelayTime = checkInt(bossView.modelVo.bossTime)
            -- cs_coroutine.yield_return(Yielders.GetWaitForSeconds(bossShowDelayTime))    -- boss入场动画开始播放以后，延迟多久开始拉近镜头
            local bossCamPosition = bossView.modelVo.camPosition or Vector3.New(1.3, 0.75, 3.6)
            local bossCamRotation = Quaternion.Euler(bossView.modelVo.camRotation.x, bossView.modelVo.camRotation.y, bossView.modelVo.camRotation.z)

            -- 相机瞬切怼脸
            CfUtils.ChangeMainCamDefalultBlend(0)
            cameraGO = GameObject("BossShow")
            cameraGO.transform:SetParent(bossView.cameraAttach, false)
            local vcam = cameraGO:AddComponent(typeof(CinemachineVirtualCamera))
            cameraGO.transform.localPosition = bossCamPosition
            cameraGO.transform.localRotation = bossCamRotation

            -- boss秀
            UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingBossShowDialog, parameters = { bossInfo = bossView } })
            -- 0.15s推进加模糊
            BattleViewMgr:AddRadialBlur()
            BattleViewMgr:VCamPushLens(vcam, 30, 50, 0.15)
            BattleViewMgr:RemoveRadialBlur()

            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1.4 - 0.15))  -- boss秀的时长
        end

        if useRival == 1 then
            -- 战力比拼
            -- print("[流程] 开始战力比拼")
            UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingRivalDialog, parameters = { rivalInfo = bossView } })

            -- 等战力比拼通知结束
            self.waittingRivalEnd = true
            while self.waittingRivalEnd do
                cs_coroutine.yield_return(nil)
            end
        end

        if useBossShow == 1 then
            -- 恢复镜头
            KTool.SafeDelete(cameraGO)
        end

        if useRival == 1 then
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))  -- 战力比拼结束
        end

        Events.Broadcast(Constants.EventNames.BattleBossEnterEnd)

        self.co_bossShow = nil
    end)
end

function UIBattlingDialog:OnBattleRivalEnd()
    self.waittingRivalEnd = false
end

--- 展示游戏开始
function UIBattlingDialog:ShowGameStart()
    -- print("[流程] 播放战斗开始UI")
    UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattleStartDialog })
end

--- 展示波次开始（有战力比拼就没有波次展示）
---@param waveNum integer @ 波次数
function UIBattlingDialog:ShowWaveStart(waveNum)
    if waveNum == 1 then
        return
    end
    if not UIBattlingTools:ShowWaveNum() then
        return
    end
    self.coShowWaveStart = cs_coroutine.start(function()
        --- 敌方波次
        -- print("[流程] 播放波次开始UI")
        UIBattlingCtrlMgr:GetInstance():SetBooleanWaveDialogShowState(true)
        local paraList = { id = Constants.UITypeIds.UIBattlingWaveChangeDialog, parameters = { numWaveNow = waveNum } }
        UIModule.OpenDialog(paraList)
        if self.luaTableWaveInfo and UIBattlingTools:ShowWaveNum() then
            self.luaTableWaveInfo:SetWaveInfo(waveNum)
        end
        -- 如果是多阶段boss，设置阶段数
        if self.isMultiStage then
            self.LB_MultiStageGroup:SetStage(waveNum)
        end
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))
        self.coShowWaveStart = nil
    end)
end

--- 显示战中角色UI(在战力比拼和波次开始之后)
function UIBattlingDialog:ShowBattlingCharacterUI()
    self.coShowBattlingCharacterUI = cs_coroutine.start(function()

        -- print("[流程] 显示战斗UI")
        -- if not BattleInfo:IsOnline() then
            self:ShowBattleUI()
        -- end

        -- 打开血条
        -- print("[流程] 打开血条")
        self:SetBattleInfoUIState(true)

        -- 展示被动buff
        -- print("[流程] 展示被动buff")
        local waitTime, catBuffWaitTime = UIBattlingCtrlMgr:GetInstance():GetBattlingInfoDialog():ShowPassiveBuff()
        local remainTime = waitTime - catBuffWaitTime
        local catAheadOfTime = 0.7
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(catBuffWaitTime - catAheadOfTime))
        -- 被动猫球入场
        local cat = BattleViewMgr:GetSkillCat(BattleInfo.myCamp, 2)
        if cat then
            cat:PlayPassiveEnter()
        end
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(remainTime + catAheadOfTime))

        -- 联机模式第一回合请求回合开始
        if BattleInfo:IsOnline() then
            BattleViewMgr:RequireFirstTurnStart()
            -- cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.05))    -- 等消息回来，然后显示卡池和战斗UI
            -- self:ShowBattleUI()
        end

        self.coShowBattlingCharacterUI = nil
    end)
end

---SetDialogRootState
---设置 Dialog 节点的状态
function UIBattlingDialog:SetDialogRootState()
    local playMode = UIBattlingCtrlMgr:GetInstance().playMode
    if playMode == Constants.UIPlayMode.Replay then
        self.canvasGroupSkillPoolRoot.blocksRaycasts = false
        self.BottomLeftPanel.blocksRaycasts = false
        self.booleanPassRound = false --手动跳过回合
    end
end

---SetRootSkillPoolInteractable
---设置技能卡池可交互状态
---@param boolean boolean
function UIBattlingDialog:SetRootSkillPoolInteractable(boolean)
    local playMode = UIBattlingCtrlMgr:GetInstance().playMode
    if self.canvasGroupSkillPoolRoot and not (playMode == Constants.UIPlayMode.Replay) then
        self.canvasGroupSkillPoolRoot.blocksRaycasts = boolean
        -- print("[流程] 卡池遮罩", not boolean, debug.traceback())
    end
end

---SetBottomLeftPanelInteractable
---设置出牌序列池交互状态
---@param boolean boolean
function UIBattlingDialog:SetBottomLeftPanelInteractable(boolean)
    local playMode = UIBattlingCtrlMgr:GetInstance().playMode
    if self.BottomLeftPanel and not (playMode == Constants.UIPlayMode.Replay) then
        self.BottomLeftPanel.blocksRaycasts = boolean
    end
end

function UIBattlingDialog:CheckTargetIdAndCleanAttackTarget(roleId)
    if self.curAttTargetId and self.curAttTargetId == roleId then
        self:ClearAttackTarget()
    end
end

---ClearAttackTarget
---清理攻击目标数据 和 表现
function UIBattlingDialog:ClearAttackTarget()
    self.curAttTargetId = nil
    Events.Broadcast(Constants.EventNames.UIBattlingSelectAttackTarget, 0)
    UIBattlingCtrlMgr:GetInstance():CleanElementRestrainSign()
    if not IsNull(self.attTargetSign) then
        KTool.SetActive(self.attTargetSign, false)
    end
end

---ClearSkillTargetInfo
---清除 选择目标信息
function UIBattlingDialog:ClearSkillTargetInfo()
    KTool.SetActive(self.attTargetSign, false)
end

function UIBattlingDialog:InitBtnReselectComp()
    local goBtnReselect = self.ReStartSelectCardBtn.gameObject
    local pathBtnImg = "Btn_Img"
    local pathBtnTxt = "Btn_Img/Text"
    if not IsNull(goBtnReselect) then
        local transImg = goBtnReselect.transform:Find(pathBtnImg)
        local transTxt = goBtnReselect.transform:Find(pathBtnTxt)
        if not IsNull(transImg) then
            self.siReselectBtn = KTool.GetOrAddComponent(transImg.gameObject, typeof(CS.Game.Native.Common.UISwitchImage))
        end
        if not IsNull(transTxt) then
            self.stReselectBtn = KTool.GetOrAddComponent(transTxt.gameObject, typeof(CS.Game.Native.Common.UISwitchText))
        end
    end
    self:UpdateBtnReselectStatus(false)

    local area = self.ReStartSelectCardBtn:Find("area")
    if not isNull(area) then
        local compArea = KTool.GetOrAddComponent(area.gameObject, typeof(NonDrawingGraphic))
        self.refBtnAreaRefreshSkillPool = compArea
    end
end

function UIBattlingDialog:UpdateBtnReselectStatus(isAct)
    if not UIBattleSettingMgr.showUndoBtn then
        return
    end
    if not IsNull(self.siReselectBtn) then
        self.siReselectBtn.Status = isAct and 1 or 2
        self.siReselectBtn:Reset()
    end
    if not IsNull(self.stReselectBtn) then
        self.stReselectBtn.Status = isAct and 1 or 2
        self.stReselectBtn:Reset()
    end
end

function UIBattlingDialog:SetRoot_PTCShow(bool)
    if not IsNull(self.Root_PTC) then
        KTool.SetActive(self.Root_PTC.gameObject, bool)
    end
end

function UIBattlingDialog:SwitchImgBtnAttribute(typeElement)
    if IsNull(self.btnAttributeImgSwitch) then
        local transBtnIcon = self.AttributeBtn:Find("BtnIcon")
        if not IsNull(transBtnIcon) then
            self.btnAttributeImgSwitch = KTool.GetComponent(transBtnIcon.gameObject, typeof(ImageAlterable))
        end
    end
    xTry(function()
        if not IsNull(self.btnAttributeImgSwitch) then
            self.btnAttributeImgSwitch:LoadSprite(CardUtils.GetCardAttrIconPath(typeElement))
        end
    end)
end
------------ Interactive ------------

function UIBattlingDialog:ActionOnPointerDown(eventData)
    if self.coInteractive then
        return
    end
    self.posPointerD = eventData.position
    self:GetRayCastCharacterAction()
    self.coInteractive = cs_coroutine.start(function()
        self.typeInteractive = Type_Interaction.Click
        cs_coroutine.yield_return(CS.UnityEngine.WaitForSecondsRealtime(TIME_LENGTH_2_PRESS))
        self.typeInteractive = Type_Interaction.PressStart
        cs_coroutine.yield_return(CS.UnityEngine.WaitForSecondsRealtime(DEFAULT_PRESS_DETECTION_TIME))
        self.typeInteractive = Type_Interaction.PressFinish
        self:ShowCharacterInfoDialog()
        --self:OnDragStartFun(pointerData)
    end)
end
function UIBattlingDialog:OnDragFun(eventData)
    if self.shiledDrag then
        return
    end
    if self.typeInteractive ~= Type_Interaction.Drag then
        local dis = Vector2.Distance(eventData.position, self.posPointerD)
        if dis >= Click_Fault_Tolerance then
            self.typeInteractive = Type_Interaction.Drag
            if self.coInteractive then
                cs_coroutine.stop(self.coInteractive)
                self.coInteractive = nil
            end
            Events.Broadcast(Constants.EventNames.UIBattlingCameraSwipeStart, eventData)
        end
    end
    if not (self.typeInteractive == Type_Interaction.Drag) then
        return
    end
    Events.Broadcast(Constants.EventNames.UIBattlingCameraSwipe, eventData)
end

function UIBattlingDialog:ActionOnPointerUp(pointerData)
    if self.coInteractive then
        cs_coroutine.stop(self.coInteractive)
        self.coInteractive = nil
    end
    if self.typeInteractive == Type_Interaction.Click and (not IsNull(pointerData)) and Vector2.Distance(pointerData.position, self.posPointerD) > Click_Fault_Tolerance then
        self.typeInteractive = Type_Interaction.None
    end
    self:SwitchInteraction(self.typeInteractive)
    self.typeInteractive = Type_Interaction.None
end

function UIBattlingDialog:SwitchInteraction(type)
    -- print("->UIBattlingDialog:SwitchInteraction", type)
    if type == Type_Interaction.Click then
        self:SelectAddBuffCharacterBackToDialogLogic()
        if not IsNull(self.funOnClick) then
            self:funOnClick()
        end
    end
end

--- 切换点击的响应函数
---@param type any
function UIBattlingDialog:SwitchFunOnClick(type)
    if type == Type_Click.ChooseBuffTarget then
        self.funOnClick = self.SelectBuffTarget
    else
        self.funOnClick = self.SelectSkillCardTarget
    end
end

function UIBattlingDialog:SetBtnRefreshSkillPoolInteractive(bool)
    bool = checkBool(bool)
    if not IsNull(self.refBtnAreaRefreshSkillPool) then
        self.refBtnAreaRefreshSkillPool.enabled = bool
    end
end

------------ Interactive ------------

--- 清空出牌序列时要做的一系列操作
function UIBattlingDialog:DoWhenClearSkillSequence()
    self:ReSetSkillSequence()
    self.anySkillSequenceInput = false
    self:ScaleSkillCardSequenecePanel(0.75)
    -- 刷新出卡序列，也刷新提示，但要判断出卡序列有没有显示出来
    if self.isSkillPoolShow then
        self:ShowInputTips(2)
    end

    -- 回合开始，刷新临时点数
    UIBattlingCtrlMgr:GetInstance():RoundStartResetTempSp()
end

--- 缩放skillCardSequence面板
---@param scale number 缩放倍数
function UIBattlingDialog:ScaleSkillCardSequenecePanel(scale)
    -- self.BottomLeftPanel.transform:DOScale(scale, 0.15):SetEase(Ease.OutElastic)
    self.BottomLeftPanel.transform.localScale = Vector3.one * scale
    self.ReStartSelectCardBtn.transform.localScale = Vector3.one * self.restartDefaultScale / scale
    self.RoundPassBtn.transform.localScale = Vector3.one * self.passRoundDefaultScale / scale
end

--- 显示提示玩家进行输入的图标
---@param type integer @ 类型（1：选择角色，2：选择出牌）
function UIBattlingDialog:ShowInputTips(type)
    if true then
        return
    end
    if not UIBattleSettingMgr.showInputTips then
        return
    end
    if type == 1 then
        -- local direction = 1
        -- local strTips = UIBattlingDataMgr:GetBattleTipsData(3)
        -- local parent = self.BattleRoleIInfoGroup.transform:GetChild(0)
        -- self.LT_CardTipsNode:SetTips(direction, strTips, parent)
        -- self.LT_CardTipsNode:Show()
    elseif type == 2 then
        local direction = 2
        local strTips = UIBattlingDataMgr:GetBattleTipsData(2)
        local parent = self.BottomRightPanel.transform
        self.LT_CardTipsNode:SetTips(direction, strTips, parent)
        self.LT_CardTipsNode:Show()
    end
end

function UIBattlingDialog:HideInputTips()
    if not UIBattleSettingMgr.showInputTips then
        return
    end
    self.LT_CardTipsNode:Hide()
end

function UIBattlingDialog:InitSkipCGBtn()
    local btn = self.SkipCGBtn:GetComponent(typeof(CS.UnityEngine.UI.Button))
    btn.onClick:AddListener(Bind(self, self.OnSkipCGBtnClicked))
end

function UIBattlingDialog:OnSkipCGBtnClicked()
    Events.Broadcast(Constants.EventNames.UIBattlingSkipSpCG)
end

function UIBattlingDialog:ShowSkipCGBtn()
    if self.SkipCGBtn then
        KTool.SetActive(self.SkipCGBtn.gameObject, true)
    end
end

function UIBattlingDialog:HideSkipCGBtn()
    if self.SkipCGBtn then
        KTool.SetActive(self.SkipCGBtn.gameObject, false)
    end
end

function UIBattlingDialog:SetPassRoundBtnState(state)
    local questType = UIBattlingDataMgr:GetQuestType()
    if AnnihilationUtils.QuestTypeIsAnnihilation(questType) then
        return
    end
    KTool.SetActive(self.btnPassRound.controller.gameObject, state)
end

--- 宝箱掉落
---@param data table {quality = 1}
function UIBattlingDialog:OnTreasureDroped(data)
    local quality = data.quality
    local num = 1
    if IsNull(self.LT_BattlingTreasureGroup) then
        self.LB_TreasureRoot:Init()
        self.LT_BattlingTreasureGroup = self.LB_TreasureRoot.Env
        KTool.SetActive(self.LB_TreasureRoot.gameObject, true)
    end
    self.LT_BattlingTreasureGroup:AddTreasure(quality, num)
end

--- 尾刀UI展示
function UIBattlingDialog:OnBattleFinalDamageShow()
    UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattlingFinalBlowDialog })
end

--- 根据卡牌位置判断是否是猫卡
---@param pos any
function UIBattlingDialog:IsCatCard(pos)
    return pos[1] == -1 and pos[2] == -1
end

--- 初始化猫球数据
---@param record any
function UIBattlingDialog:OnBattleInitSkillCat(record)
    UIBattlingDataMgr:AddSkillCat(record)

    -- 只关注玩家自己的主动猫球
    if BattleInfo:IsUserCamp(record.c)
    and BattleInfo:IsMyPlayerId(record.pId)
    and record.t == 1 then
        KTool.SetActive(self.RT_SkillCatNode, true)
        local LB_Node = GetLuaBehaviour(self.RT_SkillCatNode.gameObject, "Game.UI.UIBattling.UIBattlingSkillCatNode")
        self.LT_SkillCatNode = LB_Node.Env
        self.LT_SkillCatNode:InitData(record)
        self.LT_SkillCatNode:InitComponent()
        self.LT_SkillCatNode:SetUIBattlingDialog(self)
        self:SetSkillCatBtnState(false)
    end
end

--- 设置猫球按钮显示状态
---@param state any
function UIBattlingDialog:SetSkillCatBtnState(state)
    if self.LT_SkillCatNode then
        self.LT_SkillCatNode:SetShowState(state)
    end
end

---开启卡牌待机语音co, 15s播放一次，30s播放一次
function UIBattlingDialog:StartCardWaitVoiceCo()
    if isNotNull(self.coWaitVoice) then return end
    
    self.coWaitVoice = cs_coroutine.start(function ()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(15))
        self:PlayCardWaitVoice()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(15))
        self:PlayCardWaitVoice()
    end)
end

---播放卡牌待机语音
function UIBattlingDialog:PlayCardWaitVoice()
    local t = {}
    local roleViews = BattleViewMgr.roleViews
    for _, v in ipairs(roleViews) do
        if v.isPlayer and not v:IsDead() then
            table.insert(t, v.typeId)
        end
    end
    local cardId = t[math.random(1, #t)]
    if not cardId then return end
    
    RoleVoiceMgr:GetInstance():PlayBattleWaitVoiceByCardId(cardId)
end

---关闭卡牌待机语音co
function UIBattlingDialog:StopCardWaitVoiceCo()
    if not IsNull(self.coWaitVoice) then
        cs_coroutine.stop(self.coWaitVoice)
        self.coWaitVoice = nil
    end
end

function UIBattlingDialog:ShowBattleUI()
    if not IsNull(self.UIBattlingDialog) then
        self:SetBattleUIState(true)
        -- 左上角按钮组入场动画
        self:PlayLeftUpUIEntryAnimation()
        -- 波次的初始化动画
        if UIBattlingTools:ShowWaveNum() then
            self.luaTableWaveInfo:PlayInitAnimation()
        end
        -- boss头像入场动画
        UIBattlingCtrlMgr:GetInstance():GetBattleBossInfoPanel():BossAnimatorPlay("CharactorI_Enter")
        self:SetRootSkillPoolInteractable(false)
        if self.LT_SkillCatNode then
            self.LT_SkillCatNode:SwitchInteractiveState(false)
        end
        -- cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1.5))    -- 此时显示卡池的record应该正好进来，等待卡池动画播完
        self:SetSkillCatBtnState(true)
    end
end

--- 播放战中界面左上角UI的入场动画
function UIBattlingDialog:PlayLeftUpUIEntryAnimation()
    local animation = self.RT_LeftUpLayoutGroup.transform:GetComponent(typeof(CS.UnityEngine.Animation))
    animation:Play("LeftUpLayoutGroup_go")
end

return UIBattlingDialog
--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2019-12-04 18:37:44
]]
AnimFrameTime = 0.033

local RoleView = import("Game.BattleView.Entity.RoleView")
local SDKService = import("Game.Entry.SDKService")
local SignalReceiver = CS.UnityEngine.Timeline.SignalReceiver
local RecordInterpreter = CS.RecordInterpreterConsole
local AppEngine = CS.Engine.Lib.AppEngine
local CameraExtensions = CS.UnityEngine.Camera
local AnimationCurve = CS.UnityEngine.AnimationCurve
local Keyframe = CS.UnityEngine.Keyframe
local WaitForSecondsRealtime = CS.UnityEngine.WaitForSecondsRealtime
local Time = CS.UnityEngine.Time
---@class BattleViewMgr
local BattleViewMgr = {}
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local ResourceModule = CS.Engine.Modules.ResourceModule
local GameObject = CS.UnityEngine.GameObject
local SkinnedMeshRenderer = CS.UnityEngine.SkinnedMeshRenderer
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local UIModule = CS.Engine.UI.UIModule
local KCookie = CS.Engine.Lib.KCookie
---@type CriWareUtils
local CriWareUtils =  import('Game.Entry.CriWareUtilsFix')
local AnnihilationUtils = import('Game.UI.FightReady.UIMainChapter.AnnihilationUtils')

local KTool = CS.Engine.Lib.KTool

local settingMgr = SettingMgr:GetInstance()
local cardConfMgr = CardConfMgr:GetInstance()
local gameUtils = CS.GameUtils
local Yielders = CS.Engine.Lib.Yielders

local CinemachineBrain = CS.Cinemachine.CinemachineBrain
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local CinemachineBlendDefinition = CS.Cinemachine.CinemachineBlendDefinition
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local RotateMode = CS.DG.Tweening.RotateMode
local LoopType = CS.DG.Tweening.LoopType
local DOTween = CS.DG.Tweening.DOTween
local Ease = CS.DG.Tweening.Ease
local XLuaUtils = CS.Engine.Lib.XLuaUtils
local Animator = CS.UnityEngine.Animator
local CameraCustomData = CS.CameraCustomData
local OverrideModes = CS.Cinemachine.LensSettings.OverrideModes

BattleTag = 666
BattleMusicTag = 667


local util = require "XLua.util"
local cs_coroutine = import("XLua.cs_coroutine")
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")

local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
local LogEnableKey = "recordInterpreterConsoleLogEnable";
local SkipChapterPlotKey = "skipChapterPlot";
local ShowAILogKey = "showAILog";
local ShowBuffLogKey = "showBuffLog"
local ShowFilterLogKey = "showFilterLog"
local LowShadowCheckToolInBattle = import("Game.CheckTools.LowShadowCheckToolInBattle")

local SkipChapterPlot = false

--@RefType [Game.BattleView.Entity.RoleView#RoleView<>]
---@type RoleView[]
BattleViewMgr.roleViews = nil

BattleViewMgr.camera = nil
BattleViewMgr.backupCamera = nil    -- 备份战斗主相机的位置和相机参数

--@RefType [Game.Setting.Vo.BattleSceneVo#BattleSceneVo]
BattleViewMgr.sceneVo = nil

--@RefType [Game.UI.UIBattling.UIBattlingCtrlMgr#UIBattlingCtrlMgr]
---@type UIBattlingCtrlMgr
BattleViewMgr.battleUI = nil
--@RefType [Game.BattleView.FXMgr#FXMgr]
BattleViewMgr.FXMgr = nil

BattleViewMgr.nowTurn = 0
BattleViewMgr.nowWave = 0
BattleViewMgr.maxWave = 0

BattleViewMgr.nowSelfWave = 0
BattleViewMgr.maxSelfWave = 0

BattleViewMgr.nowLevelId = 0

BattleViewMgr.enemyAoe = nil
BattleViewMgr.teamAoe = nil
BattleViewMgr.speedLine = nil
--速度线gameobject
BattleViewMgr.blur = nil --动态模糊组件
BattleViewMgr.matrixEffect = nil    -- 黑客帝国效果组件
BattleViewMgr.matrixEffectRoleTargets = nil     -- 受黑客帝国效果影响的角色列表
BattleViewMgr.matrixEffectShadowMaterial = nil      -- 黑客帝国阴影材质球
BattleViewMgr.matrixEffectParticleMaterial = nil    -- 黑客帝国粒子材质球

BattleViewMgr.enableUltraAnim = true

BattleViewMgr.isAutoPlay = nil

BattleViewMgr.gameSpeed = 1
--@RefType [Game.Setting.Vo.WaveVo#WaveVo<>]
---@type table<number,WaveVo>
BattleViewMgr.levelData = nil

BattleViewMgr.myStands = nil --每波次的站位
BattleViewMgr.enemyStands = nil --每波次的站位
BattleViewMgr.enemyPath = nil --敌方的站位路径
BattleViewMgr.myPath = nil --我方的站位路径
BattleViewMgr.myBuffSelectStands = nil  -- 我方选择buff时候的站位
BattleViewMgr.sceneSkinGORoot = nil -- 场景存在多套皮肤时，子场景预制体的根节点

BattleViewMgr.catGameObjects = nil
BattleViewMgr.roleMoudles = nil
BattleViewMgr.playMode = nil
BattleViewMgr.pvpMode = nil
BattleViewMgr.replayData = nil
BattleViewMgr.inputMode = nil
BattleViewMgr.nowScene = nil
BattleViewMgr.rootNode = nil

BattleViewMgr.battleState = 0

BattleViewMgr.gameMode = Constants.GameMode.PVE
BattleViewMgr.address = nil
BattleViewMgr.port = nil
---@type BattleNetworkClient
BattleViewMgr.netMgr = nil

BattleViewMgr.openThreeStarCamera = nil

BattleViewMgr.waitForStart = nil
BattleViewMgr.onLoadingFinished = nil

--因为入场演出等情况导致的预先加载角色实例和站位，保存在这里，角色创建时优先使用这里的
BattleViewMgr.reuseRoleInstanceData = nil --[id={obj = obj, stand = stand}]

-- 缓存虚拟相机大脑的设置
BattleViewMgr.cinemachineBrainCache = nil

BattleViewMgr.selectBuffCamera = nil    -- 选择buff使用的相机
BattleViewMgr.selectBuffCameraBlendCache = nil  -- 选择buff时缓存虚拟相机设置

BattleViewMgr.roleRenderQuality = nil
BattleViewMgr.catFurRenderQuality = nil

-- 猫球
BattleViewMgr.skillCatViews = nil

-- 记录上一个技能的信息
BattleViewMgr.lastSkillRoleId = nil
BattleViewMgr.lastSkillPlayedVoice = nil

-- 序章使用的剧情
BattleViewMgr.opTimelineLoaders = nil

-- 记录本场是否播放过战力比拼
BattleViewMgr.hasRivaled = nil

-- 播放剧情的协程
BattleViewMgr.coChapter = nil

-- 请求了手动退出
BattleViewMgr.requestManualExit = false
BattleViewMgr.afterManualExit = false

-- 加载超时保护
BattleViewMgr.coWaitOtherOvertime = nil

-- 是否是回放的标记
BattleViewMgr.isReplay = false

function BattleViewMgr:Start(onLoadingFinished, waitForStart)
    self:FindLoadingUI()

    self.lowShadowCheckToolInBattle = LowShadowCheckToolInBattle.New() -- 低端阴影检测工具

    -- print("BattleViewMgr:Start2222")
    -- print = function ()
    local RegionQuestMgr = import('Game.UI.FightReady.UIMainChapter.RegionQuestMgr')
    RegionQuestMgr:GetInstance():ClearCurMapGo()
    
    -- end
    self:CacheCinemachineBrainSetting()
    self:CacheCarFurRenderQuality()
    ---清除下ui缓存
    UIModule.Clear()
    XGraphicSetup.EnterBattle()
    
    -- CS.UnityEngine.Debug.unityLogger.logEnabled = false
    ----设置当前主界面是否是显示的状态
    local id = KCookie.Get(Constants.UICacheDataKeys.MainSceneID)
    if not isNull(id) then
        ---@type SceneInstance
        local sceneInstance = SceneManagement:GetInstance():GetSceneInstance(id)
        if not isNull(sceneInstance) then
            local active = sceneInstance:GetEnable()
            ---设置进入战斗前的主界面的显示状态
            KCookie.Set(Constants.UICacheDataKeys.MainSceneActiveState, active)
        end
    end
    ---再关闭主界面显示
    Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
    Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })
    self.onLoadingFinished = onLoadingFinished
    self.waitForStart = waitForStart

    cs_coroutine.start(self.OnStart, self)

    -- self.playMode = Constants.PlayMode.Battle
    -- self.inputMode = Constants.InputMode.Normal
    -- BattleInfo = import("Game.BattleView.Core.BattleInfo").New(self.gameMode, self.playMode, self.inputMode)
    -- BattleMgr:Init(BattleInfo.initData)
    -- BattleMgr:GameStart()
end

function BattleViewMgr:OnStart(  )    
    self.ReconnectTest = PlayerPrefsUtility.GetBool("reconnectTest", false)
    self.DisconnectTest = PlayerPrefsUtility.GetBool("disconnectTest", false)

    -- print("ssssssssssssssssdddddddddddddddddddd")
    local d = nil

    local BI = import("Game.BattleView.Core.BattleInfo")
    local outData = {}
    coroutine.yield(BI.GetInitData(self.gameMode, outData)) 
    if not outData then
        return
    end
    if outData.onlineError ~= nil and outData.onlineError == 1 then
        print("get online init data over time")
        return
    end

    -- 猫球测试数据
    -- outData.initData.playerCatTeam = {
    --     [1] = {
    --         [1] = {
    --             id = 6001,
    --             playerId = outData.initData.selfId,
    --             playerCatId = 1,
    --             star = 0,
    --             type = 1,
    --             catId = 101001,
    --             attr = "3=5872.48&1=776.64&2=515.72&20=5&7=1.02&10=0.07&5=0.07&6=1.84&23=0.2&22=0.02&101=200&301=500",
    --             finalSkills = "71010011=1",
    --             passiveSkills = "",
    --         },
    --         [2] = {
    --             id = 6002,
    --             playerId = outData.initData.selfId,
    --             playerCatId = 2,
    --             star = 0,
    --             type = 2,
    --             catId = 101002,
    --             attr = "3=5872.48&1=776.64&2=515.72&20=5&7=1.02&10=0.07&5=0.07&6=1.84&23=0.2&22=0.02&101=200&301=500",
    --             finalSkills = "",
    --             passiveSkills = "110300802=1",
    --         }
    --     }
    -- }
    -- outData.initData.enemyCatTeam = {}
    -- local ps = outData.initData.playerTeam[1][1].passiveSkills
    -- outData.initData.playerTeam[1][1].passiveSkills = ps .. (string.isEmpty(ps) and "" or "&110300802=1=3")

    local firstCampNoBoss = 1
    if self.gameMode == Constants.GameMode.PVE
    and BI.BattleWithPlayerTeam(outData.initData.questId) then
        -- PVE与玩家队伍对战时，需要遵循先后手规则，需要关闭默认的非boss波次先手的规则
        firstCampNoBoss = 0
    end
    ---@type BattleInfo
    BattleInfo = BI.New(self.gameMode, outData.playMode, self.pvpMode, outData.inputMode, outData.initData, outData.recordData, firstCampNoBoss)
    local d = BattleInfo.initData
    
    if BattleInfo.isSimulator then
        self.openThreeStarCamera = CS.Engine.Tools.PlayerPrefsUtility.GetEncryptedInt("OpenThreeStarCamera") == 1
        self.enableUltraAnim = CS.Engine.Tools.PlayerPrefsUtility.GetEncryptedInt("ShowSPAnimation") == 1
    elseif BattleInfo:IsOnline() then
        self.openThreeStarCamera = false
        self.enableUltraAnim = false
    else
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        if playerComponent then
            local playerUID = playerComponent.playerDojo.playerId
            local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
            self.openThreeStarCamera = PlayerPrefsUtility.GetEncryptedInt(playerUID..Constants.PlayerPrefsType.BattleThreeStarCamera, 1) == 1
            self.enableUltraAnim = PlayerPrefsUtility.GetEncryptedInt(playerUID..Constants.PlayerPrefsType.BattleSpSkillState, 1) == 1
            -- print("[Setting] enableUltraAnim", self.enableUltraAnim)
        else
            self.openThreeStarCamera = true
            self.enableUltraAnim = true
        end
    end
    -- d.callTeam = DeepCopy(d.enemyTeam) 
    -- for i,wave in ipairs(d.callTeam) do
    --     for j,v in ipairs(wave) do
    --         v.id = 2000 + i*100 + j
    --     end
    -- end

    -- BattleInfo.gameRule.uiType = 3
    -- BattleInfo.gameRule.uiChat = 1
    -- print('json', json)
    -- print(table.toString(json, 'json'))
    -- local json = '{"questId":21301,"randomSeed":"611e32c71bbb0","mapId":1,"rounds":20,"battleSkill":[[]],"playerTeam":[[{"id":1,"cardId":101001,"skinId":10100101,"playerCardId":369,"level":1,"attr":"3=2564.28&1=402.9&2=237.66&20=5&7=1&10=0.05&5=0.05&6=1.8","generalSkills":{"1":41101001,"2":42101001},"finalSkills":"43101001=1","passiveSkills":"110100191=1","passiveEquipSource":"","currentHp":2564,"currentEnergy":0,"maxSP":6,"ai":"","career":2,"attribute":1,"weakId":0,"combatValue":4698,"star":0,"summons":[{"id":101,"enemyId":31002030,"level":1,"type":1,"attr":"1=1000&2=250&3=8000","generalSkills":{"1":510100224,"2":520100224},"finalSkills":"570100224=1","passiveSkills":"","currentHp":8000,"currentEnergy":0,"maxSP":5,"ai":"monster/monster_01","skinId":30100201,"career":1,"attribute":1,"weakId":0,"summonPriority":1}]}]],"enemyTeam":[[{"id":1000,"enemyId":31000037,"level":60,"type":1,"attr":"3=12012&1=3234&2=2310&7=0.99&10=0.038&5=0.318&6=1.518&209=0&210=0&21=0.036&22=0.036","generalSkills":{"1":510200001,"2":540200003},"finalSkills":"570200011=1","passiveSkills":"","passiveEquipSource":"","currentHp":12012,"currentEnergy":0,"maxSP":6,"ai":"monster/monster_01","skinId":30100301,"career":1,"attribute":3,"weakId":0,"summons":[]},{"id":1001,"enemyId":33010001,"level":60,"type":2,"attr":"3=123200&1=2772&2=2464&7=1.04&10=0.028&5=0.318&6=1.518&209=0&210=0&21=0.036&22=0.036","generalSkills":{"1":510200701,"2":520200701,"4":540200701,"6":550200701},"finalSkills":"570200701=1","passiveSkills":"14070012=1&14070009=1&641=1&641=1&14070014=1&14070017=1","passiveEquipSource":"","currentHp":123200,"currentEnergy":0,"maxSP":6,"ai":"monster/equip/type7_hard_8001pig","skinId":30800101,"career":1,"attribute":3,"weakId":0,"summons":[]},{"id":1002,"enemyId":31000038,"level":60,"type":1,"attr":"3=12012&1=3234&2=2310&7=0.99&10=0.038&5=0.318&6=1.518&209=0&210=0&21=0.036&22=0.036","generalSkills":{"1":510200001,"2":540200001},"finalSkills":"570200011=1","passiveSkills":"","passiveEquipSource":"","currentHp":12012,"currentEnergy":0,"maxSP":6,"ai":"monster/monster_01","skinId":30100301,"career":2,"attribute":3,"weakId":0,"summons":[]}]],"callTeam":[[]],"specialTeam":[[]],"mergeSkillId":[900011],"playerTeamSkill":"","skillQueueLoop":0,"skillQueue":""}'
    -- d = table.deserialize(json)
    -- local json = '{"randomSeed":"5de9cdd7978db","playerTeam":[{"id":1,"cardId":102008,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"41102008=1","skill2":"42102008=1","skill3":"43102008=1","passiveLevel":"100004=1&100005=1"},{"id":2,"cardId":102008,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"41102008=1","skill2":"42102008=1","skill3":"43102008=1","passiveLevel":"100004=1&100005=1"}],"enemyTeam":[{"id":3,"enemyId":80011,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"51080011=1","skill2":"52080011=1","skill3":"53080011=1","passiveLevel":"100004=1&100005=1"},{"id":4,"enemyId":80011,"attr":"hp=1000&atk=100&def=80&matk=100&mdef=80&lk=99&crit=0.1&crid=2.0&hit=1&dge=0.1","skill1":"51080011=1","skill2":"52080011=1","skill3":"53080011=1","passiveLevel":"100004=1&100005=1"}]}'
    -- print("easytouch swipeTolerance1", CS.HedgehogTeam.EasyTouch.EasyTouch.instance.swipeTolerance)
    CS.HedgehogTeam.EasyTouch.EasyTouch.instance.swipeTolerance = 0.1
    -- print("easytouch swipeTolerance2", CS.HedgehogTeam.EasyTouch.EasyTouch.instance.swipeTolerance)
    print(table.toString(d, "InitData"))

    -- self:FindLoadingUI(d)

    -- print("FindLoadingUI", self.loadingUI)
    if not isNull(self.rootNode) then
        CS.UnityEngine.GameObject.DestroyImmediate(self.rootNode)
    end
    self.rootNode = CS.UnityEngine.GameObject('RootNode')

    BattleMgr:Init(d)
    self:Init(d)

    --@TODO 2019-12-17 17:40:43 清除阻挡层，临时使用
    CS.Engine.UI.UIRaycastBlocker.Instance:RemoveAll()

    self._lateUpdater = Bind(self, self.OnLateUpdate)
    CS.Engine.Lib.MonoHelper.AddLateUpdateListener(self._lateUpdater)
  
    cs_coroutine.start(self.PreLoad, self, d)

    self:InitRecordInterpreter(d)

    SkipChapterPlot = PlayerPrefsUtility.GetBool(SkipChapterPlotKey, false)
    BattleMgr.BATTLE_AI_SHOW_LOG = PlayerPrefsUtility.GetBool(ShowAILogKey, false)
    BattleMgr.BATTLE_BUFF_SHOW_LOG = PlayerPrefsUtility.GetBool(ShowBuffLogKey, false)
    BattleMgr.BATTLE_FILTER_SHOW_LOG = PlayerPrefsUtility.GetBool(ShowFilterLogKey, false)
end

function BattleViewMgr:FindLoadingUI(d)
    xTry(function ()
        local isWorldBoss = d and d.questId and self:IsWorldBoss(d.questId)
        if isWorldBoss then
            self.loadingUI = FightPreWarMgr:GetInstance():GetWorldBossLoadingEnv()
        end
    end)

    --- 获取风暴巅峰加载界面
    local entity = GameUtils.GetEntity()
    if entity:IsCompExistsByName(ECSComponentType.Constants.PVPArenaComponent) then
        ---@type PVPArenaComponent
        local comp = entity:GetComp(ECSComponentType.Constants.PVPArenaComponent)
        self.loadingUI = comp:GetPVPArenaLoadingEnv()
    end

    xTry(function() 
        if not self.loadingUI then
            local go = GameObject.Find("LadderCompetionLoadingDialog")
            if not isNull(go) then
                self.loadingUI = GetLuaBehaviour(go, "Game.Behaviours.LadderCompetionLoadingDialog").Env
            end
        end
    end)

    if not self.loadingUI then
        local go = GameObject.Find("FriendReadyDialog")
        if not isNull(go) then
            self.loadingUI = GetLuaBehaviour(go, "Game.Behaviours.UIFriendPVPLoadingPanel").Env
        else
            go = GameObject.Find("LoadingPanel")
            if isNull(go) then
                GameUtils.OpenLoadingPanel()
                go = GameObject.Find("LoadingPanel")
            end
            self.loadingUI = GetLuaBehaviour(go, "Game.Behaviours.UILoadingPanel").Env
        end
    end
end

function BattleViewMgr:GetOnlineBattleData(returnData)
    --建立网络连接，初始化后获得数据
    if self.netMgr and self.netMgr.address == self.address and self.netMgr.port == self.port then
        --维持这个链接
    else
        if self.netMgr then
            self.netMgr:Dispose()
        end
        self.netMgr = import('Game.BattleView.Network.BattleNetworkClient').New()
    end
    local isFinished = false
    self.waitForStart = true

    self.netMgr.onReconnect = Bind(self, function ()
        if isFinished then
            -- 在所有阶段重连时都需要发这个消息，服务器需要这个消息来绑定玩家
            self.netMgr:Send(self.netMgr.SendPackageIds.Refresh, {playerId = GameUtils.GetPlayerId(), roomId = self.roomId})
        else
            -- 在收到4001之前，不可以发送重连消息，只能手动重发4000
            self.netMgr:Send(self.netMgr.SendPackageIds.EnterBattle, {playerId = GameUtils.GetPlayerId(), roomId = self.roomId, reconnect = self.isReconnectOutside}, nil, 0)
        end
    end)

    self.netMgr.OnReceiveInitData = function (packageId, packageData)
        isFinished = true
        returnData.data = packageData
    end

    self.netMgr:Connect(self.address, self.port)

    while not self.netMgr:IsConnected() and not self.netMgr.isQuit do
        coroutine.yield()
    end
    -- print("GetOnlineBattleData On Connected")
    self.netMgr:Send(self.netMgr.SendPackageIds.EnterBattle, {playerId = GameUtils.GetPlayerId(), roomId = self.roomId, reconnect = self.isReconnectOutside})
    -- print("GetOnlineBattleData Send EnterBattle.  isReconnect:", self.isReconnectOutside)
    self:DebugTestNetwork()

    local max = 30
    local timer = 0
    while not isFinished and not self.netMgr.isQuit do
        cs_coroutine.yield_return(Yielders.EndOfFrame)
        -- 请求4001的超时保护
        timer = timer + Time.deltaTime
        if timer > max then
            returnData.error = 1
            self.netMgr:QuitBattle(self.netMgr.QuitType.ConnectFailed)
            return
        end
    end

    if self.netMgr.isQuit then
        returnData.error = 1
    end
end

function BattleViewMgr:IsWorldBoss( questId )
    local levelType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    return levelType == Constants.IDType.QuestWorldBoss
end


--预加载
function BattleViewMgr:PreLoad(initData)

    xTry(function ()
        local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
        local customData = KTool.GetComponent(URPCameraController.mainCamera.gameObject, typeof(CS.CameraCustomData))
        if customData then
            customData.PlaneShadow = CS.CameraCustomData.BaseSettingEnum.Open
        end
    end)
    self:DebugTestNetwork()
    --场景
    self.battleState = Constants.BattleState.Preloading

    coroutine.yield()
    local stopwatch = CS.System.Diagnostics.Stopwatch()
    stopwatch:Start()


    local sceneId = initData.mapId or 1
    -- sceneId = 17003
    local setting = settingMgr:GetSetting(AutoIds.IdSetting270, "BattleSceneVo")
    --@RefType [Game.Setting.Vo.BattleSceneVo#BattleSceneVo]
    local battleSceneVo = setting:Get(sceneId)
    self.sceneVo = battleSceneVo
    print(table.toString(battleSceneVo, "battleSceneVo"))

    self.levelData = Core:GetLevelData(tonumber(initData.questId))

    self.nowLevelId = initData.questId
  
    -- 加载黑客帝国效果用的阴影材质球
    local towerSceneScriptId = self.sceneVo.towerSceneScriptId
    if towerSceneScriptId > 0 then
        coroutine.yield(self:LoadRoleShadowMatrixMaterial(towerSceneScriptId))
    end

    local loadingUI = self.loadingUI

    ResMgr:RequireRes(ResMgr.ResType.Scene, battleSceneVo.id)
    ResMgr:RequireRes(ResMgr.ResType.DynamicAtlas, 0, true)
    ResMgr:RequireNormalFX()
    ResMgr:RequireRes(ResMgr.ResType.UI, 0, true)

    local roleDatas = {}
    table.link(roleDatas, initData.playerTeam[1])
    for p, wave in ipairs(initData.enemyTeam) do
        table.link(roleDatas, wave)
    end
    if initData.callTeam then
        for p, wave in ipairs(initData.callTeam) do
            table.link(roleDatas, wave)
        end
    end

    if initData.specialTeam then
        for p, wave in ipairs(initData.specialTeam) do
            table.link(roleDatas, wave)
        end
    end

    for i,roleData in ipairs(roleDatas) do
        ResMgr:RequireRole(roleData)
    end

    ---TODO 这里之后应该提供通用的方法，而不是仅仅判断序章
    ---判断中间是否有序章剧情
    local hasOp = initData.questId == Constants.QUEST_OP_LEVEL[2] or initData.questId == Constants.QUEST_OP_LEVEL[3] or initData.questId == Constants.QUEST_OP_LEVEL[4]
    local battleResPercent = hasOp and 0.8 or 1

    local sw = CS.System.Diagnostics.Stopwatch()
    sw:Start()
    coroutine.yield(ResMgr:StartLoading(function ( progress )
        -- print(progress)
        -- loadingUI:__Progress(progress)
        loadingUI:Progress(progress * 100 * battleResPercent)
    end, true))
    sw:Stop()
    -- print("load... total", sw.ElapsedMilliseconds)

    
    -- loadingUI:__Progress(1)
    --把第一波的初始化也加入加载流程
    self:InstantiateFirstWave()
    if not self:HasSkillCat() then
        coroutine.yield(self:CreateSkillCat())
    end

    -- 序章timeline剧情预加载
    if hasOp then
        CS.UnityEngine.Application.backgroundLoadingPriority = CS.UnityEngine.ThreadPriority.High

        local ChapterUtils = import('Game.Chapter.ChapterUtils')
        local setting = settingMgr:GetSetting(AutoIds.IdSetting2512, "MainQuestPlotVo")
        local vo = setting:Get(initData.questId)
        local plotIds = {}
        table.link(plotIds, parse_strings(vo.plotIdGroup2))
        table.link(plotIds, parse_strings(vo.plotIdWave1))
        table.link(plotIds, parse_strings(vo.plotIdEndWave1))
        table.link(plotIds, parse_strings(vo.plotIdEndWave2))
        table.link(plotIds, parse_strings(vo.plotIdRounds))
        self.opTimelineLoaders = {}
        for i, plotId in ipairs(plotIds) do
            local generalVo = ChapterUtils.GetChapterGeneralVo(plotId)
            if generalVo and not string.isEmpty(generalVo.timelinePath) then
                local loader = ResourceModule.LoadBundleAsync(generalVo.timelinePath)
                table.insert(self.opTimelineLoaders, loader)
                print("[加载] 预加载", plotId, generalVo.timelinePath)
            end
        end

        -- 战斗UI预加载
        local modulePrefabsTable = settingMgr:Get("Module/ModulePrefabs")
        local listDialog = {
            {id = Constants.UITypeIds.UIBattlingCharactorBattleInfoDialog},
            {id = Constants.UITypeIds.UIBattlingDialog},
            {id = Constants.UITypeIds.UIBattlingBubble},
            {id = Constants.UITypeIds.UIGamePlayGuideDialog},
        }
        for i, uiData in ipairs(listDialog) do
            local row = modulePrefabsTable:GetByPrimaryKey(uiData.id,false)
            if isNotNull(row) then
                local path = parse_string(row, "path")
                local loader = ResourceModule.LoadBundleAsync(path)
                table.insert(self.opTimelineLoaders, loader)
                print("[加载] 预加载UI", uiData.id, path)
            end
        end

        local opCount = #self.opTimelineLoaders
        ---等待所有op加载完成
        
        while opCount > 0 do 
            local loadedCount = 0

            for i = 1, opCount do
                if self.opTimelineLoaders[i].IsCompleted then
                    loadedCount = loadedCount + 1
                end
            end

            if loadedCount < opCount then
                loadingUI:Progress(100 * (battleResPercent + (1-battleResPercent) * loadedCount / opCount ))
                coroutine.yield()
            else
                break
            end
        end 
        
        CS.UnityEngine.Application.backgroundLoadingPriority = CS.UnityEngine.ThreadPriority.Normal
    end
    loadingUI:__Progress(1)

    -- 切换场景使用的模型
    self:SwitchSceneSkin(1)
    self:DebugTestNetwork()
    coroutine.yield()
    self.battleState = Constants.BattleState.WaitingForStart
     print("LoadingFinished!!", loadingUI)
    -- onLoadingFinished, waitForStart
    if self.onLoadingFinished then
        self.onLoadingFinished()
    end

    if BattleInfo:IsOnline() then
        self.netMgr:Send(self.netMgr.SendPackageIds.LoadingFinished, {})
        -- 加载超时保护
        self.coWaitOtherOvertime = cs_coroutine.start(function()
            for i = 1, 5, 1 do
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds(6))
                GameUtils.Toast(localize("等待对方加载完成"))
            end
            self.coWaitOtherOvertime = nil
            self.netMgr:QuitBattle(self.netMgr.QuitType.OtherDisconnect)
        end)
    end

    if self.waitForStart then
        -- print("waitForStart!!", loadingUI)
        return
    end
    self:StartBattle()
end

function BattleViewMgr:OnLoadSceneFinished(  )
    self.enemyPath = nil
    self.myPath = nil

    local SceneManagement = CS.UnityEngine.SceneManagement
    local sceneName = self.sceneVo.sceneName
    --  coroutine.yield(WaitForSeconds(1))
    local scene = SceneManagement.SceneManager.GetSceneByName(sceneName)
    -- if self.nowScene and self.nowScene == scene then
    --     return
    -- end
    self.nowScene = scene
    SceneManagement.SceneManager.SetActiveScene(scene)
    if isNull(self.rootNode) then
        self.rootNode = CS.UnityEngine.GameObject('RootNode')
    end
    CS.UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self.rootNode, self.nowScene)

     --添加场景aoe点，供给镜头用
    local enemyAoe = CS.UnityEngine.GameObject.Find("enemyAoe")
    if isNull(enemyAoe) then
        enemyAoe = CS.UnityEngine.GameObject("enemyAoe")
    end
    enemyAoe.transform.position = self.sceneVo.enemyAoe
    local ear = self.sceneVo.enemyAoeRotation
    enemyAoe.transform.localRotation = Quaternion.Euler(ear.x, ear.y, ear.z)

    self.lights = KTool.GetDirectLightWithLayerName("role")
    -- for i = 0, self.lights.Length - 1 do
    --     print("lights", self.lights[i].gameObject.name)
    --     -- KTool.SetActive(lights[i].gameObject, lightSt[i])
    -- end

    local teamAoe = CS.UnityEngine.GameObject.Find("teamAoe")
    if isNull(teamAoe) then
        teamAoe = CS.UnityEngine.GameObject("teamAoe")
    end
    teamAoe.transform.position = self.sceneVo.teamAoe
    local tar = self.sceneVo.teamAoeRotation
    teamAoe.transform.localRotation = Quaternion.Euler(tar.x, tar.y, tar.z)

    self.enemyAoe = enemyAoe
    self.teamAoe = teamAoe

    local sceneCenter = CS.UnityEngine.GameObject.Find("SceneCenter")
    if isNull(sceneCenter) then
        sceneCenter = CS.UnityEngine.GameObject("SceneCenter")
    end
    sceneCenter.transform.position = self.sceneVo.sceneCenter
    
    self.sceneCenter = sceneCenter

    local fxNode = CS.UnityEngine.GameObject.Find("fxNode")
    if isNull(fxNode) then
        fxNode = CS.UnityEngine.GameObject("fxNode")
        fxNode.transform:SetParent(BattleViewMgr.rootNode.transform)
        CS.Engine.Lib.KTool.ResetTransform(fxNode.transform)
    end
    self.fxNode = fxNode

    local myPath = CS.UnityEngine.GameObject.Find("MyPath")
    if isNull(myPath) then
        myPath = CS.UnityEngine.GameObject("MyPath")
        myPath:AddComponent(typeof(CS.Cinemachine.CinemachineSmoothPath))
    end
    self.sceneVo:LoadPath(myPath, true)

    local enemyPath = CS.UnityEngine.GameObject.Find("EnemyPath")
    if isNull(enemyPath) then
        enemyPath = CS.UnityEngine.GameObject("EnemyPath")
        enemyPath:AddComponent(typeof(CS.Cinemachine.CinemachineSmoothPath))
    end
    self.sceneVo:LoadPath(enemyPath, false)
    local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
    URPCameraController:SetMainCameraActive(true)
    coroutine.yield()
    local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
    SkillCameraMgr.showSceneId = tostring(self.sceneVo.id)
    coroutine.yield()

    --相机控制器挂载相机
    SkillCameraMgr:SetMainCameraPosition()
    xTry(function()
        local mixingCamera = SkillCameraMgr.transform:GetChild(0):GetComponent(typeof(CS.Cinemachine.CinemachineMixingCamera))
        mixingCamera:SetWeight(0, 0.1)
    end)
    SkillCameraMgr:InitializeCmBrain()
    coroutine.yield()
    self:InitVcamLens()
    self.camera = URPCameraController.mainCamera
    --self.camera = CS.UnityEngine.Camera.main
    -- Tools.syncStand(self.camera.transform, self.sceneVo.cameraStand)
    -- 备份主相机的位置和参数
    local backupBattleMainCamera = CS.UnityEngine.GameObject("BackupBattleMainCamera")
    backupBattleMainCamera.transform.position = self.camera.transform.position
    backupBattleMainCamera.transform.rotation = self.camera.transform.rotation
    self.backupCamera = backupBattleMainCamera:AddComponent(typeof(CS.UnityEngine.Camera))
    self.backupCamera:CopyFrom(self.camera)
    KTool.SetActive(backupBattleMainCamera, false)

    -- 爬塔用的黑客帝国效果脚本
    local sceneRoot = CS.UnityEngine.GameObject.Find("Scene")
    local towerSceneScriptId = self.sceneVo.towerSceneScriptId
    if towerSceneScriptId > 0 then
        self:AddMatrixEffect({sceneRoot}, towerSceneScriptId)
    end

    -- 场景有多套皮肤时，子场景的根节点
    self.sceneSkinGORoot = CS.UnityEngine.GameObject.Find("SceneList")
end

function BattleViewMgr:TestAAA(a, b, c, d)
    -- print("TestAAA " .. a)
    return true
end

--- 替换黑客帝国材质球
---@param roleData any
---@param go any
function BattleViewMgr:SetMatrixShadowMaterial(roleData, go)
    -- print("[加组件] 换材质球", roleData.cardId or roleData.enemyId)

    -- 替换黑客帝国材质球
    local towerSceneScriptId = self.sceneVo.towerSceneScriptId
    if towerSceneScriptId > 0 then
        local coId = -1
        local co = cs_coroutine.start(function()
            xTry(function()
                local totalTime = 0
                local shadowGO = go.transform:Find("LowDiscShadow")
                while isNull(shadowGO) do
                    cs_coroutine.yield_return(WaitForSeconds(0.2))
                    shadowGO = go.transform:Find("LowDiscShadow")
                    totalTime = totalTime + 0.2
                    if totalTime > 30 then
                        print("角色没有 LowDiscShadow ")
                        break
                    end
                end
                if isNotNull(shadowGO) then
                    local mr = shadowGO:GetComponent(typeof(CS.UnityEngine.MeshRenderer))
                    mr.material = GameObject.Instantiate(self.matrixEffectShadowMaterial)
                end
            end)
            CoManager:RemoveCoById(coId)
        end)
        coId = CoManager:AddCo(co)
    end
end

--- 设置角色的光照方向
---@param roleData any
---@param go any
function BattleViewMgr:SetCustomLightDirection(roleData, go)
    -- 设置光照方向
    local lightDir = go:EnsureComponent(typeof(CS.CustomLightDirRelativeCamera))
    if not isNull(lightDir) then
        if isNotNull(roleData.cardId) then
            -- 角色
            lightDir.CustomLightDirection = Vector3.New(25, 17, 0)
        else
            -- 怪物
            if isNotNull(self.sceneVo)
            and isNotNull(self.sceneVo.enemyLightDirection) then
                lightDir.CustomLightDirection = self.sceneVo.enemyLightDirection
            else
                lightDir.CustomLightDirection = Vector3.New(25, 17, 0)
            end
        end
    end
end

--- 材质球动画的组件和状态机
---@param roleData any
---@param go any
function BattleViewMgr:CheckGeometryAnimator(roleData, go)
    local fxList = ResMgr:GetRoleFX(roleData)
    local setting = settingMgr:GetSetting(AutoIds.IdSetting566, "FXResVo")
    for i,v in ipairs(fxList) do
        if not Tools.isNullKey(v) then
            local vo = setting:Get(v)
            if isNull(vo) then
                printError(string.format("特效资源表中没有id %d", checkNumber(v)))
                goto continue
            end
            if not string.isEmpty(vo.materialAnimState) then
                local geometryAnimationRoot = go.transform:Find("Group_Rig_Grp/Unity_Export_Grp/Geometry")
                if isNotNull(geometryAnimationRoot) then
                    local coId = -1
                    local co = cs_coroutine.start(function()
                        local animator = KTool.GetOrAddComponent(geometryAnimationRoot.gameObject, typeof(Animator))
                        local controllerPath = string.format("RuntimeController/Animator_Geometry_Material/%d_Geometry_Material.controller", roleData.cardId)
                        local loader = ResourceModule.LoadBundleAsync(controllerPath, nil, true)
                        while not loader.IsCompleted do
                            coroutine.yield(Yielders.EndOfFrame)
                        end
                    
                        if loader.IsSuccess then
                            loader:Retain(go)
                            animator.runtimeAnimatorController = loader.ResultObject
                        end
                        
                        loader:Release()
                        loader = nil

                        CoManager:RemoveCoById(coId)
                    end)
                    coId = CoManager:AddCo(co)
                end
            end
        end
        ::continue::
    end
end

--- 角色模型动态添加组件设置组件
---@param roleData any
---@param go any
function BattleViewMgr:DynamicAddComponent(roleData, go)
    self:CheckGeometryAnimator(roleData, go)
    self:SetCustomLightDirection(roleData, go)
    self:SetMatrixShadowMaterial(roleData, go)

    self.lowShadowCheckToolInBattle:AddRoleGameObj(go)
end

function BattleViewMgr:GetCatGo(skinId)
    if isNotNull(self.catGameObjects[skinId]) then
        return self.catGameObjects[skinId]
    end

    local model = ResMgr.catModels[skinId]
    if not model or isNull(model.loader) then
        printError('找不到模型:'..model)
        return
    end

    local go = GameObject.Instantiate(model.loader.ResultObject)
    KTool.SetActive(go, true)   -- 防止预制体是关着的，没有走组件的awake和onenable
    
    self.catGameObjects[skinId] = go

    return go
end

function BattleViewMgr:GetRoleGo(moudleId)
    local roleData = Core:FindRoleDataById(moudleId)
    if not roleData then
        printError('找不到角色数据:'..moudleId)
        return
    end

    local go = nil
    local modelVo = nil
    local needEnter = true
    local reuseData = self.reuseRoleInstanceData and self.reuseRoleInstanceData[roleData.id]
    if reuseData and not isNull(reuseData.obj) then
        go = reuseData.obj
        modelVo = reuseData.modelVo
        needEnter = reuseData.needEnter
    else
        local modelId = Core:GetModleId(roleData.skinId)
        local model = ResMgr.roleMoudles[modelId]
        if not model or isNull(model.loader) then
            printError('找不到模型:'..model)
            return
        end
        modelVo = model.modelVo
        -- local go = moudle.gameObject
        -- if isSummonCreep then
        --     go = GameObject.Instantiate(moudle.gameObject)
        -- end
        go = GameObject.Instantiate(model.loader.ResultObject)
        KTool.SetActive(go, true)   -- 防止预制体是关着的，没有走组件的awake和onenable

        -- 动态加载组件
        self:DynamicAddComponent(roleData, go)
    end

    go.transform:SetParent(self.rootNode.transform)
    go.transform.localScale = Vector3.one * modelVo.battleScale
    go:SetActive(false)

    return go, modelVo, needEnter
end

function BattleViewMgr:OnCreateRole( record )
    local moudleId = record.moudleId
    local id = record.id
    local nowHp = record.nowHp
    local nowSp = record.nowSp
    local pos = record.pos
    local isSummonCreep = record.isSummonCreep
    local camp = record.camp
    local roleType = record.roleType
    local attrBaseValues = record.abvs

    if nowHp <= 0 then
        --已经死亡的人不加了
        printError('要求创建一个已经死亡的人:'..moudleId)
        return
    end
    local roleData = Core:FindRoleDataById(moudleId)
    if not roleData then
        printError('找不到角色数据:'..moudleId)
        return
    end
    local reuseData = self.reuseRoleInstanceData and self.reuseRoleInstanceData[roleData.id]
    local go, modelVo, needEnter = self:GetRoleGo(moudleId)
    local roleView = RoleView.New(id, roleData, roleType, go, pos, camp, modelVo, nowHp, nowSp)
    --初始化站位
    if reuseData and reuseData.stand then
        roleView:SetStand(reuseData.stand)
        -- print("isReused stand:", table.toString(reuseData.stand))

    else
        -- print("stand:"..pos.. "  " .. camp, table.toString(self:GetStand(pos, camp)))
        roleView:SetStand(self:GetStand(pos, camp))
    end

    table.insert(self.roleViews, roleView)

    if isSummonCreep then
        -- 召唤物的初始属性可能会被效果修改，这里同步一下baseValues
        roleView.isSummonCreep = true
        for k,v in pairs(Constants.AttrTypeId) do
            v = tostring(v)
            if attrBaseValues[v] then
                roleView.attr.baseValues[v] = attrBaseValues[v]
            else
                if BattleInfo.playMode ~= Constants.PlayMode.Replay then
                    roleView.attr.baseValues[v] = 0
                else
                    if checkInt(v) ~= Constants.AttrTypeId.NowHp then
                        roleView.attr.baseValues[v] = 0
                    end
                end
            end
        end
        roleView.attr:RefreshNowValues()

        -- 召唤物不会经历入场，所以这里直接显示出来
        KTool.SetActive(roleView.gameObject, true)
        roleView:Enter()    -- 入场动画
        Events.Broadcast(Constants.EventNames.BattleCreateRoleShow, {{
            id = roleView.id,
            data = roleData
        }})
    end

    if not roleView.isPlayer then
        -- 黑客帝国效果
        self:MatrixEffectAddRole(roleView.id, roleView.gameObject)
    end
end

--- 判断是否需要跳过入场动画
---@param skipEnterAnimation any
---@param skipCampList any
---@param camp any
function BattleViewMgr:NeedSkipEnterAnimation(skipEnterAnimation, skipCampList, camp)
    if skipEnterAnimation then
        return table.isContain(skipCampList, camp)
    else
        return false
    end
end

function BattleViewMgr:PlayerRoleEnter(skipEnterAnimation, skipCampList)
    -- 切换波次BGM
    CriWareUtils.CurrentBGMSetNextBlockIndex(self.sceneVo.blockIndex[self.nowWave])

    local hasBoss = false
    local hasBossEnterTimeline = false
    -- print("[流程] 角色入场", table.dump(self.roleViews))
    local iter = ipairs
    local questType = GoodsUtils.GetIdType(self.initData.questId, Constants.IDArea.Quests)
    if AnnihilationUtils.QuestTypeIsAnnihilation(questType) then
        iter = fipairs  -- 歼灭战反向遍历，先出boss，boss入场播完再让角色入场
    end
    local hasEnterAnimation = false
    self.maxEnterFrame = 0
    for i, roleView in iter(self.roleViews) do
        if not roleView.hasEnterShowed then
            KTool.SetActive(roleView.gameObject, true)
            local roleData = roleView.roleData
            -- 入场特效
            local skinData = Core:GetSkinData(roleData.skinId)
            self.FXMgr:PlayFXOnRole(skinData.enterFX, roleView)
            if not roleView.isPlayer and roleView:IsEliteOrBoss() then
                hasBoss = true
                -- peek一下是否有入场timeline
                local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting39, "MonsterTypeVo")
                local monsterTypeVo = setting:Get(roleView.typeId)
                local res = monsterTypeVo.enterTimeline
                hasBossEnterTimeline = not Tools.isNullKey(res)
                hasEnterAnimation = true
                self.maxEnterFrame = math.max(roleView:GetAnimationFrame("enter"), self.maxEnterFrame)
                -- boss入场
                coroutine.yield(self:PlayBossEnter(roleView))
            elseif not roleView.isPlayer and not roleView:IsEliteOrBoss() then
                self.FXMgr:PlayFXOnRole(Constants.BattleCommonFX.CreepEnter, roleView)
                if not self:NeedSkipEnterAnimation(skipEnterAnimation, skipCampList, roleView.camp) then
                    hasEnterAnimation = true
                    self.maxEnterFrame = math.max(roleView:GetAnimationFrame("enter"), self.maxEnterFrame)
                    roleView:Enter()
                end
            else
                if not self:NeedSkipEnterAnimation(skipEnterAnimation, skipCampList, roleView.camp) then
                    hasEnterAnimation = true
                    self.maxEnterFrame = math.max(roleView:GetAnimationFrame("enter"), self.maxEnterFrame)
                    roleView:Enter()
                end
            end
            Events.Broadcast(Constants.EventNames.BattleCreateRoleShow, {{
                id = roleView.id,
                data = roleData
            }})

            if self.initData.questId == Constants.QUEST_OP_LEVEL[2] then
                -- op2有黑屏屏蔽登场，不用等
            else
                coroutine.yield()
                coroutine.yield()
            end
        end
    end

    self:SwitchSceneSkin(self.nowWave)  -- 切换场景皮肤

    if not hasBossEnterTimeline then
        -- 没有boss入场timeline的时候，最多等待2.5s播放角色的入场动画
        if hasEnterAnimation then
            local sec = self.maxEnterFrame / 30
            coroutine.yield(WaitForSeconds(math.min(sec, 2.5)))
        end

        -- 如果是从战斗外重连回来，跳过第一波的入场
        local skipShow = (self.nowWave == 1) and (BattleViewMgr.isReconnectOutside == 1) or false

        local needRival = (BattleInfo.gameRule.campPriority == 3) and (not self.hasRivaled) or false
        local needBossShow = hasBoss

        print("[战力比拼]", skipShow, needBossShow, needRival)

        if (not skipShow)
        and (hasBoss or BattleInfo.BattleWithPlayerTeam(self.initData.questId, self.initData.systemId))   -- 
        and (needBossShow or needRival) then
            -- boss秀或者战力比拼
            if needBossShow then
                self:CacheRoleViewPos(BattleInfo.myCamp)    -- 隐藏我方角色，防止挡镜头
            end
            Events.Broadcast(Constants.EventNames.BattleBossShowStart, needBossShow and 1 or 0, needRival and 1 or 0) -- 播boss秀UI，然后接战力比拼
            -- 等战力比拼通知结束
            self.waittingBossEnterEnd = true
            while self.waittingBossEnterEnd do
                cs_coroutine.yield_return(nil)
            end
            if needBossShow then
                self:ResetRoleViewPos(BattleInfo.myCamp)    -- 显示我方角色
            end
            if needRival then
                self.hasRivaled = true
            end
        else
            if self.nowWave > 1 then
                coroutine.yield(WaitForSeconds(1)) -- 从第二波开始，如果没有boss，就需要额外等1s波次开始UI
            end
        end
    end

    Events.Broadcast(Constants.EventNames.BattleRoleEnterEnd, self.nowWave, hasBoss) -- 角色入场结束
end

function BattleViewMgr:OnBattleBossEnterEnd()
    self.waittingBossEnterEnd = false
end

--场景的表现相机
function BattleViewMgr:PlayBossEnter( boss )
    -- local res = self.sceneVo.enterCamera
    
    -- print("[Boss] enter", table.dump(boss, nil, 5))
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting39, "MonsterTypeVo")
    local monsterTypeVo = setting:Get(boss.typeId)
    local res = monsterTypeVo.enterTimeline
    local enterSFX = monsterTypeVo.enterSFX
    -- print("[Boss] enter res", res)
    -- res = "8004_enter_timeline"
    if not Tools.isNullKey(res) and not (self.isReconnectOutside == 1) then
        boss.gameObject:SetActive(false)

        --有场景相机动画资源就加载
        local path = gameUtils.GetThreeStarCameraFullPath(res)
        local loader = ResourceModule.LoadBundleAsync(path, nil, true)--"Timeline/Timeline.prefab"
        while not loader.IsSuccess do
            coroutine.yield( )
        end
        if not loader.IsError then
            --隐藏ui
            -- Events.Broadcast(Constants.EventNames.UIBattingStoryRunning, false)
            -- if not isNull(self.camera) then
            --     self.camera.gameObject:SetActive(false)
            -- end
            ---这里还出现卡，人物的prefab需要优化
            -- local go = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
            local go = loader:Instantiate()
            local oldScale = boss.gameObject.transform.localScale    -- timeline可能会改模型缩放，这里保存一下，等播完timeline还原回来
            local playableDirector = go:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
            local binder = go:AddComponent( typeof(CS.Game.Native.Timeline.TimelineBinder) )
            playableDirector.playOnAwake = false
            -- print("PlayBossEnter", self.sceneVo.enterCameraWithBoss)
            boss.gameObject:SetActive(true)
            boss:HideLoopFXNode()
            boss:HideOnceFXNode()
            if self.sceneVo.enterCameraWithBoss then
                binder:SetTrackDynamic("boss", boss.gameObject)
            else
                boss:Enter()
            end
            binder = nil
            --主相机隐藏
            CfUtils.ChangeMainCamDefalultBlend(0)
            URPCameraController:SetMainCameraActive(false)  -- timeline里面会自带一个base相机
            
            if not self.hasRivaled then
                -- 要把UI相机添加到里面，不然渲染不出UI来
                local uacd = go.transform:GetComponentInChildren(typeof(CS.UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
                uacd.nextCamera = URPCameraController.uiCamera
            else
                KTool.SetActive(URPCameraController.uiCamera, false)
            end

            playableDirector:Play()
            self:PlayCameraSFX(self.sceneVo.enterSound)     -- 场景进入音效
            self:PlayCameraSFX(enterSFX)                    -- 怪物入场timeline音效
            coroutine.yield()
            CfUtils.ChangeMainCamDefalultBlend(self.sceneVo.cameraFuse)
            self:SwitchSceneSkin(self.nowWave)  -- 趁着播bosstimeline，切换场景
            coroutine.yield( WaitForSeconds(playableDirector.duration) )
            playableDirector:Stop()

            --重置站位
            boss:SyncStand()
            BattleViewMgr:ChangeGameSpeed(BattleViewMgr.gameSpeed)
            
            if not self.hasRivaled
            and BattleInfo.gameRule.campPriority == 3 then
                Events.Broadcast(Constants.EventNames.BattleBossShowStart, 0, 1)     -- 播放战力比拼
                coroutine.yield(WaitForSeconds(3.3))    -- 开始播放战力比拼，等3.5s之后，关掉timeline，切换回战斗相机，此时战力比拼还未结束
            else
                KTool.SetActive(URPCameraController.uiCamera, true)
            end

            URPCameraController:SetMainCameraActive(true)
            CfUtils.ChangeMainCamDefalultBlend(0)

            --清除所有绑定
            CS.UnityEngine.GameObject.Destroy(playableDirector.gameObject)
            loader:Release(true)
            loader = nil
            playableDirector = nil
            -- Events.Broadcast(Constants.EventNames.UIBattingStoryRunning, true)
            -- if not isNull(self.camera) then
            --     self.camera.gameObject:SetActive(true)
            -- end

            boss.gameObject.transform.localScale = oldScale  -- 还原模型缩放
            if not self.hasRivaled
            and BattleInfo.gameRule.campPriority == 3 then
                coroutine.yield(WaitForSeconds(1))  -- 再等1s，战力比拼结束，然后开始下一步
            end
            self.hasRivaled = true
            boss:ShowLoopFXNode()
            boss:ShowOnceFXNode()
        end
    else
        boss:Enter()
        --重置站位
        boss:SyncStand()
        BattleViewMgr:ChangeGameSpeed(BattleViewMgr.gameSpeed)
    end
end

function BattleViewMgr:ChangeWave(waveNum, moudleIds, camp, maxNum)
    -- 等待死亡动画全部播完
    local roleView = self.roleViews[1]
    for i, v in ipairs(self.roleViews) do
        if not isNull(v.co) then
            roleView = v
        end
    end
    while not isNull(roleView) do
        if not isNull(roleView.co) then
            coroutine.yield(WaitForSeconds(0.1))
        else
            roleView = nil
            for i, v in ipairs(self.roleViews) do
                if not isNull(v.co) then
                    roleView = v
                end
            end
        end
    end

    self:ResetCamera()
    if BattleInfo:IsPVE() and camp == Constants.Camp.Two then
        local waveData = self.levelData[waveNum]
        if waveData then
            local waveScript = waveData:GetWaveScript()
            if waveScript then
                coroutine.yield(waveScript:BeforeWaveChange(waveData.scriptData))
            end
        end

        --这里需要处理上一波结束和下一波开始
        if waveNum > 1 then
            coroutine.yield(self:PlayWaveChapter(waveNum - 1, false))
            coroutine.yield(self:PlayWaveChapter(waveNum, true))
        end
    end
    if camp == Constants.Camp.One then
        self.nowSelfWave = waveNum
    elseif camp == Constants.Camp.Two then
        self.nowWave = waveNum
    end

    --根据当前的波数变化
    -- coroutine.yield(WaitForSeconds(0.1))

    local ids = {}

    --清除当前波次角色
    -- for i, role in fipairs(self.roleViews) do
    --     if role.camp == camp then
    --         table.remove(self.roleViews, i)
    --         table.insert(ids, role.id)
    --         role.gameObject:SetActive(false)
    --         role:Dispose()
    --         --我方情况需要清除之前加载的角色数据
    --         if camp == Constants.TargetCamp.Friend then
    --             ResMgr:UnloadRoleRes(role.roleData)
    --         end
    --     end
    -- end

    if BattleInfo:IsPVE() and camp == Constants.Camp.One then
        --加载新波次上的角色
        for i,v in ipairs(moudleIds) do
            local roleData = Core:FindRoleDataById(v)
            ResMgr:RequireRole(roleData)
        end
    end
    
    ResMgr:StartLoading()
    Events.Broadcast(Constants.EventNames.BattleDeleteRoleShow, ids)
    -- coroutine.yield(CS.UnityEngine.Resources.UnloadUnusedAssets())
    self:InitStand(maxNum, not BattleInfo:IsUserCamp(camp))
end

function BattleViewMgr:GetUnitSkillId()
    local initData = BattleInfo.initData
    -- print("nowSelfWave", self.nowSelfWave)
    return initData.mergeSkillId[self.nowSelfWave] or nil
end


function BattleViewMgr:ChangeWaveEnd(waveNum, camp, maxNum, needWait)
    local nowWave = (camp == Constants.Camp.One) and self.nowSelfWave or self.nowWave
    Events.Broadcast(Constants.EventNames.BattleWaveChangeShow, { waveNum = nowWave, camp = camp })
end

--获取站位
function BattleViewMgr:GetPath(isEnemy)
    if isEnemy then
        if not self.enemyPath then
            self.enemyPath = CS.UnityEngine.GameObject.Find("EnemyPath")
        end
        return self.enemyPath
    else
        if not self.myPath then
            self.myPath = CS.UnityEngine.GameObject.Find("MyPath")
        end
        return self.myPath
    end
end

function BattleViewMgr:tt( )
    BattleViewMgr:InitStand(6, true)
    BattleViewMgr:InitStand(4, false)
    for i,v in ipairs(self.roleViews) do
        v:GetStand(v.standIndex, v.camp)
        v:SyncStand()
    end
end

--@rs: [Game.BattleView.Entity.RoleView#RoleView<>]
function BattleViewMgr:InitStand(rsLength, isEnemy)
    local path = self:GetPath(isEnemy)
    if path == nil then
        printError('找不到角色站位, 场景id:'..self.sceneVo.id)
        return {
            position = Vector3.New(0, 0, 0),
            rotation = Vector3.New(0, 0, 1)
        }
    end
    local waveStands = nil
    if isEnemy then
        self.enemyStands = {}
        waveStands = self.enemyStands
    else
        self.myStands = {}
        waveStands = self.myStands
    end
    local total = rsLength
    if isEnemy and self.levelData and self.levelData[self.nowWave] then
        local waveData = self.levelData[self.nowWave]
        if waveData.maxNum > total then
            total = waveData.maxNum
        end
    end
    local cinemachinePath = path:GetComponent(typeof(CS.Cinemachine.CinemachinePathBase))
    local min = cinemachinePath.MinPos
    local max = cinemachinePath.MaxPos
    local pathLength = cinemachinePath.PathLength

    local totalWidth = 0
    local scale = (max - min) / pathLength
    --每个角色有各自的宽度，需要让分布保证各自的边界距离相邻端点或角色边界距离相等

    --先得到所有角色总宽度
    -- for i,v in ipairs(rs) do
    --     totalWidth = totalWidth + v.modelVo.width
    -- end
    -- --如果排布的怪物超过了总宽度，则需要进行间隔缩放
    -- if totalWidth * scale > (max - min) then
    --     scale = (max - min) / totalWidth
    -- end
    --然后获得相邻距离,少除一份,两边距离等于只占一半
    local edge = (max - min) / total
    --然后按顺序一个个给值
    local nowValue = min - edge / 2
    for i=1,total do
        nowValue = nowValue + edge
        local pos = cinemachinePath:EvaluatePosition(nowValue)
        local stand = {
            position = pos,
            rotation = isEnemy and Quaternion.FromToRotation(Vector3.forward, self.sceneVo.enemyLookAtPoint - pos):ToEulerAngles() or self.sceneVo.roleDir
        }
        table.insert(waveStands, stand)
    end

    waveStands[Constants.SpecialSummonPosition] = {
        position = Vector3.New(0, 0, 0),
        rotation = isEnemy and self.sceneVo.enemyDir or self.sceneVo.roleDir
    }
    -- local start = math.floor((total - #rs) / 2)
    -- for i,v in ipairs(rs) do
    --     v:SetStand(waveStands[start + i])
    -- end
end

function BattleViewMgr:GetStand( pos, camp )
    if pos == -1 then
        if BattleInfo:IsUserCamp(camp) then
            return self.sceneVo.roleSummonStand
        else
            return self.sceneVo.enemySummonStand
        end
        return {
            position = Vector3.New(0, 0, 0 ),
            rotation = Vector3.New(0, 0, 0 )
        }
    end
    local waveStands = BattleInfo:IsUserCamp(camp) and self.myStands or self.enemyStands
    local stand = waveStands[pos]
    if not stand then
        -- print("BattleViewMgr:GetStand", pos, camp, table.toString(waveStands,"waveStands"))
        return {
            position = Vector3.New(9999, 0, 0 ),
            rotation = Vector3.New(0, 0, 0 )
        }
    end
    return stand
end

--事先读取一下配置
function BattleViewMgr:WarmUpData(initData)
    --配置表加载
    settingMgr:Get(AutoIds.IdSetting261)
    settingMgr:Get(AutoIds.IdSetting262)
    settingMgr:Get(AutoIds.IdSetting263)
    settingMgr:Get(AutoIds.IdSetting264)
    settingMgr:Get(AutoIds.IdSetting265)
    settingMgr:Get(AutoIds.IdSetting266)
    settingMgr:Get(AutoIds.IdSetting267)
    settingMgr:Get(AutoIds.IdSetting268)
    settingMgr:Get(AutoIds.IdSetting269)
    settingMgr:Get(AutoIds.IdSetting270)
    settingMgr:Get(AutoIds.IdSetting271)
    settingMgr:Get(AutoIds.IdSetting272)
    settingMgr:Get(AutoIds.IdSetting273)
    settingMgr:Get(AutoIds.IdSetting274)
    settingMgr:Get(AutoIds.IdSetting275)
    settingMgr:Get(AutoIds.IdSetting276)
end

--初始化
function BattleViewMgr:Register()
    self.__OnReceiveRecords = Bind(self, self.OnReceiveRecords)
    Events.AddListener(Constants.EventNames.BattleRecordShow, self.__OnReceiveRecords)

    self.__OnReceiveBattleRestart = Bind(self, self.OnReceiveBattleRestart)
    Events.AddListener(Constants.EventNames.BattleRestart, self.__OnReceiveBattleRestart)

    self.__OnChangeGameSpeed = Bind(self, self.OnChangeGameSpeed)
    Events.AddListener(Constants.EventNames.UIBattlingDoubleRateRunning, self.__OnChangeGameSpeed)

    self.__OnChangeLongIdleCamera = Bind(self, self.OnChangeLongIdleCamera)
    Events.AddListener(Constants.EventNames.UIBattlingChangeLongIdleCamera, self.__OnChangeLongIdleCamera)

    self.eventShowSkillStart = Events.AddListener(Constants.EventNames.BattleSkillStartShow, Bind(self, self.OnSkillShow))
    self.eventBattleRivalEnd = Events.AddListener(Constants.EventNames.BattleBossEnterEnd, Bind(self, self.OnBattleBossEnterEnd))
end

function BattleViewMgr:Unregister()
    Events.RemoveListener(Constants.EventNames.BattleRestart, self.__OnReceiveBattleRestart)
    Events.RemoveListener(Constants.EventNames.UIBattlingDoubleRateRunning, self.__OnChangeGameSpeed)
    Events.RemoveListener(Constants.EventNames.UIBattlingChangeLongIdleCamera, self.__OnChangeLongIdleCamera)
    Events.RemoveListener(Constants.EventNames.BattleRecordShow, self.__OnReceiveRecords)
    Events.RemoveListener(Constants.EventNames.BattleSkillStartShow, self.eventShowSkillStart)
    Events.RemoveListener(Constants.EventNames.BattleBossEnterEnd, self.eventBattleRivalEnd)
end

function BattleViewMgr:Init(d)
    self.initData = d
    self.roleViews = {}
    self.roleMoudles = {}
    self.catGameObjects = {}
    self.FXMgr = import("Game.BattleView.FXMgr")
    self.FXMgr:Init()
    self.gameSpeed = 1
    self.maxWave = #d.enemyTeam
    self.maxSelfWave = #d.playerTeam
    self.showBattleUIFinished = false
    ResMgr = import("Game.BattleView.Core.ResMgr")
    ResMgr:Init()
    CoManager = import("Game.BattleView.Core.CoManager")
    RecordReader = import("Game.BattleView.RecordReader.RecordReader")
    RecordReader:Init()

    self.battleUI = UIBattlingCtrlMgr:GetInstance()
    self.battleUI:InitBattlingData(d)

    self:Register()
end

function BattleViewMgr:Refresh()
    -- print("[流程] battle view mgr refresh")
    self.nowTurn = 0
    self.nowWave = 0
    self.hasRivaled = false
    self.requestManualExit = false
    self.afterManualExit = false
end

function BattleViewMgr:RestartBattle(initData, onLoadingFinished, waitForStart)
    self.onLoadingFinished = onLoadingFinished
    self.waitForStart = waitForStart
    self.showBattleUIFinished = false

    self:ClearChapter()
    for i, v in pairs(self.catGameObjects) do
        CS.UnityEngine.GameObject.Destroy(v)
        self.catGameObjects[i] = nil
    end
    self.catGameObjects = {}
    for i,v in fipairs(self.roleViews) do
        v:Dispose()
        v = nil
    end
    self.roleViews = {}
    self.reuseRoleInstanceData = {}     -- 清除重用角色，防止重开战斗时，角色变化导致没有在加载阶段实例化
    ResMgr:MarkAllFinishedToDispose()
    self:Refresh()
    self:ClearCo()
    CoManager:Dispose()
    xTry(function ()
        RecordReader:Reset()
    end)
    
    self:DestroySkillCat()

    self:ChangeRoleModleQuality(CS.CameraCustomData.RoleSettingEnum.LowQuality) -- 重开战斗时，设置为低模

    -- printInfo("initData " .. table.dump(initData))
    
    --initData = '{"questId":0,"randomSeed":"5de9cdd7978db","enemyTeam":[[{"type":1,"enemyId":34002091,"level":1,"pos":1,"weakId":0,"attr":"3=10000&1=100&2=80","ai":"monster/monster_34002091_001","attribute":3,"generalSkills":{"4":540400264,"1":510400264,"2":520400264,"6":560400264},"finalSkills":"570400264=1","summonPriority":999,"id":10,"summons":[],"passiveSkills":"2800101=1&2000406=1&2800135=1&2800136=1&2800133=1&99940=1","career":1,"skinId":30400201}]],"mapId":2,"playerTeamSkill":"","skillQueue":"","skillQueueLoop":1,"playerTeam":[[{"attribute":1,"level":1,"attr":"1=100&2=80&3=10000&25=0&26=0&27=0&28=0&29=0&30=0&37=95&40=0&35=0&41=0&36=0&32=0&20=0","passiveSkills":"","weakId":0,"generalSkills":{"2":72101001,"1":71101001},"finalSkills":"73101001=1","summonPriority":1,"id":1,"summons":[{"type":1,"enemyId":30400001,"level":1,"weakId":0,"attr":"3=10000&1=100&2=80","ai":"monster/equip/monster_4_xiaoguai","attribute":4,"generalSkills":{"1":510101810},"finalSkills":"570101810=1","summonPriority":1,"id":77001,"summons":[],"passiveSkills":"14000070=1","career":2,"skinId":30101801}],"cardId":101001,"career":2,"skinId":10100101},{"attribute":1,"level":1,"attr":"1=100&2=80&3=10000&25=0&26=0&27=0&28=0&29=0&30=0&37=95&40=0&35=0&41=0&36=0&32=0&20=0","passiveSkills":"","weakId":0,"generalSkills":{"2":72104001,"1":71104001},"finalSkills":"73104001=1","summonPriority":1,"id":2,"summons":[],"cardId":104001,"career":1,"skinId":10400101},{"attribute":2,"level":1,"enterVoice":true,"attr":"1=100&2=80&3=10000&25=0&26=0&27=0&28=0&29=0&30=0&37=95&40=0&35=0&41=0&36=0&32=0&20=0","passiveSkills":"","weakId":0,"generalSkills":{"2":72103008,"1":71103008},"finalSkills":"73103008=1","summonPriority":1,"id":3,"summons":[],"cardId":103008,"career":4,"skinId":10300801},{"attribute":3,"level":1,"attr":"1=100&2=80&3=10000&25=0&26=0&27=0&28=0&29=0&30=0&37=95&40=0&35=0&41=0&36=0&32=0&20=0","passiveSkills":"","weakId":0,"generalSkills":{"2":72101005,"1":71101005},"finalSkills":"73101005=1","summonPriority":1,"id":4,"summons":[],"cardId":101005,"career":1,"skinId":10100501}]]}'
    --if initData then
    --    initData = table.deserialize(initData)
    --end
    initData = initData or BattleInfo.initData
    self.initData = initData
    
    printInfo("initData " .. table.dump(initData))

    self:FindLoadingUI(initData)
    BattleInfo:ResetInitData(initData)
    self:ResetCamera(true)
    self:InitVcamLens()
    BattleMgr:Clear()

    BattleMgr:Init(initData)

    self:ClearCacheAndGC()
  
    -- self.battleUI:BattleReStart(initData, function()
    --     self:StartBattle()
    -- end)
    xTry(function()
        cs_coroutine.start(function()
            cs_coroutine.yield_return(self.battleUI:CleanUIBattleElement())
            self.battleUI:InitBattlingData(initData)
            self:PreLoad(initData)
        end)
    end)

    self:InitRecordInterpreter(initData)
end

--- 准备再次开始时候的清理工作
function BattleViewMgr:PrepareRestart()
    self.showBattleUIFinished = false
    self:ClearChapter()
    for i,v in fipairs(self.roleViews) do
        v:Dispose()
        v = nil
    end
    self.roleViews = {}
    ResMgr:MarkAllFinishedToDispose()
    self:Refresh()
    self:ClearCo()
    CoManager:Dispose()
    xTry(function ()
        RecordReader:Reset()
    end)
    self:DestroySkillCat()
    self:ResetCamera(true)
    BattleMgr:Clear()
    self:ClearCacheAndGC()
    self.battleUI:CleanUIBattleElement()
end

function BattleViewMgr:StartBattle()
    if isNotNull(self.coWaitOtherOvertime) then
        cs_coroutine.stop(self.coWaitOtherOvertime)
        self.coWaitOtherOvertime = nil
    end
    -- CS.UnityEngine.Debug.unityLogger.logEnabled = false
    -- print("StartBattle", self.initData.playerName, debug.traceback())
    -- 序章和教学关卡，不发SDk事件
    local questId = self.initData.questId
    if not table.isContain(Constants.QUEST_OP_LEVEL, questId)
    and not GamePlayGuideMgr then
        xTry(function()
            local SDKService = import("Game.Entry.SDKService")
            SDKService:GetInstance():AceSDKCall("AceDataSend2")
            -- SDKService:QueryYDRiskPerceptionData()
        end)
    end

    -- 提前加载战斗UI
    -- coroutine.yield(self.battleUI:ShowUIBattlingDialog())

    self.battleState = Constants.BattleState.Processing
    -- 第一波剧情
    self:AddSpeedLinePlane()

    self.showBattleUIFinished = true
    self:Refresh()
    -- CS.UnityEngine.Resources.UnloadUnusedAssets()

    --加载战斗UI
    self.battleUI:ShowUIBattlingDialog()
    
    self:PlayWaveChapter(1, true, true)   -- 战前剧情，isGameOver给了true，主要是为了要剧情结束时的黑屏
    
    Events.Broadcast(Constants.EventNames.UIBattingStoryRunning, false)     -- 播放完剧情会把UI全给打开，这里因为还没有开始战斗，所以再关上
    
    self:HideLoadingUI()    -- 放在剧情后面，防止在剧情预制体加载完之前露出战斗场景

    if BattleInfo.playMode == Constants.PlayMode.Replay then
        RecordReader:ShowRecords(BattleInfo.recordData)
    else
        BattleMgr:InitBattle()

        -- 序章2战前剧情结束之后趁着黑屏直接开始走流程，跳过入场动画，等序章2的第一段战中剧情出来的时候再去掉黑屏
        if self.initData.questId == Constants.QUEST_OP_LEVEL[2] then
            self:OnReceiveRecords()
        else
            -- 播放游戏开始的UI展示，等待一段时间
            -- coroutine.yield(Yielders.GetWaitForSeconds(0.9)) -- loading界面会延迟1s销毁
            CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar"):ShowBackAnimation() -- 一个黑屏过渡遮罩
            coroutine.yield(Yielders.GetWaitForSeconds(0.1))
            Events.Broadcast(Constants.EventNames.BattleStartGameShow) -- 显示start界面
            coroutine.yield(Yielders.GetWaitForSeconds(0.4)) -- start界面动画时长1s     -- 不用等动画播完就可以开始后续的角色入场了
            -- 广播战斗初始化信息,主要是给ui用的
            self:OnReceiveRecords()
        end
    end
    self:DebugTestNetwork()
end

--- 创建UnitCat
---@param camp any
function BattleViewMgr:CreateCat(camp)
    local data = self.initData.myPartyCat
    if isNull(data) or not data.id or not data.catId then
        return
    end
    local parts = {}
    for i,v in ipairs(data.genes) do
        table.insert(parts,v.geneId)
    end
    cs_coroutine.yield_return(CS.Game.Native.Corder.AutoPNGWriter.LoadCatAsync(2, tostring(data.catId), true, parts, self.rootNode, function(go)
        ---@type UnityEngine.Transform
        go.name = tostring(data.catId)
        go:AddComponent(typeof(CS.CustomLightDirRelativeCamera))
        local animancer = go:GetComponent(typeof(CS.Animancer.NamedAnimancerComponent))
        CS.UnityEngine.GameObject.DestroyImmediate(animancer)
        local scale = Core:GetBattleParamNum("battleCatSize")
        go.transform.localScale = Vector3.New(scale, scale, scale)
        local UnitCat = import("Game.BattleView.Entity.UnitCat")
        self.cat = UnitCat.New(data, camp, go)
    end))
end

function BattleViewMgr:OnCreateSkillCat(record)
    -- 猫球在预加载的时候就已经创建了
    -- 这里只同步猫球数据给UI
    Events.Broadcast(Constants.EventNames.BattleInitSkillCat, record)
end

--- 创建主动技能猫球
function BattleViewMgr:CreateSkillCat()
    if isNull(self.initData.playerCatTeam) and isNull(self.initData.enemyCatTeam) then return end

    local catDatas = {}
    local team1 = self.initData.playerCatTeam[1] or {}
    local team2 = self.initData.enemyCatTeam[1] or {}
    for i, v in ipairs(team1) do
        v.camp = Constants.Camp.One
    end
    for i, v in ipairs(team2) do
        v.camp = Constants.Camp.Two
    end
    table.link(catDatas, team1)
    table.link(catDatas, team2)
    if table.count(catDatas) == 0 then
        return
    end
    self.skillCatViews = {}
    -- 创建猫球
    for i, catData in ipairs(catDatas) do
        local catId = catData.catId
        local tableFile = settingMgr:Get(AutoIds.IdSetting6033)
        local row = tableFile:GetByPrimaryKey(catId, false)
        local catTypeId = parse_number(row, "catId", 101)
        local genes = parse_strings(parse_string(row, "kind", ""), ";")

        local parts = {}
        for i,v in ipairs(genes) do
            table.insert(parts,checkInt(v))
        end
        cs_coroutine.yield_return(CS.Game.Native.Corder.AutoPNGWriter.LoadCatAsync(2, tostring(catTypeId), true, parts, self.rootNode, function(go)
            ---@type UnityEngine.Transform
            go.name = tostring(catData.id)
            go:AddComponent(typeof(CS.CustomLightDirRelativeCamera))
            local animancer = go:GetComponent(typeof(CS.Animancer.NamedAnimancerComponent))
            CS.UnityEngine.GameObject.DestroyImmediate(animancer)
            local scale = Core:GetBattleParamNum("battleCatSize")
            go.transform.localScale = Vector3.New(scale, scale, scale)
            local SkillCat = import("Game.BattleView.Entity.SkillCat")
            local catView = SkillCat.New(catData, go)
            table.insert(self.skillCatViews, catView)

            if catData.type == 1 then
                
            end
        end))
    end
end

--- 销毁猫球
function BattleViewMgr:DestroySkillCat()
    if self:HasSkillCat() then
        for i, v in ipairs(self.skillCatViews) do
            if v and isNotNull(v.gameObject) then
                CS.UnityEngine.GameObject.Destroy(v.gameObject)
                v:Delete()
            end
        end
    end
    self.skillCatViews = nil
end

function BattleViewMgr:HasSkillCat()
    return isNotNull(self.skillCatViews) and table.count(self.skillCatViews) > 0
end

function BattleViewMgr:OnReceiveRecords()
    local battleRecords = RecordMgr:GetData()
    RecordReader:ShowRecords(battleRecords)
end

function BattleViewMgr:OnReceiveBattleRestart(data)
    local battleData = data.initData
    self:RestartBattle(battleData)
end

--- 释放技能时
---@param skillInfo {roleId, skillId, skillIndex, star, lv, targetIds, isInput}
function BattleViewMgr:OnSkillShow(skillInfo)
    if not skillInfo.isInput then return end
    local roleView = self:FindRoleView(skillInfo.roleId)
    if not roleView.isPlayer then return end
    
    local canPlay = self:CanPlaySkillVoice(skillInfo)
    if canPlay then
        -- 播放普通技能语音
        self:PlayCardNormalSkillVoice(roleView.typeId, skillInfo.skillIndex)
    end

    self.lastSkillPlayedVoice = canPlay
    self.lastSkillRoleId = skillInfo.roleId
end

function BattleViewMgr:CanPlaySkillVoice(skillInfo)
    if skillInfo.skillIndex == 0 then
        -- print("[技能语音] sp skill", false)
        return false
    end

    local isSameRole = false
    if isNotNull(self.lastSkillRoleId) then
        isSameRole = self.lastSkillRoleId == skillInfo.roleId
    end

    if isSameRole then
        -- print("[技能语音] same role", true)
        return true
    end

    local lastSkillVoicePlayed = false
    if isNotNull(self.lastSkillPlayedVoice) then
        lastSkillVoicePlayed = self.lastSkillPlayedVoice
    end

    if lastSkillVoicePlayed then
        -- print("[技能语音] last played", false)
        return false
    end

    local rate = Core:GetBattleParamNum(Constants.BattleParam.SkillVoicePlayRate)
    local rand = math.random(0,1)
    local canPlay = rand > rate
    
    -- print("[技能语音] random", canPlay)
    return canPlay
end

---播放普通技能语音
---@param cardId integer 播放语音的卡牌id
---@param skillIdx integer 技能序号
function BattleViewMgr:PlayCardNormalSkillVoice(cardId, skillIdx)
    if skillIdx == 1 then
        RoleVoiceMgr:GetInstance():PlaySkillAVoiceByCardId(cardId)
    elseif skillIdx == 2 then
        RoleVoiceMgr:GetInstance():PlaySkillBVoiceByCardId(cardId)
    end
end

--- 清理技能语音的记录
function BattleViewMgr:ResetSkillVoiceRecord()
    self.lastSkillPlayedVoice = nil
    self.lastSkillRoleId = nil
end

function BattleViewMgr:TurnStart(camp)
    Events.Broadcast(Constants.EventNames.BattleTurnStartShow, { isMyTurn = BattleInfo:IsUserCamp(camp), turn = self.nowTurn })
    --如果是我方的话，当前回合数加1
    if camp == Constants.Camp.One then
        self.nowTurn = self.nowTurn + 1
        --通知
        self:PlayRoundChapter(self.nowTurn)
        Events.Broadcast(Constants.EventNames.BattleRoundChangeShow, { round = self.nowTurn })
    end

    -- coroutine.yield(WaitForSeconds(1))
    self:ResetCamera()
    self:ResetSkillVoiceRecord()

    local rs = self:FindCampRoles(camp)
    for i, v in ipairs(rs) do
        if not v:IsDead() then
            v.buffViewMgr:OnTurnStart()
        end
    end
end

function BattleViewMgr:TurnEnd(camp)
    if camp ~= Constants.Camp.One then
        local t = self.sceneVo.battleAndUICameraSwitchTime
        coroutine.yield(WaitForSeconds(t))

        -- UIBattlingPVPMgr.timerStart =  CS.Engine.Http.TimeZoneUtils.UtcSeconds - UIBattlingPVPMgr.waitingSeconds - 1
        -- self.battleUI:GetBattlingDialog():ActionOnMyPlayerInputFinish()

        if BattleInfo:IsOnline() then
            self.netMgr:Send(self.netMgr.SendPackageIds.PlayRecordFinished, {round = self.nowTurn + 1})
        end
    end

    local rs = self:FindCampRoles(camp)

    for i, v in ipairs(rs) do
        if not v:IsDead() then
            v.buffViewMgr:OnTurnEnd()
        end
    end

   
end

--- 联机模式第一回合请求回合开始
function BattleViewMgr:RequireFirstTurnStart()
    if BattleInfo:IsOnline() and not (self.isReconnectOutside == 1) then
        -- 不是重连的正常情况下，第一回合的回合开始是在表现层表现完成以后进行请求的
        self:DebugTestNetwork()
        self.netMgr:AddCache(self.netMgr.SendPackageIds.PlayRecordFinished, {round = 1, type = 1}, true)  -- 这条消息不能丢，否则第一回合就永远开始不了了，所以这里手动强制添加一个缓存
        self.netMgr:Send(self.netMgr.SendPackageIds.PlayRecordFinished, {round = 1, type = 1})
    else
        -- 战斗外重连时，请求重连数据
        self.waitSyncGame = 1
        self.netMgr:Send(self.netMgr.SendPackageIds.Refresh, {
            playerId = GameUtils.GetPlayerId(),
            roomId = self.roomId
        })
    end
end

function BattleViewMgr:ResetCamera(isForce)
    local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
    if not isForce then
        isForce = false
        --去除nil的情况
    end
    local rotation = SkillCameraMgr.gameObject.transform.rotation
    CS.Engine.Lib.KTool.ResetTransform(SkillCameraMgr.gameObject.transform)
    SkillCameraMgr:FocusCmMainCamera(isForce)
    self:RestartLongIdle()
    SkillCameraMgr.gameObject.transform.rotation = rotation
    -- self:ResetAllStand()
end

function BattleViewMgr:SwithToUICamera()
    local t = BattleViewMgr.sceneVo.battleAndUICameraSwitchTime
    local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
    SkillCameraMgr:SwitchBattleCamera(false, t)
    self:ResetCamera()
end

function BattleViewMgr:RestartLongIdle()
    --倒计时
    -- self:StopLongIdle()
    -- self.longIdleCo = cs_coroutine.start(
    --     function()
    --         coroutine.yield(CS.UnityEngine.WaitForSecondsRealtime(60))
    --         CS.Game.Native.Battle.BattleSkillCameraMgr.Instance:StartLongIdle()
    --         Events.Broadcast(Constants.EventNames.UIBattlingChangeLongIdleCamera, 1)
    --     end
    -- )
end

function BattleViewMgr:StopLongIdle()
    -- if self.longIdleCo then
    --     cs_coroutine.stop(self.longIdleCo)
    --     self.longIdleCo = nil
    -- end
    -- CS.Game.Native.Battle.BattleSkillCameraMgr.Instance:StopLongIdle()
end

function BattleViewMgr:OnChangeLongIdleCamera(isOn)
    -- print("OnChangeLongIdleCamera:" .. isOn)
    if isOn == 0 then
        self:RestartLongIdle()
    end
end

function BattleViewMgr:StartCharacterCamera(roleId, blendTime)
    blendTime = blendTime or 0
    local rv = self:FindRoleView(roleId)
    if not rv or rv:IsDead() then
        return
    end
    --隐藏其他角色,只显示被关注的角色
    for i, role in ipairs(self.roleViews) do
        if role.id ~= roleId then
            role:Hide()
        else
            role:SyncStand()
        end
    end

    --移除之前的角色相机
    if self.characterCamera then
        CS.UnityEngine.GameObject.Destroy(self.characterCamera)
    end

    --创建一个新的虚拟相机
    self.characterCamera = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance:StartCharacterCamera(rv.transform, rv.modelVo.detailPosition, rv.modelVo.detailDirection, blendTime)
end

function BattleViewMgr:StopCharacterCamera()
    for i, role in ipairs(self.roleViews) do
        if not role:IsDead() then
            role:SyncStand()
        end
    end

    if self.characterCamera then
        CS.UnityEngine.GameObject.Destroy(self.characterCamera)
    end
end

function BattleViewMgr:ResetAllStand()
    for i, role in ipairs(self.roleViews) do
        role:SyncStand()
    end
end

function BattleViewMgr:GameOver(isWin, gameEndData)
    gameEndData = checkTable(gameEndData)
    -- print("[加载] GameOver", CS.UnityEngine.Time.realtimeSinceStartup)
    if self.battleState == Constants.BattleState.End then
        printError('游戏重复进入结算流程,如果看到这个报错,请通知我(水稻)!!:' .. (table.toString(gameEndData, "gameEndData") or "") .. (debug.traceback() or ""))
        return
    end
    self.battleState = Constants.BattleState.End
    self:DebugTestNetwork()
    -- 第一次通关主线章节关卡时，修改主界面BGM
    if isWin then
        local isFirstPass = QuestConfMgr:GetInstance():IsMainChapterFirstPass(self.nowLevelId)
        if isFirstPass then
            local vo = QuestConfMgr:GetInstance():GetMainQuestPlotVo(self.nowLevelId)
            CS.Engine.Lib.KCookie.Set("MainChapterFirstPassBGM", vo.music)
            print("[BGM] 主线首通", self.nowLevelId, vo.music)
        end
    end
    
    local IsOpenOp =  AppEngine.GetConfig("Engine.Dev", "IsOpenOp")
    local curOp = QuestConfMgr:GetInstance():GetCurOpId()
    if checkNumber(IsOpenOp) > 0 and curOp ~= 0 then
        -- RecordReader.SkillRecordReader:DestroyTl()
        coroutine.yield(self:PlayWaveChapter(self.nowWave, false))
    else
        if BattleInfo.gameMode == Constants.GameMode.PVE and (isWin or self.nowLevelId == Constants.QUEST_DOUBLE_GUIDE) then
            if checkNumber(self.nowLevelId) == Constants.QUEST_GUIDE_ID then
                coroutine.yield(self:PlayWaveChapter(self.nowWave, false))
                return
            else
                coroutine.yield(self:PlayWaveChapter(self.nowWave, false, true))
            end
        end
    end

    if self.opTimelineLoaders and table.count(self.opTimelineLoaders) > 0 then
        for i, loader in ipairs(self.opTimelineLoaders) do
            loader:Release()
        end
    end

    self:StopView()
    self:SwithToUICamera()  -- 把战斗相机复原到main相机的位置上
    
    local data = {}
    -- Events.Broadcast(Constants.EventNames.BattleRestart, {})
    if BattleInfo:IsOnline() then
        data = {
            isWin = isWin,
            recordData = gameEndData.recordData,
        }
    elseif BattleInfo:IsPVE() then
        data = {
            isWin = isWin,
            turn = gameEndData.t,
            deadCount = gameEndData.dc,
            healthData = gameEndData.healthData,
            energyData = gameEndData.energyData,
            totalGiveDamage = gameEndData.totalGiveDamage,
            totalUsedCard = gameEndData.totalUsedCard,
            totalUnitedCard = gameEndData.totalUnitedCard,
            totalUsedSp = gameEndData.totalUsedSp,
            recordData = gameEndData.recordData,
        }
    end
    print(table.toString(data, "BattleViewMgr:GameOver"))
    --游戏结束，通知
    Events.Broadcast(
        Constants.EventNames.BattleGameOverShow,
        data
    )
    -- 序章和教学关卡，不发SDk事件
    local questId = self.initData.questId
    if not table.isContain(Constants.QUEST_OP_LEVEL, questId)
    and not GamePlayGuideMgr then
        xTry(function()
            local SDKService = import("Game.Entry.SDKService")
            SDKService:GetInstance():AceSDKCall("AceDataSend2") 
            -- SDKService:QueryYDRiskPerceptionData()
        end)
    end
    --战斗失败胜利音效，会自动停止战斗背景音乐
    --AudioManager.Instance:EnsurePlaySFX(isWin and Constants.BattleWinSound or Constants.BattleLoseSound)
    coroutine.yield(WaitForSeconds(1))
end

--- 获取我自己的猫球
function BattleViewMgr:GetSkillCat(camp, type)
    if self:HasSkillCat() then
        for i, v in ipairs(self.skillCatViews) do
            if v.camp == camp and v.type == type then
                return v
            end
        end
    end
    return nil
end

--@return [Game.BattleView.Entity.RoleView#RoleView]
function BattleViewMgr:FindRoleView(id)
    if self:HasSkillCat() then
        for i, v in ipairs(self.skillCatViews) do
            if v.id == id then
                return v
            end
        end
    end
    for i, v in ipairs(self.roleViews) do
        if v.id == id then
            return v
        end
    end
end
--@return [Game.BattleView.Entity.RoleView#RoleView<>]
function BattleViewMgr:FindCampRoles(camp)
    local rs = {}
    for i, v in ipairs(self.roleViews) do
        if (v.camp == camp) then
            table.insert(rs, v)
        end
    end
    return rs
end

--获取buff的飘字信息
---@param buffEffectId integer
---@param buffId integer
---@param star integer
---@param lv integer
---@return string, string
function BattleViewMgr:GetBuffInfo(buffEffectId, buffId, star, lv)
    if Tools.isNullKey(buffEffectId) or Tools.isNullKey(buffId) then return end
    --判断是否要飘字，根据配表
    local setting = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
    --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
    local skillEffectViewVo = setting:Get(buffId)
    if isNull(skillEffectViewVo) or skillEffectViewVo.isWord ~= 1 then return end
    -- local data = Core:GetBuffEffectData(buffEffectId, star, lv)
    -- --- 属性变更类 Buff 的跳字提示
    -- if data.mainEffectType == Constants.BuffType.AttributeChange then
    --     --找到对应的属性值
    --     --@RefType [Game.Setting.Vo.BasicAttrAdditionVo#BasicAttrAdditionVo]
    --     local attrData = cardConfMgr:GetBasicAttrAdditionById(data.subEffectType)
    --     if attrData then
    --         local vDesc = attrData.attrAdditionName
    --         local vOppsite = attrData.oppsite
    --         local vEffectNum = data.effectNum1[1]
    --         local vSelectDesc = vOppsite * vEffectNum
    --         local vOppShow = vSelectDesc >= 0 and Constants.GetOppsiteDesc.Up or Constants.GetOppsiteDesc.Down
    --         local svEffectNum = math.abs(data.effectNum1[1])
    --         return string.format("%s%s",vDesc,vOppShow), attrData.isConversion == 1 and math.floor(svEffectNum * 100) .. "%" or svEffectNum .. ""
    --     end
    -- end
    --- 获取效果表现表的 Desc 字段
    return skillEffectViewVo.desc or ""
end

function BattleViewMgr:ResetCameraRadiaBlur()
    -- print(table.toString(self.camera,"camera"))
    if not self.blur then
        self.blur = self.camera.gameObject:AddComponent(typeof(CS.RadiaBlur))
        self.blur.enabled = false
    end
    self.blur.Level = math.floor(11.5)
    self.blur.BufferRadius = 0.6
    self.blur.CenterX = 0.5
    self.blur.CenterY = 0.352
end

function BattleViewMgr:AddRadialBlur()
    self.blur = self.camera.gameObject:GetComponent(typeof(CS.RadiaBlur))
    if isNull(self.blur) then
        self.blur = self.camera.gameObject:AddComponent(typeof(CS.RadiaBlur))
    end
    self.blur.enabled = true
    self.blur.Level = math.floor(15)
    self.blur.BufferRadius = 0.3
    self.blur.CenterX = 0.35
    self.blur.CenterY = 0.5
    self.blur.InnerRadius = 0.55
    self.blur.OuterRadius = 0.55
    self.blur.MaskScaleX = 10
    self.blur.MaskScaleY = 10
end

function BattleViewMgr:RemoveRadialBlur()
    if not isNull(self.blur) then
        self.blur.enabled = false
    end
end

--- 插值一个径向模糊
---@param lerpParam any
---@param duration any
function BattleViewMgr:LerpRadialBlur(lerpParam, duration)
    self.blur = self.camera.gameObject:GetComponent(typeof(CS.RadiaBlur))
    if isNull(self.blur) then
        self.blur = self.camera.gameObject:AddComponent(typeof(CS.RadiaBlur))
    end
    self.blur.enabled = true
    self.blur.Level = 15
    self.blur.BufferRadius = lerpParam.bufferRadiusFrom
    self.blur.CenterX = 0.5
    self.blur.CenterY = 0.5
    self.blur.InnerRadius = lerpParam.innerRadiusFrom
    self.blur.OuterRadius = lerpParam.outerRadiusFrom
    self.blur.MaskScaleX = 10
    self.blur.MaskScaleY = 10
    -- lerpParam = {
    --     outerRadiusFrom = 1,
    --     outerRadiusTo = 0.3,
    -- }
    local rTime = 0.2
    local time = duration
    local timer = 0
    -- local curve = AnimationCurve.Linear(0,0,1,1)
    local curve = AnimationCurve()
    curve:AddKey(Keyframe(0,0,3,3))
    curve:AddKey(Keyframe(1,1,0,0))
    while timer < time do
        timer = timer + 0.016
        cs_coroutine.yield_return(WaitForSecondsRealtime(0.016))
        local bufferRadius = Mathf.Lerp(lerpParam.bufferRadiusFrom, lerpParam.bufferRadiusTo, curve:Evaluate(timer / time))
        local innerRadius = Mathf.Lerp(lerpParam.innerRadiusFrom, lerpParam.innerRadiusTo, curve:Evaluate(timer / time))
        local outerRadius = Mathf.Lerp(lerpParam.outerRadiusFrom, lerpParam.outerRadiusTo, curve:Evaluate(timer / time))
        -- self.blur.Level = math.floor(level)
        self.blur.BufferRadius = bufferRadius
        self.blur.InnerRadius = innerRadius
        self.blur.OuterRadius = outerRadius
    end
end

function BattleViewMgr:AddSpeedLinePlane()
    local sl = GameObject.Find("SpeedLine")
    if not isNull(sl) or not isNull(self.speedLine) then
        self.speedLine = self.speedLine or sl
        self.speedLine:SetActive(false)
        return
    end
    local loader = ResourceModule.LoadBundleAsync("Effect/prefab/fx_screen_uv_plane.prefab", nil, true)
    while not loader.IsSuccess do
        cs_coroutine.yield_return()
    end
    if not loader.IsError then
        ---这里还出现卡，人物的prefab需要优化
        -- local go = GameObject.Instantiate(loader.ResultObject)
        local go = loader:Instantiate()
        go.name = "SpeedLine"
        go:SetActive(false)
        go.transform:SetParent(self.camera.transform)
        CS.Engine.Lib.KTool.ResetTransform(go.transform)
        self.speedLine = go
    end
    loader:Release()
    loader = nil
end

function BattleViewMgr:GetAoe(targetCamp)
    return BattleInfo:IsUserCamp(targetCamp) and self.teamAoe or self.enemyAoe
end

function BattleViewMgr:OnChangeGameSpeed(nowSpeed)
    if nowSpeed == 3 then
        self.gameSpeed = 2
    elseif nowSpeed == 2 then
        self.gameSpeed = 1.2
    else
        self.gameSpeed = 1
    end
    
    self:ChangeGameSpeed(self.gameSpeed)
end

function BattleViewMgr:ChangeGameSpeed( speed, ignoreAudio )
    -- print("[倍速]", speed, debug.traceback())
    CS.UnityEngine.Time.timeScale = speed
    CS.TimeDilationMixerBehaviour.gameSpeedTimeScale = speed
    if not ignoreAudio then
        CriWareUtils.SetAudioSpeed(speed)
    end
end


function BattleViewMgr:OnSyncRole( record )
    for i,data in ipairs(record.datas) do
        local roleView = self:FindRoleView(data.id)
        for k,v in pairs(Constants.AttrTypeId) do
            v = tostring(v)
            if data.values[v] then
                roleView.attr.values[v] = data.values[v]
            else
                if BattleInfo.playMode ~= Constants.PlayMode.Replay then
                    roleView.attr.values[v] = 0
                else
                    if checkInt(v) ~= Constants.AttrTypeId.NowHp then
                        roleView.attr.values[v] = 0
                    end
                end
            end
        end
    end
end


function BattleViewMgr:OnSyncRoleStatus( record )
    local roleId = record.id
    local status = record.status
    local roleView = self:FindRoleView(roleId)
    if not roleView then
        return
    end

    -- --如果是不能行动状态就播发weak
    -- if not status.canAction then
    --     roleView:SwitchIdle(Constants.IdleType.Weak)
    -- else
    -- --否则播放普通Idle
    --     roleView:SwitchIdle(Constants.IdleType.Normal)
    -- end

end


function BattleViewMgr:PlaySFX(sfxId, roleView)
    if sfxId == 0 or sfxId == "0" or sfxId == "" then
        return
    end

    if not roleView.gameObject.activeInHierarchy then return end

    CriWareUtils.PlaySeById(sfxId, roleView.gameObject)
end

function BattleViewMgr:StopSFX(sfxId)
    if sfxId == 0 or sfxId == "0" or sfxId == "" then
        return
    end
    CriWareUtils.StopById(sfxId)
end

function BattleViewMgr:PlayCameraSFX(sfxId)
    if sfxId == 0 or sfxId == "0" or sfxId == "" then
        return
    end
    CriWareUtils.PlaySeById(sfxId, self.camera.gameObject)
end

---PlayWaveChapter
---@param wave number 波数
---@param isFront boolean 是否剧情前段
---@param isGameOver boolean 是否是剧情结束点，不删除剧情对象
function BattleViewMgr:PlayWaveChapter( wave, isFront, isGameOver)
    isGameOver = checkBool(isGameOver)
    if not self.levelData then
        return
    end
    local waveData = self.levelData[wave]
    if not waveData then
        --直接播放音乐
        -- print("[声音] BGM", self.sceneVo.sceneMusic)
        CriWareUtils.PlayMusicById(self.sceneVo.sceneMusic)
        return
    end

    local tableFile = settingMgr:Get(AutoIds.IdSetting2512)
    local row = tableFile:GetByPrimaryKey(self.initData.questId, false)
    if isNull(row)  then
        -- print("[声音] BGM", self.sceneVo.sceneMusic)
        CriWareUtils.PlayMusicById(self.sceneVo.sceneMusic)
        return
    end

    local tmp = isFront and parse_string(row,"plotIdWave" .. wave, '') or parse_string(row, "plotIdEndWave" .. wave, '')
    local ids = string.isEmpty(tmp) and 0 or parse_strings(tmp)
    
    -- local ids = isFront and waveData.waveFront or waveData.waveAfter
    --printInfo(wave)
    --printInfo(isFront)
    
    if ids ~= 0 and isTable(ids) and #ids  then
        -- print("[剧情] wave start", wave, isFront, isGameOver, #ids, table.dump(ids))
        --print(table.dump(ids))
        self.xs = {}
        -- self:SwitchShow(false)
        
        for i = 1, #ids do
            printInfo(ids[i])
            if not string.isEmpty(ids[i]) then
                coroutine.yield( self:PlayChapter(tonumber(ids[i]), isGameOver and (i == #ids), i < #ids))
            end
        end

        --AudioManager.Instance:StopMusic()
        
        self:SwitchShow(true)
    -- else
        -- print("[剧情] wave start nil", isFront, wave)
    end
    -- print("[剧情] wave end")
    -- print("[声音] BGM", self.sceneVo.sceneMusic)
    CriWareUtils.PlayMusicById(self.sceneVo.sceneMusic)
end


function BattleViewMgr:PlayRoundChapter(round)
    round = checkString(round)
    if not self.levelData then
        return
    end
    local tableFile = settingMgr:Get(AutoIds.IdSetting2512)
    local row = tableFile:GetByPrimaryKey(self.initData.questId, false)
    if isNull(row)  then
        -- print("[声音] BGM", self.sceneVo.sceneMusic)
        CriWareUtils.PlayMusicById(self.sceneVo.sceneMusic)
        return
    end

    -- print("[剧情] round start")
    local roundTmp = parse_string(row, "plotIdRound", '')
    local rounds = string.isEmpty(roundTmp) and 0 or parse_strings(roundTmp)

    local plotTmp = parse_string(row, "plotIdRounds", '')
    local plots = string.isEmpty(plotTmp) and 0 or parse_strings(plotTmp)

    if rounds ~= 0 and isTable(rounds) and #rounds
    and plots ~= 0 and isTable(plots) and #plots then
        self.xs = {}
        for i = 1, #rounds do
            if not string.isEmpty(rounds[i]) and rounds[i] == round and not string.isEmpty(plots[i]) then
                coroutine.yield( self:PlayChapter(tonumber(plots[i]), false, false))
            end
        end
        self:SwitchShow(true)
    end
    -- print("[剧情] round end")
    -- print("[声音] BGM", self.sceneVo.sceneMusic)
    CriWareUtils.PlayMusicById(self.sceneVo.sceneMusic)
end

function BattleViewMgr:HideLoadingUI()
    if self.loadingUI then
        self.loadingUI:Close(true)
        self.loadingUI = nil
    end
end 

function BattleViewMgr:SwitchShow(isShow, moveRole)
    if isNull(moveRole) then
        moveRole = true
    end
    
    Events.Broadcast(Constants.EventNames.UIBattingStoryRunning, isShow)
    
    if not isNull(self.camera) then
        self.camera.gameObject:SetActive(isShow)
    end
    for i, role in ipairs(self.roleViews) do
        -- if role.transform then
            if not isShow and moveRole then
                print(role.id, role.typeId)
                self.xs[role.id] = role.transform.position
                role.transform.position = Vector3.New(999999, 0, 0)
            else
                if not isNull(self.xs[role.id]) then
                    role.transform.position = self.xs[role.id]
                end
            end
        -- end
    end
end

---PlayChapter
---@param chapterId number
---@param isGameOver boolean
function BattleViewMgr:PlayChapter( chapterId, isGameOver, hasNextOne)
    -- print("[剧情]",chapterId, isGameOver)
    if SkipChapterPlot or self.isReplay then
        return
    end

    if Tools.isNullKey(chapterId) then
        return
    end

    printInfo("PlayChapter %d", chapterId)
    -- print("[剧情] start", chapterId)

    local isFinish = false
    local obj = nil
    local ChapterUtils = import("Game.Chapter.ChapterUtils")
    local vo = ChapterUtils.GetChapterGeneralVo(chapterId)
    if not vo then
        return
    end

    local backupCamera = nil
    local plot3DCamera = nil

    self.coChapter = ChapterUtils.StartChapter( 
        vo , 
        function ( go )
            obj = go
            -- 战中对话剧情（一种可以看到场景的剧情）
            if vo.is2d == 3 then
                GameUtils.HideBlack(0.5)    -- 序章2开场跳过入场，这里关掉黑屏
                local plot3DCameraTF = go.transform:Find("3DCamera")
                plot3DCamera = plot3DCameraTF:GetComponent(typeof(CS.UnityEngine.Camera))

                -- 保存原本的相机参数
                local tmpGo = CS.UnityEngine.GameObject()
                backupCamera = tmpGo:AddComponent(typeof(CS.UnityEngine.Camera))
                backupCamera:CopyFrom(plot3DCamera)
                KTool.SetActive(tmpGo, false)

                -- 整体移动剧情预制体，让剧情的3d相机到主相机的位置上
                plot3DCameraTF:SetParent(nil)
                go.transform:SetParent(plot3DCameraTF)

                local mainCameraTF = self.backupCamera.transform
                plot3DCameraTF.position = mainCameraTF.position
                plot3DCameraTF.rotation = mainCameraTF.rotation

                go.transform:SetParent(nil)
                plot3DCameraTF:SetParent(go.transform)

                -- 拷贝主相机的参数
                plot3DCamera:CopyFrom(self.backupCamera)
            end
            self:SwitchShow(false, vo.is2d ~= 3)

            self:HideLoadingUI()

            local questId = self.initData.questId
            if questId == Constants.QUEST_OP_LEVEL[2] or questId == Constants.QUEST_OP_LEVEL[3] then
                -- 这里删除的是当前关卡里面保存的timeline
                -- RecordReader.SkillRecordReader:DestroyTl()
                -- 这里的timeline是一个视频，销毁的时候很卡，延迟一帧销毁这个timeline，不然会跟加载下一个剧情在同一帧里发生
                self.coDelayDestroyTl = cs_coroutine.start(function()
                    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.03))
                    RecordReader.SkillRecordReader:DestroyTl()
                    self.coDelayDestroyTl = nil
                end)
                -- print("[加载] 删除上一个timeline", questId, CS.UnityEngine.Time.realtimeSinceStartup)
            end

            local IsOpenOp =  AppEngine.GetConfig("Engine.Dev", "IsOpenOp")
            local curOp = QuestConfMgr:GetInstance():GetCurOpId()
            -- print("[PlayChapter] ", IsOpenOp, curOp, chapterId)
            if checkNumber(IsOpenOp) > 0 and curOp ~= 0 and chapterId == 1000060 then
                -- 这里延迟删除的是上一关保存下来的最后一个剧情，所以1000060是下一关的第一个剧情的id
                local MainQuestMapMgr = import('Game.UI.FightReady.UIMainChapter.UIMainChapter.MainQuestMapMgr')
                -- print("[PlayChapter] 延迟删除 获取", MainQuestMapMgr:GetInstance().delayDestroyChapter)
                if not IsNull(MainQuestMapMgr:GetInstance().delayDestroyChapter) then
                    CS.UnityEngine.GameObject.Destroy(MainQuestMapMgr:GetInstance().delayDestroyChapter)
                end
            end
        end,
        function (  )
            isFinish = true
            if vo.is2d == 3 then
                -- 战中对话剧情（一种可以看到场景的剧情）
                if not IsNull(backupCamera) and not IsNull(plot3DCamera) then
                    -- 还原剧情相机的参数
                    plot3DCamera:CopyFrom(backupCamera)
                    KTool.SafeDelete(backupCamera.gameObject)
                    backupCamera = nil
                    plot3DCamera = nil
                end
            end
            self:SwitchShow(true)
        end,
        nil,
        function()
            -- 序章3的最后一段剧情，剧情末尾是闪白，这里制造一个白屏，直到卸载完战斗场景，等序章4剧情开始再解除白屏
            if chapterId == 1000100 then
                GameUtils.ShowBlack(0.001, Color.white)
                return
            end
            -- 战斗结束的剧情加一个黑幕，直接等到结算界面出来，结算界面会关闭黑幕
            -- 如果剧情结束请求结算失败，会弹出二级确认框，点击确定直接跳出战斗。点击二级确认框也会HideBlack
            if checkBool(isGameOver) then
                GameUtils.ShowBlack(0.3)
                coroutine.yield(Yielders.GetWaitForSeconds(0.3))
            end
            -- 连续的两段剧情之间加一段黑幕
            if hasNextOne == true then
                -- print("[黑幕] 战中 段间黑幕")
                GameUtils.ShowBlackDuration(0.3, 0.3, 0.3)
                coroutine.yield(Yielders.GetWaitForSeconds(0.3))
            end
        end
    )

    while not isFinish do
        coroutine.yield()
    end
    self.coChapter = nil
    if not isNull(obj) then
        local needDestroy = true

        local IsOpenOp =  AppEngine.GetConfig("Engine.Dev", "IsOpenOp")
        local curOp = QuestConfMgr:GetInstance():GetCurOpId()
        -- 序章2的最后一段剧情做延迟删除，等序章3的第一段剧情开始再删除
        if checkNumber(IsOpenOp) > 0 and curOp ~= 0 and (chapterId == 1000050) then
            needDestroy = false
            local MainQuestMapMgr = import('Game.UI.FightReady.UIMainChapter.UIMainChapter.MainQuestMapMgr')
            MainQuestMapMgr:GetInstance().delayDestroyChapter = obj
            -- print("[PlayChapter] 延迟删除 保存", MainQuestMapMgr:GetInstance().delayDestroyChapter)
        end

        if needDestroy then
            CS.UnityEngine.GameObject.Destroy(obj)
        end
    end
    -- print("[剧情] end", chapterId)
end

function BattleViewMgr:ClearCo()
    if self.coDelayDestroyTl then
        cs_coroutine.stop(self.coDelayDestroyTl)
        self.coDelayDestroyTl = nil
    end
    if isNotNull(self.coWaitOtherOvertime) then
        cs_coroutine.stop(self.coWaitOtherOvertime)
        self.coWaitOtherOvertime = nil
    end
end

--- 退出战斗时打断正在播放的剧情协程
function BattleViewMgr:ClearChapter()
    if self.coChapter then
        cs_coroutine.stop(self.coChapter)
        self.coChapter = nil
    end
    local ChapterUtils = import("Game.Chapter.ChapterUtils")
    ChapterUtils.SetOutChapter()
    KTool.SetActive(URPCameraController.uiCamera, true)
    KTool.SetActive(URPCameraController.mainCamera, true)
end

function BattleViewMgr:AddCommonSignals(rootNode)
    local eventNode = rootNode.gameObject:FindGameObjectByName("event")
    if not isNull(eventNode) then
        --添加事件
        self:AddSignalHandler("appear", eventNode, function ()
            -- print("eventNode4")
            local rs = BattleViewMgr:FindCampRoles(BattleInfo.myCamp)
            for i,v in ipairs(rs) do
                if not v.isSkillPerforming then
                    v:SyncStand()
                end
            end
        end)

        self:AddSignalHandler("disappear", eventNode, function ()
            -- print("eventNode3")
            local rs = BattleViewMgr:FindCampRoles(BattleInfo.myCamp)
            for i,v in ipairs(rs) do
                if not v.isSkillPerforming then
                    v:Hide()
                end
            end
        end)

        self:AddSignalHandler("fuse", eventNode, function ()
            -- print("eventNode fuse")
            local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
            SkillCameraMgr:ResetDTime()
        end)
    end
end

function BattleViewMgr:AddSignalHandler(signalName, gameObject, handler)
    local sr = KTool.GetOrAddComponent(gameObject, typeof(SignalReceiver))
    local path = gameUtils.GetTimelineSignalFullPath(signalName)
    local loader = ResourceModule.LoadBundleSync(path)--"Timeline/Timeline.prefab"
    loader:Retain(sr)
    if not loader.IsError and isNull(sr:GetReaction(loader.ResultObject))  then
        local event = CS.UnityEngine.Events.UnityEvent()
        event:AddListener(handler)
        sr:AddReaction(loader.ResultObject, event)
    end
    loader:Release()
end


function BattleViewMgr:ChangeScene( sceneId )
    local setting = settingMgr:GetSetting(AutoIds.IdSetting270, "BattleSceneVo")
    --@RefType [Game.Setting.Vo.BattleSceneVo#BattleSceneVo]
    local battleSceneVo = setting:Get(sceneId)
    self.sceneVo = battleSceneVo

    local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
    --移出根节点和相机控制器
    CS.UnityEngine.Object.DontDestroyOnLoad(self.rootNode)
    CS.UnityEngine.Object.DontDestroyOnLoad(SkillCameraMgr.gameObject)
    --音效listener切换
    --AudioManager.Instance:StopMusic()
    --移除场景
    CS.UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync(self.nowScene)

    --加载场景
    ResMgr:RequireRes(ResMgr.ResType.Scene, self.sceneVo.id)
    coroutine.yield(ResMgr:StartLoading())
    -- coroutine.yield(self:LoadScene(self.sceneVo.sceneName))
    --放入根节点和相机控制器

    CS.UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(self.rootNode, self.nowScene)
    CS.UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(SkillCameraMgr.gameObject, self.nowScene)
    
    --刷新站位

    

    local num = 0
    for i,roleView in ipairs(self.roleViews) do
        if roleView.camp == Constants.Camp.One then
            num = num + 1
        end
    end
    self:InitStand(num, false)
    for i,roleView in ipairs(self.roleViews) do
        roleView:SetStand(self:GetStand(roleView.standIndex, roleView.camp))
    end
    self:ResetAllStand()
end

function BattleViewMgr:NeedUnloadScene()
    --if not self:IsWorldBoss(self.initData.questId) then
        return true
    --end
end

function BattleViewMgr:EnableThreeStarCamera()
    if BattleInfo:IsOnline() then
        return false
    end
    return self.openThreeStarCamera
end

function BattleViewMgr:GetSkillCameraVo(skillViewVo)
    if Tools.isNullKey(skillViewVo.skillCameraId) then
        return
    end
    local setting = settingMgr:GetSetting(AutoIds.IdSetting300, "SkillCameraVo")
    --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
    local SkillCameraVo = setting:Get(skillViewVo.skillCameraId)

    if not SkillCameraVo then
        return
    end

    return SkillCameraVo
end

function BattleViewMgr:BindRoleInEnterTimeline(director)
    if not self.reuseRoleInstanceData then
        self.reuseRoleInstanceData = {}
    end
    local binder = nil
    if director then
        binder = director.gameObject:EnsureComponent( typeof(CS.Game.Native.Timeline.TimelineBinder) )
    end
    local deal = function (roleData)
        local go = self:GetOrAddRoleInstance(roleData, false)

        --根据命名规则绑定进入轨
        local roleId = roleData.cardId or roleData.enemyId
        if binder then
            binder:SetTrackDynamic(roleId .. "_ani", go)
            binder:SetTrackDynamic(roleId .. "_act", go)
        end
        
        KTool.SetActive(go, false)
        --挂到pos点下面
        local parent = director.transform:Find("allposition/" .. tostring(roleId))
        if isNull(parent) then
            parent = director.transform:Find("allposition/" .. tostring(roleId) .. "_loc")
        end
        if isNull(parent) then
            parent = director.transform:Find("allposition")
        end
        go.transform:SetParent(parent)
        KTool.ResetTransform(go.transform)
        
    end
    local myWave = self.initData.playerTeam[1]
    for i,v in ipairs(myWave) do
        deal(v)
    end
    local enemyWave = self.initData.enemyTeam[1]
    for i,v in ipairs(enemyWave) do
        deal(v)
    end
end

function BattleViewMgr:InstantiateFirstWave()
    local myWave = self.initData.playerTeam[1]
    for i,v in ipairs(myWave) do
        self:GetOrAddRoleInstance(v, true)
    end
    local enemyWave = self.initData.enemyTeam[1]
    if(enemyWave==nil or next(enemyWave) == nil) then
        printInfo("enemyWave is nil or empty")
        return
    end
    for i,v in ipairs(enemyWave) do
        self:GetOrAddRoleInstance(v, true)
    end
end

function BattleViewMgr:GetOrAddRoleInstance(roleData, needEnter)
    if not self.reuseRoleInstanceData then
        self.reuseRoleInstanceData = {}
    end

    local go = nil
    --可能会重复调取bind，优先读取之前的reused数据
    local instance = self.reuseRoleInstanceData[roleData.id]
    if instance then
        go = instance.obj
        --needEnter为否时不再接受刷新
        if instance.needEnter then
            instance.needEnter = needEnter
        end
    else
        local modelId = Core:GetModleId(roleData.skinId)
        local model = ResMgr.roleMoudles[modelId]
        if not model or isNull(model.loader) then
            printError('找不到模型:'..model)
            return
        end
        --创建第一波角色和怪物实例
        go = GameObject.Instantiate(model.loader.ResultObject)
        KTool.SetActive(go, true)   -- 防止预制体是关着的，没有走组件的awake和onenable

        -- 动态加载组件
        self:DynamicAddComponent(roleData, go)

        --把实例存储，角色入场时候直接使用
        self.reuseRoleInstanceData[roleData.id] = {obj = go, modelVo = model.modelVo, needEnter = needEnter}
    end
    KTool.SetActive(go, false)
    return go
end


function BattleViewMgr:OnEnterTimelineFinished(tb)
    printInfo("OnEnterTimelineFinished")
    for k,v in pairs(self.reuseRoleInstanceData) do
        local stand = nil
        printInfo(k)
        if tb ~= nil and isSet(tb, k) then
            stand = tb[k]
            printInfo("%s set", tostring(k))
        else
            stand = {
                position = v.obj.transform.position,
                rotation = v.obj.transform.rotation.eulerAngles
            }
        end
        
        v.stand = stand
        v.obj.transform:SetParent(self.rootNode.transform)
        KTool.SetActive(v.obj, true)
    end
end

---SetSceneActive
---在场景退出之前，先不显示所有的状态，防止相机还在运算
---@param active boolean
function BattleViewMgr:SetSceneActive(active)
    ---@type UnityEngine.SceneManagement.Scene
    local scene = SceneManager.GetActiveScene()
    local rootObjects = scene:GetRootGameObjects();
    for i, v in array_pairs(rootObjects) do
        if not KTool.IsNull(v) then
            KTool.SetActive(v.gameObject, checkBool(active))
        end
    end
end
---
---虚拟相机关掉的逻辑
---@param active boolean
function BattleViewMgr:SetCameraVMActive(active)
    KTool.SetActive(CS.Game.Native.Battle.BattleSkillCameraMgr.Instance.gameObject, active)
end

function BattleViewMgr:SwitchSceneLights(isEnable)
    if isNull(self.lights) then
        return 
    end
    for i = 0, self.lights.Length - 1 do
        -- self.lights[i].game = isEnable
        KTool.SetActive(self.lights[i].gameObject, isEnable)
    end
end

function BattleViewMgr:StopView()
    xTry(function ()
        self:ClearCo()
        if CoManager then
            CoManager:Dispose()
        end
    end)

    xTry(function ()
        if RecordReader then
            RecordReader:Reset()
        end
    end)
end

function BattleViewMgr:OnLateUpdate()
    if self.sceneVo and self.sceneVo.lateUpdateScript and self.sceneVo.lateUpdateScript.Evaluate then
        self.sceneVo.lateUpdateScript:Evaluate()
    end
    if self.lowShadowCheckToolInBattle then
        self.lowShadowCheckToolInBattle:SelfUpdate()
    end
end

function BattleViewMgr:OnDestroy()
    xpcall(function()
        self.isReplay = false
        
        xTry(function() 
            XGraphicSetup.ExitBattle()
        end)

        if self._lateUpdater ~= nil then
            CS.Engine.Lib.MonoHelper.RemoveLateUpdateListener(self._lateUpdater)
        end

        ---设置进入战斗前的主界面的显示状态
        local active = KCookie.Get(Constants.UICacheDataKeys.MainSceneActiveState)
        -- print("MainSceneActiveState", active)
        if checkBool(active) == true then
            ---如果是进入战斗前是显示的状态再发下面的事件
            Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
            --Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = true })
        end
        
        self:StopView()
        self:ClearChapter()

        if self.netMgr then
            xTry(function ()
                self.netMgr:Dispose()
                self.netMgr = nil
            end)
        end
  

        self:OnChangeGameSpeed(1)
        --AudioManager.Instance:UnloadBank(BattleTag)
        --AudioManager.Instance:StopMusic()
        --AudioManager.Instance:UnloadBank(BattleMusicTag)


        --AudioManager.Instance:PlayMusic(Constants.MainBGM)
        xTry(function ()
            if not isNull(self.selectBuffCamera) then
                KTool.SafeDelete(self.selectBuffCamera)
            end
            local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
            if not isNull(SkillCameraMgr) and not isNull(SkillCameraMgr.gameObject) then
                KTool.SafeDelete(SkillCameraMgr.gameObject)
                -- CS.UnityEngine.GameObject.Destroy(SkillCameraMgr.gameObject)
            end
        end)


        self:StopLongIdle()
        xTry(function ()
            if BattleMgr then
                BattleMgr:Clear()
            end
        end)
        xTry(function ()
            self:Unregister()
        end)
        
        
        xTry(function ()
            if self.battleUI then
                self.battleUI:Delete()
                self.battleUI = nil
            end
        end)
        
        self.enemyAoe = nil
        self.teamAoe = nil
        if not isNull(self.blur) then
            CS.UnityEngine.GameObject.Destroy(self.blur)
        end
        self.blur = nil
        if isNotNull(self.matrixEffect) then
            CS.UnityEngine.GameObject.Destroy(self.matrixEffect)
        end
        self.matrixEffect = nil
        self.matrixEffectRoleTargets = nil
        KTool.SafeDelete(self.matrixEffectShadowMaterial)
        KTool.SafeDelete(self.matrixEffectParticleMaterial)

        self.enemyPath = nil
        self.myPath = nil
        self.myStands = nil
        self.enemyStands = nil
        self.isAutoPlay = false
        self.nowScene = nil

        if self.roleViews then
            for i,v in fipairs(self.roleViews) do
                v:Dispose()
                v = nil
            end
        end
        self.roleViews = nil

        if self.roleMoudles then
            for i,v in pairs(self.roleMoudles) do
                if not isNull(v.gameObject) then
                    CS.UnityEngine.GameObject.Destroy(v.gameObject)
                end
                if not isNull(v.loader) then
                    v.loader:Release(true)
                    v.loader = nil
                end
            end
        end
        self.roleMoudles = nil

        if self.catGameObjects then
            for i, v in pairs(self.catGameObjects) do
                if isNotNull(v) then
                    CS.UnityEngine.GameObject.Destroy(v)
                end
                self.catGameObjects[i] = nil
            end
        end
        self.catGameObjects = nil

        self:DestroySkillCat()
        
        xTry(function ()
            if self.FXMgr then
                self.FXMgr:Clear()
                self.FXMgr = nil
            end
        end)

        xTry(function ()
            if self.reuseRoleInstanceData then
                for k,v in pairs(self.reuseRoleInstanceData) do
                    if not isNull(v.obj) then
                        CS.UnityEngine.GameObject.Destroy(v.obj)
                    end
                end
                self.reuseRoleInstanceData = nil
            end
        end)

        xTry(function ()
            if not isNull(self.speedLine) then
                self.speedLine:SetActive(false)
                CS.UnityEngine.GameObject.Destroy(self.speedLine)
                self.speedLine = nil
            end
        end)

        xTry(function ()
            -- print("FindLoadingUI close", self.loadingUI)
            if self.loadingUI then
                self.loadingUI:Close()
                self.loadingUI = nil
            end
        end)
        
        RecordReader = nil
        BattleMgr = nil
        
        xTry(function ()
            if BattleInfo then
                BattleInfo:Dispose()
                BattleInfo = nil
            end
        end)
      
    end, function(err)
        print("Error:", err)
        printError(err)
    end)
    --移除声音源
    self.xs = nil
    -- if not self:IsWorldBoss(self.initData.questId) then
    --     ResMgr:UnloadBattleScene()
    -- end

    xTry(function ()
        if ResMgr then
            ResMgr:Dispose()
        end
    end)
    collectgarbage("collect")
    collectgarbage("collect")
    collectgarbage("collect")

    GlobalWait = function (  )
        coroutine.yield( WaitForSeconds(2) )
        CS.System.GC.Collect()
        CS.UnityEngine.Resources.UnloadUnusedAssets()
    end

    cs_coroutine.start(GlobalWait)
end

function BattleViewMgr:ClearCacheAndGC()
    collectgarbage("collect")
    collectgarbage("collect")
    collectgarbage("collect")
    CS.System.GC.Collect()
    CS.UnityEngine.Resources.UnloadUnusedAssets()
end

function BattleViewMgr:InitRecordInterpreter(d)
    local enable = PlayerPrefsUtility.GetBool(LogEnableKey, false)
    if enable then
        local initData = table.serialize(d)
        RecordInterpreter.SetInitData(initData)
    end
end

--- 缓存猫毛的渲染质量选项
function BattleViewMgr:CacheCarFurRenderQuality()
    local ccd = URPCameraController.mainCamera.gameObject:GetComponent(typeof(CameraCustomData))
    if isNotNull(ccd) then
        self.roleRenderQuality = ccd.Role
        self.catFurRenderQuality = ccd.Fur
    end
end

--- 恢复猫毛的渲染质量选项
function BattleViewMgr:ResetCatFurRenderQuality()
    local ccd = URPCameraController.mainCamera.gameObject:GetComponent(typeof(CameraCustomData))
    if isNotNull(ccd) and isNotNull(self.catFurRenderQuality) then
        ccd.Role = self.roleRenderQuality
        ccd.Fur = self.catFurRenderQuality
    end
end

--- 缓存当前虚拟相机大脑的设置
function BattleViewMgr:CacheCinemachineBrainSetting()
    local brain = URPCameraController.mainCamera.gameObject:GetComponent(typeof(CinemachineBrain))
    if not isNull(brain) then
        self.cinemachineBrainCache = brain.m_DefaultBlend
    end
end

--- 恢复虚拟相机大脑的设置
function BattleViewMgr:ResetCinemachineBrainSetting()
    local brain = URPCameraController.mainCamera.gameObject:GetComponent(typeof(CinemachineBrain))
    if not isNull(brain) and not isNull(self.cinemachineBrainCache) then
        brain.m_DefaultBlend = self.cinemachineBrainCache
    end
end

--- 回复战斗外的一些设置参数
function BattleViewMgr:ResetOutsetBattleSettings()
    self:ResetCinemachineBrainSetting()
    self:ResetCatFurRenderQuality()
end

--- 创建一个选择buff目标的相机
function BattleViewMgr:CreateSelectBuffCamera()
    local lookAtPos = self:GetSelectBuffCameraLookAtPoint()
    local cameraGO = GameObject("SelectBuff")
    cameraGO.transform.position = self.sceneCenter.transform.position + Vector3.up
    cameraGO.transform:LookAt(lookAtPos, Vector3.up)
    local camForwardDir = Vector3.New(cameraGO.transform.forward.x, 0, cameraGO.transform.forward.z):SetNormalize()
    cameraGO.transform.position = cameraGO.transform.position - camForwardDir * 5
    self.selectBuffCamera = cameraGO:AddComponent(typeof(CinemachineVirtualCamera))
    -- 修改焦距
    local lens = self.selectBuffCamera.m_Lens
    lens.FieldOfView = CameraExtensions.FocalLengthToFieldOfView(80, lens.SensorSize.y)
    self.selectBuffCamera.m_Lens = lens
    -- 相机的推拉呼吸
    local targetPoint = cameraGO.transform.position + camForwardDir * 0.3
    cameraGO.transform:DOMove(targetPoint, 8):SetEase(Ease.InOutSine):SetLoops(-1, LoopType.Yoyo)
    -- cameraGO.transform:DOLocalRotate(Vector3.up, 8, RotateMode.WorldAxisAdd):SetEase(Ease.InOutSine):SetLoops(-1, LoopType.Yoyo)

    -- 计算选择buff时候的角色站位
    self:CalculateMyBuffSelectStands()
end

--- 计算选择buff时候的角色站位
function BattleViewMgr:CalculateMyBuffSelectStands()
    local cameraGO = self.selectBuffCamera.gameObject
    self.myBuffSelectStands = {}
    local roleNum = #self.myStands
    roleNum = math.min(roleNum, 5)
    for i = 1, roleNum, 1 do
        self.myBuffSelectStands[i] = {}
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting4061, "BuffCameraParamVo", i)
        local cameraForwardDir = Vector3.New(cameraGO.transform.forward.x, 0, cameraGO.transform.forward.z):SetNormalize()
        local cameraLeftDir = -cameraGO.transform.right
        local cameraRightDir = cameraGO.transform.right

        local rolePosMidPoint = cameraGO.transform.position + cameraForwardDir * checkNumber(vo.camDistance)

        for j = 1, i, 1 do
            local pos = rolePosMidPoint + cameraLeftDir * (j - 1) * checkNumber(vo.roleDistance)
            pos = pos + cameraRightDir * (i - 1) * 0.5 * checkNumber(vo.roleDistance)

            table.insert(self.myBuffSelectStands[i], pos)
        end
    end
    -- print("[相机] buff相机 stands", table.dump(self.myBuffSelectStands, nil, 3))
end

--- 打开选择buff目标的相机
function BattleViewMgr:OpenSelectBuffCamera()
    if isNull(self.selectBuffCamera) then
        self:CreateSelectBuffCamera()
    end

    local brain = URPCameraController.mainCamera.gameObject:GetComponent(typeof(CinemachineBrain))
    if not isNull(brain) then
        self.selectBuffCameraBlendCache = brain.m_DefaultBlend
    end
    CfUtils.ChangeMainCamDefalultBlend(0)
    self.selectBuffCamera.Priority = 10
    self:ChangeRoleModleQuality(CS.CameraCustomData.RoleSettingEnum.MediumQuality)

    local myAliveRoles = {}
    for i, role in ipairs(self.roleViews) do
        if BattleInfo:IsMyPlayerId(role.roleData.playerId) then
            table.insert(myAliveRoles, role)
        else
            role:Hide()
        end
    end

    local roleNum = #myAliveRoles
    local stands = self.myBuffSelectStands[roleNum]
    for i, role in ipairs(myAliveRoles) do
        role.transform.localPosition = Vector3.New(stands[i].x, role.transform.localPosition.y, stands[i].z) 
    end
end

--- 关闭选择buff目标的相机
function BattleViewMgr:CloseSelectBuffCamera()
    if isNull(self.selectBuffCameraBlendCache) then
        return
    end
    self.selectBuffCamera.Priority = 0
    for i, role in ipairs(self.roleViews) do
        role:SyncStand()
    end
    cs_coroutine.start(function()
        cs_coroutine.yield_return()
        self:ChangeRoleModleQuality(CS.CameraCustomData.RoleSettingEnum.LowQuality)
        local brain = URPCameraController.mainCamera.gameObject:GetComponent(typeof(CinemachineBrain))
        if not isNull(brain) then
            brain.m_DefaultBlend = self.selectBuffCameraBlendCache
            self.selectBuffCameraBlendCache = nil
        end
    end)
end

--- 计算选择buff相机的lookAt点
function BattleViewMgr:GetSelectBuffCameraLookAtPoint()
    local stands = self.myStands
    -- print("[相机] 选择buff", table.dump(stands, nil, 3))
    local leftPoint = stands[1].position
    local rightPoint = stands[#stands].position
    local midPoint = (leftPoint + rightPoint) / 2
    
    -- local leftGo = GameObject("leftPoint")
    -- leftGo.transform.position = leftPoint
    -- local rightGo = GameObject("rightPoint")
    -- rightGo.transform.position = rightPoint
    -- local midGo = GameObject("midPoint")
    -- midGo.transform.position = midPoint
    return midPoint + Vector3.up * 1
end

function BattleViewMgr:ChangeRoleModleQuality(quality)
    local ccd = self.camera.gameObject:GetComponent(typeof(CS.CameraCustomData))
    if not isNull(ccd) then
        ccd.Role = quality
    end
end

-- 结算界面猫的timeline会修改lens的设置，这里重新初始化一下
function BattleViewMgr:InitVcamLens()
    local SkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance
    local cameraCount = SkillCameraMgr.followCameras.Count

    -- 设置战斗跟随相机的lens
    for i = 0, cameraCount - 2, 1 do
        local vcam = SkillCameraMgr.followCameras[i].FollowCamera
        local lens = vcam.m_Lens
        lens.FieldOfView = 40
        lens.ModeOverride = OverrideModes.Physical
        vcam.m_Lens = lens
    end

    -- 设置overlayCamera
    local vcam = SkillCameraMgr.overlayCamera
    local lens = vcam.m_Lens
    lens.FieldOfView = self.sceneVo.view == 0 and URPCameraController.mainCamera.fieldOfView or self.sceneVo.view
    lens.ModeOverride = OverrideModes.Physical
    vcam.m_Lens = lens

    -- 设置压仓相机
    vcam = SkillCameraMgr:GetBattleFollowCamera().FollowCamera
    local lens = vcam.m_Lens
    lens.FieldOfView = self.sceneVo.view == 0 and URPCameraController.mainCamera.fieldOfView or self.sceneVo.view
    lens.ModeOverride = OverrideModes.Physical
    vcam.m_Lens = lens
end

--- 虚拟相机推镜
---@param vcam any
---@param from any
---@param to any
---@param duration any
function BattleViewMgr:VCamPushLens(vcam, from, to, duration)
    local time = duration
    local timer = 0
    local fromValue = from
    local toValue = to
    local curve = AnimationCurve()
    curve:AddKey(Keyframe(0,0,3,3))
    curve:AddKey(Keyframe(1,1,0,0))
    while timer < time do
        timer = timer + 0.016
        cs_coroutine.yield_return(WaitForSecondsRealtime(0.016))
        local p = Mathf.Lerp(fromValue, toValue, curve:Evaluate(timer / time))
        local lens = vcam.m_Lens
        lens.FieldOfView = CameraExtensions.FocalLengthToFieldOfView(p, lens.SensorSize.y)
        vcam.m_Lens = lens
    end
end

--- 黑客帝国特效
function BattleViewMgr:AddMatrixEffect(sceneGameObjects, sceneParamId)
    if sceneParamId <= 0 then
        return
    end
    self.matrixEffect = self.camera.gameObject:GetComponent(typeof(CS.MatrixTriplanarEffect))
    if isNull(self.matrixEffect) then
        self.matrixEffect = self.camera.gameObject:AddComponent(typeof(CS.MatrixTriplanarEffect))
        local matrixEffectType = self.matrixEffect:GetType()
        local method = matrixEffectType:GetMethod("SetEmotionalParticleMaterial")
        if isNotNull(method) then
            -- print("[黑客] 新版本 设置粒子")
            self.matrixEffect:SetEmotionalParticleMaterial(self.matrixEffectParticleMaterial)
        end
    end

    if isNotNull(sceneGameObjects) and table.count(sceneGameObjects) > 0 then
        for i, go in ipairs(sceneGameObjects) do
            self.matrixEffect.targets:Add(go)
        end
    end

    local matrixEffectType = self.matrixEffect:GetType()
    local method = matrixEffectType:GetMethod("SetEffectByTableId")
    if isNotNull(method) then
        -- print("[黑客] 新版本 读表")
        self.matrixEffect:SetEffectByTableId(sceneParamId)
    else
        -- print("[黑客] 旧版本 读表")
        local tableFile = settingMgr:GetSetting(AutoIds.IdSetting6022, "TowerSceneScriptVo")
        ---@type TowerSceneScriptVo
        local paramVo = tableFile:Get(sceneParamId)
    
        self.matrixEffect.UseColorAdjustments = paramVo.UseColorAdjustments
        self.matrixEffect.postExposure = paramVo.postExposure
        self.matrixEffect.contrast = paramVo.contrast
        self.matrixEffect.colorFilter = paramVo.colorFilter
        self.matrixEffect.hueShift = paramVo.hueShift
        self.matrixEffect.saturation = paramVo.saturation
        self.matrixEffect.postExposureRole = paramVo.postExposureRole
        self.matrixEffect.contrastRole = paramVo.contrastRole
        self.matrixEffect.colorFilterRole = paramVo.colorFilterRole
        self.matrixEffect.hueShiftRole = paramVo.hueShiftRole
        self.matrixEffect.saturationRole = paramVo.saturationRole
        self.matrixEffect.EffectBrightness = paramVo.EffectBrightness
        self.matrixEffect.RainSpeed = paramVo.RainSpeed
        self.matrixEffect.WordChangeSpeed = paramVo.WordChangeSpeed
        self.matrixEffect.WordColor = XLuaUtils.HexToColor("#"..paramVo.WordColor)
        self.matrixEffect.RainMaxColor = paramVo.RainMaxColor
        self.matrixEffect.RainEffectScale = paramVo.RainEffectScale
        self.matrixEffect.RainLengthScale = paramVo.RainLengthScale
        self.matrixEffect.RainInvertDistance = paramVo.RainInvertDistance
        self.matrixEffect.WordSpace = paramVo.WordSpace
    end

    -- 因为性能问题，临时添加一个处理
    if isNotNull(self.matrixEffect) then
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))
        self.matrixEffect.WordChangeSpeed = 1000
    end
end

--- 向黑客帝国效果脚本添加受影响的角色
---@param gameObject any
function BattleViewMgr:MatrixEffectAddRole(roleId, gameObject)
    self.matrixEffect = self.camera.gameObject:GetComponent(typeof(CS.MatrixTriplanarEffect))
    if isNull(self.matrixEffect) then return end

    if isNull(self.matrixEffectRoleTargets) then
        self.matrixEffectRoleTargets = {}
    end
    self.matrixEffect.targetsRole:Add(gameObject)
    table.insert(self.matrixEffectRoleTargets, roleId)

    -- 强制调用onenable的逻辑
    self.matrixEffect.enabled = false
    self.matrixEffect.enabled = true
end

--- 从黑客帝国效果脚本的目标中移除角色
---@param roleId any
function BattleViewMgr:MatrixEffectRemoveRole(roleId)
    self.matrixEffect = self.camera.gameObject:GetComponent(typeof(CS.MatrixTriplanarEffect))
    if isNull(self.matrixEffect) then return end

    local index = -1
    for i, v in ipairs(self.matrixEffectRoleTargets) do
        if v == roleId then
            index = i
            break
        end
    end

    if index < 0 then return end

    self.matrixEffect.targetsRole:RemoveAt(index - 1)
    table.remove(self.matrixEffectRoleTargets, index)

    -- 强制调用onenable的逻辑
    self.matrixEffect.enabled = false
    self.matrixEffect.enabled = true
end

--- 加载黑客帝国效果用的阴影材质球
function BattleViewMgr:LoadRoleShadowMatrixMaterial(towerSceneScriptId)
    local loader1 = ResourceModule.LoadBundleAsync("Materials/RoleLowDiscShadow_Matrix.mat", nil, true)
    local loader2 = ResourceModule.LoadBundleAsync("Materials/EmotionalParticle.mat", nil, true)
    local loaders = {loader1, loader2}
    while true do
        local allCompelet = true
        for i, loader in ipairs(loaders) do
            if not loader.IsCompleted then
                allCompelet = false
            end
        end
        if allCompelet then
            break
        end
        coroutine.yield(Yielders.EndOfFrame)
    end

    -- 阴影材质球
    if loader1.IsSuccess then
        local mat = GameObject.Instantiate(loader1.ResultObject)
        loader1:Retain(mat)
        
        local tableFile = settingMgr:GetSetting(AutoIds.IdSetting6022, "TowerSceneScriptVo")
        ---@type TowerSceneScriptVo
        local paramVo = tableFile:Get(towerSceneScriptId)
        local shadowColor = XLuaUtils.HexToColor("#"..paramVo.WordColor)

        local propertyId = CS.UnityEngine.Shader.PropertyToID("_ShadowColor")
        
        mat:SetColor(propertyId, shadowColor)
        -- print("[爬塔] 设置材质球颜色", mat, propertyId, shadowColor)

        self.matrixEffectShadowMaterial = mat
    end
    
    loader1:Release()
    loader1 = nil

    -- 粒子材质球
    if loader2.IsSuccess then
        local mat = GameObject.Instantiate(loader2.ResultObject)
        loader2:Retain(mat)

        self.matrixEffectParticleMaterial = mat
    end

    loader2:Release()
    loader2 = nil
end

--- 切换场景皮肤
---@param wave any
function BattleViewMgr:SwitchSceneSkin(wave)
    if isNull(self.levelData) then return end
    local waveData = self.levelData[wave]
    if isNull(waveData) then return end
    if not string.isEmpty(waveData.sceneSkinName)
    and isNotNull(self.sceneSkinGORoot) then
        local root = self.sceneSkinGORoot.transform
        local childCount = root.childCount
        for i = 0, childCount - 1, 1 do
            local child = root:GetChild(i)
            KTool.SetActive(child, child.name == waveData.sceneSkinName)
        end
    end
end

function BattleViewMgr:SyncGame(inputs, nowTurnInputs, nowTurnRemainTimes, data)
    -- 重新连接以后清除网络请求的阻塞
    GameUtils.AfterRequest()
    if self.battleState == Constants.BattleState.None
    or self.battleState == Constants.BattleState.Preloading then
        -- 双方都掉线时，服务器会关闭房间，结束游戏
        if isNotNull(data.isClose) and data.isClose == 1 then
            self.netMgr:QuitBattle(self.netMgr.QuitType.OtherDisconnect)
        end
        return
    end
    if self.battleState == Constants.BattleState.WaitingForStart then
        -- 这里是我已经加载完成，在等待对方加载完成的过程中，断线重连了
        if isNotNull(data.isLoadComplete) and data.isLoadComplete == 1 then
            -- 如果双方都加载完成了，那我就可以开始了
            -- 如果对方没有加载完成，那对方准备完成时，会有消息通知开始
            -- 如果我的加载完成消息没有到达服务器，networkManager会不断重发加载完成，直到服务器回复加载完成
            self.waitForStart = false
            cs_coroutine.start(self.StartBattle, self)
            return
        end
        -- 双方都掉线时，服务器会关闭房间，结束游戏
        if isNotNull(data.isClose) and data.isClose == 1 then
            self.netMgr:QuitBattle(self.netMgr.QuitType.OtherDisconnect)
            return
        end
        return
    end
    if self.battleState == Constants.BattleState.End then
        return
    end
    -- 服务器已经结束了游戏，但是客户端还未跑到结算的逻辑
    if isNotNull(data.isClose) and data.isClose == 1 then
        if isNotNull(BattleViewMgr.requestManualExit) and BattleViewMgr.requestManualExit == true then
            GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome, hasExcluded = false }, nil, Constants.LoadingType.MainHome)
        else
            cs_coroutine.start(self.GameOver, self, true, {})
            return
        end
    end
    
    -- 客户端只在第一个回合开始之后才需要重新计算输入 或者 从战斗外重连时
    if isNotNull(data.round) or checkNumber(self.waitSyncGame) == 1 then
        -- local records = RecordMgr:GetFlatRecordData()
        -- local inputs = BattleInfo.GetInputFromRecord(records)
        print(table.toString(inputs, "inputs"))
        BattleMgr:SyncGame(self.initData, inputs)
        RecordMgr:DropAll()
        self:StopView()
        self:SwithToUICamera()
        self:ChangeGameSpeed(self.gameSpeed)    -- 重连时会打断当前的表演，如果刚好在打击帧过程中打断了表演，那么游戏就会一直变得非常慢，这里恢复游戏速度
        --同步回合数等参数
        local oldWave = BattleViewMgr.nowWave
        BattleViewMgr.nowTurn = BattleMgr.totalTurnCount
        BattleViewMgr.nowWave = BattleMgr.nowWave
        BattleViewMgr.nowSelfWave = BattleMgr.nowSelfWave
        if oldWave ~= BattleViewMgr.nowWave then
            --波次有切换，处理波次相关问题
            local wave = self.initData.enemyTeam[BattleMgr.nowWave]
            local maxNum = math.max(BattleMgr:GetWaveMaxNum(), #wave) 
            self:InitStand(maxNum, not BattleInfo:IsUserCamp(Constants.Camp.Two))
        end

        --同步角色
        local deleteCache = {}
        local addCache = {}

        for i,v in ipairs(self.roleViews) do
            table.insert(deleteCache, v.id)
        end
        for i,v in ipairs(BattleMgr.roles) do
            if not v:IsDead() then
                local removeCount = table.removebyvalue(deleteCache, v.id)
                if removeCount <= 0 then
                    --没有移除说明是新增
                    table.insert(addCache, v.id)
                end
            end
        end

        -- 删除已经死亡的角色
        Events.Broadcast(Constants.EventNames.BattleDeleteRoleShow, deleteCache)
        for i,v in ipairs(deleteCache) do
            local roleView = self:FindRoleView(v)
            if roleView then
                roleView:Remove()
            end
        end
        -- 重置剩余的角色
        for i, v in ipairs(self.roleViews) do
            v:SyncStand()
        end
        -- 添加新增的角色
        for i,v in ipairs(addCache) do
            local role = Core:FindRole(v)
            if role then
                local moudleId = role.moudleId
                local roleData = role.rawData
                local reuseData = self.reuseRoleInstanceData and self.reuseRoleInstanceData[roleData.id]
                local go, modelVo, needEnter = self:GetRoleGo(moudleId)
                KTool.SetActive(go, true)
                local roleView = RoleView.New(role.id, roleData, role.roleType, go, role.standPosition, role.camp, modelVo, role:GetNowHp(), role.ultraPoint)
                --初始化站位
                if reuseData and reuseData.stand then
                    roleView:SetStand(reuseData.stand)
                    -- print("isReused stand:", table.toString(reuseData.stand))
                
                else
                    -- print("stand:"..role.standPosition.. "  " .. role.camp, table.toString(self:GetStand(role.standPosition, role.camp)))
                    roleView:SetStand(self:GetStand(role.standPosition, role.camp))
                end
                table.insert(self.roleViews, roleView)
                Events.Broadcast(Constants.EventNames.BattleCreateRoleShow, {{id = roleView.id, data = roleData}})
            end
        end


        --同步属性和buff等
        for i,roleView in ipairs(self.roleViews) do
            local role = Core:FindRole(roleView.id)
            if role then
                --属性
                roleView.attr = DeepCopy(role.attr)

                --血量同步
                roleView:ForceSetNowHp(role:GetNowHp())

                --sp点同步
                roleView:ChangeUltraPoint(role.ultraPoint)

                --buff
                deleteCache = {}
                addCache = {}
                for i,buffView in ipairs(roleView.buffViewMgr.buffs) do
                    table.insert(deleteCache, buffView.id)
                end
                role.buffMgr:WalkAllBuff(function (buff)
                    local id = buff.id
                    local removeCount = table.removebyvalue(deleteCache, id)
                    if removeCount <= 0 then
                        --新增
                        table.insert(addCache, buff.id)
                    else
                        --之前有的现在还存在，需要刷新
                        roleView.buffViewMgr:ChangeBuff(id, buff.layNum, buff.remainRound)
                    end
                end)

                for i,v in ipairs(deleteCache) do
                    roleView.buffViewMgr:RemoveBuff(v)
                end
                for i,v in ipairs(addCache) do
                    local buff = role.buffMgr:GetBuff(v)
                    if buff then
                        local attackerId = buff.attacker and buff.attacker.id or 0
                        roleView.buffViewMgr:AddBuff(buff.id, attackerId, buff.data.id, buff.data.star, buff.data.lv, buff.layNum, buff.remainRound, buff.sourceType)
                    end
                end

                -- 重置idle动作
                roleView:OnResetCard()
            end

        end

        if self.nowWave > 1 then
            Events.Broadcast(Constants.EventNames.BattleRoleEnterEnd, self.nowWave, true) -- 角色入场结束
        end
    end

    -- print("BattleViewMgr:SyncGame", table.toString(nowTurnInputs, "nowTurnInputs"))
    if isNotNull(nowTurnInputs) then
        -- 重连时是在出牌阶段

        --牌库同步
        local cardMgr = BattleMgr:GetUserCardMgr()
        if cardMgr then
            local rec = RecordMgr.SyncSkillCardRecord.New(cardMgr)
            print(table.toString(rec, "sync"))
            Events.Broadcast(Constants.EventNames.BattleMyCard, rec:ToData())
        end
        
        BattleMgr:RoundStart()

        -- 播放回合开始阶段的战报
        local battleRecords = RecordMgr:GetData()
        local records = {}
        for i, v in ipairs(battleRecords) do
            -- 指定出牌剩余时间
            if v.r == Constants.RecordType.RequireInput then
                v = DeepCopy(v)
                v.remainTime = nowTurnRemainTimes
            end
            -- 跳过补卡和合卡的动画，直接同步牌库
            if v.r ~= Constants.RecordType.PushCard
            and v.r ~= Constants.RecordType.UnitCard then
                table.insert(records, v)
            end
        end
        RecordReader:ShowRecords(records)

        -- 本回合的出牌
        if table.count(nowTurnInputs) > 0 then
            for j,input in ipairs(nowTurnInputs) do
                local player = BattleMgr:GetPlayer(input.playerId)
                player:HandleInputData(input)
            end
        end
    else
        -- 重连时是在表演阶段

        -- 如果是最后一回合表演阶段重连，那么已经gameOver，直接去走结算逻辑
        xTry(function()
            local lastRecord = RecordMgr:GetLastRecordData()
            if isNotNull(lastRecord) and checkNumber(lastRecord.r) == Constants.RecordType.GameOver then
                -- 使用replayNoLag模式跑逻辑的时候会跳过生成recordData，这里要发给服务器，需要补一下
                lastRecord.recordData = RecordMgr:GetRecordString()
                -- 游戏结束了
                cs_coroutine.start(function()
                    self:GameOver(lastRecord.w, lastRecord)
                end)
            end
        end)

        -- 如果走了结算逻辑，那么下面的逻辑就不用走了
        if self.battleState == Constants.BattleState.End then
            return
        end

        -- 只在第一个回合开始之后，才需要发送4010 （或者在第一回合开始之前，就战斗外重连，才需要发4010）
        if self.nowTurn > 0 or checkNumber(self.waitSyncGame) == 1 then
            --牌库同步
            local cardMgr = BattleMgr:GetUserCardMgr()
            if cardMgr then
                local rec = RecordMgr.SyncSkillCardRecord.New(cardMgr)
                print(table.toString(rec, "sync"))
                Events.Broadcast(Constants.EventNames.BattleMyCard, rec:ToData())
            end

            -- 检查其他玩家是否都被托管了
            local hasOtherPlayerManual = false
            local gameMode = BattleInfo.gameMode
            if gameMode == Constants.GameMode.PVP then
                for i, player in ipairs(BattleMgr.players) do
                    if player.playerId ~= BattleInfo.myPlayerId
                    and player.isHosting == false then
                        hasOtherPlayerManual = true
                    end
                end
            elseif gameMode == Constants.GameMode.OnlinePVE then
                for i, player in ipairs(BattleMgr.players) do
                    if player.camp == Constants.Camp.One
                    and player.playerId ~= BattleInfo.myPlayerId
                    and player.isHosting == false then
                        hasOtherPlayerManual = true
                    end
                end
            end

            if hasOtherPlayerManual then
                -- 还有玩家在手操，需要等待对方表演完成
                GameUtils.Toast(localize("等待对方完成表演"), 4)
                -- 表演阶段保证卡池UI是关闭状态
                self.battleUI:DialogShowStateChange(false)
            end

            -- 通知服务器我的技能播完了，请求开始下一回合
            self.netMgr:Send(self.netMgr.SendPackageIds.PlayRecordFinished, {round = BattleMgr.totalTurnCount + 1, type = 2})
        else
            -- 如果在战斗中掉线，然后再第一个回合之前重连，不用发4010，等到开场表演结束，会自动发4010
            -- 开场表演结束时，自动发的4010，是强制添加了重发的，保证不会丢失
        end
    end

    -- 播放战报
    Events.Broadcast(Constants.EventNames.BattleRecordShow)

    self.waitSyncGame = 0   -- 战斗外重连逻辑，只执行一次
end

function BattleViewMgr:DebugTestNetwork()
    if isNull(self.netMgr) then
        return
    end
    if self.ReconnectTest then
        self.netMgr:Reconnect()
        print("[Battle_tcp_] reconnect test ", debug.traceback())
    elseif self.DisconnectTest then
        self.netMgr:Disconnect()
        print("[Battle_tcp_] disconnect test ", debug.traceback())
    end
end

function BattleViewMgr:CacheRoleViewPos(camp)
    self.xs = {}
    local rs = self:FindCampRoles(camp)
    if #rs == 0 then
        return
    end
    for i, role in ipairs(rs) do
        self.xs[role.id] = role.transform.position
        role.transform.position = Vector3.New(999999, 0, 0)
    end
end

function BattleViewMgr:ResetRoleViewPos(camp)
    if table.count(self.xs) == 0 then
        return
    end
    local rs = self:FindCampRoles(camp)
    if #rs == 0 then
        return
    end
    for i, role in ipairs(rs) do
        if not isNull(self.xs[role.id]) then
            role.transform.position = self.xs[role.id]
        end
    end
end

--- 所有角色的音量lerp
---@param targetVolume any
---@param duration any
function BattleViewMgr:LerpAllRoleAudioVolume(targetVolume, duration)
    local iters = {}
    for i, v in ipairs(self.roleViews) do
        if isNotNull(v) then
            local iter = v:GetLerpAudioVolumeIter(targetVolume)
            if isNotNull(iter) then
                table.insert(iters, iter)
            end
        end
    end

    if table.count(iters) <= 0 then
        return
    end

    return CoStart(function()
        local time = duration
        local timer = 0

        while timer < time do
            timer = timer + 0.016
            -- CoYield(0.016)
            cs_coroutine.yield_return(WaitForSecondsRealtime(0.016))
            for i, iter in ipairs(iters) do
                iter(timer / time)
            end
        end
    end)
end

--- 指定角色的音量lerp
---@param roleId any
---@param targetVolume any
---@param duration any
function BattleViewMgr:LerpRoleAudioVolume(roleId, targetVolume, duration)
    local roleView = self:FindRoleView(roleId)
    if isNull(roleView) then
        return
    end
    return CoStart(function()
        roleView:LerpAudioVolume(targetVolume, duration)
    end)
end

function BattleViewMgr:SetAllRoleAudioVolume(volume)
    for i, roleView in ipairs(self.roleViews) do
        if isNotNull(roleView) then
            roleView:SetAudioVolume(volume)
        end
    end
end

function BattleViewMgr:SetRoleAudioVolume(roleId, volume)
    local roleView = self:FindRoleView(roleId)
    if isNull(roleView) then
        return
    end
    roleView:SetAudioVolume(volume)
end

function BattleViewMgr:PauseAllRoleAudio()
    for i, roleView in ipairs(self.roleViews) do
        if isNotNull(roleView) then
            roleView:PauseAudio()
        end
    end
end

function BattleViewMgr:PauseRoleAudio(roleId)
    local roleView = self:FindRoleView(roleId)
    if isNull(roleView) then
        return
    end
    roleView:PauseAudio()
end

function BattleViewMgr:ResumeAllRoleAudio()
    for i, roleView in ipairs(self.roleViews) do
        if isNotNull(roleView) then
            roleView:ResumeAudio()
        end
    end
end

function BattleViewMgr:ResumeRoleAudio(roleId)
    local roleView = self:FindRoleView(roleId)
    if isNull(roleView) then
        return
    end
    roleView:ResumeAudio()
end

return BattleViewMgr

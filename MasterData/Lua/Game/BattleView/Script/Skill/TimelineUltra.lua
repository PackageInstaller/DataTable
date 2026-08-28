--
-- Author:luqucheng
-- Date: 2019-12-10 10:50:22
--

local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local KTool = CS.Engine.Lib.KTool
--local AudioManager = CS.Engine.Wwise.AudioManager

local util = require "XLua.util"
local cs_coroutine = import('XLua.cs_coroutine')
local WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local ResourceModule = CS.Engine.Modules.ResourceModule
local MonoHelper = CS.Engine.Lib.MonoHelper
local CinemachineImpulseListener = CS.Cinemachine.CinemachineImpulseListener
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local SignalReceiver = CS.UnityEngine.Timeline.SignalReceiver
local CriWareUtils =  import('Game.Entry.CriWareUtilsFix')
local Yielders = CS.Engine.Lib.Yielders
local UIModule = CS.Engine.UI.UIModule

local TimelineUltra = {}
TimelineUltra.enableAnim = nil
--[[
    @desc: 
    author:luqucheng
    time:2019-12-10 11:10:14
    --@record:
	--@skillViewVo:[Game.Setting.Vo.SkillViewVo#SkillViewVo]
	--@target:[Game.BattleView.Entity.RoleView#RoleView]
	--@attacker:[Game.BattleView.Entity.RoleView#RoleView]
	--@star: 
    @return:
]]
function TimelineUltra:Show(record, skillViewVo, actionVo, target, attacker, star, onHit)
    self.enableAnim = BattleViewMgr.enableUltraAnim
    RoleVoiceMgr:GetInstance():PlayCutInVoiceByCardId(attacker.typeId, nil, skillViewVo.id)

    -- local pp = {}
    -- pp["102008"] = true
    --记录新卡牌数据,为了释放大招
    local key = "NewCards"
    -- CfUtils.WriteLocalData(key, table.serialize(pp))

    if not BattleInfo:IsOnline() and not BattleInfo.isSimulator then
        local markId = attacker:GetUltraTimelineMarkId()
        local infoString = CfUtils.GetLocalData(key)
        -- print("TimelineUltra", infoString)
        if not Tools.isNullKey(infoString) then
            local infos = table.deserialize(infoString)
            if not infos[checkString(markId)] then 
                self.enableAnim = true
                infos[checkString(markId)] = true
                -- local cs = {}
                -- for k,v in pairs(infos) do
                --     if k ~= checkString(attacker.skinId) then
                --         cs[k] = v
                --     end
                -- end
                CfUtils.WriteLocalData(key, table.serialize(infos))
            end
        else
            self.enableAnim = true
            local cs = {}
            cs[checkString(markId)] = true
            CfUtils.WriteLocalData(key, table.serialize(cs))
        end

        local questId = BattleViewMgr.initData.questId
        if questId == Constants.QUEST_OP_LEVEL[2] or questId == Constants.QUEST_OP_LEVEL[3] then
            -- print("[Timeline大招] stop bgm", questId)
            CriWareUtils.StopById(BattleViewMgr.sceneVo.sceneMusic)
        end
    end

    --先等待一秒cutin
    coroutine.yield( WaitForSeconds(1) )

    local targets = RecordReader.SkillRecordReader:GetSkillTargets(record)

    if self.enableAnim then
        -- - ThreadPriority.Low - 2ms;
        -- - ThreadPriority.BelowNormal - 4ms;
        -- - ThreadPriority.Normal - 10ms;
        -- - ThreadPriority.High - 50ms.
        -- CS.UnityEngine.Application.backgroundLoadingPriority = CS.UnityEngine.ThreadPriority.Normal
        --等待cut in 的时候加载
        self.loadCo = cs_coroutine.start(self.LoadTimeline, self, skillViewVo.attackFXs[1] )
        self.roleLoadCo = cs_coroutine.start(self.LoadRole, self, attacker, skillViewVo )
        -- coroutine.yield(CS.UnityEngine.Resources.UnloadUnusedAssets())
        -- CS.System.GC.Collect()
        --如果两秒后还没加载完，还是要继续等待
        while (not self.complete or not self.roleComplete) do
            coroutine.yield( )
        end

        --播放动画
        coroutine.yield(self.HandleTimeline( self, attacker, targets, skillViewVo))
    else
        Events.Broadcast(Constants.EventNames.BattleCutInEnd)
        coroutine.yield(self:WaitBattleCutInClose())
    end
    
    coroutine.yield(self.EndShow( self, attacker, target, targets, skillViewVo, actionVo, onHit))

    local questId = BattleViewMgr.initData.questId
    if questId == Constants.QUEST_OP_LEVEL[2] or questId == Constants.QUEST_OP_LEVEL[3] then
        -- print("[Timeline大招] resume bgm", questId)
        CriWareUtils.PlayMusicById(BattleViewMgr.sceneVo.sceneMusic)
    end
end

function TimelineUltra:WaitBattleCutInClose()
    local handler = Events.AddListener(Constants.EventNames.BattleCutInStartCloseDialog, Bind(self, self.OnBattleCutInStartCloseDialog))
    self.waitCutInClose = true
    while self.waitCutInClose do
        coroutine.yield()
        -- 防止cutIn意外关闭，或者没有加载出来导致卡死在循环里面
        local needWait = false
        local dialogs = UIModule.CurrentScreen.dialogs
        local length = dialogs.Count
        for i = length, 1, - 1 do
            local dialog = dialogs[i - 1]
            if isNotNull(dialog) and isNotNull(dialog.Argument) and isNotNull(dialog.Argument.id) then
                if checkNumber(dialog.Argument.id) == Constants.UITypeIds.UIBattlingCutInDialog then
                    needWait = true
                end
            end
        end
        if not needWait then
            break
        end
    end
    Events.RemoveListener(Constants.EventNames.BattleCutInStartCloseDialog, handler)
end

function TimelineUltra:OnBattleCutInStartCloseDialog()
    self.waitCutInClose = false
end

--@attacker: [Game.BattleView.Entity.RoleView#RoleView]
function TimelineUltra:EndShow( attacker, target, targets, skillViewVo, actionVo, onHit )
    if self.skipFunc then
        Events.RemoveListener(Constants.EventNames.UIBattlingSkipSpCG, self.skipFunc)
        self.skipFunc = nil
    end

    local BattleViewMgr = BattleViewMgr
    --切换到默认镜头
    BattleViewMgr:ResetCamera(true)

   
    if self.lobbyRole then
        if skillViewVo.isLobbyModel then
            CS.UnityEngine.GameObject.Destroy(self.lobbyRole)
            self.lobbyRole = nil
        else
            -- attacker:PlayAnimation("skill3_end", true)
            self:ChangeAllLayer(attacker.gameObject, 8, 11)
            self:ChangeAllLayer(attacker.gameObject, 18, 19)
            -- Tools.syncStand(attacker.transform, attacker.defaultStand)
            self.lobbyRole = nil
        end
    end
   
    --强制恢复idle
    --unity的bug，原本就带状态机的物体不重置一下状态机控制器就会导致物体不能再被移动，这个bug在2020.1版本被修改好
    -- attacker:ResetAnimator()
    -- attacker:PlayAnimation("idle", true)
    attacker:Hide()

    --设置角色层级
    
    -- self:ChangeAllLayer(attacker.gameObject, 8, 11)

    if self.UpdatePosFunc then
        MonoHelper.RemoveUpdateListener(self.UpdatePosFunc)
        self.UpdatePosFunc = nil
    end

    for i,t in ipairs(targets) do
        -- t:ResetAnimator()
        if t.id ~= attacker.id then
            t:PlayAnimation("idle", true)
        end
        self:ChangeAllLayer(t.gameObject, 8, 11)
        self:ChangeAllLayer(t.gameObject, 18, 19)

        if t.id ~= attacker.id then--攻击者的隐藏显示单独处理
            Tools.syncStand(t.transform, t.defaultStand)
        end
    end
    BattleViewMgr.camera.gameObject:SetActive(true);
    -- local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
    -- URPCameraController:SetActive(true)
    

    --恢复当前速度，因为大招的timeline会强制改变游戏速度
    if BattleViewMgr.enableUltraAnim then
        -- CS.UnityEngine.Time.timeScale = BattleViewMgr.gameSpeed
    else
        -- coroutine.yield( WaitForSeconds(0.4) )
    end
    attacker:PlayAnimation("skill3_end", false)
    attacker:SyncAnimation()
    attacker:SyncStand()

    -- self:PlayEndTimeline(attacker, target, skillViewVo)
    cs_coroutine.start( self.PlayEndTimeline, self, attacker, target, skillViewVo)
    local skill3EndFrame = attacker:GetAnimationFrame("skill3_end")
    -- print("skill3EndFrame", skill3EndFrame)
    coroutine.yield( WaitForSeconds(0.3) )

    if not Tools.isNullKey(skillViewVo.aimAoeFX) then
        BattleViewMgr.FXMgr:PlayFX(skillViewVo.aimAoeFX, BattleViewMgr:GetAoe(target.camp), 1)
    end
    
    --所有目标都释放瞄准特效
    for i,v in ipairs(targets) do
        local uid = BattleViewMgr.FXMgr:PlayFXOnRole(skillViewVo.aimFX, v)
     end

    local nowF = 0
    for i,v in ipairs(actionVo.hits) do
        local t = (v.frame - nowF) * AnimFrameTime

        -- for i,t in ipairs(targets) do
        --     --播放受击特效
        --     local effectName = skillViewVo.hitFX[i] or skillViewVo.hitFX[#skillViewVo.hitFX]
        --     BattleViewMgr.FXMgr:PlayFX(effectName, t.fxNode)
        -- end
        coroutine.yield( WaitForSeconds(t) )
        
        onHit(i, actionVo)
        if skillViewVo.isAoe then
            BattleViewMgr.FXMgr:PlayFX(skillViewVo.aoeHitFX[i] or skillViewVo.aoeHitFX[#skillViewVo.aoeHitFX], BattleViewMgr:GetAoe(target.camp))
        end
        nowF = v.frame
    end
    -- 强制还原倍速，防止被timeline里面改了
    BattleViewMgr:ChangeGameSpeed(BattleViewMgr.gameSpeed)
    self:ReleaseBundle()

    
    -- 大招结束触发切换动画状态机
    attacker:TrigSwitchAnimatorController(2, attacker.id)

    -- if nowF < skill3EndFrame then
    --     coroutine.yield( WaitForSeconds( (skill3EndFrame - nowF) * AnimFrameTime ) )
    -- end

    --if enableAnim then
    --    cs_coroutine.start(function ()
    --        CS.UnityEngine.Resources.UnloadUnusedAssets()
    --    end)
    --end
    -- coroutine.yield( WaitForSeconds(1) )
end

-----ReleaseBundle
function TimelineUltra:ReleaseBundle()
    -- if not isNull(self.loader) then
    --     self.loader:Release(true)
    --     self.loader = nil
    -- end
    -- if not isNull(self.roleLoader) then
    --     self.roleLoader:Release(true)
    --     self.roleLoader = nil
    -- end
end

--@targets: [Game.BattleView.Entity.RoleView#RoleView<>]
function TimelineUltra:HandleTimeline( attacker, targets, skillViewVo )
    -- self.ultraFX.transform:SetParent(attacker.transform)
    -- KTool.ResetTransform(self.ultraFX.transform)
    -- self.ultraFX:SetActive(true)
    --bgm
    -- print("HandleTimeline", skillViewVo.skillBgm)
    if not Tools.isNullKey(skillViewVo.skillBgm) then
        --AudioManager.Instance:PlayMusic(skillViewVo.skillBgm, BattleMusicTag)
    end

    --根据特效需求，关闭雾效
    self.useFog = CS.UnityEngine.RenderSettings.fog
    CS.UnityEngine.RenderSettings.fog = false
    --设置角色层级
    --绑定目标

    self.binder:SetTrackDynamic("role", self.lobbyRole)

    local update = function (  )
        --寻找位置点
        local nodes = {}
        for i,t in ipairs(targets) do
            --有时候动作想去K位移，所以如果找到动作对应的点，则去绑定相关位移
            local fxNode = KTool.DFSFindObject(self.playableDirector.transform, "bigskilltarget"..i)
            if fxNode then
                nodes[i] = fxNode.transform
            end
        end

        return function (  )
            for i,t in ipairs(targets) do
                local node = nodes[i]
                if node then
                    -- print( node.name .." x:" ..node.position.x .. " y:" ..node.position.y.. " z:"..node.position.z)
                    local s = t.modelVo.timeLineScale
                    t.transform.localPosition = node.position
                    t.transform.localRotation = node.rotation
                    t.transform.localScale = Vector3.New(node.localScale.x * s, node.localScale.y * s, node.localScale.z * s) 
                    -- Tools.syncStand(t.transform, node)
                end
            end
        end
    end
    -- self.UpdatePosFunc = update()
    -- MonoHelper.AddUpdateListener(self.UpdatePosFunc)
    local scales = {}
    scales[attacker.id] = attacker.transform.localScale

    --所有目标都需要改变层级，同时还需要移动到对应的点
    local index = 1
    for i,t in ipairs(targets) do
        scales[t.id] = t.transform.localScale
        --处理缩放
        if skillViewVo.ifScale == 1 and t.id ~= attacker.id then
            local s = t.modelVo.timeLineScale
            -- print("localScale set", skillViewVo.roleId, t.typeId, s)
            t.transform.localScale = Vector3.New(s, s, s)
        end
        --排除即时目标又是攻击者的情况（加血加护盾等）
        if t.id ~= attacker.id then
            --需要额外定义一个index
            self.binder:SetTrackDynamic("target"..index, t.gameObject)
            index = index + 1
            self:ChangeAllLayer(t.gameObject, 11, 8)
            self:ChangeAllLayer(t.gameObject, 19, 18)

        end

        --有时候动作想去K位移，所以如果找到动作对应的点，则去绑定相关位移

    end

    -- 绑定完角色以后，再把timeline摆到第一帧
    self.playableDirector:Evaluate()

    -- 关灯
    BattleViewMgr:SwitchSceneLights(false)
    -- 显示跳过按钮
    self.skipFunc = Events.AddListener(Constants.EventNames.UIBattlingSkipSpCG, Bind(self, self.SkipTimeline))
    Events.Broadcast(Constants.EventNames.BattleTimelineStart)
    -- 关闭战中UI
    Events.Broadcast(Constants.EventNames.UIBattingStoryRunning, false)
    -- 通知cut in结束
    Events.Broadcast(Constants.EventNames.BattleCutInEnd)
    -- 等待cut in关闭
    coroutine.yield(self:WaitBattleCutInClose())
    -- 主相机隐藏
    BattleViewMgr.camera.gameObject:SetActive(false)


    self.playableDirector:Play()
    BattleViewMgr:PlaySFX(skillViewVo.attackSFX, attacker)
    

    local voiceVo = RoleVoiceMgr:GetInstance():PlayVoiceWhenBigSkill(attacker.typeId)
        
    --相机和层级的隐藏显示时间跟着特效的时间走
    --判断是否是绑定骨骼的特效

    local mainFXId = -1
    
    local fxIds = {}
    --播放所有攻击特效
    for i,v in ipairs(skillViewVo.attackFXs) do
        if i == 1 then
            mainFXId = v
        else
            local uid = BattleViewMgr.FXMgr:PlayFX(v, self.lobbyRole, 1)
            table.insert(fxIds, uid)
        end
    end

    local _GetCurrentTime
    local movieController = self.playableDirector.transform:GetComponentInChildren(typeof(CS.CriWare.CriManaMovieControllerForUI))
    if isNotNull(movieController) then
        -- 如果大招是视频的话，可能会卡，所以要以视频播放组件的当前时间为准
        _GetCurrentTime = function()
            return movieController.player:GetTime() / 1000000
        end
    else
        _GetCurrentTime = function()
            return self.playableDirector.time
        end
    end

    local _timeSignFadeOut = 0.1
    self.tlEnd = false
    local lastTime = -1
    local curTime = _GetCurrentTime()
    while (curTime < (self.playableDirector.duration - _timeSignFadeOut)) and (not self.tlEnd) do
        lastTime = curTime
        coroutine.yield(Yielders.EndOfFrame)
        curTime = _GetCurrentTime()
        if lastTime > 0 and lastTime > curTime then
            self.tlEnd = true
        end
    end
    Events.Broadcast(Constants.EventNames.BattleTimelineEnd)

    local questId = BattleViewMgr.initData.questId
    if questId == Constants.QUEST_OP_LEVEL[2] or questId == Constants.QUEST_OP_LEVEL[3] then
        -- 序章大招会延迟销毁，不需要闪白
    else
        Events.Broadcast(Constants.EventNames.UIBattleShowFadeOut)      -- 大招结束闪白
    end
    
    BattleViewMgr:SwitchSceneLights(true)
    coroutine.yield(WaitForSeconds(_timeSignFadeOut))

    -- 等待_timeSignFadeOut时长以后，白屏已经全白了，再等待_timeSignFadeOut时长以后，再显示战中UI
    self.coWaitShowUI = cs_coroutine.start( function ()
        coroutine.yield(WaitForSeconds(_timeSignFadeOut))
        Events.Broadcast(Constants.EventNames.UIBattingStoryRunning, true)
        self.coWaitShowUI = nil
    end)
    

    if self.playableDirector then
        self.playableDirector:Stop()
        local questId = BattleViewMgr.initData.questId
        if questId == Constants.QUEST_OP_LEVEL[2] or questId == Constants.QUEST_OP_LEVEL[3] then
        else
            self:DestroyGO()
        end
    end
    BattleViewMgr.camera.gameObject:SetActive(true)

    if voiceVo then
        CriWareUtils.StopById(voiceVo.voicecode)
    end
    BattleViewMgr:StopSFX(skillViewVo.attackSFX)

    for i,v in ipairs(fxIds) do
        BattleViewMgr.FXMgr:RemoveFX(v)
    end
    
    CS.UnityEngine.RenderSettings.fog = self.useFog

    for i,t in ipairs(targets) do
        --还原缩放
        -- print("localScale resume", skillViewVo.roleId, t.typeId, scales[t.id])
        t.transform.localScale = scales[t.id]
    end
    attacker.transform.localScale = scales[attacker.id]

    if not Tools.isNullKey(skillViewVo.skillBgm) then
        --AudioManager.Instance:PlayMusic(BattleViewMgr.sceneVo.sceneMusic, BattleMusicTag)
    end

    -- print("Handle timeline end")
end

function TimelineUltra:DestroyGO()
    if not isNull(self.playableDirector) then
        --self.playableDirector:Stop()
        --清除所有绑定
        -- self.binder:ClearAllBind()
        CS.UnityEngine.GameObject.Destroy(self.playableDirector.gameObject)
        -- CS.UnityEngine.Resources.UnloadAsset(self.playableDirector.gameObject)
        self.playableDirector = nil
    end
end

function TimelineUltra:SkipTimeline()
    if self.tlCo then
        cs_coroutine.stop(self.tlCo)
        self.tlCo = nil
    end
    self.tlEnd = true
end

function TimelineUltra:PlayEndTimeline(attacker, target, skillViewVo)
    if target.modelVo.size > Constants.RoleSize.Big then
        return
    end
    local SkillCameraVo = BattleViewMgr:GetSkillCameraVo(skillViewVo)
    if not SkillCameraVo then
        return
    end

    if Tools.isNullKey(SkillCameraVo.skill3EndCam) then
        return
    end

    local path = gameUtils.GetThreeStarCameraFullPath(SkillCameraVo.skill3EndCam)
    local loader = ResourceModule.LoadBundleSync(path, nil, true)--"Timeline/Timeline.prefab"
    if not loader.IsError then
        --放到主目标的节点下面
        local node = nil
        if skillViewVo.isAoe then
            node = BattleViewMgr:GetAoe(target.camp).transform
        else
            node = target.cameraAttach
        end

        if not isNull(node) then
            local go = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject, node)

            local cameras = go:GetComponentsInChildren(typeof(CinemachineVirtualCamera))
            for i = 0, cameras.Length - 1 do
                local camera = cameras[i]
                if not KTool.IsNull(camera) then
                    local impulse = camera.gameObject:EnsureComponent(typeof(CinemachineImpulseListener))
                    impulse.m_ChannelMask = 1
                    impulse.m_Gain = 8
                end
                -- camera.gameObject:GetUniversalAdditionalCameraData().renderType = CS.UnityEngine.Rendering.Universal.CameraRenderType.Overlay;
            end
            CfUtils.ChangeMainCamDefalultBlend(0)
            BattleViewMgr:AddCommonSignals(go)
            local playableDirector = go:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
            KTool.ResetTransform(go.transform)
            -- go.transform:LookAt( attacker.defaultNode.position )
            --y轴转180度
            -- go.transform:Rotate(0,180,0)
            playableDirector:Play()
            -- print("PlayEndTimeline", playableDirector.duration)
            coroutine.yield( WaitForSeconds(0.1) )
            CfUtils.ChangeMainCamDefalultBlend(0.5)
            coroutine.yield( WaitForSeconds(playableDirector.duration - 0.1) )
            CfUtils.ChangeMainCamDefalultBlend(0)
            playableDirector:Stop()
            CS.UnityEngine.GameObject.Destroy(go)
        end
        loader:Release(true)
        loader = nil
    else
        loader:Release(true)
        loader = nil
    end
end

function TimelineUltra:LoadTimeline( fxId )
    self.complete = false
    local setting = settingMgr:GetSetting(AutoIds.IdSetting566, "FXResVo")
    -- print("LoadTimeline", fxId)
    --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
    local FXResVo = setting:Get(fxId)

    local path = gameUtils.GetTimelineFullPath(FXResVo.resourcesId)
    local loader = ResourceModule.LoadBundleAsync(path, nil, true)--"Timeline/Timeline.prefab"
    while not loader.IsSuccess do
        coroutine.yield( )
    end
    if not loader.IsError then

        ---这里还出现卡，人物的prefab需要优化
        -- local go = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
        local go = loader:Instantiate()
        loader:Release()
        local playableDirector = go:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
        self.binder = go:AddComponent( typeof(CS.Game.Native.Timeline.TimelineBinder) )
        playableDirector.playOnAwake = false
        playableDirector:Stop()
        playableDirector:Evaluate() -- 把timeline摆在第一帧(但是这时候角色还没有绑定进轨道，所以这里其实只有相机对了，角色的位置不一定对了)
        
        -- local time = playableDirector.duration
        -- go:SetActive(false)
        self.playableDirector = playableDirector

        --!!!!!!!!!!因为ui改成overlay了，所以不需要这里了
        --urp timeline大招会加base相机，所以要把ui相机加入到cameraStack里面
        local cameras = go:GetComponentsInChildren(typeof(CS.UnityEngine.Camera))
        local uiCamera = CS.Engine.UI.UIModule.RootCanvas.defaultCamera
        for i = 0, cameras.Length - 1 do
            local camera = cameras[i]
            if not KTool.IsNull(camera) then
                -- local additionalCameraData = CS.UnityEngine.Rendering.Universal.CameraExtensions.GetUniversalAdditionalCameraData(camera)
                -- if not KTool.IsNull(additionalCameraData) and not KTool.IsNull(uiCamera) then
                --     -- additionalCameraData.renderType = CS.UnityEngine.Rendering.Universal.CameraRenderType.Overlay;
                --     -- additionalCameraData.cameraStack:Add(uiCamera)
                    
                -- end
                local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
                URPCameraController:InitCameraStack(camera)
            end
            -- camera.gameObject:GetUniversalAdditionalCameraData().renderType = CS.UnityEngine.Rendering.Universal.CameraRenderType.Overlay;
        end
        -- local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
        -- URPCameraController:SetActive(false)
        -- BattleViewMgr.camera.gameObject:SetActive(false);

    end
    -- self.loader = loader
    setting = nil
    FXResVo = nil
    self.complete = true
    self.loadCo = nil
    -- CS.UnityEngine.Application.backgroundLoadingPriority = CS.UnityEngine.ThreadPriority.BelowNormal
end

--@attacker:[Game.BattleView.Entity.RoleView#RoleView]
function TimelineUltra:LoadRole( attacker, skillViewVo )
    self.roleComplete = false
    local path = nil
    if skillViewVo.isLobbyModel then
        local res = Core:GetLobbyModleId(attacker.skinId)
        path = "Arts/Prefab_lobby/" .. res .. ".prefab"
        local loader = ResourceModule.LoadBundleAsync(path, nil, true)
        while not loader.IsSuccess do
            cs_coroutine.yield_return()
        end
        if not loader.IsError then
            -- self.roleLoader = loader
            -- self.lobbyRole = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
            self.lobbyRole = loader:Instantiate()
            loader:Release()

            local scripts = self.lobbyRole:GetComponentsInChildren(typeof(CS.FaceForward))
            for i = 0, scripts.Length - 1 do
                scripts[i].UpdateImmediately = true
            end
        end
    else
        self.lobbyRole = attacker.gameObject
    end
    self:ChangeAllLayer(self.lobbyRole, 11, 8)
    self:ChangeAllLayer(self.lobbyRole, 19, 18)
    
    KTool.SetActive(self.lobbyRole, false)
    KTool.SetActive(self.lobbyRole, true)

    
    
    self.roleComplete = true
end

function TimelineUltra:ChangeAllLayer(gameObject, layer, aimLayer)
    local children = gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.Transform), true)
    for i = 0, children.Length - 1 do
        local child = children[i]
        if child.gameObject.layer == aimLayer then
            child.gameObject.layer = layer
        end
    end
end


function TimelineUltra:RemoveSignal( role )
    local sr = KTool.GetOrAddComponent(role.gameObject, typeof(SignalReceiver))

    local path = gameUtils.GetTimelineSignalFullPath("attack_hit")
    local loader = ResourceModule.LoadBundleSync(path)--"Timeline/Timeline.prefab"
    loader:Retain(sr)
    loader:Release()
    if not loader.IsError then
        local event = CS.UnityEngine.Events.UnityEvent();
        event:AddListener(function (  )
            -- print("TimelineUltra:AddSignal")
            role:PlayHurt()
        end)
        sr:AddReaction(loader.ResultObject, event)
    end
end

-- function TimelineUltra:LoadFX( fxId )
--     self.complete = false
--     --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
--     local FXResVo = setting:Get(fxId)

--     local path = gameUtils.GetEffectFullPath(FXResVo.resourcesId)
--     local loader = ResourceModule.LoadBundleAsync(path)
--     while not loader.IsSuccess do
--         cs_coroutine.yield_return()
--     end
--     if not loader.IsError then
--         ---这里还出现卡，人物的prefab需要优化
--         local go = CS.UnityEngine.GameObject.Instantiate(loader.ResultObject)
--         go:SetActive(false)
--         self.ultraFX = go
--     end
--     self.complete = true
-- end

function TimelineUltra:Clear(  )
    Events.Broadcast(Constants.EventNames.BattleCutInEnd)   -- 防止大招过程中被重新连接的stopview给打断，导致cutin界面残留
    if self.UpdatePosFunc then
        MonoHelper.RemoveUpdateListener(self.UpdatePosFunc)
        self.UpdatePosFunc = nil
    end
    if self.loadCo then
        cs_coroutine.stop(self.loadCo)
        self.loadCo = nil
    end
    if self.roleLoadCo then
        cs_coroutine.stop(self.roleLoadCo)
        self.roleLoadCo = nil
    end
    if self.coWaitShowUI then
        cs_coroutine.stop(self.coWaitShowUI)
        self.coWaitShowUI = nil
    end
    self.binder = nil
    self.playableDirector = nil
    self:ReleaseBundle()
end

return  TimelineUltra
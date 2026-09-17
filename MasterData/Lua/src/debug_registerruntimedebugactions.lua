local helper = CS.Lens.Tools.RuntimeDebug.RuntimeDebugActionHelper
local lockstepManager = CS.Lens.Gameplay.Battle.Logic.LockStepManager
local rePlayManager = CS.Lens.Gameplay.Battle.Logic.RePlayManager
local worldAdapter = CS.Lens.Gameplay.Modules.Azur.WorldAdapter
local debugActions = require("debug.debugActions")
if IS_DEV_BUILD then
  C_MJLog.LogInfo("@is dev build")
  helper.SetTouchToggleActive(Unity.Application.isEditor or Unity.Application.IsMobilePlatformForUI)
else
  C_MJLog.LogInfo("@is release build")
  helper.SetTouchToggleActive(false)
end
helper.RegisterButton("资源框架工具", "统计耗时", function()
  CS.Azur.Gameplay.Core.LoadAnalysisTool.ExportToCsv()
end, true, "保存路径：Application.dataPath + \"/MJRecord_Load_yyyy_MMdd_HHmm_ss.csv\"")
helper.RegisterInput("资源框架工具", "SetOperationSystemMaxTimeSlice", function(inputStr)
  local times = string.split(inputStr, ",")
  CS.Lens.Framework.AzurAssets.SetOperationSystemMaxTimeSlice(times[1], times[2], times[3])
end, true, "总时间,卸载时间,实例。默认10,1,5")
helper.RegisterButton("资源框架工具", "资源释放测试", function()
  CS.Lens.Framework.AzurAssets.Test11()
end, true, "Resources.UnloadUnusedAssets")
helper.RegisterButton("Application", "GC.Collect(Mono+Lua)", function()
  CS.System.GC.Collect()
  collectgarbage("collect")
end, true, "GC.Collect(Mono+Lua)")
helper.RegisterToggle("GM Tools", "开启/隐藏大世界", function()
  return CS.Azur.Gameplay.UI.UISceneManager.GetSceneActive()
end, function(isOn)
  CS.Azur.Gameplay.UI.UISceneManager.SetSceneActive(isOn)
  CS.AzurWorld.HUDMgr:SetAllVisible(isOn)
end)
helper.RegisterButton("GM Tools", "重新注册命令", function()
  helper.UnregisterByGroup("GM Tools")
  package.loaded["debug.registerRuntimeDebugActions"] = pcall(load("debug.registerRuntimeDebugActions"))
  package.loaded["debug.debugActions"] = pcall(load("debug.debugActions"))
  printf("RuntimeDebugActionHelper", "lua gm脚本重置")
  require("debug.registerRuntimeDebugActions")
end)
helper.RegisterButton("GM Tools", "Smart GC", function()
  CS.Azur.Gameplay.Core.SmartGC.Instance:Collect(true)
end)
helper.RegisterButton("GM Tools", "打开外挂", function()
  local msg = {
    command = "DEEPFINISHALLGUIDETASK",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  local msg = {
    command = "UNLOCKPOS",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  local msg = {
    command = "SUPERCMD",
    args = {"7"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, function()
    debugActions.SendGMCommand("ALLPETLV " .. tostring(100))
  end)
  local msg = {
    command = "SUPERCMD",
    args = {"1"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, function()
    debugActions.SendGMCommand("HEROLV " .. tostring(100))
  end)
end)
helper.RegisterButton("GM Tools", "战斗模拟器(仅标题界面进入)", function()
  local simulateType = CS.Azur.Gameplay.Flows.ESimulateType.BattleSimulate
  CS.Lens.Gameplay.Modules.BigWorld.Simulators.SimulatorContextManager.instance:LaunchSimulator(simulateType)
  CS.Azur.Gameplay.AzurEntry.instance:StartGame(function()
    AzurWorld.proxyCenter:ToSimulate(99997, CS.Azur.Gameplay.Flows.ESimulateType.BattleSimulate)
  end)
end, true, "非标题界面进入不再维护，极大概率报错")
helper.RegisterButton("GM Tools", "奇波对战模拟器(仅标题界面进入)", function()
  local simulateType = CS.Azur.Gameplay.Flows.ESimulateType.KiboDuelSimulate
  CS.Lens.Gameplay.Modules.BigWorld.Simulators.SimulatorContextManager.instance:LaunchSimulator(simulateType)
  CS.Azur.Gameplay.AzurEntry.instance:StartGame(function()
    AzurWorld.proxyCenter:ToSimulate(99997, CS.Azur.Gameplay.Flows.ESimulateType.KiboDuelSimulate)
  end)
end, true, "非标题界面进入不再维护，极大概率报错")
helper.RegisterButton("GM Tools", "付费测试", function()
  local data = {productId = 1001, times = 1}
  L_MoneyShopStore:req_purchaseCashItem(data, function(result)
    if result then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_buySuccess"))
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_buyFail"))
    end
  end)
end, true, "付费测试")
helper.RegisterInput("GM Tools", "GM命令", function(inputStr)
  debugActions.SendGMCommand(inputStr)
end, true, "向后端发送GM命令")
helper.RegisterInput("GM Tools", "切换场景", function(inputStr)
  local nextSceneId = tonumber(inputStr)
  local sceneId = AzurWorldInstance.CurWorldId
  if nextSceneId == sceneId then
    return
  end
  AzurWorld.proxyCenter:RequestTransfer(nextSceneId)
end, true, "传送到指定场景")
helper.RegisterInput("GM Tools", "进入副本", function(inputStr)
  local nums = string.split(inputStr, " ")
  local data = {
    group_id = tonumber(nums[1]),
    difficulty = tonumber(nums[2])
  }
  L_Net:sendMessage(MsgGenCode.CSProtoCampaignCreate, data, function(rspData, errorCode)
  end)
end, true, "传送到指定副本：副本组id 难度")
helper.RegisterInput("GM Tools", "进入教学关卡", function(inputStr)
  L_EntrustStore:req_CSProtoTeachStart(tonumber(inputStr))
end, true, "传送到指定教学关卡：trainTask表id")
helper.RegisterButton("GM Tools", "美术测试调参", function()
  L_UI:open("pageArtGM")
end)
helper.RegisterInput("GM Tools", "进入奇波对战测试试用奇波", function(inputStr)
  local nums = string.split(inputStr, " ")
  local levelId = tonumber(nums[1])
  if math.isEmpty(levelId) then
    return
  end
  L_KiBoDuelManager:openTestKiBoDuel(levelId)
end, true, "进入奇波对战测试试用奇波：副本id")
helper.RegisterInput("GM Tools", "相机抖动", function(inputStr)
  C_CameraManager.SetLookAtFollowLerpSpeed(tonumber(inputStr))
end, true, "相机抖动参数设置")
helper.RegisterToggle("GM Tools", "相机屏蔽总开关", function(isShow)
  return C_CameraManager.lookAtCameraIgnore
end, function(isShow)
  C_CameraManager.lookAtCameraIgnore = isShow
end)
helper.RegisterToggle("GM Tools", "相机屏蔽-屏蔽插件回正", function(isShow)
  return C_CameraManager.huizhengIgnore
end, function(isShow)
  C_CameraManager.huizhengIgnore = isShow
end)
helper.RegisterToggle("GM Tools", "相机屏蔽-屏蔽人物timeline", function(isShow)
  return C_CameraManager.herotimelineIgnore
end, function(isShow)
  C_CameraManager.herotimelineIgnore = isShow
end)
helper.RegisterToggle("GM Tools", "相机屏蔽-屏蔽宠物timeline", function(isShow)
  return C_CameraManager.pettimelineIgnore
end, function(isShow)
  C_CameraManager.pettimelineIgnore = isShow
end)
helper.RegisterToggle("GM Tools", "相机屏蔽-屏蔽切人fov与视距", function(isShow)
  return C_CameraManager.switchFovTimelineIgnore
end, function(isShow)
  C_CameraManager.switchFovTimelineIgnore = isShow
end)
helper.RegisterToggle("GM Tools", "相机屏蔽-屏蔽人物指挥镜头", function(isShow)
  return C_CameraManager.petZhihuiIgnore
end, function(isShow)
  C_CameraManager.petZhihuiIgnore = isShow
end)
helper.RegisterToggle("GM Tools", "相机屏蔽-break镜头", function(isShow)
  return C_CameraManager.breakIgnore
end, function(isShow)
  C_CameraManager.breakIgnore = isShow
end)
helper.RegisterToggle("GM Tools", "关闭BlendShape重绑定", function(isShow)
  return CS.Lens.Gameplay.Managers.CostumeChangeManager.BoneAvatarModel.CLOSE_RESET
end, function(isShow)
  CS.Lens.Gameplay.Managers.CostumeChangeManager.BoneAvatarModel.CLOSE_RESET = isShow
end)
local C_BevPlatform = CS.Lens.Framework.Utility.BehaviorOnPlatform
helper.RegisterInput("GM Tools", "PC/Mobile UI适配", function(inputStr)
  local inputNum = tonumber(inputStr)
  if C_MultiPlatformMgr.platform ~= inputNum then
    C_MultiPlatformMgr.platformInt = inputNum
  end
  C_BevPlatform.platformInt = inputNum
  if inputNum == 0 then
    C_AppConfigManager.SetUIPlatformOverrideByStr("windows")
  elseif inputNum == 16 then
    C_AppConfigManager.SetUIPlatformOverrideByStr("android")
  end
  L_DeviceTpl:inject()
  L_SettingStore:injectAdapter()
  local isShowMobile = table.containsValue({16}, tonumber(inputStr))
  L_UI:setRefResolution(not isShowMobile and {x = 2400, y = 1350} or {x = 1920, y = 1080})
  L_SettingStore:call(L_SettingStore.event.refreshEquipment)
end)
helper.RegisterInput("GM Tools", "切平台 仅切换Platform字段 1pc 2android 3ios", function(inputStr)
  if inputStr == "1" then
    C_AppConfigManager.SetPlatform(C_EAppPlatform.Standalone)
  elseif inputStr == "2" then
    C_AppConfigManager.SetPlatform(C_EAppPlatform.Android)
  elseif inputStr == "3" then
    C_AppConfigManager.SetPlatform(C_EAppPlatform.IOS)
  elseif inputStr == "4" then
    C_AppConfigManager.SetPlatform(C_EAppPlatform.Harmony)
  end
  C_GameSettingManager.OnPlatformSwitch()
end)
helper.RegisterInput("GM Tools", "禁止显示pc快捷键(1:禁止,0:显示)", function(inputStr)
  local C_ShortcutMgr = CS.Lens.Gameplay.UI.ShortcutGuidePcManager
  C_ShortcutMgr.isForbid = tonumber(inputStr) == 1
end)
helper.RegisterToggle("GM Tools", "相机屏蔽-屏蔽全局相机回正", function(isShow)
  return C_CameraManager.resetIgnore
end, function(isShow)
  C_CameraManager.resetIgnore = isShow
end)
helper.RegisterToggle("GM Tools", "大地图标点传送开关", function(isOn)
  return debugActions.enableMapPointTeleport
end, function(isOn)
  debugActions.enableMapPointTeleport = isOn
end, false, "开启后：PC 端 Ctrl+左键，移动端长按 5 秒可在大地图标点传送")
debugActions.showLogConsole(debugActions.isShowLogConsole)
helper.RegisterToggle("GM Tools", "设置当前设备", function(isShow)
  return L_DeviceTpl:getIsPc()
end, function(isShow)
  if isShow then
    L_DeviceTpl.data.equipment = L_Const.equipment.pc
    L_DeviceTpl.data.platform = C_EAppPlatform.Standalone
  else
    L_DeviceTpl.data.equipment = L_Const.equipment.mobile
    L_DeviceTpl.data.platform = C_EAppPlatform.Android
  end
  L_SettingStore:injectAdapter()
  L_SettingStore:call(L_SettingStore.event.refreshEquipment)
end)
helper.RegisterButton("GM Tools", "刷新随机任务测试", function(inputStr)
  AzurWorld.TaskMgr:GMRefreshRandomTask(inputStr, true)
end, true, "任务id")
helper.RegisterToggle("GM Tools", "开关加载句柄析构报错", function(isShow)
  return CS.Azur.Gameplay.Core.Asset.AssetManager.Instance.LogUnloadAssetByGCInfo
end, function(isShow)
  CS.Azur.Gameplay.Core.Asset.AssetManager.Instance.LogUnloadAssetByGCInfo = isShow
end)
helper.RegisterToggle("GM Tools", "开关Lua代码profiler打点", function(isShow)
  return L_ProfilerUtil.IsOpenProfiler()
end, function(isShow)
  L_ProfilerUtil.ToggleProfiler(isShow)
end)
helper.RegisterInput("GM Tools", "测试场景内存占用", function(inputStr)
  if L_CommonUtil.isValid(L_HeroManager.lastInstanceObj) then
    C_PrefabManager:RecycleByLoader(L_HeroManager.lastInstanceObj)
  end
  local goLoader = C_PrefabManager:GetLoader("测试场景内存占用")
  L_HeroManager.lastInstanceObj = goLoader:Spawn(inputStr, C_UIMgr.root)
  local virtualCameras = L_HeroManager.lastInstanceObj:GetComponentsInChildren(typeof(CS.Cinemachine.CinemachineVirtualCamera))
  for i = 0, virtualCameras.Length - 1 do
    virtualCameras[i].gameObject:SetActive(false)
  end
end, true, "场景路径")
helper.RegisterToggle("GM Tools", "设置测试key", function(isShow)
end, function(isShow)
end)
helper.RegisterToggle("GM Tools", "设置本地化key", function(isShow)
  return C_PlayerPrefsUtility.GetBool("LTextShowTextKeyToolOpen")
end, function(isShow)
  L_Lang.gm_LTextShowTextKeyToolOpen = isShow
  C_LTextShowToolWrapper.SwitchOpen(isShow)
end)
helper.RegisterInput("GM Tools", "获得当前界面文本对应的key", function(inputStr)
  local text = inputStr
end, true, "文本值")
local _testTimelineControl
helper.RegisterInput("GM Tools", "测试角色timeline内存占用", function(inputStr)
  if _testTimelineControl then
    _testTimelineControl:dispose()
    _testTimelineControl = nil
  end
  if string.isEmpty(inputStr) then
    return
  end
  G_Launcher.alias:defGamePlayCS()
  local nums = string.split(inputStr, ":")
  local heroId = tonumber(nums[1])
  local timelineControl = require("ui.manager.hero.timeline.timelineControl").new()
  _testTimelineControl = timelineControl
  local clothing = L_GameTpl:getHeroClothingTpl():getTplById(heroId)
  local path = L_Config:getPathByHash(clothing.uiperform)
  local state = L_Const.heroTimelineState.Detail
  local timelineAssetName = timelineControl:getTimelineAssetName(state)
  timelineControl:asyncLoadTimelineAssets(path, timelineAssetName, nil, heroId, false, function()
  end, function()
    timelineControl:setAssetsActive(true)
    local array = {
      L_Const.heroTimelineState.Detail,
      L_Const.heroTimelineState.Equip,
      L_Const.heroTimelineState.Skill
    }
    for i = 1, #array do
      Timer.once((i - 1) * 3, function()
        timelineControl:playTimelineState(array[i], true, i == 1)
      end)
    end
  end, tonumber(nums[2]), heroId)
end, true, "角色id")
helper.RegisterButton("GM Tools", "清理测试场景加载", function()
  if L_CommonUtil.isValid(L_HeroManager.lastInstanceObj) then
    C_PrefabManager:RecycleByLoader(L_HeroManager.lastInstanceObj)
  end
  local goLoader = C_PrefabManager:GetLoader("测试场景内存占用")
  goLoader:Dispose()
end)
helper.RegisterButton("GM Tools", "开启UI性能统计面板", function()
  CS.Azur.Gameplay.UI.UIPerformanceCollecter.Instance.showDebugPanel = true
end)
helper.RegisterInput("GM Tools", "去除随机任务测试", function(inputStr)
  AzurWorld.TaskMgr:GMRefreshRandomTask(inputStr, false)
end, true, "任务id")
helper.RegisterToggle("GM Tools", "开关灯光", function(isShow)
  return debugActions.isLightOpen
end, function(isShow)
  debugActions.changeLightObjShow("Light", isShow)
  debugActions.isLightOpen = isShow
end)
helper.RegisterToggle("GM Tools", "开关模型", function(isShow)
  return debugActions.isModelOpen
end, function(isShow)
  debugActions.changeModelObjShow("Model", isShow)
  debugActions.isModelOpen = isShow
end)
helper.RegisterToggle("GM Tools", "开关特效", function(isShow)
  return debugActions.isEffectOpen
end, function(isShow)
  debugActions.changeEffectObjShow("Effect", isShow)
  debugActions.isEffectOpen = isShow
end)
helper.RegisterToggle("GM Tools", "开关水印和Fps", function(isShow)
  return C_PlayerPrefsUtility.GetBool("IsOpenWaterMarkOrFPS")
end, function(isShow)
  local goRoot = C_GameObject.Find("[UI Root]")
  local _rootTrans = goRoot.transform
  local visiableWaterMark = _rootTrans:Find("[VisiableWaterMark]")
  local waterMark = _rootTrans:Find("[WaterMark]")
  local pageFps = _rootTrans:Find("pageFps")
  if visiableWaterMark then
    visiableWaterMark.gameObject:SetActive(not isShow)
  end
  if waterMark then
    waterMark.gameObject:SetActive(not isShow)
  end
  if pageFps then
    pageFps.gameObject:SetActive(not isShow)
  end
  C_PlayerPrefsUtility.SetBool("IsOpenWaterMarkOrFPS", isShow)
end)
helper.RegisterToggle("GM Tools", "新手引导", function(isShow)
  if not G_Launcher.gameplayRequired then
    return false
  end
  local tempGuideState = L_GuideManager:getGmGuideState()
  if tempGuideState ~= nil then
    return tempGuideState
  end
  return L_GuideManager:canStartGuide()
end, function(isShow)
  local canStartGuide = L_GuideManager:canStartGuide()
  L_GuideManager:setGmGuideState(not canStartGuide)
  L_GuideManager:setGuideActive(not canStartGuide)
end)
helper.RegisterToggle("GM Tools", "控制所有UI显示隐藏", function(isShow)
  return debugActions.isUIOpen
end, function(isShow)
  debugActions.isUIOpen = isShow
  L_UI:controlUIRootShowState(debugActions.isUIOpen)
  if not isShow then
    helper.SetTouchToggleActive(false)
  elseif IS_DEV_BUILD then
    helper.SetTouchToggleActive(Unity.Application.isEditor or Unity.Application.IsMobilePlatformForUI)
  end
  C_BattleUIManager.GMSetUIShowState(debugActions.isUIOpen)
end)
helper.RegisterToggle("GM Tools", "控制伤害跳字显示隐藏", function(isShow)
  return debugActions.isDamageText
end, function(isShow)
  debugActions.isDamageText = isShow
  C_BattleUIManager.SetDamageTextState(debugActions.isDamageText)
end)
helper.RegisterInput("GM Tools", "调试新手引导", function(inputStr)
  L_GuideManager:debugGuide(tonumber(inputStr))
end, true, "")
helper.RegisterInput("GM Tools", "调试新手引导配置条件", function(inputStr)
  local inputDatas = string.split(inputStr, "|")
  if #inputDatas ~= 2 then
    return
  end
  L_GuideManager:debugGuideCondition(tonumber(inputDatas[1]), inputDatas[2])
end, true, "")
helper.RegisterInput("GM Tools", "调试奇波对战", function(inputStr)
  local params = string.split(inputStr, " ")
  if params[1] then
    if tonumber(params[1]) == L_PetConst.PetDuelFormationType.pvpMatch then
      L_UI:open("pagePetDuelMain", {
        mode = tonumber(params[1]),
        gameMode = tonumber(params[2])
      })
    elseif tonumber(params[1]) == L_PetConst.PetDuelFormationType.pvpInvite then
      L_UI:open("pagePetDuelMain", {
        mode = tonumber(params[1]),
        playerId = tonumber(params[2])
      })
    elseif tonumber(params[1]) == L_PetConst.PetDuelFormationType.Normal then
      L_UI:open("pagePetDuelMain", {
        levelId = tonumber(params[2])
      })
    end
  end
end, true, "")
helper.RegisterInput("GM Tools", "屏蔽玩家聊天", function(inputStr)
  L_FriendStore:req_blockPlayerChat(tonumber(inputStr))
end, true, "")
helper.RegisterInput("GM Tools", "解除屏蔽玩家聊天", function(inputStr)
  L_FriendStore:req_unblockPlayerChat(tonumber(inputStr))
end, true, "")
helper.RegisterInput("GM Tools", "调试奇波对战切换模式", function(inputStr)
  L_PetDuelStore:changePetDuelMode()
end, true, "")
helper.RegisterInput("GM Tools", "调试奇波对战切换地图", function(inputStr)
  L_PetDuelStore:SyncChangePetDuelMap(tonumber(inputStr))
end, true, "")
helper.RegisterButton("GM Tools", "打开委托商店界面", function()
  local entrustShopId = L_GameConstTpl:getData("DUNGEON_SHOPGROUPID", L_Const.GameTplType.int)
  L_UI:open("pageShop", {shopId = entrustShopId, isEntrustShop = true})
end)
helper.RegisterInput("GM Tools", "调试巢穴主界面", function(inputStr)
  local params = string.split(inputStr, " ")
  if C_MultiTeamMgr:GetIsPlayerInNestTeam() then
    L_UI:open("pageNestTeam")
  elseif params[2] ~= nil then
    C_MultiTeamMgr:ReqCreateNestTeam(tonumber(params[1]), tonumber(params[2]))
  else
    C_MultiTeamMgr:ReqCreateNestTeam(tonumber(params[1]), 1)
  end
end, true, "")
helper.RegisterInput("GM Tools", "打开itemTip", function(inputStr)
  local params = string.split(inputStr, " ")
  L_UI:open("pageInfoTip", {
    itemType = tonumber(params[1]),
    itemId = tonumber(params[2])
  })
end, true, "")
helper.RegisterInput("GM Tools", "解散队伍", function()
  C_MultiTeamMgr:ReqExitTeam(true)
end, true, "")
helper.RegisterInput("GM Tools", "调试巢穴设置界面", function()
  L_UI:open("pageNestTeamSetting")
end, true, "")
helper.RegisterInput("GM Tools", "打开月卡领取界面", function()
  local time = C_DeviceGradeHelper.IsLowMemoryDevice() and L_WordsTpl:getValue("residual_code_pagefps_02") or ""
  print("currentTime: " .. tostring(L_TimeUtil.getDisplayTime()) .. " " .. tostring(time))
  L_UI:open("pageMonthCardDailyReward")
end, true, "")
helper.RegisterInput("GM Tools", "打开月卡buff界面", function()
  L_UI:open("pageMonthCardBuff")
end, true, "")
helper.RegisterInput("GM Tools", "打开月卡测试界面", function()
  L_UI:open("pageMonthCardShopTest")
end, true, "")
helper.RegisterInput("GM Tools", "购买月卡", function(inputStr)
  C_MonthCardStore.ActiveMonthCard(tonumber(inputStr))
end, true, "")
helper.RegisterInput("GM Tools", "请求月卡奖励", function()
  C_MonthCardStore.ReqGetMonthCardReward()
end, true, "")
helper.RegisterInput("GM Tools", "打开商城界面", function()
  L_UI:open("PageShopUI")
end, true, "")
helper.RegisterInput("GM Tools", "测试巢穴商店", function()
  L_UI:open("pageNestcoopShop", {shopId = 801})
end, true)
helper.RegisterInput("GM Tools", "测试巢穴奖励界面", function(inputStr)
  L_UI:open("pageNestCoopRewardPreview", {
    nestCoopLevelId = tonumber(inputStr)
  })
end, true, "")
helper.RegisterInput("GM Tools", "书籍左插弹窗激活", function(inputStr)
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.libraryBook, tonumber(inputStr))
end, true, "")
helper.RegisterInput("GM Tools", "调试奇波对战训练关卡", function(inputStr)
  local levelId = tonumber(inputStr)
  L_PetDuelStore:setCurChallengeLevelId(levelId)
  C_KiBoDuelLuaWrapper.SetCurrentLevel(levelId)
  L_PetDuelStore:req_CSProtoKiboDuelStart(levelId)
end, true, "")
helper.RegisterInput("GM Tools", "调试获得英雄", function(inputStr)
  L_UI:open("pageGetHero", {
    configId = tonumber(inputStr)
  })
end, true, "")
helper.RegisterInput("GM Tools", "检查引导状态", function(inputStr)
  if string.isEmpty(inputStr) then
    return
  end
  local guidId = tonumber(inputStr)
  if L_GuideManager:isGuideOnRunning(guidId) then
    L_FlyMsgManager:showNormalMsg(inputStr .. L_WordsTpl:getValue("notice_guide"))
    return
  end
  if L_GuideStore:isGuideComplete(guidId) then
    L_FlyMsgManager:showNormalMsg(inputStr .. L_WordsTpl:getValue("notice_finished"))
    return
  end
  L_FlyMsgManager:showNormalMsg(inputStr .. L_WordsTpl:getValue("notice_notrigger"))
end, true, "")
helper.RegisterButton("GM Tools", "模拟数据更新回到初始UI", function(inputStr)
  L_GuideManager:stopAllGuide()
  L_UI:backToRoot()
  L_GuideManager:restartAllGuide()
end, true, "")
helper.RegisterButton("GM Tools", "时间循环", function()
  L_UI:open("pageTimeLoop")
end, true, "时间循环")
helper.RegisterInput("GM Tools", "打开指定UI界面", function(inputStr)
  L_UI:open(inputStr)
end, true, "输入UI界面名称")
helper.RegisterButton("GM Tools", "打开称号界面", function()
  L_UI:open("pagePlayerTitle")
end, true, "打开称号界面")
helper.RegisterButton("GM Tools", "打开设置界面", function()
  L_UI:open("pageOption")
end, true, "打开设置界面")
helper.RegisterButton("GM Tools", "开启/关闭编队HUD调试", function()
  L_FormationManager._isGm = not L_FormationManager._isGm
end, true)
helper.RegisterInput("GM Tools", "修改断线检测时间", function(inputStr)
  local time = tonumber(inputStr)
  if 0 < time then
    local maskPlugin = CS.Azur.Gameplay.Core.Net.NetManager.GetPlugin(C_NetChannel.Main, CS.Azur.Gameplay.Core.Net.ENetPluginType.MsgMask)
    maskPlugin.MaskTimeLimit = time
    local heartPlugin = CS.Azur.Gameplay.Core.Net.NetManager.GetPlugin(C_NetChannel.Main, CS.Azur.Gameplay.Core.Net.ENetPluginType.Heart)
    heartPlugin.HeartReceiveLimit = time
  end
end, true, "断线检测时间")
helper.RegisterInput("GM Tools", "测试长重连", function(inputStr)
  local params = string.split(inputStr, " ")
  local time = tonumber(params[1])
  local showMask = params[2] == nil or tonumber(params[2]) ~= 0
  local channel = CS.Azur.Gameplay.Core.Net.NetManager.GetChannel(C_NetChannel.Main)
  channel:GM_NetReconnect(true, time, showMask)
end, true, "重连延迟毫秒数")
helper.RegisterInput("GM Tools", "测试短重连", function(inputStr)
  local params = string.split(inputStr, " ")
  local time = tonumber(params[1])
  local showMask = params[2] == nil or tonumber(params[2]) ~= 0
  local channel = CS.Azur.Gameplay.Core.Net.NetManager.GetChannel(C_NetChannel.Main)
  channel:GM_NetReconnect(false, time, showMask)
end, true, "重连延迟毫秒数")
helper.RegisterButton("GM Tools", "开启心跳重连", function(inputStr)
  L_Net.heartReconnect = true
end, true)
helper.RegisterButton("GM Tools", "关闭心跳重连", function(inputStr)
  L_Net.heartReconnect = false
end, true)
helper.RegisterInput("GM Tools", "开启协议录制端口[不填默认3680]", function(inputStr)
  local port = tonumber(inputStr) or 3680
  local channel = CS.Azur.Gameplay.Core.Net.NetManager.GetChannel(C_NetChannel.Main)
  channel:GM_StartReplayServer(port)
end, true)
helper.RegisterButton("GM Tools", "测试通用组队平台界面", function()
  L_UI:open("pageMultiTeamHub")
end, true)
helper.RegisterInput("GM Tools", "固定UI转场 参数:转场类型", function(inputStr)
  CS.Lens.Gameplay.UI.pageCommonCutIn.gmCutinType = tonumber(inputStr) or 0
end)
helper.RegisterButton("常用GM指令", "测试网关公告", function()
  C_LoginManager.GetAnnouncementOnLogin(function(data, code)
    C_AnnouncementStore:SyncAnnouncementResponeDataInfoOfGateway(data, code)
  end)
end, true)
helper.RegisterButton("常用GM指令", "测试小玉Web", function()
  local webViewManager = CS.Lens.Gameplay.UI.WebView.WebViewManager()
  webViewManager:OpenWebGame(CS.Lens.Gameplay.UI.WebView.WebViewManager.WebGameType.Xiaoyu)
end, true)
helper.RegisterButton("常用GM指令", "测试Web默认内存占用", function()
  local webViewManager = CS.Lens.Gameplay.UI.WebView.WebViewManager()
  webViewManager:OpenWebGame(CS.Lens.Gameplay.UI.WebView.WebViewManager.WebGameType.Empty)
end, true)
helper.RegisterButton("常用GM指令", "Web打开跑分网站", function()
  local webViewManager = CS.Lens.Gameplay.UI.WebView.WebViewManager()
  webViewManager:OpenWebGame(CS.Lens.Gameplay.UI.WebView.WebViewManager.WebGameType.WebScore)
end, true)
helper.RegisterButton("常用GM指令", "Web开启远程调试", function()
  CS.Lens.Gameplay.UI.WebView.WebViewManager.EnableRemoteDebugging()
end, true)
helper.RegisterInput("常用GM指令", "打开Web指定网站", function(inputStr)
  local webViewManager = CS.Lens.Gameplay.UI.WebView.WebViewManager()
  webViewManager:OpenWebGameByUrl(inputStr)
end, true, "打开Web指定网站")
helper.RegisterButton("常用GM指令", "解锁所有系统", function()
  local msg = {
    command = "SYSALLUNLOCK",
    args = {"1"}
  }
  AzurWorld.IntegrateMgr.SystemUnlockModule:SetSkipUnlockTips()
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterInput("常用GM指令", "打开地图特效", function(inputStr)
  local id = tonumber(inputStr)
  C_MapManager:setMapEffectVisible(id, true)
end, true, "打开地图特效")
helper.RegisterInput("常用GM指令", "关闭地图特效", function(inputStr)
  local id = tonumber(inputStr)
  C_MapManager:setMapEffectVisible(id, false)
end, true, "关闭地图特效")
helper.RegisterButton("常用GM指令", "解锁奇波对战委托", function()
  local msg = {
    command = "CompleteAllKiboDuel",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "一键完成所有引导任务", function()
  local msg = {
    command = "DEEPFINISHALLGUIDETASK",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "添加所有角色", function()
  local msg = {
    command = "SUPERCMD",
    args = {"1"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  debugActions.SendGMCommand("ADDITEM 1 111001 1 1")
end, true)
helper.RegisterButton("常用GM指令", "添加所有角色皮肤", function()
  local _heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  for k, v in pairs(_heroClothingTpl.data) do
    local heroId = _heroClothingTpl:getHero(v)
    if k ~= heroId and v.isUnlock then
      debugActions.SendGMCommand(string.format("ADDITEM 39 %d 1", k))
    end
  end
end, true)
helper.RegisterButton("常用GM指令", "添加所有武器", function()
  local msg = {
    command = "SUPERCMD",
    args = {"2"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "一键三星通关所有委托任务", function()
  for i = 3580, 3910, 10 do
    local msg = {
      command = "deend",
      args = {
        tostring(i),
        "7"
      }
    }
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  end
end, true)
helper.RegisterInput("常用GM指令", "动态开关BRG", function(enableStr)
  local C_BRGProvider = CS.Azur.Gameplay.World.BRG.BRGProvider
  C_BRGProvider.SetBRGEnable(tonumber(enableStr) == 1)
end, true, "输入1 开启，0 关闭")
helper.RegisterInput("GM Tools", "设置当前挑战得委托id", function(inputStr)
  L_EntrustStore:setCurChallengeEntrustId(tonumber(inputStr))
end, true, "输入UI界面名称")
helper.RegisterInput("GM Tools", "减少体力", function(inputStr)
  local msg = {
    command = "subStamina",
    args = {
      tostring(inputStr)
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true, "减少体力")
helper.RegisterButton("常用GM指令", "添加所有灵子以及相关道具", function()
  local msg = {
    command = "SUPERCMD",
    args = {"9"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  debugActions.SendGMCommand("ADDITEM 10 2 798000")
  debugActions.SendGMCommand("ADDITEM 10 10 1005")
  local total = {}
  local soulessenceRankTpl = L_GameTpl:getSoulessenceRankTpl()
  local tpl = soulessenceRankTpl:getTplList()
  for k, v in pairs(tpl) do
    for i, j in pairs(v) do
      for m, n in pairs(j.rankUpItem) do
        if not total[n[1]] then
          total[n[1]] = n[2]
        else
          total[n[1]] = total[n[1]] + n[2]
        end
      end
    end
  end
  local newTotal = {}
  for k, v in pairs(total) do
    table.insert(newTotal, {k, v})
  end
  for i = 1, #newTotal do
    local item = newTotal[i]
    local id = item[1]
    local num = item[2]
    Timer.once(i * 0.2, function()
      debugActions.SendGMCommand("ADDITEM 3 " .. tostring(item[1]) .. " " .. tostring(item[2]))
    end)
  end
end, true)
helper.RegisterButton("常用GM指令", "添加所有鞍具", function()
  local msg = {
    command = "SUPERCMD",
    args = {"25"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "添加所有道具", function()
  local msg = {
    command = "SUPERCMD",
    args = {"5"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterInput("常用GM指令", "获得指定道具", function(input)
  local msg_items = {
    cmds = {}
  }
  local param = string.split(input, " ")
  local args = {
    "3",
    param[1],
    param[2]
  }
  local cmd = {command = "ADDITEM", args = args}
  table.insert(msg_items.cmds, cmd)
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_items, nil)
end, true)
helper.RegisterButton("常用GM指令", "添加所有任务道具", function()
  local msg = {
    command = "SUPERCMD",
    args = {"20"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "添加所有宠物蛋", function()
  local msg = {
    command = "SUPERCMD",
    args = {"6"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "一键添加所有开发用宠物", function()
  local msg = {
    command = "SUPERCMD",
    args = {"7"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "添加所有可用宠物", function()
  local msg = {
    command = "SUPERCMD",
    args = {"8"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "添加所有坐骑", function()
  local msg = {
    command = "SUPERCMD",
    args = {"12"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "添加所有装备", function()
  local msg = {
    command = "SUPERCMD",
    args = {"15"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "添加所有称号", function()
  local msg = {
    command = "SUPERCMD",
    args = {"17"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "帕米速递专用跨天", function()
  local msg = {
    command = "CROSSDAY",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "金币+999999", function()
  local msg = {
    command = "ADDITEM",
    args = {
      "10",
      "2",
      "999999"
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "钻石+999999", function()
  local msg = {
    command = "ADDITEM",
    args = {
      "10",
      "1",
      "999999"
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "自然点数+999999", function()
  local msg = {
    command = "ADDITEM",
    args = {
      "10",
      "101",
      "999999"
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "玩家经验+999999", function()
  local msg = {
    command = "ADDITEM",
    args = {
      "10",
      "10",
      "999999"
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterInput("常用GM指令", "玩家经验+n", function(inputStr)
  local msg = {
    command = "ADDITEM",
    args = {
      "10",
      "10",
      inputStr
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true, "")
helper.RegisterButton("常用GM指令", "宠物蛋+1", function()
  local msg = {
    command = "ADDITEM",
    args = {
      "14",
      "500001",
      "1"
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "宠物+1", function()
  local msg = {
    command = "ADDITEM",
    args = {
      "5",
      "500001",
      "1"
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "删除所有装备", function()
  local msg = {
    command = "CLEANBAG",
    args = {"15"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "删除所有灵子", function()
  local msg = {
    command = "CLEANBAG",
    args = {"9"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "删除所有普通道具", function()
  local msg = {
    command = "CLEANBAG",
    args = {"3"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "解锁所有副本", function()
  local msg = {
    command = "UNLOCKDUNGEON",
    args = {"0", "0"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "重置钓鱼点", function()
  local msg = {
    command = "FISHPOND",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "快速增加诺诺100好感 ", function()
  local msg = {
    command = "ADDHEROFAVOREXP",
    args = {199003, 100}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterInput("常用GM指令", "增加角色好感 [heroId] [count]", function(inputStr)
  local msg = {
    command = "ADDHEROFAVOREXP",
    args = string.split(inputStr, " ")
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true, "角色id / 增加的数量")
helper.RegisterInput("常用GM指令", "增加星愈力 [count]", function(inputStr)
  local msg = {
    command = "CHARGEADD",
    args = string.split(inputStr, " ")
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true, "增加多少星愈力")
helper.RegisterInput("常用GM指令", "减少星愈力 [count]", function(inputStr)
  local msg = {
    command = "CHARGEREDUCE",
    args = string.split(inputStr, " ")
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true, "减少多少星愈力")
helper.RegisterButton("常用GM指令", "清空星愈力", function()
  local msg = {
    command = "CHARGECLEAR",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "一键发邮件", function()
  local msg = {
    command = "AllMAIL",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "一键删除所有邮件", function()
  local msg = {
    command = "DelAllMAIL",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  L_MailStore.data.mailData = {}
end, true)
helper.RegisterButton("常用GM指令", "解锁所有传送点", function()
  local msg = {
    command = "UNLOCKPOS",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "解锁世界地图所有区域", function()
  local mapStore = C_MapManager:GetMapStore()
  if mapStore then
    mapStore:setUnlockAllArea()
  end
end, true)
helper.RegisterButton("PV录制相关GM指令", "一键增加PV需求角色宠物坐骑", function()
  local count = 1
  Timer.once(count * 0.1, function()
    local heroList = {
      109001,
      109002,
      199003,
      107001,
      108001,
      111001,
      104001,
      101004,
      108002,
      108003,
      101006
    }
    local msg_hero = {
      cmds = {}
    }
    for i = 1, #heroList do
      local heroId = heroList[i]
      local cmd = {
        command = "ADDITEM",
        args = {
          "1",
          tostring(heroId),
          "1",
          "1"
        }
      }
      table.insert(msg_hero.cmds, cmd)
    end
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_hero, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local petList = {
      500001,
      500004,
      500007,
      500022,
      500024,
      500025,
      500026,
      500035
    }
    local msg_pet = {
      cmds = {}
    }
    for i = 1, #petList do
      local petId = petList[i]
      local cmd = {
        command = "ADDITEM",
        args = {
          "5",
          tostring(petId),
          "1"
        }
      }
      table.insert(msg_pet.cmds, cmd)
    end
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_pet, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local homebuildingList = {
      10011,
      10012,
      40011,
      20021,
      20041
    }
    local msg_homebuilding = {
      cmds = {}
    }
    for i = 1, #homebuildingList do
      local homebuildingId = homebuildingList[i]
      local args = {
        "13",
        tostring(homebuildingId),
        "1"
      }
      if homebuildingId == 20041 then
        args = {
          "13",
          tostring(homebuildingId),
          "20"
        }
      end
      local cmd = {command = "ADDITEM", args = args}
      table.insert(msg_homebuilding.cmds, cmd)
    end
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_homebuilding, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local homeItemList = {
      310001,
      310002,
      310004,
      310006,
      300001,
      301002,
      350000,
      350001,
      310003,
      310005,
      304003
    }
    local msg_homeItem = {
      cmds = {}
    }
    for i = 1, #homeItemList do
      local homeItemId = homeItemList[i]
      local args = {
        "3",
        tostring(homeItemId),
        "10"
      }
      if homeItemId == 310003 or homeItemId == 310005 then
        args = {
          "3",
          tostring(homeItemId),
          "999"
        }
      end
      local cmd = {command = "ADDITEM", args = args}
      table.insert(msg_homeItem.cmds, cmd)
    end
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_homeItem, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local msg = {
      command = "SUPERCMD",
      args = {"12"}
    }
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local msg = {
      command = "HEROSTARAll",
      args = {"3"}
    }
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  end)
end, true)
helper.RegisterButton("常用GM指令", "服务器自测接口0", function()
  local msg = {
    obj_ids = {920160123},
    obj_keys = {
      {obj_id = 920160123, obj_index = 0}
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoFightStart, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "服务器自测接口1", function()
end, true)
helper.RegisterButton("常用GM指令", "服务器自测接口2", function()
end, true)
helper.RegisterButton("常用GM指令", "服务器自测接口3", function()
end, true)
helper.RegisterButton("常用GM指令", "大世界重置血量", function()
  local msg = {
    command = "WORLD",
    args = {"HP"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("常用GM指令", "大世界重置物件", function()
  local msg = {
    command = "WORLD",
    args = {"ALLOBJ"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, {
    command = "CLEANALLPLAY",
    args = {}
  }, nil)
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, function()
    local mapId = AzurWorld.Instance.CurWorldId
    local suc, pos = CS.Azur.Gameplay.Table.TDWorldBorthposTable.QueryAOIPos(mapId)
    AzurWorld.AOI:OnSceneEnter(mapId, pos)
    AzurWorld.service.map:PrepareWorldMapData(mapId)
    AzurWorld.WorldMapMgr:ClearUnits()
    AzurWorld.WorldMapMgr:InitWorldMapUnits()
  end)
end, true)
helper.RegisterButton("常用GM指令", "切换幽灵模式（空格向上 ctrl向下）", function()
  local playerEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if playerEntity then
    if playerEntity.state:GetCurrentStateType() == C_EFsmStateType.Ghost then
      playerEntity.state:SetTrigger("Entry")
    else
      playerEntity.state:SetTrigger("Ghost")
    end
  end
end, true)
helper.RegisterInput("常用GM指令", "设置幽灵模式速度", function(inputStr)
  local playerEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if playerEntity then
    local speed = tonumber(inputStr)
    playerEntity.data.characterControlProperty.maxFlySpeed = speed
  end
end, true, "速度")
helper.RegisterButton("常用GM指令", "切换飞行模式", function()
  AzurWorld.mountMgr:ReqChangeMountStatus(C_WorldMapPlayerMountStatusType.WmpmstFly)
end, true)
helper.RegisterButton("常用GM指令", "切换采集轮廓", function()
  L_PlayerManager:switchCollectGizmos()
end, true)
helper.RegisterButton("常用GM指令", "清除钓鱼事件", function()
  local msg = {
    command = "FISHEVENTCLEAN",
    args = {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterInput("常用GM指令", "巡逻组移动", function(inputStr)
  local arr = string.split(inputStr, " ")
  if #arr < 2 then
    error("参数格式不对: groupId pathId [patrolType=3]")
    return
  end
  local groupId = tonumber(arr[1])
  local pathId = tonumber(arr[2])
  local patrolType = 3
  if 3 <= #arr then
    patrolType = tonumber(arr[3])
  end
  local C_GroupMoveManager = CS.Lens.Gameplay.Modules.BigWorld.GroupMoveManager
  C_GroupMoveManager.StartGroupMove(groupId, pathId, patrolType)
end, true, "参数 groupId pathId [patrolType=3]")
helper.RegisterInput("GM Tools", "打开说明界面", function(input)
  local groupId = tonumber(input)
  local pages = L_GameTpl:getIntroductionTpl():getPages(groupId)
  if table.count(pages) > 0 then
    L_UI:open("pageCommonIntroduction", {groupId = groupId})
  end
end, true, "填入groupId")
helper.RegisterButton("GM Tools", "剧情对话预览", function()
  L_UI:open("pageDialoguePreview")
end)
helper.RegisterButton("GM Tools", "显示HierarchyInspector（Game视图）", function()
  L_UI:open("runtimeHierarchyInspector")
end)
helper.RegisterInput("GM Tools", "开启RuntimeInspector（Web端）", function(input)
  debugActions.startWebRuntimeInspector(tonumber(input))
end, true, "留空使用默认，或输入你想指定的端口号")
helper.RegisterButton("GM Tools", "关闭RuntimeInspector（Web端）", function()
  debugActions.stopWebRuntimeInspector()
end)
helper.RegisterButton("GM Tools", "开启奇波获取界面调试", function()
  L_PetStore._isGm = true
end, true)
helper.RegisterInput("GM Tools", "字体额外加粗调试", function(input)
  CS.Lens.Framework.UI.LTMPStyle.extraDilate = tonumber(input)
  CS.Lens.Framework.UI.LTMPStyle.ClearCache()
end, true, "字体额外加粗调试")
helper.RegisterButton("音效", "Start Wwise Profiler", function()
  C_AudioManager.StartProfilerCapture()
end)
helper.RegisterButton("音效", "Stop Wwise Profiler", function()
  C_AudioManager.StopProfilerCapture()
end)
helper.RegisterInput("GM Tools", "更改语言", function(inputStr)
  debugActions.setLanguage_debug(inputStr)
end, true, "切换文本语言 - 输入语言代号: en|jp|kr|chs|cht")
helper.RegisterButton("GM Tools", "输出所有内存中的音效", function()
end)
helper.RegisterButton("GM Tools", "打开UWA测试面板", function()
  C_UwaLauncher.OpenUI()
end, true, "UWA不支持自己控制界面的显示隐藏")
helper.RegisterButton("GM Tools", "回到当前第一个UI", function()
  L_UI:backToRoot()
end, true, "用来测试强制回到第一个UI")
helper.RegisterButton("GM Tools", "回到登录界面", function()
  L_WorldManager:dispose()
  C_LoginManager.LogoutAccount()
end, true, "用来测试强制回登录界面")
helper.RegisterToggle("GM Tools", "开启/隐藏UI界面", function()
  return debugActions.getUIVisible()
end, function(isOn)
  debugActions.setUIVisible(isOn)
end, false, "通过修改UI相机的CullingMask来控制显示/隐藏UI界面")
helper.RegisterInput("GM Tools", "执行Lua代码", function(inputStr)
  debugActions.exeLuaScriptString(inputStr)
end, true, "输入要执行的lua代码")
helper.RegisterInput("GM Tools", "追踪地图对象", function(inputStr)
  local worldMapTpl = L_GameTpl:getWorldMapTpl()
  local sceneId = AzurWorldInstance.CurWorldId
  local areaId = AzurWorld.areaManager:GetMapAreaId()
  local tpl = worldMapTpl:getTplById(sceneId, tonumber(inputStr))
  if tpl then
    worldAdapter.CreateMapMark(areaId, worldMapTpl:getPosition(tpl))
  else
    error("找不到地图对象" .. areaId .. "-" .. sceneId .. "-" .. tonumber(inputStr))
  end
end, true, "输入要追踪的worldObjId")
helper.RegisterInput("GM Tools", "连接代码调试工具", function(inputStr)
  CS.Lens.Framework.Tools.DebugNet.DebuggerNetManager.Connect(inputStr, 1024, function()
    L_FlyMsgManager:showNormalMsg("连接成功")
  end, function()
    L_FlyMsgManager:showNormalMsg("连接失败")
  end)
end, true, "输入要连接的ip")
helper.RegisterButton("性能调试", "ParticleSystem数量统计", function()
  local allPsArray = C_UnityObject.FindObjectsOfType(typeof(Unity.ParticleSystem), true)
  errorf("ParticleSystem Count: " .. tostring(allPsArray.Length))
end, true, "包含Inactive")
helper.RegisterButton("性能调试", "关掉所有UI", function()
  L_UIManager:closeAllPages()
  L_FlyMsgManager:dispose()
end, true, "清理所有UI资源无论是否打开")
helper.RegisterButton("家园相关", "一键耕地(需将当前地块建筑清空)", function()
  AzurWorld.HomeMgr:FastPlowForGm()
end, true)
helper.RegisterInput("家园相关", "一键播种(传入种子id)", function(str)
  local seedId = tonumber(str)
  if not seedId then
    return
  end
  AzurWorld.HomeMgr:FastPlantForGm(seedId)
end, true)
helper.RegisterButton("家园相关", "一键成熟", function()
  local msg = {
    command = "HOMEHARVEST"
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg)
end, true)
helper.RegisterButton("家园相关", "一键添加指定建筑", function()
  local msg = {
    command = "SUPERCMD",
    args = {"13"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterInput("家园相关", "解锁科技", function(inputStr)
  debugActions.SendGMCommand("UnlockTech " .. tostring(inputStr))
end, true, "填1是工业  2是农业  3是采集业  4是畜牧业")
helper.RegisterInput("家园相关", "清空已解锁科技", function(inputStr)
  debugActions.SendGMCommand("LockTech " .. tostring(inputStr))
end, true, "填1是工业  2是农业  3是采集业  4是畜牧业")
helper.RegisterInput("家园相关", "设置科技等级", function(inputStr)
  local techTotal = string.split(inputStr, " ")
  local techType = tonumber(techTotal[1])
  local techLv = tonumber(techTotal[2])
  debugActions.SendGMCommand("SetTechLv " .. tostring(techType) .. " " .. tostring(techLv))
end, true, "参数1: 1是工业  2是农业  3是采集业  4是畜牧业 参数2：具体等级")
helper.RegisterInput("家园相关", "加科技经验", function(inputStr)
  local techTotal = string.split(inputStr, " ")
  local techType = tonumber(techTotal[1])
  local techExp = tonumber(techTotal[2])
  debugActions.SendGMCommand("AddTechExp " .. tostring(techType) .. " " .. tostring(techExp))
end, true, "参数1: 1是工业  2是农业  3是采集业  4是畜牧业 参数2：具体经验值")
helper.RegisterInput("家园相关", "加科技碎片", function(inputStr)
  local techTotal = string.split(inputStr, " ")
  local techType = tonumber(techTotal[1])
  local techExp = tonumber(techTotal[2])
  debugActions.SendGMCommand("AddTechPoint " .. tostring(techType) .. " " .. tostring(techExp))
end, true, "参数1: 1是工业  2是农业  3是采集业  4是畜牧业 参数2：具体碎片值")
helper.RegisterInput("家园相关", "设置宠物饱腹值", function(inputStr)
  local param = string.split(inputStr, " ")
  local petGuid = tonumber(param[1])
  local petSatiety = tonumber(param[2])
  debugActions.SendGMCommand("SETPETSATIETY " .. petGuid .. " " .. petSatiety)
end, true, "参数1:宠物guid 参数2：饱腹值")
helper.RegisterButton("家园相关", "完成解锁科技任务", function()
  local msg = {
    command = "ADDTASK",
    args = {"99010004"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  local msg = {
    command = "TASKFINISH",
    args = {"99010004"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterInput("家园相关", "景观树经验等级", function(inputStr)
  local strList = string.split(inputStr, " ")
  local command = "ResetTree"
  if strList[1] ~= nil then
    command = command .. " " .. tostring(strList[1])
  end
  if strList[2] ~= nil then
    command = command .. " " .. tostring(strList[2])
  else
    command = command .. " 1"
  end
  debugActions.SendGMCommand(command)
end, true, "参数1：进度 参数2：isNew 标记 (1true 0 false)")
helper.RegisterButton("家园相关", "开启AOI面板", function()
  AzurWorld.HomeMgr.GroupAOIModule:OnOpenHomeAOIPanel()
end, true)
helper.RegisterToggle("家园相关", "设置家园最低限度奇波", function()
  return AzurWorld.HomeMgr.PetModule.IsPetNecessaryModel
end, function(isOn)
  AzurWorld.HomeMgr.PetModule:OnSetPetNecessaryModel(isOn)
end, false, "通过修改家园只显示和产出相关的奇波")
helper.RegisterInput("家园相关", "测试家园等级（本地版）", function(str)
  local homeLv = tonumber(str)
  if not homeLv then
    return
  end
  AzurWorld.HomeMgr:OnSetHomeLevel(homeLv)
end, true)
helper.RegisterButton("家园相关", "去除所有奇波", function()
  AzurWorld.HomeMgr.PetModule:OnRemoveAllHomePet()
end, true)
helper.RegisterButton("家园相关", "删除AOI范围外奇波", function()
  AzurWorld.HomeMgr.PetModule:OnRemoveAllOutAOIHomePet()
end, true)
helper.RegisterButton("家园相关", "恢复所有奇波", function()
  AzurWorld.HomeMgr.PetModule:OnRecoverAllAOIHomePet()
end, true)
helper.RegisterInput("家园相关", "获得指定建筑", function(input)
  local msg_homebuilding = {
    cmds = {}
  }
  local args = {
    "13",
    input,
    "1"
  }
  local cmd = {command = "ADDITEM", args = args}
  table.insert(msg_homebuilding.cmds, cmd)
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_homebuilding, nil)
end, true)
helper.RegisterButton("性能测试GM", "所有角色+宠物+灵子+道具+装备+角色等级40级+家园建筑", function()
  local count = 1
  Timer.once(count * 0.1, function()
    local heroList = {
      109001,
      109002,
      199003,
      107001,
      108001,
      111001,
      104001,
      101004,
      108002,
      108003,
      101006,
      101004,
      101006,
      104001,
      101013,
      101014,
      101015,
      103001,
      101008
    }
    local msg_hero = {
      cmds = {}
    }
    for i = 1, #heroList do
      local heroId = heroList[i]
      local cmd = {
        command = "ADDITEM",
        args = {
          "1",
          tostring(heroId),
          "1",
          "1"
        }
      }
      table.insert(msg_hero.cmds, cmd)
    end
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_hero, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local petList = {
      500001,
      500004,
      500007,
      500022,
      500024,
      500025,
      500026,
      500035
    }
    local msg_pet = {
      cmds = {}
    }
    for i = 1, #petList do
      local petId = petList[i]
      local cmd = {
        command = "ADDITEM",
        args = {
          "5",
          tostring(petId),
          "1"
        }
      }
      table.insert(msg_pet.cmds, cmd)
    end
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_pet, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local homebuildingList = {
      10011,
      10012,
      40011,
      20021,
      20041,
      60011
    }
    local msg_homebuilding = {
      cmds = {}
    }
    for i = 1, #homebuildingList do
      local homebuildingId = homebuildingList[i]
      local args = {
        "13",
        tostring(homebuildingId),
        "1"
      }
      if homebuildingId == 20041 then
        args = {
          "13",
          tostring(homebuildingId),
          "20"
        }
      end
      local cmd = {command = "ADDITEM", args = args}
      table.insert(msg_homebuilding.cmds, cmd)
    end
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_homebuilding, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local homeItemList = {
      310001,
      310002,
      310004,
      310006,
      300001,
      301002,
      350000,
      350001,
      310003,
      310005,
      304003
    }
    local msg_homeItem = {
      cmds = {}
    }
    for i = 1, #homeItemList do
      local homeItemId = homeItemList[i]
      local args = {
        "3",
        tostring(homeItemId),
        "10"
      }
      if homeItemId == 310003 or homeItemId == 310005 then
        args = {
          "3",
          tostring(homeItemId),
          "999"
        }
      end
      local cmd = {command = "ADDITEM", args = args}
      table.insert(msg_homeItem.cmds, cmd)
    end
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommands, msg_homeItem, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local msg = {
      command = "SUPERCMD",
      args = {"12"}
    }
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    local msg = {
      command = "HEROSTARAll",
      args = {"3"}
    }
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  end)
  count = count + 1
  Timer.once(count * 0.1, function()
    debugActions.SendGMCommand("SETACLV 30")
  end)
  local msg = {
    command = "SUPERCMD",
    args = {"15"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  local msg = {
    command = "SUPERCMD",
    args = {"5"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  local msg = {
    command = "SUPERCMD",
    args = {"9"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  debugActions.SendGMCommand("ADDITEM 10 2 798000")
  debugActions.SendGMCommand("ADDITEM 10 10 1005")
  local itemsTotal = {
    604001,
    601001,
    600001,
    604002,
    604003,
    604004,
    604005,
    604006,
    601002,
    600002,
    604007,
    604008,
    604009,
    604010,
    604011,
    601003,
    600003,
    604012,
    604013,
    604014,
    604015,
    601004,
    600004,
    403000,
    403001,
    403002
  }
  for k, v in ipairs(itemsTotal) do
    Timer.once(k * 0.2, function()
      debugActions.SendGMCommand("ADDITEM 3 " .. tostring(v) .. " 500")
    end)
  end
end, true)
helper.RegisterInput("角色常用GM指令", "设置指定角色等级[heroid] [herolv]", function(input)
  debugActions.SendGMCommand("HEROLV " .. tostring(input))
end, true, "角色id  角色lv")
helper.RegisterInput("角色常用GM指令", "所有角色升到指定等级", function(input)
  debugActions.SendGMCommand("ALLHEROLV " .. tostring(input))
end, true, "如果要升到10级直接填10即可")
helper.RegisterInput("角色常用GM指令", "设置指定宠物等级[heroid] [herolv]", function(input)
  debugActions.SendGMCommand("PETLV " .. tostring(input))
end, true, "宠物id  宠物lv")
helper.RegisterInput("角色常用GM指令", "所有宠物升到指定等级", function(input)
  debugActions.SendGMCommand("ALLPETLV " .. tostring(input))
end, true, "如果要升到10级直接填10即可")
helper.RegisterButton("角色常用GM指令", "添加所有角色", function()
  local msg = {
    command = "SUPERCMD",
    args = {"1"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  debugActions.SendGMCommand("ADDITEM 1 111001 1 1")
end, true)
helper.RegisterButton("角色常用GM指令", "金币+100000", function()
  local msg = {
    command = "ADDITEM",
    args = {
      "10",
      "2",
      "100000"
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("角色常用GM指令", "只添加角色升级的材料*1000", function()
  local herolvItem = {}
  for v = 400000, 400003 do
    table.insert(herolvItem, v)
  end
  for k, v in ipairs(herolvItem) do
    Timer.once(k * 0.2, function()
      debugActions.SendGMCommand("ADDITEM 3 " .. tostring(v) .. " 1000")
    end)
  end
end, true)
helper.RegisterButton("角色常用GM指令", "添加所有的英雄灵子", function()
  local msg = {
    command = "SUPERCMD",
    args = {"9"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("角色常用GM指令", "只添加灵子升级的材料*1000", function()
  local spiritlvItem = {}
  for v = 403000, 403002 do
    table.insert(spiritlvItem, v)
  end
  for k, v in ipairs(spiritlvItem) do
    Timer.once(k * 0.2, function()
      debugActions.SendGMCommand("ADDITEM 3 " .. tostring(v) .. " 1000")
    end)
  end
end, true)
helper.RegisterButton("角色常用GM指令", "只添加灵子突破的材料*500", function()
  local spiritUpItem = {}
  for v = 600001, 600004 do
    table.insert(spiritUpItem, v)
  end
  for v = 601001, 601004 do
    table.insert(spiritUpItem, v)
  end
  for v = 604001, 604015 do
    table.insert(spiritUpItem, v)
  end
  for k, v in ipairs(spiritUpItem) do
    Timer.once(k * 0.2, function()
      debugActions.SendGMCommand("ADDITEM 3 " .. tostring(v) .. " 500")
    end)
  end
end, true)
helper.RegisterButton("角色常用GM指令", "星识等级升到10级", function()
  debugActions.SendGMCommand("SETACLV 10")
end, true)
helper.RegisterButton("角色常用GM指令", "星识等级升到20级", function()
  debugActions.SendGMCommand("SETACLV 20")
end, true)
helper.RegisterButton("角色常用GM指令", "星识等级升到30级", function()
  debugActions.SendGMCommand("SETACLV 30")
end, true)
helper.RegisterInput("角色常用GM指令", "设置星识等级[lv]", function(input)
  debugActions.SendGMCommand("SETACLV " .. tostring(input))
end, true, "星识lv")
helper.RegisterInput("角色常用GM指令", "增加角色好感 [heroId] [count]", function(inputStr)
  local msg = {
    command = "ADDHEROFAVOREXP",
    args = string.split(inputStr, " ")
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true, "角色id / 增加的数量")
helper.RegisterButton("角色常用GM指令", "打开FPS界面", function()
  L_UI:open("pageFps")
end, true)
helper.RegisterButton("角色常用GM指令", "一键增加商店相关货币", function()
  local moneyList = {
    502000,
    502001,
    100000
  }
  for k, v in ipairs(moneyList) do
    Timer.once(k * 0.1, function()
      debugActions.SendGMCommand("ADDITEM 3 " .. tostring(v) .. " 10000")
    end)
  end
  local currencyList = {
    1,
    2,
    901,
    102,
    416
  }
  for k, v in ipairs(currencyList) do
    Timer.once(k * 0.1, function()
      debugActions.SendGMCommand("ADDITEM 10 " .. tostring(v) .. " 10000")
    end)
  end
end, true)
helper.RegisterInput("角色常用GM指令", "设置所有装备等级[lv]", function(input)
  debugActions.SendGMCommand("SETALLOLV " .. tostring(input))
end, true, "装备LV,要设置5级直接填5")
helper.RegisterButton("角色常用GM指令", "解锁所有星脉活跃度等级", function()
  local worldDiffcultyTpl = L_GameTpl:getWorldDifficultyTpl()
  local tpl = worldDiffcultyTpl:getTplList()
  local new_tpl = {}
  local taskId_set = {}
  for k, v in pairs(tpl) do
    if not taskId_set[v.taskId] then
      taskId_set[v.taskId] = true
      table.insert(new_tpl, v.taskId)
    end
  end
  for k, v in pairs(new_tpl) do
    if v ~= 0 then
      local msg = {
        command = "ADDTASK",
        args = {
          tostring(v)
        }
      }
      L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
    end
  end
  for k, v in pairs(new_tpl) do
    local msg = {
      command = "TASKFINISH",
      args = {
        tostring(v)
      }
    }
    L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
  end
end, true)
helper.RegisterButton("角色常用GM指令", "解锁所有奇波对战关卡(简单模式&困难模式)", function()
  debugActions.SendGMCommand("UnlockAllKiboDuel")
end, true)
helper.RegisterButton("宠物常用GM指令", "添加所有可用宠物", function()
  local msg = {
    command = "SUPERCMD",
    args = {"8"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterButton("宠物常用GM指令", "添加所有宠物蛋", function()
  local msg = {
    command = "SUPERCMD",
    args = {"6"}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoGMCommand, msg, nil)
end, true)
helper.RegisterInput("宠物常用GM指令", "删除单个宠物蛋", function(input)
  local data = {
    egg_list = {
      [1] = input
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoDelEgg, data)
end, true, "输入宠物guid")
helper.RegisterButton("宠物常用GM指令", "删除所有宠物蛋", function()
  local total = L_PetStore:getAllPetEggGuid()
  for k, v in pairs(total) do
    Timer.once(k * 0.1, function()
      local data = {
        egg_list = {
          [1] = v
        }
      }
      L_Net:sendMessage(MsgGenCode.CSProtoDelEgg, data)
    end)
  end
end, true)
helper.RegisterInput("宠物常用GM指令", "修改宠物属性值", function(inputStr)
  local pettotal = string.split(inputStr, " ")
  local petguid = tonumber(pettotal[1])
  local petattrid = tonumber(pettotal[2])
  local petattr = tonumber(pettotal[3])
  debugActions.SendGMCommand("SETPETCOM " .. tostring(petguid) .. " " .. tostring(petattrid) .. " " .. tostring(petattr))
end, true, "输入宠物guid 宠物属性 属性值(pet_learningtalent.xlsx)")
helper.RegisterButton("宠物常用GM指令", "放生所有可放生的奇波", function()
  local petList = L_PetStore:getPetList()
  local petNewList = {}
  local petFinalList = {}
  for k, v in pairs(petList) do
    if v.work_status == 0 and v.hero_id == 0 and v.is_lock ~= true and v.canNotRelease ~= true and not petNewList[v.guid] then
      petNewList[v.guid] = v.id
    end
  end
  for k, v in pairs(petNewList) do
    local petTpl = L_GameTpl:getPetTpl()
    local tpl = petTpl:getTplById(v)
    local canRelease = petTpl:getIsRelease(tpl) and petTpl:getIsRename(tpl)
    if canRelease == true then
      table.insert(petFinalList, k)
    end
  end
  if 0 < #petFinalList then
    local data = {pet_list = petFinalList}
    L_Net:sendMessage(MsgGenCode.CSProtoDelPet, data)
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_quick_empty"))
    return
  end
end, true)
helper.RegisterInput("宠物常用GM指令", "增加某个宠物经验值", function(inputStr)
  local pettotal = string.split(inputStr, " ")
  local petguid = tonumber(pettotal[1])
  local petexp = tonumber(pettotal[2])
  debugActions.SendGMCommand("ADDPETEXP " .. tostring(petguid) .. " " .. tostring(petexp))
end, true, "输入宠物guid 宠物所需要增加的经验值")
helper.RegisterInput("宠物常用GM指令", "增加某个宠物好感度", function(inputStr)
  local pettotal = string.split(inputStr, " ")
  local petguid = tonumber(pettotal[1])
  local petexp = tonumber(pettotal[2])
  debugActions.SendGMCommand("ADDPETFAVOR " .. tostring(petguid) .. " " .. tostring(petexp))
end, true, "输入宠物guid 宠物所需要增加的好感度经验值")
helper.RegisterButton("宠物常用GM指令", "添加所有可用闪光奇波", function()
  debugActions.SendGMCommand("ADDSPECPET")
end, true)
helper.RegisterButton("宠物常用GM指令", "打印地图上所有奇特奇波", function()
  debugActions.SendGMCommand("AllSpecialMonster")
end, true)
helper.RegisterInput("宠物常用GM指令", "测试奇波进化提示", function(inputStr)
  local petConfigID = tonumber(inputStr)
  local petList = L_PetStore:getPetList()
  for _, v in pairs(petList) do
    if v:petCfgId() == petConfigID then
      AzurWorld.FlymsgManager:Enqueue("petEvolution_flyMsg", {
        petGuid = v.guid,
        isGM = true
      })
      break
    end
  end
end, true, "输入宠物configID")
helper.RegisterButton("战斗相关", "直接退出战斗", function()
  local worldBattle = L_UI:getPage("pageWorldBattlePC")
  if worldBattle ~= nil then
    C_BattleManager.ForceOutBattle()
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_onlyFight"))
  end
end, true)
helper.RegisterInput("战斗相关", "设置怪物主控", function(inputStr)
  local monsterId = tonumber(inputStr)
  if monsterId == nil then
    monsterId = 310001
  end
  local data = {tran_id = monsterId}
  L_Net:sendMessage(MsgGenCode.CSProtoTransformStart, data, function(rspData, errorCode)
  end)
end, true)
helper.RegisterButton("战斗相关", "退出设置怪物主控", function()
  L_Net:sendMessage(MsgGenCode.CSProtoTransformEnd, {}, function(rspData, errorCode)
  end)
end, true)
helper.RegisterButton("战斗相关", "开启战斗profiler", function()
  C_ProfilerTool.Open()
end, true)
helper.RegisterButton("战斗相关", "关闭战斗profiler", function()
  C_ProfilerTool.Close()
end, true)
helper.RegisterButton("活跃度任务相关", "完成每日活跃度所有任务", function()
  local activityTpl = L_GameTpl:getActivityTpl()
  local tpl = activityTpl:getAllData(1)
  for k, v in pairs(tpl) do
    local id = v.id
    local para = v.para
    Timer.once(k * 0.1, function()
      debugActions.SendGMCommand("SETACTIVEVAL " .. tostring(id) .. " " .. tostring(para))
    end)
  end
end, true)
helper.RegisterButton("活跃度任务相关", "完成每周活跃度所有任务", function()
  local activityTpl = L_GameTpl:getActivityTpl()
  local tpl = activityTpl:getAllData(2)
  for k, v in pairs(tpl) do
    local id = v.id
    local para = v.para
    Timer.once(k * 0.1, function()
      debugActions.SendGMCommand("SETACTIVEVAL " .. tostring(id) .. " " .. tostring(para))
    end)
  end
end, true)
helper.RegisterButton("拍照", "获取模板参数", function()
  if not L_PhotoManager:getMediator() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_noPhotoMode"))
    return
  end
  local id = 999999
  local type = L_Const.photoTemplateDataType.none
  L_PhotoManager:screenTemplateShot(id, true, true, function(bool, data, tex, name)
    local path = L_PhotoStore.path.tempBgSavePath .. "cellBg/" .. name
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_shearPlate", {
      [0] = path
    }))
    if bool then
      local data = L_PhotoManager:createPhotoWorldData(type, id, name)
      CS.UnityEngine.GUIUtility.systemCopyBuffer = data:toString()
    end
    if tex then
      tex:ReleaseTexture()
    end
  end)
end, true)
helper.RegisterToggle("七日签到活动", "开启活动隔天检验计时器", function(isShow)
  return debugActions.isUpdateAutoOpenPageActivitySevenDaySign
end, function(isShow)
  debugActions.isUpdateAutoOpenPageActivitySevenDaySign = isShow
  if isShow then
    L_TimerManager:newOrResetTimer(helper, "checkIfDeltaTimeOverOneDay", function()
      local gameEventData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_DAILY_SIGN)
      if not gameEventData then
        return
      end
      local signGE = gameEventData:getGameEvent()
      if not signGE then
        return
      end
      if not signGE.checkIfDeltaTimeOverOneDay then
        return
      end
      if not signGE:checkIfDeltaTimeOverOneDay() then
        return
      end
      if not signGE.tryAutoOpenPageActivitySevenDaySign then
        return
      end
      signGE:tryAutoOpenPageActivitySevenDaySign()
    end, 2, -1)
  else
    L_TimerManager:stopTimer(helper, "checkIfDeltaTimeOverOneDay")
  end
end)
helper.RegisterButton("七日签到活动", "尝试打开界面", function(isShow)
  local gameEventData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_DAILY_SIGN)
  if not gameEventData then
    return
  end
  local signGE = gameEventData:getGameEvent()
  if not signGE then
    return
  end
  signGE:tryAutoOpenPageActivitySevenDaySign()
end)
helper.RegisterButton("七日签到活动", "清除上次打开标记", function(isShow)
  local keyString = string.format("sevenDaySignAutoOpen_%d_%d", 2001, L_PlayerStore:getPlayerId() or -1)
  C_PlayerPrefsUtility.SetInt(keyString, 0)
end)
helper.RegisterInput("七日签到活动", "解锁签到奖励 参数:活动id，天数", function(inputStr)
  local strList = string.split(inputStr, " ")
  local gmStr = string.format("ActDailySign %d %d", tonumber(strList[1]), tonumber(strList[2]))
  debugActions.SendGMCommand(gmStr)
end)
helper.RegisterInput("设置平台标记", "平台名string,如：android,ios,pc", function(inputStr)
  CS.Lens.Framework.Managers.AppConfigManager.SetUIPlatformOverrideByStr(inputStr)
end, true)
helper.RegisterToggle("宠物", "测试捕获获得新奇波，默认false", function(isShow)
  return L_PetManager.gmForceGetPetNew
end, function(isShow)
  L_PetManager.gmForceGetPetNew = isShow
end)
helper.RegisterButton("左插测试", "测试左插", function()
  local test = require("test.testFlyMsgImageLoad")
  test.testRewardMsg()
  test.testJourneyUnlock()
  test.testJourneyUnlock()
end, true)
helper.RegisterButton("通信证", "测试通行证界面", function()
  L_UI:open("pageBattlePassMain")
end, true)

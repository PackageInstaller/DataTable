local GameObject = CS.UnityEngine.GameObject
local TimeUtil = CS.Framework.TimeUtil
local s_isBanMinimap = true
local s_isOpenGC = true
local GmManager, Super = System.NewClass("GmManager", Manager, IUpdater)
GmManager.isForbidGearUpdate = false
GmManager.isForbidInteratUpdate = false
GmManager.isForbidPlayerStateUpdate = false
GmManager.isForbidPlayerSight = false
GmManager.isForbidTestEntry = Vue.ref(false)

function GmManager:ctor()
  Super.ctor(self)
  self.gmCopyAbilityData = {}
  self.gmTempCopyAbilityData = {}
end

function GmManager:Awake(binder)
  Super.Awake(self)
  self:ShowGMTestUI()
  if not GmManager.isForbidTestEntry.value then
    self:InitItemNameList()
  end
  if not ApplicationUtils.is_editor_mode() then
    function GmManager.Update()
    end
  end
  binder:BindResponse(self, "Role", "OnGmNotice", System.fn(self, self.OnGmNotice))
  binder:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self.OnCloseUIPanel))
  self:TryOpenLogConsole()
end

function GmManager:Update()
  GmKeyInput.ProcessKeyInput()
end

function GmManager:OnCloseUIPanel()
  LangTable.CheckTextGoValid()
end

function GmManager:OpenLocalLoger()
  if not CS.FrameWork.Z1Const.IsDebugMode() then
    return
  end
  local mainAsset = ResLoadMgr.LoadAsset("GameBasePrefab/LocalLoger.prefab", self)
  local logerGo = GameObject.Instantiate(mainAsset)
  logerGo.name = "LocalLoger"
end

function GmManager:ShowDebugConsole(show, writeCache)
  local debugGO = GameObject.Find("Plugins/Debug")
  if not debugGO then
    local mainAsset = ResLoadMgr.LoadAsset("GameBasePrefab/Debug.prefab", self)
    debugGO = GameObject.Instantiate(mainAsset)
    debugGO.transform:SetParent(GameObject.Find("Plugins").transform, false)
    debugGO.name = "Debug"
  end
  local ingameDebugConsole = debugGO.transform:Find("IngameDebugConsole")
  local isVisible = show and not GmManager.isForbidTestEntry.value
  ingameDebugConsole.gameObject:SetActive(isVisible)
  if writeCache then
    MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.ShowLogConsole, isVisible)
  end
end

function GmManager:TryOpenLogConsole()
  local isVisible = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.ShowLogConsole)
  if isVisible then
    self:ShowDebugConsole(true)
  end
end

function GmManager:IsShowDebugConsoleShowed()
  local debugGO = GameObject.Find("Plugins/Debug")
  if not debugGO then
    return false
  end
  local ingameDebugConsole = debugGO.transform:Find("IngameDebugConsole")
  return ingameDebugConsole and ingameDebugConsole.gameObject.activeSelf
end

function GmManager:InitItemNameList()
  if self.initState then
    return
  end
  self.initState = true
  self.itemNameList = {}
  local tempNameList = {}
  for _, v in pairs(DT.Item) do
    tempNameList[v.Name] = v.ID
  end
  for _, v in pairs(DT.LanguageConfig) do
    if tempNameList[v.ID] then
      self.itemNameList[v.CN] = tempNameList[v.ID]
    end
  end
end

function GmManager:GetItemId(name)
  if not self.itemNameList then
    return
  end
  return self.itemNameList[name]
end

function GmManager.ShowGMTestUI()
  UIManager.Instance:Reopen(Urls.GmEntryPanel)
end

function GmManager.ShowMaskUI()
  UIManager.Instance:Reopen(Urls.ReqMaskPanel)
end

function GmManager.CloseGMTestUI()
  UIManager.Instance:CloseByUrl(Urls.GmEntryPanel)
end

function GmManager:OnDestroy()
  UIManager.Instance:CloseByUrl(Urls.ReqMaskPanel)
  UIManager.Instance:CloseByUrl(Urls.GmEntryPanel)
  ResLoadMgr.UnloadAssetByTarget(self)
  Super.OnDestroy(self)
end

function GmManager.GenSendParam(gmconfig, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
  local param = {}
  if gmconfig.num > 0 then
    if gmconfig.arg1Key and gmconfig.arg1Key ~= "" then
      param[gmconfig.arg1Key] = gmconfig.arg1Type == "number" and tonumber(arg1) or arg1
      if gmconfig.sendName == "check_item" and tonumber(arg1) == nil then
        local itemId = GmManager.Instance:GetItemId(arg1)
        if nil == itemId then
          Alert.Show(10133)
          return
        end
        param[gmconfig.arg1Key] = itemId
      elseif gmconfig.sendName == "gen_event" then
        local tid = tonumber(arg1)
        if nil ~= tid then
          local config = DT["Event.Event_" .. tid]
          if not config then
            Alert.Show(10134)
          end
        end
      end
    end
    if gmconfig.arg2Key and "" ~= gmconfig.arg2Key then
      param[gmconfig.arg2Key] = "number" == gmconfig.arg2Type and tonumber(arg2) or arg2
    end
    if gmconfig.arg3Key and "" ~= gmconfig.arg3Key then
      param[gmconfig.arg3Key] = "number" == gmconfig.arg3Type and tonumber(arg3) or arg3
    end
    if gmconfig.arg4Key and "" ~= gmconfig.arg4Key then
      param[gmconfig.arg4Key] = "number" == gmconfig.arg4Type and tonumber(arg4) or arg4
    end
    if gmconfig.arg5Key and "" ~= gmconfig.arg5Key then
      param[gmconfig.arg5Key] = "number" == gmconfig.arg5Type and tonumber(arg5) or arg5
    end
    if gmconfig.arg6Key and "" ~= gmconfig.arg6Key then
      param[gmconfig.arg6Key] = "number" == gmconfig.arg6Type and tonumber(arg6) or arg6
    end
    if gmconfig.arg7Key and "" ~= gmconfig.arg7Key then
      param[gmconfig.arg7Key] = "number" == gmconfig.arg7Type and tonumber(arg7) or arg7
    end
  elseif gmconfig.defaultArg then
    param.arg = gmconfig.defaultArg
  end
  return param
end

function GmManager.TriggerGm(id, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
  Logger.Debug("TriggerGm id=%s arg=[%s, %s, %s, %s, %s] ", id, arg1, arg2, arg3, arg4, arg5)
  local gmAllConfig = GmClientUtils.GetGmConfig()
  local gmconfig = gmAllConfig[id]
  if gmconfig.sendName and gmconfig.sendName ~= "" then
    local param = GmManager.GenSendParam(gmconfig, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    if not param then
      return
    end
    if 1 == id and bg.battleRender ~= nil then
      if not DT.Skill[tonumber(arg1)] then
        Alert.ShowStr("卡牌" .. arg1 .. "不存在")
        return
      end
      bg.battleRender:SendCommand(BattleCommand.lg_GM, {
        gm = bc.BattleGMType.NewHandCard,
        configId = tonumber(arg1),
        number = tonumber(arg2)
      })
      return
    end
    if 2 == id and bg.battleRender ~= nil then
      if not DT.RelicConfig[tonumber(arg1)] then
        Alert.ShowStr("造物" .. arg1 .. "不存在")
        return
      end
      bg.battleRender:SendCommand(BattleCommand.lg_GM, {
        gm = bc.BattleGMType.AddRelic,
        configId = tonumber(arg1)
      })
      return
    end
    if gmconfig.sendName == "OnRemoveRelic" and bg.battleRender ~= nil then
      if not DT.RelicConfig[tonumber(arg1)] then
        Alert.ShowStr("造物" .. arg1 .. "不存在")
        return
      end
      bg.battleRender:SendCommand(BattleCommand.lg_GM, {
        gm = bc.BattleGMType.RemoveRelic,
        configId = tonumber(arg1)
      })
      return
    end
    if gmconfig.sendName == "jump_novicer" then
      FrameWaiter.OnNextFrame(function()
        ProtoManager.Instance:ReqServer("GameRequest", "SetPlayerNameAndGender", function(data)
          DataCenter.playerData.DRole.name = data.name
          DataCenter.playerData.DRole.gender = data.gender
          DataCenter.playerData.DRole.icon = data.icon
          local data = DataCenter.introductionData.introData
          if data then
            data.step = 9999
          end
          SceneMgr.Instance:EnterTown()
        end, nil, PlayerDataUtils.GetAccountName(), 1)
      end)
    end
    if gmconfig.callbackName and "" ~= gmconfig.callbackName then
      ProtoManager.Instance:ReqServer("GmRequest", "OnGmCommand", function(data, code)
        GmManager.Instance:OnCallbackHandle(id, param, data, code)
      end, function(data, code)
        GmManager.Instance:OnCallbackHandle(id, param, data, code)
      end, gmconfig.sendName, param)
    else
      if gmconfig.ID == 174 then
      end
      ProtoManager.Instance.GmRequest:OnGmCommandBySend(gmconfig.sendName, param)
    end
  else
    GmManager.TriggerGm_Client(id, arg1, arg2, arg3, arg4, arg5, arg6, arg7, gmconfig)
  end
end

function GmManager.TriggerGm_Client(id, arg1, arg2, arg3, arg4, arg5, arg6, arg7, gmconfig)
  local clientFuncName = gmconfig.clientFuncName
  if clientFuncName and GmClientUtils[clientFuncName] then
    GmClientUtils[clientFuncName](arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    return
  end
  if 1 == id then
  elseif 9 == id then
    ProtoManager.Instance.GmRequest:OnGmCommandBySend("check_item", {
      tid = tonumber(arg1),
      num = tonumber(arg2)
    })
  elseif 12 == id then
    if bg.battleRender ~= nil then
      bg.battleRender:SendCommand(BattleCommand.lg_GM, {
        gm = bc.BattleGMType.CheckEnergy,
        energyNum = tonumber(arg1) or 1
      })
    end
  elseif 18 == id then
    Logger.Info("#一键上传log文件 功能已无")
  elseif 247 == id then
    Logger.Info("功能已无")
  elseif 19 == id then
    Logger.Info("功能已无")
  elseif 24 == id then
    DataCenter.mapData.InputKeyOpen = not DataCenter.mapData.InputKeyOpen
  elseif 25 == id then
    AudioManager.Instance:PostSoundEvent(arg1)
  elseif 26 == id then
    AudioManager.Instance:PostSoundEvent("Play_Function_Music_Test")
  elseif 28 == id then
    DataCenter.copiesData.isGiveUp = true
    UIManager.Instance:CloseByUrl(Urls.BattlePanel)
    ProtoManager.Instance:ReqServer("GameCopyRequest", "OnExit", nil, nil, DataCenter.copiesData.CopiesId)
  elseif 30 == id then
    ProtoManager.Instance.GmRequest:OnGmCommandBySend("set_hp", {
      hp = tonumber(arg1)
    })
  elseif 131 == id then
    Logger.Debug("性能：停止战斗脚本")
    local gameApp = GameObject.Find("GameApp")
    gameApp:SetActive(false)
  elseif 27 == id then
    Logger.SetDebugLogPrint(true)
  elseif 23 == id then
    Logger.SetDebugLogPrint(false)
  elseif 100 == id then
    Logger.Debug("#打印协议日志")
    Logger.SetProtoLogPrint(true)
  elseif 132 == id then
    Logger.Debug("性能：去除战斗特效")
    local usingObjData = bg.battleRender.sfxFactory.usingObjData
    for configId, objList in pairs(usingObjData) do
      for _, obj in ipairs(objList) do
        Logger.Debug("去除战斗特效：", configId, obj.uid, obj)
        bg.battleRender.sfxFactory:RecycleObj(obj)
      end
    end
  elseif 133 == id then
    Logger.Debug("性能：去除战斗动画")
    local roleList = bg.battleScene.roleList
    for index, role in ipairs(roleList) do
      for _, actor in ipairs(role.actorList) do
        local spineComp = actor.spineComp
        local isEnabled = not spineComp:GetSpineNode().activeSelf
        spineComp:GetSpineNode():SetActive(isEnabled)
      end
    end
  elseif 134 == id then
    Logger.Debug("性能：停止战斗动画")
    local roleList = bg.battleScene.roleList
    for index, role in ipairs(roleList) do
      for _, actor in ipairs(role.actorList) do
        local spineComp = actor.spineComp
        local skeletonAnimation = spineComp.skeletonAnimation
        local isEnabled = not skeletonAnimation.enabled
        skeletonAnimation.enabled = isEnabled
      end
    end
  elseif 135 == id then
    Logger.Debug("性能：去除战斗场景")
    local bgLayer = bg.battleScene.bgLayer.gameObject
    local isEnabled = not bgLayer.activeSelf
    bgLayer:SetActive(isEnabled)
  elseif 136 == id then
    Logger.Debug("性能：去除战斗UI")
    local uiLayer = bg.battleScene.uiLayer.gameObject
    local isEnabled = not uiLayer.activeSelf
    uiLayer:SetActive(isEnabled)
    local UIRoot = CS.UnityEngine.GameObject.Find("UIRoot")
    UIRoot:SetActive(isEnabled)
  elseif 140 == id then
    DataCenter.townData.UEMode = tonumber(arg1) or 2
  elseif 145 == id then
    Logger.Debug("#性能：停止界面动画")
    local isEnabled
    local UIRoot = GameObject.Find("UIRoot")
    local comps = UIRoot:GetComponentsInChildren(typeof(CS.UnityEngine.Animator))
    Logger.Debug("#comps:", comps, comps.Length)
    for j = 1, comps.Length do
      local comp = comps:GetValue(j - 1)
      isEnabled = not comp.enabled
      comp.enabled = isEnabled
    end
    Logger.Debug("#开关界面动画：", isEnabled)
  elseif 147 == id then
    Logger.Debug("#性能：设置抗锯齿等级")
    local lv = tonumber(arg1)
    PerformanceManager.Instance:ChangeQualitySetting(lv)
  elseif 148 == id then
    if DataCenter.gameData.IsShowAccountState then
      DataCenter.gameData.IsShowAccountState = false
    else
      DataCenter.gameData.IsShowAccountState = true
    end
  elseif 149 == id then
    Logger.Debug("#小地图事件ID")
    if DataCenter.copiesData.GMEventIdTextShow then
      DataCenter.copiesData.GMEventIdTextShow = false
    else
      DataCenter.copiesData.GMEventIdTextShow = true
    end
  elseif 150 == id then
    Logger.Debug("#角色位置，触屏位置")
    if DataCenter.playerData.GMLocation then
      DataCenter.playerData.GMLocation = false
    else
      DataCenter.playerData.GMLocation = true
    end
  elseif 152 == id and 0 ~= DataCenter.townData.TownId then
    Logger.Debug("#城镇玩家传送至副本门口")
    local player = RoleManager.Instance:GetRole(DataCenter.playerData.DRole.uid)
    local agent = player.avatarCp:GetGameObject():GetComponent(typeof(CS.UnityEngine.AI.NavMeshAgent))
    if agent then
      agent.enabled = false
      player:SetPosition(94.66667, 2.68868, -25.35)
      agent.enabled = true
    end
  elseif 153 == id then
    NetworkMgr.Instance:Disconnect(true)
  elseif 155 == id then
    Logger.Debug("修改游戏速度")
    TimeUtil.SetTimeScale(arg1)
  elseif 156 == id then
    Logger.Debug("开/关GC")
    if true == s_isOpenGC then
      Logger.Debug("关闭GC")
      CS.UnityEngine.Scripting.GarbageCollector.GCMode = CS.UnityEngine.Scripting.GarbageCollector.Mode.Disabled
      s_isOpenGC = false
    else
      Logger.Debug("打开GC")
      CS.UnityEngine.Scripting.GarbageCollector.GCMode = CS.UnityEngine.Scripting.GarbageCollector.Mode.Enabled
      s_isOpenGC = true
    end
  elseif 158 == id then
    Logger.Debug("切换卡牌堆顺序显示")
    local show
    if DataCenter.cardData.realOrderShowCard then
      show = "ID排序"
    else
      show = "真实顺序"
    end
    local desc = LT.Textf(DT.TipsType[10135].Desc, show)
    Alert.Show(10135, nil, nil, nil, desc)
    CardDataUtils.SetRealOrderShowCard(not DataCenter.cardData.realOrderShowCard)
  elseif 159 == id then
    GmClientUtils.BattleWin()
    return
  elseif 160 == id then
    GmClientUtils.BattleLose()
    return
  elseif 161 == id then
    Logger.Debug("隐藏GM界面")
    GmManager.SetGmPanelVisible(false)
  elseif 170 == id then
    Logger.Debug("瞬移至本层关卡出口")
    local player = RoleManager.Instance:GetRole(DataCenter.playerData.DRole.uid)
    local isFindExitPoint = false
    for _, eventinfo in pairs(DataCenter.barrierData.EventInfos) do
      if BarrierDataUtils.GetEventTypeByUid(DataCenter.copiesData.BarrierId, eventinfo.uid) == "Exit" then
        isFindExitPoint = true
        local agent = player.avatarCp:GetGameObject():GetComponent(typeof(CS.UnityEngine.AI.NavMeshAgent))
        if agent then
          agent.enabled = false
          local mapResource = DT["Map.Map_" .. DT["Barrier.Barrier_" .. DataCenter.copiesData.BarrierId].MapId].mapResource
          local toPostion = mapResource.nodes[eventinfo.keyId].pos
          player:SetPosition(toPostion[1], toPostion[2], toPostion[3])
          agent.enabled = true
        end
        break
      end
    end
    if not isFindExitPoint then
      Logger.Debug("当前场景没有出口处")
    end
  elseif 171 == id then
    Logger.Debug("对所有怪物造成n点伤害，不致死，最低1点血")
    if bg.battleRender ~= nil then
      bg.battleRender:SendCommand(BattleCommand.lg_GM, {
        gm = bc.BattleGMType.AttackAllEnermyToLive,
        damageNum = tonumber(arg1) or 1
      })
    end
  elseif 258 == id then
    Logger.Debug("对所有怪物造成n点伤害，致死")
    if bg.battleRender ~= nil then
      bg.battleRender:SendCommand(BattleCommand.lg_GM, {
        gm = bc.BattleGMType.AttackAllEnermyToDie,
        damageNum = tonumber(arg1) or 1
      })
    end
  elseif 175 == id then
    Logger.Debug("不触发战斗")
    DataCenter.copiesData.DontTriggerBattle = not DataCenter.copiesData.DontTriggerBattle
  elseif 185 == id then
    local itemNum = tonumber(arg1)
    local idBase = 3000
    if itemNum then
      local list = {}
      for i = 1, itemNum do
        local _id = i % 19
        if 0 == _id then
          _id = 1
        end
        local _tid = idBase + _id
        local _reason = tonumber(arg2) or 1
        table.insert(list, {
          tid = _tid,
          uid = 0,
          changedNum = i * 10 ^ (_id % 7),
          reason = 1 == _reason and "XGC" or "RW"
        })
      end
      for i = 1, 3 do
        local _reason = tonumber(arg2) or 1
        table.insert(list, {
          tid = i,
          uid = 0,
          changedNum = i * 100 ^ i,
          reason = 1 == _reason and "XGC" or "RW"
        })
      end
      EventMgr.Instance.UpdateBagEvent:Dispatch(list)
      UIManager.Instance:CloseByUrl(Urls.GmPanel)
    end
  elseif 192 == id then
    Logger.Info("打开Inspector")
    local inspectorRoot = CS.UnityEngine.GameObject.Find("Inspector")
    if inspectorRoot then
      for i = 0, inspectorRoot.transform.childCount - 1 do
        local child = inspectorRoot.transform:GetChild(i)
        child.gameObject:SetActive(not child.gameObject.activeSelf)
      end
    end
    local panel = UIManager.Instance:GetWindow(Urls.GmEntryPanel)
    if panel then
      local rectTransform = panel.ui.Btn_Gm:GetComponent(typeof(CS.UnityEngine.RectTransform))
      rectTransform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    end
  elseif 193 == id then
    local uiRoot = CS.UnityEngine.GameObject.Find("UIRoot")
    local canvasScaler = uiRoot:GetComponent(typeof(CS.UnityEngine.UI.CanvasScaler))
    if canvasScaler and canvasScaler.dynamicPixelsPerUnit then
      canvasScaler.dynamicPixelsPerUnit = tonumber(arg1)
    end
  elseif 201 == id then
    local tipTid = tonumber(arg1)
    if tipTid then
      Alert.Show(tipTid, function()
        Logger.Info("cancelFunc")
      end, function()
        Logger.Info("confirmFunc")
      end)
    end
  elseif 204 == id then
    DataCenter.gameData.OpenAsynUI = not DataCenter.gameData.OpenAsynUI
  elseif 205 == id then
    Logger.SetLogState(not Logger.GetLogState())
  elseif 206 == id then
    local vSyncCount = CS.UnityEngine.QualitySettings.vSyncCount
    vSyncCount = (vSyncCount + 1) % 2
    Logger.Info("vSyncCount is ", vSyncCount)
    CS.UnityEngine.QualitySettings.vSyncCount = vSyncCount
  elseif 212 == id then
    ProtoManager.Instance:ReqServer("GameRequest", "OnGetBattleStatistics", function(data)
      CS.System.IO.Directory.CreateDirectory("BattleLog")
      local file = io.open(string.format("BattleLog/BattleStatisics_%s.txt", os.date("%m-%d-%H-%M", os.time())), "w")
      file:write(table.tostring(data))
      file:close()
    end, nil)
  elseif 213 == id then
    local ipAddr = arg1
    CS.Framework.LiveCodingUtil.StartLiveCodingClient(ipAddr)
  elseif 214 == id then
    if ApplicationUtils.is_editor_mode() then
      local ipAddr = arg1
      LuaPanda.start(ipAddr, 8818)
    end
  elseif 216 == id then
    CS.ReflectionStatistic.Export()
  elseif 217 == id then
    PerformanceManager.Instance:SwitchGCInfo()
    if not PerformanceManager.Instance:IsGCInfoEnabled() then
      EventMgr.Instance.GMGC:Dispatch("")
    else
      EventMgr.Instance.GMGC:Dispatch(CS.PerformanceStatistic.Report())
    end
  elseif id == 221 then
    DataCenter.gameData.DelayReconnectTime = tonumber(arg1)
    if RpcMgr.Instance:is_connect() then
      RpcMgr.Instance:CloseSocket("gm")
    end
  elseif id == 242 then
    if true == GmManager.isForbidTestEntry.value then
      GmManager.isForbidTestEntry.value = false
    else
      GmManager.isForbidTestEntry.value = true
    end
  elseif id == 244 then
    if not bg.battleRender then
      return
    end
    bg.battleRender.robotMgr:SetAuto()
  elseif id == 245 then
    if not bg.battleRender then
      return
    end
    bg.battleRender:SendCommand(BattleCommand.lg_GM, {
      gm = bc.BattleGMType.ModifyHp,
      num = tonumber(arg1)
    })
  elseif id == 246 then
    if not bg.battleRender then
      return
    end
    bg.battleRender:SendCommand(BattleCommand.lg_GM, {
      gm = bc.BattleGMType.PrintSnapShot
    })
  elseif id == 267 then
    if not bg.battleRender then
      return
    end
    bg.battleRender:SendCommand(BattleCommand.lg_GM, {
      gm = bc.BattleGMType.SwitchTimer
    })
  elseif id == 268 then
    EventMgr.Instance.GMShowWorldStageGridPos:Dispatch()
  elseif id == 255 then
    local fileName, content = arg1
    Logger.Info("AccountJson Log fileName----" .. fileName .. "----")
    if ApplicationUtils.is_editor_mode() then
      local filePath = CS.UnityEngine.Application.streamingAssetsPath .. "/AccountJson"
      filePath = string.format("%s/%s", filePath, fileName)
      local file = io.open(filePath, "r")
      content = file:read("*all")
      file:close()
    else
      content = CS.Framework.AssetLoadUtil.GetJsonFileInApp("AccountJson/" .. fileName)
      local persistentFileName = Utils.GetApplicationPersistenDataPath() .. "/_game_data_/DownLoad/AccountJson/" .. fileName
      Logger.Info("AccountJson Log persistentFileName----" .. persistentFileName .. "----")
      local persisFileInfo = CS.System.IO.FileInfo(persistentFileName)
      persisFileInfo:Refresh()
      if persisFileInfo then
        Logger.Info("AccountJson Log persisFileInfo", table.tostring(persisFileInfo), persisFileInfo.Exists)
      end
      if persisFileInfo.Exists then
        content = CS.Framework.AssetLoadUtil.LoadTextData(persistentFileName, true)
      end
      persisFileInfo:Refresh()
    end
    Logger.Info("AccountJson Log Data ", content)
    local segment_length = 10000
    local str_length = string.len(content)
    local contentList = {}
    for i = 1, str_length, segment_length do
      local segment = string.sub(content, i, i + segment_length - 1)
      table.insert(contentList, segment)
    end
    local sendIdx = 1
    
    local function sendFile(jsonDataList, isFinish, sendIdx)
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("GameRequest", "OnImportAccountJson", function(data)
        Logger.Debug("GameRequest OnImportAccountJson Successful", table.tostring(data))
        sendIdx = sendIdx + 1
        if sendIdx <= #jsonDataList then
          sendFile(jsonDataList, sendIdx >= #jsonDataList, sendIdx)
        end
      end, function(data)
        Logger.Debug("GameRequest OnImportAccountJson Failed", table.tostring(data))
      end, jsonDataList[sendIdx], isFinish and 1 or 0)
    end
    
    sendFile(contentList, sendIdx >= #contentList, sendIdx)
  end
end

function GmManager:OnCallbackHandle(id, arg2, data, errCode)
  if not errCode then
    return
  end
  local gmAllConfig = GmClientUtils.GetGmConfig()
  local gmconfig = gmAllConfig[id]
  if gmconfig.callbackName ~= "" then
    local fun = self["Ret" .. gmconfig.callbackName]
    if fun then
      fun(self, gmconfig.name, arg2, data, errCode)
    else
      Logger.Error("OnCallbackHandle: not find handle function=" .. gmconfig.callbackName)
    end
  end
end

function GmManager:RetConditionGroup(id, arg2, data, errCode)
end

function GmManager:RetEnterBarrier(id, arg2, data, errCode)
  local str = string.format("RetJumpNextBarrier: id=%s, arg2=%s", id, table.tostring(arg2))
  Logger.Info(str)
  local barrierTid = data.tid
  local awakerTidsStr = arg2.awakerTids or ""
  local tempTids = string.split(awakerTidsStr, ",")
  local awakerTids = {}
  if next(tempTids) then
    for index, value in ipairs(tempTids) do
      local tid = tonumber(value or 0) or 0
      if #awakerTids <= 4 and (0 == tid or DT.AwakerConfig[tid]) then
        table.insert(awakerTids, tid)
      end
    end
    for index = #awakerTids + 1, 4 do
      table.insert(awakerTids, 0)
    end
  else
    awakerTids = {
      1001,
      1002,
      1003,
      1004
    }
  end
  ProtoManager.Instance:ReqServer("GameRequest", "ShowTeam", function(data)
    DataCenter.teamData.Team = {}
  end, nil, 1, 0)
  local canEnterStoryLine = 100
  local copiesTid = 1
  for _, cfg in pairs(DT.PlotConfig) do
    if cfg and 1 == cfg.SortID then
      canEnterStoryLine = cfg.ID
      copiesTid = cfg.CopyID
      break
    end
  end
  if next(awakerTids) or DataCenter.teamData.Team == nil or DataCenter.teamData.Team <= 0 then
    DataCenter.dbgMainCopyData.selectCopyId = copiesTid
    DataCenter.dbgMainCopyData.selectStoryLineId = canEnterStoryLine
    DataCenter.dbgMainCopyData.selectStoryLineId = 0
    ProtoManager.Instance.GmRequest:OnGmCommandBySend("clear_barrier", {})
  else
    DataCenter.dbgMainCopyData.selectCopyId = copiesTid
    DataCenter.dbgMainCopyData.selectStoryLineId = canEnterStoryLine
    DataCenter.dbgMainCopyData.selectStoryLineId = 0
    ProtoManager.Instance.GmRequest:OnGmCommandBySend("clear_barrier", {})
  end
end

function GmManager.SetGmPanelVisible(state)
  local gmEntryPanel = CS.UnityEngine.GameObject.Find("GmEntryPanel(Clone)")
  local ingameDebugConsole = CS.UnityEngine.GameObject.Find("IngameDebugConsole")
  if gmEntryPanel then
    gmEntryPanel:SetActive(state)
  end
  if ingameDebugConsole then
    ingameDebugConsole:SetActive(state)
  end
end

function GmManager:RetJumpToEvent(id, arg2, data, errCode)
end

function GmManager:RetTriggerEvent(id, arg2, data, errCode)
end

function GmManager:RetSkillUpgrade(id, arg2, data, errCode)
  if errCode.code == ErrorMsg.SUCCESS then
    Logger.Info("因唤醒体系统调整，该GM暂时屏蔽")
    return
  end
end

function GmManager:RetGenEvent(id, arg2, data, errCode)
  Logger.Info("RetGenEvent", id, arg2, table.tostring(data), table.tostring(errCode))
  if errCode.code == ErrorMsg.SUCCESS then
    Alert.Show(10137)
    return
  end
  UIManager.Instance:Show(Urls.PopMsgPanel, LT.Text(errCode.code))
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
end

function GmManager:RetSetServerTime(id, arg2, data, errCode)
  Logger.Info("RetSetServerTime", id, arg2, table.tostring(data), table.tostring(errCode))
  if errCode.code == ErrorMsg.SUCCESS then
    Alert.Show(10138)
    return
  end
  Alert.Show(10139)
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
end

function GmManager:RetUnlockPlot(id, arg2, data, errCode)
  Logger.Debug("RetUnlockPlot ", id, arg2, table.tostring(data), table.tostring(errCode))
  if errCode.code ~= ErrorMsg.SUCCESS then
    Alert.ShowStr("解锁失败")
    return
  end
  if not data then
    return
  end
  for _, v in ipairs(data) do
    if "table" == type(v) then
      DBGMainCopyDataUtils.UpdateDBGStoryLineData({
        tid = v.tid,
        star = v.star,
        unlock = true
      })
    else
      DBGMainCopyDataUtils.UpdateDBGStoryLineData({
        tid = v,
        star = 3,
        unlock = true
      })
    end
  end
end

function GmManager:RetUnlockMoneyTower(id, arg2, data, errCode)
  Logger.Debug("RetUnlockMoneyTower ", id, arg2, table.tostring(data), table.tostring(errCode))
  if errCode.code == ErrorMsg.SUCCESS then
    Alert.Show(10001)
    if data then
    end
    return
  end
end

function GmManager:RetTrainingAdjustment(id, arg2, data, errCode)
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
  Logger.Debug("RetTrainingAdjustment ", id, arg2, table.tostring(data), table.tostring(errCode))
  if errCode.code == ErrorMsg.SUCCESS then
    Alert.Show(10001)
  elseif data then
    Alert.ShowStr(data)
  else
    Alert.ShowStr("GM命令失败")
  end
end

function GmManager:RetJumpNovicer(id, arg2, data, errCode)
  Logger.Debug("RetJumpNovicer ", id, arg2, table.tostring(data), table.tostring(errCode))
  if errCode.code == ErrorMsg.SUCCESS then
    Alert.Show(10001)
    if data.step then
      DataCenter.introductionData.introData.step = data.step
    end
  end
end

function GmManager:RetEnterStage(id, param, data, errCode)
  if not data then
    Alert.ShowStr("Gm命令[进入关卡]失败")
    return
  end
  if data.msg then
    Alert.ShowStr("Gm命令[进入关卡]失败-" .. data.msg)
    return
  end
  if errCode.code ~= ErrorMsg.SUCCESS then
    ErrorMsg.ShowErrCodeTips(errCode, data)
    return
  end
  WorldStageComp._isGmEnter = true
  WorldRecoveryManager.Instance:SetRecoverData(param.stage, data.worldType)
  WorldRecoveryManager.Instance:OnHandleRecoverWorldData(data)
  WorldStageComp._isGmEnter = false
  if data.chaosRelics and #data.chaosRelics > 0 then
    TimerManager.Instance:CreateTimer(1, 0, nil, function()
      ProtoManager.Instance.WorldResponse:Dispatch("OnChaosRelic", data.chaosRelics)
    end)
  end
end

function GmManager:RetReenterStage(id, param, data, errCode)
  if data.msg then
    Alert.ShowStr("Gm命令[进入关卡]失败-" .. data.msg)
    return
  end
  if errCode.code ~= ErrorMsg.SUCCESS then
    ErrorMsg.ShowErrCodeTips(errCode, data)
    return
  end
  GmClientUtils.GmReLogin()
  LoginMgr.Instance:StartLogin(PlayerDataUtils.GetAccountName())
end

function GmManager:RetEnterBattle(id, param, data, errCode)
  if data.msg then
    Alert.ShowStr("Gm命令[进入关卡]失败-" .. data.msg)
    return
  end
  if errCode.code ~= ErrorMsg.SUCCESS then
    ErrorMsg.ShowErrCodeTips(errCode, data)
    return
  end
  WorldRecoveryManager.Instance:SetRecoverData(data.copiesTid, data.worldType)
  WorldRecoveryManager.Instance:OnHandleRecoverWorldData(data)
end

function GmManager:RetEnterSchoolTown(id, param, data, errCode)
  if data and data.msg then
    Alert.ShowStr("Gm命令[进入关卡]失败-" .. data.msg)
    return
  end
  if errCode.code ~= ErrorMsg.SUCCESS then
    ErrorMsg.ShowErrCodeTips(errCode, data or {})
    return
  end
  WorldRecoveryManager.Instance:SetRecoverData(data.copiesTid, data.worldType)
  WorldRecoveryManager.Instance:OnHandleRecoverWorldData(data)
end

function GmManager:RetResetTalent(id, param, data, errCode)
  if data and data.msg then
    Alert.ShowStr("Gm命令[进入关卡]失败-" .. data.msg)
    return
  end
  if errCode.code ~= ErrorMsg.SUCCESS then
    ErrorMsg.ShowErrCodeTips(errCode, data or {})
    return
  end
  ResonanceDataUtils.ResetResonances(data.group)
  RedPointDataUtils.UpdateMainStageResonance(data.group)
end

function GmManager:HasGmCopyAbilityId(id)
  if self.gmTempCopyAbilityData[id] and self.gmTempCopyAbilityData[id] > 0 then
    return true
  end
  return self.gmCopyAbilityData[id] and self.gmCopyAbilityData[id] > 0
end

function GmManager:ResetGmCopyAbilityId()
  self.gmCopyAbilityData = {}
end

function GmManager:ClearGmTempCopyAbilityId()
  self.gmTempCopyAbilityData = {}
end

function GmManager:SetGmTempCopyAbilityId(id, select)
  self.gmTempCopyAbilityData[id] = select and 1 or 0
end

function GmManager:SyncGmCopyAbilityId(data)
  self:ResetGmCopyAbilityId()
  self:ClearGmTempCopyAbilityId()
  for key, value in pairs(data) do
    self.gmCopyAbilityData[key] = value
  end
end

function GmManager:ReqGmCopyAbilitys(callback)
  for key, value in pairs(self.gmTempCopyAbilityData) do
    self.gmCopyAbilityData[key] = value
  end
  ProtoManager.Instance:ReqServer("GmRequest", "OnGmCopyAbility", function(data, code)
    self:SyncGmCopyAbilityId(data)
    Alert.ShowStr("成功")
    if callback then
      callback()
    end
  end, nil, self.gmCopyAbilityData)
end

function GmManager:GetGmHasCopyAb()
  local list = {}
  for key, value in pairs(self.gmCopyAbilityData) do
    if value > 0 then
      table.insert(list, key)
    end
  end
  return list
end

function GmManager:GetClientGitBranch()
  if not CS.Z1Client.LuaBehaviour.Instance or not CS.Z1Client.LuaBehaviour.Instance.useGitLuaDir then
    return ""
  end
  local branchName = CS.Z1_Git.GetGitBranchName()
  return branchName
end

function GmManager:OnGmNotice(data)
end

return GmManager

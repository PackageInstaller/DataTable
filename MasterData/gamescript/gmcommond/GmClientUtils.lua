local GmClientUtils, Super = System.NewClass("GmClientUtils")
GmClientUtils.IsEnableAvgLog = false
GmClientUtils.isSaveRecord = false
GmClientUtils.isRedDotGmOpen = false
DebugCmds.InjectFunc(GmClientUtils)

function GmClientUtils.RequestGmData()
  ProtoManager.Instance:ReqServer("GmRequest", "OnQueryGmData", function(data, code)
    Logger.Info("获取GM数据成功", table.tostring(data))
    for _, gmInfo in ipairs(data) do
      local argNames = {}
      local argTypes = {}
      local argCfgNames = {}
      local callback
      if gmInfo.params then
        for index, param in ipairs(gmInfo.params) do
          if param.type ~= "Callback" then
            table.insert(argTypes, param.type)
            local spString = string.split(param.desc, "#")
            if #spString > 1 then
              argCfgNames[index] = spString[2]
            end
            table.insert(argNames, spString[1])
          else
            callback = param.desc
          end
        end
      end
      GmClientUtils.AddDynamicGmCommand(gmInfo.name, "服务器" .. gmInfo.gm_type, gmInfo.category, gmInfo.func_name, gmInfo.argKeys, argNames, argTypes, argCfgNames, callback)
    end
  end, function(data, code)
    Logger.Info("获取GM数据失败")
  end)
end

function GmClientUtils.GmBattle(battleId, mockId, gmconfig)
  local MockConfig = DT.MockDataConfig[tonumber(mockId)]
  MockConfig = MockConfig or DT.MockDataConfig[1]
  local roles = {}
  local guid = 0
  for tid, level in pairs(MockConfig.Actors) do
    local actorData = {
      uid = guid,
      tid = tid,
      level = level
    }
    guid = guid + 1
    table.insert(roles, actorData)
  end
  local cards = {}
  for tid, num in pairs(MockConfig.Cards) do
    for _ = 1, num do
      local cardData = {uid = guid, tid = tid}
      guid = guid + 1
      table.insert(cards, cardData)
    end
  end
  local battleData = {}
  battleData.battleTid = tonumber(battleId)
  battleData.hp = MockConfig.Hp
  battleData.maxHp = MockConfig.MaxHp
  battleData.cards = cards
  battleData.roleData = roles
  battleData.gameplayType = bc.BattleGameplayType.PVE
  BattleManager.Instance:EnterBattle(battleData, 1, false)
end

function GmClientUtils.AddDynamicGmCommand(name, gmType, gmSubType, sendName, argKeys, argNames, argTypes, argConfigNames, cb)
  GmClientUtils._DynamicGmList = GmClientUtils._DynamicGmList or {}
  local dynamicGm = {
    id = GmClientUtils.GetDynamicGmId(),
    name = name,
    gmType = gmType,
    subtype = gmSubType,
    sendName = sendName,
    callbackName = cb
  }
  local num = 0
  local gmArgsCount = 6
  for index = 1, gmArgsCount do
    dynamicGm[string.format("arg%sKey", index)] = argKeys and argKeys[index]
    dynamicGm[string.format("arg%s", index)] = argNames and argNames[index]
    dynamicGm[string.format("arg%sType", index)] = argTypes and argTypes[index]
    dynamicGm[string.format("arg%sCfg", index)] = argConfigNames and argConfigNames[index]
    if argNames and argNames[index] then
      num = index
    end
  end
  dynamicGm.num = num
  GmClientUtils._DynamicGmList[name] = dynamicGm
end

function GmClientUtils.AddBattleDynamicGmCommand(name, clientFuncName, argKeys, argNames, argTypes, argConfigNames, cb, extraData)
  extraData = extraData or {}
  extraData.gmType = "战斗功能"
  extraData.subtype = "通用GM"
  GmClientUtils.AddClientDynamicGmCommand(name, clientFuncName, argKeys, argNames, argTypes, argConfigNames, cb, extraData)
end

function GmClientUtils.AddClientDynamicGmCommand(name, clientFuncName, argKeys, argNames, argTypes, argConfigNames, cb, extraData)
  GmClientUtils._DynamicGmList = GmClientUtils._DynamicGmList or {}
  extraData = extraData or {}
  local dynamicGm = {
    id = GmClientUtils.GetDynamicGmId(),
    name = name,
    gmType = extraData.gmType or "客户端Gm",
    subtype = extraData.subtype or "客户端",
    clientFuncName = clientFuncName,
    callbackName = cb
  }
  local num = 0
  local gmArgsCount = 6
  for index = 1, gmArgsCount do
    dynamicGm[string.format("arg%sKey", index)] = argKeys and argKeys[index]
    dynamicGm[string.format("arg%s", index)] = argNames and argNames[index]
    dynamicGm[string.format("arg%sType", index)] = argTypes and argTypes[index]
    dynamicGm[string.format("arg%sCfg", index)] = argConfigNames and argConfigNames[index]
    if argNames and argNames[index] then
      num = index
    end
  end
  dynamicGm.num = num
  GmClientUtils._DynamicGmList[name] = dynamicGm
end

function GmClientUtils.GetDynamicGmId()
  GmClientUtils._DynamicId = GmClientUtils._DynamicId or 10000000
  GmClientUtils._DynamicId = GmClientUtils._DynamicId + 1
  return GmClientUtils._DynamicId
end

function GmClientUtils.GetGmConfig()
  local gmGonfig = table.clone(DT.GmConfig)
  for _, dynamicGm in pairs(GmClientUtils._DynamicGmList or {}) do
    gmGonfig[dynamicGm.id] = dynamicGm
  end
  return gmGonfig
end

function GmClientUtils.BattleWin()
  Logger.Debug("战斗胜利")
  local battleRenderer = bg.battleRender
  if nil ~= battleRenderer then
    battleRenderer:SendCommand(BattleCommand.lg_GM, {
      gm = bc.BattleGMType.BattleEnd,
      winCamp = bc.BattleCamp.Camp1
    })
  end
end

function GmClientUtils.BattleLose()
  Logger.Debug("战斗失败")
  local battleRenderer = bg.battleRender
  if nil ~= battleRenderer then
    battleRenderer:SendCommand(BattleCommand.lg_GM, {
      gm = bc.BattleGMType.BattleEnd,
      winCamp = bc.BattleCamp.Camp2
    })
  end
end

function GmClientUtils.GmGetSomeRelics(count)
  Logger.Debug("GM随机获得指定数量的遗物", count)
  local itemConfig = DT.Item
  local allRelicTidList = {}
  for tid, config in pairs(itemConfig) do
    if config.AbilityIDList then
      table.insert(allRelicTidList, tid)
    end
  end
  for i = 1, count do
    TimerManager.Instance:CreateTimer(0.1 * i, 0, nil, function()
      local randIndex = math.random(1, #allRelicTidList)
      local tid = allRelicTidList[randIndex]
      table.remove(allRelicTidList, randIndex)
      if tid then
        local config = ItemDataUtils.GetItemConfig(tid)
        ProtoManager.Instance:ReqServer("GmRequest", "OnGmCommand", function(data, code)
          Logger.Info("GM获得遗物:%s", LT.Text(config.Name, true))
        end, function(data, code)
          Logger.Info("GM获得遗物失败:%s", LT.Text(config.Name, true))
        end, "add_relic", {tid = tid})
      else
        Logger.Debug("tid == nil")
      end
    end)
  end
end

function GmClientUtils.GmReLogin()
  GmModel.Instance:SaveRecentUseGm()
  ReconnectMgr.Instance:Disable()
  NetworkMgr.Instance:Close()
  SceneMgr.Instance:EnterLogin()
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
end

function GmClientUtils.OpenConfuseText()
  if not Binder.OpenConfuseText then
    Binder.OpenConfuseText = true
  else
    Binder.OpenConfuseText = not Binder.OpenConfuseText
  end
end

function GmClientUtils.GmShareTest()
  local Image = CS.UnityEngine.UI.Image
  local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
  local Logo = CS.UnityEngine.GameObject.Find("Logo")
  local testNode = CS.UnityEngine.GameObject.Instantiate(Logo)
  testNode.name = "test"
  testNode.transform:SetParent(Logo.transform, false)
  local rawImageComp = testNode:GetComponent(typeof(TypeRawImage))
  testNode:SetActive(false)
  SdkMgr.Instance:GetShare():CaptureScreen(function(tex)
    rawImageComp.texture = tex
    testNode:SetActive(true)
    rawImageComp:SetNativeSize()
    SdkMgr.Instance:GetShare():SaveTex_2_PhoneAlbum(tex)
    SdkMgr.Instance:GetShare():ShareLine("", tex)
  end)
end

function GmClientUtils:GmTestMemoryWaring()
  EventMgr.Instance.OnLowMemory:Dispatch()
  ResGcMgr.Instance:Gc()
end

function GmClientUtils.GmLuaProfiler()
  if Profile.isProfile then
    Profile.isProfile = false
    Profile.dstop(60)
  else
    Profile.start()
    Profile.isProfile = true
  end
end

function GmClientUtils.GmGearUpdate()
  GmManager.isForbidGearUpdate = not GmManager.isForbidGearUpdate
end

function GmClientUtils.GmInteratUpdate()
  GmManager.isForbidInteratUpdate = not GmManager.isForbidInteratUpdate
end

function GmClientUtils.GmPlayerUpdate()
  GmManager.isForbidPlayerStateUpdate = not GmManager.isForbidPlayerStateUpdate
end

function GmClientUtils.GmPlayerSight()
  GmManager.isForbidPlayerSight = not GmManager.isForbidPlayerSight
end

function GmClientUtils.GmLuaProfilerName()
  return Profile.isProfile and "关闭LuaProfile" or "开启LuaProfile"
end

function GmClientUtils.GmGearUpdateName()
  return GmManager.isForbidGearUpdate and "开启GearUpdate" or "关闭GearUpdate"
end

function GmClientUtils.GmInteratUpdateName()
  return GmManager.isForbidInteratUpdate and "开启InteratUpdate" or "关闭InteratUpdate"
end

function GmClientUtils.GmPlayerUpdateName()
  return GmManager.isForbidPlayerStateUpdate and "开启PlayerUpdate" or "关闭PlayerUpdate"
end

function GmClientUtils.GmPlayerSightName()
  return GmManager.isForbidPlayerSight and "开启PlayerSight" or "关闭PlayerSight"
end

function GmClientUtils.GmFixUsingCard()
  Logger.Debug("修复手牌使用中问题")
  if bg.battlePanel ~= nil and bg.battlePanel.usingCardUidMap and next(bg.battlePanel.usingCardUidMap) then
    bg.battlePanel.usingCardUidMap = {}
    Alert.Show(10132)
  end
end

function GmClientUtils.GmPrintBattleClientSnapshot()
  local snap = DataInspectorExport.CollectBattleCardGlowSnapshot()
  local lines = DataInspectorExport.FormatBattleCardGlowSnapshotLines(snap)
  for _, line in ipairs(lines) do
    Logger.Error(line)
  end
  local relativePath, fullPath, ok, err = DataInspectorExport.SaveBattleCardGlowSnapshotToFile(snap)
  if ok then
    Logger.Error("[BattleSnap] 已写入文件 relative=%s full=%s", tostring(relativePath), tostring(fullPath))
  else
    Logger.Error("[BattleSnap] 写入文件失败 err=%s", tostring(err))
  end
end

function GmClientUtils.GmDiagnoseCardGlow()
  if not bg.battlePanel then
    Logger.Error("[CardGlow] 当前不在战斗中")
    return
  end
  local cardUI = bg.battlePanel:GetCardUI()
  local realCamp
  if not cardUI and bg.battleDataCenter and bg.battleDataCenter.GetRealCamp then
    realCamp = bg.battleDataCenter:GetRealCamp()
    cardUI = bg.battlePanel:GetCardUI(realCamp)
  end
  if not cardUI then
    Logger.Error("[CardGlow] cardUI 不存在(realCamp=%s)", tostring(realCamp))
    return
  end
  local myCamp = cardUI.myCamp
  local dataCenter = bg.battleDataCenter
  local boutData = dataCenter and dataCenter.boutData
  local phase = boutData and boutData.phase
  local phaseName = "Unknown"
  if phase == bc.BoutPhase.None then
    phaseName = "None"
  elseif phase == bc.BoutPhase.Begin then
    phaseName = "Begin"
  elseif phase == bc.BoutPhase.Action then
    phaseName = "Action"
  elseif phase == bc.BoutPhase.End then
    phaseName = "End"
  end
  local isPVPSelecting = cardUI.isPVPSelecting and cardUI.isPVPSelecting.value
  local boutCamp = boutData and boutData.camp
  Logger.Error("[CardGlow] ===== 全局状态 =====")
  Logger.Error("[CardGlow] myCamp=%s realCamp=%s boutCamp=%s phase=%s(%s) isPVPSelecting=%s", tostring(myCamp), tostring(realCamp), tostring(boutCamp), tostring(phase), phaseName, tostring(isPVPSelecting))
  local cardMgr = cardUI.cardMgr
  local handCardDataList = cardMgr:GetHandCardList()
  local cardItemMap = cardUI.cardItemMap
  local cardItemCount = 0
  for _ in pairs(cardItemMap) do
    cardItemCount = cardItemCount + 1
  end
  Logger.Error("[CardGlow] 手牌数量(数据层): %d  cardItemMap条目数: %d", #handCardDataList, cardItemCount)
  for index, cardData in ipairs(handCardDataList) do
    local cardItem = cardItemMap[cardData]
    local uid = cardData.uid
    local configId = cardData.configId
    local deck = cardData.deck
    local canUse = cardData:CanUse()
    local checkUsable = cardData:CheckUsable()
    local usableVal = cardData.usable and cardData.usable.value
    local highlightVal = cardData.highlightEffect and cardData.highlightEffect.value
    if not cardItem then
      Logger.Error("[CardGlow] 卡牌#%d uid=%s configId=%s → 无CardItem!", index, tostring(uid), tostring(configId))
    else
      local isShowLight = cardItem.isShowLight and cardItem.isShowLight.value
      local interactable = cardItem.interactable and cardItem.interactable.value
      local isInserting = cardItem.isInserting and cardItem.isInserting.value
      local inAnimation = cardItem.inAnimation
      local actionCamp = bg.battleDataCenter and bg.battleDataCenter.GetRealCamp and bg.battleDataCenter:GetRealCamp()
      local cardCamp = cardData and cardData.camp
      local itemMyCamp = cardItem.myCamp
      local cardUIMyCamp = cardUI.myCamp
      local itemCard = cardItem.card and cardItem.card.value
      local itemCardUid = itemCard and itemCard.uid
      local sameCardRef = itemCard == cardData
      local blueResult = cardItem:CheckIsBlueEffect()
      local yellowResult = cardItem:CheckIsYellowEffect()
      local redResult = cardItem:CheckIsRedEffect()
      local costHp = cardData and cardData.CostHp and cardData:CostHp()
      local stateRed = uid and bg.battleDataCenter.stateData:GetIsCardRedState(uid)
      local stateYellow = uid and bg.battleDataCenter.stateData:GetIsCardYellowState(uid)
      local edgeAlpha = -1
      if cardItem.ui and cardItem.ui.Root_Effect_BianYuan then
        local cg = cardItem.ui.Root_Effect_BianYuan:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
        if cg then
          edgeAlpha = cg.alpha
        end
      end
      local edgeActive = cardItem.ui and cardItem.ui.Root_Effect_BianYuan and cardItem.ui.Root_Effect_BianYuan.activeSelf
      local blueActive = cardItem.ui and cardItem.ui.Effect_Card_BianYuan_Lan_yzw_vx and cardItem.ui.Effect_Card_BianYuan_Lan_yzw_vx.activeSelf
      Logger.Error("[CardGlow] 卡牌#%d uid=%s configId=%s deck=%s canUse=%s checkUsable=%s usable.value=%s highlight=%s " .. "isShowLight=%s interactable=%s isInserting=%s inAnim=%s " .. "cardCamp=%s actionCamp=%s itemMyCamp=%s cardUIMyCamp=%s itemCardUid=%s sameCardRef=%s " .. "blue=%s yellow=%s red=%s costHp=%s stateRed=%s stateYellow=%s edgeAlpha=%.2f edgeActive=%s blueActive=%s", index, tostring(uid), tostring(configId), tostring(deck), tostring(canUse), tostring(checkUsable), tostring(usableVal), tostring(highlightVal), tostring(isShowLight), tostring(interactable), tostring(isInserting), tostring(inAnimation), tostring(cardCamp), tostring(actionCamp), tostring(itemMyCamp), tostring(cardUIMyCamp), tostring(itemCardUid), tostring(sameCardRef), tostring(blueResult), tostring(yellowResult), tostring(redResult), tostring(costHp), tostring(stateRed), tostring(stateYellow), edgeAlpha, tostring(edgeActive), tostring(blueActive))
    end
  end
  Logger.Error("[CardGlow] ===== 诊断完毕 =====")
end

function GmClientUtils.GmCopyBattleStatistic()
  if not bg.lastStastics then
    Alert.ShowStr("没有战斗统计")
    return
  end
  Logger.Warn("战斗统计: " .. bg.lastStastics)
  local textEditor = CS.UnityEngine.TextEditor()
  textEditor.text = bg.lastStastics
  textEditor:OnFocus()
  textEditor:SelectAll()
  textEditor:Copy()
  Alert.ShowStr("复制成功 " .. bg.lastStastics)
end

function GmClientUtils.TestClientDataUtils()
  local mod = require("Data.ClientDataUtils_Test")
  if not mod or not mod.RunInGameTests then
    Logger.Info("无法加载 ClientDataUtils_Test 模块")
    Alert.ShowStr("无法加载测试模块")
    return
  end
  local ok, err = mod.RunInGameTests()
  if ok then
    Logger.Info("ClientDataUtils 真实环境测试全部通过（拉取为异步，详见日志）")
    Alert.ShowStr("ClientDataUtils 真实环境测试通过")
  else
    Logger.Info("ClientDataUtils 真实环境测试失败: ", tostring(err))
    Alert.ShowStr("真实环境测试失败: " .. tostring(err))
  end
end

function GmClientUtils.TestClientDataUtilsInGame()
  GmClientUtils.TestClientDataUtils()
end

function GmClientUtils.GmAddEnergy(pos, addValue)
  print("---------GmClientUtils.GmAddEnergy")
  if bg.battleRender ~= nil then
    print("---------GmClientUtils.GmAddEnergy send command", pos, addValue)
    bg.battleRender:SendCommand(BattleCommand.lg_GM, {
      gm = bc.BattleGMType.AddUtiEnergy,
      pos = pos,
      addValue = addValue
    })
  end
end

function GmClientUtils.GmAddKeeperEnergy(addValue)
  print("---------GmClientUtils.GmAddKeeperEnergy")
  if bg.battleRender ~= nil then
    print("---------GmClientUtils.GmAddKeeperEnergy send command", addValue)
    bg.battleRender:SendCommand(BattleCommand.lg_GM, {
      gm = bc.BattleGMType.AddKeeperEnergy,
      addValue = addValue
    })
  end
end

function GmClientUtils.GmShowLag()
  DataCenter.gameData.ShowLag = not DataCenter.gameData.ShowLag
end

function GmClientUtils.GmRestartBattle()
  if bg.battleRender ~= nil then
    GmClientUtils.BattleLose()
    bg.battleScene:RestartBattle()
  end
end

function GmClientUtils.GmHideAllBattleUI()
  local isPreActive = bg.battlePanel:IsRendering()
  local isActive = not isPreActive
  UIBasePanel.SetRendered(bg.battlePanel, isActive)
  if bg.battleScene and bg.battleScene.uiLayer then
    bg.battleScene.uiLayer.gameObject:SetActive(isActive)
  end
end

function GmClientUtils.GmBattlePanelSwitchVisible()
  if bg.battlePanel then
    local isPreActive = bg.battlePanel:IsRendering()
    UIBasePanel.SetRendered(bg.battlePanel, not isPreActive)
    bg.battlePanel.binder:SetCanvasGroup(bg.battlePanel.root, 1)
    if isPreActive then
      local tipsId = 20002
      local desc = "            战斗界面已隐藏，可使用快捷键进行操作\n            默认快捷键:\n            F1-F4 狂气爆发\n            1-9 出牌\n            "
      Alert.Show(tipsId, nil, nil, nil, desc)
    end
  else
    Alert.ShowStr("请先进入战斗")
  end
end

function GmClientUtils.GmBattlePanelSetVisible(isVisible)
  if not bg.battlePanel then
    return
  end
  UIBasePanel.SetRendered(bg.battlePanel, isVisible)
  bg.battlePanel.binder:SetCanvasGroup(bg.battlePanel.root, 1)
end

function GmClientUtils.GmHideBattleUIAfterUseSkill()
  if not bg.battleRender then
    return
  end
  if not bg.battleRender._preSendCommand then
    bg.battleRender._preSendCommand = bg.battleRender.SendCommand
  end
  
  function bg.battleRender:SendCommand(msgId, msgData)
    local useSkillMsgIds = {
      [BattleCommand.lg_UseUltiSkill] = true,
      [BattleCommand.lg_UseCard] = true,
      [BattleCommand.lg_UseKeeperSkill] = true,
      [BattleCommand.lg_UseSilverKeyAwake] = true,
      [BattleCommand.lg_UseDimensionSkill] = true,
      [BattleCommand.lg_SwitchOceanModel] = true
    }
    if not useSkillMsgIds[msgId] then
      do return bg.battleRender._preSendCommand, bg.battleRender, msgId end
      return bg.battleRender._preSendCommand, bg.battleRender, msgId, msgData, nil, nil, nil, nil
    end
    local tipsId = 20002
    local desc = "点击确定后，将隐藏战斗界面， 2秒后释放技能"
    Alert.Show(tipsId, nil, function()
      GmClientUtils.GmBattlePanelSetVisible(false)
      bg.battleRender:PerformWithDelay(2, function()
        bg.battleRender:_preSendCommand(msgId, msgData)
        bg.battleRender:PerformWithDelay(8, function()
          GmClientUtils.GmBattlePanelSetVisible(true)
        end)
      end)
    end, nil, desc)
  end
end

function GmClientUtils.AutoOpenGameObject(objName)
  GmClientUtils[objName] = CS.UnityEngine.GameObject.Find(objName) or GmClientUtils[objName]
  local gameObj = GmClientUtils[objName]
  if gameObj then
    gameObj:SetActive(not gameObj.activeSelf)
  end
end

function GmClientUtils.GmCloseBattleLight()
  GmClientUtils.AutoOpenGameObject("Light")
end

function GmClientUtils.GmClosePostProcess()
  PerformanceManager.Instance:SwitchPostProcessEffect()
end

function GmClientUtils.GmHideCamp1()
  local battleScene = bg.battleScene
  if not battleScene then
    return
  end
  local roleList = battleScene:GetRoleListByCamp(bc.BattleCamp.Camp1)
  for _, role in pairs(roleList or {}) do
    for _, actor in pairs(role.actorList or {}) do
      actor.rootNode:SetActive(not actor.rootNode.activeSelf)
    end
  end
end

function GmClientUtils.GmHideRoleEffect()
  if bg.battleScene and bg.battleScene.factoryLayer then
    bg.battleScene.factoryLayer.gameObject:SetActive(not bg.battleScene.factoryLayer.gameObject.activeSelf)
  end
  local battleScene = bg.battleScene
  if not battleScene then
    return
  end
  local roleList = battleScene:GetRoleListByCamp(bc.BattleCamp.Camp1)
  local roleList2 = battleScene:GetRoleListByCamp(bc.BattleCamp.Camp2)
  for _, roleList in pairs({roleList, roleList2}) do
    for _, role in pairs(roleList or {}) do
      for _, actor in pairs(role.actorList or {}) do
        for _, actorMount in ipairs({
          "root",
          "eyes",
          "eyes01",
          "eyes02",
          "body",
          "head",
          "Collider",
          "hands"
        }) do
          local attachment = actor.spineComp:GetBoneAttachment(actorMount)
          if attachment then
            attachment.gameObject:SetActive(not attachment.gameObject.activeSelf)
          end
        end
      end
    end
  end
end

function GmClientUtils.GmHideRoleShadow()
  local battleScene = bg.battleScene
  if not battleScene then
    return
  end
  local roleList = battleScene:GetRoleListByCamp(bc.BattleCamp.Camp1)
  local roleList2 = battleScene:GetRoleListByCamp(bc.BattleCamp.Camp2)
  for _, roleList in pairs({roleList, roleList2}) do
    for _, role in pairs(roleList or {}) do
      for _, actor in pairs(role.actorList or {}) do
        local shadowTransform = CS.Framework.GameObjectUtil.DeepFindChild(actor.rootNode.transform, "Shadow_1")
        if shadowTransform then
          shadowTransform.gameObject:SetActive(not shadowTransform.gameObject.activeSelf)
        end
      end
    end
  end
end

function GmClientUtils.GmHideBloom()
  GmClientUtils.ToggleVolumeEffect("Bloom")
end

function GmClientUtils.GmHideVignette()
  GmClientUtils.ToggleVolumeEffect("Vignette")
end

function GmClientUtils.ToggleVolumeEffect(effectName)
  local volumeObj = CS.UnityEngine.GameObject.Find("Volume")
  if not volumeObj then
    return
  end
  local volume = volumeObj:GetComponent(typeof(CS.UnityEngine.Rendering.Volume))
  local profile = volume.profile
  local effect
  if "Bloom" == effectName then
    effect = CS.Framework.UIUtilTool.GetBloom(profile)
  elseif "Vignette" == effectName then
    effect = CS.Framework.UIUtilTool.GetVignette(profile)
  end
  if effect then
    effect.active = not effect.active
  end
end

function GmClientUtils.GmHideBoss()
  local battleScene = bg.battleScene
  if not battleScene then
    return
  end
  local roleList = battleScene:GetRoleListByCamp(bc.BattleCamp.Camp2)
  for _, role in pairs(roleList or {}) do
    for _, actor in pairs(role.actorList or {}) do
      if actor.configData.MonsterClass == bc.MonsterClass.Boss or actor.configData.MonsterClass == bc.MonsterClass.Elite then
        actor.rootNode:SetActive(not actor.rootNode.activeSelf)
      end
    end
  end
end

function GmClientUtils.ReloadConfig()
  local mt = getmetatable(DT)
  mt.ReloadConfig()
  Alert.ShowTopTips("重载配置成功")
end

function GmClientUtils.GmHideBattleScene()
  GmClientUtils.AutoOpenGameObject("Scenes")
end

function GmClientUtils.GmHideSceneEffect()
  local prefab = ResLoadMgr.LoadAsset("Effects/CommonPrefab/huan_xian.prefab", self)
  CS.UnityEngine.GameObject.Instantiate(prefab)
end

function GmClientUtils.GmLoadSfx()
  local prefab = ResLoadMgr.LoadAsset("Effects/CommonEffect/Prefab/E_Co_Jiqi_02.prefab", self)
  CS.UnityEngine.GameObject.Instantiate(prefab)
end

function GmClientUtils.GmPrintRes()
  ResLoadMgr.PrintUnloadTarget()
end

local rtCamera

function GmClientUtils.GMSwitchRTCamera()
  if not rtCamera then
    local obj = CS.UnityEngine.GameObject.Find("Scenes/RTCamera")
    if not obj then
      return
    else
      rtCamera = obj
    end
  end
  rtCamera:SetActive(not rtCamera.activeSelf)
  Logger.Debug("ZZZ GMSwitchRTCamera " .. tostring(rtCamera.activeSelf))
  PerformanceManager.Instance:ChangeMaxFPS(-1)
end

function GmClientUtils.GmPrintAudioBank()
  AudioManager.Instance:PrintLoadedBank()
end

function GmClientUtils.GmSwitchLoginWay()
  local sdkLogin = SdkMgr.Instance:IsSdkLogin()
  SdkMgr.Instance:SetSdkLogin(not sdkLogin)
  LoginMgr.Instance.model:ResetLoginTokens()
  local saveKey = CommonDefine.LocalSaveKeyCommon.SDKLoginType
  MobileFileDataManager.Instance:SetCommFileValue(saveKey, not sdkLogin, true)
end

function GmClientUtils.GmEmbryoGenerateEffect()
  if not bg.battlePanel then
    return
  end
  bg.battlePanel.cardUI:TestNewEmbryoCardsAnimation()
end

function GmClientUtils.GmSwallowEmbryoEffect()
  if not bg.battlePanel then
    return
  end
  bg.battlePanel.cardUI:TestSwallowEmbryoCardsAnimation()
end

function GmClientUtils.GmTestCrash()
  CS.Z1Client.LuaCSharpUtil.TestCrashed()
end

function GmClientUtils.GmTestError()
  Logger.Error("client test error report")
end

function GmClientUtils.GmShowLogConsole()
  local isShowed = GmManager.Instance:IsShowDebugConsoleShowed()
  GmManager.Instance:ShowDebugConsole(not isShowed, true)
end

function GmClientUtils.GmAvgPortrait()
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
  UIManager.Instance:Reopen(Urls.UI_Story_Portrait_TestPanel)
end

function GmClientUtils.GmItemExpiredConvert()
  local convertItemTid
  for tid, cfg in pairs(DT.Item) do
    if cfg.TransItem and #cfg.TransItem > 0 then
      convertItemTid = tid
      break
    end
  end
  if not convertItemTid then
    Alert.ShowStr("未找到带 TransItem 的道具配置，无法测试转换列表")
    return
  end
  local expiredItemList = {}
  table.insert(expiredItemList, {tid = convertItemTid, num = 1})
  table.insert(expiredItemList, {tid = convertItemTid, num = 5})
  UIManager.Instance:Reopen(Urls.ItemExpiredPanel, expiredItemList)
end

function GmClientUtils.GmAwakerPortrait()
  if SceneMgr.Instance:GetSceneType() ~= CommonDefine.SceneType.Town then
    Alert.ShowStr("唤醒体立绘需要进入游戏后验证")
    return
  end
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
  UIManager.Instance:Reopen(Urls.AwakerBasePanel, {testFace = true})
end

function GmClientUtils.GmBattlePortrait()
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
  UIManager.Instance:Reopen(Urls.BattleDbgEntryPanel)
end

function GmClientUtils.GmKeeperSkillShow()
  local skillList = KeeperSkillUtils.GetKeeperSkillList()
  if not skillList or 0 == #skillList then
    Alert.ShowStr("未找到钥令技能配置")
    return
  end
  local skillId = skillList[math.random(1, #skillList)]
  local keeperSkillController = KeeperSkillController.Instance
  keeperSkillController:OpenKeeperSkillObtainView(skillId)
end

function GmClientUtils.GmUIAsyncTime()
  UIAsyncLoadPanel.MockAsyncTime = 3
end

function GmClientUtils.GmGetBattleData()
  local battleEngine = BattleManager.Instance.battleEngine
  if battleEngine and battleEngine.StartBattle then
    bg.battleRender.recordMgr:Reset()
    BattleManager.Instance:ReqStartBattle()
  end
end

local num2LangCodeMap = {
  [1] = "CN",
  [2] = "TW",
  [3] = "EN",
  [4] = "JP",
  [5] = "KR",
  [6] = "RU",
  [7] = "FR",
  [8] = "VN",
  [9] = "TH",
  [10] = "PT",
  [11] = "ID",
  [12] = "ES",
  [13] = "DE",
  [14] = "IT",
  [15] = "TR",
  [16] = "BN"
}

function GmClientUtils.GMSwitchLanguage(targetLangId)
  targetLangId = tonumber(targetLangId)
  if targetLangId and num2LangCodeMap[targetLangId] then
    Main.DisableNextTick()
    SettingManager.Instance:SetTextLanguage(num2LangCodeMap[targetLangId])
    ApplicationUtils.ExitGame()
  end
end

function GmClientUtils.GMHidePlayerInfo()
  EventMgr.Instance.ShowUserInfoText:Dispatch(false)
end

function GmClientUtils.GMSetResolution(setVal)
  SettingManager.Instance:SetResolution(nil, setVal)
end

function GmClientUtils.GMSetWindowResolution(setVal)
  SettingManager.Instance:SetWindowResolution(nil, setVal)
end

function GmClientUtils.GMSetWindowSetting(setVal)
  SettingManager.Instance:SetWindowSetting(nil, setVal)
end

function GmClientUtils.GmStopBattle()
  local AvgDialogPanelNew = UIManager.Instance:GetWindow(Urls.AvgDialogPanelNew)
  if AvgDialogPanelNew then
    AvgDialogPanelNew:ReplayMusic()
  end
end

function GmClientUtils.GmOnLowMemory()
  print("OnLowMemory")
  UIAsyncLoadMgr.Instance:ClearUnusedPanels()
  EventMgr.Instance.OnLowMemory:Dispatch()
  ResGcMgr.Instance:Gc()
end

function GmClientUtils.GmSwitchNewBagSys()
end

function GmClientUtils.GmSetUnlockAllCG()
  GmClientUtils.isUnlockAllCg = true
  UIManager.Instance:Reopen(Urls.ArtCollectionView)
end

function GmClientUtils.GmOpenOST()
  UIManager.Instance:Reopen(Urls.ArtCollectionOSTView)
end

function GmClientUtils.GetStoryTextList()
  local list = {}
  for key, value in pairs(DT.AvgDialog) do
    table.insert(list, {
      id = key,
      text = value.CnID
    })
  end
  return list
end

GmClientUtils.isForbidProtoLog = true

function GmClientUtils.GmOpenProtoLog()
  GmClientUtils.isForbidProtoLog = false
end

function GmClientUtils.GmSeamlessReLogin()
  LoginMgr.Instance:SeamlessReLogin(function()
    print("模拟SeamlessReLogin")
  end)
end

function GmClientUtils.GmOpenAvgLog()
  GmClientUtils.IsEnableAvgLog = true
end

function GmClientUtils.GmAutoTestAvg(avgList)
  if not avgList or 0 == #avgList then
    local list = DT.GetOriginalConstant("AutoTestAvgList", {})
    if not list or 0 == #list then
      Alert.ShowStr("常量表未配置 AutoTestAvgList 或列表为空，请在常量表配置剧情ID数组")
      return
    end
  end
  if 0 == #avgList then
    Alert.ShowStr("无有效剧情ID或剧情配置不存在")
    return
  end
  local runDriver = true
  local total = #avgList
  local currentIndex = 0
  local driverTimerId
  
  local function reportStoryFinish(storyId, index)
    local cfg = DT.AvgDialog[storyId]
    local currentCnID = cfg and cfg.CnID or tostring(storyId)
    local nextStoryId = avgList[index + 1]
    local nextCfg = nextStoryId and DT.AvgDialog[nextStoryId]
    local nextCnID = nextCfg and nextCfg.CnID or nextStoryId and tostring(nextStoryId) or "无"
    local finishInfoContent = string.format("story %s finished %s/%s next %s", currentCnID, index, total, nextCnID)
    Logger.Info("AutoTestAvg ", finishInfoContent)
    Logger.ReportApusInfo("AutoTestAvg {info}", finishInfoContent)
  end
  
  local function playNext()
    currentIndex = currentIndex + 1
    if currentIndex > total then
      runDriver = false
      if driverTimerId then
        TimerManager.Instance:StopTimer(driverTimerId)
        driverTimerId = nil
      end
      Alert.ShowStr("剧情测试完成，共 " .. tostring(total) .. " 条，已上报天燕")
      return
    end
    local storyId = avgList[currentIndex]
    AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
      reportStoryFinish(storyId, currentIndex)
      TimerManager.Instance:CreateTimer(2, 0, nil, playNext)
    end)
    local avgPanel = UIManager.Instance:GetWindow(Urls.AvgDialogPanelNew)
    if avgPanel and avgPanel.binder then
      avgPanel.binder:BindEvent(EventMgr.Instance.StoryStuck, function(storyId, chatIndex)
        UIManager.Instance:CloseByUrl(Urls.AvgDialogPanelNew)
        playNext()
      end)
    end
  end
  
  local function onDriverTick()
    if not runDriver then
      return
    end
    local panel = UIManager.Instance:GetWindow(Urls.AvgDialogPanelNew)
    if not (panel and panel.avgModel) or panel.avgModel:IsEnd() then
      return
    end
    if panel.optionComp and panel.optionComp:IsShowOption() and panel.avgModel.optionIds and #panel.avgModel.optionIds > 0 then
      panel.optionComp:OnChooseOption(1)
      return
    end
    if panel.funcBtnComp then
      panel.funcBtnComp:OnBtnNext()
    end
  end
  
  driverTimerId = TimerManager.Instance:CreateTimer(0.3, -1, onDriverTick, nil)
  playNext()
  Logger.Info("剧情测试开始，共 %s 条剧情", total)
end

function GmClientUtils.GmAutoTestAvgAll()
  local avgList = {}
  for storyId, cfg in pairs(DT.AvgDialog) do
    table.insert(avgList, storyId)
  end
  GmClientUtils.GmAutoTestAvg(avgList)
end

function GmClientUtils.GmSaveCurrentCopyBattleStatistics()
  if not UIManager.Instance:GetWindow(Urls.CopyBattleStatisticsView) then
    Alert.ShowStr("请先打开秘境结算战斗统计界面")
    return
  end
  local recordStageData = CopySettleModel.Instance:GetRecordStageData()
  local settleAwakers = CopySettleModel.Instance:Get_settleAwakerDatas()
  if type(recordStageData) ~= "table" or table.next(recordStageData) == nil then
    Alert.ShowStr("当前没有可保存的秘境统计数据")
    return
  end
  local svrData = {
    teamData = {
      awakers = table.deepclone(settleAwakers or {})
    },
    recordStageData = table.deepclone(recordStageData)
  }
  WorldExitBattleStatisticsPersist.SavePayload(svrData)
  Alert.ShowStr("已保存秘境统计缓存, 之后使用 GM 打开秘境统计缓存 命令打开")
end

function GmClientUtils.GmOpenCopyBattleStatisticsFromSavedWorldExit()
  local svrData = WorldExitBattleStatisticsPersist.TryLoadPayload()
  if not svrData then
    Alert.ShowStr("未找到秘境统计缓存，请先在统计界面点击 GM 保存。\n路径: " .. WorldExitBattleStatisticsPersist.GetSavePath())
    return
  end
  CopySettleModel.Instance:UpdateBySvrData(svrData)
  local recordStageData = CopySettleModel.Instance:GetRecordStageData() or {}
  local settleAwakers = CopySettleModel.Instance:Get_settleAwakerDatas() or {}
  local dungeonStatisticMO = DungeonStatisticMO()
  dungeonStatisticMO:UpdateSourceData(settleAwakers, recordStageData, CommonDefine.TeamAssistPos)
  dungeonStatisticMO:RebuildByScope(0, 0)
  UIManager.Instance:Reopen(Urls.CopyBattleStatisticsView, dungeonStatisticMO)
end

function GmClientUtils.GetBattleReplayDir()
  local rootDir = CS.UnityEngine.Application.persistentDataPath
  if ApplicationUtils.is_editor_mode() then
    rootDir = CS.System.Environment.CurrentDirectory
  end
  return rootDir .. "/BattleReplay"
end

function GmClientUtils.GetBattleReplayJsonFileList()
  local dir = GmClientUtils.GetBattleReplayDir()
  if not CS.System.IO.Directory.Exists(dir) then
    return nil, "BattleReplay 目录不存在:\n" .. dir
  end
  local fileList = CS.System.IO.Directory.GetFiles(dir, "*.json")
  local infoList = {}
  for i = 0, fileList.Length - 1 do
    local filePath = tostring(fileList[i])
    local fileName = string.match(filePath, "[/\\]([^/\\]+)$") or filePath
    table.insert(infoList, {
      fileName = fileName,
      filePath = filePath,
      writeTime = CS.System.IO.File.GetLastWriteTime(filePath).Ticks
    })
  end
  table.sort(infoList, function(a, b)
    return a.writeTime > b.writeTime
  end)
  return infoList
end

function GmClientUtils.GmPlayLocalReplayByPath(filePath)
  if not filePath or "" == filePath then
    Alert.ShowStr("录像文件路径为空")
    return
  end
  local panelOpenMap, panelOpenParams = PVPBattleReplayUtils.GetPanelOpenedInfo()
  UIManager.Instance:CloseByUrl(Urls.GmPanel)
  UIManager.Instance:Reopen(Urls.PVPReplayBattlePanel, "local", nil, function()
    if not bg.battleData then
      return
    end
    PVPBattleReplayUtils.BattleReplayBack(panelOpenMap, panelOpenParams)
  end, filePath)
end

function GmClientUtils.GmSelectLocalBattleReplay()
  local infoList, errMsg = GmClientUtils.GetBattleReplayJsonFileList()
  if not infoList then
    Alert.ShowStr(errMsg)
    return
  end
  if 0 == #infoList then
    Alert.ShowStr("BattleReplay 目录下没有 json 战斗录像\n路径: " .. GmClientUtils.GetBattleReplayDir())
    return
  end
  local list = {}
  for index, info in ipairs(infoList) do
    table.insert(list, {
      id = index,
      text = info.fileName,
      filePath = info.filePath
    })
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    GmClientUtils.GmPlayLocalReplayByPath(data.filePath)
  end, true, "BattleReplay")
end

function GmClientUtils.GmPlayLocalReplay(fileName)
  if not fileName or "" == fileName then
    Alert.ShowStr("请输入录像文件名，如 BattleReplay_xxx 或 BattleReplay_xxx.json")
    return
  end
  local name = fileName:gsub("^BattleReplay/", ""):gsub("^BattleReplay\\", "")
  if not name:match("%.json$") then
    name = name .. ".json"
  end
  GmClientUtils.GmPlayLocalReplayByPath("BattleReplay/" .. name)
end

function GmClientUtils.GmPlayBattleRecord()
  local text = CS.Framework.AssetLoadUtil.OnReadGameFile("battle_record.json")
  local data = JSON.decode(text)
  local record = MobileFileDataManager.Instance:TranslateToLuaTable(data)
  if record.battleData then
    local battleMgr = BattleManager.Instance
    record.battleData.isRecord = true
    record.battleData.svrRunBattle = false
    battleMgr:EnterBattle(record.battleData)
    local timer
    timer = TimerManager.Instance:CreateTimer(1, -1, function()
      local msg = table.remove(record.msgList, 1)
      if msg then
        battleMgr:OnReceiveBattleCommand(msg.msgId, msg.msgData)
      else
        TimerManager.Instance:StopTimer(timer)
      end
    end, nil)
  end
end

function GmClientUtils.GmTestBattleRecord()
  local sceneType = SceneMgr.Instance:GetSceneType()
  BattleReplayUtils.PlayPVPReplay("d665c0de-707a-3838-8fe5-4c10c75aefa8", nil, function()
    if sceneType == cd.SceneType.Login then
      SceneMgr.Instance:EnterLogin()
    else
      SceneMgr.Instance:EnterTown()
    end
  end)
  do return end
  local E = require("ejoysdk_lua.ejoysdk")
  E.HTTP.get("http://s3-report-test.oss-cn-shenzhen.aliyuncs.com/BattleReplay_d665c0de-707a-3838-8fe5-4c10c75aefa8.json", {}, function(resp)
    print("--------------record", resp.body)
    if resp.status ~= 200 then
      do return Logger.Error, "http code %s" end
      return Logger.Error, "http code %s", resp.status, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
    local content = resp.body
    local test = JSON.decode(content)
    local compStr = test.compStr
    local lz4 = require("lz4")
    local decompressedData = lz4.decompress(compStr)
    if not decompressedData then
      error("解压缩失败")
    end
    local unpackedData = cmsgpack.unpack(decompressedData)
    if not unpackedData then
      error("解包失败")
    end
    for key, _ in pairs(unpackedData) do
      print("----------key", key)
    end
    for index, cmd in ipairs(unpackedData.cmds or {}) do
      print("---------- cmd index", index, table.tostring(cmd))
    end
    for index, record in ipairs(unpackedData.records or {}) do
      print("----------index", index, table.tostring(record))
    end
    if unpackedData.battleDat then
      local battleMgr = BattleManager.Instance
      bg.isReplay = true
      unpackedData.battleDat.isRecord = true
      unpackedData.battleDat.svrRunBattle = false
      battleMgr:EnterBattle(unpackedData.battleDat)
      local records = unpackedData.records
      local recordStartTs = records[1] and records[1].time or 0
      local startTs = os.time()
      local timer
      timer = TimerManager.Instance:CreateTimer(1, -1, function()
        while true do
          local msg = records[1]
          if not msg then
            TimerManager.Instance:StopTimer(timer)
            return
          end
          local passedTime = os.time() - startTs
          if recordStartTs + passedTime < (msg.time or 0) then
            return
          end
          print("------------播放下一段录像 passedTime", passedTime, table.tostring(msg, 6))
          table.remove(records, 1)
          battleMgr:OnReceiveBattleCommand(msg.msgId, msg.msgData)
        end
      end, nil)
    end
  end)
end

function GmClientUtils.GmSwitchHuidu()
  if not UIManager.Instance:GetWindow(Urls.LoginPanel) then
    return
  end
  local E = require("ejoysdk_lua.ejoysdk")
  E.CONFIG.autoconfig("", "P11221")
  E.CONFIG.autoconfig({
    server_domain = ".qookkagames.com",
    publish_area = "hk"
  })
  UIManager.Instance:Reopen(Urls.ServerSelect)
  local loginModel = LoginMgr.Instance.model
  loginModel:ResetServerData()
  SdkMgr.Instance._isSdkLogin.value = false
  SdkMgr.Instance:GetServerList()
  SdkMgr.Instance:DelegateEventOnce(SdkConstDefine.SdkFuncListener.GetServerList, function()
    UIManager.Instance:Reopen(Urls.LoginPanel)
    UIManager.Instance:Reopen(Urls.ServerSelect)
  end)
end

function GmClientUtils.OpenRedDotGm()
  GmClientUtils.isRedDotGmOpen = not GmClientUtils.isRedDotGmOpen
  RedDotController.Instance:RefreshAllRedDots(true)
  EventMgr.Instance.OnRedDotGmStatusChanged:Dispatch()
end

function GmClientUtils.GmSwitchInner()
  if not UIManager.Instance:GetWindow(Urls.LoginPanel) then
    return
  end
  print("[steam]IsSteam:%s, IsInitialized:%s", SteamSdk.Instance:IsNativeSteamSdk(), SteamSdk.Instance:IsInitialized())
  local E = require("ejoysdk_lua.ejoysdk")
  E.CONFIG.autoconfig("", "P11104")
  E.CONFIG.autoconfig({server_domain = ".ejoy.com", publish_area = "cn"})
  UIManager.Instance:Reopen(Urls.ServerSelect)
  local loginModel = LoginMgr.Instance.model
  loginModel:ResetServerData()
  
  function ApplicationUtils.IsEditor()
    return true
  end
  
  SdkMgr.Instance._isSdkLogin.value = false
  SdkMgr.Instance:GetServerList()
  SdkMgr.Instance:DelegateEventOnce(SdkConstDefine.SdkFuncListener.GetServerList, function()
    UIManager.Instance:Reopen(Urls.LoginPanel)
    UIManager.Instance:Reopen(Urls.ServerSelect)
    if SteamSdk:IsNativeSteamSdk() then
      TimerManager.Instance:CreateTimer(0.5, 4, function()
        local loginPanel = UIManager.Instance:GetWindow(Urls.LoginPanel)
        if loginPanel then
          local account = SteamSdk.Instance:GetSteamID()
          LoginMgr.Instance.model:SetAccount(account)
          loginPanel.binder:SetText(loginPanel.ui.InputField_Account, account)
        end
      end)
    end
  end)
end

function GmClientUtils.GmOpenAwakerChat(dialogId)
  dialogId = tonumber(dialogId)
  AwakerChatDataUtils.ResetAll()
  DataCenter.communicateData.currList = {dialogId}
  AwakerChatDataUtils.InsertServerData({
    {
      dialogId = dialogId,
      history = {},
      isCompleted = nil,
      completedTime = nil
    }
  })
  MobileFileDataManager.Instance:SetCommFileValue("AvgComTest", 1)
  AwakerChatDataUtils.OpenCurrentMessagePanel()
end

function GmClientUtils.GmKeeperSkillGain(itemId)
  local keeperSkillController = KeeperSkillController.Instance
  keeperSkillController:OpenKeeperSkillObtainView(tonumber(itemId))
end

function GmClientUtils.GmEnterTown()
  SceneMgr.Instance:EnterTown(true)
end

function GmClientUtils.GmExitSettlePanel1()
  SceneMgr.Instance:EnterTown(true)
  UIManager.Instance:Reopen(Urls.ActivityChallengePanel, 55089, 56433, 54893, {})
end

function GmClientUtils.GmExitSettlePanel2()
  SceneMgr.Instance:EnterNull()
  UIManager.Instance:Reopen(Urls.ActivityMainPanel, {
    targetActivityTid = 56433,
    params = {audioPlay = false}
  })
  UIManager.Instance:Reopen(Urls.ActivityChallengePanel, 55089, 56433, 54893, {})
end

function GmClientUtils.GmExitSettlePanel3()
  SceneMgr.Instance:EnterNull()
  UIManager.Instance:Reopen(Urls.ActivityChallengePanel, 55089, 56433, 54893, {})
end

function GmClientUtils.GmAddAwakerCultivationMaterials(count)
  local materialCount = tonumber(count) or 100
  if materialCount <= 0 then
    Alert.ShowStr("数量需大于0")
    return
  end
  local targetSubTypes = {
    ExpMaterial = true,
    SkillMaterial = true,
    WeeklyMaterial = true,
    SpecialMaterial = true
  }
  local materialTidMap = {}
  for tid, cfg in pairs(DT.Item or {}) do
    if cfg and targetSubTypes[cfg.SubType] then
      materialTidMap[tonumber(tid) or 0] = true
    end
  end
  local expItemList = DT.GetOriginalConstant("AwakerExpItem") or {}
  for i = 1, #expItemList, 2 do
    local tid = tonumber(expItemList[i]) or 0
    if 0 ~= tid then
      materialTidMap[tid] = true
    end
  end
  local potencyCostTid = tonumber(DT.GetConstant("AwakerPotencyCostItem") or 0) or 0
  if 0 ~= potencyCostTid then
    materialTidMap[potencyCostTid] = true
  end
  local coinTid = tonumber(DT.GetConstant("GeneralCultivationNeedCurreny") or 0) or 0
  if 0 ~= coinTid then
    materialTidMap[coinTid] = true
  end
  local goldTid = tonumber(DT.GetConstant("GoldItemTid") or 0) or 0
  if 0 ~= goldTid then
    materialTidMap[goldTid] = true
  end
  materialTidMap[10108] = true
  local total = 0
  for tid, _ in pairs(materialTidMap) do
    if 0 ~= tid then
      local addNum = materialCount
      if 10108 == tid then
        addNum = materialCount * 10000
      end
      ProtoManager.Instance:ReqServer("GmRequest", "OnGmCommand", nil, nil, "check_item", {tid = tid, num = addNum})
      total = total + 1
    end
  end
  Alert.ShowStr(string.format("已发放唤醒体养成材料，共%s种，每种%s个", tostring(total), tostring(materialCount)))
end

function GmClientUtils.SkipAvg()
  EventMgr.Instance.SkipDialog:Dispatch()
end

function GmClientUtils.GmExecuteCommand(command)
  local msgData = {
    gm = bc.BattleGMType.ExeCmd,
    cmd = command
  }
  local battleEngine = BattleManager.Instance.battleEngine
  if battleEngine then
    battleEngine:lg_GM(msgData)
  end
end

function GmClientUtils.GmMoveAwaker(fromPos, toPos)
  local msgData = {
    gm = bc.BattleGMType.MoveAwaker,
    fromPos = fromPos,
    toPos = toPos
  }
  local battleEngine = BattleManager.Instance.battleEngine
  if battleEngine then
    battleEngine:lg_GM(msgData)
  end
end

function GmClientUtils.GmSetPosRoleStateLayer(camp, pos, stateId, layer)
  local battleEngine = BattleManager.Instance.battleEngine
  if not battleEngine then
    return
  end
  battleEngine:lg_GM({
    gm = bc.BattleGMType.SetPosRoleStateLayer,
    camp = tonumber(camp) or bc.BattleCamp.Camp1,
    pos = tonumber(pos),
    stateId = tonumber(stateId),
    layer = tonumber(layer) or 0
  })
end

function GmClientUtils.GmSetPosRoleAttr(camp, pos, attrName, attrValue)
  local battleEngine = BattleManager.Instance.battleEngine
  if not battleEngine then
    return
  end
  battleEngine:lg_GM({
    gm = bc.BattleGMType.SetPosRoleAttr,
    camp = tonumber(camp) or bc.BattleCamp.Camp1,
    pos = tonumber(pos),
    attrName = attrName,
    attrValue = tonumber(attrValue)
  })
end

function GmClientUtils.GmPvpDraft(onlyHuman, speedFirst)
  local param = {
    pvpType = PvpDefine.PvpType.Draft,
    onlyHuman = "1" == onlyHuman and true or false,
    speedFirst = "1" == speedFirst and true or false
  }
  PvpController.Instance:ReqOnMatch(param)
end

function GmClientUtils.GmShowLangKey()
  LangManager.Instance:SwitchShowLangKey()
end

function GmClientUtils.SkipAvg()
  EventMgr.Instance.SkipDialog:Dispatch()
end

function GmClientUtils.GmOpenPopupAd()
  local now = TimeUtils.GetServerTime()
  local popupAdList = {}
  for adTid, adCfg in pairs(DT.PopupAd) do
    if now < (adCfg.PopUpStartTime or 0) or now > (adCfg.PopUpEndTime or math.huge) then
    elseif PopupQueManager.Instance:IsPopupAddOpen(adTid) then
      table.insert(popupAdList, adTid)
    end
  end
  if #popupAdList > 0 then
    UIManager.Instance:Reopen(Urls.PopUpAdPanel, popupAdList, function()
    end)
  end
end

function GmClientUtils.GmOpenNewbieGuide()
  local list = {}
  list[1] = {
    text = "所有引导",
    id = 0
  }
  for id, v in pairs(DT.NewbieGuide) do
    table.insert(list, {
      text = v.CnID,
      id = id
    })
  end
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data, index)
    if 0 == data.id then
      for id, v in pairs(DT.NewbieGuide) do
        ClientDataUtils.SetData(cd.ClientDataMainKey.NewbieGuide, id, -1)
        for index, childCfg in ipairs(v.data_list) do
          local key = string.format("%s_%s", id, index)
          ClientDataUtils.SetData(cd.ClientDataMainKey.NewbieGuideCount, key, 0)
        end
      end
    else
      ClientDataUtils.SetData(cd.ClientDataMainKey.NewbieGuide, data.id, -1)
      local v = DT.NewbieGuide[data.id]
      for index, childCfg in ipairs(v.data_list) do
        local key = string.format("%s_%s", data.id, index)
        ClientDataUtils.SetData(cd.ClientDataMainKey.NewbieGuideCount, key, 0)
      end
    end
    NewbieGuideManager.Instance:InitGuideConfig()
  end)
end

function GmClientUtils.GmSkipAllGuide()
  NewbieGuideManager.Instance:GmSkipAllGuide()
end

function GmClientUtils.GmFashionAnimation()
  UIManager.Instance:Reopen(Urls.SummonSkinResultPanel)
end

function GmClientUtils.GmOpenDungeonEvent(eventId)
  if not eventId then
    return
  end
  eventId = tonumber(eventId)
  local gearData = {
    data = {
      eventId = eventId,
      option = {},
      isGmPreview = true
    },
    type = 0,
    tid = 0,
    uid = 0
  }
  local panel = UIManager.Instance:Reopen(Urls.WorldStageEventPanel, gearData)
  panel:SetCallFunc(function(index, selectedEventId)
    Logger.Info("[GM] 选择事件选项 eventId:%s, index:%s", tostring(selectedEventId), tostring(index))
    local newEventCfg = DT.Event[selectedEventId]
    local jumpStr = string.format("ChoiceJump%s", index)
    local newEventId = newEventCfg and newEventCfg[jumpStr]
    if DT.Event[newEventId] then
      gearData.data.eventId = newEventId
      panel:RefreshDataByEventData(gearData)
    else
      UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
    end
  end)
end

function GmClientUtils.GmPrintRedPointData()
  local redPointData = DataCenter.redPointData
  print("GmPrintRedPointData 只打印 DateCenter.redPointData")
  for k, v in pairs(redPointData) do
    print("GmPrintRedPointData", k, table.tostring(v))
  end
end

function GmClientUtils.GmPrintTaskDat(taskId)
  local taskData = TaskDataUtils.GetTaskData(tonumber(taskId))
  print("------------taskData", table.tostring(taskData))
end

function GmClientUtils.GmRetriggerAfterBattleWin(delaySec)
  delaySec = tonumber(delaySec) or 0
  if GmClientUtils._retriggerBattleFinishHandler then
    Alert.ShowStr("已注册监听，等待战斗结束触发")
    return
  end
  local stageComp = WorldStageManager.Instance and WorldStageManager.Instance:GetCurStageComp()
  if not stageComp or not stageComp.map then
    Alert.ShowStr("当前不在副本中")
    return
  end
  local mapOneLineManager = stageComp.map:GetComponent(MapOneLineManager)
  if not mapOneLineManager then
    Alert.ShowStr("当前不是线性/火车副本")
    return
  end
  
  local function doReqStartBattle()
    print("[GM] GmRetriggerAfterBattleWin ReqStartBattle isRunInServer=", BattleManager.Instance and BattleManager.Instance.isRunInServer)
    if not BattleManager.Instance then
      return
    end
    BattleManager.Instance:ReqStartBattle()
  end
  
  function GmClientUtils._retriggerBattleFinishHandler(result)
    EventMgr.Instance.BattleFinish:RemoveEvent(GmClientUtils._retriggerBattleFinishHandler)
    GmClientUtils._retriggerBattleFinishHandler = nil
    print("[GM] GmRetriggerAfterBattleWin BattleFinish received! result=", result)
    if delaySec <= 0 then
      doReqStartBattle()
      return
    end
    TimerManager.Instance:CreateTimer(delaySec, 0, nil, doReqStartBattle)
  end
  
  EventMgr.Instance.BattleFinish:RegisterEvent(GmClientUtils._retriggerBattleFinishHandler)
  print("[GM] GmRetriggerAfterBattleWin registered! delaySec=", delaySec)
  Alert.ShowStr(string.format("已注册：下次战斗结束后 %.1fs 再次 StartBattle", delaySec))
end

function GmClientUtils.GmEnterPatchDownloadPage()
  RpcMgr.Instance:Disconnect()
  SceneMgr.Instance:EnterLogin()
  TimerManager.Instance:CreateTimer(1.5, 0, nil, function()
    local loginPanel = UIManager.Instance:GetWindow(Urls.LoginPanel)
    if not loginPanel then
      Logger.Warn("LoginPanel未就绪，无法切换到下载页")
      return
    end
    loginPanel:_SetDownloadGroupVisible(true)
    local groupName = GroupDownloadMgr.Instance:GetInGameDownloadGroupName()
    local isDownloaded = GroupDownloadMgr.Instance:IsGroupDownload(groupName)
    if not isDownloaded then
      GroupDownloadMgr.Instance:SetUseDownloadDelegate(true)
      local inGameGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
      if not inGameGroup then
        inGameGroup = DownLoadGroup(groupName, true, 3)
        GroupDownloadMgr.Instance._inGameDownloadGroup = inGameGroup
      end
      inGameGroup:SetDelegate(loginPanel)
      inGameGroup:RequestDownLoadGroup()
      GroupDownloadMgr.Instance:CancelDownloadMaxBandWidth()
    else
      loginPanel._slider_Download.value = 1
      loginPanel.binder:SetText(loginPanel.ui.Text_DownloadPrecent, "资源已全部下载完成")
    end
  end)
end

function GmClientUtils.GmOneKeyPassLinearCopy()
  local WorldStageManager = require("Managers.WorldStage.WorldStageManager")
  local AvgStoryManager = require("Managers.AvgStory.AvgStoryManager")
  local MapOneLineManager = require("Managers.WorldStage.NewMap.Manager.MapOneLineManager")
  local stageComp = WorldStageManager.Instance and WorldStageManager.Instance:GetCurStageComp()
  if not stageComp or not stageComp.map then
    Logger.Warn("[GM] 当前不在世界舞台/线性副本中，无法一键通关")
    return
  end
  if not stageComp:IsOneLineMap() then
    Logger.Warn("[GM] 当前关卡不是线性副本/铁道，无法一键通关")
    return
  end
  local mapOneLineManager = stageComp.map:GetComponent(MapOneLineManager)
  if not mapOneLineManager or not mapOneLineManager.gears then
    Logger.Warn("[GM] 未找到线性副本节点管理器")
    return
  end
  local closeUrls = {
    Urls.WorldStageEnterPanel,
    Urls.AlertConfirm2Panel,
    Urls.WorldStageRelicSelectPanel,
    Urls.WorldStageRelicThreeSelectPanel,
    Urls.WorldStageRelicShowPanel,
    Urls.WorldStageSelectSingleCardPanel,
    Urls.WorldStageCardSelectPanel,
    Urls.WorldStageBattleRewardPanel,
    Urls.WorldStageCardFlyPanel,
    Urls.CardFeatureInfoPanel,
    Urls.WorldStageNewShopPanel,
    Urls.CopySpecialShopView,
    Urls.WorldStageAwakerSelectPanel,
    Urls.DbgMainCopyAwakerSelectionPanel,
    Urls.WorldStageCurseCardPanel,
    Urls.WorldStageRemoveCardConfirm,
    Urls.WorldStageShopCardPanel,
    Urls.WorldStageShopConfirmPanel,
    Urls.WorldStageEventPanel
  }
  for _, url in ipairs(closeUrls) do
    if url then
      UIManager.Instance:CloseByUrl(url)
    end
  end
  if mapOneLineManager.StopTick then
    mapOneLineManager:StopTick()
  end
  mapOneLineManager:SetNeedTrigger(false)
  mapOneLineManager._TriggerDatas = {}
  local gears = mapOneLineManager.gears
  local lastUnfinishedIndex
  for i = #gears, 1, -1 do
    local gear = gears[i]
    if gear and not gear.isFinished and (gear.state == nil or gear.state ~= cd.GearState.Finished) then
      lastUnfinishedIndex = i
      break
    end
  end
  if not lastUnfinishedIndex then
    Logger.Info("[GM] 线性副本所有节点已完成，无需处理")
    mapOneLineManager:SetNeedTrigger(true)
    if mapOneLineManager.StartTick then
      mapOneLineManager:StartTick()
      mapOneLineManager:DoTickImmediate()
    end
    return
  end
  AvgStoryManager.Instance:ClearSkipPlot()
  AvgStoryManager.Instance:SetSkipPlot(WorldStageManager.Instance:GetCurStageId())
  local closeUidList = {}
  for i = 1, lastUnfinishedIndex - 1 do
    local gear = gears[i]
    if gear and not gear.isFinished and (gear.state == nil or gear.state ~= cd.GearState.Finished) and gear.uid then
      table.insert(closeUidList, gear.uid)
    end
  end
  if 0 == #closeUidList then
    AvgStoryManager.Instance:ClearSkipPlot()
    mapOneLineManager:SetNeedTrigger(true)
    if mapOneLineManager.StartTick then
      mapOneLineManager:StartTick()
      mapOneLineManager:DoTickImmediate()
    end
    return
  end
  
  local function closeNext(index)
    if index > #closeUidList then
      AvgStoryManager.Instance:ClearSkipPlot()
      mapOneLineManager:SetNeedTrigger(true)
      if mapOneLineManager.StartTick then
        mapOneLineManager:StartTick()
        mapOneLineManager:DoTickImmediate()
      end
      return
    end
    local uid = closeUidList[index]
    if not uid then
      closeNext(index + 1)
      return
    end
    ProtoManager.Instance:ReqServer("WorldRequest", "OnGearClose", function()
      local gearInfo = mapOneLineManager:GetGearInfo(uid)
      if gearInfo then
        gearInfo.isFinished = true
        gearInfo.state = cd.GearState.Finished
      end
      for _, url in ipairs(closeUrls) do
        if url then
          UIManager.Instance:CloseByUrl(url)
        end
      end
      closeNext(index + 1)
    end, function()
      Logger.Warn(string.format("[GM] 结束线性节点失败 uid=%s（仍继续下一节点）", tostring(uid)))
      closeNext(index + 1)
    end, uid)
  end
  
  closeNext(1)
end

function GmClientUtils.GMOpenNetworkProfiler()
  UIManager.Instance:Reopen(Urls.NetworkProfilerView)
end

function GmClientUtils.CollectWordsEffectTags(str)
  local list = {}
  if not str or "" == str then
    return list
  end
  for richKey, id in StrUtils.GmatchWordsEffectTag(str) do
    table.insert(list, {key = richKey, id = id})
  end
  return list
end

function GmClientUtils.CollectEmptyValueWordsEffectKeys(str)
  local keys = {}
  if not str or "" == str then
    return keys
  end
  local index = 1
  while true do
    local startIndex, endIndex = StrUtils.FindNextWordEffectTag(str, index)
    if not startIndex then
      break
    end
    local effectStr = string.sub(str, startIndex + 1, endIndex - 1)
    index = endIndex + 1
    local richKey, id = string.match(effectStr, "^([%w_]+):(.*)$")
    if richKey and "" == id then
      table.insert(keys, richKey)
    end
  end
  return keys
end

function GmClientUtils.WordsEffectTagListHasKey(tagList, key)
  for _, item in ipairs(tagList) do
    if item.key == key then
      return true
    end
  end
  return false
end

function GmClientUtils.RunWordsEffectTagFixtureCases(failList)
  failList = failList or {}
  local enRuntime = "Castor gains <Energy:100> Aliemus. <ExaltIconKeywords:Rouse>: Castor's DMG always critically hits; after playing \"<DerivativeCardKeywords_107:Onyx Plume>,\" inflict [Corrosion:379] <plural value=\"379\" singular=\"stack\" plural=\"stacks\"> of <Corrosion:Corrosion> on the target."
  local pvp45517 = "弃掉所有其他唤醒体的手牌，将等量 + [Arg1] 的随机<PVPMouseKeywords:老鼠牌><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:>置入手中，<PVPPowerIconKeywords:力量> + [Arg2] 。"
  local enTags = GmClientUtils.CollectWordsEffectTags(enRuntime)
  if not GmClientUtils.WordsEffectTagListHasKey(enTags, "Corrosion") then
    table.insert(failList, "[fixture] EN Castor plural 未扫到 Corrosion")
  end
  local pvpTags = GmClientUtils.CollectWordsEffectTags(pvp45517)
  for _, key in ipairs({
    "PVPDerivativeCardKeywords_7",
    "PVPDerivativeCardKeywords_8",
    "PVPDerivativeCardKeywords_9"
  }) do
    if not GmClientUtils.WordsEffectTagListHasKey(pvpTags, key) then
      table.insert(failList, "[fixture] PVP45517 未扫到空标签 " .. key)
    end
  end
  return failList
end

function GmClientUtils.CheckWordsEffectDesc(skillId, desc, failList, stats)
  if not desc or "" == desc or not string.find(desc, "<", 1, true) then
    return
  end
  stats.descCount = stats.descCount + 1
  local tags = GmClientUtils.CollectWordsEffectTags(desc)
  stats.tagCount = stats.tagCount + #tags
  local emptyKeys = GmClientUtils.CollectEmptyValueWordsEffectKeys(desc)
  for _, emptyKey in ipairs(emptyKeys) do
    stats.emptyTagCount = stats.emptyTagCount + 1
    if not GmClientUtils.WordsEffectTagListHasKey(tags, emptyKey) then
      table.insert(failList, string.format("[empty] skill=%s missing %s", tostring(skillId), emptyKey))
    else
      local cfg = DT.WordsEffectConfig and DT.WordsEffectConfig[emptyKey]
      if (not (cfg and cfg.SkillLink) or 0 == cfg.SkillLink or "" == cfg.SkillLink) and (not (cfg and cfg.StateLink) or 0 == cfg.StateLink or "" == cfg.StateLink) then
        stats.emptyNoLinkCount = stats.emptyNoLinkCount + 1
        Logger.Warn(string.format("[WordsEffectScan] skill=%s empty tag %s 无 SkillLink/StateLink，词缀面板仍可能不出说明", tostring(skillId), emptyKey))
      end
    end
  end
  if string.find(string.lower(desc), "<plural", 1, true) then
    stats.pluralDescCount = stats.pluralDescCount + 1
    if string.find(desc, "<Corrosion:", 1, true) then
      stats.pluralCorrosionCount = stats.pluralCorrosionCount + 1
      if not GmClientUtils.WordsEffectTagListHasKey(tags, "Corrosion") then
        table.insert(failList, string.format("[plural] skill=%s 有 Corrosion 标签但未扫到", tostring(skillId)))
      end
    end
  end
end

function GmClientUtils.GmTestWordsEffectTagScan(skillIdFilter)
  local failList = {}
  local stats = {
    descCount = 0,
    tagCount = 0,
    emptyTagCount = 0,
    emptyNoLinkCount = 0,
    pluralDescCount = 0,
    pluralCorrosionCount = 0,
    skillCount = 0
  }
  GmClientUtils.RunWordsEffectTagFixtureCases(failList)
  local filterId = tonumber(skillIdFilter)
  if 0 == filterId then
    filterId = nil
  end
  for skillId, skillCfg in pairs(DT.Skill or {}) do
    if filterId and skillId ~= filterId then
    elseif not skillCfg or not skillCfg.Desc then
    else
      stats.skillCount = stats.skillCount + 1
      local desc = BattleSkillUtils.GetSkillDesc(skillCfg, 0, 0, {}) or ""
      GmClientUtils.CheckWordsEffectDesc(skillId, desc, failList, stats)
    end
  end
  local maxLog = 30
  for i, msg in ipairs(failList) do
    if i > maxLog then
      Logger.Warn(string.format("[WordsEffectScan] ... 其余失败 %d 条省略", #failList - maxLog))
      break
    end
    Logger.Warn("[WordsEffectScan] " .. msg)
  end
  local summary = string.format("词缀标签扫描: skill=%d desc=%d tags=%d empty=%d pluralDesc=%d pluralCorrosion=%d fail=%d emptyNoLinkWarn=%d lang=%s", stats.skillCount, stats.descCount, stats.tagCount, stats.emptyTagCount, stats.pluralDescCount, stats.pluralCorrosionCount, #failList, stats.emptyNoLinkCount, tostring(DataCenter.gameData and DataCenter.gameData.CurrTextLanguage))
  Logger.Info("[WordsEffectScan] " .. summary)
  if 0 == #failList then
    Alert.ShowStr("词缀标签扫描通过\n" .. summary)
  else
    Alert.ShowStr(string.format("词缀标签扫描失败 %d 条\n%s\n详见日志 [WordsEffectScan]", #failList, summary))
  end
end

function GmClientUtils.GmOpenTrinketBind(awakerTid, pos)
  awakerTid = tonumber(awakerTid)
  if not awakerTid or 0 == awakerTid then
    Alert.ShowStr("请填写唤醒体配置id")
    return
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData or not awakerData.tid then
    Alert.ShowStr(string.format("唤醒体(%s)不存在或未拥有", tostring(awakerTid)))
    return
  end
  local part = tonumber(pos)
  if part and (part < 1 or part > CommonDefine.MaxEquipTrinketsNum) then
    Alert.ShowStr(string.format("部位需在1-%s之间", tostring(CommonDefine.MaxEquipTrinketsNum)))
    return
  end
  UIManager.Instance:Reopen(Urls.TrinketAwakerBindView, awakerData, part)
end

function GmClientUtils.GmOpenTrinketUnbind(awakerTid, pos)
  awakerTid = tonumber(awakerTid)
  if not awakerTid or 0 == awakerTid then
    Alert.ShowStr("请填写唤醒体配置id")
    return
  end
  pos = tonumber(pos)
  if pos and 0 ~= pos then
    UIManager.Instance:Reopen(Urls.TrinketAwakerUnBindView, awakerTid, pos)
    return
  end
  UIManager.Instance:Reopen(Urls.TrinketAwakerUnBindView, awakerTid, nil)
end

function GmClientUtils.RegisterClient()
  GmClientUtils.AddClientDynamicGmCommand("剧情表情验证", "GmAvgPortrait")
  GmClientUtils.AddClientDynamicGmCommand("唤醒立绘验证", "GmAwakerPortrait")
  GmClientUtils.AddClientDynamicGmCommand("战斗立绘验证", "GmBattlePortrait")
  GmClientUtils.AddClientDynamicGmCommand("主角技能展示", "GmKeeperSkillShow")
  GmClientUtils.AddClientDynamicGmCommand("多语言Key", "GmShowLangKey")
  GmClientUtils.AddClientDynamicGmCommand("通讯器", "GmOpenAwakerChat", {"chatId"}, {"对话"}, {"number"}, {
    "AvgCommunicate"
  })
  GmClientUtils.AddClientDynamicGmCommand("模拟界面异步", "GmUIAsyncTime")
  GmClientUtils.AddClientDynamicGmCommand("临时解锁所有典藏", "GmSetUnlockAllCG")
  GmClientUtils.AddClientDynamicGmCommand("典藏馆音乐", "GmOpenOST")
  GmClientUtils.AddClientDynamicGmCommand("开启proto日志", "GmOpenProtoLog")
  GmClientUtils.AddClientDynamicGmCommand("SeamlessReLogin", "GmSeamlessReLogin")
  GmClientUtils.AddClientDynamicGmCommand("StartBattle", "GmGetBattleData")
  GmClientUtils.AddClientDynamicGmCommand("StopBattle", "GmStopBattle")
  GmClientUtils.AddClientDynamicGmCommand("OnLowMemory", "GmOnLowMemory")
  GmClientUtils.AddClientDynamicGmCommand("剧情打印", "GmOpenAvgLog")
  GmClientUtils.AddClientDynamicGmCommand("剧情测试", "GmAutoTestAvg")
  GmClientUtils.AddClientDynamicGmCommand("全量剧情测试", "GmAutoTestAvgAll")
  GmClientUtils.AddClientDynamicGmCommand("切灰度服", "GmSwitchHuidu")
  GmClientUtils.AddClientDynamicGmCommand("切内网", "GmSwitchInner")
  GmClientUtils.AddClientDynamicGmCommand("钥令预览", "GmKeeperSkillGain", {"itemId"}, {"钥令"}, {"number"}, {"Item"})
  GmClientUtils.AddClientDynamicGmCommand("打开红点GM", "OpenRedDotGm")
  GmClientUtils.AddClientDynamicGmCommand("切回主界面", "GmEnterTown")
  GmClientUtils.AddClientDynamicGmCommand("执行指令", "GmExecuteCommand", {"command"}, {"指令"}, {"number"}, {"cmd"})
  GmClientUtils.AddClientDynamicGmCommand("移动位置", "GmMoveAwaker", {"from", "to"}, {"from", "to"}, {"number", "number"}, {"number", "number"})
  GmClientUtils.AddClientDynamicGmCommand("跳过剧情", "SkipAvg")
  GmClientUtils.AddClientDynamicGmCommand("一键通关线性副本", "GmOneKeyPassLinearCopy")
  GmClientUtils.AddClientDynamicGmCommand("战胜后重发Trigger", "GmRetriggerAfterBattleWin", {"delaySec"}, {
    "胜利后延迟秒"
  }, {"number"})
  GmClientUtils.AddClientDynamicGmCommand("活动广告弹出", "GmOpenPopupAd")
  GmClientUtils.AddClientDynamicGmCommand("新手引导", "GmOpenNewbieGuide")
  GmClientUtils.AddClientDynamicGmCommand("跳过新手引导", "GmSkipAllGuide")
  GmClientUtils.AddClientDynamicGmCommand("打印红点data", "GmPrintRedPointData")
  GmClientUtils.AddClientDynamicGmCommand("打印任务data", "GmPrintTaskDat", {"taskId"}, {"任务"}, {"number"}, {"Task"})
  GmClientUtils.AddClientDynamicGmCommand("唤醒体养成素材", "GmAddAwakerCultivationMaterials", {"count"}, {"数量"}, {"number"})
  GmClientUtils.AddClientDynamicGmCommand("Pvp轮选模式", "GmPvpDraft", {"onlyHuman", "speedFirst"}, {
    "仅匹配真人",
    "速度优先"
  }, {"number", "number"})
  GmClientUtils.AddClientDynamicGmCommand("播放战斗录像", "GmPlayBattleRecord")
  GmClientUtils.AddClientDynamicGmCommand("选择BattleReplay录像", "GmSelectLocalBattleReplay")
  GmClientUtils.AddClientDynamicGmCommand("播放本地录像", "GmPlayLocalReplay", {"filePath"}, {
    "录像文件路径"
  }, {"string"})
  GmClientUtils.AddClientDynamicGmCommand("保存秘境统计缓存", "GmSaveCurrentCopyBattleStatistics")
  GmClientUtils.AddClientDynamicGmCommand("打开秘境统计缓存", "GmOpenCopyBattleStatisticsFromSavedWorldExit")
  GmClientUtils.AddClientDynamicGmCommand("进入热更下载页", "GmEnterPatchDownloadPage")
  GmClientUtils.AddClientDynamicGmCommand("词缀标签扫描回归", "GmTestWordsEffectTagScan", {"skillId"}, {
    "技能ID(0=全量)"
  }, {"number"})
  GmClientUtils.AddClientDynamicGmCommand("密契绑定界面", "GmOpenTrinketBind", {"awakerTid", "pos"}, {
    "唤醒体id",
    "部位(可选,默认1)"
  }, {"number", "number"})
  GmClientUtils.AddClientDynamicGmCommand("密契解绑界面", "GmOpenTrinketUnbind", {"awakerTid", "pos"}, {
    "唤醒体id",
    "栏位(留空或0=一键解绑)"
  }, {"number", "number"})
  GmClientUtils.AddBattleDynamicGmCommand("战斗界面显隐", "GmBattlePanelSwitchVisible")
  GmClientUtils.AddBattleDynamicGmCommand("隐藏全部战斗界面", "GmHideAllBattleUI")
  GmClientUtils.AddBattleDynamicGmCommand("释放技能后隐藏界面", "GmHideBattleUIAfterUseSkill")
  GmClientUtils.AddBattleDynamicGmCommand("诊断手牌发光", "GmDiagnoseCardGlow")
  GmClientUtils.AddBattleDynamicGmCommand("打印战斗客户端快照", "GmPrintBattleClientSnapshot")
  GmClientUtils.AddBattleDynamicGmCommand("试训设置对象状态", "GmSetPosRoleStateLayer", {
    "camp",
    "pos",
    "stateId",
    "layer"
  }, {
    "阵营(1友2敌)",
    "站位(1-4)",
    "状态ID",
    "层数"
  }, {
    "number",
    "number",
    "number",
    "number"
  }, {
    nil,
    nil,
    "State",
    nil
  })
  GmClientUtils.AddBattleDynamicGmCommand("试训设置对象属性", "GmSetPosRoleAttr", {
    "camp",
    "pos",
    "attrName",
    "attrValue"
  }, {
    "阵营(1友2敌)",
    "站位(1-4)",
    "属性名",
    "属性值"
  }, {
    "number",
    "number",
    "string",
    "number"
  })
end

GmClientUtils.RegisterClient()
return GmClientUtils

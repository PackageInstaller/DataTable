local GuideUtil = {}
local UINTipsGuide = require("Game.Guide.UI.UINTipsGuide")
GuideUtil.TipsGuidePrefabName = "TipsGuide"
local eshowType = require("Game.Guide.GuideEnum").TipsGuideShowType
local cs_coroutine = require("XLua.Common.cs_coroutine")
local cs_WaitForSeconds = CS.UnityEngine.WaitForSeconds

function GuideUtil.GetTipsGuideNodeName(tranName)
  return tranName .. "_" .. GuideUtil.TipsGuidePrefabName
end

function GuideUtil.ShowTipsGuide(curTargetTransform, guidePrefab, show_dir, cfg)
  local objName = GuideUtil.GetTipsGuideNodeName(curTargetTransform.name)
  local tipsGuideObj = guidePrefab:Instantiate(curTargetTransform)
  tipsGuideObj.name = objName
  local tipsGuideNode = UINTipsGuide.New()
  tipsGuideNode:Init(tipsGuideObj)
  local hasCfg = cfg ~= nil
  if hasCfg and cfg.show_type == eshowType.Area then
    tipsGuideNode:ShowUITipsGuideArea(curTargetTransform)
    return tipsGuideNode
  end
  if hasCfg and cfg.show_type == eshowType.Fx then
    tipsGuideNode:ShowUITipsGuideFX(curTargetTransform)
    return tipsGuideNode
  end
  tipsGuideNode:ShowUITipsGuideArrow(curTargetTransform, show_dir)
  return tipsGuideNode
end

function GuideUtil.ShowTipsGuideToggle(curTargetTransform, guidePrefab, show_dir, cfg)
  local tipsGuideNode = GuideUtil.ShowTipsGuide(curTargetTransform, guidePrefab, show_dir, cfg)
  local toggle = curTargetTransform:FindComponent(eUnityComponentID.ExToggle)
  if IsNull(toggle) then
    return
  end
  local luaEvent = CS.LuaBehaviourEvent.AddNew(tipsGuideNode.gameObject)
  
  local function onValueChanged(value)
    if value then
      tipsGuideNode:Hide()
    else
      tipsGuideNode:Show()
    end
  end
  
  onValueChanged(toggle.isOn)
  toggle.onValueChanged:AddListener(onValueChanged)
  luaEvent:onDestroy("+", function()
    if IsNull(toggle) then
      return
    end
    toggle.onValueChanged:RemoveListener(onValueChanged)
  end)
end

function GuideUtil.GetEpFirstRoomTarget()
  if not ExplorationManager:IsInExploration() then
    return nil
  end
  if ExplorationManager.epCtrl == nil then
    return nil
  end
  local roomData = ExplorationManager.epCtrl.mapCtrl.mapData:GetFirstAbleRoomData()
  if roomData == nil then
    return
  end
  local uiRoom = ExplorationManager.epCtrl.mapCtrl:GetRoomUI(roomData.position)
  if uiRoom == nil then
    return nil
  end
  return uiRoom.ui.btn_EpRoom.transform
end

function GuideUtil.GetEpCuroomTarget()
  if not ExplorationManager:IsInExploration() then
    return nil
  end
  if ExplorationManager.epCtrl == nil then
    return nil
  end
  local roomData = ExplorationManager.epCtrl:GetCurrentRoomData(true)
  if roomData == nil then
    return
  end
  local uiRoom = ExplorationManager.epCtrl.mapCtrl:GetRoomUI(roomData.position)
  if uiRoom == nil then
    return nil
  end
  return uiRoom.transform
end

function GuideUtil.GetSpaceAthByAthList(size)
  local uiAth = UIManager:GetWindow(UIWindowTypeID.Ath)
  if uiAth == nil then
    return
  end
  local transform = uiAth.athListNode.athListArea.athScrollList:GetSpaceAthByList(size)
  return transform
end

function GuideUtil.LocationSectorStageItem(stageId, isAvg)
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if window ~= nil then
    local difficultListNode = window:GetDifficultListNode()
    local stageItem = difficultListNode:LocationSectorStageItem(stageId, isAvg)
    return stageItem
  end
  return nil
end

function GuideUtil.TipsGuideSectorLevelItem(id, isAvg, show_dir, cfg)
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if window ~= nil then
    local difficultListNode = window:GetDifficultListNode()
    difficultListNode:SetSectorStageItemTipsGuide(id, isAvg, show_dir)
    return true
  end
  return false
end

function GuideUtil.ClearTipsGuideSectorLevelItem(id, isAvg)
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if window ~= nil then
    local difficultListNode = window:GetDifficultListNode()
    difficultListNode:ClearSectorStageItemTipsGuide(id, isAvg)
  end
end

function GuideUtil.StartBattleDeployGuide(startX, startY, endX, endY)
  local battleMgr = CS.BattleManager.Instance
  if not battleMgr.IsInBattle then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return
  end
  local battleCtrl = battleMgr.CurBattleController
  local startPoint = Vector2.New(startX, startY)
  local endPoint = Vector2.New(endX, endY)
  if not battleCtrl:ContainsRole(startPoint) then
    GuideManager:GetCurGuideCtrl():EndGuide(false)
    return
  end
  local deployGuide = CS.BattleDeployGuideData()
  deployGuide.endAction = GuideUtil.__OnBattleDeployGuideEnd
  deployGuide.startCoord = startPoint
  deployGuide.endCoord = endPoint
  local deployState = battleCtrl.fsm:GetStateFromID(CS.eBattleState.Deploy)
  deployState.guideData = deployGuide
  GuideUtil.__OnBattleDeployGuideStart(deployState, startX, startY, endX, endY)
end

function GuideUtil.__OnBattleDeployGuideStart(deployState, startX, startY, endX, endY)
  UIManager:GetWindow(UIWindowTypeID.Battle):SetBattleCanvasRaycast(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    local startPos = deployState.battleController.battleFieldData:GetGridUnityPos(startX, startY)
    local endPos = deployState.battleController.battleFieldData:GetGridUnityPos(endX, endY)
    local startUIPos = UIManager:World2UIPosition(startPos)
    local endUIPos = UIManager:World2UIPosition(endPos)
    startUIPos = Vector3.New(startUIPos.x, startUIPos.y, 0)
    endUIPos = Vector3.New(endUIPos.x, endUIPos.y, 0)
    window:PlaySlideGuide(startUIPos, endUIPos)
    window:AddSpeicalGuideShowRefresh(function()
      local battleMgr = CS.BattleManager.Instance
      if not battleMgr.IsInBattle then
        return
      end
      local startPos = deployState.battleController.battleFieldData:GetGridUnityPos(startX, startY)
      local endPos = deployState.battleController.battleFieldData:GetGridUnityPos(endX, endY)
      local startUIPos = UIManager:World2UIPosition(startPos)
      local endUIPos = UIManager:World2UIPosition(endPos)
      startUIPos = Vector3.New(startUIPos.x, startUIPos.y, 0)
      endUIPos = Vector3.New(endUIPos.x, endUIPos.y, 0)
      window:PlaySlideGuide(startUIPos, endUIPos)
    end)
    local guideStepCfg = GuideManager:GetCurGuideCtrl().guideStepCfg
    if guideStepCfg ~= nil then
      window:ShowHeroSmallTalk(LanguageUtil.GetLocaleText(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos, startUIPos)
    end
  end)
end

function GuideUtil.__OnBattleDeployGuideEnd(deployState)
  deployState.guideData = nil
  UIManager:GetWindow(UIWindowTypeID.Battle):SetBattleCanvasRaycast(true)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    window:EndSlideGuide()
    window:EndHandClickGuide()
    window:HideHeroTalkDialog()
  end)
  GuideManager:GetCurGuideCtrl():OnCurStepFinish()
end

function GuideUtil.StartBattleDeployClickGuide(endX, endY)
  local battleMgr = CS.BattleManager.Instance
  if not battleMgr.IsInBattle then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return
  end
  local battleCtrl = battleMgr.CurBattleController
  local deployState = battleCtrl.fsm:GetStateFromID(CS.eBattleState.Deploy)
  local deployGuide = CS.BattleDeployGuideData()
  deployGuide.guideType = CS.BattleDeployGuideData.GuideType.ClickRole
  deployGuide.endAction = GuideUtil.__OnBattleDeployGuideEnd
  deployGuide.endCoord = {x = endX, y = endY}
  deployState.guideData = deployGuide
  UIManager:GetWindow(UIWindowTypeID.Battle):SetBattleCanvasRaycast(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    local startPos = deployState.battleController.battleFieldData:GetGridUnityPos(endX, endY)
    local startUIPos = UIManager:World2UIPosition(startPos)
    window:PlayHandClickGuide(startUIPos)
    window:AddSpeicalGuideShowRefresh(function()
      if not battleMgr.IsInBattle then
        return
      end
      local startPos = deployState.battleController.battleFieldData:GetGridUnityPos(endX, endY)
      local startUIPos = UIManager:World2UIPosition(startPos)
      window:PlayHandClickGuide(startUIPos)
    end)
    local guideStepCfg = GuideManager:GetCurGuideCtrl().guideStepCfg
    if guideStepCfg ~= nil then
      window:ShowHeroSmallTalk(LanguageUtil.GetLocaleText(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos, startUIPos)
    end
  end)
end

function GuideUtil.GetBestBenchRoleY()
  local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
  local bestIndex = DeployTeamUtil.banchPosArray[1]
  local battleMgr = CS.BattleManager.Instance
  if not battleMgr.IsInBattle then
    return bestIndex
  end
  local BenchTileModel = battleMgr.CurBattleController.battleFieldData.BenchTileModel
  local maxIndex = BenchTileModel.Length - 1
  for _, index in pairs(DeployTeamUtil.banchPosArray) do
    if index <= maxIndex then
      local tile = BenchTileModel[index]
      if tile ~= nil and tile.role ~= nil then
        bestIndex = index
        break
      end
    end
  end
  return bestIndex
end

function GuideUtil.CancelReturnHomeCv()
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  homeCtrl:NextReturnHomeDontPlayCv(true)
end

function GuideUtil.UnlockOasisMask()
  if not GuideManager.inGuide then
    return
  end
  local mainCamera = UIManager:GetMainCamera()
  if IsNull(mainCamera) then
    GuideManager:GetCurGuideCtrl():EndGuide(false)
    return
  end
  local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
  if IsNull(bind) then
    GuideManager:GetCurGuideCtrl():EndGuide(false)
    return
  end
  TimelineUtil.StopAll()
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeController ~= nil then
    homeController.isRewindingBack2HomeTimeLine = false
  end
  local sectorPlayableDirector = bind:GetBind("sectorPlayableDirector")
  sectorPlayableDirector.time = 0
  sectorPlayableDirector:Evaluate()
  local homeToSectorGo = bind:GetBind("homeToSectorGo")
  homeToSectorGo:SetActive(false)
  local oasisLockNode = bind:GetBind("oasisLockNode")
  oasisLockNode.gameObject:SetActive(true)
  local pd_unlockOasis = bind:GetBind("pd_unlockOasis")
  pd_unlockOasis.time = 0
  pd_unlockOasis:Evaluate()
  local codeActionBinding = pd_unlockOasis:FindComponent(eUnityComponentID.CodeActionBinding)
  codeActionBinding:RegisterAction("PlayAvgAndPause", function()
    TimelineUtil.StopTlCo(GuideUtil.__tlUnlockOasis)
    codeActionBinding:ClearAllAction()
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local avgName = GuideManager:GetCurGuideCtrl().guideStepCfg.avg_name
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:ShowAvg(avgName, function()
      local function continueFunc()
        if PlayerDataCenter.renameCount == 0 then
          PlayerDataCenter.renameCount = 1
        end
        UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
        homeToSectorGo:SetActive(true)
        TimelineUtil.Play(pd_unlockOasis, function()
          GuideUtil.__tlUnlockOasis = nil
          UIManager:HideWindow(UIWindowTypeID.ClickContinue)
          local oasisLockNode = bind:GetBind("oasisLockNode")
          oasisLockNode.gameObject:SetActive(false)
          local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
          if homeWindow ~= nil then
            homeWindow:Show()
          end
          GuideManager:GetCurGuideCtrl():OnCurStepFinish()
        end, true)
      end
      
      local function selectDescribeModeFunc()
        UIManager:ShowWindowAsync(UIWindowTypeID.SettingDescribe, function(win)
          if win == nil then
            continueFunc()
            return
          end
          win:InitSettingDescribe(continueFunc)
        end)
      end
      
      if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeName) and PlayerDataCenter:GetItemCount(ConfigData.game_config.changeNameItemId) >= ConfigData.game_config.changeNameItemNum and PlayerDataCenter.renameCount == 0 and not CloseCustomBename then
        UIManager:ShowWindowAsync(UIWindowTypeID.UserNameCreate, function(window)
          window:InitUIUserNameCreate()
          window:BindUIUserNameAction(selectDescribeModeFunc)
        end)
      else
        selectDescribeModeFunc()
      end
    end)
  end)
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
  GuideUtil.__tlUnlockOasis = TimelineUtil.Play(pd_unlockOasis)
end

function GuideUtil.GetHeroListHeroItem(heroId, needRoll, isFormationQuick)
  local heroSortList
  if isFormationQuick then
    local win = UIManager:GetWindow(UIWindowTypeID.FormationQuick)
    if win == nil then
      return nil
    end
    heroSortList = win.heroSortList
  else
    local win = UIManager:GetWindow(UIWindowTypeID.HeroList)
    if win == nil then
      return nil
    end
    heroSortList = win.heroSortList
  end
  if heroSortList ~= nil then
    local hasHero, heroIndex
    for index, heroData in ipairs(heroSortList.curHeroList) do
      if heroData.dataId == heroId then
        hasHero = true
        heroIndex = index
        break
      end
    end
    if hasHero then
      heroSortList.ui.scrollRest:SrollToCell(heroIndex - 1, 5000)
      local item = heroSortList:__GetHeroItemById(heroId)
      if item ~= nil then
        if isFormationQuick then
          return item.cardItem.transform
        end
        return item.transform
      end
    end
  end
  return nil
end

function GuideUtil.GetNewFmtHeroItem(heroId)
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtWindow == nil then
    return nil
  end
  local heroList = fmtWindow.editNode.showHeroList
  if heroList == nil then
    return
  end
  local heroIndex
  for index, heroData in ipairs(heroList) do
    if heroData.dataId == heroId then
      heroIndex = index
      break
    end
  end
  if heroIndex == nil then
    return nil
  end
  fmtWindow.editNode.ui.cardList:SrollToCell(heroIndex - 1, 10000)
  local heroItem = fmtWindow.editNode:__GetFmtHeroItemByIndex(heroIndex - 1)
  if heroItem ~= nil then
    return heroItem.heroCardItem.transform
  end
  return nil
end

function GuideUtil.GetMailListItem(mailEntry)
  local win = UIManager:GetWindow(UIWindowTypeID.Mail)
  if win == nil then
    return nil
  end
  local mailWin = win
  if mailWin ~= nil then
    local hasMail, mailIndex
    for index, mailData in ipairs(mailWin.mailDataList) do
      if mailData:GetMailEntryCode() == mailEntry then
        hasMail = true
        mailIndex = index
        break
      end
    end
    if hasMail then
      mailWin.ui.loopList_mails:SrollToCell(mailIndex - 1, 5000, function()
        mailWin.ui.loopList_mails:SrollToCell(mailIndex - 1, 5000)
      end)
      do
        local item = mailWin:m_GetItemGoByIndex(mailIndex - 1)
        if item ~= nil then
          return item.transform
        end
      end
    end
  end
  return nil
end

function GuideUtil.SectorForceFocus(fromArg)
  local SectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if SectorCtrl == nil then
    return
  end
  SectorCtrl.camCtrl:SetForceFocus(fromArg)
end

function GuideUtil.SelectLotteryPool(poolId)
  local lotteryWindow = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if lotteryWindow ~= nil then
    lotteryWindow:SelectLotteryPoolById(poolId)
  end
end

function GuideUtil.ScrollLotteryPoolEnd()
  local lotteryWindow = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if lotteryWindow ~= nil then
    lotteryWindow:ScrollLotteryPoolEnd()
  end
end

function GuideUtil.SetGuideShopHeroActive(active)
  local shopWindow = UIManager:GetWindow(UIWindowTypeID.ShopMain)
  if shopWindow == nil then
    return
  end
  local ShopEnum = require("Game.Shop.ShopEnum")
  local recommendNode = shopWindow.shopGoodsNodeDic[ShopEnum.eGoodsShowType.recommend]
  if recommendNode == nil then
    return
  end
  recommendNode:SetInGuideShopHeroActive(active)
end

function GuideUtil.StartFormationGuide(heroId, posId)
  cs_coroutine.start(function()
    local guideWindow = UIManager:GetWindow(UIWindowTypeID.Guide)
    local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
    if guideWindow == nil or fmtWindow == nil then
      GuideManager:SkipGuide()
      return
    end
    guideWindow:SetWaitMaskActive(true)
    coroutine.yield(cs_WaitForSeconds(0.7))
    local heroList = fmtWindow.editNode.showHeroList
    if heroList == nil then
      guideWindow:SetWaitMaskActive(false)
      GuideManager:SkipGuide()
      return
    end
    local heroIndex
    for index, heroData in ipairs(heroList) do
      if heroData.dataId == heroId then
        heroIndex = index
        break
      end
    end
    if heroIndex == nil then
      warn("guide formation not heroId:" .. tostring(heroId))
      guideWindow:SetWaitMaskActive(false)
      GuideManager:SkipGuide()
      return
    end
    local heroTransfrom
    while heroTransfrom == nil do
      heroTransfrom = GuideUtil.GetNewFmtHeroItem(heroId)
      coroutine.yield()
    end
    coroutine.yield(cs_WaitForSeconds(0.3))
    guideWindow:SetWaitMaskActive(false)
    guideWindow:StartLimitGuideOpArea(fmtWindow.ui.guideLimitArea)
    local obj = CS.UnityEngine.GameObject.Find("Formation(Clone)/Scene/BasePlatform" .. tostring(posId))
    if IsNull(obj) then
      warn("guide formation not Platform Id:" .. tostring(posId))
      GuideManager:SkipGuide()
      return
    end
    local destTransfrom = obj.transform
    local startUIPos = UIManager:World2UIPosition(heroTransfrom.position, nil, nil, UIManager.UICamera)
    local endUIPos = UIManager:World2UIPosition(destTransfrom.position)
    startUIPos = Vector3.New(startUIPos.x, startUIPos.y, 0)
    endUIPos = Vector3.New(endUIPos.x, endUIPos.y, 0)
    guideWindow:PlaySlideGuide(startUIPos, endUIPos)
    guideWindow:AddSpeicalGuideShowRefresh(function()
      if IsNull(heroTransfrom) or IsNull(destTransfrom) then
        return
      end
      local startUIPos = UIManager:World2UIPosition(heroTransfrom.position, nil, nil, UIManager.UICamera)
      local endUIPos = UIManager:World2UIPosition(destTransfrom.position)
      startUIPos = Vector3.New(startUIPos.x, startUIPos.y, 0)
      endUIPos = Vector3.New(endUIPos.x, endUIPos.y, 0)
      guideWindow:PlaySlideGuide(startUIPos, endUIPos)
    end)
    local guideStepCfg = GuideManager:GetCurGuideCtrl().guideStepCfg
    if guideStepCfg ~= nil then
      guideWindow:ShowHeroSmallTalk(LanguageUtil.GetLocaleText(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos)
    end
    fmtWindow.editNode:SetFmtEditorGuideData(heroId, posId)
    while not fmtWindow.editNode:IsFmtEditorGuideComplete() do
      coroutine.yield()
    end
    fmtWindow.editNode:ClearFmtEditorGuideData()
    guideWindow:EndLimitGuideOpArea()
    guideWindow:EndSlideGuide()
    guideWindow:EndHandClickGuide()
    guideWindow:HideHeroTalkDialog()
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
  end)
end

function GuideUtil.GetHeroPotentialFmtPlat()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtCtrl == nil or fmtWindow == nil then
    warn("guide get potential formation plat controller or window is null !!")
    return nil
  end
  local heroDic = fmtCtrl:GetFmtCtrlFmtData():GetFormationHeroDic()
  if heroDic == nil then
    warn("guide get potential formation plat hero data dic is null !!")
    return
  end
  local guideIndex = 0
  for index = 1, ConfigData.game_config.max_formation_hero do
    local heroId = heroDic[index]
    if heroId ~= nil then
      local heroInfoItem = fmtWindow.heroInfoDic[heroId]
      if heroInfoItem ~= nil and heroInfoItem:FmtHeroAblePotential() then
        guideIndex = index
        break
      end
    end
  end
  if guideIndex == 0 then
    warn("guide get potential formation plat not a hero able potential !!")
    return nil
  end
  local fmtPlatEntity = fmtCtrl.fmtSceneCtrl:GetFmtPlatEntityByIndex(guideIndex)
  if fmtPlatEntity == nil then
    warn("guide get potential formation plat not a hero able potential !!")
    return nil
  end
  return fmtPlatEntity.transform
end

function GuideUtil.GetHeroQuickLevelUpFmtPlat()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtCtrl == nil or fmtWindow == nil then
    warn("guide get QuickLevelUp formation plat controller or window is null !!")
    return nil
  end
  local ui3dFmt = fmtCtrl.fmtSceneCtrl:Get3DUIFormation()
  if ui3dFmt == nil then
    warn("guide get QuickLevelUp formation 3DUIFormation is null !!")
    return nil
  end
  local platformDic = ui3dFmt:GetPlotformItemDic()
  for index, platItem in pairs(platformDic) do
    if platItem:IsAbleQuickLevelup() then
      return platItem:GetQuickLevelupBtnUI()
    end
  end
  return nil
end

function GuideUtil.StartManualSkillSelectHero(heroId)
  local battleMgr = CS.BattleManager.Instance
  if not battleMgr.IsInBattle then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return
  end
  local battleCtrl = battleMgr.CurBattleController
  local success, x, y = battleCtrl:TryGetCoordByHeroId(heroId)
  if not success then
    warn("can't find battle hero,heroId:" .. tostring(heroId))
    GuideManager:SkipGuide()
    return
  end
  GuideUtil.StartManualSkillSelectCoord(x, y)
end

function GuideUtil.StartManualSkillSelectCoord(x, y)
  local battleMgr = CS.BattleManager.Instance
  if not battleMgr.IsInBattle then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return
  end
  local battleCtrl = battleMgr.CurBattleController
  local playerCtrl = battleCtrl.PlayerController
  local skillGuide = CS.BattleSkillCastGuideData()
  skillGuide.selectX = x
  skillGuide.selectY = y
  skillGuide.endAction = GuideUtil.__OnManualSkillGuideEnd
  playerCtrl:StartSkillCastGuide(skillGuide)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    local startPos = battleCtrl.battleFieldData:GetGridUnityPos(x, y)
    local startUIPos = UIManager:World2UIPosition(startPos)
    window:PlayHandClickGuide(startUIPos)
    window:AddSpeicalGuideShowRefresh(function()
      if not battleMgr.IsInBattle then
        return
      end
      local startPos = battleCtrl.battleFieldData:GetGridUnityPos(x, y)
      local startUIPos = UIManager:World2UIPosition(startPos)
      window:PlayHandClickGuide(startUIPos)
    end)
    local guideStepCfg = GuideManager:GetCurGuideCtrl().guideStepCfg
    if guideStepCfg ~= nil then
      window:ShowHeroSmallTalk(LanguageUtil.GetLocaleText(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos, startUIPos)
    end
  end)
end

function GuideUtil.__OnManualSkillGuideEnd(battleCtrl)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    window:EndSlideGuide()
    window:EndHandClickGuide()
    window:HideHeroTalkDialog()
  end)
  GuideManager:GetCurGuideCtrl():OnCurStepFinish()
end

function GuideUtil.RestartEpBattle()
  local battleMgr = CS.BattleManager.Instance
  if not battleMgr.IsInBattle then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return
  end
  local battleCtrl = battleMgr.CurBattleController
  if Time.unity_time.timeScale > 0 then
    battleCtrl:CallRestartInBattle()
  else
    battleCtrl:RestartBattle()
  end
  GuideManager:GetCurGuideCtrl():OnCurStepFinish()
end

function GuideUtil.GetLotteryFragChangeUI()
  local lotteryResultWindow = UIManager:GetWindow(UIWindowTypeID.LotteryResult)
  if lotteryResultWindow == nil then
    return nil
  end
  return lotteryResultWindow:GetLotteryFragChangeUI()
end

function GuideUtil.SetTimeScale(timeScale)
  timeScale = timeScale or 0
  Time.unity_time.timeScale = timeScale
  GuideManager:GetCurGuideCtrl():OnCurStepFinish()
end

function GuideUtil.StartWarChessDeploy(tIndex, x, y)
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  cs_coroutine.start(function()
    local guideWindow = UIManager:GetWindow(UIWindowTypeID.Guide)
    local wcMain = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
    local deployNode
    if wcMain ~= nil then
      deployNode = wcMain:GetWCDeployNode()
    end
    local warchessCtrl = WarChessManager:GetWarChessCtrl()
    if guideWindow == nil or deployNode == nil or warchessCtrl == nil or warchessCtrl.state ~= eWarChessEnum.eWarChessState.deploy then
      GuideManager:SkipGuide()
      return
    end
    guideWindow:SetWaitMaskActive(true)
    coroutine.yield(cs_WaitForSeconds(1))
    local teamItem = deployNode:GetWCDeployTeamItem(tIndex)
    if teamItem == nil then
      guideWindow:SetWaitMaskActive(false)
      GuideManager:SkipGuide()
      return
    end
    guideWindow:SetWaitMaskActive(false)
    local gridData = warchessCtrl.mapCtrl:GetGridDataByLogicXY(nil, x, y)
    if gridData == nil then
      error(string.format("war chess can't find grid pos,x:%d y:%d", x, y))
      GuideManager:SkipGuide()
      return
    end
    local pos = gridData:GetGridShowPos()
    guideWindow:StartLimitGuideOpArea(deployNode.ui.wcGuideLimitArea)
    local startUIPos = UIManager:World2UIPosition(teamItem.transform.position, nil, nil, UIManager.UICamera)
    local endUIPos = UIManager:World2UIPosition(pos)
    startUIPos = Vector3.New(startUIPos.x, startUIPos.y, 0)
    endUIPos = Vector3.New(endUIPos.x, endUIPos.y, 0)
    guideWindow:PlaySlideGuide(startUIPos, endUIPos)
    guideWindow:AddSpeicalGuideShowRefresh(function()
      if IsNull(teamItem) then
        return
      end
      local pos = gridData:GetGridShowPos()
      local startUIPos = UIManager:World2UIPosition(teamItem.transform.position, nil, nil, UIManager.UICamera)
      local endUIPos = UIManager:World2UIPosition(pos)
      startUIPos = Vector3.New(startUIPos.x, startUIPos.y, 0)
      endUIPos = Vector3.New(endUIPos.x, endUIPos.y, 0)
      guideWindow:PlaySlideGuide(startUIPos, endUIPos)
    end)
    local guideStepCfg = GuideManager:GetCurGuideCtrl().guideStepCfg
    if guideStepCfg ~= nil then
      guideWindow:ShowHeroSmallTalk(LanguageUtil.GetLocaleText(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos)
    end
    local deployState = warchessCtrl.curState
    if deployState == nil then
      guideWindow:SetWaitMaskActive(false)
      GuideManager:SkipGuide()
      return
    end
    deployState:SetWCDeployGuide(tIndex, x, y)
    while not deployState:IsWCDeployGuideComplete() do
      coroutine.yield()
    end
    deployState:ClearWCDeployGuideData()
    guideWindow:EndLimitGuideOpArea()
    guideWindow:EndSlideGuide()
    guideWindow:EndHandClickGuide()
    guideWindow:HideHeroTalkDialog()
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
  end)
end

function GuideUtil.StartWCGridClickGuide(endX, endY)
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  if not WarChessManager:GetIsInWarChess() then
    GuideManager:SkipGuide()
    return
  end
  local warchessCtrl = WarChessManager:GetWarChessCtrl()
  if warchessCtrl.state ~= eWarChessEnum.eWarChessState.play then
    GuideManager:SkipGuide()
    return
  end
  local wcPlayState = warchessCtrl.curState
  wcPlayState:SetWCGridClickGuide(endX, endY, GuideUtil.__OnWCGridClickGuideEnd)
  UIManager:GetWindow(UIWindowTypeID.WarChessMain):SetWCMainCanvasRaycast(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    local gridData = warchessCtrl.mapCtrl:GetGridDataByLogicXY(nil, endX, endY)
    if gridData == nil then
      error(string.format("war chess can't find grid pos,x:%d y:%d", endX, endY))
      GuideManager:SkipGuide()
      return
    end
    local pos = gridData:GetGridShowPos()
    local startUIPos = UIManager:World2UIPosition(pos)
    window:PlayHandClickGuide(startUIPos)
    window:AddSpeicalGuideShowRefresh(function()
      if not WarChessManager:GetIsInWarChess() then
        return
      end
      local pos = gridData:GetGridShowPos()
      local startUIPos = UIManager:World2UIPosition(pos)
      window:PlayHandClickGuide(startUIPos)
    end)
    local guideStepCfg = GuideManager:GetCurGuideCtrl().guideStepCfg
    if guideStepCfg ~= nil then
      window:ShowHeroSmallTalk(LanguageUtil.GetLocaleText(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos, startUIPos)
    end
  end)
end

function GuideUtil.__OnWCGridClickGuideEnd()
  UIManager:GetWindow(UIWindowTypeID.WarChessMain):SetWCMainCanvasRaycast(true)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    if window == nil then
      return window
    end
    window:EndSlideGuide()
    window:EndHandClickGuide()
    window:HideHeroTalkDialog()
  end)
  GuideManager:GetCurGuideCtrl():OnCurStepFinish()
end

function GuideUtil.WCCameraFocus(x, y, time)
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  if not WarChessManager:GetIsInWarChess() then
    GuideManager:SkipGuide()
    return
  end
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  if wcCtrl == nil then
    GuideManager:SkipGuide()
    return
  end
  time = time or 0
  local pos = Vector3.New(x, 0, y)
  wcCtrl.wcCamCtrl:SetWcCamFollowPos(pos, time <= 0)
  if time <= 0 then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
  else
    UIUtil.AddOneCover("GuideUtil")
    GuideUtil._stepTimer = TimerManager:StartTimer(time, function()
      UIUtil.CloseOneCover("GuideUtil")
      GuideUtil._stepTimer = nil
      GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    end, nil, true)
  end
end

function GuideUtil.SetHomeHandBookState(active)
  local home = UIManager:GetWindow(UIWindowTypeID.Home)
  if home == nil or home.homeRightNode == nil then
    return
  end
  home.homeRightNode:SetHomeHandBookBtn(active)
end

function GuideUtil.ActLobbyWaitPopInteractUI(intrctEntityId, overraidSearchName)
  local fallbackTime = 20
  local waittime = Time.realtimeSinceStartup
  UIUtil.AddOneCover("GuideUtil")
  
  local function Finish()
    TimerManager:StopTimer(GuideUtil._stepTimer)
    UIUtil.CloseOneCover("GuideUtil")
    GuideUtil._stepTimer = nil
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
  end
  
  GuideUtil._stepTimer = TimerManager:StartTimer(0.2, function()
    local time = Time.realtimeSinceStartup - waittime
    if time < fallbackTime then
      local targetWindow = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
      if targetWindow ~= nil then
        local targetTrans
        if string.IsNullOrEmpty(overraidSearchName) then
          targetTrans = targetWindow.transform:Find("InteractNode/interactItem_" .. tostring(intrctEntityId))
        else
          targetTrans = targetWindow.transform:Find(overraidSearchName)
        end
        if targetTrans ~= nil and targetTrans.gameObject.activeInHierarchy == true then
          Finish()
        end
      end
      return
    end
    Finish()
  end, nil, false)
end

function GuideUtil:ClearData()
  GuideUtil.__tlUnlockOasis = nil
end

function GuideUtil.ClearOnNetReset()
  if GuideUtil._stepTimer ~= nil then
    TimerManager:StopTimer(GuideUtil._stepTimer)
    GuideUtil._stepTimer = nil
  end
end

function GuideUtil.StartCameraEffect(effectId, arg1, arg2)
  if effectId == 5 then
    local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
    local CameraEffectEnum = CameraEffectUtil.CameraEffectEnum
    CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.CRTScreen](arg1)
  end
  GuideManager:GetCurGuideCtrl():OnCurStepFinish()
end

function GuideUtil.FailedEpFloor()
  if not ExplorationManager:IsInExploration() then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return nil
  end
  ExplorationManager.epCtrl:StartCompleteExploration()
  GuideManager:GetCurGuideCtrl():OnCurStepFinish()
end

function GuideUtil.AVGCheckCondition(ChipId, AvgId, isEndGame)
  local ChipList = ExplorationManager.dynPlayer.epBuffList
  local isChipInList = false
  for _, chip in ipairs(ChipList) do
    if chip.dataId == ChipId then
      isChipInList = true
      break
    end
  end
  if not isChipInList then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return
  end
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(nil, AvgId, function()
    if isEndGame == true or isEndGame == 1 then
      GuideUtil.FailedEpFloor()
      GuideManager:SkipGuide()
      return
    else
      GuideManager:GetCurGuideCtrl():OnCurStepFinish()
      return
    end
  end, false, true, false)
end

function GuideUtil.EndCheckCondition(ChipId)
  local ChipList = ExplorationManager.dynPlayer.epBuffList
  local isChipInList = false
  for _, chip in ipairs(ChipList) do
    if chip.dataId == ChipId then
      isChipInList = true
      break
    end
  end
  if not isChipInList then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return
  end
  GuideUtil.FailedEpFloor()
  GuideManager:SkipGuide()
end

function GuideUtil.BlockRoadByChipId(ChipId, x, y)
  local ChipList = ExplorationManager.dynPlayer.epBuffList
  local isChipInList = false
  for _, chip in ipairs(ChipList) do
    if chip.dataId == ChipId then
      isChipInList = true
      break
    end
  end
  if not isChipInList then
    GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    return
  end
  local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
  local roomData = ExplorationManager.epCtrl.mapData:GetRoomByXY(x, y)
  local tagData = {}
  tagData.param1 = {}
  tagData.tagCatId = ExplorationEnum.eRoomTag.MoveStop
  roomData:SetEpRoomTagData(tagData)
  local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData(true)
  ExplorationManager.epCtrl.mapCtrl:RefreshMapShowState(ExplorationManager:GetDynPlayer():GetOperatorDetail(), curRoomData)
  GuideManager:GetCurGuideCtrl():OnCurStepFinish()
end

function GuideUtil.GetEpRoomTarget(x, y)
  if not ExplorationManager:IsInExploration() then
    return nil
  end
  if ExplorationManager.epCtrl == nil then
    return nil
  end
  local roomData = ExplorationManager.epCtrl.mapData:GetRoomByXY(x, y)
  if roomData == nil then
    return
  end
  local uiRoom = ExplorationManager.epCtrl.mapCtrl:GetRoomUI(roomData.position)
  if uiRoom == nil then
    return nil
  end
  return uiRoom.ui.btn_EpRoom.transform
end

function GuideUtil.PlayEpTip(talkId)
  if not ExplorationManager:IsInExploration() then
    return nil
  end
  if ExplorationManager.epCtrl == nil then
    return nil
  end
  local epTalkCfg = ConfigData.exploration_tip[talkId]
  UIManager:ShowWindowAsync(UIWindowTypeID.EPTalkDialog, function(win)
    if win == nil then
      return
    end
    win:StartEpTalkDialog(epTalkCfg, function()
      GuideManager:GetCurGuideCtrl():OnCurStepFinish()
    end)
  end)
end

return GuideUtil

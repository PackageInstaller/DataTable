_class("UIDiscovery", UIController)
UIDiscovery = UIDiscovery

function UIDiscovery:Constructor()
  self:CreateMapList()
  self._module = self:GetModule(MissionModule)
  self._data = self._module:GetDiscoveryData()
  self._module:InitDiscoveryData()
  self._module:UpdateChapterData()
  self._data.chapterAwardData:Init()
  self._reach = true
  self._nodes = {}
  for _, chapter in pairs(self._data:GetChapters()) do
    for _, node in ipairs(chapter.nodes) do
      self._nodes[node.id] = node
    end
  end
end

function UIDiscovery:CreateMapList()
  self._mapList = {}
  local mapList1 = {
    "first_map_01",
    "first_map_02",
    "first_map_03",
    "first_map_04",
    "first_map_05",
    "first_map_06"
  }
  local mapList2 = {
    "part_map_01",
    "part_map_02",
    "part_map_03",
    "part_map_04",
    "part_map_05",
    "part_map_06"
  }
  local mapList3 = {
    "second_map_01",
    "second_map_02",
    "second_map_03",
    "second_map_04",
    "second_map_05",
    "second_map_06"
  }
  local mapList4 = {
    "diff_map_01",
    "diff_map_02",
    "diff_map_03",
    "diff_map_04",
    "diff_map_05",
    "diff_map_06"
  }
  self._mapList[1] = mapList1
  self._mapList[2] = mapList2
  self._mapList[3] = mapList3
  self._mapList[4] = mapList3
  self._mapList[5] = mapList4
end

function UIDiscovery:LoadDataOnEnter(TT, res, uiParams)
  if GameSingle then
    local diffModule = GameGlobal.GetModule(DifficultyMissionModule)
    local res = diffModule:HandleGetDifficultyMissionData(TT)
    local uiDiffModule = GameGlobal.GetUIModule(DifficultyMissionModule)
    uiDiffModule:Init()
    return
  end
  self.mCampaign = self:GetModule(CampaignModule)
  self._latestCampObj = self.mCampaign:GetLatestCampaignObj(TT)
  self.grassData = self.mCampaign:GetGraveRobberData()
  self.grassData:RequestCampaign(TT)
  local shopModule = GameGlobal.GetModule(ShopModule)
  local resGift = shopModule:ApplyGiftMarketData(TT)
  if not resGift:GetSucc() then
    Log.error("###[UIDiscovery] LoadDataOnEnter ApplyGiftMarketData fail ! result:", resGift:GetResult())
  end
  local diffModule = GameGlobal.GetModule(DifficultyMissionModule)
  local res = diffModule:HandleGetDifficultyMissionData(TT)
  if res:GetSucc() then
    local uiDiffModule = GameGlobal.GetUIModule(DifficultyMissionModule)
    uiDiffModule:Init()
  end
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  res = anipopModule:RequestAnipopInfo(TT)
  if not res:GetSucc() then
    Log.fatal("请求消灭星星数据失败:", res:GetResult())
  end
  local worldBossModule = GameGlobal.GetModule(WorldBossModule)
  local resultWorldBoss = worldBossModule:ReqWorldBossData(TT)
  if not resultWorldBoss:GetSucc() then
    Log.fatal("请求世界Boss数据失败:", resultWorldBoss:GetResult())
  end
  GameGlobal.GetModule(ShopModule):GetLocalPrice()
end

function UIDiscovery:Dispose()
  self._data = nil
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIDiscovery.super:Dispose()
end

StateDiscovery = {
  Init = 0,
  SwitchChapter = 1,
  Move2GrassNode = 2,
  Move2MainNode = 3
}

function UIDiscovery:ChangeDiff(diff)
  self._isDiff = diff
  self:ShowDiffOrNorm()
  self:InitMap()
end

function UIDiscovery:ShowDiffOrNorm()
  self._diffRoot:SetActive(self._isDiff)
  self._normRoot:SetActive(not self._isDiff)
  self._diffBtn:SetActive(false)
  self._normBtn:SetActive(false)
  self._plotBtnGo:SetActive(not self._isDiff)
  self._awardBtnGo:SetActive(not self._isDiff)
  if GameSingle then
    self._awardBtnGo:SetActive(false)
  end
end

function UIDiscovery:OnShow(uiParams)
  CutsceneManager.ExcuteCutsceneOut()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIDiscovery)
  UnityEngine.Input.multiTouchEnabled = true
  self._srRT = self:GetUIComponent("RectTransform", "ScrollView")
  self._imgSR = self:GetUIComponent("Image", "ScrollView")
  local scaleX = self._srRT.rect.width / (self._data.cell_size.x * self._data.col)
  local scaleY = self._srRT.rect.height / (self._data.cell_size.y * self._data.row)
  local scaleXY = Mathf.Max(scaleX, scaleY)
  local scaleValue = Cfg.cfg_global.ui_discovery_content_scale.ArrayValue
  self._scaleMin = Mathf.Max(scaleValue[1], scaleXY)
  self._scaleMax = scaleValue[2]
  self._defaultScale = scaleValue[3]
  self._darkThreshold = scaleValue[4]
  self._scaleStep = 0.5
  self._data.mapScale = self._scaleMin
  self._isDiff = false
  local isDiff = self._data:GetDiffNodeInfo()
  if isDiff then
    self._isDiff = true
  end
  self:InitUI()
  if not GameSingle then
    self:StartTask(self.CheckReturnBackOpen, self)
  end
  self._contentGLG.cellSize = self._data.cell_size
  self._contentGLG.constraintCount = self._data.row
  self._cameraTweener = nil
  local c = self._data:GetCurPosChapter()
  self._chapterId = c.id
  self:InitMap()
  self:_CheckGuide()
  self:CheckDiffBtn()
  self._backBtns = self._ltBtn:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if GameGlobal.UIStateManager():IsShow("UIStage") then
      GameGlobal.UIStateManager():CloseDialog("UIStage")
    else
      local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
      if not jumpData:JumpBack() then
        if GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIMain then
          self:SwitchState(UIStateType.UIMain)
        else
          self:CloseDialog()
        end
      end
    end
  end, function()
    local param
    if self._isDiff then
      param = "UIDiffMission"
    else
      param = "UIDiscovery"
    end
    self:ShowDialog("UIHelpController", param)
  end)
  self.uiCanvas = self:GetGameObject("UICanvas")
  self._uiCanvasGroup = self.uiCanvas.transform:GetComponent("CanvasGroup")
  self._uiCanvasGroup.alpha = 1
  if not GameSingle then
    local enter = self:GetUIComponent("UISelectObjectPath", "enter")
    self.uiDiscoveryEnters = enter:SpawnObject("UIDiscoveryEnters")
    self.uiDiscoveryEnters:Flush(self._data, self._scaleMax, self._uiCanvasGroup, self._latestCampObj)
  end
  local poolActivityIntro = self:GetUIComponent("UISelectObjectPath", "activityIntro")
  poolActivityIntro:SpawnObject("UIDiscoveryIntroEnter")
  self:Flush()
  self._sr:Init(Vector2(self._scaleMin, self._scaleMax), self._scaleStep)
  self:AttachEvent(GameEventType.DiscoveryCameraMove, self.CameraMoveTo)
  self:AttachEvent(GameEventType.DiscoveryPlayerMove, self.GoWalkAlong)
  self:AttachEvent(GameEventType.UpdateChapterAwardData, self.FlushRedChapterAward)
  self:AttachEvent(GameEventType.DiscoveryFlushChapter, self.DiscoveryFlushChapter)
  self:AttachEvent(GameEventType.DiscoveryFlushLines, self.FlushLines)
  self:AttachEvent(GameEventType.DiscoveryShowHideUICanvas, self.ShowHideUICanvas)
  self:AttachEvent(GameEventType.FlushChapterPreview, self.FlushChapterPreview)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnUIOpenClose)
  self:AttachEvent(GameEventType.FlushDiffNodes, self.FlushDiffNodes)
  if not GameSingle then
    self:_PickPetTaskReward()
    self:FlushChapterPreview()
  end
  if EDITOR or IsPc() then
    local contentScale = 1
    self:SetUIEventTrigger(self._sr.gameObject, UIEventTriggerType.Scroll, function(ped)
      contentScale = Mathf.Clamp(contentScale + ped.scrollDelta.y * self._scaleStep, self._scaleMin, self._scaleMax)
      self._sr:UpdateContentScale(contentScale)
    end)
  end
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    self:GetExtEntryBtn():SetActive(false)
    self:GetTowerBtn():SetActive(false)
    self:GetMazeEntryBtn():SetActive(false)
    self:GetWorldBossBtn():SetActive(false)
  end
  GameGlobal.UIStateManager():ShowBusy(false)
  self.fsm = StateMachineManager:GetInstance():CreateStateMachine("StateDiscovery", StateDiscovery)
  self.fsm:SetData(self)
  self.fsm:Init(StateDiscovery.Init)
  if not GameSingle then
    self:SetDisGift()
  end
end

function UIDiscovery:SetDisGift()
  local pool = self:GetUIComponent("UISelectObjectPath", "disGiftPool")
  self._disGiftPool = pool:SpawnObject("UIDiscoveryGift")
  self._disGiftPool:SetData()
end

function UIDiscovery:OnHide()
  self.fsm:SetData(nil)
  StateMachineManager:GetInstance():DestroyStateMachine(self.fsm.Id)
  self.fsm = nil
  UnityEngine.Input.multiTouchEnabled = false
  self._backBtns = nil
  self._sr.OnContentPosChanged = nil
  self._sr.onContentScaleChanged = nil
  self:DetachEvent(GameEventType.DiscoveryCameraMove, self.CameraMoveTo)
  self:DetachEvent(GameEventType.DiscoveryPlayerMove, self.GoWalkAlong)
  self:DetachEvent(GameEventType.UpdateChapterAwardData, self.FlushRedChapterAward)
  self:DetachEvent(GameEventType.DiscoveryFlushChapter, self.DiscoveryFlushChapter)
  self:DetachEvent(GameEventType.DiscoveryFlushLines, self.FlushLines)
  self:DetachEvent(GameEventType.DiscoveryShowHideUICanvas, self.ShowHideUICanvas)
  self:DetachEvent(GameEventType.FlushChapterPreview, self.FlushChapterPreview)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.OnUIOpenClose)
  if self._cameraTweener then
    self._cameraTweener:Kill()
  end
  self:UnLock("UIDiscoveryPetStory")
  self:UnLock("UIDiscoveryWalkDragon")
  UIHelper.RemoveCameraBlur(self._bgCamera)
  if EDITOR then
    self:RemoveUIEventTrigger(self._sr.gameObject, UIEventTriggerType.Scroll)
  end
  if self._eff then
    UIHelper.DestroyGameObject(self._eff)
    self._eff = nil
  end
  if self._shot then
    self._shot:CleanRenderTexture()
  end
  local sModule = GameGlobal.GetModule(SerialAutoFightModule)
  if sModule then
    local jumpData = sModule:GetJumpData()
    if jumpData then
      jumpData:Jump_Clear()
    end
  end
end

function UIDiscovery:InitUI()
  self._scaleCloud = 0.8
  self._diffRoot = self:GetGameObject("diff")
  self._normRoot = self:GetGameObject("norm")
  self._diffNodePool = self:GetUIComponent("UISelectObjectPath", "diffNodePool")
  self._diffRoot:SetActive(self._isDiff)
  self._normRoot:SetActive(not self._isDiff)
  self._sr = self:GetUIComponent("ScalableScrollRect", "ScrollView")
  
  function self._sr.OnContentPosChanged()
    self:UpdateIgnLayoutPos()
  end
  
  function self._sr.onContentScaleChanged(scale)
    self._data.mapScale = scale
    self._ignLayout.localScale = Vector3.one * scale
    self._svCloud.content.localScale = Vector3.one * (self._scaleCloud - (self._scaleMax - scale) / (self._scaleMax - self._scaleMin) * (self._scaleCloud - self._scaleMin))
    local div = 1
    if self._scaleMax > self._darkThreshold then
      div = (self._scaleMax - scale) / (self._scaleMax - self._darkThreshold)
    end
    local divNew = 1 - Mathf.Clamp01(div)
    if scale < self._darkThreshold then
      UIHelper.EnableCameraBlur(self._bgCamera, false)
    else
      UIHelper.EnableCameraBlur(self._bgCamera, true)
      UIHelper.UpdateCameraBlurAlpha(self._bgCamera, divNew)
    end
  end
  
  self.preX = 0
  self.preY = 0
  self._horizontalNormalizedPosition = 0
  self._verticalNormalizedPosition = 0
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._contentGLG = self:GetUIComponent("GridLayoutGroup", "Content")
  self._contentPos = Vector2.zero
  self._glo = self:GetUIComponent("UISelectObjectPath", "Content")
  self._ignLayout = self:GetUIComponent("RectTransform", "IgnoreLayout")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self.poolNodePool = self:GetUIComponent("UISelectObjectPath", "NodePool")
  self.uiDiscoveryNodePool = self.poolNodePool:SpawnObject("UIDiscoveryNodePool")
  self.uiDiscoveryNodePool:Init(self)
  self._linesNextPool = self:GetUIComponent("UISelectObjectPath", "LinesNext")
  local effRoot = self:GetGameObject("effRoot").transform
  self._eff = UIHelper.GetGameObject("UIEff_daditu.prefab")
  self._eff.transform:SetParent(effRoot, false)
  self._svCloud = self:GetUIComponent("ScrollRect", "svCloud")
  local effCloud = UIHelper.GetGameObject("UIEff_Cloud.prefab")
  effCloud.transform:SetParent(self._svCloud.content, false)
  self._svCloud.content.sizeDelta = Vector2(self._data.cell_size.x * self._data.col, self._data.cell_size.y * self._data.row)
  self._cg = self:GetUIComponent("CanvasGroup", "SafeArea")
  if self._data.showUIStage then
    self._cg.alpha = 1
  else
    self._cg.alpha = 0
    self._cg:DOFade(1, 1)
  end
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  local btnChapter = self:GetUIComponent("UISelectObjectPath", "btnChapter")
  self.uiDiscoveryChapterEnter = btnChapter:SpawnObject("UIDiscoveryChapterEnter")
  self.uiDiscoveryChapterEnter:Init(false)
  local bgCanvas = self:GetUIComponent("Canvas", "BGCanvas")
  self._bgCamera = bgCanvas.worldCamera
  self._imgRedChapterAward = self:GetGameObject("imgRedChapterAward")
  self._imgRedChapterAward:SetActive(false)
  UIHelper.AddCameraBlur(self._bgCamera, "map_bantou13_frame", 0)
  self._showHideInUICanvas = {}
  local linesPoolGo = self:GetGameObject("Lines")
  table.insert(self._showHideInUICanvas, linesPoolGo)
  local anchorLeftTop = self:GetGameObject("AnchorLeftTop")
  local anchorTop = self:GetGameObject("AnchorTop")
  local anchorCenter = self:GetGameObject("AnchorCenter")
  local anchorRightBottom = self:GetGameObject("AnchorRightBottom")
  local anchorBottom = self:GetGameObject("AnchorBottom")
  table.insert(self._showHideInUICanvas, anchorLeftTop)
  table.insert(self._showHideInUICanvas, anchorTop)
  table.insert(self._showHideInUICanvas, anchorCenter)
  table.insert(self._showHideInUICanvas, anchorRightBottom)
  table.insert(self._showHideInUICanvas, anchorBottom)
  self.uiAnim = self:GetUIComponent("Animation", "uiAnim")
  self.uiAnim:Play("uieff_Discovery_In")
  self._diffBtn = self:GetGameObject("diffEnter")
  self._normBtn = self:GetGameObject("normEnter")
  self._btnsPos = self:GetUIComponent("RectTransform", "btnsPos")
  self._plotBtnGo = self:GetGameObject("btnPlot")
  self._awardBtnGo = self:GetGameObject("btnChapterAward")
  self.goEffect = self:GetGameObject("effect")
  self.goEffect:SetActive(false)
  self._chapterAwardTxt = self:GetUIComponent("UILocalizationText", "chapterAwardTxt")
  self._downBg = self:GetUIComponent("RawImageLoader", "downBg")
  self._returnBackIntro = self:GetGameObject("returnBackIntro")
  self._diffBtns = self:GetUIComponent("UISelectObjectPath", "diffBtns")
  self:ShowDifficultBtns()
end

function UIDiscovery:_SetAwardStar()
  local chapterData = self._data.chapterAwardData:GetChapterAwardChapterByChapterId(self._chapterId)
  if not chapterData then
    Log.warn("### no award in chapter:", self._chapterId)
  else
    local totalStar = chapterData.grades[table.count(chapterData.grades)].star_count
    self._chapterAwardTxt:SetText(chapterData.star_count .. "/" .. totalStar)
  end
end

function UIDiscovery:UpdateIgnLayoutPos()
  self._ignLayout.anchoredPosition = self._content.anchoredPosition
  self._svCloud.content.anchoredPosition = self._content.anchoredPosition * self._scaleCloud
end

function UIDiscovery:InitMap()
  self:InitSubMap()
  self:InitDownBg()
  self:_SetAwardStar()
end

function UIDiscovery:InitDownBg()
  local downBg
  if self._isDiff then
    downBg = "map_ditu_kuang13"
  else
    downBg = "map_ditu_kuang12"
  end
  self._downBg:LoadImage(downBg)
end

function UIDiscovery:InitSubMap()
  local section = self._data:GetDiscoverySectionByChapterId(self._chapterId)
  local mapList = self:GetMapList(section.id)
  self._glo:SpawnObjects("UIMapSubItem", self._data.row * self._data.col)
  for i, v in ipairs(self._glo:GetAllSpawnList()) do
    v:Flush(i, mapList[i])
  end
end

function UIDiscovery:GetMapList(id)
  if self._isDiff then
    return self._mapList[5]
  else
    return self._mapList[id]
  end
end

function UIDiscovery:GetNodeByNodeId(nodeId)
  for k, v in pairs(self._uiMapNodes) do
    local nodeInfo = v:GetNodeInfo()
    if nodeInfo.id == nodeId then
      return v:GetTip()
    end
  end
end

function UIDiscovery:DiscoveryFlushChapter(chapterId, diff)
  self._chapterId = chapterId
  local isDiff = false
  if diff then
    isDiff = true
  end
  self:ChangeDiff(isDiff)
  self:CheckDiffBtn()
  self.grassData = GameGlobal.GetModule(CampaignModule):GetGraveRobberData()
  local node = self.grassData:GetCanPlayNodeByChapterId(chapterId)
  if self.grassData:IsOpenGraveRobber() and node then
    self._data:UpdatePosByEnter(7, node.stageId)
  else
    self._data:UpdatePosByEnter(2, self._chapterId)
  end
  self.fsm:ChangeState(StateDiscovery.SwitchChapter)
end

function UIDiscovery:CheckReturnBackOpen(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaignType = ECampaignType.CAMPAIGN_TYPE_BACK_PHASE_II
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, campaignType)
  if res:GetSucc() and campaign:CheckCampaignOpen() then
    local component = UIActivityReturnSystemHelper.GetComponentByTabName(campaign, "shop", 2)
    local power2ItemInfo = component:GetComponentInfo()
    local endTime = power2ItemInfo.m_close_time
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    local stamp = endTime - curTime
    if 0 < stamp then
      self._returnBackIntro:SetActive(true)
    else
      self._returnBackIntro:SetActive(false)
    end
    return
  end
  self._returnBackIntro:SetActive(false)
end

function UIDiscovery:ReturnBackBtnOnClick()
  self:ShowDialog("UIActivityReturnSystemTipController")
end

function UIDiscovery:Flush()
  self.uiDiscoveryNodePool:Flush(self._chapterId)
  self:FlushUIDrag()
  self:FlushLines()
  self:FlushCamera()
  self:FlushRed()
  self:FlushUIStage()
  self.uiDiscoveryNodePool:FlushNextChapter()
  self.uiDiscoveryChapterEnter:Flush(self._chapterId)
  self:DiffNodeRoot()
  self:FlushDiffStage()
end

function UIDiscovery:FlushDiffStage()
  if self._data._showDiffStage then
    self._data._showDiffStage = false
  else
    return
  end
  local uiDiffModule = GameGlobal.GetUIModule(DifficultyMissionModule)
  local chapter = uiDiffModule:GetDiffChapterFromMission(self._chapterId)
  local nodeid = self._data._showNodeID
  local node = uiDiffModule:GetNode(nodeid)
  self:ShowDialog("UIDiffStage", chapter, node)
end

function UIDiscovery:FlushUIDrag()
  local uiDrags = self._ignLayout:GetComponentsInChildren(typeof(UIDrag))
  if uiDrags then
    for i = 0, uiDrags.Length - 1 do
      local uiDrag = uiDrags[i]
      uiDrag.ScalableSR = self._sr
    end
  end
end

function UIDiscovery:FlushLines()
  if not self._data then
    return
  end
  local chapter = self._data:GetChapterByChapterId(self._chapterId)
  if not chapter then
    return
  end
  if not chapter.lines or table.count(chapter.lines) <= 0 then
    return
  end
  local tLine = {}
  local len = 0
  for i, node in ipairs(chapter.nodes) do
    if node:State() == DiscoveryStageState.Nomal then
      local tNodeId = chapter.lines[node.id]
      if tNodeId then
        local count = table.count(tNodeId)
        if 0 < count then
          tLine[node.id] = tNodeId
          len = len + count
        end
      end
    end
  end
  self._linesPool:SpawnObjects("UIMapPathItem", len)
  local spawnLines = self._linesPool:GetAllSpawnList()
  local i = 1
  for sNodeId, t in pairs(tLine) do
    local sNode = self._nodes[sNodeId]
    for _, eNodeId in ipairs(t) do
      local eNode = self._nodes[eNodeId]
      if sNode == nil or eNode == nil then
        Log.error("[discovery] s", sNodeId, "e ", eNodeId)
      end
      spawnLines[i]:Flush(sNode, eNode, false)
      i = i + 1
    end
  end
end

function UIDiscovery:FlushCamera()
  if not self._data then
    return
  end
  local node = self._data:GetCurPosNode()
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  local grassData = mCampaign:GetGraveRobberData()
  local grassNodeFirst = grassData:GrassNodeFirst()
  if grassData:IsOpenGraveRobber() and grassNodeFirst then
    grassData:SaveLastNode(grassNodeFirst)
  end
  local targetPos = Vector2.zero
  if self._isDiff then
    local uiDiffModule = GameGlobal.GetUIModule(DifficultyMissionModule)
    local diffChapterID = uiDiffModule:GetDiffCIDByMissionCID(self._chapterId)
    local pos = uiDiffModule:GetMoveNodePos(diffChapterID)
    targetPos = pos
    self._startDiffNodeID = nil
  elseif grassData:IsOpenGraveRobber() and grassNodeFirst then
    grassData:SaveGrassNodeFirst(nil)
    local pos = grassNodeFirst.pos
    targetPos:Set(pos.x, pos.y)
  else
    targetPos:Set(node.pos.x, node.pos.y)
  end
  self:CameraMoveTo(targetPos, 0, self._defaultScale)
end

function UIDiscovery:FlushRed()
  self:FlushRedChapterAward()
end

function UIDiscovery:FlushUIStage()
  if not self._data then
    return
  end
  if self._data.showUIStage then
    self._data.showUIStage = false
  else
    return
  end
  local node = self._data:GetCurPosNode()
  local stage = node.stages[1]
  local stageType = node:GetStageType()
  if stageType == DiscoveryStageType.Plot then
    self:CloseUIStage()
    self:ShowDialog("UIPlotEnter", node, stage, self._chapterId)
    return
  end
  self:OpenOrFlushStage(self._again)
  self._again = false
end

function UIDiscovery:FlushRedChapterAward()
  if not self._data then
    return
  end
  local chapterAwardData = self._data.chapterAwardData
  local c = chapterAwardData:GetChapterAwardChapterByChapterId(self._chapterId)
  if c then
    self._imgRedChapterAward:SetActive(c:CanCollect())
  else
    Log.fatal("### no ChapterAwardChapter in ChapterAwardData. chapterId = ", self._chapterId)
  end
end

function UIDiscovery:btnPlotOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIDiscoveryClick", {"PlotOn"}, true)
  local node = self._data:GetCurPosNode()
  local _canPlayStages = node:GetCanPlayStages()
  local lenStages = table.count(_canPlayStages)
  local _curStage
  if _canPlayStages and 0 < lenStages then
    local _curIdx = lenStages
    _curStage = _canPlayStages[_curIdx]
  end
  local canReviewStages = self._data:GetCanReviewStorys()
  if not canReviewStages or table.count(canReviewStages) <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_discovery_no_can_review_plot"))
    return
  end
  self:ShowDialog("UIPlot", _curStage, canReviewStages)
end

function UIDiscovery:ShowHideUICanvas(isShow)
  for i, v in ipairs(self._showHideInUICanvas) do
    v.gameObject:SetActive(isShow)
  end
end

function UIDiscovery:btnChapterAwardOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIDiscoveryClick", {
    "ChapterAward"
  }, true)
  self:ShowDialog("UIChapterAward", self._chapterId)
end

local function outBackCurve(t, b, c, d, s)
  s = s or 1.70158
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end

function UIDiscovery:CameraMoveTo(target, duration, targetScale, callback, paramsTabel, ignoreLimit, outBack)
  if self:IsHandlingMap() then
    return
  end
  if self._cameraTweener and self._cameraTweener:IsPlaying() then
    return
  end
  if callback then
    callback(paramsTabel)
    return
  end
  local endPos = self:GetContentMoveVector(target)
  local beginScale = self._data.mapScale
  if not ignoreLimit and targetScale then
    targetScale = Mathf.Clamp(targetScale, self._scaleMin, self._scaleMax)
  end
  if duration == -1 then
    local moveMaximumDistance = 1000
    local currentDistance = (self._content.anchoredPosition - endPos).magnitude
    duration = Mathf.Lerp(0, 1, currentDistance / moveMaximumDistance)
  end
  if 0 < duration then
    local lockStr = "UIDiscoveryCameraMoveTo"
    self:StartTask(function(TT)
      self:Lock(lockStr)
      YIELD(TT, duration * 1000)
      self:UnLock(lockStr)
    end, self)
  end
  local tempScale = 0
  local lockStr = "UIDiscoveryCameraMoveTo"
  self:Lock(lockStr)
  self._cameraTweener = self._content:DOAnchorPos(endPos, duration):OnUpdate(function()
    self:UpdateIgnLayoutPos()
    if targetScale then
      local value = 0
      if outBack then
        if self._cameraTweener:ElapsedDirectionalPercentage() < 0.5 then
          value = beginScale + 0.5 * self._cameraTweener:ElapsedDirectionalPercentage()
          tempScale = value
        else
          value = tempScale + (targetScale - tempScale) * self._cameraTweener:ElapsedDirectionalPercentage()
        end
      else
        value = beginScale + (targetScale - beginScale) * self._cameraTweener:ElapsedDirectionalPercentage()
      end
      self._sr:UpdateContentScale(value)
    end
  end):OnComplete(function()
    self:UnLock(lockStr)
    if callback then
      callback(paramsTabel)
    end
  end)
end

function UIDiscovery:GetContentMoveVector(target)
  local endPos = Vector2.zero - target
  if self._content.sizeDelta.x ~= 0 then
    local limitX = self._content.sizeDelta.x * self._defaultScale / 2 - ResolutionManager.ScreenWidth() / 2
    local limitY = self._content.sizeDelta.y * self._defaultScale / 2 - ResolutionManager.ScreenHeight() / 2
    endPos.x = Mathf.Clamp(endPos.x, -limitX, limitX)
    endPos.y = Mathf.Clamp(endPos.y, -limitY, limitY)
  end
  return endPos
end

function UIDiscovery:GoWalkAlong(targetNodeId)
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  local grassData = mCampaign:GetGraveRobberData()
  local nodeGrass = grassData:LastNode()
  if nodeGrass then
    self.fsm:ChangeState(StateDiscovery.Move2MainNode, targetNodeId, function()
      self:WalkOver(targetNodeId)
    end)
  else
    self:WalkAlong(targetNodeId)
  end
end

function UIDiscovery:CameraPos()
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local posScreen = Vector2(UnityEngine.Screen.width, UnityEngine.Screen.height) / 2
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._content, posScreen, camera, nil)
  Log.fatal("### CameraPos", pos)
  return pos
end

function UIDiscovery:WalkAlong(targetNodeId, speedReciprocal)
  self:StartWalk(targetNodeId)
  self:CameraMoveTo(nil, nil, nil, function()
    self:WalkOver(targetNodeId)
  end)
end

function UIDiscovery:GetCurPosNode()
  local node = self._data:GetCurPosNode()
  return node
end

function UIDiscovery:CalcWalkDuration(posStart, posEnd, speedReciprocal)
  speedReciprocal = speedReciprocal or 0.001
  local duration = 0
  local dis = Vector2.Distance(posStart, posEnd)
  duration = dis * speedReciprocal
  return duration
end

function UIDiscovery:StartWalk(targetNodeId)
  local node = self._data:GetCurPosNode()
  if node.id == targetNodeId then
    return
  end
  self._data:SetCurPosNodeId(targetNodeId)
  self:CloseUIStage()
end

function UIDiscovery:WalkOver(targetNodeId)
  local node = self._module:GetNodeDataByNodeId(targetNodeId)
  local stage = node.stages[1]
  if not stage:LevelReach() then
    self._reach = false
  else
    self._reach = true
  end
  local stageType = node:GetStageType()
  if stageType == DiscoveryStageType.Plot then
    self:CloseUIStage()
    self:ShowDialog("UIPlotEnter", node, stage, self._chapterId)
  else
    self:OpenOrFlushStage()
  end
end

function UIDiscovery:CloseUIStage()
  if GameGlobal.UIStateManager():IsShow("UIStage") then
    GameGlobal.UIStateManager():CloseDialog("UIStage")
  end
end

function UIDiscovery:ShotTest2()
  local node = self._data:GetCurPosNode()
  local stage = node.stages[1]
  local stageType = node:GetStageType()
  if stageType == DiscoveryStageType.Plot then
    self:CloseUIStage()
    self:ShowDialog("UIPlotEnter", node, stage, self._chapterId)
    return
  end
end

function UIDiscovery:OpenOrFlushStage(again)
  self:StartTask(function(TT)
    local node = self._data:GetCurPosNode()
    local stage = node.stages[1]
    local stageType = node:GetStageType()
    if stageType == DiscoveryStageType.Plot then
      self:CloseUIStage()
      self:ShowDialog("UIPlotEnter", node, stage, self._chapterId)
      return
    end
    GameGlobal.UAReportForceGuideEvent("UIDiscoveryClickMission", {
      node.id
    }, true)
    self:ShowDialog("UIStage", node.id, self._chapterId, self._reach, again)
  end, self)
end

function UIDiscovery:IsHandlingMap()
  if self._sr then
    return self._sr:IsDragging() or self._sr:IsScaling()
  end
end

function UIDiscovery:_PickPetTaskReward()
end

function UIDiscovery:FlushChapterPreview()
  local missionModule = self:GetModule(MissionModule)
  if not self._chapterPreview then
    self._chapterPreview = {}
    self._chapterPreview.go = self:GetGameObject("chapterPreview")
    self._chapterPreview.icon = self:GetUIComponent("RawImageLoader", "chapteritemicon")
    self._chapterPreview.starCountTxt = self:GetUIComponent("UILocalizationText", "chapterstarcount")
    self._chapterPreview.countTxt = self:GetUIComponent("UILocalizationText", "chapteritemcount")
  end
  if not missionModule:GetShowChapterPreview() then
    self._chapterPreview.go:SetActive(false)
    return
  end
  local _data = missionModule:GetDiscoveryData()
  local chapterData = _data.chapterAwardData:GetChapterAwardChapterByChapterId(self._chapterId)
  self._chapterPreview.go:SetActive(false)
  if chapterData then
    local curMissionId = missionModule:GetCurMissionID()
    local data
    for key, v in pairs(chapterData.previewAward) do
      if curMissionId >= v.startMissionId and curMissionId < v.endMissionId then
        data = v
        break
      end
    end
    if data then
      self._chapterPreview.go:SetActive(true)
      local index = data.index
      local awardIndex = data.awardIndex
      local award = chapterData.grades[index].awards[awardIndex]
      local starCount = chapterData.grades[index].star_count
      local icon = award.icon
      local count = award.count
      self._chapterPreview.starCountTxt:SetText(starCount)
      self._chapterPreview.countTxt:SetText(count)
      self._chapterPreview.icon:LoadImage(icon)
    end
  end
end

function UIDiscovery:OnUIOpenClose()
  UnityEngine.Input.multiTouchEnabled = not self:Manager():IsTopUI(self.name) and self:Manager():GetController("UISpiritDetailLookCgAndSpineController") and self:Manager():IsTopUI("UISpiritDetailLookCgAndSpineController")
end

function UIDiscovery:btnchapterpreviewOnClick()
  self:btnChapterAwardOnClick()
end

function UIDiscovery:GetResEntryBtn()
  return self.uiDiscoveryEnters and self.uiDiscoveryEnters:GetGameObject("btnResEctype")
end

function UIDiscovery:GetMazeEntryBtn()
  return self.uiDiscoveryEnters and self.uiDiscoveryEnters:GetGameObject("btnFairyLand")
end

function UIDiscovery:GetExtEntryBtn()
  return self.uiDiscoveryEnters and self.uiDiscoveryEnters:GetGameObject("btnPetStory")
end

function UIDiscovery:GetTowerBtn()
  return self.uiDiscoveryEnters and self.uiDiscoveryEnters:GetGameObject("btnTower")
end

function UIDiscovery:GetWorldBossBtn()
  return self.uiDiscoveryEnters and self.uiDiscoveryEnters:GetGameObject("btnWorldBoss")
end

function UIDiscovery:GuideToMission(missionID)
  local chapterInfo = Cfg.cfg_mission_chapter({MissionID = missionID})[1]
  self._chapterId = chapterInfo.MainChapterID
  self:ChangeDiff(false)
  self:CheckDiffBtn()
  self._data:UpdatePosByEnter(5, missionID)
  self:Flush()
  return self:GetNodeByNodeId(chapterInfo.WayPointID)
end

function UIDiscovery:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIDiscovery:_GetStoryComponentRemainingTime(targettime)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curtime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  return targettime - curtime
end

function UIDiscovery:ShowAutoTestLogs()
  if EDITOR then
    self:ShowDialog("UIBattleAutoTest")
  end
end

function UIDiscovery:NormBtnOnClick(go)
  local c = self._data:GetChapterByChapterId(self._chapterId)
  local complete = c:IsThreeComplete()
  local lock
  if complete then
    local uiDiffMissionModule = GameGlobal.GetUIModule(DifficultyMissionModule)
    local chapter = uiDiffMissionModule:GetDiffChapterFromMission(self._chapterId)
    if not chapter then
      Log.debug("###[UIDiscovery] no diff ! id --> ", self._chapterId)
      return
    end
    lock = chapter:Lock()
    if lock == DiffMissionChapterStatus.Lock then
      local tips = StringTable.Get("str_diff_mission_lock_by_diff")
      ToastManager.ShowToast(tips)
    else
      self:PlayAnimChangeDiff("uieff_Discovery_switch01", function()
        self:ChangeDiff(true)
        self:ChangeModeUpdateCameraPos()
      end)
    end
  else
    local tips = StringTable.Get("str_diff_mission_lock_by_norm")
    ToastManager.ShowToast(tips)
  end
  return complete, lock
end

function UIDiscovery:DiffBtnOnClick(go)
  self:PlayAnimChangeDiff("uieff_Discovery_switch02", function()
    self:ChangeDiff(false)
    self:ChangeModeUpdateCameraPos()
  end)
end

function UIDiscovery:PlayAnimChangeDiff(animName, callback)
  self:StartTask(function(TT)
    self.goEffect:SetActive(true)
    local key = "UIDiscoveryPlayAnimChangeDiff"
    self:Lock(key)
    self.uiAnim:Play(animName)
    if callback then
      callback()
    end
    YIELD(TT, 1000)
    self.goEffect:SetActive(false)
    self:UnLock(key)
  end, self)
end

function UIDiscovery:ChangeModeUpdateCameraPos()
  self:FlushCamera()
end

function UIDiscovery:CheckDiffBtn()
  if self._isDiff then
    self._diffBtn:SetActive(false)
    self._normBtn:SetActive(false)
    self._plotBtnGo:SetActive(false)
    self._awardBtnGo:SetActive(false)
  else
    self._diffBtn:SetActive(false)
    self._plotBtnGo:SetActive(true)
    self._awardBtnGo:SetActive(true)
    if GameSingle then
      self._awardBtnGo:SetActive(false)
    end
    local open = self:CheckOpenDiff()
    self._normBtn:SetActive(false)
    local btnsPosY = 0
    if not open then
      btnsPosY = 118
    end
    self._btnsPos.anchoredPosition = Vector2(0, btnsPosY)
  end
  self:GetGameObject("diffBtns"):SetActive(self:CheckOpenDiff())
  self._diffBtnRoot:SetChapterId(self._chapterId, self._isDiff)
  self._diffBtnRoot:SetCallBack(function()
    return self:NormBtnOnClick()
  end, function()
    self:DiffBtnOnClick()
  end)
end

function UIDiscovery:CheckOpenDiff()
  if GameSingle then
    return true
  end
  local uiDiffMissionModule = GameGlobal.GetUIModule(DifficultyMissionModule)
  local chapter = uiDiffMissionModule:GetDiffChapterFromMission(self._chapterId)
  if not chapter then
    Log.debug("###[UIDiscovery] no diff ! id --> ", self._chapterId)
    return false
  end
  return true
end

function UIDiscovery:DiffNodeRoot()
  local cfgs = Cfg.cfg_difficulty_mission_chapter_desc({
    PreMainChapterId = self._chapterId
  })
  if cfgs and 0 < #cfgs then
    local cfg = cfgs[1]
    local uiDiffModule = GameGlobal.GetUIModule(DifficultyMissionModule)
    local chapter = uiDiffModule:GetDiffChapterFromMission(self._chapterId)
    local pool = self._diffNodePool:SpawnObject("UIDiffNodeRoot")
    pool:SetData(chapter)
  end
end

function UIDiscovery:FlushDiffNodes(mainChapterID)
  self:DiscoveryFlushChapter(mainChapterID, true)
end

function UIDiscovery:_CheckGuide()
  local cfg = Cfg.cfg_guide_const.guide_diff
  local guideModule = GameGlobal.GetModule(GuideModule)
  if not guideModule:IsGuideDone(128101) then
    local module = GameGlobal.GetModule(RoleModule)
    local isUnLock = module:CheckModuleUnlock(GameModuleID.MD_ANIPOP)
    if isUnLock then
      self:StartTask(function(TT)
        YIELD(TT)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIEliminateController1)
      end)
    end
  elseif not guideModule:IsGuideDone(5044) and cfg and cfg.IntValue == self._chapterId then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIDiscoveryHardLevel)
    self:StartTask(function(TT)
      YIELD(TT)
      if guideModule:IsGuideProcess(5044) then
        self:DiscoveryFlushChapter(12, false)
      end
    end)
  end
end

function UIDiscovery:GetScreenShotView()
  return self._shot
end

function UIDiscovery:ShowDifficultBtns()
  self._diffBtnRoot = self._diffBtns:SpawnObject("UIDiscoveryDiffChaptersWeight")
end

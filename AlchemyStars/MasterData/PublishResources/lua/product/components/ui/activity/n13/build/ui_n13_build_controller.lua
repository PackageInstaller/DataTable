_class("UIN13BuildController", UIController)
UIN13BuildController = UIN13BuildController

function UIN13BuildController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN13BuildController:_SpawnObjects(widgetName, className, count)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local objs = {}
  pool:SpawnObjects(className, count, objs)
  return objs
end

function UIN13BuildController:_SetRawImageBtn(widgetName, size, urlNormal, urlClick, callback)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRawImageBtn")
  obj:SetData(size, urlNormal, urlClick, callback)
end

function UIN13BuildController:_SetRemainingTime(widgetName, descId, endTime, customTimeStr)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIN13BuildController:_PlayAnim(widgetName, animName, time, callback)
  local anim = self:GetUIComponent("Animation", widgetName)
  self:Lock(animName)
  anim:Play(animName)
  self:StartTask(function(TT)
    YIELD(TT, time)
    self:UnLock(animName)
    if callback then
      callback()
    end
  end, self)
end

function UIN13BuildController:_SetCommonTopButton()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:_Back()
  end, nil, nil, false, function()
    self:_HideUI()
  end)
end

function UIN13BuildController:_Back()
  self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIN13MainController, UIStateType.UIMain, nil, self._campaign._id)
end

function UIN13BuildController:_HideUI()
  self:GetGameObject("_showBtn"):SetActive(true)
  self:_PlayAnim("_ani", "uieff_n13_build_main_hide", 333, nil)
  self:GetGameObject("BuildingNames"):SetActive(false)
  self:GetGameObject("BuildingPicnic"):SetActive(false)
end

function UIN13BuildController:_ShowUI()
  self:GetGameObject("_showBtn"):SetActive(false)
  self:_PlayAnim("_ani", "uieff_n13_build_main_show", 333, nil)
  self:GetGameObject("BuildingNames"):SetActive(true)
  self:GetGameObject("BuildingPicnic"):SetActive(true)
end

function UIN13BuildController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N13
  self._componentId = ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  if not self._campaign:CheckComponentOpen(self._componentId) then
    res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId)
    self._campaign._campaign_module:ShowErrorToast(res.m_result, true)
    return
  end
  self._component = self._campaign:GetComponent(self._componentId)
  self._componentInfo = self._component:GetComponentInfo()
end

function UIN13BuildController:_ReLoadDataAndRefresh()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:_Refresh()
  end)
end

function UIN13BuildController:OnShow(uiParams)
  self:SetShowDebug(false, false)
  self:_AttachEvents()
  self._isOpen = true
  UnityEngine.Input.multiTouchEnabled = true
  local dbStr = N13ToolFunctions.GetSakuragariNew()
  local hadSave = not LocalDB.SetInt(dbStr, 1)
  self:_Init()
end

function UIN13BuildController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
  UnityEngine.Input.multiTouchEnabled = false
  if self._cameraTweener then
    self._cameraTweener:Kill()
  end
  self._sr.OnContentPosChanged = nil
  self._sr.onContentScaleChanged = nil
end

function UIN13BuildController:_Init()
  self._content = self:GetUIComponent("RectTransform", "Content")
  self:_SetCommonTopButton()
  self:_SetBg()
  self:_InitBuildManager()
  self:_InitMap()
  self:_InitGotoManager()
  self:_InitScrollView()
  self:_SetPlotBtn()
  self:_SetRewardBtn()
  self:_Refresh()
  self:CheckStory()
end

function UIN13BuildController:_InitBuildManager()
  if not self._buildManager then
    self._buildManager = UIBuildComponentManager:New(self._component)
  end
end

function UIN13BuildController:_InitMap()
  local nodeData = UIUndirectedGraphData:New(Cfg.cfg_n13_map_node({}), Cfg.cfg_n13_map_line({}))
  self:_SetMapNode(nodeData)
  self:_SetMapLine(nodeData)
  if not self._petManager then
    local pool = self:GetUIComponent("UISelectObjectPath", "Nodes")
    local objs = pool:GetAllSpawnList()
    self._petManager = UIN13BuildMapPetManager:New(Cfg.cfg_n13_map_pet({}), nodeData, objs, function(count)
      return self:_SpawnObjects("Pets", "UIN13BuildMapPet", count)
    end, function()
      local seq = self._buildManager:GetPicnicCurSeq()
      local picnicList = self._buildManager:GetBuildItemIdList_Picnic()
      local list = self._buildManager:GetPicnicFixedPetIdList(seq, #picnicList + 1)
      return list
    end, function()
      local cfgs = Cfg.cfg_n13_map_node_picnic({})
      local tb = {}
      for _, v in pairs(cfgs) do
        tb[v.MapNodeId] = true
      end
      return tb
    end, function(petId)
      local seq = self._buildManager:GetPicnicCurSeq()
      local storyType = 2
      local storyId = self._buildManager:GetPicnicStory(seq)
      if storyId and 0 < storyId then
        local storyInfo = {
          storyType,
          storyId,
          0,
          0
        }
        UIActivityN13Helper.PlayStory_Picnic(self._component, storyInfo, function(res)
          if res:GetSucc() then
            Log.info("UIN13BuildMapPet:BtnOnClick() PicnicStory Succ")
          else
            Log.error("UIN13BuildMapPet:BtnOnClick() PicnicStory Failed")
          end
          self:_ReLoadDataAndRefresh()
        end)
      end
    end)
    self._petManager:Start()
  end
end

function UIN13BuildController:_InitGotoManager()
  if not self._gotoManager then
    self._gotoManager = UIN13BuildGotoManager:New(self._buildManager, self._petManager, self:GetGameObject("GotoRoot"), self:_SpawnObjects("GotoRoot", "UIN13BuildGotoBtn", 2), self:_InitGotoPoints(), self._content, function(target)
      local duration = 0.5
      local targetScale = self._defaultScale
      self:CameraMoveTo(target, duration, targetScale)
    end)
    self._gotoManager:Refresh()
  end
end

function UIN13BuildController:_InitGotoPoints()
  local pointName = {
    "_point_top_left",
    "_point_top_right",
    "_point_bottom_left",
    "_point_bottom_right",
    "_point_left_top",
    "_point_left_bottom",
    "_point_right_top",
    "_point_right_bottom"
  }
  local tb = {}
  for _, v in ipairs(pointName) do
    table.insert(tb, self:GetGameObject(v).transform.localPosition)
  end
  return tb
end

function UIN13BuildController:_Refresh()
  self:_SetProgress()
  self:_SetScore()
  self:_SetTime()
  self:_RefreshBuild()
  self:_RefreshMapPet()
  self:_MovePetToBuild()
end

function UIN13BuildController:_RefreshBuild()
  local buildItemIdList = self._buildManager:GetBuildItemIdList()
  self:_SetMapBuildings(buildItemIdList)
  self:_SetMapBuildingNames(buildItemIdList)
  local picnicItemIdList = self._buildManager:GetBuildItemIdList_Picnic()
  self:_SetMapBuildingPicnic(picnicItemIdList)
  self:_SetEffect()
end

function UIN13BuildController:_RefreshMapPet()
  local haveStory = self._buildManager:CheckPicnicHaveStory()
  local seq = self._buildManager:GetPicnicCurSeq()
  local petId = self._buildManager:GetPicnicPet(seq)
  self._petManager:SetPetBtnShow(haveStory and petId or 0)
end

function UIN13BuildController:_MovePetToBuild()
  local cfg = Cfg.cfg_n13_map_pet_setting[1]
  local petLayer = cfg.PetLayer or 0
  local idx = 0
  local buildItemIdList = self._buildManager:GetBuildItemIdList()
  for i, v in ipairs(buildItemIdList) do
    if petLayer < self._buildManager:GetLayer(v) then
      idx = i
      break
    end
  end
  local parent = self:GetUIComponent("Transform", "Buildings")
  local petTrans = self:GetUIComponent("Transform", "Pets")
  petTrans.parent = parent
  petTrans:SetSiblingIndex(idx)
end

function UIN13BuildController:_SetBg()
  local obj = self:GetUIComponent("RawImageLoader", "bg")
  local url = "xueluoyuan_map_kong"
  if url then
    obj:LoadImage(url)
  end
end

function UIN13BuildController:_SetProgress()
  local unlock, all = self._buildManager:CalcBuildUnlockProgress()
  local txt = math.floor(unlock * 100 / all) .. "%"
  local obj = self:GetUIComponent("UILocalizationText", "_txtProgress")
  obj:SetText(txt)
end

function UIN13BuildController:_SetScore()
  local obj = self:_SpawnObject("_score", "UIN13BuildScore")
  obj:SetData()
end

function UIN13BuildController:_SetTime()
  local endTime = self._componentInfo.m_close_time
  self:_SetRemainingTime("_remainingTime", "str_n13_line_mission_remaining_time", endTime, nil)
end

function UIN13BuildController:_SetPlotBtn()
  self:_SetRawImageBtn("PlotReviewBtn", Vector2(415, 213), "n13_xly_btn03", "n13_xly_btn04", function()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SakuraCommonClick)
    self:ShowDialog("UIN13BuildPlotController", self._buildManager)
  end)
end

function UIN13BuildController:_SetRewardBtn()
  self:_SetRawImageBtn("RewardBtn", Vector2(488, 242), "n13_xly_btn01", "n13_xly_btn02", function()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    self:ShowDialog("UIN13BuildRewardController", self._buildManager)
  end)
end

function UIN13BuildController:_InitScrollView()
  self._cameraTweener = nil
  self._scaleMin = Mathf.Max(0.5, self:_CalcMinScale())
  self._scaleMax = 1
  self._scaleStep = 0.1
  self._defaultScale = 1
  self._curScale = self._defaultScale
  self:_SetScrollView()
  local target = Vector2(-200, -200)
  local duration = 0
  local targetScale = self._defaultScale
  self:CameraMoveTo(target, duration, targetScale)
end

function UIN13BuildController:_CalcMinScale()
  self._srRT = self:GetUIComponent("RectTransform", "ScrollView")
  local rtBg = self:GetUIComponent("RectTransform", "bg")
  local scaleX = self._srRT.rect.width / rtBg.rect.width
  local scaleY = self._srRT.rect.height / rtBg.rect.height
  return Mathf.Max(scaleX, scaleY)
end

function UIN13BuildController:_SetScrollView()
  self._srRT = self:GetUIComponent("RectTransform", "ScrollView")
  self._sr = self:GetUIComponent("ScalableScrollRect", "ScrollView")
  self._sr:Init(Vector2(self._scaleMin, self._scaleMax), self._scaleStep)
  
  function self._sr.OnContentPosChanged()
    self._gotoManager:Refresh()
  end
  
  function self._sr.onContentScaleChanged(scale)
    Log.info("self._sr.onContentScaleChanged")
    self._curScale = scale
    self._sr:UpdateContentScale(scale)
    self._gotoManager:Refresh()
  end
  
  if EDITOR or IsPc() then
    local contentScale = 1
    self:SetUIEventTrigger(self._sr.gameObject, UIEventTriggerType.Scroll, function(ped)
      contentScale = Mathf.Clamp(contentScale + ped.scrollDelta.y * self._scaleStep, self._scaleMin, self._scaleMax)
      self._sr:UpdateContentScale(contentScale)
    end)
  end
end

function UIN13BuildController:IsHandlingMap()
  if self._sr then
    return self._sr:IsDragging() or self._sr:IsScaling()
  end
end

function UIN13BuildController:CameraMoveTo(target, duration, targetScale, callback, paramsTabel, ignoreLimit, outBack)
  if self:IsHandlingMap() then
    return
  end
  if self._cameraTweener and self._cameraTweener:IsPlaying() then
    return
  end
  local endPos = self:GetContentMoveVector(target)
  local beginScale = self._curScale
  if not ignoreLimit and targetScale then
    targetScale = Mathf.Clamp(targetScale, self._scaleMin, self._scaleMax)
  end
  if duration == -1 then
    local moveMaximumDistance = 1000
    local currentDistance = (self._content.anchoredPosition - endPos).magnitude
    duration = Mathf.Lerp(0, 1, currentDistance / moveMaximumDistance)
  end
  if 0 < duration then
    local lockStr = "UIN13BuildController_CameraMoveTo"
    self:StartTask(function(TT)
      self:Lock(lockStr)
      YIELD(TT, duration * 1000)
      self:UnLock(lockStr)
    end, self)
  end
  local tempScale = 0
  self._cameraTweener = self._content:DOAnchorPos(endPos, duration):OnUpdate(function()
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
    if callback then
      callback(paramsTabel)
    end
  end)
end

function UIN13BuildController:GetContentMoveVector(target)
  local endPos = Vector2.zero - target
  if self._content.sizeDelta.x ~= 0 then
    local limitX = self._content.sizeDelta.x * self._defaultScale / 2 - ResolutionManager.ScreenWidth() / 2
    local limitY = self._content.sizeDelta.y * self._defaultScale / 2 - ResolutionManager.ScreenHeight() / 2
    endPos.x = Mathf.Clamp(endPos.x, -limitX, limitX)
    endPos.y = Mathf.Clamp(endPos.y, -limitY, limitY)
  end
  return endPos
end

function UIN13BuildController:_SetMapBuildings(buildItemIdList)
  local buildingItems = self:_SpawnObjects("Buildings", "UIN13BuildItem", table.count(buildItemIdList))
  for i = 1, #buildingItems do
    local item = buildingItems[i]
    item:SetData(self._buildManager, buildItemIdList[i])
  end
end

function UIN13BuildController:_SetMapBuildingNames(buildItemIdList)
  local buildingItems = self:_SpawnObjects("BuildingNames", "UIN13BuildItemName", table.count(buildItemIdList))
  for i = 1, #buildingItems do
    local item = buildingItems[i]
    item:SetData(self._buildManager, buildItemIdList[i], function()
      self:ShowDialog("UIN13BuildConfirmController", self._buildManager, buildItemIdList[i])
    end)
  end
end

function UIN13BuildController:_SetMapBuildingPicnic(picnicItemIdList)
  local buildingItems = self:_SpawnObjects("BuildingPicnic", "UIBuildBuildItemPicnic", table.count(picnicItemIdList))
  for i = 1, #buildingItems do
    local item = buildingItems[i]
    item:SetData(self._buildManager, picnicItemIdList[i], function()
      self._component:Start_HandlePicnicPutFood(picnicItemIdList[i], function(res, rewardList)
        if res:GetSucc() then
          Log.info("UIBuildBuildItemPicnic:BtnOnClick() Picnic Succ")
          self:_OnPicnic(picnicItemIdList[i], function()
            UIActivityHelper.ShowUIGetRewards(rewardList)
            self:_ReLoadDataAndRefresh()
            self._petManager:ChangeFixedPet()
          end)
        else
          Log.error("UIBuildBuildItemPicnic:BtnOnClick() Picnic Failed")
          self:_ReLoadDataAndRefresh()
        end
      end)
    end)
  end
end

function UIN13BuildController:_OnPicnic(buildItemId, callback)
  local seq = self._buildManager:GetPicnicCurSeq()
  local pet = self._buildManager:GetPicnicPet(seq)
  local story = self._buildManager:GetPicnicStory(seq)
  local cfg = Cfg.cfg_n13_map_node_picnic[buildItemId]
  if not cfg then
    Log.exception("UIN13BuildController:_OnPicnic() cfg_n13_map_node_picnic == nil, buildItemId = ", buildItemId)
  end
  local nodeId = cfg.MapNodeId
  self._petManager:SetPetPicnic(pet, nodeId, story, callback)
end

function UIN13BuildController:_SetMapNode(nodeData)
  local tb = nodeData:GetNodeIdList()
  local count = table.count(tb)
  local objs = self:_SpawnObjects("Nodes", "UIN13BuildMapNode", count)
  for i, v in ipairs(objs) do
    v:SetData(nodeData, tb[i], nil)
    v:SetDebugText(tb[i])
  end
end

function UIN13BuildController:_SetMapLine(nodeData)
  local tb = nodeData:GetLineIdList()
  local count = table.count(tb)
  local objs = self:_SpawnObjects("Lines", "UIN13BuildMapLine", count)
  for i, v in ipairs(objs) do
    v:SetData(nodeData:GetLinePos(tb[i]))
    v:SetDebugText(tb[i])
  end
end

function UIN13BuildController:_SetEffect()
  self:GetGameObject("_fx"):SetActive(false)
  self:GetGameObject("_fx2"):SetActive(false)
end

function UIN13BuildController:_PlayEffect(buildItemId)
  local tbObj = {"_fx", "_fx2"}
  local tbTrans = {"_fxScale", "_fx2Scale"}
  local curStatus = self._buildManager:GetBuildCurStatus(buildItemId)
  local type = curStatus == UIBuildComponentBuildStatus.CleanUpComplete and 1 or 2
  local pos = self._buildManager:GetWidgetPos(buildItemId) + self._buildManager:GetEffectAreaPos(buildItemId)
  local objPos = self:GetGameObject(tbObj[type])
  objPos.transform.anchoredPosition = pos
  local scale = self._buildManager:GetEffectAreaScale(buildItemId)
  scale = scale * self._curScale / self._defaultScale
  local objScale = self:GetGameObject(tbTrans[type])
  objScale.transform.localScale = Vector3.one * scale
  self:GetGameObject(tbObj[type]):SetActive(true)
  if type == 1 then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6RandomItemDisapper)
  elseif type == 2 then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N6ShowBuilding)
  end
end

function UIN13BuildController:CheckStory()
  local storyList = self._buildManager:GetUnPlayStoryList()
  if storyList == nil or #storyList <= 0 then
    return
  end
  self:PlayStoryList(storyList)
end

function UIN13BuildController:PlayStoryList(storyList)
  if table.count(storyList) <= 0 then
    return
  end
  local storyInfo = storyList[1]
  table.remove(storyList, 1)
  UIActivityN13Helper.PlayStory_Build(self._component, storyInfo, function()
    self:PlayStoryList(storyList)
  end)
end

function UIN13BuildController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIN13BuildController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.NPlusSixBuildingMainRefresh, self._RefreshBuild)
  self:AttachEvent(GameEventType.NPlusSixBuildingBuildingComplete, self._PlayEffect)
  self:AttachEvent(GameEventType.NPlusSixBuildingAllBuildingComplete, self._Refresh)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnUIOpenClose)
end

function UIN13BuildController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.NPlusSixBuildingMainRefresh, self._RefreshBuild)
  self:DetachEvent(GameEventType.NPlusSixBuildingBuildingComplete, self._PlayEffect)
  self:DetachEvent(GameEventType.NPlusSixBuildingAllBuildingComplete, self._Refresh)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self.OnUIOpenClose)
end

function UIN13BuildController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN13BuildController:OnUIOpenClose()
  UnityEngine.Input.multiTouchEnabled = self:Manager():IsTopUI(self.name)
end

function UIN13BuildController:SetShowDebug(showMap, showPet)
  self._flagDebugShowMap = showMap
  self._flagDebugShowPet = showPet
  self:_SetDebug()
end

function UIN13BuildController:_SetDebug()
  local show = UIActivityHelper.CheckDebugOpen()
  local obj = self:GetGameObject("Test")
  obj:SetActive(show)
  local tb = {"Nodes", "Lines"}
  for _, v in ipairs(tb) do
    local obj = self:GetGameObject(v)
    obj:SetActive(self._flagDebugShowMap and show)
  end
  if self._petManager then
    self._petManager:SetShowDebug(self._flagDebugShowPet and show)
  end
end

function UIN13BuildController:Test1BtnOnClick(go)
  self:SetShowDebug(not self._flagDebugShowMap, self._flagDebugShowPet)
end

function UIN13BuildController:Test2BtnOnClick(go)
  self:SetShowDebug(self._flagDebugShowMap, not self._flagDebugShowPet)
end

function UIN13BuildController:Test3BtnOnClick(go)
  local newFixedPetIdList = self._petManager:DebugChangeFixedPet()
  local t = "{"
  for _, v in ipairs(newFixedPetIdList) do
    t = t .. v .. ", "
  end
  t = t .. "}"
  ToastManager.ShowToast("new fixed petid = " .. t)
end

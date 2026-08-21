_class("UIPlot", UIController)
UIPlot = UIPlot
local COLOR_ALPHA = Color(1, 1, 1, 0)

function UIPlot:OnShow(uiParam)
  if uiParam[3] then
    self._isExtraMission = uiParam[3]
  else
    self._isExtraMission = false
  end
  self._bgName = "map_ditu2_frame"
  if uiParam[4] then
    self._customTitle = ""
    self._isCustomPlot = uiParam[4]
    if self._isCustomPlot then
      if uiParam[5] then
        self._customTitle = uiParam[5]
      end
      if uiParam[6] then
        self._bgName = uiParam[6]
      end
    end
  else
    self._isCustomPlot = false
  end
  self._bgImg = self:GetUIComponent("RawImageLoader", "bg")
  self._bgImg:LoadImage(self._bgName)
  self._init = true
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._uiStoryModule = self:GetModule(StoryModule):GetUIModule()
  self._levelid = self._uiStoryModule:GetLevelID()
  self._uiStoryModule:ResetLevelID()
  self._backBtns = btns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._levelid then
      self:SwitchState(UIStateType.UIMain)
    else
      self:CloseDialog()
    end
  end, nil)
  self._imgCG = self:GetUIComponent("MultiplyImageLoader", "imgCG")
  self._txtChapterStage = self:GetUIComponent("UILocalizationText", "txtChapterStage")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._destScroll = self:GetUIComponent("ScrollRect", "descScroll")
  self._storyType = self:GetUIComponent("UILocalizationText", "storyType")
  self:SetCG(nil)
  self._btnEnterPlot = self:GetGameObject("btnEnterPlot")
  self._imgBlack = self:GetGameObject("imgBlack")
  self._imgBlack:SetActive(false)
  self._svHelper = H3DScrollViewHelper:New(self, "ScrollView", "UIPlotItem", function(index, uiWidget)
    uiWidget:Flush(self._stages[index], self._3dStoryList[index])
    return uiWidget
  end, nil, function(index, uiWidget)
    if self.curItem then
      self.curItem:Select(false)
    end
    self.curItem = uiWidget
    if self.curItem then
      self.curItem:Select(true)
    end
  end)
  self._svHelper:SetCalcScale(true)
  self._svHelper:SetEndSnappingCallback(function(index, item)
    self:UnLock("UIPlotRolling")
    if self._init then
      self._init = false
      return
    end
    local idx = index + 1
    self._curStage = self._stages[idx]
    self._openIdx = self:_GetIndex(self._curStage.id)
    self:Flush()
  end)
  self._svHelper:SetItemPassSnapPosCallback(function(index, item)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUISlideStory)
  end)
  self._curStage = uiParam[1]
  self._stages = uiParam[2]
  local cfg_mission_story = Cfg.cfg_mission_story({})
  self._3dStoryList = {}
  if self._stages and #self._stages > 0 then
    for i = 1, #self._stages do
      local missionid = self._stages[i].id or 0
      local _cfg_mission_story = cfg_mission_story[missionid]
      local have = false
      if not _cfg_mission_story then
        Log.debug("###[UIPlot] _cfg_mission_story is nil ! id --> ", missionid)
      elseif _cfg_mission_story.StoryActiveType then
        for j = 1, #_cfg_mission_story.StoryActiveType do
          local storyType = _cfg_mission_story.StoryActiveType[j]
          if storyType == 4 or storyType == 5 then
            have = true
            break
          end
        end
      end
      self._3dStoryList[i] = have
    end
  end
  local totalCount = table.count(self._stages)
  local lastStage = self._stages[totalCount]
  if not self._curStage:IsThereStory() or not self._curStage:HasFirstPass() then
    self._curStage = lastStage
  end
  self._openIdx = self:_GetIndex(self._curStage.id)
  self:Lock("UIPlotRolling")
  self._svHelper:Init(totalCount, self._openIdx, Vector2(0, 0))
  self:AttachEvent(GameEventType.UIPlotClickItem, self.MovePanelToIndex)
  if self._init then
    self:Flush()
  end
  if self._levelid then
    self:LookStoryFromBattle()
  end
end

function UIPlot:OnHide()
  self._backBtns = nil
  self._svHelper:Dispose()
  self:DetachEvent(GameEventType.UIPlotClickItem, self.MovePanelToIndex)
end

function UIPlot:Flush()
  if not self._curStage then
    return
  end
  if not self._init then
    self._txtChapterStage.color = COLOR_ALPHA
    self._txtDesc.color = COLOR_ALPHA
    self._txtChapterStage:DOFade(1, 1)
    self._txtDesc:DOFade(1, 1)
  end
  if self._isCustomPlot then
    self._txtChapterStage:SetText(self._curStage.fullname)
    self._storyType:SetText(self._customTitle)
  elseif self._isExtraMission then
    local extID = 0
    local cfg_ext = Cfg.cfg_extra_mission({})
    for key, value in HelperProxy:GetInstance():pairsByKeys(cfg_ext) do
      for j = 1, #value.ExtTaskList do
        if value.ExtTaskList[j] == self._curStage.id then
          extID = key
          break
        end
      end
      if extID ~= 0 then
        break
      end
    end
    local indexName = cfg_ext[extID].ExtMissionIdx
    self._txtChapterStage:SetText(StringTable.Get(indexName) .. " " .. self._curStage.stageIdx .. " " .. self._curStage.name)
    self._storyType:SetText(StringTable.Get("str_discovery_extra_plot_chapter"))
  else
    local module = self:GetModule(MissionModule)
    local data = module:GetDiscoveryData()
    local chapter = data:GetChapterByStageId(self._curStage.id)
    if chapter then
      self._txtChapterStage.text = chapter.index_name .. " " .. self._curStage.stageIdx .. " " .. self._curStage.name
    end
  end
  self._txtDesc.text = self._curStage.longDesc
  self:SetCG(self._curStage.cg)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._txtDesc.transform)
  self._destScroll.verticalNormalizedPosition = 1
end

function UIPlot:SetCG(cgName)
  if cgName and cgName ~= "" then
    self._imgCG.gameObject:SetActive(true)
    self._imgCG:Load(cgName)
    UICG.SetTransform(self._imgCG:GetComponent("RectTransform"), self:GetName(), cgName)
  else
    self._imgCG.gameObject:SetActive(false)
  end
end

function UIPlot:Goto3DPlot()
  local uiParams = {}
  uiParams[1] = self._curStage
  uiParams[2] = self._stages
  uiParams[3] = self._isExtraMission
  uiParams[4] = self._isCustomPlot
  uiParams[5] = self._customTitle
  self._uiStoryModule:SetUiParams(uiParams)
end

function UIPlot:btnEnterPlotOnClick(go)
  local storyList = self._curStage.story
  if storyList and storyList:Count() > 0 then
    local before = storyList:GetStoryByStoryType(StoryTriggerType.BeforeFight)
    local after = storyList:GetStoryByStoryType(StoryTriggerType.AfterFight)
    local node = storyList:GetStoryByStoryType(StoryTriggerType.Node)
    local battle_before = storyList:GetStoryByStoryType(StoryTriggerType.BattleBefore)
    local battle_after = storyList:GetStoryByStoryType(StoryTriggerType.BattleAfter)
    Log.debug("###[UIPlot] 开始检查看剧情,stageid --> ", self._curStage.id, " | openidx --> ", self._openIdx)
    self._storyReadyTable = {}
    self._lookStoryIdx = 1
    if before then
      table.insert(self._storyReadyTable, before)
      Log.debug("###[UIPlot] ui战前剧情加入")
    end
    if battle_before then
      table.insert(self._storyReadyTable, battle_before)
      Log.debug("###[UIPlot] 3d战前剧情加入")
    end
    if node then
      table.insert(self._storyReadyTable, node)
      Log.debug("###[UIPlot] ui路点战前剧情加入")
    end
    if battle_after then
      table.insert(self._storyReadyTable, battle_after)
      Log.debug("###[UIPlot] 3d战后剧情加入")
    end
    if after then
      table.insert(self._storyReadyTable, after)
      Log.debug("###[UIPlot] ui战后剧情加入")
    end
    self:ReadyPlayStory()
  end
end

function UIPlot:ReadyPlayStory()
  GameGlobal.TaskManager():StartTask(self.LookStoryTable, self)
end

function UIPlot:LookStoryTable(TT)
  if self._storyReadyTable and table.count(self._storyReadyTable) then
    Log.debug("###[UIPlot] 检查完毕，数量足够，开始看 count --> ", table.count(self._storyReadyTable))
    if self._storyReadyTable[self._lookStoryIdx] then
      local story = self._storyReadyTable[self._lookStoryIdx]
      self:Lock("UIPlot:LookStoryTable")
      YIELD(TT)
      self:UnLock("UIPlot:LookStoryTable")
      if story.activeType == StoryTriggerType.BeforeFight or story.activeType == StoryTriggerType.AfterFight or story.activeType == StoryTriggerType.Node then
        Log.debug("###[UIPlot] 看ui剧情 story.id --> ", story.id, " | story.activeType --> ", story.activeType, "。")
        self._imgBlack:SetActive(true)
        self._lookStoryIdx = self._lookStoryIdx + 1
        self:ShowDialog("UIStoryController", story.id, function()
          self:ReadyPlayStory()
        end, nil, nil, nil, true)
      else
        local missionid = self._curStage.id
        local cfg_mission = Cfg.cfg_mission[missionid]
        if not cfg_mission then
          Log.error("###[UIPlot] cfg_mission is nil ! id --> ", missionid)
          return
        end
        local levelid = cfg_mission.FightLevel
        self._uiStoryModule:SetLevelID(levelid)
        self:Goto3DPlot()
        local tmplevelid = levelid or 0
        local tmpmissionid = missionid or 0
        Log.debug("###[UIPlot] 跳转局内看剧情 levelid[", tmplevelid, "] missionid[", tmpmissionid, "]")
        self._uiStoryModule:Goto3DStory()
      end
    else
      Log.debug("###[UIPlot] 剧情看完")
      self._imgBlack:SetActive(false)
    end
  end
end

function UIPlot:LookStoryFromBattle()
  Log.debug("###[UIPlot] 局内回来检查看战后剧情")
  local storyList = self._curStage.story
  if storyList and storyList:Count() > 0 then
    local after = storyList:GetStoryByStoryType(StoryTriggerType.AfterFight)
    if after then
      Log.debug("###[UIPlot] 有战后，可以看")
      self._imgBlack:SetActive(true)
      self:ShowDialog("UIStoryController", after.id, function()
        Log.debug("###[UIPlot] 战后看完")
        self._imgBlack:SetActive(false)
      end, nil, nil, nil, true)
    end
  end
end

function UIPlot:MovePanelToIndex(id)
  local openIdx = self:_GetIndex(id)
  if self._openIdx == openIdx then
    return
  end
  self:Lock("UIPlotRolling")
  self._openIdx = openIdx
  self._svHelper:MovePanelToIndex(openIdx)
end

function UIPlot:_GetIndex(id)
  local openIdx = #self._stages or 1
  for i, v in ipairs(self._stages) do
    if id == v.id then
      openIdx = i
      break
    end
  end
  return openIdx
end

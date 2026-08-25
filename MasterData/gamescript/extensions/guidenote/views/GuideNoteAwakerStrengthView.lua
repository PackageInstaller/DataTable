local GuideNoteAwakerStrengthView, Super = NewClass("GuideNoteAwakerStrengthView", BaseView)
GuideNoteAwakerStrengthView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Panel_AwakerStrength.prefab"
local cd = CommonDefine
local COLOR_WHITE = "FFFFFF"
local COLOR_CYAN = "74F0FF"
local EXCLUDE_TALENT_SAVE_KEY = "GuideNote_AwakerStrength_ExcludeTalent"
local TOP_CURRENCY_LIST = {
  CommonDefine.CurrencyType.Energy
}
local BAG_REFRESH_DEBOUNCE_SEC = 0.15
local CELL_TAG = {
  TITLE = 1,
  MATERIAL = 2,
  TRINKET = 3
}

function GuideNoteAwakerStrengthView:ctor(strengthenType, trinketUid, trinketModel)
  Super.ctor(self)
  self.strengthenType = strengthenType
  self.trinketUid = trinketUid or 0
  self.trinketModel = trinketModel
  self._excludeTalent = nil
  self.selectedAwakerTid = GuideNoteModel.Instance:GetAwakerStrengthSelectedAwakerTid()
  self.awakerPortraitComp = nil
  self._acquireGroups = {}
  self._bagRefreshDebounceTimerId = nil
  self._lastMaterialAwakerTid = nil
end

function GuideNoteAwakerStrengthView:OnBuildView()
  if self.ui and self.ui.UI_Common_Item_Coin_Group then
    self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, TOP_CURRENCY_LIST)
  end
  self._materialTableview = self:CreateTableview(self.ui.MaterialView, function()
    return #self._acquireGroups
  end, function(view, index)
    do return self._MaterialCellAtIndex, self, view end
    return self._MaterialCellAtIndex, self, view, index
  end, function(view, index)
    do return self._MaterialCellSizeForIndex, self, view end
    return self._MaterialCellSizeForIndex, self, view, index
  end)
end

function GuideNoteAwakerStrengthView:_MaterialCellSizeForIndex(view, index)
  local group = self._acquireGroups and self._acquireGroups[index] or nil
  local baseGo = group and group.baseGameObj or self.ui.UI_GuideNote_Item_Material
  local size = baseGo.transform.sizeDelta
  return size.x, size.y
end

function GuideNoteAwakerStrengthView:_MaterialCellAtIndex(view, index)
  local group = self._acquireGroups[index]
  local baseGo = group and group.baseGameObj or self.ui.UI_GuideNote_Item_Material
  local cell = self:DequeueCellByTag(view, group.tag, baseGo)
  if cell and group then
    if baseGo == self.ui.UI_GuideNote_Item_Title then
      local titleComp = self:FindChildTextComponent(cell.gameObject, "Text_Title")
      if titleComp then
        self:SetText(titleComp.gameObject, group.title or "")
      end
    elseif baseGo == self.ui.UI_GuideNote_Item_Trinket then
      self:AddViewComponentOnce(cell.gameObject, CompGuideNoteAwakerStrengthTrinket, group)
    else
      self:AddViewComponentOnce(cell.gameObject, CompGuideNoteAwakerStrengthMaterial, group)
    end
  end
  return cell
end

function GuideNoteAwakerStrengthView:RegisterEvents()
  if self.ui and self.ui.Btn_Add then
    self:AddButtonClickListener(self.ui.Btn_Add, System.fn(self, self._OnClickAdd))
  end
  if self.ui and self.ui.Btn_Change then
    self:AddButtonClickListener(self.ui.Btn_Change, System.fn(self, self._OnClickChange))
  end
  if self.ui and self.ui.Btn_Detail then
    self:AddButtonClickListener(self.ui.Btn_Detail, System.fn(self, self._OnClickDetail))
  end
  if self.ui and self.ui.Btn_More then
    self:AddButtonClickListener(self.ui.Btn_More, System.fn(self, self._OnClickMore))
  end
  if self.ui and self.ui.Toggle_Talent then
    self:AddZ1ToggleValueChangedListener(self.ui.Toggle_Talent, System.fn(self, self._OnToggleTalentChanged))
  end
  if EventMgr and EventMgr.Instance and EventMgr.Instance.OnSyncWeekBossData then
    self:BindEvent(EventMgr.Instance.OnSyncWeekBossData, System.fn(self, self._OnStageDataChanged))
  end
end

function GuideNoteAwakerStrengthView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
  self:RegisterNotify(NotifyId.OnStageDataChanged, self._OnStageDataChanged, self)
end

function GuideNoteAwakerStrengthView:OnEnterView()
  Super.OnEnterView(self)
  self:_Refresh()
end

function GuideNoteAwakerStrengthView:RefreshOnRendered()
  self:_Refresh()
end

function GuideNoteAwakerStrengthView:_OnBagItemDataChanged()
  self:_ScheduleDebouncedRefresh()
end

function GuideNoteAwakerStrengthView:_OnStageDataChanged()
  self:_ScheduleDebouncedRefresh()
end

function GuideNoteAwakerStrengthView:_ScheduleDebouncedRefresh()
  if self._bagRefreshDebounceTimerId then
    self:StopTimer(self._bagRefreshDebounceTimerId)
    self._bagRefreshDebounceTimerId = nil
  end
  self._bagRefreshDebounceTimerId = self:BindTimer(BAG_REFRESH_DEBOUNCE_SEC, 0, nil, System.fn(self, self._DoDebouncedBagRefresh))
end

function GuideNoteAwakerStrengthView:_DoDebouncedBagRefresh()
  self._bagRefreshDebounceTimerId = nil
  self:_Refresh()
end

function GuideNoteAwakerStrengthView:_OnClickAdd()
  local initData = {
    singleChoose = true,
    allowEmpty = true,
    includeNotOwnedOpened = true,
    sameChosenAsEmpty = true,
    sameChosenConfirmText = LT.Text("Formation_SelectRole_Sure_Btn1"),
    chosenAwakers = 0 ~= self.selectedAwakerTid and {
      self.selectedAwakerTid
    } or {},
    confirmCb = System.fn(self, self._OnChooseAwakerConfirm)
  }
  UIManager.Instance:Reopen(Urls.SocialPlayerChooseAwakerPanel, initData)
end

function GuideNoteAwakerStrengthView:_OnClickChange()
  self:_OnClickAdd()
end

function GuideNoteAwakerStrengthView:_OnClickDetail()
  local awakerTid = self:_GetSelectedAwakerTid()
  if 0 ~= awakerTid then
    FuncJumpManager.Instance:JumpToAwakerLevel(awakerTid)
  end
end

function GuideNoteAwakerStrengthView:_GetAwakerBreakthroughNextRequireTaskList(awakerTid)
  if not awakerTid or 0 == awakerTid then
    return {}
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if awaker and awaker.nextRequireTaskComplete and #awaker.nextRequireTaskComplete > 0 then
    return awaker.nextRequireTaskComplete
  end
  local cfg = DT.AwakerBreakThrough and DT.AwakerBreakThrough[awakerTid]
  if not cfg or not cfg.data_list then
    return {}
  end
  local star = 0
  if awaker and awaker.currBreakthroughStar then
    star = awaker.currBreakthroughStar
  end
  local row = cfg.data_list[star + 1]
  if row and row.RequireTaskComplete then
    return row.RequireTaskComplete
  end
  return {}
end

function GuideNoteAwakerStrengthView:_AppendFormattedBullet(parts, seen, lineText)
  if not lineText or "" == lineText or seen[lineText] then
    return
  end
  seen[lineText] = true
  parts[#parts + 1] = LT.Textf("GuideNote_Format", lineText)
end

function GuideNoteAwakerStrengthView:_BuildBreakthroughMoreImprovementPart(awakerTid)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  local cfg = DT.AwakerBreakThrough and DT.AwakerBreakThrough[awakerTid]
  local curStar = awaker and awaker.currBreakthroughStar or 0
  local targetTaskList = self:_FindFirstUnmetBreakthroughTaskList(awakerTid, cfg, curStar) or {}
  local parts = {}
  local seen = {}
  for gi = 1, #targetTaskList do
    local tasks = targetTaskList[gi]
    if type(tasks) == "table" and #tasks > 0 then
      local groupDone = TaskDataUtils and TaskDataUtils.CheckTaskListIsAllDone and TaskDataUtils.CheckTaskListIsAllDone(tasks) == true
      if true ~= groupDone then
        for _, taskId in ipairs(tasks) do
          local tid = tonumber(taskId)
          if tid and 0 ~= tid and true ~= self:_IsTaskDone(tid) and TaskDataUtils and TaskDataUtils.GetTaskDesc then
            self:_AppendFormattedBullet(parts, seen, TaskDataUtils.GetTaskDesc(tid))
          end
        end
      end
    end
  end
  do return table.concat, parts end
  return table.concat, parts, "", nil, targetTaskList[gi], true, ipairs(tasks)
end

function GuideNoteAwakerStrengthView:_FindFirstUnmetBreakthroughTaskList(awakerTid, cfg, curStar)
  if not cfg or not cfg.data_list then
    return nil
  end
  local maxIdx = #cfg.data_list
  local firstList = self:_GetAwakerBreakthroughNextRequireTaskList(awakerTid)
  local startIdx = curStar + 1
  for idx = startIdx, maxIdx do
    local taskList = idx == startIdx and firstList or nil
    if not taskList or type(taskList) ~= "table" or #taskList <= 0 then
      local row = cfg.data_list[idx]
      taskList = row and row.RequireTaskComplete
    end
    if type(taskList) == "table" and #taskList > 0 and not GuideNoteAwakerStrengthCompareModel._IsBreakthroughTaskMet(taskList) then
      return taskList
    end
  end
  return nil
end

function GuideNoteAwakerStrengthView:_BuildSkillMoreImprovementPart()
  local parts = {}
  local seen = {}
  local maxLv = AwakerDataUtils.GetMaxSkillLv() or 6
  local awakerTid = self:_GetSelectedAwakerTid()
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  local curBreakLv = awaker and (awaker.currBreakthroughStar or 0) or 0
  for k = 2, maxLv do
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.AwakerSkillLevel, k, true)
    if true ~= unlocked then
      local tip = PlayerDataUtils.GetFeatureLogicUnlockTips(cd.FeatureId.AwakerSkillLevel, k)
      self:_AppendFormattedBullet(parts, seen, tip)
      do return table.concat, parts end
      return table.concat, parts, "", seen, tip, nil, nil
    end
    local needStar = AwakerDataUtils.GetSkillLevelUpBreakthroughNeed(k - 1)
    if needStar and curBreakLv < needStar then
      self:_AppendFormattedBullet(parts, seen, LT.Textf("AwakerSkillUpgradeTips", needStar))
      do return table.concat, parts end
      return table.concat, parts, "", seen, LT.Textf("AwakerSkillUpgradeTips", needStar)
    end
  end
  do return table.concat, parts end
  return table.concat, parts, "", nil, PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.AwakerSkillLevel, k, true)
end

function GuideNoteAwakerStrengthView:_IsTaskDone(taskTid)
  if not taskTid or 0 == taskTid then
    return true
  end
  if TaskDataUtils and TaskDataUtils.IsTaskDoneByTaskId then
    return TaskDataUtils.IsTaskDoneByTaskId(taskTid) == true
  end
  return false
end

function GuideNoteAwakerStrengthView:_IsCrazyOmenConditionMet(awakerTid)
  local taskList = self:_GetCrazyOmenTaskConditions(awakerTid)
  if type(taskList) ~= "table" or #taskList <= 0 then
    return true
  end
  for _, taskTid in ipairs(taskList) do
    local tid = tonumber(taskTid) or 0
    if 0 ~= tid and self:_IsTaskDone(tid) ~= true then
      return false
    end
  end
  return true
end

function GuideNoteAwakerStrengthView:_IsBreakthroughAnyConditionMet(awakerTid)
  local list = self:_GetAwakerBreakthroughNextRequireTaskList(awakerTid)
  if type(list) ~= "table" or #list <= 0 then
    return true
  end
  for _, tasks in ipairs(list) do
    if type(tasks) == "table" and #tasks > 0 and TaskDataUtils and TaskDataUtils.CheckTaskListIsAllDone and TaskDataUtils.CheckTaskListIsAllDone(tasks) == true then
      return true
    end
  end
  return false
end

function GuideNoteAwakerStrengthView:_CollectBreakthroughSkillUnlockStars(awakerTid)
  local starMap = {}
  local cfg = DT.AwakerBreakThrough and DT.AwakerBreakThrough[awakerTid]
  if cfg and cfg.data_list then
    for _, row in ipairs(cfg.data_list) do
      if row and row.PotencyName and row.Level then
        starMap[row.Level] = true
      end
    end
  end
  local stars = {}
  for lv, _ in pairs(starMap) do
    stars[#stars + 1] = lv
  end
  table.sort(stars)
  return stars
end

function GuideNoteAwakerStrengthView:_FindFirstUnmetCrazyOmenTaskList(awakerTid)
  local talentCfg = GuideNoteAwakerStrengthCompareModel._GetTalentCfgByType(awakerTid, cd.AwakerTalentType.CrazyOmen)
  if not talentCfg or not talentCfg.data_list then
    return {}
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  local talentTid = talentCfg.ID
  local curLevel = 1
  if awaker and awaker.talents and awaker.talents[talentTid] and awaker.talents[talentTid].lv then
    curLevel = awaker.talents[talentTid].lv
  end
  for lv = (curLevel or 1) + 1, #talentCfg.data_list do
    local lvCfg = talentCfg.data_list[lv]
    if lvCfg and lvCfg.TaskCondition and type(lvCfg.TaskCondition) == "table" and #lvCfg.TaskCondition > 0 then
      local allDone = TaskDataUtils and TaskDataUtils.CheckTaskListIsAllDone and TaskDataUtils.CheckTaskListIsAllDone(lvCfg.TaskCondition) == true
      if true ~= allDone then
        return lvCfg.TaskCondition
      end
    end
  end
  return {}
end

function GuideNoteAwakerStrengthView:_BuildCrazyOmenMoreImprovementPart(awakerTid)
  local parts = {}
  local seen = {}
  local taskList = self:_FindFirstUnmetCrazyOmenTaskList(awakerTid)
  if taskList and #taskList > 0 then
    for _, taskTid in ipairs(taskList) do
      local tid = tonumber(taskTid)
      if tid and 0 ~= tid and self:_IsTaskDone(tid) ~= true then
        local desc
        if TaskDataUtils and TaskDataUtils.GetTaskDesc then
          desc = TaskDataUtils.GetTaskDesc(tid)
        end
        if (nil == desc or "" == desc) and DT.Task and DT.Task[tid] and DT.Task[tid].Desc then
          desc = LT.Text(DT.Task[tid].Desc)
        end
        self:_AppendFormattedBullet(parts, seen, desc)
      end
    end
  else
    for _, lv in ipairs(self:_CollectBreakthroughSkillUnlockStars(awakerTid)) do
      self:_AppendFormattedBullet(parts, seen, LT.Textf("AwakerSkillUpgradeTips", lv))
    end
  end
  do return table.concat, parts end
  return table.concat, parts, "", ipairs(self:_CollectBreakthroughSkillUnlockStars(awakerTid))
end

function GuideNoteAwakerStrengthView:_RichSectionBlock(index, headerLangKey, bodyRich)
  if nil == bodyRich or "" == bodyRich then
    return nil
  end
  local headerText = LT.Text(headerLangKey)
  if nil == headerText or "" == headerText then
    headerText = ""
  end
  local head = string.format("%d.%s", index, headerText)
  return head .. bodyRich
end

function GuideNoteAwakerStrengthView:_BuildMoreImprovementDescRich(awakerTid)
  if not awakerTid or 0 == awakerTid then
    return ""
  end
  local blocks = {}
  local sectionIndex = 1
  local breakthroughPart = self:_BuildBreakthroughMoreImprovementPart(awakerTid)
  local block1 = self:_RichSectionBlock(sectionIndex, "GuideNote_Breakthrough", breakthroughPart)
  if block1 and "" ~= block1 then
    blocks[#blocks + 1] = block1
    sectionIndex = sectionIndex + 1
  end
  local skillPart = self:_BuildSkillMoreImprovementPart()
  local block2 = self:_RichSectionBlock(sectionIndex, "GuideNote_SkillImprovement", skillPart)
  if block2 and "" ~= block2 then
    blocks[#blocks + 1] = block2
    sectionIndex = sectionIndex + 1
  end
  local crazyOmenPart = self:_BuildCrazyOmenMoreImprovementPart(awakerTid)
  local block3 = self:_RichSectionBlock(sectionIndex, "GuideNote_CrazyOmen", crazyOmenPart)
  if block3 and "" ~= block3 then
    blocks[#blocks + 1] = block3
  end
  do return table.concat, blocks end
  return table.concat, blocks, [[


]], crazyOmenPart
end

function GuideNoteAwakerStrengthView:_OnClickMore()
  if not self.ui or not self.ui.Btn_More then
    return
  end
  local awakerTid = self:_GetSelectedAwakerTid()
  local title = LT.Text("GuideNote_MoreImprovement")
  local desc = self:_BuildMoreImprovementDescRich(awakerTid)
  if nil == desc or "" == desc then
    return
  end
  UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {
    title = title or "",
    desc = desc or ""
  }, self.ui.Btn_More)
end

function GuideNoteAwakerStrengthView:_OnToggleTalentChanged(isOn)
  self._excludeTalent = true ~= isOn
  print(string.format("[GuideNoteAwakerStrengthDebug] _OnToggleTalentChanged isOn=%s excludeTalent=%s", tostring(isOn), tostring(self._excludeTalent)))
  if MobileFileDataManager and MobileFileDataManager.Instance then
    MobileFileDataManager.Instance:SetPlayerFileValue(EXCLUDE_TALENT_SAVE_KEY, self._excludeTalent, true)
  end
  self:_Refresh()
end

function GuideNoteAwakerStrengthView:_OnChooseAwakerConfirm(chosenAwakers)
  if type(chosenAwakers) ~= "table" then
    return
  end
  local awakerTid = tonumber(chosenAwakers[1]) or 0
  self.selectedAwakerTid = awakerTid
  if GuideNoteModel and GuideNoteModel.Instance and GuideNoteModel.Instance.SetAwakerStrengthSelectedAwakerTid then
    GuideNoteModel.Instance:SetAwakerStrengthSelectedAwakerTid(awakerTid)
  end
  self:_Refresh()
end

function GuideNoteAwakerStrengthView:_Refresh()
  self:_EnsureExcludeTalentPersist()
  self:_RenderTalentToggle()
  local awakerTid = self:_GetSelectedAwakerTid()
  self:SetActive(self.ui.Group_AwakerNone, not AwakerDataUtils.HasOwnedAwaker(awakerTid))
  local needResetMaterialScroll = self._lastMaterialAwakerTid ~= nil and self._lastMaterialAwakerTid ~= awakerTid
  self._lastMaterialAwakerTid = awakerTid
  if 0 == awakerTid then
    self:_RenderNoAwakerState()
    table.clear(self._acquireGroups)
    self:_ReloadMaterialTableview(needResetMaterialScroll)
    return
  end
  local compareData = GuideNoteAwakerStrengthCompareModel.BuildCompareData(awakerTid)
  if self._excludeTalent == true then
    compareData.targetTalentText = compareData.curTalentText
  end
  self:_RenderAwakerCompare(awakerTid, compareData)
  if self.ui and self.ui.Btn_More then
    local moreDesc = self:_BuildMoreImprovementDescRich(awakerTid)
    self:SetActive(self.ui.Btn_More, nil ~= moreDesc and "" ~= moreDesc)
  end
  table.clear(self._acquireGroups)
  table.insert(self._acquireGroups, {
    tag = CELL_TAG.TITLE,
    title = LT.Text("GuideNote_MaterialNeeded"),
    baseGameObj = self.ui.UI_GuideNote_Item_Title
  })
  local includeLimitIncreaseNeed = self:_IsBreakthroughAnyConditionMet(awakerTid)
  local needList = CompGuideNoteAwakerStrengthMaterial.BuildNeedList(awakerTid, compareData, self._excludeTalent == true, includeLimitIncreaseNeed)
  local materialGroups = CompGuideNoteAwakerStrengthMaterial.BuildAcquireGroups(needList)
  if materialGroups and #materialGroups > 0 then
    for _, group in ipairs(materialGroups) do
      group.tag = CELL_TAG.MATERIAL
      group.baseGameObj = self.ui.UI_GuideNote_Item_Material
      table.insert(self._acquireGroups, group)
    end
  else
    table.insert(self._acquireGroups, {
      tag = CELL_TAG.TITLE,
      title = LT.Text("GuideNote_MaterialMet"),
      baseGameObj = self.ui.UI_GuideNote_Item_Material
    })
  end
  table.insert(self._acquireGroups, {
    tag = CELL_TAG.TITLE,
    title = LT.Text("GuideNote_RecommendMystic"),
    baseGameObj = self.ui.UI_GuideNote_Item_Title
  })
  local trinketRecommendGroups = CompGuideNoteAwakerStrengthMaterial.BuildRecommendTrinketAcquireGroups(awakerTid)
  if trinketRecommendGroups and #trinketRecommendGroups > 0 then
    print(string.format("[GuideNoteAwakerStrengthDebug] trinketRecommendGroupsCount=%s", tostring(#trinketRecommendGroups)))
    for _, group in ipairs(trinketRecommendGroups) do
      group.baseGameObj = self.ui.UI_GuideNote_Item_Trinket
      table.insert(self._acquireGroups, group)
    end
  end
  self:_PrefetchAcquireStageData()
  self:_ReloadMaterialTableview(needResetMaterialScroll)
end

function GuideNoteAwakerStrengthView:_PrefetchAcquireStageData()
  local stageGroupIds = CompGuideNoteAwakerStrengthMaterial.CollectPrefetchStageGroupIds(self._acquireGroups)
  GuideNoteController.Instance:ReqOnPrepareAwakerStrengthStageData(stageGroupIds)
end

function GuideNoteAwakerStrengthView:_ReloadMaterialTableview(needResetMaterialScroll)
  if self._materialTableview then
    if true == needResetMaterialScroll then
      self:_ResetMaterialTableviewToTop()
    end
    self._materialTableview:ReloadData()
  end
end

function GuideNoteAwakerStrengthView:_ResetMaterialTableviewToTop()
  if not self._materialTableview then
    return
  end
  self._materialTableview:SetOffset(0, false)
end

function GuideNoteAwakerStrengthView:_EnsureExcludeTalentPersist()
  if self._excludeTalent ~= nil then
    return
  end
  local stored
  if MobileFileDataManager and MobileFileDataManager.Instance then
    stored = MobileFileDataManager.Instance:GetPlayerFileValue(EXCLUDE_TALENT_SAVE_KEY, nil)
  end
  if nil == stored then
    self._excludeTalent = true
    if MobileFileDataManager and MobileFileDataManager.Instance then
      MobileFileDataManager.Instance:SetPlayerFileValue(EXCLUDE_TALENT_SAVE_KEY, self._excludeTalent, true)
    end
  else
    self._excludeTalent = stored == cd.NumberTrue or 1 == stored or true == stored
  end
end

function GuideNoteAwakerStrengthView:_GetSelectedAwakerTid()
  if 0 ~= self.trinketUid then
    local ownerTid = ItemDataUtils.GetItemOwner(self.trinketUid) or 0
    if 0 ~= ownerTid then
      if self.selectedAwakerTid ~= ownerTid then
        self.selectedAwakerTid = ownerTid
        if GuideNoteModel and GuideNoteModel.Instance and GuideNoteModel.Instance.SetAwakerStrengthSelectedAwakerTid then
          GuideNoteModel.Instance:SetAwakerStrengthSelectedAwakerTid(ownerTid)
        end
      end
      return ownerTid
    end
  end
  return self.selectedAwakerTid or 0
end

function GuideNoteAwakerStrengthView:_RenderTalentToggle()
  if self.ui and self.ui.Toggle_Talent then
    self:SetZ1Toggle(self.ui.Toggle_Talent, self._excludeTalent == false, true)
  end
end

function GuideNoteAwakerStrengthView:_RenderNoAwakerState()
  self:_SetAwakerSelectedState(false)
  self:_RefreshAwakerPortrait(0)
  self:_RefreshAwakerCareerIcon(0)
  if self.ui.Text_Awaker_Name then
    local tipsCfg = DT.TipsType and DT.TipsType[20012]
    local awakerEmptyText = tipsCfg and tipsCfg.Desc and LT.Text(tipsCfg.Desc) or LT.Text("MainShopSingleBuyConfirmPanel_Lock")
    self:SetText(self.ui.Text_Awaker_Name, awakerEmptyText)
  end
  self:_RenderComparePair(self.ui.Text_Level_Cur, self.ui.Text_Level_Previeww, "-", "-")
  self:_RenderComparePair(self.ui.Text_Skill_Cur, self.ui.Text_Skill_Previeww, "-", "-")
  self:_RenderComparePair(self.ui.Text_Talent_Cur, self.ui.Text_Talent_Previeww, "-", "-")
end

function GuideNoteAwakerStrengthView:_RenderAwakerCompare(awakerTid, compareData)
  self:_SetAwakerSelectedState(true)
  self:_RefreshAwakerPortrait(awakerTid)
  self:_RefreshAwakerCareerIcon(awakerTid)
  if self.ui.Text_Awaker_Name then
    self:SetText(self.ui.Text_Awaker_Name, compareData.name)
  end
  self:_RenderComparePair(self.ui.Text_Level_Cur, self.ui.Text_Level_Previeww, compareData.curLevelText or compareData.curLevel, compareData.targetLevelText or compareData.targetLevel)
  self:_RenderSlashSegmentComparePair(self.ui.Text_Skill_Cur, self.ui.Text_Skill_Previeww, compareData.curSkillText or compareData.curSkill, compareData.targetSkillText or compareData.targetSkill)
  self:_RenderSlashSegmentComparePair(self.ui.Text_Talent_Cur, self.ui.Text_Talent_Previeww, compareData.curTalentText or compareData.curTalent, compareData.targetTalentText or compareData.targetTalent)
end

function GuideNoteAwakerStrengthView:_RefreshAwakerCareerIcon(awakerTid)
  local hasAwaker = awakerTid and 0 ~= awakerTid
  self:SetActive(self.ui.Image_Career, true == hasAwaker)
  if true == hasAwaker then
    self:SetImage(self.ui.Image_Career, AwakerDataUtils.GetAwakerSchoolIcon(awakerTid))
  end
end

function GuideNoteAwakerStrengthView:_SetAwakerSelectedState(hasAwaker)
  if self.ui and self.ui.Image_Frame then
    self:SetActive(self.ui.Image_Frame, true == hasAwaker)
  end
  if self.ui and self.ui.AwakerBg then
    self:SetActive(self.ui.AwakerBg, true == hasAwaker)
  end
  if self.ui and self.ui.Group_Null then
    self:SetActive(self.ui.Group_Null, true ~= hasAwaker)
  end
  if self.ui and self.ui.Group_StrengthInfo then
    self:SetActive(self.ui.Group_StrengthInfo, true == hasAwaker)
  end
  if self.ui and self.ui.MaterialView then
    self:SetActive(self.ui.MaterialView, true == hasAwaker)
  end
  if self.ui and self.ui.Btn_Add then
    self:SetActive(self.ui.Btn_Add, true ~= hasAwaker)
  end
  if self.ui and self.ui.Btn_Change then
    self:SetActive(self.ui.Btn_Change, true == hasAwaker)
  end
  if self.ui and self.ui.Btn_Detail then
    self:SetActive(self.ui.Btn_Detail, true == hasAwaker)
  end
  if self.ui and self.ui.Btn_More then
    self:SetActive(self.ui.Btn_More, true == hasAwaker)
  end
end

function GuideNoteAwakerStrengthView:_RefreshAwakerPortrait(awakerTid)
  if not self.ui or not self.ui.Group_Awaker_Portrait then
    return
  end
  if self.awakerPortraitComp and self.awakerPortraitComp.binder then
    self.awakerPortraitComp.binder:teardown()
    self.awakerPortraitComp = nil
  end
  local hasAwaker = awakerTid and 0 ~= awakerTid
  self:SetActive(self.ui.Group_Awaker_Portrait, true == hasAwaker)
  if true == hasAwaker then
    local dressedSkinTid = AwakerSkinUtils.GetAwakerDressedSkin(awakerTid)
    local skinResNum
    if dressedSkinTid and dressedSkinTid ~= cd.DefaultSkinTid then
      skinResNum = AwakerSkinUtils.GetSkinResNum(dressedSkinTid)
    end
    self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Group_Awaker_Portrait, awakerTid, skinResNum, nil, cd.PortraitAlign.Center))
  end
end

function GuideNoteAwakerStrengthView:_RenderComparePair(curNode, previewNode, curValue, previewValue)
  local isChanged = tostring(previewValue or 0) ~= tostring(curValue or 0)
  if curNode then
    self:SetText(curNode, self:_WrapColorText(curValue, false))
  end
  if previewNode then
    self:SetText(previewNode, self:_WrapColorText(previewValue, isChanged))
  end
  self:_SetCompareArrowVisible(previewNode, isChanged)
end

function GuideNoteAwakerStrengthView:_SplitCompareSlashSegments(text)
  if nil == text then
    return {}
  end
  local s = tostring(text)
  if "" == s then
    return {}
  end
  local parts = {}
  for piece in string.gmatch(s, "[^/]+") do
    parts[#parts + 1] = piece
  end
  return parts
end

function GuideNoteAwakerStrengthView:_SlashSegmentsAnyChanged(curText, previewText)
  local curParts = self:_SplitCompareSlashSegments(curText)
  local previewParts = self:_SplitCompareSlashSegments(previewText)
  local n = math.max(#curParts, #previewParts)
  for i = 1, n do
    if tostring(curParts[i] or "") ~= tostring(previewParts[i] or "") then
      return true
    end
  end
  return false
end

function GuideNoteAwakerStrengthView:_BuildSlashSegmentColoredPreview(curText, previewText)
  local curParts = self:_SplitCompareSlashSegments(curText)
  local previewParts = self:_SplitCompareSlashSegments(previewText)
  local n = math.max(#curParts, #previewParts)
  if n <= 0 then
    do return self._WrapColorText, self, previewText end
    return self._WrapColorText, self, previewText, false, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local chunks = {}
  for i = 1, n do
    local curVal = curParts[i]
    local prevVal = previewParts[i]
    if nil == prevVal then
      prevVal = ""
    end
    local segChanged = tostring(curVal or "") ~= tostring(prevVal or "")
    chunks[#chunks + 1] = self:_WrapColorText(prevVal, segChanged)
  end
  do return table.concat, chunks end
  return table.concat, chunks, "/", nil, curParts[i], "", true, #chunks + 1, self:_WrapColorText(prevVal, segChanged), self, prevVal, segChanged
end

function GuideNoteAwakerStrengthView:_RenderSlashSegmentComparePair(curNode, previewNode, curValue, previewValue)
  local anyChanged = self:_SlashSegmentsAnyChanged(curValue, previewValue)
  if curNode then
    self:SetText(curNode, self:_WrapColorText(curValue, false))
  end
  if previewNode then
    self:SetText(previewNode, self:_BuildSlashSegmentColoredPreview(curValue, previewValue))
  end
  self:_SetCompareArrowVisible(previewNode, anyChanged)
end

function GuideNoteAwakerStrengthView:_WrapColorText(v, isChanged)
  local c = isChanged and COLOR_CYAN or COLOR_WHITE
  do return string.format, "<color=#%s>%s</color>", c, tostring(v or 0) end
  return string.format, "<color=#%s>%s</color>", c, tostring(v or 0)
end

function GuideNoteAwakerStrengthView:_SetCompareArrowVisible(previewNode, isVisible)
  if not previewNode or not previewNode.transform then
    return
  end
  local parentTf = previewNode.transform.parent
  if not parentTf then
    return
  end
  local upTf = parentTf:Find("Image_Up")
  if upTf and upTf.gameObject then
    self:SetActive(upTf.gameObject, true == isVisible)
  end
end

return GuideNoteAwakerStrengthView

local UIAnimationController = CS.Z1Client.UIAnimationController
local Vector3 = CS.UnityEngine.Vector3
local MainCopyChapterPanel, Super = System.NewClass("MainCopyChapterPanel", UIBasePanel)
MainCopyChapterPanel.uiResCls = UI_Chapter_Panel_MainResource

function MainCopyChapterPanel:ctor(stageGroupId, defaultStageData, noShowDetail, model, ctorParams)
  Super.ctor(self)
  self.stageGroupId = Vue.ref(stageGroupId)
  self.defaultStageData = defaultStageData
  self.noShowDetail = noShowDetail
  self.isHard = Vue.ref(false)
  self.model = model
  self.ctorParams = ctorParams or {}
  self.assumedOpenAnimTime = 0
  self.stageGameObjListOnShow = {}
  self.isBossBg = Vue.ref(false)
end

function MainCopyChapterPanel:OnBind(binder)
  if not self.model then
    self.model = binder:createModel(MainCopyModel)
  end
  if self.ctorParams.stageGroupTid then
    self.model:SetStageGroupID(self.ctorParams.stageGroupTid)
  end
  if self.ctorParams.difficulty then
    self.model:SetHardMode(self.ctorParams.difficulty)
  end
  local model = self.model
  model:SetStageGroupID(self.stageGroupId.value)
  self:OnBindTopGroup(binder, model)
  self:OnBindCenterCircularListGroup(binder, model)
  self:OnBindStartGroup(binder, model)
  self:OnBindResonanceInfo(binder)
  self:OnBindAchievementGroup(binder, model)
  self:OnBindEvent(binder)
  self:_BindAnim()
  if self.defaultStageData then
    local jumpIndex = 1
    for index, data in pairs(MainCopyDataUtils.GetStageList(model.stageGroupId)) do
      if data.stageID == self.defaultStageData.stageID then
        jumpIndex = index
        break
      end
    end
    binder:ListViewJumpToIndex(self.ui.ScrollView_Level_List_Dbg, jumpIndex)
    if self.noShowDetail == nil or self.noShowDetail == false then
      self:OpenStageDetail()
    end
  end
  local stageGroupCfg = DT.StageGroup[self.stageGroupId.value]
  if stageGroupCfg.Type == CommonDefine.StageGroupType.MainCopyHard then
    model:SetHardMode(CommonDefine.Difficulty.Hard)
  elseif stageGroupCfg.Type == CommonDefine.StageGroupType.MainCopyCrazy then
    model:SetHardMode(CommonDefine.Difficulty.Super)
  end
end

function MainCopyChapterPanel:GetTempDependenciesResources()
  local Scene_MainInterface_P = GyroscopeManager.Instance:GetGyroscopeBgByUrl(Urls.MainCopyChapterPanel)
  return {Scene_MainInterface_P}
end

function MainCopyChapterPanel:_BindAnim()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.uiAnimController:PlayState("UI_Chapter_Panel_Main_Open")
end

function MainCopyChapterPanel:OnBindEvent(binder)
  binder:BindEvent(EventMgr.Instance.OnStoryReviewEnd, System.fn(self, self.OnStoryReviewEnd))
end

function MainCopyChapterPanel:OnStoryReviewEnd()
  AudioManager.Instance:PostSoundEvent("SET_STATE_A_INTERFACE_STORY")
end

function MainCopyChapterPanel:OnBindTopGroup(binder, model)
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:Close()
  end))
  binder:BindButtonClick(self.ui.Btn_Left, function()
    local preId = model:GetPreStageGroup(model.stageGroupId)
    if preId then
      model:SetStageGroupID(preId)
      self.uiAnimController:PlayState("UI_Chapter_Panel_Main_Change_Left")
    end
  end)
  binder:BindButtonClick(self.ui.Btn_Right, function()
    local nextId = model:GetNextStageGroup(model.stageGroupId)
    if nextId then
      if not StoryReviewModel.Instance:IsReviewingStory() then
        model:SetStageGroupID(nextId)
        self.uiAnimController:PlayState("UI_Chapter_Panel_Main_Change_Right")
      elseif StoryReviewModel.Instance:IsCopyStoryShouldReivew(nextId) then
        model:SetStageGroupID(nextId)
        self.uiAnimController:PlayState("UI_Chapter_Panel_Main_Change_Right")
      else
        Alert.Show(10904)
      end
    end
  end)
  binder:BindToVisible(self.ui.Btn_Left, function()
    return model:GetPreStageGroup(model.stageGroupId) ~= nil
  end)
  binder:BindToVisible(self.ui.Btn_Right, function()
    return model:GetNextStageGroup(model.stageGroupId) ~= nil
  end)
  binder:BindToText(self.ui.Text_Gamecopy_Name, function()
    do return model.GetStageGroupName, model end
    return model.GetStageGroupName, model, model.stageGroupId
  end)
  binder:BindToText(self.ui.Text_Gamecopy_NameNum, function()
    do return model.GetStageGroupChapter, model end
    return model.GetStageGroupChapter, model, model.stageGroupId
  end)
  binder:BindTimer(0.1, -1, System.fn(self, self.CheckIsBossBg))
end

function MainCopyChapterPanel:CheckIsBossBg()
  local isBossBg = false
  for stageId, gameObj in pairs(self.stageGameObjListOnShow) do
    if self:IsGameObjInCenter(gameObj) then
      local stageCfg = DT.Stage[stageId]
      if stageCfg.StageHighDifficulty == CommonDefine.StageDiffType.Boss then
        isBossBg = true
      end
      break
    end
  end
  self.isBossBg.value = isBossBg
end

function MainCopyChapterPanel:IsGameObjInCenter(gameObj)
  if not gameObj.activeSelf then
    return false
  end
  local rootTransform = self.ui.uiNode.transform
  local panelCenterX = 0
  local goTransForm = gameObj.transform
  local goWidth = goTransForm.rect.width
  local goCenterWorldPos = goTransForm:TransformPoint(Vector3.zero + Vector3(goWidth / 2, 0, 0))
  local goCenterPanelPos = rootTransform:InverseTransformPoint(goCenterWorldPos)
  local threshold = 30
  local widthThreshold = goWidth + threshold
  if goCenterPanelPos.x > panelCenterX - widthThreshold / 2 and goCenterPanelPos.x < panelCenterX + widthThreshold / 2 then
    return true
  end
  return false
end

function MainCopyChapterPanel:OnBindCenterCircularListGroup(binder, model)
  binder:BindNormalListView(self.ui.ScrollView_Level_List_Dbg, function()
    do return model.GetPanelStageList, model end
    return model.GetPanelStageList, model, model.stageGroupId
  end, function()
    return "UI_Chaper_Item_Level"
  end, function(itemBinder, item, index)
    local stageList = model:GetPanelStageList(model.stageGroupId)
    local stageInfo = stageList[index]
    itemBinder:BindComponent(MainCopyChapterContainer(item, stageInfo.stageData, stageInfo.index, stageInfo.totalIndex, model, self))
    self.stageGameObjListOnShow[stageInfo.stageData.stageID] = item
    itemBinder:onDestroy(function()
      self.stageGameObjListOnShow[stageInfo.stageData.stageID] = nil
    end)
  end)
  self.scrollRect = self.ui.ScrollView_Level_List_Dbg:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  binder:BindToRaw(function(_, list, _)
    if self.defaultStageData then
      return
    end
    for index, stageData in ipairs(list) do
      if not stageData.unlocked or index == #list then
        if index > 2 then
          binder:ListViewJumpToIndex(self.ui.ScrollView_Level_List_Dbg, index - 1)
          self:CheckIsBossBg()
        end
        break
      end
    end
  end, function()
    do return MainCopyDataUtils.GetStageList end
    return MainCopyDataUtils.GetStageList, model.stageGroupId
  end)
  binder:BindToVisible(self.ui.bg_Easy, function()
    return not model.hardMode == CommonDefine.Difficulty.Normal
  end)
  binder:BindToVisible(self.ui.bg_Difficulty, function()
    return model.hardMode == CommonDefine.Difficulty.Hard
  end)
  binder:BindToVisible(self.ui.bg_Nightmare, function()
    return model.hardMode == CommonDefine.Difficulty.Super
  end)
  self.ui.bg_Remember:SetActive(StoryReviewModel.Instance:IsReviewingStory())
  binder:BindToRaw(function(cbinder)
    cbinder:BindToRaw(function()
      self:RefreshGyroscopeBg()
    end, function()
      return self.isBossBg.value
    end)
  end, function()
    return model.stageGroupId
  end)
end

function MainCopyChapterPanel:RefreshGyroscopeBg()
  if self.isBossBg.value then
    GyroscopeManager.Instance:ChangeBg(CommonRes.BossBgPrefab, true)
    return
  end
  if self.model and self.model.stageGroupId then
    local stageGroupCfg = DT.StageGroup[self.model.stageGroupId]
    if stageGroupCfg.BackgrandPrefab then
      GyroscopeManager.Instance:ChangeBg(stageGroupCfg.BackgrandPrefab, true)
    end
  end
end

function MainCopyChapterPanel:OnBindStartGroup(binder, model)
  if StoryReviewModel.Instance:IsReviewingStory() then
    self.ui.Group_Progress:SetActive(false)
    return
  end
  binder:BindToRaw(function()
    self:AddViewComponentOnce(self.ui.Group_Progress, UICompSatgeGroupStarsProgress, model.stageGroupId)
  end, function()
    return model.stageGroupId
  end)
end

function MainCopyChapterPanel:OnBindResonanceInfo(binder)
  if StoryReviewModel.Instance:IsReviewingStory() then
    self.ui.Group_Resonance:SetActive(false)
    return
  end
  self.ui.Group_Resonance:SetActive(true)
  local ui = UI_Common_Btn_Level3Resource(self.ui.Group_Resonance)
  binder:SetText(ui.Text_Name, LT.Text("CopyResonanceBtnGroupName"))
  binder:BindToRaw(function(cbinder, resonanceGroupId)
    binder:BindComponent(ResonanceGroupComp(resonanceGroupId, ui.Btn_Progress, ui.Text_Progress_Cur, ui.Text_Progress_Limit, ui.RedDot, nil, self))
  end, function()
    do return ResonanceDataUtils.GetReonanceGroupIdByStageGroupId end
    return ResonanceDataUtils.GetReonanceGroupIdByStageGroupId, self.model.stageGroupId
  end)
end

function MainCopyChapterPanel:Close()
  self.closeBtn:PlayCloseAnim()
  self.uiAnimController:PlayState("UI_Chapter_Panel_Main_Close", function()
    Super.Close(self)
    GyroscopeManager.Instance:EnableGyroscope(Urls.MainPanel)
  end)
end

function MainCopyChapterPanel:OpenStageDetail()
  UIManager.Instance:Reopen(Urls.CopyStageDetailView, self.defaultStageData.stageID, function()
    UIManager.Instance:Reopen(Urls.MainCopyChapterPanel, self.model.stageGroupId)
  end)
end

function MainCopyChapterPanel:OnBindAchievementGroup(binder, model)
  if StoryReviewModel.Instance:IsReviewingStory() then
    self.ui.Group_Success:SetActive(false)
    return
  end
  binder:BindToRaw(function()
    self:AddViewComponentOnce(self.ui.Group_Success, UICompSatgeGroupArchiveGroup, model.stageGroupId)
  end, function()
    return model.stageGroupId
  end)
end

return MainCopyChapterPanel

local StageGroupType = CommonDefine.StageGroupType
local ColorType = CommonDefine.ColorType
local MAX_TOWER_NUM = 4
local SchoolTowerView, Super = NewClass("SchoolTowerView", BaseView)
SchoolTowerView.uiResCls = UI_Dungeons_Panel_RealmsResource

function SchoolTowerView:ctor()
  Super.ctor(self)
  self.model = SchoolTowerModel.Instance
  self.controller = SchoolTowerController.Instance
end

function SchoolTowerView:RegisterNotifications()
end

function SchoolTowerView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Btn_Shop, self.controller.OpenTowerShop)
end

function SchoolTowerView:OnEnterView()
  Super.OnEnterView(self)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self:_InitDefaultStageGroupType()
  self:_InitCountDown()
  self:_RefreshView()
end

function SchoolTowerView:_RefreshView()
  self:_RefeshSchoolTower()
  self:_RefreshSwitchBtnGroup()
  self.ui.Group_Toggle:SetActive(not SchoolTowerDataUtils.NeedBanAlternationSchool())
end

function SchoolTowerView:_InitDefaultStageGroupType()
  local defaultType = StageGroupType.DisposableSchoolTower
  local starTotalProgress, starTotalLimit = 0, 0
  for _, towerData in pairs(SchoolTowerDataUtils.GetTowerDataByStageGroupType(StageGroupType.DisposableSchoolTower)) do
    starTotalProgress = starTotalProgress + SchoolTowerDataUtils.GetTowerProgressStars(towerData.stageGroupId)
    starTotalLimit = starTotalLimit + SchoolTowerDataUtils.GetTowerLimitStars(towerData.stageGroupId)
  end
  if starTotalProgress >= starTotalLimit then
    defaultType = StageGroupType.AlternationSchoolTower
  end
  if SchoolTowerDataUtils.NeedBanAlternationSchool() then
    defaultType = StageGroupType.DisposableSchoolTower
  end
  self.model:Set_stageGroupType(defaultType)
end

function SchoolTowerView:_RefreshSwitchBtnGroup()
  local stgGpType = self.model.stageGroupType
  self.ui.Former_Selected:SetActive(stgGpType == StageGroupType.DisposableSchoolTower)
  self.ui.Image_IconFormer_Nor:SetActive(stgGpType == StageGroupType.AlternationSchoolTower)
  self.ui.Image_IconFormer_Sel:SetActive(stgGpType == StageGroupType.DisposableSchoolTower)
  self:SetTextColorType(self.ui.Text_C_Interval1, stgGpType == StageGroupType.DisposableSchoolTower and ColorType.Light or ColorType.Dark)
  self:AddViewComponentOnce(self.ui.Com_RedDot_Former, UICompRedDot, CommonDefine.RedDotType.Dot, function()
    do return RedPointDataUtils.IsShowSchoolTowerByStageGroupType end
    return RedPointDataUtils.IsShowSchoolTowerByStageGroupType, StageGroupType.DisposableSchoolTower
  end)
  self:AddButtonClickListener(self.ui.Brn_Former, function()
    self.model:Set_stageGroupType(StageGroupType.DisposableSchoolTower)
    self:_RefreshTimeText()
  end)
  self.ui.After_Selected:SetActive(stgGpType == StageGroupType.AlternationSchoolTower)
  self.ui.Image_IconAfter_Nor:SetActive(stgGpType == StageGroupType.DisposableSchoolTower)
  self.ui.Image_IconAfter_Sel:SetActive(stgGpType == StageGroupType.AlternationSchoolTower)
  self:SetTextColorType(self.ui.Text_C_Interval2, stgGpType == StageGroupType.AlternationSchoolTower and ColorType.Light or ColorType.Dark)
  self:AddButtonClickListener(self.ui.Btn_After, function()
    self.model:Set_stageGroupType(StageGroupType.AlternationSchoolTower)
    self:_RefreshTimeText()
  end)
  self:AddViewComponentOnce(self.ui.Com_RedDot_After, UICompRedDot, CommonDefine.RedDotType.Dot, function()
    do return RedPointDataUtils.IsShowSchoolTowerByStageGroupType end
    return RedPointDataUtils.IsShowSchoolTowerByStageGroupType, StageGroupType.AlternationSchoolTower
  end)
end

function SchoolTowerView:_RefeshSchoolTower()
  local stgGpType = self.model.stageGroupType
  local towerSvrData = self.model:GetTowerSvrData()
  for i = 1, MAX_TOWER_NUM do
    local obj_BtnSchool = self.ui["Btn_School_" .. i]
    local towerData = towerSvrData[i]
    if not towerSvrData[i] then
      obj_BtnSchool:SetActive(false)
    else
      obj_BtnSchool:SetActive(true)
      local stageGroupId = towerData.stageGroupId
      self:SetText(self.ui["Text_Star_Foundation_" .. i], LT.Text(string.format("%s/", SchoolTowerDataUtils.GetTowerProgressStars(stageGroupId))))
      self:SetText(self.ui["Text_Star_" .. i], SchoolTowerDataUtils.GetTowerLimitStars(stageGroupId))
      self.ui["Image_Star_" .. i]:SetActive(self.model:GetTowerFeatureUnlock(stageGroupId))
      self:AddButtonClickListener(self.ui["Btn_School_" .. i], function()
        self.controller:OpenTowerDetailView(stageGroupId)
      end)
      self:AddButtonClickListener(self.ui["Btn_Star_" .. i], function()
        self.controller:OpenProgressFirstRewardView(stageGroupId)
      end)
      self:SetText(self.ui["Text_Name_" .. i], self:_GetTowerName(stageGroupId))
      self.ui["Image_Lock_" .. i]:SetActive(not self.model:GetTowerFeatureUnlock(stageGroupId))
      self.ui["Image_NotUnlocked_" .. i]:SetActive(not self.model:GetTowerFeatureUnlock(stageGroupId))
      self:AddViewComponentOnce(self.ui["Com_RedDot_Former_" .. i], UICompRedDot, CommonDefine.RedDotType.Dot, function()
        do return self.model.GetTowerRedStage, self.model end
        return self.model.GetTowerRedStage, self.model, stageGroupId
      end)
      self.ui["Image_Dif_" .. i]:SetActive(stgGpType == StageGroupType.AlternationSchoolTower)
      self.ui["Image_DifBg_" .. i]:SetActive(stgGpType == StageGroupType.AlternationSchoolTower)
    end
  end
end

function SchoolTowerView:_InitCountDown()
  self.ui.Image_Time:SetActive(false)
  self.countDownTimer = self:BindTimer(0.5, -1, function()
    self:_RefreshTimeText()
  end)
end

function SchoolTowerView:_RefreshTimeText()
  self.binder:SetText(self.ui.Text_Time, self:_GetCountDownDesc())
  self.ui.Image_Time:SetActive(self:_GetCountDownVisible())
end

function SchoolTowerView:_GetCountDownDesc()
  local d, h = TimeUtils.ConvertTimeCeil(self.model:GetCountDown())
  do return LT.Textf, "ActivityTimeCountdown", d end
  return LT.Textf, "ActivityTimeCountdown", d, h
end

function SchoolTowerView:_GetCountDownVisible()
  if self.model:GetCountDown() < 0 then
    return false
  end
  return self.model:Get_stageGroupType() == StageGroupType.AlternationSchoolTower
end

function SchoolTowerView:RefreshOnRendered()
  self.uiAnimController:PlayState("UI_Dungeons_Panel_Realms_Open")
end

function SchoolTowerView:OnEnterViewFinished()
  self.uiAnimController:PlayState("UI_Dungeons_Panel_Realms_Open")
end

function SchoolTowerView:_GetTowerName(stageGroupId)
  local cfg = DT.StageGroup[stageGroupId] or {}
  return cfg.Name or ""
end

function SchoolTowerView:OnExitView()
  if self.countDownTimer then
    self:StopTimer(self.countDownTimer)
    self.countDownTimer = nil
  end
  Super.OnExitView(self)
end

return SchoolTowerView

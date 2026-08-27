local UISettingGraph = class("UISettingGraph", UIBaseWindow)
local UIGuideSettingGraphTogItem = require("Game.Setting.UI.UIGuideSettingGraphTogItem")
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader

function UISettingGraph:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.ConfirmClicked)
  self.presetPerformanceLevel = {
    1,
    3,
    4
  }
  self.resLoader = cs_ResLoader.Create()
  self.ui.togItemList = {}
  self.ui.tex_WarningText.gameObject:SetActive(false)
  self.ui.multiTogItem:SetActive(false)
end

function UISettingGraph:InitSettingGraph(confirmCallback)
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  local performanceLevelName = ConfigData:GetPerformanceTypeinfoByName("mode").option_group_name
  self.recommendPerformanceLevel = GameSystemInfo.GetGuideDefaultPerformance()
  for _, presetPerformanceLevel in ipairs(self.presetPerformanceLevel) do
    local index = presetPerformanceLevel
    local name = performanceLevelName ~= nil and performanceLevelName[index] ~= nil and LanguageUtil.GetLocaleText(performanceLevelName[index]) or ""
    local image = self:__GetPerformanceLevelShowImage(presetPerformanceLevel)
    local isOn = index == self.recommendPerformanceLevel
    local toggleItemObj = self.ui.multiTogItem:Instantiate(self.ui.settingGroup.transform)
    toggleItemObj.gameObject:SetActive(true)
    local guideSettingGraphTogItem = UIGuideSettingGraphTogItem.New()
    guideSettingGraphTogItem:Init(toggleItemObj)
    local OnPerformanceLevelChangedCallback = BindCallback(self, self.OnPerformanceLevelChanged)
    guideSettingGraphTogItem:InitGuideSettingGraphTogItem(index, isOn, isOn, index == 4, name, image, self.ui.settingGroup, OnPerformanceLevelChangedCallback)
    self.ui.togItemList[index] = guideSettingGraphTogItem
  end
  self.confirmCallback = confirmCallback
end

function UISettingGraph:OnPerformanceLevelChanged(value, togItem)
  if value then
    self.ctrl:SetPerformanceLevel(togItem.index)
    self.ui.tex_WarningText.gameObject:SetActive(togItem.index > self.recommendPerformanceLevel)
  end
end

function UISettingGraph:__GetPerformanceLevelShowImage(presetPerformanceLevel)
  local performance_setting = ConfigData.performance_setting[presetPerformanceLevel]
  local PerformanceLevelImagePath = performance_setting ~= nil and performance_setting.guide_graph or nil
  if PerformanceLevelImagePath ~= nil then
    local fullPath = PathConsts:GetImagePath(PerformanceLevelImagePath)
    local image = self.resLoader:LoadABAsset(fullPath)
    return image
  end
  return nil
end

function UISettingGraph:ConfirmClicked()
  self.ctrl:ForceSetToCurrentPerformanceLevel()
  PersistentManager:SaveModelData(PersistentConfig.ePackage.SystemData)
  self:Delete()
  if self.confirmCallback ~= nil then
    self.confirmCallback()
  end
end

function UISettingGraph:OnHide()
  base.OnHide(self)
end

function UISettingGraph:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self.ctrl = nil
  base.OnDelete(self)
end

return UISettingGraph

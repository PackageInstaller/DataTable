local UITrainingHeroList = class("UITrainingHeroList", UIBaseWindow)
local base = UIBaseWindow
local UINHeroSortList = require("Game.Hero.SortList.UINHeroSortList")
local HeroUpgradePreviewNode = require("Game.Training.SelectHero.UIHeroUpgradePreviewNode")
local TrainingPlanNode = require("Game.Training.SelectHero.UITrainingPlanNode")

function UITrainingHeroList:OnInit()
  self.OnTrainingHeroEvent = nil
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.__OnClickReturn)
  self.__refreshSelectHeroUI = BindCallback(self, self.__RefreshCureSelectHeroUIData)
end

function UITrainingHeroList:InitHeroList(resloader, efficiencyCfg)
  self.resloader = resloader
  self.heroPreviewNode = HeroUpgradePreviewNode.New()
  self.heroPreviewNode:Init(self.ui.attributeNode)
  self.trainingPlanNode = TrainingPlanNode.New()
  self.trainingPlanNode:Init(self.ui.planNode)
  self.trainingPlanNode:InitPlanNode(resloader, efficiencyCfg)
  self.trainingPlanNode.OnSelectEvent = BindCallback(self, self.__OnSelectPlan)
  self.trainingPlanNode.OnConfirmEvent = BindCallback(self, self.__OnConfirmSelectPlan)
  self.trainingPlanNode.OnCancelEvent = BindCallback(self, self.__OnCancelSelectPlan)
  self.panelSortList = UINHeroSortList.New()
  self.panelSortList:Init(self.ui.heroSortListNode)
  self.panelSortList:InitHeroSortList(self.resloader, self.__refreshSelectHeroUI)
  self.panelSortList:RefreshHeroList()
end

function UITrainingHeroList:__RefreshCureSelectHeroUIData(heroData)
  self.selectHero = heroData
  self.heroPreviewNode:InitHeroData(heroData)
  self.trainingPlanNode:ResetSelect()
end

function UITrainingHeroList:__OnSelectPlan(totalExp)
  self.heroPreviewNode:RefreshNextExp(totalExp)
end

function UITrainingHeroList:__OnCancelSelectPlan()
  self.heroPreviewNode:RefreshNextExp(0)
end

function UITrainingHeroList:__OnConfirmSelectPlan(efficencyId, costExp)
  if self.OnTrainingHeroEvent ~= nil then
    self.OnTrainingHeroEvent(self.selectHero.dataId, efficencyId, costExp)
  end
end

function UITrainingHeroList:__OnClickReturn()
  self:Delete()
end

function UITrainingHeroList:OnDelete()
  self.resloader = nil
  if self.panelSortList ~= nil then
    self.panelSortList:Delete()
    self.panelSortList = nil
  end
  if self.trainingPlanNode ~= nil then
    self.trainingPlanNode:Delete()
    self.trainingPlanNode = nil
  end
  if self.heroPreviewNode ~= nil then
    self.heroPreviewNode:Delete()
    self.heroPreviewNode = nil
  end
  base.OnDelete(self)
end

return UITrainingHeroList

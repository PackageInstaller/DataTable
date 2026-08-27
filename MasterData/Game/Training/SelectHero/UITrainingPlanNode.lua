local UITrainingPlanNode = class("UITrainingPlanNode", UIBaseNode)
local base = UIBaseNode
local MaterialItem = require("Game.Training.SelectHero.UITrainingPlanMaterialItem")
local cs_MessageCommon = CS.MessageCommon

function UITrainingPlanNode:OnInit()
  self.OnSelectEvent = nil
  self.OnConfirmEvent = nil
  self.OnCancelEvent = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfim)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.__OnClickCancel)
  self.ui.materialItem:SetActive(false)
  self.__matItems = {}
end

function UITrainingPlanNode:InitPlanNode(resloader, efficiencyCfg)
  self.efficiencyCfg = efficiencyCfg
  for i, time in ipairs(ConfigData.game_config.trainingTimeCfg) do
    local go = self.ui.materialItem:Instantiate()
    go:SetActive(true)
    local item = MaterialItem.New()
    item:Init(go)
    item:InitMatItem(resloader, i, time)
    item.OnClickEvent = BindCallback(self, self.__OnSeletctPlan)
    self.__matItems[i] = item
  end
end

function UITrainingPlanNode:__OnSeletctPlan(id)
  for k, v in pairs(self.__matItems) do
    v:Select(v.id == id)
  end
  local time = ConfigData.game_config.trainingTimeCfg[id]
  local efficiency = self:__GetEfficiency()
  local costExp = time * efficiency
  local buffRatio = 0
  local totalExp = costExp * (1 + buffRatio)
  self.__efficencyId = id
  self.__costExp = costExp
  self.ui.tex_UseGlobalExp:SetIndex(0, tostring(costExp))
  self.ui.tex_Gain:SetIndex(0, tostring(buffRatio * 100))
  if self.OnSelectEvent ~= nil then
    self.OnSelectEvent(totalExp)
  end
end

function UITrainingPlanNode:__GetEfficiency()
  for i = #self.efficiencyCfg, 1, -1 do
    local cfg = self.efficiencyCfg[i]
    if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      return cfg.training_para
    end
  end
  error("找不到符合的经验效率")
end

function UITrainingPlanNode:ResetSelect()
  for k, v in pairs(self.__matItems) do
    v:Select(false)
  end
  self.ui.tex_UseGlobalExp.text.text = ""
  self.ui.tex_Gain.text.text = ""
  self.__efficencyId = nil
  self.__costExp = nil
end

function UITrainingPlanNode:__OnClickCancel()
  self:ResetSelect()
  if self.OnCancelEvent ~= nil then
    self.OnCancelEvent()
  end
end

function UITrainingPlanNode:__OnClickConfim()
  if self.__efficencyId == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Train_SelectPlan))
    return
  end
  if self.OnConfirmEvent ~= nil then
    self.OnConfirmEvent(self.__efficencyId, self.__costExp)
  end
end

function UITrainingPlanNode:OnDelete()
  base.OnDelete(self)
end

return UITrainingPlanNode

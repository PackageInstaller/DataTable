local UIFmtEvaluationItem = class("UIFmtEvaluationItem", UIBaseNode)
local base = UIBaseNode

function UIFmtEvaluationItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.btn_PressItem) then
    self.ui.btn_PressItem.onPress:AddListener(BindCallback(self, self.__OnEvaluationPress))
    self.ui.btn_PressItem.onPressUp:AddListener(BindCallback(self, self.__OnEvaluationPressUp))
  end
end

function UIFmtEvaluationItem:UpdateItemDisplay(advTypeId, isAdvantage, textColor, eColorType)
  self.advTypeId = advTypeId
  self.isAdvantage = isAdvantage
  if not IsNull(self.ui.btn_evaluationItem) then
    self.ui.btn_evaluationItem.enabled = isAdvantage
  end
  self.ui.itemBg:SetIndex(eColorType)
  local desStr
  if advTypeId < 100 then
    local careerCfg = ConfigData.career[advTypeId]
    if careerCfg == nil then
      error("找不到角色的职业配置，配置id:" .. tostring(advTypeId))
      return
    end
    desStr = LanguageUtil.GetLocaleText(careerCfg.name)
    self.ui.icon.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  elseif advTypeId == 100 then
    desStr = ConfigData:GetTipContent(903)
    self.ui.icon.sprite = CRH:GetSprite(ConfigData.chip_mark[2].icon, CommonAtlasType.ExplorationIcon)
  elseif advTypeId == 101 then
    desStr = ConfigData:GetTipContent(904)
    self.ui.icon.sprite = CRH:GetSprite(ConfigData.chip_mark[1].icon, CommonAtlasType.ExplorationIcon)
  end
  local index = isAdvantage and 1 or 0
  self.ui.text:SetIndex(index, desStr)
  self.ui.text.text.color = textColor
  self.ui.icon.color = textColor
end

function UIFmtEvaluationItem:SetEvaluationItemClickAct(pressAct, pressUpAct)
  self.pressAct = pressAct
  self.pressUpAct = pressUpAct
end

function UIFmtEvaluationItem:__OnEvaluationPress()
  if self.pressAct ~= nil then
    self.pressAct(self.transform, self.advTypeId, self.isAdvantage)
  end
end

function UIFmtEvaluationItem:__OnEvaluationPressUp()
  if self.pressUpAct ~= nil then
    self.pressUpAct()
  end
end

function UIFmtEvaluationItem:OnDelete()
  base.OnDelete(self)
end

return UIFmtEvaluationItem

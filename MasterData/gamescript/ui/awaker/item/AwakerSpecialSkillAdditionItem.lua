local AwakerSpecialSkillAdditionItem, Super = System.NewComponent("AwakerSpecialSkillAdditionItem")

function AwakerSpecialSkillAdditionItem:ctor(res, effectType, funcModule)
  Super.ctor(self)
  self.ui = UI_Awaker_Button_AdditionResource(res)
  self.effectType = effectType
  self.funcModule = funcModule
end

function AwakerSpecialSkillAdditionItem:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(AwakerSpecialSkillModel)
  binder:BindToVisible(self.ui.uiNode, function()
    return false
  end)
  binder:BindButtonClick(self.ui.Group_Item, function()
    if self.effectType == nil then
      return
    end
    AwakerDataUtils.OpenAwakerSpecialSkillActivePanel(self.effectType, self.funcModule)
  end)
  self:BindRedDotComponent()
end

function AwakerSpecialSkillAdditionItem:BindRedDotComponent()
  self.binder:BindComponent(RedDotComponent(self.ui.Group_Sub_RedDot, CommonDefine.RedDotType.Dot, function()
    do return self.model.IsSpecialSkill_Can_Active, self.model, self.effectType end
    return self.model.IsSpecialSkill_Can_Active, self.model, self.effectType, self.funcModule
  end))
end

return AwakerSpecialSkillAdditionItem

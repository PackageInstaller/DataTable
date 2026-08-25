local AssistAwakerSkillItem, Super = System.NewComponent("AssistAwakerSkillItem")

function AssistAwakerSkillItem:ctor(uiNode, skill)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Skill_NodeResource(uiNode)
  self.skill = skill
end

function AssistAwakerSkillItem:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Image_Skill_Icon, function()
    if self.skill.isBreakthroughSkill then
      return self.skill.icon
    else
      local slot = self.skill.slot
      local iconName = DT.GetOriginalConstant("AwakerSkillIconName")[slot]
      return AwakerDataUtils.GetSkillIconPrefix() .. iconName
    end
  end)
  binder:BindToText(self.ui.Text_Skill_Level, function()
    do return string.format, "Lv.%s" end
    return string.format, "Lv.%s", self.skill.lv
  end)
end

return AssistAwakerSkillItem

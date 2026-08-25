local AssistAwakerSkillListCom, Super = System.NewComponent("AssistAwakerSkillListCom")

function AssistAwakerSkillListCom:ctor(ui, skilllist)
  Super.ctor(self)
  self.ui = ui
  self.skilllist = skilllist
end

function AssistAwakerSkillListCom:OnBind(binder)
  self.binder = binder
  local skills = self.skilllist
  for i = 1, #skills do
    local obj = self.ui["UI_Awaker_Item_Skill_Node" .. i]
    local skill = skills[i]
    binder:SetActive(obj, nil ~= skill)
    binder:BindComponent(AssistAwakerSkillItem(obj, skill))
  end
end

return AssistAwakerSkillListCom

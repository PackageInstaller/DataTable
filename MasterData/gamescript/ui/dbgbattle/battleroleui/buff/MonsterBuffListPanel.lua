local MonsterBuffListPanel, Super = System.NewClass("MonsterBuffListPanel", UIBasePanel)
MonsterBuffListPanel.uiResCls = Panel_Battle_Monster_InformationResource

function MonsterBuffListPanel:ctor(role, effectDescGroup)
  Super.ctor(self)
  self.role = role
  self.effectDescGroup = effectDescGroup
  self.roleDataModel = bg.battleDataCenter:GetRoleDataModel(role.uid)
  self.intentInfo = self.roleDataModel.intentionInfo
  self.skill = DT.Skill[self.intentInfo.intention]
  self.monsterConfig = self.roleDataModel.configData
end

function MonsterBuffListPanel:OnBind(binder)
  self.loopListView = self.ui.ScrollView_Battle_Information1:GetComponent(typeof(CS.Z1ScrollView.LoopListView))
  self.adaptaionSpacing = self.loopListView.mAdaptationSpacing
  binder:BindButtonClick(self.ui.Button_Mask, System.fn(self, self.Close))
  binder:LoadAllLangFont(self.ui.Text_Monster_Name)
  binder:LoadAllLangFont(self.ui.Text_Skill_Name)
  binder:LoadAllLangFont(self.ui.Text_Monster_Desc)
  binder:BindToText(self.ui.Text_Monster_Name, function()
    do return LT.Text, bg.battleDataCenter:GetRoleName(self.role.uid) end
    return LT.Text, bg.battleDataCenter:GetRoleName(self.role.uid)
  end)
  binder:BindToText(self.ui.Text_Monster_Lv, function()
    return "Lv." .. bg.battleDataCenter:GetRoleLevel(self.role.uid)
  end)
  binder:BindToText(self.ui.Text_Monster_Desc, function()
    return self.monsterConfig.Desc
  end)
  binder:BindToText(self.ui.Text_Skill_Name, function()
    if not self.skill then
      return ""
    end
    return self:GetSkillName() or ""
  end)
  binder:BindToText(self.ui.Text_Skill_Desc_1, function()
    if not self.skill then
      return ""
    end
    do return SkillUtils.GetAwakerSkillDesc, self.roleDataModel, self.skill.ID, 1 end
    return SkillUtils.GetAwakerSkillDesc, self.roleDataModel, self.skill.ID, 1, self.intentInfo.descArgs
  end, nil, nil, {
    lockParentNode = self.ui.Node_Keyword_Tips_Pos
  })
  StrUtils.SetPreferredHeight(self.ui.Text_Skill_Name)
  StrUtils.SetPreferredHeight(self.ui.Text_Skill_Desc_1)
  binder:BindToText(self.ui.Text_Skill_Desc_2, function()
    if not self.skill then
      return ""
    end
    do return SkillUtils.GetAwakerSkillDesc, self.roleDataModel, self.skill.ID, 1 end
    return SkillUtils.GetAwakerSkillDesc, self.roleDataModel, self.skill.ID, 1, self.intentInfo.descArgs
  end, nil, nil, {
    lockParentNode = self.ui.Node_Keyword_Tips_Pos
  })
  binder:BindToText(self.ui.Text_TypeName, function()
    if not self.monsterConfig then
      return
    end
    local monsterTid = self.monsterConfig.ID
    if not CopyDataUtils.HasMonsterTypeName(monsterTid) then
      return ""
    end
    do return CopyDataUtils.GetMonsterTypeName end
    return CopyDataUtils.GetMonsterTypeName, monsterTid
  end)
  binder:BindToImage(self.ui.Image_Monster_Icon, function()
    return self.monsterConfig.MiniIcon
  end)
  binder:BindToImage(self.ui.Image_Monster_Label, function()
    if self.monsterConfig.MonsterClass == CommonDefine.MonsterClass.Elite then
      return "UIResources/AtlasSource/UI_Battle_Image/UI_Buff_Tips_JingYing.png"
    elseif self.monsterConfig.MonsterClass == CommonDefine.MonsterClass.Boss then
      return "UIResources/AtlasSource/UI_Battle_Image/UI_Buff_Tips_LingXiu.png"
    end
    return ""
  end)
  binder:BindToImage(self.ui.Image_Skill_Icon, function()
    return self.intentInfo.intentionIcon
  end)
  binder:BindToVisible(self.ui.ScrollView_KeyWords, function()
    return #self.effectDescGroup.descList > 0
  end)
  binder:BindComponent(CommonEffectDescGroup(self.ui.CardKeyWordItem_New, self.effectDescGroup))
  binder:BindToVisible(self.ui.Group_Boss_Show, function()
    return self.monsterConfig.MonsterClass ~= CommonDefine.MonsterClass.Common
  end)
  binder:BindToVisible(self.ui.Group_Skill_Infomation, function()
    local blind = bg.battleDataCenter:GetPlayerRoleProperty(bc.BattleProperty.blind)
    if blind and blind > 0 then
      return false
    end
    return self.skill ~= nil
  end)
  binder:BindToVisible(self.ui.Group_Have_Name, function()
    if not self.skill then
      return false
    end
    return self:GetSkillName() ~= nil
  end)
  binder:BindToVisible(self.ui.Image_Line_1, function()
    if not self.skill then
      return false
    end
    local skillName = self:GetSkillName()
    return skillName and "" ~= skillName
  end)
  binder:BindToVisible(self.ui.Group_No_Name, function()
    if not self.skill then
      return false
    end
    return self:GetSkillName() == nil
  end)
  self:BindMonterTags()
  StrUtils.SetPreferredHeight(self.ui.Text_Monster_Desc)
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Group_Story)
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Group_Skill_Infomation)
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.Group_Content)
end

function MonsterBuffListPanel:BindMonterTags()
  self.binder:BindToRaw(function(cbinder, tagList)
    local childList = {}
    local parent = self.ui.MonsterTag.transform.parent
    local baseGameObj = self.ui.MonsterTag
    for _, tagTid in ipairs(tagList) do
      local uiNode = cbinder:Instantiate(baseGameObj, parent)
      cbinder:SetActive(uiNode, true)
      local comp = cbinder:BindComponent(UIBattleTagItem(uiNode, tagTid, tagList))
      table.insert(childList, comp)
    end
    local gapx, gapy = 8, 9
    local height = UIUtils.FillContainerToWidth(parent.sizeDelta.x, childList, gapx, gapy, 20, 0)
    CS.Framework.TransformUtil.SetHeight(parent, height)
  end, function()
    do return CopyDataUtils.GetMonsterTagList end
    return CopyDataUtils.GetMonsterTagList, self.monsterConfig.ID
  end)
end

function MonsterBuffListPanel:GetSkillName()
  if not self.skill then
    return false
  end
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(self.roleDataModel)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(self.roleDataModel)
  do return BattleSkillUtils.GetSkillName, self.skill, breakSkillLevel end
  return BattleSkillUtils.GetSkillName, self.skill, breakSkillLevel, potencyLevel
end

function MonsterBuffListPanel:Close()
  Super.Close(self)
end

return MonsterBuffListPanel

local PVPMonsterBuffListPanel, Super = System.NewClass("PVPMonsterBuffListPanel", UIBasePanel)
PVPMonsterBuffListPanel.uiResCls = Panel_Battle_Monster_InformationResource

function PVPMonsterBuffListPanel:ctor(role, buffList)
  Super.ctor(self)
  self.role = role
  self.buffList = buffList
  self.roleDataModel = bg.battleDataCenter:GetRoleDataModel(role.uid)
  self.intentInfo = self.roleDataModel.intentionInfo
  self.skill = DT.Skill[self.intentInfo.intention]
end

function PVPMonsterBuffListPanel:OnBind(binder)
  self.loopListView = self.ui.ScrollView_Battle_Information1:GetComponent(typeof(CS.Z1ScrollView.LoopListView))
  self.adaptaionSpacing = self.loopListView.mAdaptationSpacing
  binder:BindButtonClick(self.ui.Button_Mask, System.fn(self, self.Close))
  binder:LoadAllLangFont(self.ui.Text_Monster_Name)
  binder:LoadAllLangFont(self.ui.Text_Skill_Name)
  binder:LoadAllLangFont(self.ui.Text_Monster_Desc)
  binder:BindToText(self.ui.Text_Monster_Name, function()
    do return LT.Text, bg.battleDataCenter:GetRoleName(self.role.uid, true) end
    return LT.Text, bg.battleDataCenter:GetRoleName(self.role.uid, true)
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
    local properties = self.awakerDataModel.properties
    local awakerData = {
      attrs = {
        max_hp = self.roleDataModel:GetMaxHp()
      }
    }
    for key, val in pairs(properties) do
      awakerData.attrs[key] = val
    end
    do return SkillUtils.GetAwakerSkillDesc, awakerData, self.skill.ID, 1 end
    return SkillUtils.GetAwakerSkillDesc, awakerData, self.skill.ID, 1, self.role.skillArgs, nil, awakerData.attrs
  end)
  binder:BindToText(self.ui.Text_Skill_Desc_2, function()
    if not self.skill then
      return ""
    end
    local properties = self.awakerDataModel.properties
    local awakerData = {
      attrs = {
        max_hp = self.roleDataModel:GetMaxHp()
      }
    }
    for key, val in pairs(properties) do
      awakerData.attrs[key] = val
    end
    do return SkillUtils.GetAwakerSkillDesc, awakerData, self.skill.ID, 1 end
    return SkillUtils.GetAwakerSkillDesc, awakerData, self.skill.ID, 1, self.role.skillArgs, nil, awakerData.attrs
  end)
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
  local totalLen = 0
  local buffList1 = {}
  local buffList2 = {}
  for _, data in pairs(self.buffList) do
    local obj = binder:BindComponent(NewBuffListItem(self.ui.Item_Battle_Information_Test, self.role, data))
    totalLen = totalLen + (obj.textComp.preferredHeight + self.adaptaionSpacing)
    if totalLen <= 850 then
      table.insert(buffList1, data)
    else
      table.insert(buffList2, data)
    end
  end
  binder:BindExpandListView(self.ui.ScrollView_Battle_Information1, function()
    return buffList1
  end, function()
    return "Item_Battle_Information_New"
  end, function(itemBinder, item, index)
    itemBinder:BindComponent(NewBuffListItem(item, self.role, buffList1[index], self.adaptaionSpacing))
  end)
  binder:BindExpandListView(self.ui.ScrollView_Battle_Information2, function()
    return buffList2
  end, function()
    return "Item_Battle_Information_New"
  end, function(itemBinder, item, index)
    itemBinder:BindComponent(NewBuffListItem(item, self.role, buffList2[index], self.adaptaionSpacing))
  end)
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
  binder:BindToVisible(self.ui.Group_No_Name, function()
    if not self.skill then
      return false
    end
    return self:GetSkillName() == nil
  end)
end

function PVPMonsterBuffListPanel:GetSkillName()
  if not self.skill then
    return false
  end
  local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(self.awakerDataModel)
  local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(self.awakerDataModel)
  do return BattleSkillUtils.GetSkillName, self.skill, breakSkillLevel end
  return BattleSkillUtils.GetSkillName, self.skill, breakSkillLevel, potencyLevel
end

function PVPMonsterBuffListPanel:Close()
  Super.Close(self)
end

return PVPMonsterBuffListPanel

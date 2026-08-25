local RedType = RedPointDataUtils.RedType
local RedDotType = CommonDefine.RedDotType
local AwakerSkillListItem, Super = System.NewComponent("AwakerSkillListItem")

function AwakerSkillListItem:ctor(res, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Skill_NodeResource(res)
  self.model = data.model
  self.skill = data.skill
  self.callback = data.callback
end

function AwakerSkillListItem:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick), nil, nil, function()
    return self.skill.slot ~= self.model.selectSlot
  end)
  binder:BindToText(self.ui.Text_Skill_Name, function()
    if not self.skill.isBreakthroughSkill and not self.skill.isSpecialSkill then
      local name = self.model:GetSkillName(self.skill.slot, CommonDefine.AwakerSkillMode.DBG)
      return name
    else
      return self.skill.name
    end
  end)
  binder:BindToText(self.ui.Text_Skill_Level, function()
    if not self.skill.isBreakthroughSkill and not self.skill.isSpecialSkill then
      local slotLevel = self.model:GetSkillLevel(self.skill.slot, CommonDefine.AwakerSkillMode.DBG)
      do return string.format, "Lv.%s" end
      return string.format, "Lv.%s", slotLevel
    else
      return ""
    end
  end)
  binder:BindToTextColorOld(self.ui.Text_Skill_Level, function()
    if not self.skill.isBreakthroughSkill and not self.skill.isSpecialSkill then
      local slotLevel = self.model:GetSlotLevel(self.skill.slot)
      local skillLevel = self.model:GetSkillLevel(self.skill.slot, CommonDefine.AwakerSkillMode.DBG)
      return slotLevel < skillLevel and "#6CD7EA" or "#FFFFFF"
    else
      return "#FFFFFF"
    end
  end)
  binder:BindToImage(self.ui.Image_Skill_Icon, function()
    if self.skill.isBreakthroughSkill then
      return self.skill.icon
    else
      local icon = self.model:GetSkillIcon(self.skill.slot, CommonDefine.AwakerSkillMode.DBG)
      return icon
    end
  end)
  binder:BindToVisible(self.ui.Image_Select_Select, function()
    return self.skill.slot == self.model.selectSlot
  end)
  binder:BindToVisible(self.ui.Image_Lock, function()
    local skill = self.model:GetSkillData(self.skill.slot)
    if not skill then
      return false
    end
    if skill.isBreakthroughSkill then
      return not skill.actived
    else
      return skill.lock or false
    end
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, RedDotType.Dot, nil, function()
    local awakerTid = self.model.awakerTid
    if not self.model.awakerModel:HasOwnedAwaker(awakerTid) then
      return false
    end
    if not self.skill.isSpecialSkill then
      do return RedPointDataUtils.GetRedPointState, RedType.AwakerSkill end
      return RedPointDataUtils.GetRedPointState, RedType.AwakerSkill, {
        awakerTid,
        self.skill.slot
      }, awakerTid, self.skill.slot
    else
      return false
    end
  end))
end

function AwakerSkillListItem:OnClick()
  if not self.skill or not self.callback then
    return
  end
  self.callback(self.skill.slot)
end

return AwakerSkillListItem

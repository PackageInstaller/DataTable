local AwakerSpecialSkillListItem, Super = System.NewComponent("AwakerSpecialSkillListItem")

function AwakerSpecialSkillListItem:ctor(res, data, model, showNew)
  Super.ctor(self)
  self.ui = UI_Awaker_Special_Skill_ItemResource(res)
  self.data = data
  self.model = model
  self.showNew = showNew
end

function AwakerSpecialSkillListItem:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Group_Dis, System.fn(self, self._NotActiveGroupVisible))
  binder:BindToVisible(self.ui.Group_Lock, System.fn(self, self._NotActiveGroupVisible))
  binder:BindToText(self.ui.Text_Title, System.fn(self, self._GetSkillTitle))
  binder:BindToText(self.ui.Text_Info, System.fn(self, self._GetSkillDesc))
  binder:BindToText(self.ui.Text_Level, System.fn(self, self._GetOwnerName))
  binder:BindToImage(self.ui.Image_Awaker, System.fn(self, self._GetSkillIcon))
  binder:BindToImage(self.ui.Image_D_Quality_Color, System.fn(self, self._GetSkillQualityFrame))
  if self.showNew then
    binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.TextNew, System.fn(self, self._IsNewVisible)))
  end
end

function AwakerSpecialSkillListItem:_GetSkillQualityFrame()
  do return self.model.GetSpecialSkillOwnerQualityFrame, self.model end
  return self.model.GetSpecialSkillOwnerQualityFrame, self.model, self.data.tid
end

function AwakerSpecialSkillListItem:_GetSkillIcon()
  do return self.model.GetSpecialSkillAwakerIcon, self.model end
  return self.model.GetSpecialSkillAwakerIcon, self.model, self.data.tid
end

function AwakerSpecialSkillListItem:_GetOwnerName()
  do return self.model.GetOwnerName, self.model end
  return self.model.GetOwnerName, self.model, self.data.tid
end

function AwakerSpecialSkillListItem:_GetSkillTitle()
  do return self.model.GetSpecialSkillTitle, self.model end
  return self.model.GetSpecialSkillTitle, self.model, self.data.tid
end

function AwakerSpecialSkillListItem:_GetSkillDesc()
  do return self.model.GetSpecialSkillDesc, self.model end
  return self.model.GetSpecialSkillDesc, self.model, self.data.tid
end

function AwakerSpecialSkillListItem:_NotActiveGroupVisible()
  return not self.model:IsEffectActive(self.data.tid, self.data.awaker)
end

function AwakerSpecialSkillListItem:_IsNewVisible()
  local redDataType = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.AwakerSpecialSkill, {
    self.data.tid,
    self.data.awaker
  })
  return redDataType and redDataType == RedPointDataUtils.RedAttrType.IsNew
end

return AwakerSpecialSkillListItem

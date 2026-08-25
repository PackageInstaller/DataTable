local Z1ButtonState = CS.Z1Client.Z1ButtonState
local AwakerSpecialSkillPanel, Super = System.NewClass("AwakerSpecialSkillPanel", UIBasePanel)
AwakerSpecialSkillPanel.uiResCls = UI_Awaker_Special_Skill_MainResource

function AwakerSpecialSkillPanel:ctor()
  Super.ctor(self)
  self.filters = nil
  self.hasShowSkills = {}
end

function AwakerSpecialSkillPanel:OnBind(binder)
  self.model = binder:createModel(AwakerSpecialSkillModel, true)
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetEffectList), System.fn(self, self._OnEffectListItemUpdate))
  binder:BindToCircularListView(self.ui.ScrollView_Type, System.fn(self, self._GetFilters), System.fn(self, self._OnFilterUpdate))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self._OnFilterMaskClick))
  binder:BindToVisible(self.ui.Btn_Mask, System.fn(self, self._OnFilterMaskVisible))
  binder:BindZ1Button(self.ui.Button_Tips, System.fn(self, self._OnFilterTypeClick), nil, function()
    do return self.model.GetSpecialSkillEffectTypeName, self.model end
    return self.model.GetSpecialSkillEffectTypeName, self.model, self.model.filter
  end)
  binder:BindToVisible(self.ui.UI_Popup_Type, System.fn(self, self._FiltersVisibleFunc))
  binder:BindToText(self.ui.Text_C_Type, function()
    do return self.model.GetSpecialSkillEffectTypeName, self.model end
    return self.model.GetSpecialSkillEffectTypeName, self.model, self.model.filter
  end)
  binder:BindToText(self.ui.Text_Tips, System.fn(self, self._GetActiveNum))
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back2, System.fn(self, self.Close)))
end

function AwakerSpecialSkillPanel:_OnFilterMaskClick()
  self.model:SetFilterSwitch(false)
end

function AwakerSpecialSkillPanel:_OnFilterMaskVisible()
  return self.model.filterSwitch
end

function AwakerSpecialSkillPanel:_FiltersVisibleFunc()
  return self.model.filterSwitch
end

function AwakerSpecialSkillPanel:_OnFilterTypeClick()
  self.model:SetFilterSwitch(true)
end

function AwakerSpecialSkillPanel:_GetActiveNum()
  local numInfo = self.model:GetSpecialSkillActiveNum(self.model.filter)
  do return LT.Textf, "SpecialSkillActiveNumText", numInfo.activeNum end
  return LT.Textf, "SpecialSkillActiveNumText", numInfo.activeNum, numInfo.totalNum
end

function AwakerSpecialSkillPanel:_GetEffectList()
  return self.model.specialSkillList
end

function AwakerSpecialSkillPanel:_OnEffectListItemUpdate(itemBinder, go, index)
  local data = self.model.specialSkillList[index]
  itemBinder:BindComponent(AwakerSpecialSkillListItem(go, data, self.model, true))
  local redDataType = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.AwakerSpecialSkill, {
    data.tid,
    data.awaker
  })
  if not redDataType then
    return
  end
  if not self.hasShowSkills[data.tid] then
    self.hasShowSkills[data.tid] = {}
  end
  if self.hasShowSkills[data.tid][data.awaker] then
    return
  end
  self.hasShowSkills[data.tid][data.awaker] = true
end

function AwakerSpecialSkillPanel:_GetFilters()
  if self.filters then
    return self.filters
  end
  self.filters = self.model:GetFilters()
  return self.filters
end

function AwakerSpecialSkillPanel:_OnFilterUpdate(itemBinder, go, index)
  local filterType = self.filters[index]
  itemBinder:BindZ1Button(go, function()
    self.model:SetFilter(filterType)
    self.model:SetFilterSwitch(false)
  end, function()
    if filterType == self.model.filter then
      return Z1ButtonState.High
    end
    return Z1ButtonState.Normal
  end, function()
    do return self.model.GetSpecialSkillEffectTypeName, self.model end
    return self.model.GetSpecialSkillEffectTypeName, self.model, filterType
  end)
end

function AwakerSpecialSkillPanel:Close()
  if self.hasShowSkills then
    local delList = {}
    for spSkillTid, awakerTidMap in pairs(self.hasShowSkills) do
      if spSkillTid and table.next(awakerTidMap) ~= nil then
        for awakerTid, _ in pairs(awakerTidMap) do
          if awakerTid then
            local data = {tid = spSkillTid, awaker = awakerTid}
            table.insert(delList, data)
            RedPointDataUtils.RemoveData(RedPointDataUtils.RedType.AwakerSpecialSkill, spSkillTid, awakerTid)
          end
        end
      end
      self.hasShowSkills[spSkillTid] = nil
    end
    if #delList > 0 then
      RedPointDataUtils.SetSpecialSkillLocalRed(delList, false)
    end
  end
  Super.Close(self)
end

return AwakerSpecialSkillPanel

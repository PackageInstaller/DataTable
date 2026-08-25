local UICompResonanceGroup, Super = NewViewComponent("UICompResonanceGroup")

function UICompResonanceGroup:ctor(uiNode, view, params)
  Super.ctor(self, uiNode, view)
  self.resonanceGroupId = params.resonanceGroupId or 0
  self.isShowExtraItem = params.isShowExtraItem
  self.stageGroupTid = params.stageGroupTid
end

function UICompResonanceGroup:OnBuildComponent()
  self.text_Name = self:FindChild(self.gameObject, "Text_Progress/Text_C_Resonance")
  self.text_Progress = self:FindChild(self.gameObject, "Text_Progress")
  self.red_Resonance = self:FindChild(self.gameObject, "Red_Resonance")
  self:SetText(self.text_Name, LT.Text("CopyResonanceBtnGroupName"))
end

function UICompResonanceGroup:RegisterEvents()
  self:AddButtonClickListener(self.gameObject, function()
    UIManager.Instance:Reopen(Urls.ResonanceMainPanel, {
      resonanceGroupId = self.resonanceGroupId,
      stageGroupTid = self.stageGroupTid
    })
  end)
end

function UICompResonanceGroup:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnResonanceDataChanged, self._OnResonanceDataChanged, self)
end

function UICompResonanceGroup:OnEnterComponent()
  self.gameObject:SetActive(false)
  if 0 == self.resonanceGroupId then
    return
  end
  ResonanceDataUtils.ReqResonanceData(self.resonanceGroupId, function()
    self:_RefreshResonaceInfo()
  end)
  self.view:AddRedPoint(self.red_Resonance, RedDotDefine.DynamicRedDotID.ResonanceGroupRedDot, {
    resonanceGroupTid = self.resonanceGroupId
  })
end

function UICompResonanceGroup:_RefreshResonaceInfo()
  self.gameObject:SetActive(true)
  local curLevel = ResonanceDataUtils.GetResonanceGroupTotalLevel(self.resonanceGroupId)
  local totalLevel = ResonanceDataUtils.GetResonanceGroupMaxLevel(self.resonanceGroupId)
  self:SetText(self.text_Progress, curLevel .. "/" .. totalLevel)
end

function UICompResonanceGroup:_OnResonanceDataChanged(resonanceGroupId)
  if self.resonanceGroupId == resonanceGroupId then
    self:_RefreshResonaceInfo()
  end
end

return UICompResonanceGroup

local FindChild = CS.Framework.GameObjectUtil.FindChild
local ResonanceGroupComp, Super = System.NewComponent("ResonanceGroupComp")

function ResonanceGroupComp:ctor(resonanceGroupId, btnGo, textProgressGo, textTotalGo, redGo, activityId, view, isActivityResonance)
  Super.ctor(self)
  self.resonanceGroupId = resonanceGroupId
  self.btnGo = btnGo
  self.textProgressGo = textProgressGo
  self.textTotalGo = textTotalGo
  self.redGo = redGo
  self.activityId = activityId
  self.view = view
  self.isActivityResonance = isActivityResonance
end

function ResonanceGroupComp:OnBind(binder)
  self.binder = binder
  ResonanceDataUtils.ReqResonanceData(self.resonanceGroupId, function()
    if self.btnGo then
      self.binder:BindButtonClick(self.btnGo, function()
        UIManager.Instance:Reopen(Urls.ResonanceMainPanel, {
          resonanceGroupId = self.resonanceGroupId,
          isActivity = self.isActivityResonance
        })
      end)
    end
    self:BindProgress()
    if self.redGo then
      local image = self.redGo:GetComponent(typeof(CS.UnityEngine.UI.Image))
      if image then
        image.enabled = false
      end
      local imageRedDot = FindChild(self.redGo, "Image_RedDot")
      if imageRedDot then
        self.binder:SetActive(imageRedDot, false)
      end
      if self.view and self.view.AddRedPoint then
        self.view:AddRedPoint(self.redGo, RedDotDefine.DynamicRedDotID.ResonanceGroupRedDot, {
          resonanceGroupTid = self.resonanceGroupId
        })
      else
        self.binder:BindComponent(UICompRedDotNewVue(self.redGo, RedDotDefine.DynamicRedDotID.ResonanceGroupRedDot, {
          resonanceGroupTid = self.resonanceGroupId
        }))
      end
    end
  end)
end

function ResonanceGroupComp:BindProgress()
  if self.textProgressGo then
    self.binder:BindToText(self.textProgressGo, function()
      local curLevel = ResonanceDataUtils.GetResonanceGroupTotalLevel(self.resonanceGroupId)
      if self.textTotalGo then
        return curLevel
      end
      local totalLevel = ResonanceDataUtils.GetResonanceGroupMaxLevel(self.resonanceGroupId)
      do return string.format, "%s/%s", curLevel end
      return string.format, "%s/%s", curLevel, totalLevel
    end)
  end
  if self.textTotalGo then
    self.binder:BindToText(self.textTotalGo, function()
      local totalLevel = ResonanceDataUtils.GetResonanceGroupMaxLevel(self.resonanceGroupId)
      if self.textProgressGo then
        return totalLevel
      end
      local curLevel = ResonanceDataUtils.GetResonanceGroupTotalLevel(self.resonanceGroupId)
      do return string.format, "%s/%s", curLevel end
      return string.format, "%s/%s", curLevel, totalLevel
    end)
  end
end

return ResonanceGroupComp

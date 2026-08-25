local DOTween = CS.DG.Tweening.DOTween
local TrinketConversionEntry, Super = System.NewComponent("TrinketConversionEntry")

function TrinketConversionEntry:ctor(uiNode, slotIndex, strengthenModel, trinketModel, isConversion, blockClickFunc)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Trinket_HoistResource(uiNode)
  self.strengthenModel = strengthenModel
  self.isConversion = isConversion
  self.trinketModel = trinketModel
  self.slotIndex = slotIndex
  self.isConversionValue = false
  self.blockClickFunc = blockClickFunc
end

function TrinketConversionEntry:OnBind(binder)
  binder:BindToRaw(function(childBinder, n, _)
    binder:SetActive(self.ui.uiNode, nil ~= n)
    if not n then
      return
    end
    self:BindEntry(childBinder, n)
  end, function()
    local uid = self.strengthenModel.trinketUid
    local attrs
    if self.isConversion then
      attrs = self.strengthenModel:GetSubConversionAttrsResult()
    else
      attrs = self.trinketModel:GetSubAttrs(uid)
    end
    return attrs[self.slotIndex]
  end)
  binder:BindEvent(EventMgr.Instance.TrinketConversionAnim, function()
    self.isConversionValue = true
  end)
end

function TrinketConversionEntry:BindEntry(binder, attrsData)
  local maxValue = self.trinketModel:GetSubAttrMaxValue(attrsData.tid)
  binder:BindToImage(self.ui.Image_Icon, function()
    local tid = attrsData.tid
    if not tid or 0 == tid then
      return ""
    end
    return DT.ActorAttrType[tid].Icon
  end)
  binder:BindToText(self.ui.Text_Name, function()
    local tid = attrsData.tid
    if not tid or 0 == tid then
      return ""
    end
    do return LT.Text end
    return LT.Text, DT.ActorAttrType[tid].Text
  end)
  binder:BindToText(self.ui.Text_Value, function()
    do return AwakerTrinketDataUtils.GetAttrFmtString end
    return AwakerTrinketDataUtils.GetAttrFmtString, attrsData
  end)
  binder:BindToText(self.ui.Text_Level, function()
    do return AwakerTrinketDataUtils.GetTrinketSubAttrLevel end
    return AwakerTrinketDataUtils.GetTrinketSubAttrLevel, attrsData
  end)
  binder:BindToRaw(function(_, to)
    local Image_Slider = self.ui.Image_Slider:GetComponent(typeof(CS.UnityEngine.UI.Slider))
    local speed = 0.5
    binder:SetActive(self.ui.UI_Vx_Awaker_Trinket_Glow, false)
    if to > 0 and not self.strengthenModel:IsConversionAttrLocked(attrsData.uid) and self.isConversion and self.isConversionValue then
      if to >= 1 then
        binder:SetActive(self.ui.UI_Vx_Awaker_Trinket_Glow, true)
      end
      self.isConversionValue = false
      if self.attrTweener then
        self.attrTweener:Kill(true)
        self.attrTweener = nil
      end
      Image_Slider.value = 0
      self.attrTweener = DOTween.To(function()
        return Image_Slider.value
      end, function(percent)
        Image_Slider.value = percent
      end, to, speed, self)
    else
      Image_Slider.value = to
    end
  end, function()
    local value = attrsData.count
    return value / maxValue
  end)
  local lockUI
  lockUI = binder:BindCommonLockPrefab(self.ui.UI_Common_Btn_Lock, UI_Common_Btn_LockResource, function(isOn)
    if self.blockClickFunc and self.blockClickFunc() then
      return
    end
    self.strengthenModel:LockConversionAttr(attrsData.uid, isOn)
    if isOn then
      local curLockedNum = self.strengthenModel:GetCurTrinketRefineLockNum()
      local maxLockNum = self.strengthenModel:GetTrinketRefineLockMaxNum()
      if curLockedNum > maxLockNum then
        Alert.Show(10706)
        binder:SetActive(lockUI.Btn_Lock, false)
        binder:SetActive(lockUI.Btn_Unlock, true)
        self.strengthenModel:LockConversionAttr(attrsData.uid, false)
        return
      end
    end
  end, function()
    do return self.strengthenModel.IsConversionAttrLocked, self.strengthenModel end
    return self.strengthenModel.IsConversionAttrLocked, self.strengthenModel, attrsData.uid
  end)
  binder:BindToVisible(self.ui.UI_Common_Btn_Lock, function()
    return not self.isConversion
  end)
end

function TrinketConversionEntry:OnUnbind()
  Super.OnUnbind(self)
  if self.attrTweener then
    self.attrTweener:Kill(true)
    self.attrTweener = nil
  end
end

return TrinketConversionEntry

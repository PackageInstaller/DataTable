local CS = _ENV.CS
local math = _ENV.math
local tonumber = _ENV.tonumber
local Slider = typeof(CS.UnityEngine.UI.Slider)
local Button = typeof(CS.UnityEngine.UI.Button)
local AudioControlComponent, Super = System.NewComponent("Item_Audio_ControlResource")

function AudioControlComponent:ctor(res, rtpc)
  Super.ctor(self)
  self.ui = Item_Audio_ControlResource(res)
  self.rtpc = rtpc
end

function AudioControlComponent:OnBind(binder)
  self.binder = binder
  self:InitState()
  self.binder:BindButtonClick(self.ui.Btn_Switch, function()
    if 0 == self.isON.value then
      CS.Framework.UIUtilTool.AnimatorSetBool(self.animator, "playon", true)
      self.isON.value = 1
      self:BanQuickClick()
    elseif 1 == self.isON.value then
      CS.Framework.UIUtilTool.AnimatorSetBool(self.animator, "playoff", true)
      self.isON.value = 0
      self:BanQuickClick()
    end
  end)
  self.binder:BindToSliderValueChange(self.ui.Slider_Audio, function()
    self.val.value = self.ui.Slider_Audio:GetComponent(Slider).value
    if 1 == self.isON.value then
      AudioManager.Instance:SetRTPCValueByName(self.rtpc, self.val.value)
    end
  end)
  self.binder:BindToRaw(function(_, new, _)
    self.ui.Slider_Audio:GetComponent(Slider).value = new
    self.binder:SetText(self.ui.Text_Count, math.floor(new))
  end, function()
    return self.val.value
  end)
  self.binder:BindToRaw(function(_, new, _)
    if 1 == new then
      self.ui.Fill_Mask:SetActive(false)
      AudioManager.Instance:SetRTPCValueByName(self.rtpc, self.val.value)
    elseif 0 == new then
      self.ui.Fill_Mask:SetActive(true)
      AudioManager.Instance:SetRTPCValueByName(self.rtpc, 0)
    end
  end, function()
    return self.isON.value
  end)
end

function AudioControlComponent:OnUnbind()
  MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. self.rtpc .. "_isON", self.isON.value)
  MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. self.rtpc .. "_val", self.val.value)
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function AudioControlComponent:InitState()
  self.ui.Btn_Switch:GetComponent(Button).interactable = true
  self.animator = self.ui.Btn_Audio_Switch:GetComponent(typeof(CS.UnityEngine.Animator))
  self.isON = Vue.ref(0)
  self.isON.value = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. self.rtpc .. "_isON") and tonumber(MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. self.rtpc .. "_isON")) or 1
  self.val = Vue.ref(0)
  self.val.value = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. self.rtpc .. "_val") and tonumber(MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. self.rtpc .. "_val")) or 100
  if 1 == self.isON.value then
    CS.Framework.UIUtilTool.AnimatorSetBool(self.animator, "ON", true)
  else
    CS.Framework.UIUtilTool.AnimatorSetBool(self.animator, "OFF", true)
  end
end

function AudioControlComponent:BanQuickClick()
  self.ui.Btn_Switch:GetComponent(Button).interactable = false
  self.binder:BindTimer(0.5, 1, nil, function()
    self.ui.Btn_Switch:GetComponent(Button).interactable = true
  end)
end

return AudioControlComponent

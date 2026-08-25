local AwakerVoiceItem, Super = System.NewComponent("AwakerVoiceItem")

function AwakerVoiceItem:ctor(uiNode, awakerVoiceData, model, clickCb)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Story_ListResource(uiNode)
  self.data = awakerVoiceData
  self.model = model
  self.clickCb = clickCb
end

function AwakerVoiceItem:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Image_Select_Blank, function()
    return self.data.soundEventStr
  end)
  binder:BindToVisible(self.ui.Image_Normal_Blank, function()
    return self.data.soundEventStr
  end)
  binder:BindToVisible(self.ui.Image_Icon_Play_Select, function()
    return self.data.soundEventStr and not self:IsPlaying()
  end)
  binder:BindToVisible(self.ui.Image_Icon_Play_Normal, function()
    return self.data.soundEventStr and not self:IsPlaying()
  end)
  binder:BindToVisible(self.ui.UI_Vx_Awaker_Story_Main_Voice_1, function()
    do return self.IsPlaying end
    return self.IsPlaying, self
  end)
  binder:BindToVisible(self.ui.UI_Vx_Awaker_Story_Main_Voice_2, function()
    do return self.IsPlaying end
    return self.IsPlaying, self
  end)
  binder:BindToImage(self.ui.Image_Icon_Play_Select, function()
    return "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Btn_Play.png"
  end)
  binder:BindToImage(self.ui.Image_Icon_Play_Normal, function()
    return "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Btn_Play.png"
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    if self.data.unlock == CommonDefine.AwakerStoryVoiceState.Unlock then
      return "isNew"
    end
    return false
  end))
  binder:BindToVisible(self.ui.Group_Normal, function()
    return self:IsUnlock() and not self:IsChoose()
  end)
  binder:BindToVisible(self.ui.Group_Select, function()
    return self:IsUnlock() and self:IsChoose()
  end)
  binder:BindToVisible(self.ui.Group_Lock, function()
    return not self:IsUnlock() and not self:IsChoose()
  end)
  binder:BindToVisible(self.ui.Group_Lock_Select, function()
    return not self:IsUnlock() and self:IsChoose()
  end)
  binder:BindButtonClick(self.ui.Btn_Story, function()
    if self.clickCb then
      self.clickCb()
    end
  end)
  binder:BindToText(self.ui.Text_Story_Lock, function()
    do return LT.Text end
    return LT.Text, self.data.title
  end)
  binder:BindToText(self.ui.Text_Story_Select, function()
    do return LT.Text end
    return LT.Text, self.data.title
  end)
  binder:BindToText(self.ui.Text_Story_Normal, function()
    do return LT.Text end
    return LT.Text, self.data.title
  end)
  binder:BindToText(self.ui.Text_Story_Lock_Select, function()
    do return LT.Text end
    return LT.Text, self.data.title
  end)
end

function AwakerVoiceItem:IsUnlock()
  return self.data.unlock > CommonDefine.AwakerStoryVoiceState.Lock
end

function AwakerVoiceItem:IsChoose()
  return self.data.tid == self.model.curSelectVoiceId
end

function AwakerVoiceItem:IsPlaying()
  return self.data.soundEventStr == self.model.curPlayingVoiceName
end

return AwakerVoiceItem

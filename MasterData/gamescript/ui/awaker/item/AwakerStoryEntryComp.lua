local AwakerPage = CommonDefine.AwakerPage
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local AwakerStoryEntryComp, Super = System.NewComponent("AwakerStoryEntryComp")

function AwakerStoryEntryComp:ctor(uiNode, awakerModel, storyModel)
  Super.ctor(self)
  self.ui = UI_Awaker_PanelStory_MainResource(uiNode)
  self.awakerModel = awakerModel
  self.storyModel = storyModel
  self.scrollView = self.ui.ScrollView_Story:GetComponent(T_ScrollRect)
end

function AwakerStoryEntryComp:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.Btn_Story, System.fn(self, self.OpenStoryDetail), function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "AwakerStoryIcon"
  end, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerModel.selectAwakerId)
    do return RedPointDataUtils.IsShowAwakerNewStoryRedPoint, self.awakerModel.selectAwakerId end
    return RedPointDataUtils.IsShowAwakerNewStoryRedPoint, self.awakerModel.selectAwakerId, awakerData and awakerData.curSkin
  end)
  self:_OnBindBtnVoice()
  binder:BindToVisible(self.ui.Btn_Story, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    do return self.awakerModel.HasOwnedAwaker, self.awakerModel end
    return self.awakerModel.HasOwnedAwaker, self.awakerModel, self.awakerModel.selectAwakerId
  end)
  binder:BindToVisible(self.ui.Btn_Voice, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    do return self.awakerModel.HasOwnedAwaker, self.awakerModel end
    return self.awakerModel.HasOwnedAwaker, self.awakerModel, self.awakerModel.selectAwakerId
  end)
  binder:BindToText(self.ui.Text_Story, function()
    do return LT.Text end
    return LT.Text, self.storyModel.messageShowDesc
  end)
  binder:BindToRaw(function()
    self.scrollView.verticalNormalizedPosition = 1
    binder:BindTimer(0.2, 0, nil, function()
      StrUtils.SetPreferredHeight(self.ui.Text_Story, 0)
    end)
  end, function()
    return self.storyModel.messageShowDesc
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Item_Message, function()
    return self.storyModel.messageShowList
  end, function(itemBinder, item, index)
    local data = self.storyModel.messageShowList[index]
    local property = data.property
    local message = data.message
    local obj = UI_Awaker_Item_MessageResource(item)
    itemBinder:BindToText(obj.Text_Property, function()
      do return LT.Text end
      return LT.Text, property
    end)
    itemBinder:BindToText(obj.Text_Message, function()
      do return LT.Text end
      return LT.Text, message
    end)
  end)
  binder:BindEvent(EventMgr.Instance.OnAwakerPvpVoiceStateChanged, System.fn(self, self._OnBindBtnVoice))
end

function AwakerStoryEntryComp:_OnBindBtnVoice()
  self.binder:BindZ1Button(self.ui.Btn_Voice, System.fn(self, self.OpenVoiceDetail), function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "AwakerVoiceIcon"
  end, function()
    do return RedPointDataUtils.IsShowAwakerVoiceRedPoint end
    return RedPointDataUtils.IsShowAwakerVoiceRedPoint, self.awakerModel.selectAwakerId
  end)
end

function AwakerStoryEntryComp:OpenStoryDetail()
  self.awakerModel:SetAwakerPage(AwakerPage.StoryDetail)
end

function AwakerStoryEntryComp:OpenVoiceDetail()
  self.awakerModel:SetAwakerPage(AwakerPage.VoiceDetail)
end

function AwakerStoryEntryComp:CalTMPFontSizeHeight(fontObj, offset)
  local compTMP = fontObj:GetComponent(typeof(CS.TMPro.TMP_Text))
  compTMP:ForceMeshUpdate()
  local fontSize = compTMP.fontSize
  local fontSpaceing = compTMP.lineSpacing
  local lineCount = compTMP.textInfo.lineCount
  local tran = fontObj.transform
  local sizeDelta = tran.sizeDelta
  sizeDelta.y = fontSize * lineCount + (lineCount - 1) * fontSpaceing + (offset * lineCount or 0)
  tran.sizeDelta = sizeDelta
end

return AwakerStoryEntryComp

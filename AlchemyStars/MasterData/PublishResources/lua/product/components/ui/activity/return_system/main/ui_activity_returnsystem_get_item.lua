_class("UIActivityReturnSystemGetItem", UIController)
UIActivityReturnSystemGetItem = UIActivityReturnSystemGetItem

function UIActivityReturnSystemGetItem:Constructor()
  self.imgPetOffset = Vector2(-40, -120)
end

function UIActivityReturnSystemGetItem:OnShow(uiParams)
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.tranPet = self:GetGameObject("imgIcon"):GetComponent(typeof(UnityEngine.RectTransform))
  self.tranPet.anchoredPosition = self.imgPetOffset
  self.txtPetName = self:GetUIComponent("UILocalizationText", "txtPetName")
  self.txtPet = self:GetUIComponent("UILocalizationText", "txtPet")
  self.poolAwards = self:GetUIComponent("UISelectObjectPath", "awards")
  self.selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self.tips = self.selectInfoPool:SpawnObject("UISelectInfo")
  self:AttachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self.ShowItemInfo)
  self.awards = uiParams[1]
  self.petIcon = uiParams[2]
  self.petName = uiParams[3]
  self.greeting = uiParams[4]
  self:Flush()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
end

function UIActivityReturnSystemGetItem:OnHide()
  if self.imgIcon then
    self.imgIcon:DestoryLastImage()
    self.imgIcon = nil
  end
  self:DetachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self.ShowItemInfo)
end

function UIActivityReturnSystemGetItem:Flush()
  self.imgIcon:DestoryLastImage()
  self.imgIcon:LoadImage(self.petIcon)
  self.txtPetName:SetText(self.petName)
  self.txtPet:SetText(self.greeting)
  self:FlushAwards()
end

function UIActivityReturnSystemGetItem:FlushAwards()
  local len = table.count(self.awards)
  self.poolAwards:SpawnObjects("UIActivityReturnSystemTabLoginAwardItem", len)
  local uiAwards = self.poolAwards:GetAllSpawnList()
  for i, uiAward in ipairs(uiAwards) do
    uiAward:Flush(self.awards[i])
  end
end

function UIActivityReturnSystemGetItem:ShowItemInfo(matid, pos)
  self.tips:SetData(matid, pos)
end

function UIActivityReturnSystemGetItem:bgOnClick()
  self:_PlayAnimOut()
end

function UIActivityReturnSystemGetItem:imgCloseOnClick()
  self:_PlayAnimOut()
end

function UIActivityReturnSystemGetItem:_PlayAnimOut()
  self.anim = self:GetUIComponent("Animation", "animation")
  self:StartTask(function(TT)
    self:Lock("UIActivityReturnSystemGetItem_PlayAnimOut")
    self.anim:Play("uieff_Return_GetItem_Fade")
    YIELD(TT, 200)
    self:UnLock("UIActivityReturnSystemGetItem_PlayAnimOut")
    self:CloseDialog()
  end, self)
end

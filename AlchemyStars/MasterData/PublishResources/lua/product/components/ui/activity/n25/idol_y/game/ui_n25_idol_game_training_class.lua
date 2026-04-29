_class("UIN25IdolGameTrainingClass", UICustomWidget)
UIN25IdolGameTrainingClass = UIN25IdolGameTrainingClass

function UIN25IdolGameTrainingClass:SetData(trainType, value, txtSong, head, muse, callback)
  self._trainType = trainType or 1
  self._callback = callback
  self:_SetState(trainType)
  self:SetBtnState(1)
  self:_SetHead(head)
  self:_SetText(txtSong)
  self:_SetTrainPoint(muse, trainType, value)
  self:_SetMuse(muse ~= nil)
end

function UIN25IdolGameTrainingClass:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "_bg_music",
      "_headBg_music"
    },
    {
      "_bg_dance",
      "_headBg_dance"
    },
    {
      "_bg_perform",
      "_headBg_perform"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIN25IdolGameTrainingClass:SetBtnState(state)
  self._btnStateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"StartBtn"},
    {"ProcessBtn"}
  }, self._btnStateObj)
  UIWidgetHelper.SetObjGroupShow(self._btnStateObj, state)
end

function UIN25IdolGameTrainingClass:_SetHead(head)
  if head then
    UIWidgetHelper.SetRawImage(self, "_head", head)
  end
  self:GetGameObject("_headGroup"):SetActive(head ~= nil)
end

function UIN25IdolGameTrainingClass:_SetText(txtSong)
  if txtSong then
    UIWidgetHelper.SetLocalizationText(self, "_txtSong", StringTable.Get(txtSong))
  end
end

function UIN25IdolGameTrainingClass:_SetTrainPoint(muse, trainType, value)
  value = muse or value
  local uiType = muse and 3 or 2
  local obj = UIWidgetHelper.SpawnObject(self, "_trainPoint", "UIN25IdolCommonTrainPoint")
  obj:SetData(uiType, trainType, value, nil)
end

function UIN25IdolGameTrainingClass:_SetMuse(isShow)
  self:GetGameObject("_muse"):SetActive(isShow)
  UIWidgetHelper.SetAnimationPlay(self, "_anim", "uieff_UIN25IdolGameTrainingClass_muse_loop")
end

function UIN25IdolGameTrainingClass:StartBtnOnClick(go)
  if self._callback then
    self._callback(self._trainType, self)
  end
end

_class("UIN12PhotoReviewItem", UICustomWidget)
UIN12PhotoReviewItem = UIN12PhotoReviewItem

function UIN12PhotoReviewItem:OnShow(uiParams)
  self:_GetComponent()
  self:_SetValue(uiParams)
end

function UIN12PhotoReviewItem:_GetComponent()
  self._lock = self:GetGameObject("_lock")
  self._lockGo = self:GetUIComponent("RectTransform", "_lock")
  self._lockRaw = self:GetUIComponent("RawImage", "_bgunlock")
  self._bgGo = self:GetUIComponent("RectTransform", "_bg")
  self._bg = self:GetUIComponent("RawImageLoader", "_bg")
  self._bgRaw = self:GetUIComponent("RawImage", "_bg")
  self._bgunlock = self:GetUIComponent("RawImageLoader", "_bgunlock")
  self._quad = self:GetUIComponent("MeshRenderer", "_quad")
  self._anim = self:GetUIComponent("Animation", "_anim")
  self._red = self:GetGameObject("_red")
  self._redGo = self:GetUIComponent("RectTransform", "_red")
  self._btnRect = self:GetUIComponent("RectTransform", "Btn")
end

function UIN12PhotoReviewItem:SetData(idx, cfg, story_component, info, callback, callback1)
  self._idx = idx
  self._cfg = cfg
  self._story_component = story_component
  self._info = info
  self._callback = callback
  self._callback1 = callback1
  self:_SetShow()
end

function UIN12PhotoReviewItem:_SetValue(uiParams)
  self._islock = false
  self._isEnough = true
  self._isanim = false
end

function UIN12PhotoReviewItem:_SetShow()
  self.mat = ResourceManager:GetInstance():SyncLoadAsset(self._cfg.photo.Icon .. ".mat", LoadType.Mat)
  if not self.mat then
    return
  end
  self._quad.material:SetTexture("_MainTex", self.mat.Obj:GetTexture("_MainTex"))
  if self._cfg.photo.LockIcon then
    self._bgunlock:LoadImage(self._cfg.photo.LockIcon)
  end
  if self._info.m_total_count >= self._cfg.needcount then
    self._isEnough = true
  else
    self._isEnough = false
  end
  self._islock = self._cfg.lock
  if self._cfg.photo.LockIcon then
    self:SetRed(self._cfg.last == not self:CheckStoryGotAwards())
  else
    self:SetRed(not self:CheckStoryGotAwards())
  end
  self:_SetTrans()
end

function UIN12PhotoReviewItem:_SetTrans()
  local size = self._cfg.photo.Size
  local redpos = self._cfg.photo.RedPos
  local btnSize = self._cfg.photo.BtnSize
  local btnOffset = self._cfg.photo.BtnOffset
  self._lockGo.sizeDelta = Vector2(size[1], size[2])
  self._bgGo.sizeDelta = Vector2(size[1], size[2])
  self._btnRect.sizeDelta = Vector2(btnSize[1], btnSize[2])
  self._btnRect.anchoredPosition = Vector2(btnOffset[1], btnOffset[2])
  self._redGo.anchoredPosition = Vector2(redpos[1], redpos[2])
  self._quad.transform.localScale = Vector3(size[1], size[2], 1)
end

function UIN12PhotoReviewItem:SetRed(isShow, islock)
  if islock ~= nil then
    self._islock = islock
  end
  if not self._cfg.photo.LockIcon then
    self._lockRaw.color = Color.clear
  end
  if not self._islock and not self._isanim then
    self._isanim = true
    self:PlayAnim("uieff_N12_Photo_Unlock")
  end
  self._bg.gameObject:SetActive(not self._islock)
  self._red:SetActive(isShow and not self._islock)
end

function UIN12PhotoReviewItem:_StoryEndCallBack()
  if self._callback then
    self._callback(self._idx)
  end
end

function UIN12PhotoReviewItem:GetsEnough()
  return self._isEnough
end

function UIN12PhotoReviewItem:GetSurprised()
  return self._cfg.photo.Surprised
end

function UIN12PhotoReviewItem:PlayAnim(anim_name)
  self._anim:Play(anim_name)
end

function UIN12PhotoReviewItem:BtnOnClick()
  if self._islock then
    return
  end
  self:ShowDialog("UIN12SynopsisController", self._cfg.storyid, self._story_component, function()
    self:_StoryEndCallBack()
  end, self._cfg.photo, self._idx, function()
    return self._callback1()
  end)
end

function UIN12PhotoReviewItem:LockOnClick()
  if self._islock then
    if self._isEnough then
      ToastManager.ShowToast(StringTable.Get("str_n12_look_story_unlock"))
    else
      ToastManager.ShowToast(StringTable.Get("str_n12_get_story_score_unlock", self._cfg.needcount))
    end
  end
end

function UIN12PhotoReviewItem:CheckStoryGotAwards(idx)
  local recv_list = self._story_component:GetAlreadyReceivedStoryIdList()
  return table.icontains(recv_list, self._cfg.storyid)
end

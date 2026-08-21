_class("UISeasonMaze_Campsites_Recruit_Item", UICustomWidget)
UISeasonMaze_Campsites_Recruit_Item = UISeasonMaze_Campsites_Recruit_Item

function UISeasonMaze_Campsites_Recruit_Item:InitWidget()
  self._SelectedAreaGo = self:GetGameObject("SelectedArea")
  self._SelectedOtherAreaGo = self:GetGameObject("SelectedOtherArea")
  self._card = self:GetUIComponent("UISelectObjectPath", "card")
  self._cardGo = self:GetGameObject("card")
  self._cardAreaGo = self:GetGameObject("cardarea")
  self._imgBG = self:GetGameObject("imgBG")
  self._imgBG:SetActive(false)
  self._interactableImg = self:GetUIComponent("Image", "imgBG")
  self._imgMask = self:GetGameObject("imgMask")
  self._imgMask:SetActive(false)
  self._tran = self:GetGameObject():GetComponent("RectTransform")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._callback = nil
end

function UISeasonMaze_Campsites_Recruit_Item:Flush()
  self._cardGo:SetActive(true)
  self:Select()
  local uiItem = self._card:SpawnObject("UISeasonMaze_Campsites_RecruitPetItem")
  self._itemTemp = uiItem
  uiItem:SetData(self._petInfo, self._petInfoList)
  return
end

function UISeasonMaze_Campsites_Recruit_Item:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMaze_Campsites_Recruit_Item:SetData(idx, petInfo, petInfoList, callback)
  if not petInfo then
    return
  end
  self._idx = idx
  self._petInfo = petInfo
  self._callback = callback
  self._petInfoList = petInfoList
  self:Flush()
end

function UISeasonMaze_Campsites_Recruit_Item:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UISeasonMaze_Campsites_Recruit_Item:BtnOnClick()
  if self._callback then
    self._callback(self._idx)
  end
end

function UISeasonMaze_Campsites_Recruit_Item:Select(index)
  if not index then
    self._SelectedAreaGo:SetActive(false)
    self._SelectedOtherAreaGo:SetActive(false)
    return
  end
  self._SelectedAreaGo:SetActive(self._idx == index)
  self._SelectedOtherAreaGo:SetActive(self._idx ~= index)
  if self._idx == index then
    if self._anim then
      self._anim:Stop()
      self._anim:Play("uianim_UISeasonMaze_Campsites_RecruitItem_Selected")
    end
  elseif self._anim then
    self._anim:Stop()
    self._anim:Play("uianim_UISeasonMaze_Campsites_RecruitItem_mask")
  end
end

function UISeasonMaze_Campsites_Recruit_Item:PlayShowInAnim(delay)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._cardAreaGo:SetActive(true)
  end
  if delay and 0 < delay then
    self._cardAreaGo:SetActive(false)
    self._timer = GameGlobal.Timer():AddEvent(delay, function()
      self._cardAreaGo:SetActive(true)
      if self._anim then
        self._anim:Play("uianim_UISeasonMaze_Campsites_RecruitItem_in")
      end
    end)
  else
    self._cardAreaGo:SetActive(false)
    self._timer = GameGlobal.Timer():AddEvent(delay, function()
      self._cardAreaGo:SetActive(true)
      if self._anim then
        self._anim:Play("uianim_UISeasonMaze_Campsites_RecruitItem_in")
      end
    end)
  end
end

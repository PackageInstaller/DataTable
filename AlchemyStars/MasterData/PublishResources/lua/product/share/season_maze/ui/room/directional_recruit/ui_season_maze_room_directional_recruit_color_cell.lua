_class("UISeasonMazeRoom_DirectionalRecruitColorCell", UICustomWidget)
UISeasonMazeRoom_DirectionalRecruitColorCell = UISeasonMazeRoom_DirectionalRecruitColorCell

function UISeasonMazeRoom_DirectionalRecruitColorCell:InitWidget()
  self.ElementSpriteName = {
    [ElementType.ElementType_Blue] = "cn14_xzsx_di01",
    [ElementType.ElementType_Red] = "cn14_xzsx_di02",
    [ElementType.ElementType_Green] = "cn14_xzsx_di04",
    [ElementType.ElementType_Yellow] = "cn14_xzsx_di03"
  }
  self._RootGo = self:GetGameObject("Root")
  self._colorIcon = self:GetUIComponent("RawImageLoader", "ColorIcon")
  self._SelectedAreaGo = self:GetGameObject("Selected")
  self._SelectedAreaGo:SetActive(false)
  self._anim = self:GetGameObject():GetComponent("Animation")
end

function UISeasonMazeRoom_DirectionalRecruitColorCell:OnShow()
  self:InitWidget()
end

function UISeasonMazeRoom_DirectionalRecruitColorCell:SetData(index, color, clickCb)
  self._index = index
  self._color = color
  self._clickCb = clickCb
  self:InitCell()
end

function UISeasonMazeRoom_DirectionalRecruitColorCell:InitCell()
  local img = self.ElementSpriteName[self._color]
  if img and self._colorIcon then
    self._colorIcon:LoadImage(img)
  end
end

function UISeasonMazeRoom_DirectionalRecruitColorCell:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UISeasonMazeRoom_DirectionalRecruitColorCell:RootOnClick()
  if self._clickCb then
    self._clickCb(self._index)
  end
end

function UISeasonMazeRoom_DirectionalRecruitColorCell:Select(index)
  if not index then
    self._SelectedAreaGo:SetActive(false)
    return
  end
  self._SelectedAreaGo:SetActive(self._index == index)
end

function UISeasonMazeRoom_DirectionalRecruitColorCell:PlayShowInAnim(delay)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._RootGo:SetActive(true)
  end
  if delay and 0 < delay then
    self._RootGo:SetActive(false)
    self._timer = GameGlobal.Timer():AddEvent(delay, function()
      self._RootGo:SetActive(true)
      if self._anim then
        self._anim:Play("uianim_UISeasonMazeRoomDirectionalRecruitColorCell_in")
      end
    end)
  else
    self._RootGo:SetActive(true)
    self._timer = GameGlobal.Timer():AddEvent(delay, function()
      self._RootGo:SetActive(true)
      if self._anim then
        self._anim:Play("uianim_UISeasonMazeRoomDirectionalRecruitColorCell_in")
      end
    end)
  end
end

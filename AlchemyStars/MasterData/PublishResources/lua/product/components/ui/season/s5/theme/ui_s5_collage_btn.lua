_class("UIS5CollageBtn", UICustomWidget)
UIS5CollageBtn = UIS5CollageBtn

function UIS5CollageBtn:OnShow()
end

function UIS5CollageBtn:OnHide()
end

function UIS5CollageBtn:SetData(seasonId, playAnim)
  self._seasonId = seasonId
  local seasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._collageData = seasonModule:GetCollageData()
  local isOpen = true
  if not isOpen then
    self:GetGameObject():SetActive(false)
    return
  end
  self:_SetFin()
  self:_CheckPoint()
  if playAnim then
    UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", "uieffanim_UIS5_CollageBtn_in", 0, 667)
  end
end

function UIS5CollageBtn:_SetFin()
  local show = true
  local cur, total
  cur, total = self._collageData:GetCollectionProgress()
  show = show and cur == total
  cur, total = self._collageData:GetCgProgress()
  show = show and cur == total
  cur, total = self._collageData:GetMusicProgress()
  show = show and cur == total
  self:GetGameObject("_fin"):SetActive(show)
end

function UIS5CollageBtn:_CalcNew()
  local new = false
  new = new or self._collageData:CollectionHasNew()
  new = new or self._collageData:CGHasNew()
  new = new or self._collageData:MusicHasNew()
  return new
end

function UIS5CollageBtn:_CalcRed()
  return false
end

function UIS5CollageBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS5CollageBtn:BtnOnClick()
  Log.info("UIS5CollageBtn:BtnOnClick")
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonClose_ShowClientError(self._seasonId) then
    return
  end
  self:_CheckPoint()
  UISeasonHelper.ShowCurSeasonCollage()
end

_class("UIS6CollageBtn", UICustomWidget)
UIS6CollageBtn = UIS6CollageBtn

function UIS6CollageBtn:OnShow()
end

function UIS6CollageBtn:OnHide()
end

function UIS6CollageBtn:SetData(seasonId, playAnim)
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
    UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", "uieffanim_UIS6_CollageBtn_in", 0, 667)
  end
end

function UIS6CollageBtn:_SetFin()
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

function UIS6CollageBtn:_CalcNew()
  local new = false
  new = new or self._collageData:CollectionHasNew()
  new = new or self._collageData:CGHasNew()
  new = new or self._collageData:MusicHasNew()
  return new
end

function UIS6CollageBtn:_CalcRed()
  return false
end

function UIS6CollageBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS6CollageBtn:BtnOnClick()
  Log.info("UIS6CollageBtn:BtnOnClick")
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonClose_ShowClientError(self._seasonId) then
    return
  end
  self:_CheckPoint()
  UISeasonHelper.ShowCurSeasonCollage()
end

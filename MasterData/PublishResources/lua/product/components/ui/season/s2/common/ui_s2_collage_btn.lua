_class("UIS2CollageBtn", UICustomWidget)
UIS2CollageBtn = UIS2CollageBtn

function UIS2CollageBtn:OnShow()
end

function UIS2CollageBtn:OnHide()
end

function UIS2CollageBtn:SetData(seasonId)
  self._seasonId = seasonId
  local seasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._collageData = seasonModule:GetCollageData()
  local isOpen = true
  if not isOpen then
    self:GetGameObject():SetActive(false)
    return
  end
  local obj = UIWidgetHelper.SpawnObject(self, "_iconGroup", "UIS2BtnIcon")
  obj:SetData(self:GetName())
  self:_SetFin()
  self:_CheckPoint()
end

function UIS2CollageBtn:_SetFin()
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

function UIS2CollageBtn:_CalcNew()
  local new = false
  new = new or self._collageData:CollectionHasNew()
  new = new or self._collageData:CGHasNew()
  new = new or self._collageData:MusicHasNew()
  return new
end

function UIS2CollageBtn:_CalcRed()
  return false
end

function UIS2CollageBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS2CollageBtn:BtnOnClick()
  Log.info("UIS2CollageBtn:BtnOnClick")
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonClose_ShowClientError(self._seasonId) then
    return
  end
  self:_CheckPoint()
  UISeasonHelper.ShowCurSeasonCollage()
end

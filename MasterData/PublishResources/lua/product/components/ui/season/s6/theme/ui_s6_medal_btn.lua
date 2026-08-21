_class("UIS6MedalBtn", UICustomWidget)
UIS6MedalBtn = UIS6MedalBtn

function UIS6MedalBtn:OnShow()
  self._constBtnName = self:GetName()
end

function UIS6MedalBtn:OnHide()
end

function UIS6MedalBtn:SetData(seasonId, playAnim)
  self._seasonId = seasonId
  self._medalCfg = UISeasonCfgHelper.GetCurSeasonMedalGroupCfg(seasonId)
  if self._medalCfg == nil then
    self:GetGameObject():SetActive(false)
    return
  end
  self:_SetFin(self._medalCfg)
  self:_CheckPoint()
  if playAnim then
  end
end

function UIS6MedalBtn:_SetFin(cfg)
  local haveBgNum = UIMedalGroupApply.CheckBgCollect(cfg)
  local totalBgNum = 1
  local haveMedalNum = UIMedalGroupApply.CheckMedalListCollect(cfg)
  local totalMedalNum = #cfg.MedalIDList
  local show = haveBgNum == totalBgNum and haveMedalNum == totalMedalNum
  self:GetGameObject("_fin"):SetActive(show)
end

function UIS6MedalBtn:_CalcNew()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isNew
end

function UIS6MedalBtn:_CalcRed()
  return false
end

function UIS6MedalBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS6MedalBtn:BtnOnClick()
  Log.info("UIS6MedalBtn:BtnOnClick")
  UISeasonLocalDBHelper.SeasonBtn_Set(self._constBtnName, "New")
  self:_CheckPoint()
  GameGlobal.UIStateManager():ShowDialog("UIMedalGroupListController", self._medalCfg.ID)
end

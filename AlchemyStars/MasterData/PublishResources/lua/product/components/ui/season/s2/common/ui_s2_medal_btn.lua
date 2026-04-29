_class("UIS2MedalBtn", UICustomWidget)
UIS2MedalBtn = UIS2MedalBtn

function UIS2MedalBtn:OnShow()
  self._constBtnName = self:GetName()
end

function UIS2MedalBtn:OnHide()
end

function UIS2MedalBtn:SetData(seasonId)
  self._seasonId = seasonId
  self._medalCfg = UISeasonCfgHelper.GetCurSeasonMedalGroupCfg(seasonId)
  if self._medalCfg == nil then
    self:GetGameObject():SetActive(false)
    return
  end
  local obj = UIWidgetHelper.SpawnObject(self, "_iconGroup", "UIS2BtnIcon")
  obj:SetData(self:GetName())
  self:_SetFin(self._medalCfg)
  self:_CheckPoint()
end

function UIS2MedalBtn:_SetFin(cfg)
  local haveBgNum = UIMedalGroupApply.CheckBgCollect(cfg)
  local totalBgNum = 1
  local haveMedalNum = UIMedalGroupApply.CheckMedalListCollect(cfg)
  local totalMedalNum = #cfg.MedalIDList
  local show = haveBgNum == totalBgNum and haveMedalNum == totalMedalNum
  self:GetGameObject("_fin"):SetActive(show)
end

function UIS2MedalBtn:_CalcNew()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isNew
end

function UIS2MedalBtn:_CalcRed()
  return false
end

function UIS2MedalBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS2MedalBtn:BtnOnClick()
  Log.info("UIS2MedalBtn:BtnOnClick")
  UISeasonLocalDBHelper.SeasonBtn_Set(self._constBtnName, "New")
  self:_CheckPoint()
  GameGlobal.UIStateManager():ShowDialog("UIMedalGroupListController", self._medalCfg.ID)
end

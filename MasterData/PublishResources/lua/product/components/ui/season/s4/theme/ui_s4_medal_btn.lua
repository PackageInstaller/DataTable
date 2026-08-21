_class("UIS4MedalBtn", UICustomWidget)
UIS4MedalBtn = UIS4MedalBtn

function UIS4MedalBtn:OnShow()
  self._constBtnName = self:GetName()
end

function UIS4MedalBtn:OnHide()
end

function UIS4MedalBtn:SetData(seasonId, playAnim)
  self._seasonId = seasonId
  self._medalCfg = UISeasonCfgHelper.GetCurSeasonMedalGroupCfg(seasonId)
  if self._medalCfg == nil then
    self:GetGameObject():SetActive(false)
    return
  end
  self:_SetFin(self._medalCfg)
  self:_CheckPoint()
  if playAnim then
    UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", "uieffanim_UIS4_MedalBtn_in", 500, 667)
  end
end

function UIS4MedalBtn:_SetFin(cfg)
  local haveBgNum = UIMedalGroupApply.CheckBgCollect(cfg)
  local totalBgNum = 1
  local haveMedalNum = UIMedalGroupApply.CheckMedalListCollect(cfg)
  local totalMedalNum = #cfg.MedalIDList
  local show = haveBgNum == totalBgNum and haveMedalNum == totalMedalNum
  self:GetGameObject("_fin"):SetActive(show)
end

function UIS4MedalBtn:_CalcNew()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isNew
end

function UIS4MedalBtn:_CalcRed()
  return false
end

function UIS4MedalBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS4MedalBtn:BtnOnClick()
  Log.info("UIS4MedalBtn:BtnOnClick")
  UISeasonLocalDBHelper.SeasonBtn_Set(self._constBtnName, "New")
  self:_CheckPoint()
  GameGlobal.UIStateManager():ShowDialog("UIMedalGroupListController", self._medalCfg.ID)
end

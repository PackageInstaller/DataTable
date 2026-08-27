local base = UIBaseNode
local UINAthUsingRate = class("UINAthUsingRate", base)
local UINAthUsingRateItem = require("Game.Arithmetic.UsingRate.UINAthUsingRateItem")
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility

function UINAthUsingRate:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ShowWindow, self, self._OnClickShowWin)
  self._rateItemPool = UIItemPool.New(UINAthUsingRateItem, self.ui.usingRateItem, false)
  self:_HideDetailWin()
  self.__onFingerDown = BindCallback(self, self._OnFingerDown)
end

function UINAthUsingRate:InitAthUsingRate(showWinFunc)
  self._showWinFunc = showWinFunc
end

function UINAthUsingRate:_OnClickShowWin()
  if self.ui.obj_window.activeInHierarchy then
    self:_HideDetailWin()
    return
  end
  if self._showWinFunc then
    self._showWinFunc()
  end
end

function UINAthUsingRate:ShowAthUsingRateDetail(heroData, athAreaId)
  self._heroData = heroData
  self._athAreaId = athAreaId
  self._UpdUsingRateWinFunc = self._UpdUsingRateWinFunc or BindCallback(self, self._UpdUsingRateWin)
  PlayerDataCenter.allAthData:GetHeroAthStat(self._heroData.dataId, self._UpdUsingRateWinFunc)
end

function UINAthUsingRate:_UpdUsingRateWin(heroAthStat)
  local heroName = self._heroData:GetHeroName(true)
  local areaCfg = ConfigData.ath_area[self._athAreaId]
  if areaCfg == nil then
    error("Can't find ath areaCfg, areaId = " .. tostring(self._athAreaId))
    return
  end
  local areaName = LanguageUtil.GetLocaleText(areaCfg.name2)
  self.ui.tex_NameRange:SetIndex(0, heroName, areaName)
  self._rateItemPool:HideAll()
  local affixList = heroAthStat.slots[self._athAreaId].affix
  for k, elem in ipairs(affixList) do
    local rateItem = self._rateItemPool:GetOne()
    rateItem:InitAthUsingRateItem(elem)
    if #self._rateItemPool.listItem >= 3 then
      break
    end
  end
  self.ui.obj_window:SetActive(true)
  self.ui.obj_WindowOpenMask:SetActive(true)
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  self._addFingerListner = true
end

function UINAthUsingRate:Show()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_Rate) then
    self:Hide()
    return
  end
  base.Show(self)
end

function UINAthUsingRate:_HideDetailWin()
  self.ui.obj_window:SetActive(false)
  self.ui.obj_WindowOpenMask:SetActive(false)
  self:_RemoveFingerDownListner()
end

function UINAthUsingRate:_OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:_HideDetailWin()
  end
end

function UINAthUsingRate:_RemoveFingerDownListner()
  if self._addFingerListner then
    cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
    self._addFingerListner = false
  end
end

function UINAthUsingRate:OnDelete()
  self._rateItemPool:DeleteAll()
  self:_RemoveFingerDownListner()
  base.OnDelete(self)
end

return UINAthUsingRate

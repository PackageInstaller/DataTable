local UINFmtPlatform = class("UINFmtPlatform", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local FmtEnum = require("Game.Formation.FmtEnum")

function UINFmtPlatform:ctor(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
end

function UINFmtPlatform:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_QuickLevelUp, self, self.OnQuickLevelUp)
  self.ui.btn_QuickLevelUp.onPress:AddListener(BindCallback(self, self._OnPressQuickLvUp))
  self.ui.btn_QuickLevelUp.onPressUp:AddListener(BindCallback(self, self._OnPressUpQuickLvUp))
  self.ui.btn_QuickLevelUp.onPressDown:AddListener(BindCallback(self, self._OnPressDownQuickLvUp))
  self:_ReFmtPlatformUIState()
end

function UINFmtPlatform:InitFmtPlatform(fmtIndex, isBench, lockStr, isBan)
  self.fmtIndex = fmtIndex
  self.isBench = isBench
  self.lockStr = lockStr
  self.isBan = isBan
  if not isBench then
    self.ui.img_SelectHero.color = self.ui.selectHeroColor
    self.ui.tex_SelectHero.color = self.ui.selectHeroColor
  end
end

function UINFmtPlatform:RefreshUIFmtPlatform(heroData)
  local fightingPower = 0
  self:_ReFmtPlatformUIState()
  if self.isBan then
    self.ui.cantUse:SetActive(true)
  elseif not string.IsNullOrEmpty(self.lockStr) then
    self:_LockActive(true)
    self.ui.tex_Condition.text = self.lockStr
  elseif heroData == nil then
    self:_SelectHeroActive(true)
  else
    local campSprite = CRH:GetSprite(heroData:GetCampCfg().icon, CommonAtlasType.CareerCamp)
    local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
    local fairyData = formationData:GetFmtFairyData()
    if self.isBench then
      self.ui.img_Bench_Camp.sprite = campSprite
      self:_SetBenchHeroActive(true)
    else
      self.ui.img_Camp.sprite = campSprite
      self:_SetHaveHeroActive(true)
    end
    local showPow = true
    showPow = not self.enterFmtData:IsFmtCtrlFiexd() or self.enterFmtData:HasFmtFixedShowPow()
    showPow = showPow and not self.enterFmtData:IsBondModule()
    local isHaveLock = heroData.isFixedFmtHero and self.enterFmtData:HasFmtFixedExtra()
    self:_SetFixedLockActive(isHaveLock)
    local bannedHeroDic = self.enterFmtData:GetCardSetTempBannedHeroDic()
    if bannedHeroDic then
      local isCardSetUsed = bannedHeroDic[heroData.dataId] and not heroData.isFriendSupport
      if self.enterFmtData:GetFmtCtrlFromModule() == FmtEnum.eFmtFromModule.CardSet then
        self:_SetCardSetUsedActive(isCardSetUsed, 0)
      else
        self:_SetCardSetUsedActive(isCardSetUsed, 1)
      end
    end
    fightingPower = heroData:GetFightingPower(nil, fairyData)
    if showPow then
      self:_PowerActive(true)
      self.ui.tex_Power.text = tostring(fightingPower)
    end
  end
  self._fightingPower = fightingPower
  return fightingPower
end

function UINFmtPlatform:_ReFmtPlatformUIState()
  self:_SetHaveHeroActive(false)
  self:_SelectHeroActive(false)
  self:_SetBenchHeroActive(false)
  self:_LockActive(false)
  self:_PowerActive(false)
  self:_QuickLevelActive(false)
  self.ui.cantUse:SetActive(false)
  self:_SetFixedLockActive(false)
  self:_SetCardSetUsedActive(false)
end

function UINFmtPlatform:GetFmtPlatHeroFtPower()
  return self._fightingPower
end

function UINFmtPlatform:_SetHaveHeroActive(active)
  self.ui.haveHero:SetActive(active)
end

function UINFmtPlatform:_SetBenchHeroActive(active)
  self.ui.benchHero:SetActive(active)
end

function UINFmtPlatform:_SelectHeroActive(active)
  self.ui.selectHero:SetActive(active)
  self.ui.tex_SelectHero.enabled = active
  self.ui.img_SelectHero.enabled = active
end

function UINFmtPlatform:_LockActive(active)
  self.ui.lock:SetActive(active)
  self.ui.tex_Condition.enabled = active
  self.ui.tran_lockIcon.gameObject:SetActive(active)
end

function UINFmtPlatform:_PowerActive(active)
  self.ui.power:SetActive(active)
  self.ui.tex_Power.enabled = active
end

function UINFmtPlatform:IsAbleQuickLevelup()
  return self._canQuickLvUp
end

function UINFmtPlatform:GetQuickLevelupBtnUI()
  return self.ui.btn_QuickLevelUp.transform
end

function UINFmtPlatform:_QuickLevelActive(active)
  if self.ui.btn_QuickLevelUp.gameObject.activeSelf ~= active then
    self.ui.btn_QuickLevelUp.gameObject:SetActive(active)
  end
  if active then
    self.ui.tex_QuickLevelTex:SetIndex(0, tostring(self.heroData:GetExpByLevel(self.heroData.level)))
  else
    self.ui.tex_QuickLevelTex.gameObject:SetActive(false)
    self.ui.breakThrough:SetActive(false)
  end
end

function UINFmtPlatform:_SetFixedLockActive(active)
  self.ui.fixedLock:SetActive(active)
  self.ui.tex_FixedLock:SetActive(active)
end

function UINFmtPlatform:_SetCardSetUsedActive(active, index)
  self.ui.cardSetUsed:SetActive(active)
  self.ui.tex_cardSetUsed.gameObject:SetActive(active)
  self.ui.tex_cardSetUsed:SetIndex(index or 0)
end

function UINFmtPlatform:SetItemParents(parentList)
  self.ui.haveHero.transform:SetParent(parentList[1])
  self.ui.selectHero.transform:SetParent(parentList[2])
  self.ui.img_SelectHero.transform:SetParent(parentList[3])
  self.ui.benchHero.transform:SetParent(parentList[4])
  self.ui.lock.transform:SetParent(parentList[5])
  self.ui.tran_lockIcon:SetParent(parentList[6])
  self.ui.power.transform:SetParent(parentList[7])
  self.ui.tex_SelectHero.transform:SetParent(parentList[8])
  self.ui.tex_Condition.transform:SetParent(parentList[8])
  self.ui.tex_Power.transform:SetParent(parentList[9])
  self.ui.tex_QuickLevelTex.transform:SetParent(parentList[8])
  self.ui.btn_QuickLevelUp.transform:SetParent(parentList[10])
  self.ui.fixedLock.transform:SetParent(parentList[11])
  self.ui.tex_FixedLock.transform:SetParent(parentList[8])
  self.ui.cardSetUsed.transform:SetParent(parentList[12])
  self.ui.tex_cardSetUsed.transform:SetParent(parentList[8])
end

function UINFmtPlatform:RefreshFmtQuickLvUp(heroData, quickLvUpFxPrefab)
  if self.fmtCtrl:IsFmtCtrlInEditState() or heroData == nil or heroData.isFriendSupport or heroData.isFixedFmtHero or heroData.isOfficialSupport then
    self:_QuickLevelActive(false)
    return
  end
  local couldShowQuick = self.enterFmtData:GetCouldShowQuickLevelUp()
  if not couldShowQuick then
    self:_QuickLevelActive(false)
    return
  end
  self.heroData = heroData
  self._canQuickLvUp = heroData:GenHeroCanQuickLevelUp() and not heroData:IsHeroLongTrailLevel()
  self:_RefreshShowQuickLvUpBtn(quickLvUpFxPrefab)
end

function UINFmtPlatform:_RefreshShowQuickLvUpBtn(quickLvUpFxPrefab)
  local isPowerWarn = false
  local uiFmtRoot = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFmtRoot ~= nil and self._canQuickLvUp then
    isPowerWarn = uiFmtRoot:IsFmtToltalPowerWarn()
  end
  local showBreakThrough = false
  local canBreakThrough = false
  if self.heroData:IsReachLevelLimit() and not self.heroData:IsFullLevel() and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) and not self.heroData:IsHeroLongTrailLevel() then
    showBreakThrough = true
    canBreakThrough = self.heroData:AblePotential()
  end
  local showBtn = self._canQuickLvUp or showBreakThrough
  local showFx = showBtn and (isPowerWarn or canBreakThrough)
  self.ui.img_QuickLevelUp:SetIndex(canBreakThrough and 1 or 0)
  self.ui.breakThrough:SetActive(showBreakThrough)
  self.ui.tex_QuickLevelTex.gameObject:SetActive(self._canQuickLvUp)
  self:_QuickLevelActive(showBtn)
  self:_ShowPowerWarnFx(showFx, quickLvUpFxPrefab)
end

function UINFmtPlatform:_ShowPowerWarnFx(showFx, quickLvUpFxPrefab)
  if showFx then
    if IsNull(self.quickLvUpFx) then
      self.quickLvUpFx = quickLvUpFxPrefab:Instantiate(self.ui.btn_QuickLevelUp.transform)
    end
    self.quickLvUpFx:SetActive(true)
  elseif not IsNull(self.quickLvUpFx) then
    self.quickLvUpFx:SetActive(false)
  end
end

function UINFmtPlatform:OnQuickLevelUp()
  if not self._canClickQuickLv then
    return
  end
  if self._canQuickLvUp then
    self.fmtCtrl:ReqFmtHeroLvUp(self.fmtIndex, self.heroData.dataId, self.heroData.level + 1)
    return
  end
  if self.heroData:IsReachLevelLimit() then
    if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      local tip = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
      cs_MessageCommon.ShowMessageTips(tip)
      return
    end
    if self.heroData:IsFullPotential() then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(172))
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
      if window == nil then
        return
      end
      window:InitPotential(self.heroData, function()
        self:_ShowLvUpEffect()
        self.fmtCtrl.fmtSceneCtrl:RefreshAllQuickLevel()
      end)
    end)
  end
end

function UINFmtPlatform:_OnPressDownQuickLvUp()
  self._addLevel = 0
  self._canClickQuickLv = true
end

function UINFmtPlatform:_OnPressQuickLvUp()
  if self.heroData == nil or self.heroData.level + self._addLevel >= self.heroData:GetLevelLimit() then
    return
  end
  local needExp = self.heroData:GetExpToTargetLevel(self.heroData.level + self._addLevel)
  local totalExp = PlayerDataCenter:GetItemCount(ConstGlobalItem.HeroExp)
  if needExp > totalExp then
    self:_OnPressUpQuickLvUp()
  else
    self._addLevel = self._addLevel + 1
    local level = self.heroData.level + self._addLevel
    local level_max = self.heroData:GetLevelLimit()
    self:_ShowLvUpEffect()
    local fmtWin = UIManager:GetWindow(UIWindowTypeID.Formation)
    if fmtWin ~= nil then
      fmtWin:SetUIFmtHeroInfoItemLv(self.heroData.dataId, level)
    end
    self._canClickQuickLv = false
    self.ui.tex_QuickLevelTex:SetIndex(0, tostring(self.heroData:GetExpByLevel(level)))
    if level >= level_max then
      self:_OnPressUpQuickLvUp()
    else
      AudioManager:PlayAudioById(1126)
    end
  end
end

function UINFmtPlatform:_OnPressUpQuickLvUp()
  if self._addLevel > 0 then
    self.fmtCtrl:ReqFmtHeroLvUp(self.fmtIndex, self.heroData.dataId, self.heroData.level + self._addLevel, true)
    self._addLevel = 0
  end
end

function UINFmtPlatform:_ShowLvUpEffect()
  self.fmtCtrl.fmtSceneCtrl:ShowHeroQuickLvUpEffect(self.fmtIndex)
end

function UINFmtPlatform:SetLocalPos(pos)
  self.transform.localPosition = pos
end

function UINFmtPlatform:OnDelete()
  base.OnDelete(self)
end

return UINFmtPlatform

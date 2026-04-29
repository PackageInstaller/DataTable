_class("UILuckLandBuildingLevelUp", UIController)
UILuckLandBuildingLevelUp = UILuckLandBuildingLevelUp

function UILuckLandBuildingLevelUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandBuildingLevelUp:OnShow(uiParams)
  self._buildData = uiParams[1]
  self._cb = uiParams[2]
  self:_InitWidget()
  self:_OnValue()
end

function UILuckLandBuildingLevelUp:_InitWidget()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._level = self:GetUIComponent("UILocalizationText", "Level")
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
  self._curLevelText = self:GetUIComponent("UILocalizationText", "CurLevelText")
  self._curLevelEffect = self:GetUIComponent("UILocalizationText", "CurLevelEffect")
  self._nextLevelText = self:GetUIComponent("UILocalizationText", "NextLevelText")
  self._nextLevelEffect = self:GetUIComponent("UILocalizationText", "NextLevelEffect")
  self._maxLevelText = self:GetUIComponent("UILocalizationText", "MaxLevelText")
  self._maxLevelEffect = self:GetUIComponent("UILocalizationText", "MaxLevelEffect")
  self._cost = self:GetUIComponent("UILocalizationText", "Cost")
  self._currencyCount = self:GetUIComponent("UILocalizationText", "CurrencyCount")
  self._upgradeGO = self:GetGameObject("Upgrade")
  self._maxGO = self:GetGameObject("Max")
  self._curMoneyGO = self:GetGameObject("CurMoney")
  self._levelUpBtnGO = self:GetGameObject("LevelUpBtn")
  self._cancleBtnRect = self:GetUIComponent("RectTransform", "CancleBtn")
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UILuckLandBuildingLevelUp:_OnValue()
  self:RefreshUIInfo()
end

function UILuckLandBuildingLevelUp:RefreshUIInfo()
  self._icon:LoadImage(self._buildData:Icon())
  self._name:SetText(StringTable.Get(self._buildData:Name()))
  self._desc:SetText(StringTable.Get(self._buildData:Desc()))
  self._level:SetText("Lv." .. self._buildData:GetCurLevel())
  self._isMax = self._buildData:GetCurLevel() >= self._buildData:MaxLevel()
  self._nextMax = false
  if self._isMax then
    self._maxLevelText:SetText("Lv." .. self._buildData:GetCurLevel())
    local maxLevelTipStr = self._buildData:GetLevelTip(self._buildData:ID())
    if maxLevelTipStr then
      self._maxLevelEffect:SetText(StringTable.Get(maxLevelTipStr))
    end
    self._curMoneyGO:SetActive(false)
    self._levelUpBtnGO:SetActive(false)
    self._cancleBtnRect.anchoredPosition = Vector2(0, -243)
  else
    self._curLevelText:SetText("Lv." .. self._buildData:GetCurLevel())
    local curLevelTipStr = self._buildData:GetLevelTip(self._buildData:ID())
    if curLevelTipStr then
      self._curLevelEffect:SetText(StringTable.Get(curLevelTipStr))
    end
    self._upgradeCost = self._buildData:Cfg().UpgradeCost
    self._cost:SetText(self._upgradeCost)
    local nextCfg = Cfg.cfg_luckland_client_build[self._buildData:ID() + 1]
    if nextCfg then
      local nextLevel = nextCfg.ID % 100
      self._nextMax = nextLevel >= self._buildData:MaxLevel()
      self._nextLevelText:SetText("Lv." .. nextLevel)
      local nextLevelTipStr = nextCfg.BuildLevelTips
      if nextLevelTipStr then
        self._nextLevelEffect:SetText(StringTable.Get(nextLevelTipStr))
      end
    end
    local total = LuckLandInnerGameHelper.GetCurMoney()
    self._currencyCount:SetText(total)
    self._curMoneyGO:SetActive(true)
    self._levelUpBtnGO:SetActive(true)
    self._cancleBtnRect.anchoredPosition = Vector2(-302.1, -243)
    if total < self._upgradeCost then
      self._cost.color = Color(0.9529411764705882, 0.3254901960784314, 0.28627450980392155)
    else
      self._cost.color = Color(1, 1, 1)
    end
  end
  self._upgradeGO:SetActive(not self._isMax)
  self._maxGO:SetActive(self._isMax)
end

function UILuckLandBuildingLevelUp:CloseBtnOnClick(go)
  self:_CloseUI()
end

function UILuckLandBuildingLevelUp:CancleBtnOnClick(go)
  self:_CloseUI()
end

function UILuckLandBuildingLevelUp:_CloseUI()
  self:StartTask(function(TT)
    self:Lock("UILuckLandBuildingLevelUp")
    self._animation:Play("uieff_UILuckLandBuildingLevelUp_out")
    YIELD(TT, 333)
    self:UnLock("UILuckLandBuildingLevelUp")
    if self._cb then
      self._cb(false)
    end
    self:CloseDialog()
  end, self)
end

function UILuckLandBuildingLevelUp:LevelUpBtnOnClick(go)
  if self._isMax then
    return
  end
  if self._upgradeCost > LuckLandInnerGameHelper.GetCurMoney() then
    ToastManager.ShowToast(StringTable.Get("str_luckland_building_upgrade_error"))
  else
    self:StartTask(function(TT)
      self:Lock("UILuckLandBuildingLevelUp")
      if self._nextMax then
        local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
        if entityMgr then
          local buildingEntity = entityMgr:GetBuildingByTemplateID(self._buildData:ID())
          if buildingEntity then
            GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandUpgrade, buildingEntity:ID())
            self._buildData:Upgrade()
            self:RefreshUIInfo()
          end
        end
        self._animation:Play("uieff_UILuckLandBuildingLevelUp_max")
        YIELD(TT, 1167)
      else
        self._animation:Play("uieff_UILuckLandBuildingLevelUp_levelup")
        YIELD(TT, 600)
        local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
        if entityMgr then
          local buildingEntity = entityMgr:GetBuildingByTemplateID(self._buildData:ID())
          if buildingEntity then
            GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandUpgrade, buildingEntity:ID())
            self._buildData:Upgrade()
            self:RefreshUIInfo()
          end
        end
        YIELD(TT, 567)
      end
      self:UnLock("UILuckLandBuildingLevelUp")
      local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
      local buildingEntity = entityMgr:GetBuildingByTemplateID(self._buildData:ID())
      local module = GameGlobal:GetLuckLandModule()
      module:BuildingUpgradeDrawCard(buildingEntity:GetBuildingType())
      if self._cb then
        self._cb(true)
        self:CloseDialog()
      end
    end, self)
  end
end

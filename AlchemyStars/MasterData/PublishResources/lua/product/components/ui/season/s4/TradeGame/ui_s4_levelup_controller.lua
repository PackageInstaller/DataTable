_class("UIS4LevelUpController", UIController)
UIS4LevelUpController = UIS4LevelUpController

function UIS4LevelUpController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIS4LevelUpController:OnShow(uiParams)
  self._tradeData = uiParams[1]
  self._harborId = uiParams[2]
  self._businessComponet = self._tradeData:GetBusinessComp()
  self.harborLv, self.shipLv = self._tradeData:GetHarborShipLV(self._harborId)
  self._harborCfg = Cfg.cfg_component_business_harbor({
    HarborID = self._harborId,
    Lv = self.harborLv
  })[1]
  self._shipCfg = Cfg.cfg_component_business_ship({
    ShipID = self._harborId,
    Lv = self.shipLv
  })[1]
  if self.harborLv < self._harborCfg.MaxLv then
    self._harborUPCfg = Cfg.cfg_component_business_harbor({
      HarborID = self._harborId,
      Lv = self.harborLv + 1
    })[1]
  else
    self.harborLvMax = true
  end
  if self.shipLv < self._shipCfg.MaxLv then
    self._shipUPCfg = Cfg.cfg_component_business_ship({
      ShipID = self._harborId,
      Lv = self.shipLv + 1
    })[1]
  else
    self.shipLvMax = true
  end
  self:InitWidget()
  self:InitData()
  self:RefreshLevelUpRed()
  self:PlayLevelUpAnimIn()
end

function UIS4LevelUpController:InitWidget()
  self.harborCost = self:GetUIComponent("UILocalizationText", "HarborCost")
  self.harborUpEnsure = self:GetUIComponent("Image", "HarborUpEnsure")
  self.shipCost = self:GetUIComponent("UILocalizationText", "ShipCost")
  self.shipUpEnsure = self:GetUIComponent("Image", "ShipUpEnsure")
  self.speedTxt = self:GetUIComponent("UILocalizationText", "SpeedTxt")
  self.loadTxt = self:GetUIComponent("UILocalizationText", "LoadTxt")
  self.crewTxt = self:GetUIComponent("UILocalizationText", "CrewTxt")
  self.leadTxt = self:GetUIComponent("UILocalizationText", "LeadTxt")
  self.seaTxt = self:GetUIComponent("UILocalizationText", "SeaTxt")
  self.repaireTxt = self:GetUIComponent("UILocalizationText", "RepaireTxt")
  self.harborPreviewTitle = self:GetUIComponent("UILocalizationText", "HarborPreviewTitle")
  self.shipPreviewTitle = self:GetUIComponent("UILocalizationText", "ShipPreviewTitle")
  self.HarborUpEnsureObj = self:GetGameObject("HarborUpEnsure")
  self.ShipUpEnsureObj = self:GetGameObject("ShipUpEnsure")
  self.HarborPreviewObj = self:GetGameObject("HarborPreview")
  self.ShipPreviewObj = self:GetGameObject("ShipPreview")
  self.SpeedTipsObj = self:GetGameObject("SpeedTips")
  self.ParamsObj = self:GetGameObject("Params")
  self.HarborMaxObj = self:GetGameObject("HarborMax")
  self.HarborNotMaxObj = self:GetGameObject("HarborNotMax")
  self.ShipMaxObj = self:GetGameObject("ShipMax")
  self.ShipNotMaxObj = self:GetGameObject("ShipNotMax")
  self._anim = self:GetUIComponent("Animation", "_anim")
  self.HarbortRedPointObj = self:GetGameObject("HarbortRedPoint")
  self.ShipRedPointObj = self:GetGameObject("ShiptRedPoint")
end

function UIS4LevelUpController:InitData()
  self:InitHarborData()
  self:InitShipData()
end

function UIS4LevelUpController:InitHarborData()
  local titleStr = StringTable.Get("str_season_s4_trade_harbor_levelup_title", self.harborLv, self._harborCfg.MaxLv)
  self.harborPreviewTitle:SetText(titleStr)
  if self.harborLv >= self._harborCfg.MaxLv then
    self.speedTxt.gameObject:SetActive(false)
    self.SpeedTipsObj:SetActive(false)
    self.HarborMaxObj:SetActive(true)
    self.HarborNotMaxObj:SetActive(false)
  else
    self.speedTxt.gameObject:SetActive(true)
    self.SpeedTipsObj:SetActive(true)
    local speed = self._harborUPCfg.UnloadSpeed - self._harborCfg.UnloadSpeed
    self.speedTxt:SetText(StringTable.Get("str_season_s4_trade_harbor_levelup_speed") .. "+" .. speed)
    self.HarborMaxObj:SetActive(false)
    self.HarborNotMaxObj:SetActive(true)
    local coinNum, talentPointNum = self._tradeData:GetCoinCount()
    local needNum = self._harborUPCfg.CostItem[1][2]
    if coinNum >= needNum then
      self.harborCost.color = Color(0.25098039215686274, 0.23921568627450981, 0.23529411764705882)
    else
      self.harborCost.color = Color(0.596078431372549, 0.3333333333333333, 0.25882352941176473)
    end
    self.harborCost:SetText(needNum)
  end
end

function UIS4LevelUpController:InitShipData()
  local titleStr = StringTable.Get("str_season_s4_trade_ship_levelup_title", self.shipLv, self._shipCfg.MaxLv)
  self.shipPreviewTitle:SetText(titleStr)
  if self.shipLv >= self._shipCfg.MaxLv then
    self.ParamsObj:SetActive(false)
    self.ShipMaxObj:SetActive(true)
    self.ShipNotMaxObj:SetActive(false)
  else
    self.ParamsObj:SetActive(true)
    local Boatload = self._shipUPCfg.Boatload - self._shipCfg.Boatload
    self.loadTxt.gameObject:SetActive(Boatload ~= 0)
    self.loadTxt:SetText(StringTable.Get("str_season_s4_trade_ship_levelup_load") .. "+" .. Boatload)
    local SeamanNum = self._shipUPCfg.SeamanNum - self._shipCfg.SeamanNum
    self.crewTxt.gameObject:SetActive(SeamanNum ~= 0)
    self.crewTxt:SetText(StringTable.Get("str_season_s4_trade_crew") .. "+" .. SeamanNum)
    local LeadValue = self._shipUPCfg.BaseValue[1] - self._shipCfg.BaseValue[1]
    local SeaValue = self._shipUPCfg.BaseValue[2] - self._shipCfg.BaseValue[2]
    local RepaireValue = self._shipUPCfg.BaseValue[3] - self._shipCfg.BaseValue[3]
    self.leadTxt.gameObject:SetActive(LeadValue ~= 0)
    self.seaTxt.gameObject:SetActive(SeaValue ~= 0)
    self.repaireTxt.gameObject:SetActive(RepaireValue ~= 0)
    self.leadTxt:SetText(StringTable.Get("str_season_s4_trade_command") .. "+" .. LeadValue)
    self.seaTxt:SetText(StringTable.Get("str_season_s4_trade_sail") .. "+" .. SeaValue)
    self.repaireTxt:SetText(StringTable.Get("str_season_s4_trade_fix") .. "+" .. RepaireValue)
    self.ShipMaxObj:SetActive(false)
    self.ShipNotMaxObj:SetActive(true)
    local coinNum, talentPointNum = self._tradeData:GetCoinCount()
    local needNum = self._shipUPCfg.CostItem[1][2]
    if coinNum >= needNum then
      self.shipCost.color = Color(0.25098039215686274, 0.23921568627450981, 0.23529411764705882)
    else
      self.shipCost.color = Color(0.596078431372549, 0.3333333333333333, 0.25882352941176473)
    end
    self.shipCost:SetText(needNum)
  end
end

function UIS4LevelUpController:CloseBtnOnClick(go)
  self:Close()
end

function UIS4LevelUpController:BGCloseBtnOnClick(go)
  self:Close()
end

function UIS4LevelUpController:Close()
  if not self.harborLvMax then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4HarborUPPreview, false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4ShipUPPreview, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4TradeCrewChange)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4StateIncomePreview, false)
  local LockName = "UIS4LevelUpController_AnimOut"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4LevelUpController_out")
    YIELD(TT, 300)
    self:UnLock(LockName)
    self:CloseDialog()
  end)
end

function UIS4LevelUpController:ShowHarborPreviewOnClick(go)
  local OnPreview = self.HarborPreviewObj.activeSelf
  if self.harborLv >= self._harborCfg.MaxLv then
    return
  end
  local LockName = "UIS4LevelUpController_HarborPreview"
  if OnPreview then
    self:StartTask(function(TT)
      self:Lock(LockName)
      self._anim:Play("uianim_Harbor_xuanzhong_out")
      YIELD(TT, 20)
      self:UnLock(LockName)
      self.HarborPreviewObj:SetActive(false)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4HarborUPPreview, false)
    end)
  else
    self.HarborPreviewObj:SetActive(true)
    self:StartTask(function(TT)
      self:Lock(LockName)
      self._anim:Play("uianim_Harbor_xuanzhong_in")
      YIELD(TT, 500)
      self:UnLock(LockName)
    end)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4HarborUPPreview, true)
  end
  self:RefreshStateIncomPreview()
end

function UIS4LevelUpController:ShowShipPreviewOnClick(go)
  local OnPreview = self.ShipPreviewObj.activeSelf
  if self.shipLv >= self._shipCfg.MaxLv then
    return
  end
  local LockName = "UIS4LevelUpController_ShipPreview"
  if OnPreview then
    self:StartTask(function(TT)
      self:Lock(LockName)
      self._anim:Play("uianim_ship_xuanzhong_out")
      YIELD(TT, 20)
      self:UnLock(LockName)
      self.ShipPreviewObj:SetActive(false)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4ShipUPPreview, false)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4TradeCrewChange)
    end)
  else
    self.ShipPreviewObj:SetActive(true)
    self:StartTask(function(TT)
      self:Lock(LockName)
      self._anim:Play("uianim_ship_xuanzhong_in")
      YIELD(TT, 500)
      self:UnLock(LockName)
    end)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4ShipUPPreview, true)
  end
  self:RefreshStateIncomPreview()
end

function UIS4LevelUpController:ShowHarborEnsureOnClick(go)
end

function UIS4LevelUpController:ShowShipEnsureOnClick(go)
end

function UIS4LevelUpController:HarborLevelUpBtnOnClick(go)
  local id = self._harborUPCfg.ID
  local canUp = self:CheckHarborLevelUp()
  if not canUp then
    ToastManager.ShowToast(StringTable.Get("str_season_s4_trade_levelup_notenough"))
    return
  end
  local title = StringTable.Get("str_season_s4_trade_levelup_confirm")
  PopupManager.Alert("UIS4MessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, function()
    self:HarborLevelUpCallBack()
  end)
end

function UIS4LevelUpController:HarborLevelUpCallBack()
  local id = self._harborUPCfg.ID
  self.HarborPreviewObj:SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4HarborUPPreview, false)
  self:StartTask(self.HarborLevelUp, self, id)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4StateIncomePreview, false)
end

function UIS4LevelUpController:HarborLevelUp(TT, CfgID)
  local lockName = "UIS4LevelUpController:HarborLevelUp"
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  local result = self._businessComponet:HandleBusinessHarborReq(TT, res, CfgID)
  self:UnLock(lockName)
  if res:GetSucc() then
    self:Refresh()
    self:ShowHarborEnsureOnClick()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4HarborShipLevelUP, self._harborId)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4StateIncomePreview, false)
  else
    Log.error("###[UIS4LevelUpController] HarborLevelUp fail, result:", res:GetResult(), " CfgID:", CfgID, "harborLV", self.harborLv)
  end
end

function UIS4LevelUpController:ShipLevelUpBtnOnClick(go)
  local id = self._shipUPCfg.ID
  local canUp = self:CheckShipLevelUp()
  if not canUp then
    ToastManager.ShowToast(StringTable.Get("str_season_s4_trade_levelup_notenough"))
    return
  end
  local title = StringTable.Get("str_season_s4_trade_levelup_confirm")
  PopupManager.Alert("UIS4MessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, function()
    self:ShipLevelUpCallBack()
  end)
end

function UIS4LevelUpController:ShipLevelUpCallBack()
  local id = self._shipUPCfg.ID
  self.ShipPreviewObj:SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4ShipUPPreview, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4TradeCrewChange)
  self:StartTask(self.ShipLevelUp, self, id)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4StateIncomePreview, false)
end

function UIS4LevelUpController:ShipLevelUp(TT, CfgID)
  local lockName = "UIS4LevelUpController:ShipLevelUp"
  self:Lock(lockName)
  local res = AsyncRequestRes:New()
  local result = self._businessComponet:HandleBusinessShipReq(TT, res, CfgID)
  self:UnLock(lockName)
  if res:GetSucc() then
    self:Refresh()
    self:ShowShipEnsureOnClick()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4HarborShipLevelUP, self._harborId)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4StateIncomePreview, false)
  else
    Log.error("###[UIS4LevelUpController] ShipLevelUp fail, result:", res:GetResult(), " CfgID:", CfgID, "shipLV", self.shipLv)
  end
end

function UIS4LevelUpController:Refresh()
  self.harborLv, self.shipLv = self._tradeData:GetHarborShipLV(self._harborId)
  self._harborCfg = Cfg.cfg_component_business_harbor({
    HarborID = self._harborId,
    Lv = self.harborLv
  })[1]
  self._shipCfg = Cfg.cfg_component_business_ship({
    ShipID = self._harborId,
    Lv = self.shipLv
  })[1]
  if self.harborLv < self._harborCfg.MaxLv then
    self._harborUPCfg = Cfg.cfg_component_business_harbor({
      HarborID = self._harborId,
      Lv = self.harborLv + 1
    })[1]
  else
    self.harborLvMax = true
  end
  if self.shipLv < self._shipCfg.MaxLv then
    self._shipUPCfg = Cfg.cfg_component_business_ship({
      ShipID = self._harborId,
      Lv = self.shipLv + 1
    })[1]
  else
    self.shipLvMax = true
  end
  self:RefreshLevelUpRed()
  self:InitData()
end

function UIS4LevelUpController:RefreshStateIncomPreview()
  if self.ShipPreviewObj.activeSelf or self.HarborPreviewObj.activeSelf then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4StateIncomePreview, true)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4StateIncomePreview, false)
  end
end

function UIS4LevelUpController:PlayLevelUpAnimIn()
  local LockName = "UIS4LevelUpController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._anim:Play("uianim_UIS4LevelUpController_in")
    YIELD(TT, 500)
    self:UnLock(LockName)
  end)
end

function UIS4LevelUpController:CheckHarborLevelUp()
  if self.harborLv >= self._harborCfg.MaxLv then
    return false
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local costItem = self._harborUPCfg.CostItem
  local LockItem = self._harborUPCfg.LockItem
  local lock = false
  local num = itemModule:GetItemCount(LockItem[1])
  if num < LockItem[2] then
    lock = true
    return false
  end
  for i, v in ipairs(costItem) do
    local item = v[1]
    local needNum = v[2]
    local num = itemModule:GetItemCount(item)
    if needNum > num then
      lock = true
      break
    end
  end
  if lock then
    return false
  end
  return true
end

function UIS4LevelUpController:CheckShipLevelUp()
  if self.shipLv >= self._shipCfg.MaxLv then
    return false
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local costItem = self._shipUPCfg.CostItem
  local lock = false
  for i, v in ipairs(costItem) do
    local item = v[1]
    local needNum = v[2]
    local num = itemModule:GetItemCount(item)
    if needNum > num then
      lock = true
      break
    end
  end
  if lock then
    return false
  end
  return true
end

function UIS4LevelUpController:RefreshLevelUpRed()
  local harborRed = self:CheckHarborLevelUp()
  local shipred = self:CheckShipLevelUp()
  self.HarbortRedPointObj:SetActive(harborRed)
  self.ShipRedPointObj:SetActive(shipred)
end

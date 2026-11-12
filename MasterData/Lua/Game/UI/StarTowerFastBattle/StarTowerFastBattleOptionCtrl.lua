local StarTowerFastBattleOptionCtrl = class("StarTowerFastBattleOptionCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local StarTowerSettingGate = require("Game.Adventure.StarTower.StarTowerSettingGate")
StarTowerFastBattleOptionCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  trRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Transform"
  },
  rtSelectOption = {},
  TMP_Title = {sComponentName = "TMP_Text"},
  rtChoose = {nCount = 5},
  btnChoose = {
    sComponentName = "NaviButton",
    nCount = 5,
    callback = "OnBtnClick_Select"
  },
  imgIconLeave = {nCount = 5},
  TMPChoose = {sComponentName = "TMP_Text", nCount = 5},
  imgFunc = {nCount = 5},
  Select = {nCount = 5},
  goCoin = {sNodeName = "imgBg_Coin"},
  imgCoin = {sComponentName = "Image"},
  textCoinCount = {sComponentName = "TMP_Text"},
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Back"
  },
  btnDepot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Depot"
  }
}
StarTowerFastBattleOptionCtrl._mapEventConfig = {
  RefreshStrengthMachineCost = "OnEvent_RefreshStrengthMachineCost",
  RefreshStarTowerCoin = "OnEvent_RefreshStarTowerCoin",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen",
  StarTowerAutoPreviewShopOption = "OnEvent_AutoPreviewShopOption",
  StarTowerAutoExecuteShopOption = "OnEvent_AutoExecuteShopOption",
  StarTowerAutoDecisionStateChanged = "OnEvent_AutoDecisionStateChanged",
  StarTowerSweepEnd = "OnEvent_StarTowerSweepEnd"
}

function StarTowerFastBattleOptionCtrl:Awake()
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.rtSelectOption:SetActive(false)
  for i = 1, 5 do
    self._mapNode.rtChoose[i]:SetActive(false)
    self._mapNode.imgIconLeave[i]:SetActive(false)
    self._mapNode.imgFunc[i]:SetActive(false)
    self._mapNode.Select[i]:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMPChoose[i], "")
    if i == 5 then
      NovaAPI.SetTMPText(self._mapNode.TMPChoose[i], ConfigTable.GetUIText("StartowerFastBattle_LastRoom_Option"))
    end
  end
  self.tbStrengthMachineCost = ConfigTable.GetConfigNumberArray("StrengthenMachineGoldConsume")
end

function StarTowerFastBattleOptionCtrl:OnEnable()
  local nSettingSerial = StarTowerSettingGate.Begin()
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnChoose) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_Select, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
  self.nSelectIdx = 0
  self.bAutoSelecting = false
  self.closeCallBack = self._panel.closeCallback
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:Refresh()
    self._mapNode.rtSelectOption:SetActive(true)
    if self._panel.bAutoDisplay then
      EventManager.Hit("StarTowerFastBattleOptionReady")
    end
    EventManager.Hit(EventId.TemporaryBlockInput, 1)
    StarTowerSettingGate.ReadyAfter(self, nSettingSerial, 1)
  end
  
  cs_coroutine.start(wait)
  GamepadUIManager.EnableGamepadUI("StarTowerFastBattleOptionCtrl", self:GetGamepadUINode())
  self:SetSprite_Coin(self._mapNode.imgCoin, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.textCoinCount, self:ThousandsNumber(self._panel.nCoinCount))
end

function StarTowerFastBattleOptionCtrl:OnDisable()
  StarTowerSettingGate.Clear(self)
  GamepadUIManager.DisableGamepadUI("StarTowerFastBattleOptionCtrl")
  local closeCallback = self.closeCallBack
  self.closeCallBack = nil
  if type(closeCallback) == "function" then
    closeCallback()
  end
  for k, v in ipairs(self._mapNode.btnChoose) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function StarTowerFastBattleOptionCtrl:OnDestroy()
end

function StarTowerFastBattleOptionCtrl:OnEvent_StarTowerSweepEnd()
  self.closeCallBack = nil
end

function StarTowerFastBattleOptionCtrl:Refresh()
  self._mapNode.rtChoose[1]:SetActive(self._panel.bShop)
  NovaAPI.SetTMPText(self._mapNode.TMPChoose[1], ConfigTable.GetUIText("StarTower_Sweep_Option_1"))
  self._mapNode.rtChoose[2]:SetActive(self._panel.bMachine)
  self:RefreshMachineCost()
  NovaAPI.SetTMPText(self._mapNode.TMPChoose[3], ConfigTable.GetUIText("StarTower_Sweep_Option_3"))
  self._mapNode.rtChoose[3]:SetActive(not self._panel.bLastFloor)
  self._mapNode.rtChoose[5]:SetActive(self._panel.bLastFloor)
  local sTips = ConfigTable.GetUIText("StarTower_Sweep_Option_Title")
  if self._panel.bLastFloor then
    sTips = ConfigTable.GetUIText("StartowerFastBattle_LastRoom_Title")
  end
  NovaAPI.SetTMPText(self._mapNode.TMP_Title, sTips)
  local tbBtnObj = {}
  local bFirst = true
  
  local function add(i)
    table.insert(tbBtnObj, self._mapNode.btnChoose[i])
    if bFirst then
      bFirst = false
      self.nSelectIdx = i
    end
  end
  
  if self._panel.bShop then
    add(1)
  end
  if self._panel.bMachine then
    add(2)
  end
  if self._panel.bLastFloor then
    add(5)
  else
    add(3)
  end
  GamepadUIManager.SetNavigation(tbBtnObj, false)
  self:SelectChoose()
end

function StarTowerFastBattleOptionCtrl:RefreshMachineCost()
  self.nMachineCost = 120
  if nil ~= self.tbStrengthMachineCost then
    local times = self._panel.nMachineCount + 1
    self.nMachineCost = self.tbStrengthMachineCost[times]
    if self.nMachineCost == nil then
      self.nMachineCost = self.tbStrengthMachineCost[#self.tbStrengthMachineCost]
    end
    self.nMachineCost = self.nMachineCost - self._panel.nDiscount
    if self._panel.bFirstFree then
      self.nMachineCost = 0
    end
  end
  local sCost = self.nMachineCost == 0 and ConfigTable.GetUIText("ST_StrengthenMachine_Free") or tostring(self.nMachineCost)
  NovaAPI.SetTMPText(self._mapNode.TMPChoose[2], orderedFormat(ConfigTable.GetUIText("StarTower_Sweep_Option_2"), self._panel.nCoinCount < self.nMachineCost and "#BD3059" or "#264278", sCost))
end

function StarTowerFastBattleOptionCtrl:OnBtnClick_Select(btn, bAuto)
  if self.bAutoSelecting and bAuto ~= true then
    return
  end
  local nIdx = table.indexof(self._mapNode.btnChoose, btn)
  if nIdx == 1 or nIdx == 2 or nIdx == 3 then
    StarTowerSettingGate.Begin()
  end
  if nIdx == 1 then
    EventManager.Hit("StarTowerFastBattleOpenShop", bAuto == true)
  elseif nIdx == 2 then
    EventManager.Hit("StarTowerFastBattleOpenMachine", bAuto == true)
  elseif nIdx == 3 then
    EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerFastBattleOption)
  elseif nIdx == 5 then
    EventManager.Hit("TryCloseStarTowerLastShop", self._panel.bMachine, self.nMachineCost)
  end
end

function StarTowerFastBattleOptionCtrl:OnEvent_AutoPreviewShopOption(nIndex)
  if not self:IsOptionAvailable(nIndex) then
    return
  end
  self.bAutoSelecting = true
  for k, selectNode in ipairs(self._mapNode.Select) do
    selectNode:SetActive(k == nIndex)
  end
  self.nSelectIdx = nIndex
  GamepadUIManager.SetSelectedUI(self._mapNode.btnChoose[nIndex].gameObject)
end

function StarTowerFastBattleOptionCtrl:OnEvent_AutoExecuteShopOption(nIndex)
  if not self:IsOptionAvailable(nIndex) then
    return
  end
  self.bAutoSelecting = false
  self:OnBtnClick_Select(self._mapNode.btnChoose[nIndex], true)
end

function StarTowerFastBattleOptionCtrl:OnEvent_AutoDecisionStateChanged(mapState)
  if type(mapState) == "table" and mapState.bPending ~= true then
    self.bAutoSelecting = false
  end
end

function StarTowerFastBattleOptionCtrl:IsOptionAvailable(nIndex)
  if nIndex == 1 then
    return self._panel.bShop == true
  end
  if nIndex == 2 then
    return self._panel.bMachine == true
  end
  return false
end

function StarTowerFastBattleOptionCtrl:OnEvent_RefreshStrengthMachineCost(nMachineCount, bFirstFree)
  self._panel.nMachineCount = nMachineCount
  self._panel.bFirstFree = bFirstFree
  self:RefreshMachineCost()
end

function StarTowerFastBattleOptionCtrl:OnEvent_RefreshStarTowerCoin(nCoinCount)
  self._panel.nCoinCount = nCoinCount
  self:RefreshMachineCost()
  NovaAPI.SetTMPText(self._mapNode.textCoinCount, self:ThousandsNumber(self._panel.nCoinCount))
end

function StarTowerFastBattleOptionCtrl:OnBtnSelect_Select(btn, nIndex)
  if self.nSelectIdx == nIndex then
    return
  end
  for k, v in ipairs(self._mapNode.Select) do
    if k == nIndex then
      if GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Mouse then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    elseif k == self.nSelectIdx then
      v:SetActive(false)
    end
  end
  self.nSelectIdx = nIndex
end

function StarTowerFastBattleOptionCtrl:OnBtnClick_Back()
  EventManager.Hit("LeaveStarTowerFastBattle", function()
    self.closeCallBack = nil
    EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerFastBattleOption)
  end)
end

function StarTowerFastBattleOptionCtrl:OnBtnClick_Depot()
  StarTowerSettingGate.Begin()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  self._mapNode.trRoot.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(false)
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.Potential)
end

function StarTowerFastBattleOptionCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "StarTowerFastBattleOptionCtrl" then
    return
  end
  local bNeedSelect = nBeforeType == AllEnum.GamepadUIType.Other and nAfterType ~= AllEnum.GamepadUIType.Mouse or nBeforeType == AllEnum.GamepadUIType.Mouse and nAfterType ~= AllEnum.GamepadUIType.Other
  if bNeedSelect then
    for k, v in ipairs(self._mapNode.btnChoose) do
      if k == self.nSelectIdx then
        self._mapNode.Select[k]:SetActive(true)
        GamepadUIManager.SetSelectedUI(self._mapNode.btnChoose[self.nSelectIdx].gameObject)
      end
    end
  else
    for k, v in ipairs(self._mapNode.btnChoose) do
      self._mapNode.Select[k]:SetActive(false)
    end
  end
end

function StarTowerFastBattleOptionCtrl:OnEvent_Reopen(sName)
  if sName ~= "StarTowerFastBattleOptionCtrl" then
    return
  end
  local nSettingSerial = StarTowerSettingGate.Begin()
  self._mapNode.goBlur.gameObject:SetActive(true)
  self._mapNode.trRoot.gameObject:SetActive(true)
  local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 3
  GamepadUIManager.SetSelectedUI(self._mapNode.btnChoose[nSelect].gameObject)
  self:SelectChoose()
  StarTowerSettingGate.ReadyAfter(self, nSettingSerial, 1)
end

function StarTowerFastBattleOptionCtrl:SelectChoose()
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
    if self.nSelectIdx ~= 0 then
      self._mapNode.Select[self.nSelectIdx]:SetActive(true)
      GamepadUIManager.SetSelectedUI(self._mapNode.btnChoose[self.nSelectIdx].gameObject)
    end
  else
    for k, v in ipairs(self._mapNode.btnChoose) do
      self._mapNode.Select[k]:SetActive(false)
    end
  end
end

return StarTowerFastBattleOptionCtrl

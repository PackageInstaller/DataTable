local PotentialLevelUpCtrl = class("PotentialLevelUpCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local StarTowerSettingGate = require("Game.Adventure.StarTower.StarTowerSettingGate")
PotentialLevelUpCtrl._mapNodeConfig = {
  blurBg = {},
  menuBg = {},
  btnMask = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_MaskBg"
  },
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animCtrl = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  },
  btnDepot = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Depot"
  },
  imgUpgradeTitle = {},
  imgSelectTitle = {},
  txtUpgrade = {sComponentName = "TMP_Text"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Potential_LevelUp_Title"
  },
  txtCloseTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Potential_LevelUp_Click"
  },
  goChangeDesc = {},
  btnPotential = {sComponentName = "NaviButton", nCount = 3},
  rtBtnPotential = {
    sNodeName = "btnPotential",
    sComponentName = "RectTransform",
    nCount = 3
  },
  potentialCard = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTower.Potential.PotentialCardItemCtrl"
  },
  ScrollView = {
    nCount = 3,
    sComponentName = "GamepadScroll"
  },
  btnConfirm = {sComponentName = "NaviButton"},
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Select_Confirm"
  },
  rtBtnConfirm = {
    sNodeName = "btnConfirm",
    sComponentName = "RectTransform"
  },
  depotPoint = {},
  cardFinishParticle = {},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  }
}
PotentialLevelUpCtrl._mapEventConfig = {
  ShowPotentialLevelUp = "OnEvent_ShowPotentialLevelUp",
  GamepadUIReopen = "OnEvent_Reopen",
  StarTowerAutoClosePotentialLevelUp = "OnEvent_AutoClose"
}
PotentialLevelUpCtrl._mapRedDotConfig = {}

function PotentialLevelUpCtrl:Refresh(tbPotential)
  if tbPotential == nil or #tbPotential == 0 then
    return
  end
  self._mapNode.imgUpgradeTitle.gameObject:SetActive(false)
  self._mapNode.imgSelectTitle.gameObject:SetActive(true)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self._mapNode.goChangeDesc.gameObject:SetActive(false)
  self:RefreshPotentialList(tbPotential)
end

function PotentialLevelUpCtrl:RefreshPotentialList(tbPotential)
  local nSettingSerial = StarTowerSettingGate.Begin()
  local tbCardObj = {}
  local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
  for k, v in ipairs(self._mapNode.potentialCard) do
    v.gameObject:SetActive(false)
    self._mapNode.btnPotential[k].gameObject:SetActive(tbPotential[k] ~= nil)
    if tbPotential[k] ~= nil then
      local nTid = tbPotential[k].nId
      local potentialCfg = ConfigTable.GetData("Potential", nTid)
      if nil ~= potentialCfg then
        local nCharId = potentialCfg.CharId
        local nPotentialAddLv = self._panel.mapPotentialAddLevel[nCharId][nTid] or 0
        v:SetPotentialItem(nTid, tbPotential[k].nLevel, tbPotential[k].nNextLevel, bSimple, true, nPotentialAddLv, AllEnum.PotentialCardType.StarTower)
        table.insert(tbCardObj, v)
      end
    end
  end
  if 0 < #tbCardObj then
    local function wait()
      EventManager.Hit(EventId.BlockInput, true)
      
      local frameCount = 0
      while 0 < #tbCardObj do
        if 4 <= frameCount then
          local cardObj = table.remove(tbCardObj, 1)
          if cardObj ~= nil then
            cardObj.gameObject:SetActive(true)
            cardObj:PlayAnim("tc_newperk_card_in")
            WwiseAudioMgr:PlaySound("ui_roguelike_xintiao_select")
          end
          frameCount = 0
        else
          frameCount = frameCount + 1
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        end
      end
      EventManager.Hit(EventId.BlockInput, false)
      StarTowerSettingGate.ReadyAfter(self, nSettingSerial, math.max(NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
        "PotentialSelectPanel_in"
      }), NovaAPI.GetAnimClipLength(self._mapNode.potentialCard[1].animCtrl, {
        "tc_newperk_card_in"
      })))
      self:TryAutoClose()
    end
    
    cs_coroutine.start(wait)
  else
    self:TryAutoClose()
  end
end

function PotentialLevelUpCtrl:TryAutoClose()
  if not self._bAutoClosePending or not self._mapNode.contentRoot.gameObject.activeSelf then
    return
  end
  StarTowerSettingGate.Transition(self, 0.3)
  self:AddTimer(1, 0.3, function()
    if self._bAutoClosePending and (self._isAutoEnabledCallback == nil or self._isAutoEnabledCallback()) then
      self:OnBtnClick_MaskBg()
    end
  end, true, true, true)
end

function PotentialLevelUpCtrl:HidePanel()
  StarTowerSettingGate.Begin()
  PanelManager.InputEnable()
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.btnMask.gameObject:SetActive(false)
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nInitSortingOrder)
  GamepadUIManager.DisableGamepadUI("PotentialLevelUpCtrl")
  if nil ~= self.callback then
    self.callback()
  end
end

function PotentialLevelUpCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.menuBg.gameObject:SetActive(false)
  self._mapNode.txtCloseTips.gameObject:SetActive(true)
  self._mapNode.btnMask.gameObject:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function PotentialLevelUpCtrl:OnEnable()
end

function PotentialLevelUpCtrl:OnDisable()
  StarTowerSettingGate.Clear(self)
end

function PotentialLevelUpCtrl:OnBtnClick_MaskBg()
  self._bAutoClosePending = false
  self:HidePanel()
end

function PotentialLevelUpCtrl:OnEvent_AutoClose(callback, isAutoEnabledCallback)
  if not self._mapNode.blurBg.gameObject.activeSelf or self.callback ~= callback then
    return
  end
  self._bAutoClosePending = true
  self._isAutoEnabledCallback = isAutoEnabledCallback
end

function PotentialLevelUpCtrl:OnBtnClick_Depot()
  StarTowerSettingGate.Begin()
  self.bOpenDepot = true
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.btnMask.gameObject:SetActive(false)
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.Potential)
end

function PotentialLevelUpCtrl:OnEvent_CloseStarTowerDepot()
  if self.bOpenDepot then
    local nSettingSerial = StarTowerSettingGate.Begin()
    self.bOpenDepot = false
    EventManager.Hit("StarTowerSetButtonEnable", false, false)
    self._mapNode.blurBg.gameObject:SetActive(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.contentRoot.gameObject:SetActive(true)
      self._mapNode.btnMask.gameObject:SetActive(true)
      if self.nSelectIdx ~= 0 then
        for k, v in ipairs(self._mapNode.potentialCard) do
          if k == self.nSelectIdx then
            v:PlayAnim("tc_newperk_card_switch_up")
            v:ChangeWordRaycast(true)
          end
        end
      end
    end
    
    cs_coroutine.start(function()
      wait()
      StarTowerSettingGate.ReadyAfter(self, nSettingSerial, NovaAPI.GetAnimClipLength(self._mapNode.potentialCard[1].animCtrl, {
        "tc_newperk_card_switch_up"
      }))
    end)
  end
end

function PotentialLevelUpCtrl:OnEvent_ShowPotentialLevelUp(tbPotential, callback)
  StarTowerSettingGate.Begin()
  self._panel:SetTop(self.canvas)
  if self._mapNode.blurBg.gameObject.activeSelf == false then
    PanelManager.InputDisable()
  end
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  GamepadUIManager.EnableGamepadUI("PotentialLevelUpCtrl", self.tbGamepadUINode)
  self.callback = callback
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(true)
  self._mapNode.btnMask.gameObject:SetActive(true)
  self._mapNode.menuBg.gameObject:SetActive(false)
  self._mapNode.cardFinishParticle:SetActive(false)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.contentRoot.gameObject:SetActive(true)
    self._mapNode.animCtrl:Play("PotentialSelectPanel_in")
    self:Refresh(tbPotential)
  end
  
  cs_coroutine.start(wait)
  local tbConfig = {
    {
      sAction = "Confirm",
      sLang = "ActionBar_Confirm"
    },
    {
      sAction = "Scroll",
      sLang = "ActionBar_Scroll"
    },
    {
      sAction = "Depot",
      sLang = "ActionBar_Depot"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function PotentialLevelUpCtrl:OnEvent_Reopen(sName)
  if sName ~= "PotentialLevelUpCtrl" then
    return
  end
  self:OnEvent_CloseStarTowerDepot()
end

return PotentialLevelUpCtrl

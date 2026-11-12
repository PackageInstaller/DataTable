local PotentialSelectCtrl = class("PotentialSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local StarTowerSettingGate = require("Game.Adventure.StarTower.StarTowerSettingGate")
PotentialSelectCtrl._mapNodeConfig = {
  blurBg = {},
  menuBg = {},
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animCtrl = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  },
  txtCloseTips = {},
  btnMask = {},
  imgCoinBg = {},
  imgCoin = {sComponentName = "Image"},
  txtCoinCount = {sComponentName = "TMP_Text"},
  btnDepot = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Depot"
  },
  goDepotRoot = {
    sNodeName = "imgBg_Back_Log",
    sComponentName = "GameObject"
  },
  imgUpgradeTitle = {},
  imgSelectTitle = {},
  txtUpgrade = {sComponentName = "TMP_Text"},
  txtTitle = {sComponentName = "TMP_Text"},
  goChangeDesc = {},
  txtChange = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Change_Desc"
  },
  btnChangeDesc = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ChangeDesc"
  },
  goOpen = {},
  goOff = {},
  btnPotential = {
    sComponentName = "NaviButton",
    nCount = 3,
    callback = "OnBtnClick_PotentialItem"
  },
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
  SpScrollView = {
    nCount = 3,
    sComponentName = "GamepadScroll"
  },
  btnConfirm = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Confirm"
  },
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
  RollButton = {},
  btnRoll = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Roll"
  },
  imgRollCostIcon = {sComponentName = "Image"},
  txtRollCostCount = {sComponentName = "TMP_Text"},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  }
}
PotentialSelectCtrl._mapEventConfig = {
  StarTowerPotentialSelect = "OnEvent_StarTowerPotentialSelect",
  RefreshStarTowerCoin = "OnEvent_SetCoin",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen",
  StarTowerAutoSelectPotential = "OnEvent_AutoSelectPotential",
  StarTowerAutoDecisionStateChanged = "OnEvent_AutoDecisionStateChanged"
}
PotentialSelectCtrl._mapRedDotConfig = {}

function PotentialSelectCtrl:Refresh(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, bAfterRoll, tbRecommend, nAutoSelectIdx)
  self.nEventId = nEventId
  self._nAutoSelectIdx = nAutoSelectIdx
  if tbPotential == nil or #tbPotential == 0 then
    local function completeFunc(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx)
      self:SelectComplete(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx)
    end
    
    self.callback(1000, nEventId, completeFunc)
    traceback("潜能卡选择列表为空！！！")
    return
  end
  local bSpecial = false
  local itemCfg = ConfigTable.GetData_Item(tbPotential[1].Id)
  if itemCfg then
    bSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential
  end
  if bSpecial and mapRoll then
    mapRoll.CanReRoll = false
  end
  self.nSelectIdx = 0
  self.nPanelType = nType
  self._mapNode.imgUpgradeTitle.gameObject:SetActive(nType == 1)
  self._mapNode.imgSelectTitle.gameObject:SetActive(nType ~= 1)
  if nType == 0 then
    NovaAPI.SetTMPText(self._mapNode.txtTitle, ConfigTable.GetUIText("StarTower_Potential_Select_Title_1"))
  elseif nType == 1 then
    if nLevel ~= nil and nLevel ~= 0 then
      NovaAPI.SetTMPText(self._mapNode.txtUpgrade, orderedFormat(ConfigTable.GetUIText("Potential_Select_Title"), nLevel))
    end
  elseif nType == 2 then
    NovaAPI.SetTMPText(self._mapNode.txtTitle, ConfigTable.GetUIText("StarTower_Potential_Select_Title_2"))
  else
    self._mapNode.imgSelectTitle.gameObject:SetActive(false)
  end
  self._mapNode.RollButton:SetActive(mapRoll and mapRoll.CanReRoll and nType ~= 2)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self._mapNode.goDepotRoot:SetActive(self._panel.nStarTowerId ~= 999)
  self.nCoin = nCoin
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(self.nCoin))
  self.mapRoll = mapRoll
  self:RefreshCoin(nCoin, mapRoll)
  self:RefreshPotentialList(tbPotential, mapPotential, tbNewIds, tbLuckyIds, bAfterRoll, tbRecommend)
  self:SetSimpleState()
  self:PlayCharVoice(tbPotential)
  local tbConfig = {}
  if mapRoll and mapRoll.CanReRoll then
    tbConfig = {
      {
        sAction = "Confirm",
        sLang = "ActionBar_Confirm"
      },
      {
        sAction = "Roll",
        sLang = "ActionBar_Reroll"
      },
      {
        sAction = "Scroll",
        sLang = "ActionBar_Scroll"
      },
      {
        sAction = "Depot",
        sLang = "ActionBar_Depot"
      },
      {
        sAction = "Switch",
        sLang = "ActionBar_ChangeDesc"
      }
    }
  else
    tbConfig = {
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
      },
      {
        sAction = "Switch",
        sLang = "ActionBar_ChangeDesc"
      }
    }
  end
  if self._panel.nStarTowerId == 999 then
    tbConfig = {
      {
        sAction = "Confirm",
        sLang = "ActionBar_Confirm"
      },
      {
        sAction = "Scroll",
        sLang = "ActionBar_Scroll"
      },
      {
        sAction = "Switch",
        sLang = "ActionBar_ChangeDesc"
      }
    }
  end
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function PotentialSelectCtrl:RefreshCoin(nCoin, mapRoll)
  if not mapRoll or not mapRoll.CanReRoll then
    return
  end
  self:SetSprite_Coin(self._mapNode.imgRollCostIcon, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtRollCostCount, mapRoll.ReRollPrice)
  NovaAPI.SetTMPColor(self._mapNode.txtRollCostCount, nCoin < mapRoll.ReRollPrice and Red_Unable or Blue_Normal)
end

function PotentialSelectCtrl:ReadySettingPresentationAfter(mapPresentation, nDuration)
  if self._mapSettingPresentation ~= mapPresentation then
    return
  end
  self:AddTimer(1, nDuration, function()
    if self._mapSettingPresentation == mapPresentation then
      mapPresentation.bReady = true
      StarTowerSettingGate.Ready(self, mapPresentation.nSerial)
    end
  end, true, true, true)
end

function PotentialSelectCtrl:RefreshPotentialList(tbPotential, mapPotential, tbNewIds, tbLuckyIds, bAfterRoll, tbRecommendParam)
  local mapPresentation = {
    nSerial = StarTowerSettingGate.Begin()
  }
  self._mapSettingPresentation = mapPresentation
  local tbRecommend = {}
  if 0 < #tbRecommendParam then
    if tbRecommendParam[1].nLevel == nil then
      table.insert(tbRecommend, tbRecommendParam[1])
    else
      tbRecommend = clone(tbRecommendParam)
    end
  end
  self.bSpecialPotential = false
  self.tbPotential = {}
  self.nRecommendIdx = 0
  for _, v in ipairs(tbPotential) do
    local bNew, bLucky = false, false
    local nCurLevel = mapPotential[v.Id]
    local nAddLevel = v.Count
    local nNextLevel = nCurLevel + nAddLevel
    local mapCfg = ConfigTable.GetData("Potential", v.Id)
    if mapCfg ~= nil then
      local nMaxLevel = PlayerData.StarTower:GetPotentialMaxLevelWithEquipment()
      nNextLevel = math.min(nNextLevel, nMaxLevel)
    end
    if nCurLevel == 0 then
      nCurLevel = nAddLevel
    end
    if tbNewIds ~= nil then
      for _, nId in ipairs(tbNewIds) do
        if nId == v.Id then
          bNew = true
          break
        end
      end
    end
    if tbLuckyIds ~= nil then
      for _, nId in ipairs(tbLuckyIds) do
        if nId == v.Id then
          bLucky = true
          break
        end
      end
    end
    table.insert(self.tbPotential, {
      nId = v.Id,
      nLevel = nCurLevel,
      nNextLevel = nNextLevel,
      bNew = bNew,
      bLucky = bLucky
    })
  end
  local tbCardObj, tbBtnObj = {}, {}
  for k, v in ipairs(self._mapNode.potentialCard) do
    v.gameObject:SetActive(false)
    self._mapNode.btnPotential[k].gameObject:SetActive(self.tbPotential[k] ~= nil)
    if self.tbPotential[k] ~= nil then
      local nTid = self.tbPotential[k].nId
      local potentialCfg = ConfigTable.GetData("Potential", nTid)
      if nil ~= potentialCfg then
        local nCharId = potentialCfg.CharId
        local nPotentialAddLv = self._panel.mapPotentialAddLevel[nCharId][nTid] or 0
        local data = self.tbPotential[k]
        local bSpecial = v:SetPotentialItem(nTid, data.nLevel, data.nNextLevel, self.bSimple, true, nPotentialAddLv, AllEnum.PotentialCardType.StarTower, data.bNew, data.bLucky)
        local bRec = false
        v:SetRecommend(false)
        for _, data in ipairs(tbRecommend) do
          if data.nId == nTid then
            bRec = true
            v:SetRecommend(true, data.nLevel)
            break
          end
        end
        if bRec and self.nRecommendIdx == 0 then
          self.nRecommendIdx = k
        end
        v:ChangeWordRaycast(false)
        table.insert(tbCardObj, v)
        table.insert(tbBtnObj, self._mapNode.btnPotential[k])
        self.bSpecialPotential = self.bSpecialPotential or bSpecial
      end
    end
  end
  self.nRecommendIdx = math.max(self.nRecommendIdx, 1)
  self:ResetSelect(tbBtnObj)
  local nCardAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.potentialCard[1].animCtrl, {
    "tc_newperk_card_in"
  })
  local nPanelAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
    "PotentialSelectPanel_in"
  })
  local nAnimTime = nCardAnimTime > nPanelAnimTime and nCardAnimTime or nPanelAnimTime
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  if self.nPanelType == 2 then
    WwiseAudioMgr:PlaySound("ui_roguelike_shop_slotMachine")
  else
    WwiseAudioMgr:PlaySound("ui_roguelike_xintiao_select")
  end
  if 0 < #tbCardObj then
    local function wait()
      local frameCount = 0
      
      while 0 < #tbCardObj do
        if 4 <= frameCount then
          local cardObj = table.remove(tbCardObj, 1)
          if cardObj ~= nil then
            cardObj.gameObject:SetActive(true)
            if bAfterRoll then
              cardObj:PlayAnim("tc_newperk_card_RollEffect")
              cardObj:ActiveRollEffect()
            else
              cardObj:PlayAnim("tc_newperk_card_in")
            end
          end
          frameCount = 0
        else
          frameCount = frameCount + 1
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        end
      end
    end
    
    cs_coroutine.start(function()
      wait()
      local nRollAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.potentialCard[1].animCtrl, {
        "tc_newperk_card_RollEffect"
      })
      self:ReadySettingPresentationAfter(mapPresentation, math.max(nAnimTime, bAfterRoll and nRollAnimTime or 0))
    end)
  end
end

function PotentialSelectCtrl:SetSimpleState()
  self._mapNode.goOff.gameObject:SetActive(not self.bSimple)
  self._mapNode.goOpen.gameObject:SetActive(self.bSimple)
end

function PotentialSelectCtrl:PlayCharVoice(tbPotential)
  local nCharId = 0
  for k, v in ipairs(tbPotential) do
    local nId = v.Id
    local potentialCfg = ConfigTable.GetData("Potential", nId)
    if nil == potentialCfg then
      printError(string.format("获取潜能表配置失败！！！id = [%s])", nId))
      return
    end
    nCharId = potentialCfg.CharId
    break
  end
  local bMainChar = self._panel:CheckMainChar(nCharId)
  local sVoiceKey = ""
  if bMainChar then
    sVoiceKey = "perk"
  else
    sVoiceKey = "subPerk"
  end
  PlayerData.Voice:PlayCharVoice(sVoiceKey, nCharId)
end

function PotentialSelectCtrl:SelectComplete(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx, readyCallback)
  self._mapSettingPresentation = nil
  StarTowerSettingGate.Begin()
  self:PlaySelectCollect(nEventId == 0, function()
    if nEventId == 0 then
      self:HidePanel()
      if self.callback ~= nil then
        self.callback(nEventId, -1)
      end
    else
      self._mapNode.cardFinishParticle:SetActive(false)
      self:Refresh(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, false, tbRecommend, nAutoSelectIdx)
      if type(readyCallback) == "function" then
        readyCallback()
      end
    end
  end)
end

function PotentialSelectCtrl:PlaySelectCollect(bLastSelection, completeCallback)
  if self.bSkip then
    self:SetSubmitInputBlocked(false)
    completeCallback()
    return
  end
  if self.selectTimer ~= nil then
    self.selectTimer:Cancel()
    self.selectTimer = nil
  end
  self:SetSubmitInputBlocked(true)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self._mapNode.goDepotRoot:SetActive(false)
  self._mapNode.RollButton:SetActive(false)
  if bLastSelection then
    self._mapNode.blurBg.gameObject:SetActive(false)
    self._mapNode.menuBg.gameObject:SetActive(true)
    EventManager.Hit("StarTowerSetButtonEnable", true, false)
    CS.GameCameraStackManager.Instance:OpenMainCamera()
  end
  for nIndex, ctrlCard in ipairs(self._mapNode.potentialCard) do
    if nIndex == self.nSelectIdx then
      local animCtrl = ctrlCard.gameObject:GetComponent("Animator")
      animCtrl:Play("tc_newperk_card_out")
      local fxRoot = ctrlCard.gameObject.transform:Find("FX")
      local fx = ctrlCard.gameObject.transform:Find("FX/glow")
      
      local function OutAnimFinish()
        local beginPos = fxRoot.transform.position
        local controlPos = Vector3(3, 5, 0)
        local endPos = self._mapNode.depotPoint.transform.position
        
        local function wait()
          WwiseAudioMgr:PlaySound("ui_roguelike_card_flyby")
          local totalMoveTime = 0.3
          local moveTime = 0
          local normalizedTime = 0
          while normalizedTime < 1 do
            moveTime = moveTime + CS.UnityEngine.Time.unscaledDeltaTime
            normalizedTime = math.min(moveTime / totalMoveTime, 1)
            local nPosX, nPosY, nPosZ = UTILS.GetBezierPointByT(beginPos, controlPos, endPos, normalizedTime)
            local angleZ = math.min(100 * normalizedTime * 2, 100)
            fxRoot.transform.localEulerAngles = Vector3(0, 0, angleZ)
            fxRoot.transform.position = Vector3(nPosX, nPosY, nPosZ)
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          end
          self._mapNode.cardFinishParticle:SetActive(true)
          fx.gameObject:SetActive(false)
          coroutine.yield(CS.UnityEngine.WaitForSecondsRealtime(0.5))
          fxRoot.transform.position = beginPos
          fxRoot.transform.localEulerAngles = Vector3(0, 0, 0)
          fx.gameObject:SetActive(true)
          self:SetSubmitInputBlocked(false)
          completeCallback()
        end
        
        cs_coroutine.start(wait)
      end
      
      self:SetAnimationCallback(animCtrl, OutAnimFinish)
    else
      ctrlCard.gameObject:SetActive(false)
    end
  end
  if bLastSelection then
    self._mapNode.animCtrl:Play("PotentialSelectPanel_out")
    EventManager.Hit("Guide_Potential_SelectComplete")
  end
end

function PotentialSelectCtrl:MoveConfirmButton(btnCard)
  local rtBtn = btnCard:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.localPosition = Vector3(rtBtn.localPosition.x, self.btnConfirmPosY, 0)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function PotentialSelectCtrl:HidePanel()
  self._mapSettingPresentation = nil
  StarTowerSettingGate.Begin()
  self.bOpen = false
  self._nAutoSelectIdx = nil
  if not self.bSkip then
    PanelManager.InputEnable()
    EventManager.Hit("StarTowerSetButtonEnable", true, true)
  end
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nInitSortingOrder)
  GamepadUIManager.DisableGamepadUI("PotentialSelectCtrl")
end

function PotentialSelectCtrl:Awake()
  self.nRecommendIdx = 1
  self._bSubmitInputBlocked = false
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.localPosition.y
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.menuBg.gameObject:SetActive(false)
  self._mapNode.btnDepot.gameObject:SetActive(self._panel.nStarTowerId ~= 999)
  self._mapNode.imgCoinBg.gameObject:SetActive(self._panel.nStarTowerId ~= 999)
  self._mapNode.txtCloseTips.gameObject:SetActive(false)
  self._mapNode.btnMask.gameObject:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.nCoin = 0
  self:SetSprite_Coin(self._mapNode.imgCoin, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self.nCoin)
end

function PotentialSelectCtrl:OnEnable()
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnPotential) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_PotentialItem, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
  if self._panel.nStarTowerId ~= nil and self._panel.nStarTowerId == 999 then
    self._mapNode.btnDepot.gameObject:SetActive(false)
  else
    self._mapNode.btnDepot.gameObject:SetActive(true)
  end
end

function PotentialSelectCtrl:OnDisable()
  self._mapSettingPresentation = nil
  StarTowerSettingGate.Clear(self)
  self._nAutoSelectIdx = nil
  self:SetSubmitInputBlocked(false)
  for k, v in ipairs(self._mapNode.btnPotential) do
    v.onSelect:RemoveListener(self.handler[k])
  end
  if self.selectTimer ~= nil then
    self.selectTimer:Cancel()
    self.selectTimer = nil
  end
end

function PotentialSelectCtrl:OnBtnClick_Depot()
  self._mapSettingPresentation = nil
  StarTowerSettingGate.Begin()
  self.bOpenDepot = true
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  for k, v in ipairs(self._mapNode.potentialCard) do
    v:ChangeWordRaycast(false)
  end
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.Potential)
end

function PotentialSelectCtrl:OnBtnClick_ChangeDesc()
  self.bSimple = not self.bSimple
  PlayerData.StarTower:SetPotentialDescSimple(self.bSimple)
  self:SetSimpleState()
  for _, v in ipairs(self._mapNode.potentialCard) do
    v:ChangeDesc(self.bSimple)
  end
end

function PotentialSelectCtrl:OnBtnClick_Confirm()
  if self.nSelectIdx ~= 0 and self.callback ~= nil then
    local function completeFunc(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx, readyCallback)
      self:SelectComplete(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx, readyCallback)
      
      if self.nPanelType == 2 then
        PlayerData.Voice:PlayCharVoice("thankLvup", 9133, nil, true)
      end
    end
    
    local bAuto = self._bAutoSubmitting == true
    self._bAutoSubmitting = false
    self:SetSubmitInputBlocked(true)
    self.callback(self.nSelectIdx, self.nEventId, completeFunc, false, bAuto)
  end
end

function PotentialSelectCtrl:OnBtnClick_Roll()
  if not (self.callback and self.mapRoll and self.mapRoll.CanReRoll) or self.bSpecialPotential then
    self._bAutoSubmitting = false
    return
  end
  if self.nCoin < self.mapRoll.ReRollPrice then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_ReRoll_NotEnoughCoin"))
    return
  end
  
  local function completeFunc(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx, readyCallback)
    self:SetSubmitInputBlocked(false)
    self:Refresh(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, true, tbRecommend, nAutoSelectIdx)
    if type(readyCallback) == "function" then
      readyCallback()
    end
  end
  
  local bAuto = self._bAutoSubmitting == true
  self._bAutoSubmitting = false
  self:SetSubmitInputBlocked(true)
  self.callback(self.nSelectIdx, self.nEventId, completeFunc, true, bAuto)
end

function PotentialSelectCtrl:SetSubmitInputBlocked(bBlocked)
  if bBlocked then
    self._mapSettingPresentation = nil
    StarTowerSettingGate.Begin()
  end
  bBlocked = bBlocked == true
  if self._bSubmitInputBlocked == bBlocked then
    return
  end
  self._bSubmitInputBlocked = bBlocked
  EventManager.Hit(EventId.BlockInput, bBlocked)
end

function PotentialSelectCtrl:OnBtnSelect_PotentialItem(btn, nIndex)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse or self.bRecommended then
    self:OnBtnClick_PotentialItem(btn, nIndex)
  end
end

function PotentialSelectCtrl:OnBtnClick_PotentialItem(btn, nIndex)
  if nil == self.tbPotential[nIndex] or self.nSelectIdx == nIndex then
    return
  end
  WwiseAudioMgr:PlaySound("ui_roguelike_xintiao_slide")
  StarTowerSettingGate.Transition(self, math.max(NovaAPI.GetAnimClipLength(self._mapNode.potentialCard[nIndex].animCtrl, {
    "tc_newperk_card_switch_up"
  }), NovaAPI.GetAnimClipLength(self._mapNode.potentialCard[nIndex].animCtrl, {
    "tc_newperk_card_switch_down"
  })))
  self:MoveConfirmButton(btn)
  for k, v in ipairs(self._mapNode.potentialCard) do
    if k == nIndex then
      v:PlayAnim("tc_newperk_card_switch_up")
      v:ChangeWordRaycast(true)
    elseif k == self.nSelectIdx then
      v:PlayAnim("tc_newperk_card_switch_down")
      v:ChangeWordRaycast(false)
    end
  end
  self:SelectScroll(nIndex)
  self.nSelectIdx = nIndex
end

function PotentialSelectCtrl:OnEvent_AutoSelectPotential(nEventId, nIndex, bReRoll)
  if not self.bOpen or self.nEventId ~= nEventId or self.callback == nil then
    return
  end
  if not self._mapNode.contentRoot.gameObject.activeSelf then
    return
  end
  self._bAutoSubmitting = true
  if bReRoll then
    self:OnBtnClick_Roll()
    return
  end
  local btn = self._mapNode.btnPotential[nIndex]
  if btn == nil or self.tbPotential[nIndex] == nil then
    self._bAutoSubmitting = false
    return
  end
  self:OnBtnClick_PotentialItem(btn.gameObject, nIndex)
  self:OnBtnClick_Confirm()
end

function PotentialSelectCtrl:OnEvent_AutoDecisionStateChanged(mapState)
  local bAutoInactive = type(mapState) == "table" and (mapState.bEnabled ~= true or mapState.bPaused == true)
  if bAutoInactive then
    self._nAutoSelectIdx = nil
  end
  if bAutoInactive and mapState.bRequesting ~= true then
    self:SetSubmitInputBlocked(false)
  end
end

function PotentialSelectCtrl:OnEvent_StarTowerPotentialSelect(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, callback, mapRoll, nCoin, tbLuckyIds, tbRecommend, nAutoSelectIdx)
  self.callback = callback
  if tbPotential == nil or #tbPotential == 0 then
    self.bSkip = true
    
    local function completeFunc(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, tbRecommend)
      self:SelectComplete(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, tbRecommend)
    end
    
    self.callback(1000, nEventId, completeFunc)
    traceback("潜能卡选择列表为空！！！")
    return
  end
  if self.bOpen and self.nEventId == nEventId then
    self._nAutoSelectIdx = nAutoSelectIdx
    if self.nSelectIdx ~= 0 and nAutoSelectIdx and self.tbPotential[nAutoSelectIdx] and self._mapNode.btnPotential[nAutoSelectIdx] then
      GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[nAutoSelectIdx].gameObject)
      self:OnBtnClick_PotentialItem(self._mapNode.btnPotential[nAutoSelectIdx].gameObject, nAutoSelectIdx)
    end
    local mapPresentation = self._mapSettingPresentation
    if mapPresentation ~= nil and not self._bSubmitInputBlocked and not self.bOpenDepot then
      mapPresentation.nSerial = StarTowerSettingGate.Begin()
      if mapPresentation.bReady then
        StarTowerSettingGate.Ready(self, mapPresentation.nSerial)
      end
    end
    return
  end
  self._panel:SetTop(self.canvas)
  self._mapSettingPresentation = nil
  StarTowerSettingGate.Begin()
  self.bSkip = false
  local bCloseCamera = false
  if not self.bOpen then
    PanelManager.InputDisable()
    EventManager.Hit("StarTowerSetButtonEnable", false, false)
    bCloseCamera = true
    GamepadUIManager.EnableGamepadUI("PotentialSelectCtrl", self.tbGamepadUINode)
  end
  self.bOpen = true
  self.tbPotential = {}
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(true)
  self._mapNode.menuBg.gameObject:SetActive(false)
  self._mapNode.cardFinishParticle:SetActive(false)
  self._mapNode.RollButton:SetActive(false)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    if bCloseCamera then
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    end
    self._mapNode.contentRoot.gameObject:SetActive(true)
    self._mapNode.animCtrl:Play("PotentialSelectPanel_in")
    self:Refresh(nEventId, tbPotential, mapPotential, nType, nLevel, tbNewIds, mapRoll, nCoin, tbLuckyIds, false, tbRecommend, nAutoSelectIdx)
  end
  
  cs_coroutine.start(wait)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self.nSelectIdx = 0
  self.bSimple = PlayerData.StarTower:GetPotentialDescSimple()
end

function PotentialSelectCtrl:OnEvent_CloseStarTowerDepot()
  if self.bOpenDepot then
    local mapPresentation = {
      nSerial = StarTowerSettingGate.Begin()
    }
    self._mapSettingPresentation = mapPresentation
    self.bOpenDepot = false
    EventManager.Hit("StarTowerSetButtonEnable", false, false)
    self._mapNode.blurBg.gameObject:SetActive(true)
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
    GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[nSelect].gameObject)
    EventManager.Hit(EventId.BlockInput, true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
      self._mapNode.contentRoot.gameObject:SetActive(true)
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.BlockInput, false)
      self:ReadySettingPresentationAfter(mapPresentation, NovaAPI.GetAnimClipLength(self._mapNode.potentialCard[1].animCtrl, {
        "tc_newperk_card_switch_up"
      }))
      for k, v in ipairs(self._mapNode.potentialCard) do
        v:CloseBgEffect()
      end
      if self.nSelectIdx == 0 and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other then
        self.nSelectIdx = self:GetDefaultSelectIndex(1)
        self:MoveConfirmButton(self._mapNode.btnPotential[self.nSelectIdx])
      end
      if self.nSelectIdx ~= 0 then
        for k, v in ipairs(self._mapNode.potentialCard) do
          if k == self.nSelectIdx then
            v:PlayAnim("tc_newperk_card_switch_up")
            v:ChangeWordRaycast(true)
            self:SelectScroll(self.nSelectIdx)
          end
        end
      end
    end
    
    cs_coroutine.start(wait)
  end
end

function PotentialSelectCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "PotentialSelectCtrl" then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or self:GetDefaultSelectIndex()
    GamepadUIManager.ClearSelectedUI()
    GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[nSelect].gameObject)
  end
end

function PotentialSelectCtrl:OnEvent_Reopen(sName)
  if sName ~= "PotentialSelectCtrl" then
    return
  end
  if self.bOpenDepot then
    self:OnEvent_CloseStarTowerDepot()
  else
    if self.nSelectIdx == 0 and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other then
      local nSelect = self:GetDefaultSelectIndex(1)
      self:OnBtnClick_PotentialItem(self._mapNode.btnPotential[nSelect].gameObject, nSelect)
    end
    if self.nSelectIdx == 0 then
      return
    end
    GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[self.nSelectIdx].gameObject)
    self._mapNode.potentialCard[self.nSelectIdx]:ChangeWordRaycast(true)
    self:SelectScroll(self.nSelectIdx)
  end
end

function PotentialSelectCtrl:OnEvent_SetCoin(nCount)
  if self.mapRoll ~= nil and self.mapRoll.CanReRoll and nCount then
    if nCount > self.nCoin then
      StarTowerSettingGate.Transition(self, 1)
      local twCoin = DOTween.To(function()
        return self.nCoin
      end, function(v)
        NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(math.floor(v)))
      end, nCount, 1)
      
      local function _cb()
        self.nCoin = nCount
      end
      
      twCoin.onComplete = dotween_callback_handler(self, _cb)
    else
      NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(nCount))
      self.nCoin = nCount
    end
  end
end

function PotentialSelectCtrl:GetDefaultSelectIndex(nFallbackIndex)
  local nAutoSelectIdx = self._nAutoSelectIdx
  if nAutoSelectIdx and self.tbPotential[nAutoSelectIdx] and self._mapNode.btnPotential[nAutoSelectIdx] then
    return nAutoSelectIdx
  end
  return nFallbackIndex or self.nRecommendIdx == 0 and 1 or self.nRecommendIdx
end

function PotentialSelectCtrl:ResetSelect(tbUI)
  self.nSelectIdx = 0
  self.bRecommended = self.nRecommendIdx ~= 0
  GamepadUIManager.SetNavigation(tbUI)
  local nCardAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.potentialCard[1].animCtrl, {
    "tc_newperk_card_in"
  })
  local nPanelAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
    "PotentialSelectPanel_in"
  })
  local nAnimTime = nCardAnimTime > nPanelAnimTime and nCardAnimTime or nPanelAnimTime
  nAnimTime = nAnimTime + 0.4
  StarTowerSettingGate.Transition(self, nAnimTime)
  if self.selectTimer ~= nil then
    self.selectTimer:Cancel()
    self.selectTimer = nil
  end
  self.selectTimer = self:AddTimer(1, nAnimTime, function()
    if self.nSelectIdx == 0 then
      local nSelect = self:GetDefaultSelectIndex()
      GamepadUIManager.ClearSelectedUI()
      GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[nSelect].gameObject)
      self:OnBtnClick_PotentialItem(self._mapNode.btnPotential[nSelect].gameObject, nSelect)
    end
    if self._panel.nStarTowerId ~= 999 then
      if self.bSpecialPotential then
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PotentialSelectSpecial")
      else
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PotentialSelect")
      end
    end
  end, true, true, true)
end

function PotentialSelectCtrl:SelectScroll(nIndex)
  for _, v in ipairs(self._mapNode.ScrollView) do
    NovaAPI.SetComponentEnable(v, false)
  end
  if nIndex then
    NovaAPI.SetComponentEnable(self._mapNode.ScrollView[nIndex], true)
  end
  for _, v in ipairs(self._mapNode.SpScrollView) do
    NovaAPI.SetComponentEnable(v, false)
  end
  if nIndex then
    NovaAPI.SetComponentEnable(self._mapNode.SpScrollView[nIndex], true)
  end
end

return PotentialSelectCtrl

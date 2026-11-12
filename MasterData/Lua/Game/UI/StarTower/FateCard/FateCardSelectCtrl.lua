local FateCardSelectCtrl = class("FateCardSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
FateCardSelectCtrl._mapNodeConfig = {
  blurBg = {},
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animCtrl = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  },
  imgTitleBg = {},
  txtTitle = {sComponentName = "TMP_Text"},
  imgCoinBg = {},
  imgCoin = {sComponentName = "Image"},
  txtCoinCount = {sComponentName = "TMP_Text"},
  btnFateCard = {
    sComponentName = "NaviButton",
    nCount = 3,
    callback = "OnBtnClick_FateCardItem"
  },
  rtBtnFateCard = {
    sNodeName = "btnFateCard",
    sComponentName = "RectTransform",
    nCount = 3
  },
  goFateCardItem = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTower.FateCard.FateCardItemCtrl"
  },
  btnConfirm = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "FateCard_Select_Confirm"
  },
  rtBtnConfirm = {
    sNodeName = "btnConfirm",
    sComponentName = "RectTransform"
  },
  btnAbandon = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Abandon"
  },
  btnDepot = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Depot"
  },
  fxEndPoint = {},
  depotPoint = {},
  cardFinishParticle = {nCount = 2},
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
FateCardSelectCtrl._mapEventConfig = {
  StarTowerSelectFateCard = "OnEvent_StarTowerSelectFateCard",
  RefreshStarTowerCoin = "OnEvent_SetCoin",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen"
}
FateCardSelectCtrl._mapRedDotConfig = {}

function FateCardSelectCtrl:Refresh(nEventId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward, bAfterRoll)
  self.bReward = bReward
  if tbFateCard == nil or #tbFateCard == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_FateCard_Select_Empty_Tip"))
    self._mapNode.blurBg.gameObject:SetActive(false)
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    EventManager.Hit("StarTowerSetButtonEnable", true, false)
    CS.GameCameraStackManager.Instance:OpenMainCamera()
    self:HidePanel()
    return
  end
  self._mapNode.RollButton:SetActive(mapRoll and mapRoll.CanReRoll)
  self.nEventId = nEventId
  self.nSelectIdx = 0
  self.nCoin = nCoin
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(self.nCoin))
  self.mapRoll = mapRoll
  self:RefreshCoin(nCoin, mapRoll)
  self:RefreshFateCardList(tbFateCard, tbNewIds, bAfterRoll)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, bReward and ConfigTable.GetUIText("FateCard_Select_RewardTitle") or ConfigTable.GetUIText("FateCard_Select_Title"))
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
        sAction = "Back",
        sLang = "ActionBar_SkipReward"
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
        sAction = "Back",
        sLang = "ActionBar_SkipReward"
      }
    }
  end
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function FateCardSelectCtrl:RefreshCoin(nCoin, mapRoll)
  if not mapRoll or not mapRoll.CanReRoll then
    return
  end
  self:SetSprite_Coin(self._mapNode.imgRollCostIcon, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtRollCostCount, mapRoll.ReRollPrice)
  NovaAPI.SetTMPColor(self._mapNode.txtRollCostCount, nCoin < mapRoll.ReRollPrice and Red_Unable or Blue_Normal)
end

function FateCardSelectCtrl:RefreshFateCardList(tbFateCard, tbNewIds, bAfterRoll)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self.tbFateCardList = clone(tbFateCard)
  local tbCardObj, tbBtnObj = {}, {}
  for k, v in ipairs(self._mapNode.goFateCardItem) do
    v.gameObject:SetActive(false)
    self._mapNode.btnFateCard[k].gameObject:SetActive(self.tbFateCardList[k] ~= nil)
    if self.tbFateCardList[k] ~= nil then
      local bNew = false
      if tbNewIds ~= nil then
        for _, nId in ipairs(tbNewIds) do
          if nId == self.tbFateCardList[k] then
            bNew = true
            break
          end
        end
      end
      v:SetFateCardItem(self.tbFateCardList[k], bNew)
      v:ChangeWordRaycast(false)
      table.insert(tbCardObj, v)
      table.insert(tbBtnObj, self._mapNode.btnFateCard[k])
    end
  end
  self:ResetSelect(tbBtnObj)
  local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
    "PotentialSelectPanel_in"
  })
  EventManager.Hit(EventId.TemporaryBlockInput, animTime)
  if self.bReward then
    WwiseAudioMgr:PlaySound("ui_roguelike_luckeyCard_active")
  else
    WwiseAudioMgr:PlaySound("ui_roguelike_itemCard")
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
    
    cs_coroutine.start(wait)
  end
end

function FateCardSelectCtrl:SelectComplete(nEventId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward)
  if nEventId == nil or nEventId == 0 then
    EventManager.Hit(EventId.BlockInput, true)
    self._mapNode.blurBg.gameObject:SetActive(false)
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    EventManager.Hit("StarTowerSetButtonEnable", true, false)
    CS.GameCameraStackManager.Instance:OpenMainCamera()
    local bSelect = false
    for k, v in ipairs(self._mapNode.goFateCardItem) do
      if k == self.nSelectIdx then
        bSelect = true
        local animCtrl = v.gameObject:GetComponent("Animator")
        animCtrl:Play("tc_newperk_card_out")
        local fxRoot = v.gameObject.transform:Find("FX")
        local fx = v.gameObject.transform:Find("FX/glow")
        
        local function OutAnimFinish()
          local beginPos = fxRoot.transform.position
          local controlPos = Vector3(3, 5, 0)
          local bType1 = PanelManager.CheckPanelOpen(PanelId.StarTowerShop) or self:GetPanelId() == PanelId.StarTowerFastBattle
          local endPos, goCardFx
          if bType1 then
            endPos = self._mapNode.depotPoint.transform.position
            goCardFx = self._mapNode.cardFinishParticle[1]
          else
            endPos = self._mapNode.fxEndPoint.transform.position
            goCardFx = self._mapNode.cardFinishParticle[2]
          end
          
          local function wait()
            WwiseAudioMgr:PlaySound("ui_roguelike_card_flyby")
            local totalMoveTime = 0.3
            local moveTime = 0
            local normalizedTime = 0
            while normalizedTime < 1 do
              moveTime = moveTime + CS.UnityEngine.Time.unscaledDeltaTime
              normalizedTime = moveTime / totalMoveTime
              normalizedTime = normalizedTime <= 1 and normalizedTime or 1
              local x, y, z = UTILS.GetBezierPointByT(beginPos, controlPos, endPos, normalizedTime)
              local angleZ = 100 * normalizedTime * 2
              angleZ = angleZ <= 100 and angleZ or 100
              fxRoot.transform.localEulerAngles = Vector3(0, 0, angleZ)
              fxRoot.transform.position = Vector3(x, y, z)
              coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            end
            goCardFx.gameObject:SetActive(true)
            fx.gameObject:SetActive(false)
            coroutine.yield(CS.UnityEngine.WaitForSecondsRealtime(0.5))
            EventManager.Hit(EventId.BlockInput, false)
            self:HidePanel()
            fxRoot.transform.position = beginPos
            fxRoot.transform.localEulerAngles = Vector3(0, 0, 0)
            fx.gameObject:SetActive(true)
            if nil ~= self.callback then
              self.callback(-1, nEventId)
            end
          end
          
          cs_coroutine.start(wait)
        end
        
        self:SetAnimationCallback(animCtrl, OutAnimFinish)
      else
        v.gameObject:SetActive(false)
      end
    end
    self._mapNode.animCtrl:Play("PotentialSelectPanel_out")
    if not bSelect then
      local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
        "PotentialSelectPanel_out"
      })
      self:AddTimer(1, nAnimLen, function()
        EventManager.Hit(EventId.BlockInput, false)
        self:HidePanel()
        if nil ~= self.callback then
          self.callback(-1, nEventId)
        end
      end, true, true, true, nil)
    end
    EventManager.Hit("Guide_FateCard_SelectComplete")
  else
    self:Refresh(nEventId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward)
    if bReward then
      self._mapNode.animCtrl:Play("VampireFateCard_in1")
    end
  end
end

function FateCardSelectCtrl:MoveConfirmButton(btnCard)
  local rtBtn = btnCard:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.localPosition = Vector3(rtBtn.localPosition.x, self.btnConfirmPosY, 0)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function FateCardSelectCtrl:HidePanel()
  self.bOpen = false
  PanelManager.InputEnable()
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nInitSortingOrder)
  GamepadUIManager.DisableGamepadUI("FateCardSelectCtrl")
end

function FateCardSelectCtrl:Awake()
  self.bOpen = false
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.localPosition.y
  self.bOpenDepot = false
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.btnDepot.gameObject:SetActive(self._panel.nStarTowerId ~= 999)
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.nCoin = 0
  self:SetSprite_Coin(self._mapNode.imgCoin, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self.nCoin)
end

function FateCardSelectCtrl:OnEnable()
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnFateCard) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_FateCardItem, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
end

function FateCardSelectCtrl:OnDisable()
  for k, v in ipairs(self._mapNode.btnFateCard) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function FateCardSelectCtrl:OnBtnClick_Confirm()
  if nil ~= self.callback then
    local function completeFunc(nEventId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward)
      EventManager.Hit(EventId.BlockInput, false)
      
      self:SelectComplete(nEventId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward)
    end
    
    EventManager.Hit(EventId.BlockInput, true)
    self.callback(self.nSelectIdx, self.nEventId, completeFunc)
  end
end

function FateCardSelectCtrl:OnBtnClick_Roll()
  if not self.callback then
    return
  end
  if self.nCoin < self.mapRoll.ReRollPrice then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_ReRoll_NotEnoughCoin"))
    return
  end
  
  local function completeFunc(nEventId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward)
    EventManager.Hit(EventId.BlockInput, false)
    self:Refresh(nEventId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward, true)
  end
  
  EventManager.Hit(EventId.BlockInput, true)
  self.callback(self.nSelectIdx, self.nEventId, completeFunc, true)
end

function FateCardSelectCtrl:OnBtnClick_Abandon()
  local function confirm()
    if nil ~= self.callback then
      self.nSelectIdx = 0
      
      local function abandonFunc(nEventId, tbFateCard, tbNewIds)
        self:SelectComplete(nEventId, tbFateCard, tbNewIds)
      end
      
      self.callback(1000, self.nEventId, abandonFunc)
    end
    if self.bReward then
      WwiseAudioMgr:PlaySound("ui_roguelike_perk_active_stop")
    end
  end
  
  local TipsTime = LocalData.GetPlayerLocalData("FateCard_Tips_Time")
  local _tipDay = 0
  if TipsTime ~= nil then
    _tipDay = tonumber(TipsTime)
  end
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local fixedTimeStamp = curTimeStamp + newDayTime * 3600
  local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
  local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
  local nDay = tonumber(os.date("!%d", fixedTimeStamp))
  local nowD = nYear * 366 + nMonth * 31 + nDay
  if nowD == _tipDay then
    confirm()
  else
    local isSelectAgain = false
    
    local function confirmCallback()
      if isSelectAgain then
        local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
        local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
        local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
        local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
        local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
        local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
        LocalData.SetPlayerLocalData("FateCard_Tips_Time", tostring(_nowD))
      end
      confirm()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("FateCard_AbandonTip")),
      callbackConfirm = confirmCallback,
      callbackAgain = againCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

function FateCardSelectCtrl:OnBtnSelect_FateCardItem(btn, nIndex)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse or self.bRecommended then
    self:OnBtnClick_FateCardItem(btn, nIndex)
  end
end

function FateCardSelectCtrl:OnBtnClick_FateCardItem(btn, nIndex)
  if nil == self.tbFateCardList[nIndex] or self.nSelectIdx == nIndex then
    return
  end
  WwiseAudioMgr:PlaySound("ui_roguelike_xintiao_slide")
  self:MoveConfirmButton(btn)
  for k, v in ipairs(self._mapNode.goFateCardItem) do
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

function FateCardSelectCtrl:OnBtnClick_Depot()
  self.bOpenDepot = true
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.ItemList)
end

function FateCardSelectCtrl:OnEvent_StarTowerSelectFateCard(nEventId, tbFateCard, tbNewIds, callback, mapRoll, nCoin, bReward)
  self._panel:SetTop(self.canvas)
  self.callback = callback
  local bClosePanel = false
  if not self.bOpen then
    PanelManager.InputDisable()
    EventManager.Hit("StarTowerSetButtonEnable", false, false)
    bClosePanel = true
    GamepadUIManager.EnableGamepadUI("FateCardSelectCtrl", self.tbGamepadUINode)
  end
  self.bOpen = true
  self.nSelectIdx = 0
  self.tbFateCardList = {}
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(true)
  self._mapNode.cardFinishParticle[1].gameObject:SetActive(false)
  self._mapNode.cardFinishParticle[2].gameObject:SetActive(false)
  self._mapNode.RollButton:SetActive(false)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    if bClosePanel then
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    end
    self._mapNode.contentRoot.gameObject:SetActive(true)
    if bReward then
      self._mapNode.animCtrl:Play("VampireFateCard_in1")
    else
      self._mapNode.animCtrl:Play("PotentialSelectPanel_in")
    end
    self:Refresh(nEventId, tbFateCard, tbNewIds, mapRoll, nCoin, bReward)
  end
  
  cs_coroutine.start(wait)
end

function FateCardSelectCtrl:OnEvent_CloseStarTowerDepot()
  if self.bOpenDepot then
    self.bOpenDepot = false
    EventManager.Hit("StarTowerSetButtonEnable", false, false)
    self._mapNode.blurBg.gameObject:SetActive(true)
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
    GamepadUIManager.SetSelectedUI(self._mapNode.btnFateCard[nSelect].gameObject)
    EventManager.Hit(EventId.BlockInput, true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.BlockInput, false)
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
      self._mapNode.contentRoot.gameObject:SetActive(true)
      if self.nSelectIdx == 0 and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other then
        self.nSelectIdx = 1
        self:MoveConfirmButton(self._mapNode.btnFateCard[self.nSelectIdx])
      end
      for k, v in ipairs(self._mapNode.goFateCardItem) do
        if k == self.nSelectIdx then
          v:PlayAnim("tc_newperk_card_switch_up")
          v:ChangeWordRaycast(true)
          self:SelectScroll(self.nSelectIdx)
        end
      end
    end
    
    cs_coroutine.start(wait)
  end
end

function FateCardSelectCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "FateCardSelectCtrl" then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
    GamepadUIManager.ClearSelectedUI()
    GamepadUIManager.SetSelectedUI(self._mapNode.btnFateCard[nSelect].gameObject)
  end
end

function FateCardSelectCtrl:OnEvent_Reopen(sName)
  if sName ~= "FateCardSelectCtrl" then
    return
  end
  if self.bOpenDepot then
    self:OnEvent_CloseStarTowerDepot()
  else
    if self.nSelectIdx == 0 and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other then
      self.nSelectIdx = 1
    end
    if self.nSelectIdx == 0 then
      return
    end
    GamepadUIManager.SetSelectedUI(self._mapNode.btnFateCard[self.nSelectIdx].gameObject)
    self._mapNode.goFateCardItem[self.nSelectIdx]:ChangeWordRaycast(true)
    self:SelectScroll(self.nSelectIdx)
  end
end

function FateCardSelectCtrl:OnEvent_SetCoin(nCount)
  if self.mapRoll ~= nil and self.mapRoll.CanReRoll and nCount then
    if nCount > self.nCoin then
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

function FateCardSelectCtrl:ResetSelect(tbUI)
  self.nSelectIdx = 0
  self.bRecommended = false
  GamepadUIManager.SetNavigation(tbUI)
  local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
    "PotentialSelectPanel_in"
  }) + 0.1
  self:AddTimer(1, animTime, function()
    if self.nSelectIdx == 0 then
      GamepadUIManager.ClearSelectedUI()
      GamepadUIManager.SetSelectedUI(self._mapNode.btnFateCard[1].gameObject)
      if GamepadUIManager.GetCurUIType() == AllEnum.GamepadUIType.Mouse then
        self:OnBtnClick_FateCardItem(self._mapNode.btnFateCard[1].gameObject, 1)
      end
    end
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_FateCardSelect")
  end, true, true, true)
end

function FateCardSelectCtrl:SelectScroll(nIndex)
  for _, v in ipairs(self._mapNode.goFateCardItem) do
    v:SetGamePadScrollEnable(false)
  end
  if nIndex then
    self._mapNode.goFateCardItem[nIndex]:SetGamePadScrollEnable(true)
  end
end

return FateCardSelectCtrl

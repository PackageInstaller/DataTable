local VampireFateCardSelect = class("VampireFateCardSelect", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local sAutoSelectKey = "VampireAutoSelectFateCard"
VampireFateCardSelect._mapNodeConfig = {
  blurBg = {},
  contentRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  animCtrl = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  },
  imgTitleBg = {},
  txtTitle = {sComponentName = "TMP_Text"},
  goCoin = {},
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
    sCtrlName = "Game.UI.VampireSurvivor.FateCardItemCtrl"
  },
  btnConfirm = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Confirm"
  },
  btnConfirmReward = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Confirm",
    sAction = "Confirm"
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
    callback = "OnBtnClick_Abandon",
    sAction = "Back"
  },
  txtBtnAbandon = {
    sComponentName = "TMP_Text",
    sLanguageId = "FateCard_Select_Abandon"
  },
  btnDepot = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Depot"
  },
  txtClickPre = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Click_Pre"
  },
  txtClickSuf = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Click_Suf"
  },
  TMPRewardBtnTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  imgGlory = {},
  fxEndPoint = {nCount = 5},
  depotPoint = {},
  cardFinishParticle = {nCount = 2},
  RollButton = {},
  btnRoll = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Roll"
  },
  imgRollCostIcon = {sComponentName = "Image"},
  txtRollCostCount = {sComponentName = "TMP_Text"},
  pkgInfo = {
    sNodeName = "pkgInfo1_",
    sCtrlName = "Game.UI.VampireSurvivor.VampireFateSelect_packageInfoCtrl",
    nCount = 5
  },
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnAutoSelectOpen = {
    sComponentName = "NaviButton",
    callback = "OnClick_AutoSelectOpen",
    sAction = "AutoBattle"
  },
  btnAutoSelectClose = {
    sComponentName = "NaviButton",
    callback = "OnClick_AutoSelectClose",
    sAction = "AutoBattle"
  },
  txtBtnAutoSelectOpen = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_FateCardAutoSelect"
  },
  txtBtnAutoSelectClose = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_FateCardAutoSelect"
  },
  txtBtnAutoSelectNum = {nCount = 4, sComponentName = "TMP_Text"},
  AutoSelectPanel = {}
}
VampireFateCardSelect._mapEventConfig = {
  VampireRewardChestFailed = "OnEvent_VampireRewardChestFailed",
  VampireLevelRewardFailed = "OnEvent_VampireLevelRewardFailed",
  VampireSelectFateCard = "OnEvent_SelectFateCard",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen"
}
VampireFateCardSelect._mapRedDotConfig = {}

function VampireFateCardSelect:Refresh(nEventId, tbFateCard, mapRoll, nCoin, bReward, bAfterRoll)
  self.bReward = bReward
  self._mapNode.imgGlory:SetActive(true)
  if tbFateCard == nil or #tbFateCard == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_FateCard_Select_Empty_Tip"))
    self._mapNode.blurBg.gameObject:SetActive(false)
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    CS.GameCameraStackManager.Instance:OpenMainCamera()
    self:HidePanel()
    if nil ~= self.callback then
      self.callback(-1, nEventId)
    end
    return
  end
  self._mapNode.RollButton:SetActive(mapRoll and mapRoll.CanReRoll)
  self.nEventId = nEventId
  self.nSelectIdx = 0
  self.nCoin = nCoin
  NovaAPI.SetTMPText(self._mapNode.txtRollCostCount, orderedFormat(ConfigTable.GetUIText("Vampire_FateCard_RerollCount") or "", mapRoll.ReRollPrice))
  self._mapNode.goCoin.gameObject:SetActive(mapRoll.CanReRoll)
  self.mapRoll = mapRoll
  self:RefreshFateCardList(tbFateCard, bAfterRoll, bReward)
  if bReward then
    self.nSelectIdx = 1
    self:SelectScroll(self.nSelectIdx)
    for i, nCount in ipairs(self.tbCount) do
      self._mapNode.pkgInfo[i]:SetPackageAddMarket(false)
      self._mapNode.pkgInfo[i]:SetPackageCount(nCount)
    end
    local mapBundleInfo = {}
    for _, mapFateCard in ipairs(self.tbFateCardList) do
      local nFateCardId = mapFateCard.Id
      local nBundleIdx, bEx = self:GetFateCardBundleIdx(nFateCardId)
      if mapBundleInfo[nBundleIdx] == nil then
        mapBundleInfo[nBundleIdx] = {nCount = 0, nExCount = 0}
      end
      if bEx then
        mapBundleInfo[nBundleIdx].nExCount = mapBundleInfo[nBundleIdx].nExCount + 1
      else
        mapBundleInfo[nBundleIdx].nCount = mapBundleInfo[nBundleIdx].nCount + 1
      end
    end
    for nBundleIdx, mapCount in pairs(mapBundleInfo) do
      if 0 < mapCount.nCount then
        self._mapNode.pkgInfo[nBundleIdx]:SetPackageAddMarket(true)
        self._mapNode.pkgInfo[nBundleIdx]:SetPackageCount(self.tbCount[nBundleIdx] + mapCount.nCount)
      end
      if 0 < mapCount.nExCount then
        for i = 1, mapCount.nExCount do
          self._mapNode.pkgInfo[nBundleIdx]:SetPackageExAdd(self.tbExCount[nBundleIdx] + i)
        end
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtTitle, bReward and ConfigTable.GetUIText("FateCard_Select_RewardTitle") or ConfigTable.GetUIText("FateCard_Select_Title"))
  local tbConfig = {}
  if bReward then
    tbConfig = {
      {
        sAction = "Confirm",
        sLang = "ActionBar_Confirm"
      },
      {
        sAction = "Scroll",
        sLang = "ActionBar_Scroll"
      }
    }
  elseif mapRoll and mapRoll.CanReRoll then
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
      }
    }
  end
  self._mapNode.ActionBar:InitActionBar(tbConfig)
  if bReward then
    self:StartAutoSelectCountDown()
  end
end

function VampireFateCardSelect:RefreshFateCardList(tbFateCard, bAfterRoll, bReward)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self.tbFateCardList = clone(tbFateCard)
  self.tbRecommend = {}
  if not bReward then
    local curPackage = 0
    local tbRecommend = {}
    for index, mapFateCardInfo in ipairs(tbFateCard) do
      local nIdx, bEx = self:GetFateCardBundleIdx(mapFateCardInfo.Id)
      if not bEx then
        if curPackage == 0 then
          curPackage = nIdx
          table.insert(tbRecommend, index)
        elseif nIdx == 1 then
          if curPackage == 1 then
            table.insert(tbRecommend, index)
          end
        elseif nIdx ~= 1 and curPackage == 1 or self.tbCount[curPackage] < self.tbCount[nIdx] then
          tbRecommend = {}
          curPackage = nIdx
          table.insert(tbRecommend, index)
        elseif self.tbCount[curPackage] == self.tbCount[nIdx] then
          table.insert(tbRecommend, index)
        end
      end
    end
    if 0 < #tbRecommend then
      local random = math.random(1, #tbRecommend)
      table.insert(self.tbRecommend, tbRecommend[random])
    end
  end
  local tbCardObj, tbBtnObj = {}, {}
  for k, v in ipairs(self._mapNode.goFateCardItem) do
    v.gameObject:SetActive(false)
    self._mapNode.btnFateCard[k].gameObject:SetActive(self.tbFateCardList[k] ~= nil)
    if self.tbFateCardList[k] ~= nil then
      local bNew = self.tbFateCardList[k].New
      v:SetFateCardItem(self.tbFateCardList[k].Id, bNew)
      v:SetRecommend(0 < table.indexof(self.tbRecommend, k))
      v:ChangeWordRaycast(false)
      table.insert(tbCardObj, v)
      table.insert(tbBtnObj, self._mapNode.btnFateCard[k])
    end
  end
  if not bReward then
    self:ResetSelect(tbBtnObj, "VampireFateCard_in")
    local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
      "VampireFateCard_in"
    })
    self._mapNode.animCtrl:Play("VampireFateCard_in")
    EventManager.Hit(EventId.TemporaryBlockInput, animTime)
  end
  WwiseAudioMgr:PlaySound("ui_roguelike_itemCard")
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

function VampireFateCardSelect:SelectComplete(nEventId, tbFateCard, mapRoll, nCoin, bReward)
  if nEventId == nil or nEventId == 0 then
    EventManager.Hit(EventId.BlockInput, true)
    self._mapNode.blurBg.gameObject:SetActive(false)
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    local nIdx, bEx = self:GetFateCardBundleIdx(self.tbFateCardList[self.nSelectIdx].Id)
    CS.GameCameraStackManager.Instance:OpenMainCamera()
    local bSelect = false
    for k, v in ipairs(self._mapNode.goFateCardItem) do
      if k == self.nSelectIdx then
        bSelect = true
        local animCtrl = v.gameObject:GetComponent("Animator")
        animCtrl:Play("tc_newperk_card_out")
        local fxRoot = v.gameObject.transform:Find("FX")
        local fx = v.gameObject.transform:Find("FX/glow")
        if bEx then
          self._mapNode.pkgInfo[nIdx]:PlayAnimIn(self.tbExCount[nIdx])
        end
        
        local function OutAnimFinish()
          local beginPos = fxRoot.transform.position
          local controlPos = Vector3(3, 5, 0)
          local endPos = self._mapNode.depotPoint.transform.position
          
          local function wait()
            WwiseAudioMgr:PlaySound("ui_roguelike_card_flyby")
            if bEx then
              self._mapNode.animCtrl:Play("VampireFateCard_out1")
            else
              self._mapNode.animCtrl:Play("VampireFateCard_out2")
            end
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
            fx.gameObject:SetActive(false)
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
    if not bSelect then
      do
        local nAnimLen = 1
        self:AddTimer(1, nAnimLen, function()
          EventManager.Hit(EventId.BlockInput, false)
          self:HidePanel()
          if nil ~= self.callback then
            self.callback(-1, nEventId)
          end
        end, true, true, true, nil)
      end
    end
  else
    self:Refresh(nEventId, tbFateCard, mapRoll, nCoin, bReward)
    if bReward then
      self._mapNode.animCtrl:SetBool("standby1", false)
      self._mapNode.animCtrl:SetBool("standby2", false)
      local _, bEx = self:GetFateCardBundleIdx(tbFateCard[1].Id)
      if bEx then
        self._mapNode.animCtrl:SetBool("standby1", true)
      else
        self._mapNode.animCtrl:SetBool("standby2", true)
      end
      self._mapNode.animCtrl:Play("VampireFateCard_in1")
    end
  end
end

function VampireFateCardSelect:MoveConfirmButton(btnCard)
  local rtBtn = btnCard:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.localPosition = Vector3(rtBtn.localPosition.x + 39, self.btnConfirmPosY, 0)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function VampireFateCardSelect:HidePanel()
  self.bOpen = false
  self:StopAutoSelectCountDown()
  PanelManager.InputEnable()
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.contentRoot, 0)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nInitSortingOrder)
  GamepadUIManager.DisableGamepadUI("VampireFateCardSelect")
end

function VampireFateCardSelect:Awake()
  self.bOpen = false
  self.bProcessing = false
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.localPosition.y
  self.bOpenDepot = false
  self._mapNode.contentRoot.gameObject:SetActive(false)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.contentRoot, 0)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self.nAutoTime = ConfigTable.GetConfigNumber("VampireAutoSelectFateCardTime")
  self.nAutoRemainTime = 0
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.nCoin = 0
end

function VampireFateCardSelect:OnEnable()
  self:LoadAutoSelectState()
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnFateCard) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_FateCardItem, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
  local nLevelId = self._panel.nLevelId
  local mapLevelCfgData = ConfigTable.GetData("VampireSurvivor", nLevelId)
  if mapLevelCfgData ~= nil then
    if mapLevelCfgData.Type == GameEnum.vampireSurvivorType.Turn then
      local nSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
      local mapSeason = ConfigTable.GetData("VampireRankSeason", nSeasonId)
      if mapSeason ~= nil then
        self.tbBundle = clone(mapSeason.FateCardBundle)
        self.tbExFateCard = decodeJson(mapSeason.SpeciaFateCard)
        if self.tbExFateCard == nil then
          self.tbExFateCard = {}
        end
      end
    else
      self.tbBundle = clone(mapLevelCfgData.FateCardBundle)
      self.tbExFateCard = decodeJson(mapLevelCfgData.SpeciaFateCard)
      if self.tbExFateCard == nil then
        self.tbExFateCard = {}
      end
    end
  end
  for i = 1, 5 do
    if self.tbBundle[i] ~= nil then
      self._mapNode.pkgInfo[i].gameObject:SetActive(true)
      self._mapNode.pkgInfo[i]:InitPackage(self.tbBundle[i])
    else
      self._mapNode.pkgInfo[i].gameObject:SetActive(false)
    end
  end
end

function VampireFateCardSelect:OnDisable()
  self:StopAutoSelectCountDown()
  for k, v in ipairs(self._mapNode.btnFateCard) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function VampireFateCardSelect:OnBtnClick_Confirm()
  if self.bProcessing == true then
    return
  end
  self:StopAutoSelectCountDown()
  if nil ~= self.callback then
    self.bProcessing = true
    
    local function completeFunc(nEventId, tbFateCard, mapRoll, nCoin, bReward, mapCurFateCard)
      EventManager.Hit(EventId.BlockInput, false)
      self.tbCount = {
        0,
        0,
        0,
        0,
        0
      }
      self.tbExCount = {
        0,
        0,
        0,
        0,
        0
      }
      for nFateCardId, _ in pairs(mapCurFateCard) do
        local nIdx, bEx = self:GetFateCardBundleIdx(nFateCardId)
        if bEx then
          self.tbExCount[nIdx] = self.tbExCount[nIdx] + 1
        else
          self.tbCount[nIdx] = self.tbCount[nIdx] + 1
        end
      end
      for i = 1, 5 do
        self._mapNode.pkgInfo[i]:SetPackageCount(self.tbCount[i])
        self._mapNode.pkgInfo[i]:SetPackageExCount(self.tbExCount[i])
        self._mapNode.pkgInfo[i]:SetPackageAddMarket(false)
      end
      self._mapNode.imgGlory:SetActive(false)
      self:SelectComplete(nEventId, tbFateCard, mapRoll, nCoin, bReward)
      self.bProcessing = false
    end
    
    EventManager.Hit(EventId.BlockInput, true)
    self.callback(self.nSelectIdx, self.nEventId, completeFunc, false, self.bReward)
  end
end

function VampireFateCardSelect:OnBtnClick_Roll()
  if not self.callback then
    return
  end
  if self.bProcessing == true then
    return
  end
  self:InterruptAutoSelect()
  self.bProcessing = true
  
  local function completeFunc(nEventId, tbFateCard, mapRoll, nCoin, bReward, mapCurFateCard)
    EventManager.Hit(EventId.BlockInput, false)
    self.tbCount = {
      0,
      0,
      0,
      0,
      0
    }
    self.tbExCount = {
      0,
      0,
      0,
      0,
      0
    }
    for nFateCardId, _ in pairs(mapCurFateCard) do
      local nIdx, bEx = self:GetFateCardBundleIdx(nFateCardId)
      if bEx then
        self.tbExCount[nIdx] = self.tbExCount[nIdx] + 1
      else
        self.tbCount[nIdx] = self.tbCount[nIdx] + 1
      end
    end
    for i = 1, 5 do
      self._mapNode.pkgInfo[i]:SetPackageCount(self.tbCount[i])
      self._mapNode.pkgInfo[i]:SetPackageExCount(self.tbExCount[i])
      self._mapNode.pkgInfo[i]:SetPackageAddMarket(false)
    end
    self:Refresh(nEventId, tbFateCard, mapRoll, nCoin, bReward, true)
    self.bProcessing = false
  end
  
  EventManager.Hit(EventId.BlockInput, true)
  self.callback(self.nSelectIdx, self.nEventId, completeFunc, true)
end

function VampireFateCardSelect:OnBtnClick_Abandon()
  self:StopAutoSelectCountDown()
  
  local function confirm()
    if nil ~= self.callback then
      self.nSelectIdx = 0
      
      local function abandonFunc(nEventId, tbFateCard)
        self:SelectComplete(nEventId, tbFateCard)
      end
      
      self.callback(1000, self.nEventId, abandonFunc)
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
    
    local function cancelCallback()
      self:StartAutoSelectCountDown()
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = orderedFormat(ConfigTable.GetUIText("FateCard_AbandonTip")),
      callbackConfirm = confirmCallback,
      callbackAgain = againCallback,
      callbackCancel = cancelCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

function VampireFateCardSelect:OnBtnSelect_FateCardItem(btn, nIndex)
  if self.bReward == true then
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse or self.bRecommended then
    self:OnBtnClick_FateCardItem(btn, nIndex)
  end
end

function VampireFateCardSelect:OnBtnClick_FateCardItem(btn, nIndex, bAutoSelect)
  if self.bReward == true then
    return
  end
  if nil == self.tbFateCardList[nIndex] or self.nSelectIdx == nIndex then
    return
  end
  if bAutoSelect ~= true then
    self:InterruptAutoSelect()
  end
  for i, nCount in ipairs(self.tbCount) do
    self._mapNode.pkgInfo[i]:SetPackageAddMarket(false)
    self._mapNode.pkgInfo[i]:SetPackageCount(nCount)
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
  local mapFatecardInfo = self.tbFateCardList[nIndex]
  local nBundleIdx, bEx = self:GetFateCardBundleIdx(mapFatecardInfo.Id)
  if bEx then
    self._mapNode.pkgInfo[nBundleIdx]:SetPackageExAdd(self.tbExCount[nBundleIdx] + 1)
  else
    self._mapNode.pkgInfo[nBundleIdx]:SetPackageAddMarket(true)
    self._mapNode.pkgInfo[nBundleIdx]:SetPackageCount(self.tbCount[nBundleIdx] + 1)
  end
  self:SelectScroll(nIndex)
  self.nSelectIdx = nIndex
end

function VampireFateCardSelect:OnBtnClick_Depot()
  self.bOpenDepot = true
  self:InterruptAutoSelect()
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.contentRoot, 0)
  self._mapNode.blurBg.gameObject:SetActive(false)
  EventManager.Hit("BattleDepot")
end

function VampireFateCardSelect:OnEvent_SelectFateCard(nEventId, tbFateCard, callback, mapRoll, nCoin, bReward, mapCurFateCard)
  self._panel:SetTop(self.canvas)
  self.callback = callback
  local bClosePanel = false
  if not self.bOpen then
    PanelManager.InputDisable()
    bClosePanel = true
    GamepadUIManager.EnableGamepadUI("VampireFateCardSelect", self.tbGamepadUINode)
  end
  self.bOpen = true
  self.bReward = bReward
  self.tbCount = {
    0,
    0,
    0,
    0,
    0
  }
  self.tbExCount = {
    0,
    0,
    0,
    0,
    0
  }
  for nFateCardId, _ in pairs(mapCurFateCard) do
    local nIdx, bEx = self:GetFateCardBundleIdx(nFateCardId)
    if bEx then
      self.tbExCount[nIdx] = self.tbExCount[nIdx] + 1
    else
      self.tbCount[nIdx] = self.tbCount[nIdx] + 1
    end
  end
  for i = 1, 5 do
    self._mapNode.pkgInfo[i]:SetPackageCount(self.tbCount[i])
    self._mapNode.pkgInfo[i]:SetPackageExCount(self.tbExCount[i])
    self._mapNode.pkgInfo[i]:SetPackageAddMarket(false)
  end
  self.nSelectIdx = 0
  self.tbFateCardList = {}
  self._mapNode.contentRoot.gameObject:SetActive(true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.contentRoot, 0)
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
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.contentRoot, 1)
    if bReward then
      self.bInEnd = false
      self.bAnimEx = nil
      if #tbFateCard == 0 then
        self._mapNode.animCtrl:SetBool("standby1", false)
        self._mapNode.animCtrl:SetBool("standby2", false)
        self._mapNode.animCtrl:Play("VampireFateCard_in1")
        WwiseAudioMgr:PlaySound("ui_vampire_chest_start")
        
        local function waitIn()
          self.bInEnd = true
          if self.bAnimEx == nil then
            return
          end
          local sEvent = self.bAnimEx and "ui_vampire_chest_special" or "ui_vampire_chest_normal"
          WwiseAudioMgr:PlaySound(sEvent)
        end
        
        self:AddTimer(1, 0.6, waitIn, true, true, true, nil)
      else
        local _, bEx = self:GetFateCardBundleIdx(tbFateCard[1].Id)
        self:Refresh(nEventId, tbFateCard, mapRoll, nCoin, bReward)
        if bEx then
          self._mapNode.animCtrl:SetBool("standby1", true)
        else
          self._mapNode.animCtrl:SetBool("standby2", true)
        end
        if self.bInEnd then
          local sEvent = bEx and "ui_vampire_chest_special" or "ui_vampire_chest_normal"
          WwiseAudioMgr:PlaySound(sEvent)
        else
          self.bAnimEx = bEx
        end
      end
    else
      self:Refresh(nEventId, tbFateCard, mapRoll, nCoin, bReward)
      local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
        "VampireFateCard_in"
      })
      self._mapNode.animCtrl:Play("VampireFateCard_in")
      EventManager.Hit(EventId.TemporaryBlockInput, animTime)
    end
  end
  
  cs_coroutine.start(wait)
end

function VampireFateCardSelect:OnEvent_CloseStarTowerDepot()
  if self.bOpenDepot then
    self.bOpenDepot = false
    self._mapNode.blurBg.gameObject:SetActive(true)
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
    GamepadUIManager.SetSelectedUI(self._mapNode.btnFateCard[nSelect].gameObject)
    EventManager.Hit(EventId.BlockInput, true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.BlockInput, false)
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
      self._mapNode.contentRoot.gameObject:SetActive(true)
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.contentRoot, 1)
      if self.bReward then
        self._mapNode.animCtrl:Play("VampireFateCard_out")
      else
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
    end
    
    cs_coroutine.start(wait)
  end
end

function VampireFateCardSelect:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "VampireFateCardSelect" then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
    GamepadUIManager.ClearSelectedUI()
    GamepadUIManager.SetSelectedUI(self._mapNode.btnFateCard[nSelect].gameObject)
  end
end

function VampireFateCardSelect:OnEvent_Reopen(sName)
  if sName ~= "VampireFateCardSelect" then
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

function VampireFateCardSelect:OnEvent_VampireRewardChestFailed()
  EventManager.Hit(EventId.BlockInput, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self:HidePanel()
  if nil ~= self.callback then
    self.callback(-1, 1)
  end
end

function VampireFateCardSelect:OnEvent_VampireLevelRewardFailed()
  EventManager.Hit(EventId.BlockInput, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self:HidePanel()
  if nil ~= self.callback then
    self.callback(-2, 1)
  end
end

function VampireFateCardSelect:ResetSelect(tbUI, sAnimName)
  self.nSelectIdx = 0
  self.bRecommended = false
  self:StopAutoSelectCountDown()
  self:ResetAutoSelectTime()
  GamepadUIManager.SetNavigation(tbUI)
  local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {sAnimName}) + 0.1
  self:AddTimer(1, animTime, function()
    if self.nSelectIdx == 0 then
      if self.bAutoSelect == true then
        self:DoAutoSelect()
      else
        GamepadUIManager.ClearSelectedUI()
        GamepadUIManager.SetSelectedUI(self._mapNode.btnFateCard[1].gameObject)
        self.bRecommended = true
        if GamepadUIManager.GetCurUIType() == AllEnum.GamepadUIType.Mouse then
          self:OnBtnClick_FateCardItem(self._mapNode.btnFateCard[1].gameObject, 1)
        end
      end
    end
    self:StartAutoSelectCountDown()
  end, true, true, true)
end

function VampireFateCardSelect:GetAutoSelectIndex()
  local nIndex = self.tbRecommend ~= nil and self.tbRecommend[1] or nil
  if nIndex == nil or self.tbFateCardList[nIndex] == nil then
    nIndex = 1
  end
  return nIndex
end

function VampireFateCardSelect:StartAutoSelectCountDown()
  self:StopAutoSelectCountDown()
  if self.bAutoSelect ~= true or self.bOpenDepot == true then
    return
  end
  if type(self.nAutoTime) ~= "number" or self.nAutoTime <= 0 then
    return
  end
  self:ResetAutoSelectTime()
  
  local function countdown()
    self.nAutoRemainTime = self.nAutoRemainTime - 1
    self:RefreshAutoSelectTime()
    if self.nAutoRemainTime <= 0 then
      self:StopAutoSelectCountDown()
      self:OnAutoSelectTimeEnd()
    end
  end
  
  self.autoSelectTimer = self:AddTimer(0, 1, countdown, true, true, true)
end

function VampireFateCardSelect:StopAutoSelectCountDown()
  if self.autoSelectTimer ~= nil then
    self.autoSelectTimer:Cancel()
    self.autoSelectTimer = nil
  end
end

function VampireFateCardSelect:DoAutoSelect()
  local nAutoIdx = self:GetAutoSelectIndex()
  self.bAutoSelecting = true
  GamepadUIManager.ClearSelectedUI()
  GamepadUIManager.SetSelectedUI(self._mapNode.btnFateCard[nAutoIdx].gameObject)
  self.bRecommended = true
  self:OnBtnClick_FateCardItem(self._mapNode.btnFateCard[nAutoIdx].gameObject, nAutoIdx, true)
  self.bAutoSelecting = false
end

function VampireFateCardSelect:InterruptAutoSelect()
  if self.bAutoSelecting == true then
    return
  end
  if self.bAutoSelect ~= true then
    self:StopAutoSelectCountDown()
    return
  end
  self:SetAutoSelectState(false, true)
end

function VampireFateCardSelect:CheckAutoSelectUnlock()
  local tbHardUnlock = PlayerData.VampireSurvivor:GetHardUnlock()
  return tbHardUnlock ~= nil and tbHardUnlock[2] == true
end

function VampireFateCardSelect:LoadAutoSelectState()
  self.bAutoSelectUnlock = self:CheckAutoSelectUnlock()
  if not self.bAutoSelectUnlock then
    self:SetAutoSelectState(false, false)
    return
  end
  local sData = LocalData.GetPlayerLocalData(sAutoSelectKey)
  local nState = tonumber(sData == nil and "0" or sData)
  self:SetAutoSelectState(nState == 1, false)
end

function VampireFateCardSelect:SetAutoSelectState(bOpen, bSave)
  self.bAutoSelect = bOpen == true
  if self.bAutoSelect then
    self._mapNode.btnAutoSelectClose.gameObject:SetActive(false)
    self._mapNode.btnAutoSelectOpen.gameObject:SetActive(true)
  else
    self._mapNode.btnAutoSelectOpen.gameObject:SetActive(false)
    self._mapNode.btnAutoSelectClose.gameObject:SetActive(true)
  end
  if bSave == true then
    LocalData.SetPlayerLocalData(sAutoSelectKey, self.bAutoSelect and 1 or 0)
  end
  if not self.bAutoSelect then
    self:StopAutoSelectCountDown()
    self:ResetAutoSelectTime()
  end
end

function VampireFateCardSelect:OnClick_AutoSelectOpen()
  self:SetAutoSelectState(false, true)
end

function VampireFateCardSelect:OnClick_AutoSelectClose()
  if self.bAutoSelectUnlock ~= true then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Vampire_Tips_AutoSelectLock"))
    return
  end
  self:SetAutoSelectState(true, true)
  if self.bReward ~= true and self.nSelectIdx == 0 and self.tbFateCardList ~= nil and 0 < #self.tbFateCardList then
    self:DoAutoSelect()
  end
  self:StartAutoSelectCountDown()
end

function VampireFateCardSelect:ResetAutoSelectTime()
  self.nAutoRemainTime = type(self.nAutoTime) == "number" and math.ceil(self.nAutoTime) or 0
  self:RefreshAutoSelectTime()
end

function VampireFateCardSelect:RefreshAutoSelectTime()
  local nTime = self.nAutoRemainTime or 0
  if nTime < 0 then
    nTime = 0
  end
  local sTime = string.format("%02d:%02d", math.floor(nTime / 60), nTime % 60)
  for _, txtNum in ipairs(self._mapNode.txtBtnAutoSelectNum) do
    NovaAPI.SetTMPText(txtNum, sTime)
  end
end

function VampireFateCardSelect:OnAutoSelectTimeEnd()
  if not self.bOpen or self.bProcessing == true or self.bOpenDepot == true then
    return
  end
  if self.nSelectIdx == 0 or self.tbFateCardList[self.nSelectIdx] == nil then
    return
  end
  self:OnBtnClick_Confirm()
end

function VampireFateCardSelect:SelectScroll(nIndex)
  for _, v in ipairs(self._mapNode.goFateCardItem) do
    v:SetGamePadScrollEnable(false)
  end
  if nIndex then
    self._mapNode.goFateCardItem[nIndex]:SetGamePadScrollEnable(true)
  end
end

function VampireFateCardSelect:GetFateCardBundleIdx(nFateCardId)
  local mapCfgData = ConfigTable.GetData("StarTowerBookFateCard", nFateCardId)
  if mapCfgData == nil then
    printError("no StarTowerBookFateCard Data:" .. nFateCardId)
    return 1, false
  end
  local nBundleId = mapCfgData.BundleId
  local nIdx = table.indexof(self.tbBundle, nBundleId)
  if 0 < nIdx then
    return nIdx, false
  end
  for i, tbExFateCard in ipairs(self.tbExFateCard) do
    if table.indexof(tbExFateCard, nFateCardId) > 0 then
      return i, true
    end
  end
  printError("命运卡不在当前关卡卡包中:" .. nFateCardId)
  return 1, false
end

return VampireFateCardSelect

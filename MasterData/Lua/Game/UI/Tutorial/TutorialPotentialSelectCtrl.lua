local TutorialPotentialSelectCtrl = class("TutorialPotentialSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TutorialPotentialSelectCtrl._mapNodeConfig = {
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
    sCtrlName = "Game.UI.Tutorial.TutorialPotentialCardItemCtrl"
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
TutorialPotentialSelectCtrl._mapEventConfig = {
  Tutorial_PotentialSelect = "OnEvent_TutorialPotentialSelect",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen"
}
TutorialPotentialSelectCtrl._mapRedDotConfig = {}

function TutorialPotentialSelectCtrl:Refresh(tbPotential)
  if tbPotential == nil or #tbPotential == 0 then
    traceback("潜能卡选择列表为空！！！")
    return
  end
  self.nSelectIdx = 0
  self._mapNode.imgUpgradeTitle.gameObject:SetActive(false)
  self._mapNode.imgSelectTitle.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, ConfigTable.GetUIText("StarTower_Potential_Select_Title_1"))
  self._mapNode.RollButton:SetActive(false)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self:RefreshPotentialList(tbPotential)
  self:SetSimpleState()
  self:PlayCharVoice(tbPotential)
  local tbConfig = {}
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
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function TutorialPotentialSelectCtrl:RefreshPotentialList(tbPotential)
  self.bSpecialPotential = false
  self.tbPotential = tbPotential
  local tbCardObj, tbBtnObj = {}, {}
  for k, v in ipairs(self._mapNode.potentialCard) do
    v.gameObject:SetActive(false)
    self._mapNode.btnPotential[k].gameObject:SetActive(self.tbPotential[k] ~= nil)
    if self.tbPotential[k] ~= nil then
      local nTid = self.tbPotential[k]
      local potentialCfg = ConfigTable.GetData("Potential", nTid)
      if nil ~= potentialCfg then
        local bSpecial = v:SetPotentialItem(nTid, self.bSimple, true, AllEnum.PotentialCardType.StarTower, 1, 1, 0)
        v:ChangeWordRaycast(false)
        table.insert(tbCardObj, v)
        table.insert(tbBtnObj, self._mapNode.btnPotential[k])
        self.bSpecialPotential = self.bSpecialPotential or bSpecial
      end
    end
  end
  self:ResetSelect(tbBtnObj)
  local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
    "PotentialSelectPanel_in"
  })
  EventManager.Hit(EventId.TemporaryBlockInput, animTime)
  WwiseAudioMgr:PlaySound("ui_roguelike_xintiao_select")
  if 0 < #tbCardObj then
    local function wait()
      local frameCount = 0
      
      while 0 < #tbCardObj do
        if 4 <= frameCount then
          local cardObj = table.remove(tbCardObj, 1)
          if cardObj ~= nil then
            cardObj.gameObject:SetActive(true)
            cardObj:PlayAnim("tc_newperk_card_in")
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

function TutorialPotentialSelectCtrl:SetSimpleState()
  self._mapNode.goOff.gameObject:SetActive(not self.bSimple)
  self._mapNode.goOpen.gameObject:SetActive(self.bSimple)
end

function TutorialPotentialSelectCtrl:PlayCharVoice(tbPotential)
  local nCharId = 0
  for k, v in ipairs(tbPotential) do
    local potentialCfg = ConfigTable.GetData("Potential", v)
    if nil == potentialCfg then
      printError(string.format("获取潜能表配置失败！！！id = [%s])", v))
      return
    end
    nCharId = potentialCfg.CharId
    break
  end
  local sVoiceKey = "perk"
  PlayerData.Voice:PlayCharVoice(sVoiceKey, nCharId)
end

function TutorialPotentialSelectCtrl:SelectComplete()
  if self.bSkip then
    self:HidePanel()
    if nil ~= self.callback then
      self.callback(self.nSelectIdx)
    end
    return
  end
  EventManager.Hit(EventId.BlockInput, true)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.menuBg.gameObject:SetActive(true)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  EventManager.Hit("StarTowerSetButtonEnable", true, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  for k, v in ipairs(self._mapNode.potentialCard) do
    if k == self.nSelectIdx then
      local animCtrl = v.gameObject:GetComponent("Animator")
      animCtrl:Play("tc_newperk_card_out")
      local fxRoot = v.gameObject.transform:Find("FX")
      local fx = v.gameObject.transform:Find("FX/glow")
      
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
            normalizedTime = moveTime / totalMoveTime
            normalizedTime = normalizedTime <= 1 and normalizedTime or 1
            local x, y, z = UTILS.GetBezierPointByT(beginPos, controlPos, endPos, normalizedTime)
            local angleZ = 100 * normalizedTime * 2
            angleZ = angleZ <= 100 and angleZ or 100
            fxRoot.transform.localEulerAngles = Vector3(0, 0, angleZ)
            fxRoot.transform.position = Vector3(x, y, z)
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          end
          self._mapNode.cardFinishParticle:SetActive(true)
          fx.gameObject:SetActive(false)
          coroutine.yield(CS.UnityEngine.WaitForSecondsRealtime(0.5))
          EventManager.Hit(EventId.BlockInput, false)
          self:HidePanel()
          fxRoot.transform.position = beginPos
          fxRoot.transform.localEulerAngles = Vector3(0, 0, 0)
          fx.gameObject:SetActive(true)
          if nil ~= self.callback then
            self.callback(self.nSelectIdx)
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
  EventManager.Hit("Guide_Potential_SelectComplete")
end

function TutorialPotentialSelectCtrl:MoveConfirmButton(btnCard)
  local rtBtn = btnCard:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.localPosition = Vector3(rtBtn.localPosition.x, self.btnConfirmPosY, 0)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function TutorialPotentialSelectCtrl:HidePanel()
  self.bOpen = false
  if not self.bSkip then
    PanelManager.InputEnable()
    EventManager.Hit("StarTowerSetButtonEnable", true, true)
  end
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nInitSortingOrder)
  GamepadUIManager.DisableGamepadUI("TutorialPotentialSelectCtrl")
end

function TutorialPotentialSelectCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.localPosition.y
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.menuBg.gameObject:SetActive(false)
  self._mapNode.btnDepot.gameObject:SetActive(false)
  self._mapNode.imgCoinBg.gameObject:SetActive(false)
  self._mapNode.txtCloseTips.gameObject:SetActive(false)
  self._mapNode.btnMask.gameObject:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function TutorialPotentialSelectCtrl:OnEnable()
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnPotential) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_PotentialItem, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
  self._mapNode.btnDepot.gameObject:SetActive(false)
end

function TutorialPotentialSelectCtrl:OnDisable()
  for k, v in ipairs(self._mapNode.btnPotential) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function TutorialPotentialSelectCtrl:OnBtnClick_Depot()
end

function TutorialPotentialSelectCtrl:OnBtnClick_ChangeDesc()
  self.bSimple = not self.bSimple
  PlayerData.StarTower:SetPotentialDescSimple(self.bSimple)
  self:SetSimpleState()
  for _, v in ipairs(self._mapNode.potentialCard) do
    v:ChangeDesc(self.bSimple)
  end
end

function TutorialPotentialSelectCtrl:OnBtnClick_Confirm()
  self:SelectComplete()
end

function TutorialPotentialSelectCtrl:OnBtnClick_Roll()
end

function TutorialPotentialSelectCtrl:OnBtnSelect_PotentialItem(btn, nIndex)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
    self:OnBtnClick_PotentialItem(btn, nIndex)
  end
end

function TutorialPotentialSelectCtrl:OnBtnClick_PotentialItem(btn, nIndex)
  if nil == self.tbPotential[nIndex] or self.nSelectIdx == nIndex then
    return
  end
  WwiseAudioMgr:PlaySound("ui_roguelike_xintiao_slide")
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

function TutorialPotentialSelectCtrl:OnEvent_TutorialPotentialSelect(tbPotential, callback)
  self.callback = callback
  if tbPotential == nil or #tbPotential == 0 then
    traceback("潜能卡选择列表为空！！！")
    return
  end
  self._panel:SetTop(self.canvas)
  self.bSkip = false
  local bCloseCamera = false
  if not self.bOpen then
    PanelManager.InputDisable()
    EventManager.Hit("StarTowerSetButtonEnable", false, false)
    bCloseCamera = true
    GamepadUIManager.EnableGamepadUI("TutorialPotentialSelectCtrl", self.tbGamepadUINode)
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
    self:Refresh(tbPotential)
  end
  
  cs_coroutine.start(wait)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self.nSelectIdx = 0
  self.bSimple = PlayerData.StarTower:GetPotentialDescSimple()
end

function TutorialPotentialSelectCtrl:OnEvent_CloseStarTowerDepot()
  if self.bOpenDepot then
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
      for k, v in ipairs(self._mapNode.potentialCard) do
        v:CloseBgEffect()
      end
      if self.nSelectIdx == 0 and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other then
        self.nSelectIdx = 1
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

function TutorialPotentialSelectCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "TutorialPotentialSelectCtrl" then
    return
  end
  if self.nSelectIdx == 0 then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    GamepadUIManager.ClearSelectedUI()
    GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[self.nSelectIdx].gameObject)
  end
end

function TutorialPotentialSelectCtrl:OnEvent_Reopen(sName)
  if sName ~= "TutorialPotentialSelectCtrl" then
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
    GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[self.nSelectIdx].gameObject)
    self._mapNode.potentialCard[self.nSelectIdx]:ChangeWordRaycast(true)
    self:SelectScroll(self.nSelectIdx)
  end
end

function TutorialPotentialSelectCtrl:ResetSelect(tbUI)
  self.nSelectIdx = 0
  GamepadUIManager.SetNavigation(tbUI)
  local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
    "PotentialSelectPanel_in"
  }) + 0.1
  self:AddTimer(1, animTime, function()
    if self.nSelectIdx == 0 then
      local nSelect = 1
      GamepadUIManager.ClearSelectedUI()
      GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[nSelect].gameObject)
      if GamepadUIManager.GetCurUIType() == AllEnum.GamepadUIType.Mouse then
        self:OnBtnClick_PotentialItem(self._mapNode.btnPotential[nSelect].gameObject, nSelect)
      end
    end
    if self.bSpecialPotential then
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PotentialSelectSpecial_Tutorial")
    else
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_PotentialSelect_Tutorial")
    end
  end, true, true, true)
end

function TutorialPotentialSelectCtrl:SelectScroll(nIndex)
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

return TutorialPotentialSelectCtrl

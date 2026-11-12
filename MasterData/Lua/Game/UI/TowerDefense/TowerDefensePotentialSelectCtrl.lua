local TowerDefensePotentialSelectCtrl = class("TowerDefensePotentialSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TowerDefensePotentialSelectCtrl._mapNodeConfig = {
  blurBg = {},
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animCtrl = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  },
  btnMask = {},
  imgUpgradeTitle = {},
  txtUpgrade = {sComponentName = "TMP_Text"},
  btnPotential = {
    sComponentName = "NaviButton",
    nCount = 2,
    callback = "OnBtnClick_PotentialItem"
  },
  rtBtnPotential = {
    sNodeName = "btnPotential",
    sComponentName = "RectTransform",
    nCount = 2
  },
  potentialCard = {
    nCount = 2,
    sCtrlName = "Game.UI.TowerDefense.TowerDefensePotentialCardItemCtrl"
  },
  ScrollView = {
    nCount = 2,
    sComponentName = "GamepadScroll"
  },
  SpScrollView = {
    nCount = 2,
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
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  }
}
TowerDefensePotentialSelectCtrl._mapEventConfig = {
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen"
}
TowerDefensePotentialSelectCtrl._mapRedDotConfig = {}

function TowerDefensePotentialSelectCtrl:SetData(nActId)
  self.TowerDefenseData = PlayerData.Activity:GetActivityDataById(nActId)
end

function TowerDefensePotentialSelectCtrl:Refresh(nCharId, tbPotential, nLevel, callback, sTitle)
  self.nCharId = nCharId
  self.callback = callback
  local config = ConfigTable.GetData("TowerDefenseCharacter", self.nCharId)
  if config == nil then
    return
  end
  if tbPotential == nil or #tbPotential == 0 then
    return
  end
  self.nSelectIdx = 0
  if sTitle == nil then
    NovaAPI.SetTMPText(self._mapNode.txtUpgrade, orderedFormat(ConfigTable.GetUIText("TowerDef_Text_LevelUp"), config.Name, nLevel))
  else
    NovaAPI.SetTMPText(self._mapNode.txtUpgrade, sTitle)
  end
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  self:RefreshPotentialList(tbPotential)
end

function TowerDefensePotentialSelectCtrl:RefreshPotentialList(tbPotential)
  self.tbPotential = {}
  for _, v in pairs(tbPotential) do
    table.insert(self.tbPotential, v)
  end
  local tbCardObj, tbBtnObj = {}, {}
  for k, v in pairs(self._mapNode.potentialCard) do
    v.gameObject:SetActive(false)
    self._mapNode.btnPotential[k].gameObject:SetActive(self.tbPotential[k] ~= nil)
    if self.tbPotential[k] ~= nil then
      local nTid = self.tbPotential[k]
      local potentialCfg = ConfigTable.GetData("TowerDefensePotential", nTid)
      if nil ~= potentialCfg then
        v:ChangeWordRaycast(false)
        table.insert(tbCardObj, v)
        table.insert(tbBtnObj, self._mapNode.btnPotential[k])
        v:SetPotentialItem(nTid, AllEnum.PotentialCardType.TowerDefense)
      end
    end
  end
  self:ResetSelect(tbBtnObj)
  local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
    "PotentialSelectPanel_in"
  })
  EventManager.Hit(EventId.TemporaryBlockInput, animTime)
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

function TowerDefensePotentialSelectCtrl:MoveConfirmButton(btnCard)
  local rtBtn = btnCard:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.localPosition = Vector3(rtBtn.localPosition.x, self.btnConfirmPosY, 0)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function TowerDefensePotentialSelectCtrl:ShowPanel()
  self.bOpen = true
  self._mapNode.blurBg.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.contentRoot.gameObject:SetActive(true)
    local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
      "PotentialSelectPanel_in"
    })
    EventManager.Hit(EventId.TemporaryBlockInput, animTime)
    self._mapNode.animCtrl:Play("PotentialSelectPanel_in")
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
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
  GamepadUIManager.EnableGamepadUI("TowerDefensePotentialSelectCtrl", self.tbGamepadUINode)
end

function TowerDefensePotentialSelectCtrl:HidePanel()
  self.bOpen = false
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  GamepadUIManager.DisableGamepadUI("TowerDefensePotentialSelectCtrl")
end

function TowerDefensePotentialSelectCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.localPosition.y
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.btnMask.gameObject:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function TowerDefensePotentialSelectCtrl:OnEnable()
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnPotential) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_PotentialItem, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
end

function TowerDefensePotentialSelectCtrl:OnDisable()
  for k, v in ipairs(self._mapNode.btnPotential) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function TowerDefensePotentialSelectCtrl:OnBtnClick_Confirm()
  if self.nSelectIdx ~= 0 and self.callback ~= nil then
    EventManager.Hit(EventId.BlockInput, true)
    for i = 1, 2 do
      if self.nSelectIdx ~= i then
        self._mapNode.potentialCard[i].gameObject:SetActive(false)
      end
    end
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    local cardAnim = self._mapNode.potentialCard[self.nSelectIdx].gameObject:GetComponent("Animator")
    cardAnim:Play("tc_newperk_card_out1")
    WwiseAudioMgr:PostEvent("mode_TD_skill_select_fx")
    self:AddTimer(1, 0.5, function()
      local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animCtrl, {
        "PotentialSelectPanel_out"
      })
      self._mapNode.animCtrl:Play("PotentialSelectPanel_out")
      self:AddTimer(1, nAnimLen, function()
        EventManager.Hit(EventId.BlockInput, false)
        self:HidePanel()
        if nil ~= self.callback then
          self.callback(self.tbPotential[self.nSelectIdx])
        end
      end, true, true, true, nil)
    end, true, true, true, nil)
  end
end

function TowerDefensePotentialSelectCtrl:OnBtnSelect_PotentialItem(btn, nIndex)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse or self.bRecommended then
    self:OnBtnClick_PotentialItem(btn, nIndex)
  end
end

function TowerDefensePotentialSelectCtrl:OnBtnClick_PotentialItem(btn, nIndex)
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

function TowerDefensePotentialSelectCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "TowerDefensePotentialSelectCtrl" then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
    GamepadUIManager.ClearSelectedUI()
    GamepadUIManager.SetSelectedUI(self._mapNode.btnPotential[nSelect].gameObject)
  end
end

function TowerDefensePotentialSelectCtrl:OnEvent_Reopen(sName)
  if sName ~= "TowerDefensePotentialSelectCtrl" then
    return
  end
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

function TowerDefensePotentialSelectCtrl:ResetSelect(tbUI)
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
  end, true, true, true)
end

function TowerDefensePotentialSelectCtrl:SelectScroll(nIndex)
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

return TowerDefensePotentialSelectCtrl

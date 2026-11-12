local ReceivePropsCtrl = class("ReceivePropsCtrl", BaseCtrl)
local ModuleManager = require("GameCore.Module.ModuleManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ReceivePropsCtrl._mapNodeConfig = {
  goBlur = {},
  HideRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  txtTips1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  txtTips2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  btnGrid = {},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseReward"
  },
  goItemList1 = {sComponentName = "Transform"},
  goItemList2 = {},
  sv = {
    sComponentName = "LoopScrollView"
  },
  btnSkip = {
    sComponentName = "Button",
    callback = "OnBtnClick_Skip"
  },
  txtDescTip = {sComponentName = "TMP_Text"},
  Content = {
    sComponentName = "RectTransform"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_CloseReward",
    sAction = "Confirm"
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
  imgTitle1 = {},
  imgTitle2 = {},
  imgTitleHolder1 = {},
  imgTitleHolder2 = {}
}
ReceivePropsCtrl._mapEventConfig = {
  StarTowerAutoCloseReward = "OnEvent_AutoCloseReward"
}

function ReceivePropsCtrl:RefreshList()
  if self.nRewardCount <= 8 then
    self._mapNode.goItemList1.gameObject:SetActive(true)
    self._mapNode.goItemList2:SetActive(false)
    self._mapNode.btnClose.interactable = false
    self:RefreshNormal()
  else
    self._mapNode.goItemList1.gameObject:SetActive(false)
    self._mapNode.goItemList2:SetActive(true)
    self._mapNode.btnClose.interactable = false
    self:RefreshSV()
  end
end

function ReceivePropsCtrl:RefreshNormal()
  for _, v in ipairs(self.tbReward) do
    local nItemId = v.id
    local goItem = instantiate(self._mapNode.btnGrid, self._mapNode.goItemList1)
    local ctrlObj = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
    local mapCfg = ConfigTable.GetData_Item(nItemId)
    if mapCfg then
      if mapCfg.Type == GameEnum.itemType.Char then
        ctrlObj:SetChar(nItemId, v.count, nil, v.rewardType)
      else
        ctrlObj:SetItem(nItemId, mapCfg.Rarity, v.count, nil, nil, v.rewardType and v.rewardType == AllEnum.RewardType.First, v.rewardType and v.rewardType == AllEnum.RewardType.Three, true, false, false, v.rewardType and v.rewardType == AllEnum.RewardType.Extra, v.rewardType and v.rewardType == AllEnum.RewardType.Double)
        if v.rewardType == AllEnum.RewardType.Double then
          local imgExtra = goItem.transform:Find("AnimRoot/aniGrid/goItem").transform:GetChild(5):GetChild(8).gameObject
          local imgReengagement = goItem.transform:Find("AnimRoot/aniGrid/goItem").transform:GetChild(5):GetChild(9).gameObject
          imgExtra:SetActive(true)
          imgReengagement:SetActive(false)
        end
      end
    end
    local btnGrid = goItem:GetComponent("UIButton")
    btnGrid.onClick:RemoveAllListeners()
    
    local function cbSelect()
      self:OnSelectItem(nItemId, btnGrid, v.nHasCount)
      EventManager.Hit("Stop_InfinityTowerAutoNextLv")
    end
    
    btnGrid.onClick:AddListener(cbSelect)
    NovaAPI.SetCanvasGroupAlpha(goItem:GetComponent("CanvasGroup"), 0)
  end
  self:PlayNormalAni()
end

function ReceivePropsCtrl:PlayNormalAni()
  self.sequence = DOTween.Sequence()
  self.sequence:AppendInterval(0.18)
  for i = 1, self.nRewardCount do
    self.sequence:AppendCallback(function()
      local goGrid = self._mapNode.goItemList1:GetChild(i - 1)
      if goGrid then
        NovaAPI.SetCanvasGroupAlpha(goGrid:GetComponent("CanvasGroup"), 1)
        local ani = goGrid.transform:Find("AnimRoot/aniGrid"):GetComponent("Animator")
        ani:Play("receiveprops_icon_t_in")
      end
    end)
    self.sequence:AppendInterval(0.14)
  end
  self.sequence.onComplete = dotween_callback_handler(self, function()
    self:CloseSkip()
  end)
  self.sequence:SetUpdate(true)
end

function ReceivePropsCtrl:RefreshSV()
  self.tbState = {}
  self._mapNode.sv:Init(self.nRewardCount, self, self.OnGridRefresh, self.OnGridBtnClick)
  self:PlaySVAni()
end

function ReceivePropsCtrl:PlaySVAni()
  self.sequence = DOTween.Sequence()
  self.sequence:AppendInterval(0.18)
  self.sequence:AppendCallback(function()
    self._mapNode.btnSkip.gameObject:SetActive(true)
  end)
  for i = 1, self.nRewardCount do
    self.sequence:AppendCallback(function()
      local goGrid = self._mapNode.sv.transform:Find("Viewport/Content/" .. i - 1)
      if goGrid then
        NovaAPI.SetCanvasGroupAlpha(goGrid.transform:Find("btnGrid"):GetComponent("CanvasGroup"), 1)
        local ani = goGrid.transform:Find("btnGrid/AnimRoot/aniGrid"):GetComponent("Animator")
        ani:Play("receiveprops_icon_t_in")
      end
    end)
    self.sequence:AppendInterval(0.14)
    if 8 <= i and i ~= self.nRewardCount then
      self.sequence:Append(self._mapNode.Content:DOAnchorPos(Vector2(-(i * 167.8 + 15 + 165 - 1420), 0), 0.14):SetEase(Ease.InOutQuad))
    end
  end
  self.sequence.onComplete = dotween_callback_handler(self, function()
    self:CloseSkip()
  end)
  self.sequence:SetUpdate(true)
end

function ReceivePropsCtrl:CloseSkip()
  if self.gameObject == nil or self.gameObject:IsNull() then
    return
  end
  self._mapNode.btnSkip.gameObject:SetActive(false)
  self._mapNode.btnClose.interactable = true
  if self._bAutoClosePending and (self._isAutoEnabledCallback == nil or self._isAutoEnabledCallback()) then
    self:OnBtnClick_CloseReward()
    return
  end
  self._mapNode.txtTips:DOFade(1, 0.167):SetUpdate(true)
  self._mapNode.txtTips2:DOFade(1, 0.167):SetUpdate(true)
  self._mapNode.txtTips1:DOFade(1, 0.167):SetUpdate(true)
end

function ReceivePropsCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbReward[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid.transform:Find("btnGrid").gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local mapCfg = ConfigTable.GetData_Item(mapItem.id)
  if mapCfg then
    if mapCfg.Type == GameEnum.itemType.Char or mapCfg.Type == GameEnum.itemType.CharacterSkin then
      self.tbGridCtrl[nInstanceId]:SetChar(mapItem.id, mapItem.count, nil, mapItem.rewardType)
    else
      self.tbGridCtrl[nInstanceId]:SetItem(mapItem.id, mapCfg.Rarity, mapItem.count, nil, nil, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.First, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.Three, true, false, true, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.Extra, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.Double)
    end
  end
  if not self.tbState[nIndex] then
    self.tbState[nIndex] = true
    NovaAPI.SetCanvasGroupAlpha(goGrid.transform:Find("btnGrid"):GetComponent("CanvasGroup"), 0)
  else
    NovaAPI.SetCanvasGroupAlpha(goGrid.transform:Find("btnGrid"):GetComponent("CanvasGroup"), 1)
  end
end

function ReceivePropsCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  self:OnSelectItem(self.tbReward[nIndex].id, goGrid.transform:Find("btnGrid"), self.tbReward[nIndex].nHasCount)
end

function ReceivePropsCtrl:OnSelectItem(itemId, btn, nHasCount)
  UTILS.ClickItemGridWithTips(itemId, btn.transform, false, true, false, nHasCount)
end

function ReceivePropsCtrl:ShowReward(tbReward)
  self.tbReward = tbReward
  self.nRewardCount = #tbReward
  
  local function sort(a, b)
    local cfgA = ConfigTable.GetData_Item(a.id)
    local cfgB = ConfigTable.GetData_Item(b.id)
    local rarityA = cfgA.Rarity
    local rarityB = cfgB.Rarity
    local typeA = cfgA.Type
    local typeB = cfgB.Type
    if a.rewardType ~= nil ~= (b.rewardType ~= nil) then
      return a.rewardType ~= nil and b.rewardType == nil
    elseif a.rewardType and b.rewardType and a.rewardType ~= b.rewardType then
      return a.rewardType < b.rewardType
    elseif rarityA ~= rarityB then
      return rarityA < rarityB
    elseif typeA ~= typeB then
      return typeA < typeB
    elseif a.count ~= b.count then
      return a.count > b.count
    else
      return a.id < b.id
    end
  end
  
  table.sort(self.tbReward, sort)
  self:RefreshList()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.HideRoot:SetActive(true)
    self._mapNode.aniRoot:Play("receiveprops_t_in")
    WwiseAudioMgr:PlaySound("ui_roguelike_gacha_reward")
  end
  
  cs_coroutine.start(wait)
end

function ReceivePropsCtrl:Awake()
  self._mapNode.HideRoot:SetActive(false)
  self._mapNode.txtDescTip.gameObject:SetActive(false)
  self._mapNode.txtTips.alpha = 0
  self._mapNode.txtTips2.alpha = 0
  self._mapNode.txtTips1.alpha = 0
  self.tbReward = nil
  self.tbGridCtrl = {}
  self.callback = nil
  self.tbGamepadUINode = self:GetGamepadUINode()
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  self._mapNode.txtTips1.gameObject:SetActive(not GamepadUIManager.GetInputState())
end

function ReceivePropsCtrl:OnEnable()
  if GamepadUIManager.GetInputState() then
    PanelManager.InputDisable()
    EventManager.Hit("StarTowerSetButtonEnable", false, false)
    GamepadUIManager.EnableGamepadUI("ReceivePropsCtrl", self.tbGamepadUINode)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.9)
  local tbParam = self:GetPanelParam()
  if type(tbParam[2]) == "function" then
    self.callback = tbParam[2]
  elseif type(tbParam[2]) == "string" then
    self._mapNode.txtDescTip.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtDescTip, tbParam[2])
  end
  if type(tbParam[3]) == "string" then
    self._mapNode.txtDescTip.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtDescTip, tbParam[3])
  end
  local nTitleType = tbParam[4] or AllEnum.ReceivePropsTitle.Common
  self._mapNode.imgTitle1.gameObject:SetActive(nTitleType == AllEnum.ReceivePropsTitle.Common)
  self._mapNode.imgTitle2.gameObject:SetActive(nTitleType == AllEnum.ReceivePropsTitle.Dating)
  self._mapNode.imgTitleHolder1.gameObject:SetActive(nTitleType == AllEnum.ReceivePropsTitle.Common)
  self._mapNode.imgTitleHolder2.gameObject:SetActive(nTitleType == AllEnum.ReceivePropsTitle.Dating)
  self:ShowReward(tbParam[1])
end

function ReceivePropsCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("ReceivePropsCtrl")
    EventManager.Hit("StarTowerSetButtonEnable", true, true)
    PanelManager.InputEnable()
  end
end

function ReceivePropsCtrl:OnDestroy()
end

function ReceivePropsCtrl:OnEvent_AutoCloseReward(callback, isAutoEnabledCallback)
  if not PlayerData.State:GetStarTowerSweepState() or self.callback ~= callback then
    return
  end
  self._bAutoClosePending = true
  self._isAutoEnabledCallback = isAutoEnabledCallback
  if self._mapNode.btnClose.interactable then
    self:OnBtnClick_CloseReward()
  end
end

function ReceivePropsCtrl:OnBtnClick_CloseReward(btn)
  if self._bClosing then
    return
  end
  self._bClosing = true
  self._bAutoClosePending = false
  EventManager.Hit(EventId.ClosePanel, PanelId.ReceivePropsTips)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self.callback then
      self.callback()
    end
  end
  
  cs_coroutine.start(wait)
end

function ReceivePropsCtrl:OnBtnClick_Skip(btn)
  if self.sequence then
    self.sequence:Kill()
    self.sequence = nil
  end
  if self.nRewardCount <= 8 then
    for i = 1, self.nRewardCount do
      local goGrid = self._mapNode.goItemList1:GetChild(i - 1)
      if goGrid then
        NovaAPI.SetCanvasGroupAlpha(goGrid:GetComponent("CanvasGroup"), 1)
      end
    end
  else
    for i = 1, self.nRewardCount do
      self.tbState[i] = true
      local goGrid = self._mapNode.sv.transform:Find("Viewport/Content/" .. i - 1)
      if goGrid then
        NovaAPI.SetCanvasGroupAlpha(goGrid.transform:Find("btnGrid"):GetComponent("CanvasGroup"), 1)
      end
    end
    self._mapNode.sv:SetScrollPos(1)
  end
  self:CloseSkip()
end

return ReceivePropsCtrl

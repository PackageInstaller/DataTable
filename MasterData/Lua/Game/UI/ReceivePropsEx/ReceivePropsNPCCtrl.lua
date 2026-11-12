local ReceivePropsNPCCtrl = class("ReceivePropsNPCCtrl", BaseCtrl)
local ModuleManager = require("GameCore.Module.ModuleManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local PlayerVoiceData = PlayerData.Voice
ReceivePropsNPCCtrl._mapNodeConfig = {
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
  imgTitleHolder2 = {},
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  animActorL2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "Animator"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  animActor2D = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Animator"
  },
  btnActor2D = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Actor2D"
  },
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  }
}
ReceivePropsNPCCtrl._mapEventConfig = {
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText",
  [EventId.UIBackConfirm] = "OnEvent_UIBack",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.ClosePanel] = "OnEvent_ClosePanel"
}

function ReceivePropsNPCCtrl:RefreshList()
  if self.nRewardCount <= 4 then
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

function ReceivePropsNPCCtrl:RefreshNormal()
  for _, v in ipairs(self.tbReward) do
    local nItemId = v.id
    local goItem = instantiate(self._mapNode.btnGrid, self._mapNode.goItemList1)
    local ctrlObj = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
    local mapCfg = ConfigTable.GetData_Item(nItemId)
    if mapCfg then
      if mapCfg.Type == GameEnum.itemType.Char then
        ctrlObj:SetChar(nItemId, v.count, nil, v.rewardType)
      else
        ctrlObj:SetItem(nItemId, mapCfg.Rarity, v.count, nil, nil, v.rewardType and v.rewardType == AllEnum.RewardType.First, v.rewardType and v.rewardType == AllEnum.RewardType.Three, true, false, false, v.rewardType and v.rewardType == AllEnum.RewardType.Extra)
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

function ReceivePropsNPCCtrl:PlayNormalAni()
  self.sequence = DOTween.Sequence()
  self.sequence:AppendInterval(0.25)
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

function ReceivePropsNPCCtrl:RefreshSV()
  self.tbState = {}
  self._mapNode.sv:Init(self.nRewardCount, self, self.OnGridRefresh, self.OnGridBtnClick)
  self:PlaySVAni()
end

function ReceivePropsNPCCtrl:PlaySVAni()
  self.sequence = DOTween.Sequence()
  self.sequence:AppendInterval(0.25)
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
    if 4 <= i and i ~= self.nRewardCount then
      self.sequence:Append(self._mapNode.Content:DOAnchorPos(Vector2(-(i * 167.8 + 15 + 165 - 760), 0), 0.14):SetEase(Ease.InOutQuad))
    end
  end
  self.sequence.onComplete = dotween_callback_handler(self, function()
    self:CloseSkip()
  end)
  self.sequence:SetUpdate(true)
end

function ReceivePropsNPCCtrl:CloseSkip()
  if self.gameObject == nil or self.gameObject:IsNull() then
    return
  end
  self._mapNode.btnSkip.gameObject:SetActive(false)
  self._mapNode.btnClose.interactable = true
end

function ReceivePropsNPCCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbReward[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid.transform:Find("btnGrid").gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  local mapCfg = ConfigTable.GetData_Item(mapItem.id)
  if mapCfg then
    if mapCfg.Type == GameEnum.itemType.Char then
      self.tbGridCtrl[nInstanceId]:SetChar(mapItem.id, mapItem.count, nil, mapItem.rewardType)
    else
      self.tbGridCtrl[nInstanceId]:SetItem(mapItem.id, mapCfg.Rarity, mapItem.count, nil, nil, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.First, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.Three, true, false, true, mapItem.rewardType and mapItem.rewardType == AllEnum.RewardType.Extra)
    end
  end
  if not self.tbState[nIndex] then
    self.tbState[nIndex] = true
    NovaAPI.SetCanvasGroupAlpha(goGrid.transform:Find("btnGrid"):GetComponent("CanvasGroup"), 0)
  else
    NovaAPI.SetCanvasGroupAlpha(goGrid.transform:Find("btnGrid"):GetComponent("CanvasGroup"), 1)
  end
end

function ReceivePropsNPCCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  self:OnSelectItem(self.tbReward[nIndex].id, goGrid.transform:Find("btnGrid"), self.tbReward[nIndex].nHasCount)
end

function ReceivePropsNPCCtrl:OnSelectItem(itemId, btn, nHasCount)
  UTILS.ClickItemGridWithTips(itemId, btn.transform, false, true, false, nHasCount)
end

function ReceivePropsNPCCtrl:ShowReward(tbReward)
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
    self._mapNode.animActor2D:Play("Actor2D_PNG_right_middle_in")
    self._mapNode.animActorL2D:Play("Actor2D_PNG_right_middle_in")
    WwiseAudioMgr:PlaySound("ui_roguelike_gacha_reward")
  end
  
  cs_coroutine.start(wait)
end

function ReceivePropsNPCCtrl:RefreshNPC2D(mapData)
  self.nNpcId = mapData.nNpcId
  self.nVoiceId = mapData.nVoiceId
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.rawImgActor2D.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  self.bPlayVoice = false
  self._mapNode.btnActor2D.interactable = false
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if bUseL2D then
      local param
      if self.nNpcId == 713503 then
        BubbleVoiceManager.MarkPlaySpAnim(true)
        param = "HideBgIn_ReceivePropsNPC_Panel"
      end
      Actor2DManager.SetBoardNPC2D(PanelId.ReceivePropsNPC, self._mapNode.rawImgActor2D, self.nNpcId, nil, param, 2)
    else
      Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, PanelId.ReceivePropsNPC, self.nNpcId)
    end
    self._mapNode.btnActor2D.interactable = true
    self:PlayVoice()
  end
  
  cs_coroutine.start(wait)
end

function ReceivePropsNPCCtrl:PlayVoice()
  if self.bPlayVoice then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", self.nVoiceId)
  if not mapVoDirectoryData then
    return
  end
  local vo = PlayerVoiceData:PlayCharVoice(mapVoDirectoryData.votype, self.nNpcId, nil, true)
  if vo == 0 then
    return
  end
end

function ReceivePropsNPCCtrl:Awake()
  self._mapNode.HideRoot:SetActive(false)
  self._mapNode.txtDescTip.gameObject:SetActive(false)
  self.tbReward = nil
  self.tbGridCtrl = {}
  self.callback = nil
  self.tbGamepadUINode = self:GetGamepadUINode()
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
end

function ReceivePropsNPCCtrl:OnEnable()
  if GamepadUIManager.GetInputState() then
    PanelManager.InputDisable()
    EventManager.Hit("StarTowerSetButtonEnable", false, false)
    GamepadUIManager.EnableGamepadUI("ReceivePropsNPCCtrl", self.tbGamepadUINode)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.9)
  local tbParam = self:GetPanelParam()
  if type(tbParam[3]) == "function" then
    self.callback = tbParam[3]
  end
  local nTitleType = tbParam[4] or AllEnum.ReceivePropsTitle.Common
  self._mapNode.imgTitle1.gameObject:SetActive(nTitleType == AllEnum.ReceivePropsTitle.Common)
  self._mapNode.imgTitle2.gameObject:SetActive(nTitleType == AllEnum.ReceivePropsTitle.Dating)
  self._mapNode.imgTitleHolder1.gameObject:SetActive(nTitleType == AllEnum.ReceivePropsTitle.Common)
  self._mapNode.imgTitleHolder2.gameObject:SetActive(nTitleType == AllEnum.ReceivePropsTitle.Dating)
  self:ShowReward(tbParam[1])
  BubbleVoiceManager.StopBubbleAnim()
  PlayerVoiceData:ClearTimer()
  PlayerVoiceData:StopCharVoice()
  self:RefreshNPC2D(tbParam[2])
end

function ReceivePropsNPCCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("ReceivePropsNPCCtrl")
    EventManager.Hit("StarTowerSetButtonEnable", true, true)
    PanelManager.InputEnable()
  end
  Actor2DManager.UnsetBoardNPC2D(2)
  BubbleVoiceManager.StopBubbleAnim()
  PlayerVoiceData:ClearTimer()
  PlayerVoiceData:StopCharVoice()
  if self.nNpcId == 713503 then
    BubbleVoiceManager.MarkPlaySpAnim(false)
  end
end

function ReceivePropsNPCCtrl:OnDestroy()
end

function ReceivePropsNPCCtrl:OnBtnClick_CloseReward(btn)
  EventManager.Hit(EventId.ClosePanel, PanelId.ReceivePropsNPC)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit("AfterCloseNPCReceive")
    if self.callback then
      self.callback()
    end
  end
  
  cs_coroutine.start(wait)
end

function ReceivePropsNPCCtrl:OnBtnClick_Skip(btn)
  if self.sequence then
    self.sequence:Kill()
    self.sequence = nil
  end
  if self.nRewardCount <= 4 then
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

function ReceivePropsNPCCtrl:OnBtnClick_Actor2D()
  self:PlayVoice()
end

function ReceivePropsNPCCtrl:OnEvent_ShowBubbleVoiceText(nNpcId, nId)
  if nNpcId ~= self.nNpcId then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource, 2)
  local nTime = BubbleVoiceManager.GetVoResLen(mapVoDirectoryData.voResource)
  if 0 < nTime then
    self.bPlayVoice = true
    self:AddTimer(1, nTime, function()
      self.bPlayVoice = false
    end, true, true, true)
  end
end

function ReceivePropsNPCCtrl:OnEvent_UIBack(nPanelId)
  if PanelId.DiscSample ~= nPanelId or PanelId.CharBgTrialPanel ~= nPanelId then
    PlayerVoiceData:StartBoardFreeTimer(self.nNpcId)
  end
end

function ReceivePropsNPCCtrl:OnEvent_Home(nPanelId)
  if PanelId.DiscSample ~= nPanelId or PanelId.CharBgTrialPanel ~= nPanelId then
    PlayerVoiceData:StartBoardFreeTimer(self.nNpcId)
  end
end

function ReceivePropsNPCCtrl:OnEvent_ClosePanel(nPanelId)
  if nPanelId == PanelId.DiscSample then
    self.bPlayVoice = false
    self:PlayVoice()
  end
end

return ReceivePropsNPCCtrl

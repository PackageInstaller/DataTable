local BdConvertResultCtrl = class("BdConvertResultCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
BdConvertResultCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_black"
  },
  btn_close = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  HideRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  aniRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btnSkip = {
    sComponentName = "Button",
    callback = "OnBtnClick_Skip"
  },
  btnGrid = {},
  img_icon = {sComponentName = "Image"},
  txt_tips = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_RewardTips"
  },
  goItemList1 = {
    sComponentName = "RectTransform"
  }
}
BdConvertResultCtrl._mapEventConfig = {}
BdConvertResultCtrl._mapRedDotConfig = {}

function BdConvertResultCtrl:Awake()
  local param = self:GetPanelParam()
  local tbReward, icon, callback
  if type(param) == "table" then
    tbReward = param[1]
    icon = param[2]
    callback = param[3]
  end
  self:ShowReward(tbReward, icon, callback)
end

function BdConvertResultCtrl:OnEnable()
  self._mapNode.goBlur:SetActive(true)
end

function BdConvertResultCtrl:RefreshNormal()
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
    goItem.gameObject:SetActive(true)
    NovaAPI.SetCanvasGroupAlpha(goItem:GetComponent("CanvasGroup"), 0)
  end
  self:PlayNormalAni()
end

function BdConvertResultCtrl:OnSelectItem(itemId, btn, nHasCount)
  UTILS.ClickItemGridWithTips(itemId, btn.transform, false, true, false, nHasCount)
end

function BdConvertResultCtrl:PlayNormalAni()
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

function BdConvertResultCtrl:ShowReward(tbReward, sIconPath, callback)
  self.tbReward = tbReward
  self.nRewardCount = #tbReward
  self.callback = callback
  
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
  self:RefreshNormal()
  self:SetPngSprite(self._mapNode.img_icon:GetComponent("Image"), sIconPath)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.HideRoot:SetActive(true)
    self._mapNode.aniRoot:Play("receiveprops_t_in")
    WwiseAudioMgr:PlaySound("ui_roguelike_gacha_reward")
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
end

function BdConvertResultCtrl:CloseSkip()
  self._mapNode.btnSkip.gameObject:SetActive(false)
  self._mapNode.btn_close.interactable = true
end

function BdConvertResultCtrl:OnBtnClick_Close()
  if self.callback ~= nil then
    self.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.BdConvertResultPanel)
end

function BdConvertResultCtrl:OnBtnClick_Skip(btn)
  if self.sequence then
    self.sequence:Kill()
    self.sequence = nil
  end
  for i = 1, self.nRewardCount do
    local goGrid = self._mapNode.goItemList1:GetChild(i - 1)
    if goGrid then
      NovaAPI.SetCanvasGroupAlpha(goGrid:GetComponent("CanvasGroup"), 1)
    end
  end
  self:CloseSkip()
end

return BdConvertResultCtrl

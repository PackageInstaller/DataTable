local SoldierPolicyItemCtrl = class("SoldierPolicyItemCtrl", BaseCtrl)
SoldierPolicyItemCtrl._mapNodeConfig = {
  imgIconBg = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  RewardRoot = {},
  goChar = {
    sNodeName = "tc_char_small"
  },
  goItem = {
    sNodeName = "tc_item_small"
  },
  goRewardContent = {sComponentName = "Transform"},
  txtCharTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Select_PolicyItem_Effect_Title"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_Reward_Select"
  },
  AnimRootMain = {sComponentName = "Animator"}
}
SoldierPolicyItemCtrl._mapEventConfig = {}
SoldierPolicyItemCtrl._mapRedDotConfig = {}
local CHAR_CTRL = "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl"
local iconPath = "Icon/SoldierBuffCard/"

function SoldierPolicyItemCtrl:Awake()
  self._mapNode.goChar.gameObject:SetActive(false)
  self._mapNode.goItem.gameObject:SetActive(false)
  self.tbCharItemsCtrl = {}
  self.nCardId = -1
  self.nIndex = 0
  self._bSelected = false
end

function SoldierPolicyItemCtrl:OnDisable()
  self:_ClearCharItems()
  if self.timerBtnConfirm ~= nil then
    self.timerBtnConfirm:Cancel()
    self.timerBtnConfirm = nil
  end
end

function SoldierPolicyItemCtrl:OnEnable()
end

function SoldierPolicyItemCtrl:OnDestroy()
end

function SoldierPolicyItemCtrl:SetItemData(cardId, index)
  self.nCardId = cardId
  self.nIndex = index or 0
  local mapCfg = ConfigTable.GetData("SoldierStarterCard", cardId)
  if not mapCfg then
    return
  end
  self:SetPngSprite(self._mapNode.imgIcon, iconPath .. mapCfg.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtDesc, mapCfg.Des)
  local hasReward = mapCfg.CharacterShow and 0 < #mapCfg.CharacterShow
  self._mapNode.RewardRoot:SetActive(hasReward)
  if hasReward then
    self:_RefreshCharItems(mapCfg.CharacterShow)
  end
  self:SetSelected(false)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
end

function SoldierPolicyItemCtrl:SetButtonCallback(fn)
  self._btnConfirmCallback = fn
end

function SoldierPolicyItemCtrl:_RefreshCharItems(tbCharIds)
  for k, charId in ipairs(tbCharIds) do
    local itemCtrl = self.tbCharItemsCtrl[k]
    if itemCtrl == nil then
      local go = instantiate(self._mapNode.goChar, self._mapNode.goRewardContent)
      itemCtrl = self:BindCtrlByNode(go, CHAR_CTRL)
      itemCtrl:SetCharLevel(1)
      table.insert(self.tbCharItemsCtrl, itemCtrl)
    end
    itemCtrl:SetCharItemBtnFunc(function()
      local chessData = {nId = charId, nStar = 1}
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self.charTipsRoot, chessData)
    end)
    itemCtrl.gameObject:SetActive(true)
    itemCtrl:SetItemData(charId)
  end
end

function SoldierPolicyItemCtrl:_ClearCharItems()
  for _, ctrl in ipairs(self.tbCharItemsCtrl) do
    local obj = ctrl.gameObject
    self:UnbindCtrlByNode(ctrl)
    destroy(obj)
  end
  self.tbCharItemsCtrl = {}
end

function SoldierPolicyItemCtrl:SetSelected(bSelected)
  if self.timerBtnConfirm ~= nil then
    self.timerBtnConfirm:Cancel()
    self.timerBtnConfirm = nil
  end
  local sSwitchAnimName = ""
  if bSelected == true then
    self._mapNode.btnConfirm.gameObject:SetActive(bSelected)
    sSwitchAnimName = "PolicyItem_up"
  elseif self._bSelected == true then
    sSwitchAnimName = "PolicyItem_down"
    local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.AnimRootMain, sSwitchAnimName)
    self.timerBtnConfirm = self:AddTimer(1, nAnimLength, function()
      self._mapNode.btnConfirm.gameObject:SetActive(false)
    end, true, true, true)
  elseif self._bSelected == false then
    self._mapNode.btnConfirm.gameObject:SetActive(false)
  end
  if sSwitchAnimName ~= "" then
    self._mapNode.AnimRootMain:Play(sSwitchAnimName)
  end
  self._bSelected = bSelected == true
end

function SoldierPolicyItemCtrl:SetCharTipsRoot(tr)
  self.charTipsRoot = tr
end

function SoldierPolicyItemCtrl:OnBtnClick_Confirm()
  if self._btnConfirmCallback then
    self._btnConfirmCallback()
  end
end

return SoldierPolicyItemCtrl

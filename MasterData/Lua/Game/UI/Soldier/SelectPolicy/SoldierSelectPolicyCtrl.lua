local SoldierSelectPolicyCtrl = class("SoldierSelectPolicyCtrl", BaseCtrl)
SoldierSelectPolicyCtrl._mapNodeConfig = {
  trBg = {sNodeName = "----BG----"},
  imgBgMain_Fx = {},
  trRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  goPolicyItem = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.SelectPolicy.SoldierPolicyItemCtrl"
  },
  btnPolicyItem = {
    nCount = 3,
    sNodeName = "goPolicyItem",
    sComponentName = "UIButton",
    callback = "OnBtnClick_PolicyItem"
  },
  btnRecommend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Recommend"
  },
  btnRefreshBuff = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RefreshBuff"
  },
  imgBtnMask = {},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Select_Policy_Title"
  },
  txtReRollCount = {sComponentName = "TMP_Text"},
  trCharDetail = {sComponentName = "Transform"}
}
SoldierSelectPolicyCtrl._mapEventConfig = {
  SoldierRecommendPanel_Close = "OnEvent_SoldierRecommendPanelClose",
  SoldierRecommendPanel_Open = "OnEvent_SoldierRecommendPanelOpen"
}
SoldierSelectPolicyCtrl._mapRedDotConfig = {}

function SoldierSelectPolicyCtrl:Awake()
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  self.tbCardList = {}
  self.nReRollCount = 0
  self.nSelectCardId = -1
  self.nSelectIndex = 0
end

function SoldierSelectPolicyCtrl:OnEnable()
  self:RefreshContent()
end

function SoldierSelectPolicyCtrl:OnDisable()
end

function SoldierSelectPolicyCtrl:OnDestroy()
end

function SoldierSelectPolicyCtrl:ClosePanel()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierSelectPolicy)
end

function SoldierSelectPolicyCtrl:RefreshContent()
  self.nSelectCardId = -1
  self.nSelectIndex = 0
  if self.levelData == nil then
    return
  end
  self.tbCardList, self.nReRollCount = self.levelData:GetSelectCardData()
  for k, v in ipairs(self._mapNode.goPolicyItem) do
    v.gameObject:SetActive(self.tbCardList[k] ~= nil)
    if self.tbCardList[k] ~= nil then
      v:SetItemData(self.tbCardList[k], k)
      v:SetButtonCallback(function()
        self:OnBtnClick_Confirm(k)
      end)
    end
  end
  local sRemain = orderedFormat(ConfigTable.GetUIText("Soldier_Policy_ReRoll_Count"), self.nReRollCount)
  NovaAPI.SetTMPText(self._mapNode.txtReRollCount, sRemain)
  self._mapNode.imgBtnMask.gameObject:SetActive(0 >= self.nReRollCount)
  for k, v in ipairs(self._mapNode.goPolicyItem) do
    v:SetCharTipsRoot(self._mapNode.trCharDetail)
  end
end

function SoldierSelectPolicyCtrl:HidePanel()
  self._mapNode.trBg.gameObject:SetActive(false)
  self._mapNode.imgBgMain_Fx.gameObject:SetActive(false)
  self._mapNode.trRoot.gameObject:SetActive(false)
end

function SoldierSelectPolicyCtrl:ShowPanel()
  self._mapNode.trBg.gameObject:SetActive(true)
  self._mapNode.imgBgMain_Fx.gameObject:SetActive(true)
  self._mapNode.trRoot.gameObject:SetActive(true)
  for k, v in ipairs(self._mapNode.goPolicyItem) do
    v:SetSelected(k == self.nSelectIndex)
  end
end

function SoldierSelectPolicyCtrl:OnBtnClick_PolicyItem(btn, nIndex)
  for k, v in ipairs(self._mapNode.goPolicyItem) do
    v:SetSelected(k == nIndex)
  end
  self.nSelectCardId = self.tbCardList[nIndex]
  self.nSelectIndex = nIndex
end

function SoldierSelectPolicyCtrl:OnBtnClick_RefreshBuff()
  if self.nReRollCount <= 0 then
    return
  end
  
  local function callback()
    self:RefreshContent()
  end
  
  self.levelData:SendCardSelectReRoll(callback)
end

function SoldierSelectPolicyCtrl:OnBtnClick_Confirm(k)
  local function callback()
    self:ClosePanel()
  end
  
  self.levelData:SendCardSelect(k, callback)
end

function SoldierSelectPolicyCtrl:OnBtnClick_Recommend()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierRecommendPanel, true)
end

function SoldierSelectPolicyCtrl:OnEvent_SoldierRecommendPanelClose()
  self:ShowPanel()
end

function SoldierSelectPolicyCtrl:OnEvent_SoldierRecommendPanelOpen()
  self:HidePanel()
end

return SoldierSelectPolicyCtrl

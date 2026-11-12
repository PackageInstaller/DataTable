local SoldierBattleEventCtrl = class("SoldierBattleEventCtrl", BaseCtrl)
local SELECT_CARD_TYPE_STRATEGY = 2
SoldierBattleEventCtrl._mapNodeConfig = {
  imgBgMain = {},
  imgBgMain_Fx = {},
  blur = {},
  mainRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  goSelectCard = {},
  goSelectBattle = {},
  txtTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Select_BattleEvent_Title_1"
  },
  txtCardSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Select_BattleEvent_Title_2"
  },
  txtRemainRewardCount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BattleEvent_RemainRewardCount"
  },
  txtBtnBack = {
    sComponentName = "TMP_Text",
    sLanguageId = "SoldierBattleEvent_Back"
  },
  EventItem = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.BattleEvent.SoldierBattleEventItemCtrl"
  },
  StrategyItem = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.BattleEvent.SoldierAddBuffItemCtrl"
  },
  btnReturn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Return"
  },
  btnGuide = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Guide"
  },
  txtChoose = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Select_BattleEvent"
  },
  TopBar = {
    sNodeName = "TopBarPanel"
  }
}
SoldierBattleEventCtrl._mapEventConfig = {
  SoldierSelectEventBattle = "OnEvent_SoldierSelectEventBattle",
  SoldierShowBattleEventPanel = "OnEvent_ShowBattleEventPanel",
  SoldierStrategySelect = "OnEvent_SoldierStrategySelect",
  SoldierRecommendPanel_Open = "HidePanel",
  SoldierRecommendPanel_Close = "ShowPanel",
  SoldierHandbookPanel_Open = "HidePanel",
  SoldierHandbookPanel_Close = "ShowPanel"
}
SoldierBattleEventCtrl._mapRedDotConfig = {}

function SoldierBattleEventCtrl:Awake()
  self.tbStrategyCardData = nil
  self.bSkipEvent = false
  local tbParams = self:GetPanelParam()
  if tbParams ~= nil and 0 < #tbParams then
    self.bSkipEvent = tbParams[1] or false
  end
end

function SoldierBattleEventCtrl:OnEnable()
  if self.bSkipEvent then
    self.bSkipEvent = false
    self:OnSoldierEnterCardSelect()
    return
  end
  self:RefreshBattleEventList()
end

function SoldierBattleEventCtrl:OnDisable()
  self.tbStrategyCardData = nil
end

function SoldierBattleEventCtrl:GetAddBattleEventList()
  local selectCardData = PlayerData.SoldierData:GetCurLevelData():GetEventBattleData()
  local tbList = {}
  local tbIds = selectCardData.tbIds or {}
  if next(tbIds) ~= nil then
    table.sort(tbIds, function(a, b)
      local mapEventA = ConfigTable.GetData("SoldierEventBattlePool", a)
      local mapEventB = ConfigTable.GetData("SoldierEventBattlePool", b)
      return mapEventA.LevelName < mapEventB.LevelName
    end)
  end
  for i = 1, 3 do
    local nCardId = tbIds[i]
    if nCardId ~= nil then
      tbList[i] = {id = nCardId, index = i}
    end
  end
  return tbList
end

function SoldierBattleEventCtrl:RefreshBattleEventList()
  local tbList = self:GetAddBattleEventList()
  if tbList == nil or #tbList <= 0 then
    return
  end
  self._mapNode.goSelectBattle.gameObject:SetActive(true)
  self._mapNode.goSelectCard.gameObject:SetActive(false)
  for i = 1, 3 do
    local item = self._mapNode.EventItem[i]
    if item ~= nil then
      item:SetItemData(tbList[i])
    end
  end
end

function SoldierBattleEventCtrl:RefreshStrategyCard()
  if self.tbStrategyCardData == nil then
    return
  end
  self._mapNode.goSelectBattle.gameObject:SetActive(false)
  self._mapNode.goSelectCard.gameObject:SetActive(true)
  for k, v in ipairs(self._mapNode.StrategyItem) do
    local tbItem = {
      id = self.tbStrategyCardData[k],
      index = k
    }
    v:SetCharTipsRoot(v.gameObject.transform)
    v:SetItemData(tbItem)
  end
end

function SoldierBattleEventCtrl:OnItemSelected(nIndex, nCardId)
  self._nSelectedIndex = nIndex or 0
  self._nSelectedCardId = nCardId or -1
  for k, v in ipairs(self._mapNode.StrategyItem) do
    v:SetSelected(k == self._nSelectedIndex)
  end
  self:_MoveConfirmBtnTo(self._nSelectedIndex)
end

function SoldierBattleEventCtrl:_MoveConfirmBtnTo(nIndex)
  local btnConfirm = self._mapNode.btnConfirm
  if btnConfirm == nil or btnConfirm.transform == nil then
    return
  end
  local item = self._mapNode.EventItem and self._mapNode.EventItem[nIndex]
  if item == nil then
    if btnConfirm.gameObject ~= nil then
      btnConfirm.gameObject:SetActive(false)
    end
    return
  end
  local v3Pos = item:GetConfirmBtnPosition()
  if v3Pos == nil then
    return
  end
  btnConfirm.transform.position = v3Pos
  if btnConfirm.gameObject ~= nil then
    btnConfirm.gameObject:SetActive(true)
  end
end

function SoldierBattleEventCtrl:GetSelectedCardId()
  return self._nSelectedCardId
end

function SoldierBattleEventCtrl:GetSelectedIndex()
  return self._nSelectedIndex
end

function SoldierBattleEventCtrl:HidePanel()
  self.bPrevMainRootVisible = self._mapNode.mainRoot.gameObject.activeSelf or false
  self.bPrevBlurVisible = self._mapNode.blur.gameObject.activeSelf or false
  self.bPrevImgBgMainVisible = self._mapNode.imgBgMain.gameObject.activeSelf or false
  self.bPrevImgBgMain_FxVisible = self._mapNode.imgBgMain_Fx.gameObject.activeSelf or false
  self._mapNode.mainRoot.gameObject:SetActive(false)
  self._mapNode.blur.gameObject:SetActive(false)
  self._mapNode.imgBgMain.gameObject:SetActive(false)
  self._mapNode.imgBgMain_Fx.gameObject:SetActive(false)
end

function SoldierBattleEventCtrl:ShowPanel()
  self._mapNode.mainRoot.gameObject:SetActive(self.bPrevMainRootVisible)
  self._mapNode.blur.gameObject:SetActive(self.bPrevBlurVisible)
  self._mapNode.imgBgMain.gameObject:SetActive(self.bPrevImgBgMainVisible)
  self._mapNode.imgBgMain_Fx.gameObject:SetActive(self.bPrevImgBgMain_FxVisible)
  for k, v in ipairs(self._mapNode.StrategyItem) do
    v:SetSelected(k == self._nSelectedIndex)
  end
end

function SoldierBattleEventCtrl:OnBtnClick_Return()
  CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_transition")
  self:HidePanel()
end

function SoldierBattleEventCtrl:OnBtnClick_Guide()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierRecommendPanel, true)
end

function SoldierBattleEventCtrl:OnSoldierEnterCardSelect()
  self.tbStrategyCardData = PlayerData.SoldierData:GetCurLevelData():GetSelectCardData()
  self:RefreshStrategyCard()
end

function SoldierBattleEventCtrl:OnEvent_SoldierSelectEventBattle()
  local bInSelectCard = PlayerData.SoldierData:GetCurLevelData():CheckInSelectCard()
  if not bInSelectCard then
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierBattleEventPanel)
  else
    self:OnSoldierEnterCardSelect()
  end
end

function SoldierBattleEventCtrl:OnEvent_ShowBattleEventPanel()
  self:ShowPanel()
end

function SoldierBattleEventCtrl:OnEvent_SoldierStrategySelect(nIndex, nCardId)
  self:OnItemSelected(nIndex, nCardId)
end

return SoldierBattleEventCtrl

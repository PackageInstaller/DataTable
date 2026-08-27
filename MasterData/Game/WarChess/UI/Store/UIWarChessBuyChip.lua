local UIWarChessBuyChip = class("UIWarChessBuyChip", UIBaseWindow)
local base = UIBaseWindow
local UINWCChipDetail = require("Game.WarChess.UI.Common.UINWCChipDetail")
local UINWarChessSelectTeam = require("Game.WarChess.UI.Common.UINWarChessSelectTeam")

function UIWarChessBuyChip:OnInit()
  self.ui.wcChipDetail:SetActive(false)
  self._selectChipPool = UIItemPool.New(UINWCChipDetail, self.ui.wcChipDetail)
  self.ui.teamNode:SetActive(false)
  self._selectTeamPool = UIItemPool.New(UINWarChessSelectTeam, self.ui.teamNode)
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self._OnClickLevel)
  self._selectChipItem = nil
  self.ui.tex_RareNum.text = 0
  self.__onWCChipChanged = BindCallback(self, self.OnDynPlayChipUpdate)
  MsgCenter:AddListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
  self.__onCoinNumChange = BindCallback(self, self.OnCoinNumChange)
  MsgCenter:AddListener(eMsgEventId.WC_CoinNumChange, self.__onCoinNumChange)
  self.__onWCChipChanged = BindCallback(self, self.OnWCBuyChipChanged)
  MsgCenter:AddListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
end

function UIWarChessBuyChip:InitWCBuyChip(storeDataList, teamDataDic, buyEvent, returnFunc, coinNum, rareNum)
  self._teamDataDic = teamDataDic
  self._storeDataList = storeDataList
  self._buyEvent = buyEvent
  self._returnEvent = returnFunc
  self._chipItemList = {}
  self.__clickedPanelAction = BindCallback(self, self._OnClickChipPanel)
  self.__buyChipAction = BindCallback(self, self._OnBuyTeamChip)
  self:_WCRefreshChipList(self._storeDataList)
  self:OnCoinNumChange(ConstGlobalItem.WCMoney, coinNum)
  self:OnCoinNumChange(ConstGlobalItem.WCDeployPoint, rareNum)
end

function UIWarChessBuyChip:OnCoinNumChange(itemId, num)
  if itemId == ConstGlobalItem.WCMoney then
    self.ui.tex_CoinNum.text = tostring(num)
  else
    self.ui.tex_RareNum.text = tostring(num)
  end
end

function UIWarChessBuyChip:_WCRefreshChipList(storeDataList)
  local function afterAnim()
    self._storeDataList = storeDataList
    
    self.selectChip = nil
    self._chipItemList = {}
    self._selectChipPool:HideAll()
    for k, storeData in ipairs(storeDataList) do
      local chipData = storeData.chipData
      local chipItem = self._selectChipPool:GetOne()
      chipItem.gameObject.name = tostring(chipData.dataId)
      chipItem:Show()
      chipItem:InitWCChipDetail(k, chipData, self.resloader, self.__clickedPanelAction, true)
      chipItem:ShowWCChipDetailEff(5)
      chipItem:InitDissolveTweenSetting()
      chipItem:SetWCChipSelectState(false)
      chipItem:SetIsSellOutActive(storeData.saled)
      table.insert(self._chipItemList, chipItem)
    end
  end
  
  if #self._chipItemList > 0 then
    UIUtil.AddOneCover("UISelectChip")
    self:CleanSelect()
    local waitingAnimNum = 0
    local isAddedCallback = false
    
    local function palyOver()
      waitingAnimNum = waitingAnimNum - 1
      if waitingAnimNum <= 0 then
        afterAnim()
        UIUtil.CloseOneCover("UISelectChip")
      end
    end
    
    for chipIndex, chipItem in ipairs(self._chipItemList) do
      if not chipItem.lockState then
        local chipPanel = chipItem:GetChipDetailPanel()
        waitingAnimNum = waitingAnimNum + 1
        chipPanel:OnDissolveTweenCompleteAction(palyOver)
        isAddedCallback = true
        chipPanel:PlayDissolveTween()
      end
    end
    AudioManager:PlayAudioById(1123)
    if not isAddedCallback then
      afterAnim()
    end
  else
    afterAnim()
  end
end

function UIWarChessBuyChip:_InitWCTeamList(chipItem)
  self._selectTeamPool:HideAll()
  local chipData = chipItem:GetWCChipDetailPanelData()
  for _, teamData in pairs(self._teamDataDic) do
    local selectTeamItem = self._selectTeamPool:GetOne()
    selectTeamItem:InitWCSelectTeamBuyChip(teamData, chipData, self.resloader, chipItem.price)
    selectTeamItem:BindWCSelectTeamEvent(nil, self.__buyChipAction)
  end
end

function UIWarChessBuyChip:SetDefaultChip(chipData)
  local chipItem
  for k, v in ipairs(self._chipItemList) do
    if v:GetWCChipDetailPanelData() == chipData then
      chipItem = v
      break
    end
  end
  if chipItem ~= nil then
    self:_OnClickChipPanel(chipItem, chipData)
  end
end

function UIWarChessBuyChip:OnDynPlayChipUpdate(chipList, dynPlayer)
end

function UIWarChessBuyChip:GetStoreDataByIndex(index)
  local storeData = self._storeDataList[index]
  return storeData
end

function UIWarChessBuyChip:OnBuyChipSuccessCallback(chipItem, storeData)
  chipItem:SetIsSellOutActive(storeData.saled)
  local tempChipItem
  for k, v in ipairs(self._chipItemList) do
    local storeData = self:GetStoreDataByIndex(v.index)
    if v ~= chipItem and storeData ~= nil and not storeData.saled then
      tempChipItem = v
      break
    end
  end
  if tempChipItem ~= nil then
    self:_OnClickChipPanel(tempChipItem, tempChipItem:GetWCChipDetailPanelData())
  else
    self:_OnClickLevel()
  end
end

function UIWarChessBuyChip:_OnClickChipPanel(chipItem, chipData)
  if self._selectChipItem == chipItem then
    return
  end
  if self._selectChipItem ~= nil then
    self._selectChipItem:SetWCChipSelectState(false, 0.3)
  end
  self._selectChipItem = chipItem
  self._selectChipItem:SetWCChipSelectState(true, 0.3)
  self:_InitWCTeamList(self._selectChipItem)
end

function UIWarChessBuyChip:_OnBuyTeamChip(teamItem, teamData)
  if self._selectChipItem == nil then
    return
  end
  local storeData = self:GetStoreDataByIndex(self._selectChipItem.index)
  if self._buyEvent ~= nil and storeData ~= nil then
    self._buyEvent(self._selectChipItem, teamData, storeData)
  end
end

function UIWarChessBuyChip:_OnClickLevel()
  if self._returnEvent ~= nil then
    local index = -1
    if self._selectChipItem ~= nil then
      local storeData = self:GetStoreDataByIndex(self._selectChipItem.index)
      if storeData ~= nil then
        index = storeData.idx
      end
    end
    self._returnEvent(index)
  end
  self:Delete()
end

function UIWarChessBuyChip:OnWCBuyChipChanged(chipList, dynPlayer)
  if self._selectChipItem == nil then
    return
  end
  for _, teamItem in pairs(self._selectTeamPool.listItem) do
    local teamData = teamItem:GetWCSelectTeamData()
    if teamData ~= nil and teamData:GetTeamDynPlayer() == dynPlayer then
      local chipData = self._selectChipItem:GetWCChipDetailPanelData()
      teamItem:InitWCSelectTeamBuyChip(teamData, chipData, self.resloader, self._selectChipItem.price)
      return
    end
  end
end

function UIWarChessBuyChip:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  for _, chipObj in ipairs(self._chipItemList) do
    chipObj:KillDOTween()
  end
  self._selectTeamPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.WC_CoinNumChange, self.__onCoinNumChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
  MsgCenter:RemoveListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
  base.OnDelete(self)
end

return UIWarChessBuyChip

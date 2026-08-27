local UIWarChessSelectChip = class("UIWarChessSelectChip", UIBaseWindow)
local base = UIBaseWindow
local cs_Ease = CS.DG.Tweening.Ease
local UINWCChipDetail = require("Game.WarChess.UI.Common.UINWCChipDetail")
local UINWarChessSelectTeam = require("Game.WarChess.UI.Common.UINWarChessSelectTeam")

function UIWarChessSelectChip:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self._OnClickWCSkipChip)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self._OnClickWCRefreshChip)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnClickShowMap)
  self.ui.tex_MapBtnName:SetIndex(0)
  self.ui.wcChipDetail:SetActive(false)
  self._selectChipPool = UIItemPool.New(UINWCChipDetail, self.ui.wcChipDetail)
  self.ui.teamNode:SetActive(false)
  self._selectTeamPool = UIItemPool.New(UINWarChessSelectTeam, self.ui.teamNode)
  self.ui.btn_Refresh.gameObject:SetActive(false)
  self.ui.btn_Skip.gameObject:SetActive(false)
  self.resloader = CS.ResLoader.Create()
  self._selectChipItem = nil
  self._updateWCSelectChipRefreshInfo = BindCallback(self, self.UpdateWCSelectChipRefreshInfo)
  MsgCenter:AddListener(eMsgEventId.WC_ItemNumChange, self._updateWCSelectChipRefreshInfo)
end

function UIWarChessSelectChip:InitWCSelectChip(chipDataList, teamDataDic, selectEvent)
  self._teamDataDic = teamDataDic
  self._chipDataList = chipDataList
  self._selectEvent = selectEvent
  self.__clickedPanelAction = BindCallback(self, self._OnClickChipPanel)
  self.__selectChipAction = BindCallback(self, self._OnSelectTeamChip)
  self:_WCRefreshChipList(chipDataList)
  local shopId = WarChessManager:GetWCLevelShopId()
  local shopCoinCfg = ConfigData.warchess_shop_coin[shopId]
  self._shopConinCfg = shopCoinCfg
end

function UIWarChessSelectChip:InitWCSelectChipRefresh(refreshEvent, refreshTime)
  self._refreshEvent = refreshEvent
  self._refreshLimit = self._shopConinCfg.battle_times_limit
  self._refreshTime = refreshTime or 0
  self.ui.btn_Refresh.gameObject:SetActive(self._refreshEvent ~= nil and self._refreshTime < self._refreshLimit)
  self:UpdateWCSelectChipRefreshInfo()
end

function UIWarChessSelectChip:InitWCSelectChipSkip(skipEvent)
  self._skipEvent = skipEvent
  self.ui.btn_Skip.gameObject:SetActive(self._skipEvent ~= nil)
  self:UpdateWCSelectChipSkipInfo()
end

function UIWarChessSelectChip:_WCRefreshChipList(chipDataList)
  local function afterAnim()
    self._chipDataList = chipDataList
    
    self.selectChip = nil
    self._chipItemList = {}
    if self._oldChipListPos == nil then
      self._oldChipListPos = self.ui.obj_ChipList.transform.localPosition
    end
    self._selectChipPool:HideAll()
    for k, chipData in ipairs(chipDataList) do
      local chipItem = self._selectChipPool:GetOne()
      chipItem.gameObject.name = tostring(chipData.dataId)
      chipItem:Show()
      chipItem:InitWCChipDetail(k, chipData, self.resloader, self.__clickedPanelAction)
      chipItem:ShowWCChipDetailEff(5)
      chipItem:InitDissolveTweenSetting()
      chipItem:InitWCChipSelectState()
      table.insert(self._chipItemList, chipItem)
    end
    if #chipDataList ~= 1 then
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.obj_ChipList.transform)
      self.ui.obj_ChipList.transform.localPosition = Vector3.New(0, 40, 0)
      self.ui.layout_ChipList.enabled = false
    end
    self.ui.canvas_TeamList.alpha = 0
    if #chipDataList == 1 then
      self:_OnClickChipPanel(self._selectChipPool.listItem[1], chipDataList[1])
    end
  end
  
  if self._chipItemList ~= nil and #self._chipItemList > 0 then
    UIUtil.AddOneCover("UISelectChip")
    self:_WCCleanSelect()
    local waitingAnimNum = 0
    local isAddedCallback = false
    
    local function palyOver()
      waitingAnimNum = waitingAnimNum - 1
      if waitingAnimNum <= 0 then
        afterAnim()
        UIUtil.CloseOneCover("UISelectChip")
      end
    end
    
    for chipIndex, chipPanel in ipairs(self._chipItemList) do
      waitingAnimNum = waitingAnimNum + 1
      chipPanel:OnDissolveTweenCompleteAction(palyOver)
      isAddedCallback = true
      chipPanel:PlayDissolveTween()
      self.ui.canvas_TeamList:DOFade(0, 1):SetEase(cs_Ease.OutQuad)
    end
    AudioManager:PlayAudioById(1123)
    if not isAddedCallback then
      afterAnim()
    end
  else
    afterAnim()
  end
end

function UIWarChessSelectChip:_InitWCTeamList(chipItem)
  self._selectTeamPool:HideAll()
  local chipData = chipItem:GetWCChipDetailPanelData()
  for _, teamData in pairs(self._teamDataDic) do
    local selectTeamItem = self._selectTeamPool:GetOne()
    selectTeamItem:InitWCSelectTeamGetChip(teamData, chipData, self.resloader, chipItem.price)
    selectTeamItem:BindWCSelectTeamEvent(self.__selectChipAction)
  end
end

function UIWarChessSelectChip:UpdateWCSelectChipRefreshInfo()
  if self._refreshEvent == nil then
    return
  end
  if self._refreshTime >= self._refreshLimit then
    self.ui.btn_Refresh.gameObject:SetActive(false)
    return
  end
  local costMoney = self._shopConinCfg.init_fresh_price + self._refreshTime * self._shopConinCfg.increase_fresh_price
  local money = WarChessManager:GetWarChessCtrl().backPackCtrl:GetWCItemNum(self._shopConinCfg.item1)
  self.__isLackRefreshItem = 0 < costMoney and costMoney > money
  self.ui.img_Lack:SetActive(self.__isLackRefreshItem)
  self.ui.tex_RefreshPay.text = tostring(costMoney)
  self.ui.tex_Refresh:SetIndex(self.__isLackRefreshItem and 1 or 0)
end

function UIWarChessSelectChip:UpdateWCSelectChipSkipInfo()
  if self._skipEvent == nil then
    return
  end
  local maxChipSold = 0
  for k, chipData in pairs(self._chipDataList) do
    local count = chipData:GetChipCount()
    local price = self._shopConinCfg.function_over_payback[count] or 0
    if maxChipSold < price then
      maxChipSold = price
    end
  end
  if maxChipSold == 0 then
    return
  end
  self.ui.tex_GiveupPrice.text = tostring(maxChipSold)
end

function UIWarChessSelectChip:OnClickShowMap()
  local isOpen = self.ui.frameNode.activeInHierarchy
  self.ui.tex_MapBtnName:SetIndex(isOpen and 1 or 0)
  self.ui.frameNode:SetActive(not isOpen)
end

function UIWarChessSelectChip:_OnClickChipPanel(chipItem, chipData)
  if self._selectChipItem == chipItem then
    return
  end
  if self._selectChipItem ~= nil then
    self._selectChipItem:SetWCChipSelectState(false, 0.3)
  else
    self.ui.obj_ChipList.transform:DOLocalMove(self._oldChipListPos, 0.3):SetEase(cs_Ease.OutQuad)
    self.ui.canvas_TeamList.gameObject.transform:DOLocalMoveY(-245, 0.3):From():SetEase(cs_Ease.OutQuad)
    self.ui.canvas_TeamList:DOFade(1, 0.3):SetEase(cs_Ease.OutQuad)
    for k, chipObj in ipairs(self._chipItemList) do
      if chipObj ~= chipItem then
        chipObj.ui.img_unSelected.color = Color.New(0, 0, 0, 0.4)
      end
    end
  end
  self._selectChipItem = chipItem
  if self._selectChipItem == nil then
    return
  end
  self._selectChipItem:SetWCChipSelectState(true, 0.3)
  self:_InitWCTeamList(self._selectChipItem)
end

function UIWarChessSelectChip:_OnSelectTeamChip(teamItem, teamData)
  if self._selectChipItem == nil then
    return
  end
  local index = self._selectChipItem.index
  local chipData = self._selectChipItem:GetWCChipDetailPanelData()
  self._selectEvent(index, teamData, function()
    self:Delete()
  end)
end

function UIWarChessSelectChip:_OnClickWCMap()
end

function UIWarChessSelectChip:_OnClickWCSkipChip()
  self:_OnClickChipPanel()
  if self._isGiveUp then
    return
  end
  self._isGiveUp = true
  if self._skipEvent ~= nil then
    UIUtil.AddOneCover("UISelectChip")
    self._skipEvent(function(afterAnimCallabck)
      self:_WCCleanSelect()
      
      local function afterAnim()
        self:Delete()
        UIUtil.CloseOneCover("UISelectChip")
        if afterAnimCallabck ~= nil then
          afterAnimCallabck()
        end
      end
      
      local waitingAnimNum = 0
      local isAddedCallback = false
      
      local function palyOver()
        waitingAnimNum = waitingAnimNum - 1
        if waitingAnimNum <= 0 then
          afterAnim()
        end
      end
      
      for chipIndex, chipPanel in ipairs(self._chipItemList) do
        waitingAnimNum = waitingAnimNum + 1
        chipPanel:OnDissolveTweenCompleteAction(palyOver)
        isAddedCallback = true
        chipPanel:PlayDissolveTween()
        self.ui.canvas_TeamList:DOFade(0, 1):SetEase(cs_Ease.OutQuad)
      end
      AudioManager:PlayAudioById(1123)
      if not isAddedCallback then
        afterAnim()
      end
    end)
  end
end

function UIWarChessSelectChip:_OnClickWCRefreshChip()
  if self._refreshEvent ~= nil and self._refreshTime < self._refreshLimit then
    if self.__isLackRefreshItem then
      return
    end
    self._refreshTime = self._refreshTime + 1
    self:_OnClickChipPanel()
    self.ui.canvas_TeamList:DOFade(0, 0.3):SetEase(cs_Ease.OutQuad)
    self._refreshEvent()
  end
end

function UIWarChessSelectChip:_WCCleanSelect()
  for _, v in pairs(self._chipItemList) do
    v:UnSelectAlpha(false)
  end
end

function UIWarChessSelectChip:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_ItemNumChange, self._updateWCSelectChipRefreshInfo)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self._selectTeamPool:DeleteAll()
  self.ui.canvas_TeamList:DOKill()
  self.ui.canvas_TeamList.gameObject.transform:DOKill()
  self.ui.obj_ChipList.transform:DOKill()
  for _, chipObj in ipairs(self._chipItemList) do
    chipObj:KillDOTween()
  end
  if self._selectChipPool ~= nil then
    self._selectChipPool:HideAll()
  end
  self._chipItemList = nil
  base.OnDelete(self)
end

return UIWarChessSelectChip

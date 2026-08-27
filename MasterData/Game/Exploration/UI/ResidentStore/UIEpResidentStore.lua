local UIEpResidentStore = class("UIEpResidentStore", UIBaseWindow)
local base = UIBaseWindow
local UISelectChipItem = require("Game.Exploration.UI.Base.UISelectChipItem")
local UINEpRSLevelPreview = require("Game.Exploration.UI.ResidentStore.StoreLevelPreview.UINEpRSLevelPreview")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local CS_ResLoader = CS.ResLoader

function UIEpResidentStore:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self._OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_ChipRefresh, self, self._OnClickRefresh)
  UIUtil.AddButtonListener(self.ui.btn_LevelUp, self, self._OnClickLevelUp)
  UIUtil.AddButtonListener(self.ui.btn_Preview, self, self._OnClickPreviewLevel)
  self.resLoader = CS_ResLoader.Create()
  self.ui.selectChipItem:SetActive(false)
  self.chipItemPool = UIItemPool.New(UISelectChipItem, self.ui.selectChipItem)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
  self._OnClickLockItemFunc = BindCallback(self, self._OnClickLockItem)
  self.ui.obj_Purchased:SetActive(false)
  self.ui.tex_RefreshPay.text = tostring(ConfigData.game_config.epResidentStoreRefreshCost)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  if ExplorationManager:IsInTDExp() then
    self.transform.pivot = self.ui.tower_pivot
  else
    self.transform.pivot = self.ui.normal_pivot
  end
end

function UIEpResidentStore:OnShow()
  base.OnShow(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
  if not ExplorationManager:IsInExplorationTD() then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow ~= nil then
    stateInfoWindow.chipList:ShowDungeonChipListSellTween(true)
  end
end

function UIEpResidentStore:OnHide()
  base.OnHide(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
  if not ExplorationManager:IsInExplorationTD() then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow ~= nil then
    stateInfoWindow.chipList:ShowDungeonChipListSellTween(false)
  end
end

function UIEpResidentStore:InitEpResidentStore(residentStoreCtrl)
  self.residentStoreCtrl = residentStoreCtrl
end

function UIEpResidentStore:SetEpResidentStoreCloseFunc(closeCallback)
  self.closeCallback = closeCallback
end

function UIEpResidentStore:UpdEpResidentStore(storeDataList, level, exp, showRefreshTween, isOpen)
  if self.residentStoreCtrl ~= nil then
    local refreshPrice = self.residentStoreCtrl:GetResidentStoreRefreshPrice()
    self.ui.tex_RefreshPay.text = tostring(refreshPrice)
    self:UpdEpRTRefreshBtnState(refreshPrice)
  end
  self.storeDataList = storeDataList
  self.level = level
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local tweenIndex = 0
  for k, storeData in ipairs(storeDataList) do
    local chipItem = self.chipItemPool.listItem[k]
    if chipItem == nil then
      chipItem = self.chipItemPool:GetOne()
    end
    local lockd = storeData.locked
    
    local function updItemFunc()
      chipItem:InitSelectChipItem(k, storeData.chipData, dynPlayer, self.resLoader, self._OnClickChipItemFunc, self._OnClickLockItemFunc, not storeData.sold, true)
      chipItem:SetSelectChipItemSold(storeData.sold, self.ui.obj_Purchased)
      chipItem:SetSelectChipItemLock(storeData.locked)
      chipItem.panel:ShowEpChipDetailEff(5)
      local isHadChip = dynPlayer.chipDic[storeData.chipData.dataId] ~= nil
      local chipShowState = isHadChip and ChipEnum.eChipShowState.UpState or ChipEnum.eChipShowState.NewState
      chipItem:SetObjNewTagActive(not storeData.sold, chipShowState)
    end
    
    if showRefreshTween and not lockd then
      chipItem.panel:ShowChipPanelRefreshTween(updItemFunc, tweenIndex, isOpen)
      tweenIndex = tweenIndex + 1
    else
      updItemFunc()
    end
  end
  local shopCfg = self.residentStoreCtrl:GetResidentStoreCfg()[level]
  if shopCfg == nil then
    error("Cant get GetResidentStoreCfg, level = " .. tostring(level))
    return
  end
  for k, textInfo in ipairs(self.ui.chipRateTextList) do
    textInfo:SetIndex(0, tostring(FormatNum(shopCfg.function_drop_ratio[k] / 10)))
  end
  if level >= self.residentStoreCtrl:GetResidentStoreCfg().maxLevel then
    self.ui.tex_Level:SetIndex(1)
    self.ui.img_ExpBar.fillAmount = 1
    self.ui.pay:SetActive(false)
    self.ui.tex_EXP.text.text = ""
  else
    self.ui.tex_Level:SetIndex(0, tostring(level))
    local nextLvCfg = self.residentStoreCtrl:GetResidentStoreCfg()[level + 1]
    if nextLvCfg == nil then
      error("Cant get GetResidentStoreCfg, level = " .. tostring(level + 1))
      return
    end
    local needExp = nextLvCfg.exp - exp
    self.ui.pay:SetActive(true)
    self.ui.tex_LvUpPay.text = tostring(math.ceil(ConfigData.game_config.epResidentStoreBuyExpCost * needExp))
    local curLvExp = exp - shopCfg.exp
    local curLvExpTotal = nextLvCfg.exp - shopCfg.exp
    self.ui.img_ExpBar.fillAmount = curLvExp / curLvExpTotal
    self.ui.tex_EXP:SetIndex(0, tostring(curLvExp), tostring(curLvExpTotal))
  end
end

function UIEpResidentStore:UpdEpRTRefreshBtnState(curCost)
  local curMoney = ExplorationManager:GetDynPlayer():GetMoneyCount()
  local canRefresh = curCost <= curMoney
  self.ui.img_Lack:SetActive(not canRefresh)
  self.ui.btn_ChipRefresh.enabled = canRefresh
  self.ui.tex_Refresh:SetIndex(canRefresh and 0 or 1)
end

function UIEpResidentStore:_OnClickChipItem(chipPanel)
  if chipPanel == nil then
    return
  end
  self:_OnComfirmClick(chipPanel)
end

function UIEpResidentStore:_OnComfirmClick(chipPanel)
  local chipItemTran = chipPanel:GetChipItemTransform()
  local chipData = chipPanel:GetChipDetailPanelData()
  self.residentStoreCtrl:ReqResidentStorePurchase(chipPanel.index, function()
    local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if dungeonStateWindow ~= nil then
      local uiPos = dungeonStateWindow.transform:InverseTransformPoint(chipItemTran.position)
      local localScale = chipItemTran.localScale
      dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale)
    end
    local selectChipItem = self.chipItemPool.listItem[chipPanel.index]
    selectChipItem:SetSelectChipItemSold(true, self.ui.obj_Purchased)
    selectChipItem:ShowSelectChipItemLockBtn(false)
    for _, v in pairs(self.chipItemPool.listItem) do
      v.panel:OnSelectChipChanged(false)
      v.panel:UnSelectAlpha(false)
    end
  end)
end

function UIEpResidentStore:_OnClickLockItem(chipItem)
  self.residentStoreCtrl:ReqEpResidentStoreLock(chipItem.idx, function(locked)
    chipItem:SetSelectChipItemLock(locked)
  end)
end

function UIEpResidentStore:_OnClickLevelUp()
  self.residentStoreCtrl:ReqEpResidentStoreLvUp()
end

function UIEpResidentStore:_OnClickPreviewLevel()
  if self.levelPreviewNode == nil then
    local levelPreviewNode = UINEpRSLevelPreview.New()
    levelPreviewNode:Init(self.ui.logicPreviewNode)
    self.levelPreviewNode = levelPreviewNode
  end
  self.levelPreviewNode:InitEpRSLevelPreview(self.residentStoreCtrl:GetResidentStoreCfg(), self.level)
  self.levelPreviewNode:Show()
end

function UIEpResidentStore:_OnClickRefresh()
  self.residentStoreCtrl:ReqEpResidentStoreRefresh()
end

function UIEpResidentStore:OnChipDetailActiveChange(bool)
  if bool then
    self:Hide()
  else
    self:Show()
  end
end

function UIEpResidentStore:BackAction()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow ~= nil then
    stateInfoWindow.chipList:TryPlayDungeonChipListSellCloseTween()
  end
  self:Delete()
end

function UIEpResidentStore:_OnClickReturn()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEpResidentStore:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.chipItemPool:DeleteAll()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  if self.levelPreviewNode ~= nil then
    self.levelPreviewNode:Delete()
  end
  base.OnDelete(self)
end

return UIEpResidentStore

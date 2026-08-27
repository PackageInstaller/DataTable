local UISelectChipSuit = class("UISelectChipSuit", UIBaseWindow)
local base = UIBaseWindow
local UINSelectChipSuitList = require("Game.DailyDungeon.UI.SelectChipSuit.List.UINSelectChipSuitList")
local UINSelectChipSuitItem = require("Game.DailyDungeon.UI.SelectChipSuit.UINSelectChipSuitItem")
local DynChipSuit = require("Game.Exploration.Data.ChipSuit.DynChipSuit")
local cs_Ease = CS.DG.Tweening.Ease

function UISelectChipSuit:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self._OnClickBack)
  self.selectChipSuitList = UINSelectChipSuitList.New(self)
  self.selectChipSuitList:Init(self.ui.suitDetailScroll)
  self.ui.suitItem:SetActive(false)
  self.suitItemPool = UIItemPool.New(UINSelectChipSuitItem, self.ui.suitItem)
  self.ui.fX_UINBaseItem:SetActive(false)
  local roteX = self.ui.modifier.rotation.x
  self.ui.fX_UINBaseItem.transform.rotation = Quaternion.Euler(roteX, 0, 0)
  self._onListItemClick = BindCallback(self, self._OnListItemClick)
  self._onSuitItemClick = BindCallback(self, self._OnSuitItemClick)
end

function UISelectChipSuit:InitSelectChipSuit(dInterfaceData)
  self:_InitData(dInterfaceData)
  local selectMaxNum = dInterfaceData:GetChipSuitSelectMax()
  self.selectMaxNum = selectMaxNum
  self.selectChipSuitList:SetLockedSuitDataList(self.__lockedChipPoolList, self.__lockedChipPoolUnlockInfoList)
  self.selectChipSuitList:InitSelectChipSuitList(self.seChipSuitDataList, self.lastSelectedSuitDic, selectMaxNum, self._onListItemClick, self.lastChipSuitIdList)
  self.suitItemPool:HideAll()
  for i = 1, selectMaxNum do
    self.suitItemPool:GetOne()
  end
  self:UpdSelectedChipSuit()
end

function UISelectChipSuit:_InitData(dInterfaceData)
  local seChipSuitDataList = {}
  local seChipSuitDataDic = {}
  self.__dInterfaceData = dInterfaceData
  self.lastSelectedSuitDicOrigin = dInterfaceData:GetLastSelectSuit()
  self.lastSelectedSuitDic = {}
  for suitTagId, v in pairs(self.lastSelectedSuitDicOrigin) do
    self.lastSelectedSuitDic[suitTagId] = v
  end
  local lastChipSuitIdList = {}
  for suitId, index in pairs(self.lastSelectedSuitDic) do
    table.insert(lastChipSuitIdList, suitId)
  end
  table.sort(lastChipSuitIdList, function(a, b)
    return self.lastSelectedSuitDic[a] < self.lastSelectedSuitDic[b]
  end)
  self.lastChipSuitIdList = lastChipSuitIdList
  local chipPool = dInterfaceData:GetChipSuitPool()
  if chipPool ~= nil then
    for k, chipTagId in ipairs(chipPool) do
      local dynChipSuitData = DynChipSuit.New(chipTagId, 1)
      dynChipSuitData:SetChipSuitCount(dynChipSuitData:GetChipSuitMaxCount())
      local seChipSuitData = {
        dynChipSuitData = dynChipSuitData,
        selectNumMax = dInterfaceData:GetChipSuitNumById(chipTagId),
        selectNumCur = dInterfaceData:GetChipSuitSelectedCount(chipTagId),
        chipQuality = dInterfaceData:GetChipSuitSelectQuality(chipTagId),
        notShowCouldUseTime = dInterfaceData:GetIsNotShowCouldUseTime(),
        isRecommend = dInterfaceData:GetChipSuitIsRecommend(chipTagId)
      }
      table.insert(seChipSuitDataList, seChipSuitData)
      seChipSuitDataDic[chipTagId] = dynChipSuitData
    end
  end
  self.seChipSuitDataDic = seChipSuitDataDic
  self.seChipSuitDataList = seChipSuitDataList
  local lockedChipPool = dInterfaceData:GetLockedChipSuitPool()
  if lockedChipPool ~= nil then
    self.__lockedChipPoolList = lockedChipPool
    self.__lockedChipPoolUnlockInfoList = dInterfaceData:GetLockedChipSuitPoolUnlockInfoList()
  end
end

function UISelectChipSuit:UpdSelectedChipSuit()
  self.itemDic = {}
  if self.ui.fX_UINBaseItem.activeSelf then
    self.ui.fX_UINBaseItem:SetActive(false)
  end
  local emptyIndex = 0
  for k = 1, self.selectMaxNum do
    local id = self.lastChipSuitIdList[k]
    local suitItem = self.suitItemPool.listItem[k]
    local dynChipSuitData
    if id ~= nil then
      dynChipSuitData = self.seChipSuitDataDic[id]
      self.itemDic[id] = suitItem
    elseif emptyIndex == 0 then
      emptyIndex = k
    end
    suitItem:InitSelectChipSuitItem(dynChipSuitData, self._onSuitItemClick)
  end
  local emptyItem = self.suitItemPool.listItem[emptyIndex]
  local hasEmptyItem = emptyItem ~= nil and true or false
  self.ui.tran_TriHolder.gameObject:SetActive(hasEmptyItem)
  if emptyItem ~= nil then
    self.ui.tran_TriHolder:SetParent(emptyItem:GetEmptyTransform())
    self.ui.tran_TriHolder.localPosition = Vector3.zero
    self.ui.tran_TriHolder.anchoredPosition = Vector2.zero
    self.ui.ani_Tri:DORestart()
  end
end

function UISelectChipSuit:_OnClickConfirm()
  if table.count(self.lastSelectedSuitDicOrigin) == table.count(self.lastSelectedSuitDic) then
    local allSame = true
    for suitTagId, v in pairs(self.lastSelectedSuitDicOrigin) do
      if self.lastSelectedSuitDic[suitTagId] ~= v then
        allSame = false
        break
      end
    end
    if allSame then
      self:Hide()
      return
    end
  end
  local chipTagDic = self.lastSelectedSuitDic
  NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_BATTLE_SelectChipGroup(chipTagDic, function()
    self.__dInterfaceData:SaveLastSelectSuit(chipTagDic)
    self:Hide()
    local uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
    if uiBattle ~= nil then
      uiBattle:EndChipEft()
      uiBattle:StartChipEft()
    end
    MsgCenter:Broadcast(eMsgEventId.OnEpChipSuitUpdate)
  end)
end

function UISelectChipSuit:_OnListItemClick(chipTagId)
  local item = self.itemDic[chipTagId]
  if self.oldItem ~= nil then
    local oldIcon = self.oldItem:GetSelectChipSuitIcon()
    oldIcon.transform:DOKill()
  end
  if item ~= nil then
    self.oldItem = item
    self.ui.fX_UINBaseItem.transform:SetParent(item.transform)
    self.ui.fX_UINBaseItem.transform.anchoredPosition = Vector2.zero
    self.ui.fX_UINBaseItem:SetActive(true)
    local icon = item:GetSelectChipSuitIcon()
    icon.transform.localScale = Vector3.one
    icon.transform:DOScale(Vector3.New(0.5, 0.5, 1), 0.8):From():SetEase(cs_Ease.OutElastic)
  end
end

function UISelectChipSuit:_OnSuitItemClick(dynChipSuitData)
  if dynChipSuitData == nil then
    return
  end
  self.selectChipSuitList:TrySelectChipSuitItem(dynChipSuitData.tagId, false)
  self.selectChipSuitList:RefreshSelectChipSuitList()
end

function UISelectChipSuit:_OnClickBack()
  self:Hide()
end

function UISelectChipSuit:OnShow()
  base.OnShow(self)
  UIManager:HideWindow(UIWindowTypeID.BattleEnemyDetail)
end

function UISelectChipSuit:OnDelete()
  if self.oldItem ~= nil then
    local oldIcon = self.oldItem:GetSelectChipSuitIcon()
    oldIcon.transform:DOKill()
  end
  self.selectChipSuitList:Delete()
  self.suitItemPool:DeleteAll()
  self.ui.ani_Tri:DOKill()
  base.OnDelete(self)
end

return UISelectChipSuit

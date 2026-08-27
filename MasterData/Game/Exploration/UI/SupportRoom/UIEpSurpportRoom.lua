local UIEpSurpportRoom = class("UIEpSurpportRoom", UIBaseWindow)
local base = UIBaseWindow
local UINEpSptRoomHeroItem = require("Game.Exploration.UI.SupportRoom.UINEpSptRoomHeroItem")
local UINEpSptRoomHeroDetail = require("Game.Exploration.UI.SupportRoom.UINEpSptRoomHeroDetail")
local DynHero = require("Game.Exploration.Data.DynHero")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon

function UIEpSurpportRoom:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickCancel)
  self._confirmBtnColor = self.ui.img_Confirm.color
  self._supportHeroMaxNum = ConfigData.game_config.supportHeroMaxNum
  self.ui.heroItem:SetActive(false)
  self.heroItemPool = UIItemPool.New(UINEpSptRoomHeroItem, self.ui.heroItem)
  self.heroDetailNode = UINEpSptRoomHeroDetail.New()
  self.heroDetailNode:Init(self.ui.heroDetail)
  self.heroDetailNode:Hide()
  self.resLoader = cs_ResLoader.Create()
  self._clickHeroFunc = BindCallback(self, self._OnClickHeroItem)
end

function UIEpSurpportRoom:GetSupportRoomData()
  return self.inFormationDic, self.maxHeroCount, self._supHeroItemList
end

function UIEpSurpportRoom:_InitBase(dynPlayer, epSptCtrl)
  self.epSptCtrl = epSptCtrl
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
  self.inFormationDic = {}
  self.currentHeroList = dynPlayer.heroList
  self.selectedSptHeroDic = {}
  self.currentHeroDic = {}
  self.maxHeroCount = dynPlayer:GetFmtMaxHeroNum()
  local repeatHeroItemDic = {}
  local tempHeroItemDic = {}
  
  local function tryAddRepeatHeroItem(heroId, heroItem)
    if tempHeroItemDic[heroId] ~= nil then
      local heroItemList = repeatHeroItemDic[heroId]
      if heroItemList == nil then
        heroItemList = {
          tempHeroItemDic[heroId]
        }
        repeatHeroItemDic[heroId] = heroItemList
      end
      table.insert(heroItemList, heroItem)
      return true
    else
      tempHeroItemDic[heroId] = heroItem
      return false
    end
  end
  
  self.repeatHeroItemDic = repeatHeroItemDic
  for k, dynHero in ipairs(dynPlayer.heroList) do
    local heroItem = self.heroItemPool:GetOne()
    heroItem:InitEpSptRoomHeroItem(dynHero, self.resLoader, self._clickHeroFunc)
    heroItem:SetEpSptRoomHeroItemSelect(true)
    heroItem.transform:SetParent(self.ui.currentList)
    heroItem.gameObject.name = tostring(k)
    self.inFormationDic[dynHero.dataId] = true
    self.currentHeroDic[dynHero] = true
    tryAddRepeatHeroItem(dynHero.dataId, heroItem)
  end
  self:_UpdateHeroNum()
  return tryAddRepeatHeroItem
end

function UIEpSurpportRoom:InitEpSurpportRoomEx(dynPlayer, supportHeroExList, epSptCtrl)
  self:_InitBase(dynPlayer, epSptCtrl)
  self._supHeroItemList = {}
  for k, heroData in ipairs(supportHeroExList) do
    local heroItem = self.heroItemPool:GetOne()
    heroItem:InitEpSptRoomHeroExItem(heroData, self.resLoader, self._clickHeroFunc)
    heroItem.transform:SetParent(self.ui.supportList)
    heroItem.gameObject.name = tostring(k)
    table.insert(self._supHeroItemList, heroItem)
  end
  
  function self.__cancleFunc()
    self.epSptCtrl:ReqChangeSupportExHero(table.emptytable, table.emptytable)
  end
  
  function self.__confirmFunc(curHeroNum)
    local addNum, removeNum = 0, 0
    local quitHeroUidDic, enterIdDic = {}, {}
    for k, heroData in ipairs(supportHeroExList) do
      if self.inFormationDic[heroData.dataId] == false then
        enterIdDic[heroData.dataId] = true
        addNum = addNum + 1
      end
    end
    for k, dynHero in pairs(self.currentHeroList) do
      if self.inFormationDic[dynHero.dataId] ~= true then
        quitHeroUidDic[dynHero.uid] = true
        if self.inFormationDic[dynHero.dataId] ~= false then
          removeNum = removeNum + 1
        end
      end
    end
    
    local function confirmFunc()
      self.epSptCtrl:ReqChangeSupportExHero(quitHeroUidDic, enterIdDic)
    end
    
    if self:_TryShowConfimWin(addNum, removeNum, curHeroNum, confirmFunc) then
      return
    end
    confirmFunc()
  end
end

function UIEpSurpportRoom:InitEpSurpportRoom(dynPlayer, supportHeroList, epSptCtrl)
  local tryAddRepeatHeroItemFunc = self:_InitBase(dynPlayer, epSptCtrl)
  self._supHeroItemList = {}
  for k, dynHero in ipairs(supportHeroList) do
    local heroItem = self.heroItemPool:GetOne()
    heroItem:InitEpSptRoomHeroItem(dynHero, self.resLoader, self._clickHeroFunc)
    heroItem.transform:SetParent(self.ui.supportList)
    heroItem.gameObject.name = tostring(k)
    if tryAddRepeatHeroItemFunc(dynHero.dataId, heroItem) then
      heroItem:SetEpSptRoomHeroItemHas(true)
    else
      table.insert(self._supHeroItemList, heroItem)
    end
  end
  
  function self.__cancleFunc()
    self.epSptCtrl:ReqChangeSupportHero(table.emptytable, table.emptytable)
  end
  
  function self.__confirmFunc(curHeroNum)
    local addNum, removeNum = 0, 0
    local quitHeroUidList = {}
    local enterIdList = {}
    for k, dynHero in ipairs(supportHeroList) do
      if self.inFormationDic[dynHero.dataId] == false then
        table.insert(enterIdList, k - 1)
        addNum = addNum + 1
      end
    end
    for k, dynHero in pairs(self.currentHeroList) do
      if self.inFormationDic[dynHero.dataId] ~= true then
        table.insert(quitHeroUidList, dynHero.uid)
        if self.inFormationDic[dynHero.dataId] ~= false then
          removeNum = removeNum + 1
        end
      end
    end
    
    local function confirmFunc()
      self.epSptCtrl:ReqChangeSupportHero(quitHeroUidList, enterIdList)
    end
    
    if self:_TryShowConfimWin(addNum, removeNum, curHeroNum, confirmFunc) then
      return
    end
    confirmFunc()
  end
end

function UIEpSurpportRoom:InitEpSurpportRoomForWC(dynPlayer, supportHeroMixedList, cancleFunc, confirmFunc)
  self:_InitBase(dynPlayer)
  self._supHeroItemList = {}
  self._supportHeroMaxNum = dynPlayer:GetFmtMaxHeroNum()
  for heroId, mixedHeroData in pairs(supportHeroMixedList) do
    local heroItem = self.heroItemPool:GetOne()
    if IsInstanceOfClass(mixedHeroData, DynHero) then
      heroItem:InitEpSptRoomHeroItem(mixedHeroData, self.resLoader, self._clickHeroFunc)
    else
      heroItem:InitEpSptRoomHeroExItem(mixedHeroData, self.resLoader, self._clickHeroFunc)
    end
    heroItem.transform:SetParent(self.ui.supportList)
    heroItem.gameObject.name = tostring(heroId)
    table.insert(self._supHeroItemList, heroItem)
  end
  self.__cancleFunc = cancleFunc
  
  function self.__confirmFunc(curHeroNum)
    local addNum, removeNum = 0, 0
    local quitHeroUidList = {}
    local quitHeroIdList = {}
    local enterIdList = {}
    for _, mixedHeroData in pairs(supportHeroMixedList) do
      if self.inFormationDic[mixedHeroData.dataId] == false then
        table.insert(enterIdList, mixedHeroData.dataId)
        addNum = addNum + 1
      end
    end
    for _, dynHero in pairs(self.currentHeroList) do
      if self.inFormationDic[dynHero.dataId] ~= true then
        table.insert(quitHeroUidList, dynHero.uid)
        table.insert(quitHeroIdList, dynHero.dataId)
        if self.inFormationDic[dynHero.dataId] ~= false then
          removeNum = removeNum + 1
        end
      end
    end
    local myConfirmFunc = BindCallback(confirmFunc, enterIdList, quitHeroIdList)
    if self:_TryShowConfimWin(addNum, removeNum, curHeroNum, myConfirmFunc) then
      return
    end
    myConfirmFunc()
  end
end

function UIEpSurpportRoom:_UpdateHeroNum()
  self.ui.tex_Limit.text = tostring(table.count(self.inFormationDic)) .. "/" .. tostring(self.maxHeroCount)
end

function UIEpSurpportRoom:_SetRepeatHeroHas(heroId, heroItem, has)
  local repeatHeroItemList = self.repeatHeroItemDic[heroId]
  if repeatHeroItemList ~= nil then
    for k, item in ipairs(repeatHeroItemList) do
      if item ~= heroItem then
        item:SetEpSptRoomHeroItemHas(has)
      end
    end
  end
end

function UIEpSurpportRoom:_OnClickHeroItem(heroItem, dynHeroData, fightPower, isHeroData)
  if self.inFormationDic[dynHeroData.dataId] == nil then
    if table.count(self.inFormationDic) >= self.maxHeroCount then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Formation_MaxHeroCount))
      return
    end
    if self.currentHeroDic[dynHeroData] ~= nil then
      self.inFormationDic[dynHeroData.dataId] = true
    else
      local limitNum = self._supportHeroMaxNum
      if limitNum <= table.count(self.selectedSptHeroDic) then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(168), limitNum))
        return
      end
      self.inFormationDic[dynHeroData.dataId] = false
      self.selectedSptHeroDic[dynHeroData] = true
    end
    heroItem:SetEpSptRoomHeroItemSelect(true)
    self:_SetRepeatHeroHas(dynHeroData.dataId, heroItem, true)
    self.heroDetailNode:Show()
    if isHeroData then
      self.heroDetailNode:InitEpSptExRoomHeroDetail(dynHeroData, self.resLoader, fightPower)
    else
      self.heroDetailNode:InitEpSptRoomHeroDetail(dynHeroData, self.resLoader, fightPower)
    end
    AudioManager:PlayAudioById(1059)
  else
    heroItem:SetEpSptRoomHeroItemSelect(false)
    self.inFormationDic[dynHeroData.dataId] = nil
    self.selectedSptHeroDic[dynHeroData] = nil
    self:_SetRepeatHeroHas(dynHeroData.dataId, heroItem, false)
    self.heroDetailNode:Hide()
  end
  local canConfirm = table.count(self.inFormationDic) >= #self.currentHeroList
  self.ui.img_Confirm.color = canConfirm and self._confirmBtnColor or Color.gray
  self:_UpdateHeroNum()
end

function UIEpSurpportRoom:EpSupportConfirm()
  self:_OnClickConfirm()
end

function UIEpSurpportRoom:_OnClickConfirm()
  local curHeroNum = table.count(self.inFormationDic)
  if curHeroNum < #self.currentHeroList then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(169))
    return
  end
  if self.__confirmFunc ~= nil then
    self.__confirmFunc(curHeroNum)
  end
end

function UIEpSurpportRoom:_TryShowConfimWin(addNum, removeNum, curHeroNum, confirmFunc)
  if curHeroNum < self.maxHeroCount and (addNum < self._supportHeroMaxNum or 0 < removeNum) then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(765), confirmFunc)
    end)
    return true
  end
  return false
end

function UIEpSurpportRoom:EpSupportCancel()
  self:_OnClickCancel()
end

function UIEpSurpportRoom:_OnClickCancel()
  if self.__cancleFunc ~= nil then
    self.__cancleFunc()
  end
end

function UIEpSurpportRoom:OnDelete()
  self.heroItemPool:DeleteAll()
  self.heroDetailNode:Delete()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  base.OnDelete(self)
end

return UIEpSurpportRoom

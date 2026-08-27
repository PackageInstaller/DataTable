local UIHeroChipOverflowWindow = class("UIHeroChipOverflowWindow", UIBaseWindow)
local base = UIBaseWindow
local UINHeroFragConvertItem = require("Game.ShopMain.HeroFragConvert.UINHeroFragConvertItem")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UIHeroChipOverflowWindow:OnInit()
  self.shopNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Shop)
  self.couldSelectFragList = nil
  self.selectedFragDic = nil
  self.converReulstDic = nil
  self.converReulstIdList = nil
  self.ui.ImputList.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.ImputList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.fragConvertItemDic = {}
  self.resultItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.UINBaseItemWithCount, false)
  self.addFragSelect = BindCallback(self, self.__addFragSelect)
  self.minFragSelect = BindCallback(self, self.__minFragSelect)
  UIUtil.AddButtonListener(self.ui.Btn_Confirm, self, self.__OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.Btn_Cancle, self, self.__OnClickCancle)
  UIUtil.SetTopStatus(self, self.Delete)
end

function UIHeroChipOverflowWindow:InitFragConvertCloseCallback(callback)
  self.__closeCallback = callback
end

function UIHeroChipOverflowWindow:InitByCouldUseFragList(fargIdList)
  self.fargIdList = fargIdList
  self.couldSelectFragList = {}
  self.selectedFragDic = {}
  self.converReulstDic = {}
  self.converReulstIdList = {}
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    local isCould, isFull, converDic = heroData:IsCouldFragConvert()
    if isCould then
      local weaponId, weaponData = heroData:GetSpecWeaponData()
      local fragId = heroData:GetHeroFragId()
      if self.fargIdList == nil or table.contain(self.fargIdList, fragId) then
        local fragNum = PlayerDataCenter:GetItemCount(fragId)
        local fragConvertData = {
          heroId = heroId,
          fragId = fragId,
          fragNum = fragNum,
          converDic = converDic,
          weaponData = weaponData
        }
        table.insert(self.couldSelectFragList, fragConvertData)
        if isFull then
          self:__addFragSelect(fragConvertData, fragNum)
        end
      end
    end
  end
  self:__RefreshFragConvertList()
  self:__RefreshConvertResultList()
end

function UIHeroChipOverflowWindow:__addFragSelect(fragConvertData, num)
  local fragId = fragConvertData.fragId
  local converDic = fragConvertData.converDic
  local realAddNum = num
  self.selectedFragDic[fragId] = (self.selectedFragDic[fragId] or 0) + num
  if self.selectedFragDic[fragId] > fragConvertData.fragNum then
    realAddNum = num - (self.selectedFragDic[fragId] - fragConvertData.fragNum)
    self.selectedFragDic[fragId] = fragConvertData.fragNum
  end
  for itemId, itemNum in pairs(converDic) do
    if self.converReulstDic[itemId] == nil or self.converReulstDic[itemId] == 0 then
      table.insert(self.converReulstIdList, itemId)
      table.sort(self.converReulstIdList)
    end
    self.converReulstDic[itemId] = (self.converReulstDic[itemId] or 0) + itemNum * realAddNum
  end
  self:__RefreshConvertResultList()
  return self.selectedFragDic[fragId]
end

function UIHeroChipOverflowWindow:__minFragSelect(fragConvertData, num)
  local fragId = fragConvertData.fragId
  local converDic = fragConvertData.converDic
  self.selectedFragDic[fragId] = (self.selectedFragDic[fragId] or 0) - num
  if self.selectedFragDic[fragId] <= 0 then
    self.selectedFragDic[fragId] = nil
  end
  for itemId, itemNum in pairs(converDic) do
    self.converReulstDic[itemId] = (self.converReulstDic[itemId] or 0) - itemNum * num
    if 0 >= self.converReulstDic[itemId] then
      self.converReulstDic[itemId] = nil
      table.removebyvalue(self.converReulstIdList, itemId)
    end
  end
  self:__RefreshConvertResultList()
  return self.selectedFragDic[fragId] or 0
end

function UIHeroChipOverflowWindow:__RefreshConvertResultList()
  self.resultItemPool:HideAll()
  for _, itemId in ipairs(self.converReulstIdList) do
    local itemCfg = ConfigData.item[itemId]
    local itemNum = self.converReulstDic[itemId]
    local resultItem = self.resultItemPool:GetOne(true)
    resultItem:InitItemWithCount(itemCfg, itemNum)
  end
end

function UIHeroChipOverflowWindow:__RefreshFragConvertList()
  self.ui.ImputList.totalCount = #self.couldSelectFragList
  self.ui.ImputList:RefillCells()
end

function UIHeroChipOverflowWindow:__OnNewItem(go)
  local fragConvertItem = UINHeroFragConvertItem.New()
  fragConvertItem:Init(go)
  fragConvertItem:InitHeroFragConvertItem(self.addFragSelect, self.minFragSelect)
  self.fragConvertItemDic[go] = fragConvertItem
end

function UIHeroChipOverflowWindow:__OnChangeItem(go, index)
  local fragConvertItem = self.fragConvertItemDic[go]
  if fragConvertItem == nil then
    error("Can't find fragConvertItem by gameObject")
    return
  end
  local fragConvertData = self.couldSelectFragList[index + 1]
  if fragConvertData == nil then
    error("Can't find fragConvertData by index, index = " .. tonumber(index))
  end
  local curSelectedNum = self.selectedFragDic[fragConvertData.fragId] or 0
  fragConvertItem:RefreshHeroFragConvertItem(fragConvertData, curSelectedNum)
end

function UIHeroChipOverflowWindow:__GetItemGoByIndex(index)
  local go = self.ui.ImputList:GetCellByIndex(index)
  if go ~= nil then
    return self.fragConvertItemDic[go]
  end
  return nil
end

function UIHeroChipOverflowWindow:__OnClickConfirm()
  self.shopNetCtrl:CS_Hero_Fragment_Redeem(self.selectedFragDic, function(args)
    MsgCenter:Broadcast(eMsgEventId.HeroFragConvert)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local rewards = args[0]
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(rewards)
      window:AddAndTryShowReward(CRData)
    end)
    self:InitByCouldUseFragList(self.fargIdList)
    if 0 >= #self.couldSelectFragList then
      self:__OnClickCancle()
    end
  end)
end

function UIHeroChipOverflowWindow:__OnClickCancle()
  self:Delete()
end

function UIHeroChipOverflowWindow:OnDelete()
  if self.__closeCallback ~= nil then
    self.__closeCallback()
  end
  base.OnDelete(self)
end

return UIHeroChipOverflowWindow

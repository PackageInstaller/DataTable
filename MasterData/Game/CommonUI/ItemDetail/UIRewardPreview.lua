local base = UIBaseWindow
local UIRewardPreview = class("UIRewardPreview", base)
local UINPreviewItem = require("Game.CommonUI.ItemDetail.UIRewardPreviewItem")

function UIRewardPreview:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self._OnClickClose)
  self.__OnItemClcik = BindCallback(self, self.OnItemClick)
  self.rewardPool = UIItemPool.New(UINPreviewItem, self.ui.rewardItem, false)
end

function UIRewardPreview:InitRewardPreview(itemId, rewardIdList, rewardNumList)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("item cfg is null,id:" .. tostring(itemId))
    return
  end
  local itemList = {}
  if itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift2 then
    self.ui.tex_title:SetIndex(1)
  elseif itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceBpSkin then
    self.ui.tex_title:SetIndex(1)
    for index, skinId in ipairs(rewardIdList) do
      local num = rewardNumList[index]
      local isHas = PlayerDataCenter.skinData:IsHaveSkin(skinId)
      local skinCfg = ConfigData.skin[skinId]
      local themId = skinCfg ~= nil and skinCfg.theme or ConfigData.game_config.defaultSkinThemId
      table.insert(itemList, {
        itemId = skinId,
        themId = themId,
        isHas = isHas,
        num = num
      })
    end
    table.sort(itemList, function(a, b)
      if a.isHas ~= b.isHas then
        return not a.isHas
      end
      if a.themId ~= b.themId then
        return a.themId < b.themId
      end
      return a.itemId < b.itemId
    end)
  elseif itemCfg.action_type == proto_csmsg_ItemActionType.ItemActionTypeMultChoiceNoDup then
    self.ui.tex_title:SetIndex(2)
    for index, rewardItemId in ipairs(rewardIdList) do
      local num = rewardNumList[index]
      local isHas = PlayerDataCenter:GetItemCount(rewardItemId, nil) > 0
      local order
      local itemCfg = ConfigData.item[rewardItemId]
      if itemCfg.type == eItemType.AvatarFrame then
        order = 1
      elseif itemCfg.type == eItemType.BackgroudPlate then
        order = 2
      elseif itemCfg.type == eItemType.DormFurniture then
        isHas = PlayerDataCenter.itemDic[rewardItemId] ~= nil
        order = 3
      else
        order = 9
      end
      table.insert(itemList, {
        itemId = rewardItemId,
        isHas = isHas,
        order = order,
        num = num
      })
    end
    table.sort(itemList, function(a, b)
      if a.isHas ~= b.isHas then
        return not a.isHas
      end
      if a.order ~= b.order then
        return a.order < b.order
      end
      return a.itemId < b.itemId
    end)
  else
    self.ui.tex_title:SetIndex(0)
  end
  self.rewardPool:HideAll()
  if itemList ~= nil and 0 < #itemList then
    for _, data in ipairs(itemList) do
      local itemCfg = ConfigData.item[data.itemId]
      if itemCfg ~= nil then
        local rewardItem = self.rewardPool:GetOne()
        local num = data.num
        local isHas = data.isHas
        if num <= 0 then
          rewardItem:InitItemWithCount(itemCfg, nil, self.__OnItemClcik)
        else
          rewardItem:InitItemWithCount(itemCfg, num, self.__OnItemClcik)
        end
        rewardItem:SetHasFlagObjActive(isHas)
      end
    end
  else
    for i = 1, table.count(rewardIdList) do
      local itemCfg = ConfigData.item[rewardIdList[i]]
      if itemCfg ~= nil then
        local rewardItem = self.rewardPool:GetOne()
        local num = rewardNumList[i]
        local isHas = false
        if itemCfg.type == eItemType.Skin and PlayerDataCenter.skinData:IsHaveSkin(itemCfg.id) then
          isHas = true
        end
        if num <= 0 then
          rewardItem:InitItemWithCount(itemCfg, nil, self.__OnItemClcik)
        else
          rewardItem:InitItemWithCount(itemCfg, num, self.__OnItemClcik)
        end
        rewardItem:SetHasFlagObjActive(isHas)
      end
    end
  end
end

function UIRewardPreview:InitRewardPreviewNotItem(rewardIdList, rewardNumList)
  self.rewardPool:HideAll()
  for i = 1, table.count(rewardIdList) do
    local itemCfg = ConfigData.item[rewardIdList[i]]
    if itemCfg ~= nil then
      local rewardItem = self.rewardPool:GetOne()
      local num = rewardNumList[i]
      if num <= 0 then
        rewardItem:InitItemWithCount(itemCfg, nil, self.__OnItemClcik)
      else
        rewardItem:InitItemWithCount(itemCfg, num, self.__OnItemClcik)
      end
    end
  end
end

function UIRewardPreview:OnItemClick(itemCfg)
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:SetNotNeedAnyJump(true)
    window:InitCommonItemDetail(itemCfg)
    window:HideUseGiftBtn()
  end)
end

function UIRewardPreview:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIRewardPreview:OnDelete()
  base.OnDelete(self)
  if self.rewardPool ~= nil then
    self.rewardPool:DeleteAll()
    self.rewardPool = nil
  end
end

return UIRewardPreview

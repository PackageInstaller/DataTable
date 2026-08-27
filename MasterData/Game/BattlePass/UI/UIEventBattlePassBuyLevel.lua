local UIEventBattlePassBuyLevel = class("UIEventBattlePassBuyLevel", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UIEventBattlePassBuyLevel:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnBtnBuyClicked)
  UIUtil.AddButtonListener(self.ui.btn_Sub, self, self.OnBtnSubClicked)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnBtnAddClicked)
  UIUtil.AddButtonListener(self.ui.btn_Max, self, self.OnBtnMaxClicked)
  UIUtil.AddButtonListener(self.ui.btn_Least, self, self.OnBtnMinClicked)
  UIUtil.SetTopStatus(self, self.OnReturnClick, {
    ConstGlobalItem.PaidItem,
    ConstGlobalItem.PaidSubItem
  }, nil, nil)
  UIUtil.SetCurButtonGroupActive(false)
  self.ui.baseItem:SetActive(false)
  self.baseRewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.baseItem)
  self.ui.textTitle:SetIndex(0)
end

function UIEventBattlePassBuyLevel:InitPassBuyLevelUI(passInfo)
  self.levelup = 0
  self.passInfo = passInfo
  self:UpdatePassLevelCount(1)
end

function UIEventBattlePassBuyLevel:UpdatePassLevelCount(levelup)
  if self.levelup == levelup then
    return
  end
  self.levelup = levelup
  local id = self.passInfo.id
  local curlevel = self.passInfo.level
  local nextlevel = curlevel + self.levelup
  self.ui.tex_CurLevel:SetIndex(0, tostring(curlevel))
  self.ui.tex_NextLevel:SetIndex(0, tostring(nextlevel))
  self.ui.tex_SelCount.text = tostring(self.levelup)
  local passCfg = self.passInfo.passCfg
  local itemCfg = ConfigData.item[passCfg.price_id]
  self.ui.img_Icon.sprite = CRH:GetSprite(itemCfg.small_icon)
  self.ui.tex_money.text = tostring(passCfg.price_num * self.levelup)
  local item_ids, item_nums = self.passInfo:GetPassLevelReward(curlevel + 1, nextlevel, true, self.passInfo.unlockSenior)
  local itemList, itemDic = self:_SortBPItemDicData(item_ids, item_nums)
  self.baseRewardPool:HideAll()
  for _, cfg in ipairs(itemList) do
    local itemCount = itemDic[cfg.id]
    local baseItem = self.baseRewardPool:GetOne()
    baseItem:InitItemWithCount(cfg, itemCount)
  end
end

function UIEventBattlePassBuyLevel:_SortBPItemDicData(item_ids, item_nums)
  local itemList = {}
  local itemDic = {}
  for idx, id in pairs(item_ids) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(id))
    else
      itemDic[id] = item_nums[idx]
      table.insert(itemList, itemCfg)
    end
  end
  return CommonUtil.DefaultItemsSort(itemList), itemDic
end

function UIEventBattlePassBuyLevel:OnBtnSubClicked()
  if self.levelup == 1 then
    return
  end
  self:UpdatePassLevelCount(self.levelup - 1)
end

function UIEventBattlePassBuyLevel:OnBtnAddClicked()
  if self.levelup >= self.passInfo.maxlevel - self.passInfo.level then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(327))
    return
  end
  self:UpdatePassLevelCount(self.levelup + 1)
end

function UIEventBattlePassBuyLevel:OnBtnMaxClicked()
  if self.passInfo:IsPassFullLevel() then
    return
  end
  self:UpdatePassLevelCount(self.passInfo.maxlevel - self.passInfo.level)
end

function UIEventBattlePassBuyLevel:OnBtnMinClicked()
  if self.levelup == 1 then
    return
  end
  self:UpdatePassLevelCount(1)
end

function UIEventBattlePassBuyLevel:OnBtnBuyClicked()
  if self.passInfo:IsPassFullLevel() then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(325))
    return
  end
  local passCfg = self.passInfo.passCfg
  local haveCount = PlayerDataCenter:GetItemCount(passCfg.price_id)
  local costCount = passCfg.price_num * self.levelup
  local curLevel = self.passInfo.level
  local nextLevel = self.passInfo.level + self.levelup
  
  local function butFunc()
    local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
    battlepassCtrl:BuyBattlePassExp(self.passInfo.id, self.levelup, function()
      self:OnBtnCloseClicked()
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonUpgradeTips, function(window)
        if window == nil then
          return
        end
        window:InitBattlePassLevelUp(curLevel, nextLevel)
      end)
    end)
  end
  
  if haveCount < costCount then
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    if not payCtrl:TryConvertPayItem(passCfg.price_id, costCount - haveCount, nil, nil, butFunc, true) then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(25))
    end
    return
  end
  butFunc()
end

function UIEventBattlePassBuyLevel:OnBtnCloseClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventBattlePassBuyLevel:OnReturnClick()
  self:Delete()
end

function UIEventBattlePassBuyLevel:OnDelete()
  base.OnDelete(self)
end

return UIEventBattlePassBuyLevel

local UINQuickPurchaseOptionItemNode = class("UINQuickPurchaseOptionItemNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader
local CS_ClientConsts = CS.ClientConsts
local cs_MessageCommon = CS.MessageCommon
local ShopEnum = require("Game.Shop.ShopEnum")

function UINQuickPurchaseOptionItemNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buy_Normal, self, self.OnClickBuyNormal)
  UIUtil.AddButtonListener(self.ui.btn_GiftPageDetail, self, self.OnClickSaveMoneyPreview)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
  self.ui.tex_GiftPageDetail:SetIndex(4)
end

function UINQuickPurchaseOptionItemNode:OnInitOptionItemNode(saveCfg, buyEvent, parentWin)
  self.quickBuyWindow = parentWin
  self.buyEvent = buyEvent
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.resloader = cs_ResLoader.Create()
  if self.updateFuncs ~= nil then
    table.removeall(self.updateFuncs)
  end
  self.cfg = saveCfg
  local saveMoneyController = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney)
  if saveMoneyController == nil then
    return
  end
  local saveMoneyData = saveMoneyController:GetSaveMoneyDataByActId(self.cfg.id)
  if saveMoneyData == nil then
    return
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.cfg.level_name)
  if self._heroSelectNode ~= nil then
    self._heroSelectNode:Hide()
  end
  local itemCfg = ConfigData.item[self.cfg.save_consume_ids[1]]
  self.ui.Normal_img_Item.sprite = CRH:GetSprite(itemCfg.small_icon)
  self.ui.Normal_tex_Cost.text = tostring(self.cfg.save_consume_nums[1])
  local hasQz = false
  self.itemPool:HideAll()
  for k, v in pairs(self.cfg.immediate_rewards_ids) do
    local itemCfg = ConfigData.item[v]
    local count = self.cfg.immediate_rewards_nums[k]
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, count)
    if itemCfg.id == ConstGlobalItem.PaidQZ or itemCfg.id == ConstGlobalItem.PaidItem then
      hasQz = true
    end
  end
  for k, v in pairs(self.cfg.show_rewards_ids) do
    local itemCfg = ConfigData.item[v]
    local count = self.cfg.show_rewards_nums[k]
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, count)
    self:AddNewUpdateFunc(function()
      item.baseItem:SetCountDownTime(saveMoneyData:GetSaveMoneyCountDownTimeReward(self.cfg.save_level, k, true))
    end)
    if itemCfg.id == ConstGlobalItem.PaidQZ or itemCfg.id == ConstGlobalItem.PaidItem then
      hasQz = true
    end
  end
  self.ui.obj_JpQZ:SetActive(hasQz and Consts.GameChannelType.IsJp())
  if not string.IsNullOrEmpty(self.cfg.level_picture) then
    self.ui.img_GiftBag.enabled = false
    self.resloader:LoadABAssetAsync(PathConsts:GetActivitySaveMoney(self.cfg.level_picture), function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.img_GiftBag.texture = texture
      self.ui.img_GiftBag.enabled = true
    end)
  end
  self:RefreshPurchaseNode()
end

function UINQuickPurchaseOptionItemNode:RefreshPurchaseNode()
  TimerManager:StopTimer(self.countDowntimerId)
  self.countDowntimerId = TimerManager:StartTimer(3, function()
    for _, func in ipairs(self.updateFuncs) do
      func()
    end
  end, self)
end

function UINQuickPurchaseOptionItemNode:AddNewUpdateFunc(func)
  func()
  self.updateFuncs = self.updateFuncs or {}
  table.insert(self.updateFuncs, func)
end

function UINQuickPurchaseOptionItemNode:OnClickSaveMoneyPreview()
  UIManager:ShowWindowAsync(UIWindowTypeID.SaveMoneyPreview, function(win)
    win:InitSaveMoneyPreview(self.cfg)
  end)
end

function UINQuickPurchaseOptionItemNode:OnClickBuyNormal()
  if self.quickBuyWindow.isSlideOuting then
    return
  end
  if self.buyEvent ~= nil then
    self.buyEvent()
  end
end

function UINQuickPurchaseOptionItemNode:OnDelete()
  TimerManager:StopTimer(self.countDowntimerId)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINQuickPurchaseOptionItemNode

local UICIDJumpInfoItem = class("UICommonItemDetailWinNew", UIBaseNode)
local base = UIBaseNode
local UICIDJumpDescrItem = require("Game.CommonUI.ItemDetail.UICIDJumpDescrItem")
local cs_MessageCommon = CS.MessageCommon

function UICIDJumpInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.PoolDescrItem = UIItemPool.New(UICIDJumpDescrItem, self.ui.obj_jumpDescrItem)
  self.ui.obj_jumpDescrItem:SetActive(false)
end

function UICIDJumpInfoItem:InitCIDJumpInfoItem(jumpId, args)
  local jumpCfg = ConfigData.system_jump[jumpId]
  self.ui.tex_tile:SetIndex(0, LanguageUtil.GetLocaleText(jumpCfg.title))
  self.PoolDescrItem:HideAll()
  if args ~= nil and 0 < #args then
    for _, arg in ipairs(args) do
      local item = self.PoolDescrItem:GetOne()
      item:InitCIDJumpDescrItem(jumpCfg, jumpId, arg)
    end
  else
    local item = self.PoolDescrItem:GetOne()
    item:InitCIDJumpDescrItem(jumpCfg, jumpId)
  end
end

function UICIDJumpInfoItem:InitQuickProduce(targetOrderData, factoryController)
  self.ui.tex_tile:SetIndex(1)
  self.PoolDescrItem:HideAll()
  local item = self.PoolDescrItem:GetOne()
  item:InitCIDJumpDescrItem4Factory(targetOrderData)
  item:SetJumpCallback(function()
    factoryController:OpenQuickProduceUI(targetOrderData, function()
      local commonItemDetailWin = UIManager:GetWindow(UIWindowTypeID.GlobalItemDetail)
      if commonItemDetailWin ~= nil then
        commonItemDetailWin:OnBtnReturnClick()
      end
    end)
  end)
end

function UICIDJumpInfoItem:InitQuickBuy(shopId, shelfId, resourceIds)
  self.ui.tex_tile:SetIndex(2)
  self.PoolDescrItem:HideAll()
  local item = self.PoolDescrItem:GetOne()
  item:InitJump2Buy()
  item:SetJumpCallback(function()
    local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    ctrl:GetShopData(shopId, function(shopData)
      local goodData = shopData.shopGoodsDic[shelfId]
      if goodData.isFullHeroFrag then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(559))
        return
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
        if win == nil then
          error("can't open QuickBuy win")
          return
        end
        local winItemDetail = UIManager:GetWindow(UIWindowTypeID.GlobalItemDetail)
        if winItemDetail ~= nil then
          winItemDetail:OnBtnReturnClick()
        end
        win:SlideIn()
        win:InitBuyTarget(goodData, nil, true, resourceIds)
        win:OnClickAdd(true)
      end)
    end)
  end)
end

function UICIDJumpInfoItem:InitUseGift(selectItemId, giftList)
  self.ui.tex_tile:SetIndex(3)
  self.PoolDescrItem:HideAll()
  local item = self.PoolDescrItem:GetOne()
  item:InitUseGift()
  item:SetJumpCallback(function()
    for i, itemId in ipairs(giftList) do
      local itemCfg = ConfigData.item[itemId]
      if ConfigData:IsManualOpenGiftItem(itemCfg) and PlayerDataCenter:GetItemCount(itemId) > 0 then
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonUseGift, function(window)
          if window == nil then
            return
          end
          UIManager:HideWindow(UIWindowTypeID.GlobalItemDetail)
          window:InitCommonUseGift(itemCfg, selectItemId, function()
            UIUtil.OnClickBackByWinId(UIWindowTypeID.GlobalItemDetail)
          end)
        end)
        return
      end
    end
  end)
end

function UICIDJumpInfoItem:InitFragConvert(fargIdList)
  self.ui.tex_tile:SetIndex(4)
  self.PoolDescrItem:HideAll()
  local item = self.PoolDescrItem:GetOne()
  item:InitFragConvert()
  item:SetJumpCallback(function()
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroChipOverflowWindow, function(win)
      if win == nil then
        return
      end
      UIManager:HideWindow(UIWindowTypeID.GlobalItemDetail)
      win:InitFragConvertCloseCallback(function()
        UIUtil.OnClickBackByWinId(UIWindowTypeID.GlobalItemDetail)
      end)
      win:InitByCouldUseFragList(fargIdList)
    end)
  end)
end

function UICIDJumpInfoItem:OnDelete()
  self.PoolDescrItem:DeleteAll()
  base.OnDelete(self)
end

return UICIDJumpInfoItem

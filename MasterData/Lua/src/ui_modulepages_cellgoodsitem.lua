local module = class("cellGoodsItem", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()

function module.bind()
  return {
    txt_name = "",
    img_currency = nil,
    txt_cost = "",
    costSpciaText = "",
    costSpciaTextActive = false,
    go_selFrame = false,
    go_selNum = false,
    selNum = "",
    go_new = false,
    go_stock = false,
    stockText = "",
    soldOutMask = false,
    timeRefresh = false,
    lockActive = false,
    currencyActive = true,
    list_star = {},
    itemIcon = "",
    img_iconFilter = "",
    itemBg = "",
    txt_refreshTime = "",
    soulessence_index = 2
  }
end

function module.methods()
  return {
    onClick = function(self)
      self:refreshSel(true)
      self:emit("onClick", self.bind.slotId, self.bind.txt_cost)
    end,
    onClickReduce = function(self)
      self:refreshSel(false)
      self:emit("onClickReduce", self.bind.slotId)
    end,
    onLongClick = function(self)
      if self.itemType == L_Const.resType.book then
        L_UI:open("pageInfoTip", {
          itemType = self.itemType,
          itemId = self.itemId,
          goodsId = self.bind.itemId
        })
        return
      end
      L_ItemTplManager:showInfoTip(self.itemType, self.itemId)
    end
  }
end

function module:open()
  local goodsTpl = L_GameTpl:getGoodsTpl()
  local tpl = goodsTpl:getTplById(self.bind.itemId)
  self.itemType = goodsTpl:getItem(tpl)[1][1]
  self.itemId = goodsTpl:getItem(tpl)[1][2]
  local itemConfig = L_ItemTplManager:getItemConfig(self.itemType, self.itemId)
  if self.itemType == L_Const.resType.soulEssence then
    itemConfig = L_ItemTplManager:getsoulessenceItem(self.itemId, self.bind.soulessence_index)
  end
  self.bind.itemIcon = itemConfig.icon
  local commonItemTpl = _commonItemTpl:getTplById(self.itemId)
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  self.bind.itemBg = string.format("UI/Atlas/ShopPage/tex_npcshop_icon_rarity%d.png", itemConfig.quality)
  self.bind.txt_name = L_ItemTplManager:getSplitName(self.bind.txt_name, 8)
  local starNum = L_ItemTplManager:getItemShowStarNum(self.itemType, self.itemId)
  self:_setStars(starNum)
  self:refreshStatus()
end

function module:refresh()
  self:refreshStatus()
end

function module:close()
  self:closeRefreshGoods()
end

function module:refreshSel(sel)
  if sel == nil then
  end
  self.bind.go_selFrame = sel
  if self.bind.lockActive == false and self.bind.soldOutMask == false then
    self.bind.go_selNum = sel
  else
    self.bind.go_selNum = false
  end
end

function module:refreshBuyNum(num)
  self.bind.selNum = tostring(num)
end

function module:_setStars(num)
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_star:clear()
  self.bind.list_star:insert_array(stars)
end

function module:refreshStatus()
  self:refreshSel(self.bind.choice)
  local goodsTpl = L_GameTpl:getGoodsTpl()
  local tpl = goodsTpl:getTplById(self.bind.itemId)
  local costId = goodsTpl:getCostId(tpl)
  self.bind.currencyActive = true
  if self.bind.soldOutMask == true then
    self.bind.sel = false
    self:checkRefreshTime(tpl)
  else
    self:closeRefreshGoods()
    self.bind.timeRefresh = false
  end
  local isLimit = L_ShopStore:getIsLimitGoods(self.bind.curShopId, self.bind.slotId)
  if self.bind.lockActive == true then
    local darkSafeHelper = self.bindComponents.btnBg:GetComponent(typeof(CS.Lens.Framework.UI.UIDarkenSafeHelper))
    darkSafeHelper:SetGrayForLua(0.42, self.bindComponents.stock.transform)
  else
    local darkSafeHelper = self.bindComponents.btnBg:GetComponent(typeof(CS.Lens.Framework.UI.UIDarkenSafeHelper))
    darkSafeHelper:ResetColors()
  end
  self.bind.go_stock = self.bind.soldOutMask == false and self.bind.lockActive == false and isLimit == true
  if 1 < #costId then
    self.bind.currencyActive = false
    self.bind.costSpciaText = L_GameTpl:getWordsTpl():getTplById("npc_shop_special")
  end
  if table.isEmpty(costId) then
    self.bind.currencyActive = false
    self.bind.costSpciaText = L_GameTpl:getWordsTpl():getTplById("npc_shop_free")
  end
  if #costId == 1 then
    local currency = goodsTpl:getCurrencyNum(tpl)
    if currency <= 0 then
      self.bind.currencyActive = false
      self.bind.costSpciaText = L_GameTpl:getWordsTpl():getTplById("npc_shop_free")
    else
      local currencyType = goodsTpl:getCurrencyType(tpl)
      local currencyId = goodsTpl:getCurrencyId(tpl)
      self.bind.img_currency = L_ItemTplManager:getItemConfig(currencyType, currencyId).icon
      self.bind.txt_cost = tostring(currency)
    end
  end
  self.bind.costSpciaTextActive = not self.bind.currencyActive
end

function module:checkRefreshTime(tpl)
  local goodsTpl = L_GameTpl:getGoodsTpl()
  local refreshType = goodsTpl:getRefreshType(tpl)
  if refreshType == 1 then
    self:closeRefreshGoods()
    self.bind.timeRefresh = false
  else
    self.bind.timeRefresh = true
    self:openRefreshGoods()
  end
end

function module:openRefreshGoods()
  if self.goodsRefreshTimer then
    self:closeRefreshGoods()
  end
  local endTime = self.bind.deadTime
  self.bind.timeRefresh = true
  if string.isEmpty(endTime) then
    self.bind.timeRefresh = false
    return
  end
  local frequency = 1
  local shopId = self.bind.curShopId
  
  local function _run()
    local tempEndTime = self.bind.deadTime
    self.bind.txt_refreshTime = L_TimeUtil.getLeftTimeString(tempEndTime)
    if tempEndTime and tempEndTime < L_TimeUtil.getServerTime() then
      self:closeRefreshGoods()
      self.bind.timeRefresh = false
    end
  end
  
  self.bind.txt_refreshTime = L_TimeUtil.getLeftTimeString(endTime)
  if endTime and endTime >= L_TimeUtil.getServerTime() then
    self.goodsRefreshTimer = Timer.repeated(frequency, _run)
  end
end

function module:closeRefreshGoods()
  if self.goodsRefreshTimer == nil then
    return
  end
  self.goodsRefreshTimer:destroy()
  self.goodsRefreshTimer = nil
end

return module

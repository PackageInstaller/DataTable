local UINShopTogs = class("UINShopTogs", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
local JumpManager = require("Game.Jump.JumpManager")
local UINShopShelfTog = require("Game.Shop.UINShopShelfTog")

function UINShopTogs:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.shelfTypeTogPool = UIItemPool.New(UINShopShelfTog, self.ui.obj_tog_ShelfType)
  self.ui.obj_tog_ShelfType:SetActive(false)
end

function UINShopTogs:InitShopTogs(shopCtrl, resloader, onClickTogFunc)
  self.shopCtrl = shopCtrl
  self.resloader = resloader
  self.onClickTogFunc = onClickTogFunc
end

function UINShopTogs:RefreshShopTogs(shopId, shopData, autoSelectShelfId, autoSelectPageId)
  local shopCfg = ConfigData.shop[shopId]
  local pageList = {}
  if shopCfg.shop_type == ShopEnum.eShopType.Recommend then
    for _, pageId in ipairs(shopCfg.shop_para) do
      local pageCfg = ConfigData.shop_page[pageId]
      if pageCfg ~= nil and pageCfg.imgs ~= nil and self:_CheckRecommendValid(pageCfg) then
        table.insert(pageList, pageId)
      end
    end
  elseif shopCfg.shop_type == ShopEnum.eShopType.PayGift then
    local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
    local pageDic = {}
    for k, v in pairs(payGiftCtrl.dataDic) do
      if pageDic[v.groupCfg.inPage] == nil and v:IsUnlock() and (v.needRefresh or not v:IsSoldOut()) and shopCfg.id == v.groupCfg.inShop then
        pageDic[v.groupCfg.inPage] = true
      end
    end
    for pageId, _ in pairs(pageDic) do
      if ConfigData.shop_page[pageId] ~= nil then
        table.insert(pageList, pageId)
      end
    end
    table.sort(pageList)
    for _, pageId in ipairs(shopCfg.shop_para) do
      table.insert(pageList, pageId)
    end
  elseif shopCfg.shop_type == ShopEnum.eShopType.MonthCard then
    table.insert(pageList, shopId)
  else
    if shopData:GetIsHavePages() then
      for pageId, _ in pairs(shopData:GetPageDic()) do
        if shopData:HasShopGoodsInPage(pageId) then
          table.insert(pageList, pageId)
        end
      end
    end
    table.sort(pageList)
  end
  if shopCfg.is_topbar ~= 0 then
    self:Show()
  else
    self:Hide()
  end
  self.shelfTypeTogPool:HideAll()
  if pageList == nil or #pageList == 0 then
    if shopCfg.is_topbar == -1 then
      local item = self.shelfTypeTogPool:GetOne()
      item:InitOnlyTitleShelfTog(shopCfg.name)
    end
    self.onClickTogFunc(shopId, nil, autoSelectShelfId)
    return
  end
  local autoSelectIndex = 1
  if autoSelectPageId ~= nil then
    for index, pageId in pairs(pageList) do
      if autoSelectPageId == pageId then
        autoSelectIndex = index
        break
      end
    end
  end
  self.ui.obj_tog_ShelfType.transform.parent.gameObject:SetActive(false)
  for index, pageId in ipairs(pageList) do
    local item = self.shelfTypeTogPool:GetOne()
    item:InitShelfTog(shopId, pageId, self.onClickTogFunc, #pageList)
    item:SetSelected(index == autoSelectIndex, autoSelectShelfId)
  end
  self.onClickTogFunc(shopId, pageList[autoSelectIndex], autoSelectShelfId)
  self.ui.obj_tog_ShelfType.transform.parent.gameObject:SetActive(true)
end

function UINShopTogs:_CheckRecommendValid(pageCfg)
  local isOpen = false
  if CS.ClientConsts.IsAudit and pageCfg.id == 601 then
    return false
  end
  for _, imgNum in ipairs(pageCfg.imgs) do
    local recommedCfg = ConfigData.shop_recommend[imgNum]
    if recommedCfg ~= nil then
      if recommedCfg.jump_target == JumpManager.eJumpTarget.DynActivity then
        self.frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
        local frameData = self.frameCtrl:GetActivityFrameData(recommedCfg.jump_arg[1])
        isOpen = frameData ~= nil and frameData:GetCouldShowActivity()
      elseif pageCfg.able_close then
        isOpen = CheckCondition.CheckLua(recommedCfg.pre_condition, recommedCfg.pre_para1, recommedCfg.pre_para2)
      else
        isOpen = true
      end
      if isOpen then
        return true
      end
    end
  end
end

function UINShopTogs:OnDelete()
  self.shelfTypeTogPool:DeleteAll()
  base.OnDelete(self)
end

return UINShopTogs

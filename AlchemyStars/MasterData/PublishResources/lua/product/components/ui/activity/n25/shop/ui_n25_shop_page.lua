_class("UIN25ShopPage", UICustomWidget)
UIN25ShopPage = UIN25ShopPage

function UIN25ShopPage:Constructor()
  self._atlas = self:GetAsset("UIN25.spriteatlas", LoadType.SpriteAtlas)
  self:InitCfg()
end

function UIN25ShopPage:OnShow(uiParams)
  self:InitWidget()
end

function UIN25ShopPage:InitWidget()
end

function UIN25ShopPage:SetData(pageIndex, itemsData)
  self.pageIndex = pageIndex
  self.itemsData = itemsData
  self:Refresh()
end

function UIN25ShopPage:Refresh()
  local cfg = UIN25ShopPage.PageCfg[self.pageIndex]
  self.startIndex = cfg.startIndex
  self.count = cfg.count
  self._itmes = {}
  for i = 1, self.count do
    local itemIndex = self.startIndex + i - 1
    local itemCfg = UIN25ShopPage.ItemCfg[itemIndex]
    local style = itemCfg.style
    local item = self._itmes and self._itmes[i]
    if not item then
      local pos = "pos" .. i
      local itemPool = self:GetUIComponent("UISelectObjectPath", pos)
      local itemRt = self:GetUIComponent("RectTransform", pos)
      local scale = itemCfg.scale
      local rot = itemCfg.rot
      itemRt.localScale = Vector3(scale, scale, 1)
      itemRt.localRotation = Quaternion.Euler(0, 0, rot)
      if style == 1 then
        item = itemPool:SpawnObject("UIN25CampaignShopItemBig")
        self._itmes[i] = item
      else
        item = itemPool:SpawnObject("UIN25CampaignShopItemSmall")
        self._itmes[i] = item
      end
      local bgImg = item:GetInfoBg()
      if itemCfg.infoBg and bgImg then
        bgImg.sprite = self._atlas:GetSprite(itemCfg.infoBg)
      end
    end
    local subData = self.itemsData[1][itemIndex]
    if subData then
      if not subData.goodsId then
        subData = subData[1]
      end
      item:InitData(subData)
    else
      Log.fatal("UIN25ShopPage:Refresh can't find itemIndex " .. itemIndex .. "  curpage = " .. self.pageIndex .. " pos = " .. i)
    end
  end
end

function UIN25ShopPage:Show(bShow)
  if not self.gameObject then
    self.gameObject = self:GetGameObject()
  end
  self.gameObject:SetActive(bShow)
end

function UIN25ShopPage:InitCfg()
  if not UIN25ShopPage.PageCfg then
    UIN25ShopPage.PageCfg = {
      [1] = {startIndex = 1, count = 7},
      [2] = {startIndex = 8, count = 10},
      [3] = {startIndex = 18, count = 8}
    }
    UIN25ShopPage.ItemCfg = {
      [1] = {
        scale = 1,
        rot = 0,
        style = 1
      },
      [2] = {
        scale = 0.98,
        rot = 1,
        style = 1
      },
      [3] = {
        scale = 0.95,
        rot = 2,
        style = 1
      },
      [4] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di7"
      },
      [5] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di7"
      },
      [6] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di7"
      },
      [7] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di7"
      },
      [8] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [9] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [10] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [11] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [12] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [13] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [14] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [15] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [16] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [17] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [18] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [19] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [20] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [21] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [22] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [23] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di6"
      },
      [24] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di5"
      },
      [25] = {
        scale = 1,
        rot = 0,
        style = 2,
        infoBg = "N25_shop_di5"
      }
    }
  end
end

function UIN25ShopPage:PlaySellOutAni(goodsId)
  if not self._itmes then
    return
  end
  for k, subItem in pairs(self._itmes) do
    if subItem._data and subItem._data:GetGoodsId() == goodsId then
      local remainCount = subItem._data:GetRemainCount()
      if remainCount < 1 then
        subItem:PlaySellOutAni()
      end
      break
    end
  end
end

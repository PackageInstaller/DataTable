local View = require("UIDressStore/UIDressStoreView")
local DataModel = require("UIDressStore/UIDressStoreDataModel")
local ViewFunction = {
  DressStore_Group_RightPanel_Group_Top_ScrollGrid_SkinType_SetGrid = function(element, elementIndex)
    local skinType = DataModel.shopItemTypes[elementIndex]
    local skinTypeCA = PlayerData:GetFactoryData(skinType, "TagFactory")
    element.Group_.Txt_:SetText(skinTypeCA.name)
    element.Group_.Img_Icon:SetSprite(skinTypeCA.unSelectIconPathDS)
    element.Img_Picked:SetActive(DataModel.curSelectShopItemType == skinType)
    element.Img_Picked.Img_IconPicked:SetSprite(skinTypeCA.selectIconPathDS)
    element.Img_Picked.Txt_:SetText(skinTypeCA.name)
    element.Btn_:SetClickParam(skinType)
  end,
  DressStore_Group_RightPanel_Group_Top_ScrollGrid_SkinType_Group_Item_Btn__Click = function(btn, str)
    if DataModel.curSelectShopItemType and DataModel.curSelectShopItemType == tonumber(str) then
      return
    end
    DataModel.SetCurSkinListByType(tonumber(str))
  end,
  DressStore_Group_RightPanel_Group_Middle_ScrollGrid_Skin_SetGrid = function(element, elementIndex)
    local shopItem = DataModel.curTypeShopItems[elementIndex]
    local skinId = shopItem.itemId
    local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
    local commodityCA
    if shopItem.commodityId and shopItem.commodityId > 0 then
      commodityCA = PlayerData:GetFactoryData(shopItem.commodityId, "CommodityFactory")
    end
    local have = PlayerData.CaptainSkinSystem:IsSkinHave(shopItem.itemId)
    local select = PlayerData.CaptainSkinSystem:IsSkinCurShow(shopItem)
    element.Img_Picked:SetActive(select)
    element.Txt_Name:SetText(skinCA.name)
    element.Img_Skin:SetSprite(commodityCA and commodityCA.commodityView or skinCA.iconPath)
    element.Img_Owned:SetActive(have)
    element.Img_BgMoney:SetActive(not have)
    element.Group_Overlay:SetActive(skinCA.overlay)
    element.Group_Fashion.Txt_:SetText(skinCA.fashion)
    if not have and commodityCA then
      local costConfig = commodityCA.moneyList[1]
      if costConfig then
        local costNum = costConfig.moneyNum
        local costItemCA = PlayerData:GetFactoryData(costConfig.moneyID, "ItemFactory")
        element.Img_BgMoney.Group_Money.Group_Money.Img_Money:SetSprite(costItemCA.buyPath)
        element.Img_BgMoney.Group_Money.Txt_MoneyNum:SetText(costNum)
      end
    end
    element.Btn_Dress:SetClickParam(elementIndex)
    element.Btn_Buy:SetActive(not have)
    element.Btn_Buy:SetClickParam(elementIndex)
    element.Btn_Info:SetClickParam(skinId)
  end,
  DressStore_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn_Info_Click = function(btn, str)
    CommonTips.OpenDressTips(tonumber(str))
  end,
  DressStore_Group_Character_Btn_Turn_Click = function(btn, str)
    local animName = DataModel.isBack and "dorm_stand" or "dorm_stand_back"
    View.Group_Character.SpineAnimation_:SetActionWithoutMix(animName, true, true)
    DataModel.isBack = not DataModel.isBack
  end,
  DressStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  DressStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  DressStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  DressStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  DressStore_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn_Dress_Click = function(btn, str)
    local shopItem = DataModel.curTypeShopItems[tonumber(str)]
    local takeOn = not PlayerData.CaptainSkinSystem:IsSkinCurShow(shopItem)
    local change = DataModel.ChangeSkin(shopItem, takeOn)
    if change then
      DataModel.TakeOnSkinPlayAnim(shopItem.itemId)
      View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:RefreshAllElement()
    end
  end,
  DressStore_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn_Buy_Click = function(btn, str)
    local shopItem = DataModel.curTypeShopItems[tonumber(str)]
    local have = PlayerData.CaptainSkinSystem:IsSkinHave(shopItem.itemId)
    if have then
      return
    end
    local commodityCA = PlayerData:GetFactoryData(shopItem.commodityId, "CommodityFactory")
    local costConfig = commodityCA[1]
    if costConfig then
      local costNum = costConfig.moneyNum
      local haveNum = PlayerData:GetGoodsById(costConfig.moneyID).num
      if costNum > haveNum then
        PlayerData:AllBuyCommodity(costConfig.moneyID, costNum)
        return
      end
    end
    local data = {}
    data.commoditData = commodityCA
    data.shopid = DataModel.shopId
    data.storeType = PlayerData:GetFactoryData(DataModel.shopId, "StoreFactory").storeType
    data.name = commodityCA.commodityName
    data.image = commodityCA.commodityView
    data.qualityInt = commodityCA.qualityInt + 1
    CommonTips.OpenBuyTips(data, function()
      local skinId = shopItem.itemId
      local skinUid
      for i, v in pairs(PlayerData.CaptainSkinSystem:GetAllSkinData()) do
        if v.id == tostring(skinId) then
          skinUid = i
          break
        end
      end
      if skinUid then
        shopItem.skinUid = skinUid
        DataModel.ChangeSkin(shopItem, true)
        DataModel.SaveDresses()
        View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:RefreshAllElement()
      end
      View.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end)
  end,
  DressStore_Group_Character_Btn_Save_Click = function(btn, str)
    local normalSkinItems = PlayerData.CaptainSkinSystem.curShowNormalSkinItems
    for skinType, shopItem in pairs(normalSkinItems) do
      if not PlayerData.CaptainSkinSystem:IsSkinHave(shopItem.itemId) then
        local format = PlayerData:GetFactoryData(80602332, "TextFactory").text
        local skinTypeCA = PlayerData:GetFactoryData(skinType, "TagFactory")
        CommonTips.OpenTips(string.format(format, skinTypeCA.name))
        return
      end
    end
    DataModel.SaveDresses()
    CommonTips.OpenTips(80602333)
  end,
  DressStore_Btn_Medal_Click = function(btn, str)
  end,
  DressStore_Btn_Medal_Btn_Add_Click = function(btn, str)
  end
}
return ViewFunction

local View = require("UIGoodsTips/UIGoodsTipsView")
local DataModel = require("UIGoodsTips/UIGoodsTipsDataModel")
local ViewFunction = require("UIGoodsTips/UIGoodsTipsViewFunction")
local TradeDataModel = require("UIHomeTrade/UITradeDataModel")
local back_params
local Luabehaviour = {
  serialize = function()
    return back_params
  end,
  deserialize = function(initParams)
    back_params = initParams
    local data = Json.decode(initParams)
    DataModel.Id = data.goodsId
    local goodsConfig = PlayerData:GetFactoryData(data.goodsId)
    local rarityPath = UIConfig.TipConfig[goodsConfig.qualityInt + 1]
    local qualityPath = UIConfig.ItemTipQuality[goodsConfig.qualityInt + 1]
    View.Group_Show.Txt_Speciality:SetActive(goodsConfig.isSpeciality)
    View.Group_Show.Img_Rarity:SetSprite(rarityPath)
    View.Group_Show.Img_Quality:SetSprite(qualityPath)
    View.Group_Show.Img_Icon:SetSprite(goodsConfig.tipsPath)
    local typeName = ""
    if goodsConfig.goodsType and goodsConfig.goodsType > 0 then
      local tagCA = PlayerData:GetFactoryData(goodsConfig.goodsType)
      typeName = GetText(80611079) .. tagCA.typeName
    end
    View.Group_Show.Txt_N.Txt_Type:SetText(typeName)
    View.Group_Show.Txt_Name:SetText(goodsConfig.name)
    View.Group_Show.ScrollView_Describe.Viewport.Txt_Describe:SetText(goodsConfig.des)
    if data.goodsType == 1 then
      local goodsNum = PlayerData:GetGoodsById(data.goodsId).num
      if PlayerData.ServerData.user_prison_info then
        if PlayerData.ServerData.user_prison_info.raw_material and PlayerData.ServerData.user_prison_info.raw_material[tostring(data.goodsId)] then
          goodsNum = goodsNum + PlayerData.ServerData.user_prison_info.raw_material[tostring(data.goodsId)].num
        end
        if PlayerData.ServerData.user_prison_info.product and PlayerData.ServerData.user_prison_info.product[tostring(data.goodsId)] then
          goodsNum = goodsNum + PlayerData.ServerData.user_prison_info.product[tostring(data.goodsId)].num
        end
      end
      View.Group_Show.Group_Num.Txt_Num:SetText(goodsNum)
      View.Group_Show.Group_UnitPrice:SetActive(false)
      View.Group_Show.Group_Num:SetActive(true)
    elseif data.goodsType == 2 then
      local goldRate = TradeDataModel.GetTradeGoldRate() or 1
      View.Group_Show.Group_UnitPrice.Txt_Num:SetText(math.floor((PlayerData:GetGoodsById(data.goodsId).avg_price or 0) * goldRate + 0.5))
      View.Group_Show.Group_UnitPrice:SetActive(true)
      View.Group_Show.Group_Num:SetActive(false)
    end
    View.Group_Show.Group_Lock.self:SetActive(data.showLock == true)
    if data.showLock then
      local goodsServerInfo = PlayerData:GetHomeInfo().warehouse[tostring(data.goodsId)]
      local isLock = goodsServerInfo and goodsServerInfo.is_locked == 1
      View.Group_Show.Group_Lock.Btn_Unlock:SetActive(not isLock)
      View.Group_Show.Group_Lock.Btn_Lock:SetActive(isLock)
    end
    local getwayList = goodsConfig.Getway
    View.Group_Show.Group_GetWay.Btn_Access:SetActive(next(getwayList or {}))
    View.Group_Show.Group_GetWay:SetActive(true)
    View.Group_Show.ScrollView_Describe:SetContentHeight(View.Group_Show.ScrollView_Describe.Viewport.Txt_Describe:GetHeight())
    View.Group_Show.ScrollView_Describe:SetVerticalNormalizedPosition(1)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}

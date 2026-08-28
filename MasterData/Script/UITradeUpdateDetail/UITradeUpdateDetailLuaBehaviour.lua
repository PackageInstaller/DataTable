local View = require("UITradeUpdateDetail/UITradeUpdateDetailView")
local DataModel = require("UITradeUpdateDetail/UITradeUpdateDetailDataModel")
local ViewFunction = require("UITradeUpdateDetail/UITradeUpdateDetailViewFunction")
local HomeTradeUpdateDataModel = require("UIHomeTradeUpgrade/UIHomeTradeUpgradeDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local isMax = HomeTradeUpdateDataModel.GetIsTotalInvestBuffRateMax()
    local nowRate = HomeTradeUpdateDataModel.GetMoneyBuffRate() or 0
    if isMax then
      View.Group_NoMax:SetActive(false)
      View.Group_Max:SetActive(true)
      View.Group_Max.Txt_Num:SetText(tostring(nowRate) .. "%")
    else
      View.Group_NoMax:SetActive(true)
      View.Group_Max:SetActive(false)
      View.Group_NoMax.Group_L.Txt_Num:SetText(tostring(nowRate) .. "%")
      View.Group_NoMax.Group_R.Txt_Num:SetText(tostring(nowRate + 1) .. "%")
      local needNum = HomeTradeUpdateDataModel.GetNextNeedInvestMoney() or 0
      View.Group_NoMax.Group_M.Txt_Num:SetText(tostring(needNum))
      local station_info = PlayerData:GetHomeInfo().station_info
      if station_info ~= nil then
        local stationId = 0
        local stop_info = station_info.stop_info
        if stop_info ~= nil and stop_info[2] == -1 then
          stationId = tonumber(stop_info[1])
        end
        local ca = PlayerData:GetFactoryData(stationId)
        local itemCa = PlayerData:GetFactoryData(ca.currency, "ItemFactory")
        if itemCa and not string.nilorempty(itemCa.tipsPath) then
          View.Group_NoMax.Group_M.Img_:SetSprite(itemCa.tipsPath)
        end
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
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

local View = require("UIWarehouseBuy/UIWarehouseBuyView")
local DataModel = require("UIWarehouseBuy/UIWarehouseBuyDataModel")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  View.Group_Slider.Group_Num.Txt_Select:SetText(DataModel.minNum)
  View.Group_Slider.Group_Num.Txt_Possess:SetText(DataModel.maxNum)
  View.Group_Slider.Slider_Value:SetMinAndMaxValue(DataModel.minNum, DataModel.maxNum, true)
  View.Group_Slider.Slider_Value:SetSliderValue(DataModel.minNum)
  Controller:RefreshCost()
  if not DataModel.canBuy then
    View.Group_Gold.Txt_Num:SetColor("#FF0000")
    View.Group_Gold.Txt_Num:SetText(DataModel.priceInfo.num)
  else
    View.Group_Gold.Txt_Num:SetColor("#FFFFFF")
  end
end

function Controller:Add()
  if DataModel.curNum >= DataModel.initParams.maxNum then
    return
  end
  DataModel.curNum = DataModel.curNum + 1
  Controller:RefreshCost()
end

function Controller:AddToMax()
  if DataModel.curNum >= DataModel.initParams.maxNum then
    return
  end
  DataModel.curNum = DataModel.initParams.maxNum
  Controller:RefreshCost()
end

function Controller:Sub()
  if DataModel.curNum <= 1 then
    return
  end
  DataModel.curNum = DataModel.curNum - 1
  Controller:RefreshCost()
end

function Controller:SubToMin()
  if DataModel.curNum <= 1 then
    return
  end
  DataModel.curNum = 1
  Controller:RefreshCost()
end

function Controller:SliderValueChange(value)
  DataModel.curNum = math.floor(value + 0.5)
  Controller:RefreshCost()
end

function Controller:RefreshCost()
  DataModel.curCost = DataModel.curNum * DataModel.priceInfo.num
  View.Group_Slider.Slider_Value:SetSliderValue(DataModel.curNum)
  View.Group_Slider.Group_Num.Txt_Select:SetText(DataModel.curNum)
  View.Group_Gold.Txt_Num:SetText(DataModel.curCost)
  View.Group_Gold.Img_:SetSprite(DataModel.goldIcon or "")
end

function Controller:ConfirmExpand()
  if not DataModel.canBuy then
    CommonTips.OpenTips(80600461)
    return
  end
  Net:SendProto("station.expand_warehouse", function(json)
    local strStationId = tostring(DataModel.initParams.stationId)
    local curSpace = PlayerData:GetHomeInfo().stations[strStationId].max_goods_space or 0
    if DataModel.priceInfo then
      local costItem = {}
      costItem[DataModel.priceInfo.id] = DataModel.curCost or 0
      PlayerData:RefreshUseItems(costItem)
    end
    PlayerData:GetHomeInfo().stations[strStationId].max_goods_space = curSpace + DataModel.curNum
    UIManager:GoBack()
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    else
      CommonTips.OpenRepLvUp()
    end
  end, DataModel.curNum)
end

function Controller:Return()
  UIManager:GoBack()
end

return Controller

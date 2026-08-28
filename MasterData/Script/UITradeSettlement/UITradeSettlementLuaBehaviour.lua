local View = require("UITradeSettlement/UITradeSettlementView")
local DataModel = require("UITradeSettlement/UITradeSettlementDataModel")
local ViewFunction = require("UITradeSettlement/UITradeSettlementViewFunction")
local NPCDialog = require("Common/NPCDialog")
local MainUIDataModel = require("UIMainUI/UIMainUIDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    local stationId = data.stationId
    local info = data.info
    local recent_trade_report = data.recent_trade_report
    DataModel.GoodsInfo = data.goodsInfo
    DataModel.StationId = stationId
    local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    local name = stationCA.name
    if stationCA.force > 0 then
      local tagCA = PlayerData:GetFactoryData(stationCA.force, "TagFactory")
      name = tagCA.tagName
    end
    DataModel.IsBuy = data.type == 1
    DataModel.IsClose = false
    View.Group_Buy.self:SetActive(DataModel.IsBuy)
    View.Group_Sell.self:SetActive(not DataModel.IsBuy)
    DataModel.ResetAniData()
    local _, goldIcon = MainUIDataModel.GetCityGoldCountAndIcon()
    local element
    if DataModel.IsBuy then
      DataModel.CurAniFrame = DataModel.BuyAniFrame
      element = View.Group_Buy
      element.Group_Rep.Txt_Title:SetText(name)
      local rep = math.modf(info.rep or 0)
      element.Group_Rep.Txt_Num:SetText(info.repLv or 0)
      element.Group_Rep.Group_EXP.Txt_EXP:SetText(string.format("%.0f", 0))
      element.Group_Rep.Group_EXP.Img_Arrow:SetActive(0 < rep)
      element.Group_Rep.Group_EXP.Txt_Null:SetActive(0 < rep)
      DataModel.AniData.Rep = rep
      
      function DataModel.AniFrameFunc.Rep(val)
        element.Group_Rep.Group_EXP.Txt_EXP:SetText(string.format("%.0f", val))
      end
      
      element.Img_Tax.Txt_Num:SetText(string.format(GetText(80600595), 0, info.tax * 100 .. "%"))
      DataModel.AniData.Tax = info.taxPrice
      
      function DataModel.AniFrameFunc.Tax(val)
        element.Img_Tax.Txt_Num:SetText(string.format(GetText(80600595), math.floor(val), info.tax * 100 .. "%"))
      end
      
      element.Img_Price.Txt_Num:SetText(string.format(GetText(80600596), 0, info.bargain * 100 .. "%"))
      DataModel.AniData.Price = info.totalPrice
      
      function DataModel.AniFrameFunc.Price(val)
        element.Img_Price.Txt_Num:SetText(string.format(GetText(80600596), math.floor(val), info.bargain * 100 .. "%"))
      end
      
      element.Img_Tax.Txt_Num.Img_Icon:SetSprite(goldIcon or "")
      element.Img_Price.Txt_Num.Img_Icon:SetSprite(goldIcon or "")
      table.sort(DataModel.GoodsInfo, function(a, b)
        if a.totalPrice > b.totalPrice then
          return true
        end
        return false
      end)
      local totalPrice = info.totalPrice - info.taxPrice
      local percent = 0
      local remainPrice = totalPrice
      local alpha = 1
      DataModel.AniFrameFunc.PieInfo = {}
      DataModel.AniData.PieInfo = {}
      for i = 1, 4 do
        local img = element.Img_Top3["Img_Pie" .. i]
        local goods = element.Img_Top3["Img_Goods_Buy" .. i]
        local Img_No = element.Img_Top3.Img_Goods["Img_No" .. i]
        local t = DataModel.GoodsInfo[i]
        DataModel.AniFrameFunc.PieInfo[i] = function(val)
          img:SetFilledImgAmount(val)
        end
        img:SetFilledImgAmount(0)
        if Img_No then
          Img_No:SetActive(t ~= nil)
        end
        if t ~= nil then
          alpha = 1
          if i == 4 then
            goods.Group_TotalPrice.Txt_Num:SetText(PlayerData.FormatNumThousands(remainPrice))
            DataModel.AniData.PieInfo[i] = 1
          else
            local goodsQuoCA = PlayerData:GetFactoryData(t.id)
            local goodsCA = PlayerData:GetFactoryData(goodsQuoCA.goodsId, "HomeGoodsFactory")
            percent = percent + t.totalPrice / totalPrice
            goods.Txt_Name:SetText(goodsCA.name)
            goods.Group_UnitPrice.Txt_Num:SetText(t.price)
            local showTotal = math.floor(t.totalPrice + 0.5)
            goods.Group_TotalPrice.Txt_Num:SetText(PlayerData.FormatNumThousands(showTotal))
            remainPrice = remainPrice - showTotal
            DataModel.AniData.PieInfo[i] = percent
          end
        else
          if i ~= 4 then
            alpha = 0.5
            goods.Txt_Name:SetText("\226\128\148\226\128\148")
          end
          goods.Group_UnitPrice.Txt_Num:SetText(0)
          goods.Group_TotalPrice.Txt_Num:SetText(0)
        end
        if i ~= 4 then
          goods.Txt_Name:SetAlpha(alpha)
          goods.Group_UnitPrice.Txt_Num:SetAlpha(alpha)
          goods.Group_UnitPrice.Img_Icon:SetAlpha(alpha)
          goods.Group_TotalPrice.Txt_Num:SetAlpha(alpha)
          goods.Group_TotalPrice.Img_Icon:SetAlpha(alpha)
        end
      end
      element.Img_Top3.Img_Goods.StaticGrid_Goods.grid.self:RefreshAllElement()
      NPCDialog.SetNPC(element.Group_NPC, data.npcId, "buySettlementText", "qResUrl")
      View.self:PlayAnimOnce("BuyIn")
    else
      DataModel.CurAniFrame = DataModel.SaleAniFrame
      element = View.Group_Sell
      element.Img_Rep.Txt_Title:SetText(name)
      local rep = math.modf(info.rep or 0)
      element.Img_Rep.Txt_Num:SetText(info.repLv or 0)
      element.Img_Rep.Group_EXP.Txt_EXP:SetText(string.format("%.0f", rep))
      element.Img_Rep.Group_EXP.Img_Arrow:SetActive(0 < rep)
      element.Img_Rep.Group_EXP.Txt_Null:SetActive(0 < rep)
      element.Img_Trade.Txt_Num:SetText(info.tradeLv)
      element.Img_Trade.Group_EXP.Txt_EXP:SetText(string.format("%.0f", info.tradeExp))
      element.Img_Trade.Group_EXP.Img_Arrow:SetActive(0 < rep)
      element.Img_Trade.Group_EXP.Txt_Null:SetActive(0 < rep)
      element.Img_Tax.Txt_Num:SetText(string.format(GetText(80600595), info.taxPrice or 0, info.tax * 100 .. "%"))
      element.Img_Price.Txt_Num:SetText(string.format(GetText(80600597), info.totalPrice, info.bargain * 100 .. "%"))
      element.Img_Tax.Txt_Num.Img_Icon:SetSprite(goldIcon or "")
      element.Img_Price.Txt_Num.Img_Icon:SetSprite(goldIcon or "")
      element.Img_Profit.Txt_Num:SetText(0)
      DataModel.AniData.Profit = info.profit
      
      function DataModel.AniFrameFunc.Profit(val)
        element.Img_Profit.Txt_Num:SetText(PlayerData.FormatNumThousands(math.floor(val)))
      end
      
      if 0 > info.profit then
        element.Img_Profit.Txt_Num:SetColor("#e76666")
      else
        element.Img_Profit.Txt_Num:SetColor("#FFB800")
      end
      local cost = info.totalPrice + info.taxPrice - info.profit
      local ROI = "-"
      if 0 < cost then
        ROI = string.format("%.1f", info.totalPrice / cost)
      end
      element.Img_ROI.Txt_Num:SetText(ROI)
      table.sort(DataModel.GoodsInfo, function(a, b)
        if a.totalProfit > b.totalProfit then
          return true
        end
        return false
      end)
      local totalProfit = info.profit
      local totalAbsProfit = 0
      for k, v in pairs(DataModel.GoodsInfo) do
        totalAbsProfit = totalAbsProfit + math.abs(v.totalProfit)
      end
      local percent = 0
      local remainProfit = totalProfit
      local alpha = 1
      DataModel.AniData.PieInfo = {}
      DataModel.AniFrameFunc.PieInfo = {}
      for i = 1, 4 do
        local img = element.Img_Top3["Img_Pie" .. i]
        local goods = element.Img_Top3["Group_Goods" .. i]
        local Img_No = element.Img_Top3.Img_Goods["Img_No" .. i]
        local t = DataModel.GoodsInfo[i]
        img:SetFilledImgAmount(0)
        DataModel.AniFrameFunc.PieInfo[i] = function(val)
          img:SetFilledImgAmount(val)
        end
        if Img_No then
          Img_No:SetActive(t ~= nil)
        end
        if t ~= nil then
          alpha = 1
          if i == 4 then
            goods.Txt_Num:SetText(PlayerData.FormatNumThousands(remainProfit))
            DataModel.AniData.PieInfo[i] = 1
          else
            local goodsQuoCA = PlayerData:GetFactoryData(t.id)
            local goodsCA = PlayerData:GetFactoryData(goodsQuoCA.goodsId, "HomeGoodsFactory")
            percent = percent + math.abs(t.totalProfit) / totalAbsProfit
            goods.Txt_Name:SetText(goodsCA.name)
            local showTotal = math.floor(t.totalProfit + 0.5)
            goods.Txt_Num:SetText(PlayerData.FormatNumThousands(showTotal))
            remainProfit = remainProfit - showTotal
            DataModel.AniData.PieInfo[i] = percent
          end
        else
          if i ~= 4 then
            alpha = 0.5
            goods.Txt_Name:SetText("\226\128\148\226\128\148")
          end
          goods.Txt_Num:SetText(0)
        end
        if i ~= 4 then
          goods.Txt_Name:SetAlpha(alpha)
          goods.Txt_Num:SetAlpha(alpha)
          goods.Txt_Num.Img_Icon:SetAlpha(alpha)
        end
      end
      element.Img_Top3.Img_Goods.StaticGrid_Goods.grid.self:RefreshAllElement()
      local todayDate = os.date("*t", TimeUtil:GetServerTimeStamp())
      local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
      local refreshHour = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
      local recordDay = todayDate.day
      local recordMonth = todayDate.month
      local recordYear = todayDate.year
      if refreshHour > todayDate.hour then
        recordDay = recordDay - 1
      end
      local maxNum = 0
      
      local function getRoundNum(num)
        if 0 <= num then
          return math.floor(num + 0.5)
        else
          return math.ceil(num - 0.5)
        end
      end
      
      local profit = getRoundNum(info.profit)
      local reportProfit = recent_trade_report[1].profit + profit
      if reportProfit < 0 then
        reportProfit = 0
      end
      recent_trade_report[1].profit = reportProfit
      for k, v in pairs(recent_trade_report) do
        if maxNum < v.cost then
          maxNum = v.cost
        end
        if maxNum < v.profit then
          maxNum = v.profit
        end
      end
      DataModel.AniData.PBProfit = {}
      DataModel.AniData.PBCost = {}
      DataModel.AniFrameFunc.PBProfit = {}
      DataModel.AniFrameFunc.PBCost = {}
      for i = 1, 4 do
        local group_pb = element.Img_4Day["Group_PB" .. i]
        local t = recent_trade_report[i]
        group_pb:SetActive(t ~= nil)
        local recentProfit = 0
        local recentCost = 0
        if t ~= nil then
          if i ~= 1 then
            recordDay = recordDay - 1
            if recordDay == 0 then
              recordMonth = recordMonth - 1
              if recordMonth == 0 then
                recordDay = 31
                recordMonth = 12
                recordYear = recordYear - 1
              elseif recordMonth == 2 then
                if recordYear % 400 == 0 or recordYear % 4 == 0 and recordYear % 100 ~= 0 then
                  recordDay = 29
                else
                  recordDay = 28
                end
              elseif recordMonth == 4 or recordMonth == 6 or recordMonth == 9 or recordMonth == 11 then
                recordDay = 30
              else
                recordDay = 31
              end
            end
            group_pb.Txt_Day:SetText(recordMonth .. "/" .. recordDay)
          end
          recentProfit = t.profit
          recentCost = t.cost
        end
        local isNull = recentProfit == 0 and recentCost == 0
        if group_pb.Img_Null then
          group_pb.Img_Null:SetActive(isNull)
        end
        local profitPercent = recentProfit / maxNum
        local costPercent = recentCost / maxNum
        group_pb.Img_Profit:SetFilledImgAmount(0)
        group_pb.Img_Cost:SetFilledImgAmount(0)
        group_pb.Txt_Profit:SetActive(not isNull and 0 < profitPercent)
        group_pb.Txt_Cost:SetActive(not isNull and 0 < costPercent)
        if not isNull then
          group_pb.Txt_Profit:SetText(PlayerData:TransitionNum(recentProfit))
          group_pb.Txt_Cost:SetText(PlayerData:TransitionNum(recentCost))
          group_pb.Txt_Profit:SetAnchoredPositionY(200 * profitPercent)
          group_pb.Txt_Cost:SetAnchoredPositionY(200 * costPercent)
        end
        DataModel.AniData.PBProfit[i] = profitPercent
        DataModel.AniData.PBCost[i] = costPercent
        DataModel.AniFrameFunc.PBProfit[i] = function(val)
          group_pb.Img_Profit:SetFilledImgAmount(val)
        end
        DataModel.AniFrameFunc.PBCost[i] = function(val)
          group_pb.Img_Cost:SetFilledImgAmount(val)
        end
      end
      if data.rank_profit_per < 0.01 then
        data.rank_profit_per = 0.01
      end
      View.Group_Sell.Img_Ranking.Txt_Num:SetText(string.format(GetText(80601883), PlayerData:GetUserInfo().role_name, math.floor(data.rank_profit_per * 100 + 0.5) .. "%"))
      NPCDialog.SetNPC(element.Group_NPC, data.npcId, "sellSettlementText", "qResUrl")
      View.Group_Sell.Img_Profit.Txt_Num.self:SetActive(false)
      View.Group_Sell.Img_Profit.Txt_Num.Group_Sound:SetActive(true)
      View.self:PlayAnimOnce("SellIn")
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.FrameEnd then
      return
    end
    DataModel.RecordFrame = DataModel.RecordFrame + 1
    local frameEnd = true
    for k, v in pairs(DataModel.CurAniFrame) do
      if v.startFrame then
        if v.startFrame < DataModel.RecordFrame and v.endFrame >= DataModel.RecordFrame then
          local totalFrame = v.endFrame - v.startFrame
          local playFrame = DataModel.RecordFrame - v.startFrame
          local percent = playFrame / totalFrame
          local info = DataModel.AniData[k]
          local func = DataModel.AniFrameFunc[k]
          pcall(func, info * percent)
        end
        frameEnd = frameEnd and DataModel.RecordFrame > v.endFrame
      else
        for k1, v1 in ipairs(v) do
          if v1.startFrame < DataModel.RecordFrame and v1.endFrame >= DataModel.RecordFrame then
            local totalFrame = v1.endFrame - v1.startFrame
            local playFrame = DataModel.RecordFrame - v1.startFrame
            local percent = playFrame / totalFrame
            local info = DataModel.AniData[k][k1]
            local func = DataModel.AniFrameFunc[k][k1]
            if info and func then
              pcall(func, info * percent)
            end
          end
          frameEnd = frameEnd and DataModel.RecordFrame > v1.endFrame
        end
      end
    end
    if frameEnd then
      DataModel.FrameEnd = frameEnd
    end
  end,
  ondestroy = function()
    DataModel.AniFrameFunc = nil
    DataModel.AniData = nil
    DataModel.FrameEnd = true
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

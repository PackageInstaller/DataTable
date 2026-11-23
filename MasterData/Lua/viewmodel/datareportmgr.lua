




DataReportMgr= {}


local function RequestData(event,askData,succCallBack,failCallBack)
    local data={};
    data["event"]=event;
    data["log"]= json.encode(askData);
    ApiMgr.Request("log_client_event", data, true, succCallBack, failCallBack, false);
end

function DataReportMgr.RequestBiliData(event,askData,succCallBack,failCallBack)
    local data={};
    data["Event"]=event;
    data["Probs"]= json.encode(askData);
    ApiMgr.Request("log_bili_event", data, true, succCallBack, failCallBack, false, false);
end


function DataReportMgr.AchievementTaskJumpPage(ptaskId,ptype)
    local askData={};
    askData["accountId"]=DataMgr.Player.uid;
    askData["assignmentId"]=ptaskId;
    askData["endTime"]=0;
    askData["types"]=ptype;
    askData["status"]=2;
    askData["isJump"]=0;
    RequestData("assignment",askData,function()  end,function()  end);
end


function DataReportMgr.ClickPayView(goodsId,goodsType)
    local askData={}
    askData["accountId"]=DataMgr.Player.uid
    askData["goodsId"]=goodsId
    askData["goodsType"]=goodsType
    RequestData("clickbuyview", askData,nil ,nil, false);
end

function DataReportMgr.NetClickGoodsAndPage(goodsId,mallHomeTab,mallSubTab)
    local askData={}
    askData["accountId"]=DataMgr.Player.uid
    askData["goodsId"]=goodsId
    askData["hometab"]=mallHomeTab
    askData["subtab"]=mallSubTab
    RequestData("shopclick", askData,nil ,nil);
end









DataReportMgr.goodsDataJson = nil
function DataReportMgr.OpenShopView(shopId,shop_sub_id,shopName,goodsList,type,sub_type)
    DataReportMgr.ShopGoodsJson(type,sub_type,goodsList)
    local askData = {}
    askData["shop_id"] = shopId
    askData["shop_sub_id"] = shop_sub_id
    askData["shop_name"] = shopName
    askData["goods_list"] = DataReportMgr.goodsDataJson
    DataReportMgr.RequestBiliData("shop_open", askData,nil ,nil);
end

function DataReportMgr.OpenShopShowView(shopId,shop_sub_id,shopName,goodsList,type,sub_type)

    if TimerConst.ShopDataReportTime==nil then

        return
    end
    LuaMgr.RemoveTimer(TimerConst.ShopDataReportTime)
    LuaMgr.AddTimer(TimerConst.ShopDataReportTime,function()
        local askData = {}
        askData["shop_id"] = shopId
        askData["shop_sub_id"] = shop_sub_id
        askData["shop_name"] = shopName
        askData["goods_list"] = DataReportMgr.goodsDataJson
        DataReportMgr.RequestBiliData("shop_goods_show", askData,nil ,nil);
        LuaMgr.RemoveTimer(TimerConst.ShopDataReportTime)
    end,1,1,false)
end
function DataReportMgr.ShopGoodsJson(type,sub_type,goodsList)
    local tempData = {}
    local limitCount = nil
    local buyCount = 0
    if type == 2 then

        for i = 1, #goodsList do
            for k,v in pairs(ConfigMgr.Config.RandGoodsMap) do
                if goodsList[i] == k then
                    limitCount = DataMgr.Player.randShop["RandomShop"].buycnt[i].."/"..v.LimitCount
                    table.insert(tempData,{productid = k,amount = v.Price,currency = v.Currency,
                                           discount = v.Discount,buy_limit = limitCount,countdown = ""})
                end
            end
        end
    else
        local config = nil
        local sub_config = nil
        for i = 1, #goodsList do
            if type == 1 then

                config = ConfigHelper.GetChargeChannel(goodsList[i].ChargeGroup)
                if config ~= nil then
                    table.insert(tempData,{productid = goodsList[i].Id,amount = config.PriceShow,
                                           currency = config.Currency,discount = "",buy_limit = "",countdown = ""})
                end
            elseif type == 3 then
                if sub_type then

                    config = ConfigMgr.Config.charge[goodsList[i].Id]
                    if config ~= nil then
                        limitCount = DataHelper.GetShopRecordByGoodsId(config.Id).."/"..config.RefreshCount
                        if config.ChargeGroup == "" then
                            table.insert(tempData,{productid = config.Id,amount = config.Cost.count,
                                                   currency = config.Cost.id,discount = config.Discount,
                                                   buy_limit = limitCount,countdown = config.EndTime})
                        else
                            sub_config = ConfigHelper.GetChargeChannel(config.ChargeGroup)
                            if sub_config ~= nil then
                                table.insert(tempData,{productid = config.Id,amount = sub_config.PriceShow,
                                                       currency = sub_config.Currency,discount = config.Discount,
                                                       buy_limit = limitCount,countdown = config.EndTime})
                            end
                        end
                    end
                else

                    limitCount = DataHelper.GetShopRecordByGoodsId(goodsList[i].Id).."/"..goodsList[i].RefreshCount
                    table.insert(tempData,{productid = goodsList[i].Item,amount = goodsList[i].Price,
                                           currency = goodsList[i].Currency,discount = goodsList[i].Discount,
                                           buy_limit = limitCount,countdown = ""})
                end
            elseif type == 4 then

                buyCount = DataMgr.Player.moreModShop.buyinfo[goodsList[i].Id] == nil and 0 or DataMgr.Player.moreModShop.buyinfo[goodsList[i].Id]
                limitCount = buyCount.."/"..goodsList[i].RefreshCount
                table.insert(tempData,{productid = goodsList[i].Goods[1].id,amount = goodsList[i].Price[buyCount + 1],
                                       currency = goodsList[i].Currency,discount = "",buy_limit = limitCount,countdown = ""})
            elseif type==5 then

                local goodItem=goodsList[i];
                table.insert(tempData,{productid = goodItem.id,amount = goodItem.cost.count,
                                       currency = goodItem.cost.id,discount = "",buy_limit = goodItem.progress,countdown = ""})
                
                
            end
            
        end
        
    end
    DataReportMgr.goodsDataJson = tempData
end

return DataReportMgr;


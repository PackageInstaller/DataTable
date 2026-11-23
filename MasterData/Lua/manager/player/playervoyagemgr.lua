PlayerVoyageMgr = {
isBuy = true,
buyResetTime = 0,
sellResetTime = 0,
}

local this = {
rollDiceId = "",
rollDiceCount = 0,
specialDiceId = "",
captain = "",
selectMembers = nil,
members = nil,
shops = {},
buyShops = {},
};

PlayerVoyageMgr.Init = function()

end

PlayerVoyageMgr.Clear = function()
    this.members = nil;
    this.shops = nil;
    this.buyShops = {};
end


PlayerVoyageMgr.GetCurrentPort = function()
    local sailing = DataMgr.Player.Sailing;
    if (not IsNullOrEmpty(sailing.HarborID)) then
        if (sailing.Status == VoyageRichManStatus.Opening) then
            if (not ConfigVoyageMgr.IsPortTimeout(sailing.HarborID)) then
                return ConfigVoyageMgr.GetPortConfig(sailing.HarborID);
            end
        end
    end















    return nil;
end


PlayerVoyageMgr.IsPortLock = function(id)
    local config = ConfigVoyageMgr.GetPortConfig(id);
    if (config ~= nil) then
        if (IsNullOrEmpty(config.HarborPre)) then
            return false;
        end
        if (PlayerVoyageMgr.IsPortPass(config.HarborPre)) then
           return false; 
        end
    end
    return true;
end


PlayerVoyageMgr.IsPortPass = function(id)
    return DataMgr.Player.SailingPassRecords[id] ~= nil;
end


PlayerVoyageMgr.SetDices = function()
    local sailing = DataMgr.Player.Sailing;
    local captainConfig = ConfigVoyageMgr.GetCaptainConfig(sailing.Captain);
    if (captainConfig ~= nil) then
        this.specialDiceId = captainConfig.SkillParam[1];
    else
        this.specialDiceId = "";
    end
    this.rollDiceId = "1";
    for k, _ in pairs(sailing.Dices) do
        if (k ~= this.specialDiceId) then
            this.rollDiceId = k;
        end
    end
end


PlayerVoyageMgr.GetRollDiceId = function() 
    return this.rollDiceId;
end


PlayerVoyageMgr.GetRollDiceCount = function() 
    return this.rollDiceCount;
end


PlayerVoyageMgr.SetRollDiceCount = function(isReal)
    if (isReal) then
        this.rollDiceCount = PlayerVoyageMgr.GetDiceCount(this.rollDiceId);
    else
        this.rollDiceCount = this.rollDiceCount - 1;
    end
end


PlayerVoyageMgr.GetSpecialDiceId = function() 
    return this.specialDiceId;
end


PlayerVoyageMgr.GetDiceCount = function(id) 
    local count = DataMgr.Player.Sailing.Dices[id];
    if (count ~= nil) then
        return count;
    end
    return 0;
end


PlayerVoyageMgr.IsDiceCount = function()
    local dices = DataMgr.Player.Sailing.Dices;
    for _, v in pairs(dices) do
        if (v > 0) then
            return true;
        end
    end
    return false;
end


PlayerVoyageMgr.CorsairRollDice = function()
    ApiMgr.Request("sailing/corsairRollDice", {}, true, this.CorsairRoolDiceResponse, nil, true, true);
end


this.CorsairRoolDiceResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        VoyageRichManMgr.CorsairRollDice(data.result);
    end
end


PlayerVoyageMgr.Drop = function(callback)
    ApiMgr.Request("sailing/drop", {}, true, callback, nil, true, true);
end


PlayerVoyageMgr.OpenHarbor = function(harborID, captain, members)
    ApiMgr.Request("sailing/openHarbor", {HarborID=harborID, Captain=captain, Members=members}, true, this.OpenHarborResponse, nil, true, true);
end


this.OpenHarborResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        VoyageRichManMgr.OpenHarbor(true);
        LuaMgr.ShowLuaPanel(UIName.VoyageLoadingViewModel);
    end
end


PlayerVoyageMgr.RollDice = function(diceID, customPoints, testPoint)
    ApiMgr.Request("sailing/rollDice", {DiceID=diceID, CustomPoints=customPoints, TestPoint=testPoint}, true, this.RollDiceResponse, nil, true, true);
end


this.RollDiceResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        VoyageRichManMgr.RollDiceResponse(data.result);
    end
end


PlayerVoyageMgr.TestBattleEnd = function(success, roleHPMap)
    ApiMgr.Request("sailing/test_battle_end", {Success=success, RoleHPMap=roleHPMap}, true, this.TestBattleEndResponse, nil, true, true);
end


this.TestBattleEndResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        
    end
end


PlayerVoyageMgr.IsMyRollDice = function()
    local sailing = DataMgr.Player.Sailing;
    if (not IsNull(sailing.Corsair) and sailing.Corsair.IsTurn) then
        return false;
    end
    return true;
end


PlayerVoyageMgr.GetQuestData = function(id)
    return DataMgr.Player.SailingQuestions[id];
end


PlayerVoyageMgr.GetQuestionReward = function(questionID, callback)
    local data = {};
    if (not IsNullOrEmpty(questionID)) then
        data.QuestionID = questionID;
    end
    ApiMgr.Request("sailing/getQuestionReward", data, true, callback, nil, true, true);
end


PlayerVoyageMgr.SetCaptain = function(captain)
    this.captain = captain;
end


PlayerVoyageMgr.GetCaptain = function()
    return this.captain;
end


PlayerVoyageMgr.IsLockCaptain = function(captainConfig)
    if (IsNullOrEmpty(captainConfig.UnlockHarbor)) then return false end

    if (PlayerVoyageMgr.IsPortPass(captainConfig.UnlockHarbor)) then return false end
    
    return true;
end


PlayerVoyageMgr.GetTodayDelegateQuest = function()
    local questConfig;
    local sailingQuestMap = ConfigMgr.Config.SailingQuestMap;
    local sailingQuestions = DataMgr.Player.SailingQuestions;
    for k, v in pairs(sailingQuestions) do
        questConfig = sailingQuestMap[k];
        if (questConfig ~= nil and questConfig.QuestType == 2) then
            return v;
        end
    end
    return nil;
end


PlayerVoyageMgr.ChoosePath = function(choose)
    ApiMgr.Request("sailing/choosePath", {Choose=choose}, true, this.ChoosePathResponse, nil, true, true);
end


this.ChoosePathResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        VoyageRichManMgr.ChoosePathResponse(data.result);
    end
end 


PlayerVoyageMgr.GetPath = function(pos)
    local list = {};
    local path = DataMgr.Player.Sailing.Path;
    local len = #path;
    for i = len, 1, -1 do
        if (path[i] == pos) then break end
        
        table.insert(list, 1, path[i]);
    end
    return list;
end


PlayerVoyageMgr.InitMembers = function()
    this.members = {};
    local list = DataMgr.Player.Sailing.Members;
    for _, v in pairs(list) do
        if (v.HP > 0) then
            table.insert(this.members, v.ID);
        end
    end
end


PlayerVoyageMgr.GetMembers = function()
    return this.members;
end


PlayerVoyageMgr.GetHideMembers = function()
    local member;
    local list = {};
    local len = #this.members;
    local map = DataMgr.Player.Sailing.Members;
    for i = 1, len do
        member = map[this.members[i]];
        if (member.HP <= 0) then
            table.insert(list, i);
        end
    end
    return list;
end


PlayerVoyageMgr.GetMemberIndex = function(id)
    local len = #this.members;
    for i = 1, len do
        if (this.members[i] == id) then
            return i;
        end
    end
    return 0;
end


PlayerVoyageMgr.GetMember = function(id)
    return DataMgr.Player.Sailing.Members[id];
end


PlayerVoyageMgr.IsCurrentPos = function(harborID)
    local sailing = DataMgr.Player.Sailing;
    if (not IsNullOrEmpty(sailing.HarborID) and sailing.Status == VoyageRichManStatus.Opening) then
        return sailing.HarborID == harborID;
    end
    local sailingLastHarbor = DataMgr.Player.SailingLastHarbor;
    if (IsNullOrEmpty(sailingLastHarbor)) then
        local portList = ConfigVoyageMgr.GetPortList();
        return harborID == portList[1].HarborID;
    end
    return sailingLastHarbor == harborID;
end


PlayerVoyageMgr.IsBox = function(eventID)
    local record = DataMgr.Player.SailingRecords[eventID];
    return record ~= nil;
end


PlayerVoyageMgr.SetSelectMembers = function(members)
    this.selectMembers = {};
    if (members ~= nil) then
        local member;
        local len = #members;
        for i = 1, len do
            member = members[i];
            if (not IsNullOrEmpty(member)) then
                table.insert(this.selectMembers, member);
            end
        end
    end
end


PlayerVoyageMgr.GetSelectMembers = function()
    return this.selectMembers;
end


PlayerVoyageMgr.GetSailingMailReward = function(mailID)
    ApiMgr.Request("sailing/getSailingMailReward", {MailID=mailID}, true, this.GetSailingMailRewardResponse, nil, true, true);
end


this.GetSailingMailRewardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageMailSelect);
    end
end


PlayerVoyageMgr.GetSailingGoodsPrice = function()
    ApiMgr.Request("sailing/getSailingGoodsPrice", {}, true, this.GetSailingGoodsPriceResponse, nil, true, true);
end


this.GetSailingGoodsPriceResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        PlayerVoyageMgr.SetSailingGoodsPrice(data.result);
        LuaMgr.ShowLuaPanel(UIName.VoyageTradeViewModel);
    end
end


PlayerVoyageMgr.SetSailingGoodsPrice = function(result)
    local goods = result.Goods;
    result.Goods = nil;
    PlayerVoyageMgr.buyResetTime = result.NextReplenishmentTime;
    PlayerVoyageMgr.sellResetTime = result.NextRestTime;
    this.InitGoods(goods);
end


this.InitGoods = function(goods)
    this.shops = {};
    if (goods ~= nil) then
        local len = #goods;
        for i = 1, len do
            this.shops[i] = goods[i];
        end
    end
end


PlayerVoyageMgr.GetGoods = function(id)
    local count = DataMgr.Player.SailingCargos[id];
    if (count ~= nil) then
        return count;
    end
    return 0;
end


PlayerVoyageMgr.GetShops = function()
    local shop;
    local list = {};
    local len = #this.shops;
    if (PlayerVoyageMgr.isBuy) then
        for i = 1, len do
            shop = this.shops[i];
            if (shop.BuyAccount > 0) then
                table.insert(list, shop);
            end
        end
    else
        for i = 1, len do
            shop = this.shops[i];
            if (shop.SoldAccount > 0 and PlayerVoyageMgr.GetGoods(shop.GoodsID) > 0) then
                table.insert(list, shop);
            end
        end
    end
    return list;
end


PlayerVoyageMgr.GetShop = function(id)
    local shop;
    local len = #this.shops;
    for i = 1, len do
        shop = this.shops[i];
        if (shop.GoodsID == id) then
            return shop;
        end
    end
    return nil;
end


PlayerVoyageMgr.ClearShops = function()
    this.shops = {};
end


PlayerVoyageMgr.BuyShop = function(id, count)
    if (count <= 0) then return false end
    
    local shop = PlayerVoyageMgr.GetShop(id);
    if (shop == nil) then return false end

    local buyShop = PlayerVoyageMgr.GetBuyShop(id);
    if (buyShop == nil) then
        buyShop = {id = id, price = shop.CurrentPrice, count = 0};
        table.insert(this.buyShops, buyShop);
    end
    if (PlayerVoyageMgr.isBuy) then
        shop.BuyAccountRemaining = shop.BuyAccountRemaining - count;
    else

    end
    buyShop.count = buyShop.count + count;
    return true;
end


PlayerVoyageMgr.IsBuyShop = function(id, count)
    local shop = PlayerVoyageMgr.GetShop(id);
    if (shop == nil) then return false end
    
    if (shop.BuyAccountRemaining < count) then return false end

    local price = PlayerVoyageMgr.CalcBuyShopPrice();
    local coins = PlayerItemMgr.GetItemCountById("5130");
    return coins >= price + count * shop.CurrentPrice;
end


PlayerVoyageMgr.CancelBuyShop = function(id)
    local shop = PlayerVoyageMgr.GetShop(id);
    if (shop == nil) then return false end

    local buyShop = PlayerVoyageMgr.GetBuyShop(id);
    if (buyShop == nil) then return false end

    if (PlayerVoyageMgr.isBuy) then
        shop.BuyAccountRemaining = shop.BuyAccountRemaining + buyShop.count;
    else

    end
    PlayerVoyageMgr.RemoveBuyShop(id);
    return true;
end


PlayerVoyageMgr.CancelBuyAllShop = function()
    while (#this.buyShops > 0) do
        PlayerVoyageMgr.CancelBuyShop(this.buyShops[1].id);
    end
end


PlayerVoyageMgr.BuyAllShops = function()
    local shop;
    local status = -1;
    local shops = PlayerVoyageMgr.GetShops();
    local len = #shops;
    for i = 1, len do
        shop = shops[i];
        if (shop.BuyAccountRemaining > 0) then
            status = 0;
            break;
        end
    end
    if (status == 0) then
        for i = 1, len do
            shop = shops[i];
            while (shop.BuyAccountRemaining > 0) do
                if (PlayerVoyageMgr.IsBuyShop(shop.GoodsID, 1)) then
                    PlayerVoyageMgr.BuyShop(shop.GoodsID, 1);
                    status = 1;
                else
                    break;
                end
            end
        end
    end
    return status;
end


PlayerVoyageMgr.IsShopSellOut = function()
    local shop;
    local shops = PlayerVoyageMgr.GetShops();
    local len = #shops;
    for i = 1, len do
        shop = shops[i];
        if (shop.BuyAccountRemaining > 0) then
            return false;
        end
    end
    return true;
end


PlayerVoyageMgr.SellAllShops = function()
    local shop;
    local count;
    local buyCount;
    local sailingCargos = DataMgr.Player.SailingCargos;
    local shops = PlayerVoyageMgr.GetShops();
    local len = #shops;
    for i = 1, len do
        shop = shops[i];
        count = sailingCargos[shop.GoodsID];





        buyCount = count - PlayerVoyageMgr.GetSellShopCount(shop.GoodsID);
        if (buyCount > 0) then
            PlayerVoyageMgr.BuyShop(shop.GoodsID, buyCount);
        end
    end
end


PlayerVoyageMgr.HasShop = function(id)
    local shop = PlayerVoyageMgr.GetShop(id);
    if (shop == nil) then return false end

    if (PlayerVoyageMgr.isBuy) then
        return shop.BuyAccountRemaining > 0;
    end

    return shop.SoldAccount > 0;
end


PlayerVoyageMgr.GetBuyShop = function(id)
    local shop;
    local len = #this.buyShops;
    for i = 1, len do
        shop = this.buyShops[i];
        if (shop.id == id) then
            return shop;
        end
    end
    return nil;
end


PlayerVoyageMgr.GetSellShopCount = function(id)
    local shop;
    local len = #this.buyShops;
    for i = 1, len do
        shop = this.buyShops[i];
        if (shop.id == id) then
            return shop.count;
        end
    end
    return 0;
end


PlayerVoyageMgr.RemoveBuyShop = function(id)
    local len = #this.buyShops;
    for i = 1, len do
        if (this.buyShops[i].id == id) then
            table.remove(this.buyShops, i);
            break;
        end
    end
end


PlayerVoyageMgr.GetBuyShops = function()
    return this.buyShops;
end


PlayerVoyageMgr.CalcBuyShopPrice = function()
    local shop;
    local price = 0;
    local len = #this.buyShops;
    for i = 1, len do
        shop = this.buyShops[i];
        price = price + shop.count * shop.price;
    end
    return price;
end


PlayerVoyageMgr.ClearBuyShop = function()
    this.buyShops = {};
end


PlayerVoyageMgr.GetMoney = function()
    return PlayerItemMgr.GetItemCountById("5130");
end


PlayerVoyageMgr.Buy = function(goods)
    ApiMgr.Request("sailing/buy", {Goods = goods}, true, this.BuyResponse, nil, true, true);
end


this.BuyResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        PlayerVoyageMgr.ClearBuyShop();
        PlayerVoyageMgr.SetSailingGoodsPrice(data.result);
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageTradeBuyShop, false, true);
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRefreshInterest);
    end
end


PlayerVoyageMgr.Sell = function(goods)
    ApiMgr.Request("sailing/sell", {Goods = goods}, true, this.SellResponse, nil, true, true);
end


this.SellResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        PlayerVoyageMgr.ClearBuyShop();
        PlayerVoyageMgr.SetSailingGoodsPrice(data.result);
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageTradeBuyShop, false, false);
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRefreshInterest);
    end
end


PlayerVoyageMgr.ReceiveSailingPropertyInterest = function()
    ApiMgr.Request("sailing/receiveSailingPropertyInterest", {}, true, this.ReceiveSailingPropertyInterestResponse, nil, true, true);
end


this.ReceiveSailingPropertyInterestResponse = function(result)
    LuaMgr.HidePanel(UIName.VoyageInterestViewModel);
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRefreshInterest);
end


PlayerVoyageMgr.GetUnlockCardCount = function()
    local count = 0;
    local sailingCards = DataMgr.Player.SailingCards;
    for k, _ in pairs(sailingCards) do
        count = count + 1;
    end
    return count;
end


PlayerVoyageMgr.UnlockCard = function(callback)
    ApiMgr.Request("sailing/unlockCard", {}, true, callback, nil, true, true);
end


PlayerVoyageMgr.EnterLeaveDungeon = function(dungeonId, callback)
    ApiMgr.Request("enter_leave_dungeon", {dungeonId=dungeonId}, true, callback, nil, true, true);
end


PlayerVoyageMgr.Market = function()
    ApiMgr.Request("sailing/market", {}, true, this.MarketResponse, nil, true, true);
end


this.MarketResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        LuaMgr.ShowLuaPanel(UIName.VoyageTradePriceViewModel, data.result.Goods);
    end
end


PlayerVoyageMgr.GoodsStatus = function(harborId, callback)
    ApiMgr.Request("sailing/goodsStatus", {HarborId=harborId}, true, callback, nil, true, true);
end


PlayerVoyageMgr.CheckRedDot = function()
    local quest = this.CheckQuest();
    RedMgr.Singleton:UpdateClientRedData("10002", quest);
    local mail = this.CheckMail();
    RedMgr.Singleton:UpdateClientRedData("10003", mail);
    local money = this.CheckMoney();
    RedMgr.Singleton:UpdateClientRedData("10005", money);
    local cards = this.CheckCards();
    RedMgr.Singleton:UpdateClientRedData("10004", cards);

    RedMgr.Singleton:UpdateClientRedData("10001", quest + mail + money + cards);
end


this.CheckQuest = function()
    local questData;
    local sailingQuestMap = ConfigMgr.Config.SailingQuestMap;
    for k, v in pairs(sailingQuestMap) do
        if (v.QuestType == 1) then
            questData = PlayerVoyageMgr.GetQuestData(k);
            if (questData ~= nil and questData.Status == 1) then
                return 1;
            end
        end
    end
    return 0;
end


this.CheckMail = function()
    local sailingMail;
    local sailingMails = DataMgr.Player.SailingMails;
    local sailingMailMap = ConfigMgr.Config.SailingMailMap;
    for k, _ in pairs(sailingMailMap) do
        sailingMail = sailingMails[k];
        if (sailingMail ~= nil and sailingMail.Status == 1) then
            return 1;
        end
    end
    return 0;
end


this.CheckMoney = function()
    local questData;
    local sailingQuestMap = ConfigMgr.Config.SailingQuestMap;
    for k, v in pairs(sailingQuestMap) do
        if (v.QuestType == 3) then
            questData = PlayerVoyageMgr.GetQuestData(k);
            if (questData ~= nil and questData.Status == 1) then
                return 1;
            end
        end
    end
    return 0;
end


this.CheckCards = function()
    local cards = ConfigVoyageMgr.GetCards();
    local unlockCardCount = PlayerVoyageMgr.GetUnlockCardCount();
    if (unlockCardCount < #cards) then
        local cost = ConfigVoyageMgr.GetCardCost();
        if (cost ~= nil) then
            local itemCount = PlayerItemMgr.GetItemCountById(cost.id);
            if (itemCount >= cost.count) then
                return 1;
            end
        end
    end
    return 0;
end
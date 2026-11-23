ConfigVoyageMgr = {}

local this = {
portMap = nil,
portList = nil,
eventPoolMap = nil,
captains = nil,
};

ConfigVoyageMgr.Init = function()
    this.InitPorts();
    this.InitEventPool();
    this.InitCaptains();
end

ConfigVoyageMgr.Clear = function()
    this.portMap = nil;
    this.portList = nil;
    this.eventPoolMap = nil;
    this.captains = nil;
end


this.InitPorts = function()
    this.portMap = {};
    this.portList = {};
    local sysTime = LuaMgr.Timestamp();
    local sailingHarborMap = ConfigMgr.Config.SailingHarborMap;
    for k, v in pairs(sailingHarborMap) do
        if (v.OpenTime > 0 and sysTime < v.CloseTime) then
            table.insert(this.portList, v);
            this.portMap[k] = v;
        end
    end
    table.sort(this.portList, this.PortSort);
end


this.PortSort = function(a, b)
    return string.lower(a.HarborID) < string.lower(b.HarborID);
end


ConfigVoyageMgr.IsOpen = function()
    return #this.portList > 0;
end


ConfigVoyageMgr.IsPortTimeout = function(id)
    local config = this.portMap[id];
    if (config ~= nil) then
        local sysTime = LuaMgr.Timestamp();
        if (sysTime >= config.OpenTime and sysTime < config.CloseTime) then
            return false;
        end
    end
    return true;
end


ConfigVoyageMgr.GetHarborPre = function(id)
    local config = ConfigVoyageMgr.GetPortConfig(id);
    if (config ~= nil) then
        if (IsNullOrEmpty(config.HarborPre)) then return nil end
        
         return ConfigVoyageMgr.GetPortConfig(config.HarborPre);
    end
    return nil;
end


ConfigVoyageMgr.GetPortList = function()
    return this.portList;
end


ConfigVoyageMgr.GetPortIndex = function(id)
    local len = #this.portList;
    for i = 1, len do
        if (this.portList[i].HarborID == id) then
            return i;
        end
    end
    return 1;
end


ConfigVoyageMgr.GetPortConfig = function(id)
    return this.portMap[id];
end


ConfigVoyageMgr.GetSailingEvent = function(id)
    return ConfigMgr.Config.SailingEventMap[id];
end


ConfigVoyageMgr.GetSailingDice = function(id)
    return ConfigMgr.Config.SailingDiceMap[id];
end


ConfigVoyageMgr.GetQuestList = function()
    local questList = {};
    local sailingQuestMap = ConfigMgr.Config.SailingQuestMap;
    for _, v in pairs(sailingQuestMap) do
        if (v.QuestType == 1) then
            table.insert(questList, v);
        end
    end
    table.sort(questList, this.SortQuest);
    return questList;
end


this.SortQuest = function(a, b)
    return string.lower(a.QuestID) < string.lower(b.QuestID);
end


ConfigVoyageMgr.GetQuestById = function(id)
    return ConfigMgr.Config.SailingQuestMap[id];
end


this.InitCaptains = function()
    this.captains = {};
    local sailingCaptainMap = ConfigMgr.Config.SailingCaptainMap;
    for _, v in pairs(sailingCaptainMap) do
        table.insert(this.captains, v);
    end
    table.sort(this.captains, this.CaptainSort);
    if (#this.captains > 0) then
        PlayerVoyageMgr.SetCaptain(this.captains[1].CaptainID);
    end
end


this.CaptainSort = function(a, b)
    return tonumber(a.CaptainID) < tonumber(b.CaptainID);
end


ConfigVoyageMgr.GetCaptains = function()
    return this.captains;
end


ConfigVoyageMgr.GetCaptainConfig = function(id)
    return ConfigMgr.Config.SailingCaptainMap[id];
end


ConfigVoyageMgr.GetCaptainTexture = function(id, select)
    local captainConfig = ConfigMgr.Config.SailingCaptainMap[id];
    if (captainConfig ~= nil) then
        local pic = select and captainConfig.CaptainPic or captainConfig.CaptainPicLock;
        return LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/Voyage/%s.png", pic));
    end
    return nil;
end


ConfigVoyageMgr.GetCaptainCharacterCount = function(id)
    local captainConfig = ConfigMgr.Config.SailingCaptainMap[id];
    if (captainConfig ~= nil) then
        local count = captainConfig.TeamAmount;
        if (captainConfig.SkillType == 3) then
            count = count + tonumber(captainConfig.SkillParam[1]);
        end
        return count;
    end
    return ConfigMgr.Config.constants.SailingCharacterNumber;
end


ConfigVoyageMgr.IsCaptainSelectDice = function(id)
    local captainConfig = ConfigMgr.Config.SailingCaptainMap[id];
    if (captainConfig ~= nil) then
        return captainConfig.SkillType == 2;
    end
    return false;
end


this.InitEventPool = function()
    this.eventPoolMap = {};
    local key;
    local config;
    local sailingEventPoolList = ConfigMgr.Config.SailingEventPoolList;
    local len = #sailingEventPoolList;
    for i = 1, len do
        config = sailingEventPoolList[i];
        key = config.EventPool .. config.EventID .. config.GridNumber;
        this.eventPoolMap[key] = config;
    end
end


ConfigVoyageMgr.GetEventPoolConfig = function(eventPool, eventId, gridNumber)
    return this.eventPoolMap[eventPool .. eventId .. gridNumber];
end


ConfigVoyageMgr.GetEventPoolDungeons = function(eventPoolId)
    local sailingEventPool;
    local dungeons = {};
    local sailingEventPoolList = ConfigMgr.Config.SailingEventPoolList;
    local len = #sailingEventPoolList;
    for i = 1, len do
        sailingEventPool = sailingEventPoolList[i];
        if (sailingEventPool.EventPool == eventPoolId and StartsWith(sailingEventPool.EventID, "dungeon") and not this.EventPoolContains(dungeons,sailingEventPool)) then
            table.insert(dungeons, sailingEventPool);
        end
    end
    return dungeons;
end


this.EventPoolContains = function(table,value)
    for i, v in ipairs(table) do
        if v.EventID == value.EventID then
            return true
        end
    end
    return false
end


ConfigVoyageMgr.GetMoneyQuestList = function()
    local questList = {};
    local sailingQuestMap = ConfigMgr.Config.SailingQuestMap;
    for _, v in pairs(sailingQuestMap) do
        if (v.QuestType == 3) then
            table.insert(questList, v);
        end
    end
    table.sort(questList, this.SortQuest);
    return questList;
end


ConfigVoyageMgr.GetCards = function()
    local cards = {};
    local sailingGoodsMap = ConfigMgr.Config.SailingGoodsMap;
    for _, v in pairs(sailingGoodsMap) do
        if (v.GoodsType == 3) then
            table.insert(cards, v);
        end
    end
    table.sort(cards, this.SortCard);
    return cards;
end


this.SortCard = function(a, b)
    return string.lower(a.GoodsID) < string.lower(b.GoodsID);
end


ConfigVoyageMgr.GetCardCost = function()
    local sailingGoodsMap = ConfigMgr.Config.SailingGoodsMap;
    for _, v in pairs(sailingGoodsMap) do
        if (v.GoodsType == 3) then
            return v.UnlockType[1];
        end
    end
    return "";
end


ConfigVoyageMgr.GetTradeGoods = function()
    local list = {};
    local sailingGoodsMap = ConfigMgr.Config.SailingGoodsMap;
    for _, v in pairs(sailingGoodsMap) do
        if (v.GoodsType == 1 or v.GoodsType == 2) then
            table.insert(list, v);
        end
    end
    table.sort(list, this.SortGoods);
    return list;
end


this.SortGoods = function(a, b)
    return string.lower(a.GoodsID) < string.lower(b.GoodsID);
end
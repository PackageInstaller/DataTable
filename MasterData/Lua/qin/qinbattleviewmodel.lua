require("Qin/QinConst")
require("Qin/QinBattleItem")
require("Qin/QinBattleCountryItem")
require("Qin/QinMapItem")

local this = {
    mapItem = nil,
    countryList = nil,
    battleItem1 = nil,
    battleItem2 = nil,
    selectIndex = 1,
};

local objs = {

    mapTF = { path = "root/Map", type = "Transform" },
    countryItem = { path = "template/CountryItem", type = "GameObject" },
    countrysGO = { path = "root/Left/Countrys", type = "GameObject" },
    countrysTF = { path = "root/Left/Countrys", type = "Transform" },
    battle1 = { path = "root/Middle/Battle1", type = "GameObject" },
    battle2 = { path = "root/Middle/Battle2", type = "GameObject" },
    closeBtn = { path = "root/Middle/Close", type = "Button" },
};


this.SetData = function()
    local eventList = DataExHelper.EX_GetEventListByArea(QinActivityType.daqinMap_main);
    ConfigQinMgr.InitMainActivityMapEvent(eventList);
    this.SetCountryList();
    this.SelectCountry();   
    local oldData = PlayerQinMgr.GetOldQuest()
    if(oldData ~= nil)then
        PlayerQinMgr.SetOldQuest(nil)        
    end 
    this.mapItem:SetData(oldData);
end


this.SetCountryList = function()
    this.countryList:Clear();
    local listData;
    local listDatas = {};
    local len = 6;
    for i = 1, len do
        listData = UIListData.GetData(this.countryItem, "QinBattleCountryItem", {index=i, select=i==this.selectIndex});
        table.insert(listDatas, listData);
    end
    this.countryList:SetData(listDatas);
end


this.SelectCountry = function()
    this.events = ConfigQinMgr.GetMainActivityMapEvents(tostring(this.selectIndex));
    if (#this.events < 2) then return end
    this.finishNum = 0
    for i = 1, 2 do
        local eventData = PlayerQinMgr.GetActivityMapEvent(QinActivityType.daqinMap_main, this.events[i].id);
        if (eventData ~= nil) then
            if (eventData.complete) then
                if(not this.countrysGO.activeSelf)then
                    this.finishNum =  this.finishNum + 1
                end
            end
        end
    end 

    this.battleItem1:SetData(this.events[1]);
    this.battleItem2:SetData(this.events[2]);
end


this.OnClickClose = function()    
    LuaMgr.Back();
    if(this.finishNum == 2)then       
        LuaMgr.ShowLuaPanel(UIName.QinResultViewModel,this.events);
    end
end


this.OnBattleCountry = function(args)
    this.selectIndex = args[0];
    PlayerQinMgr.SetBattleCountry(this.selectIndex);
    this.SetCountryList();
    this.SelectCountry();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.mapItem = QinMapItem.New(this.mapTF);
        this.countryList = UIListView.New(this.countrysTF);
        this.battleItem1 = QinBattleItem.New(this.battle1);
        this.battleItem2 = QinBattleItem.New(this.battle2);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH.."DaQin/DQ_YP_02.mp3");
        vm.behaviour:UpdateTopBar("", this.OnClickClose)    

        LuaMgr.AddUIEventListener(UIEventConst.QinBattleCountry, this.OnBattleCountry);
        local isReview = false;
        local len = vm.behaviour.Params.Length;
        if (len >= 1) then
            isReview = vm.behaviour.Params[0];
        end
        SetActive(this.countrysGO, isReview);
        if (vm.behaviour.IsPop) then
            this.selectIndex = PlayerQinMgr.GetBattleCountry();
        else
            if (len >= 2) then
                this.selectIndex = vm.behaviour.Params[1];
            else
                this.selectIndex = 1;    
            end
        end
        PlayerQinMgr.SetBattleCountry(this.selectIndex);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.QinBattleCountry, this.OnBattleCountry);
        this.countryList:Clear();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        if (this.mapItem ~= nil) then
            this.mapItem:Destroy();
            this.mapItem = nil;
        end
        UIListView.ClearItem("QinBattleCountryItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
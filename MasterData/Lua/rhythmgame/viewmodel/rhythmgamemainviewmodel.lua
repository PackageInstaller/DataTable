require("RhythmGame/ViewModel/RhythmGameItemEffect")

local this = {
    itemEffectList = nil
};

local objs = {
    rootLeft = { path = "root/Left", type = "GameObject" },
    rootMiddle = { path = "root/Middle", type = "GameObject" },
    signInBtn = { path = "root/Left/SignIn", type = "Button" },
    achieveBtn = { path = "root/Left/Achieve", type = "Button" },
    demoBtn = { path = "root/Right/Demo", type = "Button" },
    exchangeBtn = { path = "root/Left/Exchange", type = "Button" },
    battleBtn = { path = "root/Right/Battle", type = "Button" },
    musicBtn = { path = "root/Right/Music", type = "Button" },    
    musicGO = { path = "root/Right/Music", type = "GameObject" },    
    itemEffectTF = { path = "root/Left/ItemGroup/HGroup", type = "Transform" },
    itemEffectItem = { path = "template/ItemEffect", type = "GameObject" },
    textTime = { path = "root/Middle/Image/Text/TextTime", type = "Text" },
};


this.SetData = function()
    local music = DataExHelper.GetDataExByTag(ActivityKey.musicYDW);
    if  not music then
        this.textTime.text = ""
        return
    end

    local time = music.expireTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, m = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("<color=#bff1e5>%s</color>%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("<color=#bff1e5>%s</color>%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("<color=#bff1e5>%s</color>%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.textTime.text = string.format(timeStr);  

end


this.SetItemEffects = function()
    this.itemEffectList:Clear();
    local listData;
    local listDatas = {};
    local equips = DataMgr.Player.musicEquips.Equip;
    
    local musicEquips = {}
    for k, v in pairs(equips) do
        local item = RhythmGameMgr.GetMusicEquip(tonumber(k))
        table.insert(musicEquips, item)
    end
    if #musicEquips <= 0 then
        return
    end

    table.sort(musicEquips, function(a, b)
        return a.id < b.id
    end)

    for k, v in ipairs(musicEquips) do
        listData = UIListData.GetData(this.itemEffectItem, "RhythmGameItemEffect", v);
        table.insert(listDatas, listData);
    end

    listData = UIListData.GetData(this.itemEffectItem, "RhythmGameItemEffect", {id=-1});
    table.insert(listDatas, listData);

    this.itemEffectList:SetData(listDatas);
end

this.OnItemEffect = function(args)
    local musicAlbum = args[0];
    LuaMgr.ShowLuaPanel(UIName.RhythmGameItemEffectSelectViewModel, args[0]);
end


this.OnClickSignIn = function()
    LuaMgr.ShowLuaPanel(UIName.RhythmGameSignInViewModel);
end


this.OnClickAchieve = function()
    LuaMgr.ShowLuaPanel(UIName.RhythmGameMissionViewModel);
end


this.OnClickDemo = function()

end


this.OnClickExchange = function()
    LuaMgr.ShowLuaPanel(UIName.RhythmGameShopViewModel);
end


this.OnClickBattle = function()
    LuaMgr.ShowLuaPanel(UIName.RhythmGameChapterViewModel);
end


this.OnClickMusic = function()
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("6901"), "aa"));

end

this.OnBack=function()
    if not DataExHelper.Check_Music() then
        LuaMgr.Back();
    else
        LuaMgr.Back(ActivityKey.musicYDW);
    end
end

local command = {}
local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.AddClick(this.achieveBtn, this.OnClickAchieve);
        LuaMgr.AddClick(this.demoBtn, this.OnClickDemo);
        LuaMgr.AddClick(this.exchangeBtn, this.OnClickExchange);
        LuaMgr.AddClick(this.battleBtn, this.OnClickBattle);
        LuaMgr.AddClick(this.musicBtn, this.OnClickMusic);
        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameMainViewModel);

        this.itemEffectList = UIListView.New(this.itemEffectTF);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        SetActive(this.rootLeft, false)
        SetActive(this.rootMiddle, false)
        SetActive(this.musicGO, false)

        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();
        PlayerRhythmGameMgr.CheckEntranceRedAndNewDot()
        RedMgr.Singleton:Refresh()
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameItemEffect, this.OnItemEffect);
    end,
    before_deactive = function(vm)
        this.itemEffectList:Clear();

        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameItemEffect, this.OnItemEffect);
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.signInBtn, this.OnClickSignIn);
        LuaMgr.RemoveClick(this.achieveBtn, this.OnClickAchieve);
        LuaMgr.RemoveClick(this.demoBtn, this.OnClickDemo);
        LuaMgr.RemoveClick(this.exchangeBtn, this.OnClickExchange);
        LuaMgr.RemoveClick(this.battleBtn, this.OnClickBattle);
        LuaMgr.RemoveClick(this.musicBtn, this.OnClickMusic);

        UIListView.ClearItem("RhythmGameItemEffect");
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameMainViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
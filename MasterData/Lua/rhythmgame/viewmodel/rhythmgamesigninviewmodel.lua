require("RhythmGame/ViewModel/RhythmGameSignInItem")

local this = {
    scrollView = nil,
    dayBoxList = {}
};

local objs = {
    dayBox = { path = "root/Middle/SignIn/Days/DayBox", type = "Transform" },
    dayText = { path = "root/Middle/SignIn/Days/Text", type = "Text" },
    skinName = { path = "root/Middle/SignIn/Skin/Name/Text", type = "Text" },
    tipsText = { path = "root/Middle/SignIn/Tips/Text", type = "Text" },
    progressSlider = { path = "root/Middle/SignIn/Days/Progress/ProgressSlider", type = "Image" },
    closeBtn = { path = "root/Middle/SignIn/Close", type = "Button" },
    signInItem = { path = "template/SignInItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/SignIn/ScrollView", type = "GameObject" },
};


this.SetData = function()   
    this.curDay = 0
    this.SetDayList();
end

this.InitDaysBox = function()
    for i = 1, this.dayBox.childCount do
        local child = this.dayBox:GetChild(i - 1)
        table.insert(this.dayBoxList, child)
    end
end


this.SetDayList = function()
    this.dataQuests = DataMgr.Player.quests;
    local scrollData;
    this.scrollView:Clear(false);
    local scrollDatas = {};
    for i, v in ipairs(this.totalConfig) do
        local cache = this.dataQuests[v.id]
        if (cache ~= nil) then   

            if (cache.state ~= 1) then
                this.curDay = i
            end
        else
            LuaDebug.error("累计登录没有服务器数据，对应id = "..v.id)
        end
        local data = {}
        data.data = cache
        data.config = v
        data.index = i
        scrollData = UIScrollData.GetData(this.signInItem, "RhythmGameSignInItem", 168, 486, data);
        table.insert(scrollDatas, scrollData);
    end
    this.dayText.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_10752"), this.curDay);
    this.progressSlider.fillAmount = (this.curDay - 0.5) / 7
    this.scrollView:SetParams(740, 500);
    this.scrollView:SetData(scrollDatas, true);
    for i,v in ipairs(this.dayBoxList) do
        SetActive(v.gameObject,i<=this.curDay)       
    end
    PlayerRhythmGameMgr.CheckSignEntranceRedDot() 
    RedMgr.Singleton:Refresh()  
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.RhythmGameSignInViewModel);
end

local data = {}
local command = {}



local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);        
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        this.InitDaysBox();
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameSignReceive, this.SetDayList);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end


        this.tipsText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_10751")
        this.totalConfig = DataExHelper.Check_ConfigQuestEventByGroupId(231);        
        this.SetData();
    end,
    before_deactive = function(vm)
        this.scrollView:Clear(true);
    end,
    before_destroy = function()       
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        UIScrollView.ClearItem("RhythmGameSignInItem");
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameSignReceive, this.SetDayList);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
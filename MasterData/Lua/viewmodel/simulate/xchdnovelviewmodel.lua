require("ViewModel/Simulate/XCHDNovelItem")

local this = {
    showIndex = 0,
    showList = nil,
    totalNum = 0,
    selectedData = nil,
    isUnLock = false,
    posList = { { -80, 200 }, { -150, 50 }, { -138, -100 }, { -50, -240 }, { 92, -310 }, { 415, -298 }, { 551, -208 }, { 623, -63 }, { 611, 97 }, { 521, 228 }, { 379, 298 }, { 56, 291 } }
};

local objs = {

    novelItem = { path = "template/NovelItem", type = "GameObject" },
    listTF = { path = "root/Middle/List", type = "Transform" },
    btnBox = { path = "root/Right/btnBox", type = "GameObject" },
    novelBtn = { path = "root/Right/btnBox/novelBtn", type = "Button" },
    textName = { path = "root/Right/btnBox/Image/Image/TextName", type = "Text" },
    repeatObj = { path = "root/Right/btnBox/repeat", type = "GameObject" },
    unlockObj = { path = "root/Right/btnBox/unlock", type = "GameObject" },
    ratioText = { path = "root/Right/btnBox/ratioBg/ratioText", type = "Text" },
};


this.SetData = function()
    this.SetNovelList()
end


this.SetNovelList = function()
    this.novelList:Clear();
    local scrollData;
    local scrollDatas = {};
    local cacheList = XCHDMgr.GetActiveEventsByArea("XCHD4")
    local novelList = {};
    this.totalNum = 0
    local nestNum = 0
    local novelNumList = {}
    for k, v in ipairs(cacheList) do
        if v.type == 1 then
            this.totalNum = this.totalNum + 1;
            novelNumList[this.totalNum] = k
            if (XCHDMgr.CheckEventIsUnLock(v)) then
                if (not XCHDMgr.CheckEventIsComplete(v) and nestNum == 0) then
                    nestNum = k;
                end
                table.insert(novelList, v);
            end
        end
    end
    if (#novelList < #novelNumList) then
        local key = novelNumList[#novelList + 1]
        table.insert(novelList, cacheList[key]);
    end
    local len = #novelList;
    for i = 1, len do
        scrollData = UIListData.GetData(this.novelItem, "XCHDNovelItem",
            {
                config = novelList[i],
                num = i,
                pos = this.posList[i],
                isSelected = nestNum == i,
                callback = this.ItemClickCallBack
            });
        table.insert(scrollDatas, scrollData);
    end
    this.novelList:SetData(scrollDatas);
    this.showIndex = 1;
    this.showList = this.novelList.itemList
    local showAni = XCHDMgr.CheckShowAni()
    for _, v in pairs(this.showList) do
        SetActive(v.gameObject, not showAni);
    end
    if (showAni) then
        LuaMgr.AddTimer(TimerConst.SGYNovelListDelay, this.OnNovelList, 0.05, -1, true);
    end
    local showbtnBox = nestNum > 0;
    if (showbtnBox) then
        this.ItemClickCallBack(nestNum);
    else
        this.ItemClickCallBack(1);
    end
end


this.OnNovelList = function()
    if (this.showIndex > #this.showList) then
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        return;
    end
    local item = this.showList[this.showIndex];
    SetActive(item.gameObject, true);
    this.showIndex = this.showIndex + 1;
end


this.OnClickNovel = function()
    if (this.selectedData ~= nil) then
        local isUnLock = this.isUnLock
        if (not isUnLock) then
            local eventMap = DataExHelper.GetActivityMapEventMap();
            local unlockEvent = eventMap[this.selectedData.unlockParam]
            if (unlockEvent == nil) then
                return
            end
            local name = LuaMgr.GetLangText(unlockEvent.namelan)
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(tipStr, name))
            return
        end
        LuaMgr.PlayNovel(this.selectedData.eventParam, function()
            XCHDMgr.SetShowAni(false);
            LuaMgr.ShowLuaPanel(UIName.XCHDNovelViewModel);
        end);
    end
end


this.OnBack = function()
    XCHDMgr.SetShowAni(true);
    LuaMgr.Back();
end

this.ItemClickCallBack = function(index)
    local item = this.novelList.itemList[index];
    local data = item.data.config;
    this.selectedData = data
    local numText = "";
    if (index >= 10) then
        numText = tostring(index);
    else
        numText = "0" .. index;
    end
    this.textName.text = LuaMgr.GetLangText(data.namelan);
    this.isUnLock = XCHDMgr.CheckEventIsUnLock(data)
    local isFinish = XCHDMgr.CheckEventIsComplete(data)
    SetActive(this.repeatObj, isFinish);
    SetActive(this.unlockObj, this.isUnLock)
    this.ratioText.text = numText .. "/" .. this.totalNum
    for k, v in pairs(this.novelList.itemList) do
        v.data.isSelected = false
        if (index == v.data.num) then
            v.data.isSelected = true
        end
        v:ShowSelected(v.data.isSelected)
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.novelList = UIListView.New(this.listTF);
        LuaMgr.AddClick(this.novelBtn, this.OnClickNovel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            vm.behaviour:UpdateTopBar("", this.OnBack);
        end
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        this.novelList:Clear();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.novelBtn, this.OnClickNovel);
        UIListView.ClearItem("XCHDNovelItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
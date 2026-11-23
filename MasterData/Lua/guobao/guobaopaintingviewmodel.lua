local this = {
    wordPath = "Assets/_BundleResources/Images/GuoBao/ui_hd_ydkb_txt%d.png",
    savePath = "",
    prefix = "GuoBaoBrushWord",
    eventList = nil,
    eventIndex = 1,
    rewardItem = nil,
}

local objs = {
    calendarDate = {path = "root/Left/Calendar/Date", type = "Text"},
    calendarWeek = {path = "root/Left/Calendar/Week", type = "Text"},
    calendarLunar = {path = "root/Left/Calendar/Lunar", type = "Text"},
    calendarDay = {path = "root/Left/Calendar/Day", type = "Text"},
    calendarLunar2 = {path = "root/Left/Calendar/Lunar2", type = "Text"},
    calendarLunar3 = {path = "root/Left/Calendar/Lunar3", type = "Text"},
    calendarLunar4 = {path = "root/Left/Calendar/Lunar4", type = "Text"},
    calendarLunar5 = {path = "root/Left/Calendar/Lunar5", type = "Text"},
    msg = {path = "root/Left/Msg/Text", type = "Text"},
    rewardItemTF = {path = "root/Middle/Reward/Item", type = "Transform"},
    rewardCount = {path = "root/Middle/Reward/Count/Text", type = "Text"},
    rewardReceived = {path = "root/Middle/Reward/Received", type = "GameObject"},
    clearBtn = {path = "root/Middle/ChineseBrushOther/Clear", type = "Button"},
    leftArrowGO = {path = "root/Middle/LeftArrow", type = "GameObject"},
    leftArrowBtn = {path = "root/Middle/LeftArrow", type = "Button"},
    rightArrowGO = {path = "root/Middle/RightArrow", type = "GameObject"},
    rightArrowBtn = {path = "root/Middle/RightArrow", type = "Button"},
    painting = {path = "root/Middle/ChineseBrushOther/RawImage", type = "UIPainting"},
    chineseWordBg = {path = "root/Middle/Paper/ChineseWordBg", type = "RawImage"},
    mainpages = {path = "root/Middle/Paper/Mainpages", type = "RawImage"},
    saveGO = {path = "root/Middle/ChineseBrushOther/Save", type = "GameObject"},
    saveBtn = {path = "root/Middle/ChineseBrushOther/Save", type = "Button"},
};


this.SetData = function()
    this.savePath = LuaMgr.GetPersistentWWWPre() .. "/bundles/LoadImages/";
    this.eventList = ConfigGuoBaoMgr.GetEventList(2);
    this.CheckEvent(this.FindEvent());
end


this.SetReward = function()
    local event = this.eventList[this.eventIndex];
    if (this.rewardItem == nil) then
        this.rewardItem = GoodsDataItem.New(this.rewardItemTF);
    end
    local showItem = event.Reward[1];
    local itemConfig = ConfigMgr.Config.itemMap[showItem.id];
    if (itemConfig ~= nil) then
        local itemData = table.Copy(itemConfig);
        itemData.count0 = 0;
        this.rewardItem:SetData(1, itemData, 1, false, Vector3(0.5,0.5,1), false, true);
        this.rewardCount.text = "x" .. showItem.count;
        SetActive(this.rewardReceived, PlayerGuoBaoMgr.GetFinishEvent(event.ID) ~= nil);
    end
end


this.FindEvent = function()
    local event;
    local index = 1;
    local time = LuaMgr.Timestamp();
    local len = #this.eventList;
    for i = 1, len do
        event = this.eventList[i];
        if (time >= event.StartTime and PlayerGuoBaoMgr.GetFinishEvent(event.ID) == nil) then
            index = i;
            break;
        end
    end
    return index;
end


this.CheckEvent = function(index)
    if (index <= 0 or index > #this.eventList) then return end

    local event = this.eventList[index];
    if (event == nil) then return end

    local time = LuaMgr.Timestamp();
    if (time < event.StartTime) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("GuoBaoPaintingViewModel_0"));
        return;
    end
    this.eventIndex = index;
    SetActive(this.leftArrowGO, index > 1);
    SetActive(this.rightArrowGO, index < #this.eventList);
    this.SetDate(event.GameParameters);
    this.SetPainting();
    this.SetReward();
end


this.SetDate = function(params)
    this.calendarDate.text = ConfigMgr.LangGlobal(params[1]); 
    this.calendarWeek.text = ConfigMgr.LangGlobal(params[2]); 
    this.calendarLunar.text = ConfigMgr.LangGlobal(params[3]);
    this.calendarDay.text = ConfigMgr.LangGlobal(params[6]); 
    this.calendarLunar2.text = ConfigMgr.LangGlobal(params[4]);
    this.calendarLunar3.text = ConfigMgr.LangGlobal(params[5]);
    this.calendarLunar4.text = ConfigMgr.LangGlobal(params[7]);
    this.calendarLunar5.text = ConfigMgr.LangGlobal(params[8]);
    this.msg.text = ConfigMgr.LangGlobal(params[9]);
end


this.SetPainting = function()
    this.painting:OnClickClear();
    local key = this.prefix .. DataMgr.Player.uid .. "_" .. this.eventIndex .. ".png";
    local texture = LuaMgr.LoadNeedTexture(key);
    this.mainpages.texture = texture;
    this.chineseWordBg.texture = LuaMgr.GetTexture(string.format(this.wordPath, this.eventIndex));
    this.painting.Begins = false;
    if (texture ~= nil) then
        this.painting.Locks = true;
        SetActive(this.saveGO, false);
    else
        this.painting.Locks = false;
        SetActive(this.saveGO, true);
    end
end


this.SavePage = function(parames)
    local key = this.prefix .. DataMgr.Player.uid .. "_" .. this.eventIndex;
    if (LuaMgr.SaveNeedTexture("GuoBaoBrushWord", key, parames[0])) then
        local event = this.eventList[this.eventIndex];
        if (PlayerGuoBaoMgr.GetFinishEvent(event.ID) == nil) then
            PlayerGuoBaoMgr.SimulatedShopFinishEvent(event.ID, this.FinishEventResponse);
        end
    end
end


this.OnClickClear = function()
    this.painting.Locks = false;
    this.painting.Begins = false;
    this.painting:OnClickClear();
    this.mainpages.texture = nil;
    SetActive(this.saveGO, true);
    local key = this.prefix .. DataMgr.Player.uid .. "_" .. this.eventIndex .. ".png";
    LuaMgr.DeleteFile(this.savePath .. key);
end


this.OnClickLeftArrow = function()
    this.CheckEvent(this.eventIndex - 1);
end


this.OnClickRightArrow = function()
    this.CheckEvent(this.eventIndex + 1);
end


this.OnClickSave = function()
    this.painting.Locks = true;
    this.painting:saveTexture();
    SetActive(this.saveGO, false);
end


this.FinishEventResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result);
        LuaMgr.ShowItemRewared(reward);
    else
        this.OnShowItemReward();
    end
    this.SetReward();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.clearBtn, this.OnClickClear);
        LuaMgr.AddClick(this.leftArrowBtn, this.OnClickLeftArrow);
        LuaMgr.AddClick(this.rightArrowBtn, this.OnClickRightArrow);
        LuaMgr.AddClick(this.saveBtn, this.OnClickSave);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        LuaMgr.AddUIEventListener(UIEventConst.ChineseBrush, this.SavePage);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.ChineseBrush, this.SavePage);
        this.painting:OnClickClear();
        this.painting.Begins = false;
        this.chineseWordBg.texture = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.clearBtn, this.OnClickClear);
        LuaMgr.RemoveClick(this.leftArrowBtn, this.OnClickLeftArrow);
        LuaMgr.RemoveClick(this.rightArrowBtn, this.OnClickRightArrow);
        LuaMgr.RemoveClick(this.saveBtn, this.OnClickSave);
        if (this.rewardItem ~= nil) then
            this.rewardItem:Clear();
            this.rewardItem = nil;
        end
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
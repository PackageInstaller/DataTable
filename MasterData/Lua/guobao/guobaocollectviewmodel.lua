require("GuoBao/GuoBaoCollectItem")

local this = {
    events = {"302021","302022","302023","302024","302025","302026"},
    completeEvent = "302030",
    collectList = nil,
};

local objs = {
    collectItem = { path = "template/CollectItem", type = "GameObject" },
    collectsTF = { path = "root/Middle/Group/Collects", type = "Transform" },
    name = { path = "root/Middle/Group/Name/Text", type = "Text" },
    msg = { path = "root/Middle/Group/Msg/Text", type = "Text" },
    closeBtn = { path = "root/Middle/Group/Close", type = "Button" },
    lockGO = { path = "root/Middle/Group/Lock", type = "GameObject" },
    lockBtn = { path = "root/Middle/Group/Lock", type = "Button" },
    receiveGO = { path = "root/Middle/Group/Receive", type = "GameObject" },
    receiveBtn = { path = "root/Middle/Group/Receive", type = "Button" },
};


this.SetData = function()
    this.name.text = ConfigMgr.LangGlobal("18340");
    local questConfig = ConfigMgr.Config.questEvent[this.completeEvent];
    if (questConfig ~= nil) then
        this.msg.text = LuaMgr.GetLangText(questConfig.remarksLan);
        local questData = PlayerGuoBaoMgr.GetQuestEvent(this.completeEvent);
        if (questData ~= nil) then
            if (questData.state == 1) then
                SetActive(this.lockGO, true);
                SetActive(this.receiveGO, false);
            elseif (questData.state == 2) then
                SetActive(this.lockGO, false);
                SetActive(this.receiveGO, true);
            else
                SetActive(this.lockGO, false);
                SetActive(this.receiveGO, false);
            end
        end
    end
    this.SetCollects();
end


this.SetCollects = function()
    this.collectList:Clear();
    local listDatas = {};
    local len = #this.events;
    for i = 1, len do
        local listData = UIListData.GetData(this.collectItem, "GuoBaoCollectItem", this.events[i]);
        table.insert(listDatas, listData);
    end
    this.collectList:SetData(listDatas);
end


this.CloseCollect = function()
    LuaMgr.HidePanel(UIName.GuoBaoCollectViewModel);
end


this.OnClickClose = function()
    LuaMgr.NextFrame(this.CloseCollect);
end


this.OnClickLock = function()
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("GuoBaoCollectViewModel_0"));
end


this.OnClickReceive = function()
    DataExHelper.EX_GetAward(this.completeEvent, this.GetAwardResponse);
end


this.GetAwardResponse = function()
    this.SetData();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.collectList = UIListView.New(this.collectsTF);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
        LuaMgr.AddClick(this.lockBtn, this.OnClickLock);
        LuaMgr.AddClick(this.receiveBtn, this.OnClickReceive);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData();
    end,
    before_deactive = function(vm)
        this.collectList:Clear();
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        LuaMgr.RemoveClick(this.lockBtn, this.OnClickLock);
        LuaMgr.RemoveClick(this.receiveBtn, this.OnClickReceive);
        UIListView.ClearItem("GuoBaoCollectItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
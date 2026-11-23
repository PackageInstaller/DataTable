require("Foundation/ViewModel/ActivityRoomVisitorPlayerItem")
require("Foundation/ViewModel/ActivityRoomVisitorRecordItem")

local this = {
    playerSV = nil,
    recordSV = nil,
    visitData = nil,
};

local objs = {

    closeBtn = { path = "root/Middle/Visitors/Close", type = "Button" },
    playerItem = { path = "template/PlayerItem", type = "GameObject" },
    playersSVGO = { path = "root/Middle/Visitors/Players", type = "GameObject" },
    recordItem = { path = "template/RecordItem", type = "GameObject" },
    recordsSVGO = { path = "root/Middle/Visitors/Records", type = "GameObject" },
};


this.SetData = function()
    this.SetPlayerList();
    this.SetRecordList();
end


this.SetPlayerList = function()
    this.playerSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local visits = this.visitData.Visits;
    local len = #visits;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.playerItem, "ActivityRoomVisitorPlayerItem", 370 , 92, visits[i]);
        table.insert(scrollDatas, scrollData);
    end
    this.playerSV:SetParams(380, 400);
    this.playerSV:SetData(scrollDatas, true);
end


this.SetRecordList = function()
    this.recordSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local roomDecorationRecordLimit = ConfigMgr.Config.constants.RoomDecorationRecordLimit;
    local visitRecords = this.visitData.VisitRecords;
    local len = #visitRecords;
    if (len > roomDecorationRecordLimit) then
        len = RoomDecorationRecordLimit;
    end
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.recordItem, "ActivityRoomVisitorRecordItem", 432, 86, visitRecords[i]);
        table.insert(scrollDatas, scrollData);
    end
    this.recordSV:SetParams(432, 400);
    this.recordSV:SetData(scrollDatas, true);
end


this.OnClickClose = function()
    LuaMgr.HidePanel(UIName.ActivityRoomVisitorViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.playerSV = UIScrollView.New(this.playersSVGO);
        this.recordSV = UIScrollView.New(this.recordsSVGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.visitData = vm.behaviour.Params[0];
        this.SetData();
    end,
    before_deactive = function(vm)
        if (this.playerSV ~= nil) then
            this.playerSV:Clear(true);
        end
        if (this.recordSV ~= nil) then
            this.recordSV:Clear(true);
        end
        this.visitData = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        UIScrollView.ClearItem("ActivityRoomVisitorPlayerItem");
        UIScrollView.ClearItem("ActivityRoomVisitorRecordItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
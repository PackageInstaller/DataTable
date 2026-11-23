require("Foundation/ViewModel/FoundationMsgItem")

FoundationMsgMgr = {};

local this = {
    msgItem = nil,
    container = nil,
    msgList = {},
    msgPool = nil,
    isUpdate = false,
    dataList = {},
    showList = {},
    nextTime = 0,
};

FoundationMsgMgr.Init = function(msgItem, container)
    this.msgItem = msgItem;
    this.container = container;
    this.msgList = {};
    this.msgPool = {};
end

FoundationMsgMgr.Clear = function()
    if (this.msgList ~= nil) then
        local len = #this.msgList;
        for i = 1, len do
            this.AddMsgItem(this.msgList[i]);
        end
        this.msgList = {};
    end
end


FoundationMsgMgr.ClearDataList=function()
    FoundationMsgMgr.Clear()
    this.showList = {};
    this.dataList = {};
end

FoundationMsgMgr.Destroy = function()
    if (this.msgList ~= nil) then
        local len = #this.msgList;
        for i = 1, len do
            this.msgList[i]:Destroy();
        end
        this.msgList = {};
    end
    if (this.msgPool ~= nil) then
        local len = #this.msgPool;
        for i = 1, len do
            this.msgPool[i]:Destroy();
        end
        this.msgPool = nil;
    end
    this.dataList = nil;
    this.showList = nil;
    this.container = nil;
    this.msgItem = nil;
end


FoundationMsgMgr.SetData = function(datas)
    this.dataList = {};
    this.showList = {};
    if (datas ~= nil) then
        local data;
        local len = #datas;
        for i = 1, len do
            data = datas[i];
            this.dataList[i] = data;
            this.showList[i] = data.Id;
        end
    end
end



FoundationMsgMgr.Show = function()
    this.isUpdate = true;
    if (IsNull(this.container)) then return end
    if (LuaMgr.IsObjectNull(this.container)) then return end

    SetActive(this.container.gameObject, true);
end


FoundationMsgMgr.Hide = function()
    this.isUpdate = false;
    if (IsNull(this.container)) then return end
    if (LuaMgr.IsObjectNull(this.container)) then return end
    
    SetActive(this.container.gameObject, false);
end


FoundationMsgMgr.GetDataList = function(type)
    if (type == 1) then
        return this.dataList;
    end
    local data;
    local list = {};
    local len = #this.dataList;
    if (type == 2) then
        for i = 1, len do
            data = this.dataList[i];
            if (data.Friend) then
                table.insert(list, data);
            end
        end
    else
        for i = 1, len do
            data = this.dataList[i];
            if (not data.Friend) then
                table.insert(list, data);
            end
        end
    end
    return list;
end

FoundationMsgMgr.Update = function()
    if (this.isUpdate) then
        this.AddMsg();
        this.CheckMsgs();
    end
end


FoundationMsgMgr.GetAvatarFrame = function(id)
    local avatarFrame;
    local avatarFrames = ConfigMgr.Config.avatarFrames;
    local len = #avatarFrames;
    for i = 1, len do
        avatarFrame = avatarFrames[i];
        if (avatarFrame.id == id) then
            return avatarFrame;
        end
    end
    return nil;
end


this.AddMsg = function()
    local time = os.time();
    if (time < this.nextTime) then return end
    if (this.showList == nil or #this.showList <= 0) then return end
    
    local id = this.showList[1];
    table.remove(this.showList, 1, 1);
    local data = this.GetMsgData(id);
    if (data ~= nil) then
        local item = this.GetMsgItem();
        item:SetData(data);
        table.insert(this.msgList, item);
        this.nextTime = time + 3;
    end
end


this.CheckMsgs = function()
    local item;
    local index = 1;
    local len = #this.msgList;
    while (index <= len) do
        item = this.msgList[index];
        item:Update();
        if (item.isLive) then
            index = index + 1;
        else
            len = len - 1;
            table.remove(this.msgList, index, 1);
            local data = this.GetMsgData(item.data.Id);
            if (data ~= nil) then
                table.insert(this.showList, data.Id);
            end
            this.AddMsgItem(item);
        end
    end
end


this.GetMsgData = function(id)
    local data;
    local len = #this.dataList;
    for i = 1, len do
        data = this.dataList[i];
        if (data.Id == id) then
            return data;
        end
    end
    return nil;
end


this.GetMsgItem = function()
    local len = #this.msgPool;
    if (len > 0) then
        local item = this.msgPool[len];
        this.msgPool[len] = nil;
        return item;
    end
    return FoundationMsgItem.New(this.msgItem, this.container);
end


this.AddMsgItem = function(item)
    item:Clear();
    local index = #this.msgPool + 1;
    this.msgPool[index] = item;
end
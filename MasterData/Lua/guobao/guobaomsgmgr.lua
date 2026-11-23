require("GuoBao/GuoBaoMsgItem")

GuoBaoMsgMgr = {};

local this = {
    msgItem = nil,
    container = nil,
    msgList = {},
    msgPool = nil,
    isUpdate = false,
    dataList = {},
    showList = {},
    nextTime = 0,
    lineList = {},
};

GuoBaoMsgMgr.Init = function(msgItem, container)
    this.msgItem = msgItem;
    this.container = container;
    this.msgList = {};
    this.msgPool = {};
    this.lineList = {};
end

GuoBaoMsgMgr.Clear = function()
    if (this.msgList ~= nil) then
        local len = #this.msgList;
        for i = 1, len do
            this.AddMsgItem(this.msgList[i]);
        end
        this.msgList = {};
    end
end

GuoBaoMsgMgr.Destroy = function()
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
    this.lineList = nil;
end


GuoBaoMsgMgr.SetData = function(datas)
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


GuoBaoMsgMgr.AddData = function(data)
    data.Id = #this.dataList;
    table.insert(this.dataList, data);
    table.insert(this.showList, 1, data.Id);
end


GuoBaoMsgMgr.Show = function()
    this.isUpdate = true;
    if (not IsObjectNull(this.container)) then
        SetActive(this.container.gameObject, true);
    end
end


GuoBaoMsgMgr.Hide = function()
    this.isUpdate = false;
    if (not IsObjectNull(this.container)) then
        SetActive(this.container.gameObject, false);
    end
end

GuoBaoMsgMgr.Update = function()
    if (this.isUpdate) then
        this.CheckMsgs();
        this.AddMsg();
    end
end


this.AddMsg = function()
    local time = os.time();
    if (time < this.nextTime) then return end
    if (this.showList == nil or #this.showList <= 0) then return end
    if (#this.msgList >= 30) then return end

    local lastX = 0;
    local lineIndex = math.random(1, 6);
    local item = this.lineList[lineIndex];
    if (item ~= nil and item.isLive) then
        item = this.lineList[lineIndex];
        lastX = item.pos.x + item.size.x * 0.5;
    end
    local id = this.showList[1];
    table.remove(this.showList, 1, 1);
    local data = this.GetMsgData(id);
    if (data ~= nil) then
        item = this.GetMsgItem();
        item:SetData(data, lineIndex, lastX);
        table.insert(this.msgList, item);
        this.lineList[lineIndex] = item;
        this.nextTime = time + 1;
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
    return GuoBaoMsgItem.New(this.msgItem, this.container);
end


this.AddMsgItem = function(item)
    item:Clear();
    local index = #this.msgPool + 1;
    this.msgPool[index] = item;
end
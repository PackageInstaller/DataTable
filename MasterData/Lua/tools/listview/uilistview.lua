UIListView = {};

UIListView.__index = UIListView;

local poolMap = {};
local scale = Vector3.one;

local function GetItem(this, data)
    local list = poolMap[data.class];
    if (list ~= nil) then
        local len = #list;
        if (len > 0) then
            local item = list[len];
            list[len] = nil;
            if (this.transform ~= item.transform.parent) then
                item.transform:SetParent(this.transform, false);
                item.transform.localScale = scale;
            end
            item.gameObject:SetActive(true);
            item.transform:SetAsLastSibling();
            return item;
        end
    end
    local obj = LuaMgr.InstantiateGO(data.prefab);
    if (obj ~= nil) then
        local objTF = obj:GetComponent("RectTransform");
        objTF:SetParent(this.transform, false);
        objTF.localScale = scale;
        local class = _G[data.class];
        if (class ~= nil) then
            local item = class.New();
            item.class = data.class;
            item.gameObject = obj;
            item.transform = objTF;
            item:Init();
            return item;
        end
    end
    LuaMgr.DestroyImmediateGO(obj);
    return nil;
end

local function AddItem(item)
    item:Clear();
    item.gameObject:SetActive(false);
    local list = poolMap[item.class];
    if (list == nil) then
        list = {};
        poolMap[item.class] = list;
    end
    list[#list + 1] = item;
end

UIListView.ClearItem = function(class)
    local list = poolMap[class];
    if (list ~= nil) then
        local item;
        local len = #list;
        for i = 1, len do
            item = list[i];
            item:Destroy();
            LuaMgr.DestroyImmediateGO(item.gameObject);
        end
        poolMap[class] = nil;
        list = nil;
    end
end

UIListView.ClearAll = function()
    for k, _ in pairs(poolMap) do
        UIListView.ClearItem(k);
    end
end

UIListView.New = function(transform)
    local self = {};
    setmetatable(self, UIListView);
    self.transform = transform;
    self.dataId = 0;
    self.itemMap = {};
    self.dataList = {};
    self.itemList={};
    return self;
end

function UIListView:SetData(list)
    self:Clear();
    local len = #list;
    for i = 1, len do
        self:AddData(list[i]);
    end
    self:SetItems(true);
end

function UIListView:AddData(data)
    self.dataId = self.dataId + 1;
    data.id = self.dataId;
    table.insert(self.dataList, data);
end

function UIListView:Refresh()
    self:SetItems(true);
end

function UIListView:SetItems(refresh)
    local item;
    local data;
    local map = {};
    local len = #self.dataList;
    for i = 1, len do
        data = self.dataList[i];
        item = self.itemMap[data.id];
        if (item ~= nil) then
            if (refresh) then
                item:SetData(data);
            end
        else
            item = GetItem(self, data);
            item:SetData(data);
        end
        self.itemMap[data.id] = nil;
        map[data.id] = item;
        table.insert(self.itemList,item)
    end
    for _, v in pairs(self.itemMap) do
        AddItem(v);
    end
    self.itemMap = map;
end

function UIListView:Clear()
    self.dataId = 0;
    if (self.itemMap ~= nil) then
        for _, v in pairs(self.itemMap) do
            AddItem(v);
        end
        self.itemMap = {};
    end
    if (self.dataList ~= nil) then
        local len = #self.dataList;
        for i = 1, len do
            UIListData.AddData(self.dataList[i]);
        end
        self.dataList = {};
    end
    self.itemList={}
end

function UIListView:Destroy()
    self.transform = nil;
    self.dataList = nil;
    self.itemMap = nil;
    self.itemList=nil
end
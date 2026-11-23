QinMainProgressItem = {};

QinMainProgressItem.__index = QinMainProgressItem;

local objs = {
    receiveBtn = { path = "Btn", type = "Button" },
    name = { path = "Name", type = "Text" },
    itemsTF = { path = "Items", type = "Transform" },
    status1 = { path = "Status/Status1", type = "GameObject" },
    status2 = { path = "Status/Status2", type = "GameObject" },
    status3 = { path = "Status/Status3", type = "GameObject" },
    mask = { path = "Mask", type = "GameObject" },
    effect = { path = "fx_glow", type = "GameObject" },
}

function QinMainProgressItem.New()
    local self = {};
    setmetatable(self, QinMainProgressItem);
    return self;
end

function QinMainProgressItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickReceive = function()
        if(self.data.state == 2)then
            if(PlayerQinMgr.GetCanGetReward())then
                return
            end
            PlayerQinMgr.SetCanGetReward(true)
            DataExHelper.EX_GetAward(self.data.id, function(_result) 
                PlayerSlgMgr.CheckUnionEntranceRedDot()     
                LuaMgr.InvokeUIEventListeners(UIEventConst.QinRewardRefresh, self.data);                
            end)

        elseif(self.data.state == 1)then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10434"));
        end      
    end
    LuaMgr.AddClick(self.receiveBtn, self.OnClickReceive);
    self.itemList = {};
end

function QinMainProgressItem:SetData(data)
    self.data = data.data;
    self.config = ConfigMgr.Config.questEvent[self.data.id];
    self.name.text = LuaMgr.GetLangText(self.config.remarksLan);
    self:SetItemList();
    SetActive(self.mask, self.data.state == 3);
end

function QinMainProgressItem:SetItemList()
    local item;
    local itemData;
    local itemMap = ConfigMgr.Config.itemMap;
    local scale = Vector3(0.5, 0.5, 0.5);
    local showReward = self.config.showReward;
    local len = #showReward;
    for i = 1, len do
        item = self.itemList[i];
        if (item == nil) then
            item = GoodsDataItem.New(self.itemsTF);
            self.itemList[i] = item;
        end
        itemData = table.Copy(itemMap[showReward[i].id]);
        itemData.count0 = showReward[i].count;
        item:SetData(i, itemData, 1, false, scale, false);
    end
    SetActive(self.status1, false);
    SetActive(self.status2, false);
    SetActive(self.status3, false);
    SetActive(self.effect,self.data.state == 2)
    if(self.data.state == 3) then
        SetActive(self.status1, len >= 1);
        SetActive(self.status2, len >= 2);
        SetActive(self.status3, len >= 3);
    end   
end

function QinMainProgressItem:HideItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Hide();
    end
end

function QinMainProgressItem:ClearItemList()
    local len = #self.itemList;
    for i = 1, len do
        self.itemList[i]:Clear();
    end
    self.itemList = nil;
end

function QinMainProgressItem:Clear()
    self:HideItemList();
end

function QinMainProgressItem:Destroy()
    self:ClearItemList();
    if (self.OnClickReceive ~= nil) then
        LuaMgr.RemoveClick(self.receiveBtn, self.OnClickReceive);
        self.OnClickReceive = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end

Rank_RewardItem = {};

Rank_RewardItem.__index = Rank_RewardItem;
local objs = {
    txtDes = { path = "root/bg/des", type = "Text" },
    tfItem = { path = "root/bg/item", type = "Transform" },
};

function Rank_RewardItem.New()
    local self = {};
    setmetatable(self, Rank_RewardItem);
    return self;
end

function Rank_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Rank_RewardItem:SetData(data)
    self.data=data.data;
    local des=ConfigMgr.LangGlobal("35128")
    self.txtDes.text=string.format(des,self.data.ranArea[1],self.data.ranArea[2]);
    if self.itemVM==nil then
        self.itemVM=GoodsDataItem.New(self.tfItem);
    end
    local itemData = table.Copy(ConfigMgr.Config.itemMap[self.data.itemId]);
    itemData.count0 = 0;
    self.itemVM:SetData(1, itemData, 1, false, Vector3(0.4,0.4,1), false,true);
end

function Rank_RewardItem:Clear()
    self.data=nil;
end

function Rank_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;

end
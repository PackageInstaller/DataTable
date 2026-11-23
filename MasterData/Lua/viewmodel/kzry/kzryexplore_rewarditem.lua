KZRYExplore_RewardItem = {};

KZRYExplore_RewardItem.__index = KZRYExplore_RewardItem;
local objs = {
    goodsTF={ path = "root/goods", type = "Transform" },
    firstObj={ path = "root/first", type = "GameObject" },
    secondObj={ path = "root/second", type = "GameObject" },
    passObj={ path = "root/pass", type = "GameObject" }
}

function KZRYExplore_RewardItem.New()
    local self = {};
    setmetatable(self, KZRYExplore_RewardItem);
    return self;
end

function KZRYExplore_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function KZRYExplore_RewardItem:SetData(pdata)
    self.data = pdata.data
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodsTF)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.id]
    itemConfig["count0"] = self.data.count
    self.item:SetData(1,itemConfig,1,false,Vector3.one*0.7,false)
    SetActive(self.passObj,self.data.isComplete)
    SetActive(self.firstObj,not self.data.isComplete and self.data.isFirst)
    SetActive(self.secondObj,not self.data.isComplete and self.data.isSecond)
end
    


function KZRYExplore_RewardItem:Clear()
    self.data = nil;
end

function KZRYExplore_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end
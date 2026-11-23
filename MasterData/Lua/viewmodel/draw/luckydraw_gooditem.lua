LuckyDraw_goodItem = {};

LuckyDraw_goodItem.__index = LuckyDraw_goodItem;

local objs = {
    good={path="good",type="Transform"},
    count={path="count/Text",type="Text"},
    goSeldOut={path = "seldOut", type = "GameObject"},
}

function LuckyDraw_goodItem.New()
    local self = {};
    setmetatable(self, LuckyDraw_goodItem);
    self.item=nil;
    return self;
end

function LuckyDraw_goodItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function LuckyDraw_goodItem:SetData(data)
    self.data=data.data
    self.count.text=self.data.count
    SetActive(self.goSeldOut,self.data.count==0);
    if self.item==nil then
        self.item=GoodsDataItem.New(self.good)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.Reward[1].id]
    itemConfig["count0"] = self.data.Reward[1].count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.7,0.7,0.7),false)
end

function LuckyDraw_goodItem:Clear()
    self.data=nil;
end


function LuckyDraw_goodItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.good=nil;
    self.count=nil;
    self.goSeldOut=nil;
end


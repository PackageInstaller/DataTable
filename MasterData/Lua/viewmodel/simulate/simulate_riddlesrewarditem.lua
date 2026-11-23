Simulate_RiddlesRewardItem = {};

Simulate_RiddlesRewardItem.__index = Simulate_RiddlesRewardItem;

local objs = {
    goodsTF={path="root/goods",type="Transform"},
    canvas={path="root/goods",type="CanvasGroup"},
    goDone={path="root/done",type="GameObject"},
}



function Simulate_RiddlesRewardItem.New()
    local self = {};
    setmetatable(self, Simulate_RiddlesRewardItem);
    return self;
end


function Simulate_RiddlesRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.goodsVM=nil;
end

function Simulate_RiddlesRewardItem:SetData(pdata)
    self.data=pdata.data
    if self.goodsVM==nil then
        self.goodsVM=GoodsDataItem.New(self.goodsTF);
    end
    local itemConfig =ConfigMgr.Config.itemMap[self.data.item.id]
    itemConfig["count0"] = self.data.item.count
    self.goodsVM:SetData(1,itemConfig,1,false,Vector3(0.6,0.6,0.6),false)
    SetActive(self.goDone,self.data.isPass);
    self.canvas.alpha=self.data.isPass and 0.6 or 1.0
end
    


function Simulate_RiddlesRewardItem:Clear()
    self.data=nil
end


function Simulate_RiddlesRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.goodsVM=nil;
end


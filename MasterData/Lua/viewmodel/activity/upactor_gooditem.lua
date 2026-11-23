Upactor_goodItem = {};

Upactor_goodItem.__index = Upactor_goodItem;

local objs = {
   goRewarded={path="rewarded",type="GameObject"},
   goods={path="goods",type="Transform"},
   canvasGroup={path="goods",type="CanvasGroup"},
}


function Upactor_goodItem.New()
    local self = {};
    setmetatable(self, Upactor_goodItem);
    return self;
end

function Upactor_goodItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Upactor_goodItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.goRewarded,self.data.isPass);
    self.canvasGroup.alpha=self.data.isPass and 0.7 or 1.0;
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goods)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.id]
    itemConfig["count0"] = self.data.count
    local scale=self.data.scale;
    self.item:SetData(1,itemConfig,1,false,Vector3(scale,scale,scale),false,not self.data.isCount)
    
end



function Upactor_goodItem:Clear()
    self.data = nil;
  
end

function Upactor_goodItem:Destroy()
    self.goRewarded=nil;
    self.goods=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
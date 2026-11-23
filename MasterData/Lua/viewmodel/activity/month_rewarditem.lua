Month_RewardItem = {};

Month_RewardItem.__index = Month_RewardItem;

local objs = {
    goodRoot={path="good",type="Transform"},
    goIsMonth={path="isMonth",type="GameObject"},
    name={path="name",type="Text"},
    fxObj={path="fx_getting",type="GameObject"},
}
function Month_RewardItem.New()
    local self = {};
    setmetatable(self, Month_RewardItem);
    return self;
end

function Month_RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Month_RewardItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.goIsMonth,pdata.data.type==2)
    self.name.text=pdata.data.name
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.id]
    itemConfig["count0"] = self.data.count
    self.item:SetData(1,itemConfig,1,false,Vector3.one*pdata.data.scale,false)
    SetActive(self.fxObj,false)
end

function Month_RewardItem:SetFxVisible(visible)
    SetActive(self.fxObj,visible)
end
function Month_RewardItem:Clear()
    self.data=nil
end
function Month_RewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end


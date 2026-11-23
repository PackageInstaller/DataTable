





SignIn7DaysGoodsItem = {}

SignIn7DaysGoodsItem.__index = SignIn7DaysGoodsItem
local objs = {
    goodsRoot = {path = "root/goods",type = "Transform"},
    goRewarded = {path = "root/rewarded",type = "GameObject"},
}

function SignIn7DaysGoodsItem.New()
    local self = {}
    setmetatable(self, SignIn7DaysGoodsItem)
    return self
end

function SignIn7DaysGoodsItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function SignIn7DaysGoodsItem:SetData(data)
    self.data = data.data;
    SetActive(self.goRewarded,self.data.isRewarded)
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodsRoot)
    end
    local itemConfig = table.Copy(ConfigMgr.Config.itemMap[self.data.id])
    if TableIsNull(itemConfig) then return end
    itemConfig["count0"] = self.data.count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.55,0.55,0.55),false)
end

function SignIn7DaysGoodsItem:Clear()
    self.data=nil;
end

function SignIn7DaysGoodsItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
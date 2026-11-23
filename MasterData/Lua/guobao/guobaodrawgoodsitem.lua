GuoBaoDrawGoodsItem = {};

GuoBaoDrawGoodsItem.__index = GuoBaoDrawGoodsItem;

local objs = {
    itemTF = {path = "item", type = "Transform"},
    num = {path = "num", type = "Text"},
    sellOut = {path = "sellOut", type = "GameObject"},
}
function GuoBaoDrawGoodsItem.New()
    local self = {};
    setmetatable(self, GuoBaoDrawGoodsItem);
    return self;
end

function GuoBaoDrawGoodsItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
end

function GuoBaoDrawGoodsItem:SetData(data)
    self.data = data.data;
    if (self.item == nil) then
        self.item = GoodsDataItem.New(self.itemTF);
    end
    local itemConfig = table.Copy(ConfigMgr.Config.itemMap[self.data.id]);
    itemConfig.count0 = self.data.count;
    self.item:SetData(1, itemConfig, 1, false, Vector3(0.7,0.7,1), false);
    self.num.text = LuaMgr.GetLangText("GuoBaoDrawGoodsItem_0") .. self.data.drawCount;
    SetActive(self.sellOut, self.data.drawCount <= 0);
    self.transform.localPosition = self.data.pos;
end

function GuoBaoDrawGoodsItem:Clear()
    self.data = nil;
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function GuoBaoDrawGoodsItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
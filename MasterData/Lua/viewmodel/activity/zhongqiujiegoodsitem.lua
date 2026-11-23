ZhongQiuJieGoodsItem = {};

ZhongQiuJieGoodsItem.__index = ZhongQiuJieGoodsItem;

local objs = {
    itemTF = {path = "item", type = "Transform"},
    num = {path = "num", type = "Text"},
    sellOut = {path = "sellOut", type = "GameObject"},
}
function ZhongQiuJieGoodsItem.New()
    local self = {};
    setmetatable(self, ZhongQiuJieGoodsItem);
    return self;
end

function ZhongQiuJieGoodsItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.item = nil;
end

function ZhongQiuJieGoodsItem:SetData(data)
    self.data = data.data;
    if (self.item == nil) then
        self.item = GoodsDataItem.New(self.itemTF);
    end
    local itemConfig = table.Copy(ConfigMgr.Config.itemMap[self.data.id]);
    itemConfig.count0 = self.data.count;
    self.item:SetData(1, itemConfig, 1, false, Vector3(0.55,0.55,1), false);
    self.num.text = LuaMgr.GetLangText("ZhongQiuJieGoodsItem_0") .. self.data.drawCount;
    SetActive(self.sellOut, self.data.drawCount <= 0);
    self.transform.localPosition = self.data.pos;
end

function ZhongQiuJieGoodsItem:Clear()
    self.data = nil;
    if (self.item ~= nil) then
        self.item:Hide();
    end
end

function ZhongQiuJieGoodsItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear();
        self.item = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
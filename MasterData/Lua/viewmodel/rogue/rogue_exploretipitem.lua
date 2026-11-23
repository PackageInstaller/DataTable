Rogue_ExploreTipItem = {};

Rogue_ExploreTipItem.__index = Rogue_ExploreTipItem;

local objs = {
    itemTF = { path = "root/goodsTF", type = "Transform" },
    des = { path = "root/des", type = "Text" },
}

function Rogue_ExploreTipItem.New(transform,tipObj)
    local self = {};
    setmetatable(self, Rogue_ExploreTipItem);
    self.gameObject = LuaMgr.InstantiateGO(tipObj)
    self.gameObject.transform:SetParent(transform, false)
    self.gameObject.transform.anchoredPosition = Vector2.zero
    self.gameObject.transform.localScale=Vector3.one;
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject,false);
    return self;
end

function Rogue_ExploreTipItem:SetData(id,count,tip)
    SetActive(self.gameObject,true);
    if self.itemVM==nil then
        self.itemVM=GoodsDataItem.New(self.itemTF)
    end
    local itemConfig = ConfigMgr.Config.itemMap[id];
    if (itemConfig ~= nil) then
        local name = LuaMgr.GetLangText(itemConfig.nameLan);
        self.itemVM:SetData(1, itemConfig, 1, false, Vector3(0.6,0.6,0.6), false,true);
        self.des.text=string.format(tip,name,count)
    end
end

function Rogue_ExploreTipItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
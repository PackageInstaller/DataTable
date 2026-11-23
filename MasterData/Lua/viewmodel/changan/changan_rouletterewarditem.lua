Changan_RouletteRewardItem = {};

Changan_RouletteRewardItem.__index = Changan_RouletteRewardItem;

local objs = {
    itemRoot={path="root/goodRoot",type="Transform"},
    alphaCanvas={path="root/goodRoot",type="CanvasGroup"},
    surplus={path="root/goodRoot/reCount",type="Text"},
    sellOut={path="root/sellOut",type="GameObject"},
}
function Changan_RouletteRewardItem.New()
    local self = {};
    setmetatable(self, Changan_RouletteRewardItem);
    return self;
end

function Changan_RouletteRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function Changan_RouletteRewardItem:SetData(pdata)
    self.data=pdata.data
    if self.item==nil then
        self.item=GoodsDataItem.New(self.itemRoot)
    end
    local itemConfig = ConfigMgr.Config.itemMap[pdata.data.id]
    itemConfig["count0"] = pdata.data.count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.65,0.65,0.65),false)
    self.surplus.text=LuaMgr.GetLangText("Changan_RouletteRewardItem_0")..pdata.data.surplus
    SetActive(self.sellOut,pdata.data.surplus<1)
    self.alphaCanvas.alpha=pdata.data.surplus>0 and 1.0 or 0.5
    self.transform.anchoredPosition=pdata.data.pos
end
function Changan_RouletteRewardItem:Clear()
  self.data=nil
end
function Changan_RouletteRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
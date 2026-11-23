Review_ShopItem = {};

Review_ShopItem.__index = Review_ShopItem;

local objs = {
    goodsTF={path="root/BG/itemTF",type="Transform"},
    nameText={path="root/BG/name",type="Text"},
    limitNum={path="root/BG/limit/num",type="Text"},
    type1Obj={path="root/BG/type1",type="GameObject"},
    type2Obj={path="root/BG/type2",type="GameObject"},
    type3Obj={path="root/BG/type3",type="GameObject"},
    costIcon={path="root/BG/type2/icon",type="RawImage"},
    costCount={path="root/BG/type2/count",type="Text"},
    btnClick={path="root/BG/btnClick",type="Button"},
}
function Review_ShopItem.New()
    local self = {};
    setmetatable(self, Review_ShopItem);
    return self;
end










function Review_ShopItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick, function()
        if self.data.callBack~=nil then
           self.data.callBack(self.data.index);
        end
    end)
   
end

function Review_ShopItem:SetData(pdata)
    self.data=pdata.data
    SetActive(self.type1Obj,false)
    SetActive(self.type2Obj,false)
    SetActive(self.type3Obj,false)
    self.limitNum.text=self.data.pro;
    if self.item==nil then
        self.item=GoodsDataItem.New(self.goodsTF)
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.item[1].id]
    self.nameText.text=LuaMgr.GetLangText(itemConfig.nameLan);
    itemConfig["count0"] = self.data.item[1].count
    self.item:SetData(1,itemConfig,1,false,Vector3.one,false)
    if self.data.isSellOut then
        SetActive(self.type3Obj,true)
    elseif self.data.cost[1].count==0 then
        SetActive(self.type1Obj,true)
    else
        SetActive(self.type2Obj,true)
        self.costIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(self.data.cost[1].id))
        self.costCount.text=self.data.cost[1].count;
    end
    
end
function Review_ShopItem:Clear()
   self.data=nil
end
function Review_ShopItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
    self.goodsTF=nil;
    self.limitNum=nil;
    self.goodsTF=nil;
    self.type1Obj=nil;
    self.type2Obj=nil;
    self.type3Obj=nil;
    self.costIcon=nil;
    self.costCount=nil;
    self.nameText=nil;
end


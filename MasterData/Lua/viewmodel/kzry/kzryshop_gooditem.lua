KZRYShop_GoodItem = {};

KZRYShop_GoodItem.__index = KZRYShop_GoodItem;
local objs = {
    maskObj={path="root/bg/mask",type="GameObject"},
    sellOutObj={path="root/sellOut",type="GameObject"},
    canvasGroup={path="root/canvasGroup",type="CanvasGroup"},
    good={ path = "root/canvasGroup/good", type = "Transform" },
    limitObj={ path = "root/canvasGroup/limit", type = "GameObject" },
    limitText={ path = "root/canvasGroup/limit/limitCount", type = "Text" },
    nolimitObj={ path = "root/canvasGroup/nolimit", type = "GameObject" },
    freeObj={ path = "root/canvasGroup/free", type = "GameObject" },
    costObj={path="root/canvasGroup/cost",type="GameObject"},
    costIcon={path="root/canvasGroup/cost/icon",type="RawImage"},
    costCount={path="root/canvasGroup/cost/count",type="Text"},
    btnBg={path="root/bg",type="Button"},
    name={path="root/canvasGroup/name",type="Text"},
}

function KZRYShop_GoodItem.New()
    local self = {};
    setmetatable(self, KZRYShop_GoodItem);
    self.isActive=false;
    return self;
end

function KZRYShop_GoodItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg,function()
        if self.data.callBack~=nil and not self.data.isSellOut then
            self.data.callBack(self.data.id);
        end
    end)
end


function KZRYShop_GoodItem:SetData(pdata)
    self.data = pdata.data
    SetActive(self.limitObj,false)
    SetActive(self.freeObj,false)
    SetActive(self.nolimitObj,false);
    SetActive(self.costObj,false);
    local nameLan=ConfigHelper.GetItemNamelan(self.data.award[1].id)
    self.name.text=LuaMgr.GetLangText(nameLan);
    if self.data.limitCount>=9999 then
        SetActive(self.nolimitObj,true)
    else
        SetActive(self.limitObj,true)
        self.limitText.text=LuaMgr.NumFormat(self.data.limitCount)
    end
    if not IsNull(self.data.cost) and self.data.cost[1].count==0 then
        SetActive(self.freeObj,true)
    else
        SetActive(self.costObj,true);
        self.costIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(self.data.cost[1].id));
        self.costCount.text=self.data.cost[1].count;
    end
    if self.item==nil then
        self.item=GoodsDataItem.New(self.good);
    end
    local itemConfig = ConfigMgr.Config.itemMap[self.data.award[1].id]
    itemConfig["count0"] = self.data.award[1].count
    self.item:SetData(1,itemConfig,1,false,Vector3(0.88,0.88,1),false)
    SetActive(self.sellOutObj,self.data.isSellOut);
    SetActive(self.maskObj,self.data.isSellOut);
    self.canvasGroup.alpha=self.data.isSellOut and 0.5 or 1.0
end

function KZRYShop_GoodItem:Clear()
    self.data = nil;
end

function KZRYShop_GoodItem:Destroy()
    self.good=nil;
    self.limitObj=nil;
    self.limitText=nil;
    self.nolimitObj=nil;
    self.freeObj=nil;
    self.costObj=nil;
    self.costIcon=nil;
    self.costCount=nil;
    self.sellOutObj=nil;
    self.name=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end
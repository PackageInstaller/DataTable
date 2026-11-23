Travel_AwardItem = {};

Travel_AwardItem.__index = Travel_AwardItem;
local objs = {
   rateText={path="BG/rate",type="Text"},
   hurtText={path="BG/hurt",type="Text"},
   awardTf={path="BG/awardTf",type="Transform"},
   goLast={path="BG/last",type="GameObject"},
   lastText={path="BG/last/Text",type="Text"}
}

function Travel_AwardItem.New()
    local self = {};
    setmetatable(self, Travel_AwardItem);
    return self;
end

function Travel_AwardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end



function Travel_AwardItem:SetData(pdata)
    self.data = pdata.data;
    self.rateText.text=self.data.rate;
    self.hurtText.text=self.data.hurt;
    self.lastText.text=string.format(ConfigMgr.LangGlobal("7504"),self.data.lastHurt)
    SetActive(self.goLast,self.data.isLast);
    if self.item==nil then
        self.item=GoodsDataItem.New(self.awardTf);
    end
    local itemData = ConfigMgr.Config.itemMap[self.data.award.id];
    itemData.count0 = self.data.award.count;
    self.item:SetData(1, itemData, 1, false, Vector3.one*0.88);
end




function Travel_AwardItem:Clear()
    self.data = nil;
end

function Travel_AwardItem:Destroy()
    self.rateText=nil;
    self.hurtText=nil;
    self.awardTf=nil;
    self.goLast=nil;
    self.lastText=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
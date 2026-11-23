Simulate_OrderLanternItem = {};

Simulate_OrderLanternItem.__index = Simulate_OrderLanternItem;

local objs = {
    imgIcon={path="root/icon",type="Image"},
    txtName={path="root/name",type="Text"},
    goTag={path="root/tag",type="GameObject"},
    txtTag={path="root/tag/Text",type="Text"},
    goSelect={path="root/select",type="GameObject"},
    goCount2={path="root/count2bg",type="GameObject"},
    txtCount1 = {path="root/count1",type="Text"},
    txtCount2 = {path="root/count2",type="Text"},
}



function Simulate_OrderLanternItem.New()
    local self = {};
    setmetatable(self, Simulate_OrderLanternItem);
    return self;
end

function Simulate_OrderLanternItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end






















function Simulate_OrderLanternItem:SetData(pdata)
    self.data=pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName)
    self.txtName.text=self.data.name;
    if self.data.isTag then
        SetActive(self.goTag,true);
        self.txtTag.text=self.data.tagInfo;
    else
        SetActive(self.goTag,false);
    end
    SetActive(self.goCount2,self.data.type==2)
    if self.data.type==1 then

        self.txtCount1.text=self.data.curCount<self.data.needCount and  string.format("<color=#EE6453>%s/%s</color>",self.data.curCount,self.data.needCount)
               or string.format("%s/%s",self.data.curCount,self.data.needCount);
        self.txtCount2.text="";
    else
        self.txtCount2.text=self.data.needCount;
        self.txtCount1.text="";
    end
    self:SetSelect(self.data.isSelect)
end

function Simulate_OrderLanternItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_OrderLanternItem:Clear()
    self.data=nil
end


function Simulate_OrderLanternItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end


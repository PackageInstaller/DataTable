Simulate_BuildingLineItem = {};

Simulate_BuildingLineItem.__index = Simulate_BuildingLineItem;

local objs = {
    txtDay={path="root/day",type="Text"},
    goCur={path="root/cur",type="GameObject"},
    goLine1={path="root/line1",type="GameObject"},
    goLine2={path="root/line2",type="GameObject"},
    imgLine1 ={path="root/line1",type="Image"},
    imgLine2={path="root/line2",type="Image"},
}



function Simulate_BuildingLineItem.New(parent,childObj)
    local self = {};
    setmetatable(self, Simulate_BuildingLineItem);
    return self;
end


function Simulate_BuildingLineItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end










function Simulate_BuildingLineItem:SetData(pdata)
    self.data=pdata.data
    self.txtDay.text=self.data.isCur and string.format("<color=#fffec6>%s</color>",self.data.num) 
            or string.format("<color=#a88a41>%s</color>",self.data.num);
    SetActive(self.goLine1,self.data.isCur)
    SetActive(self.goCur,self.data.isCur)
    SetActive(self.goLine2,not self.data.isCur)
    self.imgLine1.enabled=self.data.isFirst or self.data.isEnd
    self.imgLine2.enabled=self.data.isFirst or self.data.isEnd
    self.goLine1.transform.sizeDelta=Vector2(6,self.data.value*205);
    self.goLine2.transform.sizeDelta=Vector2(6,self.data.value*205);
end


function Simulate_BuildingLineItem:Clear()
    self.data=nil
end


function Simulate_BuildingLineItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end


Simulate_OrderBagItem = {};

Simulate_OrderBagItem.__index = Simulate_OrderBagItem;

local objs = {
    imgIcon={path="root/icon",type="Image"},
    txtName={path="root/name",type="Text"},
    txtCount={path="root/count",type="Text"},
    iconBtn={path="root/icon",type="Button"},
    goSelect={path="root/select",type="GameObject"},
}



function Simulate_OrderBagItem.New()
    local self = {};
    setmetatable(self, Simulate_OrderBagItem);
    return self;
end

function Simulate_OrderBagItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    SetActive(self.gameObject,true);
    LuaMgr.AddClick(self.iconBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end

function Simulate_OrderBagItem:SetData(pdata)
    self.data=pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName)
    self.txtName.text=self.data.name;
    if self.data.needCount>0 then
        self.txtCount.text=string.format("%s/%s",self.data.count,self.data.needCount);
    else
        self.txtCount.text=self.data.count;
    end
    self:SetSelect(self.data.isSelect)
end

function Simulate_OrderBagItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_OrderBagItem:Clear()
    self.data=nil
end


function Simulate_OrderBagItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end


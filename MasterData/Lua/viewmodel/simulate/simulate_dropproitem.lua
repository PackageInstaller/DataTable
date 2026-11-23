Simulate_DropProItem = {};

Simulate_DropProItem.__index = Simulate_DropProItem;

local objs = {
    txtPro={path="root/pro/proText",type="Text"},
    imgIcon={path="root/icon",type="Image"},
    imgValue={path="root/pro/value",type="Image"},
    goMax={path="root/max",type="GameObject"},
}



function Simulate_DropProItem.New()
    local self = {};
    setmetatable(self, Simulate_DropProItem);
    return self;
end

function Simulate_DropProItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Simulate_DropProItem:SetData(pdata)
    self.data=pdata.data
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName);



    self.txtPro.text=string.format("%s",self.data.curCount)
    self.imgValue.fillAmount=1;
    SetActive(self.goMax,false)
end


function Simulate_DropProItem:Clear()
    self.data=nil
end


function Simulate_DropProItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end


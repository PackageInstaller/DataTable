Simulate_DropBookItem = {};

Simulate_DropBookItem.__index = Simulate_DropBookItem;

local objs = {
    txtInfo={path="root/info",type="Text"},
    imgIcon={path="root/icon",type="Image"},
}



function Simulate_DropBookItem.New()
    local self = {};
    setmetatable(self, Simulate_DropBookItem);
    return self;
end

function Simulate_DropBookItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end






function Simulate_DropBookItem:SetData(pdata)
    self.data=pdata.data
    self.transform.anchoredPosition=self.data.pos;
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName);
    self.txtInfo.text=string.format(LuaMgr.GetLangText("Simulate_DropBookItem_0"),self.data.count);
end

function Simulate_DropBookItem:Clear()
    self.data=nil
end


function Simulate_DropBookItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end
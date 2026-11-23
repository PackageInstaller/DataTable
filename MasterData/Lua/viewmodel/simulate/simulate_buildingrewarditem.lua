Simulate_BuildingRewardItem = {};

Simulate_BuildingRewardItem.__index = Simulate_BuildingRewardItem;

local objs = {
    txtName={path="root/name",type="Text"},
    rawIcon ={path="root/icon",type="RawImage"},
    txtCount={path="root/count",type="Text"},
}



function Simulate_BuildingRewardItem.New(parent,childObj)
    local self = {};
    setmetatable(self, Simulate_BuildingRewardItem);
    if parent~=nil then
        self.gameObject=childObj;
        self.gameObject.transform:SetParent(parent,false);
        self.gameObject.transform.localPosition=Vector3.zero;
        self.gameObject.transform.localScale=Vector3.one;
        self:Init();
    end
    return self;
end


function Simulate_BuildingRewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end





function Simulate_BuildingRewardItem:SetData(pdata)
    self.data=pdata.data
    self.txtName.text=self.data.name;
    if IsNull(self.data.rewards) or NumTool.GetLen(self.data.rewards)==0 then
        local path=ConfigHelper.GetItemHomeIconPath("5252");
        self.rawIcon.texture=LuaMgr.GetTexture(path)
        self.txtCount.text=0;
    else
        for i,v in pairs(self.data.rewards) do
            local path=ConfigHelper.GetItemHomeIconPath(i);
            self.rawIcon.texture=LuaMgr.GetTexture(path)
            self.txtCount.text=v;
        end
    end
end


function Simulate_BuildingRewardItem:Clear()
    self.data=nil
end


function Simulate_BuildingRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end


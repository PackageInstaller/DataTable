Simulate_BuildingProItem = {};

Simulate_BuildingProItem.__index = Simulate_BuildingProItem;

local objs = {
    txtName={path="root/name",type="Text"},
    imgTag={path="root/tag",type="Image"},
    imgFillAmount={path="root/slider/fillAmount",type="Image"},
    txtValue={path="root/slider/value",type="Text"},
    starTF={path="root/star",type="Transform"},
}



function Simulate_BuildingProItem.New()
    local self = {};
    setmetatable(self, Simulate_BuildingProItem);
    return self;
end


function Simulate_BuildingProItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    
end






function Simulate_BuildingProItem:SetData(pdata)
    self.data=pdata.data
    self.txtName.text=self.data.name;
    self.imgTag.sprite=LuaMgr.GetSprite("Simulate","ui_hd_rsrh_jy_icon_"..self.data.id);
    self.txtValue.text=self.data.value;
    self:SetStar();
    SetActive(self.gameObject,false)
    NumTool.DelayHandler(function()
        if self~=nil and self.gameObject~=nil then
            SetActive(self.gameObject,true)
        end
    end,0.5*self.data.index)
end

function Simulate_BuildingProItem:SetStar()
    for i=1,self.starTF.childCount,1 do 
        SetActive(self.starTF:GetChild(i-1).gameObject,i<=self.data.starIndex);
    end
end

function Simulate_BuildingProItem:Clear()
    self.data=nil
end


function Simulate_BuildingProItem:Destroy()
    self.gameObject=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end


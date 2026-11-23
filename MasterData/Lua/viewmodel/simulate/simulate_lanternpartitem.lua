Simulate_LanternPartItem = {};

Simulate_LanternPartItem.__index = Simulate_LanternPartItem;

local objs = {
    canvas={path="root/canvas",type="CanvasGroup"},
    imgIcon={path="root/canvas/icon",type="Image"},
    txtName={path="root/canvas/name",type="Text"},
    goSelect={path="root/canvas/select",type="GameObject"},
    goLock={path="root/lock",type="GameObject"},
    iconBtn={path="root/canvas/icon",type="Button"},
    txtNameSelect={path="root/canvas/select/name",type="Text"},
}



function Simulate_LanternPartItem.New()
    local self = {};
    setmetatable(self, Simulate_LanternPartItem);
    return self;
end


function Simulate_LanternPartItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.iconBtn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end


function Simulate_LanternPartItem:SetData(pdata)
    self.data=pdata.data
    self.canvas.alpha=self.data.isLock and 0.6 or 1.0
    self.imgIcon.sprite=LuaMgr.GetSprite("Simulate",self.data.iconName)
    self.txtName.text=self.data.name;
    self.txtNameSelect.text=self.data.name;
    self:SetSelect(self.data.isCur)
    SetActive(self.goLock,self.data.isLock);
end

function Simulate_LanternPartItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn);
end

function Simulate_LanternPartItem:Clear()
    self.data=nil
end


function Simulate_LanternPartItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
  
end


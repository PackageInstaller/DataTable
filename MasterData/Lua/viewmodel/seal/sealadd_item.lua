SealAdd_Item = {};

SealAdd_Item.__index = SealAdd_Item;
local objs = {
  
    goOff={ path = "off", type = "GameObject" },
    goOn={ path = "on", type = "GameObject" },
    texName={ path = "name", type = "Text" },
    btnClick={path="off",type="Button"},
}

function SealAdd_Item.New()
    local self = {};
    setmetatable(self, SealAdd_Item);
    self.isActive=false;
    return self;
end

function SealAdd_Item:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnClick,function()
        if self.data~=nil and self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end


function SealAdd_Item:SetData(pdata)
    self.data = pdata.data
    SetActive(self.goOff,not self.data.isActive)
    SetActive(self.goOn, self.data.isActive)
    self.texName.text=self.data.name;
    self.texName.text=self.data.isActive and string.format("<color=#7f6852>%s</color>",self.data.name)
            or string.format("<color=#dcd0b5>%s</color>",self.data.name);
end



function SealAdd_Item:SetActive(isOn)
    SetActive(self.goOff,not isOn)
    SetActive(self.goOn, isOn)
    self.texName.text=isOn and string.format("<color=#7f6852>%s</color>",self.data.name)
            or string.format("<color=#dcd0b5>%s</color>",self.data.name);
end


function SealAdd_Item:Clear()
    self.data = nil;
end

function SealAdd_Item:Destroy()
    self.goOff=nil;
    self.goOn=nil;
    self.texName=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end
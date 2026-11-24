SmallMapAreaItem = {};

SmallMapAreaItem.__index = SmallMapAreaItem;
local objs = {
    root={ path = "root", type = "Transform" },
    btnArea = { path = "root/Button", type = "Button" },
    numText={ path = "root/Text", type = "Text" },
    goLight={ path = "root/Light", type = "GameObject" },
    goUp={ path = "root/Image2", type = "GameObject" },
};

function SmallMapAreaItem.New()
    local self = {};
    setmetatable(self, SmallMapAreaItem);
    return self;
end

function SmallMapAreaItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self:Register();
end

function SmallMapAreaItem:Register()
    self.OnCickArea = function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data);
        end
    end
    LuaMgr.AddClick(self.btnArea, self.OnCickArea);
end

function SmallMapAreaItem:SetData(data)
    self.data = data.data;
    self.transform.localScale=Vector3.one

    self.numText.text=self.data.cfgData.Name;
    SetActive(self.goLight, self.data.selected)
    SetActive(self.goUp, not self.data.selected)
end



function SmallMapAreaItem:Clear()
    self.data = nil;
end

function SmallMapAreaItem:Destroy()
    if self.OnCickArea~=nil then
        LuaMgr.RemoveClick(self.btnArea, self.OnCickArea);
    end
    self.OnCickArea = nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
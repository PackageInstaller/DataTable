TeamWeaponItem = {};

TeamWeaponItem.__index = TeamWeaponItem;

local objs = {
    animatorObj = { path = "Group", type = "GameObject" },
    ClickBtn = { path = "Group/Bg", type = "UIButtonClick" },
    Name = { path = "Group/Name", type = "Text" },
    Level = { path = "Group/Level", type = "Text" },
    SelectedGo = { path = "Group/Selected", type = "GameObject" },
    RedGo = { path = "Group/Red", type = "GameObject" },
}

function TeamWeaponItem.New()
    local self = {};
    setmetatable(self, TeamWeaponItem);
    return self;
end

function TeamWeaponItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if self.data.isSelected then
            return
        end
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.weaponId)
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.OnClickItem);
    SetActive(self.animatorObj, false)
end

function TeamWeaponItem:SetData(pdata)
    self.data = pdata.data;
    self.Name.text = self.data.nameStr;
    self.Level.text = tostring(self.data.level);
    SetActive(self.SelectedGo, self.data.isSelected)
    SetActive(self.RedGo, self.data.redCount > 0)
    if self.data.animBool then
        SetActive(self.animatorObj, true)
    end
end

function TeamWeaponItem:Clear()
    self.data = nil;
    SetActive(self.animatorObj, false)
end

function TeamWeaponItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
TaskBarItem = {};

TaskBarItem.__index = TaskBarItem;
local objs = {
    root={ path = "root", type = "Transform" },
    clickBtn = { path = "root/bg", type = "Button" },
    redIconListener = { path = "root/bg", type = "RedIconListener" },
    name = { path = "root/bg/name",type = "Text"},
    tag = { path = "root/bg/tag",type = "Image"},
    tagOn = { path = "root/bg/isOn/tag",type = "Image"},
    selectObj = { path = "root/bg/isOn",type = "GameObject"},
    name2 = { path = "root/bg/isOn/name",type = "Text"},
};

function TaskBarItem.New()
    local self = {};
    setmetatable(self, TaskBarItem);
    self.onClick = nil
    return self;
end

function TaskBarItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClick = function()
        if self.data ~= nil and self.data.callBack ~= nil then
            self.data.callBack(self.data.id)
        end
    end
    if self.clickBtn ~= nil then
        LuaMgr.AddClick(self.clickBtn, self.onClick)
    end
end


function TaskBarItem:SetData(data)
    self.data = data.data;
    if self.data == nil then
        return
    end
    self.redIconListener.RedId = "18007_"..self.data.id
    if self.name ~= nil then
        self.name.text = self.data.name or ""
    end
    if self.name2 ~= nil then
        self.name2.text = self.data.name or ""
    end
    SetActive(self.selectObj, self.data.selected == true)
    self.tag.sprite = LuaMgr.GetSprite("SLGSeason","sjz-zlfy-rw-dqch-cbl-0" .. self.data.id .. "a")
    self.tagOn.sprite = LuaMgr.GetSprite("SLGSeason","sjz-zlfy-rw-dqch-cbl-0" .. self.data.id .. "b")
end


function TaskBarItem:Clear()
    self.data = nil;

end

function TaskBarItem:Destroy()
    if self.clickBtn ~= nil and self.onClick ~= nil then
        LuaMgr.RemoveClick(self.clickBtn, self.onClick)
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
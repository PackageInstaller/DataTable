CrisisContract4LevelItem = {};

CrisisContract4LevelItem.__index = CrisisContract4LevelItem;

local objs = {
    NameText_1 = { path = "Selected/Bg/Text", type = "Text" },
    NameText_2 = { path = "Default/Text", type = "Text" },
    DefaultGo = { path = "Default", type = "GameObject" },
    PointGo = { path = "Default/Point", type = "GameObject" },
    SelectGo = { path = "Selected", type = "GameObject" },
    RedGo = { path = "Red", type = "GameObject" },
    LockGo = { path = "Lock", type = "GameObject" },
    ClickBtn = { path = "ClickBtn", type = "Button" },
}

function CrisisContract4LevelItem.New(obj)
    local self = {};
    setmetatable(self, CrisisContract4LevelItem);
    self.gameObject = obj
    return self;
end

function CrisisContract4LevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.levelId);
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.onClickCommand);
end

function CrisisContract4LevelItem:SetData(pdata)
    self.data = pdata.data
    self.NameText_1.text = self.data.nameStr
    self.NameText_2.text = self.data.nameStr
    SetActive(self.SelectGo, self.data.isSelected)
    SetActive(self.DefaultGo, not self.data.isSelected)
    SetActive(self.RedGo, self.data.isRed)
    SetActive(self.LockGo, self.data.isLock)
    SetActive(self.PointGo, not self.data.isLock)
    SetActive(self.gameObject, true)
end

function CrisisContract4LevelItem:SetSelect(isSelected)
    self.data.isSelected = isSelected
    SetActive(self.SelectGo, isSelected)
    SetActive(self.DefaultGo, not isSelected)
end

function CrisisContract4LevelItem:SetRed(isRed)
    self.data.isRed = isRed
    SetActive(self.RedGo, isRed)
end

function CrisisContract4LevelItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract4LevelItem:Clear()
    self.data = nil
end

function CrisisContract4LevelItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    self.gameObject = nil;
end 
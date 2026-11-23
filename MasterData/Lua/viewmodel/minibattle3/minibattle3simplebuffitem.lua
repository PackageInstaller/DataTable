MiniBattle3SimpleBuffItem = {};

MiniBattle3SimpleBuffItem.__index = MiniBattle3SimpleBuffItem;

local objs = {
    ClickBtn = { path = "", type = "UIButtonClick" },
    CardTexture = { path = "Group/Icon", type = "Image" },
    LevelText = { path = "Group/Level", type = "Text" },
    LevelGo = { path = "Group/Level", type = "GameObject" },
}

function MiniBattle3SimpleBuffItem.New(obj)
    local self = {};
    setmetatable(self, MiniBattle3SimpleBuffItem);
    self.gameObject = obj
    return self;
end

function MiniBattle3SimpleBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.id);
        end
    end
    LuaMgr.AddClick(self.ClickBtn, self.onClickCommand);
end

function MiniBattle3SimpleBuffItem:SetData(pdata)
    self.data = pdata.data
    self.CardTexture.sprite = self.data.icon
    self.LevelText.text = self.data.levelStr
    SetActive(self.LevelGo, not IsNullOrEmpty(self.data.levelStr))
    SetActive(self.gameObject, true)
end

function MiniBattle3SimpleBuffItem:Hide()
    SetActive(self.gameObject, false)
end

function MiniBattle3SimpleBuffItem:Clear()
    self.data = nil
end

function MiniBattle3SimpleBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.ClickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    self.gameObject = nil
end 
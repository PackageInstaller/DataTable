MiniBattle3DungeonItem = {};

MiniBattle3DungeonItem.__index = MiniBattle3DungeonItem;

local objs = {
    clickBtn = { path = "", type = "Button" },
    Nametxt = { path = "Group/Name", type = "Text" },
    TipsGo = { path = "Group/Tips", type = "GameObject" },
    Tipstxt = { path = "Group/Tips/Text", type = "Text" },
    LockGo = { path = "Group/Lock", type = "GameObject" },
    LockTips = { path = "Group/Lock/Tips", type = "Text" },
    RedGo = { path = "Group/Red", type = "GameObject" },
}

function MiniBattle3DungeonItem.New(obj)
    local self = {};
    setmetatable(self, MiniBattle3DungeonItem);
    self.gameObject = obj
    return self;
end

function MiniBattle3DungeonItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.unlockTime > LuaMgr.Timestamp() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, os.date(LuaMgr.GetLangText("MiniBattle2DungeonItem_0"), self.data.unlockTime));
            return
        end
        LuaMgr.ShowLuaPanel(UIName.MiniBattle3BuffViewModel, self.data.plotId)
    end
    LuaMgr.AddClick(self.clickBtn, self.onClickCommand);
    SetActive(self.LockGo, false)
    SetActive(self.SelectGo, false)
end

function MiniBattle3DungeonItem:SetData(pdata)
    self.data = pdata
    self.Nametxt.text = self.data.showName
    if self.data.isLock then
        self.LockTips.text = os.date(LuaMgr.GetLangText("MiniBattle2DungeonItem_1"), self.data.unlockTime)
    end
    self.Tipstxt.text = self.data.tips
    SetActive(self.TipsGo, not self.data.isLock)
    SetActive(self.LockGo, self.data.isLock)
    SetActive(self.RedGo,RedMgr.Singleton:GetRedStateById(self.data.redId) > 0)
    SetActive(self.gameObject, true)
end

function MiniBattle3DungeonItem:Hide()
    SetActive(self.gameObject, false)
end

function MiniBattle3DungeonItem:Clear()
    self.data = nil
end

function MiniBattle3DungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    self.gameObject = nil
end 
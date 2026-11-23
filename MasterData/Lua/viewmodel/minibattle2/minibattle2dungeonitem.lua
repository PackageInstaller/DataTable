MiniBattle2DungeonItem = {};

MiniBattle2DungeonItem.__index = MiniBattle2DungeonItem;

local objs = {
    clickBtn = { path = "", type = "Button" },
    Nametxt = { path = "Group/Name", type = "Text" },
    ScoreGo = { path = "Group/Score", type = "GameObject" },
    Scoretxt = { path = "Group/Score/Score", type = "Text" },
    LockGo = { path = "Group/Lock", type = "GameObject" },
    LockTips = { path = "Group/Lock/Tips", type = "Text" },
    RedGo = { path = "Group/Red", type = "GameObject" },
    BgGo_1 = { path = "Group/Bg/Bg_1", type = "GameObject" },
    BgGo_2 = { path = "Group/Bg/Bg_2", type = "GameObject" },
    MaskGo_1 = { path = "Group/Lock/Mask_1", type = "GameObject" },
    MaskGo_2 = { path = "Group/Lock/Mask_2", type = "GameObject" },
}

function MiniBattle2DungeonItem.New(obj)
    local self = {};
    setmetatable(self, MiniBattle2DungeonItem);
    self.gameObject = obj
    return self;
end

function MiniBattle2DungeonItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.unlockTime > LuaMgr.Timestamp() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, os.date(LuaMgr.GetLangText("MiniBattle2DungeonItem_0"), self.data.unlockTime));
            return
        end
        LuaMgr.ShowLuaPanel(UIName.MiniBattle2BuffViewModel, self.data.plotId)
    end
    LuaMgr.AddClick(self.clickBtn, self.onClickCommand);
    SetActive(self.LockGo, false)
    SetActive(self.SelectGo, false)
end

function MiniBattle2DungeonItem:SetData(pdata)
    self.data = pdata
    self.Nametxt.text = self.data.showName
    if self.data.isLock then
        self.LockTips.text = os.date(LuaMgr.GetLangText("MiniBattle2DungeonItem_1"), self.data.unlockTime)
    end
    self.Scoretxt.text = self.data.score
    SetActive(self.ScoreGo, not isLock)
    SetActive(self.LockGo, self.data.isLock)
    local showBg1 = self.data.groupIndex % 2 == 1
    local showBg2 = self.data.groupIndex % 2 == 0
    SetActive(self.BgGo_1, showBg1)
    SetActive(self.BgGo_2, showBg2)
    SetActive(self.MaskGo_1, showBg1)
    SetActive(self.MaskGo_2, showBg2)
    SetActive(self.RedGo,RedMgr.Singleton:GetRedStateById(self.data.redId) > 0)
    SetActive(self.gameObject, true)
end

function MiniBattle2DungeonItem:Hide()
    SetActive(self.gameObject, false)
end

function MiniBattle2DungeonItem:Clear()
    self.data = nil
end

function MiniBattle2DungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    self.gameObject = nil
end 
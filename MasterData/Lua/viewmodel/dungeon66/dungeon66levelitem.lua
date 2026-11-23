Dungeon66LevelItem = {};

Dungeon66LevelItem.__index = Dungeon66LevelItem;

local objs = {
    item1Btn = { path = "root/Item1", type = "Button" },
    item1Star1 = { path = "root/Item1/Stars/Star1/Icon", type = "GameObject" },
    item1Star2 = { path = "root/Item1/Stars/Star2/Icon", type = "GameObject" },
    item1Star3 = { path = "root/Item1/Stars/Star3/Icon", type = "GameObject" },
    item1Finish = { path = "root/Item1/Finish", type = "GameObject" },
    item2Btn = { path = "root/Item2", type = "Button" },
    item2Star1 = { path = "root/Item2/Stars/Star1/Icon", type = "GameObject" },
    item2Star2 = { path = "root/Item2/Stars/Star2/Icon", type = "GameObject" },
    item2Star3 = { path = "root/Item2/Stars/Star3/Icon", type = "GameObject" },
    item2Finish = { path = "root/Item2/Finish", type = "GameObject" },
    num = { path = "root/Num/Text", type = "Text" },
    lock = { path = "root/Lock", type = "GameObject" },
    lineGo = { path = "Line", type = "GameObject" },
}

function Dungeon66LevelItem.New()
    local self = {};
    setmetatable(self, Dungeon66LevelItem);
    return self;
end

function Dungeon66LevelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem1 = function()
        if (self:IsUnlock(true)) then
            TrainingCampMgr.SetMembers(self.data.config.SeriesId, self.data.config.DungeonId[1]);
            LuaMgr.ShowLuaPanel(UIName.Dungeon66PrepareViewModel, self.data, 1);
        end
    end
    self.OnClickItem2 = function()
        if (self:IsUnlock(true)) then
            TrainingCampMgr.SetMembers(self.data.config.SeriesId, self.data.config.DungeonId[2]);
            LuaMgr.ShowLuaPanel(UIName.Dungeon66PrepareViewModel, self.data, 2);
        end
    end
    LuaMgr.AddClick(self.item1Btn, self.OnClickItem1);
    LuaMgr.AddClick(self.item2Btn, self.OnClickItem2);
end

function Dungeon66LevelItem:SetData(data)
    self.data = data.data;
    local config = self.data.config;
    SetActive(self.item1Star1, false);
    SetActive(self.item1Star2, false);
    SetActive(self.item1Star3, false);
    SetActive(self.item1Finish, false);

    local star = TrainingCampMgr.GetStar(config.DungeonId[1]);
    SetActive(self.item1Star1, star >= 1);
    SetActive(self.item1Star2, star >= 2);
    SetActive(self.item1Star3, star >= 3);
    SetActive(self.item1Finish, star >= 3);

    SetActive(self.item2Star1, false);
    SetActive(self.item2Star2, false);
    SetActive(self.item2Star3, false);
    SetActive(self.item2Finish, false);
    star = TrainingCampMgr.GetStar(config.DungeonId[2]);
    SetActive(self.item2Star1, star >= 1);
    SetActive(self.item2Star2, star >= 2);
    SetActive(self.item2Star3, star >= 3);
    SetActive(self.item2Finish, star >= 3);

    self.num.text = string.format("<size=64>%d</size>", self.data.index);
    SetActive(self.lock, not self:IsUnlock(false));
    SetActive(self.lineGo, self.data.index < 7);
end

function Dungeon66LevelItem:IsUnlock(isTips)
    if (IsNullOrEmpty(self.data.config.Unlock) or TrainingCampMgr.IsPass(self.data.config.Unlock)) then
        return true;
    end
    if (isTips) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("Dungeon66LevelItem_1"));
    end
    return false;
end

function Dungeon66LevelItem:Clear()
    self.data = nil;
end

function Dungeon66LevelItem:Destroy()
    if (self.OnClickItem1 ~= nil) then
        LuaMgr.RemoveClick(self.item1Btn, self.OnClickItem1);
        self.OnClickItem1 = nil;
    end
    if (self.OnClickItem2 ~= nil) then
        LuaMgr.RemoveClick(self.item2Btn, self.OnClickItem2);
        self.OnClickItem2 = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
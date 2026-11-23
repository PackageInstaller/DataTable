CrisisContract2SimpleEnemyBuffItem = {};

CrisisContract2SimpleEnemyBuffItem.__index = CrisisContract2SimpleEnemyBuffItem;

local objs = {
    IconSprite = { path = "Icon", type = "Image" },
    Nametxt = { path = "Name", type = "Text" },
    Attrtxt = { path = "Level/AddAttrStr", type = "Text" },
    LevelGo_1 = { path = "Level/LevelList/Level_1", type = "GameObject" },
    LevelGo_2 = { path = "Level/LevelList/Level_2", type = "GameObject" },
    LevelGo_3 = { path = "Level/LevelList/Level_3", type = "GameObject" },
    LevelGo_4 = { path = "Level/LevelList/Level_4", type = "GameObject" },
    LevelGo_5 = { path = "Level/LevelList/Level_5", type = "GameObject" },
    LevelChooseGo_1 = { path = "Level/LevelList/Level_1/Image", type = "GameObject" },
    LevelChooseGo_2 = { path = "Level/LevelList/Level_2/Image", type = "GameObject" },
    LevelChooseGo_3 = { path = "Level/LevelList/Level_3/Image", type = "GameObject" },
    LevelChooseGo_4 = { path = "Level/LevelList/Level_4/Image", type = "GameObject" },
    LevelChooseGo_5 = { path = "Level/LevelList/Level_5/Image", type = "GameObject" },
}

function CrisisContract2SimpleEnemyBuffItem.New(obj)
    local self = {};
    setmetatable(self, CrisisContract2SimpleEnemyBuffItem);
    self.gameObject = obj
    return self;
end

function CrisisContract2SimpleEnemyBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function CrisisContract2SimpleEnemyBuffItem:SetData(pdata)
    self.data = pdata.data
    local buffInfo = self.data.BuffInfo
    if TableIsNull(buffInfo) or self.data.Level ~= buffInfo.Level then
        buffInfo = CrisisContract4Mgr.GetBuffInfoByLevel(self.data.Id, self.data.Level)
        self.data.BuffInfo = buffInfo
    end
    self.IconSprite.sprite = buffInfo.Icon
    self.Nametxt.text = buffInfo.Name
    self.Attrtxt.text = buffInfo.AttrStr

    SetActive(self.LevelGo_1, self.data.MaxLevel > 0)
    SetActive(self.LevelGo_2, self.data.MaxLevel > 1)
    SetActive(self.LevelGo_3, self.data.MaxLevel > 2)
    SetActive(self.LevelGo_4, self.data.MaxLevel > 3)
    SetActive(self.LevelGo_5, self.data.MaxLevel > 4)
    SetActive(self.LevelChooseGo_1, self.data.Level > 0)
    SetActive(self.LevelChooseGo_2, self.data.Level > 1)
    SetActive(self.LevelChooseGo_3, self.data.Level > 2)
    SetActive(self.LevelChooseGo_4, self.data.Level > 3)
    SetActive(self.LevelChooseGo_5, self.data.Level > 4)
    SetActive(self.Attrtxt.gameObject, self.data.Level > 0)
    SetActive(self.gameObject, true)
end

function CrisisContract2SimpleEnemyBuffItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract2SimpleEnemyBuffItem:Clear()
    self.data = nil
end

function CrisisContract2SimpleEnemyBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.IconSprite = nil
    self.Nametxt = nil
    self.Attrtxt = nil
    self.LevelGo_1 = nil
    self.LevelGo_2 = nil
    self.LevelGo_3 = nil
    self.LevelGo_4 = nil
    self.LevelGo_5 = nil
    self.LevelChooseGo_1 = nil
    self.LevelChooseGo_2 = nil
    self.LevelChooseGo_3 = nil
    self.LevelChooseGo_4 = nil
    self.LevelChooseGo_5 = nil
end 
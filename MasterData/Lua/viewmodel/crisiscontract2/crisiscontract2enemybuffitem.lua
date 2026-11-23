CrisisContract2EnemyBuffItem = {};

CrisisContract2EnemyBuffItem.__index = CrisisContract2EnemyBuffItem;

local objs = {
    Desctxt = { path = "Desc/Text", type = "Text" },
    IconSprite = { path = "NameAndIcon/Icon", type = "Image" },
    Nametxt = { path = "NameAndIcon/Name", type = "Text" },
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
    Choosed = { path = "Choosed", type = "GameObject" },
    DelBtn = { path = "DelBtn", type = "Button" },
    AddBtn = { path = "AddBtn", type = "Button" },
    MinGo = { path = "MinImg", type = "GameObject" },
    MaxGo = { path = "MaxImg", type = "GameObject" },
}

function CrisisContract2EnemyBuffItem.New(obj)
    local self = {};
    setmetatable(self, CrisisContract2EnemyBuffItem);
    self.gameObject = obj
    return self;
end

function CrisisContract2EnemyBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickAddCommand = function()
        if self.data.onClickAdd ~= nil then
            self.data.onClickAdd(self.data.index);
        end
    end
    LuaMgr.AddClick(self.AddBtn, self.onClickAddCommand);
    self.onClickDelCommand = function()
        if self.data.onClickDel ~= nil then
            self.data.onClickDel(self.data.index);
        end
    end
    LuaMgr.AddClick(self.DelBtn, self.onClickDelCommand);
end

function CrisisContract2EnemyBuffItem:SetData(pdata)
    self.data = pdata.data
    local buffInfo = self.data.BuffInfo
    if TableIsNull(buffInfo) or self.data.Level ~= buffInfo.Level then
        buffInfo = CrisisContract4Mgr.GetBuffInfoByLevel(self.data.Id, self.data.Level)
        self.data.BuffInfo = buffInfo
    end
    self.Desctxt.text = buffInfo.Desc
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
    SetActive(self.Choosed, self.data.Level > 0)
    SetActive(self.DelBtn.gameObject, self.data.Level > 0)
    SetActive(self.MinGo, self.data.Level == 0)
    SetActive(self.AddBtn.gameObject, self.data.Level < self.data.MaxLevel)
    SetActive(self.MaxGo, self.data.Level == self.data.MaxLevel)
    SetActive(self.gameObject, true)
end

function CrisisContract2EnemyBuffItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract2EnemyBuffItem:Clear()
    self.data = nil
end

function CrisisContract2EnemyBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickAddCommand ~= nil) then
        LuaMgr.RemoveClick(self.AddBtn, self.onClickAddCommand)
        self.onClickAddCommand = nil
    end
    if (self.onClickDelCommand ~= nil) then
        LuaMgr.RemoveClick(self.DelBtn, self.onClickDelCommand)
        self.onClickDelCommand = nil
    end
    self.Desctxt = nil
    self.IconSprite = nil
    self.Nametxt = nil
    self.Choosed = nil
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
    self.DelBtn = nil
    self.AddBtn = nil
    self.MinGo = nil
    self.MaxGo = nil
end 
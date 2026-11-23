RogueBuffItem = {};

RogueBuffItem.__index = RogueBuffItem;

local objs = {
    Bg1 = { path = "Group/Bg1", type = "GameObject" },
    Bg2 = { path = "Group/Bg2", type = "GameObject" },
    Desctxt = { path = "Group/Desc", type = "Text" },
    IconSprite = { path = "Group/NameAndIcon/Icon", type = "Image" },
    Nametxt = { path = "Group/NameAndIcon/Name", type = "Text" },
    Attrtxt = { path = "Group/Level/AddAttrStr", type = "Text" },
    LevelGo_1 = { path = "Group/Level/LevelList/Level_1", type = "GameObject" },
    LevelGo_2 = { path = "Group/Level/LevelList/Level_2", type = "GameObject" },
    LevelGo_3 = { path = "Group/Level/LevelList/Level_3", type = "GameObject" },
    LevelGo_4 = { path = "Group/Level/LevelList/Level_4", type = "GameObject" },
    LevelGo_5 = { path = "Group/Level/LevelList/Level_5", type = "GameObject" },
    LevelGo_6 = { path = "Group/Level/LevelList/Level_6", type = "GameObject" },
    LevelChooseGo_1 = { path = "Group/Level/LevelList/Level_1/Image", type = "GameObject" },
    LevelChooseGo_2 = { path = "Group/Level/LevelList/Level_2/Image", type = "GameObject" },
    LevelChooseGo_3 = { path = "Group/Level/LevelList/Level_3/Image", type = "GameObject" },
    LevelChooseGo_4 = { path = "Group/Level/LevelList/Level_4/Image", type = "GameObject" },
    LevelChooseGo_5 = { path = "Group/Level/LevelList/Level_5/Image", type = "GameObject" },
    LevelChooseGo_6 = { path = "Group/Level/LevelList/Level_6/Image", type = "GameObject" },
    DelBtn = { path = "Group/DelBtn", type = "Button" },
    AddBtn = { path = "Group/AddBtn", type = "Button" },
    MinGo = { path = "Group/MinImg", type = "GameObject" },
    MaxGo = { path = "Group/MaxImg", type = "GameObject" },
}

function RogueBuffItem.New(obj)
    local self = {};
    setmetatable(self, RogueBuffItem);
    self.gameObject = obj
    return self;
end

function RogueBuffItem:Init()
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

function RogueBuffItem:SetData(pdata)
    self.data = pdata.data
    local buffInfo = self.data.BuffInfo
    if TableIsNull(buffInfo) then
        return
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
    SetActive(self.LevelGo_6, self.data.MaxLevel > 5)
    SetActive(self.LevelChooseGo_1, self.data.Level > 0)
    SetActive(self.LevelChooseGo_2, self.data.Level > 1)
    SetActive(self.LevelChooseGo_3, self.data.Level > 2)
    SetActive(self.LevelChooseGo_4, self.data.Level > 3)
    SetActive(self.LevelChooseGo_5, self.data.Level > 4)
    SetActive(self.LevelChooseGo_6, self.data.Level > 5)
    SetActive(self.Bg1, self.data.Level > 0)
    SetActive(self.Bg2, self.data.Level == 0)
    SetActive(self.DelBtn.gameObject, self.data.Level > 0)
    SetActive(self.MinGo, self.data.Level == 0)
    SetActive(self.AddBtn.gameObject, self.data.Level < self.data.MaxLevel)
    SetActive(self.MaxGo, self.data.Level == self.data.MaxLevel)
    SetActive(self.gameObject, true)
end

function RogueBuffItem:Hide()
    SetActive(self.gameObject, false)
end

function RogueBuffItem:Clear()
    self.data = nil
end

function RogueBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickAddCommand ~= nil) then
        LuaMgr.RemoveClick(self.AddBtn, self.onClickAddCommand)
        self.onClickAddCommand = nil
    end
    if (self.onClickDelCommand ~= nil) then
        LuaMgr.RemoveClick(self.DelBtn, self.onClickDelCommand)
        self.onClickDelCommand = nil
    end
    self.gameObject = nil
end 
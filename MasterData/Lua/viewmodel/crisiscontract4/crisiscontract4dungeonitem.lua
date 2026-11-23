CrisisContract4DungeonItem = {};

CrisisContract4DungeonItem.__index = CrisisContract4DungeonItem;

local objs = {
    clickBtn = { path = "Group/Bg", type = "Button" },
    ScoreText = { path = "Group/Score/Text", type = "Text" },
    NoScoreGo = { path = "Group/Score/NoScore", type = "GameObject" },
    UnLockGo = { path = "Group/Unlock", type = "GameObject" },
    UnLockTips = { path = "Group/Unlock/Image/Tips", type = "Text" },
    SelectGo = { path = "Group/Select", type = "GameObject" },
    RedGo = { path = "Group/Red", type = "GameObject" },
}

function CrisisContract4DungeonItem.New(obj)
    local self = {};
    setmetatable(self, CrisisContract4DungeonItem);
    self.gameObject = obj
    return self;
end

function CrisisContract4DungeonItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.data.dungeonId);
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.onClickCommand);
    SetActive(self.UnLockGo, false)
    SetActive(self.SelectGo, false)
end

function CrisisContract4DungeonItem:SetData(pdata)
    self.data = pdata
    local dungeonId = self.data.dungeonId
    SetActive(self.UnLockGo, false)
    local score = CrisisContract4Mgr.GetDungeonHighestScore(dungeonId)
    self.ScoreText.text = score
    SetActive(self.NoScoreGo, score <= 0)
    SetActive(self.ScoreText.gameObject, score > 0)
    SetActive(self.RedGo,self.data.isRed)
    SetActive(self.SelectGo, self.data.isSelected)
    SetActive(self.gameObject, true)
end

function CrisisContract4DungeonItem:SetSelect(isSelected)
    self.data.isSelected = isSelected
    SetActive(self.SelectGo, isSelected)
end

function CrisisContract4DungeonItem:PlayAnim()
    SetActive(self.gameObject, false)
    SetActive(self.gameObject, true)
end

function CrisisContract4DungeonItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract4DungeonItem:Clear()
    self.data = nil
end

function CrisisContract4DungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    self.gameObject = nil
end 
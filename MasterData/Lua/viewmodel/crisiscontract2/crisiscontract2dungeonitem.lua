CrisisContract2DungeonItem = {};

CrisisContract2DungeonItem.__index = CrisisContract2DungeonItem;

local objs = {
    clickBtn = { path = "Group/Bg", type = "Button" },
    Indextxt = { path = "Group/Index", type = "Text" },
    ScoreGo = { path = "Group/Score", type = "GameObject" },
    Scoretxt = { path = "Group/Score/Text", type = "Text" },
    NoScoreGo = { path = "Group/Score/NoScore", type = "GameObject" },
    UnLockGo = { path = "Group/Unlock", type = "GameObject" },
    UnLockTips = { path = "Group/Unlock/Tips", type = "Text" },
    SelectGo = { path = "Group/Select", type = "GameObject" },
    RedGo = { path = "Group/Red", type = "GameObject" },
    groupImage = { path = "Group", type = "Image" },
}

function CrisisContract2DungeonItem.New(obj)
    local self = {};
    setmetatable(self, CrisisContract2DungeonItem);
    self.gameObject = obj
    return self;
end

function CrisisContract2DungeonItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.onClickCommand = function()
        if self.data.callBack ~= nil then
            self.data.callBack(self.data.index);
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.onClickCommand);
    SetActive(self.UnLockGo, false)
    SetActive(self.SelectGo, false)
end

function CrisisContract2DungeonItem:SetData(pdata)
    self.data = pdata
    local plotId = self.data.plotId
    self.Indextxt.text = tostring(self.data.index)
    local leftTime = self.data.unlockTime - LuaMgr.Timestamp()
    local isUnLock = leftTime <= 0
    if isUnLock then
        local score = CrisisContract2Mgr.GetCurPlotScore(plotId)
        self.Scoretxt.text = score
        SetActive(self.NoScoreGo, score <= 0)
        SetActive(self.Scoretxt.gameObject, score > 0)
        SetActive(self.ScoreGo, true)
        SetActive(self.UnLockGo, false)
    else
        SetActive(self.ScoreGo, false)
        SetActive(self.UnLockGo, true)
        self.data.addTimer(plotId, {
            tips = self.UnLockTips,
            leftTime = leftTime,
        })
        self.UnLockTips.text = string.format(LuaMgr.GetLangText("CrisisContract2DungeonItem_0"), CrisisContract2Mgr.GetLeftTimeStr(leftTime))
    end
    SetActive(self.SelectGo, self.data.getChoosePlotId() == plotId)
    self.groupImage.sprite = LuaMgr.GetSprite("CrisisContract2","ui_hd_eh_gq_0" .. (self.data.index % 6 + 1))
    SetActive(self.RedGo,RedMgr.Singleton:GetRedStateById(self.data.redId) > 0)
    
    SetActive(self.gameObject, true)
end

function CrisisContract2DungeonItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract2DungeonItem:Clear()
    self.data = nil
end

function CrisisContract2DungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.onClickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.onClickCommand)
        self.onClickCommand = nil
    end
    self.clickBtn = nil
    self.Nametxt = nil
    self.Scoretxt = nil
    self.UnLockGo = nil
    self.UnLockTips = nil
    self.SelectGo = nil
end 
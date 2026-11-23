CrisisContract2RewardItem = {};

CrisisContract2RewardItem.__index = CrisisContract2RewardItem;

local objs = {
    onClickBtn = { path = "root", type = "Button" },
    bg1 = { path = "root/bg1", type = "GameObject" },
    bg2 = { path = "root/bg2", type = "GameObject" },
    finished = { path = "root/finished", type = "GameObject" },
    Score = { path = "root/Score", type = "Text" },
}

function CrisisContract2RewardItem.New()
    local self = {};
    setmetatable(self, CrisisContract2RewardItem);
    return self;
end

function CrisisContract2RewardItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClick = function()
        if self.data.onClick ~= nil then
            self.data.onClick(self.data, self.transform.position);
        end
    end
    LuaMgr.AddClick(self.onClickBtn, self.OnClick);
end

function CrisisContract2RewardItem:SetData(pdata)
    self.data = pdata.data;
    self.Score.text = string.format(LuaMgr.GetLangText("CrisisContract2RewardItem_0"), self.data.credit)
    SetActive(self.bg1, not self.data.isCanGet)
    SetActive(self.bg2, self.data.isCanGet)
    SetActive(self.finished, self.data.isFinished)
end

function CrisisContract2RewardItem:Clear()
    self.data = nil;
end

function CrisisContract2RewardItem:Destroy()
    if (self.onClickBtn ~= nil) then
        LuaMgr.RemoveClick(self.onClickBtn, self.OnClick);
        self.onClickBtn = nil;
    end
    self.data = nil;
    self.goRewarded = nil
    self.bgSprite = nil
    self.root = nil
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
VoyageRichManBattleConditionItem = {};

VoyageRichManBattleConditionItem.__index = VoyageRichManBattleConditionItem;

local objs = {
    winBg = { path = "WinBg", type = "GameObject" },
    loseBg = { path = "LoseBg", type = "GameObject" },
    text = { path = "Text", type = "Text" },
};

function VoyageRichManBattleConditionItem.New()
    local self = {};
    setmetatable(self, VoyageRichManBattleConditionItem);
    return self;
end

function VoyageRichManBattleConditionItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function VoyageRichManBattleConditionItem:SetData(data)
    SetActive(self.winBg, data.data.isWin);
    SetActive(self.loseBg, not data.data.isWin);
    self.text.text = data.data.text;
end

function VoyageRichManBattleConditionItem:Clear()
end

function VoyageRichManBattleConditionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
RhythmGameWinConditionItem = {};

RhythmGameWinConditionItem.__index = RhythmGameWinConditionItem;

local objs = {
    status1 = { path = "Status1", type = "GameObject" },
    status2 = { path = "Status2", type = "GameObject" },
    text = { path = "Text", type = "Text" },
}

function RhythmGameWinConditionItem.New()
    local self = {};
    setmetatable(self, RhythmGameWinConditionItem);
    return self;
end

function RhythmGameWinConditionItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function RhythmGameWinConditionItem:SetData(data)
    local status = data.data.status;
    if (status == 0) then
        SetActive(self.status1, true);
        SetActive(self.status2, false);
        self.text.text = string.format("<color=#97a0b1>%s</color>", data.data.content);
    else
        SetActive(self.status1, false);
        SetActive(self.status2, true);
        self.text.text = data.data.content;
    end
end

function RhythmGameWinConditionItem:Clear()
end

function RhythmGameWinConditionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end
ActivityBossDummy3DelegateBattleResultPopupItem = {}

ActivityBossDummy3DelegateBattleResultPopupItem.__index = ActivityBossDummy3DelegateBattleResultPopupItem

local objs = 
{
    text_score  = { path = "text_score", type = "Text" },
    nums_go     = { path = "nums", type = "GameObject" },
}

function ActivityBossDummy3DelegateBattleResultPopupItem.New()
    local obj = {}
    setmetatable(obj, ActivityBossDummy3DelegateBattleResultPopupItem)
    return obj
end

function ActivityBossDummy3DelegateBattleResultPopupItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityBossDummy3DelegateBattleResultPopupItem:SetData(d)
    local data = d.data
    local index = data.index
    self.text_score.text = data.score
    if index >= 1 and index <= 9 then
        self.nums_go.transform:Find("num" .. index).gameObject:SetActive(true)
    end
end

function ActivityBossDummy3DelegateBattleResultPopupItem:Clear()

end

function ActivityBossDummy3DelegateBattleResultPopupItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
end
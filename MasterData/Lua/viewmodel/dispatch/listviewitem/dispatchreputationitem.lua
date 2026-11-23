










DispatchReputationItem = {}
DispatchReputationItem.__index = DispatchReputationItem

local objs = {
    nameText = {path = "Group/Name", type = UITool.Text},
    conditionText = {path = "Group/ConditionText", type = UITool.Text},
}

DispatchReputationItem.New = function()

    local self = {}
    setmetatable(self, DispatchReputationItem)
    return self
end

function DispatchReputationItem:Init()
    self.rewardItems = {}
    UITool.Parse(self.gameObject, self, objs)
end

function DispatchReputationItem:SetData(data)
    if data ~= nil then
        self.data = data.data
    end
    self:SetItem()
end

function DispatchReputationItem:SetItem()
    local txt1 = LuaMgr.GetLangText(self.data.config.LevelNameLan)
    local txt2 = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23712")
    local str = string.format(txt2, txt1)
    self.nameText.text = str
    self.conditionText.text = tostring(self.data.unlockReputation)
end

function DispatchReputationItem:ClearItems()
end

function DispatchReputationItem:Clear()
    self:ClearItems()
end

function DispatchReputationItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end













LHSARecollectionItem = {}
LHSARecollectionItem.__index = LHSARecollectionItem

local objs = {
    button = {path = "Group", type = UITool.Button},
    groupObj = {path = "Group", type = UITool.GameObject},
    flagObjRepeat = {path = "Group/FlagObjRepeat", type = UITool.GameObject},
    flagRepeatComplete = {path = "Group/FlagObjRepeat/FlagRepeatComplete", type = UITool.GameObject},
    flagObjMain = {path = "Group/FlagObjMain", type = UITool.GameObject},
    flagMainComplete = {path = "Group/FlagObjMain/FlagMainComplete", type = UITool.GameObject},
    flagObjHard = {path = "Group/FlagObjHard", type = UITool.GameObject},
    name = {path = "Group/Name", type = UITool.Text},
    statusText = {path = "Group/StatusText", type = UITool.Text},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject}
}

LHSARecollectionItem.New = function()

    local self = {}
    setmetatable(self, LHSARecollectionItem)
    return self
end

function LHSARecollectionItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnclickItemBtn = function()
        if self.data.OnClickCallback ~= nil then
            self.data.OnClickCallback(self)
        end
    end
    LuaMgr.AddClick(self.button, self.OnclickItemBtn)
end

function LHSARecollectionItem:SetData(data)
    self.data = data.data
    SetActive(self.flagObjRepeat, self.data.EventType == LHSAMgr.EventType.Repeat)
    SetActive(self.flagObjMain, self.data.EventType == LHSAMgr.EventType.MainLine)
    SetActive(self.flagObjHard, self.data.EventType == LHSAMgr.EventType.Hard)
    SetActive(self.statusText.gameObject, true)
    SetActive(self.lockObj, self.data.Status == CommonRewardItem.Status.Lock)
    SetActive(self.flagRepeatComplete, self.data.Status == CommonRewardItem.Status.Got)
    SetActive(self.flagMainComplete, self.data.Status == CommonRewardItem.Status.Got)
    if self.data.IsNew == true then
        self.statusText.text = LuaMgr.GetLangText("LHSARecollectionItem_0")
    elseif self.data.EventType == LHSAMgr.EventType.Hard and self.data.Status == CommonRewardItem.Status.Got then
        self.statusText.text = LuaMgr.GetLangText(self.data.ScoreLan)
    else
        SetActive(self.statusText.gameObject, false)
    end
    self.name.text = self.data.Name
end

function LHSARecollectionItem:ClearItems()
end

function LHSARecollectionItem:Clear()
    self:ClearItems()
end

function LHSARecollectionItem:Destroy()
    self:Clear()
    self.gameObject = nil
    self.data = nil
end
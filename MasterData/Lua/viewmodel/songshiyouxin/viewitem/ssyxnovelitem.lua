










SSYXNovelItem = {}
SSYXNovelItem.__index = SSYXNovelItem

local objs = {
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    lockName = {path = "Group/LockObj/Name", type = UITool.Text},
    unlockObj = {path = "Group/UnlockObj", type = UITool.GameObject},
    unlockName = {path = "Group/UnlockObj/Name", type = UITool.Text},
    finishObj = {path = "Group/FinishObj", type = UITool.GameObject},
    finishName = {path = "Group/FinishObj/Name", type = UITool.Text},
    selectObj = {path = "Group/SelectObj", type = UITool.GameObject},
    selectButton = {path = "", type = UITool.Button}
}

SSYXNovelItem.New = function()

    local self = {}
    setmetatable(self, SSYXNovelItem)
    return self
end

function SSYXNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.onClickSelectBtn = function()
        if self.data.Status == CommonRewardItem.Status.Lock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.data.UnlockDesc)
            return
        end
        if self.data.OnClickCallback then
            self.data.OnClickCallback(self, false)
        end
    end
    LuaMgr.AddClick(self.selectButton, self.onClickSelectBtn)
end

function SSYXNovelItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    if self.data.IsSelected == true then
        self.data.OnClickCallback(self, false)
    else
        self:SetSelected(false)
    end
    SetActive(self.lockObj, self.data.Status == CommonRewardItem.Status.Lock)
    SetActive(self.unlockObj, self.data.Status == CommonRewardItem.Status.None)
    SetActive(self.finishObj, self.data.Status == CommonRewardItem.Status.Got)
    SetActive(self.selectObj, self.data.IsSelected == true)
    if self.data.Status == CommonRewardItem.Status.Lock then
        self.lockName.text = self.data.Name
    elseif self.data.Status == CommonRewardItem.Status.None then
        self.unlockName.text = self.data.Name
    elseif self.data.Status == CommonRewardItem.Status.Got then
        self.finishName.text = self.data.Name
    end
end

function SSYXNovelItem:SetSelected(isSelect)
    self.data.IsSelected = isSelect
    SetActive(self.selectObj, self.data.IsSelected == true)
end

function SSYXNovelItem:ClearItems()
end

function SSYXNovelItem:Clear()
    self:ClearItems()
end

function SSYXNovelItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
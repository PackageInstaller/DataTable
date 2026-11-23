




BranchNumModel = {}

BranchNumModel.__index = BranchNumModel

local objs = {
    countText_1 = {path = "Normal/Text",type = "Text"},
    lock = {path = "Lock",type = "GameObject"},
    countText_2 = {path = "Lock/Text",type = "Text"},
    normalBtn = {path = "Normal",type = "Button"},
    lockBtn = {path = "Lock",type = "Button"},
}

function BranchNumModel.New(prefab, parent)
    local self = {}
    setmetatable(self, BranchNumModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.normalCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.BranchItemClick, self.branchId)
    end
    self.lockCommand = function()
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["9008"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tipStr)
    end
    LuaMgr.AddClick(self.normalBtn,self.normalCommand)
    LuaMgr.AddClick(self.lockBtn,self.lockCommand)
    return self
end

function BranchNumModel:SetData(index,branchId)
    self.index = index
    self.branchId = branchId
    local numStr = self:GetNumStr()
    self.countText_1.text,self.countText_2.text = numStr,numStr
    SetActive(self.lock,self:GetState())
    self.gameObject:SetActive(true)
end

function BranchNumModel:GetNumStr()
    if self.index == 1 then
        return LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["9009"].NameLan)
    elseif self.index == 2 then
        return LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["9010"].NameLan)
    elseif self.index == 3 then
        return LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["9011"].NameLan)
    end
end

function BranchNumModel:GetState()
    for i = 1, #DataMgr.Player.completedChapters do
        if DataMgr.Player.completedChapters[i] == self.branchId then
            return false
        end
    end
    return true
end

function BranchNumModel:Clear()
    self.index = nil
    self.branchId = nil
    self.gameObject:SetActive(false)
end

function BranchNumModel:Destroy()
    if (self.normalCommand ~= nil) then
        LuaMgr.RemoveClick(self.normalBtn, self.normalCommand)
        self.normalCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    if (self.lockCommand ~= nil) then
        LuaMgr.RemoveClick(self.lockBtn, self.lockCommand)
        self.lockCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
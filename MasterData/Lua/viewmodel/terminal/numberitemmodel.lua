





NumberItemModel = {}

NumberItemModel.__index = NumberItemModel

local objs = {
    normalText = {path = "Normal/Text",type = "Text"},
    select = {path = "Select",type = "GameObject"},
    selectText = {path = "Select/Text",type = "Text"},
    button = {path = "Normal",type = "Button"},
    lockText = {path = "Lock/Text",type = "Text"},
    lockBtn = {path = "Lock",type = "Button"},
    isLock = {path = "Lock",type = "GameObject"},
}

function NumberItemModel.New()
    local self = {}
    setmetatable(self, NumberItemModel)
    return self
end

function NumberItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.NumberItemClick,self.data.index,self.data.dataId)
    end
    self.lockCommand = function()
        self:ClickLock()
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
    LuaMgr.AddClick(self.lockBtn,self.lockCommand)
end

function NumberItemModel:SetData(data)
    self.data = data.data
    self.data.unlock = ConfigMgr.Config.TxtContentMap[self.data.dataId].Unlock
    self.tipLan = ConfigMgr.Config.TxtContentMap[self.data.dataId].UnlockTipLan
    SetActive(self.select,false)
    self:SetLock()
    local strNum = self.data.index < 10 and "0"..self.data.index or self.data.index
    self.lockText.text = strNum
    self.normalText.text = strNum
    self.selectText.text = strNum
    self.gameObject:SetActive(true)
end

function NumberItemModel:SetLock()
    local tempLock = false
    if self.data.unlock[1] == "1" then
        tempLock = tonumber(self.data.unlock[2]) > DataMgr.Player.level
    elseif self.data.unlock[1] == "2" then
        tempLock = DataMgr.Player.completedAreaEvents[self.data.unlock[2]] == nil
    elseif self.data.unlock[1] == "3" then
        tempLock = PlayerCharacterMgr.GetState(self.data.unlock[2])
    end
    SetActive(self.isLock,tempLock)
end

function NumberItemModel:ClickLock()
    local tipStr,condition = "",""
    if self.data.unlock[1] == "1" then
        condition = self.data.unlock[2]
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2128"].NameLan)
    elseif self.data.unlock[1] == "2" then
        condition = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[self.data.unlock[2]].NameLan)
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2134"].NameLan)
    elseif self.data.unlock[1] == "3" then
        condition = LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[self.data.unlock[2]].nameLan)
        tipStr = LuaMgr.GetLangText(self.tipLan)..LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13200"].NameLan)
    end
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,condition))
end

function NumberItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function NumberItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    if (self.lockCommand ~= nil) then
        LuaMgr.RemoveClick(self.lockBtn, self.lockCommand)
        self.lockCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end





DungeonItemModel = {}

DungeonItemModel.__index = DungeonItemModel
local objs = {
    normal = {path = "Normal",type = "GameObject"},
    normal_Text = {path = "Normal/Num",type = "Text"},
    lock = {path = "Lock",type = "GameObject"},
    lock_Text = {path = "Lock/Num",type = "Text"},
    perfect = {path = "Perfect",type = "GameObject"},
    normal_1 = {path = "Normal_1",type = "GameObject"},
    lock_1 = {path = "Lock_1",type = "GameObject"},
    select = {path = "Select",type = "GameObject"},
    select_Text = {path = "Select/Num",type = "Text"},
    button = {path = "Btn",type = "Button"},
}

function DungeonItemModel.New()
    local self = {}
    setmetatable(self, DungeonItemModel)
    return self
end

function DungeonItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.AbyssDungeonSelect,self.data.index)
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
end

function DungeonItemModel:SetData(data)
    self.data = data.data.data
    self.config = data.data.config
    self.dungeonConfig = ConfigMgr.Config.dungeonMap[self.config.eventParam]
    self.dungeonData = DataMgr.Player.dungeonRecords[self.config.eventParam]
    



    SetActive(self.lock_1,self.data.dungeonStatus == 3)
    SetActive(self.perfect,self.data.dungeonStatus == 1)
    SetActive(self.normal_1,self.data.dungeonStatus == 2)
    
    SetActive(self.normal,not self.data.lock)
    self.normal_Text.text = self.data.index
    
    SetActive(self.lock,self.data.lock)
    self.lock_Text.text = self.data.index
    
    self:SetSelect(self.data.select)
    self.select_Text.text = self.data.index

    self.gameObject:SetActive(true)
end

function DungeonItemModel:SetSelect(isShow)
    SetActive(self.select,isShow)
end

function DungeonItemModel:Clear()
    self.data = nil
    self.config = nil
    self.gameObject:SetActive(false)
end

function DungeonItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end






EquipSeriesItem = {}
EquipSeriesItem.__index = EquipSeriesItem

local objs = {
    normal_Text = {path = "Normal/Text",type = "Text"},
    choose = {path = "Choose",type = "GameObject"},
    choose_Text = {path = "Choose/Text",type = "Text"},
    clickBtn = {path = "Normal",type = "Button"},
}

function EquipSeriesItem.New()
    local self = {}
    setmetatable(self, EquipSeriesItem)
    return self
end

function EquipSeriesItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        if self.callback ~= nil then
            self.callback(self.data)
        end
    end
    LuaMgr.AddClick(self.clickBtn,self.clickCommand)
end

function EquipSeriesItem:SetData(data)
    self.data = data.data.data
    self.callback = data.data.callback
    self.seriesOptions = data.data.seriesOptions
    local str = ConfigMgr.LangGlobal("16100_"..self.data)
    self.normal_Text.text = str
    self.choose_Text.text = str
    SetActive(self.choose,self.seriesOptions[self.data] ~= nil)
    self.gameObject:SetActive(true)
end

function EquipSeriesItem:Clear()
    self.data = nil
    self.callback = nil
    self.seriesOptions = nil
    self.gameObject:SetActive(false)
end

function EquipSeriesItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
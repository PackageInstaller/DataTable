





SettingPlayerTitleGroup = {}

SettingPlayerTitleGroup.__index = SettingPlayerTitleGroup

function SettingPlayerTitleGroup.New()
    local self = {}
    setmetatable(self, SettingPlayerTitleGroup)
    return self
end

function SettingPlayerTitleGroup:Init()
    self.itemList = {}
end

function SettingPlayerTitleGroup:SetData(data)
    self.data = data.data
    for i = 1, #self.data.title do
        if i > #self.itemList then
            tempItem = SettingPlayerTitleItem.New(self.data.item,self.transform)
            table.insert(self.itemList,tempItem)
        end
        self.itemList[i]:SetData(self.data.title[i],self.data.call)
    end
end

function SettingPlayerTitleGroup:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
end

function SettingPlayerTitleGroup:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    self.itemList = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
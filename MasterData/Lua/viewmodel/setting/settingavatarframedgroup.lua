SettingAvatarFramedGroup = {}

SettingAvatarFramedGroup.__index = SettingAvatarFramedGroup 

local itemNameList = { "item1", "item2", "item3", "item4" }
local keyList = { "data_1", "data_2", "data_3", "data_4" }

function SettingAvatarFramedGroup.New()
    local self = {} 
    setmetatable(self, SettingAvatarFramedGroup) 
    return self 
end

function SettingAvatarFramedGroup:Init()
    for i = 1, #itemNameList do
        self[itemNameList[i]] = nil
    end
end

function SettingAvatarFramedGroup:SetData(data)
    self.data = data.data 
    for i = 1, #itemNameList do
        if (self.data[keyList[i]] ~= nil) then
            if (self[itemNameList[i]] == nil) then
                self[itemNameList[i]] = SettingAvatarFramedItem.New(self.data.item, self.transform) 

            end
            self[itemNameList[i]]:SetData(self.data[keyList[i]]) 
        end
    end
end

function SettingAvatarFramedGroup:Clear()
    self.data = nil
    for i = 1, #itemNameList do
        if (self[itemNameList[i]] ~= nil) then
            self[itemNameList[i]]:Clear()
        end
    end
end

function SettingAvatarFramedGroup:Destroy()
    for i = 1, #itemNameList do
        if (self[itemNameList[i]] ~= nil) then
            self[itemNameList[i]]:Destroy()
            self[itemNameList[i]] = nil
        end
    end
    LuaMgr.DestroyImmediateGO(self.gameObject) 
    self.gameObject = nil 
end
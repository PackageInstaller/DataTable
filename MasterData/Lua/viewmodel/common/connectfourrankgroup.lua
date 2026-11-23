ConnectFourRankGroup = {}

ConnectFourRankGroup.__index = ConnectFourRankGroup

local itemNameList = { "item1" }
local keyList = { "data_1" }

function ConnectFourRankGroup.New()
    local self = {}
    setmetatable(self, ConnectFourRankGroup)
    return self
end

function ConnectFourRankGroup:Init()
    for i = 1, #itemNameList do
        self[itemNameList[i]] = nil
    end
end

function ConnectFourRankGroup:SetData(data)
    self.data = data.data
    for i = 1, #itemNameList do
        if (self.data[keyList[i]] ~= nil) then
            if (self[itemNameList[i]] == nil) then
                self[itemNameList[i]] = ConnectFourRankItem.New(self.data.item, self.transform)
                self[itemNameList[i]].transform.anchoredPosition = Vector2.zero;
            end
            self[itemNameList[i]]:SetData(self.data[keyList[i]])
        end
    end
end

function ConnectFourRankGroup:Clear()
    self.data = nil
    for i = 1, #itemNameList do
        if (self[itemNameList[i]] ~= nil) then
            self[itemNameList[i]]:Clear()
        end
    end
end

function ConnectFourRankGroup:Destroy()
    for i = 1, #itemNameList do
        if (self[itemNameList[i]] ~= nil) then
            self[itemNameList[i]]:Destroy()
            self[itemNameList[i]] = nil
        end
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
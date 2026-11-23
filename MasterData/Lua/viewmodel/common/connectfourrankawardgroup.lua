ConnectFourRankAwardGroup = {}

ConnectFourRankAwardGroup.__index = ConnectFourRankAwardGroup

local itemNameList = { "item1" }
local keyList = { "data_1" }

function ConnectFourRankAwardGroup.New()
    local self = {}
    setmetatable(self, ConnectFourRankAwardGroup)
    return self
end

function ConnectFourRankAwardGroup:Init()
    for i = 1, #itemNameList do
        self[itemNameList[i]] = nil
    end
end

function ConnectFourRankAwardGroup:SetData(data)
    self.data = data.data
    for i = 1, #itemNameList do
        if (self.data[keyList[i]] ~= nil) then
            if (self[itemNameList[i]] == nil) then
                self[itemNameList[i]] = ConnectFourRankAwardItem.New(self.data.item, self.transform)
                self[itemNameList[i]].gameObject.transform.anchoredPosition = Vector2.zero;
            end
            self[itemNameList[i]]:SetData(self.data[keyList[i]])
        end
    end
end

function ConnectFourRankAwardGroup:Clear()
    self.data = nil
    for i = 1, #itemNameList do
        if (self[itemNameList[i]] ~= nil) then
            self[itemNameList[i]]:Clear()
        end
    end
end

function ConnectFourRankAwardGroup:Destroy()
    for i = 1, #itemNameList do
        if (self[itemNameList[i]] ~= nil) then
            self[itemNameList[i]]:Destroy()
            self[itemNameList[i]] = nil
        end
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
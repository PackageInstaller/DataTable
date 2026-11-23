




BuildingItemModel = {}

BuildingItemModel.__index = BuildingItemModel
local objs = {
    perfect = {path = "Normal/Perfect",type = "GameObject"},
    normal = {path = "Normal/Normal",type = "GameObject"},
    select = {path = "Select",type = "GameObject"},
    lock = {path = "Lock",type = "GameObject"},
    num = {path = "Num",type = "Image"},
    button = {path = "Normal",type = "Button"},
    dungeonNode = {path = "Dungeon",type = "Transform"},
}
local dungeonObjs = {
    lock = {path = "Lock",type = "GameObject"},
    normal = {path = "Normal",type = "GameObject"},
    perfect = {path = "Perfect",type = "GameObject"},
}

function BuildingItemModel.New()
    local self = {}
    setmetatable(self, BuildingItemModel)
    return self
end

function BuildingItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    if self.dungeon == nil then
        self.dungeon = {}
        local item,tempObj = nil,nil
        for i = 1, self.dungeonNode.childCount do
            item = {}
            tempObj = self.dungeonNode:Find(i).gameObject
            UITool.Parse(tempObj,item,dungeonObjs)
            table.insert(self.dungeon,i,item)
        end
    end
    self.clickCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.AbyssBuildingSelect,self.data.index)
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
end

function BuildingItemModel:SetData(data)
    self.data = data.data
    if self.data.data.lock then
        self:SetNum3()
    else
        if self.data.data.select then
            self:SetNum1()
        else
            self:SetNum2()
        end
    end
    SetActive(self.perfect,false)
    SetActive(self.normal,false)
    SetActive(self.lock,self.data.data.lock)
    self:SetDungeon()
    self.gameObject:SetActive(true)
end

function BuildingItemModel:SetDungeon()
    if not TableIsNull(self.data.dungeon) then
        local perfectCount,normalCount = 0,0
        local length = #self.data.dungeon
        local dungeonData = nil
        for i = 1, #self.dungeon do
            if i > length then
                SetActive(self.dungeon[i].lock,false)
                SetActive(self.dungeon[i].normal,false)
                SetActive(self.dungeon[i].perfect,false)
            else
                dungeonData = DataMgr.Player.dungeonRecords[self.data.dungeon[i].eventParam]
                local challengeCount = ConfigAreaMgr.GetChallengeCountById(self.data.dungeon[i].eventParam)
                local completeCount = 0
                if challengeCount > 0 then
                    completeCount = PlayerAreaMgr.GetChallengeCompleteCountById(self.data.dungeon[i].eventParam)
                end
                local statusNum = 0
                if dungeonData == nil or IsNullOrEmpty(dungeonData.historyRating) then
                    statusNum = 3
                else
                    normalCount = normalCount + 1
                    if dungeonData.historyRating == "S" and challengeCount == completeCount then
                        statusNum = 1
                        perfectCount = perfectCount + 1
                    else
                        statusNum = 2
                    end
                end
                SetActive(self.dungeon[i].lock,statusNum == 3)
                SetActive(self.dungeon[i].normal,statusNum == 2)
                SetActive(self.dungeon[i].perfect,statusNum == 1)
            end
        end
        SetActive(self.perfect,perfectCount == length)
        SetActive(self.normal,perfectCount ~= length and normalCount == length)
    end
end

function BuildingItemModel:SetNum1()
    SetActive(self.select,true)
    self.num.sprite = LuaMgr.GetSprite("AbyssNumFont", "0"..self.data.index.."_1")
end

function BuildingItemModel:SetNum2()
    SetActive(self.select,false)
    self.num.sprite = LuaMgr.GetSprite("AbyssNumFont", "0"..self.data.index.."_2")
end

function BuildingItemModel:SetNum3()
    SetActive(self.select,false)
    self.num.sprite = LuaMgr.GetSprite("AbyssNumFont", "0"..self.data.index.."_3")
end

function BuildingItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function BuildingItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.dungeon = nil
    self.gameObject = nil
end
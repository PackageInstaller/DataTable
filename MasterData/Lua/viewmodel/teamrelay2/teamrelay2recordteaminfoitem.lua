require("ViewModel/TeamRelay2/TeamRelay2RecordHeadItem")
TeamRelay2RecordTeamInfoItem = {}

TeamRelay2RecordTeamInfoItem.__index = TeamRelay2RecordTeamInfoItem

local objs = {
    animGo = { path = "Group", type = UITool.GameObject },
    titleTxt = { path = "Group/Title/Text", type = UITool.Text },
    scoreTxt = { path = "Group/Score", type = UITool.Text },
    headContainer = { path = "Group/CharacterList", type = UITool.Transform },
}

function TeamRelay2RecordTeamInfoItem.New(obj, parent)
    local self = {}
    setmetatable(self, TeamRelay2RecordTeamInfoItem)
    self.gameObject = LuaMgr.InstantiateGO(obj, parent, false)
    self.transform = self.gameObject.transform;
    self:Init()
    return self
end

function TeamRelay2RecordTeamInfoItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.headItemList = {}
    SetActive(self.animGo, false)
end

function TeamRelay2RecordTeamInfoItem:SetData(pdata)
    self.data = pdata
    self.titleTxt.text = self.data.title
    self.scoreTxt.text = self.data.score
    local index = 1
    for i = 0, 5 do
        local characterId = self.data.members[tostring(i)]
        if characterId ~= nil then
            if not self.headItemList[index] then
                table.insert(self.headItemList, TeamRelay2RecordHeadItem.New(self.data.headItemTemplate, self.headContainer))
            end
            self.headItemList[index]:SetData(characterId)
            index = index + 1
        end
    end
    for i = index, #self.headItemList do
        self.headItemList[i]:Hide()
    end
    SetActive(self.animGo, self.data.animBool)
end

function TeamRelay2RecordTeamInfoItem:Clear()
    SetActive(self.animGo, false)
    for i, v in ipairs(self.headItemList) do
        v:Clear()
    end
    self.data = nil
end

function TeamRelay2RecordTeamInfoItem:Destroy()
    for i, v in ipairs(self.headItemList) do
        v:Destroy()
        LuaMgr.DestroyImmediateGO(v.gameObject)
    end
    self.headItemList = {}
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
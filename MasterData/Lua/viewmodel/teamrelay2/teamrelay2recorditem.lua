require("ViewModel/TeamRelay2/TeamRelay2RecordTeamInfoItem")

TeamRelay2RecordItem = {}

TeamRelay2RecordItem.__index = TeamRelay2RecordItem

local objs = {
    timeTxt = { path = "Group/Time", type = UITool.Text },
    scoreTxt = { path = "Group/Score", type = UITool.Text },
    teamInfoContainer = { path = "Group/TeamInfoList", type = UITool.Transform },
}

function TeamRelay2RecordItem.New()
    local self = {}
    setmetatable(self, TeamRelay2RecordItem)
    return self
end

function TeamRelay2RecordItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.teamInfoItemList = {}
end

function TeamRelay2RecordItem:SetData(pdata)
    self.data = pdata.data
    self.timeTxt.text = os.date(LuaMgr.GetLangText("TeamRelay2RecordItem_0"), self.data.timestamp)
    self.scoreTxt.text = self.data.totalScore
    for i, teamData in ipairs(self.data.teamInfos) do
        if self.teamInfoItemList[i] == nil then
            table.insert(self.teamInfoItemList, TeamRelay2RecordTeamInfoItem.New(self.data.teamItemTemplate, self.teamInfoContainer))
        end
        self.teamInfoItemList[i]:SetData(teamData)
    end
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine)
    end
    self.coroutine = coroutine_runner.start(function()
        for i = 1, 3 do
            self.teamInfoItemList[i].data.animBool = true
            SetActive(self.teamInfoItemList[i].animGo, true)
        end
        coroutine_runner.wait(0.1)
    end)
end

function TeamRelay2RecordItem:Clear()
    for i, v in ipairs(self.teamInfoItemList) do
        v:Clear()
    end
    if self.coroutine ~= nil then
        coroutine_runner.stop(self.coroutine)
    end
    self.data = nil
end

function TeamRelay2RecordItem:Destroy()
    for i, v in ipairs(self.teamInfoItemList) do
        v:Destroy()
        LuaMgr.DestroyImmediateGO(v.gameObject)
    end
    self.teamInfoItemList = {}
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
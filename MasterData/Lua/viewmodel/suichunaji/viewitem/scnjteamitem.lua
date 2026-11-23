require("ViewModel/SuiChuNaJi/ViewItem/SCNJTeamHeroItem")






SCNJTeamItem = {}
SCNJTeamItem.__index = SCNJTeamItem

local objs = {
    teamNum = {path = "Group/TeamNum", type = UITool.Text},
    damageCount = {path = "Group/DamageCount", type = UITool.Text},
    selectedFlag = {path = "Group/SelectedFlag", type = UITool.GameObject},
    button = {path = "Group", type = UITool.Button}
}

SCNJTeamItem.New = function()

    local self = {}
    setmetatable(self, SCNJTeamItem)
    return self
end

function SCNJTeamItem:Init()
    for i = 1, 6 do
        local heroHeadName = string.format("CharacterHead%d", i)
        local tempPath = string.format("Group/SelectHoreParent/%s", heroHeadName)
        objs[heroHeadName] = {path = tempPath, type = UITool.GameObject}
    end
    UITool.Parse(self.gameObject, self, objs)
    self.heroItemDic = {}
    for i = 1, 6 do
        local heroHeadName = string.format("CharacterHead%d", i)
        self.heroItemDic[heroHeadName] = SCNJTeamHeroItem.New(self[heroHeadName], nil, 0.85, nil, true)
    end

    self.onClickButton = function()
        if self.data.OnSelectTeam ~= nil then
            self.data.OnSelectTeam(self)
        end
    end
    LuaMgr.AddClick(self.button, self.onClickButton)
end

function SCNJTeamItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetItem()
    if self.data.IsSelected == true and self.data.OnSelectTeam ~= nil then
        self.data.OnSelectTeam(self)
    end
    self:SetSelected(self.data.IsSelected or false)
end

function SCNJTeamItem:SetItem()
    self.teamNum.text = self.data.TeamName
    self.damageCount.text = self.data.DamageCount
    self:SetHeroList()
end

function SCNJTeamItem:SetHeroList()
    local memberIDs, helps = SCNJData.GetLockMembersAndHelps(self.data.Id, self.data.StageIndex)
    local heroDataList = {}
    for i = 0, 5 do
        local heroData = {}
        heroData.heroID = memberIDs[tostring(i)]
        heroData.uid = helps[tostring(i)]
        if heroData.heroID ~= nil then
            if IsNullOrEmpty(heroData.uid) then
                heroData.characterData = DataMgr.Player.characters[heroData.heroID]
            else
                heroData.characterData = SCNJData.CheckHelpCharacterValid(heroData.uid, heroData.heroID)
            end
        end
        if heroData.characterData ~= nil then
            table.insert(heroDataList, heroData)
        end
    end
    for i = 1, 6 do
        local heroHeadName = string.format("CharacterHead%d", i)
        local heroData = heroDataList[i]
        local heroItem = self.heroItemDic[heroHeadName]
        if heroData == nil or heroData.characterData == nil then
            heroItem:SetData1()
        else
            heroItem:SetData1(heroData)
        end
    end
end

function SCNJTeamItem:SetSelected(isSelected)
    self.data.IsSelected = isSelected
    SetActive(self.selectedFlag, isSelected)
end

function SCNJTeamItem:ClearItems()
end

function SCNJTeamItem:Clear()
    self:ClearItems()
end

function SCNJTeamItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.data = nil
end
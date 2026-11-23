




BranchHeroItemModel = {}
BranchHeroItemModel.__index = BranchHeroItemModel
BranchHeroItemModel.heroIconPath = "Assets/_BundleResources/Images/BranchHero/branch_"
BranchHeroItemModel.c_barIconPath = "Assets/_BundleResources/Images/BranchHero/c_bar_"
BranchHeroItemModel.n_barIconPath = "Assets/_BundleResources/Images/BranchHero/n_bar_"

local objs = {
    clickBtn = {path = "Btn",type = "Button"},
    heroCover = {path = "Btn",type = "RawImage"},
    heroCover_1 = {path = "HeroCover_1",type = "RawImage"},
    bar_1 = {path = "Bar/Bar_1",type = "GameObject"},
    bar_1_img = {path = "Bar/Bar_1",type = "RawImage"},
    bar_2 = {path = "Bar/Bar_2",type = "GameObject"},
    bar_2_img = {path = "Bar/Bar_2",type = "RawImage"},
    bar_3 = {path = "Bar/Bar_3",type = "GameObject"},
    bar_3_img = {path = "Bar/Bar_3",type = "RawImage"},
    rewardIcon = {path = "Reward",type = "GameObject"},
    newIcon = {path = "New",type = "GameObject"},
    heroName = {path = "Name/NameText",type = "Text"},
    activityIcon = {path = "ActivityIcon",type = "Image"},
    activity = {path = "ActivityIcon",type = "GameObject"},
    n_barImg_1 = {path = "Bar/Bar_Img_1",type = "RawImage"},
    n_barImg_2 = {path = "Bar/Bar_Img_2",type = "RawImage"},
    n_barImg_3 = {path = "Bar/Bar_Img_3",type = "RawImage"},
}

function BranchHeroItemModel.New()
    local self = {}
    setmetatable(self, BranchHeroItemModel)
    return self
end

function BranchHeroItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        UnityEngine.PlayerPrefs.SetInt(self.data.ID, 1)

        HeroParameter.branchHeroItemClick = false
        HeroParameter.SavePanelType("branchprop",self.data.ID,self.data.page,self.data.before)
        LuaMgr.ShowLuaPanel(UIName.BranchHeroViewModel,self.data.ID,self.data.page,self.data.before)
    end
    LuaMgr.AddClick(self.clickBtn,self.clickCommand)
end

function BranchHeroItemModel:SetData(data)
    self.data = data.data.data
    self.heroCover.texture = LuaMgr.GetTexture(self.heroIconPath..self.data.page..".png")
    self.heroCover_1.texture = LuaMgr.GetTexture(self.heroIconPath..self.data.page.."_1.png")

    local n_bar_img = LuaMgr.GetTexture(self.n_barIconPath..self.data.page.."_1.png")
    local c_bar_img = LuaMgr.GetTexture(self.c_barIconPath..self.data.page.."_1.png")
    self.n_barImg_1.texture = n_bar_img
    self.bar_1_img.texture = c_bar_img

    n_bar_img = LuaMgr.GetTexture(self.n_barIconPath..self.data.page.."_2.png")
    c_bar_img = LuaMgr.GetTexture(self.c_barIconPath..self.data.page.."_2.png")
    self.n_barImg_2.texture = n_bar_img
    self.bar_2_img.texture = c_bar_img

    n_bar_img = LuaMgr.GetTexture(self.n_barIconPath..self.data.page.."_3.png")
    c_bar_img = LuaMgr.GetTexture(self.c_barIconPath..self.data.page.."_3.png")
    self.n_barImg_3.texture = n_bar_img
    self.bar_3_img.texture = c_bar_img
    
    local barList = self:GetHeroBranchBar()
    SetActive(self.bar_1,barList[1])
    SetActive(self.bar_2,barList[2])
    SetActive(self.bar_3,barList[3])
    local redPoint = UnityEngine.PlayerPrefs.HasKey(self.data.ID)
    SetActive(self.newIcon,not redPoint)
    SetActive(self.rewardIcon,redPoint and self:RewardEffect())
    self.heroName.text = LuaMgr.GetLangText(ConfigMgr.Config.characterTable[self.data.page].namelan)

    if self.data.type ~= nil and self.data.type == 4 then
        self.activityIcon.sprite = LuaMgr.GetSprite("BranchHeroActivityIcon","activityIcon_"..self.data.page)
    end
    SetActive(self.activity,self.data.type ~= nil and self.data.type == 4)
    self.gameObject:SetActive(true)
end

function BranchHeroItemModel:GetHeroBranchBar()
    local barList = {}
    local tempList = {}
    for i = 1, #ConfigMgr.Config.branchEventList do
        if ConfigMgr.Config.branchEventList[i].storyID == self.data.ID and 
                ConfigMgr.Config.branchEventList[i].type == "1" then
            table.insert(tempList,ConfigMgr.Config.branchEventList[i])
        end
    end
    local tempData = DataMgr.Player.branch.children["Reg1001"].children[self.data.ID].children
    if TableIsNull(tempData) then
        for i = 1, #tempList do
            table.insert(barList,false)
        end
    else
        for i = 1, #tempList do
            table.insert(barList,tempData[tempList[i].ID].completed)
        end
    end
    tempList = nil
    return barList
end

function BranchHeroItemModel:RewardEffect()
    local groupId = ActivityMgr.groupKeyList["Story1"]
    local activityData = DataMgr.Player.variables[groupId]
    if activityData == nil then return false end
    local time = activityData.expireTime - LuaMgr.Timestamp()
    if time <= 0 then return false end
    local typeId = tonumber(string.sub(groupId,7))
    local questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(typeId)
    local tempData = nil
    for i = 1, #questEvents do
        if questEvents[i].text == self.data.ID then
            tempData = DataMgr.Player.quests[questEvents[i].id]
            if tempData.state == 2 and questEvents[i].progress == tempData.progress then
                return true
            end
        end
    end
end

function BranchHeroItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function BranchHeroItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
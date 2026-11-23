





ComeBackMissionItem = {}

ComeBackMissionItem.__index = ComeBackMissionItem
ComeBackMissionItem.countFormat = "<color=#715f49>/%d</color>"
local objs = {
    normal = {path = "Normal",type = "GameObject"},
    normalText = {path = "Normal/Text",type = "Text"},
    gotoBut = {path = "Normal/GoBtn",type = "Button"},
    countText = {path = "Normal/GoBtn/CountText",type = "Text"},
    barValue = {path = "Normal/GoBtn/Bar/Image",type = "Image"},
    
    canGet = {path = "CanGet",type = "GameObject"},
    canGetText = {path = "CanGet/Text",type = "Text"},
    getBtn = {path = "CanGet/GetBtn",type = "Button"},


    completeMask = {path = "CompleteMask",type = "GameObject"},
    complete = {path = "Complete",type = "GameObject"},
    completeText = {path = "Complete/Text",type = "Text"},

    
rewardRoot = {path = "RewardList",type = "RectTransform"}
}

function ComeBackMissionItem.New()
    local self = {}
    setmetatable(self, ComeBackMissionItem)
    return self
end

function ComeBackMissionItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        if not DataExHelper.Check_ComeBackActivity() then
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("7023"))
            return
        end
        DataExHelper.EX_ComeBackComplete(self.data.id,self.tab,function()
            LuaMgr.InvokeUIEventListeners(UIEventConst.ComeBackMissionGetReward)
        end)
    end
    self.gotoCommand = function()
        if not IsNullOrEmpty(self.config.pageSkip) then
            HeroParameter.SaveComeBackParam("Mission",self.tabNum)
            local panel = FeatureManager.GetPanelInfo(self.config.pageSkip)
            if panel.tab == "" then
                FeatureManager.GotoPanel(panel.id)
            else
                FeatureManager.GotoPanel(panel.id,panel.tab)
            end
        end
    end
    LuaMgr.AddClick(self.getBtn,self.getCommand)
    LuaMgr.AddClick(self.gotoBut,self.gotoCommand)
    SetActive(self.animatorObj,false)
end

function ComeBackMissionItem:SetData(data)
    self.data = data.data.data
    self.tab = data.data.tab
    self.tabNum = data.data.tabNum
    self.config = ConfigMgr.Config.BackPlayerTaskMap[self.data.id]
    local missionIntro = LuaMgr.GetLangText(self.config.NameLan)
    self.normalText.text = missionIntro
    self.canGetText.text = missionIntro
    self.completeText.text = missionIntro
    local targetCount = MissionHelper.GetTargetCount(self.data.id)
    SetActive(self.normal,not self.data.completed and self.data.current < targetCount)
    SetActive(self.canGet,not self.data.completed and self.data.current >= targetCount)
    SetActive(self.complete,self.data.completed)
    SetActive(self.completeMask,self.data.completed)
    self.countText.text = LuaMgr.NumFormat(self.data.current)..string.format(self.countFormat,LuaMgr.NumFormat(targetCount))
    self.barValue.fillAmount = self.data.current / targetCount
    local anchoredPosition = self.transform.anchoredPosition
    self.transform.anchoredPosition = Vector2(anchoredPosition.x - 35,anchoredPosition.y)
    self:SetReward()
    self.gameObject:SetActive(true)
end

function ComeBackMissionItem:SetReward()
    if TableIsNull(self.config.rewards) then
        return
    end
    if TableIsNull(self.rewardList) then
        self.rewardList = {}
    end
    local itemConfig = nil
    local index = 1
    for i = 1, #self.config.rewards do
        if self.config.rewards[i].itemId ~= ConfigMgr.Config.constants.BackPlayerItems[1] then
            itemConfig = table.Copy(ConfigMgr.Config.itemMap[self.config.rewards[i].itemId])
            if TableIsNull(itemConfig) then return end
            if #self.rewardList < index then
                table.insert(self.rewardList,GoodsDataItem.New(self.rewardRoot))
            end
            itemConfig["count0"] = self.config.rewards[i].count
            self.rewardList[index]:SetData(index,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
            index = index + 1
        end
    end
    for i = #self.config.rewards, #self.rewardList do
        self.rewardList[i]:Hide()
    end
end

function ComeBackMissionItem:Clear()
    self.data = nil
    self.tab = nil
    self.config = nil
    self.tabNum = nil
    self.gameObject:SetActive(false)
end

function ComeBackMissionItem:Destroy()
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.getCommand)
        self.getCommand = nil
    end
    if (self.gotoCommand ~= nil) then
        LuaMgr.RemoveClick(self.gotoBut, self.gotoCommand)
        self.gotoCommand = nil
    end
    if not TableIsNull(self.rewardList) then
        for i = 1, #self.rewardList do
            self.rewardList[i]:Clear()
        end
        self.rewardList = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
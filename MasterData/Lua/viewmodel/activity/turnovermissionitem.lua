





TurnOverMissionItem = {}

TurnOverMissionItem.__index = TurnOverMissionItem
local objs = {
    normal = {path = "Normal",type = "GameObject"},
    gotoBtn = {path = "Normal/Btn",type = "Button"},
    gotoText = {path = "Normal/Btn/Text",type = "Text"},
    missionText_n = {path = "Normal/MissionText",type = "Text"},
    numText_n = {path = "Normal/NumText",type = "Text"},
    
    canGet = {path = "CanGet",type = "GameObject"},
    getBtn = {path = "CanGet/Btn",type = "Button"},
    getText = {path = "CanGet/Btn/Text",type = "Text"},
    missionText_c = {path = "CanGet/MissionText",type = "Text"},
    numText_c = {path = "CanGet/NumText",type = "Text"},

    alreadyGet = {path = "AlreadyGet",type = "GameObject"},
    alreadyText = {path = "AlreadyGet/Image/Text",type = "Text"},
    missionText_a = {path = "AlreadyGet/MissionText",type = "Text"},
    numText_a = {path = "AlreadyGet/NumText",type = "Text"},

    rewardRoot = {path = "Reward",type = "RectTransform"},
    rewardGroup = {path = "Reward",type = "CanvasGroup"},
}

function TurnOverMissionItem.New()
    local self = {}
    setmetatable(self, TurnOverMissionItem)
    return self
end

function TurnOverMissionItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        if self.getRewardCallBack ~= nil and self.data.state == 2 then
            self.getRewardCallBack()
        end
    end
    self.gotoCommand = function()
        if self.gotoPanelCallBack ~= nil then
            self.gotoPanelCallBack(self.config)
        end
    end
    LuaMgr.AddClick(self.getBtn,self.getCommand)
    LuaMgr.AddClick(self.gotoBtn,self.gotoCommand)
end

function TurnOverMissionItem:SetData(data)
    self.config = data.data.config
    self.data = data.data.data
    self.getRewardCallBack = data.data.getReward
    self.gotoPanelCallBack = data.data.gotoPanel
    if self.data.state == 1 then
        self.gotoText.text = ConfigMgr.LangGlobal("15502")
        self.missionText_n.text = LuaMgr.GetLangText(self.config.remarksLan)
        self.numText_n.text = "（<color=#DD4D4E>"..self.data.progress.."</color>/"..self.config.progress..LuaMgr.GetLangText("TurnOverMissionItem_0")
    elseif self.data.state == 2 then
        self.getText.text = ConfigMgr.LangGlobal("15009")
        self.missionText_c.text = LuaMgr.GetLangText(self.config.remarksLan)
        self.numText_c.text = LuaMgr.GetLangText("TurnOverMissionItem_1")..self.data.progress.."/"..self.config.progress..LuaMgr.GetLangText("TurnOverMissionItem_2")
    else
        self.alreadyText.text = ConfigMgr.LangGlobal("15705")
        self.missionText_a.text = LuaMgr.GetLangText(self.config.remarksLan)
        self.numText_a.text = LuaMgr.GetLangText("TurnOverMissionItem_3")..self.data.progress.."/"..self.config.progress..LuaMgr.GetLangText("TurnOverMissionItem_4")
    end
    SetActive(self.normal,self.data.state == 1)
    SetActive(self.canGet,self.data.state == 2)
    SetActive(self.alreadyGet,self.data.state == 3)
    self:SetReward()
    self.gameObject:SetActive(true)
end

function TurnOverMissionItem:SetReward()
    if TableIsNull(self.config.reward) then
        return
    end
    if TableIsNull(self.rewardList) then
        self.rewardList = {}
    end
    local itemConfig = nil
    for i = 1, #self.config.reward do
        if #self.rewardList < i then
            table.insert(self.rewardList,GoodsDataItem.New(self.rewardRoot))
        end
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[self.config.reward[i].id])
        itemConfig["count0"] = self.config.reward[i].count
        self.rewardList[i]:SetData(i,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
    end
    for i = #self.config.reward + 1, #self.rewardList do
        self.rewardList[i]:Hide()
    end
    itemConfig = nil
end

function TurnOverMissionItem:Clear()
    self.data = nil
    self.config = nil
    self.getRewardCallBack = nil
    self.gotoPanelCallBack = nil
    self.gameObject:SetActive(false)
end

function TurnOverMissionItem:Destroy()
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.getCommand)
        self.getCommand = nil
    end
    if (self.gotoCommand ~= nil) then
        LuaMgr.RemoveClick(self.gotoBtn, self.gotoCommand)
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
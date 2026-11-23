require("ViewModel/Draw/GiftCharacterTaskNewItem")
GiftCharacterCommonPopupItem = {}

GiftCharacterCommonPopupItem.__index = GiftCharacterCommonPopupItem
local objs = {
    rectTransform = {path = "root", type = "RectTransform"},
    taskItemTemplateGo = {path = "template/TaskItem",type = "GameObject"},
    scrollViewGo = {path = "root/Middle/TaskList/Scroll View",type = "GameObject"},
    totalProgressStr = {path = "root/Middle/TaskList/Progress/Text",type = "Text"},
    totalProgressSlider = {path = "root/Middle/TaskList/Progress/Slider",type = "Slider"},
    progressTipsStr = {path = "root/Middle/TaskList/Progress/tips",type = "Text"},
    tipsStr = {path = "root/Middle/TaskList/Tips/text",type = "Text"},
    maskBtn = {path = "root/Mask", type = "Button"}
}

local this = {
    taskList = { {
         nameStr = "",
         showReward = { id = "1", count = tostring(0), isCount = true, sizeDelta = Vector2(0, 0), rare = DefaultSprite, icon = DefaultTexture, scale = Vector3(0, 0, 0), isClick = true },
         dynamicAvatarId = "",
         isCanGet = false,
         isFinish = false,
         isProgress = false
     } },
    
    scrollView = nil,
    characterId = nil,
    curCardPoolId = "",
    redId = "",
    tipsType = "",
    panelName = "",
}

function GiftCharacterCommonPopupItem.New()
    local self = {}
    setmetatable(self, GiftCharacterCommonPopupItem)
    return self
end

function GiftCharacterCommonPopupItem:Init()
UITool.Parse(self.gameObject, self, objs)
    
    this.scrollView = UIScrollView.New(self.scrollViewGo)

    self.MaskCommand = function()
if self.maskBtn ~= nil then
            LuaMgr.HidePanel(UIName.GiftCharacterCommonPopup);
        end
    end

    LuaMgr.AddClick(self.maskBtn,self.MaskCommand);
end

function GiftCharacterCommonPopupItem:SetData(data)
    self.data = data

    this.curCardPoolId = self.data.curCardPoolId
    this.characterId = ConfigMgr.Config.cardPools[this.curCardPoolId].characterShow[1]
    this.redId = self.data.redId
    this.tipsType = self.data.tipsType
    this.panelName = self.data.panelName
    self:SetTaskList()
end

function GiftCharacterCommonPopupItem:Clear()
    this.scrollView:Clear(true)
    UIScrollView.ClearItem("GiftCharacterTaskNewItem")
    self.data = nil
end

function GiftCharacterCommonPopupItem:SetTaskList()
    local characterId = this.characterId
    local cfgCharacter = ConfigMgr.Config.characterTable[characterId]
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByGroupId(self.data.id);
    table.sort(cfgCheckInQuest, function(a, b)
        return tonumber(a.id) < tonumber(b.id);
    end)

    self.OnGetTaskReward = function(pId)
        local askData = { questId = pId }
        ApiMgr.Request("ex/get_award", askData, true, function(result)
            local re = json.decode(result)
            local data = json.encode(re.result)
            LuaMgr.ShowItemRewared(data)
            self:SetTaskList()
            LuaMgr.InvokeUIEventListeners(UIEventConst.GiftCharacterGetReward)
        end, nil, true)
    end

    self.OnShowTaskRewardPreview = function(pIndex)



    end
    
    local allCanGetTaskCount = 0
    local tempTaskList = {}
    for i, cfg in ipairs(cfgCheckInQuest) do
        local tempData = DataMgr.Player.quests[cfg.id]
        local progressValue = 0
        if tempData ~= nil then
            progressValue = tempData.progress
        end
        local state = DataExHelper.Check_RewardState(cfg.id)
        local taskData = {
            id = cfg.id,
            nameStr = string.format("%s*%s", LuaMgr.GetLangText(cfgCharacter.namelan), cfg.progress),
            isProgress = state == 1,
            isCanGet = state == 2,
            isFinish = state == 3,
            target = cfg.progress,
            progress = progressValue,

            OnClickArea = self.OnShowTaskRewardPreview,

            OnClickGetBtn = self.OnGetTaskReward,
            hide = true,
        }
        if cfg.eventType == 801 then
            allCanGetTaskCount = taskData.isCanGet and allCanGetTaskCount + 1 or allCanGetTaskCount
            taskData.dynamicAvatarId = self:GetItemDynamicAvatarID(cfg.showReward[1].id)
            taskData.showReward = cfg.showReward
            table.insert(tempTaskList, taskData)
        elseif cfg.eventType == 808 then
            local cardPoolCfg = ConfigMgr.Config.cardPools[this.curCardPoolId]
            self.totalProgressStr.text = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26680"),
                    LuaMgr.GetLangText(cardPoolCfg.nameLan), progressValue, cfg.progress)
            self.totalProgressSlider.value = progressValue / cfg.progress
        end
    end
    table.sort(tempTaskList, function(a, b)
        if a.isFinish == b.isFinish then
            if a.isCanGet == b.isCanGet then
                return tonumber(a.id) < tonumber(b.id)
            else
                return a.isCanGet
            end
        else
            return not a.isFinish
        end
    end)
    this.taskList = tempTaskList

    local groupData
    local scrollData
    this.scrollView:Clear(false)
    local scrollDatas = {}
    for i, v in ipairs(this.taskList) do
        groupData = v
        groupData.index = i
        scrollData = UIScrollData.GetData(self.taskItemTemplateGo, "GiftCharacterTaskNewItem", 520, 80, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(520, 300)
    this.scrollView:SetData(scrollDatas, true)

    local index = this.scrollView:GetIndex()
    LuaMgr.AddTimer(TimerConst.LimitCharacterTaskShowTimer, function()
        if this.scrollView.itemMap[index] ~= nil then
            this.scrollView.itemMap[index]:PlayAnim("ActivityLimitCharacterTaskItem")
        end
        if this.scrollView.dataList[index] ~= nil then
            this.scrollView.dataList[index].data.hide = false
        end
        index = index + 1
        if index > #this.scrollView.dataList then
            LuaMgr.RemoveTimer(TimerConst.LimitCharacterTaskShowTimer)
        end
    end, 0.05, -1, true)
    RedMgr.Singleton:UpdateClientRedData(this.redId, allCanGetTaskCount)
    self.progressTipsStr.text = ConfigMgr.LangGlobal("25701");
    if(this.tipsType == "zztd") then
        self.tipsStr.text = ConfigMgr.LangGlobal("26526");
    else
        self.tipsStr.text = ConfigMgr.LangGlobal("25702");
    end
end

function GiftCharacterCommonPopupItem:GetItemDynamicAvatarID(pItemId)
    local rewardItemCfg = ConfigHelper.GetItemById(pItemId)
    if rewardItemCfg.type ~= 13 then

        return ""
    end
    if nil ~= ConfigMgr.Config.avatarFrames then
        for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
            if v.type == 1 and v.imgType == 2 and v.unlockType == 2 and v.unlock == pItemId then
                return v.id
            end
        end
    end
    return ""
end

function GiftCharacterCommonPopupItem:Destroy()
    if self.data ~= nil then
        if self.data.MaskCommand ~= nil then
            LuaMgr.RemoveClick(self.maskBtn, self.data.MaskCommand)
        end
    end
    
    LuaMgr.RemovePrefabRefCount(self.path);
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
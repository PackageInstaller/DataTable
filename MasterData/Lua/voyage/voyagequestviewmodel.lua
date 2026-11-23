require("Voyage/VoyageQuestItem")

local this = {
    scrollView = nil,
    questProgress = {0, 0.065, 0.253, 0.44, 0.628, 0.811, 1},
    questList = nil,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    tips = { path = "root/Left/Quest/Tips", type = "Text" },
    progressBar = { path = "root/Left/Quest/Progress/Bar", type = "Image" },
    progress2Bar = { path = "root/Left/Quest/Progress2/Bar", type = "Image" },
    progress2Text = { path = "root/Left/Quest/Progress2/Text", type = "Text" },
    scrollViewGO = { path = "root/Left/Quest/ScrollView", type = "GameObject" },
    questItem = { path = "template/QuestItem", type = "GameObject" },
    receiveAllGO = { path = "root/Left/Quest/ReceiveAll", type = "GameObject" },
    receiveAllBtn = { path = "root/Left/Quest/ReceiveAll", type = "Button" },
    spineCharacter = { path = "root/Middle/Body/Character", type = "UISpineCharacter" },
    drawingAdjustTool = { path = "root/Middle/Body/Character", type = "DrawingAdjustTool" },
};


this.SetData = function()
    this.tips.text = ConfigMgr.LangGlobal("10466");
    this.SetQuests();
    this.SetProgress();
    this.SetProgress2();
    this.SetCharacter();
end


this.OnBack = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
end


this.SetQuests = function()
    this.scrollView:Clear(false);
    this.questList = ConfigVoyageMgr.GetQuestList();
    local questConfig;
    local questData;
    local scrollData;
    local isReceive = false;
    local scrollDatas = {};
    local questMap = {};
    local len = #this.questList;
    for i = 1, len do
        questConfig = this.questList[i];
        questData = PlayerVoyageMgr.GetQuestData(questConfig.QuestID);
        if (questData ~= nil and questData.Status == 1) then
            scrollData = UIScrollData.GetData(this.questItem, "VoyageQuestItem", 713, 79, questConfig);
            table.insert(scrollDatas, scrollData);
            questMap[questConfig.QuestID] = true;
            isReceive = true;
        end
    end
    for i = 1, len do
        questConfig = this.questList[i];
        if (not questMap[questConfig.QuestID]) then
            questData = PlayerVoyageMgr.GetQuestData(questConfig.QuestID);
            if (questData ~= nil and questData.Status == 0) then
                scrollData = UIScrollData.GetData(this.questItem, "VoyageQuestItem", 713, 79, questConfig);
                table.insert(scrollDatas, scrollData);
                questMap[questConfig.QuestID] = true;
            end
        end
    end
    for i = 1, len do
        questConfig = this.questList[i];
        if (not questMap[questConfig.QuestID]) then
            scrollData = UIScrollData.GetData(this.questItem, "VoyageQuestItem", 713, 79, questConfig);
            table.insert(scrollDatas, scrollData);
        end
    end
    this.scrollView:SetParams(713, 362);
    this.scrollView:SetPadding(0, 0, 0, -60);
    this.scrollView:SetData(scrollDatas, true);
    SetActive(this.receiveAllGO, isReceive);
end


this.SetProgress = function()
    local questConfig;
    local questData;
    local count = 1;
    local len = #this.questList;
    for i = 1, len do
        questConfig = this.questList[i];
        if (questConfig.HarborID ~= "") then
            questData = PlayerVoyageMgr.GetQuestData(questConfig.QuestID);
            if (questData ~= nil and questData.Status ~= 0 and questData.Status ~= 1) then
                count = count + 1;
            end
        end
    end
    this.progressBar.fillAmount = this.questProgress[count];
end


this.SetProgress2 = function()
    local questConfig;
    local questData;
    local count = 0;
    local len = #this.questList;
    for i = 1, len do
        questConfig = this.questList[i];
        questData = PlayerVoyageMgr.GetQuestData(questConfig.QuestID);
        if (questData ~= nil and questData.Status ~= 0 and questData.Status ~= 1) then
            count = count + 1;
        end
    end
    this.progress2Bar.fillAmount = count / len;
    this.progress2Text.text = string.format("%d/%d", count, len);
end


this.SetCharacter = function()
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, "A0156", "A0156002");
    if (path ~= "") then
        this.drawingAdjustTool.Sprite = path;
    end
end


this.OnClickReceiveAll = function()
    PlayerVoyageMgr.GetQuestionReward(nil, this.GetQuestionRewardResponse);
end


this.OnQuestReceive = function(args)
    local questId = args[0];
    PlayerVoyageMgr.GetQuestionReward(questId, this.GetQuestionRewardResponse);
end


this.GetQuestionRewardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        this.SetData();
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.receiveAllBtn, this.OnClickReceiveAll);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageQuestReceive, this.OnQuestReceive);
        this.SetData();
        this.animator.AnimationName = "UI_VoyageQuestPanel_01";
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageQuestReceive, this.OnQuestReceive);
        this.scrollView:Clear(true);
        if (this.spineCharacter ~= nil) then
            this.spineCharacter:Clear();
        end
        this.drawingAdjustTool.Sprite = nil;
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.receiveAllBtn, this.OnClickReceiveAll);
        UIScrollView.ClearItem("VoyageQuestItem");
        this.spineCharacter = nil;
        this.drawingAdjustTool = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
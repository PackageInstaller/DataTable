
local tarGameObject = nil;
local tarRect = nil;
local UICollectorEventOptionItemPrefab = nil;
local root = nil;
local goOptionList = nil;
local rawImageCharacter = nil;
local rawImageLeftBG = nil;
local animatorDice = nil;
local textTitle = nil;
local textIntroduce = nil;
local btnClose = nil;
local goEffect = nil;
local LeftImage = nil;
local goTipsList = nil;
local goOptionTips1 = nil;
local textOptionTips1 = nil;
local goOptionTips2 = nil;
local textOptionTips2 = nil;
local btnBGMask=nil;
local goClickMask=nil;
require("CollectorPractice/Common/UICollectorEventOptionItem")
local EventData = 14
local EventId = 0
local ParamThemeId = nil;
local UseItem = false;
local eventconfig = nil;
local optionList = nil;
local eventPanelData = nil;
local nowOptionList = {};
local specialList = {};
local clickLimit = false;
local forceOpen = false;
local optionState = 0;
local optionTipsText = "";
local tipsAnimator=nil;
local this = {
    vm = nil,
}
local data = {
}
local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour.gameObject);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            ParamThemeId = vm.behaviour.Params[0]
            EventData = vm.behaviour.Params[1]
            EventId = vm.behaviour.Params[2]
if vm.behaviour.Params.Length > 3 then
                UseItem = vm.behaviour.Params[3]
            end
if vm.behaviour.Params.Length > 4 then
                forceOpen = vm.behaviour.Params[4]
            end

            this.InitData();
            this.InitTrammeChildPanellList();
SetActive(goClickMask,false);
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if forceOpen then
                CollectorPracticeMainSceneViewModel.succssfulfun();
            end
            forceOpen=false
            SetActive(goTipsList, false);
            SetActive(goOptionTips1, false);
            SetActive(goOptionTips2, false);
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end
}

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UICollectorEventOptionItemPrefab = uiLink:Get("UICollectorEventOptionItem");
    root = uiLink:Get("root");
    goOptionList = uiLink:Get("goOptionList");
    rawImageCharacter = uiLink:Get("rawImageCharacter"):GetComponent("RawImage");
    rawImageLeftBG = uiLink:Get("rawImageLeftBG"):GetComponent("RawImage");
    animatorDice = uiLink:Get("animatorDice"):GetComponent("Animator");
    textTitle = uiLink:Get("textTitle"):GetComponent("Text");
    textIntroduce = uiLink:Get("textIntroduce"):GetComponent("Text");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    goEffect = uiLink:Get("goEffect");
    LeftImage = uiLink:Get("LeftImage");
    goTipsList = uiLink:Get("goTipsList");
    goOptionTips1 = uiLink:Get("goOptionTips1");
    textOptionTips1 = uiLink:Get("textOptionTips1"):GetComponent("Text");
    goOptionTips2 = uiLink:Get("goOptionTips2");
    textOptionTips2 = uiLink:Get("textOptionTips2"):GetComponent("Text");
    goClickMask=uiLink:Get("goClickMask");
    tipsAnimator=uiLink:Get("goTipsList"):GetComponent("Animator");
    uiLink:AddClickEvent("btnClose", function()
        LuaMgr.HidePanel(UIName.CollectorPracticeMapEventViewModel)
    end)
    uiLink:AddClickEvent("btnBGMask",function ()
        SetActive(goTipsList, false);
        SetActive(goOptionTips1, false);
        SetActive(goOptionTips2, false);
    end)
end


this.Clear = function()
    for i = 1, #nowOptionList do
        nowOptionList[i]:Destroy();
    end
    tarGameObject = nil
    tarRect = nil
    UICollectorEventOptionItemPrefab = nil;
    root = nil;
    goOptionList = nil;
    rawImageCharacter = nil;
    rawImageLeftBG = nil;
    animatorDice = nil;
    animatorDice = nil;
    textTitle = nil;
    textIntroduce = nil;
    btnClose = nil;
    goEffect = nil;
    LeftImage = nil;
    goTipsList = nil;
    goOptionTips1 = nil;
    textOptionTips1 = nil;
    goOptionTips2 = nil;
    textOptionTips2 = nil;
    goClickMask=nil;
    btnBGMask=nil;
    EventData = 14
    EventId = 0
    ParamThemeId = nil;
    UseItem = false;
    eventconfig = nil;
eventPanelData = nil;
nowOptionList = {};
end

this.InitData = function()
    eventconfig = ConfigMgr.Config.EventStoryMap
    optionList = ConfigMgr.Config.EventOptionMap
    local eventMapData = ""
clickLimit = false;
if ConfigMgr.Config.EventStoryMap[EventId] ~= nil and ConfigMgr.Config.EventStoryMap[EventId].EventPic ~= "" then
        eventMapData = ConfigMgr.Config.EventStoryMap[EventId].EventPic
    else
        eventMapData = ConfigMgr.Config.InternEventKV[EventId].EventPic
    end
    this.SetLeftImage(eventMapData);
end

this.InitTrammeChildPanellList = function()
    local stageData = DataMgr.Player.studyEvent.curEvent

    eventPanelData = eventconfig[stageData]
    if eventPanelData ~= nil then
        textTitle.text = LuaMgr.GetLangText(eventPanelData.EventTitleLan)
        textIntroduce.text = LuaMgr.GetLangText(eventPanelData.EventDesLan)
    end


    local eventList = eventPanelData ~= nil and eventPanelData.EventOption or {}
    local eventMapItemListData = {}
    for key, value in ipairs(eventList) do
        if optionList[value] ~= nil then
            table.insert(eventMapItemListData, optionList[value])
        end
    end
    this.InitEventMapList(eventMapItemListData)

end


this.RefusheventById = function(tabId)
    local eventList = eventPanelData ~= nil and eventPanelData.EventOption
    local eventMapItemListData = {}
    if eventconfig[tabId] ~= nil and eventconfig[tabId].EventOption ~= nil then
        for key, value in ipairs(eventconfig[tabId].EventOption) do
            if optionList[value] ~= nil then
                table.insert(eventMapItemListData, optionList[value])
            end
        end
    end
    this.InitEventMapList(eventMapItemListData)
end


this.NetDataSuccssful = function(OptionId)
    clickLimit = true;
    local data = { ThemeId = ParamThemeId, EventType = EventData, Optional = OptionId, UseItem = UseItem,Win=(optionList[OptionId].TipsType==1) }
    local Url = "practice/choose_event_story"
    ApiMgr.Request(Url, data, true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                optionState = optionList[OptionId].TipsType;
                CollectorPracticeMgr.FinishTipsState = optionList[OptionId].TipsType;
                optionTipsText = LuaMgr.GetLangText(optionList[OptionId].OptionTipsLan)
                CollectorPracticeMgr.FinishTips = LuaMgr.GetLangText(optionList[OptionId].EventTipsLan)
                clickLimit = false;
                local stageData = re.result.CurEvent
if stageData ~= nil and stageData ~= "" then
if eventconfig[stageData].EventDesLan ~= nil and eventconfig[stageData].EventDesLan ~= "" then
                        textTitle.text = LuaMgr.GetLangText(eventconfig[stageData].EventTitleLan)
                        textIntroduce.text = LuaMgr.GetLangText(eventconfig[stageData].EventDesLan)
                    end
this.RefusheventById(stageData)
                    this.ShowTips();
                else
                    local rewardTab = {}

                    if re.result.OtherReward ~= nil and type(re.result.OtherReward) == "table" then
                        for key, value in pairs(re.result.OtherReward) do
                            local otherReward = { special = true, id = key, count = value }
                            table.insert(rewardTab, otherReward)
                            local item =ConfigMgr.Config.itemMap[key];
                            if item~=nil and item.type==23 then

                                table.insert(CollectorPracticeMgr.OtherReward,otherReward);
                            end
                        end
                        LuaMgr.NextFrame(function()
                            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorBagToolRefush);
                        end)
                    end

if re.result.Reward ~= nil and type(re.result.Reward.Items) == "table" then
for index, value in pairs(re.result.Reward.Items) do
                            table.insert(rewardTab, value)
                            local item = ConfigMgr.Config.itemMap[value.id];
if item ~= nil and(item.type == 20 or item.type==25 or item.type==26) then

                                table.insert(CollectorPracticeMgr.RewardTab, value);
                            end
                        end
LuaMgr.NextFrame(function()
                            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorBagToolRefush);
                        end)
                    end
                    LuaMgr.HidePanel(UIName.CollectorPracticeMapEventViewModel)
                end
            end
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        true
    )
end

this.InitEventMapList = function(tab)
    for i = 1, #nowOptionList, 1 do
        nowOptionList[i]:Hide();
end
    local index = 1;
    for i, value in ipairs(tab) do
if value.OptionRoll == "1_0" then
specialList[1] = value.OptionId
            goto continue;
        elseif value.OptionRoll == "1_1" then
specialList[2] = value.OptionId
        end
local costNum = 0
local showToolcost = false
if value.ToolCost ~= nil and type(value.ToolCost) == "table" then
            costNum = this.GetCostTool(value.ToolCost[1].id)
            showToolcost = true
        end
        local temp = nil;
        if nowOptionList[index] == nil then
            temp = UICollectorEventOptionItem.New(UICollectorEventOptionItemPrefab,
                goOptionList:GetComponent("RectTransform"));
        else
            temp = nowOptionList[index];
        end
        temp:SetData(value.OptionId,
            showToolcost and costNum == 0,
            value.OptionRoll ~= "",
            LuaMgr.GetLangText(value.OptionDesLan),
            LuaMgr.GetLangText(value.OptionDes2Lan),
            function(self)
                this.ClickFun(self)
            end
        );
        nowOptionList[index] = temp;
        index = index + 1;
        if value.OptionRoll ~= "" then
            temp.transform:SetAsFirstSibling();
        end
        ::continue::
    end
end

this.GetCostTool = function(id)
    return (DataMgr.Player.practicesStage.tools[id]~=nil and DataMgr.Player.practicesStage.tools[id] or 0)
end

this.ClickFun = function(self)
    if clickLimit then
        return;
    end
    if self.id == specialList[2] then
        local timeData = { 2.5, 3 }
        local special = math.random(1, 2)
        SetActive(goEffect, true);
        SetActive(goClickMask,true);
        animatorDice:Play("CollectorPractice_shaizi_0" .. special, 0, 0);
        local time = timeData[special]
        local selectItem = specialList[special]
        local refushData = function()
            this.NetDataSuccssful(selectItem)
        end
        this.updateCortinue = coroutine_runner.start(function()
            coroutine_runner.wait(time)
            SetActive(goEffect, false);
            SetActive(goClickMask,false);
            refushData()
        end)
    else
        this.NetDataSuccssful(self.id)
    end
end

this.SetLeftImage = function(eventMapData)
if eventMapData == "" then
        SetActive(rawImageCharacter.gameObject, false);
        SetActive(LeftImage, true);
        rawImageLeftBG.texture = LuaMgr.GetTexture(string.format(
            "Assets/_BundleResources/Images/CollectorEventBg/%s.png"
            , "ui_sx_dt_dad3"))
    end
    local TextureName = eventMapData ~= "" and eventMapData or "ui_sx_dt_dad3"
if string.starts(TextureName, "ui") then
        SetActive(rawImageCharacter.gameObject, false);
        SetActive(LeftImage, true);
        rawImageLeftBG.texture = LuaMgr.GetTexture(string.format(
            "Assets/_BundleResources/Images/CollectorEventBg/%s.png"
            , TextureName))
else
        SetActive(rawImageCharacter.gameObject, true);
        SetActive(LeftImage, false);
        rawImageCharacter.texture = LuaMgr.GetTexture(string.format(
            "Assets/_BundleResources/Character/%s/Drawing/%s.png"
            , string.sub(TextureName, 1, 5), TextureName))
    end
end


this.ShowTips = function()
    if optionState ~= 0 then
        if optionState == 1 then
            SetActive(goTipsList, true);
            SetActive(goOptionTips1, true);
            tipsAnimator:Play("UI_CollectorPracticeMapEventPanel_goTipsList_1",0,0)
            textOptionTips1.text = optionTipsText;
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_levelup.mp3");
        elseif optionState == 2 then
            SetActive(goTipsList, true);
            SetActive(goOptionTips2, true);
            tipsAnimator:Play("UI_CollectorPracticeMapEventPanel_goTipsList_2",0,0)
            textOptionTips2.text = optionTipsText;
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_wrong.mp3");
        end
        optionState = 0;
        optionTipsText = "";
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})
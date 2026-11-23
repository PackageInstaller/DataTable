




local this = {
    closefun = nil,
    getPointNum = nil,
    cardList = {},
    storyItem = nil,
rewardTab = {},
    getItem = {},
finishGetItemCount = {},
    gradeItemList={},
};
require("CollectorPractice/Common/UICollectorCardItem")
require("CollectorPractice/Common/UICollectorStoryOptionItem")
local tarGameObject = nil;
local tarRect = nil;
local UICollectorStoryOptionItemPrefab = nil;
local root = nil;
local Middle = nil;
local textGetPoint = nil;
local textItemNum = nil;
local rectCharacter = nil;
local rectContent = nil;
local ScrollView = nil;
local imgGrade1 = nil;
local imgGrade2 = nil;
local imgGrade3 = nil;
local imgGrade4 = nil;
local imgGrade5 = nil;
local imgGrade6 = nil;
local btnContinue = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UICollectorStoryOptionItemPrefab = uiLink:Get("UICollectorStoryOptionItem");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    textGetPoint = uiLink:Get("textGetPoint"):GetComponent("Text");
    textItemNum = uiLink:Get("textItemNum"):GetComponent("Text");
    rectCharacter = uiLink:Get("rectCharacter"):GetComponent("RectTransform");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    imgGrade1 = uiLink:Get("imgGrade1"):GetComponent("Image");
    imgGrade2 = uiLink:Get("imgGrade2"):GetComponent("Image");
    imgGrade3 = uiLink:Get("imgGrade3"):GetComponent("Image");
    imgGrade4 = uiLink:Get("imgGrade4"):GetComponent("Image");
    imgGrade5 = uiLink:Get("imgGrade5"):GetComponent("Image");
    imgGrade6 = uiLink:Get("imgGrade6"):GetComponent("Image");
    btnContinue = uiLink:Get("btnContinue"):GetComponent("Button");
    uiLink:AddClickEvent("btnContinue", function()
        this.ClickBtn();
    end);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UICollectorStoryOptionItemPrefab = nil;
    root = nil;
    Middle = nil;
    textGetPoint = nil;
    textItemNum = nil;
    rectCharacter = nil;
    rectContent = nil;
    ScrollView = nil;
    imgGrade1 = nil;
    imgGrade2 = nil;
    imgGrade3 = nil;
    imgGrade4 = nil;
    imgGrade5 = nil;
    imgGrade6 = nil;
    btnContinue = nil;
    this = nil;
end

this.InitData = function()
    
    this.finishGetItemCount = 0;
    if not IsNull(this.rewardTab) then
        for key, value in pairs(this.rewardTab) do
            if value.id=="18" then
                this.finishGetItemCount=value.count;
                break;
            end
        end
    end
    this.gradeItemList={};
    table.insert(this.gradeItemList,imgGrade1);
    table.insert(this.gradeItemList,imgGrade2);
    table.insert(this.gradeItemList,imgGrade3);
    table.insert(this.gradeItemList,imgGrade4);
    table.insert(this.gradeItemList,imgGrade5);
    table.insert(this.gradeItemList,imgGrade6);
end

this.InitPanel = function()
    local nowRefrestTime = DataMgr.Player.practicesStage.refreshTime;
    textItemNum.text = "x" .. tostring(this.finishGetItemCount);

    textGetPoint.text = "+" .. tostring(this.getPointNum);
    for key, value in pairs(ConfigMgr.Config.RelicsMap) do
        if DataMgr.Player.relics ~= nil and DataMgr.Player.relics[value.RelicsId] ~= nil and DataMgr.Player.relics[value.RelicsId].Time > nowRefrestTime then
            local temp = UICollectorCardItem.New(rectContent, Vector3(1, 1, 1))
            local data = table.Copy(value);
            data.Achieve = true;
            temp:SetData(data);
            table.insert(this.cardList, temp);
        end
    end
    for index, value in pairs(DataMgr.Player.practices.grades) do
        local rating = "B";
        if value == 3 then
            rating = "S";
        elseif value == 2 then
            rating = "A";
        end
        this.gradeItemList[tonumber(index)].sprite = LuaMgr.GetSprite("AreaMapRes", "ui_zqzb_pj_" .. rating)
    end
local mapType = "MapA";
    local data = CollectorPracticeMgr.StoryData[mapType];
    for i = 1, #data, 1 do
        if ConfigMgr.Config.InternLevel2Map[DataMgr.Player.practicesStage.MapId].CharacterID == data[i].characterID then
            local temp = UICollectorStoryOptionItem.New(UICollectorStoryOptionItemPrefab, rectCharacter);
            this.storyItem = temp;
            this.storyItem:SetData(data[i], mapType)
            break;
        end
    end
    this.storyItem.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(0, 0);
end

this.ClickBtn = function()
    this.closefun();
end

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour.gameObject);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
CollectorPracticeMgr.RefreshGalleryData()
this.rewardTab = vm.behaviour.Params[0]
this.relicsExchange = vm.behaviour.Params[1]
this.getItem = vm.behaviour.Params[2]
            this.getPointNum = vm.behaviour.Params[3]
            this.closefun = vm.behaviour.Params[4]
            this.InitData();
            this.InitPanel();
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/hightea_levelup.mp3");
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil and this.closefun ~= nil) then
            this.closefun()
            this.closefun = nil;
        end
    end,
    before_destroy = function(vm)
        this.Clear();
    end,
}

return vm({
    hook = hook
})




CollectorPracticeMainSceneViewModel = {}

local this = { buildClickIndex = nil, buildClickColumnIndex = nil, rewardList = nil, buffItemList = {}, showBuffItem = nil, stateList = {}, selectBUffItem = nil, }
local BuildDataTa
require("CollectorPractice/Common/UICollectorPracticeBuffItem")
require("CollectorPractice/Common/UICollectorSmallBuffTipsItem")
require("CollectorPractice/Common/UICollectorBuildingItem")
require("CollectorPractice/Common/UICollectorRewardItem")
































local BuildItemPosGroup_3 = {
}


local uiSpineCharacter = nil;
local initScene = true;
local tweener
local characterInitTweener
local coroutine_Back = nil;
local rectHeroPos = nil;
local rectSceneInitPos = nil;
local rectSceneOutPos = nil;
local rectHeroInitPos = nil;
local rectBuildGroup = nil;
local buildItems = {};
local dotList = {};
local goDotItem = nil;
local dotItems = { {}, {}, {} };
local taskItems = {};
local tasKRewardData={};
local tasKRewardItem = {};
local goPen = nil;
local penItems = {};
local scrollRectBuild = nil;
local scrollPosition = nil;
local goTipsList = nil;
local goTips1 = nil;
local goTips2 = nil;
local textTips1 = nil;
local textTips21 = nil;
local textTips22 = nil;
local goDayNum = nil
local goBuildTips = nil
local rectTips = nil
local imgNum = nil
local txtBuildEventName = nil
local txtBuildEvent = nil
local rectGoodsList = nil
local btnCloseBuff = nil;
local rectBuffBg = nil;
local goHaveReward = nil;
local UICollectorSmallBuffTipsItemPrefab = nil;
local rectTipsAnimator = nil;

local goRewardMask =nil;
local    goBG2 =nil;
local   textToolNum = nil;
local   scrollRectReward = nil;
local  rectRewardHor = nil;
local   rectBgWeight = nil;
local  rectBgButtonScale = nil;
local rectScrollRectReward=nil;



local animator = nil;
local dayNumAnimator = nil;
local firstOpenPanel = true;
local closeBuildTipsCo = nil;
local closeBuffTipsCo = nil;
local dayNumEffectCo = nil;
local initPanelSpineCo=nil;
local bottombgaTweener=nil;
local PREFAB_PATH="Assets/_BundleResources/UI/CollectorPractice/UICollectorPracticeBuffItem.prefab";
this.Init = function(prefab)
    local uiLink = prefab.gameObject:GetComponent("UILink");
    scrollRectBuild = uiLink:Get("ScrollViewBuild"):GetComponent("ScrollRect");
    goHaveReward = uiLink:Get("goHaveReward");


    rectHeroPos = uiLink:Get("uiSpineCharacter"):GetComponent("RectTransform");
    rectSceneInitPos = uiLink:Get("rectSceneInitPos"):GetComponent("RectTransform");
    rectSceneOutPos = uiLink:Get("rectSceneOutPos"):GetComponent("RectTransform");
    rectHeroInitPos = uiLink:Get("rectHeroInitPos"):GetComponent("RectTransform");
    rectBuildGroup = uiLink:Get("rectBuildGroup"):GetComponent("RectTransform");
    uiSpineCharacter = uiLink:Get("uiSpineCharacter"):GetComponent("UISpineCharacter")
    table.insert(dotList, uiLink:Get("rectDotList1"))
    table.insert(dotList, uiLink:Get("rectDotList2"))
    table.insert(dotList, uiLink:Get("rectDotList3"))
    goDotItem = uiLink:Get("goDotItem");
    SetActive(goDotItem, false);
    animator = uiLink:Get("root"):GetComponent("Animator");
    dayNumAnimator = uiLink:Get("goDayNum"):GetComponent("Animator");
    rectTipsAnimator = uiLink:Get("rectTips"):GetComponent("Animator");
    goPen = uiLink:Get("goPen");
    goTipsList = uiLink:Get("goTipsList");
    goTips1 = uiLink:Get("goTips1");
    goTips2 = uiLink:Get("goTips2");
    textTips1 = uiLink:Get("textTips1"):GetComponent("Text");
    textTips21 = uiLink:Get("textTips21"):GetComponent("Text");
    textTips22 = uiLink:Get("textTips22"):GetComponent("Text");
    goDayNum = uiLink:Get("goDayNum")
    goBuildTips = uiLink:Get("goBuildTips")
    rectTips = uiLink:Get("rectTips"):GetComponent("RectTransform");
    imgNum = uiLink:Get("imgNum"):GetComponent("Image");
    txtBuildEventName = uiLink:Get("txtBuildEventName"):GetComponent("Text");
    txtBuildEvent = uiLink:Get("txtBuildEvent"):GetComponent("Text");
    rectGoodsList = uiLink:Get("rectGoodsList"):GetComponent("RectTransform");

    btnCloseBuff = uiLink:Get("btnCloseBuff"):GetComponent("Button");
    rectBuffBg = uiLink:Get("rectBuffBg"):GetComponent("RectTransform");
    UICollectorSmallBuffTipsItemPrefab = uiLink:Get("UICollectorSmallBuffTipsItem");

    goRewardMask = uiLink:Get("goRewardMask")
    goBG2 = uiLink:Get("goBG2")
    textToolNum = uiLink:Get("textToolNum"):GetComponent("Text");
    scrollRectReward = uiLink:Get("scrollRectReward"):GetComponent("ScrollRect");
    rectScrollRectReward=uiLink:Get("scrollRectReward"):GetComponent("RectTransform");
    rectRewardHor = uiLink:Get("rectReward"):GetComponent("HorizontalLayoutGroup");
    rectBgWeight = uiLink:Get("rectBgWeight"):GetComponent("RectTransform");
    rectBgButtonScale = uiLink:Get("rectBgButtonScale"):GetComponent("RectTransform");

    for i = 1, 8, 1 do
        local temp = uiLink:Get("goState" .. i):GetComponent("Image");
        table.insert(this.stateList, temp);
    end

    table.insert(penItems, goPen)

    scrollPosition = scrollRectBuild.content.anchoredPosition;

    uiLink:AddClickEvent("btnClose", function()
        if coroutine_Back ~= nil then
            return;
        end
        LuaMgr.Back();
    end)
    uiLink:AddClickEvent("btnGuide", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeGuideViewModel)
    end)
    uiLink:AddClickEvent("btnCloseBtn", function()
if rectTipsAnimator:GetCurrentAnimatorStateInfo(0).normalizedTime < 1 then
            return;
        end
        rectTipsAnimator:Play("ani_CollectorPracticeMainScenePanel_rectTips_disappear", 0, 0);
closeBuildTipsCo = coroutine_runner.start(function()
            coroutine_runner.wait(0.34)
            SetActive(goBuildTips, false)
        end)
    end)
    uiLink:AddClickEvent("btnGotoBtn", function()
        this.GotoBuild()
    end)
    uiLink:AddClickEvent("btnStateList", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStateViewModel, true, true, nil, nil)
    end)
    uiLink:AddClickEvent("btnCloseBuff", function()
if this.showBuffItem:AnimIsPlaying() then
            return;
        end
        SetActive(btnCloseBuff.gameObject, false);
        this.showBuffItem:BuffTipsCloseAnim();
closeBuffTipsCo = coroutine_runner.start(function()
            coroutine_runner.wait(0.34)
            this.showBuffItem:Hide();
            this.selectBUffItem = nil;
        end)
    end)
    uiLink:AddClickEvent("btnBottomOpen", function()
        if bottombgaTweener ~= nil then
            return
        end

        local type = 1;
        if rectBgButtonScale.localScale.x == 1 then
            type = 0;
            rectBgButtonScale.localScale = Vector3(-1, 1, 1)
        else
            type = 1;
            rectBgButtonScale.localScale = Vector3(1, 1, 1)
        end

        local pos1 = type == 0 and Vector2(0, 0) or Vector2(-rectBgWeight.sizeDelta.x + 22, 0)
        local pos2 = type == 0 and Vector2(-rectBgWeight.sizeDelta.x + 22, 0) or Vector2(0, 0)
        bottombgaTweener = DOTWeen.To(function() return pos1 end,
            function(vector) rectScrollRectReward.anchoredPosition = vector end, pos2, 0.3)
        bottombgaTweener:SetEase(Ease.InQuart)
        bottombgaTweener.onComplete = function()
            bottombgaTweener = nil;
        end
    end)
end

this.InitBuffPanel = function()
    SetActive(btnCloseBuff.gameObject, false);
    local data = DataMgr.Player.practices.buffIds;
    if #this.buffItemList ~= #data then
        for i = #this.buffItemList + 1, #data, 1 do
            local temp = UICollectorSmallBuffTipsItem.New(UICollectorSmallBuffTipsItemPrefab, rectBuffBg);
            table.insert(this.buffItemList, temp);
        end
    end
    if this.showBuffItem == nil then
        this.showBuffItem = UICollectorPracticeBuffItem.New();
        this.showBuffItem.gameObject = LuaMgr.GetPrefab(
            PREFAB_PATH);
        LuaMgr.AddPrefabRefCount(PREFAB_PATH);
        this.showBuffItem:Init();
        this.showBuffItem.gameObject:GetComponent("RectTransform"):SetParent(rectBuffBg, false);
        SetActive(this.showBuffItem.gameObject, false);
    end
    this.RefreshBuffPanel();
end

this.InitGuidePanel = function()
    if CollectorPracticeMgr.CheckHaveReward(-1) then
        SetActive(goHaveReward, true);
    else
        SetActive(goHaveReward, false);
    end
end

this.ClickBuffItem = function(item)
    if this.selectBUffItem == item then
        return;
    end
if this.showBuffItem.gameObject.activeSelf then
        return;
    end
    this.showBuffItem.gameObject:GetComponent("RectTransform"):SetParent(item.rectGroup, false);
    this.showBuffItem.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(0, 0);
    local tempData = {}
    tempData.data = table.Copy(item.data);
    tempData.data.fun = nil;
    tempData.data.isChoose = true;
    this.showBuffItem:SetData(tempData);
    SetActive(btnCloseBuff.gameObject, true);
    this.showBuffItem:BuffTipsShowAnim();
    this.selectBUffItem = item;
end

this.RefreshBuffPanel = function()
    SetActive(btnCloseBuff.gameObject, false);
    local data = DataMgr.Player.practices.buffIds;
    for i = #this.buffItemList + 1, #data, 1 do
        local temp = UICollectorSmallBuffTipsItem.New(UICollectorSmallBuffTipsItemPrefab, rectBuffBg);
        table.insert(this.buffItemList, temp);
    end
    for i = 1, #data, 1 do
        local tempData = CollectorPracticeMgr.buffIdToBuffConfig[data[i]];
        tempData.fun = this.ClickBuffItem;
        this.buffItemList[i]:SetData(tempData);
    end

    for i = #data + 1, #this.buffItemList, 1 do
        this.buffItemList[i]:Hide();
    end
end

this.ClearBuffPanel=function ()
    SetActive(btnCloseBuff.gameObject, false);
    this.showBuffItem:Hide();
    this.selectBUffItem = nil;
end

this.Clear = function()
    LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
    for i = 1, #tasKRewardItem do
        tasKRewardItem[i]:Destroy();
    end

    for i = 1, #taskItems do
        taskItems[i]:Destroy();
    end
     goRewardMask =nil;
        goBG2 =nil;
       textToolNum = nil;
       scrollRectReward = nil;
      rectRewardHor = nil;
       rectBgWeight = nil;
      rectBgButtonScale = nil;
      rectScrollRectReward=nil;
    tasKRewardItem = nil;
    taskItems = nil;
    rectSceneInitPos = nil;
    goHaveReward = nil;
    rectSceneOutPos = nil;
    rectHeroInitPos = nil;
    rectBuildGroup = nil;
    rectTipsAnimator = nil;
    dayNumAnimator = nil;
    buildItems = nil;
    closeBuildTipsCo = nil;
    animator = nil
    goTipsList = nil;
    goTips1 = nil;
    goTips2 = nil;
    textTips1 = nil;
    textTips21 = nil;
    dayNumEffectCo = nil;
    textTips22 = nil;
    goDayNum = nil


    goBuildTips = nil
    rectTips = nil
    imgNum = nil
    txtBuildEventName = nil
    txtBuildEvent = nil
    rectGoodsList = nil
    UICollectorSmallBuffTipsItemPrefab = nil;
    rectBuffBg = nil;
    btnCloseBuff = nil;

    if this.rewardList ~= nil then
        for i = 1, #this.rewardList do
            this.rewardList[i]:Clear()
        end
    end
end

this.btnRewardClick = function(lua_index, id, count)
    if tweener ~= nil then
        return
    end

    tasKRewardItem[lua_index]:SetSelect(true);
    LuaMgr.ShowLuaPanel(UIName.CollectorPracticeToolBagViewModel, 1, { ID = id, Count = count }, function()
        for i = 1, #tasKRewardItem do
            tasKRewardItem[i]:SetSelect(false);
        end
    end)
end

this.CoroutineClose = function()
if coroutine_runner.checkIsDestory() then
        return;
    end
    if closeBuildTipsCo ~= nil then
        coroutine_runner.stop(closeBuildTipsCo)
    end
    if closeBuffTipsCo ~= nil then
        coroutine_runner.stop(closeBuffTipsCo)
    end
    if dayNumEffectCo ~= nil then
        coroutine_runner.stop(dayNumEffectCo)
    end
    if initPanelSpineCo ~= nil then
        coroutine_runner.stop(initPanelSpineCo)
    end
    if coroutine_Back ~= nil then
        coroutine_runner.stop(coroutine_Back)
    end
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject);
        RedMgr.Singleton:RegisterViewModel(UIName.CollectorPracticeMainSceneViewModel);
CollectorPracticeMgr.AwakeInitGuideData();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            initScene = CollectorPracticeMgr.InitMainScene;
            this.InitBuildingPos();
            LuaMgr.SceneSwitchMark();
            CollectorPracticeMgr.RefushMapData()
            
            BuildDataTa = CollectorPracticeMgr.GetDataLunch()

LuaMgr.AddUIEventListener(UIEventConst.CollectorBagToolRefush, this.UpdateRewardList);
            LuaMgr.AddUIEventListener(UIEventConst.CollectorRandomRewardRefush, this.UpdateBagData);
            LuaMgr.AddUIEventListener(UIEventConst.NeedRefreshBuff, this.RefreshBuffPanel);
            LuaMgr.AddUIEventListener(UIEventConst.NeedRefreshState, this.RefreshState);
            LuaMgr.AddUIEventListener(UIEventConst.NeedRefreshGuideState, this.InitGuidePanel);
            local characterId = DataMgr.Player.sex > 1 and "SCJ202" or "SCJ201"
            uiSpineCharacter:Clear()
            uiSpineCharacter:SetBattle(characterId, characterId .. "001", "",
                ConfigMgr.Config.characterTable[characterId].job)
            uiSpineCharacter:Play("idle", true, nil)


            local currentColumnNum = 1;
if not IsNull(DataMgr.Player.practicesStage.stages) then
                currentColumnNum = #DataMgr.Player.practicesStage.stages
            end
            if firstOpenPanel then
                imgNum.sprite = LuaMgr.GetSprite("CollectorMainScene", "ui_sx_dt_sz_" .. currentColumnNum);
            end





            if #CollectorPracticeMgr.RewardTab > 0 then
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChipItemsPanel, function()
                    this.EndMainSceneFun();
                end)
            else
                this.EndMainSceneFun();
            end


            this.UpdateRewardList()
            rectBgButtonScale.localScale = Vector3(-1, 1, 1)
            rectScrollRectReward.anchoredPosition = Vector2(-rectBgWeight.sizeDelta.x + 22, 0)

            local Passod = CollectorPracticeMgr.GetPassIndex();
            local ClickTeaTimesamp = UnityEngine.PlayerPrefs.GetString(DataMgr.Player.uid .. "EventMapTip")
animator:Play("ani_CollectorPracticeHomePanel_rectContent_chuxian", 0, 0)
            if Passod <= 0 then
if ClickTeaTimesamp == "" or ClickTeaTimesamp == nil then
                    UnityEngine.PlayerPrefs.SetString(DataMgr.Player.uid .. "EventMapTip",
                        CollectorPracticeMgr.ThemData.mapType)
                end
            end
HeroRedDataHelper.RefreshCollectorPracticeStoryRed();
this.InitBuffPanel();
            this.InitGuidePanel();
            this.RefreshState();

            if initScene then
                this.ClearBuildingItem();
scrollRectBuild.horizontalNormalizedPosition = 0;
                this.PlayFirstOpenGameAnimation();
            else
                if not CollectorPracticeMgr.isByBattleViewModel then
                    this.InitBuildItem();
                    this.ClearBuildingItem();
                    this.InitHeroPos();
                end
                LuaMgr.DragTargetToViewPortOnCenter(scrollRectBuild,rectHeroPos,
nil, 0);
            end

            local type21Num = 0;
            for index1, value1 in ipairs(DataMgr.Player.practicesStage.stages) do
                for index2, value2 in ipairs(value1) do
                    local type = ConfigMgr.Config.InternEventKV[value2.stageid].EventType
if type == 21 and  value2.status ~= 0 then
                        type21Num = type21Num + 1;
                    end
if value2.status == 1 and value2.stageid ~= "A10001" then
if type == 21 and DataMgr.Player.practices.buffTimes <= type21Num then
                            local callBack = function()
CollectorPracticeEvent.OpenMiniGameByEventId(value2.stageid, false, true);
                            end
                            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStateViewModel, false, true, callBack, nil)
                        else
CollectorPracticeEvent.OpenMiniGameByEventId(value2.stageid, false, true);
                        end
                    end
                end
            end


        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveUIEventListener(UIEventConst.CollectorBagToolRefush, this.UpdateRewardList);
            LuaMgr.RemoveUIEventListener(UIEventConst.CollectorRandomRewardRefush, this.UpdateBagData);
            LuaMgr.RemoveUIEventListener(UIEventConst.NeedRefreshBuff, this.RefreshBuffPanel);
            LuaMgr.RemoveUIEventListener(UIEventConst.NeedRefreshState, this.RefreshState);
            LuaMgr.RemoveUIEventListener(UIEventConst.NeedRefreshGuideState, this.InitGuidePanel);
            SetActive(goTipsList, false);
            SetActive(goTips1, false);
            SetActive(goTips2, false);
            if LuaMgr.IsPanelOpen(UIName.CollectorPracticeToolBagViewModel) then
                LuaMgr.HidePanel(UIName.CollectorPracticeToolBagViewModel)
            end

            if tweener ~= nil then
                tweener:Kill()
                tweener = nil;
            end


            coroutine_Back = nil;
            uiSpineCharacter:Clear();
            this.ClearBuffPanel();
            LuaMgr.RemoveTimer(TimerConst.DelayClose);
            LuaMgr.RemoveTimer(TimerConst.PracticeDayTips)
firstOpenPanel = true;
            SetActive(goTipsList, false);
            SetActive(goTips1, false);
            SetActive(goTips2, false);
            this.CoroutineClose();
        end
    end,
    before_destroy = function(vm)
        this.Clear();
        this = nil
    end,
}


this.UpdateRewardList = function()
    local Num = 0
    local ToolData = ConfigMgr.Config.EventToolsMap;
    local index = 0;
    tasKRewardData = {};
    for key, value in pairs(ToolData) do
        local _count = (DataMgr.Player.practicesStage.tools[key]~=nil and DataMgr.Player.practicesStage.tools[key] or 0)
        Num = Num + _count;
        if _count > 0 then
            index = index + 1;
            if index > #tasKRewardItem then
                table.insert(tasKRewardItem, UICollectorRewardItem.New(rectRewardHor.transform, Vector3.one))
            end

table.insert(tasKRewardData, { toolId = value.ToolId, count = _count })

            SetActive(tasKRewardItem[index].gameObject, true);
            tasKRewardItem[index]:SetData(index, value.ToolId, _count, function(data1, data2, date3)
                this.btnRewardClick(data1, data2, date3);
            end,value.ToolIcon);
        end
    end

    for i = (index + 1), #tasKRewardItem do
        tasKRewardItem[i]:Clear();
    end

    if index <= 0 then
        rectBgWeight.sizeDelta = Vector2(22, rectBgWeight.sizeDelta.y)
    else
        local itemNum = index >= 5 and 5 or index;
        rectBgWeight.sizeDelta = Vector2((132 * itemNum) + (rectRewardHor.spacing * (itemNum - 1)) + 36,
            rectBgWeight.sizeDelta.y)
    end

    scrollRectReward.horizontal = index >= 5
    textToolNum.text = Num
    SetActive(goRewardMask,Num > 0)
    SetActive(goBG2,Num > 0)
end


this.PlayFirstOpenGameAnimation = function()
    local startPos = rectSceneInitPos.anchoredPosition
    local targetpos = rectHeroInitPos.anchoredPosition
    rectHeroPos.anchoredPosition =startPos;
initPanelSpineCo = coroutine_runner.start(function()
        coroutine_runner.wait(0.1) 
        initPanelSpineCo = nil;
        uiSpineCharacter:Play("run", true, nil)

        tweener = DOTWeen.To(function() return startPos end,
            function(vector) rectHeroPos.anchoredPosition = vector end, targetpos, 1.5)
        tweener.onComplete = function()
            initScene = false
            CollectorPracticeMgr.InitMainScene=false;
            uiSpineCharacter:Play("idle", true, nil)
            local tempCallBack = function()
                CollectorPracticeMgr.GetNextGropIdTab()
                
            end
            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChooseBuffViewModel, -1, tempCallBack)
            tweener = nil
        end
    end)
    
end

this.InitBuildingPos = function()
    BuildItemPosGroup_3 = ConfigMgr.Config.InternLevel2Map["A101"].BuildItemPosGroup_3;
    SetActive(goBuildTips, false)
end


this.CharacterMoveFunction = function(targetIndex, columnIndex)
    local targetpos = Vector2(buildItems[targetIndex].pos[1], buildItems[targetIndex].pos[2])
    uiSpineCharacter:Play("run", true, nil)
    tweener = DOTWeen.To(function() return rectHeroPos.anchoredPosition end,
        function(vector) rectHeroPos.anchoredPosition = vector end, targetpos, 1.5)
    tweener.onComplete = function()
        local internEventKV = buildItems[targetIndex].internEventKV
CollectorPracticeMgr.WalkToOtherPos(this.succssfulfun, columnIndex)
        uiSpineCharacter:Play("idle", true, nil)
        tweener=nil;
    end
end

this.UpdateBuildPos = function(index)
    if index ~= 0 and not firstOpenPanel then
        LuaMgr.DragTargetToViewPortOnCenter(scrollRectBuild, buildItems[index].transform:GetComponent("RectTransform"),
            nil, 0.7);
    end
end


this.EndMainSceneFun = function()
tweener = nil
this.InitGuidePanel();
    if DataMgr.Player.practicesStage ~= nil and DataMgr.Player.practicesStage.stages ~= nil and DataMgr.Player.practicesStage.stages[#DataMgr.Player.practicesStage.stages] ~= nil
        and DataMgr.Player.practicesStage.stages[#DataMgr.Player.practicesStage.stages][1] ~= nil
        and DataMgr.Player.practicesStage.stages[#DataMgr.Player.practicesStage.stages][1].stageid == "A10001"
and DataMgr.Player.practicesStage.stages[#DataMgr.Player.practicesStage.stages][1].status == 1 then
        if LuaMgr.IsPanelOpen(UIName.CollectorPracticeRewardResultViewModel) then
            print("禁止连续请求")
            return
        end

        UnityEngine.PlayerPrefs.SetString(DataMgr.Player.uid .. "EventMapTip", "")

        local data = { ThemeId = CollectorPracticeMgr.ThemData.mapType }
        local Url = "practice/settlement"
        ApiMgr.Request(Url, data, true,
            function(result)
                local re = json.decode(result)
                if re.code == 0 then
                    if IsNull(re.result.Items) then
                        print("没有获得奖励")
                    end

                    LuaMgr.ShowLuaPanel(UIName.CollectorPracticeRewardResultViewModel, re.result.Reward.Items,
                        re.result.RelicsExchange, re.result.GetItem, re.result.Score,
                        function()
                            LuaMgr.HidePanel(UIName.CollectorPracticeStateViewModel)
                            LuaMgr.HidePanel(UIName.CollectorPracticeGuideViewModel)
                            LuaMgr.Back()












                        end)
                end
            end,
            function(failCode)
                print("EnterDungeonError,ErrorCode:", failCode)
            end,
            true
        )
    else

        if #DataMgr.Player.practicesStage.stages == 1 and (not initScene) then
            if DataMgr.Player.practices.buffIds == nil or #DataMgr.Player.practices.buffIds == 0 then
                local tempCallBack = function()
                    if this ~= nil then
                        LuaMgr.NextFrame(this.RefreshMainScenePanelOnFinishEvent)
                    end
                end
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChooseBuffViewModel, -1, tempCallBack)
            else
                LuaMgr.NextFrame(this.RefreshMainScenePanelOnFinishEvent)
            end
        else
            local tempData = DataMgr.Player.practices.eventinfos
            if TableIsNull(tempData) then
                tempData = {}
            end
            if #tempData > DataMgr.Player.practices.gradesCount then
                local callBack = function()
                    if this ~= nil then
                        LuaMgr.NextFrame(this.RefreshMainScenePanelOnFinishEvent)
                    end
                end
                local isUpLevel = false
                local index = #DataMgr.Player.practicesStage.stages - 1
                if #tempData < index then
                    isUpLevel = false
                else
                    isUpLevel = tempData[index].win
                end

local allNumber = DataMgr.Player.practices.grades["1"];
                local isAllNumber = true;
                for key, value in pairs(DataMgr.Player.practices.grades) do
                    if allNumber ~= value then
                        isAllNumber = false;
                        break;
                    end
                end

                if CollectorPracticeMgr.isByBattleViewModel then
                    CollectorPracticeMgr.GetNextGropIdTab()
                        BuildDataTa = CollectorPracticeMgr.GetDataLunch()
                        this.InitBuildItem();
                        SetActive(buildItems[#buildItems].gameObject, false);
                        this.InitHeroPos();

                        if TableIsNull(CollectorPracticeMgr.NextStepTab) then
                            this.UpdateBuildPos(CollectorPracticeMgr.GetPassIndex() - 1);
                        else
this.UpdateBuildPos(CollectorPracticeMgr.NextStepTab[#CollectorPracticeMgr.NextStepTab] - 1);
                        end

                        if not (isAllNumber and ((allNumber == 1 and (not isUpLevel))or (allNumber == 3 and isUpLevel))) then
                            LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStateViewModel, false, false, callBack, isUpLevel)
                        else
                            LuaMgr.NextFrame(this.RefreshMainScenePanelOnFinishEvent)
                        end
                else
                    if not (isAllNumber and ((allNumber == 1 and (not isUpLevel))or (allNumber == 3 and isUpLevel))) then
                        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeStateViewModel, false, false, callBack, isUpLevel)
                    else
                        LuaMgr.NextFrame(this.RefreshMainScenePanelOnFinishEvent)
                    end
                end
            else
                LuaMgr.NextFrame(this.RefreshMainScenePanelOnFinishEvent)
            end
        end
    end
end

this.ShowOtherReward = function()
    if #CollectorPracticeMgr.OtherReward <= 0 then
        return;
    end

    local items = {};
    local reward = CollectorPracticeMgr.OtherReward
    for i, v in pairs(reward) do
        local item = { ID = v.id, Count = v.count }
        table.insert(items, item);
    end

    LuaMgr.ShowItemGetPanel(items);


    CollectorPracticeMgr.OtherReward = {};
end


this.succssfulfun = function()
    if #CollectorPracticeMgr.RewardTab > 0 then
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChipItemsPanel, function()
            this.ShowOtherReward();
            this.EndMainSceneFun();
        end)
    else
        if #CollectorPracticeMgr.OtherReward > 0 then
            this.ShowOtherReward();
        end
        this.EndMainSceneFun();
    end
this.ShowTips();

    CollectorPracticeMgr.RefushStoryData("MapA")

    this.UpdateRewardList()

    HeroRedDataHelper.RefreshCollectorPracticeStoryRed();

end

this.ClearBuildingItem=function ()
    for i = 1, #buildItems do
        buildItems[i]:Clear();
    end
end



this.InitBuildItem = function()
    CollectorPracticeMgr.GetNextGropIdTab()
    rectHeroInitPos.localScale = Vector3(0.9, 0.9, 0.9);
    local len = #BuildDataTa;
    for i = 1, len do
        local newItem = false;
if i > #buildItems then
table.insert(buildItems, UICollectorBuildingItem.New(rectBuildGroup, nil))
            newItem = true;
        end
if #DataMgr.Player.practicesStage.stages == (BuildDataTa[i].rowIndex + 1) then
            newItem = true;
        end
        local pos = nil;
if #DataMgr.Player.practicesStage.stages[BuildDataTa[i].rowIndex + 1] == 1 then
local posIndex = BuildDataTa[i].rowIndex * 3 + 2;
            pos = BuildItemPosGroup_3[posIndex];
elseif #DataMgr.Player.practicesStage.stages[BuildDataTa[i].rowIndex + 1] == 2 then
if BuildDataTa[i].columnIndex == 0 then
local posIndex = BuildDataTa[i].rowIndex * 3 + 1;
                pos = BuildItemPosGroup_3[posIndex];
            else
local posIndex = BuildDataTa[i].rowIndex * 3 + 2;
                pos = BuildItemPosGroup_3[posIndex];
            end
elseif #DataMgr.Player.practicesStage.stages[BuildDataTa[i].rowIndex + 1] == 3 then
            local posIndex = BuildDataTa[i].rowIndex * 3 + BuildDataTa[i].columnIndex + 1;
            pos = BuildItemPosGroup_3[posIndex];
        end
if BuildDataTa[i].rowIndex == 8 then
            pos = BuildItemPosGroup_3[25];
        end
        SetActive(buildItems[i].gameObject, true);

        buildItems[i]:SetData(i, BuildDataTa[i].columnIndex, BuildDataTa[i].stageid, pos, this.BuildItemClick);
        if newItem and((not firstOpenPanel)or CollectorPracticeMgr.isByBattleViewModel) then
            buildItems[i]:FirstAnimation();
        end
    end
    for i = (len + 1), #buildItems do
        buildItems[i]:Clear();
    end
this.SetBuildActive();
    this.InitDotLineList();
end

this.BuildItemClick = function(index, columnIndex)
if tweener ~= nil then
        return
    end
    this.buildClickIndex = index
    this.buildClickColumnIndex = columnIndex
    local canGoto, targetindex = CollectorPracticeMgr.CheckNextStep(this.buildClickIndex)
    if canGoto then
        local tempBuild = buildItems[index]
        local tempX = tempBuild.transform.anchoredPosition.x + 53
        if tempX > 950 then tempX = 950 end
        local tempY = tempBuild.transform.anchoredPosition.y + 120
        rectTips.transform.anchoredPosition = Vector2(tempX, tempY)
        txtBuildEventName.text = LuaMgr.GetLangText(tempBuild.internEventKV.EventNameLan)
        txtBuildEvent.text = LuaMgr.GetLangText(tempBuild.internEventKV.EventDesLan)
        if this.rewardList == nil then
            this.rewardList = {}
        end
        local itemCount = 0
        if not IsNull(tempBuild.internEventKV.ItemIcon) then

            itemCount = #tempBuild.internEventKV.ItemIcon
            local itemConfig = nil
            for i = 1, itemCount do
                if #this.rewardList < i then
                    table.insert(this.rewardList, GoodsDataItem.New(rectGoodsList))
                end
                itemConfig = table.Copy(ConfigMgr.Config.itemMap[tempBuild.internEventKV.ItemIcon[i].id])
                print(itemConfig.id)
                itemConfig["count0"] = tempBuild.internEventKV.ItemIcon[i].count
                this.rewardList[i]:SetData(i, itemConfig, 1, false, Vector3(0.6, 0.6, 0.6), false, true)
            end
        end
        for i = itemCount + 1, #this.rewardList do
            this.rewardList[i]:Hide()
        end
        SetActive(goBuildTips, true)

        rectTipsAnimator:Play("ani_CollectorPracticeMainScenePanel_rectTips_trigger", 0, 0);

    else
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("7101"));
    end
end

this.GotoBuild = function()
    if tweener ~= nil then
        return
    end
    this.CharacterMoveFunction(this.buildClickIndex, this.buildClickColumnIndex)
    this.UpdateBuildPos(this.buildClickIndex)
    SetActive(goBuildTips, false)
end

this.UpdatePen = function()
local practicestage = 9

    local currentColumnNum = 0;
if DataMgr.Player.practicesStage.stages ~= nil then
        currentColumnNum = #DataMgr.Player.practicesStage.stages
    end

    for i = 1, practicestage do
        if i > #penItems then
            table.insert(penItems, LuaMgr.InstantiateGO(goPen, goPen.transform.parent, false))
        end

        penItems[i].transform.localScale = Vector3.one;
        SetActive(penItems[i].gameObject, true);

local lockstate = i > currentColumnNum;

        local goIsOn = penItems[i].transform:Find("goIsOn").gameObject
        local par = penItems[i].transform:Find("goIsOn/BG/Par").gameObject
        SetActive(par, false);

if lockstate then

            SetActive(goIsOn, false);

        else
if i <= currentColumnNum then

                SetActive(goIsOn, true);


            else

                SetActive(goIsOn, false);

            end
        end
    end
    this.UpdatePenDetails()
end

this.RefreshState = function()
    local tempData = DataMgr.Player.practices.eventinfos
    if TableIsNull(tempData) then
        tempData = {}
    end
    for i = 1, #tempData, 1 do
        SetActive(this.stateList[i].gameObject, true);
        this.stateList[i].sprite = LuaMgr.GetSprite("CollectorMainScene", "ui_sx_dt_zt_0" .. (tempData[i].win and 1 or 2));
    end

    for i = #tempData + 1, 8, 1 do
        SetActive(this.stateList[i].gameObject, false);
    end
end

this.UpdatePenDetails = function()
    SetActive(goDayNum, true)
    dayNumAnimator:Play("ani_CollectorPracticeMainScenePanel_goDayNum_001", 0, 0);
    local currentColumnNum = 1;
if not IsNull(DataMgr.Player.practicesStage.stages) then
        currentColumnNum = #DataMgr.Player.practicesStage.stages
    end
    if firstOpenPanel then
        imgNum.sprite = LuaMgr.GetSprite("CollectorMainScene", "ui_sx_dt_sz_" .. currentColumnNum);
    end
dayNumEffectCo = coroutine_runner.start(function()
        coroutine_runner.wait(0.4)
        imgNum.sprite = LuaMgr.GetSprite("CollectorMainScene", "ui_sx_dt_sz_" .. currentColumnNum);
        coroutine_runner.wait(0.7)
        for i = 1, 9 do
            local par = penItems[i].transform:Find("goIsOn/BG/Par").gameObject
if i <= currentColumnNum then
                SetActive(par, true);
            else
                SetActive(par, false);
            end
        end
    end)
end

this.SetBuildActive = function()
    local nowBuildingRow = #DataMgr.Player.practicesStage.stages
    for i = 1, #BuildDataTa do
if not (BuildDataTa[i].rowIndex + 1 == nowBuildingRow or
DataMgr.Player.practicesStage.stages[BuildDataTa[i].rowIndex + 1][BuildDataTa[i].columnIndex + 1].status == 1 or
DataMgr.Player.practicesStage.stages[BuildDataTa[i].rowIndex + 1][BuildDataTa[i].columnIndex + 1].status == 2)
        then
            buildItems[i]:Hide();
        end
    end
end


this.InitDotLineList = function()
    if buildItems == nil or IsNull(rectHeroInitPos) then
        print("buildItems is nil")
        return;
    end

    local currentHeroPos = CollectorPracticeMgr.GetPassIdPanelIndex()
    if currentHeroPos ~= nil and currentHeroPos > #BuildDataTa then
        print("索引越界了  " .. currentHeroPos)
        return;
    end

    local PosValue = (currentHeroPos ~= nil and currentHeroPos > 0) and buildItems[currentHeroPos].pos or
        { rectHeroInitPos.anchoredPosition.x, rectHeroInitPos.anchoredPosition.y, 0 }

    if PosValue == nil then
        print("PosValue is nil")
        return;
    end

    for i = 1, #dotList do
        SetActive(dotList[i], false);
    end

    local index = 1;
    for _index, _value in ipairs(CollectorPracticeMgr.NextStepTab) do
        if _index ~= 1 then
            local stepindex = _value
            local NextPosValue = buildItems[stepindex].pos

            local heroPos = Vector2(PosValue[1], PosValue[2])
            local NextPos = Vector2(NextPosValue[1], NextPosValue[2])
            local diasance = Vector2(heroPos.x - NextPos.x, heroPos.y - NextPos.y)
            local NewListLinPos = { (heroPos.x + NextPos.x) * 0.5, (heroPos.y + NextPos.y) * 0.5 }
            local mealu = diasance:SqrMagnitude()

            local distanceLength = CollectorPracticeMgr.keepDecimal(math.sqrt(mealu), 2)

            local angel = CS.UnityEngine.Vector2.SignedAngle(diasance, Vector2(1, 0))
            local nun = math.ceil(distanceLength / 45.5)

            SetActive(dotList[index], true)
            local rect = dotList[index].transform:GetComponent("RectTransform");
            rect.localEulerAngles = Vector3(0, 0, -angel);
            rect.anchoredPosition = Vector2(NewListLinPos[1], NewListLinPos[2]);

            for i = 1, nun, 1 do
                if i > #dotItems[index] then
                    table.insert(dotItems[index], LuaMgr.InstantiateGO(goDotItem, rect, false))
                end
                SetActive(dotItems[index][i], true);
            end

            for i = nun + 1, #dotItems[index] do
                SetActive(dotItems[index][i], false)
            end
            index = index + 1;
        end
    end
end




this.RefreshMainScenePanelOnFinishEvent = function()
if this == nil then
        return
    end
if DataMgr.Player.practicesStage.stages ~= nil then
        CollectorPracticeMgr.GetNextGropIdTab()
        BuildDataTa = CollectorPracticeMgr.GetDataLunch()
        this.InitBuildItem();
        this.InitHeroPos();

        if TableIsNull(CollectorPracticeMgr.NextStepTab) then
            this.UpdateBuildPos(CollectorPracticeMgr.GetPassIndex() - 1);
        else
this.UpdateBuildPos(CollectorPracticeMgr.NextStepTab[#CollectorPracticeMgr.NextStepTab] - 1);
        end

        if buildItems ~= nil and buildItems[1] ~= nil then
if firstOpenPanel and( not CollectorPracticeMgr.isByBattleViewModel) then
                local mat = buildItems[1].rawImage.material;
coroutine_Back = coroutine_runner.start(function()
                    mat:SetFloat("_ShowID", 0);
                    for i = 1, 7, 1 do
                        coroutine_runner.wait(0.05)
                        mat:SetFloat("_ShowID", i);
                    end
                    coroutine_Back = nil;
                end)
            end
        end
        CollectorPracticeMgr.isByBattleViewModel=false;
        this.UpdatePen();
firstOpenPanel = false;
    end
end

this.InitHeroPos=function ()
CollectorPracticeMgr.CheckPosIndex()
    if not initScene then
        if CollectorPracticeMgr.selectPoint > 0 then
            print("CollectorPracticeMgr.selectPoint"..CollectorPracticeMgr.selectPoint)
            rectHeroPos.anchoredPosition = Vector2(buildItems[CollectorPracticeMgr.selectPoint].pos[1],
                buildItems[CollectorPracticeMgr.selectPoint].pos[2])
        else
            if CollectorPracticeMgr.selectPoint == 0 then
                rectHeroPos.anchoredPosition = rectHeroInitPos.anchoredPosition
                scrollRectBuild.content.anchoredPosition = scrollPosition;
                scrollRectBuild.horizontalNormalizedPosition = 0;
            end
        end
    end
end


this.UpdateBagData = function()
    if #CollectorPracticeMgr.RewardTab > 0 then
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChipItemsPanel, function()
            this.EndMainSceneFun();
        end)
    else
        this.EndMainSceneFun();
    end
end


this.ShowTips = function()
if CollectorPracticeMgr.FinishTipsState == 0 then
        SetActive(goTipsList, false);
        SetActive(goTips1, false);
        SetActive(goTips2, false);
        return;
    end
if CollectorPracticeMgr.FinishTipsState ~= 0 then
        SetActive(goTipsList, false);
        SetActive(goTips1, false);
        SetActive(goTips2, false);
        if CollectorPracticeMgr.FinishTipsState == 1 then
            SetActive(goTipsList, true);
            SetActive(goTips1, true);
            textTips1.text = string.gsub(CollectorPracticeMgr.FinishTips, "\\n", "\n");
        elseif CollectorPracticeMgr.FinishTipsState == 2 then
            SetActive(goTipsList, true);
            SetActive(goTips2, true);
            local nowText = tostring(CollectorPracticeMgr.FinishTips)
            local finishTest = string.gsub(nowText, "\\n", "|");
            local textTable = Split(finishTest, "|")
            textTips21.text = textTable[1];
            textTips22.text = textTable[2];
        end
        CollectorPracticeMgr.FinishTipsState = 0;
        CollectorPracticeMgr.FinishTips = "";
    end
end


CollectorPracticeMainSceneViewModel.succssfulfun = this.succssfulfun;

return vm({
    hook = hook
})
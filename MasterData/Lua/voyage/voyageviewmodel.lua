require("Voyage/VoyageConst")
require("Voyage/VoyageSceneMgr")
require("Voyage/VoyagePort")
require("Voyage/VoyagePortInfoGoodsItem")
require("Voyage/VoyageRichManMgr")
require("Voyage/VoyagePortInfoDungeonItem")

local this = {
    portInfoRewardList = nil,
    todayDelegateRewardList = nil,
    portConfig = nil,
    todayDelegateQuestId = "",
    spineGO = nil,
    dungeonList = nil,
    soldOut = false,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    songOfBlueBtn = { path = "root/Left/SongOfBlue", type = "Button" },
    rightGroup = { path = "root/Right/Group", type = "GameObject" },
    setSailGO = { path = "root/Right/Group/SetSail", type = "GameObject" },
    setSailBtn = { path = "root/Right/Group/SetSail", type = "Button" },
    sailOnGO = { path = "root/Right/Group/SailOn", type = "GameObject" },
    sailOnBtn = { path = "root/Right/Group/SailOn", type = "Button" },
    formationGO = { path = "root/Right/Group/Formation", type = "GameObject" },
    formationBtn = { path = "root/Right/Group/Formation", type = "Button" },
    tinklyTaleBtn = { path = "root/Middle/TinklyTale", type = "Button" },
    sceneTF = { path = "root/Middle/Scene", type = "RectTransform" },
    middleMaskGO = { path = "root/Middle/Mask", type = "GameObject" },
    middleMaskBtn = { path = "root/Middle/Mask", type = "Button" },
    scenePortGO = { path = "root/Middle/Scene/Container/Port", type = "GameObject" },
    todayDelegateItem = { path = "template/TodayDelegateItem", type = "GameObject" },
    currentPosItem = { path = "template/CurrentPosItem", type = "GameObject" },
    newPortItem = { path = "template/NewPortItem", type = "GameObject" },
    portTF = { path = "root/Middle/Scene/Container/Port", type = "Transform" },
    portInfoGO = { path = "root/PortInfo", type = "GameObject" },
    portInfoTF = { path = "root/PortInfo", type = "RectTransform" },
    portInfoMaskBtn = { path = "root/PortInfo/Mask", type = "Button" },
    portInfo = { path = "root/PortInfo/Info", type = "Transform" },
    portInfoArrow1 = { path = "root/PortInfo/Info/Arrow1", type = "GameObject" },
    portInfoArrow2 = { path = "root/PortInfo/Info/Arrow2", type = "GameObject" },
    portInfoArrow3 = { path = "root/PortInfo/Info/Arrow3", type = "GameObject" },
    portInfoIcon = { path = "root/PortInfo/Info/Icon", type = "Image" },
    portInfoName = { path = "root/PortInfo/Info/Name", type = "Image" },
    portInfoDesc = { path = "root/PortInfo/Info/Desc", type = "Text" },
    portInfoGridCount = { path = "root/PortInfo/Info/GridCount/Text", type = "Text" },
    portInfoPirateCount = { path = "root/PortInfo/Info/PirateCount/Text", type = "Text" },
    portInfoBox0 = { path = "root/PortInfo/Info/Box0", type = "GameObject" },
    portInfoBox1 = { path = "root/PortInfo/Info/Box1", type = "GameObject" },
    portInfoDungeons = { path = "root/PortInfo/Info/Dungeons", type = "GameObject" },
    portInfoDungeonsTitle = { path = "root/PortInfo/Info/Dungeons/Title/Text", type = "Text" },
    portInfoDungeonListTF = { path = "root/PortInfo/Info/Dungeons/List", type = "Transform" },
    dungeonItem = { path = "template/DungeonItem", type = "GameObject" },
    portInfoPlayGO = { path = "root/PortInfo/Info/Play", type = "GameObject" },
    portInfoPlayBtn = { path = "root/PortInfo/Info/Play", type = "Button" },
    portInfoPlayReplay = { path = "root/PortInfo/Info/Play/Repaly", type = "GameObject" },
    portInfoPlayNum = { path = "root/PortInfo/Info/Play/Num", type = "Text" },
    portInfoPlayText = { path = "root/PortInfo/Info/Play/Text", type = "Text" },
    portInfoSpecialityGO = { path = "root/PortInfo/Info/Speciality", type = "GameObject" },
    portInfoSpecialityText = { path = "root/PortInfo/Info/Speciality/Text", type = "Text" },
    portInfoUnknownGO = { path = "root/PortInfo/Info/Unknown", type = "GameObject" },
    goodsItem = { path = "template/GoodsItem", type = "GameObject" },
    portInfoRewardGO = { path = "root/PortInfo/Info/Reward", type = "GameObject" },
    portInfoRewardListTF = { path = "root/PortInfo/Info/Reward/List", type = "Transform" },
    todayDelegateRewardListTF = { path = "root/TodayDelegate/Delegate/Reward/List", type = "Transform" },
    todayDelegateGO = { path = "root/TodayDelegate", type = "GameObject" },
    todayDelegateMaskBtn = { path = "root/TodayDelegate/Mask", type = "Button" },
    todayDelegateTime = { path = "root/TodayDelegate/Delegate/Time/Text", type = "Text" },
    todayDelegateContent = { path = "root/TodayDelegate/Delegate/Content", type = "Text" },
    todayDelegateGotoGO = { path = "root/TodayDelegate/Delegate/Goto", type = "GameObject" },
    todayDelegateGotoBtn = { path = "root/TodayDelegate/Delegate/Goto", type = "Button" },
    todayDelegateReceiveGO = { path = "root/TodayDelegate/Delegate/Receive", type = "GameObject" },
    todayDelegateReceiveBtn = { path = "root/TodayDelegate/Delegate/Receive", type = "Button" },
    time = { path = "root/Middle/Time/Text", type = "Text" },
    moneyBtn = { path = "root/Middle/Money", type = "Button" },
    moneyText = { path = "root/Middle/Money/Text", type = "Text" },
    tradeBtn = { path = "root/PortInfo/Info/Trade", type = "Button" },
    tradeUnlock = { path = "root/PortInfo/Info/Trade/Unlock", type = "GameObject" },
    tradeLock = { path = "root/PortInfo/Info/Trade/Lock", type = "GameObject" },
    tradeSellOut = { path = "root/PortInfo/Info/Trade/SellOut", type = "GameObject" },
    cardsBtn = { path = "root/Middle/Cards", type = "Button" },
    cardsCount = { path = "root/Middle/Cards/Count/Text", type = "Text" },
    enterAniGO = { path = "root/EnterAni", type = "GameObject" },
    enterAniSpineTF = { path = "root/EnterAni/Spine", type = "Transform" },
    enterAniSpine = { path = "root/EnterAni/Spine", type = "UISpineCharacter" },
    novelBtn = { path = "root/Middle/Novel", type = "Button" },
    tradePriceBtn = { path = "root/Middle/TradePrice", type = "Button" },
};


this.SetData = function()
    local sailing = DataMgr.Player.Sailing;
    if (not IsNullOrEmpty(sailing.HarborID) and sailing.Status == VoyageRichManStatus.Opening) then
        SetActive(this.setSailGO, false);
        SetActive(this.sailOnGO, true);
        SetActive(this.formationGO, false);
    else
        SetActive(this.setSailGO, true);
        SetActive(this.sailOnGO, false);
        SetActive(this.formationGO, false);
    end
    this.portConfig = nil;
    SetActive(this.portInfoGO, false);
    SetActive(this.todayDelegateGO, false);
    this.SetMoney();
    this.SetCards();
end


this.SetEnterAni = function()
    if (this.spineGO == nil) then
        local path = "Assets/_BundleResources/UI/KV/KVHH.prefab";
        this.spineGO = LuaMgr.GetPrefab(path);
        this.spineGO.transform:SetParent(this.enterAniSpineTF, false);
        this.enterAniSpine:SetDrawing();
    end
    SetActive(this.enterAniGO, true);
    this.enterAniSpine:Play("idle", false, nil);
    this.PlayUIAni("UI_VoyagePanel_01");
end


this.PlayUIAni = function(aniName)
    this.animator.Loop = false;
    this.animator.AnimationName = aniName;
end


this.DestroyEnterAni = function()
    this.enterAniSpine = nil;
    if (this.spineGO ~= nil) then
        LuaMgr.Destroy(this.spineGO);
        this.spineGO = nil;
    end
end


this.SetMoney = function()
    local money = PlayerVoyageMgr.GetMoney();
    this.moneyText.text = LuaMgr.NumFormat(tostring(money));
    PlayerVoyageMgr.CheckRedDot();
end


this.SetCards = function()
    local count = PlayerVoyageMgr.GetUnlockCardCount();
    local cards = ConfigVoyageMgr.GetCards();
    this.cardsCount.text = string.format("<color=#4be1dc>%d</color>/%d", count, #cards);
end


this.CheckInterest = function()
    if (DataMgr.Player.SailingPropertyInterest > 0) then
        LuaMgr.ShowLuaPanel(UIName.VoyageInterestViewModel);
    end
end


this.SetTime = function()
    local sailing = DataExHelper.GetDataExByTag(ActivityKey.sailing);
    if (sailing == nil) then return end
    
    local time = sailing.expireTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, _ = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    this.time.text = string.format(ConfigMgr.LangGlobal("10461"), timeStr);
end


this.CheckFormation = function(portConfig)
    local status = false;
    local sailing = DataMgr.Player.Sailing;
    if (IsNullOrEmpty(sailing.HarborID) or sailing.Status ~= VoyageRichManStatus.Opening) then
        if (not PlayerVoyageMgr.IsPortLock(portConfig.HarborID) and 
                not ConfigVoyageMgr.IsPortTimeout(portConfig.HarborID)) then
            status = true;
        end
    end
    if (status) then
        SetActive(this.setSailGO, false);
        SetActive(this.formationGO, true);
    else
        SetActive(this.setSailGO, true);
        SetActive(this.formationGO, false);
    end
end


this.SailHandler = function(portConfig)
    if (portConfig == nil) then
        portConfig = PlayerVoyageMgr.GetCurrentPort();
        if (portConfig ~= nil) then
            this.SetPortInfo(portConfig);
            this.CheckFormation(portConfig);
        end
        this.SetPortLight();
    else
        local sailing = DataMgr.Player.Sailing;
        if (IsNullOrEmpty(sailing.HarborID) or sailing.Status ~= VoyageRichManStatus.Opening) then
            if (PlayerVoyageMgr.IsPortLock(portConfig.HarborID)) then
                local harborPre = ConfigVoyageMgr.GetHarborPre(portConfig.HarborID);
                if (harborPre ~= nil) then
                    local msg = string.format(ConfigMgr.LangGlobal("10455"), LuaMgr.GetLangText(harborPre.HarborNameLan));
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg);
                end
                return;
            end
            if (ConfigVoyageMgr.IsPortTimeout(portConfig.HarborID)) then
                return;
            end
            local sailingLastCaptain = DataMgr.Player.SailingLastCaptain;
            if (not IsNullOrEmpty(sailingLastCaptain)) then
                PlayerVoyageMgr.SetCaptain(sailingLastCaptain);
            end
            this.SetLastMembers();
            LuaMgr.ShowLuaPanel(UIName.VoyageSelectCharacterViewModel, portConfig);
            return;
        end
        if (sailing.Status == VoyageRichManStatus.Opening) then
            if (portConfig.HarborID == sailing.HarborID) then
                VoyageRichManMgr.OpenHarbor(false);
                LuaMgr.ShowLuaPanel(UIName.VoyageLoadingViewModel);
            else
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal("10460"), this.OnConfirmDrop, nil);
            end
        end
    end
end


this.SetLastMembers = function()
    local members = {};
    local sailingLastCharsCopy = DataMgr.Player.SailingLastCharsCopy;
    for k, _ in pairs(sailingLastCharsCopy) do
        table.insert(members, k);
    end
    PlayerVoyageMgr.SetSelectMembers(members);
end


this.OnBack = function()
    if (DataExHelper.Check_Sailing()) then
        LuaMgr.Back(ActivityKey.sailing);
    else
        LuaMgr.Back();
    end
end


this.OnClickSongOfBlue = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageQuestViewModel);
end


this.OnClickSetSail = function()
    this.SailHandler(this.portConfig);
end


this.OnClickSailOn = function()
    this.SailHandler(this.portConfig);
end


this.OnClickFormation = function()
    this.SailHandler(this.portConfig);
end


this.OnClickTinklyTale = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageMailViewModel);
end


this.OnClickPortInfoMask = function()
    this.portConfig = nil;
    SetActive(this.portInfoGO, false);
    LuaMgr.RemoveCanvas(this.rightGroup);
end


this.OnClickPortInfoPlay = function()
    VoyageSceneMgr.PlayNovel(this.portConfig);
    this.OnClickPortInfoMask();
end


this.OnConfirmDrop = function()
    PlayerVoyageMgr.Drop(this.DropResponse);
end


this.DropResponse = function(result)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageViewModel_0"));
    this.OnClickPortInfoMask();
    this.SetData();
    VoyageSceneMgr.SetCurrentPos();
end


this.SetPortInfo = function(portConfig)
    this.portConfig = portConfig;
    PlayerVoyageMgr.GoodsStatus(portConfig.HarborID, this.GoodsStatusResponse);
end


this.GoodsStatusResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        this.soldOut = data.result.SoldOut;
    end
    this.ShowPortInfo();
end


this.ShowPortInfo = function()
    LuaMgr.AddCanvas(this.rightGroup, 4);
    local index = ConfigVoyageMgr.GetPortIndex(this.portConfig.HarborID);
    local infoPos = VoyageSceneMgr.GetPortInfoPos(index);
    local pos = RectTransformTool.ToContainer(infoPos, this.portInfoTF);
    this.portInfo.localPosition = Vector3(pos.x, pos.y, 0);
    SetActive(this.portInfoArrow1, false);
    SetActive(this.portInfoArrow2, false);
    SetActive(this.portInfoArrow3, false);
    if (index == 4) then
        SetActive(this.portInfoArrow2, true);
    elseif (index == 6) then
        SetActive(this.portInfoArrow3, true);
    else
        SetActive(this.portInfoArrow1, true);
    end
    if (PlayerVoyageMgr.IsPortLock(this.portConfig.HarborID)) then
        this.portInfoIcon.sprite = LuaMgr.GetSprite(this.portConfig.ResID, this.portConfig.HarborLockIcon);
    else
        this.portInfoIcon.sprite = LuaMgr.GetSprite(this.portConfig.ResID, this.portConfig.HarborUnlockIcon);
    end
    this.portInfoName.sprite = LuaMgr.GetSprite(this.portConfig.ResID, this.portConfig.HarborIcon);
    this.portInfoDesc.text = LuaMgr.GetLangText(this.portConfig.HarborDesLan);





    this.portInfoSpecialityText.text = LuaMgr.GetLangText(this.portConfig.HarborGoodsLan);
    SetActive(this.portInfoSpecialityGO, true);
    SetActive(this.portInfoUnknownGO, false);
    if (PlayerVoyageMgr.IsPortPass(this.portConfig.HarborID)) then
        this.portInfoRewardList:Clear();
        this.SetNovelInfo();
        SetActive(this.portInfoRewardGO, false);
        SetActive(this.portInfoPlayGO, true);
    else
        this.SetPortInfoReward();
        SetActive(this.portInfoPlayGO, false);
    end
    this.SetTrade();
    this.SetDungeons();
    SetActive(this.portInfoGO, true);
end


this.SetNovelInfo = function()
    local narrative = ConfigMgr.Config.narrativeMap[this.portConfig.NovelID];
    if (narrative ~= nil) then
        local index = ConfigVoyageMgr.GetPortIndex(this.portConfig.HarborID);
        this.portInfoPlayNum.text = "0" .. index;
        this.portInfoPlayText.text = LuaMgr.GetLangText(narrative.nameLan);
    else
        this.portInfoPlayNum.text = "";
        this.portInfoPlayText.text = "";
    end
end


this.SetTrade = function()
    local sailing = DataMgr.Player.Sailing;
    if ((IsNullOrEmpty(sailing.HarborID) or sailing.Status ~= VoyageRichManStatus.Opening)
            and PlayerVoyageMgr.IsCurrentPos(this.portConfig.HarborID)
            and not PlayerVoyageMgr.IsPortLock(this.portConfig.HarborID)
            and PlayerVoyageMgr.IsPortPass(this.portConfig.HarborID)) then
        SetActive(this.tradeUnlock, true);
        SetActive(this.tradeLock, false);
    else
        SetActive(this.tradeUnlock, false);
        SetActive(this.tradeLock, true);
    end
    SetActive(this.tradeSellOut, this.soldOut);
end


this.SetDungeons = function()
    this.dungeonList:Clear();
    local listData;
    local listDatas = {};
    local dungeons = ConfigVoyageMgr.GetEventPoolDungeons(this.portConfig.EventPool[1][1]);
    local len = #dungeons;
    for i = 1, len do
        listData = UIListData.GetData(this.dungeonItem, "VoyagePortInfoDungeonItem", dungeons[i]);
        table.insert(listDatas, listData);
    end
    this.dungeonList:SetData(listDatas);
    local harborID = this.portConfig.HarborID;
    if (harborID == "101" or harborID == "102" or harborID == "103") then
        this.portInfoDungeonsTitle.text = ConfigMgr.LangGlobal("10493");
    else
        this.portInfoDungeonsTitle.text = ConfigMgr.LangGlobal("10494");
    end
end


this.OnPortInfo = function(args)
    local portConfig = args[0];
    this.SetPortInfo(portConfig);
    this.CheckFormation(portConfig);
    this.SetPortLight();
end


this.SetPortInfoReward = function()
    this.portInfoRewardList:Clear();
    local len = #this.portConfig.FirstReward;
    if (len > 0) then
        local listData;
        local listDatas = {};
        for i = 1, len do
            listData = UIListData.GetData(this.goodsItem, "VoyagePortInfoGoodsItem", this.portConfig.FirstReward[i]);
            table.insert(listDatas, listData);
        end
        this.portInfoRewardList:SetData(listDatas);
        SetActive(this.portInfoRewardGO, true);
    else
        SetActive(this.portInfoRewardGO, false);
    end
end


this.OnClickTodayDelegateMask = function()
    SetActive(this.todayDelegateGO, false);
end


this.OnTodayDelegate = function()
    local questData = PlayerVoyageMgr.GetTodayDelegateQuest();
    if (questData == nil) then return end

    this.todayDelegateQuestId = questData.ID;
    local questConfig = ConfigVoyageMgr.GetQuestById(questData.ID);
    if (questConfig == nil) then return end
    
    this.SetTodayDelegateReward(questConfig);
    this.SetTodayDelegateTime(questData);
    this.todayDelegateContent.text = LuaMgr.GetLangText(questConfig.QuestDesLan);
    if (questData.Status == 0) then
        SetActive(this.todayDelegateGotoGO, true);
        SetActive(this.todayDelegateReceiveGO, false);
    elseif (questData.Status == 1) then
        SetActive(this.todayDelegateGotoGO, false);
        SetActive(this.todayDelegateReceiveGO, true);
    else
        SetActive(this.todayDelegateGotoGO, false);
        SetActive(this.todayDelegateReceiveGO, false);
    end
    SetActive(this.todayDelegateGO, true);
end


this.SetTodayDelegateTime = function(questData)
    local time = questData.NextResetTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, m = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.todayDelegateTime.text = string.format(timeStr);
end


this.SetTodayDelegateReward = function(questConfig)
    this.todayDelegateRewardList:Clear();
    local listData;
    local listDatas = {};
    local len = #questConfig.RewardItems;
    for i = 1, len do
        listData = UIListData.GetData(this.goodsItem, "VoyagePortInfoGoodsItem", questConfig.RewardItems[i]);
        table.insert(listDatas, listData);
    end
    this.todayDelegateRewardList:SetData(listDatas);
end


this.OnClickTodayDelegateGoto = function()
    local questConfig = ConfigVoyageMgr.GetQuestById(this.todayDelegateQuestId);
    if (questConfig == nil) then return end

    local portConfig = ConfigVoyageMgr.GetPortConfig(questConfig.HarborID);
    if (portConfig == nil) then return end
    
    this.SailHandler(portConfig);
end


this.OnClickTodayDelegateReceive = function()
    local questData = PlayerVoyageMgr.GetQuestData(this.todayDelegateQuestId);
    if (questData == nil) then return end

    if (questData.Status == 0) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageViewModel_1"));
        return;
    end
    PlayerVoyageMgr.GetQuestionReward(questData.ID, this.GetQuestionRewardResponse);
end


this.GetQuestionRewardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local reward = json.encode(data.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        this.OnTodayDelegate();
        VoyageSceneMgr.SetPorts();
    end
end


this.OnAniPlayFinish = function(args)
    if (args.Length <= 0) then return end
    
    local aniName = args[0];
    if (aniName == "UI_VoyagePanel_01") then
        VoyageSceneMgr.SetTodayDelegate();
        VoyageSceneMgr.SetCurrentPos();
        VoyageSceneMgr.SetNewPort();
        this.animator.Loop = true;
        this.animator.AnimationName = "UI_VoyagePanel_02";
        this.CheckInterest();
    elseif (aniName == "UI_VoyagePanel_03") then
        this.animator.Loop = true;
        this.animator.AnimationName = "UI_VoyagePanel_02";
    end
end


this.SetPortLight = function()
    SetActive(this.middleMaskGO, true);
    VoyageSceneMgr.SetScale(false);
    RaycastTool.AddCanvas(this.scenePortGO, 2);
end


this.OnClickMiddleMask = function()
    SetActive(this.middleMaskGO, false);
    VoyageSceneMgr.SetScale(true);
    RaycastTool.RemoveCanvas(this.scenePortGO);
    LuaMgr.ClearNormalParams(UIName.VoyageViewModel);
    this.SetData();
end


this.OnClickMoney = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageRewardsViewModel);
end


this.OnClickTrade = function()
    local sailing = DataMgr.Player.Sailing;
    if (not IsNullOrEmpty(sailing.HarborID) and sailing.Status == VoyageRichManStatus.Opening) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageViewModel_6"));
        return;
    end
    if (PlayerVoyageMgr.IsPortLock(this.portConfig.HarborID)) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageViewModel_7"));
        return;
    end
    if (not PlayerVoyageMgr.IsPortPass(this.portConfig.HarborID)) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageViewModel_8"));
        return;
    end
    if (not PlayerVoyageMgr.IsCurrentPos(this.portConfig.HarborID)) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("VoyageViewModel_9"));
        return;
    end
    PlayerVoyageMgr.GetSailingGoodsPrice();
end


this.OnClickCards = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageCardsViewModel);
end


this.OnClickNovel = function()
    LuaMgr.PlayNovel("E010001", this.OnNovel);
end


this.OnNovel = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
end


this.OnClickTradePrice = function()
    PlayerVoyageMgr.Market();
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.songOfBlueBtn, this.OnClickSongOfBlue);
        LuaMgr.AddClick(this.setSailBtn, this.OnClickSetSail);
        LuaMgr.AddClick(this.sailOnBtn, this.OnClickSailOn);
        LuaMgr.AddClick(this.formationBtn, this.OnClickFormation);
        LuaMgr.AddClick(this.tinklyTaleBtn, this.OnClickTinklyTale);
        LuaMgr.AddClick(this.portInfoMaskBtn, this.OnClickPortInfoMask);
        LuaMgr.AddClick(this.portInfoPlayBtn, this.OnClickPortInfoPlay);
        LuaMgr.AddClick(this.todayDelegateMaskBtn, this.OnClickTodayDelegateMask);
        LuaMgr.AddClick(this.todayDelegateGotoBtn, this.OnClickTodayDelegateGoto);
        LuaMgr.AddClick(this.todayDelegateReceiveBtn, this.OnClickTodayDelegateReceive);
        LuaMgr.AddClick(this.middleMaskBtn, this.OnClickMiddleMask);
        LuaMgr.AddClick(this.moneyBtn, this.OnClickMoney);
        LuaMgr.AddClick(this.tradeBtn, this.OnClickTrade);
        LuaMgr.AddClick(this.cardsBtn, this.OnClickCards);
        LuaMgr.AddClick(this.novelBtn, this.OnClickNovel);
        LuaMgr.AddClick(this.tradePriceBtn, this.OnClickTradePrice);
        this.portInfoRewardList = UIListView.New(this.portInfoRewardListTF);
        this.todayDelegateRewardList = UIListView.New(this.todayDelegateRewardListTF);
        this.dungeonList = UIListView.New(this.portInfoDungeonListTF);
        VoyageSceneMgr.Init(this.sceneTF, this.todayDelegateItem, this.currentPosItem, this.newPortItem);
        RedMgr.Singleton:RegisterViewModel(UIName.VoyageViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        vm.behaviour:UpdateTopBar("", this.OnBack);
        LuaMgr.AddUIEventListener(UIEventConst.VoyagePortInfo, this.OnPortInfo);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageTodayDelegate, this.OnTodayDelegate);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageRefreshInterest, this.SetMoney);
        LuaMgr.AddUIEventListener(UIEventConst.VoyageCardsUnlock, this.SetCards);
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        VoyageSceneMgr.Show();
        local paramsLen = vm.behaviour.Params.Length;
        this.SetData();
        this.SetTime();
        SetActive(this.middleMaskGO, false);
        if (paramsLen >= 2) then
            local portConfig = vm.behaviour.Params[1];
            if (portConfig ~= nil) then
                this.SetPortInfo(portConfig);
                this.CheckFormation(portConfig);
                this.SetPortLight();
            else
                this.SailHandler(nil);
            end
        end
        if (paramsLen == 0) then
            this.SetEnterAni();
        else
            SetActive(this.enterAniGO, false);
            this.PlayUIAni("UI_VoyagePanel_03");
            VoyageSceneMgr.SetCurrentPos();
            VoyageSceneMgr.SetNewPort();
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyagePortInfo, this.OnPortInfo);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageTodayDelegate, this.OnTodayDelegate);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageRefreshInterest, this.SetMoney);
        LuaMgr.RemoveUIEventListener(UIEventConst.VoyageCardsUnlock, this.SetCards);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        this.portInfoRewardList:Clear();
        this.todayDelegateRewardList:Clear();
        this.dungeonList:Clear();
        VoyageSceneMgr.Clear();
        LuaMgr.RemoveCanvas(this.rightGroup);
        LuaMgr.RemoveCanvas(this.scenePortGO);
        this.portConfig = nil;
        this.portInfoName.sprite = nil;
        this.portInfoIcon.sprite = nil;
    end,
    before_destroy = function()
        VoyageSceneMgr.Destroy();
        LuaMgr.RemoveClick(this.songOfBlueBtn, this.OnClickSongOfBlue);
        LuaMgr.RemoveClick(this.setSailBtn, this.OnClickSetSail);
        LuaMgr.RemoveClick(this.sailOnBtn, this.OnClickSailOn);
        LuaMgr.RemoveClick(this.formationBtn, this.OnClickFormation);
        LuaMgr.RemoveClick(this.tinklyTaleBtn, this.OnClickTinklyTale);
        LuaMgr.RemoveClick(this.portInfoMaskBtn, this.OnClickPortInfoMask);
        LuaMgr.RemoveClick(this.portInfoPlayBtn, this.OnClickPortInfoPlay);
        LuaMgr.RemoveClick(this.todayDelegateMaskBtn, this.OnClickTodayDelegateMask);
        LuaMgr.RemoveClick(this.todayDelegateGotoBtn, this.OnClickTodayDelegateGoto);
        LuaMgr.RemoveClick(this.todayDelegateReceiveBtn, this.OnClickTodayDelegateReceive);
        LuaMgr.RemoveClick(this.middleMaskBtn, this.OnClickMiddleMask);
        LuaMgr.RemoveClick(this.moneyBtn, this.OnClickMoney);
        LuaMgr.RemoveClick(this.tradeBtn, this.OnClickTrade);
        LuaMgr.RemoveClick(this.cardsBtn, this.OnClickCards);
        LuaMgr.RemoveClick(this.novelBtn, this.OnClickNovel);
        LuaMgr.RemoveClick(this.tradePriceBtn, this.OnClickTradePrice);
        UIListView.ClearItem("VoyagePortInfoGoodsItem");
        UIListView.ClearItem("VoyagePortInfoDungeonItem");
        this.DestroyEnterAni();
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
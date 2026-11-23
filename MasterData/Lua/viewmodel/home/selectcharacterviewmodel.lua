require("ViewModel/Home/SelectCharacter_HeadList")
require("ViewModel/Home/SelectCharacter_HeadItem")
require("ViewModel/Home/SelectCharacter_SkinItem")
require("ViewModel/Home/SelectCharacter_BgItem")
require("ViewModel/Home/SelectCharacter_MainUIItem")
require("ViewModel/Home/SelectCharacter_HeroMsgItem")
require("ViewModel/Home/SelectCharacter_WheelItem")
require("ViewModel/Home/SelectCharacter_KVItem")
require("ViewModel/Home/SelectCharacter_DrawCardItem")


local this = {
    vm = nil,
    headScrollViewList = nil,
    headListItemObj = nil,
    headItemObj = nil,
    skinUIList = nil,
    skinItemObj = nil,
    bgPath = "Assets/_BundleResources/Images/Home/%s.png",
    bgScrollView = nil,
    bgItem = nil,
panel = 0,
    bgSwitchList = {},
timeSort = 1,
    selectBgId = nil,
    isBgLock = false,
    selectUIMainId = nil,
    mainUIScrollView = nil,
    mainUIList = nil,
    mainUIItem = nil,
    mainUISortUp = false,
    curSkinId = nil,

directPreviewBgId = "",
    msgToggle = false,
    msgSortUp = false,
    msgScroll = nil,
    msgTemplate = nil,
    curSelectMsgID = nil,
    msgScrollMoveToIndex = nil,
    characterLine = nil,

    wheelHeroList={};
    wheelHeroItemObj=nil;
    kvScrollView=nil;

    drawCardScroll = nil,
    drawCardTemplate = nil,
    selectDrawCardId = nil,
    selectDrawCardState = nil,
}

local itemContent = nil
local skinItemContent = nil
local spineCharacter = nil

local starStatus = 0
local timeStatus = 0


local characterDatasCache = nil

local ROWCOUNT = 4
local jobIndex = nil;
local characterId = nil;
local backgroundSkin = nil;
local lastIndexData = nil;

local data = {
    selectStar = DefaultSprite,
    isStarArrow = false,
    starScale = Vector3.zero,

    selectTime = DefaultSprite,
    isTimeArrow = false,
    timeScale = Vector3.zero,

    bodyPath = "",
    characterName = "",
    characterSkinName = "",
    skinBgSizeData = Vector2(0, 0),
    jobsList = {
        { isSelect = false }, { isSelect = false }, { isSelect = false }, { isSelect = false }, { isSelect = false }, { isSelect = false },
    },
    bgTexture = DefaultTexture,
    isOperateBtn = false,
    isBgmBtn = false,
    isBgBtn = false,
    bgBtnText = "",
    isShowCharacter = false,
    isShowSkin = false,
    isShowGroup = false,
    isShowBgGroup = false,
    isBgRole = false,
    isBgRoleShow = false,
    isBgRoleHide = false,
    bgTimeText = "",
    bgTimeArrowDown = false,
    bgTimeArrowUp = false,
    bgConfirmText = "",
    bgTimeBtnActive = false,
    bgConfirmBtnActive = false,

    isMainUIGroup = false,
    isShowUIMainBtn = false,
    mainUITimeArrowDown = false,
    mainUITimeArrowUp = false,
    mainUIRaw = DefaultTexture,

    isMsgGroup = false,
    isMsgBtn = false,
    msgText = "",
    msgTimeArrowDown = false,
    msgTimeArrowUp = false,
    msgToggleText = "",
    msgConfirmText = "",
    isToggle = false,
    msgLineStrText = "",
    msgLineStrSkin = DefaultSprite,
    isMsgRed = false,
    msgToggleIsShow = false,
    wheelSkinPro="";
    
    isKVGroup=false;
    isKVButton=false;
    
    drawCardPic = DefaultTexture,
    isDrawCardGroup = false,
    isDrawCard = false,
    isDrawCardText = "",
}

local command = {
    jobCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local job = tonumber(param) + 1;
            this.SetJobType(job)
        end
    },
    starCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickStar()
        end
    },
    timeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickTime()
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickConfirm()
        end
    },
    jumpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            HeroParameter.SaveKanBanNiang(characterId, backgroundSkin)
            LuaMgr.ShowLuaPanel(UIName.AdjustSpineViewModel, characterId, backgroundSkin);
        end
    },
    bgCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetPanel(1);
        end
    },
    bgConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (DataMgr.Player.currentBgImage == this.selectBgId) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15965"));
                return;
            end
            if (this.isBgLock) then
                LuaMgr.ShowLuaPanel(UIName.BackgroundUnlockViewModel, this.selectBgId);
                return;
            end
            this.UpdateBgImage(this.selectBgId);
        end
    },
    bgTimeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetTimeSort(this.timeSort == 1 and 2 or 1);
            this.SetBgScrollView();
        end
    },
    bgmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetBGM()
        end
    },
    bgRoleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local isShowCharacter = this.vm.data.isShowCharacter;
            if (isShowCharacter) then
                this.vm.data.isShowCharacter = false;
                this.vm.data.isBgRoleShow = true;
                this.vm.data.isBgRoleHide = false;
            else
                this.vm.data.isShowCharacter = true;
                this.vm.data.isBgRoleShow = false;
                this.vm.data.isBgRoleHide = true;
            end
        end
    },
    mainUITimeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.mainUISortUp = not this.mainUISortUp;
            this.MainUISortTime();
            this.SetMainUIScrollView()
        end
    },
    mainUICommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetPanel(2);

            local firstkey = DataMgr.Player.uid .. "_MianUISwitch_FirstShow"
            if not PlayerPrefs.HasKey(firstkey) or PlayerPrefs.GetInt(firstkey) == 0 then
                PlayerPrefs.SetInt(firstkey, 1)
                PlayerPrefs.Save();
                MainPageViewModelRed.CheckQHRedStatus()
                RedMgr.Singleton:Refresh();
            end
        end
    },
    mainUIConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local select = this.mainUIList[this.mainUIIndex]
            if select.ID == this.curSkinId then
                return;
            end
            ApiMgr.Request("uiskin/use", { ID = select.ID }, true, function(re)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("1302"));
                LuaMgr.ClearVM("MainPageViewModel")
                this.SetMainUI();
            end, nil, true);
        end
    },
    msgCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetPanel(3);
        end
    },
    msgTimeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.msgSortUp = not this.msgSortUp
            this.vm.data.msgTimeArrowDown = not this.msgSortUp
            this.vm.data.msgTimeArrowUp = this.msgSortUp
            this.SetMsgView()
        end
    },
    msgConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SaveMsgConfirm()
        end
    },
    msgToggleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.msgToggle = not this.msgToggle
            this.vm.data.isToggle = this.msgToggle
        end
    },
    loginBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetPanel(4);
        end
    },
    KVTimeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetTimeSort(this.timeSort == 1 and 2 or 1);
            this.SetKVScrollView();
        end
    },
    KVConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           local kvName=this.KVList[this.kvIndex].KV;
            local key="LOGINKV_NAME";
            PlayerCharacterMgr.UpdateLoginKV(kvName,function()
                UnityEngine.PlayerPrefs.SetString(key,kvName);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("30258"));
                this.SetKVScrollView();
            end)
        end
    },
    drawCardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SetPanel(5);
        end
    },
    drawCardConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if IsNullOrEmpty(this.selectDrawCardId) then
                return
            end
            if DataMgr.Player.GachaSkin == this.selectDrawCardId then
                return
            end
            if not this.selectDrawCardState then
                local tempData = {}
                tempData.id = this.selectDrawCardId
                ApiMgr.Request("select_gachaskin", tempData,true,function(result)
                    local re = json.decode(result)
                    if re.code == 0 then
                        for i = 1, #this.drawCardScroll.dataList do
                            this.drawCardScroll.dataList[i].data.select = false
                        end
                        this.drawCardScroll:Refresh()
                        this.selectDrawCardId = nil
                        local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["25607"].NameLan)
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
                    end
                end,nil,true)
            end
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm = vm;

        RedMgr.Singleton:RegisterViewModel(UIName.SelectCharacterViewModel);
        spineCharacter = this.vm.behaviour.transform:Find("root/Middle/Character/Group/Body"):GetComponent(
        "UISpineCharacter")
        itemContent = this.vm.behaviour.transform:Find("root/Right/Group/HeadScrollView")
        skinItemContent = this.vm.behaviour.transform:Find("root/Left/skin/ScrollView/Viewport/Content")
        this.headScrollViewList = UIScrollView.New(itemContent.gameObject);
        this.skinUIList = UIListView.New(skinItemContent);
        this.headItemObj = this.vm.behaviour.transform:Find("template/HeadItem").gameObject;
        this.headListItemObj = this.vm.behaviour.transform:Find("template/ListHeadItem").gameObject;
        this.skinItemObj = this.vm.behaviour.transform:Find("template/SkinItem").gameObject;
        this.bgScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Right/BgGroup/BgScrollView").gameObject);
        this.bgItem = vm.behaviour.transform:Find("template/BgItem").gameObject;
        this.mainUIScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Right/mianUIGroup/mainUIScrollView")
        .gameObject);
        this.mainUIItem = vm.behaviour.transform:Find("template/MainUIItem").gameObject;
        this.animator = vm.behaviour.transform:Find("root"):GetComponent("Animator");
        this.msgScroll = UIScrollView.New(vm.behaviour.transform:Find("root/Right/MsgGroup/MsgScroll").gameObject)
        this.msgTemplate = vm.behaviour.transform:Find("template/HeroMsgItem").gameObject
        this.tranWheelContent=vm.behaviour.transform:Find("root/Right/Group/selectedScrollView/ScrollView/Viewport/Content");
        this.wheelHeroList=UIListView.New(this.tranWheelContent)
        this.wheelHeroItemObj=vm.behaviour.transform:Find("template/wheelHeroItem").gameObject
        this.kvScrollView=UIScrollView.New(vm.behaviour.transform:Find("root/Right/KVGroup/KVScrollView").gameObject);
        this.kvItemObj=vm.behaviour.transform:Find("template/KVItem").gameObject;
        this.tansKV=vm.behaviour.transform:Find("root/Middle/LoginKV");
        this.drawCardScroll = UIScrollView.New(vm.behaviour.transform:Find("root/Right/DrawGroup/DrawScroll").gameObject)
        this.drawCardTemplate = vm.behaviour.transform:Find("template/DrawCardItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetLanguageText()
        this.animator:Play("UI_SelectCharacterPanel_01", 0, 0)
        LuaMgr.AddUIEventListener(UIEventConst.SelectCharacterSelectBg, this.OnSelectBg);
        LuaMgr.AddUIEventListener(UIEventConst.SelectCharacterRefreshBg, this.OnRefreshBg);
        this.isKVOpen=false;
        local kvOpenTime=ConfigMgr.Config.constants.KVOpenTime
        if kvOpenTime~=nil and LuaMgr.Timestamp()>=kvOpenTime then
            this.isKVOpen=true;
        end
        jobIndex = nil;
        starStatus = -1
        timeStatus = 0
        lastIndexData = nil;
        characterId = PlayerSkinMgr.GetCharacterId()
        backgroundSkin = PlayerSkinMgr.GetSkinId()
        if vm.behaviour.IsPop then
            characterId = HeroParameter.kanBanNiang_character;
            backgroundSkin = HeroParameter.kanBanNiang_characterSkin
            HeroParameter.EmptyKanBanNiang();
            if characterId == nil then
                characterId = PlayerSkinMgr.GetCharacterId()
            end
            if backgroundSkin == nil then
                backgroundSkin = PlayerSkinMgr.GetSkinId()
            end
        end
        this.mainUISortUp = true;

        this.directPreviewBgId = ""
        if (vm.behaviour.Params.Length > 0) and (vm.behaviour.Params.Length < 2) then
            this.directPreviewBgId = vm.behaviour.Params[0];
            vm.behaviour:UpdateTopBar("Preview", this.OnPreviewBgBack);
        else
            vm.behaviour:UpdateTopBar("", this.OnBack);
        end

        if this.CheckIsDirectPreviewBg() then
            this.SetText();
            this.SetPanel(1);
            this.SetBgPic(this.bgSwitchList[1].config);
            this.SetBody(backgroundSkin);
            this.vm.data.isShowCharacter = false;
            this.vm.data.isBgRoleShow = true;
            this.vm.data.isBgRoleHide = false;
        else
            this.SetText();
            if vm.behaviour.Params.Length == 2 then
                this.SetPanel(3)
            else
                this.SetPanel(0);
            end
            this.selectSkinList = {}
            this.oldSelectMap = {}
            local infos = DataMgr.Player.backgroundData.BackgroundInfos
            if infos ~= nil and #infos > 0 then
                for i, v in ipairs(infos) do
                    local wheelData = { CharacterID = v.CharacterID, Skin = v.Skin }
                    if (v.Skin == nil or v.Skin == "" or v.Skin == "null") then
                        wheelData = { CharacterID = v.CharacterID, Skin = v.CharacterID .. "001" }
                    end
                    table.insert(this.selectSkinList, wheelData)
                    this.oldSelectMap[wheelData.Skin]=true;
                end
            else
                LuaDebug.error("DataMgr.Player.backgroundData.BackgroundInfos数据为空，请检查相关逻辑")
            end
            this.SetBody(backgroundSkin);
            this.SetSkinHeads(backgroundSkin);
            this.SetWheelHeroList();
           end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.RemoveUIEventListener(UIEventConst.SelectCharacterSelectBg, this.OnSelectBg);
        LuaMgr.RemoveUIEventListener(UIEventConst.SelectCharacterRefreshBg, this.OnRefreshBg);
        spineCharacter:Clear();
        this.headScrollViewList:Clear(true);
        this.skinUIList:Clear(true);
        this.bgScrollView:Clear(true);
        this.mainUIScrollView:Clear(true);
        this.msgScroll:Clear(true);
        this.drawCardScroll:Clear(true);
        this.selectBgId = nil;
        this.wheelHeroList:Clear();
        this.kvScrollView:Clear();
        LuaMgr.CheckRefCount();
    end,
    before_destroy = function()
        UIScrollView.ClearItem("SelectCharacter_HeadList")
        UIListView.ClearItem("SelectCharacter_HeadItem")
        UIListView.ClearItem("SelectCharacter_SkinItem")
        UIScrollView.ClearItem("SelectCharacter_BgItem")
        UIScrollView.ClearItem("SelectCharacter_MainUIItem")
        UIScrollView.ClearItem("SelectCharacter_HeroMsgItem")
        UIScrollView.ClearItem("SelectCharacter_DrawCardItem")
        UIListView.ClearItem("SelectCharacter_WheelItem")
        UIScrollView.ClearItem("SelectCharacter_KVItem");
        this = nil
    end
}

this.SetLanguageText = function()
    this.vm.data.msgText = ConfigMgr.LangGlobal("25602")
    this.vm.data.msgToggleText = ConfigMgr.LangGlobal("25605")
    this.vm.data.msgConfirmText = ConfigMgr.LangGlobal("25604")
    this.vm.data.isDrawCardText = ConfigMgr.LangGlobal("31207")
end

this.SetJobType = function(index)
    if jobIndex == index then return end;
    for i, v in ipairs(this.vm.data.jobsList) do
        v.isSelect = i == index
    end
    jobIndex = index;
    lastIndexData = nil;
    this.SetCharactersData();
    this.SetType(starStatus, timeStatus);
    this.SetHeadScrollView();
end


this.SetCharactersData = function()
    local characters = DataMgr.Player.characters
    characterDatasCache = {}
    for k, item in pairs(characters) do
        local config = ConfigMgr.Config.characterTable[item.id]
        if config ~= nil and config.Switch == 0 and LuaMgr.Timestamp() >= config.UnlockDate then
            if jobIndex == 1 or jobIndex == config.job + 1 then
                local data = {
                    id = config.id,
                    icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(config.id)),
                    name = LuaMgr.GetLangText(config.namelan),
                    level = item.level,
                    rare = HeroMgr.GetHeroNowRare(item.id),
                    time = item.createTime,
                    select = false
                }
                table.insert(characterDatasCache, data)
            end
        end
    end
end

this.SetBody = function(skinId)
    if characterId == nil then
        return
    end
    if skinId == nil then
        skinId = DataMgr.Player.backgroundSkin;
        if skinId == nil then
            local character = ConfigCharacterMgr.GetCharacter(characterId)
            skinId = character.curSkin
        end
    end
    backgroundSkin = skinId;
    local path = HeroManager.SetCharacterDrawing(spineCharacter, characterId, skinId)
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
    LuaMgr.CheckRefCount();
end



this.SetType = function(star, time)
    starStatus = star
    timeStatus = time
    this.vm.data.selectStar = LuaMgr.GetSprite("CommonRes", starStatus ~= 0 and "ui_home_kbn_bt2" or "ui_home_kbn_bt3")
    this.vm.data.selectTime = LuaMgr.GetSprite("CommonRes", timeStatus ~= 0 and "ui_home_kbn_bt2" or "ui_home_kbn_bt3")
    if timeStatus ~= 0 then
        this.vm.data.timeScale = Vector3(1, -timeStatus, 1)
        this.vm.data.isTimeArrow = true
        if timeStatus == -1 then
            table.sort(characterDatasCache, function(a, b)
                if a.time == b.time then
                    return a.id < b.id;
                else
                    return a.time > b.time;
                end
            end)
        else
            table.sort(characterDatasCache, function(a, b)
                if a.time == b.time then
                    return a.id > b.id;
                else
                    return a.time < b.time;
                end
            end)
        end
    else
        this.vm.data.isTimeArrow = false
    end
    if starStatus ~= 0 then
        this.vm.data.starScale = Vector3(1, -starStatus, 1)
        this.vm.data.isStarArrow = true
        if starStatus == -1 then
            table.sort(characterDatasCache, function(a, b)
                if a.rare == b.rare then
                    return a.id < b.id;
                else
                    return a.rare > b.rare
                end
            end)
        else
            table.sort(characterDatasCache, function(a, b)
                if a.rare == b.rare then
                    return a.id > b.id;
                else
                    return a.rare < b.rare
                end
            end);
        end
    else
        this.vm.data.isStarArrow = false
    end
    local curCharacterData = DataMgr.Player.backgroundData.BackgroundInfos;
    local cacheList = {}
    if curCharacterData ~= nil and #curCharacterData > 0 then
        for i = #characterDatasCache, 1, -1 do
            for key, value in ipairs(curCharacterData) do
                if characterDatasCache[i].id == value.CharacterID then
                    table.insert(cacheList, characterDatasCache[i])
                    table.remove(characterDatasCache, i)
                    break
                end
            end
        end
    else
        LuaDebug.error("DataMgr.Player.backgroundData.BackgroundInfos数据为空，请检查相关逻辑")
    end
    for i, v in ipairs(cacheList) do
        table.insert(characterDatasCache, 1, v)
    end
end


this.OnClickStar = function(parameter)
    local status = -1
    if starStatus ~= 0 then
        status = starStatus == 1 and -1 or 1
    end
    this.SetType(status, 0)
    this.SetHeadScrollView()
end

this.OnClickTime = function(parameter)
    local status = -1
    if timeStatus ~= 0 then
        status = timeStatus == 1 and -1 or 1
    end
    this.SetType(0, status)
    this.SetHeadScrollView()
end

this.OnClickConfirm = function(parameter)

    if #this.selectSkinList<1 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26611"));
        return;
    end
    local isChange=false
    if NumTool.GetLen(this.oldSelectMap)~=#this.selectSkinList then
        isChange=true;
    else 
        for i,v in ipairs(this.selectSkinList) do
            if this.oldSelectMap[v.Skin]==nil then
                isChange=true;
                break
            end
        end
    end
    if not isChange then
        return;
    end
    ApiMgr.Request("select_background", { backgrounds = this.selectSkinList }, true, function(re)
        PlayerSkinMgr.UpdatePlayerSkinData(DataMgr.Player.backgroundData.BackgroundInfos)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("1303"));
        HeroParameter.update_background = this.selectSkinList;
        this.oldSelectMap={}
        for i,v in ipairs(this.selectSkinList) do
            this.oldSelectMap[v.Skin]=true;
        end
    end, nil, true);
end


this.OnClickItem = function(indexData)
    if lastIndexData ~= nil then
        this.SetHeadItem(lastIndexData, false);
        this.headScrollViewList.dataList[lastIndexData.row].data[lastIndexData.col].isSelect = false;
    end
    this.headScrollViewList.dataList[indexData.row].data[indexData.col].isSelect = true;
    characterId = characterDatasCache[indexData.index].id;
    lastIndexData = indexData;
    this.SetBody(characterId .. "001");
    this.SetSkinHeads(nil);
end

this.SetHeadItem = function(indexData, isOn)
    for i, v in pairs(this.headScrollViewList.itemMap) do
        for p, m in ipairs(v.data) do
            if m.indexData.index == indexData.index then
                v:SetIndex(indexData.col, isOn)
                return
            end
        end
    end
end


this.SetHeadScrollView = function()
    this.headScrollViewList:Clear(true);
    local rowNum = math.ceil(#characterDatasCache / ROWCOUNT);
    local list = {}
    for i = 1, rowNum do
        local headList = {}
        local loc = 0;
        for j = ROWCOUNT * (i - 1) + 1, ROWCOUNT * i do
            if j <= #characterDatasCache then
                loc = loc + 1;
                local item = {
                    datas = characterDatasCache[j],
                    indexData = { row = i, col = loc, index = j },
                    itemObj = this.headItemObj,
                    callBack = this.OnClickItem,
                    isSelect = false,
                }
                table.insert(headList, item);
                if item.datas.id == characterId then
                    lastIndexData = item.indexData;
                    item.isSelect = true;
                end
            end
        end
        local headData = UIScrollData.GetData(this.headListItemObj, "SelectCharacter_HeadList", 430, 132, headList);
        table.insert(list, headData);
    end
    this.headScrollViewList:SetParams(432, 470)
    this.headScrollViewList:SetData(list, true)
end

this.SetSkinHeads = function(skinId)
    if characterId==nil then return end;
    this.skinUIList:Clear();

    local skinList = { characterId .. "001" }

    local skins = DataMgr.Player.characterSkins[characterId];
    if skins ~= nil then
        for i, v in ipairs(skins) do
            table.insert(skinList, v);
        end
    end
    table.sort(skinList, function(a, b) return a < b end)
    local list = {}
    if skinId == nil or skinId == "" then
        skinId = skinList[1];
    end
    for i, v in ipairs(skinList) do
        local cfgSkin = ConfigHelper.GetHeroSkinConfig(v)
        local skinItem = {
            index = i,
            skinId = v,
            skinTex = LuaMgr.GetTexture(HeroManager.GetCharacterAvatar(characterId, v)),
            isSelect = skinId == v,
            isTag = cfgSkin.highskin ~= nil and cfgSkin.highskin == 1,
            isSelected=this.CheckIsSelected(v),
            callBack = this.ClickSkinItem,
            addCallBack=this.AddCallBack,
            removeCallBack=this.ReMoveCallBack,
        }
        local skinData = UIListData.GetData(this.skinItemObj, "SelectCharacter_SkinItem", skinItem);
        table.insert(list, skinData)
    end
    this.skinUIList:SetData(list);

    local characterConfig = ConfigMgr.Config.characterTable[characterId]
    if characterConfig ~= nil then
        local characterName = LuaMgr.GetLangText(characterConfig.namelan)
        this.vm.data.characterName = characterName;
    end
    this.vm.data.skinBgSizeData = Vector2(#skinList * 116 + 40, 168);
    this.SetCharacterSkinInfo(skinId)
    this.SetWheelSkinCount();
end

this.SetWheelHeroList=function()
    this.wheelHeroList:Clear();
    local list={}
    for i,v in ipairs(this.selectSkinList) do
        local wheelItem={
            index=i,
            icon=LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(v.CharacterID,v.Skin)),
            rare=HeroMgr.GetHeroRareSort(v.CharacterID),
            callBack=this.WheelCallBack,
        }
        local wheelData=UIListData.GetData(this.wheelHeroItemObj,"SelectCharacter_WheelItem",wheelItem);
        table.insert(list,wheelData);
    end
    this.wheelHeroList:SetData(list);
end

this.WheelCallBack=function(index)
    local skinId=this.selectSkinList[index].Skin;
    local skinIndex=nil;
    for i,v in ipairs(this.skinUIList.itemList) do
        if v.data.skinId==skinId then
            skinIndex=i;
            break;
        end
    end
    if skinIndex~=nil then
        this.ReMoveCallBack(skinIndex);
    else
        table.remove(this.selectSkinList,index);
        this.SetWheelHeroList();
        this.SetWheelSkinCount();
    end
end

this.SetWheelSkinCount=function()
    this.vm.data.wheelSkinPro=string.format("<color=#efe5cc><size=26>%s</size></color>/%s",#this.selectSkinList,ConfigMgr.Config.constants.CharacterLimit)
end


this.CheckIsSelected=function(skinId)
    for i,v in ipairs(this.selectSkinList) do
        if v.Skin==skinId then
            return true;
        end
    end
    return false;
end

this.ClickSkinItem = function(index)
    for i, v in ipairs(this.skinUIList.itemList) do
        v:SetActive(i == index);
    end
    local skinId = this.skinUIList.itemList[index].data.skinId;
    this.SetCharacterSkinInfo(skinId)
    this.SetBody(skinId);
end

this.AddCallBack=function(index)
    if #this.selectSkinList >= ConfigMgr.Config.constants.CharacterLimit then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26610"));
        return;
    end
    local skinId=this.skinUIList.itemList[index].data.skinId;
    local wheelData = { CharacterID = characterId, Skin = skinId }
    table.insert(this.selectSkinList,wheelData)
    this.SetSkinHeads(skinId)
    this.SetWheelHeroList();
    local offIndex=#this.selectSkinList-4;
    LuaMgr.NextFrame(function()
        if offIndex>0 then
            local posX=-38-75*(offIndex-1)
            DOTWeen.To(function() return this.tranWheelContent.anchoredPosition.x  end,function(value)
                this.tranWheelContent.anchoredPosition=Vector2(value,this.tranWheelContent.anchoredPosition.y);
            end,posX,0.2)
        end
    end)
end

this.ReMoveCallBack=function(index)
    local skinId=this.skinUIList.itemList[index].data.skinId;
    local removeIndex=nil;
    for i,v in ipairs(this.selectSkinList) do
        if v.Skin==skinId then
            removeIndex=i;
            break
        end
    end
    if removeIndex~=nil then
        table.remove(this.selectSkinList,removeIndex);
        this.SetSkinHeads(skinId)
    end
    this.SetWheelHeroList();
end

this.SetCharacterSkinInfo = function(skinId)
    local skinConfig = nil;
    local skinList = ConfigMgr.Config.characterSkins[characterId];
    if skinList ~= nil then
        for i, v in ipairs(skinList) do
            if v.skinID == skinId then
                skinConfig = v;
                break;
            end
        end
    end
    if skinConfig == nil then return end;
    local skinName = LuaMgr.GetLangText(skinConfig.skinNamelan);
    this.vm.data.characterSkinName = skinName;
    backgroundSkin = skinId;
end


this.OnBack = function()
    if this.panel == 1 or this.panel == 3 or this.panel==4 or this.panel == 5 then
        this.SetPanel(0);
        this.SetText();
    elseif this.panel == 2 then
        this.SetPanel(0);
        this.animator:Play("UI_SelectCharacterPanel_05", 0, 0)
    else
        LuaMgr.Back();
    end
end

this.OnPreviewBgBack = function()
    LuaMgr.Back();
    return
end



this.SetText = function()
    this.vm.data.bgBtnText = ConfigMgr.LangGlobal("15961");
    this.vm.data.bgTimeText = ConfigMgr.LangGlobal("15960");
    this.vm.data.bgConfirmText = ConfigMgr.LangGlobal("15958");
end


this.SetPanel = function(panel)
    this.panel = panel;
    this.SetBgPic(nil);
    if panel == 0 then
        this.vm.data.isShowCharacter = true;
        this.vm.data.isOperateBtn = true;
        this.vm.data.isShowSkin = true;
        this.vm.data.isBgmBtn = not FeatureManager.IsLock("1302");
        this.vm.data.isBgBtn = true
        this.vm.data.isBgRole = false;
        this.vm.data.isShowGroup = true;
        this.vm.data.isShowBgGroup = false;
        this.vm.data.isShowUIMainBtn = false;
        this.vm.data.isMainUIGroup = false;
        this.vm.data.isShowUIMainBtn = true;
        this.vm.data.isMsgGroup = false;
        this.vm.data.isMsgBtn = true;
        this.vm.data.isDrawCard = true;
        this.vm.data.isKVGroup=false;;
        this.vm.data.isDrawCardGroup=false;
        this.vm.data.isKVButton=this.isKVOpen;
        this.vm.data.isMsgRed = MainPageViewModelRed.CheckMsgRedStatus() > 0
        this.SetJobType(1);
    elseif panel == 1 then
        this.vm.data.isShowCharacter = true;
        this.vm.data.isOperateBtn = false;
        this.vm.data.isShowSkin = false;
        this.vm.data.isBgmBtn = false;
        this.vm.data.isBgBtn = false;
        this.vm.data.isBgRole = true;
        this.vm.data.isShowGroup = false;
        this.vm.data.isShowBgGroup = true;
        this.vm.data.isBgRoleShow = false;
        this.vm.data.isBgRoleHide = true;
        this.vm.data.isShowUIMainBtn = false;
        this.vm.data.isMainUIGroup = false;
        this.vm.data.isMsgGroup = false;
        this.vm.data.isMsgBtn = false;
        this.vm.data.isDrawCard = false;
        this.vm.data.isKVGroup=false;
        this.vm.data.isDrawCardGroup=false;
        this.vm.data.isKVButton=false;
        this.SetTimeSort(2);
        this.selectBgId = nil;
        this.SetBgScrollView();
    elseif panel == 2 then

        this.vm.data.isShowCharacter = true;
        this.vm.data.isOperateBtn = false;
        this.vm.data.isShowSkin = false;
        this.vm.data.isBgmBtn = false;
        this.vm.data.isBgBtn = false;
        this.vm.data.isBgRole = true;
        this.vm.data.isShowGroup = false;
        this.vm.data.isShowBgGroup = false;
        this.vm.data.isBgRoleShow = false;
        this.vm.data.isBgRoleHide = true;
        this.vm.data.isShowUIMainBtn = false;
        this.vm.data.isMsgGroup = false;
        this.vm.data.isMsgBtn = false;
        this.vm.data.isDrawCard = false;
        this.vm.data.isMainUIGroup = true;
        this.vm.data.isKVGroup=false;;
        this.vm.data.isKVButton=false;
        this.vm.data.isDrawCardGroup=false;
        this.animator:Play("UI_SelectCharacterPanel_04", 0, 0)
        this.SetMainUI();
    elseif panel == 3 then
        this.vm.data.isShowCharacter = true;
        this.vm.data.isOperateBtn = false;
        this.vm.data.isShowSkin = false;
        this.vm.data.isBgBtn = false;
        this.vm.data.isBgmBtn = false;
        this.vm.data.isBgRole = false;
        this.vm.data.isShowGroup = false;
        this.vm.data.isShowBgGroup = false;
        this.vm.data.isBgRoleShow = false;
        this.vm.data.isBgRoleHide = false;
        this.vm.data.isShowUIMainBtn = false;
        this.vm.data.isMainUIGroup = false;
        this.vm.data.isMsgGroup = true;
        this.vm.data.isMsgBtn = false;
        this.vm.data.isDrawCard = false;
        this.vm.data.isKVGroup=false;;
        this.vm.data.isKVButton=false;
        this.vm.data.isDrawCardGroup=false;
        this.SetMsgInfo()
        this.SetMsgView()


        this.SetMsgText()
    elseif panel == 4 then

        this.vm.data.isKVButton=false;
        this.vm.data.isKVGroup=true;
        this.vm.data.isShowBgGroup=false;
        this.vm.data.isShowCharacter = false;
        this.vm.data.isOperateBtn = false;
        this.vm.data.isShowSkin = false;
        this.vm.data.isBgmBtn = false;
        this.vm.data.isBgBtn = false;
        this.vm.data.isBgRole = false;
        this.vm.data.isShowGroup = false;
        this.vm.data.isBgRoleShow = false;
        this.vm.data.isBgRoleHide = false;
        this.vm.data.isShowUIMainBtn = false;
        this.vm.data.isMainUIGroup = false;
        this.vm.data.isMsgGroup = false;
        this.vm.data.isMsgBtn = false;
        this.vm.data.isDrawCard = false;
        this.vm.data.isDrawCardGroup = false;
        this.SetTimeSort(2);
        this.SetKVScrollView();


    elseif panel == 5 then
        this.selectDrawCardId = nil
        this.selectDrawCardState = false
        this.UpdataDrawCardPic(DataMgr.Player.GachaSkin.."_bg")
        this.SetDarwCardView()
        this.vm.data.isKVButton=false;
        this.vm.data.isKVGroup=false;
        this.vm.data.isShowBgGroup=false;
        this.vm.data.isShowCharacter = false;
        this.vm.data.isOperateBtn = false;
        this.vm.data.isShowSkin = false;
        this.vm.data.isBgmBtn = false;
        this.vm.data.isBgBtn = false;
        this.vm.data.isBgRole = false;
        this.vm.data.isShowGroup = false;
        this.vm.data.isBgRoleShow = false;
        this.vm.data.isBgRoleHide = false;
        this.vm.data.isShowUIMainBtn = false;
        this.vm.data.isMainUIGroup = false;
        this.vm.data.isMsgGroup = false;
        this.vm.data.isMsgBtn = false;
        this.vm.data.isDrawCard = false;
        this.vm.data.isDrawCardGroup = true;
    end
end


this.SetBgPic = function(config)
    if (config ~= nil) then
        this.vm.data.bgTexture = LuaMgr.GetTexture(string.format(this.bgPath, config.Image));
    else
        config = ConfigMgr.Config.BGSwitchMap[DataMgr.Player.currentBgImage];
        if (config ~= nil) then
            this.vm.data.bgTexture = LuaMgr.GetTexture(string.format(this.bgPath, config.Image));
        end
    end
end


this.SetBgScrollView = function()
    this.bgScrollView:Clear(true);
    this.GetBgSwitchList(this.timeSort);
    local scrollData;
    local scrollDatas = {};
    local len = #this.bgSwitchList;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.bgItem, "SelectCharacter_BgItem", 416, 200, this.bgSwitchList[i]);
        table.insert(scrollDatas, scrollData);
    end
    this.bgScrollView:SetParams(416, 540);
    this.bgScrollView:SetData(scrollDatas, true);
end


this.SetTimeSort = function(type)
    this.timeSort = type;
    this.vm.data.bgTimeArrowUp = type == 1;
    this.vm.data.bgTimeArrowDown = type == 2;
end


this.SetBGM = function()
    LuaMgr.ShowLuaPanel(UIName.FoundationBgmViewModel);
    LuaMgr.NextFrame(this.ClosePanel);
end


this.GetBgSwitchList = function(type)
    local selectBg = nil;
    this.bgSwitchList = {};
    this.isBgLock = false;

    if this.CheckIsDirectPreviewBg() then
        local bgSwitchMap = ConfigMgr.Config.BGSwitchMap;
        table.insert(this.bgSwitchList, { config = bgSwitchMap[this.directPreviewBgId], select = true });
    else
        if (this.selectBgId == nil) then
            this.selectBgId = DataMgr.Player.currentBgImage;
        end
        local bgSwitchMap = ConfigMgr.Config.BGSwitchMap;
        for _, v in pairs(bgSwitchMap) do
            if (v.Id == this.selectBgId) then
                selectBg = { config = v, select = true };
            else
                table.insert(this.bgSwitchList, { config = v, select = false });
            end
        end
        if (type == 1) then
            table.sort(this.bgSwitchList, this.BgSwitchSort1);
        else
            table.sort(this.bgSwitchList, this.BgSwitchSort2);
        end
        if (selectBg ~= nil) then
            table.insert(this.bgSwitchList, 1, selectBg);
        end
    end
end


this.BgSwitchSort1 = function(a, b)
    return tonumber(a.config.Id) > tonumber(b.config.Id);
end


this.BgSwitchSort2 = function(a, b)
    return tonumber(a.config.Id) < tonumber(b.config.Id);
end


this.OnSelectBg = function(args)
    local item;
    local config = args[0];
    this.isBgLock = args[1];
    this.vm.data.bgConfirmText = ConfigMgr.LangGlobal(this.isBgLock and "15966" or "15958");
    local len = #this.bgSwitchList;
    for i = 1, len do
        item = this.bgSwitchList[i];
        item.select = item.config.Id == config.Id;
    end
    this.selectBgId = config.Id;
    this.SetBgPic(config);
    this.bgScrollView:Refresh();

    MainPageViewModelRed.CheckQHRedStatus()
    RedMgr.Singleton:Refresh();
end


this.OnRefreshBg = function(args)
    local bgId = args[0];
    if (this.selectBgId == bgId) then
        this.isBgLock = false;
        this.vm.data.bgConfirmText = ConfigMgr.LangGlobal("15958");
    end
    this.bgScrollView:Refresh();
end


this.UpdateBgImage = function(bgImageId)
    ApiMgr.Request("update_bg_image", { bgImageId = bgImageId }, true, this.UpdateBgImageResponse, nil, true, true);
end


this.UpdateBgImageResponse = function(result)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15963"));
    this.SetBgScrollView();
end

this.SetMainUI = function()
    this.selectUIMainId = nil;
    this.curSkinId = nil;
    if not IsNull(DataMgr.Player.uiSkin) and not IsNullOrEmpty(DataMgr.Player.uiSkin.use) then
        this.curSkinId = DataMgr.Player.uiSkin.use;
    end
    this.MainUISortTime();
    this.SetMainUIScrollView();
end

this.GetMainUIUnlockData = function()
    local uiList = {}
    for i, v in pairs(ConfigMgr.Config.UIskinMap) do
        if v.DefaultUnlock == 0 or this.MainUIItemUnlock(v.ID) then
            table.insert(uiList, v);
        end
    end
    return uiList;
end

this.MainUIItemUnlock = function(id)
    if IsNull(DataMgr.Player.uiSkin) or IsNull(DataMgr.Player.uiSkin.unlock) then
        return false;
    end
    return DataMgr.Player.uiSkin.unlock[id] ~= nil and DataMgr.Player.uiSkin.unlock[id] > 0;
end


this.MainUISortTime = function()
    this.vm.data.mainUITimeArrowUp = this.mainUISortUp;
    this.vm.data.mainUITimeArrowDown = not this.mainUISortUp;
    local curUISkin = nil;
    this.mainUIList = {}
    for i, v in pairs(ConfigMgr.Config.UIskinMap) do
        if this.curSkinId ~= nil and this.curSkinId == v.ID then
            curUISkin = v;
        elseif v.DefaultUnlock == 0 or this.MainUIItemUnlock(v.ID) then
            table.insert(this.mainUIList, v);
        end
    end
    if #this.mainUIList > 0 then
        table.sort(this.mainUIList, function(a, b)
            if this.mainUISortUp then
                return tonumber(a.ID) < tonumber(b.ID)
            else
                return tonumber(a.ID) > tonumber(b.ID)
            end
        end)
    end
    if curUISkin ~= nil then
        table.insert(this.mainUIList, 1, curUISkin);
    end
end


this.SetMainUIScrollView = function()
    if #this.mainUIList == 0 then return end;
    this.mainUIIndex = 1;
    local scrollDatas = {}
    for i, v in ipairs(this.mainUIList) do
        local uiItem = {
            index = i,
            id = v.ID,
            name = LuaMgr.GetLangText(v.NameLan),
            imgName = v.Resource,
            isCur = this.mainUIIndex == i,
            callBack = this.MainUIItemClick,
            isSelect = this.mainUIIndex == i,
        }
        local scrollData = UIScrollData.GetData(this.mainUIItem, "SelectCharacter_MainUIItem", 416, 200, uiItem);
        table.insert(scrollDatas, scrollData);
    end
    this.mainUIScrollView:SetParams(416, 540);
    this.mainUIScrollView:SetData(scrollDatas, true);
    this.SetMainUIPreview()
end

this.MainUIItemClick = function(index)
    if this.mainUIIndex == index then
        return;
    end
    this.mainUIIndex = index;
    for i, v in ipairs(this.mainUIScrollView.dataList) do
        v.data.isSelect = index == i;
    end
    this.mainUIScrollView:Refresh();
    this.SetMainUIPreview();
    MainPageViewModelRed.CheckQHRedStatus()
    RedMgr.Singleton:Refresh();
end

this.SetMainUIPreview = function()
    local rawPath = this.mainUIList[this.mainUIIndex].Resource
    local bgPath = string.format("Assets/_BundleResources/Images/HomeTheme/%s.png", rawPath .. "b");
    this.vm.data.mainUIRaw = LuaMgr.GetTexture(bgPath)
end

this.CheckIsDirectPreviewBg = function()
    if IsNullOrEmpty(this.directPreviewBgId) then
        this.vm.data.bgTimeBtnActive = true
        this.vm.data.bgConfirmBtnActive = true
        return false
    end

    this.vm.data.bgTimeBtnActive = false
    this.vm.data.bgConfirmBtnActive = false
    return true
end

this.SetMsgInfo = function()
    this.msgToggle = false
    this.vm.data.isToggle = this.msgToggle
    this.msgSortUp = false
    this.vm.data.msgTimeArrowDown = not this.msgSortUp
    this.vm.data.msgTimeArrowUp = this.msgSortUp
    this.curSelectMsgID = nil
    local msgRedKey = DataMgr.Player.uid .. "_MsgRed"
    if not PlayerPrefs.HasKey(msgRedKey) or PlayerPrefs.GetInt(msgRedKey) == 0 then
        PlayerPrefs.SetInt(msgRedKey, 1)
    end
    this.vm.data.msgToggleIsShow = not IsNullOrEmpty(this.curSelectMsgID)
end

this.SetMsgView = function()
    local tempList = this.GetMsgConfig()
    if TableIsNull(tempList) then
        return
    end
    this.msgScroll:Clear(true)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    local usingID = HeroMgr.GetHeroMsgUsingID(characterId)

    local lineStr = HeroManager.CheckCharacterLine(characterId, "RegardsLine", characterId .. "001")
    if not IsNullOrEmpty(lineStr) then
        if NumTool.GetStringLength(lineStr) > 10 then
            this.characterLine = LuaMgr.Substring(lineStr, 10)
        else
            this.characterLine = lineStr
        end
    else
        this.characterLine = ""
    end
    for i = 1, #tempList do
        groupData = {}
        groupData.data = tempList[i]
        groupData.characterId = characterId
        groupData.usingID = usingID
        groupData.callBack = this.MsgItemClick
        groupData.select = tempList[i].ID == this.curSelectMsgID
        groupData.lineStr = this.GetLinesStr(this.characterLine, tempList[i].RGB)



        scrollData = UIScrollData.GetData(this.msgTemplate, "SelectCharacter_HeroMsgItem", 426, 206, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.msgScroll:SetParams(426, 530)
    this.msgScroll:SetPadding(0, 0, 0, 0)
    this.msgScroll:SetData(scrollDatas, true)
end

this.SetDarwCardView = function()
    local tempList = this.GetDarwCardConfig()
    if TableIsNull(tempList) then
        return
    end
    this.drawCardScroll:Clear(true)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    for i = 1, #tempList do
        groupData = {}
        groupData.data = tempList[i]
        groupData.select = false
        groupData.callBack = this.DrawCardItemClick
        scrollData = UIScrollData.GetData(this.drawCardTemplate, "SelectCharacter_DrawCardItem", 426, 206, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.drawCardScroll:SetParams(426, 530)
    this.drawCardScroll:SetPadding(0, 0, 0, 0)
    this.drawCardScroll:SetData(scrollDatas, true)
end

this.SetMsgText = function()
    local usingID = ""
    if this.curSelectMsgID == nil then
        usingID = HeroMgr.GetHeroMsgUsingID(characterId)
    else
        usingID = this.curSelectMsgID
    end
    local rgb = "FFFFFF"
    if not TableIsNull(ConfigMgr.Config.DialogFrameMap) then
        if ConfigMgr.Config.DialogFrameMap[usingID] ~= nil then
            rgb = ConfigMgr.Config.DialogFrameMap[usingID].RGB
        end
    end
    this.vm.data.msgLineStrSkin = LuaMgr.GetSprite("HeroMsgBg", "Msg_" .. usingID)
    this.vm.data.msgLineStrText = this.GetLinesStr(this.characterLine, rgb)
end

this.MsgItemClick = function(index, param)
    if index == nil or param == nil then
        return
    end
    this.curSelectMsgID = param.ID
    for i = 1, #this.msgScroll.dataList do
        this.msgScroll.dataList[i].data.select = this.msgScroll.dataList[i].id == index
    end
    this.msgToggle = this.GetMsgToggleState(this.curSelectMsgID)
    this.vm.data.isToggle = this.msgToggle
    this.msgScroll:Refresh()
    this.SetMsgText()
    this.vm.data.msgToggleIsShow = true
end

this.DrawCardItemClick = function(param,activeSelf)
    if param == nil or this.selectDrawCardId == param.Id then
        return
    end
    this.selectDrawCardId = param.Id
    this.selectDrawCardState = activeSelf
    for i = 1, #this.drawCardScroll.dataList do
        this.drawCardScroll.dataList[i].data.select = this.drawCardScroll.dataList[i].data.data.Id == this.selectDrawCardId
    end
    this.drawCardScroll:Refresh()
    this.UpdataDrawCardPic(param.Preview)
end
this.UpdataDrawCardPic = function(name)
    this.vm.data.drawCardPic = LuaMgr.GetTexture(Path.DrawCardBg_Path..name..".png")
end

this.SaveMsgConfirm = function()
    if this.curSelectMsgID == nil then
        local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["25606"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        return
    end
    local tempData = {}
    tempData["ID"] = this.msgToggle and "all" or characterId
    tempData["Frame"] = this.curSelectMsgID
    ApiMgr.Request("dialogframe/save", tempData, true, function(result)
        local re = json.decode(result)
        if re.code == 0 then
            local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["25607"].NameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
            this.curSelectMsgID = nil
            this.vm.data.msgToggleIsShow = false
            local usingID = HeroMgr.GetHeroMsgUsingID(characterId)
            for i = 1, #this.msgScroll.dataList do
                this.msgScroll.dataList[i].data.select = false
                this.msgScroll.dataList[i].data.usingID = usingID
            end
            this.msgScroll:Refresh()
        end
    end, nil, true)
end

this.GetLinesStr = function(lineStr, RGB)
    local ellipsis = "......"
    if IsNullOrEmpty(lineStr) then
        return string.format("<color=#" .. RGB .. ">%s</color>", ellipsis)
    else
        return string.format("<color=#" .. RGB .. ">%s%s</color>", lineStr, ellipsis)
    end
    return ""
end

this.GetMsgConfig = function()
    local tempList = {}
    if TableIsNull(ConfigMgr.Config.DialogFrameMap) then
        return tempList
    end
    for _, value in pairs(ConfigMgr.Config.DialogFrameMap) do
        if value.Hide == 0 or (value.Hide == 1 and this.GetMsgState(value.ID)) then
            table.insert(tempList, value)
        end
    end
    if this.msgSortUp then
        table.sort(tempList, this.MsgTimeArrowUpSort)
    else
        table.sort(tempList, this.MsgTimeArrowDownSort)
    end
    return tempList
end
this.GetDarwCardConfig = function()
    local tempList = {}
    if TableIsNull(ConfigMgr.Config.GachaSkinMap) then
        return tempList
    end
    for _, value in pairs(ConfigMgr.Config.GachaSkinMap) do
        table.insert(tempList, value)
    end
    table.sort(tempList, function(a, b)
        return a.Id < b.Id
    end)
    return tempList
end
this.GetMsgState = function(msgId)
    if TableIsNull(DataMgr.Player.DialogFrame.unlock) then
        return false
    end
    if DataMgr.Player.DialogFrame.unlock[msgId] == nil then
        return false
    end
    return true
end
this.GetMsgToggleState = function(msgId)
    if TableIsNull(DataMgr.Player.DialogFrame.items) or IsNullOrEmpty(msgId) then
        return false
    end
    if DataMgr.Player.DialogFrame.items["all"] ~= nil then
        return DataMgr.Player.DialogFrame.items["all"] == msgId
    end
    return false
end

this.MsgTimeArrowDownSort = function(a, b)
    return a.Sort > b.Sort
end
this.MsgTimeArrowUpSort = function(a, b)
    return a.Sort < b.Sort
end


this.GetKVSwitchList=function(sortDir)
    this.KVList={};
    local key="LOGINKV_NAME";
    local value=UnityEngine.PlayerPrefs.GetString(key);
    for i,v in ipairs(ConfigMgr.Config.LoginBackgroundList) do
        if PlayerCharacterMgr.CheckLoginBackGroundUnLock(v) then
            v.used=not IsNullOrEmpty(value) and v.KV==value;
            table.insert(this.KVList,v);
        end
    end
    if sortDir>1 then
        table.sort(this.KVList,function(a,b)
            if a.used~=b.used then
                return a.used
            end
            return a.StartTime>b.StartTime;
        end)
    else
        table.sort(this.KVList,function(a,b)
            if a.used~=b.used then
                return a.used
            end
            return a.StartTime<b.StartTime;
        end)
    end
end




this.SetKVScrollView = function()
    this.kvScrollView:Clear();
    this.kvIndex=1;
    this.GetKVSwitchList(this.timeSort);
    local scrollData;
    local scrollDatas = {};
    for i,v in ipairs(this.KVList) do
        local kvItem={
            index=i,
            select=v.used,
            name=LuaMgr.GetLangText(v.NameLan),
            isUse=v.used;
            picName=v.KvPic,
            callBack=this.KVCallBack,
        }
        if kvItem.isUse then
            this.kvIndex=i;
        end
        scrollData = UIScrollData.GetData(this.kvItemObj, "SelectCharacter_KVItem", 416, 200, kvItem);
        table.insert(scrollDatas, scrollData);
    end
    this.kvScrollView:SetParams(416, 540);
    this.kvScrollView:SetData(scrollDatas, true);
    this.SetBGKV();
end

this.KVCallBack=function(index)
    if this.kvIndex~=nil and this.kvIndex==index then return end;
    this.kvIndex=index;
    for i,v in ipairs(this.kvScrollView.dataList) do
        v.data.select=i==index;
    end
    this.kvScrollView:Refresh();
    this.SetBGKV();
    
end


this.SetBGKV=function()
    if this.kvObj~=nil then
        LuaMgr.DestroyImmediateGO(this.kvObj);
    end
    local name=this.KVList[this.kvIndex].KV
    local path=string.format("Assets/_BundleResources/UI/KV/%s.prefab",name)
    this.kvObj = LuaMgr.GetPrefab(path);
    if this.kvObj ~=nil then
        this.kvObj.transform.parent=this.tansKV;
        this.kvObj.transform.localPosition=Vector3.zero;
        this.kvObj.transform.localScale=Vector3.one;
    end
    
end


return vm({
    data = data,
    command = command,
    hook = hook
})
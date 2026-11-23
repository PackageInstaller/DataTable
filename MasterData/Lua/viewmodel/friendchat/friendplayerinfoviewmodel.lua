
require("ViewModel/FriendChat/FriendPlayerInfoBadgeItem")
require("ViewModel/FriendChat/FriendPlayerInfoItem")
require("ViewModel/FriendChat/FriendChat_themeItem")

local PrefabPath = "Assets/_BundleResources/UI/FriendChat/FriendPlayerInfoSkin/PlayerInfo"

local this = {
    vm = nil,
    data = {
        playerData = nil,
        isChangeStyle = false,
        curSkinID = "",
        skinPanelData = nil,
        badgeItemDatas = nil,
        isInit = false,
        isDynamicAvatar,
    },
    skinPanelMap = {},
    badgeItemMap = {},
    playerInfoContent = nil,
    badgeContent = nil,
    themeListCfg = {},
    themeUIList = {};
    themeObj = nil;
    topBarIndex = nil;
    themeIndex = nil;
    assistItemObj = nil;
}
local data = {
    isShowBadgeRoot = false,
    curSkinTitle = "",
    curSkinDesc = "",
    showUnLockBtn = false,
    showLockBtn = false,
    lockTips = "",
    topList = {
        {
            isOn = false;
            showRed = false,
        },
        {
            isOn = true;
            showRed = false,
        }
    },
    badgeListActive = false;
    themeListActive = false;
    themePreviewTexture = DefaultTexture;
}

local command = {
    changeBadgeCancelBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.themeListActive = false;
            this.data.isChangeStyle = false
            this.data.curSkinID = this.data.playerData.ChatSkin
            this.ShowSkinPanel(this.data.curSkinID)
            this.SetPanelSize()
            this.RefreshSkinPanel()
        end
    },
    changeBadgeConfirmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.topBarIndex == 1 then
                ApiMgr.Request("set_chat_skin", { ChatSkin = this.data.curSkinID }, true, function(data)
                    this.data.isChangeStyle = false
                    this.data.playerData.ChatSkin = this.data.curSkinID
                    this.ShowSkinPanel(this.data.curSkinID)
                    this.SetPanelSize()
                    this.RefreshSkinPanel()
                end, nil, true)
            elseif this.topBarIndex == 2 then
                local themeId = this.themeListCfg[this.themeIndex].Id
                if FriendChatMgr.GetCurrentTheme() == themeId then
                    this.ParseData();
                    return ;
                end
                ApiMgr.Request("friends/chat/setSkin", { Id = themeId }, true, function(data)
                    LuaMgr.ClearVM(UIName.FriendChatViewModel)
                    this.ParseData();
                end, nil, true)
            end
        end
    },
    lockConfirmBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, this.vm.data.lockTips)
        end
    },
    topBarBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param)
            if this.topBarIndex == index then
                return
            end ;
            this.topBarIndex = index;
            this.SwitchTopBar();
        end
    },

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.playerInfoContent = vm.behaviour.transform:Find("root/Middle/PlayerInfo"):GetComponent("RectTransform")
        this.badgeContent = vm.behaviour.transform:Find("root/Middle/BadgeRoot/BadgeList/Viewport/Content"):GetComponent("RectTransform")
        local themeTF = vm.behaviour.transform:Find("root/Middle/BadgeRoot/ThemeList/Viewport/Content"):GetComponent("RectTransform")
        this.themeUIList = UIListView.New(themeTF);
        this.themeObj = vm.behaviour.transform:Find("template/themeItem").gameObject;
        this.data.isInit = true
        this.assistItemObj = vm.behaviour.transform:Find("template/assistItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if vm.behaviour.Params.Length > 0 then
            this.data.playerData = vm.behaviour.Params[0]
        end
        if this.data.playerData == nil then
            return
        end
        if vm.behaviour.Params.Length > 1 then
            this.data.characterInfoMap = vm.behaviour.Params[1];
        else
            this.data.characterInfoMap = nil;
        end

        if vm.behaviour.Params.Length > 2 then
            this.data.previewSkinId = vm.behaviour.Params[2];
        else
            this.data.previewSkinId = nil;
        end
        this.ParseData()
    end,
    before_deactive = function(vm)
        this.Clear()
    end,
    before_destroy = function(vm)
        for k, v in pairs(this.skinPanelMap) do
            v:Destroy()
        end
        for k, v in pairs(this.badgeItemMap) do
            v:Destroy()
        end
        this.themeUIList:Clear();
        UIListView.ClearItem("FriendChat_themeItem");
        UIListView.ClearItem("FriendPlayerInfoAssistItem");
        this = nil
    end,

}

this.ParseData = function()
    if IsNullOrEmpty(this.data.previewSkinId) then
        this.data.curSkinID = this.data.playerData.ChatSkin
    else
        this.data.curSkinID = this.data.previewSkinId
    end
    this.data.isChangeStyle = false
    this.vm.data.themeListActive = false;
    this.InitPlayerInfoData()
    this.LoadSkinPanel(this.data.curSkinID)
    this.SetPanelSize()

    this.ShowSkinPanel(this.data.curSkinID)
end

this.InitPlayerInfoData = function()
    this.data.skinPanelData = {}
    this.data.skinPanelData.isSelf = this.data.playerData.Uid == DataMgr.Player.uid
    this.data.skinPanelData.ShowUIBtn = true
    this.data.skinPanelData.userName = this.data.playerData.Name
    this.data.skinPanelData.userID = this.data.playerData.Uid
    this.data.skinPanelData.userMotto = this.data.playerData.Motto
    this.data.skinPanelData.showMotto = ConfigMgr.Config.FriendConstants.PlayerInfoMotto > 0
    this.data.skinPanelData.userLevel = tostring(this.data.playerData.Level)
    this.data.skinPanelData.CopyToClipboard = this.CopyToClipboard
    this.data.skinPanelData.OnClickChangeSkinBtn = this.OnClickChangeSkinBtn
    this.data.skinPanelData.OnClickShareBtn = this.OnClickShareBtn
    this.data.skinPanelData.title = this.data.playerData.Title
    this.SetAvatar()
    this.SetBrithDay()
    this.SetExp()
    this.SetCharactor()
    this.SetChallenge()
    this.SetSeal()
end

this.SetPanelSize = function()
    this.data.skinPanelData.showSubList = false
    this.data.skinPanelData.unLockRawAnchoredPos = Vector2(-527, -296)
    this.data.skinPanelData.characterAnchoredPos = Vector2(-639, -333.5)
    if this.data.isChangeStyle then
        this.vm.data.isShowBadgeRoot = true
        this.data.skinPanelData.isShowEffect = false
        this.data.skinPanelData.localScale = Vector3(0.758, 0.758, 1)
        this.data.skinPanelData.anchoredPosition = Vector2(-169, 41)
        this.data.skinPanelData.sizeDelta = Vector2(1173, 660)
    else
        this.vm.data.isShowBadgeRoot = false
        this.data.skinPanelData.isShowEffect = true
        this.data.skinPanelData.localScale = Vector3(1, 1, 1)

        if this.data.skinPanelData.isSelf then
            this.data.skinPanelData.anchoredPosition = Vector2(-49, -26)
            this.data.skinPanelData.sizeDelta = Vector2(1175, 660)
            this.data.skinPanelData.showSubList = true
        else
            this.data.skinPanelData.anchoredPosition = Vector2(1, -26)
            this.data.skinPanelData.sizeDelta = Vector2(1276, 660)
            this.data.skinPanelData.unLockRawAnchoredPos = Vector2(-527 - 48, -296 + 4.5)
            this.data.skinPanelData.characterAnchoredPos = Vector2(-639 - 48, -333.5 + 4.5)
        end
    end
end

this.LoadSkinPanel = function(skinId)
    if this.skinPanelMap[skinId] == nil then
        local path = PrefabPath .. skinId .. ".prefab"
        local prefab = LuaMgr.GetPrefab(path);
        LuaMgr.AddPrefabRefCount(path);
        if (prefab ~= nil) then
            local objTF = prefab.transform;
            objTF:SetParent(this.playerInfoContent, false);
            objTF.localScale = Vector3.one;
            objTF.localPosition = Vector3.zero;
            local item = FriendPlayerInfoItem.New();
            item.path = path
            item.class = data.class;
            item.gameObject = prefab;
            item.transform = objTF;
            item.assistItem = this.assistItemObj;
            item.characterInfoMap = this.data.characterInfoMap;
            item:Init(skinId);
            this.skinPanelMap[skinId] = item
        end
    end
end

this.RefreshSkinPanel = function()
    for k, v in pairs(this.skinPanelMap) do
        v:SetData(this.data.skinPanelData)
    end
end

this.ShowSkinPanel = function(skinId)
    this.LoadSkinPanel(skinId)
    this.RefreshSkinPanel()
    if this.data.isInit then
        for k, v in pairs(this.skinPanelMap) do
            v:SetActive(false)
            if k == skinId then
                LuaMgr.NextFrame(function()
                    v:SetActive(true)
                end)
            end
        end
        this.data.isInit = false
    else
        for k, v in pairs(this.skinPanelMap) do
            v:SetActive(k == skinId)
        end
    end

    local panelSkinCfg = ConfigMgr.Config.FriendSkinMap[skinId]
    local lock = not (IsNullOrEmpty(panelSkinCfg.AvatarFrame) or nil ~= DataMgr.Player.avatarFrameMap[panelSkinCfg.AvatarFrame])
    local name = LuaMgr.GetLangText(panelSkinCfg.NameLan);
    local describe = LuaMgr.GetLangText(panelSkinCfg.DescribeLan);
    local tips = LuaMgr.GetLangText(panelSkinCfg.UnLockTipslan);
    this.ShowTipInfo(name, describe, lock, tips)
end

this.ShowTipInfo = function(titleName, describe, lock, tips)
    this.vm.data.curSkinTitle = titleName
    this.vm.data.curSkinDesc = describe
    this.vm.data.showLockBtn = lock
    this.vm.data.showUnLockBtn = not lock
    this.vm.data.lockTips = tips;
end

this.SetAvatar = function()
    local avatarData = nil
    local frameData = nil
    for i, v in ipairs(ConfigMgr.Config.avatarFrames) do
        if v.id == this.data.playerData.Avatar then
            avatarData = v
        elseif v.id == this.data.playerData.CurrentAvatarFrame then
            frameData = v
        end
        if avatarData ~= nil and frameData ~= nil then
            break
        end
    end
    if avatarData ~= nil then
        local avatarPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId)
        this.data.skinPanelData.playerAvatar = LuaMgr.GetTexture(avatarPath)
        this.data.skinPanelData.isDynamicAvatar = avatarData.imgType == 2
        this.data.skinPanelData.avatarId = avatarData.id
    end
    if frameData ~= nil then
        this.data.skinPanelData.playerAvatarFrameId = frameData.id
        this.data.skinPanelData.playerAvatarFrame = PlayerAvatarFrameTool.GetStaticSprite(frameData.id, frameData)
    end
end

this.SetBrithDay = function()
    local birthday = this.data.playerData.Birthday
    if birthday == "" then
        this.data.skinPanelData.playerBirthDay = LuaMgr.GetLangText("SystemSettingViewModel_0")
        return
    end
    local value = string.sub(birthday, 6, 10)
    local briths = NumTool.split(value, "/")
    this.data.skinPanelData.playerBirthDay = string.format(LuaMgr.GetLangText("SystemSettingViewModel_3"), briths[1], briths[2])
end

this.SetExp = function()
    local levelUp = ConfigMgr.Config.playerLevelUp[tostring(this.data.playerData.Level)]
    local nextLevelUp = ConfigMgr.Config.playerLevelUp[tostring(this.data.playerData.Level + 1)]

    if nextLevelUp ~= nil then
        local totalExp = nextLevelUp.exp - levelUp.exp
        local nowExp = this.data.playerData.Exp - levelUp.exp
        if nowExp <= 0 then
            this.data.skinPanelData.playerExp = tostring(0)
            this.data.skinPanelData.expScaleData = Vector3(0, 0, 0)
        else
            this.data.skinPanelData.playerExp = tostring(nowExp / totalExp)
            this.data.skinPanelData.expScaleData = Vector3(nowExp / totalExp, 1, 1)
        end
    else
        this.data.skinPanelData.playerExp = tostring(0)
        this.data.skinPanelData.expScaleData = Vector3(0, 0, 0)
    end
end

this.GetCurrentChallengeName = function()
    local isComplete = false;
    local challengeNameLan = nil;
    local lastMainEvent = this.data.playerData.LastMainEvent;
    if not IsNullOrEmpty(lastMainEvent) then
        challengeNameLan, isComplete = DataHelper.GetNextChallengeName(lastMainEvent, this.data.playerData.CompletedAreaEvents)
    else
        challengeNameLan = ConfigMgr.Config.narrativeMap["M0001001"].nameLan;
    end

    return LuaMgr.GetLangText(challengeNameLan), isComplete;
end

this.SetChallenge = function()
    local challengeName, isComplete = this.GetCurrentChallengeName()
    this.data.skinPanelData.userChallenge = challengeName
    this.data.skinPanelData.userChallengeCompleteBool = isComplete

    local heroCount = 0
    local curTime = LuaMgr.Timestamp()
    for key, value in pairs(ConfigMgr.Config.characterTable) do
        if value.CharacterType == 1 and value.Switch == 0 and (value.UnlockDate == 0 or value.UnlockDate <= curTime) then
            heroCount = heroCount + 1
        end
    end

    this.data.skinPanelData.characterCount = this.data.playerData.Characters
    this.data.skinPanelData.allCharacterCount = heroCount
    this.data.skinPanelData.equipmentCount = this.data.playerData.Equipments
    this.data.skinPanelData.allEquipmentCount = NumTool.GetLen(ConfigMgr.Config.equipments)
    this.data.skinPanelData.characterChallengeFill = this.data.playerData.Characters / heroCount
    this.data.skinPanelData.equipmentChallengeFill = this.data.playerData.Equipments / NumTool.GetLen(ConfigMgr.Config.equipments)
end

this.SetCharactor = function()
    local curSkinId = nil
    for i, v in pairs(this.data.playerData.PlayerSkins) do
        if v then
            curSkinId = i
            break
        end
    end
    if curSkinId == nil then
        curSkinId = this.data.playerData.Sex > 1 and "SCJ102" or "SCJ101"
    end
    local unlock = curSkinId ~= "SCJ101" and curSkinId ~= "SCJ102"
    this.data.skinPanelData.userTeamLock = not unlock
    this.data.skinPanelData.unLockRawImgBool = not unlock
    local skinInfo = ConfigMgr.Config.playerSkinMap[curSkinId]
    this.data.skinPanelData.userTeam = LuaMgr.GetLangText(skinInfo.TypeDisplayLan)
    this.data.skinPanelData.userTeamIcon = LuaMgr.GetSprite("PlayerFigure", skinInfo.TypeEnterPic)
    this.data.skinPanelData.userTeamIcon_b = skinInfo.TypeEnterPic .. "_b"
    this.data.skinPanelData.curSkinId = ""
    if not unlock then
        local imgName = this.data.playerData.Sex > 1 and "SCJ102" or "SCJ101"
        this.data.skinPanelData.unLockRawImg = LuaMgr.GetTexture("Assets/_BundleResources/Images/PlayerSKin/" .. imgName .. ".png")
        this.data.skinPanelData.bodyRawBool = false
        this.data.skinPanelData.characterPath = ""
        return
    end

    this.data.skinPanelData.curSkinId = curSkinId
end

this.SetSeal = function()
    this.data.skinPanelData.sealList = {
        { isOn = false, texture = DefaultTexture },
        { isOn = false, texture = DefaultTexture },
        { isOn = false, texture = DefaultTexture },
        { isOn = false, texture = DefaultTexture },
        { isOn = false, texture = DefaultTexture },
        { isOn = false, texture = DefaultTexture },
        { isOn = false, texture = DefaultTexture },
    }
    this.data.skinPanelData.medalList = {
        { isOn = false, texture = DefaultSprite },
        { isOn = false, texture = DefaultSprite },
        { isOn = false, texture = DefaultSprite },
        { isOn = false, texture = DefaultSprite },
        { isOn = false, texture = DefaultSprite },
        { isOn = false, texture = DefaultSprite },
        { isOn = false, texture = DefaultSprite },
        { isOn = false, texture = DefaultSprite },
        { isOn = false, texture = DefaultSprite },
    }
    local sealCharacterIds = nil;
    if not IsNull(this.data.playerData.FriendShipSeal) then
        sealCharacterIds = this.data.playerData.FriendShipSeal;
    end
    for i = 1, 7, 1 do
        if sealCharacterIds ~= nil and sealCharacterIds[i] ~= nil and sealCharacterIds[i] ~= "" then
            local iconId = ConfigMgr.Config.characterPreferences[sealCharacterIds[i]].friendshipTalent[10][1]
            this.data.skinPanelData.sealList[i].isOn = true
            this.data.skinPanelData.sealList[i].texture = LuaMgr.GetTexture(Path.Image .. "FriendlyIcon/friendly_" .. iconId .. ".png")
        else
            this.data.skinPanelData.sealList[i].isOn = false
        end
    end
    local medal = {}
    if type(this.data.playerData.MedalDisplay) ~= "function" and not TableIsNull(this.data.playerData.MedalDisplay) then
        medal = this.data.playerData.MedalDisplay
    end
    local length = #medal
    for i = 1, 9 do
        if length >= i then
            this.data.skinPanelData.medalList[i].isOn = true
            this.data.skinPanelData.medalList[i].texture = LuaMgr.GetSprite("ZhanXunIcon", medal[i])
        else
            this.data.skinPanelData.medalList[i].isOn = false
        end
    end
    this.data.skinPanelData.OnClickSealBtn = this.OnClickSealBtn
end

this.SetBadgeList = function()
    this.data.badgeItemDatas = {}
    local skinCfgs = ConfigMgr.Config.FriendSkinMap
    for k, v in pairs(skinCfgs) do
        local isUnlock = IsNullOrEmpty(v.AvatarFrame) or nil ~= DataMgr.Player.avatarFrameMap[v.AvatarFrame]
        local itemData = {
            id = k,
            isSelect = k == this.data.curSkinID,
            avatar = this.data.skinPanelData.playerAvatar,
            avatarFrameId = this.data.skinPanelData.playerAvatarFrameId,
            avatarFrame = this.data.skinPanelData.playerAvatarFrame,
            level = this.data.skinPanelData.userLevel,
            name = this.data.skinPanelData.userName,
            teamName = this.data.skinPanelData.userTeam,
            teamIcon = this.data.skinPanelData.userTeamIcon,
            func = this.OnClickBadgeItem,
            lock = not isUnlock
        }

        local avatarFrameCfg = ConfigHelper.GetAvatarFrame(v.AvatarFrame)
        if isUnlock or (avatarFrameCfg ~= nil and avatarFrameCfg.hide == 0) then
            table.insert(this.data.badgeItemDatas, itemData)
        end
    end

    table.sort(this.data.badgeItemDatas, function(a, b)
        return a.id < b.id
    end)
    for i, v in ipairs(this.data.badgeItemDatas) do
        local skinId = v.id
        v.index = i
        this.LoadBadgeItem(skinId)
        if this.badgeItemMap[skinId] ~= nil then
            this.badgeItemMap[skinId].transform:SetAsLastSibling()
        end
    end
    this.RefreshBadgeItems()
end

this.LoadBadgeItem = function(skinId)
    if this.badgeItemMap[skinId] == nil then
        local path = "Assets/_BundleResources/UI/FriendChat/FriendPlayerInfoSkin/PlayerInfoBadgeItem" .. skinId .. ".prefab"
        local prefab = LuaMgr.GetPrefab(path);
        LuaMgr.AddPrefabRefCount(path);
        if (prefab ~= nil) then
            local objTF = prefab.transform;
            objTF:SetParent(this.badgeContent, false);
            objTF.localScale = Vector3.one;
            objTF.localPosition = Vector3.zero;
            local item = FriendPlayerInfoBadgeItem.New();
            item.path = path
            item.class = data.class;
            item.gameObject = prefab;
            item.transform = objTF;
            item:Init();
            this.badgeItemMap[skinId] = item
        else
            print("error load badgeItem:" .. path);
        end
    end
end

this.RefreshBadgeItems = function()
    for i, v in ipairs(this.data.badgeItemDatas) do
        this.badgeItemMap[v.id]:SetData(v)
    end
    this.RefreshTopListRed()
end

this.OnClickBadgeItem = function(id)
    this.data.curSkinID = id
    for i, v in ipairs(this.data.badgeItemDatas) do
        if v.id == this.data.curSkinID then
            v.isSelect = true
        else
            v.isSelect = false
        end
    end
    this.RefreshBadgeItems()
    this.ShowSkinPanel(this.data.curSkinID)
end

this.CopyToClipboard = function()
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("PlayerInfoViewModel_1"));
    local input = DataMgr.Player.uid;
    LuaMgr.DoCopyText(input);
end

this.OnClickSealBtn = function()
    LuaMgr.ShowLuaPanel(UIName.SealEditorViewModel)
end

this.OnClickChangeSkinBtn = function()
    this.topBarIndex = 1;
    this.SwitchTopBar();
end

this.OnClickShareBtn = function()
    LuaMgr.HidePanel("Laigu.ViewModel.TopBarViewModel")
    LuaMgr.HidePanel(UIName.MessageTipsViewModel);
    LuaMgr.HidePanel(UIName.NoticeRollhorseViewModel)
    this.data.skinPanelData.ShowUIBtn = false
    this.data.skinPanelData.isShowEffect = false
    this.data.skinPanelData.isSelf = false
    this.SetPanelSize()
    this.RefreshSkinPanel()
    local filename = "screenshot/shareScreenshot.png"
    LuaMgr.NextFrame(function()
        LuaMgr.CaptureScreenshot(filename)
        local path = UnityEngine.Application.persistentDataPath .. '/' .. filename
        LuaMgr.NextFrame(function()
            LuaMgr.ShowPanel("Laigu.ViewModel.SharePopupViewModel", "friends", path, function()
                this.data.skinPanelData.ShowUIBtn = true
                this.data.skinPanelData.isShowEffect = true
                this.data.skinPanelData.isSelf = true
                this.SetPanelSize()
                this.RefreshSkinPanel()
                this.vm.behaviour:UpdateTopBar("", nil)
            end)
        end)
    end)
end

this.Clear = function()
    for k, v in pairs(this.skinPanelMap) do
        v:Clear()
    end
    for k, v in pairs(this.badgeItemMap) do
        v:Clear()
    end
end

this.SwitchTopBar = function()
    for i, v in ipairs(this.vm.data.topList) do
        v.isOn = i == this.topBarIndex;
    end
    this.vm.data.badgeListActive = this.topBarIndex == 1;
    this.vm.data.themeListActive = this.topBarIndex == 2;
    if this.topBarIndex == 1 then
        this.data.isChangeStyle = true
        this.SetBadgeList()
        this.SetPanelSize()

        this.ShowSkinPanel(this.data.curSkinID)
    elseif this.topBarIndex == 2 then
        this.InitThemeCfg();
        this.SetThemeList();
    end
    this.RefreshTopListRed()
end

this.InitThemeCfg = function()
    if this.themeListCfg == nil or #this.themeListCfg == 0 then
        this.themeListCfg = {}
        for i, v in pairs(ConfigMgr.Config.FriendChatSkinMap) do
            table.insert(this.themeListCfg, v);
        end
        table.sort(this.themeListCfg, function(a, b)
            return a.Id < b.Id;
        end)
    end
end

this.SetThemeList = function()
    if #this.themeListCfg == 0 then
        return
    end ;
    local list = {}
    for i, v in ipairs(this.themeListCfg) do
        local themeItem = {
            id = v.Id,
            index = i,
            isCur = v.Id == FriendChatMgr.GetCurrentTheme();
            isUnlock = IsNullOrEmpty(v.Unlockitem) or DataHelper.GetItemCountById(v.Unlockitem) > 0;
            callBack = this.ThemeItemCallBack
        }
        if themeItem.isCur then
            this.themeIndex = i;
        end
        local themeItemData = UIListData.GetData(this.themeObj, "FriendChat_themeItem", themeItem);
        table.insert(list, themeItemData);
    end
    this.themeUIList:SetData(list);
    this.SetThemeTipInfo();
end

this.ThemeItemCallBack = function(index)
    if this.themeIndex == index then
        return
    end ;
    this.themeIndex = index;
    for i, v in ipairs(this.themeUIList.itemList) do
        v:isSelect(i == index);
    end
    this.SetThemeTipInfo();
end

this.SetThemeTipInfo = function()
    local path = Path.Image .. "FriendChat/ui_hy_theme_0" .. this.themeIndex .. ".png";
    this.vm.data.themePreviewTexture = LuaMgr.GetTexture(path);
    local themeCfg = this.themeListCfg[this.themeIndex]
    local titleName = LuaMgr.GetLangText(themeCfg.Namelan);
    local describe = LuaMgr.GetLangText(themeCfg.Describelan);
    local tips = LuaMgr.GetLangText(themeCfg.UnLockTipslan);
    local lock = not IsNullOrEmpty(themeCfg.Unlockitem) and DataHelper.GetItemCountById(themeCfg.Unlockitem) == 0;
    this.ShowTipInfo(titleName, describe, lock, tips)
    this.RefreshTopListRed()
end

this.RefreshTopListRed = function()
    for i, v in ipairs(this.vm.data.topList) do
        if i == 1 then
            v.showRed = FriendChatMgr.CheckFriendPlayerInfoRed_Badge() > 0
        elseif i == 2 then
            v.showRed = FriendChatMgr.CheckFriendPlayerInfoRed_Theme() > 0
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})
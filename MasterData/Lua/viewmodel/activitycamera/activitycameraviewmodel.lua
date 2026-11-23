local archivesPath = "Assets/_BundleResources/Images/Archives/";
local PlayerPrefsKeys_Character = ""
local PlayerPrefsKeys_CharacterTheme = ""
local PlayerPrefsKeys_Patch = ""
local PlayerPrefsKeys_PatchTheme = ""
local PlayerPrefsKeys_ChaForbiddenType = ""
local PlayerPrefsKeys_PatchForbiddenType = ""

local this = {
    vm=nil,
    rawImageCamera = nil,
    btnRotate = nil,
    btnScale = nil,
    rectBtnRotate = nil,
    rectBtnScale = nil,
    rectBtnDel = nil,
    rectTemplate = nil,
    rectCapture = nil,
    patchTemplate = nil,
    patchContent = nil,
    patchItemList = {},
    choosePatchIndex = 0,
    characterTextureRect = nil,

    screenWidth = 1280,
    screenHeight = 720,
    captureRequestedWidth = 1280,
    defaultRightFrameWidth = 128,
    cfg_MaxPatchCount = 5,
    
    downPos = Vector2.zero,
    patchStartRotate = 0.0,
    patchStartScale = 0.0,
    
photoMode = 0,
sideBarType = 0,

    jobIndex = 0,
    patchTypeIndex = nil,
    characterSkinList = nil,
    patchConfigList = nil,
    patchTypeConfigList = nil,
    themeConfigList = nil,
    

    openSideBarListType = 0,
    

    curChooseCharacterSkinId = "",
    curChoosePatchIdMap = {},
    curThemeId = "",
    

    cha_forbiddenType = 0,
    patch_forbiddenType = 0,
};

local data = {
    goSwitchPanelActive = false,
    goCameraUIActive = false,
    showBack = false,
    showButtons = false,

    leftFrameSizeDelta = Vector2(0, 720),
    rightFrameSizeDelta = Vector2(128, 720),
    captureSizeDelta = Vector2(1280, 720),
    capturePosition = Vector2(0, 0),
    
    isChaMode = false,
    isPatchMode = false,

    chaRelicsIcon = DefaultTexture;
    chaName = "",
    chaFullName = "",
    
    isEditorMode = false,
    showSideBarList = false,
    sideBarListPos = Vector2.zero,
    hideSideBarList = false,
    sideBarListTypeLeftActive = false,
    sideBarListTypeLeftLock = false,
    sideBarListTypeRightActive = false,
    sideBarListTypeRightLock = false,
    showChaJobs = false,
    showPatchTypes = false,

    jobsList={
        {isSelect=false},{isSelect=false},{isSelect=false},{isSelect=false},{isSelect=false},{isSelect=false},
    },
    patchTypeList={
        {typeName = "", isSelect = false}
    },
    chaSkinVMList = {
        {index = "", skinId = "", skinTexture = DefaultTexture, isSelect = false}
    },
    patchVMList = {
        {index = "", patchId = "", patchSprite = DefaultSprite, isSelect = false}
    },
    themeVMList = {
        {index = "", themeId = "", themeSprite = DefaultSprite, name = "", forbidden = 0, isSelect = false}
    },
    choosePatchCountStr = "";
    contentAnchedPos = Vector2.zero,
    showTheme_pfhy01 = false,
    showTheme_pfhy02 = false,
    showTheme_pfhy03 = false,
    showTheme_pfhy04 = false,
    showTheme_pfhy05 = false,
    showTheme_pftz01 = false,
    showTheme_pftz02 = false,
    showTheme_pftz03 = false,
    isShowCharacterTexture = false,
    characterTexture = DefaultTexture,
    
    showNotSaveConfirmPanel = false,
    showCheckPermissionPanel = false,
    showNoPermissionImage = false,
}

this.Init = function(prefab)
    local uiLink = prefab.gameObject:GetComponent("UILink");
    this.rawImageCamera = uiLink:Get("rawImageCamera"):GetComponent("RawImage");
    this.btnRotate = uiLink:Get("btnRotate"):GetComponent("OnDragEvent");
    this.btnScale = uiLink:Get("btnScale"):GetComponent("OnDragEvent");
    this.rectBtnRotate = uiLink:Get("btnRotate"):GetComponent("RectTransform");
    this.rectBtnScale = uiLink:Get("btnScale"):GetComponent("RectTransform");
    this.rectBtnDel = uiLink:Get("btnDel"):GetComponent("RectTransform");
    this.rectTemplate = uiLink:Get("rectTemplate"):GetComponent("RectTransform");
    this.patchTemplate = uiLink:Get("patchTemplate");
    this.patchContent = uiLink:Get("rectPatchContent"):GetComponent("RectTransform");
    this.rectCapture = uiLink:Get("rectCapture"):GetComponent("RectTransform");
    this.characterTextureRect = uiLink:Get("rectHeroTexture"):GetComponent("RectTransform");
    
    this.btnRotate:SetData(0, this.OnRotateBtnBeginDrag, this.OnRotateBtnDrag, this.OnRotateBtnEndDrag)
    this.btnScale:SetData(0, this.OnScaleBtnBeginDrag, this.OnScaleBtnDrag, this.OnScaleBtnEndDrag)

    this.screenWidth = LuaMgr.ScreenWidth();
    this.screenHeight = LuaMgr.ScreenHeight();
    this.captureRequestedWidth = this.screenWidth - this.defaultRightFrameWidth
end

local command = {
    backCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnBack()
        end
    },
    chaModeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.CheckPermission() then
                this.photoMode = 1;
                this.Refresh()
            else
                this.vm.data.showCheckPermissionPanel = true
            end
        end
    },
    patchModeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.CheckPermission() then
                this.photoMode = 2;
                this.Refresh()
            else
                this.vm.data.showCheckPermissionPanel = true
            end
        end
    },
    captureCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnCapture()
        end
    },
    switchCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            ActivityCameraMgr.Singleton:SwitchBtn()
        end
    },
    patchDelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.RemovePatch(this.choosePatchIndex, true)
        end
    },
    editorCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.EnterEditorMode()
        end
    },
    applyEditorCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ApplyEditor()
        end
    },
    sideBarListTypeLeftBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.sideBarType == 0 then
                return
            end
            this.SetSideBarListType(0)
        end
    },
    sideBarListTypeRightBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.sideBarType == 1 then
                return
            end
            this.SetSideBarListType(1)
        end
    },
    sideBarListShowOrHideBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SetSideBarListAcitve(this.vm.data.hideSideBarList)
        end
    },
    jobCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local job = tonumber(param) + 1;
            this.SetJobType(job)
        end
    },
    patchTypeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1;
            local type = this.vm.data.patchTypeList[index].catalog
            this.ChoosePatchType(type)
        end
    },
    patchOrSkinVMItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1;
            if this.photoMode == 1 then

                local skinId = ""
                for i, v in ipairs(this.vm.data.chaSkinVMList) do
                    v.isSelect = v.index == index
                    if v.index == index then
                        skinId = v.skinId
                    end
                end
                this.ChooseCharacter(skinId)
            elseif this.photoMode == 2 then

                local isSelect = this.vm.data.patchVMList[index].isSelect
                local patchId = this.vm.data.patchVMList[index].patchId
                if not isSelect then

                    this.AddPatch(patchId)
                else

                    this.RemovePatch(patchId, false)
                end
            end
        end
    },
    themeItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1;
            local themeId = this.vm.data.themeVMList[index].themeId
            local forbiddenType = this.vm.data.themeVMList[index].forbidden
            for i, v in ipairs(this.vm.data.themeVMList) do
                v.isSelect = v.index == index
            end
            
            this.LoadTheme(themeId)
            this.ApplyTableForbidden(forbiddenType)
        end
    },
    notSaveConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ApplyEditor()
            this.vm.data.showNotSaveConfirmPanel = false
        end
    },
    notSaveCancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.showNotSaveConfirmPanel = false
            this.QuitEditorMode()
        end
    },
    checkPermissionConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            ActivityCameraMgr.Singleton:InitParam(this.captureRequestedWidth, this.screenHeight)
            ActivityCameraMgr.Singleton:ToOpenCamera(this.rawImageCamera, this.UpdateCaptureSize)
            this.vm.data.showCheckPermissionPanel = false
        end
    },
    checkPermissionCancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnBack()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.SetDefaultStatus()
            if this.CheckPermission() then
                ActivityCameraMgr.Singleton:InitParam(this.captureRequestedWidth, this.screenHeight)
                ActivityCameraMgr.Singleton:ToOpenCamera(this.rawImageCamera, this.UpdateCaptureSize)
            end
            this.Refresh()
        end
    end,
    before_deactive = function(vm)
        this.characterSkinList = nil
        this.patchConfigList = nil
        this.patchTypeConfigList = nil
        this.themeConfigList = nil
        ActivityCameraMgr.Singleton:Clear();
    end,
    before_destroy=function()
        this.Clear()
    end
}

this.UpdateCaptureSize = function(captureSize)
    LuaDebug.info(string.format("UpdateCaptureSize : %s-%s", captureSize.x, captureSize.y) )
    local offset = math.max(0, this.captureRequestedWidth - captureSize.x)
    local halfOffset = offset / 2
    this.vm.data.leftFrameSizeDelta = Vector2(halfOffset, this.screenHeight)
    this.vm.data.rightFrameSizeDelta = Vector2(this.defaultRightFrameWidth + halfOffset, this.screenHeight)
    this.vm.data.captureSizeDelta = captureSize
    this.vm.data.capturePosition = Vector2(halfOffset, 0)
end

this.SetDefaultStatus = function()
    PlayerPrefsKeys_Character = DataMgr.Player.uid.."ActivityCamera_Character_"
    PlayerPrefsKeys_CharacterTheme = DataMgr.Player.uid.."ActivityCamera_CharacterTheme_"
    PlayerPrefsKeys_Patch = DataMgr.Player.uid.."ActivityCamera_Patch_"
    PlayerPrefsKeys_PatchTheme = DataMgr.Player.uid.."ActivityCamera_PatchTheme_"
    PlayerPrefsKeys_ChaForbiddenType = DataMgr.Player.uid.."ActivityCamera_ChaForbiddenType_"
    PlayerPrefsKeys_PatchForbiddenType = DataMgr.Player.uid.."ActivityCamera_PatchForbiddenType_"
    this.cfg_MaxPatchCount = ConfigMgr.Config.CameraConstants.PatchMaxChoose
    this.UpdateCaptureSize(Vector2(this.captureRequestedWidth, this.screenHeight))
end

this.Refresh = function()
    this.vm.data.showBack = true
    this.vm.data.showButtons = true
    this.vm.data.isEditorMode = false
if this.photoMode == 0 then
        this.vm.behaviour:UpdateTopBar("", this.OnBack);
        this.vm.data.goSwitchPanelActive = true
        this.vm.data.goCameraUIActive = false
    else
        this.vm.data.isChaMode = this.photoMode == 1
        this.vm.data.isPatchMode = this.photoMode == 2
        this.vm.behaviour:UpdateTopBar("1", this.OnBack);
        this.vm.data.goSwitchPanelActive = false
        this.vm.data.goCameraUIActive = true

        this.LoadApplyEditorInfo()
        LuaMgr.InvokeUIEventListeners(UIEventConst.CameraImageDragInteractable, false);
    end
end

this.EnterEditorMode = function()
    this.vm.data.isEditorMode = true
    this.vm.data.showBack = true
    this.vm.data.showButtons = false
    this.InitSideBarConfig()

    this.SetSideBarListAcitve(true)
    this.SetSideBarListType(this.openSideBarListType)
    LuaMgr.InvokeUIEventListeners(UIEventConst.CameraImageDragInteractable, true);
end

this.QuitEditorMode = function()
    this.vm.data.isEditorMode = false
    this.vm.data.showBack = true
    this.vm.data.showButtons = true
    this.HidePatchButtons()
    LuaMgr.InvokeUIEventListeners(UIEventConst.CameraImageDragInteractable, false);
    this.Refresh()
end

this.ApplyEditor = function()
    if this.photoMode == 1 then
        PlayerPrefs.SetString(PlayerPrefsKeys_Character, this.curChooseCharacterSkinId);
        PlayerPrefs.SetString(PlayerPrefsKeys_CharacterTheme, this.curThemeId);
    elseif this.photoMode == 2 then
        local patchInfosJson = this.GetCurPatchInfoJson()
        PlayerPrefs.SetString(PlayerPrefsKeys_Patch, patchInfosJson);
        PlayerPrefs.SetString(PlayerPrefsKeys_PatchTheme, this.curThemeId);
    end
    PlayerPrefs.SetString(PlayerPrefsKeys_ChaForbiddenType, this.cha_forbiddenType);
    PlayerPrefs.SetString(PlayerPrefsKeys_PatchForbiddenType, this.patch_forbiddenType);
    
    this.QuitEditorMode()
end

this.LoadApplyEditorInfo = function()
    this.RemoveAllPatch()
    this.ChooseCharacter("")
    this.LoadTheme("")
    this.ApplyTableForbidden("")

    this.cha_forbiddenType = tonumber(PlayerPrefs.GetString(PlayerPrefsKeys_ChaForbiddenType, ""));
    this.patch_forbiddenType = tonumber(PlayerPrefs.GetString(PlayerPrefsKeys_PatchForbiddenType, ""));
    
    if this.photoMode == 1 then
        this.curThemeId = PlayerPrefs.GetString(PlayerPrefsKeys_CharacterTheme, "pfhy01");
        local skinId = PlayerPrefs.GetString(PlayerPrefsKeys_Character, "");
        this.ChooseCharacter(skinId)
        this.ApplyTableForbidden(this.cha_forbiddenType)
    elseif this.photoMode == 2 then
        this.curThemeId = PlayerPrefs.GetString(PlayerPrefsKeys_PatchTheme, "pftz01");
        local patchInfosJson = PlayerPrefs.GetString(PlayerPrefsKeys_Patch, "");
        local curPatchInfos = json.decode(patchInfosJson)
        if not TableIsNull(curPatchInfos) then
            for i, v in ipairs(curPatchInfos) do
                this.AddPatch(v.id)
                this.patchItemList[i].rect.anchoredPosition = v.pos
                this.patchItemList[i].rect.localScale = v.scale
                this.patchItemList[i].rect.localEulerAngles = v.rotate
            end
        end
        this.ApplyTableForbidden(this.patch_forbiddenType)
    end
    
    this.LoadTheme(this.curThemeId)
end

this.CheckIsChanged = function()
    if this.photoMode == 1 then
        local themeId = PlayerPrefs.GetString(PlayerPrefsKeys_CharacterTheme, "pfhy01");
        local skinId = PlayerPrefs.GetString(PlayerPrefsKeys_Character, "");
        if themeId ~= this.curThemeId or skinId ~= this.curChooseCharacterSkinId then
            return true
        end
    elseif this.photoMode == 2 then
        local themeId = PlayerPrefs.GetString(PlayerPrefsKeys_PatchTheme, "pftz01");
        local patchInfosJson = PlayerPrefs.GetString(PlayerPrefsKeys_Patch, "");
        local curPatchInfosJson = this.GetCurPatchInfoJson()
        if themeId ~= this.curThemeId or patchInfosJson ~= curPatchInfosJson then
            return true
        end
    end
    return false
end

this.GetCurPatchInfoJson = function()
    local curPatchInfos = {}
    for i, v in ipairs(this.patchItemList) do
        if not v.isHide then
            local info = {
                id = v.id,
                pos = VectorToTable(v.rect.anchoredPosition),
                scale = VectorToTable(v.rect.localScale),
                rotate = VectorToTable(v.rect.localEulerAngles),
            }
            table.insert(curPatchInfos, info)
        end
    end
    local patchInfosJson = json.encode(curPatchInfos)
    return patchInfosJson
end

this.InitSideBarConfig = function()
    local cameraConfigs = ConfigMgr.Config.CameraMap
    if this.characterSkinList == nil then
        this.characterSkinList = {}
        local characterDatas = DataMgr.Player.characters
        local skinConfigs = ConfigMgr.Config.characterSkins
        for characterId, v in pairs(characterDatas) do
            local skins = skinConfigs[characterId]
            for i, skinCfg in ipairs(skins) do
                if DataHelper.IsContainsSkin(characterId, skinCfg.skinID) then
                    table.insert(this.characterSkinList, {characterId = characterId, skinId = skinCfg.skinID});
                end
            end
        end
        table.sort(this.characterSkinList,function(a, b) return a.skinId < b.skinId end)
    end

    if this.patchConfigList == nil or this.themeConfigList == nil then
        this.patchConfigList = {}
        this.patchTypeConfigList = {}
        this.themeConfigList = {}
        for k, v in pairs(cameraConfigs) do
            if v.Type == 1 then
                local isUnLock = this.CheckUnlock(v.UnlockType, v.Unlock)
                if isUnLock or v.Hide == 0 then
                    if this.patchTypeConfigList[tostring(v.Catalog)] == nil then
                        local typeConfig = {
                            catalog = v.Catalog,
                            typeName = LuaMgr.GetLangText(v.CatalogTxtLan),
                        }
                        this.patchTypeConfigList[tostring(v.Catalog)] = typeConfig
                    end
                    table.insert(this.patchConfigList, v)
                end
            elseif v.Type == 3 or v.Type == 4 then
                local isUnLock = this.CheckUnlock(v.UnlockType, v.Unlock)
                if isUnLock or v.Hide == 0 then
                    table.insert(this.themeConfigList, v)
                end
            end
        end
    end
    table.sort(this.patchConfigList, function(a, b) return a.Sort < b.Sort end)
    table.sort(this.themeConfigList, function(a, b) return a.Sort < b.Sort end)
    
    local tempTypeList = { { catalog = 0, typeName = LuaMgr.GetLangText("ActivityCameraViewModel_0"), isSelect = true } }
    for k, v in pairs(this.patchTypeConfigList) do
        local typeItem = {
            catalog = v.catalog,
            typeName = v.typeName,
            isSelect = false
        }
        table.insert(tempTypeList, typeItem)
    end
    table.sort(tempTypeList, function(a, b) return a.catalog < b.catalog end)
    this.vm.data.patchTypeList = tempTypeList
end

this.SetSideBarListAcitve = function(active)
    this.vm.data.showSideBarList = active
    this.vm.data.sideBarListPos = active and Vector2.zero or Vector2(2000, 0)
    this.vm.data.hideSideBarList = not active
end

this.SetSideBarListType = function(type)
if type == 0 and this.vm.data.sideBarListTypeLeftLock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("26401"));
        return
    end
    
    this.sideBarType = type
    this.vm.data.sideBarListTypeLeftActive = type == 0
    this.vm.data.sideBarListTypeRightActive = type == 1
    this.SetSideBarList()
    this.vm.data.contentAnchedPos = Vector2.zero
end

this.SetSideBarList = function()
    if this.sideBarType == 0 then

        if this.photoMode == 1 then

            this.SetJobType(1)
        elseif this.photoMode == 2 then

            this.ChoosePatchType(0)
        end
    elseif this.sideBarType == 1 then

            this.SetSideBarThemeList()
    end
end

this.SetJobType = function(index)
    this.vm.data.showChaJobs = true
    this.vm.data.showPatchTypes = false
    for i,v in ipairs(this.vm.data.jobsList) do
        v.isSelect = i == index
    end
    if(not IsNullOrEmpty(this.curChooseCharacterSkinId)) then
        this.vm.data.isShowCharacterTexture = true;
    end
    if this.jobIndex == index then return end;
    this.jobIndex = index;
    this.SetSideBarCharacterList()
end

this.SetSideBarCharacterList = function()
    local index = 1;
    local tempList = {}
    for k, item in pairs(this.characterSkinList) do
        local config = ConfigMgr.Config.characterTable[item.characterId]
            if this.jobIndex == 1 or this.jobIndex == config.job+1 then
            local item = {
                index = index,
                skinId = item.skinId,
                skinTexture = LuaMgr.GetTexture( ConfigHelper.GetCharacterAvatarPath(item.characterId, item.skinId)), 
                isSelect = item.skinId == this.curChooseCharacterSkinId,
            }
            table.insert(tempList, item)
            index = index + 1
        end
    end
    this.vm.data.chaSkinVMList = tempList
    this.vm.data.contentAnchedPos = Vector2.zero
end

this.ChoosePatchType = function(catalog)
    this.vm.data.showChaJobs = false
    this.vm.data.showPatchTypes = true
    for i,v in ipairs(this.vm.data.patchTypeList) do
        v.isSelect = v.catalog == catalog
    end
    if this.patchTypeIndex == catalog then return end;
    this.patchTypeIndex = catalog;
    this.SetSideBarPatchList()
end

this.SetSideBarPatchList = function()
    local index = 1;
    local tempList = {}
    for i, item in ipairs(this.patchConfigList) do
        if this.patchTypeIndex == 0 or this.patchTypeIndex == item.Catalog then
            local patchId = item.ResourceID
            local item = {
                index = index,
                patchId = patchId,
                patchSprite = LuaMgr.GetSprite("ActivityCameraIcon", patchId);
                isSelect = this.curChoosePatchIdMap[patchId] ~= nil,
            }
            table.insert(tempList, item)
            index = index + 1
        end
    end
    this.vm.data.patchVMList = tempList
    this.vm.data.contentAnchedPos = Vector2.zero
end

this.SetSideBarThemeList = function()
    local index = 1;
    local tempList = {}
    for k, item in pairs(this.themeConfigList) do
        if (this.photoMode == 1 and item.Type == 4) or (this.photoMode == 2 and item.Type == 3) then
            local themeId = item.ResourceID
            local item = {
                index = index,
                themeId = themeId,
                themeSprite = LuaMgr.GetSprite("ActivityCameraIcon", "ui_pz_pzhy_zt_" .. themeId),
                name = LuaMgr.GetLangText(item.NameLan),
                forbidden = item.Forbidden,
                isSelect = this.curThemeId == themeId,
            }
            table.insert(tempList, item)
            index = index + 1
        end
    end
    this.vm.data.themeVMList = tempList
end

this.ChooseCharacter = function(skinId)
    if this.curChooseCharacterSkinId == skinId then
        return
    end
    
    if skinId == "" then
        this.curChooseCharacterSkinId = skinId
        this.vm.data.isShowCharacterTexture = false;
        return
    end
    
    local characterId = string.sub(skinId, 1, string.len(skinId) - 3)
    local cfgCharacterTable = ConfigMgr.Config.characterTable[characterId];
    if cfgCharacterTable == nil then
        return
    end

    this.curChooseCharacterSkinId = skinId
    this.vm.data.characterTexture = LuaMgr.GetTexture(HeroManager.GetCharacterDrawing(characterId, skinId))
    local re = ActivityCameraMgr.Singleton:GetCharacterPos(characterId, skinId)
    this.characterTextureRect.sizeDelta = re[0]
    local pos = re[1]
    local anchorType = math.floor(pos.y / 10000)
    local anchoredPos = Vector2(pos.x, pos.y - anchorType * 10000)
if anchorType == 1 then
        this.characterTextureRect.anchorMin = Vector2(0, 0)
        this.characterTextureRect.anchorMax = Vector2(0, 0)
elseif anchorType == 2 then
        this.characterTextureRect.anchorMin = Vector2(0.5, 0)
        this.characterTextureRect.anchorMax = Vector2(0.5, 0)
elseif anchorType == 3 then
        this.characterTextureRect.anchorMin = Vector2(1, 0)
        this.characterTextureRect.anchorMax = Vector2(1, 0)
elseif anchorType <= 0 then
        this.characterTextureRect.anchorMin = Vector2(0.5, 0.5)
        this.characterTextureRect.anchorMax = Vector2(0.5, 0.5)
        anchoredPos = Vector2.zero
    end
    
    this.characterTextureRect.anchoredPosition = anchoredPos
    this.vm.data.chaRelicsIcon = LuaMgr.GetTexture(archivesPath .. characterId .. ".png");
    this.vm.data.chaName = LuaMgr.GetLangText(cfgCharacterTable.namelan);
    this.vm.data.chaFullName = LuaMgr.GetLangText(cfgCharacterTable.FullnameLan);
    this.vm.data.isShowCharacterTexture = true;
end

this.LoadTheme = function(themeId)
    this.vm.data.showTheme_pfhy01 = themeId == "pfhy01"
    this.vm.data.showTheme_pfhy02 = themeId == "pfhy02"
    this.vm.data.showTheme_pfhy03 = themeId == "pfhy03"
    this.vm.data.showTheme_pfhy04 = themeId == "pfhy04"
    this.vm.data.showTheme_pfhy05 = themeId == "pfhy05"
    this.vm.data.showTheme_pftz01 = themeId == "pftz01"
    this.vm.data.showTheme_pftz02 = themeId == "pftz02"
    this.vm.data.showTheme_pftz03 = themeId == "pftz03"
    this.curThemeId = themeId
end

this.GetPatchItem = function()
    local patchItem = nil
    for i = 1, this.cfg_MaxPatchCount do
        if i > #this.patchItemList then
            local object = LuaMgr.InstantiateGO(this.patchTemplate, this.patchContent, false)
            local tempItem = {
                index = i,
                id = "",
                cameraImageDrag = object:GetComponent("CameraImageDrag"),
                image = object:GetComponent("Image"),
                rect = object:GetComponent("RectTransform"),
                frameRect = object.transform:Find("Frame").gameObject:GetComponent("RectTransform"),
                isHide = true,
            }
            tempItem.cameraImageDrag:SetData(i, this.OnClickPatch, this.rectCapture)
            table.insert(this.patchItemList, tempItem)
        end
        if this.patchItemList[i].isHide then
            patchItem = this.patchItemList[i]
            break
        end
    end
    return patchItem
end

this.AddPatch = function(patchId)
    if this.curChoosePatchIdMap[patchId] ~= nil then
        return
    end
    local patchItem = this.GetPatchItem()
    if patchItem ~= nil then
        this.curChoosePatchIdMap[patchId] = true
        patchItem.id = patchId
        patchItem.isHide = false
        patchItem.cameraImageDrag:ResetImage()
        patchItem.image.sprite = LuaMgr.GetSprite("ActivityCameraIcon", patchId);
        SetActive(patchItem.frameRect.gameObject, false)
        SetActive(patchItem.rect.gameObject, true)
        if this.vm.data.isEditorMode then
            this.OnClickPatch(patchItem.index)
        end
    else
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityCameraViewModel_1"))
    end
    this.UpdatePatchChooseStatus()
end

this.OnClickPatch = function(index, eventData)
    if this.choosePatchIndex ~= index then
        local oldPatchItem = this.patchItemList[this.choosePatchIndex]
        if oldPatchItem ~= nil then
            SetActive(oldPatchItem.frameRect.gameObject, false)
        end
        this.choosePatchIndex = index;
        this.ShowPatchButtons()
        local patchItem = this.patchItemList[this.choosePatchIndex]
        patchItem.rect:SetSiblingIndex(this.patchContent.childCount)
    else


    end
end

this.RemovePatch = function(patchId, isIndex)
    local patchItem = nil
    for i, v in ipairs(this.patchItemList) do
        if (isIndex and v.index == patchId) or (not isIndex and v.id == patchId) then
            patchItem = v
            break
        end
    end

    if patchItem ~= nil then
        patchItem.isHide = true
        SetActive(patchItem.rect.gameObject, false)

        if this.choosePatchIndex == patchItem.index then
            this.HidePatchButtons()
            this.choosePatchIndex = -1;
        end
        this.curChoosePatchIdMap[patchItem.id] = nil
        this.UpdatePatchChooseStatus()
    end
end

this.RemoveAllPatch = function()
    for i, v in ipairs(this.patchItemList) do
        v.isHide = true
        SetActive(v.rect.gameObject, false)
    end
    this.HidePatchButtons()
    this.choosePatchIndex = -1;
    this.curChoosePatchIdMap = {}
    this.UpdatePatchChooseStatus()
end

this.UpdatePatchChooseStatus = function()
    if this.vm.data.patchVMList ~= nil then
        for i, v in ipairs(this.vm.data.patchVMList) do
            v.isSelect = this.curChoosePatchIdMap[v.patchId] ~= nil
        end
    end
    
    local chooseCount = ConfigHelper.GetTableLength(this.curChoosePatchIdMap)
    this.vm.data.choosePatchCountStr = string.format("%d/%d", chooseCount, this.cfg_MaxPatchCount)
end

this.ShowPatchButtons = function()
    local patchItem = this.patchItemList[this.choosePatchIndex]
    if patchItem ~= nil then
        SetActive(patchItem.frameRect.gameObject, true)
    end
    this.SetButtonParent(this.rectBtnRotate, patchItem.frameRect, true)
    this.SetButtonParent(this.rectBtnScale, patchItem.frameRect, true)
    this.SetButtonParent(this.rectBtnDel, patchItem.frameRect, true)
    this.UpdatePatchContralBtnScale()
end

this.HidePatchButtons = function()
    local patchItem = this.patchItemList[this.choosePatchIndex]
    if patchItem ~= nil then
        SetActive(patchItem.frameRect.gameObject, false)
    end
    this.SetButtonParent(this.rectBtnRotate, this.rectTemplate, false)
    this.SetButtonParent(this.rectBtnScale, this.rectTemplate, false)
    this.SetButtonParent(this.rectBtnDel, this.rectTemplate, false)
end

this.SetButtonParent = function(rect, parent, active)
    rect.parent = parent
    rect.anchoredPosition = Vector2.zero
    rect.localEulerAngles = Vector3.zero
    rect.localScale = Vector3.one
    SetActive(rect.gameObject, active)
end

this.SetPatchContralBtnScale = function(scale)
    local scaleVec = Vector3(scale, scale, scale)
    this.rectBtnRotate.localScale = scaleVec
    this.rectBtnScale.localScale = scaleVec
    this.rectBtnDel.localScale = scaleVec
    this.rectBtnRotate.anchoredPosition = Vector2.zero
    this.rectBtnScale.anchoredPosition = Vector2.zero
    this.rectBtnDel.anchoredPosition = Vector2.zero
end

this.OnCapture = function()
    this.vm.data.showBack = false
    this.vm.data.showButtons = false
    local filename = ActivityCameraMgr.Singleton:GetPicName();
    LuaMgr.NextFrame(function()
        LuaMgr.CaptureScreenByRT(filename, this.rectCapture)
        LuaMgr.NextFrame(function()
            LuaMgr.ShowPanel("Laigu.ViewModel.SharePopupViewModel", "activityCamera", filename, function()
                if this == nil then
                    return
                end
                this.vm.data.showBack = true
                this.vm.data.showButtons = true
            end)
        end)
    end)
end

this.OnRotateBtnBeginDrag = function(index, eventData)
    this.downPos = eventData.position
    this.patchStartRotate = this.patchItemList[this.choosePatchIndex].rect.localEulerAngles.z;
end

this.OnRotateBtnDrag = function(eventData)
    ActivityCameraMgr.Singleton:RotateImage(this.patchItemList[this.choosePatchIndex].rect, this.downPos, eventData.position, this.patchStartRotate)
end

this.OnRotateBtnEndDrag = function(eventData)
    ActivityCameraMgr.Singleton:RotateImage(this.patchItemList[this.choosePatchIndex].rect, this.downPos, eventData.position, this.patchStartRotate)
end

this.OnScaleBtnBeginDrag = function(index, eventData)
    this.downPos = eventData.position
    this.patchStartScale = this.patchItemList[this.choosePatchIndex].rect.localScale.x;
end

this.OnScaleBtnDrag = function(eventData)
    ActivityCameraMgr.Singleton:ScaleImage(this.patchItemList[this.choosePatchIndex].rect, this.downPos, eventData.position, this.patchStartScale)
    this.UpdatePatchContralBtnScale()
end

this.OnScaleBtnEndDrag = function(eventData)
    ActivityCameraMgr.Singleton:ScaleImage(this.patchItemList[this.choosePatchIndex].rect, this.downPos, eventData.position, this.patchStartScale)
    this.UpdatePatchContralBtnScale()
end

this.UpdatePatchContralBtnScale = function()
    local patchItem = this.patchItemList[this.choosePatchIndex]
    if patchItem == nil then
        return
    end

    local imageScale = patchItem.rect.localScale
    this.SetPatchContralBtnScale(1 / imageScale.x)
end

this.CheckUnlock = function(unlockType, unlockParam)
    local isUnLock = false
    if unlockType == 0 then
        isUnLock = true
    elseif unlockType == 2 and not IsNullOrEmpty(unlockParam) then
        local count = PlayerItemMgr.GetItemCountById(unlockParam)
        isUnLock = count > 0
    end
    return isUnLock;
end

this.CheckPermission = function()
    local havePermission = ActivityCameraMgr.Singleton:CheckHaveCameraPermission()
    this.vm.data.showNoPermissionImage = not havePermission
    return havePermission
end

this.ApplyTableForbidden = function(forbiddenType)
    this.openSideBarListType = 0
    this.vm.data.sideBarListTypeLeftLock = false
    this.vm.data.sideBarListTypeRightLock = false
    
    if this.photoMode == 1 then
        this.cha_forbiddenType = forbiddenType
if forbiddenType == 1 then
            this.openSideBarListType = 1
            this.vm.data.isShowCharacterTexture = false
            this.vm.data.sideBarListTypeLeftLock = true
        end
    elseif this.photoMode == 2 then
        this.patch_forbiddenType = forbiddenType

        this.vm.data.isShowCharacterTexture = false
    end
end

this.OnBack = function()
    if this.vm.data.showCheckPermissionPanel then
        this.vm.data.showCheckPermissionPanel = false
        return
    end
    if this.vm.data.showNotSaveConfirmPanel then
        this.vm.data.showNotSaveConfirmPanel = false
        return
    end
    if this.vm.data.isEditorMode and this.CheckIsChanged() then
        this.vm.data.showNotSaveConfirmPanel = true
    else
        if this.photoMode ~= 0 then
            this.photoMode = 0
            this.Refresh()
        else
            LuaMgr.Back();
        end
    end
end

this.Clear = function()
    this = nil;
end

return vm({
    data = data,
    command = command,
    hook = hook
})
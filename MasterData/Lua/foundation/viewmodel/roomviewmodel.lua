local data = {
    isBuilding = false,
    isShowEdit = false,
    buildingList = {{id="",name="",count="",icon=DefaultTexture,comfort="",isDot=false}},
    typeList = {{type=0,bg=DefaultSprite,typeName="",showName="",isDot=false}},
    pos = "",
    rotationColor = UnityEngine.Color(1,1,1,1),
    isThemeBtn = false,
    isShopBtn = false,
    isRoom = false,
    roomList = {{id="",name="",isSelect=false}},
    roomName = "",
    putText = "",
    isDisplay = false,
    isAddCharacter = false,
    addCharacterNum = "",
    isInfo = false,
    staminaNum = "",
    isStaminaReceive = false,
    comfortNum = "",
    playerName = "",
    isMsgBoard = false,
    isLike1 = false,
    isLike2 = false,
    isLeftArrow = false,
    isRightArrow = false,
    isLikeRedDot = false,
    likeCount = "",
    showInfoMode = false,
    showEditMode = false,
};

local this = {
    vm = nil,
    buildView = nil,
    buildOperate = nil,
    middle = nil,
    isEdit = false,
    furniturePath = "Assets/_BundleResources/Images/ItemIcons/%s",
    typeIndex = 0,
    room = "",
    subclass = 0,
    isRotation = false,
    rotationColor = UnityEngine.Color(1,1,1,1),
    roomIndex = 0,
    friendList={},
    isInfoMode = false,
};


this.OnBack = function()
    if (FoundationRoomCtrl.IsPlayAni()) then return end

    if (FoundationMgr.IsVisitor()) then
        LuaMgr.Back();
        return;
    end
    FoundationMgr.StopVoice();
    if (FoundationRoom.IsChange()) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText("RoomViewModel_15"), this.OnConfirm, this.OnCancel);
    else
        this.Back();
    end
end


this.OnConfirm = function()
    FoundationRoom.Save(this.Back);
end


this.OnCancel = function()
    FoundationRoom.Reset();
    this.Back();
end


this.Back = function()
    if (this.isEdit) then
        this.SetEdit(false);
    else
        FoundationMgr.Enter(FoundationMgr.Outside);
    end
end


this.OnRefresh = function(vm)
    vm.behaviour:UpdateTopBar("", this.OnBack);
    this.room = vm.behaviour.Params[0];
    this.SetBuildView();
    this.isEdit = false;
    this.isInfoMode = false
    this.vm.data.isShowEdit = true;
    this.vm.data.isBuilding = false;
    this.vm.data.isThemeBtn = false;
    this.vm.data.isShopBtn = false;
    this.SetRoomList();
    this.SelectRoom();
    this.SetDisplay(true);
    FoundationMsgMgr.ClearDataList();
    if (FoundationMgr.IsVisitor()) then
        PlayerFoundationMgr.VisitLeaveMessageList(nil, true);
    else
        PlayerFoundationMgr.VisitLeaveMessageList(DataMgr.Player.uid, true);
        this.vm.data.isLikeRedDot = false;
        PlayerFoundationMgr.VisitGetLike();
    end
end


this.SetTypeList = function()
    local item;
    local config;
    local list = {};
    local furnitureTypeMap = ConfigMgr.Config.FurnitureTypeMap;
    local subclassList = ConfigFoundationMgr.GetFurnitureSubclassList();
    local len = #subclassList;
    for i = 1, len do
        item = {type=subclassList[i], typeName="", isDot=false};
        if (i == 1) then
            item.bg = LuaMgr.GetSprite("Foundation", "ui_jj_ss_tab04");
        else
            item.bg = LuaMgr.GetSprite("Foundation", "ui_jj_ss_tab02");
        end
        config = furnitureTypeMap[tostring(item.type)];
        if (config ~= nil) then
            item.typeName = LuaMgr.GetLangText(config.Namelan);
            item.showName = item.typeName;
        end
        table.insert(list, item);
    end
    this.vm.data.typeList = list;
    this.SelectType(1);
end


this.SelectType = function(index)
    local itemData;
    if (this.typeIndex > 0) then
        itemData = this.vm.data.typeList[this.typeIndex];
        itemData.bg = LuaMgr.GetSprite("Foundation", this.typeIndex == 1 and "ui_jj_ss_tab01" or "ui_jj_ss_tab02");
        itemData.showName = itemData.typeName;
    end
    itemData = this.vm.data.typeList[index];
    itemData.bg = LuaMgr.GetSprite("Foundation", index == 1 and "ui_jj_ss_tab04" or "ui_jj_ss_tab03");
    itemData.showName = string.format("<color=#000000>%s</color>", itemData.typeName);
    this.typeIndex = index;
    this.subclass = itemData.type;
    this.SetBuildingList();
end


this.SetBuildingList = function()
    local config;
    local building;
    local list = {};
    local furnitures = ConfigFoundationMgr.GetFurnitures(this.subclass);
    local len = #furnitures;
    for i = 1, len do
        config = furnitures[i];
        building = {id=config.Id, 
                    name=LuaMgr.GetLangText(config.NameLan),
                    count=tostring(PlayerFoundationMgr.GetFurnitureItemCount(config.Furniture)),
                    icon=LuaMgr.GetTexture(string.format(this.furniturePath, config.Icon)),
                    comfort=tostring(config.Comfort),
                    isDot=false};
        table.insert(list, building);
    end
    this.vm.data.buildingList = list;
end


this.SetPos = function(x, y)
    this.vm.data.pos = string.format("x:%d y:%d", x, y);
end


this.OperateState = function(isRotation)
    this.isRotation = isRotation;
    if (isRotation) then
        this.rotationColor.r = 1;
        this.rotationColor.g = 1;
        this.rotationColor.b = 1;
    else
        this.rotationColor.r = 0.39;
        this.rotationColor.g = 0.39;
        this.rotationColor.b = 0.39;
    end
    this.vm.data.rotationColor = this.rotationColor;
end


this.SetEdit = function(isEdit)
    this.isEdit = isEdit;
    if (this.isEdit) then
        this.isInfoMode = false
        this.vm.data.showInfoMode = this.isInfoMode
        this.vm.data.showEditMode = not this.isInfoMode
        this.vm.data.isShowEdit = false;
        FoundationRoomCtrl.EnterEdit();
        this.vm.data.isBuilding = true;
        this.vm.data.isRoom = false;
        this.vm.data.isAddCharacter = false;
        this.vm.data.isThemeBtn = true;
        this.vm.data.isShopBtn = true;
        FoundationRoomCtrl.RemoveCharacters();
    else
        this.vm.data.isShowEdit = true;
        this.vm.data.isBuilding = false;
        this.vm.data.isRoom = #this.vm.data.roomList > 1;
        this.vm.data.isAddCharacter = true;
        this.vm.data.isThemeBtn = false;
        this.vm.data.isShopBtn = false;
        FoundationRoomCtrl.ExitEdit();
    end
    this.SetDisplay(not this.isEdit);
end


this.SetBuildView = function()
    FoundationRoom.SetBuildView(this.buildView, this.buildOperate, this.middle, this.SetPos, this.OperateState, this.OnClick);
end


this.OnFurnitureChange = function(args)
    this.SetBuildingList();
end

this.OnSkinChange = function(args)
    this.SetEdit(false);
end


this.SetFurnituresResponse = function(result)
    this.SetEdit(false);
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("PlayerFoundationMgr_19"));
end


this.SetRoomList = function()
    local roomConfig;
    local roomData;
    local list = {};
    this.roomIndex = 1;
    if (FoundationMgr.IsVisitor()) then
        local visitData = PlayerFoundationMgr.GetVisitData();
        if (visitData ~= nil) then
            local len = #visitData.Rooms;
            for i = 1, len do
                roomConfig = ConfigMgr.Config.roomMap[visitData.Rooms[i].RoomId];
                if (roomConfig ~= nil) then
                    roomData = {id=roomConfig.Id, name=LuaMgr.GetLangText(roomConfig.NameLan)};
                    roomData.isSelect = this.roomIndex == i;
                    table.insert(list, roomData);
                end
            end
        end
    else
        local roomList = ConfigFoundationMgr.GetRoomList();
        local mainConfig = PlayerFoundationMgr.GetMainInteraction();
        local len = #roomList;
        for i = 1, len do
            roomConfig = roomList[i];
            if (mainConfig.Level >= roomConfig.Unlock) then
                roomData = {id=roomConfig.Id, name=LuaMgr.GetLangText(roomConfig.NameLan)};
                roomData.isSelect = this.roomIndex == i;
                table.insert(list, roomData);
            end
        end
    end
    this.vm.data.roomList = list;
    this.vm.data.isRoom = #list > 1;
end


this.SelectRoom = function()
    local room;
    local roomId = FoundationMgr.GetRoomId();
    local roomList = this.vm.data.roomList;
    local len = #roomList;
    for i = 1, len do
        room = roomList[i];
        if (room.id == roomId) then
            this.vm.data.roomName = room.name;
            this.roomIndex = i;
            room.isSelect = true;
        else
            room.isSelect = false;
        end
    end
    this.SetRoomArrow();
end


this.SetRoomArrow = function()
    local len = #this.vm.data.roomList;
    this.vm.data.isLeftArrow = this.roomIndex <= 1;
    this.vm.data.isRightArrow = this.roomIndex >= len;
end


this.SetAddCharacter = function(status, isClickScreen)
    this.vm.data.isAddCharacter = status;
    if (status) then
        local roomId = FoundationMgr.GetRoomId();
        local buildingId = PlayerFoundationMgr.GetRoomCharacterInteractionId(roomId);
        local buildingConfig = ConfigFoundationMgr.GetInteractionById(buildingId);
        if (buildingConfig == nil) then return end

        local buildingData = DataMgr.Player.interactions[buildingId];
        if (buildingData == nil) then return end
        
        local count = IsNull(buildingData.Characters) and 0 or #buildingData.Characters;
        this.vm.data.addCharacterNum = string.format("<color=#d9d3c5>%d</color><size=26>/%d</size>", count, buildingConfig.Cap);

        local characters = FoundationRoomCtrl.GetAddCharacters(buildingData.Characters);
        local len = #characters;
        for i = 1, len do
            FoundationRoomCtrl.AddCharacter(characters[i], HeroManager.GetCharacterSkin(characters[i]));
        end
        FoundationRoomCtrl.CheckComfort(true);
        FoundationRoomCtrl.CheckFriendlys();
        if not isClickScreen then
            FoundationRoom.OnShowPlayAudio()
        end
    end
end


this.OnHeroChoice = function(args)
    local roomId = FoundationMgr.GetRoomId();
    local buildingId = PlayerFoundationMgr.GetRoomCharacterInteractionId(roomId);
    if (args[0] == buildingId) then
        this.SetAddCharacter(true);
        FoundationRoom.OnChooseNewCharacter()
    end
end


this.SetVisitCharacter = function()
    local roomId = FoundationMgr.GetRoomId();
    local visitRoomData = PlayerFoundationMgr.GetVisitRoom(roomId);
    if (visitRoomData ~= nil) then
        local characters = {};
        for k, _ in pairs(visitRoomData.Characters) do
            table.insert(characters, k);
        end
        characters = FoundationRoomCtrl.GetAddCharacters(characters);
        local len = #characters;
        if (len > 0) then
            local characterId;
            local characterSkin;
            for i = 1, len do
                characterId = characters[i];
                characterSkin = visitRoomData.Characters[characterId];
                FoundationRoomCtrl.AddCharacter(characterId, characterSkin);
            end
        end
    end
end


this.SetInfo = function(status)
    this.vm.data.isInfo = status;
    if (status) then
        local stamina = PlayerFoundationMgr.GetCurrentStamina();
        local staminaLimit = PlayerFoundationMgr.GetRoomStaminaInteraction();
        this.vm.data.staminaNum = string.format("%d<color=#8a8067>/%d</color>", stamina, staminaLimit);
        this.vm.data.isStaminaReceive = stamina > 0;
        local roomId = FoundationMgr.GetRoomId();
        local comfortBuildingId = PlayerFoundationMgr.GetRoomCharacterInteractionId(roomId);
        local comfortBuildingData = DataMgr.Player.interactions[comfortBuildingId];
        if (comfortBuildingData ~= nil) then
            this.vm.data.comfortNum = tostring(comfortBuildingData.Comfort);
        end
    end
end


this.SetLikeRedDot = function()
    this.vm.data.isLikeRedDot = PlayerFoundationMgr.GetLikePoint() > 0;
end


this.SetMsgBoard = function()
    local visitData = PlayerFoundationMgr.GetVisitData();
    if (visitData == nil) then return end
    
    this.vm.data.isMsgBoard = true;
    if (visitData.LikePoint) then
        this.vm.data.isLike1 = true;
        this.vm.data.isLike2 = false;
    else
        this.vm.data.isLike1 = false;
        this.vm.data.isLike2 = true;
    end
    this.vm.data.playerName = visitData.Name;
    local roomId = FoundationMgr.GetRoomId();
    local roomData = PlayerFoundationMgr.GetVisitRoom(roomId);
    if (roomData ~= nil) then
        this.vm.data.comfortNum = tostring(roomData.Comfort);
    end
    local harvestLikePoint = DataMgr.Player.Friends.HarvestLikePoint;
    local harvestLikePointLimit = ConfigMgr.Config.FriendConstants.HarvestLikePointLimit;
    this.vm.data.likeCount = string.format(ConfigMgr.LangGlobal("17021"), harvestLikePoint, harvestLikePointLimit);
end


this.SetDisplay = function(status)
    if (FoundationMgr.IsVisitor()) then
        this.vm.data.isDisplay = false;
        this.vm.data.isShowEdit = false;
        this.SetAddCharacter(false);
        this.SetVisitCharacter();
        this.SetInfo(false);
        this.SetMsgBoard();
        FoundationMsgMgr.Show();
    else
        this.vm.data.isDisplay = status;
        this.vm.data.isShowEdit = status;
        this.vm.data.isMsgBoard = false;
        this.SetAddCharacter(status, true);
        this.SetInfo(status);
        if (status) then
            FoundationMsgMgr.Show();
        else
            FoundationMsgMgr.Hide();
        end
    end
end


this.SwitchRoom = function(index)
    if (this.roomIndex ~= index) then
        if (not FoundationMgr.IsVisitor()) then
            local mainConfig = PlayerFoundationMgr.GetMainInteraction();
            local room = this.vm.data.roomList[index];
            local roomConfig = ConfigMgr.Config.roomMap[room.id];
            if (roomConfig ~= nil and mainConfig.Level < roomConfig.Unlock) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_20"));
                return;
            end
        end
        local room = this.vm.data.roomList[this.roomIndex];
        room.isSelect = false;
        this.roomIndex = index;
        room = this.vm.data.roomList[this.roomIndex];
        room.isSelect = true;
        this.vm.data.roomName = room.name;
        this.SetRoomArrow();
        FoundationMgr.SetRoomId(room.id);
        LuaMgr.ShowLuaPanel(UIName.FoundationTransitionViewModel, this.OnSwitchRoom);
    end
end


this.OnSwitchRoom = function()
    FoundationRoom.Clear();
    FoundationRoom.Show();
end


this.OnClick = function()
    if (this.isEdit) then return end
    
    this.SetDisplay(true);
end


this.GetExtraStaminaResponse = function(result)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("6958"));
    this.SetInfo(true);
end


this.OnShopConfirm = function()
    FoundationRoom.Save(this.ShowShop);
end


this.OnShopCancel = function()
end


this.ShowShop = function()
    FoundationRoomCtrl.ExitEdit();
    LuaMgr.ShowLuaPanel(UIName.MarketViewModel, "furnitureShop_furniture1");
end


this.GetCurrentStamina = function()
    return PlayerFoundationMgr.GetCurrentStamina();
end


this.CheckStaminaReceive = function()
    local maxStamina = ConfigMgr.Config.constants.maxStamina;
    local stamina = DataMgr.Player.stamina;
    if (stamina >= maxStamina) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("6960"));
        return;
    end
    local addStamina = maxStamina - stamina;
    local currentStamina = this.GetCurrentStamina();
    if (currentStamina < addStamina) then
        PlayerFoundationMgr.GetExtraStamina(this.GetExtraStaminaResponse);
        return;
    end
    local msg = ConfigMgr.LangGlobal("6961");
    msg = string.format(msg, stamina, maxStamina, addStamina);
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, msg, this.OnStaminaConfirm, this.OnStaminaCancel);
end


this.OnStaminaConfirm = function()
    PlayerFoundationMgr.GetExtraStamina(this.GetExtraStaminaResponse);
end


this.OnStaminaCancel = function()
end


this.VisitLikeResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        local visitData = PlayerFoundationMgr.GetVisitData();
        if (visitData ~= nil) then
            visitData.LikePoint = true;
            this.SetMsgBoard();
        end
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_22"));
        end
    end
end

local command = {
    OnClickType = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1;
            if (index ~= this.typeIndex) then
                this.SelectType(index);
            end
        end
    },
    OnClickBuilding = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (FoundationRoomCtrl.IsPlayAni()) then return end
            
            local building = this.vm.data.buildingList[param + 1];
            if (building ~= nil) then
                local config = ConfigFoundationMgr.GetInteractionById(building.id);
                if (config == nil) then return end

                if this.isInfoMode then
                    if not IsNullOrEmpty(config.Furniture) then
                        LuaMgr.ShowLuaPanel(UIName.FoundationGoodsTipsPopup, config.Id)
                    end
                else
                    local count = PlayerFoundationMgr.GetFurnitureItemCount(config.Furniture);
                    if (count <= 0) then
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_17"));
                        return;
                    end
                    FoundationRoom.SetBuilding(building.id);
                end
            end
        end
    },
    OnClickRotation = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.isRotation) then
                FoundationRoom.RotationBuilding();
            else
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_18"));
            end
        end
    },
    OnClickRemove = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.NextFrame(FoundationRoom.RemoveBuilding);
        end
    },
    OnClickCancel = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            
        end
    },
    OnClickEdit = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not FoundationRoomCtrl.IsPlayAni()) then
                FoundationMgr.DelayClick = true;
                this.SetEdit(not this.isEdit);
            end
        end
    },
    OnClickReset = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FoundationRoom.Reset();
        end
    },
    OnClickSave = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FoundationRoom.Save(this.SetFurnituresResponse);
        end
    },
    OnClickClear = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FoundationRoom.ClearAll();
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_19"));
        end
    },
    OnClickShop = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (FoundationRoom.IsChange()) then
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal("6959"), this.OnShopConfirm, this.OnShopCancel);
                return;
            end
            this.ShowShop();
        end
    },
    OnClickPut = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationQuickSetViewModel);
        end
    },
    OnClickTheme = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationThemeViewModel);
        end
    },
    OnClickRoomLeft = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = this.roomIndex > 1 and this.roomIndex - 1 or 1;
            this.SwitchRoom(index);
        end
    },
    OnClickRoomRight = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local len = #this.vm.data.roomList;
            local index = this.roomIndex < len and this.roomIndex + 1 or len;
            this.SwitchRoom(index);
        end
    },
    OnClickDisplay = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FoundationMgr.DelayClick = true;
            this.SetDisplay(false);

        end
    },
    OnClickAddCharacter = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local roomId = FoundationMgr.GetRoomId();
            local buildingId = PlayerFoundationMgr.GetRoomCharacterInteractionId(roomId);
            local buildingConfig = ConfigFoundationMgr.GetInteractionById(buildingId);
            if (buildingConfig ~= nil) then
                local buildingData = DataMgr.Player.interactions[buildingId];
                if (buildingData ~= nil) then
                    LuaMgr.ShowLuaPanel(UIName.FoundationHeroChoiceViewModel, buildingConfig.Id, buildingData.Characters, buildingConfig.Cap);
                end
            end
        end
    },
    OnClickStaminaReceive = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.CheckStaminaReceive();
        end
    },
    OnClickMsgInfo = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationMsgBoardViewModel);
        end
    },
    OnClickMsgBoard = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationMsgBoardViewModel);
        end
    },
    OnClickLike = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local visitData = PlayerFoundationMgr.GetVisitData();
            if (visitData ~= nil) then
                if (visitData.LikePoint) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_23"));
                    return;
                end
                PlayerFoundationMgr.VisitLike(this.VisitLikeResponse);
            end
        end
    },
    OnClickLikeRecord = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            PlayerFoundationMgr.VisitRecord();
        end
    },
    OnClickNextFriendRoom={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            PlayerFoundationMgr.VisitNextFriend();
        end
    },
    OnClickSwitchInfoMode={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.isInfoMode = not this.isInfoMode
            this.vm.data.showInfoMode = this.isInfoMode
            this.vm.data.showEditMode = not this.isInfoMode
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.buildView = vm.behaviour.transform:Find("root/Middle/BuildView");
        this.buildOperate = vm.behaviour.transform:Find("root/Middle/BuildView/Operate").gameObject;
        this.middle = vm.behaviour.transform:Find("root/Middle");
        FoundationMsgMgr.Init(vm.behaviour.transform:Find("template/MsgItem").gameObject, vm.behaviour.transform:Find("root/Left/MsgList"));
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.AddUIEventListener(UIEventConst.FoundationRoomFurnitureChange, this.OnFurnitureChange);
        LuaMgr.AddUIEventListener(UIEventConst.FoundationRoomSkinChange, this.OnSkinChange);
        LuaMgr.AddUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
        LuaMgr.AddUIEventListener(UIEventConst.FoundationLikeRefresh, this.SetLikeRedDot);
        PlayerFoundationMgr.InitFurnitureItems();
        this.SetTypeList();
        this.OnRefresh(vm);
    end,
    refresh = this.OnRefresh,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationRoomFurnitureChange, this.OnFurnitureChange);
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationRoomSkinChange, this.OnSkinChange);
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationLikeRefresh, this.SetLikeRedDot);
        FoundationRoom.ClearBuildView();
        FoundationMsgMgr.Clear();
    end,
    before_destroy = function(vm)
        FoundationMsgMgr.Destroy();
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
local data = {
    isBuilding = false,
    isShowEdit = false,
    isShowEditDisable = false,
    buildingList = {{id="",name="",count="",icon=DefaultTexture,comfort="",isDot=false,isInteract=false}},
    typeList = {{type=0,bg=DefaultSprite,typeName="",showName="",isDot=false}},
    pos = "",
    rotationColor = UnityEngine.Color(1,1,1,1),
    isRoom = false,
    roomList = {{id="",name="",isSelect=false}},
    roomName = "",
    isDisplay = false,
    isAddCharacter = false,
    addCharacterNum = "",
    isInfo = false,
    playerName = "",
    isLeftArrow = false,
    isRightArrow = false,
    isShowScore = false,
    scoreNum = "",
    isScoreAdd = false,
    isScoreAddUp = false,
    isScoreAddDown = false,
    addScore = "",
    isShowVisitor = false,
    isShowReward = false,
    isShowLike = false,
    isShowShare = false,
    isShowTodayLike = false,
    isShowTodayNum = false,
    likeCount = "",
    isShowShareNum = false,
    shareNum = "",
    shareIcon = DefaultTexture,
    todayNum = "",
    todayLike = "",
    isShowUI = false,
    isShowPlayerInfo = false,
    playerHead = DefaultTexture,
    playerFrame = DefaultSprite,
    playerName = "",
    playerScore = "",
    playerLike = "",
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
    friendList = {},
    activityRoomScore = 0,
    playerHeadFrame = nil,
};


this.OnBack = function()
    if (FoundationRoomCtrl.IsPlayAni()) then return end

    if (FoundationMgr.IsVisitor()) then
        if (FoundationMgr.IsActivityRoom()) then
            FoundationMgr.Open(FoundationMgr.ActivityRoom);
        else
            LuaMgr.Back();
        end
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
        FoundationRoomCtrl.RemoveCharacters();
        LuaMgr.GoToHome(UIName.DHHome2ViewModel, nil, false);
    end
end


this.OnRefresh = function(vm)
    vm.behaviour:UpdateTopBar("", this.OnBack);
    this.room = vm.behaviour.Params[0];
    this.SetBuildView();
    this.isEdit = false;
    this.vm.data.isShowEdit = true;
    this.vm.data.isBuilding = false;
    this.SetRoomList();
    this.SelectRoom();
    this.SetDisplay(true);
end


this.SetTypeList = function()
    local item;
    local config;
    local resId;
    local list = {};
    local furnitureTypeMap = ConfigMgr.Config.FurnitureTypeMap;
    local subclassList = ConfigFoundationMgr.GetFurnitureSubclassList();
    local len = #subclassList;
    for i = 1, len do
        item = {type=subclassList[i], typeName="", isDot=false};
        if (FoundationMgr.IsActivityRoom()) then
            resId = i == 1 and "ui_hd_jjfx_jjbf_lban1" or "ui_hd_jjfx_jjbf_lban";
        else
            resId = i == 1 and "ui_jj_ss_tab04" or "ui_jj_ss_tab02";
        end
        item.bg = LuaMgr.GetSprite("Foundation", resId);
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
    local resId;
    local colorStr;
    if (this.typeIndex > 0) then
        itemData = this.vm.data.typeList[this.typeIndex];
        if (FoundationMgr.IsActivityRoom()) then
            resId = this.typeIndex == 1 and "ui_hd_jjfx_jjbf_lban0" or "ui_hd_jjfx_jjbf_lban";
            colorStr = "<color=#FFF6DD>%s</color>";
        else
            resId = this.typeIndex == 1 and "ui_jj_ss_tab01" or "ui_jj_ss_tab02";
            colorStr = "<color=#9A9A99>%s</color>";
        end
        itemData.bg = LuaMgr.GetSprite("Foundation", resId);
        itemData.showName = string.format(colorStr, itemData.typeName);
    end
    itemData = this.vm.data.typeList[index];
    if (FoundationMgr.IsActivityRoom()) then
        resId = index == 1 and "ui_hd_jjfx_jjbf_lban1" or "ui_hd_jjfx_jjbf_lban2";
        colorStr = "<color=#633012>%s</color>";
    else
        resId = index == 1 and "ui_jj_ss_tab04" or "ui_jj_ss_tab03";
        colorStr = "<color=#000000>%s</color>";
    end
    itemData.bg = LuaMgr.GetSprite("Foundation", resId);
    itemData.showName = string.format(colorStr, itemData.typeName);
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
                    isDot=false,
                    isInteract=config.Intertag>=1};
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
        this.vm.data.isShowEdit = false;
        FoundationRoomCtrl.EnterEdit();
        this.vm.data.isBuilding = true;
        this.vm.data.isRoom = false;
        this.vm.data.isAddCharacter = false;
        this.vm.data.isShowVisitor = false;
        this.vm.data.isShowReward = false;
        this.vm.data.isShowLike = false;
        this.vm.data.isShowShare = false;
        this.vm.data.isShowTodayLike = false;
        this.vm.data.isShowTodayNum = false;
        FoundationRoomCtrl.RemoveCharacters();
    else
        this.vm.data.isShowEdit = true;
        this.vm.data.isBuilding = false;
        this.vm.data.isRoom = #this.vm.data.roomList > 1;
        this.vm.data.isAddCharacter = true;
        this.vm.data.isShowVisitor = true;
        this.vm.data.isShowReward = true;
        this.vm.data.isShowLike = true;
        this.vm.data.isShowShare = true;
        this.vm.data.isScoreAdd = false;
        this.vm.data.isShowTodayLike = true;
        this.vm.data.isShowTodayNum = true;
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


this.SetFurnituresResponse = function(result)
    this.SetEdit(false);
    this.SetRoomList();
    this.SelectRoom();
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityRoomViewModel_0"));
end


this.SetRoomList = function()
    local roomConfig;
    local roomData;
    local list = {};
    this.roomIndex = 1;
    if (FoundationMgr.IsVisitor()) then
        if (FoundationMgr.IsActivityRoom()) then
            local visitData = PlayerFoundationMgr.GetActivityVisitData();
            if (visitData ~= nil) then
                for k, _ in pairs(visitData) do
                    roomConfig = ConfigMgr.Config.roomMap[k];
                    if (roomConfig ~= nil) then
                        roomData = {id=roomConfig.Id, name=LuaMgr.GetLangText(roomConfig.NameLan)};
                        roomData.isSelect = this.roomIndex == i;
                        table.insert(list, roomData);
                    end
                end
                table.sort(list, this.SortVisitRoom);
            end
        else
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
        end
    else
        if (FoundationMgr.IsActivityRoom()) then
            local score;
            local unlockScore;
            local roomList = ConfigFoundationMgr.GetActivityRoomList();
            local len = #roomList;
            for i = 1, len do
                roomConfig = roomList[i];
                if (#roomConfig.Unlock2 > 0) then
                    score = PlayerFoundationMgr.GetActivityRoomScore(roomConfig.Unlock2[1]);
                    unlockScore = tonumber(roomConfig.Unlock2[2]);
                else
                    score = 0;
                    unlockScore = 0;
                end
                if (score >= unlockScore) then
                    roomData = {id=roomConfig.Id, name=LuaMgr.GetLangText(roomConfig.NameLan)};
                    roomData.isSelect = this.roomIndex == i;
                    table.insert(list, roomData);
                end
            end
        else
            local roomList = ConfigFoundationMgr.GetRoomList();
            local mainConfig = PlayerFoundationMgr.GetMainInteraction();
            local len = #roomList;
            for i = 1, len do
                roomConfig = roomList[i];
                if (mainConfig ~= nil and mainConfig.Level >= roomConfig.Unlock) then
                    roomData = {id=roomConfig.Id, name=LuaMgr.GetLangText(roomConfig.NameLan)};
                    roomData.isSelect = this.roomIndex == i;
                    table.insert(list, roomData);
                end
            end
        end
    end
    this.vm.data.roomList = list;
    this.vm.data.isRoom = #list > 1;
end


this.SortVisitRoom = function(a, b)
    return tonumber(a.id) < tonumber(b.id);
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


this.SetAddCharacter = function(status)
    this.vm.data.isAddCharacter = status;
    if (status) then
        local roomId = FoundationMgr.GetRoomId();
        local buildingId = PlayerFoundationMgr.GetRoomCharacterInteractionId(roomId);
        local buildingConfig = ConfigFoundationMgr.GetInteractionById(buildingId);
        if (buildingConfig == nil) then return end

        local buildingData = DataMgr.Player.interactions[buildingId];
        if (buildingData == nil) then return end
        
        local count = IsNull(buildingData.Characters) and 0 or #buildingData.Characters;
        this.vm.data.addCharacterNum = string.format("%d<size=26><color=#633012>/%d</color></size>", count, buildingConfig.Cap);

        local characters = FoundationRoomCtrl.GetAddCharacters(buildingData.Characters);
        local len = #characters;
        for i = 1, len do
            FoundationRoomCtrl.AddCharacter(characters[i], HeroManager.GetCharacterSkin(characters[i]));
        end
    end
end


this.OnHeroChoice = function(args)
    local roomId = FoundationMgr.GetRoomId();
    local buildingId = PlayerFoundationMgr.GetRoomCharacterInteractionId(roomId);
    if (args[0] == buildingId) then
        this.SetAddCharacter(true);
    end
end


this.SetVisitCharacter = function()
    local visitRoomData;
    local isInteract = false;
    local characters = {};
    local roomId = FoundationMgr.GetRoomId();
    if (FoundationMgr.IsActivityRoom()) then
        visitRoomData = PlayerFoundationMgr.GetActivityVisitRoom(roomId);
        if (visitRoomData ~= nil) then
            for k, _ in pairs(visitRoomData.Characters) do
                table.insert(characters, k);
            end
            isInteract = #characters;
        end
    else
        visitRoomData = PlayerFoundationMgr.GetVisitRoom(roomId);
        if (visitRoomData ~= nil) then
            for k, _ in pairs(visitRoomData.Characters) do
                table.insert(characters, k);
            end
        end
    end
    if (visitRoomData == nil) then return end
    
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
    if (isInteract) then
        FoundationRoomCtrl.RandomInteract();
    end
end


this.SetVisitPlayerInfo = function()
    local playerData = PlayerFoundationMgr.GetActivityVisitPlayer();
    if (playerData == nil) then return end
    
    local avatarData = FoundationMsgMgr.GetAvatarFrame(playerData.Avatar);
    if (avatarData ~= nil) then
        local headPath = ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId);
        this.vm.data.playerHead = LuaMgr.GetTexture(headPath);
    end
    this.vm.data.playerFrame = PlayerAvatarFrameTool.GetStaticSprite(playerData.AvatarFrame);
    local hasFrameEffect = PlayerAvatarFrameTool.SetAvatarFrame(this.playerHeadFrame, playerData.AvatarFrame);
    if not hasFrameEffect then
        if not IsObjectNull(this.playerHeadFrame.sprite) then
            this.playerHeadFrame:SetNativeSize();
        end
    end
    this.vm.data.playerName = playerData.Name;
    this.vm.data.playerScore = LuaMgr.GetLangText("ActivityRoomViewModel_5") .. playerData.Score;
    this.vm.data.playerLike = tostring(playerData.LikePoint);
end


this.SetDisplay = function(status)
    if (FoundationMgr.IsVisitor()) then
        this.vm.data.isDisplay = status;
        this.vm.data.isShowEdit = false;
        this.SetAddCharacter(false);
        this.SetVisitCharacter();
        this.vm.data.isShowVisitor = status;
        this.vm.data.isAddCharacter = false;
        this.vm.data.isShowReward = false;
        this.vm.data.isShowLike = false;
        this.vm.data.isShowShare = false;
        this.vm.data.isShowScore = false;
        this.vm.data.isShowTodayLike = status;
        this.vm.data.isShowTodayNum = status;
        this.SetVisitPlayerInfo();
        this.vm.data.isShowPlayerInfo = status;
        this.SetTodayNum();
        this.SetTodayLike();
    else
        this.vm.data.isDisplay = status;
        this.vm.data.isShowEdit = status;
        local roomId = FoundationMgr.GetRoomId();
        local roomConfig = ConfigMgr.Config.roomMap[roomId];
        if (roomConfig ~= nil and roomConfig.RoomType == 1) then
            this.vm.data.isShowEditDisable = true;
            this.vm.data.isShowScore = true;
        else
            this.vm.data.isShowEditDisable = false;
            this.vm.data.isShowScore = false;
        end
        this.SetAddCharacter(status);
        this.vm.data.isShowVisitor = status;
        this.vm.data.isShowReward = status;
        this.vm.data.isShowLike = status;
        this.vm.data.isShowShare = status;
        this.vm.data.isShowTodayLike = false;
        this.vm.data.isShowTodayNum = false;
        this.vm.data.isShowPlayerInfo = false;
        this.SetLikeCount();
        this.SetScore();
        this.SetShareReward();
    end
end


this.SetLikeCount = function()
    this.vm.data.likeCount = string.format("x %d", DataMgr.Player.ShareF.GetLikePoint);
end


this.SetScore = function()
    local room = this.vm.data.roomList[this.roomIndex];
    this.activityRoomScore = PlayerFoundationMgr.GetActivityRoomScore(room.id);
    this.vm.data.scoreNum = tostring(this.activityRoomScore);
end


this.SetScoreAdd = function()
    local score = FoundationRoom.GetPutFurnitureScore();
    local addScore = score - this.activityRoomScore;
    if (addScore > 0) then
        this.vm.data.addScore = "+" .. tostring(addScore);
        this.vm.data.isScoreAddUp = true;
        this.vm.data.isScoreAddDown = false;
    else
        this.vm.data.addScore = tostring(addScore);
        this.vm.data.isScoreAddUp = false;
        this.vm.data.isScoreAddDown = true;
    end
    this.vm.data.isScoreAdd = true;
end


this.SetShareReward = function()
    local shareCount = DataMgr.Player.ShareF.ShareCount;
    local reward = ConfigMgr.Config.constants.RoomDecorationReward[shareCount + 1];
    if (reward ~= nil and #reward >= 2) then
        this.vm.data.shareIcon = GetItemTexture(reward[1]);
        this.vm.data.shareNum = reward[2];
        this.vm.data.isShowShareNum = true;
    else
        this.vm.data.isShowShareNum = false;
    end
end


this.SetTodayNum = function()
    local interactCount = DataMgr.Player.ShareF.InteractCount;
    local roomDecorationRewardLimit = ConfigMgr.Config.constants.RoomDecorationRewardLimit;
    this.vm.data.todayNum = string.format(LuaMgr.GetLangText("ActivityRoomViewModel_1"), interactCount, roomDecorationRewardLimit);
end


this.SetTodayLike = function()
    local likePoint = DataMgr.Player.ShareF.LikePoint;
    local roomDecorationLikeLimit = ConfigMgr.Config.constants.RoomDecorationLikeLimit;
    this.vm.data.todayLike = string.format(LuaMgr.GetLangText("ActivityRoomViewModel_2"), likePoint, roomDecorationLikeLimit);
end


this.SwitchRoom = function(index)
    if (this.roomIndex ~= index) then
        if (FoundationMgr.IsVisitor() and FoundationMgr.IsActivityRoom()) then
            local room = this.vm.data.roomList[index];
            local roomData = PlayerFoundationMgr.GetActivityVisitRoom(room.id);
            if (roomData ~= nil and not roomData.Unlock) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityRoomViewModel_3"));
                return;
            end
        end
        if (not FoundationMgr.IsVisitor() and not FoundationMgr.IsActivityRoom()) then
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


this.OnDelayRemove = function()
    FoundationRoom.RemoveBuilding();
    this.SetScoreAdd();
end


this.OnSwitchRoom = function()
    FoundationRoom.Clear();
    FoundationRoom.Show();
    PlayerFoundationMgr.EnterDunHuangRoom(this.EnterDunHuangRoomResponse);
end


this.EnterDunHuangRoomResponse = function()
    this.SetLikeCount();
end


this.OnClick = function()
    if (this.isEdit) then return end
    
    this.SetDisplay(true);
end


this.TodayLikeResponse = function(result)
    local resultData = json.decode(result);
    if (resultData ~= nil and resultData.result ~= nil) then
        if (not IsNull(resultData.result.Rewards)) then
            local reward = json.encode(resultData.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        end
    end
    this.SetTodayNum();
    this.SetTodayLike();
end


this.Share = function()
    LuaMgr.HidePanel("Laigu.ViewModel.TopBarViewModel");
    LuaMgr.HidePanel(UIName.MessageTipsViewModel);
    LuaMgr.HidePanel(UIName.NoticeRollhorseViewModel);
    this.vm.data.isShowUI = false;
    local fileName = "screenshot/shareScreenshot.png";
    LuaMgr.NextFrame(function()
        LuaMgr.CaptureScreenshot(fileName);
        local path = UnityEngine.Application.persistentDataPath .. "/" .. fileName;
        LuaMgr.NextFrame(function()
            LuaMgr.ShowPanel("Laigu.ViewModel.SharePopupViewModel", "foundation", path, function()
                this.vm.data.isShowUI = true;
                this.vm.behaviour:UpdateTopBar("", this.OnBack);
                PlayerFoundationMgr.ShareRewards(this.ShareRewardsResponse);
            end);
        end);
    end);
end


this.ShareRewardsResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result.Rewards)) then
            local reward = json.encode(data.result.Rewards);
            LuaMgr.ShowItemRewared(reward);
        end
    end
    this.SetShareReward();
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

                local count = PlayerFoundationMgr.GetFurnitureItemCount(config.Furniture);
                if (count <= 0) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_17"));
                    return;
                end
                FoundationRoom.SetBuilding(building.id);
                this.SetScoreAdd();
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
            LuaMgr.NextFrame(this.OnDelayRemove);
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
            if (this.vm.data.isShowEditDisable) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityRoomViewModel_4"));
                return;
            end
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
            this.SetScoreAdd();
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
            this.SetScoreAdd();
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("RoomViewModel_19"));
        end
    },
    OnClickPut = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FoundationRoom.ClearAll();
            FoundationRoom.PutFurniture();
            this.SetScoreAdd();
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
    OnClickVisitor = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            PlayerFoundationMgr.VisitList();
        end
    },
    OnClickReward = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.ActivityRoomRewardViewModel);
        end
    },
    OnClickShare = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.Share();
        end
    },
    OnClickTodayLike = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local likePoint = DataMgr.Player.ShareF.LikePoint;
            local roomDecorationLikeLimit = ConfigMgr.Config.constants.RoomDecorationLikeLimit;
            if (likePoint >= roomDecorationLikeLimit) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("22660"));
                return;
            end
            PlayerFoundationMgr.Interact(ActivityRoomInteract.Like, this.TodayLikeResponse);
        end
    },
    OnClickLike = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("22661"));
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.buildView = vm.behaviour.transform:Find("root/Middle/BuildView");
        this.buildOperate = vm.behaviour.transform:Find("root/Middle/BuildView/Operate").gameObject;
        this.middle = vm.behaviour.transform:Find("root/Middle");
        this.playerHeadFrame = vm.behaviour.transform:Find("root/Left/Group/PlayerInfo/Head/Frame"):GetComponent("Image");
        RedMgr.Singleton:RegisterViewModel(UIName.ActivityRoomViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.vm.data.isShowUI = true;
        LuaMgr.AddUIEventListener(UIEventConst.FoundationRoomFurnitureChange, this.OnFurnitureChange);
        LuaMgr.AddUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
        PlayerFoundationMgr.InitFurnitureItems();
        this.SetTypeList();
        this.OnRefresh(vm);
        HeroRedDataHelper.SetDH2Red();
        RedMgr.Singleton:Refresh();
    end,
    refresh = this.OnRefresh,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationRoomFurnitureChange, this.OnFurnitureChange);
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
        FoundationRoom.ClearBuildView();
    end,
    before_destroy = function(vm)
        PlayerAvatarFrameTool.ClearImage(this.playerHeadFrame);
        RedMgr.Singleton:RemoveViewModel(UIName.ActivityRoomViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})
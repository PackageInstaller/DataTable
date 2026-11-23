require("Voyage/VoyageRichManRandomEvent");
require("Voyage/VoyageRichManTimeMgr");
require("Voyage/VoyageRichManSceneMgr");

VoyageRichManMgr = {}

local this = {
    sceneGO = nil,
    camera = nil,
    cameraSize = nil,
    cameraEff = nil,
    container = nil,
    gridsContainer = nil,
    gridList = nil,
    myShip = nil,
    corsair = nil,
    isWait = false,
    isDrop = false,
    nextTime = 0,
    isRollDice = false,
    result = nil,
    status = "",
    gotoArrowList = nil,
    isGotoArrow = false,
    openHarbor = false,
    isDungeon = false,
    winEffect = nil,
    battleMembers = nil,
    isAutoDice = false,
    itemRewardTime = 0,
};

VoyageRichManMgr.Init = function()
    this.sceneGO = LuaMgr.GetPrefab("Assets/_BundleResources/Voyage/VoyageRichManScene.prefab");
    local sceneTF = this.sceneGO.transform;
    this.camera = sceneTF:Find("Art/camera/Camera"):GetComponent("Camera");
    this.cameraSize = this.camera.orthographicSize;
    this.cameraEff = sceneTF:Find("Art/camera/Camera/eff_camera").gameObject;
    SetActive(this.cameraEff, false);
    this.container = sceneTF:Find("Container");
    this.gridsContainer = sceneTF:Find("Container/Grids");

    this.SetContainer();
    this.InitGrids();
    this.InitData();
    VoyageRichManRandomEvent.Init(this.container);
    local sailingCameraScale = ConfigMgr.Config.constants.SailingCameraScale;
    VoyageRichManSceneMgr.Init(this.camera, sailingCameraScale[1], sailingCameraScale[2]);
    LuaMgr.AddUpdate(this.OnUpdate);
    this.SetAntiAliasing();
    if (this.isDungeon) then
        this.isDungeon = false;
        VoyageRichManMgr.Start();
        VoyageRichManSceneMgr.Resume();
    else
        VoyageRichManSceneMgr.Goto(ConfigMgr.Config.constants.SailingCameraOrigin[1]);
    end
    this.isWait = true;
    this.isDrop = false;
end

VoyageRichManMgr.Destroy = function()
    LuaMgr.RemoveUpdate(this.OnUpdate);
    LuaMgr.AntiAliasing(0);
    VoyageRichManRandomEvent.Destroy();
    VoyageRichManSceneMgr.Clear();
    VoyageRichManTimeMgr.Clear();
    this.RemoveWinEffect();
    this.container = nil;
    this.myShip = nil;
    this.RemoveMyShip();
    this.RemoveCorsair();
    this.RemoveGrids();
    this.RemoveGotoArrow();
    this.isWait = false;
    this.isRollDice = false;
    this.result = nil;
    this.isGotoArrow = false;
    this.battleMembers = nil;
    this.countdownTime = 0;
    this.countdownCallback = nil;
    this.countdownData = nil;
    this.cameraEff = nil;
    if (this.sceneGO ~= nil) then
        LuaMgr.DestroyImmediateGO(this.sceneGO);
        this.sceneGO = nil;
    end
end


VoyageRichManMgr.OpenHarbor = function(openHarbor)
    this.openHarbor = openHarbor;
end


VoyageRichManMgr.Start = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManStart);
end


VoyageRichManMgr.IsDungeon = function()
    return this.isDungeon;
end


VoyageRichManMgr.BattleMember = function(member)
    if (this.battleMembers == nil) then
        this.battleMembers = {};
    end
    if (this.battleMembers[member.ID] == nil) then
        this.battleMembers[member.ID] = member;
    else
        this.battleMembers[member.ID] = nil;
    end
end


VoyageRichManMgr.HasBattleMember = function(memberId)
    return this.battleMembers ~= nil and this.battleMembers[memberId] ~= nil;
end


VoyageRichManMgr.GetBattleMembers = function()
    return this.battleMembers;
end


VoyageRichManMgr.InitStatus = function()
    this.isWait = false;
    if (this.openHarbor) then
        this.openHarbor = false;
        this.status = VoyageRichManStatus.OpenHarbor;
        this.isWait = true;
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManStatusViewModel, this.status);
    else
        this.status = VoyageRichManStatus.Runing;
        this.nextTime = VoyageRichManTimeMgr.GetTime() + 1;
        local sailing = DataMgr.Player.Sailing;
        if (not IsNullOrEmpty(sailing.PendingBattle)) then
            this.CheckEnterDungeon(sailing.PendingBattle, sailing.Members);
        end
    end
end


VoyageRichManMgr.BattleResult = function()
    local sailing = DataMgr.Player.Sailing;
    if (sailing.BattleResult == VoyageRichManBattleResult.Success) then return end
    if (sailing.BattleResult == VoyageRichManBattleResult.Start) then return end
    if (IsNullOrEmpty(sailing.BattleEvent)) then return end
    if (this.HasEvent()) then return end
    
    local eventConfig = ConfigVoyageMgr.GetSailingEvent(sailing.BattleEvent);
    if (eventConfig == nil) then return end

    local msg = "";
    if (sailing.BattleResult == VoyageRichManBattleResult.Fail) then
        msg = string.format(ConfigMgr.LangGlobal("10465"), tostring(eventConfig.DiceOut));
    elseif (sailing.BattleResult == VoyageRichManBattleResult.NoMember) then
        msg = string.format(ConfigMgr.LangGlobal("10464"), tostring(eventConfig.DiceOut));
    end
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg);
    PlayerVoyageMgr.SetRollDiceCount(true);
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowDice, VoyageEventConst.DiceMinus);
end


VoyageRichManMgr.StatusComplete = function()
    this.isWait = false;
end


VoyageRichManMgr.SetAutoDice = function(isAutoDice)
    this.isAutoDice = isAutoDice;
    if (this.isRollDice) then
        this.AutoDice();
    end
end


VoyageRichManMgr.IsAutoDice = function()
    return this.isAutoDice;
end


VoyageRichManMgr.HasRecord = function(dungeonId)
    local record = DataMgr.Player.dungeonRecords[dungeonId];
    return record ~= nil and record.completeCount > 0;
end


VoyageRichManMgr.GetStatus = function()
    return this.status;
end


VoyageRichManMgr.SetDrop = function(isDrop)
    this.isDrop = isDrop;
end


this.SetCameraPos = function()
    local rate = UnityEngine.Screen.width / UnityEngine.Screen.height;
    local design = 21 / 9;
    if (rate < design) then
        local addSize = (design - rate) * 1;
        this.camera.orthographicSize = this.cameraSize + addSize;
    else
        this.camera.orthographicSize = this.cameraSize;
    end
end


this.SetAntiAliasing = function()
    local sailingAntiAliasing = ConfigMgr.Config.constants.SailingAntiAliasing;
    local quality = SettingHelper.GetCurImageQuality();
    if (quality.key == ESetting.Image_QualityHigh.key) then
        LuaMgr.AntiAliasing(sailingAntiAliasing[3]);
    elseif (quality.key == ESetting.Image_QualityMiddle.key) then
        LuaMgr.AntiAliasing(sailingAntiAliasing[2]);
    else
        LuaMgr.AntiAliasing(sailingAntiAliasing[1]);
    end
end


VoyageRichManMgr.IsRollDice = function()
    return this.isRollDice and not this.isGotoArrow;
end


VoyageRichManMgr.RollDiceResponse = function(result)
    this.result = result;
    this.isRollDice = false;
    local rollDiceId = PlayerVoyageMgr.GetRollDiceId();
    if (result.DiceID == rollDiceId) then
        PlayerVoyageMgr.SetRollDiceCount(false);
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowDice);
    else
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowSpecialDice);
    end
    this.ShowRollDice();
end


this.GetPathGridAndPos = function(path)
    local grids = {};
    local len = #path;
    for i = 1, len do
        grids[i] = this.gridList[path[i]];
    end
    local pos = path[len];
    return grids, pos;
end


this.ShowRollDice = function()
    local diceConfig = ConfigVoyageMgr.GetSailingDice(this.result.DiceID);
    if (diceConfig ~= nil) then
        if (diceConfig.RollMode == 2) then
            VoyageRichManMgr.RollDice();
            return;
        end
        if (diceConfig.RollNumber == 4) then
            LuaMgr.ShowLuaPanel(UIName.VoyageRichManDiceViewModel, VoyageRichManDiceType.Triangle, this.result.Points);
        else
            LuaMgr.ShowLuaPanel(UIName.VoyageRichManDiceViewModel, VoyageRichManDiceType.Square, this.result.Points);
        end
    else
        VoyageRichManMgr.RollDice();
    end
    local captainConfig = ConfigVoyageMgr.GetCaptainConfig(DataMgr.Player.Sailing.Captain);
    if (captainConfig ~= nil) then
        local specialDiceId = PlayerVoyageMgr.GetSpecialDiceId();
        local specialDiceCount = PlayerVoyageMgr.GetDiceCount(specialDiceId);
        if (specialDiceCount >= captainConfig.SkillLimit) then
            LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowSpecialDice, VoyageEventConst.PlusDice);
        else
            LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowSpecialDice);
        end
    end
end


VoyageRichManMgr.ChoosePathResponse = function(result)
    this.result = result;
    this.isRollDice = false;
    VoyageRichManMgr.RollDice();
end


VoyageRichManMgr.RollDice = function()
    if (this.IsPositionBack()) then
        this.isWait = true;
        return;
    end
    local path = PlayerVoyageMgr.GetPath(this.myShip.data.index);
    local len = #path;
    if (len > 0) then
        local num = this.result.Points;
        if (len > num) then
            num = num + 1;
            for i = len, num, -1 do
                table.remove(path);
            end
        end
        local grids, pos = this.GetPathGridAndPos(path);
        this.myShip.data.index = pos;
        this.myShip:Move(grids, this.MyShipMoveComplete);
    else
        this.isWait = false;
    end
end


this.IsPositionBack = function()
    if (this.HasEvent()) then
        local event = this.result.Events[1];
        if (event.Event == VoyageEventConst.PositionBack) then
            local backPath = NumTool.split(event.Details.backPath, ',');
            local path = {};
            local len = #backPath;
            local posBefore = tostring(this.result.PosBefore);
            local index = 1;
            for i = 1, len do
                if (posBefore == backPath[i]) then
                    index = i;
                    break;
                end
            end
            for i = index, len do
                table.insert(path, tonumber(backPath[i]));
            end
            local grids, pos = this.GetPathGridAndPos(path);
            this.myShip.data.index = pos;
            this.myShip:Move(grids, this.ShowPositionBack);
            return true;
        end
    end
    return false;
end


this.ShowPositionBack = function()
    local event = this.result.Events[1];
    table.remove(this.result.Events, 1);
    local grid = this.gridList[this.myShip.data.index];
    LuaMgr.ShowLuaPanel(UIName.VoyageRichManEventViewModel, grid.config, event);
end


this.MyShipMoveComplete = function()
    VoyageRichManMgr.BattleResult();
    if (VoyageRichManMgr.CheckGameEnd()) then return end

    local sailing = DataMgr.Player.Sailing;
    if (sailing.BattleEvent ~= "" and sailing.BattleResult == VoyageRichManBattleResult.NoMember) then
        if (PlayerVoyageMgr.IsDiceCount()) then
            if (this.HasEvent()) then
                this.CheckGridEvent();
            else
                this.result = nil;
                this.isWait = false;    
            end
        else
            this.result = nil;
            VoyageRichManMgr.CheckGameEnd();
        end
        return;
    end
    this.CheckGridEvent();
end


VoyageRichManMgr.CorsairRollDice = function(result)
    local num = result.Points;
    if (this.corsair == nil) then
        this.AddCorsair(result.PosBefore);
    end
    local path = PlayerVoyageMgr.GetPath(this.corsair.data.index);
    local len = #path;
    if (len > num) then
        for i = num + 1, len do
            table.remove(path);
        end
    end
    local grids, pos = this.GetPathGridAndPos(path);
    if (#grids > 0) then
        this.corsair.data.index = pos;
        this.corsair:MoveNum(grids, this.CorsairMoveComplete, num);
    else
        this.CorsairMoveComplete();
    end
end


this.CorsairMoveComplete = function()
    local sailing = DataMgr.Player.Sailing;
    if (sailing.Status == VoyageRichManStatus.Fail) then
        this.status = VoyageRichManStatus.Fail;
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowDice);
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManStatusViewModel, this.status);
        this.isWait = true;
        return;
    end
    if (not IsNullOrEmpty(sailing.PendingBattle)) then
        this.CheckEnterDungeon(sailing.PendingBattle, sailing.Members);
        return;
    end
    if (sailing.BattleResult == VoyageRichManBattleResult.NoMember) then
        VoyageRichManMgr.BattleResult();
    end
    this.isWait = false;
    this.nextTime = VoyageRichManTimeMgr.GetTime() + 0.5;
end


this.SetContainer = function()
    local portConfig = ConfigVoyageMgr.GetPortConfig(DataMgr.Player.Sailing.HarborID);
    if (portConfig == nil) then return end
    
    this.container.localPosition = Vector3(portConfig.ContainerPosition[1], portConfig.ContainerPosition[2], portConfig.ContainerPosition[3]);
    this.container.localRotation = Quaternion.Euler(portConfig.ContainerRotate[1], portConfig.ContainerRotate[2], portConfig.ContainerRotate[3]);
end


this.InitData = function()
    PlayerVoyageMgr.SetRollDiceCount(true);
    local sailing = DataMgr.Player.Sailing;
    if (this.myShip == nil) then
        this.myShip = VoyageRichManShip.New("HH_terrain04_02", this.container);
    end
    local grid = this.gridList[sailing.MyPos];
    local grid2;
    if (grid.config.EventParam[1] == VoyageEventConst.ReturnTo) then
        local pos = tonumber(grid.config.EventParam[2]);
        grid2 = this.gridList[pos];
    else
        grid2 = this.gridList[sailing.MyPos + 1];
    end
    if (grid == nil or grid2 == nil) then return end
    
    this.myShip:SetData({index=sailing.MyPos}, grid.pos, grid2.pos);
    if (IsNull(sailing.Corsair)) then
        this.RemoveCorsair();
    else
        this.AddCorsair(sailing.Corsair.CorsairPos);
    end
    if (sailing.ForkStatus == "choose") then
        this.GotoArrow(grid.config);
        return;
    end
end


this.HasEvent = function()
    if (this.result ~= nil and not IsNull(this.result.Events) and #this.result.Events > 0) then
        return true;
    end
    return false;
end


VoyageRichManMgr.CheckGameEnd = function()
    if (this.HasEvent()) then return false end
    
    local sailing = DataMgr.Player.Sailing;
    if (sailing.Status == VoyageRichManStatus.Success) then
        this.status = VoyageRichManStatus.WinEffect;
        this.PlayWinEffect();
        return true;
    elseif (sailing.Status == VoyageRichManStatus.Fail) then
        this.status = VoyageRichManStatus.Fail;
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManStatusViewModel, this.status);
        this.isWait = true;
        return true;
    end
    return false;
end


VoyageRichManMgr.SetWait = function(isWait)
    this.isWait = isWait;
end


VoyageRichManMgr.IsWait = function()
    return this.isWait;
end


VoyageRichManMgr.CheckCorsair = function()
    if (IsNull(DataMgr.Player.Sailing.Corsair)) then
        this.RemoveCorsair();
    end
end


this.PlayWinEffect = function()
    if (this.winEffect == nil) then
        this.winEffect = LuaMgr.GetPrefab("Assets/_BundleResources/Voyage/UI_Voyage_win.prefab");
        this.winEffect.transform:SetParent(this.container, false);
    end
    local grid = this.gridList[this.myShip.data.index];
    if (grid ~= nil) then
        this.winEffect.transform.localPosition = grid.pos;
    end
    this.nextTime = VoyageRichManTimeMgr.GetTime() + 2;
    this.isWait = false;
end


this.RemoveWinEffect = function()
    if (this.winEffect ~= nil) then
        LuaMgr.DestroyImmediateGO(this.winEffect);
        this.winEffect = nil;
    end
end


this.CheckGridEvent = function()
    if (this.result == nil) then return end

    local grid = this.gridList[this.myShip.data.index];
    if (grid == nil or grid.config == nil) then
        this.isWait = false;
        return;
    end
    local type = grid.config.EventParam[1];
    if (type == VoyageEventConst.GoTo) then
        this.GotoArrow(grid.config);
        return;
    end
    local events = this.result.Events;
    if (#events <= 0) then
        this.isWait = false;
        return;
    end
    local event = this.result.Events[1];
    table.remove(this.result.Events, 1);
    if (type == VoyageEventConst.Empty) then
        this.isWait = false;
        return;
    end
    if (type == VoyageEventConst.End) then
        VoyageRichManMgr.CheckGameEnd();
        return;
    end
    if (type == VoyageEventConst.Corsair) then
        VoyageRichManMgr.ExecuteEvent(grid.config, event);
        return;
    end
    if (grid.config.EventGroup == "") then
        grid:Trigger(event);
    else
        VoyageRichManRandomEvent.Show(grid, event);
    end
end


VoyageRichManMgr.ExecuteEvent = function(config, data)
    this.isWait = false;
    local type = config.EventParam[1];
    if (type == VoyageEventConst.PositionGo) then
        this.PositionGo(data);
    elseif (type == VoyageEventConst.PositionBack) then
        this.PositionBack(data);
    elseif (type == VoyageEventConst.HealthDown) then
        this.HealthDown(data);
    elseif (type == VoyageEventConst.HealthUp) then
        this.HealthUp(data);
    elseif (type == VoyageEventConst.Dungeon) then
        local sailing = DataMgr.Player.Sailing;
        if (sailing.BattleResult == VoyageRichManBattleResult.NoMember) then
            VoyageRichManMgr.BattleResult();
        else
            this.CheckEnterDungeon(sailing.PendingBattle, sailing.Members);
        end
    elseif (type == VoyageEventConst.Item) then
        this.GetItem(data);
    elseif (type == VoyageEventConst.DiceAdd) then
        this.DiceAdd(data);
    elseif (type == VoyageEventConst.DiceMinus) then
        this.DiceMinus(data);
    elseif (type == VoyageEventConst.Corsair) then
        local sailing = DataMgr.Player.Sailing;
        if (not IsNull(sailing.Corsair)) then
            this.AddCorsair(sailing.Corsair.CorsairPos);
            this.nextTime = VoyageRichManTimeMgr.GetTime() + 1;
        end
    elseif (type == VoyageEventConst.GoodsAdd) then
        this.GoodsAdd(data);
    elseif (type == VoyageEventConst.GoodsMinus) then
        this.GoodsMinus(data);
    elseif (type == VoyageEventConst.ItemAdd) then
        this.ItemAdd(data);
    elseif (type == VoyageEventConst.ItemMinus) then
        this.ItemMinus(data);
    end
    VoyageRichManMgr.CheckGameEnd();
end


this.PositionGo = function(event)
    this.isWait = true;
    local num = tonumber(event.Details.dis);
    this.result.Points = num;
    VoyageRichManMgr.RollDice();
end


this.PositionBack = function(event)
    this.isWait = true;
    local backPath = NumTool.split(event.Details.backPath, ',');
    local path = {};
    local len = #backPath;
    for i = len - 1, 1, -1 do
        table.insert(path, tonumber(backPath[i]));
    end
    local grids, pos = this.GetPathGridAndPos(path);
    this.myShip.data.index = pos;
    this.myShip:Move(grids, this.MyShipMoveComplete);
end


this.HealthDown = function(event)
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManRefreshCharacters);
end


this.HealthUp = function(event)
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManRefreshCharacters);
end


this.GetItem = function(event)
    if (not IsNull(this.result.Rewards)) then
        local reward = json.encode(this.result.Rewards);
        LuaMgr.ShowItemRewared(reward);
        this.itemRewardTime = os.time() + 3;
    end
end


this.DiceAdd = function(event)
    this.nextTime = VoyageRichManTimeMgr.GetTime() + 1.6;
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowDice, event.Event);
end


this.DiceMinus = function(event)
    this.nextTime = VoyageRichManTimeMgr.GetTime() + 1.6;
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManShowDice, event.Event);
end


this.CheckEnterDungeon = function(dungeonId, members)
    local portConfig = ConfigVoyageMgr.GetPortConfig(DataMgr.Player.Sailing.HarborID);
    if (portConfig == nil) then return end

    this.isWait = true;
    this.battleMembers = {};
    if (VoyageRichManMgr.IsAutoDice() and VoyageRichManMgr.HasRecord(dungeonId)) then
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManMopUpViewModel, portConfig, dungeonId, members, this.EnterDungeon);
    else
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManBattleViewModel, portConfig, dungeonId, members, this.EnterDungeon);
    end
end


this.EnterDungeon = function(dungeonId, members)
    this.isWait = true;
    local memberDic = {};
    local index = 0;
    for k, v in pairs(members) do
        if (v.HP > 0) then
            memberDic[tostring(index)] = k;
            index = index + 1;
        end
    end
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
    enterDungeonParams.eventId = dungeonId;
    enterDungeonParams.dungeonId = dungeonId;
    enterDungeonParams.members = memberDic;
    enterDungeonParams.extraParams = {"sailing"};
    BattlePrepareMgr._enterDungeonParams = enterDungeonParams;
    LuaMgr.SceneSwitchMark();
    this.isDungeon = true;
    LuaMgr.SetCurTeamId(BattlePrepareMgr.formationId)
    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon", enterDungeonParams, true, function(result)
        local re = json.decode(result);
        local data = json.encode(re.result);
        VoyageRichManSceneMgr.Record();
        LuaMgr.EnterBattle(data, -1);
    end, function(code) end, true);
end


this.AddCorsair = function(pos)
    if (this.corsair == nil) then
        this.corsair = VoyageRichManShip.New("HH_terrain04_01", this.container);
        this.corsair:InitNum();
    end
    local grid = this.gridList[pos];
    local grid2 = nil;
    if (grid.config.EventParam[1] == VoyageEventConst.ReturnTo) then
        local pos2 = tonumber(grid.config.EventParam[2]);
        grid2 = this.gridList[pos2];
    else
        grid2 = this.gridList[pos + 1];
    end
    if (grid ~= nil and grid2 ~= nil) then
        this.corsair:SetData({index=pos}, grid.pos, grid2.pos);
        SetActive(this.cameraEff, true);
    end
end


this.GoodsAdd = function(event)
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManWarehouseChange, event.Event);
end


this.GoodsMinus = function(event)
    LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageRichManWarehouseChange, event.Event);
end


this.ItemAdd = function(event)
    
end


this.ItemMinus = function(event)
    
end


this.GotoArrow = function(event)
    local gridId;
    local arrows = {};
    local grid = this.gridList[this.myShip.data.index];
    local len = #event.EventParam;
    for i = 2, len do
        gridId = tonumber(event.EventParam[i]);
        table.insert(arrows, {id=gridId, startGrid=grid, endGrid=this.gridList[gridId]});
    end
    if (VoyageRichManMgr.IsAutoDice()) then
        local index = math.random(1, #arrows);
        local arrow = arrows[index];
        PlayerVoyageMgr.ChoosePath(arrow.id);
    else
        this.ShowGotoArrow(arrows);
    end
end


this.ShowGotoArrow = function(arrows)
    if (this.gotoArrowList == nil) then
        this.gotoArrowList = {};
    end
    local arrow;
    local len = #arrows;
    for i = 1, len do
        arrow = this.gotoArrowList[i];
        if (arrow == nil) then
            arrow = VoyageRichManArrow.New(this.container, i);
            this.gotoArrowList[i] = arrow;
        end
        arrow:SetData(arrows[i]);
    end
    this.isGotoArrow = true;
end


this.HideGotoArrow = function()
    if (this.gotoArrowList ~= nil) then
        local len = #this.gotoArrowList;
        for i = 1, len do
            this.gotoArrowList[i]:Clear();
        end
    end
    this.isGotoArrow = false;
end


this.RemoveGotoArrow = function()
    if (this.gotoArrowList ~= nil) then
        local len = #this.gotoArrowList;
        for i = 1, len do
            this.gotoArrowList[i]:Destroy();
        end
        this.gotoArrowList = nil;
    end
end


this.CheckArrow = function()
    if (this.isGotoArrow and RaycastTool.GetMouseButtonUp(0)) then
        local obj = RaycastTool.GetClickInfo(this.camera, 100, "CellHandler");
        if (obj ~= nil) then
            this.HideGotoArrow();
            local list = NumTool.split(obj.name, "_");
            PlayerVoyageMgr.ChoosePath(tonumber(list[2]));
        end
    end
end


this.ReturnTo = function(event)
end


this.CheckShips = function()
    if (this.myShip ~= nil) then
        this.myShip:Update();
    end
    if (this.corsair ~= nil) then
        this.corsair:Update();
    end
end


this.RemoveMyShip = function()
    if (this.myShip ~= nil) then
        this.myShip:Destroy();
        this.myShip = nil;
    end
end


this.RemoveCorsair = function()
    if (this.corsair ~= nil) then
        this.corsair:Destroy();
        this.corsair = nil;
    end
    if (this.cameraEff ~= nil and not LuaMgr.IsObjectNull(this.cameraEff)) then
        SetActive(this.cameraEff, false);
    end
end


this.InitGrids = function()
    this.gridList = {};
    local eventConfig;
    local eventPoolConfig;
    local grid;
    local eventPool = DataMgr.Player.Sailing.EventPool;
    local gridDatas = DataMgr.Player.Sailing.GridList;
    local len = #gridDatas;
    for i = 1, len do
        eventPoolConfig = ConfigVoyageMgr.GetEventPoolConfig(eventPool, gridDatas[i], i);
        if (eventPoolConfig ~= nil) then
            eventConfig = ConfigVoyageMgr.GetSailingEvent(eventPoolConfig.EventID);
            if (eventConfig ~= nil) then
                grid = VoyageRichManGrid.New(eventConfig.ModelID, this.gridsContainer);
                grid:SetData(eventConfig, eventPoolConfig);
                this.gridList[i] = grid;
            end
        end
    end
end


this.RemoveGrids = function()
    if (this.gridList ~= nil) then
        local len = #this.gridList;
        for i = 1, len do
            this.gridList[i]:Destroy();
        end
        this.gridList = nil;
    end
end


this.OnRewards = function()
    if (this.PlayNovel()) then return end
    
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
    PlayerVoyageMgr.GetSailingGoodsPrice();
end


this.PlayNovel = function()
    local portConfig = ConfigVoyageMgr.GetPortConfig(DataMgr.Player.Sailing.HarborID);
    if (portConfig == nil or IsNullOrEmpty(portConfig.NovelID)) then
        return false;
    end
    LuaMgr.PlayNovel(portConfig.NovelID, this.OnPlayNovel);
    return true;
end


this.OnPlayNovel = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
    PlayerVoyageMgr.GetSailingGoodsPrice();
end


this.AutoDice = function()
    if (LuaMgr.IsPanelOpen(UIName.VoyageConfirmViewModel)) then return end
    
    local specialDiceId = PlayerVoyageMgr.GetSpecialDiceId();
    local specialDiceCount = PlayerVoyageMgr.GetDiceCount(specialDiceId);
    if (specialDiceCount > 0) then
        if (specialDiceId == VoyageRichManDiceId.SelectDice) then
            LuaMgr.ShowLuaPanel(UIName.VoyageRichManDiceViewModel, VoyageRichManDiceType.SelectDice);
        elseif (specialDiceId == VoyageRichManDiceId.FourDice) then
            PlayerVoyageMgr.RollDice(specialDiceId, 0);
        end
        return;
    end
    local rollDiceId = PlayerVoyageMgr.GetRollDiceId();
    local rollDiceCount = PlayerVoyageMgr.GetDiceCount(rollDiceId);
    if (rollDiceCount <= 0) then return end
    
    PlayerVoyageMgr.SetRollDiceCount(true);
    PlayerVoyageMgr.RollDice(rollDiceId, 0);
end


this.CheckRollDice = function()
    if (this.isWait) then return end
    if (this.isDrop) then return end
    if (VoyageRichManTimeMgr.GetTime() < this.nextTime) then return end

    if (this.status == VoyageRichManStatus.Runing) then
        this.isWait = true;
        this.result = nil;
        if (PlayerVoyageMgr.IsMyRollDice()) then
            this.isRollDice = true;
            if (this.isAutoDice) then
                this.AutoDice();
            end
        else
            this.isRollDice = false;
            PlayerVoyageMgr.CorsairRollDice();
        end
    elseif (this.status == VoyageRichManStatus.OpenHarbor) then
        this.status = VoyageRichManStatus.Runing;
    elseif (this.status == VoyageRichManStatus.WinEffect) then
        this.status = VoyageRichManStatus.Success;
        this.isWait = true;
        this.RemoveWinEffect();
        LuaMgr.ShowLuaPanel(UIName.VoyageRichManStatusViewModel, this.status, DataMgr.Player.Sailing.HarborID);
    elseif (this.status == VoyageRichManStatus.Success) then
        this.isWait = true;
        if (IsNull(this.result.Rewards)) then
            LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
            PlayerVoyageMgr.GetSailingGoodsPrice();
        else
            local rewards = json.encode(this.result.Rewards);
            LuaMgr.ShowItemRewared(rewards, this.OnRewards);
        end
    elseif (this.status == VoyageRichManStatus.Fail) then
        this.isWait = true;
        LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false);
    end
end


this.CheckItemReward = function()
    if (this.itemRewardTime > 0) then
        if (os.time() > this.itemRewardTime) then
            this.itemRewardTime = 0;
            LuaMgr.HidePanel(UIName.ItemGetViewModel);
        end
    end
end


this.OnUpdate = function()
    VoyageRichManTimeMgr.Update();
    VoyageRichManSceneMgr.Update();
    this.CheckRollDice();
    this.CheckArrow();
    this.CheckShips();
    this.CheckItemReward();
end
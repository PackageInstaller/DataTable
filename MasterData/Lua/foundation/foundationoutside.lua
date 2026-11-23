FoundationOutside = {};

local this = {
    gameObject = nil,
    transform = nil,
    camera = nil,
    uiContainer = nil,
    roomMap = {},
    roomInfoList = nil,
    nextTime = 0,
    isFirst = false,
    container = nil,
    boxAnimator = nil,
    nameAnimator = nil,
};

FoundationOutside.Init = function()
    this.gameObject = GameObject.Find(FoundationMgr.Outside);
    this.transform = this.gameObject.transform;
    this.camera = this.transform:Find("Camera"):GetComponent("Camera");
    this.container = this.transform:Find("Container");
    this.boxAnimator = this.transform:Find("Animator/Box"):GetComponent("ModelAnimator");
    this.nameAnimator = this.transform:Find("Animator/Name"):GetComponent("ModelAnimator");
    this.isFirst = true;
end

FoundationOutside.Show = function()
    FoundationMgr.SetCamera(this.camera);
    this.transform.localPosition = Vector3.zero;
    SetActive(this.gameObject, true);
    LuaMgr.ShowLuaPanel(UIName.FoundationViewModel);
    if (this.isFirst) then
        this.isFirst = false;
        FoundationMgr.SetOutsideClick(false);
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/foundation_boxopen.mp3");
        this.boxAnimator:Play("mod_guizi_001", false, this.OnBoxComplete, 0.5);
        this.nameAnimator:Play("ani_foundationoutside_01", false, this.OnNameComplete);
    else
        this.boxAnimator:Stop();
        this.nameAnimator:Stop();
        LuaMgr.AddUpdate(this.OnUpdate);
    end
    LuaMgr.AddUIEventListener(UIEventConst.GuideClickFoundation, this.OnGuideClickFoundation);
end

FoundationOutside.Hide = function()
    if (this.gameObject ~= nil) then
        this.gameObject:SetActive(false);
    end
end

FoundationOutside.Clear = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.GuideClickFoundation, this.OnGuideClickFoundation);
    this.boxAnimator:Stop();
    this.nameAnimator:Stop();
    LuaMgr.RemoveUpdate(this.OnUpdate);
    this.ClearRoomInfo();
end

FoundationOutside.Destroy = function()
    FoundationRoom.Destroy();
    FoundationTeaRoom.Destroy();
    FoundationExpoHall.Destroy();
    FoundationWorking.Destroy();
    FoundationOffice.Destroy();
    FoundationEditor.Destroy();
    this.gameObject = nil;
    this.transform = nil;
    this.camera = nil;
    this.uiContainer = nil;
end


FoundationOutside.SetUIContainer = function(container)
    this.uiContainer = container;
end


this.OnBoxComplete = function()
    LuaMgr.AddUpdate(this.OnUpdate);
    this.nextTime = 0;
end


this.OnNameComplete = function()
    FoundationMgr.SetOutsideClick(true);
end


this.SetRoomInfo = function()
    if (this.uiContainer == nil) then return end
    
    this.roomMap["101"] = "OutsideExpoHall";
    this.roomMap["102"] = "OutsideWorking";
    this.roomMap["103"] = "OutsideOffice";
    this.roomMap["104"] = "OutsideTeaRoom";
    this.roomMap["105"] = "OutsideRoom";
    local roomInfo;
    this.roomInfoList = {};
    for k, v in pairs(this.roomMap) do
        roomInfo = FoundationRoomInfo.New(this.uiContainer, this.camera);
        roomInfo:SetData(k, this.container:Find(string.format("%s/%s", v, v)));
        table.insert(this.roomInfoList, roomInfo);
    end
end


this.ClearRoomInfo = function()
    if (this.roomInfoList ~= nil) then
        local len = #this.roomInfoList;
        for i = 1, len do
            this.roomInfoList[i]:Clear();
        end
        this.roomInfoList = nil;
    end
end


this.CheckRoomInfo = function()
    local time = os.time();
    if (time < this.nextTime) then return end
    
    if (this.roomInfoList == nil) then
        this.SetRoomInfo();
    end
    if (this.roomInfoList == nil) then return end

    this.nextTime = time + 1;
    local len = #this.roomInfoList;
    for i = 1, len do
        this.roomInfoList[i]:SetItem();
    end
end


this.OnGuideClickFoundation = function(args)
    if (args.Length > 0) then
        this.EnterRoom(args[0]);
    end
end


this.EnterRoom = function(obj)
    local objName = obj.name;
if (objName == "OutsideTeaRoom") then
        FoundationMgr.Enter(FoundationMgr.TeaRoom);
elseif (objName == "OutsideRoom") then
        if (FeatureManager.IsLock("1303")) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6901"].NameLan));
            return;
        end
        LuaMgr.ShowLuaPanel(UIName.FoundationTransitionViewModel, function()
            
            FoundationMgr.Enter(FoundationMgr.Room);
        end);
elseif (objName == "OutsideExpoHall") then
        FoundationMgr.Enter(FoundationMgr.ExpoHall);
elseif (objName == "OutsideWorking") then
        FoundationMgr.Enter(FoundationMgr.Working);
elseif (objName == "OutsideOffice") then
        FoundationMgr.Enter(FoundationMgr.Office);
elseif (objName == "OutsideEditor") then

    end
end


this.OnUpdate = function()
    this.CheckRoomInfo();
    if (not FoundationMgr.IsOutsideClick()) then return end
    
    if (RaycastTool.GetMouseButtonUp(0)) then
        if (not LuaMgr.HasNormalStack(UIName.FoundationViewModel)) then return end
        if (LuaMgr.IsPanelOpen(UIName.FoundationFriendlyViewModel)) then return end
        if (RaycastTool.IsPointerOverGameObject()) then
            if (not IsObjectNull(RaycastTool.CurrentSelectedGameObject())) then return end
        end
        local obj = FoundationSceneMgr.Click(this.camera, 100, "SceneDynamic");
        if (obj ~= nil) then
            FoundationMgr.ClickSound();
            LuaMgr.InvokeUIEventListeners(UIEventConst.GuideClick, obj);
            this.EnterRoom(obj);
        end
    end
end
VoyageSceneMgr = {}

local this = {
    ctrl = nil,
    containerTF = nil,
    mapTF = nil,
    lineTF = nil,
    portTF = nil,
    mapBgGO = nil,
    portList = nil,
    novelPort = nil,
};

VoyageSceneMgr.Init = function(sceneTF, todayDelegateItem, currentPosItem, newPortItem)
    this.ctrl = sceneTF:GetComponent("SceneTouchCtrl");
    this.containerTF = sceneTF:Find("Container"):GetComponent("RectTransform");
    this.mapTF = sceneTF:Find("Container/Map");
    this.lineTF = sceneTF:Find("Container/Line");
    this.portTF = sceneTF:Find("Container/Port");
    this.InitPorts(todayDelegateItem, currentPosItem, newPortItem);
end

VoyageSceneMgr.Show = function()
    this.camera = LuaMgr.UICamera();
    local size = Vector2(2520, 1080);
    local offset = Vector2(size.x * 0.5, size.y * 0.5);
    this.containerTF.sizeDelta = size;
    local pos = Vector3(-offset.x + 50, offset.y - 50, 0);
    this.mapTF.localPosition = pos;
    this.lineTF.localPosition = pos;
    this.portTF.localPosition = pos;
    this.ctrl:SetData(this.camera, this.containerTF, this.OnMouseEvent, 0.666, 1, size, offset, 0, 0.666);
    this.SetMap();
    VoyageSceneMgr.SetPorts();
    LuaMgr.MultiTouchEnabled(true);
end

VoyageSceneMgr.Clear = function()
    this.ClearPorts();
    LuaMgr.MultiTouchEnabled(false);
end

VoyageSceneMgr.Destroy = function()
    if (this.ctrl ~= nil) then
        this.ctrl:Clear();
        this.ctrl = nil;
    end
    this.RemovePosts();
    if (this.mapBgGO ~= nil) then
        LuaMgr.DestroyImmediateGO(this.mapBgGO);
        this.mapBgGO = nil;
    end
end


VoyageSceneMgr.PlayNovel = function(portConfig)
    this.novelPort = portConfig;
    LuaMgr.PlayNovel(portConfig.NovelID, this.OnPlayNovel);
end


this.OnPlayNovel = function()
    LuaMgr.ShowLuaPanel(UIName.VoyageViewModel, false, this.novelPort);
end


this.SetMap = function()
    if (this.mapBgGO == nil) then
        this.mapBgGO = LuaMgr.GetPrefab("Assets/_BundleResources/UI/Voyage/VOYAGEMAP.prefab");
        local tf = this.mapBgGO:GetComponent("RectTransform");
        tf:SetParent(this.mapTF, false);
        tf.anchoredPosition = Vector2(0, 0);
    end
end


this.InitPorts = function(todayDelegateItem, currentPosItem, newPortItem)
    local port;
    this.portList = {};
    for i = 1, 6 do
        port = VoyagePort.New(this.portTF:Find("Port" .. i), todayDelegateItem, currentPosItem, newPortItem);
        port:Clear();
        this.portList[i] = port;
    end
end


VoyageSceneMgr.SetTodayDelegate = function()
    local len = #this.portList;
    for i = 1, len do
        this.portList[i]:SetTodayDelegate();
    end
end


VoyageSceneMgr.SetCurrentPos = function()
    local len = #this.portList;
    for i = 1, len do
        this.portList[i]:SetCurrentPos();
    end
end


VoyageSceneMgr.SetNewPort = function()
    local len = #this.portList;
    for i = 1, len do
        this.portList[i]:SetNewPort();
    end
end


VoyageSceneMgr.SetPorts = function()
    local ports = ConfigVoyageMgr.GetPortList();
    local len = #this.portList;
    for i = 1, len do
        this.portList[i]:SetData(ports[i]);
    end
end


this.ClearPorts = function()
    local len = #this.portList;
    for i = 1, len do
        this.portList[i]:Clear();
    end
end


this.RemovePosts = function()
    local len = #this.portList;
    for i = 1, len do
        this.portList[i]:Destroy();
    end
    this.portList = nil;
end


VoyageSceneMgr.GetPortInfoPos = function(index)
    local port = this.portList[index];
    if (port ~= nil) then
        return port.infoPosTF;
    end
    return nil;
end


VoyageSceneMgr.SetOperate = function(isOperate)
    this.ctrl.isOperate = isOperate;
end


VoyageSceneMgr.SetScale = function(isScale)
    this.ctrl.isScale = isScale;
end


this.OnMouseEvent = function(type)
if (type == 1) then
        
elseif (type == 4) then
        
elseif (type == 3) then
        
    end
end
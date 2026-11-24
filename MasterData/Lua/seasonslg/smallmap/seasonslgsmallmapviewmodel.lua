require("SeasonSLG/SmallMap/SLGSmallMapScrollView")
require("SeasonSLG/SmallMap/SLGSmallMapScrollData")
require("SeasonSLG/SmallMap/SmallMapBlockItem")
require("SeasonSLG/SmallMap/SmallMapAreaItem")
require("SeasonSLG/SmallMap/SmallMapAreaGridItem")
require("SeasonSLG/SmallMap/SmallProgressItem")
require("SeasonSLG/SmallMap/SeasonSLGLegendItem")
require("SeasonSLG/SeasonSLGBuffFixCom")

local this = {
    smallScrollView = nil,
    mapWidth = 4200,
    mapHeight = 1784,
    pinchScaleSensitivity = 0.001;
};

local ui = {}
this.InitUI = function(vm)
    local prefab = vm.behaviour
    ui.tarGameObject = prefab
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");


    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.sliderMap = uiLink:Get("sliderMap"):GetComponent("Slider");

    ui.scrollAreaView = uiLink:Get("ScrollAreaView"):GetComponent("ScrollRect");
    ui.scrollGridView = uiLink:Get("ScrollGridView"):GetComponent("ScrollRect");
    ui.goAreaMapWin = uiLink:Get("goAreaMapWin")
    ui.goBuffCom = uiLink:Get("goBuffCom")

    ui.goBuffCom = uiLink:Get("goBuffCom")
    ui.goBuffCom = uiLink:Get("goBuffCom")
    ui.goBuffCom = uiLink:Get("goBuffCom")

    ui.inputGridX = uiLink:Get("inputFieldX"):GetComponent("InputField");
    ui.inputGridY = uiLink:Get("inputFieldY"):GetComponent("InputField");
    ui.btnLoc=uiLink:Get("btnLoc"):GetComponent("Button");

    ui.rawImageMiwu = uiLink:Get("rawImageMiwu"):GetComponent("RawImage");
    ui.rawImageMiwuMat=uiLink:Get("rawImageMiwuMat"):GetComponent("RawImage");

    this.backImageItemObj = vm.behaviour.transform:Find("template/BackImage").gameObject;
    this.blockItemObj = vm.behaviour.transform:Find("template/BlockItem").gameObject;
    this.scrollItemObj = vm.behaviour.transform:Find("template/ScrollItem").gameObject;
    this.areaItemObj = vm.behaviour.transform:Find("template/AreaItem").gameObject;
    this.legendItem = vm.behaviour.transform:Find("template/LegendItem").gameObject;
    this.legendTrans = vm.behaviour.transform:Find("root/Left/LegendGroup").transform;
    this.legendBtn = vm.behaviour.transform:Find("root/Left/ArrowBtn"):GetComponent(UITool.Button);
    this.legendTransBtn = this.legendTrans:GetComponent(UITool.Button)
    this.AddRegister(uiLink)
end
this.ClearUI = function()
    ui = nil
end

this.AddRegister = function(uiLink)

    uiLink:AddClickEvent("btnLoc", function()
        this.smallScrollView:MoveToIndex(this.curGrid)
    end)

    uiLink:AddClickEvent("btnFilter", function()
        LuaMgr.ShowLuaPanel(UIName.SeasonSLGFilterSortViewModel)
    end)

    uiLink:AddClickEvent("btnArea", function()
        SetActive(ui.goAreaMapWin, not ui.goAreaMapWin.activeSelf)
    end)

    uiLink:AddClickEvent("btnBackgroundImage", function()
        local pos = this.smallScrollView:GetMouseContentPosition()
        if pos == nil then
            return
        end
        local index = SeasonSLGSmallMapMgr.SmallMapBlockItem(pos)
        if index ~= nil then
            this.smallScrollView:SelectItem(index)
        end
    end)

    local checkInput = function()
            local data = {}
            data.clickCallbacks = {[ConfirmCommonPanel.BtnType.Confirm]=function()
            end}

            data.btnTextStrs = {}

            data.contentStr = string.format(LuaMgr.GetLangText("SeasonSLGSmallMapViewModel_0"),SeasonSLGMapMgr.mapConfig.col,SeasonSLGMapMgr.mapConfig.row)

            data.btnTextStrs[ConfirmCommonPanel.BtnType.Confirm] = LuaMgr.GetLangText("SeasonSLGSmallMapViewModel_1")
            data.btnTextStrs[ConfirmCommonPanel.BtnType.Cancel] = LuaMgr.GetLangText("SeasonSLGSmallMapViewModel_2")
            LuaMgr.ShowLuaPanel(UIName.ConfirmCommonPanel, ConfirmCommonPanel.MsgBoxType.TextButton, data)
    end

    uiLink:AddClickEvent("btnGo", function()
        local x=ui.inputGridX.text
        local y=ui.inputGridY.text


        if IsNullOrEmpty(x) or IsNullOrEmpty(y) then
            checkInput()
            return
        end
        x = tonumber(x)
        y = tonumber(y)

        if IsNullOrEmpty(x) or IsNullOrEmpty(y) then
            checkInput()
            return
        end

        if (SeasonSLGSmallMapMgr.CheckGridLimit(x,y)) then
            SeasonSLGSmallMapMgr.JumpToGrid(x,y)
        else
            checkInput()
        end
    end)

    LuaMgr.AddClick(this.legendBtn, function ()
        this.OpenLegendUI(this.legendBtn.transform.localScale.x == 1)
    end)

    LuaMgr.AddClick(this.legendTransBtn, function ()
        this.OpenLegendUI(false)
    end)
    this.OpenLegendUI(true)
























end

this.OpenLegendUI = function(isOpen)
    local scaleArrowX = this.legendBtn.transform.localScale.x
    if isOpen then
        scaleArrowX = -1
    else
        scaleArrowX = 1
    end
    this.legendBtn.transform.localScale = Vector3(scaleArrowX, 1, 1)
    SetActive(this.legendTrans.gameObject, isOpen)
end

this.itemDataCallBack = function(index)
    local gridID = tostring(index)
    local cfgData = SeasonSLGSmallMapMgr.GetCurGridCfg(gridID)
    local pos = SeasonSLGSmallMapMgr.GetGridGroupPosition(gridID)
    local row, col = SeasonSLGMapMgr.GetBlockLocByIndex(index)

    local timedEventType=SeasonSLGSmallMapMgr.timedEventMainGridMap[gridID] or 0
    local miniIcon=cfgData.MiniIcon
    if timedEventType==2 then
        miniIcon="sjz_zlfy_xdt_icon07"
    elseif timedEventType==1 then
        miniIcon="sjz_zlfy_xdt_icon09"


    end
    local name, textType = SeasonSLGSmallMapMgr.GetBlockName(gridID)
    local blockItem = {
        isActive = false,
        index = index,
        gridID = gridID,
        rowIndex = row,
        colIndex = col,
        callBack = this.SmallMapBlockItemCallBack,
        cfgData = cfgData,
        miniIcon = miniIcon,
        name = name,
        nameTextType = textType
    }
    local blockData = SLGSmallMapScrollData.GetData(this.blockItemObj, "SmallMapBlockItem", 40, 40, pos, blockItem);
    return blockData;
end

this.SmallMapBlockItemCallBack = function(data1)
    SeasonSLGSmallMapMgr.SmallMapBlockItemCallBack(data1)














end
























































































this.RegisterTouchInput=function()
    local manager = CS.Laigu.Tools.TouchInputManager.Instance
    if manager ~= nil then
        manager.OnPinchInput = this.OnPinchInput
    end
end

this.UnregisterTouchInput=function()
    local manager = CS.Laigu.Tools.TouchInputManager.Instance
    if manager ~= nil then
        manager.OnPinchInput = nil
    end
end

this.SetMiwuImage = function()
    if ui.rawImageMiwu == nil or ui.rawImageMiwuMat == nil then
        return
    end
    local configs = ConfigMgr.Config.SeasonalGridAreaMap
    local index = 1
    local curTime = LuaMgr.Timestamp()
    for i = 1, 100 do
        local id = tostring(i)
        local config = configs[id]
        if config == nil then
            break
        end
        if config.AreaOpen <= curTime then
            index = i
        else
            break
        end
    end
    if index >= NumTool.GetLen(configs) then
        SetActive(ui.rawImageMiwu.gameObject, false)
        return
    end
    SetActive(ui.rawImageMiwu.gameObject, true)
    local material = ui.rawImageMiwuMat.material
    if material ~= nil then
        local path2 = string.format("Assets/_BundleResources/Images/SeasonSLG/SmallMap/sjz_xdt_lgs_zz%d_1.png", index)
        local texture = this.GetMiwuTexture(path2)
        if texture ~= nil then
            material:SetTexture("_MaskTex", texture)
        end
    end
end

this.GetMiwuTexture = function(path)
    if this.miwuTextureCache == nil then
        this.miwuTextureCache = {}
    end
    if this.miwuTextureCache[path] == nil then
        this.miwuTextureCache[path] = LuaMgr.GetTexture(path)
    end
    return this.miwuTextureCache[path]
end

this.OnPinchInput=function(deltaDistance)
    if deltaDistance == nil then
        return
    end
    local currentScale = this.scaleValue or ui.sliderMap.value
    local speed=SeasonSLGMapMgr.Constants().SeasonalMapminiSpeed==nil and 25 or SeasonSLGMapMgr.Constants().SeasonalMapminiSpeed;
    local scaleDelta = deltaDistance * this.pinchScaleSensitivity*speed;
    if math.abs(scaleDelta) < 0.0001 then
        return
    end
    local manager = CS.Laigu.Tools.TouchInputManager.Instance
    local scaleAnchor = nil
    if manager ~= nil and manager.HadTwoFingerTouch then

        scaleAnchor = manager.LastTwoData.pos0
    else

        local mousePosition = CS.UnityEngine.Input.mousePosition
        scaleAnchor = Vector2(mousePosition.x, mousePosition.y)
    end
    this.SliderChangeMapScale(currentScale + scaleDelta, scaleAnchor)
end

this.SliderChangeMapScale=function(value, screenPosition)
    if this.smallScrollView == nil or ui == nil then
        return
    end
    local minScale = ui.sliderMap.minValue
    local maxScale = ui.sliderMap.maxValue
    value = math.max(minScale, math.min(maxScale, value))
    value = math.floor(value * 100) / 100
    if this.scaleValue ~= nil and value == this.scaleValue then
        return
    end
    this.smallScrollView:LocationCurIndexPositon(nil, value, screenPosition);



    this.smallScrollView:Refresh(value)
    this.scaleValue=value;
end

this.OnClickBack = function()
    if this.oldPos then



        LuaMgr.Back()
    end
end

this.SetLegendUI = function()
    this.legendTransList:Clear();
    local list={};
    for i,data in ipairs(SeasonSLGConst.Legend) do
        if data.IsHide == false then
            local listData=UIListData.GetData(this.legendItem,"SeasonSLGLegendItem", data);
            table.insert(list,listData);
        end
    end
    this.legendTransList:SetData(list);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm;

        this.InitUI(vm)
        this.scrollAreaView = UIScrollView.New(ui.scrollAreaView.transform.gameObject);
        this.scrollGridView = UIScrollView.New(ui.scrollGridView.transform.gameObject);
        this.smallScrollView = SLGSmallMapScrollView.New(ui.ScrollView.transform.gameObject);
        SeasonSLGSmallMapMgr.SetMapSize(this.mapWidth, this.mapHeight);
        this.smallScrollView:SetParams(LuaMgr.ScreenWidth(), 720, this.mapWidth, this.mapHeight);

        ui.sliderMap.onValueChanged:AddListener(this.SliderChangeMapScale)
        this.legendTransList = UIListView.New(this.legendTrans)
        this.SetLegendUI()
        this.scrollWidth = 364
        this.scrollHeight = 376
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.SetMiwuImage()
        this.RegisterTouchInput()
        vm.behaviour:UpdateTopBar("", this.OnClickBack)
        LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGFilterSort, this.OnFilterSort);
        if this.vm.behaviour.Params.Length>0 then
            this.oldPos = vm.behaviour.Params[0]
        end
        this.ParseData();
        SeasonSLGSmallMapMgr.showGridList=nil;
        SeasonSLGSmallMapMgr.timedEventMainGridMap=nil;

        this.smallScrollView:SetBackImages(this.backImageItemObj, SeasonSLGSmallMapMgr.GetCurMapImages());
        this.smallScrollView:SetData(this.itemDataCallBack, true);




        SetActive(ui.goAreaMapWin, false)


        this.SliderChangeMapScale(1);
        this.curGrid = SeasonSLGMapMgr.GetCurrentGrid()
        this.smallScrollView:MoveToIndex(this.curGrid)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.smallScrollView:Clear();
        this.scrollAreaView:Clear();
        this.scrollGridView:Clear();
        this.UnregisterTouchInput();
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGFilterSort, this.OnFilterSort);
    end,
    before_destroy = function()
        SLGSmallMapScrollView.ClearItem("SmallMapBlockItem")
        UIScrollView.ClearItem("SmallMapAreaItem")
        UIScrollView.ClearItem("SmallMapAreaGridItem")
        UIListView.ClearItem("SeasonSLGLegendItem")
        if this.miwuMaterial ~= nil then
            UnityEngine.Object.Destroy(this.miwuMaterial)
            this.miwuMaterial = nil
        end
        this.miwuTextureCache = nil
        this.ClearUI();
    end
}

this.OnFilterSort = function()
    this.SetGridItems()
end

this.ParseData = function()
    local curGridId = SeasonSLGMapMgr.GetCurrentGrid();
    if IsNullOrEmpty(curGridId) then
        curGridId = 1;
    end

end

return vm({
    data = data,
    command = command,
    hook = hook
})
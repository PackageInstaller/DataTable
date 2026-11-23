require("ViewModel/TRJ/TRJPuzzleItem")
local this = {
   animator=nil;
};
local clickInterval=1.5;
local lastClickTime=0;

local config={
    cellX=200,
    cellY=140,
    row=4;
    col=5;
    distance=70;
    spacing=5;
    leftOff=-8;
    topOff=-6;
}


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.goMask = uiLink:Get("goMask");
    ui.Right = uiLink:Get("Right");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");
    ui.tranList = uiLink:Get("tranList"):GetComponent("RectTransform");
    ui.tranFix = uiLink:Get("tranFix"):GetComponent("RectTransform");
    ui.btnReSet = uiLink:Get("btnReSet"):GetComponent("Button");
    ui.btnSee = uiLink:Get("btnSee"):GetComponent("Button");
    ui.btnSkip = uiLink:Get("btnSkip"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnReSet",this.BtnReSetExecute)
    uiLink:AddClickEvent("btnSee",this.BtnSeeExecute)
    uiLink:AddClickEvent("btnSkip",this.BtnSkipExecute)
end

this.CheckClickInterval=function()
    if UnityEngine.Time.realtimeSinceStartup-lastClickTime>clickInterval then
        lastClickTime=UnityEngine.Time.realtimeSinceStartup;
        return true;
    end
    return false;
end

this.BtnReSetExecute=function()
    if not this.CheckClickInterval() then
        return
    end
    this.StartGame();
end

this.BtnSeeExecute=function()
    if not this.CheckClickInterval() then
        return 
    end;
   ui.rawIcon.transform:SetAsLastSibling();
    NumTool.DelayHandler(function()
        ui.rawIcon.transform:SetAsFirstSibling();
    end,1.5)
end

this.BtnSkipExecute=function()
    for i,v in ipairs(this.dataList) do
        if v.fixIndex~=nil then
            v.vm:SetOutFade();
        end
    end
    SetActive(ui.tranFix.gameObject,false);
    this.GameSuccess()
end

local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
        this.iconItemObj=vm.behaviour.transform:Find("template/iconItem").gameObject;
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
        this.InitData();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            this.puzzleId=vm.behaviour.Params[0];
            this.puzzleCfg=ConfigMgr.Config.RestoredImgMap[this.puzzleId];
            lastClickTime=0;
            SetActive(ui.btnSkip.gameObject,false);
            LuaMgr.RemoveTimer(TimerConst.TRJPuzzleSkipTime)
            LuaMgr.AddTimer(TimerConst.TRJPuzzleSkipTime, function()
                SetActive(ui.btnSkip.gameObject,true);
                this.animator:Play("ani_TRJPuzzlePanel_root_002",0,0)
            end, this.puzzleCfg.SkipTime, 1, false);
            this.animator:Play("ani_TRJPuzzlePanel_root_001",0,0)
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.TRJPuzzleSkipTime)
    end,
    before_destroy = function()
        this.ClearUI()
        for i,v in ipairs(this.dataList) do
            v.vm:Destroy();
        end
    end
}

this.InitData=function()
    this.dataList={};
    for i=1,config.row*config.col,1 do
        local dataItem={}
        dataItem.vm=TRJPuzzleItem.New(this.iconItemObj,ui.tranList);
        table.insert(this.dataList,dataItem);
    end
end


this.ParseData=function()
    this.SetBaseInfo();
    this.StartGame();
end

this.SetBaseInfo=function()
    local imgPath=string.format("%sTRJ/%s.png",Path.Image,this.puzzleCfg.ImgRes);
    ui.rawIcon.texture=LuaMgr.GetTexture(imgPath);
end

this.StartGame=function()
    SetActive(ui.goMask,true);
    SetActive(ui.btnReSet.gameObject,true);
    SetActive(ui.btnSee.gameObject,true);
    math.randomseed(LuaMgr.Timestamp());
    this.iconIndexList={};
    this.successList={};
    this.randomCount=1;
    for i=1,config.row*config.col,1 do
        table.insert(this.iconIndexList,i);
    end
    local randomIndexList=this.GetImgIndexList();
    for i,v in ipairs(this.dataList) do
        v.fixIndex=i;
        v.fixPos=this.GetPosByIndex(i-1);
        local data={
            index=i,
            iconName=this.puzzleCfg.ImgRes,
            iconIndex=randomIndexList[i],
            pos=v.fixPos;
            onDragBeginCallBack=this.OnDragBeginCallBack,
            onDragCallBack=this.OnDragCallBack,
            onDragEndCallBack=this.OnDragEndCallBack,
            tf=ui.tranList
        }
        v.vm:SetData(data)
    end
end


this.GetImgIndexList=function()
    local indexList={}
    for i,v in ipairs(this.dataList) do
        local index=this.GetImgIndex(i);
        table.insert(indexList,index);
    end
    local isSameIndex=nil;
    for i,v in ipairs(indexList) do
        if i==v then
            isSameIndex=i;
            break;
        end
    end
    if isSameIndex==nil then
        return indexList
    else
        local tempValue=indexList[1];
        indexList[1]=indexList[#indexList];
        indexList[#indexList]=tempValue;
        return indexList;
    end
end

this.GetPosByIndex=function(index)
    local index_y=math.floor(index/config.col)
    local index_x=index%config.col;
    local x=config.leftOff+index_x*config.cellX+(index_x-1)*config.spacing;
    local y=config.topOff-index_y*config.cellY-(index_y-1)*config.spacing;
    return Vector2(x,y);
end


this.GetImgIndex=function(i)
    if #this.iconIndexList==0 then 
        LuaDebug.error("iconIndexList index is Error")
        return nil
    end;
    local value=i;
    local index=nil;
    local count=1;
    while(value==i)
    do
        index =math.random(#this.iconIndexList)
        value=this.iconIndexList[index];
        count=count+1;
        if i==#this.dataList and value==#this.dataList then
            break
        end
    end
    table.remove(this.iconIndexList,index);
    return value;
end

this.OnDragBeginCallBack=function(index)
    this.SetCurrentBlock(index)
end

this.OnDragCallBack=function(index)
    
end

this.OnDragEndCallBack=function(index,pos)
    local curData=this.dataList[index];
    local tarData=nil;
    for i,v in ipairs(this.dataList) do
        if v.fixIndex~=nil and v.vm.data.index~=index then
            local distance_i=Vector2.Distance(v.fixPos,pos);
            if distance_i<config.distance then
                tarData=v;
                break;
            end
        end
    end
    if tarData==nil then
        curData.vm:DOMove(curData.fixPos,true,false);
    else
        local tempData={fixIndex=tarData.fixIndex,fixPos=tarData.fixPos};
        tarData.fixIndex=curData.fixIndex;
        tarData.fixPos=curData.fixPos;
        tarData.vm:DOMove(tarData.fixPos,false,this.CheckSuccess(tarData));
        
        curData.fixIndex=tempData.fixIndex;
        curData.fixPos=tempData.fixPos;
        curData.vm:DOMove(curData.fixPos,true,this.CheckSuccess(curData));
    end
end

this.CheckSuccess=function(dataItem)
    if dataItem.fixIndex==dataItem.vm.data.iconIndex then

        dataItem.fixIndex=nil;
        SetActive(ui.tranFix.gameObject,false);
        table.insert(this.successList,dataItem);
        if #this.successList>=#this.dataList then

            this.GameSuccess()
        end
        return true;
    end
    return false;
end


this.GameSuccess=function()
    SetActive(ui.goMask,false);
    SetActive(ui.btnReSet.gameObject,false);
    SetActive(ui.btnSee.gameObject,false);
    SetActive(ui.btnSkip.gameObject,false);
    if DataMgr.Player.RestoreImgMap[this.puzzleId]~=nil and DataMgr.Player.RestoreImgMap[this.puzzleId]>0 then
        return;
    end
    if not DataExHelper.CommonActivityCheck(ActivityKey.ZNHD) then

        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15901"))
        return;
    end
    local askData={Id=this.puzzleId};
    ApiMgr.Request("restored/puzzle", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
    end, nil, true);
end


this.SetCurrentBlock=function(index)
    local currentBlock=this.dataList[index]
    SetActive(ui.tranFix.gameObject,true);
    ui.tranFix.anchoredPosition=currentBlock.fixPos;
end


return vm({
    data = data,
    command = command,
    hook = hook
})
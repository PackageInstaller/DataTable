






require("ViewModel/SawPuzzle/SawPuzzle_PuzzleItem")
require("ViewModel/SawPuzzle/SawPuzzleConfig")

local this = {
    vm=nil,
    puzzleUIList={};
    puzzleItemObj=nil,
    puzzleItemObj2=nil;

};
local isFilter=false;
local isSee=false;
local isAuto=false;

local puzzleId=nil;
local isComplete=false;
local animator=nil;
local coKeyComplete=nil;
local coKeyEdge=nil;
local isStop=false;
local curPuzzle=nil;
local autoInterval=nil;
local curRemainTime=nil;


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goTools = nil;
local goActivePanel = nil;
local goEdgePanel = nil;
local goExitePanel = nil;
local Right = nil;
local scroll = nil;
local ScrollView = nil;
local tranContent = nil;
local tranArea = nil;
local tranRect = nil;
local btnEdge = nil;
local btnSaw = nil;
local btnAuto = nil;
local btnClear = nil;
local btnMaskActive = nil;
local btnAcitve = nil;
local btnCancel = nil;
local btnExit = nil;
local textAutoCount = nil;
local textExitTip = nil;
local rawImagePuzzle = nil;
local rawImagePuzzleActive = nil;
local rawImageFXPuzzleActive=nil;
local goEdgeHight=nil;
local goSawHight=nil;
local goAutoTime=nil;
local txtAutoTime=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goTools = uiLink:Get("goTools");
    goActivePanel = uiLink:Get("goActivePanel");
    goEdgePanel = uiLink:Get("goEdgePanel");
    goExitePanel = uiLink:Get("goExitePanel");
    goEdgeHight= uiLink:Get("goEdgeHight");
    goSawHight=uiLink:Get("goSawHight");
    Right = uiLink:Get("Right");
    scroll = uiLink:Get("scroll"):GetComponent("ScrollRect");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranArea = uiLink:Get("tranArea"):GetComponent("RectTransform");
    tranRect = uiLink:Get("tranRect"):GetComponent("RectTransform");
    btnEdge = uiLink:Get("btnEdge"):GetComponent("Button");
    btnSaw = uiLink:Get("btnSaw"):GetComponent("Button");
    btnAuto = uiLink:Get("btnAuto"):GetComponent("Button");
    btnClear = uiLink:Get("btnClear"):GetComponent("Button");
    btnMaskActive = uiLink:Get("btnMaskActive"):GetComponent("Button");
    btnAcitve = uiLink:Get("btnAcitve"):GetComponent("Button");
    btnCancel = uiLink:Get("btnCancel"):GetComponent("Button");
    btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    textAutoCount = uiLink:Get("textAutoCount"):GetComponent("Text");
    textExitTip = uiLink:Get("textExitTip"):GetComponent("Text");
    rawImagePuzzle = uiLink:Get("rawImagePuzzle"):GetComponent("RawImage");
    rawImagePuzzleActive = uiLink:Get("rawImagePuzzleActive"):GetComponent("RawImage");
    rawImageFXPuzzleActive=uiLink:Get("rawImageFXPuzzleActive"):GetComponent("RawImage");
    goAutoTime=uiLink:Get("goAutoTime");;
    txtAutoTime=uiLink:Get("txtAutoTime"):GetComponent("Text");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goTools = nil;
    goActivePanel = nil;
    goEdgePanel = nil;
    goExitePanel = nil;
    Right = nil;
    scroll = nil;
    ScrollView = nil;
    tranContent = nil;
    tranArea = nil;
    tranRect = nil;
    btnEdge = nil;
    btnSaw = nil;
    btnAuto = nil;
    btnClear = nil;
    btnMaskActive = nil;
    btnAcitve = nil;
    btnCancel = nil;
    btnExit = nil;
    textAutoCount = nil;
    textExitTip = nil;
    rawImagePuzzle = nil;
    rawImagePuzzleActive = nil;
    rawImageFXPuzzleActive=nil;
    goEdgeHight=nil;
    goSawHight=nil;
    goAutoTime=nil;
    txtAutoTime=nil;
end




this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnEdge",this.BtnEdgeExecute)
    uiLink:AddClickEvent("btnSaw",this.BtnSawExecute)
    uiLink:AddClickEvent("btnAuto",this.BtnAutoExecute)
    uiLink:AddClickEvent("btnClear",this.BtnClearExecute)
    uiLink:AddClickEvent("btnAcitve",this.BtnActiveExecute)
    uiLink:AddClickEvent("btnMaskActive",this.BtnMaskActiveExecute)
    uiLink:AddClickEvent("btnCancel",function()
        SetActive(goExitePanel,false);
    end)
    uiLink:AddClickEvent("btnExit",function()
        SawPuzzleMgr.SavePuzzle();
        LuaMgr.Back();
    end)
    
end


this.BtnEdgeExecute=function()
    isFilter=not isFilter
    SetActive(goEdgeHight,isFilter);
    SawPuzzleMgr.FilterEdgePuzzles(isFilter);
end


this.BtnSawExecute=function()
    isSee=not isSee
    SetActive(goSawHight,isSee);
    SetActive(rawImagePuzzle.gameObject,isSee);
end

this.BtnAutoExecute=function()
    if isAuto then return end;
    if SawPuzzleMgr.autoCount==0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7603"));
        return;
    end
    if #SawPuzzleMgr.initUIList==0 and SawPuzzleMgr.filerList~=nil and #SawPuzzleMgr.filerList>0 then
        this.BtnEdgeExecute();
    end
    isAuto=true;
    SawPuzzleMgr.AutoFixPuzzle(function(isResult)
        if isResult then
            SawPuzzleMgr.autoCount=SawPuzzleMgr.autoCount-1;
            textAutoCount.text=SawPuzzleMgr.autoCount;
        end
        isAuto=false 
    end);
    
end

this.BtnClearExecute=function()
    local tip=ConfigMgr.LangGlobal("7607")
    LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tip,function()
        isFilter=false;
        if SawPuzzleMgr.cacheData[puzzleId]~=nil then
            SawPuzzleMgr.cacheData[puzzleId]=nil;
        end
        SetActive(goEdgeHight,isFilter);
        this.InitPuzzle(true);
    end,nil)
end


this.BtnActiveExecute=function()
    if isStop then
        return;
    end
    LuaMgr.Back();
end

this.BtnMaskActiveExecute=function()
    
end


this.OnAskPuzzleAward=function(callBack)
    local askData={PuzzleId=puzzleId};
    ApiMgr.Request("teaTask/puzzle_get_award",askData,true,function(re)
        local re=json.decode(re);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if callBack~=nil then
            callBack();
        end
        SetActive(btnAcitve.gameObject,true);
        isStop=false;
    end,nil,true)
end

this.OnBack=function()
    if isComplete  then
        LuaMgr.Back();
        return;
    end
    SetActive(goExitePanel,true);
    textExitTip.text=ConfigMgr.LangGlobal("7604");
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.puzzleUIList=UIListView.New(tranContent)
        this.puzzleItemObj=vm.behaviour.transform:Find("template/puzzleItem").gameObject;
        this.puzzleItemObj2=vm.behaviour.transform:Find("template/puzzleItem2").gameObject;
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                puzzleId=vm.behaviour.Params[0];
                curPuzzle=ConfigMgr.Config.PuzzleMap[puzzleId];
                isComplete=false;
                isStop=false;
                this.vm.behaviour:UpdateTopBar("", this.OnBack)
                animator:Play("ui_ani_SawPuzzlePanel_root",0,0)
                SetActive(goSawHight,false);
                SetActive(goEdgeHight,false);
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.puzzleUIList:Clear();
            UIListView.ClearItem("SawPuzzle_PuzzleItem")
            LuaMgr.RemoveTimer(TimerConst.PuzzleAutoCount)
        end
    end,
    before_destroy=function()
       this.Clear();
        if coKeyComplete~=nil then
            coroutine_runner.stop(coKeyComplete);
            coKeyComplete=nil;
        end
        if coKeyEdge~=nil then
            coroutine_runner.stop(coKeyEdge);
            coKeyEdge=nil;
        end
    end
    
}

this.InitPuzzle=function(isRest)
    isFilter=false;
    isSee=false;
    isAuto=false;
    SawPuzzleMgr.Clear();
    SawPuzzleMgr.InitPuzzleList(this.vm.behaviour.transform,puzzleId,curPuzzle.Type)
    if curPuzzle.Type=="1" then
        tranContent.anchoredPosition=Vector2(50,0);
    elseif curPuzzle.Type=="2" then
        tranContent.anchoredPosition=Vector2(65,0);
    end
    local recordData=SawPuzzleMgr.CheckLocalRecord(puzzleId);
    if recordData==nil or isRest then
        this.SetPuzzleItemList();
        this.SetAutoCount(nil,isRest);
    else
        this.SetHistoryPuzzleList();
        this.SetAutoCount(recordData.autoCount,isRest);
    end
end

this.ParseData=function()
    local texture=LuaMgr.GetTexture(Path.Image.."SawPuzzle/"..curPuzzle.Pic ..".png");
    rawImagePuzzle.texture=texture;
    rawImagePuzzleActive.texture=texture;
    rawImageFXPuzzleActive.texture=texture;
    SetActive(btnAcitve.gameObject,false)
    SetActive(goTools,true);
    SetActive(rawImagePuzzle.gameObject,false);
    SetActive(goActivePanel,false);
    SetActive(goEdgePanel,false);
    SetActive(goExitePanel,false);
    this.InitPuzzle(false);
    
end


this.SetAutoCount=function(recordCount,isReset)
    if curPuzzle.UnlockTime[1]==0 then
        SawPuzzleMgr.autoCount=recordCount==nil and curPuzzle.UnlockTime[2] or recordCount;
        SetActive(goAutoTime,false)
    else
        if isReset then 

            return 
        end;
        SawPuzzleMgr.autoCount=recordCount==nil and 0 or recordCount;
        autoInterval=curPuzzle.UnlockTime[1];
        curRemainTime=autoInterval;
        LuaMgr.AddTimer(TimerConst.PuzzleAutoCount, this.PuzzleAutoCount,1, -1, true);
    end
    textAutoCount.text=SawPuzzleMgr.autoCount;
end

this.PuzzleAutoCount=function()
    if SawPuzzleMgr.autoCount<curPuzzle.Help then
        SetActive(goAutoTime,true)
        txtAutoTime.text=string.format(ConfigMgr.LangGlobal("7605"),math.floor(curRemainTime/60),curRemainTime%60)
        curRemainTime=curRemainTime-1;
        if curRemainTime<0 then
            SawPuzzleMgr.autoCount=SawPuzzleMgr.autoCount+curPuzzle.UnlockTime[2];
            if SawPuzzleMgr.autoCount>curPuzzle.Help then
                SawPuzzleMgr.autoCount=curPuzzle.Help;
            end
            curRemainTime=autoInterval;
        end
        textAutoCount.text=SawPuzzleMgr.autoCount;
    else
        SetActive(goAutoTime,false)
    end
end



this.SetPuzzleItemList=function() 

   if #SawPuzzleMgr.puzzleList==0 then return end;
    math.randomseed(LuaMgr.Timestamp())
    local list={}
    local objItem=curPuzzle.Type=="1" and this.puzzleItemObj or this.puzzleItemObj2
    for i,v in ipairs(SawPuzzleMgr.puzzleList) do
        for p,m in ipairs(v) do
            local puzzleItem={
                data=m,
                index=(i-1)*#v+p,
                imgName=curPuzzle.Pic,
                sortNum=this.GetRandomNum();
                completeCallBack=this.CompleteCallBackExecute;
                autoSwitchEdgeCallback=this.BtnEdgeExecute;
                name=m.loc_x.."_"..m.loc_y;
            }
            local puzzleItemData=UIListData.GetData(objItem,"SawPuzzle_PuzzleItem",puzzleItem);
            table.insert(list,puzzleItemData);
        end
    end
    table.sort(list,function(a, b) return a.data.sortNum<b.data.sortNum end)
    this.puzzleUIList:SetData(list);
    SawPuzzleMgr.puzzleUIList=this.puzzleUIList;
    SawPuzzleMgr.puzzleScrollView=ScrollView;
    SawPuzzleMgr.BindLoc2Index(this.puzzleUIList)
    SawPuzzleMgr.InitUIList(SawPuzzleMgr.puzzleUIList.itemList);
   
end


this.SetHistoryPuzzleList=function()

    local list={}
    local objItem=curPuzzle.Type=="1" and this.puzzleItemObj or this.puzzleItemObj2
    for i,v in ipairs(SawPuzzleMgr.puzzleList) do
        for p,m in ipairs(v) do
            local index=(i-1)*#v+p;
            local record=SawPuzzleMgr.cacheData[puzzleId].data[m.loc_x.."_"..m.loc_y];
            m.angleZ=record.angleZ
            local puzzleItem={
                data=m,
                index=index,
                imgName=curPuzzle.Pic,
                sortNum=record.sortNum,
                completeCallBack=this.CompleteCallBackExecute;
                autoSwitchEdgeCallback=this.BtnEdgeExecute;
                name=m.loc_x.."_"..m.loc_y;
            }
            local puzzleItemData=UIListData.GetData(objItem,"SawPuzzle_PuzzleItem",puzzleItem);
            table.insert(list,puzzleItemData);
        end
    end
    table.sort(list,function(a, b) return a.data.sortNum<b.data.sortNum end)
    this.puzzleUIList:SetData(list);
    SawPuzzleMgr.puzzleUIList=this.puzzleUIList;
    SawPuzzleMgr.puzzleScrollView=ScrollView;
    SawPuzzleMgr.BindLoc2Index(this.puzzleUIList)
    local initUIList={}
    for i,v in ipairs(SawPuzzleMgr.puzzleUIList.itemList) do
        local record=SawPuzzleMgr.cacheData[puzzleId].data[v.data.data.loc_x.."_"..v.data.data.loc_y];
        if record.isInit then
            v.data.data.index=record.index;
            table.insert(initUIList,v);
        else
            v.data.data.isFix=record.isFix
            v.data.data.isInit=false;
            v.data.data.index=nil;
            v.data.data.groupId=record.groupId;
            v.transform.parent=SawPuzzleMgr.tfArea;
            v.transform.anchoredPosition=Vector2(record.anchoredPositionX,record.anchoredPositionY)
            v.root.localScale=Vector3.one;
        end
    end
    SawPuzzleMgr.InitUIList(initUIList);
end


this.GetRandomNum=function()
    local num = math.random(1, 500)
    return num;
end

this.CompleteCallBackExecute=function(isAll)
    if isAll then
        isComplete=true;
        SetActive(goTools,false)
        SetActive(goActivePanel,true);
        animator:Play("ui_ani_SawPuzzlePanel_root02",0,0)
        if DataMgr.Player.puzzleStatus[puzzleId]==nil then
            isStop=true;
            coKeyComplete=coroutine_runner.start(function()
                coroutine_runner.wait(2)
                this.OnAskPuzzleAward();
            end)
        else
            SetActive(btnAcitve.gameObject,true);
            isStop=false;
            this.OnAskPuzzleAward();
        end
    else
        SetActive(goEdgePanel,true);
        coKeyEdge=coroutine_runner.start(function()
            coroutine_runner.wait(2)
            SetActive(goEdgePanel,false);
        end)
    end
end

return vm({
    data = nil,
    command = nil,
    hook = hook
})
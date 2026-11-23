






require("ViewModel/RefractionGame/Refraction_BlockItem")
require("ViewModel/RefractionGame/Refraction_BlockNull")
require("ViewModel/RefractionGame/Refraction_PointItem")
require("ViewModel/RefractionGame/Refraction_HighPointItem")
require("ViewModel/RefractionGame/RefractionMgr")


local this = {
    vm=nil,
    initBlockUIList={},
    opBlockUIList={};
    initPointUIList={};
    highPointUIList={};
    blockItemNullObj=nil,
    renderItem=nil;
    blockItemObj=nil,
    pointItemObj=nil;
    highPointItemObj=nil;
    lineRenderer=nil;
    renderList={};
    gameTime=nil;
};

local tarGameObject = nil;
local tarRect = nil;
local imgNull = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goPause = nil;
local Right = nil;
local tranInitBoards = nil;
local tranInitPoints = nil;
local tranOpBoards = nil;
local tranRay = nil;
local tranHightPoints = nil;
local txtTitle = nil;
local btnPause = nil;
local btnMask = nil;
local btnExit = nil;
local btnRestart = nil;
local btnContinue = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    imgNull = uiLink:Get("imgNull"):GetComponent("Image");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goPause = uiLink:Get("goPause");
    Right = uiLink:Get("Right");
    tranInitBoards = uiLink:Get("tranInitBoards"):GetComponent("RectTransform");
    tranInitPoints = uiLink:Get("tranInitPoints"):GetComponent("RectTransform");
    tranOpBoards = uiLink:Get("tranOpBoards"):GetComponent("RectTransform");
    tranRay = uiLink:Get("tranRay"):GetComponent("RectTransform");
    tranHightPoints = uiLink:Get("tranHightPoints"):GetComponent("RectTransform");
    txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    btnPause = uiLink:Get("btnPause"):GetComponent("Button");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    btnRestart = uiLink:Get("btnRestart"):GetComponent("Button");
    btnContinue = uiLink:Get("btnContinue"):GetComponent("Button");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    imgNull = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    goPause = nil;
    Right = nil;
    tranInitBoards = nil;
    tranInitPoints = nil;
    tranOpBoards = nil;
    tranRay = nil;
    tranHightPoints = nil;
    txtTitle = nil;
    btnPause = nil;
    btnMask = nil;
    btnExit = nil;
    btnRestart = nil;
    btnContinue = nil;

end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnPause",function()
        this.SetPauseTime(true)
        SetActive(goPause,true);
    end)
    uiLink:AddClickEvent("btnExit",function()
        LuaMgr.Back();
    end)
    uiLink:AddClickEvent("btnRestart",function()
        this.StartGame();
    end)

    uiLink:AddClickEvent("btnContinue",function()
        this.SetPauseTime(false)
        SetActive(goPause,false);
    end)


end


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.initBlockUIList=UIListView.New(tranInitBoards);
        this.opBlockUIList=UIListView.New(tranOpBoards);
        this.initPointUIList=UIListView.New(tranInitPoints);
        this.highPointUIList=UIListView.New(tranHightPoints);
        this.blockItemNullObj=vm.behaviour.transform:Find("template/blockNull").gameObject;
        this.blockItemObj=vm.behaviour.transform:Find("template/blockItem").gameObject;
        this.pointItemObj=vm.behaviour.transform:Find("template/pointItem").gameObject;
        this.highPointItemObj=vm.behaviour.transform:Find("template/hightPointItem").gameObject;
        this.renderItem=vm.behaviour.transform:Find("template/renderItem").gameObject;
        this.lineRenderer=tranRay:GetComponent("LineRenderer");
        this.renderList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "DH/DH_YP_01.mp3");
                local lightId=vm.behaviour.Params[0]
                this.cfgLevelGame=ConfigMgr.Config.LightGameMap[lightId]
                if IsNull(this.cfgLevelGame) then
                    return
                end;
                this.ParseData();
                this.LightGameEnterServerData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.ClearRenderGroup(0);
        end
    end,
    before_destroy=function()
        this.Clear();
        this.renderList={}
        UIListView.ClearItem("Refraction_BlockNull")
        UIListView.ClearItem("Refraction_BlockItem")
        UIListView.ClearItem("Refraction_PointItem")
        UIListView.ClearItem("Refraction_HighPointItem");
    end
    
    
}

this.ParseData=function()
    this.StartGame();
end

this.StartGame=function()
    this.gameTime=UnityEngine.Time.realtimeSinceStartup
    SetActive(goPause,false);
    txtTitle.text=LuaMgr.GetLangText(this.cfgLevelGame.NameLan);
    this.InitBoards();
    this.InitPointsList();
    this.SetOpBlockList();
    this.SetLineRender();
end


this.InitBoards=function()
    local initBoards=RefractionMgr.InitBoards(this.cfgLevelGame.Boards,tranOpBoards);
    local list={}
    for i,v in ipairs(initBoards) do
        if v.init then
            local blockNull={
              data=v.data;   
            }
            local blockData=UIListData.GetData(this.blockItemNullObj,"Refraction_BlockNull",blockNull)
            table.insert(list,blockData);
        end
    end
    this.initBlockUIList:SetData(list);
end


this.SetOpBlockList=function()
    local opBlocks=RefractionMgr.OpBlocksList(this.cfgLevelGame.Blocks);
    local list={}
    for i,v in ipairs(opBlocks) do
        v.callBack=this.OpBlockCallBack;
        local blockData=UIListData.GetData(this.blockItemObj,"Refraction_BlockItem",v)
        table.insert(list,blockData);
    end
    this.opBlockUIList:SetData(list);
end


this.InitPointsList=function()
    local initPoints=RefractionMgr.InitPointList(this.cfgLevelGame.RayTargetPoints)
    local list={}
    for i,v in ipairs(initPoints) do
        v.spriteName=this.cfgLevelGame.RayTargetPic;
        local pointData=UIListData.GetData(this.pointItemObj,"Refraction_PointItem",v);
        table.insert(list,pointData);
    end
    this.initPointUIList:SetData(list);
end

this.SetLineRender=function()
    local rayPoint=this.cfgLevelGame.RayInitPoint;
    local linePoints,tarPointMap=RefractionMgr.GetLinesPoints(rayPoint[1],rayPoint[2],rayPoint[3]);
    this.SetRenderGroup(linePoints);
    this.SetHighPointUIList(linePoints);
    this.RefreshPointUIList(tarPointMap);

    if NumTool.GetLen(tarPointMap)==#this.cfgLevelGame.RayTargetPoints then
        NumTool.DelayHandler(this.DOSuccess,1);

    end
end

this.SetRenderGroup=function(points)
local arrayTable={}
    for i=1,#points-1,1 do
        table.insert(arrayTable,{points[i],points[i+1]})
    end
    this.ClearRenderGroup(#arrayTable);
    for i,v in ipairs(arrayTable) do
        if this.renderList[i]==nil then
            local renderObj= LuaMgr.InstantiateGO(this.renderItem, tranRay, false)
            renderObj.transform.localPosition=Vector3.zero;
            renderObj.transform.localScale=Vector3.one;
            this.renderList[i]=renderObj:GetComponent("LineRenderer");
        end
        this.renderList[i].enabled=true;
        this.renderList[i].positionCount=2;
        this.renderList[i]:SetPositions(v);
        this.renderList[i]:SetWidth(1,1);
    end
end

this.ClearRenderGroup=function(len)
    if this.renderList==nil then return end;
    if #this.renderList>len then
        for i=len+1,#this.renderList,1 do
            this.renderList[i].enabled=false;
        end
    end
end


this.RefreshPointUIList=function(activeMap)
    for i,v in ipairs(this.initPointUIList.itemList) do
        v:SetActive(activeMap[i]~=nil)
    end
end


this.SetHighPointUIList=function(points)
    local list={}
    local len=#points;
    if Vector3.Distance(points[1],points[len])<5 then
        table.remove(points,len);
    end
    for i,v in ipairs(points) do
        local highItem={
            pos=v;
            index=i,
        }
        local highData=UIListData.GetData(this.highPointItemObj,"Refraction_HighPointItem",highItem);
        table.insert(list,highData);
    end
    this.highPointUIList:SetData(list);
end

this.SetPauseTime=function(isPause)
    if isPause then
        this.pausePreTime=UnityEngine.Time.realtimeSinceStartup-this.gameTime;
    else
        this.gameTime=UnityEngine.Time.realtimeSinceStartup-this.pausePreTime;
    end
end

this.DOSuccess=function()
    this.gameTime=UnityEngine.Time.realtimeSinceStartup-this.gameTime;
    local dataRewards={}
    if not IsNull(DataMgr.Player.LightGame) and not IsNull(DataMgr.Player.LightGame.rewards) then
        dataRewards=DataMgr.Player.LightGame.rewards
    end
    local reStartGameCallback=function(isResult)
        if isResult then
            LuaMgr.Back();
        else
            this.StartGame();
        end
    end
    if dataRewards[this.cfgLevelGame.ID]~=nil then
        LuaMgr.ShowLuaPanel(UIName.RefractionResultViewModel,this.cfgLevelGame,this.gameTime,false,reStartGameCallback)
    end
    local data={ID=this.cfgLevelGame.ID}
    ApiMgr.Request("lightgame/getRewards",data,true,function(re)
        LuaMgr.ShowLuaPanel(UIName.RefractionResultViewModel,this.cfgLevelGame,this.gameTime,true,reStartGameCallback)
    end,nil,true)
end


this.LightGameEnterServerData=function()
    local data={ID=this.cfgLevelGame.ID}
    ApiMgr.Request("lightgame/enter",data,true,nil,nil,false)
end


this.OpBlockCallBack=function(index)
   this.SetLineRender(); 
end


return vm({
    data = nil,
    command = nil,
    hook = hook
})
require("ViewModel/Simulate/SimulateDropMat")
require("ViewModel/Simulate/Simulate_DropGameItem")
require("ViewModel/Simulate/Simulate_DropProItem")

local this = {
    vm = nil,
    matUIList={};
    matItemObj=nil;
    proUIList={};
    proItemObj=nil;
    lastDropIndex=nil;
    dropList={};
    collectList={};
    combCount=0;
    isFastModel=false;
};
local lastDropTime=0;
local lastGameTime=0;
local dropInterval=0.7;
local dropAddInterval=0;
local dropSpeed=300;
local dropAddSpeed=0;
local basketSpeed=400;
local basketASpeed=800;
local DROP_SIZE=Vector2(80,80);
local BASKET_SIZE=Vector3(120,120)


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goflowerFail = uiLink:Get("goflowerFail");
    ui.goTime = uiLink:Get("goTime");
    ui.goComb = uiLink:Get("goComb");
    ui.goFast = uiLink:Get("goFast");
    ui.goStart = uiLink:Get("goStart");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goPausePanel = uiLink:Get("goPausePanel");
    ui.goSettlementPanel = uiLink:Get("goSettlementPanel");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.txtComb = uiLink:Get("txtComb"):GetComponent("Text");
    ui.txtAddTimeComb = uiLink:Get("txtAddTimeComb"):GetComponent("Text");
    ui.tranArea = uiLink:Get("tranArea"):GetComponent("RectTransform");
    ui.tranBasket = uiLink:Get("tranBasket"):GetComponent("RectTransform");
    ui.tranItemList = uiLink:Get("tranItemList"):GetComponent("RectTransform");
    ui.tranProContent = uiLink:Get("tranProContent"):GetComponent("RectTransform");
    ui.btnPause = uiLink:Get("btnPause"):GetComponent("Button");
    ui.btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    ui.btnRestart = uiLink:Get("btnRestart"):GetComponent("Button");
    ui.btnContinue = uiLink:Get("btnContinue"):GetComponent("Button");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.slider = uiLink:Get("slider"):GetComponent("Slider");
    ui.imgFastSlider = uiLink:Get("imgFastSlider"):GetComponent("Image");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnPause",this.OnPauseBack)
    uiLink:AddClickEvent("btnExit",function()
        this.GameOver();
        LuaMgr.Back();
        UnityEngine.Time.timeScale=1;
    end)
    uiLink:AddClickEvent("btnRestart",function()
        SetActive(ui.goPausePanel,false);
        this.GameOver();
        this.ReStartGame();
        UnityEngine.Time.timeScale=1;
    end)
    uiLink:AddClickEvent("btnContinue",function()
        SetActive(ui.goPausePanel,false);
        UnityEngine.Time.timeScale=1;
    end)
    uiLink:AddClickEvent("btnMask",function()
        SetActive(ui.goPausePanel,false);
        LuaMgr.Back();
    end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.matUIList=UIListView.New(ui.tranItemList);
        this.matItemObj=vm.behaviour.transform:Find("template/matItem").gameObject;
        this.proUIList=UIListView.New(ui.tranProContent)
        this.proItemObj=vm.behaviour.transform:Find("template/proItem").gameObject;
        this.flowerFXObj=vm.behaviour.transform:Find("template/flowerFX").gameObject;
        this.dragBehaviour=vm.behaviour.transform:Find("root/Middle/game/tranArea/tranBasket/basket"):GetComponent("OnDragBehaviour")
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
        this.dragBehaviour.onBeginDrag=this.OnBeginDrag;
        this.dragBehaviour.onDrag=this.OnDrag;
        this.dragBehaviour.onPointerUp=function(event)
            
        end;
        this.collectList={};
        this.fxPoolList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                local levelId=vm.behaviour.Params[0];
                PlayerPrefs.SetInt(DataMgr.Player.uid .. "Simulate_DropGame_"..levelId,1);
                vm.behaviour:UpdateTopBar("",this.OnPauseBack)
                this.gameConfig=ConfigMgr.Config.SimulateCatchGameMap[levelId]
                this.constants=ConfigMgr.Config.SimulateConstants;
                SetActive(ui.goPausePanel,false);
                SetActive(ui.goSettlementPanel,false);
                this.InitDropMaterialList();
                this.InitDropPosList();
                this.PrepareStartGame();
            end
        end

    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.matUIList:Clear();
        this.proUIList:Clear();
        LuaMgr.RemoveUpdate(this.Update)
        if this.weener~=nil then
            this.weener:Kill();
        end
        if this.TimerId~=nil then
            NumTool.RemoveDelayHandler(this.TimerId)
        end
        UnityEngine.Time.timeScale=1
        this.CollectAllMaterial();
    end,
    before_destroy = function()
        this.ClearUI()
        this.DestroyCollectList();
        UIListView.ClearItem("Simulate_DropGameItem")
        UIListView.ClearItem("Simulate_DropProItem")
    end
}


this.OnPauseBack=function()
    SetActive(ui.goPausePanel,true)
    this.animator:Play("ani_SimulateDropGamePanel_root_004",0,0)
    UnityEngine.Time.timeScale=0;
end

this.PrepareStartGame=function()
    SetActive(ui.goStart,true)
    SetActive(ui.goTime,false);
    SetActive(ui.btnPause.gameObject,false);
    SetActive(ui.goComb,false)
    SetActive(ui.goFast,false)
    this.animator:Play("ani_SimulateDropGamePanel_root_001",0,0)
    this.TimerId=NumTool.DelayHandler(function()
        if ui~=nil and ui.goStart~=nil then
            SetActive(ui.goStart,false)
            this.ReStartGame();
            this.TimerId=nil;
        end
    end,3.5)
end

this.ReStartGame=function()
    this.materialDic={}
    math.randomseed(LuaMgr.Timestamp())
    this.ParseData();
    this.StartGame();
end


this.ParseData=function()
    this.gameItems=DataMgr.Player.SimulateGame.Items
    this.SetMatUIList();
end


this.SetMatUIList=function()
    local list={}
    for i,v in ipairs(this.gameConfig.Material) do
        local iconName=ConfigMgr.Config.SimulateCatchMaterialMap[v].Icon;
        local matItem={
            Id=v,
            count=0,
            iconName=iconName,
        }
        local matData=UIListData.GetData(this.matItemObj,"Simulate_DropGameItem",matItem);
        table.insert(list,matData);
    end
    this.matUIList:SetData(list);
end

this.AddMaterial=function(Id,count)
    if this.materialDic[Id]==nil then
        this.materialDic[Id]=0;
    end
    this.materialDic[Id]=this.materialDic[Id]+count;
    this.UpdateMatUIList();
end

this.UpdateMatUIList=function()
    for i,v in ipairs(this.matUIList.dataList) do
        if this.materialDic[v.data.Id]~=nil then
            v.data.count=this.materialDic[v.data.Id];
        end
    end
    this.matUIList:Refresh();
end

this.UpdateGameTime=function(isInit,time)
    if isInit then
        this.gameTime=time;
    else
        this.gameTime=this.gameTime+time;
    end
    ui.txtTime.text=this.gameTime;
    if this.gameTime<=0 then
        this.GameOver(true);
    end
end






this.InitDropPosList=function()
    local step=math.floor(ui.tranArea.sizeDelta.x/this.constants.SimulateCatchNumber-1);
    this.dropPosXList={};
    for i=1,this.constants.SimulateCatchNumber,1 do
        table.insert(this.dropPosXList,-ui.tranArea.sizeDelta.x/2+60+(i-1)*step);
    end
end

this.GetDropPosition=function()
    local randomIndex=nil;
    while true do
        randomIndex=math.random(#this.dropPosXList)
        if this.lastDropIndex==nil or this.lastDropIndex~=randomIndex then
            break;
        end
    end
    this.lastDropIndex=randomIndex;
    local dropX=this.dropPosXList[randomIndex];
    return Vector3(dropX,ui.tranArea.sizeDelta.y/2-40,0)
end
this.InitDropMaterialList=function()
    this.dropMaterialList={}
    for i,v in ipairs(this.gameConfig.Material) do
        table.insert(this.dropMaterialList,{id=v,type=1,count=1});
    end
    for i,v in pairs(ConfigMgr.Config.SimulateCatchMaterialMap) do
        if v.Istrans>0 then

            table.insert(this.dropMaterialList,{id=v.Id,type=2,count=1});
        end
    end
end

this.GetDropMaterial=function()
    local randomIndex=math.random(#this.dropMaterialList)
    local randomMaterial=this.dropMaterialList[randomIndex];
    if this.isFastModel then

        local randomDoubleWeight=math.random(10000)
        randomMaterial.count=randomDoubleWeight<=this.constants.SimulateCatchDouble and 2 or 1;
    end
    return randomMaterial;
end


this.StartGame=function()
    SetActive(ui.goTime,true);
    SetActive(ui.btnPause.gameObject,true);
    SetActive(ui.goflowerFail,false);
    this.dropList={};
    this.SetFastModel(false);
    this.UpdateGameTime(true,this.gameConfig.TimeLimit)
    LuaMgr.AddUpdate(this.Update);
end


this.GameOver=function(isPlayOver)

    LuaMgr.RemoveUpdate(this.Update)
    this.CollectAllMaterial();
    if this.weener~=nil then
        this.weener:Kill()
    end
    if isPlayOver then

        SimulateRoomMgr.OnAskCatchGame(this.gameConfig.Id,this.materialDic,function()
            this.SetSettlementUIList();
        end)
    end
   
end


this.DestroyCollectList=function()
    if #this.collectList==0 then return end;
    for i,v in ipairs(this.collectList) do
        v.vm:Destroy();
    end ;
end

this.Update=function()

    this.CheckGameTime()
    if UnityEngine.Time.time-lastDropTime>(dropInterval-dropAddInterval) then
        lastDropTime=UnityEngine.Time.time;
        this.CreateDropMaterial();
    end
    if #this.dropList==0 then return end;
    this.DODropMaterial();



    this.CheckTriggerSuccess();
    this.CheckCollectMaterial();
end

this.CheckGameTime=function()
    if UnityEngine.Time.time-lastGameTime>=1 then

lastGameTime=UnityEngine.Time.time
        this.UpdateGameTime(false,-1)
    end
end

this.CreateDropMaterial=function()
    local materialData=nil;
    if #this.collectList>0  then
        materialData=this.collectList[1];
        table.remove(this.collectList,1);
    else
        local dropItem=SimulateDropMat.New(ui.tranArea);
        materialData={
            material=nil,
            initPos=nil,
            vm=dropItem
        }
    end
    local initPos=this.GetDropPosition();
    local material=this.GetDropMaterial();
    materialData.vm:SetPosition(initPos)
    materialData.vm:SetData(material.id)
    materialData.material=material;
    materialData.initPos=initPos;
    table.insert(this.dropList,materialData);
end

this.DODropMaterial=function()
    this.curDropSpeed=(dropSpeed+dropAddSpeed)*UnityEngine.Time.deltaTime;
    for i,v in ipairs(this.dropList) do
        v.vm:DODrop(this.curDropSpeed);
    end
end


this.CheckTriggerSuccess=function()
    for i=#this.dropList,1,-1 do
        local dropItem=this.dropList[i];
        local centerPos=Vector2(dropItem.vm.transform.localPosition.x,dropItem.vm.transform.localPosition.y);
        local centerBasketPos=Vector2(ui.tranBasket.localPosition.x,ui.tranBasket.localPosition.y)
        if Vector2.Distance(centerPos,centerBasketPos)<(DROP_SIZE.x/2+BASKET_SIZE.x/2+20) and dropItem.vm.transform.localPosition.y-ui.tranBasket.localPosition.y>20 then

            if dropItem.material.type==1 then

                this.CatchUsedMaterial(dropItem.material)
            elseif dropItem.material.type==2 then

                this.CatchUnUsedMaterial(dropItem.material.id);
            end
            table.remove(this.dropList,i);
            dropItem.vm:SetPosition(Vector3(0,-1500,0))
            table.insert(this.collectList,dropItem);
        end
    end
end


this.SetFastModel=function(isFast)
    this.isFastModel=isFast;
    SetActive(ui.goFast,isFast)
    if isFast then
        this.animator:Play("ani_SimulateDropGamePanel_root_003",0,0)
        NumTool.DelayHandler(function()
            if ui~=nil and ui.goComb~=nil then
                SetActive(ui.goComb,false);
                ui.txtAddTimeComb.text="";
            end
        end,1)
    else
        SetActive(ui.goComb,false);
    end
    this.combCount=0;
    if not isFast then
        dropAddSpeed=0;
        dropAddInterval=0;
    else
        dropAddSpeed=dropSpeed*this.constants.SimulateCatchComboSpeed/10000;
        dropAddInterval=dropInterval*this.constants.SimulateCatchComboFrequency/10000;
        local fastTime=this.constants.SimulateCatchComboLast;
        this.weener=DOTWeen.To(function() return 1.0  end,function(value)
            ui.imgFastSlider.fillAmount=value;
        end,0,fastTime);
        this.weener.onComplete=function()
            this.SetFastModel(false);
        end
        
    end
end



this.UpdateCombCount=function(isAdd)
    if this.isFastModel then return end;
    if isAdd then
        this.combCount=this.combCount+1;
        ui.txtComb.text=this.combCount;
        this.animator:Play("ani_SimulateDropGamePanel_root_002",0,0)
    else
        this.combCount=0;
    end
    SetActive(ui.goComb,this.combCount>1);
    if this.combCount>=this.constants.SimulateCatchComboTrigger then

        this.combCount=0;
        ui.txtAddTimeComb.text="+"..this.constants.SimulateCatchComboAddTime;
        this.UpdateGameTime(false,this.constants.SimulateCatchComboAddTime);
        this.SetFastModel(true);
    end
end


this.CatchUsedMaterial=function(material)
    this.AddMaterial(material.id,material.count);
    this.UpdateCombCount(true);
    this.PlaySuccessAnimatorAndFX();
end

this.CatchUnUsedMaterial=function(id)
    this.UpdateCombCount(false)

    this.UpdateGameTime(false,-this.constants.SimulateCatchTrashDelete);
    AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_08.mp3");
    SetActive(ui.goflowerFail,true);
    NumTool.DelayHandler(function()
        if ui~=nil and ui.goflowerFail~=nil then
            SetActive(ui.goflowerFail,false);
        end
    end,0.5)
end


this.PlaySuccessAnimatorAndFX=function(dropItem)
    local objFX=this.GetFlowerFXObj();
    if objFX==nil then return end;
    AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DH/DH_YP_07.mp3");
    SetActive(objFX,true);
    NumTool.DelayHandler(function()
        SetActive(objFX,false);
        table.insert(this.fxPoolList,objFX);
    end,0.5)
end

this.GetFlowerFXObj=function()
    local obj=nil;
    if #this.fxPoolList>0 then
        obj=this.fxPoolList[1];
        table.remove(this.fxPoolList,1);
    else
         obj = LuaMgr.InstantiateGO(this.flowerFXObj, ui.tranBasket, false);
         obj.transform.localPosition=Vector3(0,44.8,0);
    end
    return obj;
end


this.CheckCollectMaterial=function()
    for i=#this.dropList,1,-1 do
        local dropItem=this.dropList[i];
        if dropItem.vm.transform.localPosition.y<-ui.tranArea.sizeDelta.y/2-40 then

            if dropItem.material.type==1 then

                this.UpdateCombCount(false)
            end
            dropItem.vm:SetPosition(Vector3(0,-1500,0))
            table.insert(this.collectList,dropItem);
            table.remove(this.dropList,i);
        end
    end
end

this.CollectAllMaterial=function()
    if #this.dropList==0 then return end;
    for i=#this.dropList,1,-1 do
        local dropItem=this.dropList[i];
        dropItem.vm:SetPosition(Vector3(0,-1500,0))
        table.insert(this.collectList,dropItem);
    end
    this.dropList={};
end

this.OnBeginDrag=function(event)
    local pos=LuaMgr.Screen2Local(event.position,ui.tranArea)
    this.offVector=ui.tranBasket.anchoredPosition.x-pos.x;
end

this.OnDrag=function(event)
    local pos=LuaMgr.Screen2Local(event.position,ui.tranArea)
    ui.tranBasket.anchoredPosition=Vector2(pos.x+this.offVector,-233.8);
end













this.SetSettlementUIList=function()
    SetActive(ui.goSettlementPanel,true);
    this.animator:Play("ani_SimulateDropGamePanel_root_005",0,0)
    this.proUIList:Clear();
    local list={}
    for i,v in ipairs(this.gameConfig.Material) do
        local materialConfig=ConfigMgr.Config.SimulateCatchMaterialMap[v];
        local proItem={
            id=materialConfig.Id,
            maxCount=materialConfig.Limit,
            iconName=materialConfig.Icon,
            curCount=this.materialDic[v]==nil and 0 or  this.materialDic[v];
        }
        local proData=UIListData.GetData(this.proItemObj,"Simulate_DropProItem",proItem);
        table.insert(list,proData);
    end
    this.proUIList:SetData(list);
end


return vm({
    data = data,
    command = command,
    hook = hook
})
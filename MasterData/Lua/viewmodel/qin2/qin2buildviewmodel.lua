




require("ViewModel/Qin2/Qin2Build_EventItem")

local this = { vm = nil,
               eventUIList = {};
               eventItemObj = nil;
               curTourSpot=nil;
               isCanHandlerEvent=false;
               dataTour=nil;
               animator=nil;
};

local EventType={
    Init=0,
Progress=1,
FinishWheelOrNone=2,
FinishAll=3
}
local cokey=nil;
local cokeyRoot=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Middle = nil;
local goState3 = nil;
local Right = nil;
local goState1 = nil;
local goState2 = nil;
local Left = nil;
local rawImageBuild = nil;
local rawImageCost = nil;
local tranArea = nil;
local btnNovel = nil;
local btnGame = nil;
local btnHandEvent = nil;
local btnBattle=nil;
local txtNovelName = nil;
local txtGameNum = nil;
local txtCostCount = nil;
local txtCount = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    goState3 = uiLink:Get("goState3");
    Right = uiLink:Get("Right");
    goState1 = uiLink:Get("goState1");
    goState2 = uiLink:Get("goState2");
    Left = uiLink:Get("Left");
    rawImageBuild = uiLink:Get("rawImageBuild"):GetComponent("RawImage");
    rawImageCost = uiLink:Get("rawImageCost"):GetComponent("RawImage");
    tranArea = uiLink:Get("tranArea"):GetComponent("RectTransform");
    btnNovel = uiLink:Get("btnNovel"):GetComponent("Button");
    btnGame = uiLink:Get("btnGame"):GetComponent("Button");
    btnBattle=uiLink:Get("btnBattle"):GetComponent("Button");
    btnHandEvent = uiLink:Get("btnHandEvent"):GetComponent("Button");
    txtNovelName = uiLink:Get("txtNovelName"):GetComponent("Text");
    txtGameNum = uiLink:Get("txtGameNum"):GetComponent("Text");
    txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    this.AddRegister(uiLink)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Middle = nil;
    goState3 = nil;
    Right = nil;
    goState1 = nil;
    goState2 = nil;
    Left = nil;
    rawImageBuild = nil;
    rawImageCost = nil;
    tranArea = nil;
    btnNovel = nil;
    btnGame = nil;
    btnHandEvent = nil;
    txtNovelName = nil;
    txtGameNum = nil;
    txtCostCount = nil;
    txtCount = nil;
    btnBattle=nil;
    
end


local data={}
local command={}

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnHandEvent",function()
        if not this.isCanHandlerEvent then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("104001"))
        else
            Qin2EventMgr.TourRefreshEvent(this.curTourSpot.Id,function()
                this.dataTour=DataMgr.Player.tour;
                this.SetEventState(EventType.Progress,1);
            end)
        end
    end)
    uiLink:AddClickEvent("btnNovel",function()
        if this.novelEvent~=nil then
            HeroParameter.Qin2ScenicId=this.curTourSpot.Id;
            LuaMgr.PlayNovel(this.novelEvent.FightParameter,function()
                LuaMgr.ShowLuaPanel(UIName.Qin2BuildViewModel,HeroParameter.Qin2ScenicId)
            end)
        end
    end)
    uiLink:AddClickEvent("btnBattle",function()
        if this.battleEvent~=nil then
            HeroParameter.Qin2ScenicId=this.curTourSpot.Id;
            local dungeonId=this.battleEvent.FightParameter;
            BattlePrepareMgr.EnterBattlePrepare(dungeonId,dungeonId,2);
        end
    end)
    uiLink:AddClickEvent("btnGame",function()
        LuaMgr.ShowLuaPanel(UIName.Qin2LetterGameViewModel,this.gameEvent.Id);
    end)
   
end

this.EventCallBack=function(eventId)
    local tourEvent=ConfigMgr.Config.TourEventMap[eventId]
    if tourEvent.EventType==1 then

        HeroParameter.Qin2ScenicId=this.curTourSpot.Id;
        LuaMgr.PlayNovel(tourEvent.FightParameter,function()
            LuaMgr.ShowLuaPanel(UIName.Qin2BuildViewModel,HeroParameter.Qin2ScenicId)
        end)
    elseif tourEvent.EventType==2 or tourEvent.EventType==3 then

        local dungeonId=tourEvent.FightParameter;
        BattlePrepareMgr.EnterBattlePrepare(dungeonId,dungeonId,2);
    elseif tourEvent.EventType==4 then
        LuaMgr.ShowLuaPanel(UIName.Qin2LetterGameViewModel,eventId);

    elseif tourEvent.EventType==5 then

        LuaMgr.ShowLuaPanel(UIName.Qin2AnswerViewModel,eventId);
    end
    
end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.eventItemObj=vm.behaviour.transform:Find("template/eventItem").gameObject;
        this.eventUIList=UIListView.New(tranArea);
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                local scenicId=vm.behaviour.Params[0];
                this.curTourSpot=ConfigMgr.Config.TourSpotMap[scenicId]
                this.animator:Play("ani_Qin2BuildPanel_root")
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.eventUIList:Clear();
        if cokey~=nil then
            coroutine_runner.stop(cokey);
        end
        if cokeyRoot~=nil then
            coroutine_runner.stop(cokeyRoot);
        end
    end,
    before_destroy=function()
        this.Clear()
        UIListView.ClearItem("Qin2Build_EventItem")
    end
}

this.ParseData=function()
    this.dataTour=DataMgr.Player.tour;
    this.SetBaseInfo();
    this.CheckGetReward();

    if Qin2EventMgr.CheckFinishAreaEvents(this.curTourSpot.TourEvent) then
        this.SetEventState(EventType.Init)



            if cokeyRoot~=nil then
                coroutine_runner.stop(cokeyRoot);
            end
             cokeyRoot=coroutine_runner.start(function()
                coroutine_runner.wait(1.7)
                 this.SetEventState(EventType.FinishAll)
                this.animator:Play("ani_Qin2BuildPanel_root_02")
            end)

        return
    end

    if Qin2EventMgr.CheckFinishWheeEvents(this.curTourSpot) then
        this.SetEventState(EventType.FinishWheelOrNone);
        return
    end

    this.SetEventState(EventType.Progress,2);
   
end



this.CheckGetReward=function()
    if IsNull(this.dataTour.finishEvent) then return end;
    for i,v in pairs(this.dataTour.finishEvent) do
        if IsNull(this.dataTour.receiveEvent) or this.dataTour.receiveEvent[i]==nil then
            Qin2EventMgr.TourGetReward(i,0,function()
                this.dataTour=DataMgr.Player.tour;
            end);
            break;
        end
    end
end

this.SetEventState=function(type,aniType)
    SetActive(goState1,type==EventType.FinishWheelOrNone);
    SetActive(goState2,type==EventType.Progress);
    SetActive(goState3,type==EventType.FinishAll);
    if type==EventType.Progress then
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/climb_enter.mp3");
        this.SetEventList(aniType);
    end
end

this.SetBaseInfo=function()
    rawImageBuild.texture=LuaMgr.GetTexture(Path.Image.."Qin2/"..this.curTourSpot.ScenicSpotPic..".png")
    txtCount.text=#this.curTourSpot.TourEvent-Qin2EventMgr.GetFinishEventCountByArea(this.curTourSpot.TourEvent);
    local cost=this.curTourSpot.TourCost;
    local path=ConfigHelper.GetItemHomeIconPath(cost[1].id)
    this.isCanHandlerEvent=DataHelper.GetItemCountById(cost[1].id)>=cost[1].count
    rawImageCost.texture=LuaMgr.GetTexture(path);
    if this.isCanHandlerEvent then
        txtCostCount.text=tostring(cost[1].count);
    else
        txtCostCount.text=string.format("<color=#ff0000>%s</color>",cost[1].count)
    end
    this.novelEvent=nil;
    this.gameEvent=nil;
    this.battleEvent=nil;
    for i,v in pairs(this.curTourSpot.TourEvent) do
        if ConfigMgr.Config.TourEventMap[v].EventType==1 then
            this.novelEvent=ConfigMgr.Config.TourEventMap[v]
        elseif ConfigMgr.Config.TourEventMap[v].EventType==4 then
            this.gameEvent=ConfigMgr.Config.TourEventMap[v];
        elseif ConfigMgr.Config.TourEventMap[v].EventType==3 then
            this.battleEvent=ConfigMgr.Config.TourEventMap[v];
        end
    end
    if this.novelEvent~=nil and not IsNull(this.dataTour.finishEvent) and this.dataTour.finishEvent[this.novelEvent.Id]~=nil then
        SetActive(btnNovel.gameObject,true)
        txtNovelName.text=LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[this.novelEvent.FightParameter].nameLan)
    else
        SetActive(btnNovel.gameObject,false)
    end
    if this.gameEvent~=nil and not IsNull(this.dataTour.finishEvent) and this.dataTour.finishEvent[this.gameEvent.Id]~=nil then
        SetActive(btnGame.gameObject,true)
        local time=""
        if not IsNull(this.dataTour.finishEventCost) then
            time=this.dataTour.finishEventCost[this.gameEvent.Id]
        end
        txtGameNum.text=string.format(ConfigMgr.LangGlobal("104004"),time);
    else
        SetActive(btnGame.gameObject,false)
    end
    if this.battleEvent~=nil and not IsNull(this.dataTour.finishEvent) and this.dataTour.finishEvent[this.battleEvent.Id]~=nil then
        SetActive(btnBattle.gameObject,true);
    else
        SetActive(btnBattle.gameObject,false)
    end
    
end


this.SetEventList=function(aniType)
    if IsNull(this.dataTour.scenicEvent) or this.dataTour.scenicEvent[this.curTourSpot.Id]==nil then
        return
    end
    local unlockEvents=this.dataTour.scenicEvent[this.curTourSpot.Id];
    local list={}
    this.pointList=table.Copy(this.curTourSpot.EventPoint);
    for i,v in pairs(unlockEvents) do
        if not Qin2EventMgr.CheckFinishEventById(i) then
            local event=ConfigMgr.Config.TourEventMap[i];
            local eventItem={
                eventId=i,
                eventType=event.EventType,
                callBack=this.EventCallBack,
                pos=this.GetEventPos(event.Point),
            }
            local eventData=UIListData.GetData(this.eventItemObj,"Qin2Build_EventItem",eventItem);
            table.insert(list,eventData);
        end
    end
    this.eventUIList:SetData(list);
    if aniType==nil then return end;
    if cokey~=nil then
        coroutine_runner.stop(cokey);
    end
    cokey=coroutine_runner.start(function()
        if this.eventUIList~=nil and not IsNull(this.eventUIList.itemList) then
            for i,v in ipairs(this.eventUIList.itemList) do
                if v~=nil then
                    v:PlayAnimator(aniType)
                end
                coroutine_runner.wait(0.1);
            end
        end
    end)
    
end

this.GetEventPos=function(index)
    if index==0 or index>#this.curTourSpot.EventPoint then
        LuaDebug.error("eventId config is Error")
        return Vector2(0,0);
    end
    local eventPoint=this.curTourSpot.EventPoint[index]
    return Vector2(eventPoint[1],eventPoint[2]);
end


return vm({
    data = data,
    command = command,
    hook = hook
})
require("ViewModel/Rogue/Rogue_ExploreItem")
require("ViewModel/Rogue/Rogue_ExploreItem2")

local this = {
    vm = nil,
    exploreUIList={},
    exploreItemObj=nil;
    exploreItemObj2=nil;
    renderItemGray=nil;
    renderItemHigh=nil;
    mapID=nil;
    itemVM=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle1 = uiLink:Get("Middle1");
    ui.goExploreMap = uiLink:Get("goExploreMap");
    ui.Left = uiLink:Get("Left");
    ui.goInfoUp = uiLink:Get("goInfoUp");
    ui.goInfoDown = uiLink:Get("goInfoDown");
    ui.Right = uiLink:Get("Right");
    ui.goTips = uiLink:Get("goTips");
    ui.goEffect = uiLink:Get("goEffect");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranViewContent = uiLink:Get("tranViewContent"):GetComponent("RectTransform");
    ui.tranMapList = uiLink:Get("tranMapList"):GetComponent("RectTransform");
    ui.tranGoods = uiLink:Get("tranGoods"):GetComponent("RectTransform");
    ui.rawMapBG = uiLink:Get("rawMapBG"):GetComponent("RawImage");
    ui.txtUpTitle = uiLink:Get("txtUpTitle"):GetComponent("Text");
    ui.txtDownTitle = uiLink:Get("txtDownTitle"):GetComponent("Text");
    ui.txtGoodsTip = uiLink:Get("txtGoodsTip"):GetComponent("Text");
    ui.btnBuff = uiLink:Get("btnBuff"):GetComponent("Button");
    ui.btnBag = uiLink:Get("btnBag"):GetComponent("Button");
    ui.btnGM = uiLink:Get("btnGM"):GetComponent("Button");
    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBag",function()
        if not RogueExploreMgr.isContinue then

            return
        end
        LuaMgr.ShowLuaPanel(UIName.RogueExploreBagViewModel);
    end)
    uiLink:AddClickEvent("btnBuff",function()
        if not RogueExploreMgr.isContinue then

            return
        end
        LuaMgr.ShowLuaPanel(UIName.RogueExploreBuffPopupViewModel);
    end)
    uiLink:AddClickEvent("btnGM",function()
        LuaMgr.ShowLuaPanel(UIName.RogueGMViewModel);
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
        this.exploreUIList = UIListView.New(ui.tranMapList);
        this.exploreItemObj = vm.behaviour.transform:Find("template/exploreItem").gameObject
        this.exploreItemObj2 = vm.behaviour.transform:Find("template/exploreItem2").gameObject
        this.renderItemGray=vm.behaviour.transform:Find("template/renderItemGray").gameObject
        this.renderItemHigh=vm.behaviour.transform:Find("template/renderItemHigh").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack)
            this.isPop=vm.behaviour.IsPop;
            LuaMgr.ShowLuaPanel(UIName.RogueTopBarResViewModel)
            LuaMgr.ShowLuaPanel(UIName.RogueTipsViewModel)
            LuaMgr.RemoveUIEventListener(UIEventConst.RogueEventType,this.CompleteEventNumber)
            LuaMgr.AddUIEventListener(UIEventConst.RogueEventType, this.CompleteEventNumber);
            LuaMgr.RemoveUIEventListener(UIEventConst.RogueSwitchMapStart,this.RogueSwitchMapStart);
            LuaMgr.AddUIEventListener(UIEventConst.RogueSwitchMapStart,this.RogueSwitchMapStart);
            SetActive(ui.btnGM.gameObject,LuaMgr.IsDebug())
            SetActive(ui.goEffect,false);
            this.ParseData();
            RogueMgr.PlayBgm()
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params ~= nil) then
            if this.exploreUIList ~= nil then
                this.exploreUIList:Clear();
            end
            LuaMgr.HidePanel(UIName.RogueTopBarResViewModel)
            LuaMgr.RemoveUIEventListener(UIEventConst.RogueEventType,this.CompleteEventNumber)
            LuaMgr.RemoveUIEventListener(UIEventConst.RogueSwitchMapStart,this.RogueSwitchMapStart);
            RogueExploreMgr.lastPosition=ui.tranViewContent.anchoredPosition;
        end
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_ExploreItem")
        UIListView.ClearItem("Rogue_ExploreItem2")
    end
}

this.OnBack=function()
    LuaMgr.ShowLuaPanel(UIName.RogueConfirmViewModel,ConfigMgr.LangGlobal("26222"),ConfigMgr.LangGlobal("26224"),
            ConfigMgr.LangGlobal("26223"), this.ExitExplore,this.EndExplore)
end

this.ExitExplore=function()
    LuaMgr.ShowLuaPanel(UIName.RogueMain2ViewModel)
end

this.EndExplore=function()
    RogueExploreMgr.TriggerExploreEnd(nil);
end

this.ParseData=function()
    this.mapId=RogueExploreMgr.GetCurMapID();
    SetActive(ui.goTips,false);
    local bgName=RogueExploreMgr.GetBuildingBGImgById()
    ui.rawMapBG.texture=LuaMgr.GetTexture(string.format("Images/Rogue/%s.png",bgName));
    SetActive(ui.goInfoUp,RogueExploreMgr.exploreTheme==1)
    SetActive(ui.goInfoDown,RogueExploreMgr.exploreTheme==2)
    if ConfigMgr.Config.RogueMaps[this.mapId]~=nil then
        if RogueExploreMgr.exploreTheme==1 then
            ui.txtUpTitle.text=LuaMgr.GetLangText(ConfigMgr.Config.RogueMaps[this.mapId].NameLan);
        else
            ui.txtDownTitle.text=LuaMgr.GetLangText(ConfigMgr.Config.RogueMaps[this.mapId].NameLan);
        end
    end
    this.SetMapBuildings(true);
    if RogueExploreMgr.isBattleContinue then
        RogueExploreMgr.isBattleContinue=false;
        RogueExploreMgr.isContinue=true;
    end
end
this.SetMapBuildings=function(isAni)
    local isShowBtnBuff= not IsNull(DataMgr.Player.Rogue) and not IsNull(DataMgr.Player.Rogue.GlobalBuffIds) and #DataMgr.Player.Rogue.GlobalBuffIds>0;
    SetActive(ui.btnBuff.gameObject,isShowBtnBuff)
    this.exploreUIList:Clear();
    local buildings=RogueExploreMgr.GetBuildingsByMapId();
    local list={}
    local unlockPro=0;
    for i,v in ipairs(buildings) do
        local pIsUnlock=RogueExploreMgr.CheckBuildingIsUnLock(v.EventNumber);
        local pIsDone=RogueExploreMgr.CheckBuildingIsComplete(v.EventNumber);
        local building={
            id=v.EventNumber,
            isUnlock=pIsUnlock;
            isDone=pIsDone,
            name=LuaMgr.GetLangText(v.EventNameLan),
            bigIcon=v.BigIcon,
            smallIcon=v.SmallIcon,
            callBack=this.BuildingCallBack,
            pos=Vector2(v.EventCo[1],v.EventCo[2]);
            isAnima=isAni;
            isFog=v.Fog>0;
            isUnlockAnima=not isAni and RogueExploreMgr.CheckBuildingIsCurrentUnLock(v.EventNumber,not pIsDone and pIsUnlock);
        }
        if RogueExploreMgr.exploreTheme==2 then
            building.points=RogueExploreMgr.GetBuildingLinePoints(v);
        else

            building.unLockLines=RogueExploreMgr.GetUnLockLines(v);
        end
        if not building.isDone and building.isUnlock then
            unlockPro=i;
        end
        local buildingData=nil;
        if RogueExploreMgr.exploreTheme==2 then
            building.highObj=this.renderItemHigh;
            building.grayObj=this.renderItemGray;
            buildingData=UIListData.GetData(this.exploreItemObj2,"Rogue_ExploreItem2",building);
        else
            buildingData=UIListData.GetData(this.exploreItemObj,"Rogue_ExploreItem",building);
        end
        table.insert(list,buildingData);
    end
    RogueExploreMgr.SaveLastBuildingState(list);
    this.exploreUIList:SetData(list);
    local hisIndex=this.GetCurBuildingsProIndex(buildings);
    if hisIndex>0 then
        unlockPro=hisIndex;
    end
    if unlockPro==0 then
        unlockPro=#buildings;
    end
    if unlockPro==1 then
        local eventCo=buildings[unlockPro].EventCo;
        local tarPos=Vector2(-eventCo[1],-eventCo[2]);
        ui.tranViewContent.anchoredPosition=tarPos;

    else
        if isAni and RogueExploreMgr.lastPosition~=nil then
            ui.tranViewContent.anchoredPosition=RogueExploreMgr.lastPosition;
        end
    end
end


this.UpdateMapBuilding=function()
    local buildings=RogueExploreMgr.GetBuildingsByMapId();
    local list={}
    for i,v in ipairs(buildings) do
        local pIsUnlock=RogueExploreMgr.CheckBuildingIsUnLock(v.EventNumber);
        local pIsDone=RogueExploreMgr.CheckBuildingIsComplete(v.EventNumber);
        local unLockInfo={
            isUnlock=pIsUnlock;
            isDone=pIsDone,
            isUnlockAnima= RogueExploreMgr.CheckBuildingIsCurrentUnLock(v.EventNumber,not pIsDone and pIsUnlock);
        }
        if RogueExploreMgr.exploreTheme==2 then
            unLockInfo.points=RogueExploreMgr.GetBuildingLinePoints(v);
        else

            unLockInfo.unLockLines=RogueExploreMgr.GetUnLockLines(v);
        end
        table.insert(list,unLockInfo);
    end
    for i,v in ipairs(this.exploreUIList.itemList) do
        local unLockInfo=list[i];
        v:UpdateData(unLockInfo);
    end
end

this.GetCurBuildingsProIndex=function(buildings)
    if IsNull(DataMgr.Player.Rogue) or IsNull(DataMgr.Player.Rogue.CurrentLocation) then
        return 0;
    end
    local currentLocationEventNumber=DataMgr.Player.Rogue.CurrentLocation.EventNumber
    if IsNullOrEmpty(currentLocationEventNumber) then
        return 0;
    end
    for i,v in ipairs(buildings) do
        if v.EventNumber==currentLocationEventNumber and not RogueExploreMgr.CheckBuildingIsComplete(v.EventNumber) then
            return i;
        end
    end
    return 0;
end


this.DOMoveTarPos=function(tarPos)
    DOTWeen.To(function() return ui.tranViewContent.anchoredPosition  end,function(value)
        ui.tranViewContent.anchoredPosition=value;
    end,tarPos,0.5).onComplete=function()
        
    end
end

this.BuildingCallBack=function(eventNumber)
    RogueExploreMgr.StartBuildingEvent(eventNumber);
end

this.RogueSwitchMapStart=function()
    SetActive(ui.goEffect,true);
    coroutine_runner.start(function()
        coroutine_runner.wait(1.2)
        if ui~=nil and ui.goEffect~=nil then
            SetActive(ui.goEffect,false);
        end
    end)
end

this.CompleteEventNumber=function(param)
    LuaMgr.InvokeUIEventListeners(UIEventConst.RogueUpdateTopRes)
    if param.Length>0 then
        local reData=param[0];
        if reData~=nil then
            local tipsStr=""
            if reData.EventType==6 or reData.EventType==13then
                tipsStr=ConfigMgr.LangGlobal("26209");
                this.ShowItemTips(reData.EventParams,tipsStr)
            elseif reData.EventType==8 or reData.EventType==9 then
                tipsStr=ConfigMgr.LangGlobal("26210");
                this.ShowItemTips(reData.EventParams,tipsStr)
            elseif reData.EventType==14 then
                this.SwitchNextMap();
            end
        end

        this.UpdateMapBuilding();
    end
end


this.ShowItemTips=function(eventParams,tipStr)
    LuaDebug.error(eventParams[1]);
    LuaMgr.InvokeUIEventListeners(UIEventConst.RogueEventTip,eventParams[1],eventParams[2],tipStr)
    RogueExploreMgr.CheckContinue();






















end

this.SwitchNextMap=function()
    RogueExploreMgr.UpdateMap();
    this.ParseData();
end


return vm({
    data = data,
    command = command,
    hook = hook
})
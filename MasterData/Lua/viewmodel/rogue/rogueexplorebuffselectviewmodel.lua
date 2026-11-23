require("ViewModel/Rogue/Rogue_BuffSelectItem")

local this = {
    vm = nil,
    exploreUIList={},
    exploreItemObj=nil;
    
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.Middle = uiLink:Get("Middle");
    ui.btnBag = uiLink:Get("btnBag"):GetComponent("Button");
    ui.btnRefrush = uiLink:Get("btnRefrush"):GetComponent("Button");
    ui.btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    ui.txtFrushCount = uiLink:Get("txtFrushCount"):GetComponent("Text");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.rawFrushIcon = uiLink:Get("rawFrushIcon"):GetComponent("RawImage");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBag",function()
        LuaMgr.ShowLuaPanel(UIName.RogueExploreBagViewModel)
    end)
    uiLink:AddClickEvent("btnExit",function()
        local mapId=RogueExploreMgr.GetCurMapID();
        local eventNumber=RogueExploreMgr.CurEventNumber();
        if this.curEventNumber==nil then

            mapId=nil;
            eventNumber=nil;
        end
        RogueMgr.OnAskExitCharacterOrBuff(mapId,eventNumber,function()
            LuaMgr.Back();
            RogueExploreMgr.CheckContinue();
        end)
    end)
    uiLink:AddClickEvent("btnConfrim",function()
        if this.curIndex==nil then return end;
        local buffId=this.buffIds[this.curIndex];
        local mapId=RogueExploreMgr.GetCurMapID();
        local eventNumber=RogueExploreMgr.CurEventNumber();
        if this.curEventNumber==nil then

            mapId=nil;
            eventNumber=nil;
        end
        RogueMgr.OnAskConfrimCharacterOrBUFF(mapId,eventNumber,buffId,function()
            LuaMgr.ShowLuaPanel(UIName.RogueExploreBuffInfoViewModel,buffId,function()
                LuaMgr.Back();
                RogueExploreMgr.CheckContinue();
            end);
        end)
    end)
    uiLink:AddClickEvent("btnRefrush",this.FrushBuff);
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.KZRYExploreViewModel);
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.buffUIList = UIListView.New(ui.tranContent);
        this.buffItemObj = vm.behaviour.transform:Find("template/buffItem").gameObject
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", function()
                RogueExploreMgr.ClearHandlerList()
                if this.curEventNumber==nil then

                    RogueMgr.OnAskExitCharacterOrBuff(nil,nil,function()
                        LuaMgr.Back();
                    end)
                else
                    LuaMgr.Back();
                end
            end);
            if vm.behaviour.Params.Length>0 then
                this.curEventNumber=vm.behaviour.Params[0]
            else
                this.curEventNumber=nil;
            end
            if RogueExploreMgr.selectBuffInfo.eventNumber==nil or RogueExploreMgr.selectBuffInfo.eventNumber~=this.curEventNumber then
                this.curIndex=1;
            else
                this.curIndex=RogueExploreMgr.selectBuffInfo.selectIndex;
            end
            LuaMgr.ShowLuaPanel(UIName.RogueTopBarResViewModel)
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end;
        if this.buffUIList ~= nil then
            this.buffUIList:Clear();
        end
        RogueExploreMgr.selectBuffInfo={eventNumber=this.curEventNumber,selectIndex=this.curIndex};
        LuaMgr.HidePanel(UIName.RogueTopBarResViewModel)
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_BuffSelectItem")
    end
}


this.FrushBuff=function()
    local maxCount=ConfigMgr.Config.RogueConstants.RogueBuffRefresh;
    local AddCount= RogueExploreMgr.CheckIsRefreshAddCount();
    maxCount=maxCount+AddCount;
    if this.curRefreshCount>=maxCount then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("26218"))
        return;
    end
    local mapId=RogueExploreMgr.GetCurMapID();
    local eventNumber=RogueExploreMgr.CurEventNumber();
    if this.curEventNumber==nil then

        mapId=nil;
        eventNumber=nil;
    end
    RogueMgr.OnAskRefreshCharacterOrBUFF(mapId,eventNumber,function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.RogueUpdateTopRes)
        this.CheckResultData()
    end)
end

this.CheckResultData=function()
    local reData=nil;
    if this.curEventNumber==nil then
        local curInitEvent=RogueExploreMgr.GetCurHandlerEvent();
        for i,v in ipairs(DataMgr.Player.Rogue.InitEvents) do
            if v.EventPoolRowId==curInitEvent.EventPoolRowId then
                reData=v;
                break;
            end
        end
    else
        reData=RogueExploreMgr.GetEventResultData(this.curEventNumber)
    end
    if reData.EventType==5 then
        this.buffIds=reData.EventResult
        this.curRefreshCount=reData.RefreshCount;
        if not IsNull(this.buffIds) and #this.buffIds>0 then
            this.SetBuffList();
        end
    else
        LuaDebug.error("reData is Error")
    end
end


this.ParseData=function()
    this.SetBaseInfo();
    this.CheckResultData()
end

this.SetBaseInfo=function()
    local cfgRogueConstants=ConfigMgr.Config.RogueConstants;
    local buffComp=cfgRogueConstants.RogueBuffRefreshComp;
    local refreshCost=cfgRogueConstants.RogueBuffRefreshCost;
    ui.txtFrushCount.text=string.format(LuaMgr.GetLangText("RogueExploreBuffSelectViewModel_0"),refreshCost[2])
    ui.rawFrushIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(refreshCost[1]));
    ui.txtCount.text=string.format(LuaMgr.GetLangText("RogueExploreBuffSelectViewModel_1"),buffComp[2])
    ui.rawIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(buffComp[1]));
    local isRefreshOpen=RogueExploreMgr.CheckIsOpenRefresh();
    SetActive(ui.btnRefrush.gameObject,isRefreshOpen);
end

this.SetBuffList=function()
    this.buffUIList:Clear();
    local list={}
    for i,v in ipairs(this.buffIds) do
        local cfgBuffDes=ConfigMgr.Config.RogueBuffDescMap[v]
        local buffItem={
            index=i,
            isSelect=i==this.curIndex,
            name=LuaMgr.GetLangText(cfgBuffDes.BuffNameLan),
            des=LuaMgr.GetLangText(cfgBuffDes.BuffDesLan),
            iconName=cfgBuffDes.BuffIcon,
            isPush=RogueExploreMgr.CheckBuffIsPush(v),
            isNoGet=not RogueExploreMgr.CheckBuffInBag(v),
            rare=cfgBuffDes.BuffQuality;
            callBack=this.BuffCallBack,
        }
        local buffData=UIListData.GetData(this.buffItemObj,"Rogue_BuffSelectItem",buffItem);
        table.insert(list,buffData);
    end
    this.buffUIList:SetData(list);
end

this.BuffCallBack=function(index)
    if this.curIndex~=nil and this.curIndex==index then
        return
    end
    this.curIndex=index;
    for i,v in ipairs(this.buffUIList.itemList) do
        v:SetSelect(i==this.curIndex);
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})
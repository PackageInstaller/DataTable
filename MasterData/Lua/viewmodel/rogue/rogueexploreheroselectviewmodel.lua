require("ViewModel/Rogue/Rogue_BuffHeroItem")

local this = {
    vm = nil,
    heroUIList={},
    heroItemObj=nil,
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.btnExit = uiLink:Get("btnExit"):GetComponent("Button");
    ui.btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    ui.btnBag = uiLink:Get("btnBag"):GetComponent("Button");
    ui.btnRefrush = uiLink:Get("btnRefrush"):GetComponent("Button");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.txtFrushCount = uiLink:Get("txtFrushCount"):GetComponent("Text");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");
    ui.rawFrushIcon = uiLink:Get("rawFrushIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnExit",function()
        local mapId=RogueExploreMgr.GetCurMapID();
        local eventNumber=RogueExploreMgr.CurEventNumber();
        RogueMgr.OnAskExitCharacterOrBuff(mapId,eventNumber,function()
            LuaMgr.Back();
            RogueExploreMgr.CheckContinue();
        end)
    end)
    uiLink:AddClickEvent("btnConfrim",function()
        if this.curIndex==nil then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("RogueExploreHeroSelectViewModel_0"));
            return
        end
        local heroId=this.heroIDList[this.curIndex];
        local mapId=RogueExploreMgr.GetCurMapID();
        local eventNumber=RogueExploreMgr.CurEventNumber();
        this.characterType=DataMgr.Player.Rogue.Characters[heroId]~=nil and 1 or 0
        RogueMgr.OnAskConfrimCharacterOrBUFF(mapId,eventNumber,heroId,function()
            LuaMgr.RemoveUIEventListener(UIEventConst.NewCardShowClose,this.NewCardClose);
            LuaMgr.AddUIEventListener(UIEventConst.NewCardShowClose,this.NewCardClose)
            local heroInfo=string.format("%s_%s",heroId,this.characterType);
            LuaMgr.ShowNewCardPanel(heroInfo);
            RogueExploreMgr.CheckShowCharacterExploreLevel(heroId);
        end)
    end)
    uiLink:AddClickEvent("btnRefrush",this.FrushCharacter);
    uiLink:AddClickEvent("btnBag",function()
        LuaMgr.ShowLuaPanel(UIName.RogueExploreBagViewModel);
    end)
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
        this.heroUIList = UIListView.New(ui.tranContent);
        this.heroItemObj=vm.behaviour.transform:Find("template/RogueHeroCardItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                vm.behaviour:UpdateTopBar("", function()
                    RogueExploreMgr.ClearHandlerList()
                    LuaMgr.Back();
                end);
                this.curEventNumber=vm.behaviour.Params[0];
                if RogueExploreMgr.selectHeroInfo.eventNumber==nil or RogueExploreMgr.selectHeroInfo.eventNumber~=this.curEventNumber then
                    this.curIndex=1;
                else
                    this.curIndex=RogueExploreMgr.selectHeroInfo.selectIndex;
                end
                this.ParseData();
                LuaMgr.ShowLuaPanel(UIName.RogueTopBarResViewModel)
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if (vm.behaviour.Params == nil) then return end;
        if this.heroUIList ~= nil then
            this.heroUIList:Clear();
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.NewCardShowClose,this.NewCardClose);
        RogueExploreMgr.selectHeroInfo={eventNumber=this.curEventNumber,selectIndex=this.curIndex};
        LuaMgr.HidePanel(UIName.RogueTopBarResViewModel)
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_BuffHeroItem")
    end
}

this.NewCardClose=function()
    LuaMgr.Back();
    RogueExploreMgr.CheckContinue();
end


this.FrushCharacter=function()
    local maxCount=ConfigMgr.Config.RogueConstants.RogueCharacterRefresh;
    local AddCount= RogueExploreMgr.CheckIsRefreshAddCount();
    maxCount=maxCount+AddCount;
    if this.curRefreshCount>=maxCount then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("26218"))
        return;
    end
    local mapId=RogueExploreMgr.GetCurMapID();
    local eventNumber=RogueExploreMgr.CurEventNumber();
    RogueMgr.OnAskRefreshCharacterOrBUFF(mapId,eventNumber,function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.RogueUpdateTopRes)
        this.CheckResultData()
    end)
end

this.CheckResultData=function()
    local reData=RogueExploreMgr.GetEventResultData(this.curEventNumber)
    if reData.EventType==3 then
        this.heroIDList=reData.EventResult
        this.curRefreshCount=reData.RefreshCount;
        this.SetHeroList();
    else
        LuaDebug.error("reData is Error")
    end
end

this.ParseData=function()
    this.CheckResultData();
    this.SetInfo();
end

this.SetInfo=function()
    local cfgRogueConstants=ConfigMgr.Config.RogueConstants;
    local refreshCost=cfgRogueConstants.RogueCharacterRefreshCost;
    local refreshComp=cfgRogueConstants.RogueCharacterRefreshComp;
    ui.txtFrushCount.text=string.format(LuaMgr.GetLangText("RogueExploreHeroSelectViewModel_1"),refreshCost[2])
    ui.rawFrushIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(refreshCost[1]));
    ui.txtCount.text=string.format(LuaMgr.GetLangText("RogueExploreHeroSelectViewModel_2"),refreshComp[2])
    ui.rawIcon.texture=LuaMgr.GetTexture(ConfigHelper.GetItemHomeIconPath(refreshComp[1]));
    local isRefreshOpen=RogueExploreMgr.CheckIsOpenRefresh();
    SetActive(ui.btnRefrush.gameObject,isRefreshOpen);
end

this.SetHeroList=function()
    this.heroUIList:Clear();
    this.heroList={}
    local heroData=RogueMgr.GetCharacterDatasByIDList(this.heroIDList);
    local characters=table.Copy(heroData);
    for i,v in pairs(characters) do
        local cfgCharacter=ConfigMgr.Config.characterTable[v.id];
        local rare=cfgCharacter.rare
        if not IsNull(v.brilliant) then
            rare=rare+ v.brilliant.RareLevel
        end
        v.name=LuaMgr.GetLangText(cfgCharacter.namelan);
        v.job=cfgCharacter.job;
        v.isHZ=not IsNull(v.brilliant) and rare > 4;
        v.isNoHZ=not IsNull(v.brilliant) and rare <= 4
        v.rare=rare>5 and 4 or rare;
        table.insert(this.heroList,v);
    end
    local list={}
    for i,v in pairs(this.heroList) do
        local cardItem= {
            index=i,
            id = v.id,
            data = v;
            isChoice = i==this.curIndex,
            scale=1.0,
            callback = this.HeroCallBack,
            exploreLevel=RogueExploreMgr.GetCharacterExploreLevel(v.id);
        }
        local cardData=UIListData.GetData(this.heroItemObj,"Rogue_BuffHeroItem",cardItem);
        table.insert(list,cardData);
    end
    this.heroUIList:SetData(list);
    
end

this.HeroCallBack=function(index)
    if this.curIndex~=nil and this.curIndex==index then
        return 
    end
    this.curIndex=index;
    for i,v in ipairs(this.heroUIList.itemList) do
        v:SetSelect(i==this.curIndex);
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})
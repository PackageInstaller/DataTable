require("SeasonSLG/EventPopUp/HeroHeadItem")
require("SeasonSLG/HeroChoiceModel")
local this = {
   dispatchLocUIList={};
   dispatchWorldUIList={};
   headItemObj=nil;
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
    ui.goDispatchBefore = uiLink:Get("goDispatchBefore");
    ui.goNoDispatch = uiLink:Get("goNoDispatch");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtLocProduct = uiLink:Get("txtLocProduct"):GetComponent("Text");
    ui.txtWorldProduct = uiLink:Get("txtWorldProduct"):GetComponent("Text");
    ui.txtTip = uiLink:Get("txtTip"):GetComponent("Text");
    ui.tranLocContent = uiLink:Get("tranLocContent"):GetComponent("RectTransform");
    ui.tranWorldContent = uiLink:Get("tranWorldContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.SeasonSlGEventDispatchInfoPopupViewModel)
    end)
    uiLink:AddClickEvent("btnComfrim",function()
        if #this.locHeroIdList==0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventDispatchInfoPopupViewModel_0"))
            return;
        end
        SeasonSLGAPI.OnAskDispatch(SeasonSLGEventMgr.curGridIndex,this.dispatchLocId,this.dispatchWorldId,this.locHeroIdList,this.worldHeroIdList,
                function() LuaMgr.HidePanel(UIName.SeasonSlGEventDispatchInfoPopupViewModel)
        end)
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.dispatchLocUIList=UIListView.New(ui.tranLocContent)
        this.dispatchWorldUIList=UIListView.New(ui.tranWorldContent);
        this.headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            this.dispatchLocId=vm.behaviour.Params[0];
            this.dispatchWorldId=vm.behaviour.Params[1];
            this.worldProgress=vm.behaviour.Params[2]
            this.guildName=vm.behaviour.Params[3]
            this.dispatchCfgLoc=ConfigMgr.Config.SeasonalGridGuardMap[this.dispatchLocId]
            this.dispatchCfgWorld=ConfigMgr.Config.SeasonalGridGuardMap[this.dispatchWorldId]
            this.locHeroIdList={};
            this.worldHeroIdList={};
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.dispatchLocUIList:Clear();
        this.dispatchWorldUIList:Clear();
        if this.HeroChoiceModel~=nil then
            this.HeroChoiceModel:Clear();
        end
    end,
    before_destroy = function()
        UIListView.ClearItem("HeroHeadItem")
        if this.HeroChoiceModel~=nil then
            this.HeroChoiceModel:Destroy();
        end
        this.ClearUI();
    end
}


this.ParseData=function()
    this.IsCanWorldDispatch=this.worldProgress<this.dispatchCfgWorld.WorldNum
    ui.txtTitle.text=ConfigMgr.LangGlobal(this.dispatchCfgLoc.Title)
    SetActive(ui.goDispatchBefore,false);
    SetActive(ui.goNoDispatch, not this.IsCanWorldDispatch);
    if not this.IsCanWorldDispatch then
        local guidName=""
        if not IsNull(this.guildName) then
            guidName=this.guildName;
        end
        ui.txtTip.text=string.format(LuaMgr.GetLangText("SeasonSlGEventDispatchInfoPopupViewModel_1"),guidName);
    end
    this.otherFitterList=SeasonSLGEventMgr.GetDispatchHeroList(tostring(SeasonSLGEventMgr.curGridIndex));
    local dispatchData=SeasonSLGEventMgr.GetDispatchData(SeasonSLGEventMgr.curGridIndex);
    if dispatchData~=nil then
        if #dispatchData.Members1>0 then
            this.locHeroIdList=dispatchData.Members1;
        end
        if not IsNull(dispatchData.Members2) and #dispatchData.Members2>0 then
            this.worldHeroIdList=dispatchData.Members2;
        end
    end
    this.SetDispatchLocUIList();
    this.SetDispatchWorldUIList();
end

this.SetDispatchAddInfo=function()
    local produce1,addRate1=nil,0;
    local produce2,addRate2=nil,0;
    produce1,addRate1=SeasonSLGMapMgr.GetDispatchGroupProduceInfo(this.dispatchLocId,this.locHeroIdList,"",{})
    produce2,addRate2=SeasonSLGMapMgr.GetDispatchGroupProduceInfo("",{},this.dispatchWorldId,this.worldHeroIdList)
    local addRate1Str=string.format("%.f",addRate1);
    local addRate2Str=string.format("%.f",addRate2);
    ui.txtLocProduct.text=string.format(LuaMgr.GetLangText("SeasonSlGEventDispatchInfoPopupViewModel_2"),addRate1Str)
    ui.txtWorldProduct.text=string.format(LuaMgr.GetLangText("SeasonSlGEventDispatchInfoPopupViewModel_3"),addRate2Str)
end


this.FormatHeroDataList=function(heroIDList)
    local list={};
    for i,v in ipairs(heroIDList) do
        local heroInfo={
            id=v,
            level=DataMgr.Player.characters[v]~=nil and DataMgr.Player.characters[v].level or 1,
            sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(v),
        }
        table.insert(list,heroInfo);
    end
    return list;
end

this.SetDispatchLocUIList=function()
    this.dispatchLocUIList:Clear();
    local heroDataList=this.FormatHeroDataList(this.locHeroIdList);
    local list=this.GetHeroItems(heroDataList,this.dispatchCfgLoc.Count,this.LocHeroCallBack)
    this.dispatchLocUIList:SetData(list);
    this.SetDispatchAddInfo();
end

this.SetDispatchWorldUIList=function()
    this.dispatchWorldUIList:Clear();
    local heroDataList=this.FormatHeroDataList(this.worldHeroIdList);
    local list=this.GetHeroItems(heroDataList,this.dispatchCfgWorld.Count,this.WorldHeroCallBack)
    this.dispatchWorldUIList:SetData(list);
    this.SetDispatchAddInfo();
end

this.GetHeroItems=function(heroList,maxCount,upCallBack)
    local list={}
    for i=1,maxCount  do
        local heroItem={index=i,callBack=upCallBack};
        if i<=#heroList then
            local cfgHero=ConfigMgr.Config.characterTable[heroList[i].id]
            if cfgHero~=nil then
                heroItem={
                    index=i,
                    id=heroList[i].id,
                    rare=HeroMgr.GetHeroNowRare(heroList[i].id),
                    job=cfgHero.job,
                    name=LuaMgr.GetLangText(cfgHero.namelan),
                    level=heroList[i].level,
                    callBack=upCallBack,
                    sLevel=heroList[i].sLevel,
                }
            end
        end
        local heroData=UIListData.GetData(this.headItemObj,"HeroHeadItem",heroItem);
        table.insert(list,heroData);
    end
    return list;
end

this.LocHeroCallBack=function()
    this.ShowHeroChoicePanel(this.locHeroIdList,function(newHeroIdList)
        this.locHeroIdList=newHeroIdList;
        this.SetDispatchLocUIList();
    end,1,this.worldHeroIdList)
end

this.WorldHeroCallBack=function()
    if not this.IsCanWorldDispatch then return end;
    this.ShowHeroChoicePanel(this.worldHeroIdList,function(newHeroIdList)
       this.worldHeroIdList=newHeroIdList;
       this.SetDispatchWorldUIList();
    end,2,this.locHeroIdList)
end

this.ShowHeroChoicePanel=function(heroIDList,upCallBack,type,fitterIDList)
    local otherFitterList=table.Copy(this.otherFitterList)
    for i,v in ipairs(fitterIDList) do
        table.insert(otherFitterList,v);
    end
    SetActive(ui.goDispatchBefore,true);
    if this.HeroChoiceModel==nil then
        this.HeroChoiceModel=HeroChoiceModel.New(ui.goDispatchBefore.transform);
    end
    this.HeroChoiceModel:SetData(heroIDList,upCallBack,otherFitterList)
    if this.formatType==nil or this.formatType~=type then
        this.formatType=type;
        this.HeroChoiceModel:PlayAnimation();
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})
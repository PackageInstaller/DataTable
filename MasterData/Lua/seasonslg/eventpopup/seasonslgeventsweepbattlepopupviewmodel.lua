
local this = {

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
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnConfirm = uiLink:Get("btnConfirm"):GetComponent("Button");
    ui.btnSkip = uiLink:Get("btnSkip"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.txtMonsterCount = uiLink:Get("txtMonsterCount"):GetComponent("Text");
    ui.txtProgress = uiLink:Get("txtProgress"):GetComponent("Text");
    ui.sliderSweep = uiLink:Get("sliderSweep"):GetComponent("Slider");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.SeasonSlGEventSweepBattlePopupViewModel)
    end)
    uiLink:AddClickEvent("btnConfirm",function()
        SeasonSLGAPI.OnAskSeasonalSweep(SeasonSLGEventMgr.curGridIndex,this.sweepId,this.sweepCount,this.heroIDList,function()
            SeasonSLGMapMgr.UpdateMapGridState();
            LuaMgr.HidePanel(UIName.SeasonSlGEventSweepBattlePopupViewModel)
        end)
    end)

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.mySpine = vm.behaviour.transform:Find("root/Middle/spines/mySpine/spine"):GetComponent("UISpineCharacter");
        this.monsterSpine = vm.behaviour.transform:Find("root/Middle/spines/monsteSpine/spine"):GetComponent("UISpineCharacter");
        this.rewardItemList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>5 then
            this.sweepId=vm.behaviour.Params[0];
            this.sweepCount=vm.behaviour.Params[1];
            this.heroIDList=vm.behaviour.Params[2];
            this.rewardList=vm.behaviour.Params[3];
            this.progressValue=vm.behaviour.Params[4]
            this.monsterCount=vm.behaviour.Params[5]
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.ClearReward();
    end,
    before_destroy = function()
        this.ClearUI();

    end
}

this.ParseData=function()
    ui.txtCount.text=string.format(LuaMgr.GetLangText("SeasonSlGEventSweepBattlePopupViewModel_0"),this.sweepCount);
    ui.txtMonsterCount.text="";
    ui.txtProgress.text=string.format("%.f%%",this.progressValue*100);
    ui.sliderSweep.value=this.progressValue;
    this.cfgSweep=ConfigMgr.Config.SeasonalEventSweepMap[this.sweepId];
    ui.txtMonsterCount.text=this.monsterCount;
    this.SetSpines();
    this.SetRewards();
end

this.SetSpines=function()

    local randomIndex=RandomNum(1,#this.heroIDList)
    local myCharacterId=this.heroIDList[randomIndex];
    this.mySpine:SetBattle(myCharacterId,myCharacterId.."001","-1",0);
    local monsterId="CV00601"
    local monsterSpines=SeasonSLGMapMgr.Constants().SeasonalEventSweepMonsterSpines;
    if monsterSpines~=nil then
        randomIndex=RandomNum(1,#monsterSpines)
        monsterId=monsterSpines[randomIndex];
    end
    this.monsterSpine:SetBattle(monsterId,monsterId.."001","-1",0);
end

this.SetRewards=function()
    this.ClearReward();
    for i,v in ipairs(this.rewardList) do
        if this.rewardItemList[i]==nil then
            this.rewardItemList[i]=GoodsDataItem.New(ui.tranRewardContent)
        end
        local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemData.count0 = v.count*this.sweepCount;
        SetActive(this.rewardItemList[i].gameObject,true);
        this.rewardItemList[i]:SetData(1, itemData, 1, false, Vector3(0.5,0.5,0.5), false);
    end
end

this.ClearReward=function()
    if NumTool.GetLen(this.rewardItemList)>0 then
        for i,v in pairs(this.rewardItemList) do
            SetActive(v.gameObject,false);
        end
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})
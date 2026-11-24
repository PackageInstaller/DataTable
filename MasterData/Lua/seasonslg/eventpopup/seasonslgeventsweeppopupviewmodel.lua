require("SeasonSLG/EventPopUp/HeroHeadItem")
require("SeasonSLG/HeroChoiceModel")
local this = {
   sweepCount=nil;
   heroUIList={};
   heroItemObj=nil;
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
    ui.goHeroChoicePanel = uiLink:Get("goHeroChoicePanel");
    ui.goGou = uiLink:Get("goGou");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button");
    ui.btnAdd = uiLink:Get("btnAdd"):GetComponent("Button");
    ui.btnMax = uiLink:Get("btnMax"):GetComponent("Button");
    ui.btnConfirm = uiLink:Get("btnConfirm"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtTip = uiLink:Get("txtTip"):GetComponent("Text");
    ui.txtProgress = uiLink:Get("txtProgress"):GetComponent("Text");
    ui.txtMonterCount = uiLink:Get("txtMonterCount"):GetComponent("Text");
    ui.txtPower = uiLink:Get("txtPower"):GetComponent("Text");
    ui.txtCur = uiLink:Get("txtCur"):GetComponent("Text");
    ui.txtRemain = uiLink:Get("txtRemain"):GetComponent("Text");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.sliderSweep = uiLink:Get("sliderSweep"):GetComponent("Slider");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.SeasonSlGEventSweepPopupViewModel)
    end)
    uiLink:AddClickEvent("btnConfirm",function()
        if #this.heroIDList<this.sweepCfg.CharacterNum then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("SeasonSlGEventSweepPopupViewModel_0"),this.sweepCfg.CharacterNum));
            return
        end
        if this.sweepCount==0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventSweepPopupViewModel_1"))
            return
        end
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventSweepBattlePopupViewModel,this.sweepId,this.sweepCount,this.heroIDList,this.rewardList,
                this.progressValue,this.maxMonsterCount-this.curRemainMonsterCount)
        LuaMgr.HidePanel(UIName.SeasonSlGEventSweepPopupViewModel)
    end)
    uiLink:AddClickEvent("btnMax",function()
       this.sweepCount=this.powerMaxCount;
        this.SetCountText()
    end)
    uiLink:AddClickEvent("btnAdd",function()
        LuaMgr.ShowLuaPanel(UIName.SeasonSLGFatigueReplyViewModel)
    end)

end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.addUINumber = vm.behaviour.transform:Find("root/Right/Cost/buttons/AddBtn"):GetComponent("UIAddNumber");
        this.lessenUINumber =vm.behaviour.transform:Find("root/Right/Cost/buttons/lessenBtn"):GetComponent("UIAddNumber");
        this.heroUIList=UIListView.New(ui.tranContent)
        this.heroItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
        this.UINumberBinder();
        this.rewardItemList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>0 then
            LuaMgr.AddUIEventListener(UIEventConst.FatigueReply,this.UpdatePower);
            this.sweepId=vm.behaviour.Params[0];
            this.sweepCfg=ConfigMgr.Config.SeasonalEventSweepMap[this.sweepId];
            this.progressValue=0;
            this.sweepCount=0;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.FatigueReply, this.UpdatePower)
        this.heroUIList:Clear();
        this.ClearReward();
        if this.HeroChoiceModel~=nil then
            this.HeroChoiceModel:Clear();
        end
        SetActive(ui.goHeroChoicePanel,false);
    end,
    before_destroy = function()
        UIListView.ClearItem("HeroHeadItem")
        this.ClearUI();
        if this.HeroChoiceModel~=nil then
            this.HeroChoiceModel:Destroy();
        end
    end
}


this.UINumberBinder=function()
    this.addUINumber.Callback=function(data,delta,current)
        this.SetSweepCount(1)
    end
    this.lessenUINumber.Callback=function(data,delta,current)
        this.SetSweepCount(-1)
    end

end

this.SetSweepCount=function(dir)
    this.sweepCount=this.sweepCount+dir;
    if this.sweepCount<1 then
        this.sweepCount=1;
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventSweepPopupViewModel_2"))
    end
    if this.sweepCount>this.maxCount then
        this.sweepCount=this.maxCount
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventSweepPopupViewModel_3"))
    elseif this.sweepCount>this.powerMaxCount then
        this.sweepCount=this.powerMaxCount
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventSweepPopupViewModel_4"))
    end;
    this.SetCountText()
end

this.SetProgress=function()
    this.curPro = this.historyValue+this.sweepCfg.StartSweep + this.sweepCfg.BaseSweep * this.sweepCount
    local value = this.curPro / this.sweepCfg.MaxSweep
    value=value>1.0 and 1.0 or value;
    this.progressValue=value;
    this.curRemainMonsterCount=math.floor(this.sweepCfg.MonsterNum*(1-this.progressValue));
    ui.txtMonterCount.text=this.curRemainMonsterCount;
    ui.txtProgress.text = string.format("%.1f%%", value * 100)
    ui.sliderSweep.value=value;
    local myPower=DataHelper.GetItemCountById(this.sweepCfg.Consume[1].id)
    local remainPower=myPower-this.sweepCfg.Consume[1].count*this.sweepCount;
    ui.txtCur.text=myPower;
    ui.txtRemain.text=math.floor(remainPower);
end

this.SetCountText=function()
    this.SetProgress();
    this.SetRewards();
    ui.txtCount.text=this.sweepCount;
end

this.UpdatePower=function()
    this.ParseData(true)
end

this.ParseData=function(isUpdatePower)
    ui.txtPower.text=this.sweepCfg.CharacterNum;
    ui.txtTitle.text=ConfigMgr.LangGlobal(this.sweepCfg.Name)
    ui.txtTip.text=ConfigMgr.LangGlobal(this.sweepCfg.Desc)
    this.historyValue=0;
    local dataGrid=DataMgr.Player.SeasonalGrid[tostring(SeasonSLGEventMgr.curGridIndex)];
    this.historyValue=dataGrid~=nil and dataGrid.Sweep or 0;
    this.maxSweep=this.sweepCfg.MaxSweep-this.historyValue;
    this.maxCount=math.ceil((this.maxSweep-this.sweepCfg.StartSweep)/this.sweepCfg.BaseSweep)
    local myPower=DataHelper.GetItemCountById(this.sweepCfg.Consume[1].id);
    this.powerMaxCount=math.floor(myPower/this.sweepCfg.Consume[1].count);
    this.powerMaxCount=this.powerMaxCount>this.maxCount and this.maxCount or this.powerMaxCount;
    this.sweepCount=this.powerMaxCount<1 and 0 or 1;

    local pro = this.historyValue+this.sweepCfg.StartSweep
    local proValue = pro / this.sweepCfg.MaxSweep
    proValue=proValue>1.0 and 1.0 or proValue;
    this.maxMonsterCount=math.floor(this.sweepCfg.MonsterNum*(1-proValue));
    this.SetCountText()
    if isUpdatePower then return end;
    this.UpdateHeroList();
end

this.GetHeroList=function()
    local list={};
    for i,v in ipairs(this.heroIDList) do
        local heroInfo={
            id=v,
            level=DataMgr.Player.characters[v]~=nil and DataMgr.Player.characters[v].level or 1,
            sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(v),
            rare= HeroMgr.GetHeroNowRare(v);
        }
        table.insert(list,heroInfo);
    end
    return list;
end

this.UpdateHeroList=function(list)
    this.heroIDList=list==nil and {} or list;
    this.heroList=this.GetHeroList();
    SetActive(ui.goGou,#this.heroList>=this.sweepCfg.CharacterNum);

    this.levelItem=nil;

    this.sLevelItem=nil;

    this.rareItem=nil;
    for i,v in ipairs(this.heroList) do
        local level_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.sweepCfg.ExtraLevel,v.level);
        local level_s_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.sweepCfg.ExtraSeasonalLevel,v.sLevel);
        local level_rare_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.sweepCfg.Rare,v.rare)
        if level_rewardIndex>0 then
            local item=this.sweepCfg.ExtraLevelReward[level_rewardIndex]
            if this.levelItem==nil then
                this.levelItem={id=item.id,count=0};
            end
            this.levelItem.count=this.levelItem.count+item.count;
        end
        if level_s_rewardIndex>0 then
            local item=this.sweepCfg.ExtraSeasonalLevelReward[level_s_rewardIndex]
            if this.sLevelItem==nil then
                this.sLevelItem={id=item.id,count=0};
            end
            this.sLevelItem.count=this.sLevelItem.count+item.count;
        end
        if level_rare_rewardIndex>0 then
            local item=this.sweepCfg.RareReward[level_rare_rewardIndex]
            if this.rareItem==nil then
                this.rareItem={id=item.id,count=0};
            end
            this.rareItem.count=this.rareItem.count+item.count;
        end
    end
    this.SetHeroUIList();
    this.SetRewards();
end

this.SetHeroUIList=function()
    this.heroUIList:Clear();
    local list={}
    for i=1,6  do
        local heroItem={index=i,callBack=this.HeroCallBack};
        if i<=#this.heroList then
            local cfgHero=ConfigMgr.Config.characterTable[this.heroList[i].id]
            if cfgHero~=nil then
                heroItem={
                    index=i,
                    id=this.heroList[i].id,
                    rare=HeroMgr.GetHeroNowRare(this.heroList[i].id),
                    job=cfgHero.job,
                    name=LuaMgr.GetLangText(cfgHero.namelan),
                    level=this.heroList[i].level,
                    callBack=this.HeroCallBack,
                    sLevel=this.heroList[i].sLevel,
                }
            end
        end
        local heroData=UIListData.GetData(this.heroItemObj,"HeroHeadItem",heroItem);
        table.insert(list,heroData);
    end
    this.heroUIList:SetData(list);
end


this.HeroCallBack=function(index)

    SetActive(ui.goHeroChoicePanel,true);
    if this.HeroChoiceModel==nil then
        this.HeroChoiceModel=HeroChoiceModel.New(ui.goHeroChoicePanel.transform);
    end
    this.HeroChoiceModel:SetData(this.heroIDList,this.UpdateHeroList)
end

this.SetRewards=function()
    this.ClearReward();
    local countProgress=math.floor(this.curPro/this.sweepCfg.SweepProgress)
    local rewardList={}
    for i,v in ipairs(this.sweepCfg.Reward) do
        local item={
            id=v.id,
            count=v.count
        }
        table.insert(rewardList,item);
    end
    if this.levelItem~=nil then
        table.insert(rewardList,this.levelItem)
    end
    if this.sLevelItem~=nil then
        table.insert(rewardList,this.sLevelItem);
    end
    if this.rareItem~=nil then
        table.insert(rewardList,this.rareItem);
    end
    this.rewardList=rewardList;
    for i,v in ipairs(rewardList) do
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
    this.rewardList={};
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
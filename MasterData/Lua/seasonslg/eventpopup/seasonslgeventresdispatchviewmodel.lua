require("SeasonSLG/EventPopUp/HeroHeadItem")
require("SeasonSLG/HeroChoiceModel")
local this = {
   dispatchLocUIList={};
   headItemObj=nil;
};

local ui = {}

this.InitUI = function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua")
    ui.root = uiLink:Get("root")
    ui.Middle = uiLink:Get("Middle")
    ui.Left = uiLink:Get("Left")
    ui.Right = uiLink:Get("Right")
    ui.goNoDispatch = uiLink:Get("goNoDispatch")
    ui.goDispatchBefore = uiLink:Get("goDispatchBefore")
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button")
    ui.btnAdd = uiLink:Get("btnAdd"):GetComponent("Button")
    ui.btnMax = uiLink:Get("btnMax"):GetComponent("Button")
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button")
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button")
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text")
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text")
    ui.txtDispatchName = uiLink:Get("txtDispatchName"):GetComponent("Text")
    ui.txtLocProduct = uiLink:Get("txtLocProduct"):GetComponent("Text")
    ui.txtLocHeroCount = uiLink:Get("txtLocHeroCount"):GetComponent("Text")
    ui.txtLocSeasonLevel = uiLink:Get("txtLocSeasonLevel"):GetComponent("Text")
    ui.txtTip = uiLink:Get("txtTip"):GetComponent("Text")
    ui.txtCur = uiLink:Get("txtCur"):GetComponent("Text")
    ui.txtRemain = uiLink:Get("txtRemain"):GetComponent("Text")
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text")
    ui.text = uiLink:Get("text"):GetComponent("Text")
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect")
    ui.tranLocContent = uiLink:Get("tranLocContent"):GetComponent("RectTransform")
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform")
    ui.rawImageLocIcon = uiLink:Get("rawImageLocIcon"):GetComponent("RawImage")

    this.AddRegister(uiLink)
end

this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventResDispatchViewModel)
    end)
    uiLink:AddClickEvent("btnAdd",function()
        LuaMgr.ShowLuaPanel(UIName.SeasonSLGFatigueReplyViewModel)
    end)
    uiLink:AddClickEvent("btnHelp",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_0"))
    end)
    uiLink:AddClickEvent("btnMax",function()
       this.dispatchCount=this.powerMaxCount;
        this.SetCountText()
        this.SetRewardUIList()
    end)
    uiLink:AddClickEvent("btnComfrim",function()
        if #this.locHeroIdList==0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_1"))
            return;
        end
        if this.dispatchCount==0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_2"))
            return;
        end
        SeasonSLGAPI.OnAskResourceDispatch(tostring(SeasonSLGEventMgr.curGridIndex),this.resId,this.dispatchCount,this.locHeroIdList,
                function()
                    LuaMgr.HidePanel(UIName.SeasonSlGEventResDispatchViewModel)

        end)
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.dispatchLocUIList=UIListView.New(ui.tranLocContent)
        this.headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
        this.addUINumber = vm.behaviour.transform:Find("root/Right/Cost/buttons/AddBtn"):GetComponent("UIAddNumber");
        this.lessenUINumber =vm.behaviour.transform:Find("root/Right/Cost/buttons/lessenBtn"):GetComponent("UIAddNumber");
        this.UINumberBinder();
        this.rewardItemList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            LuaMgr.AddUIEventListener(UIEventConst.FatigueReply,this.UpdatePower);
            this.resId=vm.behaviour.Params[0];
            this.curProgress=vm.behaviour.Params[1].Progress
            this.cfgGirdRes=ConfigMgr.Config.SeasonalGridResourceMap[this.resId];
            this.locHeroIdList={};
            this.dispatchCount=1;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.FatigueReply, this.UpdatePower)
        this.ClearRewardItem();
        this.dispatchLocUIList:Clear();
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

this.UpdatePower=function()
    this.ParseData(true)
end
this.UINumberBinder=function()
    this.addUINumber.Callback=function(data,delta,current)
        this.SetDispatchCount(1)
    end
    this.lessenUINumber.Callback=function(data,delta,current)
        this.SetDispatchCount(-1)
    end
end

this.ParseData=function(isUpdatePower)
    SetActive(ui.goDispatchBefore,false);
    this.dataResLevel=SeasonSLGEventMgr.GetGridResLevel(SeasonSLGEventMgr.curGridIndex);
    local resLevelId=this.cfgGirdRes.Level[this.dataResLevel];
    this.cfgCurResLevel =ConfigMgr.Config.SeasonalGridResourceLevelMap[resLevelId]
    this.dispatchLocId=this.cfgCurResLevel.Id;
    ui.txtTitle.text=ConfigMgr.LangGlobal(this.cfgGirdRes.Name);
    ui.txtDes.text=ConfigMgr.LangGlobal(this.cfgGirdRes.GridDesc);

    this.maxCount=this.cfgGirdRes.WorldNum-this.curProgress;
    local myPower=DataHelper.GetItemCountById(this.cfgGirdRes.ConsumeDispatch[1].id);
    myPower=math.floor(myPower/this.cfgGirdRes.ConsumeDispatch[1].count);
    this.powerMaxCount=myPower>this.maxCount and this.maxCount or myPower;
    this.dispatchCount=this.powerMaxCount>0 and 1 or 0;
    this.SetCountText();
    SetActive(ui.goNoDispatch,false);
    if isUpdatePower then
        return;
    end
    this.SetDispatchLocUIList();
end

this.SetDispatchCount=function(dir)
    this.dispatchCount=this.dispatchCount+dir;
    if this.dispatchCount<1 then
        this.dispatchCount=1;
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_3"))
    end
    if this.dispatchCount>this.maxCount then
        this.dispatchCount=this.maxCount
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_4"))
    elseif this.dispatchCount>this.powerMaxCount then
        this.dispatchCount=this.powerMaxCount
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_5"))
    end;
    this.SetCountText()
    this.SetRewardUIList();
end

this.SetCountText=function()
    local myPower=DataHelper.GetItemCountById(this.cfgGirdRes.ConsumeDispatch[1].id);
    local remainPower=myPower-this.cfgGirdRes.ConsumeDispatch[1].count*this.dispatchCount;
    ui.txtCur.text=myPower;
    ui.txtRemain.text=math.floor(remainPower);
    ui.txtCount.text=this.dispatchCount;
end

this.UpdateDispatchAddInfo=function(heroDataList)
    local tableCount = this.GetProduceTableCount(heroDataList)
    local produceItem = this.cfgCurResLevel.ProduceSweep[1]
    local additionRate = this.GetBuffRate(produceItem.id) / 100
    local totalCount = tableCount * (1 + additionRate / 100)
    ui.txtLocProduct.text=string.format(LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_6"), totalCount, additionRate)
    ui.txtLocHeroCount.text = string.format(LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_7"), this.cfgCurResLevel.MinCard)
    ui.txtLocSeasonLevel.text = string.format(LuaMgr.GetLangText("SeasonSlGEventResDispatchViewModel_8"), this.cfgCurResLevel.MinLevel)
    ui.rawImageLocIcon.texture = GetItemTexture(produceItem.id)
    this.SetRewardUIList()
end



this.GetProduceTableCount = function(heroDataList)

    this.levelItem=nil;

    this.sLevelItem=nil;

    this.rareLevelItem=nil;
    for i,v in ipairs(heroDataList) do
        local level_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.cfgCurResLevel.ExtraLevel,v.level);
        local level_s_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.cfgCurResLevel.ExtraSeasonalLevel,v.sLevel);
        local level_rare_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.cfgCurResLevel.Rare,v.rare)
        if level_rewardIndex>0 then
            local item=this.cfgCurResLevel.ExtraLevelReward[level_rewardIndex]
            if this.levelItem==nil then
                this.levelItem={id=item.id,count=0};
            end
            this.levelItem.count=this.levelItem.count+item.count;
        end
        if level_s_rewardIndex>0 then
            local item=this.cfgCurResLevel.ExtraSeasonalLevelReward[level_s_rewardIndex]
            if this.sLevelItem==nil then
                this.sLevelItem={id=item.id,count=0};
            end
            this.sLevelItem.count=this.sLevelItem.count+item.count;
        end
        if level_rare_rewardIndex>0 then
            local item=this.cfgCurResLevel.RareReward[level_rare_rewardIndex]
            if this.rareLevelItem==nil then
                this.rareLevelItem={id=item.id,count=0};
            end
            this.rareLevelItem.count=this.rareLevelItem.count+item.count;
        end
    end
    local addCount=0;
    if this.levelItem~=nil then
        addCount=addCount+this.levelItem.count;
    end
    if this.sLevelItem~=nil then
        addCount=addCount+this.sLevelItem.count;
    end
    if this.rareLevelItem~=nil then
        addCount=addCount+this.rareLevelItem.count;
    end
    return addCount
end

this.GetBuffRate = function(id)
    local _, produceDic = SeasonSLGMapMgr.GetActiveProduceBuff()
    return produceDic[id] or 0
end

this.FormatHeroDataList=function(heroIDList)
    local list={};
    for i,v in ipairs(heroIDList) do
        local heroInfo={
            id=v,
            level=DataMgr.Player.characters[v]~=nil and DataMgr.Player.characters[v].level or 1,
            sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(v),
            rare=HeroMgr.GetHeroNowRare(v);
        }
        table.insert(list,heroInfo);
    end
    return list;
end

this.SetDispatchLocUIList=function()
    this.dispatchLocUIList:Clear();
    local heroDataList=this.FormatHeroDataList(this.locHeroIdList);
    local list=this.GetHeroItems(heroDataList,this.cfgGirdRes.CountDispatch,this.LocHeroCallBack)
    this.dispatchLocUIList:SetData(list);
    this.UpdateDispatchAddInfo(heroDataList);
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
    end,1)
end

this.ShowHeroChoicePanel=function(heroIDList,upCallBack,type)
    local fitterIDList=SeasonSLGEventMgr.GetDispatchHeroList(SeasonSLGEventMgr.curGridIndex);
    SetActive(ui.goDispatchBefore,true);
    if this.HeroChoiceModel==nil then
        this.HeroChoiceModel=HeroChoiceModel.New(ui.goDispatchBefore.transform);
    end
    this.HeroChoiceModel:SetData(heroIDList,upCallBack,fitterIDList)
    if this.formatType==nil or this.formatType~=type then
        this.formatType=type;
        this.HeroChoiceModel:PlayAnimation();
    end
end

this.SetRewardUIList=function()
    this.ClearRewardItem();
    local rewardList={}
    for i,v in ipairs(this.cfgCurResLevel.ProduceSweep) do
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
    if this.rareLevelItem~=nil then
        table.insert(rewardList,this.rareLevelItem);
    end
    if IsNull(rewardList) or #rewardList==0 then
       return
    end;
    local rewardCount=this.dispatchCount==0 and 1 or this.dispatchCount;
    for i,v in ipairs(rewardList) do
        if this.rewardItemList[i]==nil then
            this.rewardItemList[i]=GoodsDataItem.New(ui.tranRewardContent)
        end
        local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemData.count0 = v.count*rewardCount;
        SetActive(this.rewardItemList[i].gameObject,true);
        this.rewardItemList[i]:SetData(1, itemData, 1, false, Vector3(0.5,0.5,0.5), false);
    end
end

this.ClearRewardItem=function()
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
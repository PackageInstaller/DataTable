require("SeasonSLG/EventPopUp/HeroHeadItem")
require("SeasonSLG/HeroChoiceModel")
require("SeasonSLG/EventPopUp/EventTimeRewardItem")
require("SeasonSLG/EventPopUp/EventTimeRewardBuffItem")
require("SeasonSLG/EventPopUp/BlockTopRankCom")
require("SeasonSLG/EventPopUp/SeasonSLGTopRankRewardCom")
local this = {
   dispatchLocUIList={};
   headItemObj=nil;
   rewardUIList={};
   rewardItemObj=nil;
   produceUIList={};
   produceItemObj=nil;
   topRankUIList={};
   topRankItemObj=nil;
};

local ui = {}

this.InitUI = function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua")
    ui.root = uiLink:Get("root")
    ui.goods = uiLink:Get("goods")
    ui.Middle = uiLink:Get("Middle")
    ui.Left = uiLink:Get("Left")
    ui.Right = uiLink:Get("Right")
    ui.goDispatchBefore = uiLink:Get("goDispatchBefore")
    ui.goDispatchTime = uiLink:Get("goDispatchTime")
    ui.goDispatching = uiLink:Get("goDispatching")
    ui.gotopRank = uiLink:Get("gotopRank")
    ui.gotopRankReward = uiLink:Get("gotopRankReward")
    ui.goScrollView = uiLink:Get("goScrollView")
    ui.goProgress = uiLink:Get("goProgress")
    ui.goformationLoc = uiLink:Get("goformationLoc")
    ui.goActiveSelf = uiLink:Get("goActiveSelf")
    ui.goActiveAll = uiLink:Get("goActiveAll")
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button")
    ui.btnComfrim = uiLink:Get("btnComfrim"):GetComponent("Button")
    ui.btnRank = uiLink:Get("btnRank"):GetComponent("Button")
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button")
    ui.btnSelf = uiLink:Get("btnSelf"):GetComponent("Button")
    ui.btnAll = uiLink:Get("btnAll"):GetComponent("Button")
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text")
    ui.txtDispatchLeftTime = uiLink:Get("txtDispatchLeftTime"):GetComponent("Text")
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text")
    ui.txtProgressValue = uiLink:Get("txtProgressValue"):GetComponent("Text")
    ui.txtProgressAdd = uiLink:Get("txtProgressAdd"):GetComponent("Text")
    ui.txtDispatchName = uiLink:Get("txtDispatchName"):GetComponent("Text")
    ui.txtLocProduct = uiLink:Get("txtLocProduct"):GetComponent("Text")
    ui.txtLocHeroCount = uiLink:Get("txtLocHeroCount"):GetComponent("Text")
    ui.txtLocSeasonLevel = uiLink:Get("txtLocSeasonLevel"):GetComponent("Text")
    ui.txtRewardDes = uiLink:Get("txtRewardDes"):GetComponent("Text")
    ui.txtRewardDes1 = uiLink:Get("txtRewardDes1"):GetComponent("Text")
    ui.scrollViewContent = uiLink:Get("scrollViewContent"):GetComponent("ScrollRect")
    ui.tranTopRank = uiLink:Get("tranTopRank"):GetComponent("RectTransform")
    ui.tranTopRankReward = uiLink:Get("tranTopRankReward"):GetComponent("RectTransform")
    ui.tranLocContent = uiLink:Get("tranLocContent"):GetComponent("RectTransform")
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform")
    ui.tranProduceContent = uiLink:Get("tranProduceContent"):GetComponent("RectTransform")
    ui.imgProgress = uiLink:Get("imgProgress"):GetComponent("Image")
    ui.animatorProgress = uiLink:Get("animatorProgress"):GetComponent("Animator")
    ui.txtCostEnergy = uiLink:Get("txtCostEnergy"):GetComponent("Text")
    ui.rawImageLocIcon = uiLink:Get("rawImageLocIcon"):GetComponent("RawImage")
    ui.txtLocation=uiLink:Get("txtLocation"):GetComponent("Text")
    this.AddRegister(uiLink)
end

this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventLimitDispatchViewModel)
    end)
    uiLink:AddClickEvent("btnHelp",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_0"))
    end)
    uiLink:AddClickEvent("btnRank",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_1"))
    end)
    uiLink:AddClickEvent("btnSelf",function()
        this.SwitchRewardType(1)
    end)
    uiLink:AddClickEvent("btnAll",function()
        this.SwitchRewardType(2)
    end)
    uiLink:AddClickEvent("btnComfrim",function()
        if not SeasonSLGMapMgr.CheckBlockIsUnLock(tostring(SeasonSLGEventMgr.curGridIndex),SeasonSLGMapMgr.CheckTriggerEventCoverByTime()) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_2"));
            return;
        end
        if this.progressRate>=1.0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_3"))
            return;
        end

        if #this.locHeroIdList<this.dispatchCfgLoc.MinCard then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_4"), this.dispatchCfgLoc.MinCard))
            return
        end

        local chooseTime = this.dispatchCfgLoc.Time[this.dispatchTimeSelectIndex]
        local chooseHour = tonumber(chooseTime)
        for k,v in pairs(this.dispatchCfgLoc.ConsumeDispatch) do
            local needItemId = v.id
            local needCountPerHour = v.count
            local haveDestItemCount = DataHelper.GetItemCountById(needItemId)
            local needItemCount = chooseHour * needCountPerHour
            if needItemCount > haveDestItemCount then
                local configData = ConfigMgr.Config.itemMap[needItemId]
                local itemName = LuaMgr.GetLangText(configData.nameLan)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_5"), itemName))
                return
            end
        end


        local timeEventId=nil;





        SeasonSLGAPI.OnAskTimeEventDispatch(tostring(SeasonSLGEventMgr.curGridIndex),this.dispatchLocId,this.dispatchCfgLoc.Time[this.dispatchTimeSelectIndex],this.locHeroIdList,
                function(progress)
                    if not SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex)) and
                            this.fullProgress/SeasonSLGMapMgr.gridMap[tostring(SeasonSLGEventMgr.curGridIndex)].GridHealth >= 1 then

                        SeasonSLGEventMgr.UpdateUnLockProgress()
                    else
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_6"))
                        this.ParseData()
                    end

        end)
    end)
end

local data =
{
    dispatchTimeList = {{time = "",select = false},}
}

local command =
{
    SelectTimeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.OnClickDispatchTimeItem(param + 1)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
        this.dispatchLocUIList=UIListView.New(ui.tranLocContent)
        this.headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
        this.rewardUIList=UIListView.New(ui.tranRewardContent);
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.produceUIList=UIListView.New(ui.tranProduceContent);
        this.produceItemObj=vm.behaviour.transform:Find("template/produceBuffItem").gameObject;
        this.topRankUIList=UIListView.New(ui.tranTopRankContent);
        this.topRankItemObj=vm.behaviour.transform:Find("template/TopRankItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm = vm
        if vm.behaviour.Params.Length>0 then
            this.dispatchLocId=vm.behaviour.Params[0];
            this.dispatchCfgLoc=ConfigMgr.Config.SeasonalGridWorldGuardMap[this.dispatchLocId]
            this.locHeroIdList={};
            SetActive(ui.txtProgressAdd.gameObject,false)
            SetActive(ui.animatorProgress.gameObject,false)
            this.ParseData();
            if not SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex)) then
                LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
                LuaMgr.AddUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUpdate(this.UpdateProgress)
        this.rewardType=nil;
        this.dispatchLocUIList:Clear();
        this.rewardUIList:Clear();
        UIListView.ClearItem("EventTimeRewardItem")
        UIListView.ClearItem("EventTimeRewardBuffItem")
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGDispatchTimer)
        if this.topRankItem ~= nil then
            this.topRankItem:Destroy()
            this.topRankItem = nil
        end
        if this.topRankRewardItem ~= nil then
            this.topRankRewardItem:Destroy()
            this.topRankRewardItem = nil
        end
        if this.HeroChoiceModel~=nil then
            this.HeroChoiceModel:Clear();
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
        LuaMgr.RemoveUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
    end,
    before_destroy = function()
        LuaMgr.RemoveUpdate(this.UpdateProgress)
        UIListView.ClearItem("HeroHeadItem")
        if this.topRankItem ~= nil then
            this.topRankItem:Destroy()
            this.topRankItem = nil
        end
        if this.topRankRewardItem ~= nil then
            this.topRankRewardItem:Destroy()
            this.topRankRewardItem = nil
        end
        if this.HeroChoiceModel~=nil then
            this.HeroChoiceModel:Destroy();
        end
        this.ClearUI();
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
        LuaMgr.RemoveUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
    end
}


this.OnMapUnLock=function()

    if SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex)) then
        this.progressFinishAction=function()
            LuaMgr.HidePanel(UIName.SeasonSlGEventLimitDispatchViewModel)
            SeasonSLGEventMgr.DOGridEvent(tostring(SeasonSLGEventMgr.curGridIndex))
        end
        if not this.progressAnimating then
            local finishAction=this.progressFinishAction
            this.progressFinishAction=nil
            finishAction()
        end
    end
end

this.OnMapStateUpdate=function()
    local gridId=tostring(SeasonSLGEventMgr.curGridIndex)
    local progressData=SeasonSLGMapMgr.MapStateData.EventProgress[gridId]
    local progress=progressData~=nil and progressData.Progress or nil
    if progress==nil then return end
    local oldProgress=this.fullProgress
    if progress>oldProgress then
        this.ShowProgressAdd(oldProgress,progress)
    else
        this.RefreshProgress(progress)
    end
    if progress>=SeasonSLGMapMgr.gridMap[gridId].GridHealth and oldProgress<SeasonSLGMapMgr.gridMap[gridId].GridHealth then
        SeasonSLGEventMgr.UpdateUnLockProgress()
    end
end

this.ParseData=function()
    this.isFunction = SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex))
    ui.txtLocation.text=SeasonSLGMapMgr.GetLocationPositionStr(SeasonSLGEventMgr.curGridIndex)
    SetActive(ui.goProgress,not this.isFunction)
    SetActive(ui.goScrollView,not this.isFunction)
    this.dispatchTimeSelectIndex = 1;
    local isUnLock = SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex))
    if not isUnLock then
        SetActive(ui.goProgress,true)
        SetActive(ui.gotopRank,false)
        SetActive(ui.gotopRankReward,true)
        SetActive(ui.goScrollView,true);
        if this.topRankRewardItem == nil then
            this.topRankRewardItem = SeasonSLGTopRankRewardCom.New(ui.tranTopRankReward)
            this.topRankRewardItem:SetData(tostring(SeasonSLGEventMgr.curGridIndex))
        end
        local gridId=tostring(SeasonSLGEventMgr.curGridIndex)
        local progressData=SeasonSLGMapMgr.MapStateData.EventProgress[gridId]
        this.fullProgress=(progressData~=nil and progressData.Progress) or this.vm.behaviour.Params[1].Progress or 0;
        this.RefreshProgress(this.fullProgress)
    else
        SetActive(ui.goScrollView,false);
        SetActive(ui.goProgress,false)
        SetActive(ui.gotopRankReward,false)
        SetActive(ui.gotopRank,true)
        if this.topRankItem == nil then
            this.topRankItem = BlockTopRankCom.New(ui.tranTopRank)
            this.topRankItem:SetData(this.vm.behaviour.Params[1],SeasonSLGMapMgr.gridMap[tostring(SeasonSLGEventMgr.curGridIndex)].GridHealth)
        end
        this.progressRate = 0
        SeasonSLGMapMgr.CheckTopRanReward(SeasonSLGEventMgr.curGridIndex,this.vm.behaviour.Params[1])
    end

    SetActive(ui.goDispatchBefore,false);
    ui.txtTitle.text=ConfigMgr.LangGlobal(this.dispatchCfgLoc.Name);
    ui.txtDes.text=ConfigMgr.LangGlobal(this.dispatchCfgLoc.GridDesc);

    this.dispatchData=DataMgr.Player.SeasonalWorldGuard[tostring(SeasonSLGEventMgr.curGridIndex)];
    if this.dispatchData~=nil then
        if #this.dispatchData.Members>0 then
            this.locHeroIdList=this.dispatchData.Members;
        end
    end
    this.SetDispatchLocUIList();
    this.SwitchRewardType(1);
    this.SetDispatchTimeList();
    if this.isFunction then

    end
end

this.SetTopRank = function()
    this.topRankUIList:Clear();
    local plist={};

    if infos ~= nil then
        for i,v in ipairs(this.infos) do
            local item={
                name=v.Name,
                percent=v.percent
            }
            local itemData=UIListData.GetData(this.topRankItemObj,"EventTimeRewardBuffItem",item);
            table.insert(plist,itemData);
        end
    end
    this.topRankUIList:SetData(plist);
end

this.SetDispatchTimeList = function()
    local tempList = {};
    for i, v in ipairs(this.dispatchCfgLoc.Time) do
        local item = {};
        item.time = v .. LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_7");
        item.select = i == this.dispatchTimeSelectIndex;
        table.insert(tempList,item)
    end
    this.vm.data.dispatchTimeList = tempList
end

this.OnClickDispatchTimeItem = function(param)
    if param == this.dispatchTimeSelectIndex then
        return
    end
    this.vm.data.dispatchTimeList[this.dispatchTimeSelectIndex].select = false
    this.dispatchTimeSelectIndex = tonumber(param)
    this.vm.data.dispatchTimeList[this.dispatchTimeSelectIndex].select = true
    this.SetRewardUIList()
    this.UpdateCostText();
end

this.RefreshProgress = function(progress)
    this.fullProgress=progress
    this.progressRate=this.fullProgress/SeasonSLGMapMgr.gridMap[tostring(SeasonSLGEventMgr.curGridIndex)].GridHealth
    ui.txtProgressValue.text=string.format("%.1f%%",this.progressRate*100);
    if not this.progressAnimating then
        ui.imgProgress.fillAmount=this.progressRate;
    end
end

this.ShowProgressAdd = function(oldProgress, newProgress)
    local progressAdd = newProgress - oldProgress
    this.fullProgress = newProgress
    if progressAdd <= 0 then
        this.RefreshProgress(newProgress)
        return
    end
    local gridHealth=SeasonSLGMapMgr.gridMap[tostring(SeasonSLGEventMgr.curGridIndex)].GridHealth
    local per = string.format("%.2f%%",progressAdd/gridHealth*100)
    local text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34175")
    ui.txtProgressAdd.text=string.format(text,per)
    SetActive(ui.txtProgressAdd.gameObject,true)
    SetActive(ui.animatorProgress.gameObject,true)
    ui.animatorProgress:Play("SeasonSLGProgressAddAniClip",0,0)
    this.progressFrom=oldProgress/gridHealth
    this.progressTo=this.fullProgress/gridHealth
    this.progressDuration=0.35
    this.progressElapsed=0
    this.progressAnimating=true
    LuaMgr.RemoveUpdate(this.UpdateProgress)
    LuaMgr.AddUpdate(this.UpdateProgress)
end

this.UpdateProgress = function()
    this.progressElapsed=this.progressElapsed+UnityEngine.Time.unscaledDeltaTime
    local progressRate=math.min(this.progressElapsed/this.progressDuration,1)
    local progress=UnityEngine.Mathf.Lerp(this.progressFrom,this.progressTo,progressRate)
    ui.imgProgress.fillAmount=progress
    if progressRate>=1 then
        ui.imgProgress.fillAmount=this.progressTo
        this.progressAnimating=false
        LuaMgr.RemoveUpdate(this.UpdateProgress)
        if this.progressFinishAction~=nil then
            local finishAction=this.progressFinishAction
            this.progressFinishAction=nil
            finishAction()
        end
    end
end

this.SwitchRewardType=function(index)
    if this.rewardType~=nil and this.rewardType==index then
        return;
    end
    SetActive(ui.goActiveSelf,index==1);
    SetActive(ui.goActiveAll,index==2);
    this.rewardList=this.dispatchCfgLoc.FirstReward;
    this.produceList=this.dispatchCfgLoc.ProduceItem;

    SetActive(ui.goDispatchTime,true)
    SetActive(ui.goDispatching,false)
    SetActive(ui.btnComfrim.gameObject,true)

    if this.dispatchData ~= nil then
        local dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(this.dispatchData.Members, this.dispatchData.ProduceTime)
        if dispatchStatus ~= SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No then
            SetActive(ui.goDispatchTime,false)
            SetActive(ui.goDispatching,true)
            SetActive(ui.btnComfrim.gameObject,false)
            this.isComplete=LuaMgr.Timestamp() >= this.dispatchData.ProduceTime

            if this.isComplete then
                local grids = {}
                local gridsId = tostring(SeasonSLGEventMgr.curGridIndex)
                grids[gridsId] = this.dispatchLocId
                SeasonSLGAPI.OnAskTimeEventDispatchReward(grids,function()
                    SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(SeasonSLGEventMgr.curGridIndex),function(re)
                        local newProgress = re.Progress
                        SeasonSLGEventMgr.UpdateUnLockProgress()
                        this.ParseData();
                    end)
                end)
            else
                LuaMgr.RemoveTimer(TimerConst.SeasonSLGDispatchTimer)
                LuaMgr.AddTimer(TimerConst.SeasonSLGDispatchTimer, this.UpdateLeftTime, 1, -1, true)
            end
        end
    end
    this.SetRewardUIList();
end

this.UpdateLeftTime = function()
    local leftTime = this.dispatchData.ProduceTime - LuaMgr.Timestamp()
    if leftTime <= 0 then
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGDispatchTimer)
        local grids = {}
        local gridsId = tostring(SeasonSLGEventMgr.curGridIndex)
        grids[gridsId] = this.dispatchLocId
        SeasonSLGAPI.OnAskTimeEventDispatchReward(grids,function()
            SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(SeasonSLGEventMgr.curGridIndex),
                    function(re)
                        SeasonSLGEventMgr.UpdateUnLockProgress()
                        this.ParseData();
                    end
            )
        end)
    else
        local h,m,s = GetTimeHMS2(leftTime)
        local str = ""
        if h > 0 then
            str = str .. tostring(h) .. LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_8")
        end
        if m > 0 then
            str = str .. tostring(m) .. LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_9")
        end
        str = str .. tostring(s) .. LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_10")
        ui.txtDispatchLeftTime.text = string.format(LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_11"),str)
    end
end


this.GetProduceTableCount=function(heroDataList)

    this.levelItem=nil;

    this.sLevelItem=nil;

    this.rareLevelItem=nil;
    if #heroDataList <= 0 then
        local rareRewardItem=this.dispatchCfgLoc.RareReward[1]
        if this.rareLevelItem==nil then
            this.rareLevelItem={id=rareRewardItem.id,count=0};
        end
        this.rareLevelItem.count=this.rareLevelItem.count+rareRewardItem.count;
    end
    for i,v in ipairs(heroDataList) do
        local level_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.dispatchCfgLoc.Level,v.level);
        local level_s_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.dispatchCfgLoc.SeasonLevel,v.sLevel);
        local level_rare_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.dispatchCfgLoc.Rare,v.rare)
        if level_rewardIndex>0 then
            local item=this.dispatchCfgLoc.HourlyProduce1[level_rewardIndex]
            if this.levelItem==nil then
                this.levelItem={id=item.id,count=0};
            end
            this.levelItem.count=this.levelItem.count+item.count;
        end
        if level_s_rewardIndex>0 then
            local item=this.dispatchCfgLoc.HourlyProduce2[level_s_rewardIndex]
            if this.sLevelItem==nil then
                this.sLevelItem={id=item.id,count=0};
            end
            this.sLevelItem.count=this.sLevelItem.count+item.count;
        end
        if level_rare_rewardIndex>0 then
            local item=this.dispatchCfgLoc.RareReward[level_rare_rewardIndex]
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


this.FormatHeroDataList=function(heroIDList)
    local list={};
    for i,v in ipairs(heroIDList) do
        local heroInfo={
            id=v,
            level=DataMgr.Player.characters[v]~=nil and DataMgr.Player.characters[v].level or 1,
            sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(v),
            rare=HeroMgr.GetHeroNowRare(v),
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

    local tableCount = this.GetProduceTableCount(heroDataList)
    local produceItem = this.dispatchCfgLoc.ProduceItem[1]
    local additionRate = this.GetBuffRate(produceItem.id) / 100
    local totalCount = tableCount * (1 + additionRate / 100)
    ui.txtLocProduct.text=string.format(LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_12"), math.floor(totalCount), additionRate)
    ui.rawImageLocIcon.texture = GetItemTexture(produceItem.id)
    ui.txtLocHeroCount.text = string.format(LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_13"), this.dispatchCfgLoc.MinCard)
    ui.txtLocSeasonLevel.text = string.format(LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_14"), this.dispatchCfgLoc.MinLevel)
    this.UpdateCostText();
end

this.UpdateCostText=function()
    local costEnergyCount = this.dispatchCfgLoc.ConsumeDispatch[1].count
    local timeValue=tonumber(this.dispatchCfgLoc.Time[this.dispatchTimeSelectIndex])
    ui.txtCostEnergy.text = string.format(LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_15"), costEnergyCount*timeValue)
end

this.GetBuffRate = function(id)
    local _, produceDic = SeasonSLGMapMgr.GetActiveProduceBuff()
    return produceDic[id] or 0
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
                    rare=heroList[i].rare,
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
    if not IsNull(this.dispatchData) then
        local dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(this.dispatchData.Members, this.dispatchData.ProduceTime)
        if dispatchStatus ~= SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No then
            if dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Ing then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_16"))
            elseif dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventLimitDispatchViewModel_17"))
            end
            return
        end
    end
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
    this.rewardUIList:Clear();
    local list={};
    for i,v in ipairs(this.rewardList) do
        local rewardItem={
            item=v,
            isComplete=this.isComplete
        }
        local rewardData=UIListData.GetData(this.rewardItemObj,"EventTimeRewardItem",rewardItem);
        table.insert(list,rewardData);
    end
    this.rewardUIList:SetData(list);

    this.produceUIList:Clear();
    local plist={};
    for i,v in ipairs(this.produceList) do
        local rewardItem={
            item=v,
        }
        local rewardData=UIListData.GetData(this.produceItemObj,"EventTimeRewardBuffItem",rewardItem);
        table.insert(plist,rewardData);
    end
    this.produceUIList:SetData(plist);
end
return vm({
    data = data,
    command = command,
    hook = hook
})
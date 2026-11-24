require("SeasonSLG/EventPopUp/ResUpCostItem")
require("SeasonSLG/EventPopUp/ResUpItem")
require("SeasonSLG/EventPopUp/HeroHeadItem")
require("SeasonSLG/EventPopUp/BlockTopRankCom")
require("SeasonSLG/HeroChoiceModel")
local this = {
   resUpUIList={};
   resCostUIList={};
   resUpItemObj=nil;
   costItemObj=nil;

   dispatchLocUIList={};
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
    ui.goGrayRes = uiLink:Get("goGrayRes");
    ui.goGrayDispath = uiLink:Get("goGrayDispath");
    ui.goResUpPanel = uiLink:Get("goResUpPanel");
    ui.goCost = uiLink:Get("goCost");
    ui.goMax = uiLink:Get("goMax");
    ui.goDespatchPanel = uiLink:Get("goDespatchPanel");
    ui.goNoDispatch = uiLink:Get("goNoDispatch");
    ui.goReward = uiLink:Get("goReward");
    ui.goDispatchBefore = uiLink:Get("goDispatchBefore");
    ui.goDispatchTime = uiLink:Get("goDispatchTime");
    ui.goDispatching = uiLink:Get("goDispatching");
    ui.rawIconRes = uiLink:Get("rawIconRes"):GetComponent("RawImage");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnResUp = uiLink:Get("btnResUp"):GetComponent("Button");
    ui.btnDispatch = uiLink:Get("btnDispatch"):GetComponent("Button");
    ui.btnComfrimResUp = uiLink:Get("btnComfrimResUp"):GetComponent("Button");
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button");
    ui.btnAdd = uiLink:Get("btnAdd"):GetComponent("Button");
    ui.btnMax = uiLink:Get("btnMax"):GetComponent("Button");
    ui.btnShowReward = uiLink:Get("btnShowReward"):GetComponent("Button");
    ui.btnConfrimDispatch = uiLink:Get("btnConfrimDispatch"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.txtDispatchDes = uiLink:Get("txtDispatchDes"):GetComponent("Text");
    ui.txtDispatchName = uiLink:Get("txtDispatchName"):GetComponent("Text");
    ui.txtLocProduct = uiLink:Get("txtLocProduct"):GetComponent("Text");
    ui.txtTip = uiLink:Get("txtTip"):GetComponent("Text");
    ui.txtRemainDispatchCount = uiLink:Get("txtRemainDispatchCount"):GetComponent("Text");
    ui.txtRemainTime = uiLink:Get("txtRemainTime"):GetComponent("Text");
    ui.txtCur = uiLink:Get("txtCur"):GetComponent("Text");
    ui.txtRemain = uiLink:Get("txtRemain"):GetComponent("Text");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.txtDispatchLeftTime = uiLink:Get("txtDispatchLeftTime"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.tranCostContent = uiLink:Get("tranCostContent"):GetComponent("RectTransform");
    ui.transTopRank = uiLink:Get("transTopRank"):GetComponent("RectTransform");
    ui.tranLocContent = uiLink:Get("tranLocContent"):GetComponent("RectTransform");
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    ui.txtLocation=uiLink:Get("txtLocation"):GetComponent("Text");
    ui.txtDispatchCostCount=uiLink:Get("txtDispatchCostCount"):GetComponent("Text");
    ui.rawDispatchCostIcon=uiLink:Get("rawDispatchCostIcon"):GetComponent("RawImage");
    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
       LuaMgr.HidePanel(UIName.SeasonSlGEventResUpLevelPopupViewModel)
    end)
    uiLink:AddClickEvent("btnResUp",function()
        this.SwitchType(1)
    end)
    uiLink:AddClickEvent("btnDispatch",function()
        this.SwitchType(2)
    end)
    uiLink:AddClickEvent("btnAdd",function()
        LuaMgr.ShowLuaPanel(UIName.SeasonSLGFatigueReplyViewModel)
    end)
    uiLink:AddClickEvent("btnHelp",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_0"))
    end)







    uiLink:AddClickEvent("btnMax",function()
        this.dispatchCount=this.powerMaxCount;

        this.SetRewardUIList()
    end)

    uiLink:AddClickEvent("btnComfrimResUp",function()

        if not this.isCanUpLevel then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_1"));
            return;
        end
        SeasonSLGAPI.OnAskResourceUpLevel(SeasonSLGEventMgr.curGridIndex,function()
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_2"))
            SeasonSLGMapMgr.UpdateMapGridState()
            this.ParseData();
            this.SetResUpInfos();
        end)
    end)
    uiLink:AddClickEvent("btnConfrimDispatch",function()
        if this.maxCount==0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_3"))
            return;
        end
        if this.dispatchCount==0 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_4"))
            return;
        end

        if #this.locHeroIdList<this.cfgCurResLevel.MinCard then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_5"), this.cfgCurResLevel.MinCard))
            return
        end

        local chooseTime = this.cfgCurResLevel.Time[this.dispatchTimeSelectIndex]
        local chooseHour = tonumber(chooseTime)
        for k,v in pairs(this.cfgCurResLevel.ConsumeDispatch) do
            local needItemId = v.id
            local needCountPerHour = v.count
            local haveDestItemCount = DataHelper.GetItemCountById(needItemId)
            local needItemCount = chooseHour * needCountPerHour
            if needItemCount > haveDestItemCount then
                local configData = ConfigMgr.Config.itemMap[needItemId]
                local itemName = LuaMgr.GetLangText(configData.nameLan)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_6"), itemName))
                return
            end
        end
        SeasonSLGAPI.OnAskResourceDispatch(tostring(SeasonSLGEventMgr.curGridIndex),this.resId,chooseTime,this.locHeroIdList,
                function(progress)

                    this.ParseData();
                    this.SetDispatchInfos(true);
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
        this.resCostUIList=UIListView.New(ui.tranCostContent)
        this.resUpUIList=UIListView.New((ui.tranContent))
        this.resUpItemObj= vm.behaviour.transform:Find("template/resUpItem").gameObject;
        this.costItemObj= vm.behaviour.transform:Find("template/costItem").gameObject;
        this.dispatchLocUIList=UIListView.New(ui.tranLocContent)
        this.headItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
        this.addUINumber = vm.behaviour.transform:Find("root/Right/goDespatchPanel/Cost/buttons/AddBtn"):GetComponent("UIAddNumber");
        this.lessenUINumber =vm.behaviour.transform:Find("root/Right/goDespatchPanel/Cost/buttons/lessenBtn"):GetComponent("UIAddNumber");
        this.UINumberBinder();
        this.rewardItemList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            SetActive(ui.goDispatchBefore,false);
            LuaMgr.AddUIEventListener(UIEventConst.FatigueReply,this.UpdatePower);
            this.resId=vm.behaviour.Params[0];
            this.curProgress=vm.behaviour.Params[1].Progress or 0
            this.cfgGirdRes=ConfigMgr.Config.SeasonalGridResourceMap[this.resId];
            this.dispatchTimeSelectIndex = 1;
            this.locHeroIdList={};
            this.dispatchCount=1;
            if this.topRankItem == nil then
                this.topRankItem = BlockTopRankCom.New(ui.transTopRank)
            end
            this.topRankItem:SetData(vm.behaviour.Params[1],SeasonSLGMapMgr.gridMap[tostring(SeasonSLGEventMgr.curGridIndex)].GridHealth)
            this.ParseData();
            this.SwitchType(1)
            SeasonSLGMapMgr.CheckTopRanReward(SeasonSLGEventMgr.curGridIndex,vm.behaviour.Params[1])
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.typeIndex=nil;
        this.resUpUIList:Clear();
        this.resCostUIList:Clear();
        LuaMgr.RemoveUIEventListener(UIEventConst.FatigueReply, this.UpdatePower)
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGResourceDispatchTimer)
        this.ClearRewardItem();
        this.dispatchLocUIList:Clear();
        if this.HeroChoiceModel~=nil then
            this.HeroChoiceModel:Clear();
        end
    end,
    before_destroy = function()
        UIListView.ClearItem("ResUpCostItem")
        UIListView.ClearItem("ResUpItem")
        UIListView.ClearItem("HeroHeadItem")
        if this.HeroChoiceModel~=nil then
            this.HeroChoiceModel:Destroy();
        end
        this.ClearUI();
    end
}


this.SwitchType=function(typeIndex)
    if this.typeIndex~=nil and this.typeIndex==typeIndex then
        return;
    end
    this.typeIndex=typeIndex


    SetActive(ui.goGrayRes,false)
    SetActive(ui.goGrayDispath,typeIndex==1)
    SetActive(ui.goResUpPanel,typeIndex==1)
    SetActive(ui.goDespatchPanel,typeIndex==2);
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGResDispatchTime)
    if typeIndex==1 then
        this.SetResUpInfos();
    elseif typeIndex==2 then
        this.SetDispatchInfos();
        this.SetDispatchTimeList();
    end
end

this.SetDispatchTimeList = function()
    local tempList = {};
    for i, v in ipairs(this.cfgCurResLevel.Time) do
        local item = {};
        item.time = v .. LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_7");
        item.select = i == this.dispatchTimeSelectIndex;
        table.insert(tempList,item)
    end
    this.vm.data.dispatchTimeList = tempList
end

this.OnClickDispatchTimeItem = function(param)
    if not SeasonSLGMapMgr.CheckBlockIsUnLock(tostring(SeasonSLGEventMgr.curGridIndex),SeasonSLGMapMgr.CheckTriggerEventCoverByTime()) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_8"));
        return;
    end
    if param == this.dispatchTimeSelectIndex then
        return
    end
    this.vm.data.dispatchTimeList[this.dispatchTimeSelectIndex].select = false
    this.dispatchTimeSelectIndex = tonumber(param)
    this.vm.data.dispatchTimeList[this.dispatchTimeSelectIndex].select = true

    this.dispatchCount = tonumber(this.cfgCurResLevel.Time[this.dispatchTimeSelectIndex])
    this.SetRewardUIList()
    this.SetDispatchCost()
end


this.ParseData=function()
    ui.txtTitle.text=ConfigMgr.LangGlobal(this.cfgGirdRes.Name)
    this.dataResLevel=SeasonSLGEventMgr.GetGridResLevel(SeasonSLGEventMgr.curGridIndex);
    ui.txtLocation.text=SeasonSLGMapMgr.GetLocationPositionStr(SeasonSLGEventMgr.curGridIndex)
    local resLevelId=this.cfgGirdRes.Level[this.dataResLevel];
    this.cfgCurResLevel =ConfigMgr.Config.SeasonalGridResourceLevelMap[resLevelId]
    this.dataGrid=DataMgr.Player.SeasonalResource[tostring(SeasonSLGEventMgr.curGridIndex)]
    if SeasonSLGMapMgr.gridMap[tostring(SeasonSLGEventMgr.curGridIndex)].Empty == 4 then
        SetActive(ui.btnDispatch.gameObject,false)
    else
        SetActive(ui.btnDispatch.gameObject,true)
    end
    this.SetDispatchCost();
end

this.SetDispatchCost=function()
    local costItem=this.cfgCurResLevel.ConsumeDispatch[1];
    local path=ConfigHelper.GetItemHomeIconPath(costItem.id);
    ui.rawDispatchCostIcon.texture=LuaMgr.GetTexture(path);
    local dispatchCount=tonumber(this.cfgCurResLevel.Time[this.dispatchTimeSelectIndex])
    local myCount=DataHelper.GetItemCountById(costItem.id);
    local costCount=costItem.count*dispatchCount;
    ui.txtDispatchCostCount.text=myCount<costCount and string.format("<color=#FF3240>%s</color>",costCount) or costCount;
end

this.SetResUpInfos=function()

    this.isMaxUpLevel=this.dataResLevel>=this.cfgGirdRes.MaxLevel

    this.SetResUpUIList();
end

this.SetResUpUIList=function()
    local resLevelId=this.cfgGirdRes.Level[this.dataResLevel];
    this.cfgNextResLevel=nil;
    if not this.isMaxUpLevel then
        resLevelId=this.cfgGirdRes.Level[this.dataResLevel+1];
        this.cfgNextResLevel=ConfigMgr.Config.SeasonalGridResourceLevelMap[resLevelId]
    end
    this.resUpUIList:Clear();
    local list={}
    local produceTechBuff = SeasonSLGTechMgr.GetProduceBuff()
    for i,v in ipairs(this.cfgCurResLevel.ProduceItem) do
        local upLevelItem={
            itemId=v.id,
            name=ConfigHelper.ItemName(v.id),
            curNum=v.count,
            nextCount=this.cfgNextResLevel==nil and 0 or this.cfgNextResLevel.ProduceItem[i].count;
        }
        local itemIDList = {v.id}
        local blockBuffPercent = SeasonSLGEventMgr.GetProductByBuff(itemIDList)
        local techBuffPercent = (produceTechBuff[v.id] or 0) / 10000

        blockBuffPercent = math.min(blockBuffPercent, 1)
        techBuffPercent = math.min(techBuffPercent, 1)
        local totalPercent = math.min(blockBuffPercent + techBuffPercent, 1)
        upLevelItem.curNum = math.floor((1 + totalPercent) * upLevelItem.curNum)
        local upLevelData=UIListData.GetData(this.resUpItemObj,"ResUpItem",upLevelItem)
        table.insert(list,upLevelData);
    end
    this.resUpUIList:SetData(list);
    this.SetResUpCostUIList();
end

this.SetResUpCostUIList=function()
    this.resCostUIList:Clear();


    if this.cfgNextResLevel==nil then
        return;
    end
    local list={}
    this.isCanUpLevel=true;
    for i,v in ipairs(this.cfgCurResLevel.Consume) do
        local costItem={
            itemId=v.id,
            count=v.count,
            myCount=DataHelper.GetItemCountById(v.id)
        }
        if costItem.count>costItem.myCount then
            this.isCanUpLevel=false;
        end
        local costData=UIListData.GetData(this.costItemObj,"ResUpCostItem",costItem);
        table.insert(list,costData)
    end
    this.resCostUIList:SetData(list);
end


this.SetDispatchInfos=function(isUpdatePower)
    SetActive(ui.goDispatchBefore,false);
    local resLevelId=this.cfgGirdRes.Level[this.dataResLevel];
    this.cfgCurResLevel =ConfigMgr.Config.SeasonalGridResourceLevelMap[resLevelId]
    this.dispatchLocId=this.cfgCurResLevel.Id;
    ui.txtDispatchDes.text=ConfigMgr.LangGlobal(this.cfgGirdRes.GridDesc);







    this.dispatchCount = tonumber(this.cfgCurResLevel.Time[this.dispatchTimeSelectIndex])






    this.SetDispatchLocUIList();
end

this.SetTimer=function()
    this.remainTime = Get_Beijing_IntervalSec_curTimeTo_AM4()
    if this.remainTime > 0 then
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGResDispatchTime)
        LuaMgr.AddTimer(TimerConst.SeasonSLGResDispatchTime,this.ShowRemainTime,1,-1,true)
    else
        this.txtRemainTime.text = string.format("%02d:%02d:%02d", 0, 0, 0)
    end
end

this.ShowRemainTime=function()
    local h, m, s = GetTimeHMS(this.remainTime)
    ui.txtRemainTime.text= string.format("%02d:%02d:%02d", h, m, s)
    this.remainTime=this.remainTime-1;
    if this.remainTime<0 then
        ui.txtRemainTime.text = string.format("%02d:%02d:%02d", 0, 0, 0)
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGResDispatchTime)
        SeasonSLGAPI.OnAskResourceDispatchProgress(tostring(SeasonSLGEventMgr.curGridIndex),this.resId,function(re)
            this.curProgress=re.Progress;
            this.SetDispatchInfos(true);
        end)
    end
end


this.SetDispatchLocUIList=function()
    if not IsNull(this.dataGrid) and not IsNull(this.dataGrid.Members) and #this.dataGrid.Members > 0 then
        SetActive(ui.goDispatching,true)
        SetActive(ui.goDispatchTime,false)
        SetActive(ui.btnConfrimDispatch.gameObject,false)
        this.locHeroIdList = this.dataGrid.Members
        local curTime = LuaMgr.Timestamp()
        if this.dataGrid.ProduceTime > LuaMgr.Timestamp() then
            LuaMgr.RemoveTimer(TimerConst.SeasonSLGResourceDispatchTimer)
            LuaMgr.AddTimer(TimerConst.SeasonSLGResourceDispatchTimer, this.UpdateLeftTime, 1, -1, true)
        else
            LuaMgr.RemoveTimer(TimerConst.SeasonSLGResourceDispatchTimer)
            local grids = {}
            local gridsId = tostring(SeasonSLGEventMgr.curGridIndex)
            grids[gridsId] = this.resId
            SeasonSLGAPI.OnAskResourceDispatchReward(grids,
                    function()
                        this.ParseData();
                        this.SetDispatchInfos(true);
                    end)
            return
        end
    else
        SetActive(ui.goDispatching,false)
        SetActive(ui.goDispatchTime,true)
        SetActive(ui.btnConfrimDispatch.gameObject,true)
    end
    this.dispatchLocUIList:Clear();
    local heroDataList=this.FormatHeroDataList(this.locHeroIdList);
    local list=this.GetHeroItems(heroDataList,this.cfgGirdRes.CountDispatch,this.LocHeroCallBack)
    this.dispatchLocUIList:SetData(list);
    this.UpdateDispatchAddInfo(heroDataList);
end

this.UpdateLeftTime = function()
    local leftTime = this.dataGrid.ProduceTime - LuaMgr.Timestamp()
    if leftTime <= 0 then
        LuaMgr.RemoveTimer(TimerConst.SeasonSLGResourceDispatchTimer)
        SeasonSLGAPI.OnAskResourceDispatch(tostring(SeasonSLGEventMgr.curGridIndex),this.resId,this.cfgCurResLevel.Time[this.dispatchTimeSelectIndex],this.locHeroIdList,
                function(progress)
                    this.ParseData();
                    this.SetDispatchInfos(true);
                end)
    else
        local h,m,s = GetTimeHMS2(leftTime)
        local str = ""
        if h > 0 then
            str = str .. tostring(h) .. LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_9")
        end
        if m > 0 then
            str = str .. tostring(m) .. LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_10")
        end
        str = str .. tostring(s) .. LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_11")
        ui.txtDispatchLeftTime.text = string.format(LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_12"),str)
    end
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
                    level= SeasonSLGMapMgr.GetCharacterLevel(heroList[i].id),
                    callBack=upCallBack,
                    sLevel=SeasonSLGMapMgr.GetCharacterSeasonLevel(heroList[i].id)
                }
            end
        end
        local heroData=UIListData.GetData(this.headItemObj,"HeroHeadItem",heroItem);
        table.insert(list,heroData);
    end
    return list;
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
this.LocHeroCallBack=function()

    if not IsNull(this.dataGrid) then
        local dispatchStatus = SeasonSLGEventMgr.GetDisPatchStatus(this.dataGrid.Members, this.dataGrid.ProduceTime)
        if dispatchStatus ~= SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_No then
            if dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Ing then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_13"))
            elseif dispatchStatus == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_14"))
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

this.UpdateDispatchAddInfo=function(heroDataList)

    this.levelItem=nil;

    this.sLevelItem=nil;

    this.rareLevelItem=nil;

    this.talentAddition = {}
    for i,v in ipairs(heroDataList) do
        local level_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.cfgCurResLevel.ExtraLevel,SeasonSLGMapMgr.GetCharacterLevel(v.id));
        local level_s_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.cfgCurResLevel.ExtraSeasonalLevel,SeasonSLGMapMgr.GetCharacterSeasonLevel(v.id));
        local level_rare_rewardIndex=SeasonSLGEventMgr.GetIndexByArray(this.cfgCurResLevel.Rare,HeroMgr.GetHeroNowRare(v.id))
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
        if level_rare_rewardIndex>0 and level_rare_rewardIndex <= #this.cfgCurResLevel.RareReward then
            local item=this.cfgCurResLevel.RareReward[level_rare_rewardIndex]
            if this.rareLevelItem==nil then
                this.rareLevelItem={id=item.id,count=0};
            end
            this.rareLevelItem.count=this.rareLevelItem.count+item.count;
        end


        local _, heroTalentBuffDic = SeasonSLGTechMgr.GetSpecialHeroTalentBuffs(v.id)
        for key, value in pairs(heroTalentBuffDic) do
            if this.talentAddition[key] == nil then
                this.talentAddition[key] = value
            else
                this.talentAddition[key] = this.talentAddition[key] + value
            end
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



    this.SetRewardUIList()
end

this.UpdatePower=function()
    this.SetDispatchInfos(true)
end
this.UINumberBinder=function()
    this.addUINumber.Callback=function(data,delta,current)
        this.SetDispatchCount(1)
    end
    this.lessenUINumber.Callback=function(data,delta,current)
        this.SetDispatchCount(-1)
    end
end

this.SetDispatchCount=function(dir)
    this.dispatchCount=this.dispatchCount+dir;
    if this.dispatchCount<1 then
        this.dispatchCount=1;
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_15"))
    end
    if this.dispatchCount>this.maxCount then
        this.dispatchCount=this.maxCount
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_16"))
    elseif this.dispatchCount>this.powerMaxCount then
        this.dispatchCount=this.powerMaxCount
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventResUpLevelPopupViewModel_17"))
    end;

    this.SetRewardUIList();
end

this.SetCountText=function()
    local myPower=DataHelper.GetItemCountById(this.cfgGirdRes.ConsumeDispatch[1].id);
    local remainPower=myPower-this.cfgGirdRes.ConsumeDispatch[1].count*this.dispatchCount;
    ui.txtCur.text=myPower;
    ui.txtRemain.text=math.floor(remainPower);
    ui.txtCount.text=this.dispatchCount;
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
    local cacheMap = {}
    for i,v in ipairs(rewardList) do
        if cacheMap[v.id] == nil then
            cacheMap[v.id] = {
                id = v.id,
                count = v.count
            }
        else
            cacheMap[v.id].count = cacheMap[v.id].count + v.count
        end
    end
    local rewardListNew = {}
    local curSeasonal = SeasonSLGMapMgr.GetCurSeasonCfgData()
    local techBuffDic = SeasonSLGTechMgr.GetProduceBuff()
    for i,v in pairs(cacheMap) do
        local seasonCache = DataMgr.Player.Seasonal[curSeasonal.Id]
        if seasonCache == nil then
            break
        end
        local cache = seasonCache.ProduceIncr[v.id]
        local additionNum = 0
        if cache ~= nil then
            additionNum = cache
        end
        local techBuffNum = techBuffDic[v.id]
        if techBuffNum ~= nil then
            additionNum = additionNum + techBuffNum
        end

        local talentNum = this.talentAddition[v.id]
        if talentNum ~= nil then
            additionNum = additionNum + talentNum
        end
        LuaDebug.error("")
        v.count = math.floor(v.count * (1 + additionNum / 10000))
        table.insert(rewardListNew,v)
    end

    rewardList = rewardListNew
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
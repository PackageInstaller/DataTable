require("SeasonSLG/EventPopUp/EventTimeRewardItem")
require("SeasonSLG/EventPopUp/EventTimeRewardBuffItem")
require("SeasonSLG/EventPopUp/SeasonSLGTopRankRewardCom")
local this = {
   rewardUIList={};
   rewardItemObj=nil;
};

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.goods = uiLink:Get("goods");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goProgress = uiLink:Get("goProgress");
    ui.goActiveSelf = uiLink:Get("goActiveSelf");
    ui.goActiveAll = uiLink:Get("goActiveAll");
    ui.goBtns = uiLink:Get("goBtns");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button");
    ui.btnSelf = uiLink:Get("btnSelf"):GetComponent("Button");
    ui.btnAll = uiLink:Get("btnAll"):GetComponent("Button");
    ui.btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");
    ui.btnDelegate = uiLink:Get("btnDelegate"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtProgressValue = uiLink:Get("txtProgressValue"):GetComponent("Text");
    ui.txtProgressAdd = uiLink:Get("txtProgressAdd"):GetComponent("Text");
    ui.txtRewardDes = uiLink:Get("txtRewardDes"):GetComponent("Text");
    ui.txtRewardDes1 = uiLink:Get("txtRewardDes1"):GetComponent("Text");
    ui.txtBattleCostCount = uiLink:Get("txtBattleCostCount"):GetComponent("Text");
    ui.txtBtnConfirm = uiLink:Get("txtBtnConfirm"):GetComponent("Text");
    ui.txtBtnConfirmMask = uiLink:Get("txtBtnConfirmMask"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.txtLocation = uiLink:Get("txtLocation"):GetComponent("Text");
    ui.imgProgress = uiLink:Get("imgProgress"):GetComponent("Image");
    ui.imgBattleMask = uiLink:Get("imgBattleMask"):GetComponent("Image");
    ui.animatorProgress = uiLink:Get("animatorProgress"):GetComponent("Animator");
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    ui.tranRewardBuffContent = uiLink:Get("tranRewardBuffContent"):GetComponent("RectTransform");
    ui.transTopRankReward = uiLink:Get("transTopRankReward"):GetComponent("RectTransform");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.rawBattleCostIcon = uiLink:Get("rawBattleCostIcon"):GetComponent("RawImage");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventNormalGridViewModel)
    end)
    uiLink:AddClickEvent("btnHelp",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventNormalGridViewModel_0"))
    end)






    uiLink:AddClickEvent("btnBattle",function()
        if not SeasonSLGMapMgr.CheckBlockIsUnLock(tostring(SeasonSLGEventMgr.curGridIndex),SeasonSLGMapMgr.CheckTriggerEventCoverByTime()) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventNormalGridViewModel_1"));
            return;
        end
        local canSweep = false
        if canSweep then
            this.OnDelegate();
        else
            local dungeonTag=IsNullOrEmpty(SeasonSLGEventMgr.curTimedEventId) and "normal" or "timed"


            LuaMgr.HidePanel(UIName.SeasonSlGEventNormalGridViewModel)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.SeasonSLG,this.eventId,this.eventType, SeasonSLGEventMgr.curGridIndex,dungeonTag,this.DungeonId)
        end
    end)
    uiLink:AddClickEvent("btnDelegate",function()
        this.OnDelegate();
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
        this.rewardUIList=UIListView.New(ui.tranRewardContent);
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.rewardBuffList=UIListView.New(ui.tranRewardBuffContent);
        this.rewardBuffItemObj=vm.behaviour.transform:Find("template/produceBuffItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm = vm
        if vm.behaviour.Params.Length>1 then
            this.eventType=vm.behaviour.Params[0]
            this.eventId =vm.behaviour.Params[1]
            this.cfgDungeon=ConfigMgr.Config.SeasonalEventDungeonMap[this.eventId];
            this.DungeonId = this.RandomDungeon()
            this.cfgGrid = ConfigMgr.Config.SeasonalGridMap[tostring(SeasonSLGEventMgr.curGridIndex)]
            SetActive(ui.txtProgressAdd.gameObject,false)
            SetActive(ui.animatorProgress.gameObject,false)
            SetActive(ui.imgBattleMask.gameObject,false)
            this.ParseData();
            if not SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex)) then
                LuaMgr.AddUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
                LuaMgr.AddUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
            end

            if not SeasonSLGMapMgr.CheckBlockIsUnLock(tostring(SeasonSLGEventMgr.curGridIndex),SeasonSLGMapMgr.CheckTriggerEventCoverByTime()) then
                SetActive(ui.imgBattleMask.gameObject,true)
            end

            if this.topRankRewardItem == nil then
                this.topRankRewardItem = SeasonSLGTopRankRewardCom.New(ui.transTopRankReward)
                this.topRankRewardItem:SetData(tostring(SeasonSLGEventMgr.curGridIndex))
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUpdate(this.UpdateProgress)
        this.rewardUIList:Clear();
        this.rewardBuffList:Clear();
        UIListView.ClearItem("EventTimeRewardItem")
        UIListView.ClearItem("EventTimeRewardBuffItem")
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
        LuaMgr.RemoveUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
        if this.topRankRewardItem ~= nil then
            this.topRankRewardItem:Destroy()
            this.topRankRewardItem = nil
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveUpdate(this.UpdateProgress)
        this.ClearUI();
        LuaMgr.RemoveUIEventListener(UIEventConst.SeasonSLGUpdateMapState, this.OnMapStateUpdate)
        LuaMgr.RemoveUIEventListener(UIEventConst.SLGSeasonMapUnLock, this.OnMapUnLock)
        if this.topRankRewardItem ~= nil then
            this.topRankRewardItem:Destroy()
            this.topRankRewardItem = nil
        end
    end
}

this.RandomDungeon = function()
    local dungs = {}
    local seasonalDungeonRecords = DataMgr.Player.SeasonalDungeonRecords or {}
    local usedDungs = seasonalDungeonRecords[this.cfgDungeon.Id] or {}
    for i = 1, #this.cfgDungeon.Dungeons do
        local cur = this.cfgDungeon.Dungeons[i]
        local fund = false
        for k, v in pairs(usedDungs) do
            if cur == v then
                fund = true
                break
            end
        end
        if not fund then
            table.insert(dungs, cur)
        end
    end

    if #dungs <= 0 then
        LuaDebug.error("err no dungenons")
        return this.cfgDungeon.Dungeons[1]
    end

    local r = math.random(1,#dungs)
    return dungs[r]
end

this.OnMapUnLock=function()

    if SeasonSLGMapMgr.CheckBlockEventsIsComplete(tostring(SeasonSLGEventMgr.curGridIndex)) then
        this.progressFinishAction=function()
            LuaMgr.HidePanel(UIName.SeasonSlGEventNormalGridViewModel)
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
    if progress>=this.cfgGrid.GridHealth and oldProgress<this.cfgGrid.GridHealth then
        SeasonSLGEventMgr.UpdateUnLockProgress()
    end
end

this.ParseData=function()
    local isUnLock = SeasonSLGMapMgr.CheckBlockEventsIsComplete(SeasonSLGEventMgr.curGridIndex)
    ui.txtLocation.text=SeasonSLGMapMgr.GetLocationPositionStr(SeasonSLGEventMgr.curGridIndex)
    if not isUnLock then
        SetActive(ui.goProgress,true)
        local gridId=tostring(SeasonSLGEventMgr.curGridIndex)
        local progressData=SeasonSLGMapMgr.MapStateData.EventProgress[gridId]
        this.fullProgress=(progressData~=nil and progressData.Progress) or this.vm.behaviour.Params[2].Progress or 0;
        this.RefreshProgress(this.fullProgress)
    else
        SetActive(ui.goProgress,false)
        this.progressRate = 0;
    end
    ui.txtTitle.text=SeasonSLGMapMgr.GetGridName(SeasonSLGEventMgr.curGridIndex);
    SetActive(ui.btnDelegate.gameObject,false)
    local canFastBattle = SeasonSLGMapMgr.CheckBlockEventsCanFastBattle(SeasonSLGEventMgr.curGridIndex,this.cfgDungeon.Id,this.cfgDungeon.DungeonBattle,true)
    ui.txtBtnConfirm.text = canFastBattle and LuaMgr.GetLangText("SeasonSlGEventNormalGridViewModel_2") or LuaMgr.GetLangText("SeasonSlGEventNormalGridViewModel_3")
    ui.txtBtnConfirmMask.text = canFastBattle and LuaMgr.GetLangText("SeasonSlGEventNormalGridViewModel_4") or LuaMgr.GetLangText("SeasonSlGEventNormalGridViewModel_5")





    local costItem=SeasonSLGEventMgr.GetBlockCostItem(tostring(SeasonSLGEventMgr.curGridIndex))
    local path=ConfigHelper.GetItemHomeIconPath(costItem.id)
    ui.rawBattleCostIcon.texture=LuaMgr.GetTexture(path);
    local myCount=DataHelper.GetItemCountById(costItem.id)
    ui.txtBattleCostCount.text=myCount<costItem.count and string.format("<color=#FF3240>%s</color>",costItem.count) or costItem.count;
    this.SwitchRewardType()
end


this.OnDelegate = function()
    local dungeonTag=IsNullOrEmpty(SeasonSLGEventMgr.curTimedEventId) and "normal" or "timed"
    local enterDungeonParams        = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId      = this.eventId
    enterDungeonParams.dungeonId    = this.DungeonId
    enterDungeonParams.extraParams = { "seasonal", tostring(SeasonSLGEventMgr.curGridIndex), this.eventType, "", "", this.eventId, dungeonTag,this.DungeonId}

    enterDungeonParams.count = 1

    ApiMgr.Request("enter_leave_dungeon", enterDungeonParams, true, function(result)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventNormalGridViewModel_6"))
        SeasonSLGAPI.OnAskBlockUnlockProgress(tostring(SeasonSLGEventMgr.curGridIndex),function(re)
            if re.Progress/this.cfgGrid.GridHealth >= 1 then
                SeasonSLGEventMgr.UpdateUnLockProgress()
            end
        end)
    end, nil, true, true);
end

this.RefreshProgress = function(progress)
    this.fullProgress=progress
    this.progressRate=this.fullProgress/this.cfgGrid.GridHealth
    ui.txtProgressValue.text=string.format("%.2f%%",this.progressRate*100);
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
    local per = string.format("%.2f%%",progressAdd/this.cfgGrid.GridHealth*100)
    local text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_34174")
    ui.txtProgressAdd.text=string.format(text,per)
    SetActive(ui.txtProgressAdd.gameObject,true)
    SetActive(ui.animatorProgress.gameObject,true)
    ui.animatorProgress:Play("SeasonSLGProgressAddAniClip",0,0)
    this.progressFrom=oldProgress/this.cfgGrid.GridHealth
    this.progressTo=this.fullProgress/this.cfgGrid.GridHealth
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

this.SwitchRewardType=function()
    SetActive(ui.tranRewardBuffContent.gameObject,false)
    if #this.cfgGrid.Function > 0 and this.cfgGrid.Function[1] == "4" then
        SetActive(ui.tranRewardBuffContent.gameObject,true)
        local functionId = this.cfgGrid.Function[2]
        local resourceConfig = ConfigMgr.Config.SeasonalGridResourceMap[functionId]
        local resourceLevelConfig = ConfigMgr.Config.SeasonalGridResourceLevelMap[resourceConfig.Level[1]]
        this.rewardBuffs = resourceLevelConfig.ProduceItem
        this.SetRewardBuffList();
    end
    this.isComplete=false;
    this.SetRewardUIList();
end

this.SetRewardUIList=function()
    local rewardList=this.cfgDungeon.ExtraReward;

    this.rewardUIList:Clear();

    local mergeList={};
    local mergeMap={};
    local function AddReward(id,count)
        if IsNullOrEmpty(id) then
            return
        end
        local key=tostring(id);
        local num=tonumber(count) or 0;
        if mergeMap[key]~=nil then
            mergeMap[key].count=mergeMap[key].count+num;
        else
            local itemData={id=id,count=num};
            mergeMap[key]=itemData;
            table.insert(mergeList,itemData);
        end
    end


    local dungeonCfg = ConfigMgr.Config.dungeonMap[tostring(this.DungeonId)];
    if dungeonCfg ~= nil then
        local firstDropList = ConfigHelper.GetRewardListByDrop(dungeonCfg.firstDrop);
        if firstDropList ~= nil then
            for i,v in ipairs(firstDropList) do
                AddReward(v.id,v.count);
            end
        end
    end
    for i,v in ipairs(rewardList) do
        AddReward(v.id,v.count);
    end

    local list={};
    for i,v in ipairs(mergeList) do
        local rewardItem={
            item=v,
            isComplete=this.isComplete
        }
        local rewardData=UIListData.GetData(this.rewardItemObj,"EventTimeRewardItem",rewardItem);
        table.insert(list,rewardData);
    end
    this.rewardUIList:SetData(list);
end

this.SetRewardBuffList=function()
    this.rewardBuffList:Clear();
    local list={};
    for i,v in ipairs(this.rewardBuffs) do
        local rewardItem={
            item=v,
        }
        local rewardData=UIListData.GetData(this.rewardBuffItemObj,"EventTimeRewardBuffItem",rewardItem);
        table.insert(list,rewardData);
    end
    this.rewardBuffList:SetData(list);
    SetActive(ui.btnAll.gameObject,#list > 0)
end


return vm({
    data = data,
    command = command,
    hook = hook
})
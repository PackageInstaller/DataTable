require("SeasonSLG/EventPopUp/BossBuffItem")
local this = {
   buffUIList={};
   buffItemObj=nil;
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
    ui.goRank = uiLink:Get("goRank");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button");
    ui.btnLess = uiLink:Get("btnLess"):GetComponent("Button");
    ui.btnAdd = uiLink:Get("btnAdd"):GetComponent("Button");
    ui.btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");
    ui.btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtRank = uiLink:Get("txtRank"):GetComponent("Text");
    ui.txtScore = uiLink:Get("txtScore"):GetComponent("Text");
    ui.txtBossStage = uiLink:Get("txtBossStage"):GetComponent("Text");
    ui.txtBossHp = uiLink:Get("txtBossHp"):GetComponent("Text");
    ui.txtDiffcult = uiLink:Get("txtDiffcult"):GetComponent("Text");
    ui.txtBattleCost = uiLink:Get("txtBattleCost"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.Scrollbar = uiLink:Get("Scrollbar"):GetComponent("ScrollRect");
    ui.tranBuffContent = uiLink:Get("tranBuffContent"):GetComponent("RectTransform");
    ui.tranRewadContent = uiLink:Get("tranRewadContent"):GetComponent("RectTransform");
    ui.imgHpProgress = uiLink:Get("imgHpProgress"):GetComponent("Image");
    ui.txtLocation=uiLink:Get("txtLocation"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBossPopupInfoViewModel)
    end)
    uiLink:AddClickEvent("btnHelp",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_0"))
    end)
    uiLink:AddClickEvent("btnLess",function()
        if not SeasonSLGMapMgr.CheckBlockIsUnLock(tostring(SeasonSLGEventMgr.curGridIndex),SeasonSLGMapMgr.CheckTriggerEventCoverByTime()) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_1"));
            return;
        end
        if this.dataGridBoss~=nil and not IsNullOrEmpty(this.dataGridBoss.DungeonGroupId) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_2"))
            return;
        end

        if this.curGroupIndex>1 then
            this.curGroupIndex=this.curGroupIndex-1;
            this.SetBossGroup();
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_3"))
        end
    end)
    uiLink:AddClickEvent("btnAdd",function()
        if this.dataGridBoss~=nil and not IsNullOrEmpty(this.dataGridBoss.DungeonGroupId) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_4"))
            return;
        end
        if this.curGroupIndex<#this.cfgGridBoss.DungeonGroupID then
            this.curGroupIndex=this.curGroupIndex+1
            this.SetBossGroup();
        else
           LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_5"))
        end
    end)

    uiLink:AddClickEvent("btnBattle",function()
        if SeasonSLGMapMgr.CheckBlockIsUnLock(tostring(SeasonSLGEventMgr.curGridIndex)) then
            LuaMgr.HidePanel(UIName.SeasonSlGEventBossPopupInfoViewModel)



            LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBossContinueInfoViewModel,this.eventType,this.gridBossId,this.curGroupCfg.Id)
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_6"))
        end
    end)
    uiLink:AddClickEvent("btnReward",function()
        SeasonSLGEventMgr.bossContinueData={
            viewName=UIName.SeasonSlGEventBossPopupInfoViewModel,
            data= {
                eventType = this.eventType,
                bossId = this.gridBossId,
            }
        }
        LuaMgr.HidePanel(UIName.SeasonSlGEventBossPopupInfoViewModel)
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGBossTaskViewModel,1);
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitUI(vm.behaviour)
        this.buffUIList=UIListView.New(ui.tranBuffContent);
        this.buffItemObj=vm.behaviour.transform:Find("template/buffItem").gameObject;
        this.rewardItemList={};
        RedMgr.Singleton:RegisterViewModel(UIName.SeasonSlGEventBossPopupInfoViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm = vm
        if vm.behaviour.Params.Length>1 then
            this.eventType=vm.behaviour.Params[0]
            this.gridBossId=vm.behaviour.Params[1]
            this.cfgGridBoss=ConfigMgr.Config.SeasonalGridBOSSMap[this.gridBossId]
            SeasonSLGEventMgr.bossContinueData=nil;
            this.ParseData();
        end
        SeasonSLGMapMgr.CheckBossTaskRed()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.buffUIList:Clear();
        this.ClearRewardItem();
    end,
    before_destroy = function()
        UIListView.ClearItem("BossBuffItem")
        this.ClearUI();
        RedMgr.Singleton:RemoveViewModel(UIName.SeasonSlGEventBossPopupInfoViewModel);
    end
}

this.ParseData=function()
    local bossStage = SeasonSLGMapMgr.MapStateData.BossStage and SeasonSLGMapMgr.MapStateData.BossStage[this.gridBossId]
    if bossStage == nil then
        return
    end
    this.curGroupIndex= bossStage.Stage
    ui.txtLocation.text=SeasonSLGMapMgr.GetLocationPositionStr(SeasonSLGEventMgr.curGridIndex)
    this.dataGridBoss=DataMgr.Player.SeasonalBoss[tostring(SeasonSLGEventMgr.curGridIndex)]







    if this.curGroupIndex >= 5 then
        SetActive(ui.goRank,true)
    else
        SetActive(ui.goRank,false)
    end
    local progress = bossStage.Progress
    local max = bossStage.Max
    ui.txtBossHp.text =string.format("%s/<color=#cf64c9>%s</color>",tostring(progress),tostring(max))
    this.hpProgress=progress/max;
    ui.imgHpProgress.fillAmount = this.hpProgress
    ui.txtScore.text= SeasonSLGEventMgr.GetPlayerMaxScore(this.gridBossId)
    local rankData=SeasonSLGEventMgr.bossRankMap[tostring(SeasonSLGEventMgr.curGridIndex)]
    if rankData~=nil then
        ui.txtRank.text=rankData.Rank;
    else
        ui.txtRank.text=LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_7");
    end
    this.SetBossGroup();
end

this.SetBossGroup=function()
    if this.curGroupIndex>#this.cfgGridBoss.Group then
        this.curGroupIndex=#this.cfgGridBoss.Group;
    end
    local proIndex_maxNum=NumTool.GetMaxNum(this.curGroupIndex)
    ui.txtBossStage.text=string.format(LuaMgr.GetLangText("SeasonSlGEventBossPopupInfoViewModel_8"),
            proIndex_maxNum,this.hpProgress*100);
    local groupId=this.cfgGridBoss.Group[this.curGroupIndex];
    this.curGroupCfg=ConfigMgr.Config.SeasonalGridBOSSGroupMap[groupId];

    this.bossDungeonID=this.GetBossDungeonID()
    this.cfgDungeon=ConfigMgr.Config.SeasonalGridBOSSDungeonMap[this.bossDungeonID]
    local costItem=this.cfgDungeon.Consume[1]


    ui.txtBattleCost.text=costItem.count;
    this.SetBuffUIList();
    this.SetRewardUIList();
end


this.GetBossDungeonID=function()

    return this.curGroupCfg.DungeonGroupID[1];
end


this.SetBuffUIList=function()
    this.buffUIList:Clear();
    local list={};
    for i,v in ipairs(this.cfgDungeon.BuffGroup) do
        local seasonalBuff=ConfigMgr.Config.SeasonalBuffMap[v];
        if seasonalBuff~=nil then
            local buffItem={
                icon=LuaMgr.GetSprite("BuffIcon", seasonalBuff.BuffIcon);
                name=LuaMgr.GetLangText(seasonalBuff.BuffNameLan),
                index=i,
                callBack=this.BuffClickCallBack
            }
            local buffData=UIListData.GetData(this.buffItemObj,"BossBuffItem",buffItem);
            table.insert(list,buffData)
        end
    end
    this.buffUIList:SetData(list);
end

this.SetBuffUIListOld=function()
   this.buffUIList:Clear();
    local progress = 0
    local bossStage = SeasonSLGMapMgr.MapStateData.BossStage and SeasonSLGMapMgr.MapStateData.BossStage[this.gridBossId];
    if bossStage ~= nil then
        progress = bossStage.Progress;
    end
    local selectedHeatProgress = -1;
    local selectedBuffGroup = nil;
    for i,v in ipairs(ConfigMgr.Config.SeasonalGridBOSSHeat) do
        if v.BossID == this.gridBossId and v.HeatProgress <= progress and v.HeatProgress > selectedHeatProgress then
            selectedHeatProgress = v.HeatProgress;
            selectedBuffGroup = v.BuffGroup;
        end
    end
    if selectedBuffGroup == nil then
        return;
    end
    this.curHeatBuffGroup = selectedBuffGroup;
    local list={};
    for i,v in ipairs(this.curHeatBuffGroup) do
        local seasonalBuff=ConfigMgr.Config.SeasonalBuffMap[v];
        if seasonalBuff~=nil then
            local buffItem={
                icon=LuaMgr.GetSprite("BuffIcon", seasonalBuff.BuffIcon);
                name=LuaMgr.GetLangText(seasonalBuff.BuffNameLan),
                index=i,
                callBack=this.BuffClickCallBack
            }
            local buffData=UIListData.GetData(this.buffItemObj,"BossBuffItem",buffItem);
            table.insert(list,buffData)
        end
    end
    this.buffUIList:SetData(list);
end

this.BuffClickCallBack=function(index)
    if this.curHeatBuffGroup == nil then
        return;
    end
    local buffId=this.curHeatBuffGroup[index]
    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBuffDesPopUpViewModel,buffId)
end

this.SetRewardUIList=function()
    local rewardList=this.cfgDungeon.Reward;
    if IsNull(rewardList) or #rewardList==0 then
        this.ClearRewardItem();
        return
    end;
    for i,v in ipairs(rewardList) do
        if this.rewardItemList[i]==nil then
            this.rewardItemList[i]=GoodsDataItem.New(ui.tranRewadContent)
        end
        local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemData.count0 = v.count;
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
require("SeasonSLG/EventPopUp/BossBuffItem")
local this = {
    buffUIList={};
    buffItemObj=nil;
    uiSpineCharacter=nil;
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
    ui.rawBossIcon = uiLink:Get("rawBossIcon"):GetComponent("RawImage");
    ui.txtBossName = uiLink:Get("txtBossName"):GetComponent("Text");
    ui.txtProgressValue = uiLink:Get("txtProgressValue"):GetComponent("Text");
    ui.txtScore = uiLink:Get("txtScore"):GetComponent("Text");
    ui.txtRank = uiLink:Get("txtRank"):GetComponent("Text");
    ui.txtDiffcult = uiLink:Get("txtDiffcult"):GetComponent("Text");
    ui.sliderWorldProgress = uiLink:Get("sliderWorldProgress"):GetComponent("Slider");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranBuffContent = uiLink:Get("tranBuffContent"):GetComponent("RectTransform");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.btnLess = uiLink:Get("btnLess"):GetComponent("Button");
    ui.btnAdd = uiLink:Get("btnAdd"):GetComponent("Button");
    ui.btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");
    ui.btnReward = uiLink:Get("btnReward"):GetComponent("Button");
    ui.txtLocation=uiLink:Get("txtLocation"):GetComponent("Text");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)




    uiLink:AddClickEvent("btnLess",function()
        if this.dataGridBoss~=nil and not IsNullOrEmpty(this.dataGridBoss.DungeonGroupId) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBoss2PopupInfoViewModel_0"))
            return;
        end

        if this.curGroupIndex>1 then
            this.curGroupIndex=this.curGroupIndex-1;
            this.SetBossGroup();
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBoss2PopupInfoViewModel_1"))
        end
    end)
    uiLink:AddClickEvent("btnAdd",function()
        if this.dataGridBoss~=nil and not IsNullOrEmpty(this.dataGridBoss.DungeonGroupId) then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBoss2PopupInfoViewModel_2"))
            return;
        end
        if this.curGroupIndex<#this.cfgGridBoss.Group then
            this.curGroupIndex=this.curGroupIndex+1
            this.SetBossGroup();
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBoss2PopupInfoViewModel_3"))
        end
    end)

    uiLink:AddClickEvent("btnBattle",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBoss2PopupInfoViewModel)
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBoss2ContinueInfoViewModel,this.eventType,this.gridBossId,this.curGroupCfg.Id)
    end)
    uiLink:AddClickEvent("btnReward",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBoss2PopupInfoViewModel)
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGBossTaskViewModel,2);
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.InitUI(vm.behaviour)
        this.buffUIList=UIListView.New(ui.tranBuffContent);
        this.buffItemObj=vm.behaviour.transform:Find("template/buffItem").gameObject;
        this.uiSpineCharacter=vm.behaviour.transform:Find("root/Middle/leftInfos/rawBossIcon"):GetComponent("UISpineCharacter");
        this.rewardItemList={};
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            this.eventType=vm.behaviour.Params[0]
            this.gridBossId=vm.behaviour.Params[1]
            this.cfgGridBoss=ConfigMgr.Config.SeasonalGridBOSSMap[this.gridBossId]
            this.curGroupIndex=1;
            SeasonSLGEventMgr.boss2Param=nil;
            SeasonSLGEventMgr.CheckPopUpWorldProgressTip();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.buffUIList:Clear();
        this.ClearRewardItem();
        this.uiSpineCharacter:Clear();
    end,
    before_destroy = function()
        UIListView.ClearItem("BossBuffItem")
        this.ClearUI();
    end
}

this.ParseData=function()
    ui.txtLocation.text=SeasonSLGMapMgr.GetLocationPositionStr(SeasonSLGEventMgr.curGridIndex)
    this.dataGridBoss=DataMgr.Player.SeasonalBoss[tostring(SeasonSLGEventMgr.curGridIndex)]
    if this.dataGridBoss~=nil and not IsNullOrEmpty(this.dataGridBoss.GroupId) then
        for i,v in ipairs(this.cfgGridBoss.Group) do
            if v==this.dataGridBoss.GroupId then
                this.curGroupIndex=i;
            end
        end
    end
    local rankData=SeasonSLGEventMgr.bossRankMap[tostring(SeasonSLGEventMgr.curGridIndex)]
    if rankData~=nil then
        ui.txtScore.text=rankData.Score;
        ui.txtRank.text=rankData.Rank;
    else
        ui.txtScore.text="0";
        ui.txtRank.text=LuaMgr.GetLangText("SeasonSlGEventBoss2PopupInfoViewModel_4");
    end
    ui.txtBossName.text=LuaMgr.GetLangText(this.cfgGridBoss.NameLan);
    local challengeProgress=SeasonSLGMapMgr.GetBoss2ChallengeProgress();
    local limit=SeasonSLGMapMgr.Constants().SeasonalBossHeatMax
    local progress=challengeProgress/(limit[1]*limit[2]);
    ui.sliderWorldProgress.value= progress;
    ui.txtProgressValue.text=SeasonSLGEventMgr.GetProgressName(challengeProgress)
    this.SetBossSpine();
    this.SetBossGroup();
end

this.SetBossSpine=function()
    local arrayCamera=NumTool.split(this.cfgGridBoss.Offset,",")
    this.uiSpineCharacter:SetBattleBoss(this.cfgGridBoss.BossPreview,this.cfgGridBoss.BossSkinPreview,
            Vector3(tonumber(arrayCamera[2]),tonumber(arrayCamera[3]),tonumber(arrayCamera[4])),
            tonumber(arrayCamera[1]));
end

this.SetBossGroup=function()
    local groupId=this.cfgGridBoss.Group[this.curGroupIndex];
    this.curGroupCfg=ConfigMgr.Config.SeasonalGridBOSSGroupMap[groupId];
    ui.txtDiffcult.text=LuaMgr.GetLangText(this.curGroupCfg.DescLan);
    this.bossDungeonID=this.GetBossDungeonID()
    this.cfgDungeon=ConfigMgr.Config.SeasonalGridBOSSDungeonMap[this.bossDungeonID]




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

this.BuffClickCallBack=function(index)
    local buffId=this.cfgDungeon.BuffGroup[index]
    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBuffDesPopUpViewModel,buffId)
end

this.SetRewardUIList=function()
    local rewardList=this.cfgGridBoss.RewardPreview;
    if IsNull(rewardList) or #rewardList==0 then
        this.ClearRewardItem();
        return
    end;
    for i,v in ipairs(rewardList) do
        if this.rewardItemList[i]==nil then
            this.rewardItemList[i]=GoodsDataItem.New(ui.tranContent)
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
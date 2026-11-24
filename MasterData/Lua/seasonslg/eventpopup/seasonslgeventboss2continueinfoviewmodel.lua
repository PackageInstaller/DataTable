require("SeasonSLG/EventPopUp/Boss2BuffItem")
require("SeasonSLG/EventPopUp/HeroHeadItem")
require("SeasonSLG/EventPopUp/Boss2HeroTeam")

local this = {
    buffUIList={};
    buffItemObj=nil;
    teamUIList={};
    heroListGroup=nil;
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Middle = uiLink:Get("Middle");
    ui.LeftBG = uiLink:Get("LeftBG");
    ui.Right = uiLink:Get("Right");
    ui.txtScore = uiLink:Get("txtScore"):GetComponent("Text");
    ui.txtDiffcult = uiLink:Get("txtDiffcult"):GetComponent("Text");
    ui.txtBattleInfo = uiLink:Get("txtBattleInfo"):GetComponent("Text");
    ui.tranBuffContent = uiLink:Get("tranBuffContent"):GetComponent("RectTransform");
    ui.tranFormationContent = uiLink:Get("tranFormationContent"):GetComponent("RectTransform");
    ui.btnAddInfos = uiLink:Get("btnAddInfos"):GetComponent("Button");
    ui.btnComplete = uiLink:Get("btnComplete"):GetComponent("Button");
    ui.btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnBattle",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBossContinueInfoViewModel)
        local grid_bossDungeonId=string.format("%s_%s",SeasonSLGEventMgr.curGridIndex,this.cfgDungeon.Id)
        ActivityBattlePrepareMgr.SetMembers(ActivityKey.SeasonSLGBoss, grid_bossDungeonId);
        local dungeonTag=IsNullOrEmpty(SeasonSLGEventMgr.curTimedEventId) and "normal" or "timed"
        SeasonSLGEventMgr.boss2Param=this.cfgDungeon.Id;
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.SeasonSLGBoss,
                this.cfgDungeon.Id,this.eventType,SeasonSLGEventMgr.curGridIndex,this.curGroupCfg.Id,this.gridBossId,dungeonTag)
    end)
    uiLink:AddClickEvent("btnComplete",function()

        if not this.isContinue then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBoss2ContinueInfoViewModel_0"))
            return;
        end
        local tips=LuaMgr.GetLangText("SeasonSlGEventBoss2ContinueInfoViewModel_1");
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tips,function()
            SeasonSLGAPI.OnAskBossBattleComplete(SeasonSLGEventMgr.curGridIndex,function()
                LuaMgr.Back();
                LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBoss2PopupInfoViewModel,this.eventType,this.gridBossId);
            end)
        end,nil)
    end)
    uiLink:AddClickEvent("btnAddInfos",function()
       LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBoss2WorldBuffAddInfoViewModel);
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.buffUIList=UIListView.New(ui.tranBuffContent);
        this.buffItemObj=vm.behaviour.transform:Find("template/buffItem").gameObject;
        this.teamUIList=UIListView.New(ui.tranFormationContent);
        this.heroListGroup=vm.behaviour.transform:Find("template/teamItem").gameObject;
        this.heroItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>2 then
            this.eventType=vm.behaviour.Params[0]
            this.gridBossId=vm.behaviour.Params[1]
            this.gridGroupId=vm.behaviour.Params[2]
            this.curGroupCfg=ConfigMgr.Config.SeasonalGridBOSSGroupMap[this.gridGroupId];
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.buffUIList:Clear();
        this.teamUIList:Clear();
    end,
    before_destroy = function()
        UIListView.ClearItem("Boss2BuffItem")
        UIListView.ClearItem("HeroHeadItem")
        UIListView.ClearItem("Boss2HeroTeam")
        this.ClearUI();
    end
}

this.ParseData=function()
    this.dataGridBoss=DataMgr.Player.SeasonalBoss[tostring(SeasonSLGEventMgr.curGridIndex)]
    this.dungeonIndex=1;
    if SeasonSLGEventMgr.boss2Param~=nil and this.dataGridBoss~=nil and NumTool.GetLen(this.dataGridBoss.Battles)>=#this.curGroupCfg.DungeonGroupID then
        LuaMgr.Back();
    end
    SeasonSLGEventMgr.boss2Param=nil;
    this.isContinue=this.dataGridBoss~=nil and not IsNullOrEmpty(this.dataGridBoss.DungeonGroupId);
    if this.isContinue then
        for i,v in ipairs(this.curGroupCfg.DungeonGroupID) do
            if v==this.dataGridBoss.DungeonGroupId then
                this.dungeonIndex=i;
                break;
            end
        end
    end
    this.bossDungeonID=this.curGroupCfg.DungeonGroupID[this.dungeonIndex];
    this.cfgDungeon=ConfigMgr.Config.SeasonalGridBOSSDungeonMap[this.bossDungeonID]
    this.SetBaseInfo();
    this.SetBuffUIList();
    this.SetHeroGroupList();

end

this.SetBaseInfo=function()
    ui.txtDiffcult.text=LuaMgr.GetLangText(this.curGroupCfg.DescLan)






    ui.txtBattleInfo.text=string.format(LuaMgr.GetLangText("SeasonSlGEventBoss2ContinueInfoViewModel_2"),this.dungeonIndex);
end


this.SetBuffUIList=function()
    this.buffUIList:Clear();
    local list={};
    this.worldBuffs=SeasonSLGMapMgr.GetBoss2ChallengeBuffs()
    for i,v in ipairs(this.worldBuffs) do
        local seasonalBuff=ConfigMgr.Config.SeasonalBuffMap[v];
        if seasonalBuff~=nil then
            local buffItem={
                icon=LuaMgr.GetSprite("BuffIcon", seasonalBuff.BuffIcon);
                name=LuaMgr.GetLangText(seasonalBuff.BuffNameLan),
                level=seasonalBuff.Param[2];
                index=i,
                callBack=this.BuffClickCallBack
            }
            local buffData=UIListData.GetData(this.buffItemObj,"Boss2BuffItem",buffItem);
            table.insert(list,buffData)
        end
    end
    this.buffUIList:SetData(list);
end

this.BuffClickCallBack=function(index)
    local buffId=this.worldBuffs[index]
    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBuffDesPopUpViewModel,buffId)
end

this.SetHeroGroupList=function()
    this.teamUIList:Clear();
    local historyList={};
    local list={}
    local totalScore=0;
    if this.isContinue then

        for i,v in ipairs(this.curGroupCfg.DungeonGroupID) do
            if this.dataGridBoss.Battles[v]~=nil then
                table.insert(historyList,this.dataGridBoss.Battles[v]);
            end
        end
    end
    if #historyList>0 then
        for i,v in ipairs(historyList) do
            local heroGroup={
                index=i,
                score=v.Score,
                helps=v.Helps,
                select=this.dungeonIndex==i,
                members=v.Members,
                heroItemObj=this.heroItemObj,
            }
            totalScore=totalScore+v.Score
            local heroGroupData=UIListData.GetData(this.heroListGroup,"Boss2HeroTeam",heroGroup);
            table.insert(list,heroGroupData);
        end
    end
    if #historyList<#this.curGroupCfg.DungeonGroupID then
        if this.isContinue or this.dungeonIndex==1 then
            local heroGroup={
                index=#historyList+1;
                score=0,
                helps={},
                select=true,
                members={},
                heroItemObj=this.heroItemObj,
            }
            local heroGroupData=UIListData.GetData(this.heroListGroup,"Boss2HeroTeam",heroGroup);
            table.insert(list,heroGroupData);
        end
    end
    this.teamUIList:SetData(list);
    ui.txtScore.text=totalScore;
end



return vm({
    data = data,
    command = command,
    hook = hook
})
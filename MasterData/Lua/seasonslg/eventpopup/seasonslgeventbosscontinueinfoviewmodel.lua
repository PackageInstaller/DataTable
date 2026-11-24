require("SeasonSLG/EventPopUp/BossContinueBuffItem")
require("SeasonSLG/EventPopUp/HeroHeadItem")
require("SeasonSLG/EventPopUp/BossHeroGroup")

local this = {
    buffUIList={};
    buffItemObj=nil;
    heroGroupView={};
    heroListGroup=nil;
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
    ui.goScrollView = uiLink:Get("goScrollView");
    ui.txtPower = uiLink:Get("txtPower"):GetComponent("Text");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtRank = uiLink:Get("txtRank"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.tranBuffContent = uiLink:Get("tranBuffContent"):GetComponent("RectTransform");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button");
    ui.btnComplete = uiLink:Get("btnComplete"):GetComponent("Button");
    ui.btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        SeasonSLGEventMgr.bossContinueData=nil;
        LuaMgr.HidePanel(UIName.SeasonSlGEventBossContinueInfoViewModel)
    end)
    uiLink:AddClickEvent("btnHelp",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventBossContinueInfoViewModel_0"))
    end)
    uiLink:AddClickEvent("btnBattle",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventBossContinueInfoViewModel)
        local grid_bossDungeonId=string.format("%s_%s",SeasonSLGEventMgr.curGridIndex,this.cfgDungeon.Id)
        ActivityBattlePrepareMgr.SetMembers(ActivityKey.SeasonSLGBoss, grid_bossDungeonId);
        SeasonSLGEventMgr.bossContinueData={
            type=1,
            viewName=UIName.SeasonSlGEventBossContinueInfoViewModel,
            data= {
                eventType = this.eventType,
                bossId = this.gridBossId,
                groupId = this.curGroupCfg.Id,
            }
        }
        local dungeonTag=IsNullOrEmpty(SeasonSLGEventMgr.curTimedEventId) and "normal" or "timed"
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.SeasonSLGBoss,
                this.cfgDungeon.Id,this.eventType,SeasonSLGEventMgr.curGridIndex,this.curGroupCfg.Id,this.gridBossId,dungeonTag)
    end)
    uiLink:AddClickEvent("btnComplete",function()
        local tips=LuaMgr.GetLangText("SeasonSlGEventBossContinueInfoViewModel_1");
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tips,function()
            SeasonSLGAPI.OnAskBossBattleComplete(SeasonSLGEventMgr.curGridIndex,function()
                LuaMgr.HidePanel(UIName.SeasonSlGEventBossContinueInfoViewModel);
                LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBossPopupInfoViewModel,this.eventType,this.gridBossId);
            end)
        end,nil)
    end)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.buffUIList=UIListView.New(ui.tranBuffContent);
        this.buffItemObj=vm.behaviour.transform:Find("template/buffItem").gameObject;
        this.heroGroupView=UIScrollView.New(ui.goScrollView);
        this.heroListGroup=vm.behaviour.transform:Find("template/heroListGroup").gameObject;
        this.heroItemObj=vm.behaviour.transform:Find("template/headItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>2 then
            SeasonSLGEventMgr.bossContinueData=nil;
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
        this.heroGroupView:Clear();
    end,
    before_destroy = function()
        UIListView.ClearItem("BossContinueBuffItem")
        UIListView.ClearItem("HeroHeadItem")
        UIScrollView.ClearItem("BossHeroGroup")
        this.ClearUI();
    end
}

this.ParseData=function()
    local rankData=SeasonSLGEventMgr.bossRankMap[tostring(SeasonSLGEventMgr.curGridIndex)]
    if rankData~=nil then

        ui.txtRank.text=rankData.Rank;
    else

        ui.txtRank.text=LuaMgr.GetLangText("SeasonSlGEventBossContinueInfoViewModel_2");
    end
    this.dataGridBoss=DataMgr.Player.SeasonalBoss[tostring(SeasonSLGEventMgr.curGridIndex)]
    this.dungeonIndex=1;
    this.isContinue=this.dataGridBoss~=nil and not IsNullOrEmpty(this.dataGridBoss.DungeonGroupId) and
            this.dataGridBoss.Battles[this.dataGridBoss.DungeonGroupId]==nil;
    if this.dataGridBoss~=nil and not IsNullOrEmpty( this.dataGridBoss.DungeonGroupId) then
        for i,v in ipairs(this.curGroupCfg.DungeonGroupID) do
            if v==this.dataGridBoss.DungeonGroupId then
                this.dungeonIndex=i;
                break;
            end
        end
    end
    this.bossDungeonID=this.curGroupCfg.DungeonGroupID[this.dungeonIndex];
    this.cfgDungeon=ConfigMgr.Config.SeasonalGridBOSSDungeonMap[this.bossDungeonID]
    local costItem=this.cfgDungeon.Consume[1]
    local path=ConfigHelper.GetItemHomeIconPath(costItem.id)
    ui.rawCostIcon.texture=LuaMgr.GetTexture(path);
    ui.txtCostCount.text=costItem.count;
    this.SetBuffUIList();
    this.SetHeroGroupList();
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
            local buffData=UIListData.GetData(this.buffItemObj,"BossContinueBuffItem",buffItem);
            table.insert(list,buffData)
        end
    end
    this.buffUIList:SetData(list);
end

this.BuffClickCallBack=function(index)
    local buffId=this.cfgDungeon.BuffGroup[index]
    LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBuffDesPopUpViewModel,buffId)
end

this.SetHeroGroupList=function()
    this.heroGroupView:Clear();
    local historyList={};
    local list={}
    if this.dataGridBoss~=nil and not IsNullOrEmpty(this.dataGridBoss.DungeonGroupId) and this.dataGridBoss.Battles~=nil then

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
                score=v.Damage,
                helps=v.Helps,
                select=this.dungeonIndex==i,
                members=v.Members,
                heroItemObj=this.heroItemObj,
            }
            local heroGroupData=UIScrollData.GetData(this.heroListGroup,"BossHeroGroup",650,154,heroGroup);
            table.insert(list,heroGroupData);
        end
    end
    if #historyList<#this.curGroupCfg.DungeonGroupID then
        if  this.isContinue or this.dataGridBoss==nil or IsNullOrEmpty(this.dataGridBoss.DungeonGroupId) then
            local heroGroup={
                index=#historyList+1;
                score=0,
                helps={},
                select=true,
                members={},
                heroItemObj=this.heroItemObj,
            }
            local heroGroupData=UIScrollData.GetData(this.heroListGroup,"BossHeroGroup",613,154,heroGroup);
            table.insert(list,heroGroupData);
        end
    end
    this.heroGroupView:SetParams(630,370);
    this.heroGroupView:SetData(list);
end



return vm({
    data = data,
    command = command,
    hook = hook
})
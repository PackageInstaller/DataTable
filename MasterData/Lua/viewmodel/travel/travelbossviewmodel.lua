





require("ViewModel/Travel/Travel_AwardItem")
local this = {vm=nil, 
              awardUIList={},
              awardItemObj=nil;
              
};

local curBarIndex=nil;
local cfgBossList=nil;
local dataTravel=nil;
local battleBossStageLv=nil;
local animator=nil;
local remainBattleCount=nil;



local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local textInfor = nil;
local textCount = nil;
local tranReward = nil;
local btnSerach = nil;
local goTip=nil;
local textTip=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    textInfor = uiLink:Get("textInfor"):GetComponent("Text");
    textCount = uiLink:Get("textCount"):GetComponent("Text");
    tranReward = uiLink:Get("tranReward"):GetComponent("RectTransform");
    btnSerach = uiLink:Get("btnSerach"):GetComponent("Button");
    goTip=uiLink:Get("goTip");
    textTip= uiLink:Get("textTip"):GetComponent("Text");
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    textInfor = nil;
    textCount = nil;
    tranReward = nil;
    btnSerach = nil;
    goTip=nil;
    textTip=nil;
end


local data = {
    barList={
        {
            isSelect=false,
            scale=Vector3.one
        },
        {
            isSelect=false,
            scale=Vector3.one
        },
        {
            isSelect=false,
            scale=Vector3.one
        }
    }
    
}

local command = {

    barBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            if index==curBarIndex then return end;
            curBarIndex=index;
            animator:Play("ani_TravelBossPanel_root_002",0,0);
            this.SwitchBarState();
        end
    },
    searchBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if remainBattleCount<=0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7503"));
                return;
            end
            local dungeonId=cfgBossList[curBarIndex].BossLevel;
            HeroParameter.TravelBossBarIndex=curBarIndex;
            BattlePrepareMgr.EnterBattlePrepare(dungeonId,dungeonId,BattlePrepareMgr.BattleType.Travel);
        end
    },
  

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.awardUIList=UIListView.New(tranReward);
        this.awardItemObj=vm.behaviour.transform:Find("template/awardItem").gameObject
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", function()
                HeroParameter.TravelBossBarIndex=nil;
                LuaMgr.Back();
            end)
            curBarIndex=1;
            if HeroParameter.TravelBossBarIndex~=nil then
                curBarIndex=HeroParameter.TravelBossBarIndex;
            end
            cfgBossList={}
            for i,v in pairs(ConfigMgr.Config.TravelBossMap) do
                table.insert(cfgBossList,v);
            end
            table.sort(cfgBossList,function(a, b) return a.Id<b.Id end)
            animator:Play("ani_TravelBossPanel_root_001",0,0);
           this.ParseData();
        end
    end,
    before_deactive = function(vm)
       
    end,
    before_destroy=function()
        this.Clear();
        UIListView.ClearItem("Travel_AwardItem")
    end
}



this.ParseData=function()
    dataTravel=DataMgr.Player.travel
    remainBattleCount=dataTravel.BattleBossCount;
    battleBossStageLv=DataMgr.Player.travel.BattleBossStageLv;
    this.SwitchBarState()
end

this.SwitchBarState=function()
    for i,v in ipairs(this.vm.data.barList) do
        v.isSelect=i==curBarIndex;
        v.scale=i==curBarIndex and Vector3.one or Vector3.one*0.88
    end
    this.SetInfors();
end

this.SetInfors=function()
    local dungeonMap=ConfigMgr.Config.dungeonMap;
    local cfgBoss=cfgBossList[curBarIndex]
    textInfor.text=LuaMgr.GetLangText(dungeonMap[cfgBoss.BossLevel].descriptionLan)
    textCount.text=string.format(ConfigMgr.LangGlobal("7502"),remainBattleCount);
    this.SetAwardList(cfgBoss);
end

this.SetAwardList=function(cfgBoss)
    local list={}
    local hurtLevel,hurtNum=this.GetLevelAndHurt(cfgBoss.DamageShow,cfgBoss.BossLevel);
    for i,v in ipairs(cfgBoss.DamageShow) do
        local item={
            rate=v[1];
            hurt=ConfigMgr.LangGlobal(cfgBoss.DamageShowInfo[i]);
            isLast=battleBossStageLv[cfgBoss.BossLevel]~=nil and hurtLevel==i;
            lastHurt=hurtNum;
            award=cfgBoss.RewardShow[i]
        }
        local itemData=UIListData.GetData(this.awardItemObj,"Travel_AwardItem",item);
        table.insert(list,itemData);
    end
    this.awardUIList:SetData(list);
    SetActive(goTip,hurtLevel==0)
    textTip.text=ConfigMgr.LangGlobal("7509")
   
end

this.GetLevelAndHurt=function(range,level)
    local hurtNum=battleBossStageLv[level]
    if hurtNum==nil then
        return -1,0;
    end
    if hurtNum>=tonumber(range[3][2]) then
        return 3,hurtNum;
    elseif hurtNum>tonumber(range[2][2]) and hurtNum<=tonumber(range[2][3]) then
        return 2,hurtNum
    elseif hurtNum>tonumber(range[1][2]) then
        return 1,hurtNum;
    else
        return 0,hurtNum;
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})
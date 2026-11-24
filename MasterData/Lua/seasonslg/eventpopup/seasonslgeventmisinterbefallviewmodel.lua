require("SeasonSLG/EventPopUp/EventTimeRewardItem")
require("SeasonSLG/EventPopUp/EventTimeRewardBuffItem")
require("ViewModel/Activity/ActivityBattlePrepareEnemyItem")
local this = {
   rewardUIList={};
   rewardItemObj=nil;
   buffItemObj = nil,
   enemyItem = nil,
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
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnHelp = uiLink:Get("btnHelp"):GetComponent("Button");
    ui.btnSelf = uiLink:Get("btnSelf"):GetComponent("Button");
    ui.btnAll = uiLink:Get("btnAll"):GetComponent("Button");
    ui.btnBattle = uiLink:Get("btnBattle"):GetComponent("Button");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.txtProgressValue = uiLink:Get("txtProgressValue"):GetComponent("Text");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.txtRewardDes = uiLink:Get("txtRewardDes"):GetComponent("Text");
    ui.txtRewardDes1 = uiLink:Get("txtRewardDes1"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.imgProgress = uiLink:Get("imgProgress"):GetComponent("Image");
    ui.tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");
    ui.goBuffMiniDescItem = uiLink:Get("goBuffMiniDescItem");
    ui.tranBuffMiniDescItem = ui.goBuffMiniDescItem.transform:GetComponent("RectTransform");
    ui.tranBuffMiniDescContent = ui.goBuffMiniDescItem.transform:Find("Image"):GetComponent("RectTransform");
    ui.txtBuffMiniDesc = ui.goBuffMiniDescItem.transform:Find("Image/txtWorldProgressReward"):GetComponent("Text");
    ui.scrollRectBuff = uiLink:Get("scrollRectBuff").gameObject;
    ui.txtLocation=uiLink:Get("txtLocation"):GetComponent("Text");
    ui.enemyContent = ui.Right.transform:Find("EnemyGroup/tranEnemyContent").gameObject
    ui.bossFlag = ui.Right.transform:Find("BossFlag").gameObject
    ui.txtEnter = uiLink:Get("txtEnter"):GetComponent("Text");
    SetActive(ui.goBuffMiniDescItem, false);
    this.AddRegister(uiLink)
end


this.ClearUI = function()ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventMisinterBefallViewModel)
    end)
    uiLink:AddClickEvent("btnHelp",function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSlGEventMisinterBefallViewModel_0"))
    end)
    uiLink:AddClickEvent("btnSelf",function()
        this.SwitchRewardType(1)
    end)
    uiLink:AddClickEvent("btnAll",function()
        this.SwitchRewardType(2)
    end)
    local func = function()
        LuaMgr.HidePanel(UIName.SeasonSlGEventMisinterBefallViewModel)
        local param0 = ActivityKey.SeasonSLG
        local data = {}
        data.BattleKey = SeasonSLGConst.BattleKey
        data.GridIndex = SeasonSLGEventMgr.curGridIndex
        data.EventType = this.eventType
        data.BattleTag = "timed"
        data.SeasonalTimedEvent = SeasonSLGEventMgr.curTimedEventId
        data.DungeonID = this.dungeonID
        data.SeasonalGridWorldAttackID = this.attackCfgId
        data.ActivityDungeonId = this.dungeonID
        data.EventId = this.attackCfgId
        LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel,param0,data)
        SeasonSLGMapMgr.SetLastMinimapGrid(SeasonSLGEventMgr.curGridIndex)
    end
    uiLink:AddClickEvent("btnBattle", func)
end

this.SetServerData = function(data)
    this.fullProgress = 0
    local eventProgress = data.TimedEventProgress
    if eventProgress == nil then
        return
    end
    local timedProgressData = eventProgress[tostring(SeasonSLGEventMgr.curGridIndex)]
    if timedProgressData == nil then
        return
    end
    this.fullProgress = timedProgressData.Progress
    local stepTimeInterval,startTime = SeasonSLGTimeEventMgr.GetTimedEventInterval(timedProgressData)
    this.eventEndTime = startTime + (stepTimeInterval[#stepTimeInterval] or 0)
    this.StartCountDown()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour)
        this.rewardUIList=UIListView.New(ui.tranRewardContent);
        this.enemyContentUIList = UIScrollView.New(ui.enemyContent);
        this.scrollRectBuffUI = UIScrollView.New(ui.scrollRectBuff)
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        this.buffItemObj=vm.behaviour.transform:Find("template/buffItem").gameObject;
        this.enemyItem=vm.behaviour.transform:Find("template/EnemyItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length>1 then
            this.eventType=vm.behaviour.Params[0]
            this.attackCfgId=vm.behaviour.Params[1]
            this.cfgAttack=ConfigMgr.Config.SeasonalGridWorldAttackMap[this.attackCfgId]
                    or ConfigMgr.Config.SeasonalGridWorldAttackMap[tostring(this.attackCfgId)];
            if this.cfgAttack==nil then
                return
            end
            local eventDungeonMap = this.cfgAttack.SeasonalPersonalDungeons
            if eventDungeonMap == nil then
                return
            end
            local randomIndex = RandomNum(1, #eventDungeonMap)
            this.dungeonID = eventDungeonMap[randomIndex]
            SetActive(ui.bossFlag, this.cfgAttack.ShowIcon==1)
            this.SetServerData(vm.behaviour.Params[2])
            this.SetEnemyUIList()
            SetActive(ui.goProgress,true)
            this.SetProgress()
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        this.StopCountDown();
        if (vm.behaviour.Params == nil) then return end
        this.rewardUIList:Clear();
        UIListView.ClearItem("EventTimeRewardItem")
        SetActive(ui.goBuffMiniDescItem, false);
        this.rewardType=nil;
    end,
    before_destroy = function()
        this.StopCountDown();
        UIScrollView.ClearItem("ActivityBattlePrepareEnemyItem")
        UIScrollView.ClearItem("EventTimeRewardBuffItem")
        this.ClearUI();
    end
}

this.ParseData=function()
    ui.txtTitle.text=LuaMgr.GetLangText(this.cfgAttack.NameLan);
    ui.txtDes.text=LuaMgr.GetLangText(this.cfgAttack.DescLan);
    ui.txtEnter.text = SeasonSLGMapMgr.CheckBlockEventsCanFastBattle(SeasonSLGEventMgr.curGridIndex,this.cfgAttack.Id,this.cfgAttack.DungeonBattle,true)
            and LuaMgr.GetLangText("SeasonSlGEventMisinterBefallViewModel_1") or LuaMgr.GetLangText("SeasonSlGEventMisinterBefallViewModel_2")
    local des=LuaMgr.GetLangText("SeasonSlGEventMisinterBefallViewModel_3")
    ui.txtRewardDes.text=des;
    ui.txtRewardDes1.text=des;
    ui.txtLocation.text=SeasonSLGMapMgr.GetLocationPositionStr(SeasonSLGEventMgr.curGridIndex)
    this.dataTimeEvent=DataMgr.Player.SeasonalTimedEvent[tostring(SeasonSLGEventMgr.curGridIndex)]
    local costItem=this.cfgAttack.SeasonalMonsterCost[1]
    if costItem~=nil then
        local path=ConfigHelper.GetItemHomeIconPath(costItem.id)
        ui.rawCostIcon.texture=LuaMgr.GetTexture(path);
        ui.txtCostCount.text=costItem.count;
    end
    this.SwitchRewardType(1)

end

this.FormatCountDownTime=function(timeLeft)
    local day,hour,min,sec=GetTimeDHMS2(math.max(0,math.floor(timeLeft)));
    if day>0 then
        local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_10908")
        return string.format(content,day,hour,min);
    end
    local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35131")
    return string.format(content,hour,min,sec);
end

this.RefreshCountDown=function()
    local timeLeft=this.eventEndTime-LuaMgr.Timestamp();
    ui.txtTime.text=this.FormatCountDownTime(timeLeft);
    if timeLeft<=0 then
        this.StopCountDown();
    end
end

this.StartCountDown=function()
    if this.eventEndTime==nil then
        ui.txtTime.text="";
        return;
    end
    this.RefreshCountDown();
    if this.eventEndTime>LuaMgr.Timestamp() then
        LuaMgr.AddTimer(TimerConst.SeasonSLGMisinterCountDown,this.RefreshCountDown,1,-1,true);
    end
end

this.StopCountDown=function()
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGMisinterCountDown);
    this.eventEndTime=nil;
end

this.SetProgress = function()
    local totalHp=this.cfgAttack.SeasonalMonsterHP or 1
    this.progressRate=this.fullProgress/totalHp
    if this.progressRate>1 then
        this.progressRate=1;
    end
    if this.progressRate<0 then
        this.progressRate=0;
    end
    local finalProgress = 1-this.progressRate
    if this.progressRate == 0 then
        ui.txtProgressValue.text=string.format("%.0f%%",finalProgress*100);
    else
        ui.txtProgressValue.text=string.format("%.1f%%",finalProgress*100);
    end
    ui.imgProgress.fillAmount=finalProgress;
end

this.SwitchRewardType=function(index)
    if this.rewardType~=nil and this.rewardType==index then
        return;
    end
    SetActive(ui.goActiveSelf,index==1);
    SetActive(ui.goActiveAll,index==2);
    SetActive(ui.goBuffMiniDescItem, false);
    this.rewardType=index;
    this.isComplete=index==1 and DataHelper.CheckDungeonComplete(this.dungeonID);
    SetActive(ui.btnBattle.gameObject,true);
    SetActive(ui.tranRewardContent.gameObject, false)
    SetActive(this.scrollRectBuffUI.gameObject, false)
    if index==1 then
        SetActive(ui.tranRewardContent.gameObject, true)
        this.rewardList=this.cfgAttack.FirstReward;
        this.SetRewardUIList();
    else
        SetActive(this.scrollRectBuffUI.gameObject, true)
        this.SetBuffUIList();
    end
end

this.SetEnemyUIList=function()
    this.enemyContentUIList:Clear();
    local dungeonConfig =ConfigMgr.Config.dungeonMap[this.dungeonID]
    if dungeonConfig == nil then
        return
    end
    local monsterList = ConfigHelper.GetEnemyList(this.dungeonID)
    local list={};
    this.dungeonConfig = dungeonConfig
    this.monsterList = monsterList
    for i,data in ipairs(monsterList) do
        if data ~= nil and not data.hideShowinfo then
            data.OnClickBtn = this.OnClicEnemyItem
            local listData=UIScrollData.GetData(this.enemyItem,"ActivityBattlePrepareEnemyItem",76,76,data);
            table.insert(list,listData);
        end
    end
    this.enemyContentUIList:SetParams(462, 80)
    this.enemyContentUIList:SetData(list);
end

this.OnClicEnemyItem = function(item)
    if this.dungeonConfig == nil or this.monsterList == nil then
        LuaDebug.error("配置有误 SeasonSlGEventMisinterBefallViewModel AddRegister 88")
        return
    end
    LuaMgr.HidePanel(UIName.SeasonSlGEventMisinterBefallViewModel)
    LuaMgr.ShowLuaPanel(UIName.BattlePrepareEnemyViewModel, this.dungeonConfig, this.monsterList);
end

this.SetRewardUIList=function()
    this.rewardUIList:Clear();
    local list={};
    for i,v in ipairs(this.rewardList) do
        local rewardItem={item=v,isComplete=false}
        local rewardData=UIListData.GetData(this.rewardItemObj,"EventTimeRewardItem",rewardItem);
        table.insert(list,rewardData);
    end
    this.rewardUIList:SetData(list);
end

this.SetBuffUIList=function()
    this.scrollRectBuffUI:Clear();
    local list={};
    local seasonBuffConfig = ConfigMgr.Config.SeasonalBuffMap[this.cfgAttack.SeasonalPersonalBuff]
    if seasonBuffConfig == nil then
        LuaDebug.error("297 this.SetBuffUIList 曲解BUFF配置错误")
        return
    end
    for i = 1, 1 do
        local data = {}
        data.index=i
        data.config=seasonBuffConfig
        data.onClick=this.OnClickBuff
        local buffData=UIScrollData.GetData(this.buffItemObj,"EventTimeRewardBuffItem",80,80,data);
        table.insert(list,buffData);
    end
    this.scrollRectBuffUI:SetParams(602, 80)
    this.scrollRectBuffUI:SetData(list);
end

this.OnClickBuff=function(buffData)
    ui.txtBuffMiniDesc.text=LuaMgr.GetLangText(buffData.config.BuffDesLan);
    local pos=ui.tranBuffMiniDescItem.position;
    pos.x=buffData.itemTransform.position.x;
    ui.tranBuffMiniDescItem.position=pos;

    local contentRect=ui.tranBuffMiniDescContent.rect;
    local panelRect=ui.tarRect.rect;
    local contentLeft=ui.tranBuffMiniDescContent:TransformPoint(Vector3(contentRect.xMin,0,0)).x;
    local contentRight=ui.tranBuffMiniDescContent:TransformPoint(Vector3(contentRect.xMax,0,0)).x;
    local panelLeft=ui.tarRect:TransformPoint(Vector3(panelRect.xMin,0,0)).x;
    local panelRight=ui.tarRect:TransformPoint(Vector3(panelRect.xMax,0,0)).x;
    if contentLeft<panelLeft then
        pos.x=pos.x+panelLeft-contentLeft;
    elseif contentRight>panelRight then
        pos.x=pos.x-(contentRight-panelRight);
    end
    ui.tranBuffMiniDescItem.position=pos;
    local localPos = ui.tranBuffMiniDescItem.localPosition
    localPos.x = localPos.x + 40
    ui.tranBuffMiniDescItem.localPosition = localPos
    SetActive(ui.goBuffMiniDescItem,true);
    SetActive(ui.tranBuffMiniDescItem.gameObject,true);
end


return vm({
    data = data,
    command = command,
    hook = hook
})
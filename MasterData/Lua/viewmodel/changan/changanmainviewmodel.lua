




local this = {
    vm=nil,
    curNovel=nil,
    remainTime=0,
    dailyShopRemainTime=0,
    seek=0;
              
};
local objs={
    pointRoot={path="root/Middle/points",type="Transform"}, 
    animator={path="root",type="Animator"},
 }

local data = {
    time="";
    novelList={
        {
            loc="301",
            name="",
            isActive=false,

            sprite=DefaultSprite,
            isTime=false,
        },
        {
            loc="302",
            name="",
            isActive=false,

            sprite=DefaultSprite,
            isTime=false,
        }, 
        {
            loc="303",
            name="",
            isActive=false,

            sprite=DefaultSprite,
            isTime=false,
        }
    },
    runShopTime="",
    runshopBool=false,
    runShopLocPos=Vector2(330,-110);
    novelRecordBtnBool=false,
    isLevelShopBool=false,
    isRouletteBool=false,
activeRunningBool=false;
}

local command = {

    novelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.curNovel~=nil and this.curNovel.eventParam~="" then
                if not this.curNovel.isOpening then
                    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10002"].NameLan)
                    local openTime=this.curNovel.openDate;
                    local tip = os.date(LuaMgr.GetLangText("ChanganMainViewModel_5"),openTime)
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,tip));
                    return
                end
                local novelId=this.curNovel.eventParam;
                LuaMgr.PlayNovel(novelId,function()

                    LuaMgr.Back();
                end)
            end
        end
        
    },
    shopDailyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ChanganDailyShopViewModel);
        end
    },
    shopLevelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ChanganLevelShopViewModel);
        end
    },
    taskBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.ChanganTaskViewModel);
        end
    },
    shopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           LuaMgr.ShowLuaPanel(UIName.ChanganShopViewModel);
        end
    },
    levelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if DataExHelper.Check_ChanganRunning() and this.remainTime<=0 then
               LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10004")) 
                return
            end
            LuaMgr.ShowLuaPanel(UIName.ChanganLevelViewModel)
        end
    },
    yunyouBtn= {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not DataExHelper.Check_TourismRuning() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ChanganMainViewModel_0"));
                return;
            end
           LuaMgr.ShowLuaPanel(UIName.ActivityTourismPanelViewModel)
        end
    },
    novelRecordBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           LuaMgr.ShowLuaPanel(UIName.ChanganNovelViewModel)
        end
    },
    rouletteBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.ChanganRouletteViewModel)
        end
    }
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        UITool.Parse(vm.behaviour,this,objs);
        RedMgr.Singleton:RegisterViewModel(UIName.ChanganMainViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            vm.behaviour:UpdateTopBar("", this.OnBack);
            HeroRedDataHelper.SetChanganRed();
            ChanganMgr.InitData();
            this.dailyShopRemainTime=0
            if not vm.behaviour.IsPop then
                this.seek=os.time()
                this.animator:Play("UI_ChanganMainPanel01",0,0)
            else
                this.animator:Play("UI_ChanganMainPanel02",0,0)
            end






            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveTimer(TimerConst.ChanganTimer);
        end
    end,
    before_destroy=function()
         this.Clear();
    end
        
    
}
this.OnBack=function()
    if not DataExHelper.Check_ChanganRunning() then
        LuaMgr.Back();
    else
        LuaMgr.Back("changan");
    end
end
this.Clear=function()
    this.curNovel=nil;
    this.remainTime=nil;
end

this.ParseData=function()
    this.vm.data.activeRunningBool=DataExHelper.Check_ChanganRunning();
    local levelGroup1=ChanganMgr.changanMapEventList[1]
    local dgRcds=DataMgr.Player.dungeonRecords;
    this.CheckShowNovel();
    if DataExHelper.Check_ChanganRunning() then
        this.vm.data.isLevelShopBool=dgRcds[levelGroup1[1].eventParam]~=nil and dgRcds[levelGroup1[1].eventParam].completeCount>0;
        this.vm.data.isRouletteBool=dgRcds[levelGroup1[2].eventParam]~=nil and dgRcds[levelGroup1[2].eventParam].completeCount>0;
        this.SetTime();
    end
    
end


this.IsCompleteNovel=function(novelId)
    local completeNovels=DataMgr.Player.completedChapters;
    for i,v in ipairs(completeNovels) do
        if v==novelId then
            return true;
        end
    end
    return false;
end

this.CheckShowNovel=function()
    if #ChanganMgr.changanNovelEventList==0 then return end;
    local isNovelRecord=false















    
    this.curNovel=nil;
    for i,v in ipairs(ChanganMgr.changanNovelEventList) do
        if  DataHelper.CheckNovelComplete(v.eventParam) then
            isNovelRecord=true;
        elseif IsNullOrEmpty(v.unlockParam) or DataHelper.CheckNovelComplete(v.unlockParam) then
            this.curNovel=v;
            break;
        end
    end
    
    this.vm.data.novelRecordBtnBool=DataExHelper.Check_ChanganRunning() and isNovelRecord;
    if this.curNovel==nil then
        for i,v in ipairs(this.vm.data.novelList) do
            v.isActive=false;

        end
        return
    end;
    local loc=this.curNovel.classId;
    local index=0;
    for i,v in ipairs(this.vm.data.novelList) do
        v.isActive=v.loc==loc;

        v.name=v.loc==loc and LuaMgr.GetLangText(this.curNovel.namelan) or "";
        if v.isActive then
            index=i
        end
    end
    if this.curNovel.openDate~=nil then
        local isOpeningTime=false;
        if this.curNovel.openDate==0 and this.curNovel.closeDate then
            isOpeningTime=true;
        elseif LuaMgr.Timestamp()>=this.curNovel.openDate and LuaMgr.Timestamp()<this.curNovel.closeDate then
            isOpeningTime=true;
        end
        this.curNovel.isOpening=isOpeningTime;
        this.vm.data.novelList[index].sprite=isOpeningTime and LuaMgr.GetSprite("Changan","ui_ca_qp2_di") or LuaMgr.GetSprite("Changan","ui_ca_qp2_di02")
        this.vm.data.novelList[index].isTime=isOpeningTime;
    else
        this.vm.data.novelList[index].sprite=LuaMgr.GetSprite("Changan","ui_ca_qp2_di")
        this.vm.data.novelList[index].isTime=true;
    end
    
end
this.SetTime=function()
    local actChangan=nil;
    local actMap=ConfigMgr.Config.activityMapList
    for i,v in ipairs(actMap) do
        if v.area=="changan" then
            actChangan=v;
        end
    end
    local curTime=LuaMgr.Timestamp();
    local endTime=actChangan.closeDate;
    this.remainTime=endTime-curTime;
    LuaMgr.RemoveTimer(TimerConst.ChanganTimer);
    LuaMgr.AddTimer(TimerConst.ChanganTimer,this.Timer,30,-1,true);

end


this.Timer=function()

    if this.dailyShopRemainTime<=0 then
        this.SetRunDailyShop();
    end
    if this.dailyShopRemainTime>0 then
        local shop_hour=math.floor(this.dailyShopRemainTime/(60*60));
        local shop_min=math.floor(this.dailyShopRemainTime%(60*60)/60);
        if shop_hour>0 then
            this.vm.data.runShopTime=string.format(LuaMgr.GetLangText("ChanganMainViewModel_1"),shop_hour);
        else
            this.vm.data.runShopTime=string.format(LuaMgr.GetLangText("ChanganMainViewModel_2"),shop_min);
        end
    end

    if this.remainTime<=0 then
        LuaMgr.RemoveTimer(TimerConst.ChanganTimer);
        this.vm.data.time=LuaMgr.GetLangText("ChanganMainViewModel_3");
        return;
    end
    local day=math.floor(this.remainTime/(24*60*60));
    local daySec=this.remainTime%(24*60*60);
    local hour=math.floor(daySec/(60*60));
    local min=math.floor(daySec%(60*60)/60);
    this.vm.data.time=string.format(LuaMgr.GetLangText("ChanganMainViewModel_4"),day,hour,min);
    this.remainTime=this.remainTime-1;
    
end
    
    


this.SetRunDailyShop=function()
    local curTime=LuaMgr.Timestamp();
    local date=os.date("*t",curTime);
    local startTime=os.time({year=date.year,month=date.month,day=date.day,hour=8,min=0,sec=00});
    local endTime=os.time({year=date.year,month=date.month,day=date.day,hour=22,min=0,sec=00});
    if curTime<startTime or curTime>endTime then
        this.vm.data.runshopBool=false;
        this.dailyShopRemainTime=0
        return
    end
    this.vm.data.runshopBool=true;
    this.vm.data.runShopLocPos=this.GetRunDailyShopPos();
    this.dailyShopRemainTime=endTime-curTime;
    
end

this.GetRunDailyShopPos=function()
    local count=this.pointRoot.childCount;
    math.randomseed(this.seek);
    local childIndex=math.random(1,count);
    return this.pointRoot:GetChild(childIndex-1).anchoredPosition;
end





return vm({
    data = data,
    command = command,
    hook = hook
})
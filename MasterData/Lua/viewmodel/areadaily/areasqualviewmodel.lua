





local this = { vm = nil,
               dataMoreModData = {},

               squadPosList = { { pos = Vector2(-12, 256) },
                                { pos = Vector2(16, 186) },
                                { pos = Vector2(16, 120) },
                                { pos = Vector2(16, 60) },
               },
               cfgmoreModeConstants={},
               cfgmoreModList={},
               moreModTheme = nil,
               moreModExpires = nil,
               moreRemainTime = nil,
               adText = nil,
               adTweenter = nil,
               adTweenter1 = nil,
               coKey = nil,
               remainDay = nil,
               coKeyTheme = nil,
               path = "Assets/_BundleResources/Images/Squal/",
}

local bgSpineConfig={
    chun={spineName="Xiangqi001_chun",pos=Vector3(-62,-371,0)},
    xia={spineName="Xiangqi001_xia",pos=Vector3(0,0,0)},
}
local tranSpine=nil;
local isADFirst=false;
local curTheme=nil;
local curThemeObj=nil;
local data = {



    themeList={
        {
            icon=DefaultSprite,
            pos=Vector2(0,0),
            scale=Vector3(1,1,1),
            nameSprite=DefaultSprite,
            locktime="",
            isLock=false,
            isOpen=false,
            isActive=false,
        }
    };
    
    timeDay="";
    timeHour="";
    timeMin="";
    
    
    squadPanel=false;
    squadCostIcon=DefaultTexture;
    squadCostCount="";
    startBtnBool=false;
    continueBtnBool=false;
    squadTimer="";
    squadContentBool=true;
    squadCostBool=false;
    mainBgTexture=DefaultTexture;

    adPos=Vector2(1680,0);
    ad1Pos=Vector2(1680,0);
    yellowPointBool=false;
    isBG_Drawing=false;
    isBG_Spine=false;

    isLockStart=false,
    isLockReward=false,
    isTeachingPass=false;
    letterSprite=DefaultSprite,
    taskSprite=DefaultSprite,
    taskTagSprite=DefaultSprite,
    startSprite=DefaultSprite,
    startTagSprite=DefaultSprite,

    debugBtnActive = false,
}

local command = {
   
    resBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           
        end
    },
    squadStartBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.RefreshTimeRed()
            local re=this.CheckCharacterLevel();
            local constRe=this.CheckPlayerItems();
            if  not constRe then
                local itemNameLan=ConfigHelper.GetItemNamelan(this.cfgmoreModeConstants.SingleRoundTickets.id);
                local itemName=LuaMgr.GetLangText(itemNameLan)
                local info=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2238"].NameLan);
                local tip=string.format(info,itemName);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tip);
                return;
            end

            if not re then
                local info=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2239"].NameLan);
                local tip=string.format(info,ConfigMgr.Config.moreModConstants.MinLevelLimit);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tip);
                return;
            end

            ApiMgr.Request("moremod/open_theme", { } ,true,function()
                UnityEngine.PlayerPrefs.SetInt("open_theme",0);
                LuaMgr.ShowLuaPanel(UIName.AreaSquadLevelViewModel);
            end,nil,true)
        end
    },
    scoreBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.AreaSqualTaskViewModel,this.moreModTheme);
        end
    },
    continueBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.RefreshTimeRed()
            LuaMgr.ShowLuaPanel(UIName.AreaSquadLevelViewModel);
        end
    },
    squadAreaBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)
            local isLock=this.vm.data.squadArealock[index]
            if isLock then
                local nameLan=ConfigMgr.Config.langGlobal["2249"].NameLan
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(nameLan));
            end
        end
    },
    squadShopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.AreaSqualShopViewModel);
        end
    },
    weekFreeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.AreaSqualJointViewModel)
        end
    },
    teachingBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.RefreshTimeRed()
            LuaMgr.ShowLuaPanel(UIName.AreaSqualTeachingViewModel)
        end
    },
    lockRewardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local isPass,id=HeroRedDataHelper.MoreModCheckPassTeaching();
            if not isPass then
                local name=LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[id].NameLan)
                local tips=string.format(ConfigMgr.LangGlobal("7063"),name);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
            end
        end
    },
    lockStartBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local isPass,id=HeroRedDataHelper.MoreModCheckPassTeaching();
            if not isPass then
                local name=LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[id].NameLan)
                local tips=string.format(ConfigMgr.LangGlobal("7063"),name);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
            end
        end
    },
    debugBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if LuaMgr.IsDebug() then
                LuaMgr.ShowLuaPanel(UIName.MoreModTestViewModel)
            end
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.adText=vm.behaviour.transform:Find("root/Middle/BG/Image/AD/"):GetComponent("Text");
        tranSpine=vm.behaviour.transform:Find("root/Middle/BG/tranSpine"):GetComponent("Transform");
        RedMgr.Singleton:RegisterViewModel(UIName.AreaSqualViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        LuaMgr.AddUIEventListener(UIEventConst.FatigueReply, this.UpdateFatigue);
        LuaMgr.AddUIEventListener(UIEventConst.HeartAcrossDay,this.HeartAcrossDay);
        this.cfgmoreModeConstants=ConfigMgr.Config.moreModConstants;

        this.vm.data.isBG_Drawing=true;
        this.vm.data.mainBgTexture=LuaMgr.GetTexture(Path.Image.."Squal/ui_dzr_bj_chun.png");
        this.vm.data.taskSprite=LuaMgr.GetSprite("Squad","ui_dzr_jsjl_chun")
        this.vm.data.letterSprite=LuaMgr.GetSprite("Squad","ui_dzr_jssx_chun")
        this.vm.data.startSprite=LuaMgr.GetSprite("Squad","ui_dzr_btn_chun");
        this.vm.data.startTagSprite=LuaMgr.GetSprite("Squad","ui_dzr_xq_an1_chun");
        this.vm.data.taskTagSprite=LuaMgr.GetSprite("Squad","ui_dzr_xq_icon1_chun");
        
        this.vm.data.isBG_Spine=not SettingHelper.IsImageLow();
        
        this.vm.data.debugBtnActive = LuaMgr.IsDebug()
        isADFirst=true;
        this.SetAD();
        this.ParseData()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartAcrossDay,this.HeartAcrossDay);
        LuaMgr.RemoveUIEventListener(UIEventConst.FatigueReply, this.UpdateFatigue)
        LuaMgr.RemoveTimer(TimerConst.MoreModExprie)
        if this.adTweenter~=nil then
            this.adTweenter:Kill();
        end
        if this.adTweenter1~=nil then
            this.adTweenter1:Kill();
        end

        if this.coKey~=nil then
            coroutine_runner.stop(this.coKey);
        end
        HeroParameter.moreModeTheme=nil
    end,
    before_destroy=function(vm)
        this=nil
    end
}

this.RefreshTimeRed = function()
    local redID, redID1 = "15111", "15111_1"
    RedMgr.Singleton:FrushRedCondition(redID)
    RedMgr.Singleton:FrushRedCondition(redID1)
    HeroRedDataHelper.FrushMoreModRed()
end

this.UpdateFatigue=function()
    this.ParseData();
end

this.HeartAcrossDay=function()
    this.ParseData();
end


this.ParseData=function()
    this.dataMoreModData=DataMgr.Player.moreModData;
    this.vm.data.isLockStart=not HeroRedDataHelper.MoreModCheckPassTeaching()
    this.vm.data.isLockReward=not HeroRedDataHelper.MoreModCheckPassTeaching()
    this.vm.data.isTeachingPass=HeroRedDataHelper.MoreModCheckPassTeaching();
    this.ShowSquadPanel();
    this.SetYellowRed();
    if HeroParameter.moremodeTeaching~=nil then
        LuaMgr.ShowLuaPanel(UIName.AreaSqualTeachingViewModel)
    end
    HeroParameter.moremodeTeaching=nil;
end


this.SetYellowRed=function()
    local isLevel=this.CheckCharacterLevel();
    local isItem=this.CheckPlayerItems();
    local isNew=RedMgr.Singleton:CheckRedCondition("1148")
    local isPass=false;
    if isLevel and isItem and isNew then
        isPass=not IsNull(DataMgr.Player.moreModData.Box) and NumTool.GetLen(DataMgr.Player.moreModData.Box)<4
    end
    this.vm.data.yellowPointBool=isLevel and isItem and isNew and isPass;
end

this.SetAD=function()
    local width=LuaMgr.ScreenWidth();
    local beginPos=Vector2(width+this.adText.preferredWidth/2,43);
    local endPos=Vector2(-this.adText.preferredWidth/2,43);





        this.vm.data.adPos=beginPos;

    this.vm.data.ad1Pos=beginPos;
    
    if this.adTweenter~=nil then
        this.adTweenter:Kill();
    end
    if this.adTweenter1~=nil then
        this.adTweenter1:Kill();
    end
    local time=(this.adText.preferredWidth+width)/50;
    this.adTweenter=DOTWeen.To(function() return beginPos end,function(vector)
        this.vm.data.adPos=vector
    end,endPos,time):SetEase(Ease.Linear):SetLoops(-1);

    if this.coKey~=nil then
        coroutine_runner.stop(this.coKey);
    end
    this.coKey=coroutine_runner.start(function()
        coroutine_runner.wait(time/2)
        local beginPos2=Vector2(width+this.adText.preferredWidth/2,43)
        if this.adTweenter1~=nil then
            this.adTweenter1:Kill();
        end
        this.adTweenter1=DOTWeen.To(function() return beginPos2  end,function(vector)
            this.vm.data.ad1Pos=vector
        end,endPos,time):SetEase(Ease.Linear):SetLoops(-1);
    end)
    
end



this.OnAskGetCurrentTheme=function()
    ApiMgr.Request("moremod/get_current_theme", { } ,true,function(result)
        local re=json.decode(result);
        this.moreModTheme=re.result.Theme;
        this.moreModExpires=re.result.Expires
        this.dataMoreModData=DataMgr.Player.moreModData;
        local key=DataMgr.Player.uid.."MOREMODE_SUSPEND"
        UnityEngine.PlayerPrefs.DeleteKey(key)
        this.ShowSquadInfo();
    end,nil,true)
end



this.CheckPlayerItems=function()
    local costItemId=this.cfgmoreModeConstants.SingleRoundTickets.id;
    local costCount=this.cfgmoreModeConstants.SingleRoundTickets.count
    if costItemId=="101" then
        return DataMgr.Player.stamina-costCount>=0;
    else
        local playerCount=DataHelper.GetItemCountById(costItemId)
        return playerCount-costCount>=0;
    end

end


this.CheckCharacterLevel=function()
    local index=0;
    for i,v in pairs(DataMgr.Player.characters) do
        if v.level>=this.cfgmoreModeConstants.MinLevelLimit then
            index=index+1;
            if index>=6 then
                break;
            end
        end
    end
    return index>=6;
end

this.ShowSquadPanel=function()

    this.vm.data.themeList={};

    if this.dataMoreModData.Expires==nil or this.dataMoreModData.Expires - LuaMgr.Timestamp()<=0 then
        this.vm.data.startBtnBool=true;
        this.vm.data.continueBtnBool=false;
        if not IsNull(HeroParameter.moreModeTheme) then
            this.moreModTheme=HeroParameter.moreModeTheme.Theme;
            this.moreModExpires=HeroParameter.moreModeTheme.Expires
            this.dataMoreModData=DataMgr.Player.moreModData;
            local key=DataMgr.Player.uid.."MOREMODE_SUSPEND"
            UnityEngine.PlayerPrefs.DeleteKey(key);
            this.ShowSquadInfo();
        else
            this.OnAskGetCurrentTheme();
        end
    else
        this.moreModTheme=this.dataMoreModData.Theme;
        this.moreModExpires=this.dataMoreModData.Expires;
        this.vm.data.startBtnBool=false;
        this.vm.data.continueBtnBool=true;
        this.ShowSquadInfo();
    end

end


this.SetSpritesByTheme=function()
    if SettingHelper.IsImageLow() then
        this.vm.data.mainBgTexture=LuaMgr.GetTexture(Path.Image..string.format("Squal/ui_dzr_bj_%s.png",this.moreModTheme));
    else
         curThemeObj=LuaMgr.GetPrefab("Assets/_BundleResources/UI/Area/AreaDaily/theme/Xiangqi001_"..this.moreModTheme..".prefab")
        if curThemeObj~=nil then
            curThemeObj.transform.parent=tranSpine;
            curThemeObj.transform.localPosition=bgSpineConfig[this.moreModTheme].pos
            curThemeObj.transform.localScale=Vector3.one;
            this.vm.data.isBG_Drawing=false;
        else
            this.vm.data.mainBgTexture=LuaMgr.GetTexture(Path.Image..string.format("Squal/ui_dzr_bj_%s.png",this.moreModTheme));
            this.vm.data.isBG_Spine=false;
        end
    end
    this.vm.data.taskSprite=LuaMgr.GetSprite("Squad","ui_dzr_jsjl_"..this.moreModTheme)
    this.vm.data.letterSprite=LuaMgr.GetSprite("Squad","ui_dzr_jssx_"..this.moreModTheme)
    this.vm.data.startSprite=LuaMgr.GetSprite("Squad","ui_dzr_btn_"..this.moreModTheme);
    this.vm.data.startTagSprite=LuaMgr.GetSprite("Squad","ui_dzr_xq_an1_"..this.moreModTheme);
    this.vm.data.taskTagSprite=LuaMgr.GetSprite("Squad","ui_dzr_xq_icon1_"..this.moreModTheme);
end


this.ShowExpiresTime=function()
    this.moreRemainTime=this.moreModExpires-LuaMgr.Timestamp();
    if this.moreRemainTime<0 then
        print("当前主题已结束，更新主题")
        this.OnAskGetCurrentTheme();
    else
        LuaMgr.RemoveTimer(TimerConst.MoreModExprie)
        LuaMgr.AddTimer(TimerConst.MoreModExprie,function()
            local day=math.floor(this.moreRemainTime/86400);
            local hour=math.fmod(math.floor(this.moreRemainTime/3600),24);
            local minute=math.fmod(math.floor(this.moreRemainTime/60), 60);
            this.vm.data.timeDay=tostring(day);
            this.vm.data.timeHour=tostring(hour);
            this.vm.data.timeMin=tostring(minute);
            this.moreRemainTime=this.moreRemainTime-1;
            if this.moreRemainTime<0 then
                print("当前主题已结束，更新主题");
                this.OnAskGetCurrentTheme();
            end
            this.remainDay=day;
            if hour>0 or minute>0 then
                this.remainDay=day+1;
            end
        end,1,-1,true);
    end
end


this.GetThemeList=function()
    this.cfgmoreModList={};
    local moreModGroup=ConfigMgr.Config.moreModGroup;

    table.insert(this.cfgmoreModList,moreModGroup[this.moreModTheme]);
    local startTime=ConfigMgr.Config.moreModConstants.ActivityCycleStartTime
    local cycleDay=ConfigMgr.Config.moreModConstants.ActivityCycle;
    local nextThemeTime=LuaMgr.Timestamp()+cycleDay*24*60*60;
    local step=math.ceil((nextThemeTime-startTime)/(cycleDay*24*60*60));
    local cycleList=this.cfgmoreModeConstants.ActivityCycleList;

    local nextIndex=step%#cycleList
    nextIndex=nextIndex==0 and #cycleList or nextIndex;
    local nextTheme=cycleList[nextIndex];
    table.insert(this.cfgmoreModList,moreModGroup[nextTheme])
    
end



this.ShowSquadInfo=function()
    if curTheme~=this.moreModTheme then
        if curThemeObj~=nil then
            LuaMgr.DestroyImmediateGO(curThemeObj);
        end
        this.SetSpritesByTheme();
    end
    curTheme=this.moreModTheme
    this.GetThemeList();
    this.ShowExpiresTime();















    this.vm.data.themeList={};
    local list={};
    for i,v in pairs(this.cfgmoreModList) do
        local themeItem={
            icon=LuaMgr.GetSprite("Squad",v.ButtonRes),
            pos=this.squadPosList[i].pos,
            nameSprite=LuaMgr.GetSprite("Squad",v.ButtonRes.."_2"),
            isLock=i~=1;
            isOpen=i==1,
            locktime=i==1 and tostring(this.remainDay) or "",
            isActive=false;
        }
        themeItem.scale=themeItem.isLock and Vector3(0.8,0.8,0.8) or Vector3(1,1,1);
        table.insert(list,themeItem);
    end
    this.vm.data.themeList=list;
    if this.coKeyTheme~=nil then
        coroutine_runner.stop(this.coKeyTheme);
    end
    this.coKeyTheme=coroutine_runner.start(function()
        for i,v in ipairs(this.vm.data.themeList) do
            v.isActive=true;
            coroutine_runner.wait(0.1)
        end
    end);
    
    list=nil
    this.vm.data.squadContentBool=false;
    this.vm.data.squadContentBool=true;
    
end


this.GetThemeDungeonsPro=function()
    local pro=0.0;
    if this.vm.data.startBtnBool then
        return pro;
    end
    local len=NumTool.GetLen(this.dataMoreModData.Dungeons);
    if len~=0 then
        table.sort(this.dataMoreModData.Dungeons,function(a,b) return a.Id<b.Id  end)
        local index=0;
        for i,v in pairs(this.dataMoreModData.Dungeons) do
            if v.Score~=0 then
                index=index+1;
            end
        end
        pro=index/len;
    end
    pro=pro>0 and pro+0.04 or pro;
    return pro;
end


return vm({
    data = data,
    command = command,
    hook = hook
})
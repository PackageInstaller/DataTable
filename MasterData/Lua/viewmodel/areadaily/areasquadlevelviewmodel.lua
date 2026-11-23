





local this = { vm = nil,
               cfgmoreModMap = {},
               cfgmoreModGroup = {},
               cfgmoreModLawMap = {},
               cfgDropMap = {},
               cfgmoreModRewardMap = {},
               dataMoreModData = {},
               dataDungeonRecords = {},
               bgPath = "Assets/_BundleResources/Images/Squal/",
               lawIconPath = "Assets/_BundleResources/Images/MoreModIcon/",
               dataDungeons = {},
               moreModDungeonStateList = {},
               moreRemainTime = nil,
               tisPosList = { Vector2(-530, -100), Vector2(-210, -100), Vector2(80, -100), Vector2(375, -100) },
               cokey = nil,
               gridLayout = nil,
               scrollView=nil,
}

local data = {

    squadName=""; 
    timer="";
    bgTexture=DefaultTexture;
    letterSprite=DefaultSprite;
    middleContentBool=true;
    middleLayOutSpacing=Vector2(0,0);
    levelList={
        {
            scale=Vector3(1,1,1);
            title="",
            subTitle="",
            isFixMore=false,
            isExpendMore=false,
            isReward=false,
            isDone=false,
            isLock=false,
            isFixLaw=false,
            isExpendLaw=false,
            rewardRare=DefaultSprite,
            passEvaluate=DefaultSprite,
            isActive=false;
            isYellowPoint=false,
            bgSprite=DefaultSprite,
            bgDoneSprite=DefaultSprite,
            bgLockSprite=DefaultSprite,
            fixLaxList={
                {
                    
                }
            },
            expendLaxList={
                {
                    
                }
            },
        }
    };
    lawList={
        {
            rawIcon=DefaultTexture,
            rawName="",
            scale=Vector3(1,1,1);
        }
        
    },
    
    tipsBool=false;
    tipsPos=Vector2(0,0);
    tipsSizeData=Vector2(234,75);
    tipsList={
        {
            
        }
    }
}

local command = {
    closeTipBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.tipsBool=false;
        end
        
    },
   
    levelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1
            local levelInfo=this.vm.data.levelList[index];
            if levelInfo.isLock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2236"].NameLan))
                return;
            elseif levelInfo.isDone then
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2234"].NameLan),
                function()
                    LuaMgr.ShowLuaPanel(UIName.AreaSqualEntryViewModel,levelInfo.moreModId,1);
                end,nil);
                return;
            end
            LuaMgr.ShowLuaPanel(UIName.AreaSqualEntryViewModel,levelInfo.moreModId,1);
            RedMgr.Singleton:FrushRedCondition("1148_"..index);
        end
    },
    boxBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.vm.data.tipsBool then
                this.vm.data.tipsBool=false;
                return
            end
            local index=tonumber(param)+1;
            this.ShowTipsList(index);
        end
    },
    scoreBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.AreaSqualTaskViewModel,this.dataMoreModData.Theme);
        end
    },
    squadShopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.AreaSqualShopViewModel);
        end
    },
    scrOnChange={
        type=XLuaCommandType.Vector2,
        execute=function(vm,vector,param)
            if this.vm.data.tipsBool and this.scrollView.velocity.x>0 or this.scrollView.velocity.x<0 then
                this.vm.data.tipsBool=false;
            end
        end
    },
    resetBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("2724"),function()
                this.ResetTeachingLevel();
            end,nil);
        end
    }
    
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.gridLayout=vm.behaviour.transform:Find("root/Middle/Scroll View/Viewport/Content"):GetComponent("GridLayoutGroup");
        this.scrollView=vm.behaviour.transform:Find("root/Middle/Scroll View"):GetComponent("ScrollRect");
        RedMgr.Singleton:RegisterViewModel(UIName.AreaSquadLevelViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end

        this.cfgmoreModMap=ConfigMgr.Config.moreModMap;
        this.cfgmoreModGroup=ConfigMgr.Config.moreModGroup;
        this.cfgDropMap=ConfigMgr.Config.dropMap;
        this.cfgmoreModLawMap=ConfigMgr.Config.moreModLawMap;
        this.cfgmoreModRewardMap=ConfigMgr.Config.moreModRewardMap;
        HeroRedDataHelper.FrushMoreModRed();
        this.SetAdjustScreen()
        this.ParseData();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        LuaMgr.RemoveTimer(TimerConst.MoreModExprie);
        local isClear_1148=true;
        for i,v in ipairs(this.vm.data.levelList) do
            if v.isYellowPoint then
                isClear_1148=false;
            end
        end
        if isClear_1148 then
            RedMgr.Singleton:FrushRedCondition("1148");
        else
            PlayerPrefs.DeleteKey(DataMgr.Player.uid.."1148");
        end
    end,
    before_destroy=function(vm)
        this=nil
    end
}


this.ResetTeachingLevel=function()
    local theme=DataMgr.Player.moreModData.Theme;
    local matchData={Theme=theme}
    ApiMgr.Request("moremod/reset_progress",matchData,true,function(result)
        this.ParseData();
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2725"))
    end,nil,true)
end


this.SetAdjustScreen=function()
    local rate1 = 16 / 9;
    local rate2 = LuaMgr.ScreenWidth()/ LuaMgr.ScreenHeight();
    local rate=  rate2/rate1;
    local spacingX=(rate-1)*100;
    this.gridLayout.spacing=Vector2(spacingX,0);
    local left=(LuaMgr.ScreenWidth()-(300*4)-(spacingX*3))/2;;
    left=left-(rate-1)*150
    this.gridLayout.padding.left=math.ceil(left);
end


this.OnAskRewardBox=function(dungeonId)
    local matchData={Id=dungeonId};
    ApiMgr.Request("moremod/draw_box_reward",matchData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        
        this.ParseData();
    end,nil,true)
end


this.CheckIsRewardBox=function()
    local dungeonId=nil;

    if IsNull(this.dataMoreModData) or IsNull(this.dataMoreModData.Dungeons) then
        return 
    end
    for i,v in pairs(this.dataMoreModData.Dungeons) do
        if tonumber(v.Score)>0 and this.dataMoreModData.Box[v.Id]==nil then
            dungeonId=v.Id;
            break;
        end
    end
    if dungeonId~=nil then
        this.OnAskRewardBox(dungeonId);
    end
end


this.CheckIsPassLevel=function()
    for i,v in pairs(this.dataMoreModData.Dungeons) do
        if tonumber(v.Score)==0 then
            return false;
        end
    end
    return true;
end

this.ParseData=function()
    this.dataMoreModData=DataMgr.Player.moreModData;
    this.dataDungeonRecords=DataMgr.Player.dungeonRecords;
    this.CheckIsRewardBox();


    this.vm.data.tipsBool=false;
    this.MoreModDungeonState();

    this.ShowLevel();
    this.ShowExpiresTime();
end



this.ShowExpiresTime=function()
    this.moreRemainTime=this.dataMoreModData.Expires-LuaMgr.Timestamp();
    if this.moreRemainTime<0 then
        print("当前主题已结束，更新主题")
        LuaMgr.Back();
    else
        LuaMgr.RemoveTimer(TimerConst.MoreModExprie)
        LuaMgr.AddTimer(TimerConst.MoreModExprie,function()
            local day=math.floor(this.moreRemainTime/86400);
            local hour=math.fmod(math.floor(this.moreRemainTime/3600),24);
            local minute=math.fmod(math.floor(this.moreRemainTime/60), 60);
            local tex=string.format(LuaMgr.GetLangText("AreaSquadLevelViewModel_1"),day,hour,minute);
            this.vm.data.timer=tex;
            this.moreRemainTime=this.moreRemainTime-1;
            if this.moreRemainTime<0 then
                print("当前主题已结束，更新主题");
                LuaMgr.Back();
            end
        end,1,-1,true);
    end
end



this.MoreModDungeonState=function()
    this.dataDungeons ={};
    this.moreModDungeonStateList={};
    if IsNull(this.dataMoreModData) or IsNull(this.dataMoreModData.Dungeons) then
        return
    end
    for i,v in pairs(this.dataMoreModData.Dungeons) do
        table.insert(this.dataDungeons,v);
    end
    table.sort(this.dataDungeons,function(a, b)
        return a.Id<b.Id;
    end)
    
    local re=true;
    for i,v in ipairs(this.dataDungeons) do
        if re and v.Score~=0 then
            this.moreModDungeonStateList[v.Id]=3;
        elseif re and v.Score==0 then
            this.moreModDungeonStateList[v.Id]=2;
        else
            this.moreModDungeonStateList[v.Id]=1;
        end
        re=re and v.Score~=0;
    end
end




this.GetLevelStateAndScore=function(moreMod)
        return this.moreModDungeonStateList[moreMod.Id]
end



this.ShowTipInfo=function()


end


this.SetSpriteByTheme=function()
    this.vm.data.bgTexture=LuaMgr.GetTexture(Path.Image..string.format("Squal/ui_dzr_gk_bj_%s.png",this.dataMoreModData.Theme));
    this.vm.data.letterSprite=LuaMgr.GetSprite("Squad","ui_dzr_jssx_"..this.dataMoreModData.Theme)
    
end

this.ShowLevel=function()
    this.SetSpriteByTheme();
    this.vm.data.levelList={};
    local list={};
    for i,v in ipairs(this.dataDungeons) do
        local cfgmoreMod=this.cfgmoreModMap[v.Id];
        local state=this.GetLevelStateAndScore(v);
        local levelItem={
            title=LuaMgr.GetLangText(cfgmoreMod.NameTextLan),
            subTitle=LuaMgr.GetLangText(cfgmoreMod.NameSuffixLan),
            isFixMore=#v.Law[1]>2,
            isExpendMore=#v.Law[3]+#v.Law[3]+#v.Law[4]>4,
            isDone=state==3,
            isLock=state==1,
            isReward=state~=3 and this.dataDungeonRecords[v.Dungeon]~=nil and this.dataDungeonRecords[v.Dungeon].historyRating~="";
            scale=state==2 and Vector3(1,1,1) or Vector3(0.8,0.8,0.8);
            isYellowPoint=state==2 and RedMgr.Singleton:CheckRedCondition("1148_"..i);
            isFixLaw=false;
            isExpendLaw=false;
            moreModId=v.Id,
            rewardRare=LuaMgr.GetSprite("Squad","ui_dzr_gk_jl"..cfgmoreMod.RareBox);
            passEvaluate=DefaultSprite,
            isActive=false;
            bgSprite=LuaMgr.GetSprite("Squad","ui_dzr_gk_"..this.dataMoreModData.Theme),
            bgDoneSprite=LuaMgr.GetSprite("Squad","ui_dzr_gk_zz1_"..this.dataMoreModData.Theme),
            bgLockSprite=LuaMgr.GetSprite("Squad","ui_dzr_gk_zz2_"..this.dataMoreModData.Theme),
            fixLaxList={
               
            },
            expendLaxList={
                
            },
        }

        if #v.Law[1]>0 then
            levelItem.isFixLaw=true;
            local tarIndex=#v.Law[1]>2 and 2 or #v.Law[1];
            for p=1,tarIndex,1 do
                local m=v.Law[1][p];
                local lawPath=this.lawIconPath..this.cfgmoreModLawMap[m].LawICON..".png";
                local fixLawItem={
                    rawIcon=LuaMgr.GetTexture(lawPath);
                    rawName=LuaMgr.GetLangText(this.cfgmoreModLawMap[m].LawNameLan),
                    scale=Vector3(1,1,1);
                }
                table.insert(levelItem.fixLaxList,fixLawItem);
            end
        end
        

        local expendlaw={}
        for _,_v in ipairs(v.Law[2]) do
            table.insert(expendlaw,_v);
        end
        for _,_v in ipairs(v.Law[3]) do
            table.insert(expendlaw,_v);
        end
        for _,_v in ipairs(v.Law[4]) do
            table.insert(expendlaw,_v);
        end
        if #expendlaw>0 then
            levelItem.isExpendLaw=true;
            local tarIndex=#expendlaw>4 and 4 or #expendlaw;
            for p=1,tarIndex,1 do
                local m=expendlaw[p];
                local lawPath=this.lawIconPath..this.cfgmoreModLawMap[m].LawICON..".png";
                local expendLawItem={
                    rawIcon=LuaMgr.GetTexture(lawPath);
rawName="";
                    scale=Vector3(0.49,0.49,0.49);
                }
                table.insert(levelItem.expendLaxList,expendLawItem);
            end
        end
        if levelItem.isDone then
            local eva="B";
            if v.Score==3 then
                eva="S";
            elseif v.Score==2 then
                eva="A";
            end
            levelItem.passEvaluate=LuaMgr.GetSprite("AreaMapRes","ui_zqzb_pj_"..eva);
        end
        table.insert(list,levelItem);
    end
    
    this.vm.data.levelList=list;

    if this.cokey~=nil then
        coroutine_runner.stop(this.cokey);
    end
    this.cokey=coroutine_runner.start(function()
        for i,v in ipairs(this.vm.data.levelList) do
            v.isActive=true;
            coroutine_runner.wait(0.1);
        end
    end)
    
    list=nil;
    this.vm.data.middleContentBool=false;
    this.vm.data.middleContentBool=true;
   
end

this.ShowTipsList=function(index)
    this.vm.data.tipsBool=true;
    this.vm.data.tipsPos=this.tisPosList[index];
    local moreMod=this.cfgmoreModMap[this.dataDungeons[index].Id]
    local items=this.cfgDropMap[moreMod.Reward].items;
    local list={}
    if items~=nil then
        for i,v in ipairs(items) do
            local item=ConfigHelper.CreateGoodsItem(v.id,v.count,0.45,true,true);
            table.insert(list,item);
        end
    end
    local width=57*#list+20;
    this.vm.data.tipsSizeData=Vector2(width,75);
    this.vm.data.tipsList=list;
            
end



return vm({
    data = data,
    command = command,
    hook = hook
})
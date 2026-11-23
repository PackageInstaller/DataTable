





require("ViewModel/AreaDaily/AreaDaily_equip")

local this = {vm=nil,
              equip1UIList={},
              equip2UIList={},
              equipObj=nil;
};
local jobName={"sw","qr","yj","gs","zl"}
local jobNameMap={}
local weekDays={};
local weekDaysNum={};


local typeStartY=0;
local typeOffY=80.0;
local subOffY=76;
local subStartY=0;
local moveDistance=nil;

local curTypeBar=0;
local curJobBar=0;
local cfgActiveMap=nil;
local cfgDailyActiveMap=nil;
local cfgDungeonMap=nil;
local dataDailyActives=nil;
local dataDungeonRecords=nil;
local curDailyActiveId=nil;
local curDailyData=nil;
local lastActiveTimeStamp=0;
local cfgEquipWeek=nil;
local curEquipWeekIndex=0;
local curEquipWeekEndTime=nil;
local GALLERY_PAth = "Assets/_BundleResources/Images/Daily/";
local daySecondes = 24 * 3600
local redList={};
local data = {

    typeBarList = { { isOn = false,
                      name = "",
                      pos = Vector2(0, 0),
                      childBgSizeData = Vector2(0, 0),
                      redId = "",
                      isDouble=false,
                      sublist = { {} }
                    } };
    subList = { { BG = DefaultSprite,
                  isOn = false,
                  pos = Vector2(0, 0),
                  timeBool = false,
                  time = "",
                  alpha = 1.0,
                  nameText = "",
                  name1Bool = false,
                  name2Bool = false,
                  name3Bool = false,
                  suoBool = false,
                  isDouble=false,
                  redId = "",
                } };

    goldList = { { offset = Vector2(0, 0),
                   lineDownOffset = Vector2(0, 0);
                   off = false,
                   on = false,
                   upline = false,
                   downline = false,
                   new = false,
                   levelSprite = DefaultSprite,
                   num = "",
                   name = "",
                   star1IsOn = false,
                   star2IsOn = false,
                   star3IsOn = false
                 } };
    expList = { { offset = Vector2(0, 0),
                  lineDownOffset = Vector2(0, 0),
                  off = false,
                  on = false,
                  upline = false,
                  downline = false,
                  new = false,
                  levelSprite = DefaultSprite,
                  num = "",
                  name = "",
                  star1IsOn = false,
                  star2IsOn = false,
                  star3IsOn = false
                } };

    equipList = { { offset = Vector2(0, 0),
                    lineDownOffset = Vector2(0, 0),
                    off = false,
                    on = false,
                    upline = false,
                    downline = false,
                    new = false,
                    levelSprite = DefaultSprite,
                    num = "",
                    name = "",
                    star1IsOn = false,
                    star2IsOn = false,
                    star3IsOn = false,
                    sliderList = { {} },
                    equipName="",
                    starOffSet=Vector2(41.6,13.4);
                    isShow = false;
                  } };
    areaList = { { offset = Vector2(0, 0),
                  lineDownOffset = Vector2(0, 0),
                  off = false,
                  on = false,
                  upline = false,
                  downline = false,
                  new = false,
                  levelSprite = DefaultSprite,
                  num = "",
                  name = "",
                  star1IsOn = false,
                  star2IsOn = false,
                  star3IsOn = false
                } };

    jobList = { {
                    offset = Vector2(0, 0),
                    off = false,
                    on = false,
                    jobBg = DefaultSprite,
                    name = "",
                    num = "",
                    new = false,
                    star1IsOn = false,
                    star2IsOn = false,
                    star3IsOn = false
                } };
    weekItemList = { { weekName = "", actToday = false, today = false } };
    sliderList={{sizeData=Vector2(0,0),isOn=false}};

    subListPos = Vector2(0, 0);
    subBool = false;
    bar_jobBool = true;
    baseGoldPanel = false;
    baseExpPanel = false;
    baseEquipPanel = false;
    baseAreaPanel = false;

    baseResPanel = false;
    jobResPanel = false;
    jobResOpen = false;
    actJobResOpen = false;
    equipResOpen=false;
    weekBool = false;
    actText = "";

    remainCount = "";
    jobName = "";

    Middle = false;
    middleAnimaName = "";
    textureJob = DefaultTexture;
    curWeekEquipTime="";
    otherEquipBool=false;
    otherEquip_topTitle="";
    otherEquip_topTip="";
    otherEquip_next1Title="";
    otherEquip_next2Title="";
    otherEquip_next1List={};
    otherEquip_next2List={};
    isDouble=false;
    doubleText="";
    
}

local command = {
    typeBarToggle = {
        type = XLuaCommandType.Bool,
        execute = function(vm,isOn,param)
            local index=tonumber(param+1);
            this.SwitchTypeBar(tonumber(index),isOn);
            this.vm.data.otherEquipBool=false;
        end
    },
    subBarBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            this.SwitchJobBar(index);
            this.vm.data.otherEquipBool=false;
        end
    },
    goldItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            
            if this.vm.data.goldList[index].off then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2236"));
                return;
            end
            
            local dungeonId=this.vm.data.goldList[index].dungeonId;
            this.OpenBattlePreprePanel(dungeonId);
        end
    },
    expItemBtn={
        type=XLuaCommandType.Void,
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local dungeonId=this.vm.data.expList[index].dungeonId;

            if this.vm.data.expList[index].off then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2236"));
                return;
            end
            
            this.OpenBattlePreprePanel(dungeonId);
        end
    },
    equipItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local dungeonId=this.vm.data.equipList[index].dungeonId;
            
            if this.vm.data.equipList[index].off then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2236"));
                return;
            end
            
            this.OpenBattlePreprePanel(dungeonId);
        end
    },
    areaItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local dungeonId=this.vm.data.areaList[index].dungeonId;
            if this.vm.data.areaList[index].off then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2236"));
                return;
            end
            this.OpenBattlePreprePanel(dungeonId);
        end
    },
    jobItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local dungeonId=this.vm.data.jobList[index].dungeonId;

            if this.vm.data.jobList[index].off then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2236"));
                return;
            end
            
            this.OpenBattlePreprePanel(dungeonId);
        end
    },
    otherEquipBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
          this.vm.data.otherEquipBool=true;
            this.SetOtherWeekEquipInfo();
        end
    },
    closeOtherEquipBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.otherEquipBool=false;
        end
    }

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        weekDays = { LuaMgr.GetLangText("AreaDailyViewModel_0"), LuaMgr.GetLangText("AreaDailyViewModel_1"), LuaMgr.GetLangText("AreaDailyViewModel_2"), LuaMgr.GetLangText("AreaDailyViewModel_3"), LuaMgr.GetLangText("AreaDailyViewModel_4"), LuaMgr.GetLangText("AreaDailyViewModel_5"), LuaMgr.GetLangText("AreaDailyViewModel_6") }
        weekDaysNum = { LuaMgr.GetLangText("AreaDailyViewModel_7"), LuaMgr.GetLangText("AreaDailyViewModel_8"), LuaMgr.GetLangText("AreaDailyViewModel_9"), LuaMgr.GetLangText("AreaDailyViewModel_10"), LuaMgr.GetLangText("AreaDailyViewModel_11"), LuaMgr.GetLangText("AreaDailyViewModel_12"), LuaMgr.GetLangText("AreaDailyViewModel_13") }
        RedMgr.Singleton:RegisterViewModel(UIName.AreaDailyViewModel);
        local equip1Tf=vm.behaviour.transform:Find("root/Middle/otherEquip/equipArray/next1/content")
        this.equip1UIList=UIListView.New(equip1Tf);
        local equip2Tf=vm.behaviour.transform:Find("root/Middle/otherEquip/equipArray/next2/content")
        this.equip2UIList=UIListView.New(equip2Tf);
        this.equipObj=vm.behaviour.transform:Find("template/equip").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        lastActiveTimeStamp = LuaMgr.Timestamp();
        curTypeBar = 1;
        curJobBar = 1;
        local type_1, style = this.GetPlayerPref();
        curTypeBar = type_1 ~= nil and type_1 or curTypeBar;
        curJobBar = style ~= nil and style or curJobBar;
        this.vm.data.Middle = true;
        this.ParseData(curTypeBar)
        LuaMgr.AddUIEventListener(UIEventConst.EnterBattleDailyError, this.OnAskRefreshDialy)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.EnterBattleDailyError, this.OnAskRefreshDialy);
        LuaMgr.RemoveTimer(TimerConst.MoreModExprie)
    end,

    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        UIListView.ClearItem("AreaDaily_equip")
    end
}


this.OnAskRefreshDialy=function()
    this.vm.data.Middle=false
    this.OnAskRefreshDailyActive(curTypeBar)
end

this.OnBack=function()
    HeroParameter.EmptyDailyFB()
    HeroParameter.EmptyTarItem()
    LuaMgr.Back();
end

this.GetPlayerPref=function()
    return HeroParameter.dailyType,HeroParameter.dailyStyle;
end


this.OnAskRefreshDailyActive=function(NO)
    ApiMgr.Request("refresh_dailyActive", {}, true, function(result)
        this.vm.data.Middle=true;
       this.ParseData(NO);
    end, nil, false);
end

this.OpenBattlePreprePanel=function(dungeonId)
    local isFrush= this.GetRefushDataTime();
    if(isFrush) then
        this.OnAskRefreshDailyActive(curTypeBar);
        curJobBar=1;
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("AreaDailyViewModel_14"));
        return
    end
    local activeId=this.vm.data.typeBarList[curTypeBar].activeId;
    LuaMgr.SetAreaBattleType(BattleType.Daily);

    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = dungeonId
    enterDungeonParams.dungeonId = dungeonId
    enterDungeonParams.activeInfo.activeId = activeId
    enterDungeonParams.activeInfo.dailyActiveId = curDailyActiveId
    enterDungeonParams.isActive = true
    BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    HeroParameter.SaveDailyFB(curTypeBar,curJobBar)
end


this.ParseData=function(NO)
    cfgActiveMap=ConfigMgr.Config.ActiveMap;
    cfgDailyActiveMap=ConfigMgr.Config.dailyActiveMap;
    dataDailyActives=DataMgr.Player.dailyActives;
 
    cfgDungeonMap=ConfigMgr.Config.dungeonMap;
    dataDungeonRecords=DataMgr.Player.dungeonRecords;
   
    this.vm.data.bar_jobBool=curTypeBar<3;
    this.vm.data.baseGoldPanel=curTypeBar==1 and curJobBar==1;
    this.vm.data.baseExpPanel=curTypeBar==1 and curJobBar==2;
    this.vm.data.baseEquipPanel=curTypeBar==1 and curJobBar==3;
    this.vm.data.baseAreaPanel=curTypeBar==1 and curJobBar==4;
    this.vm.data.otherEquipBool=false;
    this.SetLeftTypeBar(NO);
end




this.SwitchTypeBar=function(index,isOn)
    if not isOn then
        local lan=this.vm.data.typeBarList[index].nameLan;
        this.vm.data.typeBarList[index].name=string.format("<color=#9e8f76>%s</color>",lan);

moveDistance=moveDistance+10;

        this.TypeBarDoMove(moveDistance,false);
        return;
    end

    curTypeBar=index;
    curJobBar=1;
    for i,v in ipairs(this.vm.data.typeBarList) do
        v.isOn=i==index;
        v.name=i==index and string.format("<color=#262429>%s</color>",v.nameLan) or string.format("<color=#9e8f76>%s</color>",v.nameLan);
        local posY=typeStartY-(i-1)*typeOffY;

        if i==2 then
            if v.isOn then
posY=posY+10;
            end
        end

        v.pos=Vector2(0,posY);
    end

    this.vm.data.baseGoldPanel=index==1 and curJobBar==1;
    this.vm.data.baseExpPanel=index==1 and curJobBar==2;
    this.vm.data.baseEquipPanel=index==1 and curJobBar==3;
    this.vm.data.baseAreaPanel=index==1 and curJobBar==4;
    this.vm.data.jobResPanel=index==2;
    this.vm.data.baseResPanel=index==1;
    this.vm.data.actJobResOpen=false;
    this.vm.data.bar_jobBool=curTypeBar<3;
    this.SetLeftJobBar(index);
end


this.FormatData=function(data,compare)
    local list={};
    if not IsNull(data) then
        for i,v in pairs(data) do
            table.insert(list,v);
        end
    end
    table.sort(list,compare);
    return list;
end

this.SetLeftTypeBar=function(NO)
    this.vm.data.typeBarList={};
    local list={};
    local cfgTypeBarData=this.FormatData(cfgActiveMap,function(a,b) 
        return tonumber(a.id)<tonumber(b.id)  end);

    NO = this.FindDailyActiveTypeIndex(NO, cfgTypeBarData);
    curTypeBar = NO;
    if curTypeBar==nil then curTypeBar=1 end;

    this.vm.data.jobResPanel=curTypeBar==2;
    this.vm.data.baseResPanel=curTypeBar==1;

    for i,v in ipairs(cfgTypeBarData) do
        local lan=LuaMgr.GetLangText(v.nameLan);

        local  _isOn=i==NO;
        local posY=typeStartY-(i-1)*typeOffY;
        if i==2 then
            if _isOn then
posY=posY+10;
            end
        end
        
        local typeBarItem={activeId=v.id,
                           nameLan=lan,
                           isOn=_isOn,
                           name=i==NO and string.format("<color=#262429>%s</color>",lan) or
                                   string.format("<color=#9e8f76>%s</color>",lan);
                           pos=Vector2(0,posY),
                           childBgSizeData=Vector2(0,0);
                           redId="1106_"..v.id;
                           isDouble=ActivityMgr.DoubleRewards_CheckDailyFB(v.id,nil)
        };
        table.insert(list,typeBarItem);
    end
    this.vm.data.typeBarList=list;
    this.SetLeftJobBar(curTypeBar);
    
end

this.CalculateRed=function()
    local dailyList=this.FormatData(dataDailyActives,function(a,b) return tonumber(a.activeId)<tonumber(b.activeId)  end);
    for i,v in ipairs(dailyList) do

        local list={};
        local jobData=this.FormatData(v.dailyActives,function(a,b) return tonumber(a.activeId)<tonumber(b.activeId)  end)
        for p,m in ipairs(jobData) do
            local redNum=0;

            if i==2 and m.unlock then
                redNum=RedMgr.Singleton:CheckRedCondition("1106_"..m.activeId) and 1 or 0;
            else
                redNum=0
            end
            list[m.activeId]=redNum;
        end
        redList[i]=list;
    end
    
end
        
    





this.SwitchJobBar=function(index)
    if(curJobBar==index) then return end;
    local selectJobr=this.vm.data.subList[index];
    if(not selectJobr.unlock) then 
        if selectJobr.timeBool then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("AreaDailyViewModel_15"));
        else
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,selectJobr.time);
        end
        return
    end;
    curJobBar=index;
    for i, v in ipairs(this.vm.data.subList) do
        v.isOn=i==index;
    end

    this.SetDungeonItem(selectJobr.jobId);
    
end

this.SetLeftJobBar=function(NO)
    this.vm.data.subList={};
    this.vm.data.subBool=true;
    local dailyList=this.FormatData(dataDailyActives,function(a,b) return tonumber(a.activeId)<tonumber(b.activeId)  end);
    local jobData=this.FormatData(dailyList[NO].dailyActives,function(a,b) return tonumber(a.activeId)<tonumber(b.activeId)  end);
    if(jobData==nil) then return end;
    curDailyData=jobData;
    for i,v in ipairs(jobData) do
        jobNameMap[v.activeId]=jobName[i];
    end
    table.sort(jobData,function(a,b) return a.unlock and not b.unlock end);
    curJobBar = this.FindDailyActiveJobIndex(jobData);
    local list={};
    local Cindex=this.CheckCurJobBarUnlock(jobData);
    if Cindex==nil then
        Cindex=1;
    end

    
    for i, v in ipairs(jobData) do
        local cfgActive=cfgDailyActiveMap[v.activeId]
        local name=LuaMgr.GetLangText(cfgDailyActiveMap[v.activeId].nameLan);
        local barBaseItem={jobId=v.activeId,unlock=v.unlock,
                           BG=LuaMgr.GetSprite("AreaDialy","ui_rcfb_"..v.activeId),
                           isOn=i==Cindex;
                           timeBool=curTypeBar~=3 and cfgActive.timeType~=1 and cfgActive.timeType~=6;
                           pos=Vector2(0,-10-(i-1)*subOffY);
                           time=this.GetOpenTimeOffWeek(cfgDailyActiveMap[v.activeId]),
                           alpha=1.0,
                           nameText=v.unlock and string.format("<color=#efe5cc>%s</color>",name) or
                                   string.format("<color=#86867d>%s</color>",name),
                           suoBool=not v.unlock,
                           name1Bool=curTypeBar==1,
                           name2Bool=curTypeBar==2,
                           name3Bool=curTypeBar==3,
                           redId="1106_"..v.activeId,
                           isDouble=ActivityMgr.DoubleRewards_CheckDailyFB(nil,v.activeId)

        };
        if curTypeBar<3 then

        end
        table.insert(list,barBaseItem);
    end
    this.vm.data.subList=list;
    moveDistance=#list*subOffY+subStartY;
    if curTypeBar==nil then
        curTypeBar=1 
    end;
    this.vm.data.typeBarList[curTypeBar].childBgSizeData=Vector2(220,moveDistance+76);
    this.vm.data.subListPos=this.vm.data.typeBarList[curTypeBar].pos-Vector2(0,58);
    this.TypeBarDoMove(-moveDistance,true);
    if Cindex~=nil and jobData[Cindex]~=nil then

        this.SetDungeonItem(jobData[Cindex].activeId);
    end
    RedMgr.Singleton:Refresh();
end



































this.TypeBarDoMove=function(distance,isOn)
    this.vm.data.subBool=isOn;
    for i,v in ipairs(this.vm.data.typeBarList) do
        if i>curTypeBar then
            DOTWeen.To(function() return v.pos  end,
                    function(vect) v.pos=vect  end,
                    Vector2(0,v.pos.y+distance),0.2);
            
        end
    end
    if not isOn then return end;
    for i,v in ipairs(this.vm.data.subList) do
        v.alpha=0;
        DOTWeen.To(function() return v.alpha  end,
                function(value) v.alpha=value  end,
                1,0.2*i);
    end
end


this.CheckCurJobBarUnlock=function(jobData)
    if curJobBar==nil then
        curJobBar=1;
    end
    if(jobData[curJobBar]~=nil and not jobData[curJobBar].unlock) then
        curJobBar=1;
    end
    return curJobBar;
end






this.SetDungeonItem=function(dailyId)
    this.vm.data.isDouble=ActivityMgr.DoubleRewards_CheckDailyFB(nil,dailyId);
    this.vm.data.doubleText=ActivityMgr.DoubleRewards_ProText();
    this.vm.data.middleAnimaName="AreaDailyPanel_Middle";
    local isGold=dailyId=="100001";
    local isExp=dailyId=="100002";
    local isEquip=dailyId=="100003";
    local isArea=dailyId=="100004";
    this.vm.data.baseGoldPanel=curTypeBar==1 and isGold;
    this.vm.data.baseExpPanel=curTypeBar==1 and isExp;
    this.vm.data.baseEquipPanel=curTypeBar==1 and isEquip;
    this.vm.data.baseAreaPanel=curTypeBar==1 and isArea;
    curDailyActiveId=dailyId;
    local cfgDailyMap=cfgDailyActiveMap[dailyId]
    local dataDailyMap=curDailyData[curJobBar];
    this.vm.data.jobName=LuaMgr.GetLangText(cfgDailyMap.nameLan);
    if curTypeBar==1 then
        if isGold then
            this.SetGoldDungeonList(cfgDailyMap,dataDailyMap);
        elseif isExp then
            this.SetExpDungeonList(cfgDailyMap,dataDailyMap);
        elseif isEquip then
            this.RequestEquipTurnData(dailyId)
        elseif isArea then
            this.SetAreaDungeonList(cfgDailyMap,dataDailyMap)
        end
        this.SetActInfo(dataDailyMap,curTypeBar==1 and isEquip);
        this.SetOpenTime(cfgDailyMap);
    elseif curTypeBar==2 then
        this.SetJobDungeonList(cfgDailyMap,dataDailyMap);
        this.SetActInfo(dataDailyMap);
        this.SetOpenTime(cfgDailyMap);

    elseif curTypeBar==3 then
        print("curTypeBar==3  error")
    end
    this.vm.data.weekBool=curTypeBar~=3 and cfgDailyMap.timeType~=1 and cfgDailyMap.timeType~=6;
end

this.SetGoldDungeonList=function(cfgDailyMap,dataDailyMap)
    this.vm.data.goldList={};
    local list={}
    local dungeonsGroup=NumTool.split(cfgDailyMap.dungeonIdGroup,",")

    local imgName = GALLERY_PAth .. "ui_rcfb_bj_tl.png";
    this.vm.data.textureJob = LuaMgr.GetTexture(imgName);
    
    for i,v in pairs(dungeonsGroup) do
        local dungeonRecord=dataDungeonRecords[v];
        local star=this.GetStar(dungeonRecord);
        local unlock=dataDailyMap.dungeons[v];
        local spriteName="ui_rcfb_pic_gqd_dgb_00";
        if unlock then
            spriteName="ui_rcfb_pic_gqd_dgb_0"..tostring(i);
        end

        local _offset=Vector2(0,0);
        local _lineDownOffset=Vector2(0,0);
        
        if i%2~=0 then
            _offset=Vector2(0,70);
        else
            _offset=Vector2(-67,-208);
        end

        if i>=(#dungeonsGroup) and i%2~=0 then
            _offset=Vector2(0,0);
            _lineDownOffset=Vector2(81,0);
        end
        
        local dungeonItem={dungeonId=v,
                           offset=_offset,
                           lineDownOffset=_lineDownOffset,
                           off=not unlock,
                           on=unlock,
                           upline=i%2==0 and i~=1,
                           downline=i%2~=0 and i~=1,
                           new=unlock and dungeonRecord==nil,
                           levelSprite=LuaMgr.GetSprite("AreaDialy",spriteName),
                           num=unlock and string.format("<color=#ffffff>0%s</color>",i)
                                   or string.format("<color=#B6B6B6>0%s</color>",i);
                           name=unlock and string.format("<color=#ffffff>%s</color>", LuaMgr.GetLangText(cfgDungeonMap[v].NameLan))
                                   or string.format("<color=#B6B6B6>%s</color>",LuaMgr.GetLangText(cfgDungeonMap[v].NameLan));
                           star1IsOn=star>=1,star2IsOn=star>=2,star3IsOn=star>=3,

        }
        table.insert(list,dungeonItem);
    end
    this.vm.data.goldList=list;
    list=nil;
end


this.SetExpDungeonList=function(cfgDailyMap,dataDailyMap)
    this.vm.data.expList={};
    local list={}
    local dungeonsGroup=NumTool.split(cfgDailyMap.dungeonIdGroup,",")

    local imgName = GALLERY_PAth .. "ui_rcfb_bj_jc.png";
    this.vm.data.textureJob = LuaMgr.GetTexture(imgName);
    
    for i,v in pairs(dungeonsGroup) do
        local dungeonRecord=dataDungeonRecords[v];
        local star=this.GetStar(dungeonRecord);
        local unlock=dataDailyMap.dungeons[v];
        
        local _offset=Vector2(0,0);
        local _lineDownOffset=Vector2(0,0);

        if i%2~=0 then
            _offset=Vector2(0,70);
        else
            _offset=Vector2(-23,-208);
        end

        if i>=(#dungeonsGroup) and i%2~=0 then
            _offset=Vector2(37,-41.2);
            _lineDownOffset=Vector2(25.4,106.1);
        end

        local spriteName="ui_rcfb_rk_jc00";
        if unlock then
            spriteName="ui_rcfb_rk_jc0"..tostring(i);
        end
        
        local dungeonItem={dungeonId=v,
                           offset=_offset,
                           lineDownOffset=_lineDownOffset,
                           off=not unlock,
                           on=unlock,
                           upline=i%2==0 and i~=1,
                           downline=i%2~=0 and i~=1,
                           new=unlock and dungeonRecord==nil,
                           levelSprite=LuaMgr.GetSprite("AreaDialy",spriteName),
                           num=unlock and string.format("<color=#ffffff>0%s</color>",i)
                                   or string.format("<color=#B6B6B6>0%s</color>",i);
                           name=unlock and string.format("<color=#ffffff>%s</color>", LuaMgr.GetLangText(cfgDungeonMap[v].NameLan))
                                   or string.format("<color=#B6B6B6>%s</color>",LuaMgr.GetLangText(cfgDungeonMap[v].NameLan));
                           star1IsOn=star>=1,star2IsOn=star>=2,star3IsOn=star>=3,

        }
        table.insert(list,dungeonItem);
    end
    this.vm.data.expList=list;
    list=nil;
end

this.RequestEquipTurnData = function (dailyId)
    local cfgDailyMap = cfgDailyActiveMap[dailyId]
    local data = {
        DungeonID = cfgDailyMap.pointTurnItems[1].id
    }
    local onSucc = function(res)
        local data = json.decode(res)
        if data.code ~= 0 then
            LuaDebug.error("770:请求装备副本轮换信息失败. Code:" ..  data.code)
            return
        end
        this.equipTurnServerData = data.result
        local dataDailyMap = curDailyData[curJobBar];
        this.SetWeekEquipBaseData(cfgDailyMap)
        this.SetEquipDungeonList(cfgDailyMap,dataDailyMap)
    end
    this.vm.data.equipList={}
    local imgName = GALLERY_PAth .. "ui_rcfb_bj_dgb.png";
    this.vm.data.textureJob = LuaMgr.GetTexture(imgName);
    ApiMgr.Request("get_daily_active_cur_turn_drop", data, true, onSucc, nil, true)
end


this.SetAreaDungeonList=function(cfgDailyMap,dataDailyMap)
    this.vm.data.areaList={};
    local list={}
    local dungeonsGroup=NumTool.split(cfgDailyMap.dungeonIdGroup,",")

    local imgName = GALLERY_PAth .. "ui_rcfb_bj_cy.png";
    this.vm.data.textureJob = LuaMgr.GetTexture(imgName);
    for i,v in pairs(dungeonsGroup) do
        local dungeonRecord=dataDungeonRecords[v];
        local star=this.GetStar(dungeonRecord);
        local unlock=dataDailyMap.dungeons[v];
        local _offset=Vector2(0,0);
        local _lineDownOffset=Vector2(0,0);

        if i%2~=0 then
            _offset=Vector2(0,70);
        else
            _offset=Vector2(-23,-208);
        end

        if i>=(#dungeonsGroup) and i%2~=0 then
            _offset=Vector2(37,-41.2);
            _lineDownOffset=Vector2(25.4,106.1);
        end

        local spriteName="ui_rcfb_rk_ct00";
        if unlock then
            spriteName="ui_rcfb_rk_ct0"..tostring(i);
        end
        
        local dungeonItem={dungeonId=v,
                           offset=_offset,
                           lineDownOffset=_lineDownOffset,
                           off=not unlock,
                           on=unlock,
                           upline=i%2==0 and i~=1,
                           downline=i%2~=0 and i~=1,
                           new=unlock and dungeonRecord==nil,
                           levelSprite=LuaMgr.GetSprite("AreaDialy",spriteName),
                           num=unlock and string.format("<color=#ffffff>0%s</color>",i)
                                   or string.format("<color=#B6B6B6>0%s</color>",i);
                           name=unlock and string.format("<color=#ffffff>%s</color>", LuaMgr.GetLangText(cfgDungeonMap[v].NameLan))
                                   or string.format("<color=#B6B6B6>%s</color>",LuaMgr.GetLangText(cfgDungeonMap[v].NameLan));
                           star1IsOn=star>=1,star2IsOn=star>=2,star3IsOn=star>=3,

        }
        table.insert(list,dungeonItem);
    end
    this.vm.data.areaList=list;
    list=nil;
end

this.SetEquipDungeonList=function(cfgDailyMap,dataDailyMap)
    this.vm.data.equipList={};
    local list={}
    local dungeonsGroup=NumTool.split(cfgDailyMap.dungeonIdGroup,",")
    for i,v in pairs(dungeonsGroup) do
        local dungeonRecord=dataDungeonRecords[v];
        local star=this.GetStar(dungeonRecord);
        local unlock=dataDailyMap.dungeons[v];
        local _offset=Vector2(0,0);
        local _lineDownOffset=Vector2(0,0);

        if i%2~=0 then
            _offset=Vector2(0,70);
        else
            _offset=Vector2(-67,-183);
        end

        if i>=(#dungeonsGroup) and i%2~=0 then
            _offset=Vector2(16,-22);
            _lineDownOffset=Vector2(42,75);
        end

        local spriteName="ui_rcfb_rk_tl00";
        if unlock then
            spriteName="ui_rcfb_rk_tl0"..tostring(i);
            if i==5 and curEquipWeekIndex~=nil then
                spriteName="ui_rcfb_rk_tl05_"..curEquipWeekIndex;
            end
        end
        
        local slider_List={};
        if unlock then
            local drops=ConfigMgr.Config.dungeonMap[v].secondDrop
            local maxCount=0;
            for i,v in ipairs(drops) do
                maxCount=maxCount+ ConfigMgr.Config.dropMap[v.id].ensureCount
            end
            local proCount=dungeonRecord==nil and 0 or dungeonRecord.completeCount % maxCount;
            for i=1,maxCount,1 do
                local proItem={
                    sizeData=Vector2(170/maxCount,20);
                    isOn=proCount>=i;
                }
                table.insert(slider_List,proItem);
            end
        end
        local starPos=Vector2(41.6,6.6);
        local equipName_5="";
        if i==5 and curEquipWeekIndex~=nil then
            equipName_5=ConfigMgr.LangGlobal(cfgEquipWeek.nameTurn[curEquipWeekIndex])
            starPos=Vector2(41.6,13.4)
            
        end
        local dungeonItem={dungeonId=v,
                           offset=_offset,
                           lineDownOffset=_lineDownOffset,
                           off=not unlock,
                           on=unlock,
                           upline=i%2==0 and i~=1,
                           downline=i%2~=0 and i~=1,
                           new=unlock and dungeonRecord==nil,
                           levelSprite=LuaMgr.GetSprite("AreaDialy",spriteName),
                           num=unlock and string.format("<color=#ffffff>0%s</color>",i)
                                   or string.format("<color=#B6B6B6>0%s</color>",i);
                           name=unlock and string.format("<color=#ffffff>%s</color>", LuaMgr.GetLangText(cfgDungeonMap[v].NameLan))
                                   or string.format("<color=#B6B6B6>%s</color>",LuaMgr.GetLangText(cfgDungeonMap[v].NameLan));
                           star1IsOn=star>=1,star2IsOn=star>=2,star3IsOn=star>=3,
                           sliderList=slider_List,
                           equipName=equipName_5,
                           starOffSet=starPos,
                           isShow = true

        }
        table.insert(list,dungeonItem);
    end
    this.vm.data.equipList=list;
    list=nil;
    
end


this.SetJobDungeonList=function(cfgDailyMap,dataDailyMap)
    this.vm.data.jobList={};
    local list={}
    local dungeonsGroup=NumTool.split(cfgDailyMap.dungeonIdGroup,",")
    local imgName = GALLERY_PAth .. "ui_rcfb_bj_" .. jobNameMap[curDailyActiveId] .. ".png";
    this.vm.data.textureJob = LuaMgr.GetTexture(imgName);
    print(imgName);
    
    for i,v in pairs(dungeonsGroup) do
        local dungeonRecord=dataDungeonRecords[v];
        local star=this.GetStar(dungeonRecord);
        local unlock=dataDailyMap.dungeons[v];

        local spriteName="ui_rcfb_rk_"..jobNameMap[curDailyActiveId].."00";
        if unlock then
            spriteName="ui_rcfb_rk_"..jobNameMap[curDailyActiveId].."0"..tostring(i);
        end

        local _offset=Vector2(0,0);
        
        if i%2~=0 then
            _offset=Vector2(0,0);
        else
            _offset=Vector2(0,-96);
        end
        
        local dungeonItem={dungeonId=v,
                           offset=_offset,
                           offset=_offset,
                           off=not unlock,
                           on=unlock,
                           new=unlock and dungeonRecord==nil,
                           jobBg=LuaMgr.GetSprite("AreaDialy",spriteName),
                           num=unlock and string.format("<color=#3d6666>0%s</color>",i)
                                   or string.format("<color=#575755>0%s</color>",i);
                           name=unlock and string.format("<color=#efe5cc>%s</color>",LuaMgr.GetLangText(cfgDungeonMap[v].NameLan))
                                   or string.format("<color=#575755>%s</color>",LuaMgr.GetLangText(cfgDungeonMap[v].NameLan));
                           star1IsOn=star>=1,star2IsOn=star>=2,star3IsOn=star>=3,

        }
        table.insert(list,dungeonItem);
    end
    this.vm.data.jobList=list;
    list=nil;
    
end



this.GetStar=function(dungeonRecord)
    local star=0;
    if dungeonRecord==nil or dungeonRecord.historyRating=="" then
        star=0;
    elseif dungeonRecord.historyRating=="B" then
        star=1;
    elseif dungeonRecord.historyRating=="A" then
        star=2;
    elseif dungeonRecord.historyRating=="S" then
        star=3;
    end
    return star;
end




this.SetActInfo=function(dailyData,isEquip)
    if isEquip~=nil and curEquipWeekIndex~=nil and isEquip then
        this.vm.data.equipResOpen=true;
        this.vm.data.actJobResOpen=false;
        this.vm.data.jobResOpen=false;
        return
    end
    this.vm.data.equipResOpen=false;
    this.vm.data.actJobResOpen=dailyData.status==2;
    this.vm.data.jobResOpen=dailyData.status==1;
    if dailyData.status==2 then
        local timePara=cfgDailyActiveMap[dailyData.activeId].timeParaSP;
        local times=NumTool.split(timePara,",");
        
        this.vm.data.actText=string.format(LuaMgr.GetLangText("AreaDailyViewModel_18"),times[2]);
    end
   
end

this.GetOpenTimeOffWeek=function(dailyMap)
    if dailyMap.timeType == 6 then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319")
        local dungeonConfig = ConfigMgr.Config.dungeonMap[dailyMap.timePara];
        local name = LuaMgr.GetLangText(dungeonConfig.NameLan)
        return string.format(tips, name)
    end
    local openTimers=NumTool.split(dailyMap.timePara,",")
    local result="";

    for i,v in ipairs(openTimers) do
        if v~=nil and v~="" then
            local day=tonumber(v);
if day<=5 then
                if(i==1) then
                    result=weekDaysNum[day];
                else
                    result=result..LuaMgr.GetLangText("AreaDailyViewModel_20").. weekDaysNum[day];
                end
            end
        end
    end

    if result==nil or result=="" then
        for i,v in ipairs(openTimers) do
            if v~=nil and v~="" then
                local day=tonumber(v);
                if(i==1) then
                    result=weekDaysNum[day];
                else
                    result=result..LuaMgr.GetLangText("AreaDailyViewModel_21").. weekDaysNum[day];
                end
            end
        end
    end

    if result==nil or result=="" then
        return result;
    end

    return string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2390"),result);
end

this.GetDungeonUnlockState=function(dungeonIdGroup)
    local unlockList={};
    local defaultUnlock=true;
    for i,v in ipairs(dungeonIdGroup) do
        local dungeonRecord=dataDungeonRecords[v];
        local hasrecord=dungeonRecord~=nil;
        local unlock=defaultUnlock or hasrecord;
        defaultUnlock=hasrecord;
        if(unlock) then
            table.insert(unlockList,true);
        else
            table.insert(unlockList,false);
        end
    end
    return unlockList;
    
end




this.SetOpenTime=function(dailyMap)
    if dailyMap.timeType == 6 then
        return
    end
    local dayWeek=os.date("%w",LuaMgr.Timestamp()-14400);
    if(dayWeek=="0") then dayWeek="7" end;
    this.vm.data.weekItemList={};
    local list={};
    for i,v in ipairs(weekDays) do
        local isHas,index=string.find(dailyMap.timePara,tostring(i));
        local re=dayWeek==tostring(i);
        local weekItem={
            weekName=isHas and v or string.format("<color=#89774b>%s</color>",v),
            today=re and not this.vm.data.actJobResOpen,
            actToday=re and this.vm.data.actJobResOpen,
        }
        table.insert(list,weekItem);
    end
    this.vm.data.weekItemList=list;
    
end

this.GetRefushDataTime=function()
    local da=os.date("*t",LuaMgr.Timestamp());
    local tempTimestamp=os.time({year=da.year,month=da.month,day=da.day,hour=4});
    if(lastActiveTimeStamp<tempTimestamp and LuaMgr.Timestamp()>tempTimestamp)then
        lastActiveTimeStamp=LuaMgr.Timestamp();
        return true;
    end
    return false;
end


this.FindDailyActiveTypeIndex=function(NO, cfgTypeBarData)
    local typeBar = NO;
    if  this.vm.behaviour.IsPop then
        return typeBar;
    end
    local params = this.vm.behaviour.Params;
    if (params.Length > 0) then
        local typeId = params[0];
        for i,v in ipairs(cfgTypeBarData) do
            if (v.id == typeId) then

                return i;
            end
        end
    end
    return typeBar;
end


this.FindDailyActiveJobIndex=function(jobData)
    local jobBar = curJobBar;
    if  this.vm.behaviour.IsPop then
        return jobBar;
    end
    local params = this.vm.behaviour.Params;
    
    if params.Length==1 then
        local tabs=params[0];
        tabs=NumTool.split(tabs,"_");
        if #tabs==1 then
            return jobBar;
        else
            for i,v in ipairs(jobData) do
                if (v.activeId == tabs[2]) then
                    return i;
                end
            end
        end
    end
    
    if (params.Length > 1) then
        local activeId = params[1];
        for i, v in ipairs(jobData) do
            if (v.activeId == activeId) then
                params[1]=nil;
              return i;
            end
        end
    end
    
    return jobBar;
end



this.SetWeekEquipBaseData=function(cfgDailyMap)
    cfgEquipWeek=ConfigMgr.Config.dailyActiveMap["100003"];
    curEquipWeekIndex = (this.equipTurnServerData.Turn or 0) + 1
    BattlePrepareMgr.SetAreaDailyWeekEquipTurn(curEquipWeekIndex)
    curEquipWeekEndTime = this.equipTurnServerData.EffectTime[2]
    local endTime=os.date("%Y.%m.%d",curEquipWeekEndTime)
    this.vm.data.otherEquip_topTitle=string.format(ConfigMgr.LangGlobal("2804"),endTime);
    this.vm.data.otherEquip_topTip=ConfigMgr.LangGlobal("2805")
end


this.SetOtherWeekEquipInfo=function()
    this.SetEquipItemInfo((this.equipTurnServerData.Turn2 or 0) + 1,this.equip1UIList);
    this.SetEquipItemInfo((this.equipTurnServerData.Turn3 or 0) + 1,this.equip2UIList);
   
    local next1Time=this.equipTurnServerData.EffectTime2;
    local next1_startTime=os.date("%Y.%m.%d",next1Time[1]);
    local next1_endTime=os.date("%Y.%m.%d",next1Time[2]);
    local next1Str=string.format("%s-%s",next1_startTime,next1_endTime);
    this.vm.data.otherEquip_next1Title=string.format(ConfigMgr.LangGlobal("2806"),next1Str);
    
    local next2Time=this.equipTurnServerData.EffectTime3;
    local next2_startTime=os.date("%Y.%m.%d",next2Time[1]);
    local next2_endTime=os.date("%Y.%m.%d",next2Time[2]);
    local next2Str=string.format("%s-%s",next2_startTime,next2_endTime);
    this.vm.data.otherEquip_next2Title=string.format(ConfigMgr.LangGlobal("2807"),next2Str);
    
end


this.SetEquipItemInfo=function(turn,uiList)
    local showEquips=cfgEquipWeek.showTurn[turn];
    local list={}
    for i,v in ipairs(showEquips) do
        local equipItem={
            equipId=v;
        }
        local equipData=UIListData.GetData(this.equipObj,"AreaDaily_equip",equipItem);
        table.insert(list,equipData);
    end
    uiList:SetData(list);
end



return vm({
    data = data,
    command = command,
    hook = hook
})
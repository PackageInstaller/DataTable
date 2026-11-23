local this = {vm=nil};

local this = {vm=nil};
local cfgActMapEventList={}
local cfgActMapGroupList={}
local cfgActMapList={}
local cfgDungeonMap={}
local dataActEvents={}
local dataActMapGroup={};
local dungeonRecords={};
local chapterPosList={Vector2(-1146,81),Vector2(-885,22),Vector2(-760,-99),Vector2(-501,-84),Vector2(-342,77),Vector2(-107,-56),
                      Vector2(103,-72),Vector2(343,181),Vector2(567,115),Vector2(798,147),Vector2(1010,-59),Vector2(1202,43) }
local chapterSizeList={Vector2(112,112),Vector2(92,132),Vector2(152,152),Vector2(104,104),Vector2(128,128),Vector2(140,224),
                       Vector2(96,112),Vector2(100,128),Vector2(148,148),Vector2(112,112),Vector2(92,124),Vector2(124,152)}

local chapterDissovleValue={0.35,0.49,0.69,0.75}
local levelSpriteNames={"ui_hd_hzj_lb_bt_jd","ui_hd_hzj_lb_bt_pt","ui_hd_hzj_lb_bt_kn"}

local chapterAniName1="UI_FlowerFestivalPanel_chapterItem";
local chapterAniName2="UI_FlowerFestivalPanel_chapterItem2";

local rootAniName1="UI_FlowerFestivalPanel_01";
local rootAniName2="UI_FlowerFestivalPanel_PopLevel";
local rootAniName3="UI_FlowerFestivalPanel_bg";
local curChapterIndex=nil;
local remainTime=nil;
local coKey=nil;
local data = {

    chapterList={{chapterPos=Vector2(0,0),
                  chapterSize=Vector2(100,100),
                  chapterSprite=DefaultSprite,
                  chapterPass_Sprite=DefaultSprite,
                  chapterLock_Sprite=DefaultSprite,
                  btnInteractable=true,
                  chapterBool=true,
                  chapterPassBool=false,
                  chapterLock=false,
                  flyBool=false,
                  rootBool=false,
                  chapterAniName="",
                  chapterCompleteCount=0,
                 }},
    levelList={{suoBool=false,unLockBool=true,unlockInfo="",bestLevel="",levelName="",oneText="",twoText="",endText="",isPass=false,rewardList={{}}}},

    LevelPopBool=false;
    bgContentAnchorPos=Vector2(0,0);
    level_remainTimeBool=true;
    level_warinInfoBool=false;
    remainTime="";
    warnInfo="";
    rootAniName="";
    dissovleValue=0.3;
    flowerFX_2Bool=false;
    flowerFX_3Bool = false;
    flowerFX_4Bool=false;
    
    kvBool=false;
    rootBool=false;
    activityRunning=false;
    
}
local command = {

    skinBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if(not this.CheckOpen()) then  return end;
            LuaMgr.ShowLuaPanel(UIName.FlowerSkinViewModel)
        end
    },
    taskBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if(not this.CheckOpen()) then  return end;
            LuaMgr.ShowLuaPanel(UIName.FlowerTaskViewModel)
        end
    },
    shopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if(not this.CheckOpen()) then  return end;
            LuaMgr.ShowLuaPanel(UIName.FlowerShopViewModel)
        end
    },
    chapterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;

            if this.vm.data.chapterList[index].chapterLock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7108"))
                return;
            end
            this.ShowLevelPop(index);
        end
    },
    levelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local level=this.vm.data.levelList[index];
            this.PrepareLevel(level.id);
        end
    },
    LevelPopCloseBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.LevelPopBool=false;
            HeroParameter.huazhaoChapter=nil;
        end
    },

}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        RedMgr.Singleton:RegisterViewModel(UIName.FlowerFestivalViewModel);
        print("before_awake");
        
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            this.vm.data.rootAniName=rootAniName1;
            vm.behaviour:UpdateTopBar("", this.OnBack);


            this.ParseConfig();
            if not vm.behaviour.IsPop and  HeroParameter.huazhaoLevel==nil then
                this.vm.data.kvBool=true;
                this.vm.data.rootBool=false
                if coKey~=nil then
                    coroutine_runner.stop(coKey)
                end
                coKey=coroutine_runner.start(function()
                    coroutine_runner.wait(1)
                    this.vm.data.rootBool=true;
                    this.ParseData();
                end)
            else
                this.vm.data.kvBool=false;
                this.vm.data.rootBool=true;
                this.ParseData();
            end
           
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");

        LuaMgr.RemoveTimer(TimerConst.FlowerTimer)
    end,
}




this.OnBack=function()
    if  not DataExHelper.Check_FlowerRuning() then
        LuaMgr.Back();
    else
        LuaMgr.Back("huazhao");
    end
end

this.ParseConfig=function()
    dungeonRecords=DataMgr.Player.dungeonRecords;
    cfgActMapGroupList=ConfigMgr.Config.activityMapGroupList;
    cfgActMapEventList=ConfigMgr.Config.activityMapEventList;
    cfgDungeonMap=ConfigMgr.Config.dungeonMap;
    cfgActMapList=ConfigMgr.Config.activityMapList;
end

this.ParseData=function()
    HeroParameter.huazhaoLevel=nil;
    this.vm.data.activityRunning=false;
    if DataExHelper.Check_FlowerRuning() then
        this.vm.data.activityRunning=true;
        HeroRedDataHelper.ShowFlowerRed();
        RedMgr.Singleton:Refresh();
        this.ShowTimer();
        if DataMgr.Player.activityMaps.huazhao==nil then
            this.vm.data.chapterList={};
            return
        end
        dataActEvents=DataMgr.Player.activityMaps.huazhao.activityEvents;
        dataActMapGroup=DataMgr.Player.activityMaps.huazhao.mapGroups;
        
    end
    this.vm.data.LevelPopBool=false;
    this.ShowFestival();

end

this.CheckLevelTime=function(index)
    local group=cfgActMapGroupList[index];
    local curTimeStamp=LuaMgr.Timestamp();
    if group.openDate==0 and group.closeDate==0 then
        return true;
    end
    if curTimeStamp<group.openDate then
        local date1=os.date("20%y-%m-%d %H:%M:%S",group.openDate);
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("FlowerFestivalViewModel_0")..date1);
    elseif curTimeStamp>group.closeDate then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("FlowerFestivalViewModel_1"));
    end
    return curTimeStamp>=group.openDate and curTimeStamp<=group.closeDate;
end


this.CheckOpen=function()
    local groupId = ActivityMgr.groupKeyList["huazhao"]
    local re=DataMgr.Player.variables[groupId];
    if re==nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("FlowerFestivalViewModel_2"));
    end
    return re~=nil;
end

this.CheckLevelOpen=function()
    for i,v in pairs(cfgActMapList) do
        if v.area=="huazhao" then
            if v.closeDate<=LuaMgr.Timestamp() then
                return false,v;
            else
                return true,v;
            end
        end
    end
end


this.ShowTimer=function()
    if not this.CheckOpen() then
        this.vm.data.level_warinInfoBool=true;
        this.vm.data.level_remainTimeBool=false;
        this.vm.data.warnInfo=LuaMgr.GetLangText("FlowerFestivalViewModel_3")
        return;
    end
    local isOpen,cfgFlowerMap=this.CheckLevelOpen();
    if not isOpen then
        this.vm.data.level_warinInfoBool=true;
        this.vm.data.level_remainTimeBool=false;
        this.vm.data.warnInfo=LuaMgr.GetLangText("FlowerFestivalViewModel_4")
        return;
    end
    this.vm.data.level_warinInfoBool=false;
    this.vm.data.level_remainTimeBool=true;
    local timer=cfgFlowerMap;
    if timer~=nil then
        remainTime=timer.closeDate-LuaMgr.Timestamp();
        LuaMgr.RemoveTimer(TimerConst.FlowerTimer)
        LuaMgr.AddTimer(TimerConst.FlowerTimer,this.ShowTime,1,-1,true);
    end
end

this.ShowTime=function()
    if remainTime<0 then return end;
    local day=math.floor(remainTime/86400);
    local hour=math.fmod(math.floor(remainTime/3600),24);
    local minute=math.fmod(math.floor(remainTime/60), 60);
    this.vm.data.remainTime=string.format(LuaMgr.GetLangText("FlowerFestivalViewModel_6"),day,hour,minute);
    remainTime=remainTime-1;
end


this.ShowFestival=function()
    this.vm.data.chapterList={}
    local list={};
    curChapterIndex=0;
    for i,v in ipairs(cfgActMapGroupList) do

        if v.area=="huazhao" then
            local festivalItem={
                chapterPos=chapterPosList[i],
                chapterSize=chapterSizeList[i],
                chapterSprite=LuaMgr.GetSprite("Flower",v.statusIcon),
                chapterPass_Sprite=LuaMgr.GetSprite("Flower",v.statusIcon.."_2"),
                chapterLock_Sprite=LuaMgr.GetSprite("Flower",v.statusIcon.."_3"),
                btnInteractable=true;
                rootBool=true;
                chapterBool=false;
                chapterPassBool=this.CheckChapterPass(v.id);
                chapterLock=not IsNullOrEmpty(v.unlockParam) and (dungeonRecords[v.unlockParam]==nil or dungeonRecords[v.unlockParam].completeCount==0);
                flyBool=false,
                chapterAniName="",
                id=v.id;
                chapterCompleteCount=this.GetChapterCount(v.id),
                curBool=false,
            }
            if not festivalItem.chapterLock then
                curChapterIndex=curChapterIndex+1;
            end
            table.insert(list,festivalItem);
       end
    end
    if curChapterIndex>1 then
        list[curChapterIndex-1].chapterBool=true;
        list[curChapterIndex-1].chapterPassBool=false;
    end
    this.SetDissvle(list);
    this.vm.data.chapterList=list;
    this.DOMoveBG();
    this.ShowFestivelFX();
    
    list=nil;
end

this.CheckChapterPass=function(groupId)
    local levelList=this.CheckLevelData(groupId);
    if #levelList==0 then return false end;
    for i, v in ipairs(levelList) do
        if dungeonRecords[v.eventParam]==nil or dungeonRecords[v.eventParam].completeCount<=0 then
            return false
        end
    end
    return true
end

this.GetChapterCount=function(groupId)
    local levelList=this.CheckLevelData(groupId);
    if #levelList==0 then return 0 end;
    local count=0;
    for i,v in ipairs(levelList) do
        if dungeonRecords[v.eventParam]~=nil and dungeonRecords[v.eventParam].completeCount>0 then
            count=count+dungeonRecords[v.eventParam].completeCount;
        end
    end
    return count;
end

this.DOMoveBG=function()
    if curChapterIndex<7 and curChapterIndex>=4 then
        this.vm.data.bgContentAnchorPos=Vector2(-4*120,0);
    elseif curChapterIndex>=7 and curChapterIndex<9 then
        this.vm.data.bgContentAnchorPos=Vector2(-7*120,0);
    elseif curChapterIndex>=9 then
        this.vm.data.bgContentAnchorPos=Vector2(-13*120,0);
    end
    
end




this.SetDissvle=function(list)
local lastDissvleIndex =math.ceil((curChapterIndex-1)/3);
    local dissvleIndex=math.ceil(curChapterIndex/3);
    if dissvleIndex>lastDissvleIndex and lastDissvleIndex~=0 
    and list[curChapterIndex].chapterCompleteCount==0 and not this.CheckFlyFristShowed(list[curChapterIndex].id,1)then
        dissvleIndex=lastDissvleIndex;
    end
    this.vm.data.flowerFX_2Bool=dissvleIndex>=2;
    this.vm.data.flowerFX_3Bool=dissvleIndex>=3;
    this.vm.data.flowerFX_4Bool=dissvleIndex>=4;
    this.vm.data.dissovleValue=chapterDissovleValue[dissvleIndex];
end

this.ShowFestivelFX=function()
    coroutine_runner.start(function()
        for i,v in ipairs(this.vm.data.chapterList) do
            if i<curChapterIndex-1 then
                v.chapterBool=true;

            elseif i==curChapterIndex-1 then
                if this.vm.data.chapterList[curChapterIndex].chapterCompleteCount>0 or  this.CheckFlyFristShowed(v.id,2) then
                    v.chapterBool=true;

                else
                    v.chapterBool=true;
                    this.DODissovleValue(i);
                    coroutine_runner.wait(1);

                    AudioHelper.PlayUISFX(AudioNames.HuaZhao_1)
                    v.chapterAniName=chapterAniName1;
                    this.SavePlayerPrefs(DataMgr.Player.uid..v.id,2);
                end
            elseif i==curChapterIndex  then

                if v.chapterCompleteCount==0 and not this.CheckFlyFristShowed(v.id,1) then
                    coroutine_runner.wait(1)
                    v.flyBool=true;
                    AudioHelper.PlayUISFX(AudioNames.HuaZhao_2)

                    coroutine_runner.wait(0.8)
                    v.chapterAniName=chapterAniName2;
                    AudioHelper.PlayUISFX(AudioNames.HuaZhao_3)
                    coroutine_runner.wait(0.2)
                    v.chapterLock=false;

                    this.SavePlayerPrefs(DataMgr.Player.uid..v.id,1);

                elseif v.chapterCompleteCount==0 and this.CheckFlyFristShowed(v.id,1)then
                    v.chapterBool=true;
                    v.chapterLock=false;


                elseif v.chapterCompleteCount==1 and this.CheckFlyFristShowed(v.id,1) then
                    v.chapterBool=true;
                    if curChapterIndex<5 then
                        coroutine_runner.wait(1);
                    else
                        coroutine_runner.wait(1.5);
                    end

                    AudioHelper.PlayUISFX(AudioNames.HuaZhao_1)
                    v.chapterAniName=chapterAniName1;
                    this.SavePlayerPrefs(DataMgr.Player.uid..v.id,2);

                else
                    v.rootBool=true;
                    v.chapterBool=true;

                end

            end
            
        end
        if HeroParameter.huazhaoChapter~=nil then
            this.ShowLevelPop(HeroParameter.huazhaoChapter)
        end
    end)
    
end

this.DODissovleValue=function(index)
    local missovleIndex=math.ceil(index/3);
    local nextMissovleIndex=math.ceil((index+1)/3);
    if nextMissovleIndex>missovleIndex then
        DOTWeen.To(function()return this.vm.data.dissovleValue  end,
                function(value) this.vm.data.dissovleValue=value  end,chapterDissovleValue[nextMissovleIndex],1)
                .onComplete=function()
            this.vm.data.flowerFX_2Bool=nextMissovleIndex>=2;
            this.vm.data.flowerFX_3Bool=nextMissovleIndex>=3;
            this.vm.data.flowerFX_4Bool=nextMissovleIndex>=4;
        end;
    end
    
end


this.SavePlayerPrefs=function(key,value)
    if UnityEngine.PlayerPrefs.HasKey(key) then
        UnityEngine.PlayerPrefs.DeleteKey(key)
    end
    UnityEngine.PlayerPrefs.SetInt(key,value);
end

this.CheckFlyFristShowed=function(id,value)
    local re= UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid..id);
    print(id,re,value);
    return re==value;
end



this.ShowLevelPop=function(index)
    if not this.CheckLevelTime(index) then return end;
    local groupId= cfgActMapGroupList[index].id;
    local eventsByGroup=this.CheckLevelData(groupId);
    if #eventsByGroup==1 then

        this.PrepareLevel(eventsByGroup[1].id);
        HeroParameter.huazhaoChapter=nil;
        return
    end
    this.vm.data.rootAniName=rootAniName2;
    this.vm.data.LevelPopBool=true;
    this.vm.data.levelList={};
    local list={};
    for i,v in ipairs(eventsByGroup) do
        local dungeon=cfgDungeonMap[v.eventParam];
        local subList={};
        local rewards=dungeon.firstDropShow;
        local showReward=NumTool.split(rewards,';')
        for _i,_v in ipairs(showReward) do
            local Item =ConfigMgr.Config.itemMap[tostring(_v)];
            local subItem={
                id=tostring(_v),isCount=false,
                rare=ActivityMgr.GetRareSprite(Item.rare),
                icon=ActivityMgr.GetItemTexture(tostring(_v)),
                scale=Vector3(0.4,0.4,0.4),
                sizeDelta=Vector2(58,58),
                isClick=true
            }
            table.insert(subList,subItem)
        end
        local eventPoem=LuaMgr.GetLangText(v.descriptionlan);
        local poems=NumTool.split(eventPoem,'，');
        local levelUnlock=IsNullOrEmpty(v.unlockParam) or (dungeonRecords[v.unlockParam]~=nil and dungeonRecords[v.unlockParam].completeCount>0);
        local levelItem={
            levelName=LuaMgr.GetLangText(v.namelan);
            oneText=poems[1],
            twoText=poems[2],
            rewardList=subList;
            suoBool=levelUnlock==nil,
            unlockInfo=v.tipslan~=nil and LuaMgr.GetLangText(v.tipslan) or "";
            bestLevel=tostring(dungeon.levelShow),
            id=v.id;
            isPass=dungeonRecords[v.id]~=nil and dungeonRecords[v.id].completeCount>0
        }
        table.insert(list,levelItem);
    end
    this.vm.data.levelList=list;
    HeroParameter.huazhaoChapter=index;
end

this.CheckLevelData=function(groupId)
    local eventsByGroup={}
    for i,v in ipairs(cfgActMapEventList) do
        if v.area=="huazhao" and  v.type == 2 and v.groupId==groupId then
            table.insert(eventsByGroup,v);
        end
    end
    return eventsByGroup;
end


this.PrepareLevel=function(dungeonId)
    LuaMgr.SetAreaBattleType(BattleType.HZJ);
    BattlePrepareMgr.EnterBattlePrepare(dungeonId,dungeonId,2);
    HeroParameter.huazhaoLevel=1;
end;

return vm({
    data = data,
    command = command,
    hook = hook
})
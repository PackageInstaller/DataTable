




local this = { vm = nil,
               colorBar1 = UnityEngine.Color(204 / 255.0, 192 / 255.0, 162 / 255.0, 255 / 255),
               colorBar2 = UnityEngine.Color(38 / 255.0, 36 / 255.0, 41 / 255.0, 255 / 255),
               colorCourse1 = UnityEngine.Color(239 / 255.0, 229 / 255.0, 204 / 255.0, 255 / 255),
               colorCourse2 = UnityEngine.Color(0 / 255.0, 0 / 255.0, 0 / 255.0, 255 / 255),
               tagColor1 = UnityEngine.Color(59 / 255.0, 99 / 255.0, 98 / 255.0, 255 / 255),
               tagColor2 = UnityEngine.Color(173 / 255.0, 159 / 255.0, 135 / 255.0, 255 / 255),
               phaseDesColor1 = UnityEngine.Color(0 / 255.0, 0.0 / 255.0, 0 / 255.0, 255 / 255),
               phaseDesColor2 = UnityEngine.Color(241 / 255.0, 234 / 255.0, 218 / 255.0, 255 / 255),
               phaseDesColor3 = UnityEngine.Color(200 / 255.0, 200 / 255.0, 200 / 255.0, 255 / 255),
               tagColor1=UnityEngine.Color(32 / 255.0, 107 / 255.0, 109 / 255.0, 76 / 255),
               tagColor2 = UnityEngine.Color(53 / 255.0, 52 / 255.0, 49 / 255.0, 178 / 255),
               cfgMissionMap = {},
               dataMissions = {},
               cfgAreas = {},
               curArea = nil,
               curTab = nil,
               courseKey = nil,
               allRewardBool = false,
               name = {},
}
local data = {
    
    barlist={{isOn=false,name="",barColor=this.colorBar1,barIndex=0,redId="",lock=false}},
    phaseRewardList={{scale=Vector3(1,1,1),bg=DefaultSprite,btnBool=false,phaseDes="",phaseDesColor=this.phaseDesColor1,tagName="",tagBool=false,missionId="",tagColor=this.tagColor1,
                      phaseItemRewards={ 
                          { id = "",
                            rare = DefaultSprite, 
                            icon = DefaultTexture,
                            count=""
                             } }
                     }},
    courseList={{courseItemBool=false,
                 bg=DefaultSprite,
                 isFree=false,
                 hasRewardBool=true,
                 interactable=false,
                 des="",
                 tag=this.tagColor1,
                 desColor=this.colorCourse1,
                 progross=0.0,
                 progrossBool=true,
                 progrossVlaue="",
                 rewardBool=false,
                 missionId="";
                 point_1Bool=false,point_2Bool=false,point_3Bool=false,point_4Bool=false,point_5Bool=false,
                 point_1IsOn=false,point_2IsOn=false,point_3IsOn=false,point_4IsOn=false,point_5IsOn=false,
                 courseItemRewards={ { id = "",
                                       rare = DefaultSprite,
                                       icon = DefaultTexture,
                                       count = "",
                                     } },
                 starsList={{isOn=false}}
                }},
    progrossList={{bg_di=DefaultSprite,bg=DefaultSprite,pro=0.0}};
    pointsList={{isOn=false}};
    chaterBg=DefaultSprite,
    cityName="",
    cityChapter="",
    chapterProgrossValue="";
    courseRewardAllBool=true;
    courseNoRewardAllBool=false;
    isRewardsAll=false;
    contentAnchorPos=Vector2(0,0);
    
    

    gridLayOutCellSize=Vector2(312,176);
    
    bgOffSetMin=Vector2(340,-322);
    bgOffSetMax=Vector2(-28,322);
    
    rightOffSetMin=Vector2(340,-50);
    rightOffSetMax=Vector2(-24,50);
    
    leftOffSetPos=Vector2(600,0);
    rightScrollAlpha=1.0
    
}

local command = {
    phaseRewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param+1)
            local missId=vm.data.phaseRewardList[index].missionId;
            this.CompletemMission(missId);
        end

    },
    courseRewardBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=(param+1)
            local missId=vm.data.courseList[index].missionId;
            this.CompletemMission(missId);
        end
    },
    courseRewardAllBtn = {
        type = XLuaCommandType.Void;
        execute = function(vm, param)
            this.CompletemMission("all");
        end
    },
    tabToggle = {
        type = XLuaCommandType.Bool,
        execute = function(vm, isOn, param)
            this.OnSwitchTab(isOn,tonumber(param + 1));
        end
    },

}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.name={LuaMgr.GetLangText("AreaCourseViewModel_3"),LuaMgr.GetLangText("AreaCourseViewModel_4"),LuaMgr.GetLangText("AreaCourseViewModel_5")};
        RedMgr.Singleton:RegisterViewModel(UIName.AreaCourseViewModel);
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            local data=vm.behaviour.Params;
            this.curArea=data[0];
            this.curTab=0;
            this.ScreenAjust();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)

    end,
    before_destroy=function(vm)
        this=nil
    end
}




this.CompletemMission=function(missionId)
    local data={missionId=missionId,tab=this.curArea};
    ApiMgr.Request("complete_mission", data, true, function(data)
        local result=json.decode(data);
        local dataString=json.encode(result.result);
        LuaMgr.ShowItemRewared(dataString);
        this.ParseData();
    end,nil,true);
end


this.OnSwitchTab=function(isOn,index)
    if (not isOn or this.curTab==index) then
        return;
    end
    this.curTab=index;
    
    for i,v in ipairs(this.vm.data.barlist) do
        if(v.barIndex==index) then
            v.barColor=this.colorBar2;
            this.curArea=v.area;
        else
            v.barColor=this.colorBar1;
        end
    end
    
    for i, v in ipairs(this.vm.data.pointsList) do
        if(i==index) then
            v.isOn=true;
        else
            v.isOn=false;
        end
    end
    this.SetLeftInfo()
    this.SetRightReward()
    
end












this.ScreenAjust=function()
    local defaultRate=16/9;

    local offset= LuaMgr.ScreenOffSet();
    local screenWidth=LuaMgr.ScreenWidth();
    local screenHight=LuaMgr.ScreenHeight();
    local rate=screenWidth/screenHight;
    local zoomRate=(rate/defaultRate-1);
    local ZOOMSIZE=200;

    local zoomOffSet=ZOOMSIZE*zoomRate;
    local offsetMix=Vector2(340+zoomOffSet,-50);
    local offsetMax=Vector2(-24-zoomOffSet,50);

    this.vm.data.rightOffSetMax=offsetMax;
    DOTWeen.To(function() return Vector2(664,-50)  end,
    function(vect) this.vm.data.rightOffSetMin=vect  end,offsetMix,0.5);



    
    
    
    this.vm.data.bgOffSetMin=Vector2(340+zoomOffSet,-322);
    this.vm.data.bgOffSetMax=Vector2(-28-zoomOffSet,322);
    
    this.vm.data.leftOffSetPos=Vector2(600+zoomOffSet,0);
    
    local scrollViewWidth=screenWidth-340-zoomOffSet-offset;
    if(zoomRate>0.02) then
        scrollViewWidth=scrollViewWidth-60;
    end
    local cellX=scrollViewWidth/3;
    this.vm.data.gridLayOutCellSize=Vector2(cellX,176);

end


this.ParseData=function()
    this.allRewardBool=false;
    this.vm.data.contentAnchorPos=Vector2(0,0);
    this.cfgMissionMap=ConfigMgr.Config.missionMap;
    this.dataMissions=DataMgr.Player.missions;
    this.cfgAreas=ConfigMgr.Config.areas;
    if this.curArea==nil then 
        return 
    end;
    this.SetTopBar();
    this.SetLeftInfo()
    this.SetRightReward() 
end



this.SetTopBar=function()
    local unlockArea=this.FilterZhengzhuanUnLockAreaMap();
    this.vm.data.barlist={};
    this.vm.data.pointsList={};
    local list={};
    local pointsList={};
    for i,v in ipairs(unlockArea) do
        local baritem= {
            isOn = v.area == this.curArea,
            barIndex = i,
            name = LuaMgr.GetLangText(v.mapTitlelan),
            barColor = v.area == this.curArea and this.colorBar2 or this.colorBar1, area = v.area,
            redId = "1014_" .. i,
lock = not PlayerAreaMgr.CheckAreaUnlock(v.area),
        }
        table.insert(list,baritem);
        
        local pointItem={isOn=v.area==this.curArea};
        table.insert(pointsList,pointItem);
    end
    this.vm.data.barlist=list;
    this.vm.data.pointsList=pointsList;
    this.ShowRed();
end

this.ShowRed=function()
   local unlockArea=this.FilterZhengzhuanUnLockAreaMap();
    for i,v in ipairs(unlockArea) do
        local red=0;
        if this.dataMissions[v.area]~=nil and this.dataMissions[v.area]["202"]~=nil then
            local missions= this.dataMissions[v.area]["202"];
            local redAreaData=this.FormatPhaseData(missions);
            for _i,_v in ipairs(redAreaData) do
                local state=this.GetCourseState(_v);
                if(state==1) then
                    red=1;
                    break;
                end
            end
            local phaseMissions=this.dataMissions[v.area]["203"]
            redAreaData=this.FormatPhaseData(phaseMissions);
            for _i,_v in ipairs(redAreaData) do
                local state=this.GetCourseState(_v);
                if(state==1) then
                    red=1;
                    break;
                end
            end
        end
        RedMgr.Singleton:UpdateClientRedData(this.vm.data.barlist[i].redId,red);
    end
end

this.FilterZhengzhuanUnLockAreaMap=function()
    local areaMap=ConfigMgr.Config.areas;
    local zhengzhuanAreas={};
    local isBanned = false
    for i,v in pairs(areaMap) do

        isBanned = FeatureManager.UnifyVerControls("areamap",v.area)
        if(v.world=="zhengzhuan") and isBanned then
            table.insert(zhengzhuanAreas,v);
        end
    end









    table.sort(zhengzhuanAreas,function(a, b) return a.sortNum<b.sortNum  end)
    return zhengzhuanAreas;
end

this.SetLeftInfo=function()
    this.vm.data.progrossList={};
    this.vm.data.cityName=LuaMgr.GetLangText(this.cfgAreas[this.curArea].mapTitlelan)
    this.vm.data.chaterBg=LuaMgr.GetSprite("AreaCourse","ui_cj_img_"..this.curArea);
    if(this.dataMissions[this.curArea]==nil or this.dataMissions[this.curArea]["203"]==nil) then
        local msg=LuaMgr.GetLangText("AreaCourseViewModel_6")..this.curArea..LuaMgr.GetLangText("AreaCourseViewModel_7");
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,msg);
        return;
    end
    local phaseData=this.dataMissions[this.curArea]["203"];
    phaseData=this.FormatPhaseData(phaseData);
    table.sort(phaseData,function(a,b)
        return tonumber(a.id)<tonumber(b.id);
    end)
    local list={};
    local index=1;
    local lastTarget=0;
    local proIndex=1;
    for i,v in pairs(phaseData) do
        local targetCount = MissionHelper.GetTargetCount(v.id);
        local endStr="c"
        local pro=(v.current-lastTarget)/(targetCount-lastTarget);
        if pro>=1 then 
            endStr="a"
        elseif pro<1 and pro>0 then
            endStr="b"
        end
        local chapterItem={
            bg_di=LuaMgr.GetSprite("AreaCourse","ui_cj_jd0"..i.."c"),
            bg=LuaMgr.GetSprite("AreaCourse","ui_cj_jd0"..i..endStr),
            pro=pro
        }
        table.insert(list,chapterItem);
        lastTarget=targetCount;
        if index==3 then
            local value=v.current/targetCount;
            this.vm.data.chapterProgrossValue=value<1 and tostring(math.floor(value*100)).."%" or string.format("<color=#ffe7b0>%s</color>",tostring(math.floor(value*100)).."%");
        end
        index=index+1;
        proIndex=pro>=1 and proIndex+1 or proIndex;
        
    end
    this.vm.data.progrossList=list;
    proIndex=proIndex>=3 and 3 or proIndex;
    local areas=ConfigMgr.Config.areas;
    this.vm.data.cityChapter=LuaMgr.GetLangText(areas[this.curArea].episodelan);
    this.SetLeftReward();
    
end
this.SetLeftReward=function()
    this.allRewardBool=false
    this.vm.data.phaseRewardList={};
    local dataPhaseData=this.dataMissions[this.curArea]["203"];
    local sortlist=this.FormatPhaseData(dataPhaseData);
    table.sort(sortlist,function(a,b)
        return tonumber(a.id)<tonumber(b.id);
    end)
    local lastTarget=0;
    local list={};
    local cfgPhaseList=this.GetCfgPhases();
    for i,v in pairs(sortlist) do
        local dataItem=v;
        local cfgPhase=this.GetRewardData(cfgPhaseList,v.id);
        local rewardlist={};
        for i,v1 in pairs(cfgPhase.rewards) do
            local item =ConfigMgr.Config.itemMap[v1.itemId];
            local rewardItem= { id = v1.itemId, count = LuaMgr.NumFormat(v1.count),
                                rare = LuaMgr.GetSprite("ItemRare", "itemRare" .. item.rare),
                                icon = LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. v1.itemId .. ".png");
            }
            table.insert(rewardlist,rewardItem);
        end
        
        local state=this.GetRewardState(dataItem,lastTarget);
        lastTarget=MissionHelper.GetTargetCount(v.id);

        if(i==1 and state==2) then
            state=3
        end;
        if state==4 then
            this.allRewardBool=true 
        end;
        local bgName="ui_cj_jl_di0"..state;
        local itemRewad={scale=state==1 and Vector3(0.9,0.9,0.9) or Vector3(1,1,1),bg=LuaMgr.GetSprite("AreaCourse",bgName),btnBool=state==4,missionId=v.id,
                         tagBool=state ==4 ,tagName=state==4 and LuaMgr.GetLangText("AreaCourseViewModel_9") or "",phaseDes=LuaMgr.GetLangText(cfgPhase.NameLan),
                         order=state,phaseItemRewards=rewardlist}
        if state==4 then
            itemRewad.phaseDesColor=this.phaseDesColor1
        elseif state==3 then
            itemRewad.phaseDesColor=this.phaseDesColor2
        else
            itemRewad.phaseDesColor=this.phaseDesColor3
        end
        table.insert(list,itemRewad);
    end

    this.vm.data.phaseRewardList=list;
    
end

this.FormatPhaseData=function(data)
    if(data==nil) then return nil end;
    local list={}
    for i,v in pairs(data) do
        table.insert(list,v)
    end
    return list;
end

this.GetCfgPhases=function()
    local list={};
    for i,v in pairs(this.cfgMissionMap) do
        if(v.tab==this.curArea and v.type=="203") then
            table.insert(list,v);
        end
    end
    return list;
end

this.GetRewardData=function(cfgPhaseList,id)
    for i,v in pairs(cfgPhaseList) do
        if(v.id==id) then
            return v;
        end
    end
end

this.GetRewardState=function(itemData,lastTarget)
    local state=nil;
    local done=itemData.current-lastTarget>=itemData.target-lastTarget;
    if(itemData.completed and done) then
        state=1;
    elseif(not itemData.completed and done) then
        state=4;
    elseif(itemData.current-lastTarget>0)then
        state=3;
    else
        state=2;
    end
    return state;
end

this.GetCourseState=function(curseData)
    local state=nil;
    if(curseData.completed) then
        state=3;
    elseif(curseData.current>=curseData.target) then
        state=1;
    else
        state=2;
    end
    return state;
end

this.SetRightReward=function()
    this.vm.data.courseList={};
    if(this.dataMissions[this.curArea]==nil or this.dataMissions[this.curArea]["202"]==nil) then
        local msg=LuaMgr.GetLangText("AreaCourseViewModel_10")..this.curArea..LuaMgr.GetLangText("AreaCourseViewModel_11");
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,msg);
        return;
    end
    local dataCourseData=this.dataMissions[this.curArea]["202"];
    dataCourseData=this.FormatPhaseData(dataCourseData);
    table.sort(dataCourseData,function(a,b)
        return tonumber(a.id)<tonumber(b.id);
    end)
    local list={};
    local hasReward=0;
    local rewarded=0;
    for i,v in pairs(dataCourseData) do
        local cfgRewards=this.cfgMissionMap[v.id].rewards;
        local rewardlist={};
        for i,v1 in pairs(cfgRewards) do
            local item =ConfigMgr.Config.itemMap[v1.itemId];
            local rewardItem={id=v1.itemId,count=LuaMgr.NumFormat(v1.count),sizeDelta = Vector2(64, 64),isCount=true,
                              rare=LuaMgr.GetSprite("ItemRare", "itemRare" ..item.rare),
                              icon=LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. v1.itemId ..".png");
                              scale = Vector3(0.5, 0.5, 0.5), isClick = true}
            table.insert(rewardlist,rewardItem);
        end
        
        local state=this.GetCourseState(v);
        hasReward=state==1 and hasReward+1 or hasReward;
        rewarded=state~=3 and rewarded+1 or rewarded
        local bgName="ui_cj_rwdi0"..state;
        local cfgCourse=this.cfgMissionMap[v.id];
        local targetCount = MissionHelper.GetTargetCount(v.id);
        local courseItem={courseItemBool=false,bg=LuaMgr.GetSprite("AreaCourse",bgName), progross=v.current/targetCount,missionId=v.id;
                          hasRewardBool=v.groupCurrent~=v.groupTarget or not v.completed,
                          isFree=v.completed,
                          tag=not v.completed and this.tagColor1 or this.tagColor2,
                          interactable=v.current>=targetCount and not v.completed,
                          des=LuaMgr.GetLangText(cfgCourse.NameLan),rewardBool=state==1,
                          desColor=state==1 and this.colorCourse2 or this.colorCourse1,progrossBool=state==2, 
                          progrossVlaue="<color=#262429><size=20>"..LuaMgr.NumFormat(v.current).."</size></color>/"..LuaMgr.NumFormat(targetCount),
                          point_1Bool=v.groupTarget>=1,point_2Bool=v.groupTarget>=2,point_3Bool=v.groupTarget>=3,point_4Bool=v.groupTarget>=4,point_5Bool=v.groupTarget>=5,
                          point_1IsOn=v.groupCurrent>=1,point_2IsOn=v.groupCurrent>=2,point_3IsOn=v.groupCurrent>=3,point_4IsOn=v.groupCurrent>=4,point_5IsOn=v.groupCurrent>=5,
                          courseItemRewards=rewardlist};
        table.insert(list,courseItem);
    end
    this.vm.data.courseList=list;
    this.allRewardBool=this.allRewardBool or hasReward>0;
    this.vm.data.isRewardsAll=rewarded==0;
    this.vm.data.rightScrollAlpha=rewarded==0 and 0.8 or 1.0
    this.vm.data.courseRewardAllBool=this.allRewardBool;
    this.vm.data.courseNoRewardAllBool=not this.allRewardBool;
    if(this.courseKey~=nil) then
        coroutine_runner.stop(this.courseKey);
    end
    this.courseKey=coroutine_runner.start(function()
        for i,v in ipairs(this.vm.data.courseList) do
            coroutine_runner.wait(0.05);
            v.courseItemBool=true;
        end
    end)
   
end

return vm({
    data = data,
    command = command,
    hook = hook
})
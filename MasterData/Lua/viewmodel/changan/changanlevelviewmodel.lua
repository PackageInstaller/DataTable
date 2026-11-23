




local this = {
    vm=nil,
    changanList={},
    changanEventList={},
    cfgChanganLevelList={},
    dungeonRecords={},
    completedTags={},
    cfgDungeonMap={},
    tabIndex=nil;
    coKey=nil;
    
};
local data = {
    chapters={
        { isOn=false,name="",value=0.0,lock=true,isLevelLock=false,isOpeningTimeLock=false,openDate=0},
        { isOn=false,name="", value=0.0,lock=true,isLevelLock=false,isOpeningTimeLock=false,openDate=0},
        { isOn=false,name="", value=0.0,lock=true,isLevelLock=false,isOpeningTimeLock=false,openDate=0},
        { isOn=false,name="", value=0.0,lock=true,isLevelLock=false,isOpeningTimeLock=false,openDate=0},
    },
    levelList={
        { BGSprite=DefaultSprite,islock=false,tagSprite=DefaultSprite,tagText="",nameSprite=DefaultSprite,nameText="",isRate_ing=false,isRate_ed=false,boxNum="",unlockFX=false,parameter=0,statusIcon="",rateText="",rateImg=DefaultSprite},
        { BGSprite=DefaultSprite,islock=false,tagSprite=DefaultSprite,tagText="",nameSprite=DefaultSprite,nameText="",isRate_ing=false,isRate_ed=false,boxNum="",unlockFX=false ,parameter=0,statusIcon="",rateText="",rateImg=DefaultSprite},
        { BGSprite=DefaultSprite,islock=false,tagSprite=DefaultSprite,tagText="",nameSprite=DefaultSprite,nameText="",isRate_ing=false,isRate_ed=false ,boxNum="",unlockFX=false,parameter=0,statusIcon="",rateText="",rateImg=DefaultSprite},
        { BGSprite=DefaultSprite,islock=false,tagSprite=DefaultSprite,tagText="",nameSprite=DefaultSprite,nameText="",isRate_ing=false,isRate_ed=false ,boxNum="",unlockFX=false,parameter=0,statusIcon="",rateText="",rateImg=DefaultSprite},
        { BGSprite=DefaultSprite,islock=false,tagSprite=DefaultSprite,tagText="",nameSprite=DefaultSprite,nameText="",isRate_ing=false,isRate_ed=false ,boxNum="",unlockFX=false,parameter=0,statusIcon="",rateText="",rateImg=DefaultSprite},
        { BGSprite=DefaultSprite,islock=false,tagSprite=DefaultSprite,tagText="",nameSprite=DefaultSprite,nameText="",isRate_ing=false,isRate_ed=false,boxNum="",unlockFX=false ,parameter=0,statusIcon="",rateText="",rateImg=DefaultSprite},
        { BGSprite=DefaultSprite,islock=false,tagSprite=DefaultSprite,tagText="",nameSprite=DefaultSprite,nameText="",isRate_ing=false,isRate_ed=false ,boxNum="",unlockFX=false,parameter=0,statusIcon="",rateText="",rateImg=DefaultSprite},
    },
}

local command = {
    chapterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            if  this.vm.data.chapters[index].isOpeningTimeLock then
                local openDate=this.vm.data.chapters[index].openDate
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10003"].NameLan)
                local tip = os.date(LuaMgr.GetLangText("ChanganLevelViewModel_5"),openDate)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,tip));
                return
            end
            if this.vm.data.chapters[index].isLevelLock then
                local unlockLevel=ChanganMgr.changanMapList[index][1]
                local name=LuaMgr.GetLangText(this.cfgDungeonMap[unlockLevel.unlockParam].NameLan)
                local tipStr=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,name))
                return
            end

            for i,v in ipairs(this.vm.data.chapters) do
                v.isOn=i==index
            end
            this.ParseData(index)
            local key=DataMgr.Player.uid.."CHANGAN_LEVEL";
            UnityEngine.PlayerPrefs.SetInt(key,index);
        end
    },
    levelBtn = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local eventItem=this.changanEventList[index];
            if this.vm.data.levelList[index].islock then
                local dungeonName=LuaMgr.GetLangText(this.cfgDungeonMap[eventItem.unlockParam].NameLan)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("ChanganLevelViewModel_0"),dungeonName));
                return
            end
            BattlePrepareMgr.EnterBattlePrepare(this.changanEventList[index].id,this.changanEventList[index].eventParam,2);
        end
    },

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            ChanganMgr.InitData();
            this.dungeonRecords=DataMgr.Player.dungeonRecords
            this.completedTags=DataMgr.Player.completedTags
            this.cfgDungeonMap=ConfigMgr.Config.dungeonMap
            if HeroParameter.ChanganLevelLable~=nil then
                this.tabIndex=HeroParameter.ChanganLevelLable;
            end
            this.cfgChanganLevelList={}
            for i,v in ipairs(ConfigMgr.Config.activityMapList) do
                if string.match(v.area,"changan") then
                    table.insert(this.cfgChanganLevelList,v);
                end
            end
            this.tabIndex=this.GetCurrentChapter()
            this.ParseData(this.tabIndex)
        end 
        
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroParameter.SaveChanganLevelLable(this.tabIndex);
    end,
    before_destroy=function()
       
    end
        
    
}

this.GetCurrentChapter=function()












    local key=DataMgr.Player.uid.."CHANGAN_LEVEL";
    local value=UnityEngine.PlayerPrefs.GetInt(key);
    if value==0 then value=1 end;
    return value;
end


this.ParseData=function(loc)
    this.tabIndex=loc
    for i,v in ipairs(this.vm.data.chapters) do
        v.isOn=i==loc
        v.name=LuaMgr.GetLangText(this.cfgChanganLevelList[i].namelan)
        v.isLevelLock=this.CheckChapterLock(i);
        v.isOpeningTimeLock=this.CheckChapterTimer(this.cfgChanganLevelList[i]);
        v.lock=v.isLevelLock or v.isOpeningTimeLock;
        v.openDate=this.cfgChanganLevelList[i].openDate
    end
    this.changanList=ChanganMgr.changanMapList[loc]
    this.changanEventList=ChanganMgr.changanMapEventList[loc]
   
    this.SetLevelList(loc);
end

this.CheckChapterLock=function(index)
    local changanList=ChanganMgr.changanMapList[index]
    for i,v in ipairs(changanList) do
        if v.unlockParam=="" or this.dungeonRecords[v.unlockParam]~=nil and this.dungeonRecords[v.unlockParam].completeCount>0 then
            return false;
        end
    end
    return true
end

this.CheckChapterTimer=function(levelEvent)
    if levelEvent.openDate==0 and levelEvent.closeDate==0 then
        return false;
    end
    return LuaMgr.Timestamp()<levelEvent.openDate or LuaMgr.Timestamp()>levelEvent.closeDate
end


this.SetLevelList=function(loc)
    local mainLineIndex=0;
    local unlockIndexList={};
    for i,v in ipairs(this.vm.data.levelList) do
        local cfgLevel=this.changanList[i];
        if cfgLevel~=nil then
            local levelEvent=this.changanEventList[i]
            local unlock=cfgLevel.unlockParam=="" or (this.dungeonRecords[cfgLevel.unlockParam]~=nil and this.dungeonRecords[cfgLevel.unlockParam].completeCount>0);
            if cfgLevel.parameter==1 then
                mainLineIndex=unlock and mainLineIndex+1 or mainLineIndex;
            end
            if unlock and this.dungeonRecords[levelEvent.id]==nil then

                if PlayerPrefs.GetInt(DataMgr.Player.uid..levelEvent.id)==0 then
                    table.insert(unlockIndexList,i);
                    unlock=false;
                end
            end
            local tagDrops=this.cfgDungeonMap[levelEvent.id].tagDrops
            if loc==4 and cfgLevel.parameter==1 then

                if cfgLevel.parameter==1 then
                    v.tagSprite=unlock and LuaMgr.GetSprite("Changan","ui_ca_gk_xzbt1") or LuaMgr.GetSprite("Changan","ui_ca_gk_xzbt2")
                    v.nameSprite=unlock and LuaMgr.GetSprite("Changan","ui_ca_gk_xzbt3") or LuaMgr.GetSprite("Changan","ui_ca_gk_xzbt4")
                    v.nameText=unlock and string.format("<color=#f0e3c1>%s</color>",LuaMgr.GetLangText(levelEvent.namelan))
                            or string.format("<color=#aca4a1>%s</color>",LuaMgr.GetLangText(levelEvent.namelan));
                    v.tagText=unlock and string.format("<color=#522b26>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_3")) 
                            or string.format("<color=#494949>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_3"))
                    v.isRate_ing=unlock;
                    v.parameter=3
                end
            elseif cfgLevel.parameter==1 then
                local reNum=this.GetNoCompleteBoxNum(tagDrops)
                v.tagSprite=unlock and LuaMgr.GetSprite("Changan","ui_ca_gk_bt02_01") or LuaMgr.GetSprite("Changan","ui_ca_gk_bt02_02")
                v.nameSprite=unlock and LuaMgr.GetSprite("Changan","ui_ca_gk_bt01_01") or LuaMgr.GetSprite("Changan","ui_ca_gk_bt01_02")
                v.nameText=unlock and string.format("<color=#522B26>%s</color>",LuaMgr.GetLangText(levelEvent.namelan))
                        or string.format("<color=#443f3c>%s</color>",LuaMgr.GetLangText(levelEvent.namelan));
                v.tagText=unlock and string.format("<color=#522b26>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_1")) or string.format("<color=#262429>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_1"))
                v.isRate_ing=unlock and reNum>0;
                v.boxNum=reNum>0 and tostring(reNum) or ""
                v.isRate_ed=unlock and  reNum==0;
                if v.isRate_ed then
                    local rating=this.dungeonRecords[levelEvent.eventParam].historyRating
                    v.rateText=this.GetRatingText(rating);
                    v.rateImg=this.GetRatingSprite(rating);
                end
                v.parameter=1
            elseif cfgLevel.parameter==2 then
                v.tagSprite=unlock and LuaMgr.GetSprite("Changan","ui_ca_gk_bt03_01") or LuaMgr.GetSprite("Changan","ui_ca_gk_bt03_02")
                v.nameSprite=unlock and LuaMgr.GetSprite("Changan","ui_ca_gk_bt04_01") or LuaMgr.GetSprite("Changan","ui_ca_gk_bt04_02")
                v.nameText=unlock and string.format("<color=#522B26>%s</color>",LuaMgr.GetLangText(levelEvent.namelan))
                        or string.format("<color=#443f3c>%s</color>",LuaMgr.GetLangText(levelEvent.namelan));
                v.tagText=unlock and string.format("<color=#eee1ca>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_3")) or string.format("<color=#c3c2c1>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_3"))
                v.isRate_ing=unlock;
                v.parameter=2
            end
            v.statusIcon=cfgLevel.statusIcon;
            v.BGSprite=unlock and LuaMgr.GetSprite("Changan",cfgLevel.statusIcon.."1") or  LuaMgr.GetSprite("Changan",cfgLevel.statusIcon.."2")
            v.islock=not unlock
            v.unlockFX=false
            
        end
    end
    local value=0
    if loc==1 then
        value=mainLineIndex>3 and 1 or mainLineIndex/4*0.75
    elseif loc==2 then
        value=mainLineIndex>2 and 0.6+(mainLineIndex-3)*0.4 or 0.222+(mainLineIndex-1)*0.13;
    elseif loc==4 then
        value=0.25+(mainLineIndex-1)*0.25
    else
        value=mainLineIndex>3 and 1 or 0.222+(mainLineIndex-1)*0.13;
    end
 
    this.vm.data.chapters[loc].value=value

    if #unlockIndexList>0then
        this.ShowUnlockAnimation(unlockIndexList);
    end
end


this.GetRatingText=function(rating)
    if rating=="S" then
        return LuaMgr.GetLangText("ChanganLevelViewModel_6")
    elseif rating=="A" then
        return LuaMgr.GetLangText("ChanganLevelViewModel_7")
    elseif rating=="B" then
        return LuaMgr.GetLangText("ChanganLevelViewModel_8")
    else
        return ""
    end
end

this.GetRatingSprite=function(rating)
    if rating=="S" then
        return LuaMgr.GetSprite("Changan","ui_ca_gk_zhuangtai01");
    elseif rating=="A" then
        return LuaMgr.GetSprite("Changan","ui_ca_gk_zhuangtai05");
    elseif rating=="B" then
        return LuaMgr.GetSprite("Changan","ui_ca_gk_zhuangtai02");
    else
        return ""
    end
end

this.ShowUnlockAnimation=function(indexList)
    if this.coKey~=nil then
        coroutine_runner.stop(this.coKey)
    end
    this.coKey=coroutine_runner.start(function()
        coroutine_runner.wait(0.5)
        for i,v in ipairs(indexList) do
            local levelItem=this.vm.data.levelList[v];
            if this.changanEventList[v]~=nil then
                local key=DataMgr.Player.uid..this.changanEventList[v].id
                PlayerPrefs.SetInt(key,1);
                levelItem.unlockFX=true;
                coroutine_runner.wait(0.2)
                levelItem.islock=false;
                coroutine_runner.wait(0.8)
                levelItem.unlockFX=false
                levelItem.BGSprite=LuaMgr.GetSprite("Changan",levelItem.statusIcon.."1")
                if levelItem.parameter==1 then
                    levelItem.tagSprite=LuaMgr.GetSprite("Changan","ui_ca_gk_bt02_01")
                    levelItem.nameSprite= LuaMgr.GetSprite("Changan","ui_ca_gk_bt01_01")
                    levelItem.tagText=string.format("<color=#522b26>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_1"))
                    levelItem.isRate_ing=true
                    levelItem.isRate_ed=false
                elseif levelItem.parameter==2 then
                    levelItem.tagSprite= LuaMgr.GetSprite("Changan","ui_ca_gk_bt03_01")
                    levelItem.nameSprite=LuaMgr.GetSprite("Changan","ui_ca_gk_bt04_01")
                    levelItem.tagText=string.format("<color=#eee1ca>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_3"))
                    levelItem.isRate_ing=true;
                elseif levelItem.parameter==3 then
                    levelItem.tagSprite= LuaMgr.GetSprite("Changan","ui_ca_gk_xzbt1")
                    levelItem.nameSprite=LuaMgr.GetSprite("Changan","ui_ca_gk_xzbt3")
                    levelItem.tagText=string.format("<color=#522b26>%s</color>",LuaMgr.GetLangText("ChanganLevelViewModel_3"))
                    levelItem.isRate_ing=true;
                end
                
            end
            
        end
    end)
end

this.GetNoCompleteBoxNum=function(tagDrops)
    local totalNum=NumTool.GetLen(tagDrops);
    local completeNum=0;
    if totalNum>0then
        for _i,_v in pairs(tagDrops) do
            if this.completedTags[_v.tagId]~=nil then
                completeNum=completeNum+1;
            end
        end
    end
    return totalNum-completeNum;
end

return vm({
    data = data,
    command = command,
    hook = hook
})
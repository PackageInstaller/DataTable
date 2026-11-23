





local this = { vm = nil,
               moreModId = nil,
               cfgmoreModLawMap = {},
               cfgmoreModMap = {},
               cfgmoreMod = {},
               cfgmoreModConstants = {},
               datamoreModData = {},
               lawIconPath = "Assets/_BundleResources/Images/MoreModIcon/",
               currentCount = nil,
               expendScore = nil,
               _entryList = {},
               isSaveLaw = nil,
               ceilY = 262,
               ceilSpacingY = 15,
battleType=nil;
}



local data = {

   
    lawList = { {

                    lawIcon = DefaultTexture,
                    name = "",
                    isFixLaw = false,
                    isExpendLaw = false,
                    isFree = false,
                    isLaw=false,
                }
    },
  
    lawInfoList={
        {
            textAnchorPos=Vector2(0,0),
            lawIcon=DefaultTexture,
            isFixLaw=false,
            isExpendLaw=false,
            lawInfo="",
            lawName="",
            isTypeA=false,
            isTypeB=false,
            isTypeC=false;
            isOn=false;
            lawId="";
        }
    },
    fixLawList={
        {
            
        }
    },
    expendLawList={
        {
            
        }
    },
    fixSizeData=Vector2(0,0);
    expendSizeData=Vector2(0,0);
    
    entryCountText = "",
 
    pop_isActive=false;
    pop_Icon=DefaultTexture;
    pop_isFix=false;
    pop_isExpend=false;
    pop_name="";
    pop_des="";
    pop_contentPos=Vector2(0,0);
    contentPos=Vector2(0,0);
    animaName="";
    
    tips={
        {text=""},
        {text=""},
        {text=""},
        {text=""},
        {text=""},
        {text=""},
    },
    bgTexture=DefaultTexture;
}

this.InitTipsText=function()
    this.vm.data.tips[1].text=ConfigMgr.LangGlobal("2714")
    this.vm.data.tips[2].text=ConfigMgr.LangGlobal("2716")
    this.vm.data.tips[3].text=ConfigMgr.LangGlobal("2717")
    this.vm.data.tips[4].text=ConfigMgr.LangGlobal("2718")
    this.vm.data.tips[5].text=ConfigMgr.LangGlobal("2719")
    this.vm.data.tips[6].text=ConfigMgr.LangGlobal("2720")
end


local command = {
    entryItemBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          local index=tonumber(param+1);
          local lawItem=this.vm.data.lawList[index];
          if lawItem.isFixLaw then
              local tips=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2243"].NameLan)
              LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips);
              return;
          end
          local lawId=lawItem.lawId;
          this.UpdateRightEntryInfo(lawId,false);
          this.ClearEntryfromList(lawId);
      end
        
    },
    clearLawBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.ClearEntryLaw();
            local tips=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2245"].NameLan);
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips);
        end

    },
    enterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local dungeonId=this.datamoreModData.Dungeons[this.moreModId].Dungeon;
            local extraList={};
            table.insert(extraList,"moremod");
            table.insert(extraList,this.moreModId);
            for i,v in ipairs(this.vm.data.lawList) do
                table.insert(extraList,v.lawId);
            end
            
            local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
            enterDungeonParams.eventId = dungeonId
            enterDungeonParams.dungeonId = dungeonId
            enterDungeonParams.extraParams = extraList
            enterDungeonParams.battleType = "moreMod"
            enterDungeonParams.isleveling=this.cfgmoreMod.DevelopSwitch~=0;
            BattlePrepareMgr.isLeveling_teaching= DataMgr.Player.guideMoreModData~=nil and  DataMgr.Player.guideMoreModData.Dungeons[this.moreModId]~=nil;
            BattlePrepareMgr.isLeveling_test = false
            BattlePrepareMgr.BattlePrepare(enterDungeonParams, {"AreaSqualEntryViewModel"})
        end
    },
    fixBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local tips=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2247"].NameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips);
        end
                   
        
    },
    expendBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param+1);
            local baseLaw=this.vm.data.expendLawList[index];
            if not baseLaw.isOn then
                if this.CheckFreeLaw() then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2244"].NameLan))
                    return;
                end
                this.vm.data.expendLawList[index].isOn=true;
                this.UpdateRightEntryInfo(baseLaw.lawId,true);
            else
                this.vm.data.expendLawList[index].isOn=false;
                this.UpdateRightEntryInfo(baseLaw.lawId,false);
            end
        end
    },

    pressExpendBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local expendLaw=this.vm.data.expendLawList[index];
            this.SetPopInfo(expendLaw)
        end


    },
    
    detailsExpendBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local expendLaw=this.vm.data.expendLawList[index];
            this.SetPopInfo(expendLaw)
        end


    },
    detailsFixBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local fixLaw=this.vm.data.fixLawList[index];
            this.SetPopInfo(fixLaw)
        end


    },
    pressFixBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local fixLaw=this.vm.data.fixLawList[index];
            this.SetPopInfo(fixLaw)
        end


    },
    closePopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           this.vm.data.pop_isActive=false;
        end


    },
  
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params== nil) then return  end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        local isClear=UnityEngine.PlayerPrefs.GetInt("open_theme")==0;
        if isClear then
            UnityEngine.PlayerPrefs.SetInt("open_theme",1);
        end
        if vm.behaviour.Params.Length>1 then
            local data=vm.behaviour.Params;
            local modId=tostring(data[0]);
            this.battleType=tonumber(data[1]);
            this.isSaveLaw=not isClear and this.moreModId~=nil and modId==this.moreModId;
            if not this.isSaveLaw then
                this.expendScore =0;
            end
            this.moreModId=modId;
            this.cfgmoreModLawMap=ConfigMgr.Config.moreModLawMap;
            this.cfgmoreModMap=ConfigMgr.Config.moreModMap;
            this.cfgmoreModConstants=ConfigMgr.Config.moreModConstants;
            this.cfgmoreMod=this.cfgmoreModMap[this.moreModId];
            this.vm.data.contentPos=Vector2(0,0);
            this.vm.data.pop_isActive=false;
            this.InitTipsText();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.CheckAcorssDay)
        LuaMgr.RemoveTimer(TimerConst.AreaSqualEntrySelectDelay);
    end,
    before_destroy=function(vm)
        this=nil
    end
}
this.OnBack=function()
    BattlePrepareMgr.Clear();
    LuaMgr.Back();
    if this.battleType~=nil and this.battleType==2 then
        LuaMgr.ShowLuaPanel(UIName.AreaSqualTeachingViewModel);
    end
end
this.ParseData=function()
    this.datamoreModData=this.battleType==1 and DataMgr.Player.moreModData or DataMgr.Player.guideMoreModData;
    if this.datamoreModData.Theme=="JX" then
        this.vm.data.bgTexture=LuaMgr.GetTexture(Path.Image.."Squal/ui_dzr_gk_bj_chun.png");
    else
        this.vm.data.bgTexture=LuaMgr.GetTexture(Path.Image..string.format("Squal/ui_dzr_gk_bj_%s.png",this.datamoreModData.Theme));
    end
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.CheckAcorssDay)
    LuaMgr.AddUIEventListener(UIEventConst.HeartBeat,this.CheckAcorssDay);
    
    this.ShowLeftLawGroup(this.isSaveLaw);
    this.ShowRightLawInfo(this.isSaveLaw);
    
end


this.CheckAcorssDay=function()
    local remainTime=this.datamoreModData.Expires-LuaMgr.Timestamp();
    if remainTime<0 then
        LuaMgr.MessageTipsViewModel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("AreaSqualEntryViewModel_0"));
        LuaMgr.ShowLuaPanel(UIName.AreaDailyViewModel);
    end
end


this.SetPopInfo=function(lawItem)
    this.vm.data.animaName="ui_AreaSqualEntryPanel_root_PopPanel"
    this.vm.data.pop_contentPos=Vector2(0,0);
    this.vm.data.pop_isActive=true;
    this.vm.data.pop_Icon=lawItem.lawIcon;
    this.vm.data.pop_isFix=lawItem.isFixLaw;
    this.vm.data.pop_isExpend=lawItem.isExpendLaw;
    this.vm.data.pop_name=lawItem.lawName;
    this.vm.data.pop_des=lawItem.lawInfo;
end


this.ShowLeftLawGroup=function(save)
    if save then
        for i,v in ipairs(this.vm.data.fixLawList) do
            v.textAnchorPos=Vector2(0,0);
        end
        for i,v in ipairs(this.vm.data.expendLawList) do
            v.textAnchorPos=Vector2(0,0);
        end
        this.ExpendLawSelectScale(Vector3.zero);
        LuaMgr.RemoveTimer(TimerConst.AreaSqualEntrySelectDelay)
        LuaMgr.AddTimer(TimerConst.AreaSqualEntrySelectDelay, this.OnExpendLawSelectScale, 0.6, 1, false);
        return;
    end
    if IsNull(this.datamoreModData.Dungeons) then 
       return 
    end;
    local dungeon=this.datamoreModData.Dungeons[this.moreModId]
    if dungeon==nil then
        return;
    end

    local fixLaw=dungeon.Law[1];
    local rowNum=math.ceil(#fixLaw/4);
    this.vm.data.fixLawList={};
    this.vm.data.fixSizeData=Vector2(990,(this.ceilY+this.ceilSpacingY)*rowNum)
    this.vm.data.fixLawList=this.SetLawGroupList(fixLaw,true,1);
    

    local expendLaw={};
    local expendA=this.SetLawGroupList(dungeon.Law[2],false,2);
    local expendB=this.SetLawGroupList(dungeon.Law[3],false,3);
    local expendC=this.SetLawGroupList(dungeon.Law[4],false,4);
    for i,v in ipairs(expendA) do
        table.insert(expendLaw,v);
    end
    for i,v in ipairs(expendB) do
        table.insert(expendLaw,v);
    end
    for i,v in ipairs(expendC) do
        table.insert(expendLaw,v);
    end
    rowNum=math.ceil(#expendLaw/4);
    this.vm.data.expendLawList={};
    this.vm.data.expendSizeData=Vector2(990,(this.ceilY+this.ceilSpacingY)*rowNum)
    this.vm.data.expendLawList=expendLaw;
    
end

this.OnExpendLawSelectScale = function()
    this.ExpendLawSelectScale(Vector3.one);
end

this.ExpendLawSelectScale = function(scale)
    local len = #this.vm.data.expendLawList;
    for i = 1, len do
        this.vm.data.expendLawList[i].selectScale = scale;
    end
end

this.SetLawGroupList=function(law,isFix,type)
    local list={};
    for i,v in ipairs(law) do
        local cfglaw=this.cfgmoreModLawMap[v]
        if cfglaw ~=nil then
            local lawInfo= {
                lawIcon = LuaMgr.GetTexture(this.lawIconPath..cfglaw.LawICON..".png"),
                isFixLaw = isFix,
                isExpendLaw = not isFix,
                lawInfo = LuaMgr.GetLangText(cfglaw.TextLan),
                lawName=LuaMgr.GetLangText(cfglaw.LawNameLan),
                isTypeA=type==2;
                isTypeB=type==3;
                isTypeC=type==4;
                isOn=false;
                lawId=cfglaw.Id;
                textAnchorPos=Vector2(0,0);
                selectScale = Vector3.one;
            }
            table.insert(list,lawInfo);
        end
    end
    return list;
end





this.ShowRightLawInfo=function(save)
    if save then
        return;
    end
    this.vm.data.lawList={};
    local fixlaw=this.datamoreModData.Dungeons[this.moreModId].Law[1];
    local lawLen=NumTool.GetLen(fixlaw);
    this._entryList={};
    local fixlawItem=nil
    for i=1,this.cfgmoreMod.MaxLaw do
        fixlawItem=nil;
        if i<=lawLen then
            fixlawItem=this.cfgmoreModLawMap[fixlaw[i]];
        end
        local isFix = fixlawItem~=nil;
        
        local lawItem={
            lawIcon = isFix and LuaMgr.GetTexture(this.lawIconPath..fixlawItem.LawICON..".png") or DefaultTexture,
            name = isFix and LuaMgr.GetLangText(fixlawItem.LawNameLan) or "",
            isFixLaw = isFix,
            isExpendLaw =  false,
            isFree = not isFix,
            isLaw=isFix,
            lawId=isFix and fixlawItem.Id or "";
        }
        table.insert(this._entryList,lawItem);
    end
    this.vm.data.lawList=this._entryList;
    this.currentCount=this.cfgmoreMod.GroupLawOpen[1];
    this.vm.data.entryCountText=string.format("<color=#01FEF9>%s</color>/%s",this.cfgmoreMod.GroupLawOpen[1],this.cfgmoreMod.MaxLaw);;
   
end
    


this.CheckFreeLaw=function()
    for i,v in ipairs(this.vm.data.lawList) do
        if v.lawId=="" then
            return false;
        end
    end
    return true;
end





this.UpdateRightEntryInfo=function(lawId,isOn)
    local cfglaw=this.cfgmoreModLawMap[lawId];
    if cfglaw==nil then return end;
    if not isOn then
        for i,v in ipairs(this._entryList) do
            if v.lawId==lawId then
                v.lawIcon =DefaultTexture;
                v.name = "";
                v.isFixLaw = false;
                v.isExpendLaw =  false;
                v.isFree =true;
                v.isLaw=false;
                v.lawId="";

                local p=v;
                table.remove(this._entryList,i);
                table.insert(this._entryList,p);
                break;
            end
        end

        this.currentCount=this.currentCount-1;
    else
        for i,v in ipairs(this._entryList) do
            if v.lawId=="" then
                v.lawIcon = LuaMgr.GetTexture(this.lawIconPath..cfglaw.LawICON..".png");
                v.name = LuaMgr.GetLangText(cfglaw.LawNameLan);
                v.isFixLaw = false;
                v.isExpendLaw =  true;
                v.isFree =false;
                v.isLaw=true;
                v.lawId=lawId;
                break;
            end
           
        end
        this.currentCount=this.currentCount+1;
    end
    
    this.vm.data.lawList=this._entryList;
    this.vm.data.entryCountText=string.format("<color=#01FEF9>%s</color>/%s",this.currentCount,this.cfgmoreMod.MaxLaw)
end


this.ClearEntryLaw=function()
    this.      ShowLeftLawGroup();
    this.ShowRightLawInfo();
end


this.ClearEntryfromList=function(lawId)
    for i,v in ipairs(this.vm.data.expendLawList) do
        if v.lawId==lawId then
            v.isOn=false;
            return;
        end
    end
  
end

return vm({
    data = data,
    command = command,
    hook = hook
})
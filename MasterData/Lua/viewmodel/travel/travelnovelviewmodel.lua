




local this = {vm=nil};
local locPos={Vector2(-500,65),Vector2(-448,-119),Vector2(-260,-35),Vector2(-50,-139),Vector2(79,22),
              Vector2(-126,128),Vector2(85,203),Vector2(359,146),Vector2(278,-60),Vector2(529,-33),}

local cfgNovel={};
local cfgNarrative={};
local data = {
    novelList={
        {
            pos=Vector2(0,0),
            unlockBool=false,
            proingBool=false,
            doneBool=false,
            rewarding=false,
            bgSprite=DefaultSprite,
            areaSprite=DefaultSprite,
            lockSprite=DefaultSprite,
            isInteractable=false,
            title="",
            proValue="",
            alpha=1.0,
            isFlower=false,
        }
    },
    contentAnchorPos=Vector2(0,0);
    
}

local command = {

    playNovelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)




            local index=tonumber(param)+1;
            local novelItem=this.vm.data.novelList[index];
            if novelItem.unlockBool then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("12000"));
                return;
            end
            if novelItem.proingBool then
                local tips=ConfigMgr.LangGlobal("7500");
                local value=novelItem.unlockValue;
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tips,value));
                return;
            end
            local novelId=novelItem.novelId;
            if novelId~=nil or novelId~="" then
                LuaMgr.PlayNovel(novelId,function()
                    LuaMgr.ShowLuaPanel(UIName.TravelNovelViewModel);
                end)
            end
            
        end
    },

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
       
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            cfgNovel={};
            local mapEventList=ConfigMgr.Config.activityMapEventList
            for i,v in ipairs(mapEventList) do
                if v.area=="Travel" and v.type ==1 then
                    table.insert(cfgNovel,v);
                end
            end
            table.sort(cfgNovel,function(a, b) return a.id<b.id end)
            cfgNarrative=ConfigMgr.Config.narrativeMap;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
       
    end,
}


this.SelfCardsCount=function()
    return  NumTool.GetLen(DataMgr.Player.postcards)
end

this.ParseData=function()
    this.vm.data.contentAnchorPos=Vector2(0,0);
    this.vm.data.novelList={};
    local list={};
    local myCount=this.SelfCardsCount();
    local lastUnlock=true;
    for i,v in ipairs(cfgNovel) do
        local unlockValue=v.unlockParam=="" and 0 or tonumber(v.unlockParam);
        local isDone=DataHelper.IsCompleteNovel(v.eventParam);
        local novelItem={
            pos=locPos[i];
            bgSprite=LuaMgr.GetSprite("Travel","ui_lx_ltjw_gk0"..i);
            unlockBool=not lastUnlock,
            chaterBool=lastUnlock,
            proingBool=lastUnlock and myCount<unlockValue,
            doneBool=isDone,
            rewarding=not isDone and lastUnlock and myCount>=unlockValue,
            alpha=1.0,
            title=LuaMgr.GetLangText(v.namelan),
            novelId=v.eventParam,
            unlockValue=unlockValue,
            isFlower=false,
        }
        lastUnlock=isDone;
        local pro=myCount>unlockValue and unlockValue or myCount;
        novelItem.proValue=string.format(LuaMgr.GetLangText("TravelNovelViewModel_5"),pro,unlockValue);
        novelItem.proSlider=pro/unlockValue;
        
        local bgName="ui_lx_ltjw_xf_01";
        local areaName="ui_lx_ltjw_xf_01";
        if novelItem.rewarding then
            bgName="ui_lx_ltjw_xf_02"
            areaName="ui_lx_ltjw_xf_02"
            if i==#cfgNovel then
                novelItem.isFlower=true;
            end
        elseif novelItem.doneBool then
            bgName="ui_lx_ltjw_xf_03"
            novelItem.alpha=0.6
        elseif novelItem.unlockBool then
            novelItem.lockSprite=LuaMgr.GetSprite("Travel","ui_lx_ltjw_gk0"..i.."b");
            areaName="ui_lx_ltjw_xf_03"
        end
        novelItem.areaSprite=LuaMgr.GetSprite("Travel",areaName);
        table.insert(list,novelItem);
        
    end
    
    this.vm.data.novelList=list;
    
end



return vm({
    data = data,
    command = command,
    hook = hook
})
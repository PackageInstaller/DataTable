




local this = {vm=nil};
local remainTime=nil;
local actTravel=nil;

local animaName_main="ani_TravelMainPanel_01";
local animName_novel="ani_TravelMainPanel_novel";
local animName_task="ani_TravelMainPanel_task";
local animName_letter="ani_TravelMainPanel_travel";
local animName_shop="ani_TravelMainPanel_shop";
local aniName_boss="ani_TravelMainPanel_boss"
local aniName_level="ani_TravelMainPanel_level"







local isStop=false;

local data = {
    time="";
    animaterName="";
    alpha=1.0;
    collectPro="";

}

local command = {

    novelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isStop then return end;




            this.vm.data.animaterName=animName_novel;
            isStop=true;

        end
    },
    shopBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)



        end
    },
    taskBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)







        end
    },
    letterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isStop then return end;




            this.vm.data.animaterName=animName_letter;
            isStop=true;
        end
    },
    levelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isStop then return end;




            this.vm.data.animaterName=aniName_level;
            isStop=true;
        end
    },
     bossBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)







        end
    }

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        RedMgr.Singleton:RegisterViewModel(UIName.TravelMainViewModel);




    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/travel_Camera.mp3");

            this.vm.data.animaterName=animaName_main;
            vm.behaviour:UpdateTopBar("", this.OnBack);
            LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.AnimatorPlayFish);
            isStop=false;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.AnimatorPlayFish);
        isStop=false

    end,
    before_destroy=function()




    end
        
    
}


this.OnBack=function()
    if DataExHelper.Check_TravelRunning() then
        LuaMgr.Back("travel");
    else
        LuaMgr.Back();
    end
end

this.ClearPos=function()

















    
end

this.AnimatorPlayFish=function(param)
    local name=tostring(param[0]);
    if name==animName_shop then
        LuaMgr.ShowLuaPanel(UIName.TravelShopViewModel);
    elseif name==animName_task then
        LuaMgr.ShowLuaPanel(UIName.TravelTaskViewModel);
    elseif name==animName_novel then
        LuaMgr.ShowLuaPanel(UIName.TravelNovelViewModel);
    elseif name==animName_letter then
        LuaMgr.ShowLuaPanel(UIName.TravelLetterViewModel);
    elseif name==aniName_level then
        LuaMgr.ShowLuaPanel(UIName.TravelLevelViewModel);
    elseif name==aniName_boss then
        LuaMgr.ShowLuaPanel(UIName.TravelBossViewModel);

    end
end


this.ParseData=function()












    local cfgTravelCard={};
    for p,m in pairs(ConfigMgr.Config.TravelPostcardMap) do
        if m.RewardType==1 then
            table.insert(cfgTravelCard,m);
        end
    end
    local dataPostcards=DataMgr.Player.postcards;
    this.vm.data.collectPro=string.format("<color=#ffc600>%s</color>/%s",NumTool.GetLen(dataPostcards),#cfgTravelCard);
end















return vm({
    data = data,
    command = command,
    hook = hook
})
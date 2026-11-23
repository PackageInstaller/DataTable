




local this = {
    vm=nil,
};
local data = {
   novelList={
       {
           isLock=false,
           isNor=false,
           isSelecting=false,
           bg=DefaultSprite,
           name="",
       }
   }
}

local command = {

    close={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           LuaMgr.HidePanel(UIName.ChanganNovelViewModel)
        end
    },
    selectBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1
            for i,v in ipairs(this.vm.data.novelList) do
                v.isSelecting=index==i;
            end
        end
    },
    novelPlayBtn={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index=tonumber(param)+1
            local novelEvent=ChanganMgr.changanNovelEventList[index]
            LuaMgr.HidePanel(UIName.ChanganNovelViewModel)
            LuaMgr.PlayNovel(novelEvent.eventParam,function()
                LuaMgr.Back();
                LuaMgr.ShowLuaPanel(UIName.ChanganNovelViewModel)
            end)
        end
    }

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            ChanganMgr.InitData();
           this.ParseData();
        end 
        
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
        end
    end,
    before_destroy=function()
        
    end
        
    
}

this.ParseData=function()
    local list={}
    local changan_ActivityEvents={}
    if DataMgr.Player.activityMaps["changan"]~=nil then
        changan_ActivityEvents=DataMgr.Player.activityMaps["changan"].activityEvents;
    end
    for i,v in ipairs(ChanganMgr.changanNovelEventList) do
       local novelItem={
           isLock=false,
           isNor=false,
           isSelecting=false,
           bg=LuaMgr.GetSprite("Changan",v.statusIcon),
           name=LuaMgr.GetLangText(v.namelan),
       }
        local unlock= changan_ActivityEvents[v.eventParam];
        novelItem.isLock=unlock==nil or not unlock.complete;
        novelItem.isNor=unlock~=nil and unlock.complete
        table.insert(list,novelItem)
    end
    this.vm.data.novelList=list;
    
end


return vm({
    data = data,
    command = command,
    hook = hook
})
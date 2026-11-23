





require("ViewModel/AreaTeaching/JobTeaching_LevelItem")
local this = {vm=nil,
              levelUList=nil,
              goodItemObj=nil;
};

local cfgJobEventList={}
local cfgUnlockCondition={};
local cfgDungeou={};
local animPress="Teaching_Button_Pressed";
local animNor="Teaching_Button_Normal"

local isClickBtn = false

local enterDungeonParams = nil

local data = {
    
    teachLevelList={
        {
           isLock=false,
           animName="",
           isQ=false;
        },
        {
            isLock=false,
            animName="",
            isQ=false;
        },
        {
            isLock=false,
            animName="",
            isQ=false;
        },
    },
   
    jobLevelBool=false;
}

local command = {

    teachingLevelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param);
            local dungeon=ConfigMgr.Config.dungeonMap[cfgUnlockCondition[index]]
            if DataMgr.Player.dungeonRecords[cfgUnlockCondition[index]]==nil or DataMgr.Player.dungeonRecords[cfgUnlockCondition[index]].completeCount==0 then
                local tips=LuaMgr.GetLangText(dungeon.NameLan);
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("AreaTeachingViewModel_2"),tips));
                return;
            end
            if index==1 then
                RedMgr.Singleton:FrushRedCondition("1174_"..index)
            end
            this.ShowJobPanel(index);
            this.vm.data.teachLevelList[index].animName=animPress;
            this.vm.data.teachLevelList[index].isQ=true;
        end
           
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           this.vm.data.jobLevelBool=false;
            for i,v in ipairs(this.vm.data.teachLevelList) do
                v.isQ=false;
            end
        end

    },
   

}

this.LevelItemBtn=function(index)
    local teachItem=this.levelUList.itemList[index].data;
    if teachItem.isLock then
        local dungeon=ConfigMgr.Config.dungeonMap[teachItem.unlockParam];
        if dungeon~=nil then
            local tips=string.format(LuaMgr.GetLangText("AreaTeachingViewModel_1"),LuaMgr.GetLangText(dungeon.NameLan));
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips);
        end
        return;
    end
    BattlePrepareMgr.EnterBattlePrepare(teachItem.id,teachItem.eventParam,2)
end


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.levelUList=UIListView.New(vm.behaviour.transform:Find("root/Middle/Buttom/ScrollView/Viewport/Content"));
        this.goodItemObj=vm.behaviour.transform:Find("template/goodItem").gameObject
        RedMgr.Singleton:RegisterViewModel(UIName.JobTeachingViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            cfgUnlockCondition=ConfigMgr.Config.constants.UnlockTeach;
            cfgDungeou=ConfigMgr.Config.dungeonMap;
            cfgJobEventList={}
            local tempList_8={}
            local tempList_9={}
            local tempList_10={}
            for i,v in pairs(ConfigMgr.Config.areaEvents) do
                if v.category==8 then
                    table.insert(tempList_8,v);
                elseif v.category==9 then
                    table.insert(tempList_9,v);
                elseif v.category==10 then
                    table.insert(tempList_10,v);
                end
            end
            table.sort(tempList_8,function(a, b)
                return a.id<b.id;
            end)
            table.sort(tempList_9,function(a, b)
                return a.id<b.id;
            end)
            table.sort(tempList_10,function(a, b)
                return a.id<b.id;
            end)
            table.insert(cfgJobEventList,tempList_8)
            table.insert(cfgJobEventList,tempList_9);
            table.insert(cfgJobEventList,tempList_10)
            HeroRedDataHelper.SetAreaTeachingRed();
            this.ParseData();
            isClickBtn = false
        end
        
    end,
    before_deactive = function(vm)

        this.vm.data.jobLevelBool=false;
        for i,v in ipairs(this.vm.data.teachLevelList) do
            v.isQ=false;
        end
    end,
    before_destroy = function(vm)
        UIListView.ClearItem("JobTeaching_LevelItem")
    end
}


this.ParseData=function()
    this.vm.data.jobLevelBool=false;
    local lock2=cfgUnlockCondition[2]=="0" or DataMgr.Player.dungeonRecords[cfgUnlockCondition[2]]==nil
    this.vm.data.teachLevelList[2].isLock=lock2;
    local lock3=cfgUnlockCondition[3]=="0" or DataMgr.Player.dungeonRecords[cfgUnlockCondition[3]]==nil
    this.vm.data.teachLevelList[3].isLock=lock3;
end


this.ShowJobPanel=function(index)
    this.vm.data.jobLevelBool=true;
    local eventList=cfgJobEventList[index]
    local list={}
    for i,v in ipairs(eventList) do
        local dungeonRecords=DataMgr.Player.dungeonRecords[v.unlockParam];
        local lock=dungeonRecords==nil or dungeonRecords.completeCount==0;
        local goodItem={
            id=v.id,
            eventParam=v.eventParam,
            unlockParam=v.unlockParam,
            levelIndex=index,
            icon=v.icon,
            index=i,
            isLock=lock;
            isDone=DataMgr.Player.dungeonRecords[v.id]~=nil and DataMgr.Player.dungeonRecords[v.id].completeCount>0;
            name=LuaMgr.GetLangText(cfgDungeou[v.id].NameLan);
            reward=ConfigMgr.Config.constants.TeachingReward[1];
            callBack=this.LevelItemBtn;
        }
        local goodsData=UIListData.GetData(this.goodItemObj,"JobTeaching_LevelItem",goodItem);
        table.insert(list,goodsData)
    end
    this.levelUList:SetData(list);
end


this.PlayEnterBtnAnim = function(args)








end

return vm({
    data = data,
    command = command,
    hook = hook
})
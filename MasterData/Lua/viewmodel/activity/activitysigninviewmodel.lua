local this = {vm=nil};
local animator=nil;
local ANIMA_NAME1="UI_ActivitySignIn_01";
local ANIMA_NAME2="UI_ActivitySignIn_02";
local HeroManager=CS.Laigu.ViewModel.Hero.HeroManager;
local cfgCheckInQuest={};
local dataQuests={};
local rootGo = nil;
local spineCharacter=nil


local data = {
    goodslistData = {{isNor=false,isCur=false,daynum="",hasReward=false,canReward=false,isSpeical=false,isNormal=true}},

    list={},
    popInitPosition=Vector2(0,0),
    activity_id=nil,
    awards=nil,
    canvasGropAlpha=0.0;
    sliderValue=0.0,
    bodyPath=""
}
local command = {

    backCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.ActivitySignInViewModel);
        end
    },

    rewordCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.AskReword(param);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        spineCharacter = vm.behaviour.transform:Find("root/Middle/Group/BG/Character/Group/Body"):GetComponent("UISpineCharacter");
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator")
        rootGo = vm.behaviour.transform:Find("root").gameObject;
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            if(vm.behaviour.Params.Length>0) then
                AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/window_M.mp3");
            end
            animator:Play(ANIMA_NAME1);
            LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.FrushData);
            LuaMgr.AddUIEventListener(UIEventConst.HeartBeat,this.FrushData);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveCanvas(rootGo)
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,this.FrushData);
        spineCharacter:Clear()
    end,
    
    before_destroy=function()
        animator=nil;
        rootGo = nil;
    end
}

this.FrushData=function()
    this.ParseData();
end



this.ParseData = function()
    cfgCheckInQuest=DataExHelper.Check_ConfigQuestEventByGroupId(101);
    table.sort(cfgCheckInQuest,function(a,b) return tonumber(a.id)<tonumber(b.id); end)
    dataQuests=DataMgr.Player.quests;
    this.SetCharacter()
    this.ShowReword();
    
end

this.SetCharacter=function()
    local characterId ="D0060";
    local path = HeroManager.SetCharacterDrawing(spineCharacter, characterId,"D0060002");
    if (path ~= "") then
        this.vm.data.bodyPath = path;
    end
end




this.ShowReword=function()
    local datalist = {};

    local normalItemScale = Vector3(0.85,0.85,0.85)
    local specialItemScale = Vector3.one
    local passDay=0;
    local curIndex=0;
    for i,v in ipairs(cfgCheckInQuest) do
        local rewardItem_1=v.reward[1];
        local state=DataExHelper.Check_RewardState(v.id)
        if state==3 then
            passDay=passDay+1;
        elseif state==2 then
            curIndex=i
        end
        local rewardItem=ConfigHelper.CreateGoodsItem(rewardItem_1.id,rewardItem_1.count,0.85,true,state~=2)
        rewardItem.scale = i==7 and specialItemScale or normalItemScale
        rewardItem.hasReward=state==3
        rewardItem.canReward=state==2
        rewardItem.daynum=tostring(i);
        rewardItem.isNormal = i ~=7;
        rewardItem.isSpeical = i ==7;
        rewardItem.isNor=i~=3
        rewardItem.isCur=i==3
        table.insert(datalist,rewardItem);
    end

    if curIndex==0 and passDay>0 then
        curIndex=passDay;
    end




    local value= 0;
    if passDay>0 then
        value=0.052+(passDay-1)*0.159;
    end
    this.vm.data.sliderValue=value;
    this.vm.data.goodslistData=datalist;
    
end

this.CheckInCanReward=function()
    local dataCheckIn=DataExHelper.Check_DataExByGroupId(101);
    table.sort(dataCheckIn,function(a,b) return tonumber(a.id)<tonumber(b.id)  end)
    for i,v in ipairs(dataCheckIn) do
        if v.state==1 then
            return v.id;
        end
    end
end



this.AskReword=function(index)
    if(index<0)then return end;
    local reward=cfgCheckInQuest[index+1].reward;
    DataExHelper.EX_GetAward(cfgCheckInQuest[index+1].id,function()
        this.ParseData();
        local re=ActivityMgr.IsPopSignIn()
        local redNum=re and 1 or 0;
        RedMgr.Singleton:UpdateClientRedData("1017",redNum);

        local rewardids={};
        local rewardNums={};
        for i,v in ipairs(reward) do
            table.insert(rewardids,v.id);
            table.insert(rewardNums,v.count);
            ActivityMgr.CompleteActivity("checkin","101_"..index+1,rewardids,rewardNums);
        end
    end, true)
end




return vm({
    data = data,
    command = command,
    hook = hook
})
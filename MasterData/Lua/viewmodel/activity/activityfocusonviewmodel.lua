
local this = {vm=nil};
local data = {
    fieldCode="",
    receveingBool=false,
    noreceiveBool=false,
    hasreceiveBool=false,
    rewordRootBool=false,
    contentAnchorPos=Vector2(0,0),
    goodsList={{id="1",count=tostring(0),isCount=true,sizeDelta=Vector2(0,0),rare=DefaultSprite,icon=DefaultTexture,scale=Vector3(0,0,0),isClick=true}},
    
}
local cdkeyInfo;
local cfgFocusGift={};
local command = {
    
    recevieBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.OnAskFocusOnReceiveReward(function()
                this.SetButtonState(2)

                local activityId=ActivityMgr.GetActivityId("cdkey")
                local rewardids={};
                local rewardnums={};
                for i,v in ipairs(cfgFocusGift) do
                   table.insert(rewardids,v.id); 
                    table.insert(rewardnums,v.count);
                end
                ActivityMgr.CompleteActivity("cdkey",activityId,rewardids,rewardnums);
            end);
           
        end
    },
    copyBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            UnityEngine.GUIUtility.systemCopyBuffer=cdkeyInfo;
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",LuaMgr.GetLangText("ActivityFocusOnViewModel_0"));
        end
    },
   
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            cfgFocusGift=ConfigMgr.Config.constants.FocusGift;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
}
this.ParseData=function()
    this.vm.data.contentAnchorPos=Vector2(0,0);
    this.ShowReward()
    ActivityMgr.OnAskFocusOnData(function(data)
        cdkeyInfo=data.Code;
        this.vm.data.fieldCode=data.Code;
        this.SetButtonState(data.Status)
    end)
end

this.OnAskFocusOnReceiveReward=function()
    ApiMgr.Request("focus/getreward",{},true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        this.SetButtonState(2)

        local rewardids={};
        local rewardnums={};
        for i,v in ipairs(cfgFocusGift) do
            table.insert(rewardids,v.id);
            table.insert(rewardnums,v.count);
        end
        ActivityMgr.CompleteActivity("cdkey","FollowGift",rewardids,rewardnums);
    end,nil,true);
end



this.SetButtonState=function(state)
    this.vm.data.noreceiveBool=state==0;
    this.vm.data.receveingBool=state==1;
    this.vm.data.hasreceiveBool=state==2;
end


this.ShowReward=function()

    this.vm.data.rewordRootBool=false;
    this.vm.data.rewordRootBool=true;
    this.vm.data.goodsList={};
    local list={};
    for i,v in ipairs(cfgFocusGift) do
        local item=ConfigHelper.CreateGoodsItem(v.id,v.count,0.7,true,true);
        table.insert(list,item);
    end
    this.vm.data.goodsList=list;
end


return vm({
    data = data,
    command = command,
    hook = hook
})
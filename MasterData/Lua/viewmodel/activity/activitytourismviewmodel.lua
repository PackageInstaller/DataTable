





local this = {vm=nil};
local cfgActiveLotteryMap={};
local cfgLotteryMap={};
local dataLottery={};
local curType="1001";
local data = {
    openTime="",
    goodsList={{offSet=Vector2(0,0),BG=DefaultSprite,hasRewardBool=false,line_up=false,rewardBtnInteractable=false,line_down=false,tag=DefaultSprite,
                rewardList={{id="1",count=tostring(0),isCount=true,sizeDelta=Vector2(0,0),rare=DefaultSprite,icon=DefaultTexture,scale=Vector3(0,0,0),isClick=true}}}},

}
local command = {
    GotoBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local re=DataExHelper.Check_TourismRuning()
            if re==nil then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityTourismViewModel_0"));
                return;
            end
            LuaMgr.HidePanel(UIName.ActivityTourismViewModel)
            LuaMgr.ShowLuaPanel(UIName.ActivityTourismPanelViewModel);
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
            if UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid.."1068")==0 then
                UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid.."1068",1);
                RedMgr.Singleton:UpdateClientRedData("1068",0);
            end
            cfgActiveLotteryMap=ConfigMgr.Config.LotteryActivityMap;
            cfgLotteryMap=ConfigMgr.Config.LotteryMap;
            dataLottery=DataMgr.Player.lottery;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
}

this.ParseData=function()
    local sysVariables,type=DataExHelper.Check_TourismRuning();
    curType=type;
    local startTime=os.date("*t",sysVariables.startTime);
    local endTime=os.date("*t",sysVariables.expireTime);
    this.vm.data.openTime=string.format(LuaMgr.GetLangText("ActivityTourismViewModel_1"),
            startTime.month,startTime.day,startTime.hour,startTime.min,
            endTime.month,endTime.day,endTime.hour,endTime.min);
   this.ShowReward();
    
end

this.ShowReward=function()
    local curLotteryContent=cfgActiveLotteryMap[curType].Content;
    local list={};
    for i,v in ipairs(curLotteryContent) do
        local vctor=i%2==0 and Vector2(0,-100) or Vector2(0,0);
        local rewards=cfgLotteryMap[v].Reward;
        local rare=cfgLotteryMap[v].Type;
        local c=dataLottery[curType];
        local checkRewards=this.CheckReward(v)
        local BGName=checkRewards and "ui_yysh_wpk01" or "ui_yysh_wpk02";
        local item =ConfigMgr.Config.itemMap[tostring(rewards[1].id)];
        local rewardList={};
        local rewardItem={id=tostring(rewards[1].id),count=LuaMgr.NumFormat(rewards[1].count),isCount=true,
                          rare=ActivityMgr.GetRareSprite(item.rare),
                          icon=ActivityMgr.GetItemTexture(tostring(rewards[1].id)),
                          scale=Vector3(0.8,0.8,0.8),
                          sizeDelta=Vector2(102,102),
                          isClick=true
        }
        table.insert(rewardList,rewardItem);


        local goodItem={
            offSet=vctor,
            BG=LuaMgr.GetSprite("Tourism",BGName),
            hasRewardBool=not checkRewards,
            line_up=i%2~=0 and i~=1,
            line_down=i%2==0 and i~=1,
            tag=LuaMgr.GetSprite("Tourism","ui_yysh_ding0"..item.rare);
            rewardList=rewardList;
        }
        table.insert(list,goodItem);
    end
    this.vm.data.goodsList=list;
    
end

this.CheckReward=function(checkId)
    if(dataLottery==nil or dataLottery[curType]==nil) then return true end;
    local rewards=dataLottery[curType];
    for i,v in ipairs(rewards) do
        if(v==checkId) then
            return false;
        end
    end
    return true;
end

return vm({
    data = data,
    command = command,
    hook = hook
})
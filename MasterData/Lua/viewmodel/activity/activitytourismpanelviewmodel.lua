





local this = {vm=nil};
local cfgActiveLotteryMap={};
local cfgLotteryMap={};
local dataLottery={};
local curLotteryContent={};
local tweener=nil;
local poetryTweener=nil;
local serverRewardData=nil;
local lines={};
local lineIndex=1;
local lineCount=0;
local airflying=false;
local coroutineKey=nil;
local canTourism=false
local remainLotteryCount;
local trourismAnima_Name="UI_TourismItem_01";
local rewardPanelAnima_name02="UI_RewardPanel_02";
local rewardPanelAnima_name01="UI_RewardPanel_01"
local curType="1001";
local tourismPosList={Vector2(-507,4.5),Vector2(-455,162.5),Vector2(-301.5,243.6),Vector2(-78.8,182.2),
                      Vector2(129,259),Vector2(319,103),Vector2(96,-80.4),Vector2(386,-115)};
local data = {
  tourismList={{vector=Vector2(0,0),BGsuo=DefaultSprite,BG=DefaultSprite,BG2=DefaultSprite,name="",done=false,suo=false,animaName="",fx=false}};
  goodlist={{id="1",count=tostring(0),isCount=true,sizeDelta=Vector2(0,0),rare=DefaultSprite,icon=DefaultTexture,scale=Vector3(0,0,0),isClick=true}};
  airPlaneAnchorPos=Vector2(1000,450);
  toursimBtnBool=true;
  toursimBtnMaskBool=false;
  airPlaneBool=false;
  rewardPanelBool=false;
  reward_Bool=false;
  rewardPanelAnima="";
  line_1SizeData=Vector2(60,0),
  line_2SizeData=Vector2(60,0),
  line_3SizeData=Vector2(60,0),
  line_3AnchorPos=Vector2(325,-135);
  line_1text="";
  line_2text="";
  line_3text="";
  symbol_1=DefaultSprite;
  symbol_1_SizeData=Vector2(10,16);
  symbol_2=DefaultSprite;
  symbol_2_SizeData=Vector2(10,16);
  spendIcon=DefaultTexture;
  spendCount="";
  maskhomeBool=false;
  
  remainCountBool=false;
  remainCountText="";

}
local command = {
    toursimBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local re=DataExHelper.Check_TourismRuning()
            if re==nil then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityTourismPanelViewModel_0"));
                return;
            end
            local body={ActivityID=curType}
            serverRewardData=nil;
            ApiMgr.Request("buy_lottery", body, true, function(result)
                local re=json.decode(result);
                serverRewardData=re.result;
                RedMgr.Singleton:UpdateClientRedData("1068", 0);
                this.ShowTourismButtonState(false);
                this.DOFly(serverRewardData.LotteryID);
            end, nil,true);
        end,
    },
    outToursimBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if not canTourism then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityTourismPanelViewModel_2"))
            end
        end
    },
    closeBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if airflying then return end;
          if(poetryTweener~=nil) then
              poetryTweener:Kill();
          end
          this.vm.data.rewardPanelBool=false;
          this.vm.data.maskhomeBool=false;
          this.ParseData();
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
            vm.behaviour:UpdateTopBar("", this.OnBack);
            LuaMgr.AddUIEventListener(UIEventConst.PropUse, this.ParseData);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if(poetryTweener~=nil) then
            poetryTweener:Kill();
        end
        if coroutineKey~=nil then
            coroutine_runner.stop(coroutineKey)
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.PropUse, this.ParseData);
        print("before_deactive");
    end,
}
this.OnBack=function()
    if airflying then return end;
    local re=DataExHelper.Check_TourismRuning()
    if re==nil then
        LuaMgr.Back("cdkey");
    else
        LuaMgr.Back("yunyou");
    end
end




this.ParseData=function()
    local sysVariables,type=DataExHelper.Check_TourismRuning();
    curType=type;
    airflying=false;
    cfgActiveLotteryMap=ConfigMgr.Config.LotteryActivityMap;
    cfgLotteryMap=ConfigMgr.Config.LotteryMap;
    dataLottery=DataMgr.Player.lottery;
    this.vm.data.airPlaneBool=false;
    this.vm.data.rewardPanelBool=false;
    this.vm.data.reward_Bool=false;
    this.vm.data.maskhomeBool=false;

    this.ShowRemainCount();
    this.ShowTourism();
end

this.ShowRemainCount=function()
    local cfgTime=cfgActiveLotteryMap[curType].MaxCount;
    if cfgTime==0 then
        this.vm.data.remainCountBool=false;
        remainLotteryCount=-1;
    else
        this.vm.data.remainCountBool=true;
        local dailyCountMap=DataMgr.Player.dailyCount;
        local buyCount=dailyCountMap["BuyLottery"];
        if buyCount==nil then
            buyCount=0;
        end
        remainLotteryCount=cfgTime-buyCount;
        if remainLotteryCount<0 then
            remainLotteryCount=0;
        end
        this.vm.data.remainCountText=string.format(LuaMgr.GetLangText("ActivityTourismPanelViewModel_1"),remainLotteryCount);
    end
    
end

this.ShowTourismButtonState=function(tourism)
    this.vm.data.toursimBtnBool=tourism;
    this.vm.data.toursimBtnMaskBool=not tourism;
end



this.ShowTourism=function()
    curLotteryContent=cfgActiveLotteryMap[curType].Content;
    local list={};
    canTourism=false;
    for i,v in ipairs(curLotteryContent) do
        local vctor=tourismPosList[i];
        local lottery=cfgLotteryMap[v];
        local checkRewards=this.CheckReward(v);
        canTourism=checkRewards or canTourism;
        local tourismItem={
            vector=vctor,
            BG=LuaMgr.GetSprite("Tourism",lottery.Icon),
            BGsuo=LuaMgr.GetSprite("Tourism",lottery.Icon.."b"),
            BG2=LuaMgr.GetSprite("Tourism",lottery.Icon.."g");
            name=LuaMgr.GetLangText(lottery.NameLan),
            animaName="",
            done=not checkRewards,
            suo= checkRewards,
            fx=false,
        }
        table.insert(list,tourismItem);
    end
    this.ShowTourismButtonState(canTourism)
    this.vm.data.tourismList=list;
    this.ShowSpends();

end

this.ShowSpends=function()
    local maxCount=#cfgActiveLotteryMap[curType].Content;
    local doneCount=0;
    if dataLottery~=nil and dataLottery[curType]~=nil then
        doneCount=#dataLottery[curType]
    end
    if(doneCount>=maxCount) then return end;
    local curIndex=doneCount+1;
    local consumes=cfgActiveLotteryMap[curType].Consume;
    local consume=consumes[curIndex];
    local myCount=DataHelper.GetItemCountById(consume.id);
    local iconPath=ConfigHelper.GetItemHomeIconPath(consume.id)
    this.vm.data.spendIcon=LuaMgr.GetTexture(iconPath);
    this.vm.data.spendCount=consume.count>myCount 
            and "<color=#F80404>"..tostring(consume.count).."</color>" or tostring(consume.count);
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

this.DOFly=function(lotteryID)
    local flyIndex=nil;
    for i,v in ipairs(curLotteryContent) do
        if v==lotteryID then
            flyIndex=i;
            break;
        end
    end
    if(flyIndex~=nil) then
        airflying=true;
        this.vm.data.maskhomeBool=true;
        this.vm.data.airPlaneBool=true;
        local targetPos=tourismPosList[flyIndex];
        local initPos=Vector2(1000,targetPos.y);
        this.vm.data.airPlaneAnchorPos=initPos;
        if(tweener~=nil) then
            tweener:Kill();
        end
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/plane.mp3");
        tweener=DOTWeen.To(function() return initPos  end,
                function(vector) this.vm.data.airPlaneAnchorPos=vector  end,
                targetPos,1.2):SetEase(Ease.Linear);
        tweener.onComplete=function()
            this.PlayToursimAnimation(flyIndex);
        end
    end
    
end


this.PlayToursimAnimation=function(index)
    this.vm.data.tourismList[index].animaName=trourismAnima_Name;
    this.vm.data.airPlaneBool=false;
    if coroutineKey~=nil then
        coroutine_runner.stop(coroutineKey)
    end
    coroutineKey=coroutine_runner.start(function()
        this.vm.data.tourismList[index].fx=true;
        coroutine_runner.wait(0.8);
        this.vm.data.tourismList[index].suo=false;
        this.vm.data.tourismList[index].done=true;
        coroutine_runner.wait(0.5);
        this.ShowReward();
    end)
end



this.ShowReward=function()
    this.vm.data.rewardPanelBool=true;




    local rewards=cfgLotteryMap[serverRewardData.LotteryID].Reward;
    local item =ConfigMgr.Config.itemMap[tostring(rewards[1].id)];
    local list={};
    local rewardItem={id=tostring(rewards[1].id),count=LuaMgr.NumFormat(rewards[1].count),isCount=true,
                      rare=ActivityMgr.GetRareSprite(item.rare),
                      icon=ActivityMgr.GetItemTexture(tostring(rewards[1].id)),
                      scale=Vector3(1,1,1),
                      sizeDelta=Vector2(128,128),
                      isClick=true
    }
    table.insert(list,rewardItem);
    this.vm.data.goodlist=list;
    this.ShowPoetry();
end


this.ShowPoetry=function()
    local lottery=cfgLotteryMap[serverRewardData.LotteryID];
    local poetryDes=LuaMgr.GetLangText(lottery.DescriptionLan);
    lines=NumTool.split(poetryDes,';')
    lineCount=#lines
    if(lineCount>1) then
        this.vm.data.line_1text=LuaMgr.FormatVerticalText(lines[1]);
        this.vm.data.line_2text=LuaMgr.FormatVerticalText(lines[2]);
        this.vm.data.line_3text=LuaMgr.FormatVerticalText(lines[3]);
        this.vm.data.line_1SizeData=Vector2(60,0);
        this.vm.data.line_2SizeData=Vector2(60,0);
        this.vm.data.line_3SizeData=Vector2(60,0);
        lineIndex=1;

        local path=string.format("%sTourismVoice/%s.mp3",Path.audio_PATH,lottery.Voice)
        AudioMgr.Singleton:PlayVoice(path);
        this.DOShowProetry(lineIndex);
    end
    
end

this.DOShowProetry=function(index)
    if lineIndex>lineCount then
        this.vm.data.reward_Bool=true;
        this.vm.data.rewardPanelAnima=rewardPanelAnima_name02;
        if coroutineKey~=nil then
            coroutine_runner.stop(coroutineKey);
        end
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/window_M.mp3");
        coroutineKey=coroutine_runner.start(function()
            coroutine_runner.wait(0.5);
            airflying=false;
            local cardPopup = serverRewardData.Reward.Cards ~= nil and #serverRewardData.Reward.Cards > 0
            local skinPopup = serverRewardData.Reward.Skins ~= nil and #serverRewardData.Reward.Skins > 0
            if cardPopup or skinPopup then
                local data=json.encode(serverRewardData.Reward);
                LuaMgr.ShowItemRewared(data);
            end
        end)
        return 
    end
    if(poetryTweener~=nil) then
        poetryTweener:Kill();
    end
    local targetPos=Vector2(60,455);
    local durtion=2;
    if lineIndex==lineCount then
        local len=LuaMgr.GetStringLength(lines[lineIndex]);
        local offset=26;
        this.vm.data.line_3AnchorPos=Vector2(325,-150+offset*len);
        targetPos=Vector2(60,200+offset*len);
    end
    local punctuation=cfgLotteryMap[serverRewardData.LotteryID].Punctuation
    local symbol_1=LuaMgr.GetSprite("Tourism",punctuation[1]);
    local symbol_2=LuaMgr.GetSprite("Tourism",punctuation[2]);
    this.vm.data.symbol_1=symbol_1;
    this.vm.data.symbol_2=symbol_2;
    this.vm.data.symbol_1_SizeData=Vector2(symbol_1.rect.width,symbol_1.rect.height)
    this.vm.data.symbol_2_SizeData=Vector2(symbol_2.rect.width,symbol_2.rect.height)
    poetryTweener=DOTWeen.To(function()return  Vector2(60,0) end,function(vector)
        if index==1 then
            this.vm.data.line_1SizeData=vector;
        elseif index==2 then
            this.vm.data.line_2SizeData=vector;
        elseif index==3 then
            this.vm.data.line_3SizeData=vector;
        end
    end,targetPos,durtion):SetEase(Ease.Linear);
    poetryTweener.onComplete=function()
        lineIndex=lineIndex+1;
        this.DOShowProetry(lineIndex);
    end
    
end

return vm({
    data = data,
    command = command,
    hook = hook
})
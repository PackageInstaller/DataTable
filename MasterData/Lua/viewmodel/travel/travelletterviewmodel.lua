




local this = {vm=nil};
local cfgBento={};
local cfgItems={};
local cfgTravelPostCardMap={};
local travelCardMap={}
local travelAreaList={}
local cfgTravelCard={}
local cardList={};
local dataPostcards={}
local lunchId=nil;
local dataTravel=nil;
local rewardsList={};
local hasRewardList={};
local path="Images/TravelCards/"
local pageIndex=1;
local everyPage=6;
local pageTotalCount=nil;
local tweenter=nil;
local curTravelState=nil;
local cokey1=nil;
local cokey2=nil;
local cokey3=nil;
local cokeyTips=nil;
local isStopClick=false;
local postCardIdList={};
local spineCharacter=nil;
local cfgTipsMap={}
local cfgTravelConstants
local isSkipTask=false;
local curTravelCount=0;
local isPlaying=false;
local isPause=false;
local isRunTips=false;
local bentoKey=nil;
local curCardTypeIndex=1;
local remainTime=nil;
local isCanTraveling=false;
local cardArray={{pos=Vector2(-155,119),angle=Vector3(0,0,10)},
                 {pos=Vector2(12,102),angle=Vector3(0,0,-10)},
                 {pos=Vector2(176,111),angle=Vector3(0,0,0)},
                 {pos=Vector2(-142,-65),angle=Vector3(0,0,-10)},
                 {pos=Vector2(8,-134),angle=Vector3(0,0,0)},
                 {pos=Vector2(162,-75),angle=Vector3(0,0,10)},
}
local TravelState={
    Prepare=0,
    Bento=1,
    Traveling=2,
    Letter=3,
    Rewards=4,
}
local coCard=nil;

local data = {

    travelPrepareBool=false,
    travelBentoBool=false,

    travelingBool=false,
    bentoInfo="",
    tipMoreAnchorPos=Vector2(0,0);
    bentoTipLessBool=false,
    bentoTipMoreBool=false,
    startBtnGrayBool=false,
    startBtnBool=false,

    travelLetterBool=false,
    
    characterBool=false,
    
    letterCount="",
    contentSizeData=Vector2(0,0);
    contentAnchorPos=Vector2(0,0);
    
    cardList={
        {
            pos=Vector2(0,0);
            angle=Vector3(0,0,0);
            name="";
            lock=false,
            iconTexture=DefaultTexture,
            id="",
            isDecor1Active=false,
            isDecor2Active=false,
            isDecor3Active=false,
            animaName="";
            isFx=false;
            orderLayer=0;
        },
    },
    bentoList={
        {
            iconTexture=DefaultTexture,
            isOn=false;
            name="";
            num="";
            
        }
    },
    
    itemList={
        {
            
        }
    },

    isActiveUpPage=false;
    isActiveDownPage=false;
    page="";
    collectPro="";
    
    textPos1=Vector2(70,0);
    textPos2=Vector2(70,0);
    root_aniName="";
    root_aniLoop=false;
    isCommingLetter=false;
    isQingWa=false;
    isCaoDecor=false;



    travelCount="";
    tipsList={
        {
            tipText="",
            isOn=false,
        },
        {
            tipText="",
            isOn=false,
        },
        {
            tipText="",
            isOn=false,
        },
        {
            tipText="",
            isOn=false,
        }
    },
    popMailBool=false;
    mailList={
        {
          name="",
          count="",
          bg=DefaultSprite,
          isRewared=false;
        }
    },
    isBrildBool=false;
    isShipTraving=false;
    myBentoCount="";
    
    
    cardTypeBool=false;
    typeName="",
    tagUp=false,
    tagDown=false,
    cardTypeList={
        {
            name="",
            isOn=false,
        }
    },
    prepareContentAnchorPos=Vector2(0,0);
    travelTimeBool=false;
    timer="";
    battlePanelBool=false;
isCardPosting=true;
    
    
}

local command = {

    travelPrepareBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)




            if not isCanTraveling then return end;
            this.CloseTips();
            isCanTraveling=false;
            this.OnAskStartTravel();
        end
        
    },
    travelingBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)

        end
    },
    grayTravelingBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.bentoTipLessBool=true;
            if bentoKey~=nil then
                coroutine_runner.stop(bentoKey);
            end
            bentoKey=coroutine_runner.start(function()
                coroutine_runner.wait(1.5)
                this.vm.data.bentoTipLessBool=false;
            end)
            
        end
          
        
    },
    
    travelLetterBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.root_aniName="ani_TravelLetterPanel_pop";
            this.PopOnMailList();
            this.CloseTips();
        end
    },
    cardBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isStopClick then
                return;
            end
            local index=tonumber(param)+1;
            local id=this.vm.data.cardList[index].id
            LuaMgr.ShowLuaPanel(UIName.TravelCardsViewModel,cfgTravelCard,id,vm);
            this.CloseTips();
        end
    },
    bentoTog={
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            if isOn then
              this.UpdateBentoInfo(param);
            end
        end
    },
    rewardsBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.OnAskGetRewards();
            this.CloseTips();
        end
    },
    costMaskBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.SetTravelState(TravelState.Prepare);
            this.vm.data.root_aniName="ani_TravelLetterPanel_root_plateSway";
            this.BentoClear();
            this.CloseTips();
        end
    },
    upPageBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            pageIndex=pageIndex+1;
            if pageIndex<=pageTotalCount then
                this.SetTravelCard();
                this.CloseTips();
            end
        end
    },
    downPageBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            pageIndex=pageIndex-1;
            if pageIndex>=1 then
                this.SetTravelCard();
                this.CloseTips();
            end
        end
    },
    tipsSkinBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if isSkipTask then
                LuaMgr.ShowLuaPanel(UIName.TravelTaskViewModel);
            else
                LuaMgr.ShowLuaPanel(UIName.TravelNovelViewModel);
            end
            this.CloseTips();
        end
    },
    closePopMailBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.popMailBool=false;
        end
    },
    travelingTipsBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("TravelLetterViewModel_5"));
        end
    },
    travelLevelBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.ShowLuaPanel(UIName.TravelLevelViewModel);
        end
        
    },
    cardTypeMoreBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if this.vm.data.cardTypeBool then
                this.vm.data.cardTypeBool=false;
                this.vm.data.tagDown=true;
                this.vm.data.tagUp=false;
            else
                this.vm.data.cardTypeBool=true;
                this.vm.data.tagDown=false;
                this.vm.data.tagUp=true;
                this.SetCardTypeList();
            end
        end
    },
    cardTypeItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            if curCardTypeIndex==index then return end;
            curCardTypeIndex=index;
            for i,v in ipairs(this.vm.data.cardTypeList) do
                v.isOn=i==curCardTypeIndex;
            end
            local cardTypeItem=this.vm.data.cardTypeList[curCardTypeIndex];
            this.vm.data.typeName=cardTypeItem.name;
            if cardTypeItem.id==0 then
                cardList=cfgTravelCard;
            else
                cardList=travelCardMap[tostring(cardTypeItem.id)];
            end
            pageIndex=1;
            pageTotalCount=math.ceil(#cardList/everyPage);
            this.SetTravelCard()
            this.vm.data.cardTypeBool=false;
        end
    },
    randomBattleBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local dungeonId=dataTravel.DungeonIdMeet;
            BattlePrepareMgr.EnterBattlePrepare(dungeonId,dungeonId,BattlePrepareMgr.BattleType.Travel);
        end

    },
    closeBattleBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           ApiMgr.Request("travel/abandon",{},true,function()
               dataTravel=DataMgr.Player.travel;
               remainTime =dataTravel.FinishTime-LuaMgr.Timestamp()-1;
           end,nil,true);
        end

    },
    
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        spineCharacter=vm.behaviour.transform:Find("root/Middle/left_info/character/Travel001"):GetComponent("UISpineCharacter");
        RedMgr.Singleton:RegisterViewModel(UIName.TravelLetterViewModel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.vm.data.isShipTraving=false;
            curTravelState=nil;
            isPlaying=false;
            isRunTips=false;
            postCardIdList={};
            cfgTravelCard={};
            travelCardMap={};
            cardList={};
            cfgBento={};
            cfgTravelPostCardMap=ConfigMgr.Config.TravelPostcardMap;
            cfgItems=ConfigMgr.Config.itemMap;

            for i,v in pairs(cfgItems) do
                if v.type==22 then
                    table.insert(cfgBento,v.id);
                end
            end
            table.sort(cfgBento,function(a, b) return a<b end);
            
            for p,m in pairs(cfgTravelPostCardMap) do
                if m.RewardType==1 then
                    table.insert(cfgTravelCard,m);
                end
            end
            table.sort(cfgTravelCard,function(a, b) 
                return tonumber(a.Id)<tonumber(b.Id);
            end)

            for i,v in ipairs(cfgTravelCard) do

                if travelCardMap[v.Area]==nil then
                    travelCardMap[v.Area]={}
                end
                table.insert(travelCardMap[v.Area],v);
            end
            cardList=cfgTravelCard;
            
            dataPostcards=DataMgr.Player.postcards;
            pageIndex=1;
            for i,v in ipairs(cfgTravelCard) do
                if dataPostcards[v.Item]~=nil then
                    pageIndex=math.ceil(i/6);
                    break;
                end
            end
            cfgTravelConstants=ConfigMgr.Config.TravelConstants;
            local cfgTips=ConfigMgr.Config.TravelTipsMap;

            cfgTipsMap={}
            for i,v in pairs(cfgTips) do
                if cfgTipsMap[v.TravelType]==nil then
                    cfgTipsMap[v.TravelType]={}
                end
                table.insert(cfgTipsMap[v.TravelType],v);
            end
            travelAreaList={}
            table.insert(travelAreaList,{Id=0,AreaNameLan=LuaMgr.GetLangText("TravelLetterViewModel_9")})
            for i,v in pairs(ConfigMgr.Config.TravelAreaMap) do
                table.insert(travelAreaList,v);
            end
            table.sort(travelAreaList,function(a, b) 
                return tonumber(a.Id)<tonumber(b.Id)
            end)
            HeroRedDataHelper.FrushTravelRed(false);
            this.vm.data.typeName=LuaMgr.GetLangText("TravelLetterViewModel_10");
            curCardTypeIndex=1;
            this.ParseData();
            this.TipsMgr();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        LuaMgr.RemoveTimer(TimerConst.TravalTimer);
        LuaMgr.RemoveTimer(TimerConst.TravelTipTimer);
        AudioMgr.Singleton:StopVoice();
        this.CloseTips();
        if cokey1~=nil then
            coroutine_runner.stop(cokey1);
            cokey1=nil;
        end
        if cokey2~=nil then
            coroutine_runner.stop(cokey2);
            cokey2=nil;
        end
        if cokey3~=nil then
            coroutine_runner.stop(cokey3);
            cokey3=nil;
        end
        if cokeyTips~=nil then
            coroutine_runner.stop(cokeyTips);
            cokeyTips=nil;
        end
        if coCard~=nil then
            coroutine_runner.stop(coCard);
            coCard=nil;
        end
    end,
}

this.BentoClear=function()
    for i,v in ipairs(this.vm.data.bentoList) do
        v.isOn=false;
    end
    this.vm.data.bentoTipMoreBool=false;
    this.vm.data.bentoTipLessBool=false;
    lunchId=nil;
end


this.OnAskStartTravel=function()
    ApiMgr.Request("travel/start", {Lunch="5033"}, true, function(result)


        AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "newUI/travel_Leave.mp3")
        spineCharacter:PlayAnimation("run",false,this.RunAnimationComplete);
        this.vm.data.travelBentoBool=false;
        this.vm.data.bentoTipMoreBool=false;
        this.vm.data.root_aniName="ani_TravelLetterPanel_root_born_02";

        dataTravel=DataMgr.Player.travel;
        LuaMgr.RemoveTimer(TimerConst.TravalTimer);
        if cokey1~=nil then
            coroutine_runner.stop(cokey1);
        end
        cokey1=coroutine_runner.start(function()
            coroutine_runner.wait(0.5)
            this.SetTravelState(TravelState.Traveling)
            coroutine_runner.wait(2)
            remainTime =dataTravel.FinishTime-LuaMgr.Timestamp()-1;
            LuaMgr.AddTimer(TimerConst.TravalTimer,this.Timer,1,-1,true);
        end)
    end, function()
        isCanTraveling=true;
    end, true);
   
end


this.RunAnimationComplete=function()
    this.vm.data.characterBool=false;
    this.vm.data.isShipTraving=true;

    isRunTips=true;
    this.TipsOnStart();
end


this.OnAskGetRewards=function()
    ApiMgr.Request("travel/getRewards", { }, true, function(result)
        this.vm.data.popMailBool=false;
        local re=json.decode(result);
        local dataJson=json.encode(re.result.Rewards);
        local rewardCardIds={};
        for i,v in pairs(re.result.Rewards.Items) do
            if ConfigMgr.Config.itemMap[i].type==19 then
                table.insert(rewardCardIds,i);
            end
        end
        this.ShowCards(rewardCardIds,dataJson);
        
    end, nil, true);
end


this.ParseData=function()
    lunchId=nil;
    isPause=false;
    isCanTraveling=true;
    this.vm.data.cardTypeBool=false;
    this.vm.data.tagUp=false;
    this.vm.data.tagDown=true;
    this.vm.data.popMailBool=false;
    this.vm.data.bentoTipMoreBool=false;
    this.vm.data.bentoTipLessBool=false;
    dataPostcards=DataMgr.Player.postcards;
    dataTravel=DataMgr.Player.travel;

    local scrWidth=LuaMgr.GetScreenWidth()-600;
    this.vm.data.contentSizeData=Vector2(scrWidth,500);
    this.vm.data.contentAnchorPos=Vector2(0,0);
    this.vm.data.isCommingLetter=false;
    curTravelCount=DataMgr.Player.dailyCount.TravelTimes;
    curTravelCount=curTravelCount==nil and 0 or curTravelCount;
    this.vm.data.travelCount=curTravelCount.."/"..cfgTravelConstants.TravelTimes;
    pageTotalCount=math.ceil(#cardList/everyPage);
    this.SetTravelCard();
    this.vm.data.root_aniLoop=true;
    remainTime =dataTravel.FinishTime-LuaMgr.Timestamp();
    LuaMgr.RemoveTimer(TimerConst.TravalTimer);
    LuaMgr.AddTimer(TimerConst.TravalTimer,this.Timer,1,-1,true);
end


this.CheckRandomBattle=function()
    if not IsNullOrEmpty(dataTravel.DungeonIdMeet) and LuaMgr.Timestamp()>=dataTravel.DungeonIdMeetTime then
        this.vm.data.battlePanelBool=true;
        return true;
    else
        this.vm.data.battlePanelBool=false;
        return false;
    end
end


this.SetTravelTimer=function(isOn)
    this.vm.data.travelTimeBool=isOn;
    if not isOn then
        return;
    end
    if remainTime<0 then
        remainTime=0;
        return;
    end
    local h,m,s=GetTimeHMS(remainTime)
    this.vm.data.timer = string.format("%2s  %2s  %2s", h, m, s)
    remainTime=remainTime-1;
end



this.SetBentoCount=function()
    local bentoCount=0
    for i,v in pairs(cfgBento) do
        bentoCount=bentoCount+DataHelper.GetItemCountById(v);
    end
    this.vm.data.myBentoCount=tostring(bentoCount);
end

this.TipsMgr=function()
    LuaMgr.RemoveTimer(TimerConst.TravelTipTimer);
    local internal=cfgTravelConstants.OtherEjectTips;
    if internal==nil or internal==0 then
        internal=120;
    end
    LuaMgr.AddTimer(TimerConst.TravelTipTimer,this.TipsOnStart,internal,-1,true);
end

this.TipsOnStart=function()
    if cokeyTips~=nil then
        coroutine_runner.stop(cokeyTips);
    end
    cokeyTips=coroutine_runner.start(function()
        if not isRunTips then
            coroutine_runner.wait(cfgTravelConstants.FirstEjectTips);
        end
        this.SetTravelTips(); 
        this.CheckNovelAndTaskTips();
        coroutine_runner.wait(cfgTravelConstants.CloseTips);
        this.CloseTips();
    end);
    
end

this.SetTravelTips=function()
    local type=curTravelState~=0 and curTravelState or 1;
    local loc=type;
    if type==TravelState.Letter and this.vm.data.characterBool then
        type=4;
        loc=1
    elseif this.vm.data.characterBool and curTravelCount>=cfgTravelConstants.TravelTimes then
        type=7;
        loc=1;
    elseif isRunTips then
        type=8;
        loc=2;
    end
    this.vm.data.tipsList[loc].isOn=true;
    math.randomseed(os.time());
    local index=math.random(1,#cfgTipsMap[type])
    this.vm.data.tipsList[loc].tipText=LuaMgr.GetLangText(cfgTipsMap[type][index].TravelMessageLan);
    isRunTips=false;
    
end

this.CloseTips=function()
    for i,v in ipairs(this.vm.data.tipsList) do
        v.isOn=false;
    end
end

this.Timer=function()
    if isPause then return end;
    dataPostcards=DataMgr.Player.postcards;
    dataTravel=DataMgr.Player.travel;
    if curTravelState~=nil and curTravelState<TravelState.Traveling then
        return;
    end
    local isLetter=this.CheckLetterComming();
    this.SetCharacter(isLetter);
end


this.CheckNovelAndTaskTips=function()

    HeroRedDataHelper.FrushTravelRed(false);
    local isTask=RedMgr.Singleton:GetRedStateById("1142")==1;
    local isNovel=RedMgr.Singleton:GetRedStateById("1143")==1;
    this.vm.data.tipsList[4].isOn=isTask or isNovel;
    if not isTask and not isNovel then
        return;
    end
    isSkipTask=isTask;
    if isTask then
        this.vm.data.tipsList[4].tipText=LuaMgr.GetLangText(cfgTipsMap[5][1].TravelMessageLan);
    elseif isNovel then
        this.vm.data.tipsList[4].tipText=LuaMgr.GetLangText(cfgTipsMap[6][1].TravelMessageLan);
    end
end



this.ShowCardRewards=function(cardItemId,dataJson)
    postCardIdList={};
    for i,v in ipairs(cardList) do
        if v.Item==cardItemId then
            table.insert(postCardIdList,v.Id);
        end
    end
    local locIndex=1;
    if #postCardIdList>0then
        for i,v in ipairs(cardList) do
            if v.Id==postCardIdList[1] then
                locIndex=i;
            end
        end
        if locIndex~=nil then
            locIndex=math.ceil(locIndex/everyPage)
        end
    end
    pageIndex=locIndex;
    if cokey2~=nil then
        coroutine_runner.stop(cokey2);
    end
    cokey2=coroutine_runner.start(function()
        this.vm.data.isCommingLetter=true;
        this.vm.data.root_aniName="ani_TravelLetterPanel_root_xx";
        coroutine_runner.wait(0.7);
        this.vm.data.isCommingLetter=false;
        if this.vm.data.characterBool then
            this.vm.data.root_aniName="ani_TravelLetterPanel_root_xx_disappear";
            this.vm.data.travelPrepareBool=true;
        end
        coroutine_runner.wait(0.5)
        this.ParseData();
        coroutine_runner.wait(0.8);
        LuaMgr.ShowItemRewared(dataJson);
        isStopClick=false;
    end);
end


this.SetCharacter=function(isLetter)
    local curTimestamp=LuaMgr.Timestamp();
    local isBattle=this.CheckRandomBattle();
    if not isBattle and (dataTravel.FinishTime==0 or dataTravel.FinishTime<=curTimestamp) then
        LuaMgr.RemoveTimer(TimerConst.TravalTimer);

        if not isLetter then
            this.vm.data.root_aniName="ani_TravelLetterPanel_root_born";
            this.SetTravelState(TravelState.Prepare);
        else

            this.vm.data.isBrildBool=false;
            this.SetTravelState(TravelState.Letter);
        end
        this.vm.data.characterBool=true;
        this.vm.data.isShipTraving=false;
        this.SetTravelTimer(false);
        if isLetter then
            if isPlaying then return end;
            isPlaying=true;
            this.CloseTips();
            AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/travel_Back.mp3")
            spineCharacter:PlayAnimation("drop",false,function()
                spineCharacter:PlayAnimation("idle",true,nil);
            end)
            
        else
            isPlaying=false;
            this.CloseTips();
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "newUI/travel_Hello.mp3")
            spineCharacter:PlayAnimation("hi",false,function()
                spineCharacter:PlayAnimation("idle",true,nil);
            end)
        end

    else

        if isLetter then
            this.vm.data.isBrildBool=true;
            this.SetTravelState(TravelState.Letter);
        else
            this.SetTravelState(TravelState.Traveling);
        end
        this.vm.data.characterBool=false;
        this.vm.data.isShipTraving=not isBattle;
        isPlaying=false;
        this.SetTravelTimer(not isBattle)
    end
end

this.SetTravelState=function(travelState)
    if curTravelState~=nil and  curTravelState==travelState then return end;
    curTravelState=travelState;
    local isCarding=IsNull(dataPostcards) or NumTool.GetLen(dataPostcards)<#cfgTravelCard;
    this.vm.data.isCardPosting= isCarding;
    this.vm.data.travelPrepareBool=isCarding and (travelState==TravelState.Prepare or travelState==TravelState.Bento);
    this.vm.data.travelBentoBool=travelState==TravelState.Bento;
    this.vm.data.travelingBool=travelState==TravelState.Traveling;
    this.vm.data.travelLetterBool=travelState==TravelState.Letter;
    this.vm.data.isCaoDecor=travelState==TravelState.Traveling or travelState==TravelState.Letter;
    this.vm.data.isCardPosting= isCarding;
    if travelState==TravelState.Traveling then
        this.TextDoMove(1,10);
    elseif travelState==TravelState.Letter then
        this.TextDoMove(2,10);
    end
   
end


this.SetTravelCard=function()
    this.vm.data.isActiveUpPage=pageIndex<pageTotalCount;
    this.vm.data.isActiveDownPage=pageIndex>1;
    this.vm.data.collectPro=string.format("%s/%s",NumTool.GetLen(dataPostcards),#cfgTravelCard);
    this.vm.data.page=string.format(LuaMgr.GetLangText("TravelLetterViewModel_8"),pageIndex,pageTotalCount);
    this.vm.data.cardList={};
    local list={};
    for i=1,everyPage,1 do
        local loc=(pageIndex-1)*everyPage+i;
        local v=cardList[loc];
        if v~=nil then

            local cardItem={
                pos=cardArray[i].pos;
                angle=Vector3(0,0,v.Rotation);
                lock=dataPostcards[v.Item]==nil,
                iconTexture=LuaMgr.GetTexture(path..v.SetContent1..".png");
                id=v.Id;
                isDecor1Active=v.Rotation>0,
                isDecor2Active=v.Rotation<0,
                isDecor3Active=v.Rotation==0,
                isFx=false;
                orderLayer=1;
                animaName="";
            }
            cardItem.name=cardItem.lock and string.format("<color=#898783>%s</color>",LuaMgr.GetLangText(v.ItemNameLan)) 
                    or LuaMgr.GetLangText(v.ItemNameLan);
            table.insert(list,cardItem);
        end
    end
    this.vm.data.cardList=list;
    if #postCardIdList>0 then
        local locList={}
        for i,v in ipairs(postCardIdList) do
            for p,m in ipairs(this.vm.data.cardList) do
                if m.id==v then
                    table.insert(locList,p);
                    break;
                end
            end
        end
        if coCard~=nil then
            coroutine_runner.stop(coCard);
        end
        coCard=coroutine_runner.start(function()
            for i,v in ipairs(locList) do
                this.vm.data.cardList[v].orderLayer=2;
                this.vm.data.cardList[v].animaName="ani_ui_TravelLetterPanel_carditem";
            end
            coroutine_runner.wait(0.5)
            for i,v in ipairs(locList) do
                if  this.vm.data.cardList[v]~=nil then
                    this.vm.data.cardList[v].isFx=true
                end
            end
        end)
        
    end
    
    postCardIdList={};
    list=nil;
end


this.SetTravelBento=function()
    this.vm.data.bentoList={};
    local list={}
    local isCanStart=false;
    for i,v in pairs(cfgBento) do
        local myCount=DataHelper.GetItemCountById(v);
        isCanStart=isCanStart or myCount>0;
        local path=myCount>0 and ConfigHelper.GetItemIconPath(v) or string.format("%sTravelCards/itemicon_%s_hui.png",Path.Image,v);
        local bentoItem={
            iconTexture=LuaMgr.GetTexture(path),
            isOn=false;
            lunchId=v;
            name=LuaMgr.GetLangText(ConfigMgr.Config.itemMap[v].nameLan);
            num=tostring(myCount)
        }
        table.insert(list,bentoItem);
    end
    this.vm.data.bentoList=list;
    this.vm.data.startBtnBool=isCanStart;
    this.vm.data.startBtnGrayBool=not isCanStart;
    this.vm.data.prepareContentAnchorPos=Vector2(0,0);
    
end


this.CheckLetterComming=function()
    if IsNull(dataTravel.PendingRewards) or dataTravel.PendingRewards==nil or #dataTravel.PendingRewards==0 then
        return false;
    end
    rewardsList={}
    hasRewardList={};
    local curTimestamp=LuaMgr.Timestamp();
    for i,v in ipairs(dataTravel.PendingRewards) do
        if v.FinishTime<=curTimestamp then
            table.insert(rewardsList,v.Rewards);
        end
    end
    if #rewardsList>0 then
        this.vm.data.letterCount=tostring(#rewardsList);
    end
    if dataTravel.HadDrewRewards~=nil and #dataTravel.HadDrewRewards>0 then
        for i,v in ipairs(dataTravel.HadDrewRewards) do
            table.insert(hasRewardList,v.Rewards)
        end
    end
    return #rewardsList>0;
end


this.SetTravelRewards=function()
    if #rewardsList>0 then
        local list={};
        local mergeRewards={};
        for i,v in ipairs(rewardsList) do
            local post=cfgTravelPostCardMap[v]
            if post~=nil then
                for p,m in ipairs(post.Rewards) do
                    if mergeRewards[m.id]==nil then
                        mergeRewards[m.id]=m.count;
                    else
                        local count=mergeRewards[m.id]
                        mergeRewards[m.id]=m.count+count;
                    end
                end
            end
        end
        for p,m in pairs(mergeRewards) do
            local item=ConfigHelper.CreateGoodsItem(p,m,0.7,true,true);
            table.insert(list,item);
        end
        this.vm.data.itemList=list;
    end
    
end
    

this.TextDoMove=function(type,time)
    local startPos=Vector2(70,0);
    local endPos=Vector2(-160,0);
    if tweenter~=nil then
        tweenter:Kill();
    end
    tweenter=DOTWeen.To(function() return startPos  end, function(vector)
        if type==1 then
            this.vm.data.textPos1=vector;
        elseif type==2 then
            this.vm.data.textPos2=vector;
        end
    end,endPos,time):SetEase(Ease.Linear):SetLoops(-1);
end    

this.PopOnMailList=function()
    this.vm.data.popMailBool=true;
    this.vm.data.mailList={};
    local list={}
    local hasRewardId={};
    local rewardId={}
    if #hasRewardList>0 then
        for i,v in ipairs(hasRewardList) do
            for p,m in ipairs(v) do
                table.insert(hasRewardId,m);
            end
        end
    end
    if #rewardsList>0 then
        for i,v in ipairs(rewardsList) do
            for p,m in ipairs(v) do
                table.insert(rewardId,m);
            end
        end
    end

    local rewards={}
    local cfgItem =nil;
    if #rewardId>0 then
        for i,v in ipairs(rewardId) do
            if cfgTravelPostCardMap[v]~=nil then

                rewards=cfgTravelPostCardMap[v].Rewards;
                for p,m in ipairs(rewards) do
                    cfgItem=ConfigMgr.Config.itemMap[tostring(m.id)];
                    local item=ConfigHelper.CreateGoodsItem(m.id,m.count,0.5,false,true);
                    item.isRewared=false;
                    item.count="X"..m.count;
                    item.name=LuaMgr.GetLangText(cfgItem.nameLan);
                    item.bg=DefaultSprite;
                    table.insert(list,item);
                end
            end
        end
    end
    if #hasRewardId>0 then
        for i,v in ipairs(hasRewardId) do
            rewards=cfgTravelPostCardMap[v].Rewards;
            for p,m in ipairs(rewards) do
                cfgItem=ConfigMgr.Config.itemMap[tostring(m.id)];
                local item=ConfigHelper.CreateGoodsItem(m.id,m.count,0.5,false,true);
                item.isRewared=true;
                item.count="X"..m.count;
                item.name=LuaMgr.GetLangText(cfgItem.nameLan);
                item.bg=DefaultSprite;
                table.insert(list,item);
            end
        end
    end
    for i,v in ipairs(list) do
        v.bg=i%2~=0 and LuaMgr.GetSprite("Travel","ui_lx_lxwl_xx_djd1") or LuaMgr.GetSprite("Travel","ui_lx_lxwl_xx_djd2");
    end
    this.vm.data.mailList=list;
end


this.ShowCards=function(rewardCardIds,dataJson)
    local callBack=function()
        if #rewardCardIds==0 then
            if this.vm.data.characterBool then
                this.vm.data.root_aniName="ani_TravelLetterPanel_root_xx_disappear";
                this.vm.data.travelPrepareBool=true;
            end
            if cokey3~=nil then
                coroutine_runner.stop(cokey3);
            end
            cokey3=coroutine_runner.start(function()
                coroutine_runner.wait(0.5)
                LuaMgr.ShowItemRewared(dataJson);
                this.ParseData();
            end)
        else
            isStopClick=true;
            this.ShowCardRewards(rewardCardIds[1],dataJson);
        end
    end
    
    if #rewardCardIds==0 then 
        callBack();
        return
    end;
    isPause=true;
    local cfgRewardCard={}
    for i,v in ipairs(cfgTravelCard) do
        for p,m in ipairs(rewardCardIds) do
            if v.Item==m then
                table.insert(cfgRewardCard,v);
            end
        end
    end
    LuaMgr.ShowLuaPanel(UIName.TravelCardsViewModel,cfgRewardCard,cfgRewardCard[1].Id,this.vm,callBack);
end



this.UpdateBentoInfo=function(param)
    local index=tonumber(param)+1;
    local bentoItem=this.vm.data.bentoList[index]
    lunchId=bentoItem.lunchId;
    local cfgItem=ConfigMgr.Config.itemMap[bentoItem.lunchId];
    this.vm.data.bentoTipMoreBool=true;
    this.vm.data.bentoInfo=LuaMgr.GetLangText(cfgItem.DescriptionLan);
    local x=-250+(index-1)*(128+15);
    this.vm.data.tipMoreAnchorPos=Vector2(x,93);
    this.CloseTips();
    this.vm.data.startBtnBool=tonumber(bentoItem.num)>0;
    this.vm.data.startBtnGrayBool=tonumber(bentoItem.num)==0
end
    
this.SetCardTypeList=function()
    this.vm.data.cardTypeList={};
    local list={}
    for i,v in ipairs(travelAreaList) do
        local cardItem={
            name=LuaMgr.GetLangText(v.AreaNameLan),
            isOn=i==curCardTypeIndex,
            id=v.Id;
        }
        table.insert(list,cardItem);
    end
    this.vm.data.cardTypeList=list;
end


return vm({
    data = data,
    command = command,
    hook = hook
})
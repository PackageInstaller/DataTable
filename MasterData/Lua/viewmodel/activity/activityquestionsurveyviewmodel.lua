




local this = {vm=nil,
              chargeKeyFormat = "%s_%s_%s",
              urlFormat = "&q1=%s&q2=%s&q3=%s&q4=%s&q5=%s&q6=%s&q7=%s&q8=%s" };



local QuesType={quesType1=0,quesType2=1,quesType3=4,quesType4=2,quesType5 =3}

local answer={questionnaire_id=0,answers={},answer_start=0,answer_end=0};
local quesIndex=0;
local quesCount=0;
local curQuesType=0;
local surveyList={};
local cursurvey={};
local curQuestions={};
local curQuestionContent={}
local curQuestionOptions={};
local toggleGroup=nil;

local color1=UnityEngine.Color(0.64,0.63,0.58,1);
local color2=UnityEngine.Color(0.275,0.69,0.60,1);

local content_quesType4_InputField=nil;
local hyperlinkText=nil;
local userInputItemValue="";
local ansertype1Index=nil;
local coroutine_key=nil;
local isImageQues=false;
local proIndex=1;
local indexStack={}

local data = {
   chapterListData={{name="",BGURL=DefaultTexture,des="",pos=Vector2(0,-46),isCondition=false,reward=false,begain=false,nobegain=false,startReward=false,
                     chapterRewardDataList= {{id="1",count=tostring(0),isCount=true,sizeDelta=Vector2(0,0),rare=DefaultSprite,icon=DefaultTexture,scale=Vector3(0,0,0),isClick=true}}}},
   answerItemListData1={{isFillBlank="",
                         info="",
                         inputBool=false,
                         maxWidthBool=false,
                         inputText="",
                         inputValue="",
                         tipBool=false,
                         tipText="",
                         single=true,
                         multiple=false,
                         answitem1_isOn=false,
                         selectColor=UnityEngine.Color(1,1,1,1)}},
   answerItemListData4={{info="",des="",single=true,multiple=false,answitem4_isOn=false,}},
   answerItemListData5={{info="",
                         answItemToggleGroupIsOn=false,
                         answitem5_1_isOn=false,
                         answitem5_2_isOn=false,
                         answitem5_3_isOn=false,
                         answitem5_4_isOn=false,
                         answitem5_5_isOn=false,
                         answitem5_1_Active=false,
                         answitem5_2_Active=false,
                         answitem5_3_Active=false,
                         answitem5_4_Active=false,
                         answitem5_5_Active=false,
                        }},
   anserItemListImageData={{answerimage_url="",
                            answitem1_isOn=false,
                            size=Vector2(244,138),
                            single=false,
                            multiple=false,
                            
                           }},
   
   rectOpList={
       { opText="",isOn=false},
       { opText="",isOn=false},
       { opText="",isOn=false},
       { opText="",isOn=false},
       { opText="",isOn=false},
   };
   rewardListData={{id="1",count=tostring(0),sizeDelta=Vector2(0,0),isCount=true,rare=DefaultSprite,icon=DefaultTexture,scale=Vector3(0,0,0),isClick=true}};
   chapterBool=true,
   contentBool=false,
   rewardBool=false,
   endBool=false,
   
   content_titleNum="",
   content_title="",
   content_BG_Url="",
   

   content_quesTemp_1Bool=false,
   content_quesTemp_1_TogIsOn=false,


   content_quesTemp_2Bool=false,
   content_quesTemp_2_TogIsOn=false,


   content_quesTemp_3Bool=false,
   content_quesTemp_3_Tog1IsOn=false,
   content_quesTemp_3_Tog2IsOn=false,
   content_quesTemp_3_Tog3IsOn=false,
   content_quesTemp_3_Tog4IsOn=false,
   content_quesTemp_3_Tog5IsOn=false,

   content_quesPro=0.0,
   content_quesProValue="",
   
   contentAnchorPos=Vector2(0,0),
   middleBool=false,
   

   content_quesTemp_4Bool=false;
   content_quesTemp_4_text="";
   content_quesTmep_4_limit="";
   content_quesTmep_4_sizeFitterBool=true;
   userInputBool=false;
   userInputText="";
   userInputLimit=500;
   userInputLimitTextBool=true;
   

   content_quesTemp_5Bool=false;

   content_quesTemp_ImageBool=false;
   
   preQustionBool=false;
}

local command = {

    startComand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param + 1)
            local id = this.vm.data.chapterListData[index].id
            local lock,tips = this.CheckCondition(id)
            if lock then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tips)
                return
            end
            local address = this.vm.data.chapterListData[index].address.."?sojumpparm="
            local serverParam = DataMgr.Player.uid.."|"..LuaMgr.selectServer
            local serverStr = this.EncodeURI(serverParam)


            local tempMoney = 0
            local charge,chargeChannel = nil,nil
            local chargeKey = nil
            for key,value in pairs(DataMgr.Player.shop.records) do
                charge = ConfigMgr.Config.charge[key]
                if charge ~= nil then
                    chargeKey = string.format(this.chargeKeyFormat,charge.ChargeGroup,"CNY",1)
                end
                chargeChannel = ConfigMgr.Config.chargeChannel[chargeKey]
                if chargeChannel ~= nil then
                    tempMoney = tempMoney + (chargeChannel.Price * value) / 100
                end
            end
            local chargeMoney = this.GetChargeCode(tempMoney)
            local teamLevel = 0
            local character = nil
            local lastMainEvent = DataMgr.Player.lastMainEvent
            if lastMainEvent == nil then
                lastMainEvent = DataMgr.Player.lastEvent
            end
            for kay,value in pairs(DataMgr.Player.teams["0"].members) do
                character = DataMgr.Player.characters[value]
                if character ~= nil then
                    teamLevel = teamLevel + character.level
                end
            end
            local params = string.format(this.urlFormat,
                    DataMgr.Player.uid,
                    DataMgr.Player.level,
                    DataMgr.Player.registTime,
                    math.floor(CS.UnityEngine.Time.realtimeSinceStartup),
                    lastMainEvent,chargeMoney,teamLevel,LuaMgr.loginDays)
            
            local questionSurveyUrl = address..serverStr..params
            LuaMgr.OpenURL(questionSurveyUrl,"portrait")


            this.vm.data.chapterListData[index].nobegain = false
            


















        end
    },
    nextCommand = {
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           this.NextQuestion(1);
        end
    },
    preCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.NextQuestion(-1);
        end 
    },
    rewardComand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            NoticeMgr.CheckQuestionnaire_Submit(answer.questionnaire_id,answer,function()

                ActivityMgr.Activity_Reward("questionnaire",answer.questionnaire_id,this.CompleteActivity)
            end)
        end
    },

    startRewardComand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param+1);
            local id=this.vm.data.chapterListData[index].quesId;
            ActivityMgr.Activity_Reward("questionnaire",id,function()
                this.CompleteActivity(index);
            end)
        end
    },
    
    exitComand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            ActivityMgr.surveying=false;

        end
    },
    

    answerItem1_Comand=
    {
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            local index=tonumber(param)+1;
            local list=vm.data.answerItemListData1;
            if isImageQues then
                list=vm.data.anserItemListImageData;
            end
            if this.CheckMaxOptions(list) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_0"),curQuestionContent.AtMost));
                LuaMgr.DelayFrame(function()
                    list[index].answitem1_isOn=false;
                end)
                return;
            end
            if(isOn) then

                list[index].selectColor=color2;
            else
                list[index].selectColor=color1;
            end
        end
    },
    answerItem2_Comand=
    {
        type=XLuaCommandType.Bool,
        execute=function(vm,isOn,param)
            local index=tonumber(param)+1;
            if(isOn) then ;
                vm.data.answerItemListData1[index].selectColor=color2;
            else
                vm.data.answerItemListData1[index].selectColor=color1;
            end
        end
    },
    answerType4_InputOnValueChange=
    {
        type=XLuaCommandType.String,
        execute=function(vm,value)
            if not this.vm.data.userInputLimitTextBool then return end;
            local len=LuaMgr.GetStringLength(value);
            this.vm.data.content_quesTmep_4_limit="("..len.."/500)";
        end
    },
    userInputBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            ansertype1Index=tonumber(param);
            if ansertype1Index~=nil then
                this.vm.data.userInputLimit=500;
                this.vm.data.userInputLimitTextBool=true;
            else
                this.vm.data.userInputLimit=0;
                this.vm.data.userInputLimitTextBool=false;
            end
            this.vm.data.userInputBool=true;
        end
        
    },
    userInputCloseBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.vm.data.userInputBool=false;
            local text=content_quesType4_InputField.text;
            this.SetOpType1TextItem(text);
            if text=="" then
                text=LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_1")
            end
            this.vm.data.userInputText=text;
            userInputItemValue=text;
            if ansertype1Index==nil then
                if coroutine_key~=nil then
                    coroutine_runner.stop(coroutine_key);
                end
                coroutine_key=coroutine_runner.start(function()
                    coroutine_runner.wait(0.02);
                    this.vm.data.content_quesTmep_4_sizeFitterBool=false;
                    this.vm.data.content_quesTmep_4_sizeFitterBool=true;
                end)
            end
            
        end
    }
}


this.CompleteActivity=function(index)
    this.vm.data.rewardBool=false;
    this.vm.data.endBool=true;

    local rewardids={};
    local rewardNums={};
    local rewards={};
    if index~=nil then
        rewards=surveyList[index].Rewards
    else
        rewards=cursurvey.Rewards;
    end
    for i=1,#rewards,1 do
        local reward=rewards[i];
        table.insert(rewardids,reward.ID);
        table.insert(rewardNums,reward.Count);
    end
    ActivityMgr.CompleteActivity("questionnaire",tostring(answer.questionnaire_id),rewardids,rewardNums);
    
end

this.CheckCondition = function(id)
    local lock,tips,tipsCondition = nil,"",""
    local condition = ConfigMgr.Config.QuestionnaireMap[id]
    if condition == nil then return end
    if condition.require[1] == "1" then
        lock = tonumber(condition.require[2]) > DataMgr.Player.level
        tipsCondition = condition.require[2]
        tips = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2128"].NameLan),tipsCondition)
    elseif condition.require[1] == "2" then
        local dungeon = DataMgr.Player.dungeonRecords[condition.require[2]]
        lock = dungeon == nil or dungeon.historyRating == ""
        tipsCondition = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[condition.require[2]].NameLan)
        tips = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2134"].NameLan),tipsCondition)
    end
    return lock,tips
end


this.CheckStartCondition=function(index)
    local re=true;
    local tips="";
    local conditons=surveyList[index].Condition
    for i,v in ipairs(conditons) do
        local cons=NumTool.split(v,";")
        if cons[1]=="1" then
            re= DataMgr.Player.level>=tonumber(cons[2]) and re;
            if not re then
               tips=string.format(LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_39"),cons[2]);
            end
        elseif cons[1]=="2" then
            re= DataMgr.Player.dungeonRecords[cons[2]]~=nil and re;
            if not re then
                local dungeonName=LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[cons[2]].NameLan)
                tips=string.format(LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_40"),dungeonName);
            end
        end
    end
    return re,tips;
end

this.DelaySetContentFitter=function()
    if ansertype1Index==nil then
        this.vm.data.content_quesTmep_4_sizeFitterBool=false;
        this.vm.data.content_quesTmep_4_sizeFitterBool=true;
    end
end



this.CheckMaxOptions=function(list)

    if curQuestionContent.AtMost==0 or curQuesType~=QuesType.quesType2 then return false end;
    local selectCount=0;
    for i,v in ipairs(list) do
        if v.answitem1_isOn then
            selectCount=selectCount+1;
        end
    end
    return selectCount>curQuestionContent.AtMost
end


this.CheckMutexOptins=function(index)
    if curQuesType==QuesType.quesType2 and curQuestionOptions[index].mutually_exclusive then
        for i,v in ipairs(curQuestionOptions) do

            if v.mutually_exclusive and i~=index  then
                if this.vm.data.answerItemListData1[i].answitem1_isOn then
                    this.vm.data.answerItemListData1[i].answitem1_isOn=false;
                end
            end
        end
    end
end


local hook = {
    before_awake = function(vm)
        print("before_awake");
        toggleGroup=vm.behaviour.transform:Find("root/Middle/BG/Content/Body/QuestionTemp_1/Scroll View/Viewport/Content"):GetComponent("ToggleGroup");
        hyperlinkText=vm.behaviour.transform:Find("root/Middle/BG/Content/Title/title_2"):GetComponent("HyperlinkText");
        content_quesType4_InputField=vm.behaviour.transform:Find("root/Middle/BG/UserInput/InputField")
                :GetComponent("InputField")
        hyperlinkText.onHrefClick:AddListener(function(url)
            LuaMgr.OpenURL(url);
        end);
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then 
            this.vm=vm;


            this.InitSurveyData()
            LuaMgr.AddUIEventListener(UIEventConst.OnApplicationFocus, this.OnApplicationFun)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        print("before_deactive");

        vm.data.contentBool=false;
        vm.data.rewardBool=false;
        vm.data.endBool=false;
        vm.data.chapterListData = {}
        LuaMgr.RemoveUIEventListener(UIEventConst.OnApplicationFocus, this.OnApplicationFun)
    end,
    before_destroy=function()
        toggleGroup=nil;
        content_quesType4_InputField=nil;
        hyperlinkText=nil;
        this = nil
    end
}


this.InitSurveyData = function()
    local tempItem,tempList,rewardList = nil,{},nil
    for key,value in pairs(ConfigMgr.Config.QuestionnaireMap) do
        if LuaMgr.Timestamp() >= value.startTime and LuaMgr.Timestamp() < value.endTime then

            rewardList = {}
            if value.reward ~= nil and #value.reward > 0 then
                for i = 1, #value.reward do
                    tempItem = ConfigHelper.CreateGoodsItem(value.reward[i].id,value.reward[i].count,0.4,true,true)
                    table.insert(rewardList,tempItem)
                end
            end

            tempItem = {name = LuaMgr.GetLangText(value.titleLan),isCondition = this.CheckCondition(key),
                        BGURL = LuaMgr.GetTexture(Path.QuestionSurveyPath..value.cover..".png"),
                        begain = not this.GetQuestionnaireData(key),reward = true,id = key,
                        des = LuaMgr.GetLangText(value.conditionDescriptionLan),
                        nobegain = this.GetQuestionnaireData(key),chapterRewardDataList = rewardList,
                        address = this.GetChannelAddress(value.addressNew)}
            table.insert(tempList,tempItem)
        end
    end
    table.sort(tempList,function(item1,item2)
        if item1.id ~= item2.id then
            return item1.id < item2.id
        end
    end)
    this.vm.data.chapterListData = tempList
    this.vm.data.middleBool = true
end


this.GetChannelAddress = function(addressNew)
    if addressNew == nil then return end
    local address = ""
    for i = 1, #addressNew do
        if addressNew[i][1] == "prod" then
            address = addressNew[i][2]
        end
        if addressNew[i][1] == LuaMgr.selectServer then
            address = addressNew[i][2]
            break
        end
    end
    return address
end

this.GetQuestionnaireData = function(key)
    for i = 1, #NoticeMgr.questionnaireData do
        if NoticeMgr.questionnaireData[i] == key then
            return true
        end
    end
    return false
end


this.OnApplicationFun = function(args)
    local hasFocus = args[0]
    if hasFocus then
        NoticeMgr.GetQuestionnaireData(function()
            this.InitSurveyData()
        end)
    end
end

this.ParseData=function(vm)

    this.vm.data.middleBool=true;
    this.vm.data.userInputBool=false;
    this.InitDefault(vm)
    this.SetChaperData(vm);

end




this.InitDefault=function(vm,has)
    if(not has) then
        vm.data.chapterBool=true;
        vm.data.contentBool=false;
        vm.data.rewardBool=false;
        vm.data.endBool=false;
    else
        vm.data.chapterBool=false;
        vm.data.contentBool=false;
        vm.data.rewardBool=false;
        vm.data.endBool=true;
    end
   
end

this.SetChaperData=function(vm)
    vm.data.chapterListData={};
    local list={};
    


    for i=1,#surveyList,1 do
        local reward={};
        local rewardsData=surveyList[i].Rewards;
        for j=1,#rewardsData,1 do
            local rewardData=rewardsData[j];
            local rewardItem=ConfigHelper.CreateGoodsItem(rewardData.ID,LuaMgr.NumFormat(rewardData.Count),0.4,true,true)
            table.insert(reward,rewardItem);
        end
        local isCon=this.CheckStartCondition(i);
        local chapterItem={name=surveyList[i].Title,
                           quesId=surveyList[i].ID,
                           BGURL=surveyList[i].TitleBackgroundImg,
                           des=surveyList[i].Description,
                           pos=Vector2(0,-20),
                           reward=true,
                           isCondition=not isCon;
                           begain=not surveyList[i].RewardReceived and not surveyList[i].Complete,
                           nobegain= surveyList[i].RewardReceived and surveyList[i].Complete,
                           startReward=surveyList[i].Complete and not surveyList[i].RewardReceived,
chapterRewardDataList=reward};
        table.insert(list,chapterItem);
    end
    vm.data.chapterListData=list;
    list=nil;
end

this.ClearData=function()
    quesIndex=0; 
    quesCount=0;
    curQuesType=0;
    curQuestions={};
    curQuestionOptions={};
answer={questionnaire_id=0,answers={},answer_start=0,answer_end=0};
end

this.SetOpType1TextItem=function(text)
    if curQuesType==QuesType.quesType1 or curQuesType==QuesType.quesType2 then
        this.vm.data.answerItemListData1[ansertype1Index+1].inputText=text=="" and LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_41") or text;
        this.vm.data.answerItemListData1[ansertype1Index+1].inputValue=text;
    end
end

this.GetChargeCode = function(charge)

    if charge >= 0 and charge < 7 then
        return 1
    elseif charge >= 7 and charge < 30 then
        return 2
    elseif charge >= 30 and charge < 129 then
        return 3
    elseif charge >= 129 and charge < 329 then
        return 4
    elseif charge >= 329 and charge < 649 then
        return 5
    elseif charge >= 649 and charge < 2001 then
        return 6
    elseif charge >= 2001 and charge < 3001 then
        return 7
    elseif charge >= 3001 and charge < 5001 then
        return 8
    elseif charge >= 5001 and charge < 10001 then
        return 9
    elseif charge >= 10001 then
        return 10
    end
end



this.StartQuestion=function(index)

    answer.questionnaire_id=cursurvey.ID;
    answer.answer_start=LuaMgr.Timestamp();
    quesIndex=1;
    proIndex=1;
    quesCount=#curQuestions;
    curQuesType=curQuestions[quesIndex].Type;
    ActivityMgr.surveying=true;
    curQuestionContent=curQuestions[quesIndex];
    curQuestionOptions=curQuestions[quesIndex].Options;
    this.vm.data.preQustionBool=false;
    indexStack={}
    this.SetQuestionData()
end


this.NextQuestion=function(dir)
    local isAuswer,jumpIndex=this.SaveAnswer();
    if dir>0 and isAuswer==1 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_42"));
        return;
    elseif dir>0 and isAuswer==2 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_43"),curQuestionContent.AtLeast));
        return;
    end
    if(dir>0 and not isAuswer) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_2"),nil,nil);
        return
    end
    if(dir>0 and quesIndex>=quesCount) then
        answer.answer_end=LuaMgr.Timestamp();
        this.vm.data.contentBool=false;
        this.vm.data.rewardBool=true;
        this.ShowReward();
        return;
    end
    if dir<0 then
        quesIndex=indexStack[#indexStack]
        table.remove(indexStack,#indexStack);
    else
        table.insert(indexStack,quesIndex)

        local unJumpIndex=this.CheckJumpQuestion(curQuestionContent.UnconditionalJump)
        if unJumpIndex~=nil then
            quesIndex=unJumpIndex;
        elseif jumpIndex~=nil then
            quesIndex=jumpIndex;
        else
            quesIndex=quesIndex+1;
        end
    end
   
    this.vm.data.preQustionBool=quesIndex>1;
    local re=this.CheckQuestonUnlockCondition()
    if not re then
        answer.answer_end=LuaMgr.Timestamp();
        this.vm.data.contentBool=false;
        this.vm.data.rewardBool=true;
        this.ShowReward();
        return
    end
    curQuesType=curQuestions[quesIndex].Type;
    curQuestionContent=curQuestions[quesIndex];
    curQuestionOptions=curQuestions[quesIndex].Options;
    this.SetQuestionData()
    
end
    


this.CheckQuestonUnlockCondition=function()
    local re=false;
    local operator=curQuestions[quesIndex].UnlockOperator;
    local unlockCondition=curQuestions[quesIndex].UnlockCondition
    if IsNull(unlockCondition) or #unlockCondition==0 then
        return true;
    end
    local reItem=false;
    if operator=="and" then
        reItem=true;
        re=true
    end
    for i,v in ipairs(unlockCondition) do
        local tarQues_Answers=answer.answers[v.ParentQuestionID]
        if tarQues_Answers~=nil then

            reItem=this.CheckQuestionContains(v.Options,tarQues_Answers.Options,v.SelectCountType,v.SelectType==0)
        end
        if operator=="and" then
            re=re and reItem;
        else
            re=re or reItem;
        end
    end
    if not re then
        quesIndex=quesIndex+1;
        if quesIndex>#curQuestions then
           return false;
        end
        this.CheckQuestonUnlockCondition();
    end
    return true;
end


this.CheckQuestionContains=function(Options,tarOptions,op,isContain)
    local re=true;
    if op==0 then
        re=false;
    end
    local childRe=false;
    for i,v in ipairs(Options) do
        childRe=not isContain;
        for p,m in ipairs(tarOptions) do
            if m==v then
                childRe=isContain;
                break
            end
        end
        if op==1 then
            re=re and childRe;
        elseif op==0 then
            re=re or childRe;
        end 
    end
    return re;
end


 this.CheckJumpQuestion=function(jump)
     local index=quesIndex;
     if jump==nil or jump=="" or jump=="next" then
         return nil;
     end
     if jump=="end" then
         jump=quesCount;
     else
         for i,v in ipairs(curQuestions) do
             if v.ID==jump then
                 index=i;
             end
         end
     end
     return index~=quesIndex and index or nil;
 end



this.SaveAnswer=function()
    local options={};
    local fillBank={};
    local jumpIndex=nil;
    if curQuesType==QuesType.quesType1 then
        local list={};
        if isImageQues then
            list=this.vm.data.anserItemListImageData;
        else
            list=this.vm.data.answerItemListData1;
        end
        for i,v in ipairs(list) do
            if(v.answitem1_isOn) then
                table.insert(options,i-1);
                if v.inputBool  then
                    if v.inputValue=="" then
                        return 1;
                    end
                    fillBank[tostring(i-1)]=v.inputValue;
                end
                jumpIndex=this.CheckJumpQuestion(curQuestionOptions[i].Jump);
                break;
            end
        end
      
        this.SaveOptions(options,fillBank);
        return #options>0 or not curQuestionContent.Required,jumpIndex;
    elseif(curQuesType==QuesType.quesType2) then
        local list={};
        if isImageQues then
            list=this.vm.data.anserItemListImageData;
        else
            list=this.vm.data.answerItemListData1;
        end
        for i,v in ipairs(list) do
            if(v.answitem1_isOn) then
                table.insert(options,i-1)
                if  v.inputBool then
                    if v.inputValue=="" then
                        return 1;
                    end
                    fillBank[tostring(i-1)]=v.inputValue;
                end
            end
        end
        this.SaveOptions(options,fillBank)
        
        local least=curQuestionContent.AtLeast;
        least=least==0 and 1 or least;
        if #options<least and curQuestionContent.Required  then
            return 2
        end
        return #options>=least or not curQuestionContent.Required,nil
    elseif(curQuesType==QuesType.quesType5) then

        local list=this.vm.data.answerItemListData5;
        for i,v in ipairs(list) do
            local re=this.QuesType5Answer(v);
            if re<0 and curQuestionContent.Required then 
                return false
            end;
            table.insert(options,re);
        end
        this.SaveOptions(options,fillBank);
        return true,nil;
    elseif curQuesType==QuesType.quesType4 then

        local list=this.vm.data.answerItemListData4;
        for i,v in ipairs(list) do
            if v.answitem4_isOn then
                table.insert(options,i-1);
                break;
            end
        end
        this.SaveOptions(options,fillBank)
        return #options>0 or not curQuestionContent.Required,nil;
    elseif(curQuesType==QuesType.quesType3) then
        local value=content_quesType4_InputField.text;
        if curQuestionContent.Required and value=="" then
            return false;
        end
        table.insert(options,0);
        fillBank["0"]=value;
        this.SaveOptions(options,fillBank)
        return true;
    end
end


this.SaveOptions=function(options,fillBank)
    TryArray(options)
    local answerOptions={Options=options,FillBlank=fillBank}
    answer.answers[curQuestionContent.ID]=answerOptions;
end




this.QuesType5Answer=function(answer)
    local re=-1;
    if(answer.answitem5_1_isOn) then
        re=0;
    elseif(answer.answitem5_2_isOn) then
        re=1;
    elseif(answer.answitem5_3_isOn) then
        re=2;
    elseif(answer.answitem5_4_isOn) then
        re=3;
    elseif(answer.answitem5_5_isOn) then
        re=4;
    end
    return re;
end


this.ShowReward=function()
    this.vm.data.rewardListData={};
    local list={}
    for i,v in ipairs(cursurvey.Rewards) do
        local rewardItem=ConfigHelper.CreateGoodsItem(v.ID,v.Count,0.8,true,true);
        table.insert(list,rewardItem);
    end
    this.vm.data.rewardListData=list;
    
end


this.SetTitleAndSlider=function()
    local title=curQuestionContent.Title;
    if curQuesType==QuesType.quesType1 then
        title=string.format(LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_44"),title);
    elseif curQuesType==QuesType.quesType2 then
        title=string.format(LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_45"),title);
    end
    this.vm.data.content_titleNum=string.format(LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_46"),quesIndex);
    this.vm.data.content_title=title;
    local sliderVlaue=(quesIndex-1)/quesCount;
    this.vm.data.content_quesPro=sliderVlaue;
    local value=string.format("%2d",math.ceil(sliderVlaue*100));
    this.vm.data.content_quesProValue=value.."%";
end

this.SetQuestionClearData=function()
    isImageQues=false;
    ansertype1Index=nil;
    userInputItemValue="";
    this.vm.data.userInputText=LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_5");
    content_quesType4_InputField.text="";
end




this.SetQuestionData=function()
    this.SetQuestionClearData();
    this.SetTitleAndSlider();
    this.vm.data.contentAnchorPos=Vector2(0,0);
    this.Clear(curQuesType);
    this.vm.data.content_quesTemp_1Bool=false
    this.vm.data.content_quesTemp_2Bool=false
    this.vm.data.content_quesTemp_ImageBool=false;
    this.vm.data.content_quesTemp_3Bool=curQuesType==QuesType.quesType3;
    this.vm.data.content_quesTemp_4Bool=curQuesType==QuesType.quesType4;
    this.vm.data.content_quesTemp_5Bool=curQuesType==QuesType.quesType5;
    if curQuesType==QuesType.quesType1  or curQuesType==QuesType.quesType2 then 
        this.SetDataQuestionType1();
    elseif curQuesType==QuesType.quesType4 then 
        this.SetDataQuestionType4();
    elseif curQuesType==QuesType.quesType5 then
        this.SetDataQuestionType5();
    elseif curQuesType==QuesType.quesType3 then
        this.SetDataQuestionType3();
    end
    
end



this.SetDataQuestionType1=function()
    isImageQues=this.SetDataImageType();
    if  isImageQues then
        return;
    end
    local anserList={}
    local isType2=false;
    local length=0;
    for i,v in ipairs(curQuestionOptions) do
        local content=v.Content;
        if v.Description~="" then
            content=string.format("%s <color=#6f5327><size=18>(%s)</size></color>",content,v.Description);
        end
        local hasIsOn,hasInput=this.CheckHasAnswers(i)
        local anserItem={
            single=curQuesType==QuesType.quesType1 ,
            multiple=curQuesType==QuesType.quesType2,
            selectColor=hasIsOn and color2 or color1,
            answitem1_isOn=hasIsOn,
            info=content,
            inputBool= v.Required,
            maxWidthBool=not v.Required,
            inputText=hasInput~="" and hasInput or LuaMgr.GetLangText("ActivityQuestionsurveyViewModel_6"),
            inputValue=hasInput,
            tipBool=false,
        }
        table.insert(anserList,anserItem);
        local len=NumTool.GetStringLength(v.Content);
        local lentip=0;
        if v.Description~="" then
            lentip=math.ceil(NumTool.GetStringLength(v.Description)/2);
        end
        length=len+lentip;
        if length>10 then
            isType2=true;
        end
    end
    if not isType2 then
        this.vm.data.content_quesTemp_1Bool=true;
        this.vm.data.content_quesTemp_2Bool=false;
        this.vm.data.answerItemListData1=anserList;
    else
        this.vm.data.content_quesTemp_1Bool=false;
        this.vm.data.content_quesTemp_2Bool=true;
        this.vm.data.answerItemListData1=anserList;
    end
end


this.CheckHasAnswers=function(index)
    local hasAnswers=nil
    local isOn,input=false,"";
    if  answer.answers[curQuestionContent.ID]~=nil then
        hasAnswers=answer.answers[curQuestionContent.ID];
    end
    if hasAnswers~=nil then
        for i,v in ipairs(hasAnswers.Options) do
            if index-1==v then
                isOn=true
                break
            end
        end
        if hasAnswers.FillBlank[tostring(index-1)]~=nil then
            input=hasAnswers.FillBlank[tostring(index-1)];
        end
    end
    return isOn,input;
end



this.SetDataImageType=function()
    this.vm.data.anserItemListImageData={};
    local anserList={}
    for i,v in ipairs(curQuestionOptions) do
        if v.Img=="" then
            return false
        end
        local anserItem={
            single=curQuesType==QuesType.quesType1 ,
            multiple=curQuesType==QuesType.quesType2,
            answerimage_url=v.Img,
            selectColor=color1,
            answitem1_isOn=false,
            size=Vector2(244,138),
        }
        table.insert(anserList,anserItem);
    end
    this.vm.data.content_quesTemp_ImageBool=true;
    this.vm.data.anserItemListImageData=anserList;
    return true;
end






this.SetDataQuestionType4=function()
    local anserList={}
    for i,v in ipairs(curQuestionOptions) do
        local hasIsOn,hasInput=this.CheckHasAnswers(i)
        local anserItem={single=true,multiple=false,answitem4_isOn=hasIsOn,info=tostring(v.Content),des=""};
        table.insert(anserList,anserItem);
    end
    this.vm.data.answerItemListData4=anserList;

end


this.SetDataQuestionType5=function()
    local anserList={};
    local rowTitles=NumTool.split(curQuestionContent.RowTitle,"\n");
    local count=#curQuestionOptions;

    for p,m in ipairs(curQuestionOptions) do
        this.vm.data.rectOpList[p].isOn=p<=count;
        this.vm.data.rectOpList[p].opText=p<=count and m.Content or "";
    end
    local hasAnswers=nil
    if  answer.answers[curQuestionContent.ID]~=nil then
        hasAnswers=answer.answers[curQuestionContent.ID];
    end
    for i,v in ipairs(rowTitles) do
        local ausIndex=-1;
        if hasAnswers~=nil and i<=#hasAnswers.Options then
            ausIndex=hasAnswers.Options[i]
        end
        local anserItem= { info = v,
                           answItemToggleGroupIsOn = false,
                           answitem5_1_isOn = ausIndex==0,
                           answitem5_2_isOn = ausIndex==1,
                           answitem5_3_isOn = ausIndex==2,
                           answitem5_4_isOn = ausIndex==3,
                           answitem5_5_isOn = ausIndex==4,
                           answitem5_1_Active = count >= 1,
                           answitem5_2_Active = count >= 2,
                           answitem5_3_Active = count >= 3,
                           answitem5_4_Active = count >= 4,
                           answitem5_5_Active = count >= 5,
        }
        table.insert(anserList,anserItem);
    end
    this.vm.data.answerItemListData5=anserList;
end


this.SetDataQuestionType3=function()
    local hasIsOn,hasInput=this.CheckHasAnswers(1)
    this.vm.data.userInputText=hasInput
    this.vm.data.content_quesTemp_4_text=hasInput;
    this.vm.data.content_quesTmep_4_limit="(0/500)";
end



this.Clear=function(quesType)

    if(quesType==QuesType.quesType1 or quesType== QuesType.quesType2) then
        for i,v in ipairs(this.vm.data.answerItemListData1) do
            v.answitem1_isOn=false;
        end
    else if(quesType==QuesType.quesType4) then
        for i,v in ipairs(this.vm.data.answerItemListData4) do
        v.answitem4_isOn=false;
        end
    elseif(quesType==QuesType.quesType5) then
        for i,v in ipairs(this.vm.data.answerItemListData5) do
            v.answitem5_1_isOn=false;
            v.answitem5_2_isOn=false;
            v.answitem5_3_isOn=false;
            v.answitem5_4_isOn=false;
            v.answitem5_5_isOn=false;
        end
        end
    end
end
this.EncodeURI = function(str)
    str = string.gsub(str, "([^%w%.%- ])", function(c)
        return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(str, " ", "+")
end

return vm({
    data = data,
    command = command,
    hook = hook
})
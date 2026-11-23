




local serverList={};
local dev=nil;
local channel="bili";
local baseUrl=nil;
local rollList={};
local slapfaceList= { };
local PaoMaDeng_stop=false;
local PaiLianTu_stop=false;
local rollhorseKey=nil;
local slapfaceKey=nil;


NoticeMgr={
    stopSlapface=true;
    normalNotices={};
    normalNoticesRed={};
    serverTimeStamp=nil;
    lunboData=nil;
    questionnaireData={};
    heartData={
        notice={
            putong={},
            lunbo={},
            paomadeng={},
            pailiantu={},
        },
        questions = {}
    }

}







NoticeMgr.NoticeRequire=function(types,gameScene,callBack)
    if(LuaMgr.InBattle()) then return end;
    local data={Types=types,
                Env=dev,
                Channel=channel,
                GameScene=gameScene,
    };
    local dataString=json.encode(data);
    local url=baseUrl.."crypto/noticeclient/get";
    LuaMgr.HttpRequest(url,dataString,true,{service="net-config"},function(result)
        if callBack~=nil then
            local re=json.decode(result)
            callBack(re.data);
        end
    end,nil,true,false,false);
end


NoticeMgr.CheckNotice_TingFu=function()
    NoticeMgr.NoticeRequire({"tingfu"},2,function(data)
        if  NumTool.GetLen(data)>0 then
            local title=data[1].Title;
            local content=data[1].Contents;
            LuaMgr.ShowLuaPanel(UIName.NoticeTipViewModel,title,content,nil);
        end

    end)
end



NoticeMgr.CheckNotice_PuTong=function(gameScene,callBack)
    NoticeMgr.NoticeRequire({"putong"},gameScene,function(data)
        if callBack~=nil then
            callBack(data);
        end
    end)
end


NoticeMgr.CheckNotice_PaoMaDeng=function(callBack)
    NoticeMgr.NoticeRequire({"paomadeng"},1,function(data)
        if callBack~=nil then
            callBack(data);
        end
    end)
end



NoticeMgr.CheckNotice_PaiLianTu=function(callBack)
    NoticeMgr.NoticeRequire({"pailian"},1,function(data)
        if callBack~=nil then
            callBack(data);
        end
    end)
end


NoticeMgr.CheckNotice_Lunbo=function(callBack)
    NoticeMgr.NoticeRequire({"lunbo"},1,function(data)
        if callBack~=nil then
            callBack(data);
        end
    end)
end





NoticeMgr.CheckNotice_Types=function(types,gameScene,callBack)
    NoticeMgr.NoticeRequire(types,gameScene,function(data)
        if callBack~=nil then
            callBack(data);
        end
    end)
end


NoticeMgr.GetQuestionnaireData = function(callBack)
    local tempData={}
    if DataExHelper.Check_QuestionnaireSurvey() then
        ApiMgr.Request("queryQuestion", tempData, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                NoticeMgr.questionnaireData = re.result.Question
                if callBack ~= nil then
                    callBack()
                end
            end
        end, nil, true)
    end
end






































NoticeMgr.CheckQuestionnaire_LoadInfo=function(questId,callBack)
    local data={
        Env=dev,
        Channel=channel,
        UID=DataMgr.Player.uid,
        QuestionnaireID=questId
    };
    local dataString=json.encode(data);
    local url=baseUrl.."crypto/questionnaire/client/load";
    LuaMgr.HttpRequest(url,dataString,true,{service="net-config"},function(result)
        if callBack~=nil then
            local re=json.decode(result)
            callBack(re.data);
        end
    end,nil,true,false,true);
end



NoticeMgr.CheckQuestionnaire_Submit=function(questId,answer,callBack)
    local data={
        Env=dev,
        Channel=channel,
        UID=DataMgr.Player.uid,
        QuestionnaireID=questId,
        StartTime=answer.answer_start,
        EndTime=answer.answer_end,
        Answers=answer.answers,
    };
    local dataString=json.encode(data);
    local url=baseUrl.."crypto/questionnaire/client/submit";
    LuaMgr.HttpRequest(url,dataString,true,{service="net-config"},function(result)
        if callBack~=nil then
            local re=json.decode(result)
            callBack(re.data);
        end
    end,nil,true,false,true);
end






NoticeMgr.GetLunboData=function()
    return NoticeMgr.lunboData;
end

NoticeMgr.GetPaiLianCount=function()
    return  #slapfaceList
end


NoticeMgr.GoToPanel=function(url)
    local tarUrl=NumTool.split(url,"_")
    local url="";
    for i=2,#tarUrl,1 do
        url=url.."_"..tarUrl[i];
    end
    url=string.sub(url,2);
    if tarUrl[1]=="game"then
        FeatureManager.GotoViewModel(url);
    else
        LuaMgr.OpenURL(url)
    end

end




local NoticeHeartBeatCheckState=function(oldlist,newlist)
    if  IsNull(newlist) then
        return false;
    end
    if NumTool.GetLen(oldlist)~=NumTool.GetLen(newlist) then
        return true;
    end
    for i,v in pairs(newlist) do
        if oldlist[tonumber(i)]==nil then
            return true
        elseif oldlist[tonumber(i)]~=v then
            return true
        end
    end

    return false;
end



local NoticeHeartBeat=function(pdata)
    if pdata.Length<1 then return end;
    local data=json.decode(pdata[0]);;
    if NoticeMgr.heartData~=nil then
        local isChange=false;
        if not IsNull(data.Notices) then

            isChange =NoticeHeartBeatCheckState(NoticeMgr.heartData.notice.putong,data.Notices.putong)
            if isChange then
                NoticeMgr.CheckNotice_PuTong(1,function(data)
                    NoticeMgr.HandlerPuTong(data);
                end)
            end


            isChange=NoticeHeartBeatCheckState(NoticeMgr.heartData.notice.paomadeng,data.Notices.paomadeng);
            if isChange then
                NoticeMgr.CheckNotice_PaoMaDeng(function(data)
                    NoticeMgr.HandlerPaomadeng(data);
                end)
            end








        end
        if IsNull(data.Notices) or IsNull(data.Notices.paomadeng) then
            NoticeMgr.heartData.notice.paomadeng = {}
            rollList={};
        end







    end

end




local PaoMaDeng_CheckPlayCondition=function(rollItem)
    if rollItem.Contents=="" then
        return false;
    end
    if rollItem.BattleScene==1 and not LuaMgr.IsBattling() then
        return false;
    end
    if rollItem.BattleScene==2 and LuaMgr.IsBattling() then
        return false;
    end
    if rollItem.LampCount==0 then
        return false;
    end
    return true;
end

local PaoMaDeng_CheckPopRollHourse=function()
    local len=NumTool.GetLen(rollList);
    if len==0 or PaoMaDeng_stop then return end;
    PaoMaDeng_stop=true;
    local rollItem=rollList[1];
    table.remove(rollList,1);
    table.insert(rollList,rollItem);
    if not PaoMaDeng_CheckPlayCondition(rollItem) then
        PaoMaDeng_stop=false;
    else
        local rollIndex=1;
        local tempIndex=nil;
        local stopRepeat=false;
        if rollhorseKey~=nil then
            coroutine_runner.stop(rollhorseKey);
        end
        rollhorseKey=coroutine_runner.start(function()
            while(true)
            do
                if not stopRepeat then
                    stopRepeat=true;
                    tempIndex=rollIndex;
                    LuaMgr.ShowLuaPanel(UIName.NoticeRollhorseViewModel,rollItem,function()
                        tempIndex=rollIndex+1;
                    end)
                end
                if tempIndex>rollItem.LampCount then
                    coroutine_runner.wait(rollItem.LampInterval);
                    PaoMaDeng_stop=false;
                    stopRepeat=false;
                    break;
                elseif rollIndex~=tempIndex then
                    coroutine_runner.wait(rollItem.LampInterval);
                    rollIndex=tempIndex;
                    stopRepeat=false;
                end
                coroutine_runner.waitForEndOfFrame();
            end

        end);
    end
end

local CheckWeekDay=function(weeDay)
    local date=os.date("*t",LuaMgr.Timestamp());
    return date.wday==weeDay;
end


local IsPopByDay=function(lastTimeStamp)
    if lastTimeStamp==0 then return true end;
    local lastDay=os.date("%d",lastTimeStamp);
    local today=os.date("%d",LuaMgr.Timestamp())
    return today~=lastDay;
end

local PaiLianTu_CheckGoodsBoughtCondition = function(slapface)
    local chargeLinkCfg = ConfigMgr.Config.AdvertiseBlockMap
    local _dataShopRecord = DataMgr.Player.shop.records;
    local batchId = 0
    for k, v in pairs(chargeLinkCfg) do
        if v.AdvertiseId == tostring(slapface.ID) then
            batchId = v.Batch
            break;
        end
    end
    for k, v in pairs(chargeLinkCfg) do
        if v.Batch == batchId then
            for i, chargeId in ipairs(v.ChargeId) do
                if _dataShopRecord[chargeId] ~= nil then
                    return true
                end
            end
        end
    end
    return false
end

local PaiLianTu_CheckPlayCondition=function(slapface)

    if PaiLianTu_CheckGoodsBoughtCondition(slapface) then
        LuaDebug.info("过滤拍脸图")
        return false;
    end
    

    if slapface.LowLevel~=nil and slapface.LowLevel>0  then
        if  DataMgr.Player.level<slapface.LowLevel then
            return false;
        end
    end
    if slapface.HighLevel~=nil and  slapface.HighLevel>0 then
        if DataMgr.Player.level>slapface.HighLevel  then
            return false;
        end
    end

    if slapface.RegisterTime~=nil and slapface.RegisterTime>0 then
        if DataMgr.Player.registTime<slapface.RegisterTime then
            return false;
        end
    end

    if slapface.LoginTime~=nil and slapface.LoginTime>0 then
        if DataMgr.Player.lastLoginTime<slapface.LoginTime then
            return false;
        end
    end
    local lastTimeStamp=UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid..slapface.ID)

    if slapface.SaturdayView~=nil and slapface.SaturdayView then
        if CheckWeekDay(7) and IsPopByDay(lastTimeStamp) then
            return true;
        end
    end

    if slapface.SundayView~=nil and slapface.SaturdayView then
        if CheckWeekDay(1) and IsPopByDay(lastTimeStamp) then
            return true;
        end
    end
    if lastTimeStamp==0 then return true end;
    if slapface.GapDay==nil or slapface.GapDay==0 then
       return IsPopByDay(lastTimeStamp);
    else

        local nextTimeStamp=lastTimeStamp+(slapface.GapDay+1)*24*60*60;
        local nextDate= os.date("*t",nextTimeStamp);
        local nextDayTimeStamp=os.time({ year = nextDate.year, month = nextDate.month, day = nextDate.day, hour = 0, min = 0, sec = 00 });
        local curTimestamp=LuaMgr.Timestamp();
        return curTimestamp>=nextDayTimeStamp and IsPopByDay(lastTimeStamp);
    end
  
end

local PaiLianTu_CheckPopSlapface=function()
    if NoticeMgr.stopSlapface then return end;
    if NumTool.GetLen(slapfaceList)==0 or PaiLianTu_stop then return end;
    PaiLianTu_stop=true;
    local slapface=slapfaceList[1];
    if not PaiLianTu_CheckPlayCondition(slapface) then
        table.remove(slapfaceList,1);
        PaiLianTu_stop=false;
        if NumTool.GetLen(slapfaceList)==0 then
            LuaMgr.InvokeUIEventListeners(UIEventConst.ClosePopPanel,UIName.NoticeSlapfaceViewModel);
        end
    else
        if slapface.Img==nil or slapface.Img=="" then
            table.remove(slapfaceList,1);
            PaiLianTu_stop=false;
            return;
        end



        LuaMgr.LoadTextureURL(slapface.Img,function(texture)
            if not LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then return end;
            table.remove(slapfaceList,1);
            NoticeMgr.CompleteAD(1,1,slapface.ID);
            LuaMgr.ShowLuaPanel(UIName.NoticeSlapfaceViewModel,slapface.ImgHref,texture,slapface.ID,function(isOn,delayTime)
                if isOn then
                    UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid..slapface.ID,LuaMgr.Timestamp())
                end
                LuaMgr.NextFrame(function()
                    PaiLianTu_stop=false;
                end,45)




            end)
        end)
    end

end


local Update=function()
    PaoMaDeng_CheckPopRollHourse();
    PaiLianTu_CheckPopSlapface();

end

NoticeMgr.SetContinuePaiLian=function()
    PaiLianTu_stop=false;
end


NoticeMgr.CalculateRedData=function(gameScene)
    local redNum_1=0;
    local redNum_2=0;
    local redNum_3=0;
    local msgRedList={}
    local activeRedList={}
    local systemRedList={}
    local key=gameScene==1 and DataMgr.Player.uid or "guest"

    for i,v in ipairs(NoticeMgr.normalNotices[1]) do
        local num=PlayerPrefs.GetInt(key..v.ID)==0 and 1 or 0;
        msgRedList[v.ID]=num;
        redNum_1=redNum_1+num;
    end
    for i,v in ipairs(NoticeMgr.normalNotices[2]) do
        local num=PlayerPrefs.GetInt(key..v.ID)==0 and 1 or 0;
        activeRedList[v.ID]=num;
        redNum_2=redNum_2+num;
    end
    for i,v in ipairs(NoticeMgr.normalNotices[3]) do
        local num=PlayerPrefs.GetInt(key..v.ID)==0 and 1 or 0;
        systemRedList[v.ID]=num;
        redNum_3=redNum_3+num;
    end
    table.insert(NoticeMgr.normalNoticesRed,msgRedList);
    table.insert(NoticeMgr.normalNoticesRed,activeRedList);
    table.insert(NoticeMgr.normalNoticesRed,systemRedList);
    RedMgr.Singleton:UpdateClientRedData("1003_1",redNum_1);
    RedMgr.Singleton:UpdateClientRedData("1003_2",redNum_2);
    RedMgr.Singleton:UpdateClientRedData("1003_3",redNum_3);
    RedMgr.Singleton:UpdateClientRedData("1003",redNum_1+redNum_2+redNum_3);




    if LuaMgr.IsPanelOpen(UIName.MainPageViewModel) then
        RedMgr.Singleton:Refresh();
    end
end

NoticeMgr.ClearRedData=function(type,id,gameScene)
    local key=gameScene==1 and DataMgr.Player.uid or "guest";
    PlayerPrefs.SetInt(key..id,1);
    RedMgr.Singleton:UpdateClientRedData("1003_"..id,0);
    NoticeMgr.normalNoticesRed[type][id]=0;
    local redNum_1=0;
    local redNum_2=0;
    local redNum_3=0;
    for i,v in pairs(NoticeMgr.normalNoticesRed[1]) do
        if v>0 then
            redNum_1=redNum_1+1;
            break;
        end
    end
    for i,v in pairs(NoticeMgr.normalNoticesRed[2]) do
        if v>0 then
            redNum_2=redNum_2+1;
            break;
        end
    end
    for i,v in pairs(NoticeMgr.normalNoticesRed[3]) do
        if v>0 then
            redNum_3=redNum_3+1;
            break;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1003_1",redNum_1);
    RedMgr.Singleton:UpdateClientRedData("1003_2",redNum_2);
    RedMgr.Singleton:UpdateClientRedData("1003_3",redNum_3);
    RedMgr.Singleton:UpdateClientRedData("1003",redNum_1+redNum_2+redNum_3);
    RedMgr.Singleton:Refresh();
end



local FirstMainPage=function()

    LuaMgr.AddUpdate(Update)

end




NoticeMgr.CompleteAD=function(type,status,id)
    local data={
        adtype=type,
        adstatus=status,
        adid=tostring(id),
    }
    local dataJson=json.encode(data)
    local askData={
        event="ad",
        log=dataJson,
    }
    ApiMgr.Request("log_client_event",askData,true,nil,nil,false);
end




NoticeMgr.CompleteNotice=function(id,status,type)
    local data={
        type=type,
        status=status,
        noticeId=id,
        accountId=DataMgr.Player.uid;
    }
    local dataJson=json.encode(data)
    local askData={
        event="completenotice",
        log=dataJson,
    }
    ApiMgr.Request("log_client_event",askData,true,nil,nil,false);
end

NoticeMgr.Clear=function()
    rollList={};
    slapfaceList={};
    PaoMaDeng_stop=false;
    NoticeMgr.normalNotices= {};
    NoticeMgr.normalNoticesRed= nil;
    NoticeMgr.questionnaireData = {}
    if rollhorseKey~=nil then
        coroutine_runner.stop(rollhorseKey);
    end



end


NoticeMgr.Login=function()
    NoticeMgr.Clear();
    PaoMaDeng_stop=false;
    PaiLianTu_stop=false;
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat,NoticeHeartBeat);
    LuaMgr.AddUIEventListener(UIEventConst.HeartBeat,NoticeHeartBeat);

    LuaMgr.RemoveUIEventListener(UIEventConst.FirstMainPage,FirstMainPage);
    LuaMgr.AddUIEventListener(UIEventConst.FirstMainPage,FirstMainPage);
    NoticeMgr.GetQuestionnaireData(HeroRedDataHelper.SetQuestionnaireRed)












    NoticeMgr.Login_UpdateNotices();
end


NoticeMgr.Login_UpdateNotices=function()
    NoticeMgr.stopSlapface=true;
    NoticeMgr.CheckNotice_Types({"pailian","putong","paomadeng","lunbo"},1,function(data)
        if #data>0 then
            local putongList={};
            local pailianList={};
            local paomadengList={};
            local lunboList={};
            for i,v in ipairs(data) do
                if v.Type=="pailian" then
                    table.insert(pailianList,v);
                elseif v.Type=="putong" then
                    table.insert(putongList,v);
                elseif v.Type=="paomadeng" then
                    table.insert(paomadengList,v);
                elseif v.Type=="lunbo" then
                    table.insert(lunboList,v);
                end
            end
            NoticeMgr.HandlerPuTong(putongList);
            NoticeMgr.HandlerPaiLian(pailianList);
            NoticeMgr.HandlerPaomadeng(paomadengList);

        end
    end)
end


NoticeMgr.HandlerPuTong=function(data)
    NoticeMgr.heartData.notice.putong={};
    NoticeMgr.normalNotices= {};
    NoticeMgr.normalNoticesRed= {};
    if #data>0 then
        local systemList={};
        local activeList={};
        local msgList={};
        for i,v in ipairs(data) do
            if v.Tag=="msg" then
                table.insert(msgList,v);
            elseif v.Tag=="system" then
                table.insert(systemList,v);
            elseif v.Tag=="active" then
                table.insert(activeList,v);
            end
            NoticeMgr.heartData.notice.putong[v.ID]=v.UpdateTime;
        end
        table.insert(NoticeMgr.normalNotices,msgList);
        table.insert(NoticeMgr.normalNotices,activeList);
        table.insert(NoticeMgr.normalNotices,systemList);
        NoticeMgr.CalculateRedData(1);

    end

end


NoticeMgr.HandlerPaiLian=function(data)
    for i,v in ipairs(data) do
        if v.Type=="pailian" then
            table.insert(slapfaceList,v);
        end
    end
end


NoticeMgr.HandlerPaomadeng=function(data)
    NoticeMgr.heartData.notice.paomadeng={};
    if #data<=0 then return end;
    rollList={};
    for i,v  in ipairs(data) do
        if v.Type=="paomadeng" then
            table.insert(rollList,v);
            NoticeMgr.heartData.notice.paomadeng[v.ID]=v.UpdateTime;
        end
    end
end


NoticeMgr.HandlerLunBo=function(data)
    NoticeMgr.heartData.notice.lunbo={};
    NoticeMgr.lunboData=data;
    if #data>0 then
        for i,v in ipairs(data) do
            NoticeMgr.heartData.notice.lunbo[v.ID]=v.UpdateTime;
        end
    end
end



NoticeMgr.CheckGuestNotice=function()
    NoticeMgr.normalNotices={};
    NoticeMgr.normalNoticesRed={}
    local tingfu={};
    local systemList={};
    local activeList={};
    local msgList={};
    NoticeMgr.CheckNotice_Types({"tingfu","putong"},2,function(data)
        if not LuaMgr.IsPanelOpen("Laigu.ViewModel.Intro.IntroPanelViewModel") then
            return
        end;
        if  #data>0 then
            for i,v in ipairs(data) do
                if v.Type=="tingfu" then
                    table.insert(tingfu,v);
                elseif v.Type=="putong" then
                    if v.Tag=="system" then
                        table.insert(systemList,v);
                    elseif v.Tag=="active" then
                        table.insert(activeList,v);
                        elseif v.Tag=="msg" then
                        table.insert(msgList,v);
                    end
                end
            end
            local re=#activeList>0 or #systemList>0 or #msgList>0;
            if re then
                table.insert(NoticeMgr.normalNotices,msgList);
                table.insert(NoticeMgr.normalNotices,activeList);
                table.insert(NoticeMgr.normalNotices,systemList);
                NoticeMgr.CalculateRedData(2);
            end
            if #tingfu>0 then
                local title=tingfu[1].Title;
                local content=tingfu[1].Contents;
                LuaMgr.ShowLuaPanel(UIName.NoticeTipViewModel,title,content,nil);
            else
                local isPop=false;
                for i,v in ipairs(activeList) do
                    if v.PopupType==1 then
                        isPop=true;
                        break;
                    end
                end

                for i,v in ipairs(systemList) do
                    if v.PopupType==1 then
                        isPop=true;
                        break;
                    end
                end
                if isPop then
                    LuaMgr.ShowLuaPanel(UIName.NoticeNormalViewModel,2,"guest");
                end
            end
        end
    end);

end


NoticeMgr.Init=function()
    PaoMaDeng_stop=false;
    serverList=json.decode(LuaMgr.serverList);
    NoticeMgr.serverTimeStamp=tonumber(serverList.data.Time);
    if LuaMgr.selectServer~=nil then
        dev=LuaMgr.selectServer;
    else
        dev=serverList.data.CurrentSvr.ID;
    end
    print("notice dev=========================>:"..dev);
    baseUrl=LuaMgr.GetServerBaseUrl();
    channel=LuaMgr.GetChanel();



end

NoticeMgr.AddEventListener=function()
    LuaMgr.RemoveUIEventListener(UIEventConst.CheckNoticeTip,NoticeMgr.CheckGuestNotice);
    LuaMgr.AddUIEventListener(UIEventConst.CheckNoticeTip,NoticeMgr.CheckGuestNotice);
end




return NoticeMgr;
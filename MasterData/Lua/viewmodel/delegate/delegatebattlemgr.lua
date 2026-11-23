





local delegateCount=0;
local battleType=nil;
local curDelegateCount=0;
local settlementData=nil;
local members=nil;;
local dungeonId=nil;
local coroutineKey=nil;
local dataList=nil;
local lastTimestamp=nil;

DelegateBattleMgr={
    repLogData={},
    enterDuneonParams={};
    formationId=nil;
    timeScale=nil;
    dungeonId=nil,
    preExp=nil,
    preLevel=nil,
}


local function EnterBattle()
    local askData={activeInfo={},members={},extraParams=nil};
    local c_Data=BattlePrepareMgr._enterDungeonParams;

    local repLogMembers={};
    local logCharacters=DelegateBattleMgr.repLogData.Data.Characters
    local index=0;
    for i,v in pairs(logCharacters) do
        repLogMembers[tostring(index)]=i;
        index=index+1;
    end
    
    askData.eventId=c_Data.eventId;
    askData.dungeonId=c_Data.dungeonId;
    askData.teamId="";
    askData.members=repLogMembers;
    askData.isActive=c_Data.isActive;
    askData.count=delegateCount;
    if c_Data.activeInfo ~= nil then
        if c_Data.activeInfo.Count == 0 then
            askData.activeInfo=nil;
        else
            askData.activeInfo.activeId = c_Data.activeInfo.activeId;
            askData.activeInfo.dailyActiveId = c_Data.activeInfo.dailyActiveId;
        end
    end

    if c_Data.extraParams ~= nil then
        if #c_Data.extraParams == 0 then
            askData.extraParams=nil;
        else
            for i,v in pairs(c_Data.extraParams) do
                table.insert(askData.extraParams,v);
            end
        end
    end
    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon",askData,true,function(result)
        local data=json.decode(result)
        members=data.result.members;
        dungeonId=data.result.dungeonId
        local reString=json.encode(data.result);
        LuaMgr.SceneSwitchMark();
        LuaMgr.EnterBattle(reString, DelegateBattleMgr.formationId);
    end,function(failCode) 
        print("EnterDungeonError,ErrorCode:",failCode);
    end,true);
end


local function CheckAcrossDay()
    local re=false;
    local curTimeStamp=LuaMgr.Timestamp();
    local date=os.date("*t",curTimeStamp);
    local zeroTimeStamp=os.time({day=date.day,month=date.month,year=date.year,hour=4,minute=0,second=0})
    if lastTimestamp<zeroTimeStamp and curTimeStamp>=zeroTimeStamp then
        re=true;
    else
        re=false;
    end
    lastTimestamp=curTimeStamp;
    return re;
end



local function StartBattle()
    if curDelegateCount>=delegateCount then
        DelegateBattleMgr.Clear();
        return;
    end
    if battleType==BattleType.Daily or battleType==BattleType.HZJ then
        if CheckAcrossDay() then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("DelegateBattleMgr_0"));
            DelegateBattleMgr.Clear();
            return;
        end

    end

curDelegateCount=delegateCount;
    EnterBattle();
end

function DelegateBattleMgr.Init(repLogData)
    DelegateBattleMgr.repLogData=repLogData
    DelegateBattleMgr.dungeonId=repLogData.DungeonId
    DelegateBattleMgr.preExp=DataMgr.Player.exp;
    DelegateBattleMgr.preLevel=DataMgr.Player.level;

end


function DelegateBattleMgr.Start(count)
    lastTimestamp=LuaMgr.Timestamp();
    curDelegateCount=0;
    delegateCount=count;
    settlementData ={items={},equipments={}};
    members={};
    dataList={};
    battleType=LuaMgr.GetAreaBattleType();
    LuaMgr.SetAreaBattleType(BattleType.Delegate);
    StartBattle();
end


function DelegateBattleMgr.Clear()
        LuaMgr.SetAreaBattleType(battleType);
        delegateCount=0;
        curDelegateCount=0;
        battleType=nil
        members=nil;
        settlementData =nil;
        dungeonId=nil;
        dataList=nil;
        lastTimestamp=nil;
        DelegateBattleMgr.formationId=nil;
        DelegateBattleMgr.enterDuneonParams=nil;
        DelegateBattleMgr.timeScale=nil;
        DelegateBattleMgr.repLogData=nil;
        DelegateBattleMgr.preLevel=nil;
        DelegateBattleMgr.preExp=nil
end



function DelegateBattleMgr.GetDelegateTotalCount()
    return delegateCount;
end


function DelegateBattleMgr.GetDelegateRemainCount()
    return delegateCount-curDelegateCount;
end


function DelegateBattleMgr.GetRewards()
    return settlementData;
end


return DelegateBattleMgr;
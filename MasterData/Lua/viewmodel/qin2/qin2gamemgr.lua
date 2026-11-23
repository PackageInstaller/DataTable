Qin2GameMgr = {
    Board={},
    tarImg=nil;
    otherImgList={};
freeBlockList={};
busyBlockList={};
    constants={};
    gameState=nil;
};

local GameState={
Nor=1,
Fast=2,
}
local interval=nil;
local coKeyGame=nil;
local time=0;
local blockIndex=0;
local hitCount=0;
local durHitCount=0;
local delayClose=1;
local isGameEnd=nil;
local isPauseGame=false;


Qin2GameMgr.InitLetterGame=function(num)
    Qin2GameMgr.Board={}
    for i=1,num,1 do
        table.insert(Qin2GameMgr.Board,{
            loc=i,
            vm=nil;
        })
    end
end


Qin2GameMgr.BindUIList=function(UIList,tarImg,otherImgList)
    for i,v in ipairs(Qin2GameMgr.Board) do
        v.vm=UIList.itemList[v.loc];
    end
    Qin2GameMgr.tarImg=tarImg;
    Qin2GameMgr.otherImgList=otherImgList;
    Qin2GameMgr.constants=ConfigMgr.Config.TourConstants;
    blockIndex=1;
    hitCount=0;
    durHitCount=0;
    isGameEnd=false;
    isPauseGame=false;
    Qin2GameMgr.freeBlockList=Qin2GameMgr.Board;
    Qin2GameMgr.busyBlockList={};
    Qin2GameMgr.SwitchGameState(GameState.Nor);
end


Qin2GameMgr.ReStartGame=function()
    blockIndex=1;
    hitCount=0;
    durHitCount=0;
    isGameEnd=false;
    isPauseGame=false;
    Qin2GameMgr.SwitchGameState(GameState.Nor);
    Qin2GameMgr.StartGame();
end


Qin2GameMgr.StartGame=function()
    time=0;
    math.randomseed(LuaMgr.Timestamp());
    coKeyGame=coroutine_runner.start(function()
        coroutine_runner.wait(1);
        while(true) do
            if isGameEnd then
                break
            end
            if not isPauseGame then
                Qin2GameMgr.UpdateBoard();
            end
            coroutine_runner.waitForEndOfFrame();
        end
    end);
end


Qin2GameMgr.IsGameFastState=function()
    return Qin2GameMgr.gameState==GameState.Fast;
end

Qin2GameMgr.SetGamePause=function(isPause)
    isPauseGame=isPause;
end


Qin2GameMgr.GetHitCount=function()
    return hitCount;
end


Qin2GameMgr.GetDurHitCount=function()
    return durHitCount;
end


Qin2GameMgr.CheckHitCount=function(blockValue)
    if blockValue==nil then
        return false,false
    end
    if blockValue~=Qin2GameMgr.tarImg then
        durHitCount=0;
        return false,false;
    end
    hitCount=hitCount+1;
    durHitCount=durHitCount+1;
if durHitCount==Qin2GameMgr.constants.RightTimes then
        Qin2GameMgr.SwitchGameState(GameState.Fast);
        return true,true;
    else
        return true,false;
    end
end

Qin2GameMgr.SwitchGameState=function(state)
    Qin2GameMgr.gameState=state;
    if state==GameState.Nor then
        interval=Qin2GameMgr.constants.OpenTime/10;
        delayClose=1.5;
    else
        interval=Qin2GameMgr.constants.FastopenTime/10;
        delayClose=1.5;
    end
    if state==GameState.Fast then
        Qin2GameMgr.ClearBoard();
        table.sort(Qin2GameMgr.Board,function(a, b) return a.loc<b.loc end)
    end
    Qin2GameMgr.freeBlockList=Qin2GameMgr.Board;
end

Qin2GameMgr.ExitFastState=function()
    durHitCount=0;
    Qin2GameMgr.SwitchGameState(GameState.Nor);
end


Qin2GameMgr.UpdateBoard=function()
    if UnityEngine.Time.realtimeSinceStartup-time>interval then
        time=UnityEngine.Time.realtimeSinceStartup;
        local tarBlockMap={};
        local count=Qin2GameMgr.GetBlockCount();
        for i=1,count,1 do
            local tarBlock =Qin2GameMgr.GetFreeBlock()
            tarBlockMap[tostring(tarBlock.loc)]=tarBlock;
        end
        for i,v in pairs(tarBlockMap) do
            v.vm:Show(Qin2GameMgr.GetBlockValue(),delayClose);
        end
    end
end


Qin2GameMgr.GetBlockValue=function()

    if Qin2GameMgr.gameState==GameState.Fast then
        return Qin2GameMgr.tarImg;
    end

    local sucProbabilityList=Qin2GameMgr.constants.RightProbability
    local index=blockIndex;
    if index>#sucProbabilityList then index=#sucProbabilityList end;
    local sucNum=sucProbabilityList[index];
    local randomIndex=math.random(100);
    blockIndex=blockIndex+1;

    if randomIndex<=sucNum then
        return Qin2GameMgr.tarImg;
    else

        local firstRandom=math.random(100)
        if firstRandom<=50 then
            return Qin2GameMgr.otherImgList[1];
        else
            return Qin2GameMgr.otherImgList[2];
        end
    end
    
end


Qin2GameMgr.GetBlockCount=function()
    if Qin2GameMgr.gameState==GameState.Fast then

        return 1;
    end
    local probability=Qin2GameMgr.constants.OpenProbability
    local count=math.floor(probability[1]/(probability[1]+probability[2])*100)
    local tarNum=math.random(100)
    return tarNum<=count and 1 or 2;
end


Qin2GameMgr.ClearBoard=function()
    if IsNull(Qin2GameMgr.busyBlockList) or #Qin2GameMgr.busyBlockList==0 then
        return
    end
    for i=#Qin2GameMgr.busyBlockList,1,-1 do
        local busyItem=Qin2GameMgr.busyBlockList[i];
        busyItem.vm:Close(true);
        table.insert(Qin2GameMgr.freeBlockList,busyItem);
        table.remove(Qin2GameMgr.busyBlockList,i)
    end
end


Qin2GameMgr.ClearBoardByLoc=function(blockLoc)
    if #Qin2GameMgr.busyBlockList>0 then
        for i=#Qin2GameMgr.busyBlockList,1,-1 do
            local busyItem=Qin2GameMgr.busyBlockList[i];
            if busyItem.loc==blockLoc  then
                busyItem.vm:Close();
                table.insert(Qin2GameMgr.freeBlockList,busyItem);
                table.remove(Qin2GameMgr.busyBlockList,i)
            end
        end
    end
end



Qin2GameMgr.GetFreeBlock=function()
    if #Qin2GameMgr.freeBlockList==0 then
        return nil;
    end
    local index=1;
    if Qin2GameMgr.gameState==GameState.Nor then
        index=math.random(#Qin2GameMgr.freeBlockList);
    end
    local busyBlock= Qin2GameMgr.freeBlockList[index]
    table.remove(Qin2GameMgr.freeBlockList,index);
    table.insert(Qin2GameMgr.busyBlockList,busyBlock);
    return busyBlock;
end


Qin2GameMgr.GameOver=function()
    Qin2GameMgr.Board={}
    Qin2GameMgr.freeBlockList={}
    Qin2GameMgr.busyBlockList={};
    Qin2GameMgr.constants={};
    isGameEnd=true;
    if coKeyGame~=nil then
        coroutine_runner.stop(coKeyGame);
    end
end

return Qin2GameMgr;
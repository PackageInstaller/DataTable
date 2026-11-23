MiniGame2048GamePlayFrameWorkBuff={};
MiniGame2048GamePlayFrameWorkBuff.PrivateGetBaseRunBuff=function ()
    local buff={};
    buff.buffId="";
    buff.type=0;
buff.remainTime=0;
buff.remainTriggerTime=-1;
buff.triggerTime=-1;
buff.saveParams={};
buff.sendParams={};
    return buff;
end

MiniGame2048GamePlayFrameWorkBuff.GetImmediateRunBuff=function (buffId,target,extraParams,sendParams)
    local buff=MiniGame2048GamePlayFrameWorkBuff.PrivateGetBaseRunBuff();
    buff.target=target;
    buff.extraParams=extraParams;
    buff.buffId=buffId;
    buff.type=0;
    buff.sendParams=sendParams;
    return buff;
end

MiniGame2048GamePlayFrameWorkBuff.GetTimeTriggerRunBuff=function (buffId,target,extraParams,remainTime,triggerTime,sendParams)
    local buff=MiniGame2048GamePlayFrameWorkBuff.PrivateGetBaseRunBuff();
    buff.target=target;
    buff.extraParams=extraParams;
    buff.buffId=buffId;
    buff.type=1;
    buff.remainTime=remainTime;
    buff.remainTriggerTime=triggerTime;
    buff.triggerTime=triggerTime;
    buff.sendParams=sendParams;
    return buff;
end




MiniGame2048GamePlayFrameWorkBuff.AddBuffToTarget=function (target,buffId,extraParams,sendParams)
    if target.gameplayBuffList==nil or type(target.gameplayBuffList)~="table" then
        print("AddBuff Error,Target is not have a gameplayBuffList Attritubation")
        return;
    end
    if MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffId]~=nil then
        local buffData=MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffId];
if buffData.type==0  then
            local buff=MiniGame2048GamePlayFrameWorkBuff.GetImmediateRunBuff(buffId,target,extraParams,sendParams)
            MiniGame2048GamePlayFrameWorkBuff.RunImmediateBuffAction(buff);
        elseif buffData.type==1 then
            local remainTime=tonumber(sendParams[1]);
            local triggerTime=tonumber(sendParams[2]);
            local buff=MiniGame2048GamePlayFrameWorkBuff.GetTimeTriggerRunBuff(buffId,target,extraParams, remainTime,triggerTime,sendParams);
            MiniGame2048GamePlayFrameWorkBuff.RunFirstBuffAction(buff);
            table.insert(target.gameplayBuffList,buff);
        end
    else
        print("AddBuff Error,buffId is error")
    end
end

MiniGame2048GamePlayFrameWorkBuff.CheckBuff=function (target)
    if target.gameplayBuffList==nil or type(target.gameplayBuffList)~="table" then
        print("CheckBuff Error,Target is not have a gameplayBuffList Attritubation")
        return;
    end
    local removeIndexList={};
    for index, value in ipairs(target.gameplayBuffList) do
if value.remainTime~=-1 then
            value.remainTriggerTime=value.remainTriggerTime-1;
            value.remainTime=value.remainTime-1;
            if value.remainTriggerTime<=0 then
                MiniGame2048GamePlayFrameWorkBuff.RunTriggerBuffAction(value);
                value.remainTriggerTime=value.triggerTime;
            end
            if value.remainTime<=0 then
                table.insert(removeIndexList,index);
            end
        end
    end
for i = #removeIndexList, 1, -1 do
        MiniGame2048GamePlayFrameWorkBuff.RunEndBuffAction(target.gameplayBuffList[removeIndexList[i]]);
        table.remove(target.gameplayBuffList,removeIndexList[i]);
    end
end

MiniGame2048GamePlayFrameWorkBuff.RunImmediateBuffAction=function (buffTable)
    if MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffTable.buffId].operateFunction.firstAddFun~=nil then
        MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffTable.buffId].operateFunction.firstAddFun(buffTable.target,buffTable.extraParams,buffTable.sendParams);
    end
end

MiniGame2048GamePlayFrameWorkBuff.RunFirstBuffAction=function (buffTable)
    if MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffTable.buffId].operateFunction.firstAddFun~=nil then
        MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffTable.buffId].operateFunction.firstAddFun(buffTable.target,buffTable.extraParams,buffTable.sendParams);
    end
end

MiniGame2048GamePlayFrameWorkBuff.RunTriggerBuffAction=function (buffTable)
    if MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffTable.buffId].operateFunction.triggerBuffFun~=nil then
        MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffTable.buffId].operateFunction.triggerBuffFun(buffTable.target,buffTable.extraParams,buffTable.sendParams);
    end
end

MiniGame2048GamePlayFrameWorkBuff.RunEndBuffAction=function (buffTable)
    if MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffTable.buffId].operateFunction.endAddFun~=nil then
        MiniGame2048GamePlayFrameWorkBuff.BuffTable[buffTable.buffId].operateFunction.endAddFun(buffTable.target,buffTable.extraParams,buffTable.sendParams);
    end
end

MiniGame2048GamePlayFrameWorkBuff.BuffTable={
    ["ImmediateTransformOtherBlock"]={
buffId="ImmediateTransformOtherBlock",
type=0,
sendParams={},
operateFunction={
firstAddFun=function (target,extraParams,sendParams)
                if sendParams[1]=="nil" then
                    sendParams[1]=nil;
                end
                target:SetNumberData(sendParams[1]);

                MiniGame2048GamePlayFrameWorkMgr.AddNowMergeBlock(sendParams[1]);
            end,
        }
    },
["FreezeBlock"]={
buffId="FreezeBlock",
type=1,
sendParams={},
operateFunction={
firstAddFun=function (target,extraParams,sendParams)
                target.gameplayBuffAttribute["isFreeze"]=true;
            end,
            triggerBuffFun=nil,
            endAddFun=function (target,extraParams,sendParams)
                target.gameplayBuffAttribute["isFreeze"]=false;
            end,
        }
    },
["NotMerge"]={
buffId="NotMerge",
type=1,
sendParams={},
operateFunction={
firstAddFun=function (target,extraParams,sendParams)
                target.gameplayBuffAttribute["NotMerge"]=true;
            end,
            triggerBuffFun=nil,
            endAddFun=function (target,extraParams,sendParams)
                target.gameplayBuffAttribute["NotMerge"]=false;
            end,
        }
    },
["NotPlayNormalGC"]={
buffId="NotPlayNormalGC",
type=1,
sendParams={},
operateFunction={
firstAddFun=function (target,extraParams,sendParams)
            target.gameplayBuffAttribute["NotPlayNormalGC_"..sendParams[3]]=true;
        end,
        triggerBuffFun=nil,
        endAddFun=function (target,extraParams,sendParams)
            target.gameplayBuffAttribute["NotPlayNormalGC_"..sendParams[3]]=false;
        end,
        }
    },
["ForceMove"]={
buffId="ForceMove",
type=1,
sendParams={},
operateFunction={
firstAddFun=function (target,extraParams,sendParams)
            target.gameplayBuffAttribute["ForceMove_"..sendParams[3]]=true;
        end,
        triggerBuffFun=nil,
        endAddFun=function (target,extraParams,sendParams)
            target.gameplayBuffAttribute["ForceMove_"..sendParams[3]]=false;
        end,
        }
    },
};
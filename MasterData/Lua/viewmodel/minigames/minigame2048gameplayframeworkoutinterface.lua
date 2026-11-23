
MiniGame2048GamePlayFrameWorkOutInterface={};
MiniGame2048GamePlayFrameWorkOutInterface.GetOutInterface=function (name)
    if IsNullOrEmpty(name) then
        LuaDebug.error("2048策划配置表错误，操作配置错误");
        return nil;
    else
        return MiniGame2048GamePlayFrameWorkOutInterface.OutInterface[name];
    end
end

MiniGame2048GamePlayFrameWorkOutInterface.OutInterface={
["ImmediateTransformOtherBlock"]=function (target,params)
MiniGame2048GamePlayFrameWorkBuff.AddBuffToTarget(target,"ImmediateTransformOtherBlock",{},params)
    end,
[""]=nil,
["AddScore"]=function (target,params)
        MiniGame2048GamePlayFrameWorkMgr.AddNowScore(tonumber(params[1]));
    end,
["ForverFreezeBlock"]=function (target,params)
MiniGame2048GamePlayFrameWorkBuff.AddBuffToTarget(target,"FreezeBlock",{},{-1,-1})
    end,
["DonotPlayNormalGamePlayCue"]=function (target,params)
MiniGame2048GamePlayFrameWorkBuff.AddBuffToTarget(target,"NotPlayNormalGC",{},{1,-1,params[1]})
    end,
["ForceMove"]=function (target,params)
MiniGame2048GamePlayFrameWorkBuff.AddBuffToTarget(target,"ForceMove",{},{1,-1,params[1]})
    end,
["PlayImmediateGamePlayCue"]=function (target,params)
        MiniGame2048GamePlayFrameWorkGamePlayCueMgr.AddGamePlayCue(target,params[1]);
    end,
["PlayBeforeQueueGamePlayCue"]=function (target,params)
        MiniGame2048GamePlayFrameWorkGamePlayCueMgr.AddBeforeGamePlayCue(target,params[1]);
    end,
["PlayImmediateSoundCue"]=function (target,params)
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/"..params[1]..".mp3");
    end,
}


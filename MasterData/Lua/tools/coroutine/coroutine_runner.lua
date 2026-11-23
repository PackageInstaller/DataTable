




local util = require "Tools/Coroutine/util"

local gameobject = CS.UnityEngine.GameObject('Coroutine_Runner')
CS.UnityEngine.Object.DontDestroyOnLoad(gameobject)
local cs_coroutine_runner = gameobject:AddComponent(typeof(CS.Coroutine_Runner))

local coKey=0;
coroutine_runner={};




function coroutine_runner.start(...)
    if IsObjectNull(cs_coroutine_runner) then
        return nil;
    end
    local co=util.cs_generator(...);
    coKey=coKey+1;
    cs_coroutine_runner:Start_Coroutine(coKey,co);
    return coKey;
end

function coroutine_runner.wait(seconds)
    coroutine.yield(UnityEngine.WaitForSeconds(seconds));
end

function coroutine_runner.waitForEndOfFrame()
    coroutine.yield(UnityEngine.WaitForEndOfFrame());
end

function coroutine_runner.WaitUntil(fun)
    coroutine.yield(UnityEngine.WaitUntil(fun))
end

function coroutine_runner.stop(coKey)



    if IsObjectNull(cs_coroutine_runner) then
        return nil;
    end
    local key=tonumber(coKey);
    cs_coroutine_runner:Stop_Coroutine(key);
end


function coroutine_runner.stopAll()
    if IsObjectNull(cs_coroutine_runner) then
        return ;
    end
    cs_coroutine_runner:StopAll_Coroutine();
end

function coroutine_runner.checkIsDestory()
    return IsObjectNull(gameobject);
end

return coroutine_runner;





















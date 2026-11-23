Qin2EventMgr = {
  
};



Qin2EventMgr.CheckFinishAreaEvents=function(areaEvent)
    local finishCount=Qin2EventMgr.GetFinishEventCountByArea(areaEvent);
    return finishCount>=#areaEvent;
end


Qin2EventMgr.CheckFinishWheeEvents=function(area)

    if IsNull(DataMgr.Player.tour.scenicEvent) or DataMgr.Player.tour.scenicEvent[area.Id]==nil then
        return true;
    end
    if IsNull(DataMgr.Player.tour.finishEvent) then
        return false;
    end
    local scenicEvent=DataMgr.Player.tour.scenicEvent[area.Id];
    for i,v in pairs(scenicEvent) do
        if DataMgr.Player.tour.finishEvent[i]==nil then
            return false
        end
    end
    return true;
end


Qin2EventMgr.CheckFinishEventById=function(eventId)
    return not IsNull(DataMgr.Player.tour.finishEvent) and DataMgr.Player.tour.finishEvent[eventId]~=nil
end



Qin2EventMgr.GetFinishEventCountByArea=function(areaEvent)
    if IsNull(DataMgr.Player.tour.finishEvent) then
        return 0;
    end
    local finishCount=0;
    for i,v in ipairs(areaEvent) do
        if DataMgr.Player.tour.finishEvent[v]~=nil then
            finishCount=finishCount+1;
        end
    end
    return finishCount;
end


Qin2EventMgr.TourGetReward=function(eventId,cost,callBack)
    local askData={ID=eventId,Cost=cost}
    ApiMgr.Request("tour/get_reward",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        if callBack~=nil then
            callBack();
        end
    end,nil,true);
end


Qin2EventMgr.TourRefreshEvent=function(areaID,callBack)
    local askData={ID=areaID}
    ApiMgr.Request("tour/refresh_event",askData,true,function(result)
        if callBack~=nil then
            callBack();
        end
    end,nil,true);
end

return Qin2EventMgr;
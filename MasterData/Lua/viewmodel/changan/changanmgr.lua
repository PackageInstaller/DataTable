




ChanganMgr={
    changanMapList={},
    changanMapEventList={},
    changanNovelEventList={},
    changanShopQuestEventList={},
    changanShopCollectTask=nil;
    changanShopCollect=nil;
    changanTaskQuestEventList={},
    changanAppraisalQuestEventList={},
    init=false;
    
}

ChanganMgr.InitData=function()
    if ChanganMgr.init then return end;
    ChanganMgr.init=true;
    ChanganMgr.changanMapList={}
    local changan,changan2,changan3,changan4={},{},{},{}
    for i,v in pairs(ConfigMgr.Config.activityMapGroupList) do
        if v.area=="changan"  then
            table.insert(changan,v);
        elseif v.area=="changan2" then
            table.insert(changan2,v);
        elseif v.area=="changan3"  then
            table.insert(changan3,v);
        elseif v.area=="changan4"  then
            table.insert(changan4,v);
        end
    end
    table.insert(ChanganMgr.changanMapList,changan)
    table.insert(ChanganMgr.changanMapList,changan2)
    table.insert(ChanganMgr.changanMapList,changan3)
    table.insert(ChanganMgr.changanMapList,changan4)
    
    ChanganMgr.changanNovelEventList={};
    ChanganMgr.changanMapEventList={}
    local changanEvent,changanEvent2,changanEvent3,changanEvent4={},{},{},{}
    for i,v in pairs(ConfigMgr.Config.activityMapEventList) do
        if v.area=="changan" and v.type==1 then
            table.insert(ChanganMgr.changanNovelEventList,v);
        end 
        if v.area=="changan" and v.type==2 then
            table.insert(changanEvent,v);
        elseif v.area=="changan2" and v.type==2 then
            table.insert(changanEvent2,v);
        elseif v.area=="changan3" and v.type==2 then
            table.insert(changanEvent3,v);
        elseif v.area=="changan4" and v.type==2 then
            table.insert(changanEvent4,v);
        end
    end
    table.insert(ChanganMgr.changanMapEventList,changanEvent)
    table.insert(ChanganMgr.changanMapEventList,changanEvent2)
    table.insert(ChanganMgr.changanMapEventList,changanEvent3)
    table.insert(ChanganMgr.changanMapEventList,changanEvent4)
    
    
    ChanganMgr.changanShopQuestEventList={}
    ChanganMgr.changanTaskQuestEventList={}
    ChanganMgr.changanAppraisalQuestEventList={}
    ChanganMgr.changanShopCollectTask=nil;
    ChanganMgr.changanShopCollectTask=nil;

    for i,v in pairs(ConfigMgr.Config.questEvent) do
        if v.text=="CAappraisal" then
            table.insert(ChanganMgr.changanAppraisalQuestEventList,v);
        elseif v.text=="CAshop" then
            table.insert(ChanganMgr.changanShopQuestEventList,v);
        elseif v.text=="CAtask" then
            table.insert(ChanganMgr.changanTaskQuestEventList,v);
        elseif v.text=="CAshop1" then
            ChanganMgr.changanShopCollectTask=v;
        elseif v.text=="CAshop2" then
            ChanganMgr.changanShopCollect=v;
        end
    end
    
end

ChanganMgr.Clear=function()
    ChanganMgr.changanMapList=nil
    ChanganMgr.changanMapEventList=nil
    ChanganMgr.changanNovelEventList=nil
    ChanganMgr.changanShopQuestEventList=nil
    ChanganMgr.changanShopCollectTask=nil
    ChanganMgr.changanShopCollect=nil
    ChanganMgr.changanTaskQuestEventList=nil
    ChanganMgr.changanAppraisalQuestEventList=nil
    ChanganMgr.init=false;
end

return ChanganMgr;
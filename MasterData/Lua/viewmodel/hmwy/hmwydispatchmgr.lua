
HMWYDispatchMgr = {
    settlementMap={};
    dispatchCallBack=nil;
}


HMWYDispatchMgr.GetDispatchHeroDataList=function(hotHeroList)
    local heroDataList={};
    local HMWYGame=DataMgr.Player.HMWYGame;
    local rareList=ConfigMgr.Config.HmwyDispatchConstants.Rare;
    for i,v in pairs(ConfigMgr.Config.HmwyRelicStatsMap) do
        local cfgHero=ConfigMgr.Config.characterTable[v.Id]
        local lockId=nil;
        if not IsNull(HMWYGame.Locks) and  HMWYGame.Locks[v.Id]~=nil then
            lockId=HMWYGame.Locks[v.Id];
        end
        local charData=nil;
        if not IsNull(HMWYGame.Chars) and HMWYGame.Chars[v.Id]~=nil then
            charData=HMWYGame.Chars[v.Id];
        end
        local isBuyHero= not IsNull(HMWYGame.BuyChars) and HMWYGame.BuyChars[v.Id]~=nil
        if cfgHero~=nil then
            local heroItem={
                id=v.Id,
                name=LuaMgr.GetLangText(cfgHero.namelan);
                unlock=DataMgr.Player.characters[v.Id]~=nil or isBuyHero or NumTool.FindIndex(rareList,cfgHero.rare)>0;
                lockByEventId=lockId;
                level=charData~=nil and charData.Level or 1;
                exp=charData~=nil and charData.Exp or 0;
                isHot=NumTool.FindIndex(hotHeroList,v.Id)>0;
            }
            table.insert(heroDataList,heroItem);
        end
    end

    table.sort(heroDataList, function(a, b)
        if a.unlock and b.unlock then
            if a.lockByEventId==nil and b.lockByEventId==nil then
                if a.isHot~=b.isHot then
                    return a.isHot
                else
                    return a.level > b.level
                end
            end
            return a.lockByEventId==nil and b.lockByEventId~=nil;
        end
        return a.unlock and not b.unlock;










    end)
    return heroDataList
end

HMWYDispatchMgr.CalculateTechTree=function()
    local techTree=nil;
    local treeType3List={}
    for i,v in pairs(ConfigMgr.Config.HmwyTechTreeMap) do
        if v.Type==3 then
            table.insert(treeType3List,v);
        end
    end
    table.sort(treeType3List,function(a, b) return tonumber(a.Id)>tonumber(b.Id) end)
    for i,v in ipairs(treeType3List) do
        if not IsNull(DataMgr.Player.HMWYGame.TechTree) and DataMgr.Player.HMWYGame.TechTree[v.Id]~=nil then
            techTree=v;
            break;
        end
    end
    if techTree==nil then
        return 0;
    end
    return techTree.Parameter/10000;
end


HMWYDispatchMgr.CalculateRewardAdd_TechTreeType4=function()
    local techTree=nil;
    local treeType4List={}
    for i,v in pairs(ConfigMgr.Config.HmwyTechTreeMap) do
        if v.Type==4 then
            table.insert(treeType4List,v);
        end
    end
    table.sort(treeType4List,function(a, b) return tonumber(a.Id)>tonumber(b.Id) end)
    for i,v in ipairs(treeType4List) do
        if not IsNull(DataMgr.Player.HMWYGame.TechTree) and DataMgr.Player.HMWYGame.TechTree[v.Id]~=nil then
            techTree=v;
            break;
        end
    end
    if techTree==nil then
        return 0;
    end
    return techTree.Parameter/10000;
end


HMWYDispatchMgr.CalculateRewardAdd_TechTreeType6=function()
    local techTree=nil;
    local treeType6List={}
    for i,v in pairs(ConfigMgr.Config.HmwyTechTreeMap) do
        if v.Type==6 then
            table.insert(treeType6List,v);
        end
    end
    table.sort(treeType6List,function(a, b) return tonumber(a.Id)>tonumber(b.Id) end)
    for i,v in ipairs(treeType6List) do
        if not IsNull(DataMgr.Player.HMWYGame.TechTree) and DataMgr.Player.HMWYGame.TechTree[v.Id]~=nil then
            techTree=v;
            break;
        end
    end
    if techTree==nil then
        return 0;
    end
    return techTree.Parameter/10000;
end



HMWYDispatchMgr.CalculateDispatchRate=function(heroList,eventId)
    local mergeAttr=HMWYDispatchMgr.CalculateDispatchHeroListAttr(heroList,eventId);
    local resultRate=mergeAttr[1]*mergeAttr[2]+mergeAttr[2]*mergeAttr[3]+mergeAttr[3]*mergeAttr[4]+mergeAttr[4]*mergeAttr[5]+
            mergeAttr[5]*mergeAttr[6]+mergeAttr[6]*mergeAttr[1]




    resultRate=resultRate/#mergeAttr;
    local SUCRate=ConfigMgr.Config.HmwyDispatchConstants.SucRate
    local rateIndex=0;
    for i,v in ipairs(SUCRate) do
        if resultRate*10000>=v then
            rateIndex=rateIndex+1;
        end
    end
    return rateIndex,resultRate;
end


HMWYDispatchMgr.CalculateDispatchHeroListAttr=function(heroList,eventId)
    local mergeAttr={0,0,0,0,0,0};

    local techTreeRate=HMWYDispatchMgr.CalculateTechTree();
    for i,v in ipairs(heroList) do
        local attrList=HMWYDispatchMgr.GetHeroAttrList(v);
        if #attrList>0 then
            for j=1,#mergeAttr,1 do
                mergeAttr[j]=mergeAttr[j]+attrList[j]*(1+techTreeRate);
            end
        end
    end
    local cfgEventAttr=ConfigMgr.Config.HmwyDispatchEventCheckMap[eventId];
    mergeAttr[1] =HMWYDispatchMgr.CheckAttrMAXRate(mergeAttr[1]/cfgEventAttr.Patience)

    mergeAttr[2]=HMWYDispatchMgr.CheckAttrMAXRate(mergeAttr[2]/cfgEventAttr.Speed)

    mergeAttr[3]=HMWYDispatchMgr.CheckAttrMAXRate(mergeAttr[3]/cfgEventAttr.Cooperation)

    mergeAttr[4]=HMWYDispatchMgr.CheckAttrMAXRate(mergeAttr[4]/cfgEventAttr.Professional)

    mergeAttr[5]=HMWYDispatchMgr.CheckAttrMAXRate(mergeAttr[5]/cfgEventAttr.Courage)

    mergeAttr[6]=HMWYDispatchMgr.CheckAttrMAXRate(mergeAttr[6]/cfgEventAttr.Optimism)
    return mergeAttr;
end

HMWYDispatchMgr.CheckAttrMAXRate=function(value)
    local  maxRate=ConfigMgr.Config.HmwyDispatchConstants.MaxRatio/10000;
    return value>maxRate and maxRate or value;
end

HMWYDispatchMgr.GetHeroAttrList=function(heroId)
    local attrList={};
    local level=1;
    if not IsNull(DataMgr.Player.HMWYGame.Chars) and  DataMgr.Player.HMWYGame.Chars[heroId]~=nil then
        level=DataMgr.Player.HMWYGame.Chars[heroId].Level;
    end
    local heroRelic=ConfigMgr.Config.HmwyRelicStatsMap[heroId];
    if heroRelic==nil then
        return attrList;
    end
    local pat=level>#heroRelic.Pat and heroRelic.Pat[#heroRelic.Pat] or  heroRelic.Pat[level];
    local spd=level>#heroRelic.Spd and heroRelic.Spd[#heroRelic.Spd] or  heroRelic.Spd[level];
    local coop=level>#heroRelic.Coop and heroRelic.Coop[#heroRelic.Coop] or  heroRelic.Coop[level];
    local prof=level>#heroRelic.Prof and heroRelic.Prof[#heroRelic.Prof] or  heroRelic.Prof[level];
    local crt=level>#heroRelic.Crt and heroRelic.Crt[#heroRelic.Crt] or  heroRelic.Crt[level];
    local opt=level>#heroRelic.Opt and heroRelic.Opt[#heroRelic.Crt] or  heroRelic.Opt[level];
    table.insert(attrList,pat)
    table.insert(attrList,spd)
    table.insert(attrList,coop)
    table.insert(attrList,prof)
    table.insert(attrList,crt)
    table.insert(attrList,opt)
    return attrList;
end


HMWYDispatchMgr.GetPolygonPoints=function(values,size)
    local center = Vector2(0, 0)
    local posList={};

    for i = 1, #values,1 do
        local angle = i * (360.0 / #values) * (math.pi / 180.0)
        local pos = center + Vector2(
                math.cos(angle) * (size / 2 * values[i]),
math.sin(angle) * (size / 2 * values[i])
        )
        table.insert(posList,pos);
    end
    return posList;
end




HMWYDispatchMgr.CheckHeroIsUnLock=function(heroId)
    local rareList=ConfigMgr.Config.HmwyDispatchConstants.Rare;
    local HMWYGame=DataMgr.Player.HMWYGame;
    local isBuyHero= not IsNull(HMWYGame.BuyChars) and HMWYGame.BuyChars[heroId]~=nil
    local cfgHero=ConfigMgr.Config.characterTable[heroId];
    if cfgHero==nil then
        return false;
    end
    return DataMgr.Player.characters[heroId]~=nil or isBuyHero or NumTool.FindIndex(rareList,cfgHero.rare)>0;
end

HMWYDispatchMgr.GetEventData=function(eventId)
    local HMWYGame=DataMgr.Player.HMWYGame;
    if not IsNull(HMWYGame.Events) and HMWYGame.Events[eventId]~=nil then
        return HMWYGame.Events[eventId];
    end
    return nil;
end


HMWYDispatchMgr.ShowEventPopup=function(eventId,callBack);
    HMWYDispatchMgr.dispatchCallBack=callBack;
    local eventData=HMWYDispatchMgr.GetEventData(eventId)
    if eventData==nil or eventData.State==0 then
        LuaMgr.ShowLuaPanel(UIName.HMWYDispatchViewModel,eventId);
        return
    end
    local remainTime=eventData.EndTime-LuaMgr.Timestamp();
    if remainTime>0 then

        local heroList=HMWYDispatchMgr.GetDispatchHeroList(eventId);
        local rateIndex=HMWYDispatchMgr.CalculateDispatchRate(heroList,eventId);
        LuaMgr.ShowLuaPanel(UIName.HMWYDispatchInfoViewModel,eventId,rateIndex);
    else
        HMWYDispatchMgr.OnAskDispatchSettlement(eventId,function()
            local result=HMWYDispatchMgr.settlementMap[eventId];
            if IsNullOrEmpty(result.eggId) then
                LuaMgr.ShowLuaPanel(UIName.HMWYDispatchResultViewModel,result);
            else
                LuaMgr.ShowLuaPanel(UIName.HMWYDispatchRibbonViewModel,result);
            end
        end);


    end
end

HMWYDispatchMgr.ClearSettlement=function(eventId)
    if HMWYDispatchMgr.settlementMap[eventId]~=nil then
        HMWYDispatchMgr.settlementMap[eventId]=nil;
    end
end

HMWYDispatchMgr.OnAskDispatchSettlement=function(eventId,callBack)
    local askData={Id=eventId};
    HMWYDispatchMgr.settlementMap[eventId]={eventId=eventId,heroList=HMWYDispatchMgr.GetDispatchHeroList(eventId)};
    ApiMgr.Request("HMWYGame/settlement",askData,true,function(result)
        local re=json.decode(result);
        HMWYDispatchMgr.settlementMap[eventId].eggId=re.result.EggId;
        HMWYDispatchMgr.settlementMap[eventId].level=re.result.SucRate;
        HMWYDispatchMgr.settlementMap[eventId].items=re.result.Reward.Items;
        if callBack~=nil then
            callBack();
        end
    end,function()  end,true)
end


HMWYDispatchMgr.GetDispatchRewardProLevel=function(eventId)
    local heroList=HMWYDispatchMgr.GetDispatchHeroList(eventId);
    return 1;
end

HMWYDispatchMgr.GetDispatchHeroList=function(eventId)
    local heroList={}
    if not IsNull(DataMgr.Player.HMWYGame.Locks) then
        for i,v in pairs(DataMgr.Player.HMWYGame.Locks) do
            if eventId==v then
                table.insert(heroList,i);
            end
        end
    end
    return heroList;
end


HMWYDispatchMgr.GetDispatchResultHeroData=function(heroId)
    local heroData={
        level=1,
        pro=0,
        exp=0,
    }
    if IsNull(DataMgr.Player.HMWYGame.Chars) or DataMgr.Player.HMWYGame.Chars[heroId]==nil then
        return heroData;
    end
    local heroChar=DataMgr.Player.HMWYGame.Chars[heroId];
    heroData.level=heroChar.Level;
    heroData.exp=heroChar.Exp;
    local cfgHeroInfo=ConfigMgr.Config.HmwyHeroExpMap[tostring(heroChar.Level)]
    if cfgHeroInfo~=nil then
        heroData.pro=heroChar.Exp/cfgHeroInfo.Exp;
    end
    return heroData;
end


HMWYDispatchMgr.GetDispatchRareText=function()
    local attrStr=ConfigMgr.LangGlobal("30105")
    local attrArray=NumTool.split(attrStr,"_");
    return attrArray;
end





return HMWYDispatchMgr
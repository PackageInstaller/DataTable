







TrainingTowerHelper={
    isJumpCultivate=false;
    selectHeroId="";
    curOperaHeroId="";
    isfastSelectState=false,
    battleList={};
    fastSelectList={},
    viewPos=Vector2(0,0),

    weekTowerData = nil,

    curPageIndex = 0,
    curTowerCfgList = nil,
    isWeekExpired = false,

    NameSpriteStrMap = {
        tao = {"ui_pt_hua_btz_li", "ui_pt_hua_btz_tao"},
        he = {"ui_pt_hua_btz_he", "ui_pt_hua_btz_lian"},
        qiu = {"ui_pt_qiu_btz_gui", "ui_pt_qiu_btz_lan"},
        mei = {"ui_pt_hua4_btz_mei", "ui_pt_hua4_btz_song"},
        long = {"ui_pt_xing1_btz_long", "ui_pt_xing1_btz_hu"},
        que = {"ui_pt_xing2_btz_zq", "ui_pt_xing2_btz_xw"},
        hu = {"ui_pt_xing3_btz_hu", "ui_pt_xing3_btz_dou"},
        lie = {"ui_pt_xing4_btz_lie", "ui_pt_xing4_btz_che"},
        lu = {"ui_pt_lu1_btz_tu", "ui_pt_lu1_btz_ma"},
        shu = {"ui_pt_lu2_btz_shu", "ui_pt_lu2_btz_niu"},
        lu3 = {"ui_pt_lu3_btz_hu", "ui_pt_lu3_btz_yang"},
        lu4 = {"ui_pt_lu4_btz_long", "ui_pt_lu4_btz_she"},
        lu5 = {"ui_pt_lu5_btz_hou", "ui_pt_lu5_btz_ji"},
        lu6 = {"ui_pt_lu6_btz_gou", "ui_pt_lu6_btz_zhu"},
        yi1 = {"ui_pt_yi1_btz_zr", "ui_pt_yi1_btz_kf"},
        yi2 = {"ui_pt_yi1_btz_g", "ui_pt_yi1_btz_yz"},
        yi3 = {"ui_pt_yi1_btz_dj", "ui_pt_yi1_btz_xt"},
        yi4 = {"ui_pt_yi1_btz_sc", "ui_pt_yi1_btz_jm"},
        yi5 = {"ui_pt_yi1_btz_zy", "ui_pt_yi1_btz_xl"},
        yi6 = {"ui_pt_yi1_btz_tf", "ui_pt_yi1_btz_tw"},
        yi7 = {"ui_pt_yi1_btz_ql", "ui_pt_yi1_btz_ysq"},
        yi8 = {"ui_pt_yi1_btz_ls", "ui_pt_yi1_btz_jf"},
        yi9 = {"ui_pt_yi1_btz_lus", "ui_pt_yi1_btz_l"},
        yi10 = {"ui_pt_yi1_btz_by", "ui_pt_yi1_btz_jr"},
        yi11 = {"ui_pt_yi1_btz_jwh", "ui_pt_yi1_btz_gd"},
        yi12 = {"ui_pt_yi1_btz_cy", "ui_pt_yi1_btz_z"},
        yi13 = {"ui_pt_yi1_btz_lw", "ui_pt_yi1_btz_th"},
        yi14 = {"ui_pt_yi1_btz_sb", "ui_pt_yi1_btz_zheng"},
        yi15 = {"ui_pt_yi1_btz_cl", "ui_pt_yi1_btz_qy"},
        yi16 = {"ui_pt_yi1_btz_tm", "ui_pt_yi1_btz_cc"},
        yi17 = {"ui_pt_yi1_btz_zh", "ui_pt_yi1_btz_px"},
        yi18 = {"ui_pt_yi1_btz_zj", "ui_pt_yi1_btz_bm"},
        yi19 = {"ui_pt_yi1_btz_t2", "ui_pt_yi1_btz_t1"},
        yi20 = {"ui_pt_yi1_btz_tg", "ui_pt_yi1_btz_h"},
        yi21 = {"ui_pt_yi1_btz_ay", "ui_pt_yi1_btz_bf"},
        yi22 = {"ui_pt_yi1_btz_bf2", "ui_pt_yi1_btz_chi"},
    },
    UiThemeMap = {
        qiu = {
            weeklyIconStr = "ui_pt_qh8"
        },
        mei = {
            weeklyIconStr = "ui_pt_qh9"
        },
        xing = {
            themeList = { "long", "que", "hu", "lie" },
            weeklyIconStr = "ui_pt_qh10",
            hideCommonEffect = true,
        },
        lu = {
            themeList = { "lu", "shu", "lu3", "lu4", "lu5", "lu6"},
            weeklyIconStr = "ui_pt_qh11",
            hideCommonEffect = true,
        },
        yi = {
            themeList = { "yi1", "yi2", "yi3", "yi4", "yi5", "yi6", "yi7", "yi8", "yi9", "yi10",
                          "yi11", "yi12", "yi13", "yi14", "yi15", "yi16", "yi17", "yi18", "yi19",
                          "yi20", "yi21", "yi22" },
            weeklyIconStr = "ui_pt_qh12",
            hideCommonEffect = false,
        }
    }
}

local function GetBuffMasLayer(buffAttr)
    local maxLayerLine=buffAttr[6];
    local lines=NumTool.split(maxLayerLine,",")
    if #lines>2 then
        local c=string.sub(lines[3],1,#lines[3]-1);
        return c;
    end
    return "";
end

TrainingTowerHelper.GetRuleText=function(RuleShow, GroupId)
    local cfgRuleMap=ConfigMgr.Config.BTRuleMap
    local ruleTextList={};
    for i,v in ipairs(RuleShow) do
        local ruleConfig = cfgRuleMap[v[1]]
        if GroupId == nil or ruleConfig.Group == tostring(GroupId) then
            local ruleText=LuaMgr.GetLangText(ruleConfig.RuleShowLan);
            
            if cfgRuleMap[v[1]].RuleShowType==0 then
                for j=2,#v,1 do
                    ruleText=LuaMgr.FindAndReplace(ruleText,"%s",v[j]);
                end
            elseif cfgRuleMap[v[1]].RuleShowType==1 then

                local buff = ConfigMgr.Config.buffMap[v[2]];
                if buff~=nil then
                    local buffName=LuaMgr.GetLangText(buff.NameLan);
                    local maxLayer=GetBuffMasLayer(buff.Attr);
                    ruleText=string.format(ruleText,buffName,maxLayer);
                end
            elseif cfgRuleMap[v[1]].RuleShowType==2 then
                ruleText=string.format(ruleText,v[3]);
            end
            
            table.insert(ruleTextList,{ruleId=v[1],value=ruleText})
        end
    end
    for i=1,#ruleTextList-1,1 do
        if (ruleTextList[i].ruleId=="6" and ruleTextList[i+1].ruleId=="7") 
                or (ruleTextList[i].ruleId=="8" and ruleTextList[i+1].ruleId=="9") then
            ruleTextList[i].value=ruleTextList[i].value..ruleTextList[i+1].value;
            ruleTextList[i+1].value="";
        end
    end
    local ruleList={}
    for i,v in ipairs(ruleTextList) do
        if v.value~="" then
            table.insert(ruleList,v.value);
        end
    end
    return ruleList;
end


TrainingTowerHelper.CheckCondition_HeroNum=function(list,condition)
    if #condition~=2 then return false end;
    return #list==tonumber(condition[2]);
end

TrainingTowerHelper.CheckCondition_HeroJob=function(list,condition)
    if #condition~=4 then return false end;
    local num=0;
    local heroData=nil;
    for i,v in ipairs(list) do
        heroData=ConfigMgr.Config.characterTable[v];
        if heroData~=nil then
            if heroData.job==tonumber(condition[2]) then
                num=num+1;
            end
        end
    end
    if condition[3]=="101" then
        return num<tonumber(condition[4]);
    elseif condition[3]=="102" then
        return num<=tonumber(condition[4]);
    elseif condition[3]=="103" then
        return num==tonumber(condition[4]);
    elseif condition[3]=="104" then
        return num>=tonumber(condition[4]);
    elseif condition[3]=="105" then
        return num>tonumber(condition[4]);
    end
    return true;
end

TrainingTowerHelper.CheckCondition_HeroQuality=function(list,condition)
if #condition~=4 then return false end;
    local num=0;
    local heroData=nil;
    for i,v in ipairs(list) do
        heroData=ConfigMgr.Config.characterTable[v];
        if heroData~=nil then
            if heroData.rare==tonumber(condition[2]) then
                num=num+1;
            end
        end
        
    end
    if condition[3]=="101" then
        return num<tonumber(condition[4]);
    elseif condition[3]=="102" then
        return num<=tonumber(condition[4]);
    elseif condition[3]=="103" then
        return num==tonumber(condition[4]);
    elseif condition[3]=="104" then
        return num>=tonumber(condition[4]);
    elseif condition[3]=="105" then
        return num>tonumber(condition[4]);
    end
    return true;
    
    
end

TrainingTowerHelper.CheckCondition_HeroLevel=function(list,condition)
    if #condition~=5 then return false end;

    local num=0;
    local heroData=nil;
    for i,v in ipairs(list) do
        heroData=DataMgr.Player.characters[v];
        if heroData~=nil then
            if condition[2]=="101" and heroData.level<tonumber(condition[3]) then
                num=num+1;
            elseif condition[2]=="102" and heroData.level<=tonumber(condition[3])  then
                num=num+1;
            elseif condition[2]=="103" and heroData.level==tonumber(condition[3])  then
                num=num+1;
            elseif condition[2]=="104" and heroData.level>=tonumber(condition[3])  then
                num=num+1;
            elseif condition[2]=="105" and heroData.level>tonumber(condition[3])  then
                num=num+1;
            end
        end
    end
    if condition[4]=="101" then
        return num<tonumber(condition[5]);
    elseif condition[4]=="102" then
        return num<=tonumber(condition[5]);
    elseif condition[4]=="103" then
        return num==tonumber(condition[5]);
    elseif condition[4]=="104" then
        return num>=tonumber(condition[5]);
    elseif condition[4]=="105" then
        return num>tonumber(condition[5]);
    end
    return true;
end




TrainingTowerHelper.GetDuneonEnemys = function(dungeon,limitNum)
    local monsterDicJson = LuaMgr.UpdateMonsterIdList(dungeon.id)
    local monsterConfigTable = json.decode(monsterDicJson)

    local enemyListData = {}
    local enemyKeyMap = {}
    for item, v in ipairs(monsterConfigTable) do
        if enemyKeyMap[v] == nil then
            enemyKeyMap[v] = true
            local monster = ConfigMgr.Config.monsterMap[v]
            if monster ~= nil and not monster.hideShowinfo then
                local enemyData = {
                    id = monster.id,
                    icon = LuaMgr.GetTexture("Assets/_BundleResources/Character/" .. monster.monsterModel .. "/Avatar/" .. monster.monsterSkin .. ".png"),
                    border = LuaMgr.GetSprite("CommonRes", monster.type == 2 and "ui_ty_txk_guaiwu_hong" or "ui_ty_txk_guaiwu_bai"),
                    isShow = false,
                }
                if monster.type == 0 then
                    enemyData.isType = false
                    enemyData.typeOrder = 0
                elseif monster.type == 1 then
                    enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_zj")
                    enemyData.isType = true
                    enemyData.typeOrder = 1
                elseif monster.type == 2 then
                    enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_boss")
                    enemyData.isType = true
                    enemyData.typeOrder = 3
                elseif monster.type == 3 then
                    enemyData.type = LuaMgr.GetSprite("CommonRes", "ui_ty_txk_jb_jy")
                    enemyData.isType = true
                    enemyData.typeOrder = 2
                end
                table.insert(enemyListData, enemyData)
                if limitNum~=nil and #enemyListData >= limitNum then
                    break
                end
            end
        end
    end
    return enemyListData,monsterConfigTable;
end


local function IsBuffUp(charAttr)
    if IsNull(charAttr.BuffMap) or NumTool.GetLen(charAttr.BuffMap)==0 then
        return false;
    end
    local re=false;
    for i,v in pairs(charAttr.BuffMap) do
        if v.Type ~= -1 then
            re=re or v.Type == 0;
        end
    end
    return re;
end
local function IsBuffDown(charAttr)
    if IsNull(charAttr.BuffMap) or NumTool.GetLen(charAttr.BuffMap)==0 then
        return false;
    end
    local re=false
    for i,v in pairs(charAttr.BuffMap) do
        if v.Type ~= -1 then
            re=re or v.Type == 1;
        end
    end
    return re;
end




TrainingTowerHelper.GetActiveBuffByGroupId=function(groupId)
    local battleTown=ConfigMgr.Config.BattleTowerMap[groupId]
    if battleTown==nil or IsNull(battleTown.ActiveBuff) or #battleTown.ActiveBuff==0 then
        return nil;
    end
    local jsonStr=json.encode(battleTown.ActiveBuff);
    return jsonStr;
end


TrainingTowerHelper.CheckIsPassBattleGroupId=function(groupId)
    if groupId==nil then return false end;
    local battleTown=ConfigMgr.Config.BattleTowerMap[groupId];
    if battleTown==nil then
        return false;
    end
    if IsNull(battleTown.ActiveBuff) or #battleTown.ActiveBuff==0 then
        return false;
    end
    return TrainingTowerHelper.CheckIsPassBattle(groupId)
end

TrainingTowerHelper.CheckIsPassBattle = function(groupId)
    local dungeonList={}
    for i,v in pairs(ConfigMgr.Config.dungeonMap) do
        if string.match(v.id,groupId)~=nil then
            table.insert(dungeonList,v);
        end
    end
    local isPass=true;
    for i,v in ipairs(dungeonList) do
        if not DataHelper.CheckDungeonComplete(v.id) then
            isPass=false;
            break;
        end
    end
    return isPass;
end

TrainingTowerHelper.CheckIsTiredBuff=function(groupId)
    if groupId==nil then return false end;
    local battleTown=ConfigMgr.Config.BattleTowerMap[groupId];
    if battleTown==nil then
        return false;
    end
    return not IsNull(battleTown.TiredBuff) and #battleTown.TiredBuff>0;
end

TrainingTowerHelper.CreateHeroItem=function(heroAttr,isShowTiredBuff)
    local heroConfig = ConfigMgr.Config.characterTable[heroAttr.ID]
    local heroData=DataMgr.Player.TowerCharsCopy[heroAttr.ID];
    local isUp=IsBuffUp(heroAttr)
    local isDown=IsBuffDown(heroAttr);
    local isUpDown=isUp and isDown;
    local heroItem={
        heroId=heroAttr.ID,
        isFree=false,
        isActive=true,
        iconTexture=LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(heroData.id,heroData.curSkin)),
        jobSprite=LuaMgr.GetSprite("JobIcon","job2_"..heroConfig.job),
        level=tostring(heroData.level),
        hpSlider=heroAttr.LockRound==0 and (heroAttr.HP/heroAttr.MaxHP) or 1.0,
        isUp=not isUpDown and isUp,
        isDown=not isUpDown and isDown,
        isUpDown=isUpDown,
        isLock=heroAttr.LockRound~=0,
        isSelecting=false,
        isHp=heroAttr.LockRound==0;
        isPro=isShowTiredBuff;
        proList=TrainingTowerHelper.GetProList(heroAttr.FightNum);
    }
    return heroItem;
end

TrainingTowerHelper.GetProList=function(fightNum)
    local proItemList={}
    if IsNull(ConfigMgr.Config.constants.TiredLimit) or  ConfigMgr.Config.constants.TiredLimit==0 then
        return proItemList;
    end
    local remainCount=ConfigMgr.Config.constants.TiredLimit-fightNum;
    for i=1,ConfigMgr.Config.constants.TiredLimit,1 do
        local proItem={
            isOn=remainCount>=i;
        }
        table.insert(proItemList,proItem);
    end
    return proItemList;
end

TrainingTowerHelper.EnterDungeon=function(dungeonId, memberDic, groupId, teamWeaponId)
    local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
    enterDungeonParams.eventId = dungeonId
    enterDungeonParams.dungeonId = dungeonId
    enterDungeonParams.members = memberDic
    local extraList={};
    table.insert(extraList,"tower2");
    table.insert(extraList,groupId);
    table.insert(extraList, TrainingTowerHelper.GetExtraHp(teamWeaponId));
    enterDungeonParams.extraParams=extraList;
    BattlePrepareMgr._enterDungeonParams=enterDungeonParams;
    local filter={UIName.TrainingTowerChoiceViewModel}
    LuaMgr.SceneSwitchMark(filter);
    PlayerAreaMgr.SetAreaDungeonId("-1");
    ApiMgr.Request("enter_dungeon",enterDungeonParams,true,function(result)
        local re = json.decode(result)
        local data=json.encode(re.result);
        LuaMgr.EnterBattle(data, -1);
    end,function(failCode)
        BattlePrepareMgr.EnterBattleFail(failCode)
    end,true);
end

TrainingTowerHelper.GetExtraHp = function (teamWeaponId)
    local hp = 0
    local attrTable = {}

    if not IsNullOrEmpty(teamWeaponId) then
        attrTable = LuaMgr.GetTeamWeaponPropertyCopy(teamWeaponId, {"Hp"})
        attrTable = json.decode(attrTable)
        hp = attrTable["Hp"] or "0"
    end

    return hp
end

TrainingTowerHelper.GetDungeonListByGroupId = function(groupId)
    local dungeonList={};
    for i,v in pairs(ConfigMgr.Config.dungeonMap) do
        if string.match(v.id,groupId)~=nil then
            table.insert(dungeonList,v);
        end
    end
    table.sort(dungeonList,function(a, b) return a.id<b.id end)
    return dungeonList
end

TrainingTowerHelper.GetDungeonIndexFromList=function(groupId,dungeon)
    local index=1;
    local dungeonList = TrainingTowerHelper.GetDungeonListByGroupId(groupId)
    for i,v in ipairs(dungeonList) do
        if v.id==dungeon then
            index=i
            break;
        end
    end
    return index;
end

TrainingTowerHelper.CheckWeekTowerExpired = function()
    local weekTowerData = TrainingTowerHelper.weekTowerData
    if weekTowerData == nil or weekTowerData.Expires == nil or weekTowerData.Expires - LuaMgr.Timestamp() <= 0 or weekTowerData.Start > LuaMgr.Timestamp() then
        return true
    end
    return false
end

TrainingTowerHelper.OnAskGetCurrentRotation = function(cb)
    local askData={}
    ApiMgr.Request("tower2/getCurrentRotation",askData,true,function(result)
        local re=json.decode(result);
        TrainingTowerHelper.weekTowerData=re.result;
        cb()
    end,nil,true);
end

TrainingTowerHelper.GetThemeGroupNameByThemeName = function(themeName)
    local themeGroupName = themeName
    for k, v in pairs(TrainingTowerHelper.UiThemeMap) do
        if k == themeName then
            themeGroupName = k
            break
        end
        if v.themeList ~= nil then
            for i, str in ipairs(v.themeList) do
                if str == themeName then
                    themeGroupName = k
                    break
                end
            end
        end
    end
    return themeGroupName
end


local GetTowerStageRewardsRedCount = function()
    local count = 0
    if not TrainingTowerHelper.CheckWeekTowerExpired() then
        local groupId1, groupId2 = "", ""
        for k, v in pairs(ConfigMgr.Config.BattleTowerMap) do
            if v.RotationId == TrainingTowerHelper.weekTowerData.RotationId then
                if IsNullOrEmpty(groupId1) then
                    groupId1 = k
                elseif IsNullOrEmpty(groupId2) then
                    groupId2 = k
                end
            end
        end
        local stageRewards = DataMgr.Player.TowerStageRewards
        if IsNull(stageRewards) or IsNullOrEmpty(groupId1) or IsNullOrEmpty(groupId2) then
            return 0
        end
        for k, v in pairs(stageRewards) do
            if v and (string.match(k, groupId1) or string.match(k, groupId2)) then
                count = count + 1
            end
        end
    end
    return count
end


TrainingTowerHelper.GetTimeRedCount = function()
    local weekTowerData = TrainingTowerHelper.weekTowerData
    local redID = "15110_1"
    if weekTowerData == nil or weekTowerData.Expires == nil or weekTowerData.Expires <= LuaMgr.Timestamp() or weekTowerData.Start > LuaMgr.Timestamp() then
        return 0, redID
    end
    local curTime = LuaMgr.Timestamp()
    local startTime = weekTowerData.Start
    local endTime = weekTowerData.Expires
    local deltaTimeStart = GetTimeDay(curTime - startTime)
    local deltaTimeEnd = GetTimeDay(endTime - curTime)
    if deltaTimeStart == 1 and RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1, redID
    elseif (deltaTimeEnd == 1 or  deltaTimeEnd == 3) and RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1, redID
    end
    return 0, redID
end


TrainingTowerHelper.GetTowerStageRewardsRedCount = function(callback)
    if callback == nil then
        return
    end
    if TrainingTowerHelper.CheckWeekTowerExpired() then
        TrainingTowerHelper.OnAskGetCurrentRotation(function()
            callback(GetTowerStageRewardsRedCount())
        end)
    else
        callback(GetTowerStageRewardsRedCount())
    end
end

TrainingTowerHelper.CheckOutOfPower=function(members)
    if IsNull(ConfigMgr.Config.constants.TiredLimit) then 
        return false 
    end;
    for i,v in pairs(members) do
        local towerChar=DataMgr.Player.TowerCharAttrs[v];
        if towerChar~=nil and towerChar.FightNum>=ConfigMgr.Config.constants.TiredLimit then
            return true
        end
    end
    return false;
end

TrainingTowerHelper.GetTowerJobExtraAttr = function()
    if TableIsNull(DataMgr.Player.TowerJobExtraAttr) then
        return ""
    end
    local jsonStr = json.encode(DataMgr.Player.TowerJobExtraAttr)
    return jsonStr
end

TrainingTowerHelper.Clear=function()
    TrainingTowerHelper.selectHeroId="";
    TrainingTowerHelper.curOperaHeroId = "";
    TrainingTowerHelper.battleList={};
    TrainingTowerHelper.viewPos=Vector2(0,0);
end
TrainingTowerHelper.ClearCache=function()
    TrainingTowerHelper.isJumpCultivate=false;
    TrainingTowerHelper.selectHeroId="";
    TrainingTowerHelper.battleList={};
    TrainingTowerHelper.viewPos=Vector2(0,0);
end
TrainingTowerHelper.SetCache=function(id,battleList,pos)
    TrainingTowerHelper.selectHeroId=id;
    TrainingTowerHelper.battleList=battleList;
    TrainingTowerHelper.viewPos=pos;
end
TrainingTowerHelper.ClearCurTowerCache = function()

    TrainingTowerHelper.curTowerCfgList = nil
    TrainingTowerHelper.curPageIndex = nil
end

return TrainingTowerHelper;


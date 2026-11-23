
local this = { vm = nil,
               sortBarNames = {},
               totalKillNum=0,
               totalHurtNum=0,
               totalInjured=0,
               totalTreat=0,
               characterList={},
SortType={
                 Loc=1,
                 Kill=2,
                 Hurt=3,
                 Injured=4,
                 Treat=5
               },
SortStyle={
Up=1,
Down=2
               },
               sort_Type=nil,
               sort_Style=nil,
               teamMembers={},
               coKey_Bar=nil,
               coKey_Hero=nil,
}


local data = {
    barList={
        {
            name="",
            isActive=false,
            isOn=false,
            isAnima=false,
        }
    },
    heroList={
        {
            isAnima=false,
            isActive=false,
            cardRare=DefaultSprite,
            cardRaw=DefaultTexture,
            level="",
            killNum="",
            hurtValue="",
            hurtPro="",
            hurtSlider=0.0,
            injuredValue="",
            injuredPro="",
            injuredSlider=0.0,
            treatValue="",
            treatPro="",
            treatSlider=0.0,
        }
    },
total_killNum="",
total_hurtNum="",
total_injured="",
total_treat="",
    infoListContentAnchor=Vector2(0,0),
    infoListSizeData=Vector2(1036,444),
    offsetAnchorPos=Vector2(0,0)
    
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.BattleDetailViewModel)
        end
    },
    barItemBtn={
        type = XLuaCommandType.Void,
        execute = function(vm,param)
           local index=tonumber(param)+1;
            for i,v in ipairs(this.vm.data.barList) do
                v.isActive=i==index;
                v.isOn=false
            end
            this.sort_Type=index
            this.sort_Style=this.SortStyle.Down
            this.SortHero(false);
        end
    },
    sortBarBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index=tonumber(param)+1;
            local barItem=this.vm.data.barList[index];
            local isOn=barItem.isOn;
            barItem.isOn=not isOn;
            this.sort_Style=isOn and this.SortStyle.Down or this.SortStyle.Up
            this.SortHero(false);
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.sortBarNames={
            LuaMgr.GetLangText("BattleDetailViewModel_0"),
            LuaMgr.GetLangText("BattleDetailViewModel_1"),
            LuaMgr.GetLangText("BattleDetailViewModel_2"),
            LuaMgr.GetLangText("BattleDetailViewModel_3"),
            LuaMgr.GetLangText("BattleDetailViewModel_4")
        }
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local params=vm.behaviour.Params;
        this.teamMembers={}
        this.characterList=json.decode(params[0])
        local lastTeamId=this.GetTeamId()
        this.teamMembers=DataMgr.Player.teams[lastTeamId].members

        local isLock,teamId=BattlePrepareMgr.NeedLockFormation();
        if BattlePrepareMgr.IsMoreMod() then 
            this.teamMembers=DataMgr.Player.teamsMoreMod["0"].members
elseif isLock then
            this.teamMembers=DataMgr.Player.teams[teamId].members;
        end

        for i,v in ipairs(this.characterList) do
            v.loc=this.GetTeamLoc(v.roleId);
        end
        this.SetAdjustScreen();
        this.ParseData();
    end,
    before_deactive = function(vm)
       
    end,
    before_destroy=function(vm)
        this=nil
    end
}

this.GetTeamLoc=function(roleId)
    for i,v in pairs(this.teamMembers) do
        if v==roleId then
            return tonumber(i)
        end
    end
    print("Error: roleId not in teamsMembers,return 100 ")
    return 100
end


this.GetTeamId = function()
    if not IsNullOrEmpty(DataMgr.Player.lastTeamID) then
        return DataMgr.Player.lastTeamID;
    end
    local teamId = ""
    local teams = DataMgr.Player.teams
    local index = 0
    for i, v in pairs(teams) do
        teamId = tostring(index)
        if teams[teamId] ~= nil then
            return teamId
        end
        index = index + 1
    end
    return "0"
end

this.SetAdjustScreen=function()
    this.vm.data.infoListContentAnchor=Vector2(0,0);
    local scrWidth=LuaMgr.GetScreenWidth()
    local maxWidth=248+200*6;
    local offWidth= scrWidth-maxWidth;
    if offWidth>=0 then
        this.vm.data.infoListSizeData=Vector2(200*6,444);
        this.vm.data.offsetAnchorPos=Vector2(offWidth/2,0);
    else
        this.vm.data.offsetAnchorPos=Vector2(0,0);
        offWidth=scrWidth-248;
        this.vm.data.infoListSizeData=Vector2(offWidth,444);
    end
end

this.ParseData=function()
    this.totalKillNum=0
    this.totalHurtNum=0
    this.totalInjured=0
    this.totalTreat=0
    for i,v in ipairs(this.characterList) do
        this.totalKillNum=this.totalKillNum+v.kill
        this.totalHurtNum=this.totalHurtNum+v.damage
        this.totalInjured=this.totalInjured+v.getHurt
        this.totalTreat=this.totalTreat+v.heal
    end
    this.vm.data.total_killNum=this.totalKillNum
    this.DoAnimation(this.totalHurtNum,this.totalInjured,this.totalTreat)
    this.sort_Type=this.SortType.Loc
    this.sort_Style=this.SortStyle.Down
    
    this.SetTopBarList();
    this.SortHero(true);
end

this.DoAnimation=function(hurt,injured,treat)
    DOTWeen.To(function() return 0  end,function(value)
        value=math.floor(value);
            this.vm.data.total_hurtNum=value;
    end,hurt,0.4)
    DOTWeen.To(function() return 0  end,function(value)
        value=math.floor(value);
        this.vm.data.total_injured=value;
    end,injured,0.4)
    DOTWeen.To(function() return 0  end,function(value)
        value=math.floor(value);
        this.vm.data.total_treat=value;
    end,treat,0.4)
    
end



this.SortHero=function(isAnima)
    if this.sort_Type==this.SortType.Kill then
        if this.sort_Style==this.SortStyle.Down then
            table.sort(this.characterList,function(a, b)
                if a.kill==b.kill then
                    if a.damage==b.damage then
                        return a.roleId<b.roleId
                    else
                        return a.damage>b.damage
                    end
                else
                    return a.kill>b.kill
                end
            end)
        else
            table.sort(this.characterList,function(a, b)
                if a.kill==b.kill then
                    if a.damage==b.damage then
                        return a.roleId>b.roleId
                    else
                        return a.damage<b.damage
                    end
                else
                    return a.kill<b.kill
                end
            end)
        end
    elseif this.sort_Type==this.SortType.Hurt then
        if this.sort_Style==this.SortStyle.Down then
            table.sort(this.characterList,function(a, b)
                if a.damage==b.damage then
                    return a.roleId<b.roleId
                end
                return a.damage>b.damage 
            end)
        else
            table.sort(this.characterList,function(a, b)
                if a.damage==b.damage then
                    return a.roleId>b.roleId
                end
                return a.damage<b.damage 
            end)
        end
    elseif this.sort_Type==this.SortType.Injured then
        if this.sort_Style==this.SortStyle.Down then
            table.sort(this.characterList,function(a, b)
                if a.getHurt==b.getHurt then
                    return a.roleId<b.roleId
                end
                return a.getHurt>b.getHurt end)
        else
            table.sort(this.characterList,function(a, b)
                if a.getHurt==b.getHurt then
                    return a.roleId>b.roleId
                end
                return a.getHurt<b.getHurt end)
        end
    elseif this.sort_Type==this.SortType.Treat then
        if this.sort_Style==this.SortStyle.Down then
            table.sort(this.characterList,function(a, b)
                if a.heal==b.heal then
                    return a.roleId<b.roleId
                end
                return a.heal>b.heal end)
        else
            table.sort(this.characterList,function(a, b)
                if a.heal==b.heal then
                    return a.roleId>b.roleId
                end
                return a.heal<b.heal end)
        end
    else
        if this.sort_Style==this.SortStyle.Down then
            table.sort(this.characterList,function(a, b) return a.loc<b.loc end)
        else
            table.sort(this.characterList,function(a, b) return a.loc>b.loc end)
        end
    end
    this.SetCardList(isAnima);
end
    


this.SetTopBarList=function()
    local list={}
    for i,v in ipairs(this.sortBarNames) do
        local barItem={
            name=v,
            isActive=i==1,
            isOn=false,
            isAnima=false,
        }
        table.insert(list,barItem)
    end
    this.vm.data.barList=list;
    if this.coKey_Bar~=nil then
        coroutine_runner.stop(this.coKey_Bar);
    end
    this.coKey_Bar=coroutine_runner.start(function()
        for i,v in ipairs(this.vm.data.barList) do
            v.isAnima=true;
            coroutine_runner.wait(0.02);
        end
    end)
end

this.SetCardList=function(isAnima)
    local list={}
    for i=1,6 do
        local heroItem={}
        local hero=this.characterList[i];
if i>#this.characterList  then
            heroItem.isActive=false;
        else
            local character=nil;
            local rare = CharacterRare.R
            if PlayerAssistMgr.IsAssistMember(hero.roleId) then
                local uid=PlayerAssistMgr.GetAssistMemberUid(hero.roleId)
                character=PlayerAssistMgr.GetAssist_Character(uid,hero.roleId)
                rare = HeroMgr.GetHeroNowRare(hero.roleId,uid)
            elseif BattlePrepareMgr.isRogue then
                character=RogueMgr.GetCharacterDataByID(hero.roleId);
                local tempConfig = ConfigCharacterMgr.GetInfo(hero.roleId)
                rare = tempConfig.rare
                if  not IsNull(character.brilliant) then
                    rare = rare + character.brilliant.RareLevel
                end
            else
                character=DataMgr.Player.characters[hero.roleId];
                rare = HeroMgr.GetHeroNowRare(hero.roleId)
            end
            if character~=nil then
                local skinId=character.curSkin
                local imageRare = rare >= 5 and 4 or rare

                heroItem.isAnima=not isAnima
                heroItem.isActive=true
                heroItem.cardRare=LuaMgr.GetSprite("BattleBalance","ui_zd_js_zk_xyd"..imageRare)
                heroItem.cardRaw=ConfigHelper.GetHeroCard(hero.roleId,skinId)
                heroItem.level=tostring(hero.level)
                heroItem.killNum=tostring(hero.kill)
                heroItem.hurtValue=tostring(hero.damage)
                heroItem.hurtPro=this.GetPro_ByFormat(hero.damage,this.totalHurtNum)
                heroItem.hurtSlider=hero.damage/this.totalHurtNum
                heroItem.injuredValue=tostring(hero.getHurt)
                heroItem.injuredPro=this.GetPro_ByFormat(hero.getHurt,this.totalInjured)
                heroItem.injuredSlider=hero.getHurt/this.totalInjured
                heroItem.treatValue=tostring(hero.heal)
                heroItem.treatPro=this.GetPro_ByFormat(hero.heal,this.totalTreat)
                heroItem.treatSlider=hero.heal/this.totalTreat
            end
        end
        table.insert(list,heroItem);
    end
    this.vm.data.heroList=list;
    if not isAnima then return end;
    
    if this.coKey_Hero~=nil then
        coroutine_runner.stop(this.coKey_Hero);
    end
    this.coKey_Hero=coroutine_runner.start(function()
        coroutine_runner.wait(0.02);
        if this ~= nil then
            for i,v in ipairs(this.vm.data.heroList) do
                if v.isAnima~=nil then
                    v.isAnima=true;
                    coroutine_runner.wait(0.02);
                end
            end
        end
    end)
end


this.GetPro_ByFormat=function(pro,max)
    if pro==0 or max==0 then
        return "0%";
    end

    local value=pro/max;
    value=value<=0.01 and 0.01 or value+0.005 
    return string.format("%d",math.floor(value*100)).."%";
end

return vm({
    data = data,
    command = command,
    hook = hook
})
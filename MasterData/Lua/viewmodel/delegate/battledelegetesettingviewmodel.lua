




require("ViewModel/Delegate/Delegate_FrameItem")
require("ViewModel/Delegate/Delegate_GoodsItemGroup")

local this = {vm=nil,
              memberItemObj=nil,
              fetterItemObj=nil,
              goodItemObj=nil,
              rewardItemObj=nil,
              
              memberUIList=nil,
              fetterUIList=nil,
              rewardsScrollView=nil,
              unlockLevel=nil,
              unlockList={}
              
};
local cfgDungeon={};
local cfgDropMap={}
local consume={};
local curCount=0;
local maxCount=0;
local cfgMaxCount=nil;
local teams={}
local itemMap={};
local isBattleCostCount=false;
local limitMaxCount = 0


local objs = {

    warningInfo = { path = "root/Middle/BG/right/Title", type = "Text" },
    tarTf={path="root/Middle/BG/right/tar", type = "Transform"},
    tarNum = { path = "root/Middle/BG/right/tar/num", type = "Text" },
    tarItemTf={path="root/Middle/BG/right/tar/_good", type = "Transform"},
    curStamina = { path = "root/Middle/BG/right/Cost/Pro/cur", type = "Text" },
    remainStamina = { path = "root/Middle/BG/right/Cost/Pro/remain", type = "Text" },
    delegateCount = { path = "root/Middle/BG/right/buttons/Input/Text", type = "Text" },

    addUINumber = { path = "root/Middle/BG/right/buttons/AddBtn", type = "UIAddNumber" },
    lessenUINumber = { path = "root/Middle/BG/right/buttons/lessenBtn", type = "UIAddNumber" },
    maxNumber= { path = "root/Middle/BG/right/buttons/maxBtn", type = "UIButtonClick" },
    okBtn = { path = "root/Middle/BG/right/buttons/okBtn", type = "UIButtonClick" },
    cancelBtn={ path = "root/Middle/BG/right/buttons/cancelBtn", type = "UIButtonClick" },
    maskBtn={path = "root/Middle/Mask", type = "UIButtonClick" },
    addStaminaBtn={path = "root/Middle/BG/right/Cost/btnAdd", type = "UIButtonClick" },
    editorBtn={path = "root/Middle/BG/left/btnEditor", type = "UIButtonClick" },

    
    limitRoot = {path="root/Middle/BG/right/buttons/Limit", type = "GameObject"},
    limitText = {path="root/Middle/BG/right/buttons/Limit/Text", type = "Text"},
}
local obj_command = {
    cancelBtnCommand=function()
        LuaMgr.HidePanel(UIName.BattleDelegeteSettingViewModel)
    end,
    okBtnCommand = function()
        if NumTool.GetLen(teams)<1 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2461"))
            return
        end
        for i,v in pairs(teams) do
            if this.CheckPrestigeMax(v) then
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("2460"),this.Leave_Dungeon,nil);
                return;
            end
        end
       this.Leave_Dungeon();
    end,
    addStaminaCommand=function()
        LuaMgr.ShowLuaPanel("FatigueReplyViewModel")
    end,
    editorBtnCommand=function()

        LuaMgr.ShowLuaPanel(UIName.BattleDelegeteHeroViewModel,teams,function()
            this.SetAvatarList();
        end)
    end,
    maxNumberCommand=function()
        curCount=maxCount;
        this.RefrushRewardsInfo();
    end
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        UITool.Parse(vm.behaviour,this,objs)
        this.memberUIList = UIListView.New(vm.behaviour.transform:Find("root/Middle/BG/left/hero/Content"));
        this.fetterUIList = UIListView.New(vm.behaviour.transform:Find("root/Middle/BG/left/fetter/Content"));
        this.rewardsScrollView=UIScrollView.New(vm.behaviour.transform:Find("root/Middle/BG/rewards/ScrollView"))
        this.memberItemObj=vm.behaviour.transform:Find("template/frameItem").gameObject;

        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardsItem").gameObject;
        this.UINumberBinder();
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                this.RegisterCommand();
                local data=vm.behaviour.Params
                local dungeonId=tostring(data[0]);
                cfgDungeon=ConfigMgr.Config.dungeonMap[dungeonId];
                cfgDropMap=ConfigMgr.Config.dropMap;

                this.CheckUsedTeams();
                itemMap={};
                isBattleCostCount=false;

                this.SetDungeonLimit()
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.rewardsScrollView:Clear(true)
        this.RemoveRegisterCommand()
    end,
    before_destroy=function()
        UIScrollView.ClearItem("Delegate_GoodsItemGroup")
        UIListView.ClearItem("Delegate_FrameItem")
        this=nil
    end
}

this.CheckUsedTeams=function()
    teams=table.Copy(DataMgr.Player.teams["0"].members);
    local newTeams={}
    for i,v in pairs(teams) do
        if DataMgr.Player.characters[v]~=nil then
            table.insert(newTeams,{index=tonumber(i),id=v});
        end
    end
    table.sort(newTeams,function(a,b) return a.index<b.index end)
    teams={}
    for i,v in ipairs(newTeams) do
        teams[tostring(i-1)]=v.id;
    end
end

this.CheckPrestigeMax=function(id)
    local characterData=DataMgr.Player.characters[id];
    local isMax=characterData.prestigeLevel>=NumTool.GetLen(ConfigMgr.Config.friendshipLevelUp)
            or characterData.prestige>=ConfigMgr.Config.friendshipLevelUp[tostring(characterData.prestigeLevel+1)];
    return isMax;
end

this.Leave_Dungeon=function()
    local params=BattlePrepareMgr._enterDungeonParams;
    params.members=teams;
    params.count=curCount;
    local preData={characters={},preLevel=DataMgr.Player.level,preExp=DataMgr.Player.exp}
    for i,v in pairs(teams) do
        preData.characters[v]=DataMgr.Player.characters[v];
    end
    ApiMgr.Request("enter_leave_dungeon",params,true,function(result)
        LuaMgr.HidePanel(UIName.BattleDelegeteSettingViewModel)
        local data=json.decode(result);
        ActivityMgr.RefreshActivityData();
        LuaMgr.ShowLuaPanel(UIName.BattleDelegeteSettlementViewModel,data.result,preData,params.members,params.dungeonId)
    end,function(fail)  end,true)
end



this.UpdateFatigue=function()
    local costIndex=1;
    local records = DataMgr.Player.dungeonRecords[cfgDungeon.id]
    if records~=nil then
        costIndex=costIndex+records.completeCount;
        if costIndex>#cfgDungeon.consumeItem then
            costIndex=#cfgDungeon.consumeItem;
        end
    end
    consume=cfgDungeon.consumeItem[costIndex];
    if consume~=nil then




        if consume.id=="101" then
            maxCount=math.floor(DataMgr.Player.stamina/consume.count);
        else
            local myCount=DataHelper.GetItemCountById(consume.id);
            maxCount=math.floor(myCount/consume.count);
        end
        cfgMaxCount=ConfigMgr.Config.constants.EntrustBattleMax;
        local otherLimitCount=BattlePrepareMgr.GetFastBattleCount(cfgDungeon.id)
        if otherLimitCount~=nil then
            cfgMaxCount=cfgMaxCount>otherLimitCount and otherLimitCount or cfgMaxCount;
            isBattleCostCount=true;
        end
        maxCount=maxCount<=cfgMaxCount and maxCount or cfgMaxCount;
        if limitMaxCount >= 0 then
            maxCount = limitMaxCount > maxCount and maxCount or limitMaxCount
        end
        this.addUINumber.MaxNum = maxCount;
        this.lessenUINumber.MaxNum = maxCount;
        this.Refrush(0)
    end
end



this.CheckTeams=function()
    local teamStr=PlayerPrefs.GetString(DataMgr.Player.uid.."DELEGATE_TEAM");
    if teamStr==nil or teamStr=="" then
        return;
    end
    teams=json.decode(teamStr)
end

this.RegisterCommand=function()
    LuaMgr.AddClick(this.okBtn,obj_command.okBtnCommand);
    LuaMgr.AddClick(this.cancelBtn,obj_command.cancelBtnCommand)
    LuaMgr.AddClick(this.maskBtn,obj_command.cancelBtnCommand)
    LuaMgr.AddClick(this.addStaminaBtn,obj_command.addStaminaCommand)
    LuaMgr.AddClick(this.editorBtn,obj_command.editorBtnCommand)
    LuaMgr.AddUIEventListener(UIEventConst.FatigueReply, this.UpdateFatigue);
    LuaMgr.AddClick(this.maxNumber,obj_command.maxNumberCommand)
    
    
end

this.RemoveRegisterCommand=function()
    LuaMgr.RemoveClick(this.okBtn,obj_command.okBtnCommand);
    LuaMgr.RemoveClick(this.cancelBtn,obj_command.cancelBtnCommand)
    LuaMgr.RemoveClick(this.maskBtn,obj_command.cancelBtnCommand)
    LuaMgr.RemoveClick(this.addStaminaBtn,obj_command.addStaminaCommand)
    LuaMgr.RemoveClick(this.editorBtn,obj_command.editorBtnCommand)
    LuaMgr.RemoveUIEventListener(UIEventConst.FatigueReply, this.UpdateFatigue)
    LuaMgr.RemoveClick(this.maxNumber,obj_command.maxNumberCommand);
end

this.SetDungeonLimit = function()
    limitMaxCount = -1
    if this.vm.behaviour.Params.Length > 1 then
        limitMaxCount = this.vm.behaviour.Params[1]
        local isLimit,limitIndex = ConfigHelper.IsLimitCount(cfgDungeon.id)
        local totalCount = ConfigMgr.Config.constants.LevelWeeklyLimit[limitIndex]
        local limitStr = ConfigMgr.LangGlobal("31154")
        this.limitText.text = string.format(limitStr,limitMaxCount,totalCount)
    end
    SetActive(this.limitRoot,limitMaxCount >= 0)
end

this.ParseData=function()
    this.CheckTarItem();
    this.SetTarItem();
    this.SetAvatarList();

    this.SetRewards();

    this.UpdateFatigue();
   
end


this.CheckTarItem=function()
    local secondDrop={}
    local isWeekEquip,weaponStr,drops=BattlePrepareMgr.AreaDailyWeekEquip(cfgDungeon.id)
    if isWeekEquip then
        for i,v in ipairs(drops) do
            table.insert(secondDrop,{id=v,count=1})
        end
    end
    if #secondDrop==0 then
        secondDrop=cfgDungeon.secondDrop;
    end
    if IsNull(secondDrop) or IsNullOrEmpty(secondDrop) then return end;
    itemMap={}
    for i,v in ipairs(secondDrop) do
        local dropItem=cfgDropMap[v.id]
        if dropItem~=nil and not IsNull(dropItem.items) then
            for p,m in ipairs(dropItem.items) do
                if itemMap[m.id]~=nil and itemMap[m.id].weight>=10000 and m.weight>=10000 then
                    itemMap[m.id].count=itemMap[m.id].count+m.count*v.count;
                else
                    itemMap[m.id]={id=m.id,count=m.count*v.count,weight=m.weight}
                end
            end
        end
    end
    if HeroParameter.TarItem==nil then return end;
    if itemMap[HeroParameter.TarItem.id]==nil then
        HeroParameter.EmptyTarItem()
    end
end


this.SetTarItem=function()
    curCount=1;
    local tarItem=HeroParameter.TarItem
    if tarItem==nil then
        SetActive(this.tarTf.gameObject,false)
        return
    end
    SetActive(this.tarTf.gameObject,true)
    local itemConfig = nil
    local item=GoodsDataItem.New(this.tarItemTf)
        itemConfig = ConfigMgr.Config.itemMap[tarItem.id]
        itemConfig["count0"] = tarItem.count
    item:SetData(1,itemConfig,1,false,Vector3(0.3,0.3,0.3),false,true)
    this.tarNum.text="X"..tarItem.count;
    local drops=cfgDungeon.secondDrop
    if IsNull(drops) or #drops==0 then
        return;
    end
    local everyDropNum=0;
    for i,v in ipairs(drops) do
        if cfgDropMap[v.id]~=nil then
            local items=cfgDropMap[v.id].items
            if not IsNull(items) and #items>0 then
                for p,m in ipairs(items) do
                    if m.id==tarItem.id and m.weight>=10000 then
                        everyDropNum=m.count*v.count;
                    end
                end
                
            end
        end
    end
    if everyDropNum==0 then return end;
    curCount=math.ceil(tarItem.count/everyDropNum);

end

this.SetAvatarList=function()
    this.CheckTeams();
    local characterID=nil;
    local headPath=nil;
    local list={};
    for i=1,6,1 do
            local memberItem=nil;
characterID=teams[tostring(i-1)]

            if characterID ~= nil then
                local curSkin = ""
                if DataMgr.Player.characters[characterID] ~= nil then
                    curSkin = DataMgr.Player.characters[characterID].curSkin
                end
                headPath=ConfigHelper.GetCharacterAvatarPath(characterID, curSkin);
                local characterData=DataMgr.Player.characters[characterID];
                memberItem={
                    isActive=true,
                    headIcon=LuaMgr.GetTexture(headPath),
                    feelingLevel=characterData.prestigeLevel,
                    isMax=characterData.prestigeLevel>=NumTool.GetLen(ConfigMgr.Config.friendshipLevelUp) 
                            or characterData.prestige>=ConfigMgr.Config.friendshipLevelUp[tostring(characterData.prestigeLevel+1)]
                }
            else
                memberItem={
                    isActive=false,
                }
            end
        local listData =UIListData.GetData(this.memberItemObj,"Delegate_FrameItem", memberItem);
        table.insert(list,listData);
    end
    this.memberUIList:SetData(list);
end








































this.UINumberBinder=function()
    this.addUINumber.Callback=function(data,delta,current)
        this.Refrush(1)
    end
    this.lessenUINumber.Callback=function(data,delta,current)
       this.Refrush(-1)
    end
   
end

this.Refrush=function(dir)
    curCount=curCount+dir;
    if curCount<1 then
        curCount=1
        local  tip=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2147"].NameLan);
        this.DelayShowTips(tip);
    end
    if curCount>maxCount then
        if limitMaxCount >= 0 then
            local tip = nil
            if limitMaxCount > maxCount then
                if curCount>ConfigMgr.Config.constants.EntrustBattleMax then
                    tip = ConfigMgr.LangGlobal("2453")
                else
                    tip = ConfigMgr.LangGlobal("2454")
                end
            else
                tip = ConfigMgr.LangGlobal("31155")
            end
            this.DelayShowTips(tip)
        else
            if dir~=0 then
                if  curCount>ConfigMgr.Config.constants.EntrustBattleMax then
                    local  tip=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2453"].NameLan);
                    this.DelayShowTips(tip);
                else
                    local  tip=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2454"].NameLan);
                    if isBattleCostCount then
                        tip=ConfigMgr.LangGlobal("7510");
                    end
                    this.DelayShowTips(tip);
                end

            end
        end
        curCount=maxCount
    end;
    this.RefrushRewardsInfo();
end



this.RefrushRewardsInfo=function()

    local remainStamina=DataMgr.Player.stamina;
    if consume.id=="101" then
        remainStamina=DataMgr.Player.stamina-consume.count*curCount;
    else
        remainStamina=DataHelper.GetItemCountById(consume.id)-consume.count*curCount;
    end
    this.delegateCount.text=curCount;
    this.curStamina.text=tostring(DataMgr.Player.stamina);
    this.remainStamina.text=tostring(remainStamina);


    this.rewardsScrollView:Clear(false);
    UIScrollView.ClearItem("Delegate_GoodsItemGroup")
    this.SetRewards();
end


this.DelayShowTips=function(tip)
    LuaMgr.DelayFrame(function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,tip);
    end)
end

this.SetRewards=function(isRest)
    if NumTool.GetLen(itemMap)==0 then return end;
    local ItemList={}
    for i,v in pairs(itemMap) do
        local item={
            id=v.id,
            count=v.count*curCount,
            isPossible=v.weight<10000,
            rare=ConfigMgr.Config.itemMap[v.id].rare
        }
        local width=64;
        local itemData=UIScrollData.GetData(this.rewardItemObj,"Delegate_GoodsItemGroup",width,64,item);
        table.insert(ItemList,itemData);
    end
    
    
    table.sort(ItemList,function(a, b)
        if a.data.rare~=b.data.rare then
            return a.data.rare>b.data.rare;
        else
            return not a.data.isPossible and b.data.isPossible
        end
    end)
    
    this.rewardsScrollView:SetParams(370,90)
    this.rewardsScrollView:SetData(ItemList,false);
    this.rewardsScrollView.content.anchoredPosition=Vector2(this.rewardsScrollView.content.anchoredPosition.x,0);
end

return vm({
    data = data,
    command = command,
    hook = hook
})
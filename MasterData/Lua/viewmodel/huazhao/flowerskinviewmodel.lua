





local this = {vm=nil,
              spineCharacter=nil,
              characterId="V0049"};

local cfgSkinQE={}
local dataEQ={};
local cfgFullSkin={}
local curIndex=0;
local isInterval=false;
local data = {

    cardList = { 0.0,
                 0.0,
                 0.0,
                 0.0,
                 0.0,
                 0.0,
                 0.0,
    };
    chargeBool = false;
    isGrayCharge=false;
    rewardBool = false;
    spineBool = false;
    isLock=false;
    animaName = "";
    skinNameText = "";
    iconCost = DefaultTexture,
    iconCount = "";
    bodyPath = "";

}

local command = {

    skinDebrisBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local reward=cfgSkinQE[curIndex]
            if isInterval or reward==nil then return end;
            if not this.IsCharge() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10204"))
                return;
            end
            if not DataExHelper.EX_CheckLocalRunning(ActivityKey.huazhao) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10211"));
                return
            end
            isInterval=true;
            DOTWeen.To(function() return 0.0  end,function(value)
                this.vm.data.cardList[curIndex]=value;
            end,1.0,1.2).onComplete=function()
                DataExHelper.EX_ShopConvert(reward.id,1,function()
                        this.ParseData();
                end)
            end
        end
                
          
            
        
    },
    SkinRewardBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          if not DataExHelper.EX_CheckLocalRunning(ActivityKey.huazhao) then
              LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("10211"));
              return
          end
          DataExHelper.EX_GetAward(cfgFullSkin.id,function()
              this.ParseData();
          end)
      end
    },
    fullSkinBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.ShowFullSkinFX();
        end
    }

}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.spineCharacter =vm.behaviour.transform:Find("root/Middle/Content/spine/character/Body"):GetComponent("UISpineCharacter");
        print("before_awake");
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            this.ParseConfig();
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
    end,
}

this.ParseConfig=function()
    local skinQE=DataExHelper.Check_ConfigQuestEventByText("skin")
    for i,v in ipairs(skinQE) do
        if v.eventType~=106 then
            cfgFullSkin=v;
            table.remove(skinQE,i);
        end
    end
    table.sort(skinQE,function(a,b) return tonumber(a.id)<tonumber(b.id)  end);
    cfgSkinQE=skinQE;
end

this.ParseData=function()
    isInterval=false;
    curIndex=1;
    dataEQ=DataMgr.Player.quests;
    for i,v in ipairs(cfgSkinQE) do
        local state=this.CheckSkinState(v)
        this.vm.data.cardList[i]=state>2 and 1.0 or 0.0
        if state>2 then
            curIndex=curIndex+1;
        end
    end
    this.vm.data.isLock=curIndex==1;
    local skinState=dataEQ[cfgFullSkin.id].state
    this.vm.data.chargeBool=curIndex<=7
    this.vm.data.rewardBool=curIndex>7 and skinState<3;
    this.vm.data.spineBool=curIndex>7 and skinState==3;
    if curIndex<=7 then
        this.vm.data.isGrayCharge=not this.IsCharge();
        local costId=cfgSkinQE[curIndex].cost[1].id
        this.vm.data.iconCost=ConfigHelper.GetItemTexture(costId)
        local itemName=LuaMgr.GetLangText(ConfigMgr.Config.itemMap[costId].nameLan)
        this.vm.data.iconCount=itemName.."X"..DataHelper.GetItemCountById(costId);
    end
    if skinState>=2 then
        this.vm.data.skinNameText=LuaMgr.GetLangText(cfgFullSkin.remarksLan);
    end
    if skinState==3 then
        this.SetCharacter()
    end
    
end


this.IsCharge=function()
    local cost=cfgSkinQE[curIndex].cost[1]
    local myCount=DataHelper.GetItemCountById(cost.id);
    return myCount>=cost.count;
end

this.SetCharacter=function()
    local skinId = this.characterId.."003";
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, this.characterId,skinId);
    if path ~= "" then
        this.vm.data.bodyPath=path;
    end
  
end



this.CheckSkinState=function(shop)
    local state=0;
    local dataTask= dataEQ[shop.id];
    if dataTask.state==1 then
        local re= this.CheckExchange(shop);
        if re then
            state=1;
        else
            state=2;
        end
    else
        state=dataTask.state;
    end
    return state;
    
end


this.CheckExchange=function(shop)
    if shop.cost==nil or #shop.cost==0 then
        return false;
    end
    for i,v in ipairs(shop.cost) do
        local myCount=DataHelper.GetItemCountById(v.id)
        if myCount<v.count then
            return false;
        end
    end
    return true;
end


return vm({
    data = data,
    command = command,
    hook = hook
})
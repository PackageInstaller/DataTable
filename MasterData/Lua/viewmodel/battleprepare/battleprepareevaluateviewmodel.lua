local this = {vm=nil};

local colorRed=UnityEngine.Color(139/255,52/255,45/255,255/255);
local colorGreen=UnityEngine.Color(37/255,107/255,105/255,255/255);
local cfgDungeon=nil;
local dataDungeonRecord=nil;
local data = {
  evaluateList={
      {
          evaIcon=DefaultSprite,
          info="",
          infoAplha=1.0,
          tag="",
          count="",
          rare=DefaultSprite,
          lineColor=colorRed,
          isPass=false,
          rewardBool=false,
          itemList={{}},
      }
  }
}

local command = {
    closeCommand={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
           LuaMgr.HidePanel(UIName.BattlePrepareEvaluateViewModel);
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        local dungeonId=vm.behaviour.Params[0]
        cfgDungeon=ConfigMgr.Config.dungeonMap[dungeonId];
        dataDungeonRecord=DataMgr.Player.dungeonRecords[dungeonId];
        this.ParseData();
    end,
    before_deactive = function(vm)
       
    end,
}

this.ParseData=function()
    this.SetEvaluateData();
end


this.SetEvaluateData=function()
    local showTexts=NumTool.split(LuaMgr.GetLangText(cfgDungeon.rateShowLan),";")
    local re=cfgDungeon.rateAward~=json.null ;
    local rewards=re and cfgDungeon.rateAward or {"","",""};

    this.vm.data.evaluateList={};
    local list={};
    for i,v in ipairs(showTexts) do
        local goodlist={}
        local reward=rewards[i];
        if reward~="" then
            local item =ConfigMgr.Config.itemMap[reward.id];
            local rewardItem={id=reward.id,sizeDelta = Vector2(44, 44),isCount=true,
                              rare=LuaMgr.GetSprite("ItemRare", "itemRare" ..item.rare),
                              icon=LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. reward.id ..".png");
                              scale = Vector3(0.35, 0.35, 0.35), isClick = true}
            table.insert(goodlist,rewardItem);
        end
        local vaIconName,rating=this.GetDungeonDecordRating(i);
        local pass=i>=rating;
        local evaluateItem={
            evaIcon=LuaMgr.GetSprite("AreaMapRes",vaIconName),
            info=showTexts[i];
            isPass=pass;
            count=LuaMgr.NumFormat(reward.count);
            infoAplha=pass and 0.3 or 1.0;
            tag=pass and string.format("<color=#256b69>%s</color>",LuaMgr.GetLangText("BattlePrepareEvaluateViewModel_0"))
                    or string.format("<color=#8b342d>%s</color>",LuaMgr.GetLangText("BattlePrepareEvaluateViewModel_1")),
            rare=pass and LuaMgr.GetSprite("AreaMapRes","ui_zqzb_pjjl_ydc")
            or LuaMgr.GetSprite("AreaMapRes","ui_zqzb_pjjl_wdc");
            lineColor=isPass and colorGreen or colorRed,
            rewardBool=reward~="",
            itemList=goodlist,
        }
        table.insert(list,evaluateItem);
    end
    this.vm.data.evaluateList=list;
end


this.GetDungeonDecordRating=function(index)
    local vaIcon=nil;
    local rating=4;
    if index==1 then
        vaIcon="ui_zqzb_pj_S";
    elseif index==2 then
        vaIcon="ui_zqzb_pj_A";
    elseif index==3 then
        vaIcon="ui_zqzb_pj_B";
    end
    if dataDungeonRecord~=nil then
        if dataDungeonRecord.historyRating=="S" then
            rating=1;
        elseif dataDungeonRecord.historyRating=="A" then
            rating=2;
        elseif dataDungeonRecord.historyRating=="B" then
            rating=3;
        end
    end
    return vaIcon,rating;
end


return vm({
    data = data,
    command = command,
    hook = hook
})
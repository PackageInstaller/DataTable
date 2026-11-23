





require("ViewModel/Travel/Travel_LevelItem")

local this = {vm=nil,
              levelItemObj=nil,
              levelUIList=nil,
              itemUIList=nil,
};

local itemObjList={};

local levelPos={Vector2(-465,-185),Vector2(-270,-340),Vector2(-76,-125),Vector2(108,-282),Vector2(316,-94),Vector2(498,-221)}
local cfgActLevel={};
local levelList={};
local prepareIndex=nil;
local prepareAnimator=nil;
local fxBattleEasy=nil;
local fxBattleNor=nil;
local fxBattleDiff=nil;
local fxBattleAbyss=nil;
local fxText=nil;
local isCloseing=false;
local curGroupId=nil;



local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goPrepare = nil;
local Right = nil;
local ScrollView = nil;
local tranLevelContent = nil;
local tranItemContent = nil;
local txtFreeStamina = nil;
local txtName = nil;
local txtInfo = nil;
local imgName = nil;
local btnBattleEasy = nil;
local btnBattleNormal = nil;
local btnBattleDifficulty = nil;
local btnBattleAbyss=nil;
local txtEasy=nil;
local txtNormal=nil;
local txtdifficulty=nil;
local txtAbyss=nil;
local btnClose=nil;
local textWarn=nil;
local goLevelPass=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goPrepare = uiLink:Get("goPrepare");
    Right = uiLink:Get("Right");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranLevelContent = uiLink:Get("tranLevelContent"):GetComponent("RectTransform");
    tranItemContent = uiLink:Get("tranItemContent"):GetComponent("RectTransform");
    txtFreeStamina = uiLink:Get("txtFreeStamina"):GetComponent("Text");
    txtName = uiLink:Get("txtName"):GetComponent("Text");
    txtInfo = uiLink:Get("txtInfo"):GetComponent("Text");
    imgName = uiLink:Get("imgName"):GetComponent("Image");
    btnBattleEasy = uiLink:Get("btnBattleEasy"):GetComponent("Button");
    btnBattleNormal = uiLink:Get("btnBattleNormal"):GetComponent("Button");
    btnBattleDifficulty = uiLink:Get("btnBattleDifficulty"):GetComponent("Button");
    btnBattleAbyss=uiLink:Get("btnBattleAbyss"):GetComponent("Button");
    txtEasy=uiLink:Get("txtEasy"):GetComponent("Text");
    txtNormal=uiLink:Get("txtNormal"):GetComponent("Text");
    txtdifficulty=uiLink:Get("txtdifficulty"):GetComponent("Text");
    txtAbyss=uiLink:Get("txtAbyss"):GetComponent("Text");
    textWarn=uiLink:Get("textWarn"):GetComponent("Text");
    btnClose= uiLink:Get("btnClose"):GetComponent("Button");
    goLevelPass=uiLink:Get("goLevelPass");
    this.AddRegister(uiLink)
    
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goPrepare = nil;
    Right = nil;
    ScrollView = nil;
    tranLevelContent = nil;
    tranItemContent = nil;
    txtFreeStamina = nil;
    txtName = nil;
    txtInfo = nil;
    imgName = nil;
    btnBattleEasy = nil;
    btnBattleNormal = nil;
    btnBattleDifficulty = nil;
    btnBattleAbyss=nil;
    txtAbyss=nil;
    textWarn=nil;
    goLevelPass=nil;
end


this.AddRegister=function(uiLink)
    prepareAnimator=goPrepare:GetComponent("Animator");
    fxBattleEasy=btnBattleEasy.transform:Find("easyFire").gameObject
    fxBattleNor=btnBattleNormal.transform:Find("norFire").gameObject
    fxBattleDiff=btnBattleDifficulty.transform:Find("diffFire").gameObject
    fxBattleAbyss=btnBattleAbyss.transform:Find("abyss").gameObject
    fxText=goPrepare.transform:Find("bg/fxText").gameObject;
    
    uiLink:AddClickEvent("btnClose",function()
        isCloseing=true;
        prepareAnimator:Play("ani_TravelevelPanel_goPreparedisapper")
        SetActive(fxBattleNor,false)
        SetActive(fxBattleEasy,false)
        SetActive(fxBattleDiff,false)
        SetActive(fxBattleAbyss,false)
        coroutine_runner.start(function()
            coroutine_runner.wait(0.35)
            SetActive(goPrepare,false);
            isCloseing=false;
        end)
    end)
    uiLink:AddClickEvent("btnBattleEasy",function()
        this.ClickStart(1);
    end)
    uiLink:AddClickEvent("btnBattleNormal",function()
        this.ClickStart(2);
    end)
    uiLink:AddClickEvent("btnBattleDifficulty",function()
        this.ClickStart(3);
    end)
    uiLink:AddClickEvent("btnBattleAbyss",function()
        this.ClickStart(4);
    end)
end



local data = {
  
}

local command = {
    
}

this.ClickLevel=function(groupId)
    if isCloseing or  goPrepare.activeSelf and  curGroupId==groupId then return end;
    curGroupId=groupId
    HeroParameter.SaveTravelLevelGroupId(groupId);
    local index=nil;
    for i,v in ipairs(this.levelUIList.itemList) do
        v:SetSelectStatue(v.data.groupId==groupId);
        if v.data.groupId==groupId then
            index=i;
        end
    end
    levelList=cfgActLevel[groupId]
    prepareIndex=1;
    for i,v in ipairs(levelList) do
        if v.eventParam==DataMgr.Player.travel.LastDungeon then
            prepareIndex=i;
            break
        end
    end
    this.SetBattlePrepare(index);
    
end

this.ClickStart=function(index)
    if prepareIndex~=index then
        prepareIndex=index;
        this.SetBattleText();
        this.SetBattlePrepare(nil)
    else




        local dungeonId=levelList[prepareIndex].eventParam
        BattlePrepareMgr.EnterBattlePrepare(dungeonId,dungeonId,BattlePrepareMgr.BattleType.Travel);
    end
end


local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour)
        this.levelItemObj = vm.behaviour.transform:Find("template/levelItem").gameObject;
        this.levelUIList = UIListView.New(tranLevelContent)
        this.itemUIList = UIListView.New(tranItemContent);

    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            cfgActLevel={}
            local actEventlist = ConfigMgr.Config.activityMapEventList
            for i, v in ipairs(actEventlist) do
                if v.area == "Travel" and v.type == 2 and not IsNullOrEmpty(v.groupId) then
                    if cfgActLevel[v.groupId] == nil then
                        cfgActLevel[v.groupId] = {};
                    end
                    table.insert(cfgActLevel[v.groupId], v);
                end
            end
            SetActive(goPrepare, false);
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end 
        this.ClearItemsObj(0)
    end,
    before_destroy=function(vm)
        this.Clear();
    end
}



this.ParseData=function()
    isCloseing=false;


    this.SetLevelList();
    if this.vm.behaviour.IsPop then
        local groupId=HeroParameter.travelLevelGroupId;
        if groupId~=nil then
            this.ClickLevel(groupId);
        end
    else
        HeroParameter.EmptyTravelLevelGroupId();
    end
end

this.SetLevelList=function()
    local list={}
    local keyList={};
    for i,v in pairs(cfgActLevel) do
        table.insert(keyList,i);
    end
    table.sort(keyList,function(a, b) return tonumber(a)<tonumber(b) end)
    
    for i,v in ipairs(keyList) do
        local levelItem={
            groupId=v,
            index=i,
            pos=levelPos[i],
            levelClick=this.ClickLevel,
            isDone=this.CheckLocPass(v);
        }
        local levelData=UIListData.GetData(this.levelItemObj,"Travel_LevelItem",levelItem);
        table.insert(list,levelData);
    end
    this.levelUIList:SetData(list)
end



this.SetBattlePrepare=function(index)
    SetActive(goPrepare,true);
    prepareAnimator:Play("ani_TravelevelPanel_goPrepareapper")








    this.SetBattleText();
    local level=levelList[prepareIndex];
    if index~=nil then
        imgName.sprite=LuaMgr.GetSprite("Travel","ui_lx_lxwl_lxzb_ gk_tczp"..index);
    end
    txtName.text=LuaMgr.GetLangText(level.namelan);
txtInfo.text=LuaMgr.GetLangText(level.descriptionlan);
    local dungeon=ConfigMgr.Config.dungeonMap[level.eventParam];
    local isPass=this.CheckDungeonPass(dungeon.id)
    SetActive(goLevelPass,isPass);
    if dungeon==nil or IsNullOrEmpty(dungeon.firstDropShow)  then return end;
    local dropShow=dungeon.firstDropShow;
    local itemIds=NumTool.split(dropShow,";");
    this.ClearItemsObj(#itemIds);
    for i,v in ipairs(itemIds) do
        if itemObjList[i]==nil then
            itemObjList[i]=GoodsDataItem.New(tranItemContent)
        end
        SetActive(itemObjList[i].transform.gameObject,true)
        local itemConfig = ConfigMgr.Config.itemMap[v]
        itemConfig["count0"] =0
        itemObjList[i]:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,0.5),false,true)
    end
end

this.ClearItemsObj=function(count)
    for i,v in ipairs(itemObjList) do
        if i>count then
            SetActive(v.transform.gameObject,false);
        end
    end
end


this.SetBattleText=function()
    txtEasy.text=1==prepareIndex and LuaMgr.GetLangText("TravelLevelViewModel_0") or LuaMgr.GetLangText("TravelLevelViewModel_6");
    txtNormal.text=2==prepareIndex and LuaMgr.GetLangText("TravelLevelViewModel_2") or LuaMgr.GetLangText("TravelLevelViewModel_1");
    txtdifficulty.text=3==prepareIndex and LuaMgr.GetLangText("TravelLevelViewModel_4") or LuaMgr.GetLangText("TravelLevelViewModel_3");
    txtAbyss.text=4==prepareIndex and LuaMgr.GetLangText("TravelLevelViewModel_4") or LuaMgr.GetLangText("TravelLevelViewModel_5");
    SetActive(fxBattleEasy,1==prepareIndex)
    SetActive(fxBattleNor,2==prepareIndex)
    SetActive(fxBattleDiff,3==prepareIndex)
    SetActive(fxBattleAbyss,4==prepareIndex)
    SetActive(fxText,false)
    SetActive(fxText,true);
end

this.CheckLocPass=function(key)
    local list=cfgActLevel[key]
    for i,v in ipairs(list) do
        if not this.CheckDungeonPass(v.eventParam) then
            return false;
        end
    end
    return true
end

this.CheckDungeonPass=function(dungeonId)
    return DataMgr.Player.dungeonRecords[dungeonId]~=nil and DataMgr.Player.dungeonRecords[dungeonId].completeCount>0;
end

return vm({
    data = data,
    command = command,
    hook = hook
})
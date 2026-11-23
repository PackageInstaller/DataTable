




require("ViewModel/Delegate/Delegate_FrameItem")
require("ViewModel/Delegate/DelegateHero_HeadList")
require("ViewModel/Delegate/DelegateHero_HeadItem")

local this = {vm=nil,
              memberItemObj=nil,
              memberUIList=nil,
              heroListItemObj=nil,
              heroItemObj=nil,
              heroScrollView=nil,
              
};



local teams={}
local battleList={}
local sortType=1;
local sortDir=1;
local charactersData={};


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goScrollView = nil;
local Right = nil;
local btnMask = nil;
local btnAuto = nil;
local btnConfirm = nil;
local btnCancel = nil;
local tranContent = nil;
local ScrollbarVertical = nil;
local callBack=nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goScrollView = uiLink:Get("goScrollView");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnAuto = uiLink:Get("btnAuto"):GetComponent("Button");
    btnConfirm = uiLink:Get("btnConfirm"):GetComponent("Button");
    btnCancel = uiLink:Get("btnCancel"):GetComponent("Button");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    this.AddRegiset(uiLink)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goScrollView = nil;
    Right = nil;
    btnMask = nil;
    btnAuto = nil;
    btnConfirm = nil;
    btnCancel = nil;
    tranContent = nil;
    ScrollbarVertical = nil;

end


this.AddRegiset=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.BattleDelegeteHeroViewModel)
        LuaMgr.ShowLuaPanel(UIName.BattleDelegeteSettingViewModel)
    end)
    uiLink:AddClickEvent("btnAuto",function()
        this.AutoEditorBattleList();
    end)
    uiLink:AddClickEvent("btnConfirm",function()
        for i,v in ipairs(battleList) do
            if this.CheckPrestigeMax(v.id) then
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("2460"),this.SaveTeams,nil);
                return
            end
        end
        this.SaveTeams();
    end)
    uiLink:AddClickEvent("btnCancel",function()
        LuaMgr.HidePanel(UIName.BattleDelegeteHeroViewModel)
    end)
end


local data={
    topList={
        {isOn=false,sortScale=Vector3.zero},
        {isOn=false,sortScale=Vector3.zero},
        {isOn=false,sortScale=Vector3.zero}
    }
}

local command={
    topTypeBtnCommand={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
           local index=tonumber(param);
            sortDir=1;
            sortType=index
            this.SetCharacterData();
            this.SetSortType();
        end
    },
    topSortBtnCommand={
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            sortDir=sortDir>0 and -1 or 1
            this.SetCharacterData();
            this.SetSortBigOrSmall();
        end
    }
}



this.AutoEditorBattleList=function()
    battleList={}
    this.AutoSort();
    for i=1,6,1 do
        if i<=#charactersData then
            table.insert(battleList,{id=charactersData[i].id,loc=#battleList})
            charactersData[i].activeNum=i;
        end
    end
    this.SetAvatarList();
    this.SetCharacterScrollView();
end



this.SaveTeams=function()
    local action=function()
        local battleMap={}
        for i,v in ipairs(battleList) do
            battleMap[tostring(i-1)]=v.id;
        end
        local json=json.encode(battleMap);
        PlayerPrefs.SetString(DataMgr.Player.uid.."DELEGATE_TEAM",json);
        if callBack~=nil then
            callBack();
        end
        LuaMgr.HidePanel(UIName.BattleDelegeteHeroViewModel)
    end
    action();
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.memberUIList = UIListView.New(tranContent);
        this.memberItemObj=vm.behaviour.transform:Find("template/frameItem").gameObject;
        this.heroScrollView=UIScrollView.New(goScrollView);
        this.heroListItemObj=vm.behaviour.transform:Find("template/HeroList").gameObject;
        this.heroItemObj=vm.behaviour.transform:Find("template/HeroItem").gameObject;
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>0 then
                teams=vm.behaviour.Params[0]
                callBack=vm.behaviour.Params[1]
                battleList={}
                for i,v in pairs(teams) do
                    table.insert(battleList,{loc=tonumber(i),id=v})
                end
                table.sort(battleList,function(a, b) return a.loc<b.loc end)
                sortType=1;
                sortDir=1;
                charactersData={}
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.heroScrollView:Clear(true)
    end,
    before_destroy=function()
        this.Clear()
        UIListView.ClearItem("Delegate_FrameItem")
        UIListView.ClearItem("DelegateHero_HeadItem")
        UIScrollView.ClearItem("DelegateHero_HeadList")
        this=nil
    end
}


this.ParseData=function()
    this.SetAvatarList();
    this.SetCharacterData();
    this.SetSortType();
end

this.SetCharacterData=function()
    charactersData={}
    local characters=table.Copy(DataMgr.Player.characters);
    for i,v in pairs(characters) do
        local config=ConfigMgr.Config.characterTable[v.id];
        v.name=LuaMgr.GetLangText(config.namelan);
        v.rare=HeroMgr.GetHeroNowRare(i);
        v.activeNum=this.GetActiveNum(v);
        table.insert(charactersData,v);
    end
end

this.GetActiveNum=function(character)
    local num=999
    for i,v in ipairs(battleList) do
        if v.id==character.id then
            return i;
        end
    end
    return num;
end

this.SetSortType=function()
    for i,v in ipairs(this.vm.data.topList) do
        v.isOn=i==sortType;
        v.sortScale=i==sortType and Vector3(1,1,1) or Vector3.zero;
    end
    this.SetSortBigOrSmall();
end

this.SetSortBigOrSmall=function()
    this.vm.data.topList[sortType].sortScale=sortDir>0 and Vector3(1,1,1) or Vector3(1,-1,1);
    if sortType==1 then
        this.SortRare();
    elseif sortType==2 then
        this.SortLevel();
    elseif sortType==3 then
        this.SortPrestigeLevel();
    end
    this.SetCharacterScrollView();
end

this.AutoSort=function()
    local onlineMap={}
    for i,v in pairs(DataMgr.Player.teams["0"].members) do
        if not this.CheckPrestigeMax(v) then
            onlineMap[v]=tonumber(i);
        end
    end
    for i,v in ipairs(charactersData) do
        if onlineMap[v.id]~=nil then
            v.activeNum=onlineMap[v.id];
        else
            v.activeNum=999;
        end
    end
    table.sort(charactersData,function(a, b)
        if a.activeNum==b.activeNum then
            if a.rare==b.rare then
                if a.level==b.level then
                    return a.id<b.id
                else
                    return a.level>b.level
                end
            else
                return a.rare>b.rare
            end
        else
           return a.activeNum<b.activeNum
        end
    end)
    local maxList={}

    for i = #charactersData, 1, -1 do
        local character = charactersData[i]
        if this.CheckPrestigeMax(character.id) then
            table.insert(maxList, 1, character);
            table.remove(charactersData, i);
        end
    end
    






    for i,v in ipairs(maxList) do
        table.insert(charactersData,v);
    end
end
  

this.SortRare=function()
    table.sort(charactersData,function(a, b)
        if a.activeNum==b.activeNum then
            if sortDir>0 then
                if a.rare==b.rare then
                    return a.id<b.id
                else
                    return a.rare>b.rare
                end
            else
                if a.rare==b.rare then
                    return a.id>b.id
                else
                    return a.rare<b.rare
                end
            end
        else
            return a.activeNum<b.activeNum;
        end
    end)
end

this.SortLevel=function()
    table.sort(charactersData,function(a, b)
        if a.activeNum==b.activeNum then
            if sortDir>0 then
                if a.level==b.level then
                    return a.id<b.id
                else
                    return a.level>b.level
                end
            else
                if a.level==b.level then
                    return a.id>b.id
                else
                    return a.level<b.level
                end
            end
        else
            return a.activeNum<b.activeNum;
        end
    end)
end

this.SortPrestigeLevel=function()
    table.sort(charactersData,function(a, b)
        if a.activeNum==b.activeNum then
            if sortDir>0 then
                if a.prestigeLevel==b.prestigeLevel then
                    return a.id<b.id
                else
                    return a.prestigeLevel>b.prestigeLevel
                end
            else
                if a.prestigeLevel==b.prestigeLevel then
                    return a.id>b.id
                else
                    return a.prestigeLevel<b.prestigeLevel
                end
            end
        else
            return a.activeNum<b.activeNum;
        end
    end)
end

this.CheckPrestigeMax=function(id)
    local characterData=DataMgr.Player.characters[id];
    local isMax=characterData.prestigeLevel>=NumTool.GetLen(ConfigMgr.Config.friendshipLevelUp)
            or characterData.prestige>=ConfigMgr.Config.friendshipLevelUp[tostring(characterData.prestigeLevel+1)];
    return isMax;
end

this.SetAvatarList=function()
    local character=nil;
    local headPath=nil;
    local list={};
    for i=1,6,1 do
            local memberItem=nil;
            character=battleList[i];
            if character ~= nil then
                headPath=ConfigHelper.GetCharacterAvatarPath(character.id,DataMgr.Player.characters[character.id].curSkin);
                local characterData=DataMgr.Player.characters[character.id];
                memberItem={
                    index=i,
                    isActive=true,
                    headIcon=LuaMgr.GetTexture(headPath),
                    feelingLevel=characterData.prestigeLevel,
                    isMax=this.CheckPrestigeMax(character.id),
                    callBack=this.AvatarClickCallBack;
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

this.AvatarClickCallBack=function(index)
    table.remove(battleList,index);
    this.SetCharacterData();
    this.SetSortType();
    this.SetCharacterScrollView();
    this.SetAvatarList();
end

this.SetCharacterScrollView=function()
    this.heroScrollView:Clear(true)
    local rowNum=math.ceil(#charactersData/5);
    local list={}
    for i=1,rowNum do
        local headList={}
        local loc=0;
        for j=5*(i-1)+1,5*i do
            if j<=#charactersData then
                loc=loc+1;
                local headPath=ConfigHelper.GetCharacterAvatarPath(charactersData[j].id,DataMgr.Player.characters[charactersData[j].id].curSkin);
                local headItem={
                    headIcon=LuaMgr.GetTexture(headPath),
                    name=charactersData[j].name,
                    activeNum=charactersData[j].activeNum;
                    level=charactersData[j].level,
                    prestigeLevel=charactersData[j].prestigeLevel,
                    isMax= this.CheckPrestigeMax(charactersData[j].id);
                    rare=charactersData[j].rare,
                    indexData={row=i,col=loc,index=j},
                    heroItemObj=this.heroItemObj,
                    callBack=this.HeadClickCallback,
                }
                table.insert(headList,headItem);
                this.InitBattleList(charactersData[j].id,headItem)
            end
        end
        local headData=UIScrollData.GetData(this.heroListItemObj,"DelegateHero_HeadList",485,110,headList);
        table.insert(list,headData);
    end
    this.heroScrollView:SetParams(510,290)
    this.heroScrollView:SetData(list,true);
end

this.InitBattleList=function(id,headItem)
    for i,v in ipairs(battleList) do
        if v.id==id then
            v.indexData=headItem.indexData;
            v.loc=nil;
        end
    end
end


this.HeadClickCallback=function(indexData,isOn)
    if isOn and #battleList>=6 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("2168"));
        return
    end
    if isOn then
        table.insert(battleList,{id=charactersData[indexData.index].id,indexData=indexData});
        this.heroScrollView.itemMap[indexData.row].data[indexData.col].activeNum=#battleList
        this.heroScrollView.itemMap[indexData.row]:SetIndex(indexData.col,true)
        charactersData[indexData.index].activeNum=#battleList
    else
        charactersData[indexData.index].activeNum=999;
        this.heroScrollView.itemMap[indexData.row].data[indexData.col].activeNum=999
        this.heroScrollView.itemMap[indexData.row]:SetIndex(indexData.col,false)
        for i,v in ipairs(battleList) do
            if v.id==charactersData[indexData.index].id then
                table.remove(battleList,i);
            end
        end

        for i,v in ipairs(battleList) do
            if this.heroScrollView.itemMap[v.indexData.row]~=nil then
                this.heroScrollView.itemMap[v.indexData.row].data[v.indexData.col].activeNum=i;
                this.heroScrollView.itemMap[v.indexData.row]:SetIndex(v.indexData.col,true)
            end
        end
    end
    this.SetAvatarList();
end

return vm({
    data = data,
    command = command,
    hook = hook
})
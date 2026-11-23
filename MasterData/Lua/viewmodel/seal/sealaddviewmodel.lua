




require("ViewModel/Seal/SealAdd_Group")
require("ViewModel/Seal/SealAdd_Item")

local this = {vm=nil,
              topBarItemObj=nil,
              sealItemObj=nil,
              sealGroupObj=nil,
              topBarUIList=nil,
              sealScrollViewList=nil,
              friendlyIdList={}
};

local maxCount=17;
local curBarIndex=nil;
local cfgCharacterPreferences=nil;
local maxFavorLevel=nil;
local characterData=nil;
local sealIndex=nil;
local lastIndexData=nil;
local cacheIdList={}

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goScrollView = nil;
local Right = nil;
local ScrollView = nil;
local tranContent = nil;
local btnClear = nil;
local btnConfrim = nil;
local textCount = nil;
local goFree=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goScrollView = uiLink:Get("goScrollView");
    Right = uiLink:Get("Right");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    btnClear = uiLink:Get("btnClear"):GetComponent("Button");
    btnConfrim = uiLink:Get("btnConfrim"):GetComponent("Button");
    textCount = uiLink:Get("textCount"):GetComponent("Text");
    goFree=uiLink:Get("goFree");
    this.AddRegister(uiLink)
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goScrollView = nil;
    Right = nil;
    ScrollView = nil;
    tranContent = nil;
    btnClear = nil;
    btnConfrim = nil;
    textCount = nil;
    goFree=nil;

end

local data={}
local command={}

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnClear",function()
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,ConfigMgr.LangGlobal("15801"),function()
            this.friendlyIdList={};
            this.SetSealList();
        end,nil);
    end)
    uiLink:AddClickEvent("btnConfrim",function()
        this.MergeData();
        LuaMgr.Back();
    end)
end



this.MergeData=function()
    if #this.friendlyIdList>0 then
        if sealIndex==nil then
            cacheIdList=this.friendlyIdList;
            
        else
            cacheIdList[sealIndex]=this.friendlyIdList[1]
        end
    else
        if sealIndex~=nil then
            cacheIdList[sealIndex]="";
        else
           this.ClearData();
        end
    end
    HeroParameter.sealChangeList=cacheIdList;
end


this.ClearData=function()
    for i=1,#cacheIdList,1 do
        cacheIdList[i]="";
    end
end


this.ClickTopBarCallBack=function(index)
    if index==curBarIndex then return end;
    this.topBarUIList.itemList[curBarIndex]:SetActive(false)
    this.topBarUIList.itemList[index]:SetActive(true)
    curBarIndex=index;
    this.SetSealList();
end


local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.topBarItemObj=vm.behaviour.transform:Find("template/topBarItem").gameObject;
        this.sealItemObj=vm.behaviour.transform:Find("template/sealItem").gameObject;
        this.sealGroupObj=vm.behaviour.transform:Find("template/sealGroup").gameObject;
        this.topBarUIList=UIListView.New(tranContent);
        this.sealScrollViewList=UIScrollView.New(goScrollView);
    end,
    before_active = function(vm)
        print("before_active");
        if (vm.behaviour.Params ~= nil) then
            curBarIndex=1;
            characterData={}
            maxFavorLevel=NumTool.GetLen(ConfigMgr.Config.friendshipLevelUp);
            cfgCharacterPreferences=ConfigMgr.Config.characterPreferences;
            sealIndex=nil;
            lastIndexData=nil;
            vm.behaviour:UpdateTopBar("", function()
                HeroParameter.sealChangeList=cacheIdList;
                LuaMgr.Back();
            end);
            if vm.behaviour.Params.Length>0 then
                cacheIdList=vm.behaviour.Params[0]
                if vm.behaviour.Params.Length>1 then
                    sealIndex=vm.behaviour.Params[1];
                    if cacheIdList[sealIndex]~="" then
                        this.friendlyIdList={cacheIdList[sealIndex]};
                    else
                        this.friendlyIdList={};
                    end
                else
                    this.friendlyIdList= {};
                    for i,v in ipairs(cacheIdList) do
                        if v~="" then
                            table.insert(this.friendlyIdList,v);
                        end
                    end
                end
            end
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end;
        this.topBarUIList:Clear();
        this.sealScrollViewList:Clear();
      
    end,
    before_destroy=function()
        this.Clear()
        UIListView.ClearItem("SealAdd_Item")
        UIListView.ClearItem("SealAdd_GroupItem")
        UIScrollView.ClearItem("SealAdd_Group")
    end
}

this.ParseData=function()
    this.SetTopBarList()
    this.SetSealList();
end


this.SetTopBarList=function()
    local list={}
    local barName=ConfigMgr.LangGlobal("15805");
    local topBarNames=NumTool.split(barName,"_");
    for i,v in ipairs(topBarNames) do
        local barItem={
            index=i,
            isActive=i==curBarIndex;
            name=v,
            callBack=this.ClickTopBarCallBack;
        }
        local barData=UIListData.GetData(this.topBarItemObj,"SealAdd_Item",barItem);
        table.insert(list,barData);
    end
    this.topBarUIList:SetData(list);
end


this.SetTopType=function()
characterData={};
    for i,v in pairs(DataMgr.Player.characters) do
        if v.prestigeLevel>=maxFavorLevel then
            local config=ConfigMgr.Config.characterTable[v.id];
            if this.CheckInList(config.id) and (curBarIndex==1 or curBarIndex-1==config.typeJJh) then
                table.insert(characterData,{id=config.id,name=LuaMgr.GetLangText(config.namelan),rare=config.rare,indexData=nil});
            end
        end
    end
    table.sort(characterData,function(a, b) 
        return a.id<b.id;
    end)
end


this.CheckInList=function(id)
    if sealIndex==nil or id==cacheIdList[sealIndex] then
        return true;
    end
    for i,v in ipairs(cacheIdList) do
        if id==v then
            return false;
        end
    end
    return true;
    
end



this.SetSealList=function()
    this.SetTopType();
    if #characterData==0 then
        SetActive(goFree,true)
        SetActive(goScrollView,false)
        this.SetSealCount();
        return
    end;
    SetActive(goFree,false)
    SetActive(goScrollView,true)
    local list={}
    local rowCount=math.ceil(#characterData/6)
    local cfgCharacterPreferences=ConfigMgr.Config.characterPreferences;

local col=0;
    for i=1,rowCount,1 do
        local group={}
        col=0;
        for j=6*(i-1)+1,6*i,1 do
            if j<=#characterData then
                col=col+1;
                characterData[j].indexData={r=i,c=col,index=j}
                characterData[j].itemObj=this.sealItemObj
                characterData[j].callBack=this.SealClickCallBack
                characterData[j].friendly_id=cfgCharacterPreferences[characterData[j].id].friendshipTalent[10][1]
                characterData[j].isActive=this.IsActiveInList(characterData[j].id);
                table.insert(group,characterData[j]);
                if sealIndex~=nil and characterData[j].isActive then
                    lastIndexData=characterData[j].indexData;
                 end
            end
        end
       
        local groupData=UIScrollData.GetData(this.sealGroupObj,"SealAdd_Group",1240,270,group)
        table.insert(list,groupData);
    end
    this.sealScrollViewList:SetParams(1280,500)
    this.sealScrollViewList:SetData(list,true);
    this.SetSealCount();
end


this.IsActiveInList=function(id)
    if sealIndex~=nil then

        return #this.friendlyIdList>0 and id==this.friendlyIdList[1]
    end
    for i,v in ipairs(this.friendlyIdList) do
        if v==id then
            return true;
        end
    end
    return false;
    
end
    



this.SealClickCallBack=function(indexData,isOn)
    if sealIndex~=nil then

        this.SetOneSelect(indexData,isOn);
    else
        this.SetMoreSelect(indexData,isOn)
    end
    
end


this.SetOneSelect=function(indexData,isOn)
    if isOn then
        if lastIndexData~=nil then
            this.sealScrollViewList.dataList[lastIndexData.r].data[lastIndexData.c].isActive=false;
            if this.sealScrollViewList.itemMap[lastIndexData.r]~=nil then
                this.sealScrollViewList.itemMap[lastIndexData.r].UIList.itemList[lastIndexData.c]:SetActive(false);
            end
            this.RemoveFriendlyId(lastIndexData.index)
        end
        this.sealScrollViewList.dataList[indexData.r].data[indexData.c].isActive=true;
        this.sealScrollViewList.itemMap[indexData.r].UIList.itemList[indexData.c]:SetActive(true);
        this.AddFriendlyId(indexData.index)
    else
        this.sealScrollViewList.dataList[indexData.r].data[indexData.c].isActive=false;
        this.sealScrollViewList.itemMap[indexData.r].UIList.itemList[indexData.c]:SetActive(false);
        this.RemoveFriendlyId(indexData.index)
    end
    lastIndexData=indexData
    this.SetSealCount();
end


this.SetMoreSelect=function(indexData,isOn)
    if #this.friendlyIdList>=maxCount  and isOn then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("15804"));
        return
    end
    lastIndexData=indexData;
    this.sealScrollViewList.dataList[indexData.r].data[indexData.c].isActive=isOn;
    this.sealScrollViewList.itemMap[indexData.r].UIList.itemList[indexData.c]:SetActive(isOn);
    if isOn then
        this.AddFriendlyId(indexData.index)
    else
        this.RemoveFriendlyId(indexData.index)
    end
    this.SetSealCount();
end


this.AddFriendlyId=function(index)
    local characterId=characterData[index].id;
    table.insert(this.friendlyIdList,characterId)
end

this.RemoveFriendlyId=function(index)
    local characterId=characterData[index].id;
    for i=1,#this.friendlyIdList do
        if this.friendlyIdList[i]==characterId then
            table.remove(this.friendlyIdList,i);
            break;
        end
    end
end



this.SetSealCount=function()
    textCount.text=string.format(ConfigMgr.LangGlobal("15802"),#this.friendlyIdList)
end



return vm({
    data = data,
    command = command,
    hook = hook
})
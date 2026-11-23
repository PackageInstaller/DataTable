require("ViewModel/Activity/CheckInYear_BarItem")

local this = {
    vm = nil,
    checkInList={},
    barItemObj=nil,
    barScrollView=nil,
    barIndex=nil,
    rewardIds={},
    items={},
    itemsType2={},
    animator=nil,
    isTips=true;
}
local imgPath=nil;
local cfgBarMuseum=nil;
local readRecord={}


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goScrollView = nil;
local goRight1 = nil;
local goTitle1 = nil;
local goTitle2 = nil;
local goExhibit1 = nil;
local goExhibit2 = nil;
local goExhibit3 = nil;
local goRewarded = nil;
local goRight2 = nil;
local goType2Title1 = nil;
local goType2Title2 = nil;
local goType2Rewarded = nil;
local goPopUp = nil;
local Right = nil;
local ScrollbarVertical = nil;
local ScrollView = nil;
local rawImageMuseum = nil;
local rawImageTitle1 = nil;
local rawImageTitle2 = nil;
local rawImageExhibit1 = nil;
local rawImageExhibit2 = nil;
local rawImageExhibit3 = nil;
local rawImageType2Museum = nil;
local rawImageType2Title1 = nil;
local rawImageType2Title2 = nil;
local rawImagePop = nil;
local txtContent = nil;
local txtExhibit1Name = nil;
local txtExhibit2Name = nil;
local txtExhibit3Name = nil;
local txtType2Content = nil;
local txtPopName = nil;
local txtPopContent = nil;
local btnExhibit1 = nil;
local btnExhibit2 = nil;
local btnExhibit3 = nil;
local btnClose = nil;
local btnMask = nil;
local tranContent = nil;
local tranType2Content = nil;
local btnBGMask=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goScrollView = uiLink:Get("goScrollView");
    goRight1 = uiLink:Get("goRight1");
    goTitle1 = uiLink:Get("goTitle1");
    goTitle2 = uiLink:Get("goTitle2");
    goExhibit1 = uiLink:Get("goExhibit1");
    goExhibit2 = uiLink:Get("goExhibit2");
    goExhibit3 = uiLink:Get("goExhibit3");
    goRewarded = uiLink:Get("goRewarded");
    goRight2 = uiLink:Get("goRight2");
    goType2Title1 = uiLink:Get("goType2Title1");
    goType2Title2 = uiLink:Get("goType2Title2");
    goType2Rewarded = uiLink:Get("goType2Rewarded");
    goPopUp = uiLink:Get("goPopUp");
    Right = uiLink:Get("Right");
    ScrollbarVertical = uiLink:Get("ScrollbarVertical"):GetComponent("ScrollRect");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rawImageMuseum = uiLink:Get("rawImageMuseum"):GetComponent("RawImage");
    rawImageTitle1 = uiLink:Get("rawImageTitle1"):GetComponent("RawImage");
    rawImageTitle2 = uiLink:Get("rawImageTitle2"):GetComponent("RawImage");
    rawImageExhibit1 = uiLink:Get("rawImageExhibit1"):GetComponent("RawImage");
    rawImageExhibit2 = uiLink:Get("rawImageExhibit2"):GetComponent("RawImage");
    rawImageExhibit3 = uiLink:Get("rawImageExhibit3"):GetComponent("RawImage");
    rawImageType2Museum = uiLink:Get("rawImageType2Museum"):GetComponent("RawImage");
    rawImageType2Title1 = uiLink:Get("rawImageType2Title1"):GetComponent("RawImage");
    rawImageType2Title2 = uiLink:Get("rawImageType2Title2"):GetComponent("RawImage");
    rawImagePop = uiLink:Get("rawImagePop"):GetComponent("RawImage");
    txtExhibit1Name = uiLink:Get("txtExhibit1Name"):GetComponent("Text");
    txtExhibit2Name = uiLink:Get("txtExhibit2Name"):GetComponent("Text");
    txtExhibit3Name = uiLink:Get("txtExhibit3Name"):GetComponent("Text");
    txtPopName = uiLink:Get("txtPopName"):GetComponent("Text");
    txtPopContent = uiLink:Get("txtPopContent"):GetComponent("Text");
    txtContent = uiLink:Get("txtContent"):GetComponent("UIText");
    txtType2Content = uiLink:Get("txtType2Content"):GetComponent("UIText");
    btnExhibit1 = uiLink:Get("btnExhibit1"):GetComponent("Button");
    btnExhibit2 = uiLink:Get("btnExhibit2"):GetComponent("Button");
    btnExhibit3 = uiLink:Get("btnExhibit3"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnBGMask= uiLink:Get("btnBGMask"):GetComponent("Button");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranType2Content = uiLink:Get("tranType2Content"):GetComponent("RectTransform");
    this.AddRigister(uiLink);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goScrollView = nil;
    goRight1 = nil;
    goTitle1 = nil;
    goTitle2 = nil;
    goExhibit1 = nil;
    goExhibit2 = nil;
    goExhibit3 = nil;
    goRewarded = nil;
    goRight2 = nil;
    goType2Title1 = nil;
    goType2Title2 = nil;
    goType2Rewarded = nil;
    goPopUp = nil;
    Right = nil;
    ScrollbarVertical = nil;
    ScrollView = nil;
    rawImageMuseum = nil;
    rawImageTitle1 = nil;
    rawImageTitle2 = nil;
    rawImageExhibit1 = nil;
    rawImageExhibit2 = nil;
    rawImageExhibit3 = nil;
    rawImageType2Museum = nil;
    rawImageType2Title1 = nil;
    rawImageType2Title2 = nil;
    rawImagePop = nil;
    txtContent = nil;
    txtExhibit1Name = nil;
    txtExhibit2Name = nil;
    txtExhibit3Name = nil;
    txtType2Content = nil;
    txtPopName = nil;
    txtPopContent = nil;
    btnExhibit1 = nil;
    btnExhibit2 = nil;
    btnExhibit3 = nil;
    btnClose = nil;
    btnMask = nil;
    tranContent = nil;
    tranType2Content = nil;
    btnBGMask=nil;

end





this.AddRigister=function(uiLink)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.ActivityCheckInYearViewModel);
    end)
    uiLink:AddClickEvent("btnExhibit1",function()
        this.SetPopInfo(1)
    end)
    uiLink:AddClickEvent("btnExhibit2",function()
        this.SetPopInfo(2)
    end)
    uiLink:AddClickEvent("btnExhibit3",function()
        this.SetPopInfo(3)
    end)
    uiLink:AddClickEvent("btnMask",function()
        SetActive(goPopUp,false);
    end)
    uiLink:AddClickEvent("btnBGMask",function()
        LuaMgr.HidePanel(UIName.ActivityCheckInYearViewModel);
    end)
end



local data = {

}
local command = {
    
}
local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour)
        this.barItemObj = vm.behaviour.transform:Find("template/barItem").gameObject
        this.barScrollView=UIScrollView.New(goScrollView);
        this.onDragBehaviour=goScrollView:GetComponent("OnDragBehaviour")

        this.onDragBehaviour.onDrag=this.OnDrag;
        this.onDragBehaviour.onBeginDrag=this.OnBeginDrag;
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.checkInList=DataExHelper.Check_ConfigQuestEventByText("checkInOneYear")
        table.sort(this.checkInList,function(a, b) 
            return tonumber(a.id)<tonumber(b.id);
        end)
        imgPath=Path.Image.."CheckInYear/"
        this.barIndex=1;
        this.ReadHistoryRecord();
        this.ParseData();
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.barScrollView:Clear();
        HeroParameter.OnYearBarIndex=this.barIndex;
        this.SaveReadRecord();
    end,
    before_destroy = function(vm)
        this.Clear();
        this = nil
        UIScrollView.ClearItem("CheckInYear_BarItem")
    end,
}


this.ReadHistoryRecord=function()
    readRecord={}
    local key=DataMgr.Player.uid.."CheckInOnYear_Day30";
    local hisStr=PlayerPrefs.GetString(key)
    if not IsNullOrEmpty(hisStr) then
        readRecord=json.decode(hisStr);
    end
end


this.SaveReadRecord=function()
    local writeStr=json.encode(readRecord);
    if not IsNullOrEmpty(writeStr) then
        local key=DataMgr.Player.uid.."CheckInOnYear_Day30";
        PlayerPrefs.SetString(key,writeStr);
    end
    HeroRedDataHelper.CheckInOneYearRed();
    RedMgr.Singleton:Refresh();
end


this.ParseData=function()
    this.animator:Play("ani_ActivityCheckInYear_root")
    SetActive(goPopUp,false);
    this.questData=DataMgr.Player.quests;
    this.barIndex=this.GetCurIndex();
    if #this.rewardIds==0 and HeroParameter.OnYearBarIndex~=nil then
        this.barIndex=HeroParameter.OnYearBarIndex;
    end
    if this.barIndex==0 then
        this.barIndex=1;
    end
    this.SetBarScrollView();
    this.CheckAutoCheckIn();
end




this.GetCurIndex=function()
    local index=0;
    this.rewardIds={};
    for i,v in ipairs(this.checkInList) do
        if this.questData[v.id]~=nil then
            index=index+1
            if this.questData[v.id].state==2 then
                table.insert(this.rewardIds,v.id);
            end
        end 
    end
    return index;
end

this.CheckAutoCheckIn=function()
    if #this.rewardIds>0 then
        DataExHelper.EX_GetAwards(this.rewardIds,function()
            this.questData=DataMgr.Player.quests;
            SetActive(goRewarded,true);
            SetActive(goType2Rewarded,true);
        end)
    end
end


this.SetBarScrollView=function()
    if IsNull(this.checkInList) then return end;
local activeLockCount=2;
    local list={}
    for i,v in ipairs(this.checkInList) do
        local cfgMuseum=ConfigMgr.Config.MuseumMap[v.id]
        local isLock=this.questData[v.id]==nil;
        if isLock then
            activeLockCount=activeLockCount-1;
        end
        if cfgMuseum~=nil and activeLockCount>=0 then
            local checkInItem={
                index=i,
                name=LuaMgr.GetLangText(cfgMuseum.TableNameLan),
                utc=cfgMuseum.OpenDate;
                isOn=i==this.barIndex;
                lock=isLock;

                isRed=i~=this.barIndex and not isLock and readRecord[v.id]==nil;
                callBack=this.BarItemCallBack,
            }
            local checkInData=UIScrollData.GetData(this.barItemObj,"CheckInYear_BarItem",260,82,checkInItem);
            table.insert(list,checkInData);
        end
    end
    this.isTips=#this.checkInList>#list;
    this.barScrollView:SetParams(294,550)
    this.barScrollView:SetPadding(0, 0,-8, 0)
    this.barScrollView:SetData(list,false,this.barIndex);
    this.SetMuseumInfo();
end

this.BarItemCallBack=function(index)
    if this.barIndex==index then return end;
    this.barIndex=index;
    for i,v in ipairs(this.barScrollView.dataList) do
        v.data.isOn=i==index;
    end
    this.barScrollView.dataList[index].data.isRed=false;
    for i,v in pairs(this.barScrollView.itemMap) do
        v:SetIsOn(v.data.index==index)
        if v.data.index==index then
            v:CloseRed();
        end
    end
    this.animator:Play("ani_ActivityCheckInYear_switch")
    this.SetMuseumInfo()
end

this.SetMuseumInfo=function()
    txtContent.transform.anchoredPosition=Vector2(0,0)
    local id=this.checkInList[this.barIndex].id
    cfgBarMuseum=ConfigMgr.Config.MuseumMap[id]
    if cfgBarMuseum==nil then
        return 
    end;
    local isType2= IsNullOrEmpty(cfgBarMuseum.CollectionPicture1) and IsNullOrEmpty(cfgBarMuseum.CollectionPicture2) and IsNullOrEmpty(cfgBarMuseum.CollectionPicture3) 
    SetActive(goRight1,not isType2);
    SetActive(goRight2,isType2);
    if isType2 then
        this.SetMuseumInfoType2();
    else
        this.SetMuseumInfoType1();
    end
    if readRecord[cfgBarMuseum.ID]==nil then
        readRecord[cfgBarMuseum.ID]=cfgBarMuseum.ID;
    end
end


this.SetMuseumInfoType1=function()
    SetActive(goTitle1,cfgBarMuseum.LogoType==1)
    SetActive(goTitle2,cfgBarMuseum.LogoType==2)
    rawImageMuseum.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.MuseumPicture..".png");
    rawImageTitle1.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.Logo..".png")
    rawImageTitle2.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.Logo..".png")
    txtContent.text=LuaMgr.GetLangText(cfgBarMuseum.MuseumIntroductionLan);
    local isCollection1=not IsNullOrEmpty(cfgBarMuseum.CollectionPicture1)
    SetActive(goExhibit1,isCollection1);
    if isCollection1 then
        rawImageExhibit1.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.CollectionPicture1..".png")
        txtExhibit1Name.text=LuaMgr.GetLangText(cfgBarMuseum.CollectionName1Lan)
    end
    local isCollection2=not IsNullOrEmpty(cfgBarMuseum.CollectionPicture2)
    SetActive(goExhibit2,isCollection2);
    if isCollection2 then
        rawImageExhibit2.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.CollectionPicture2..".png")
        txtExhibit2Name.text=LuaMgr.GetLangText(cfgBarMuseum.CollectionName2Lan)
    end

    local isCollection3=not IsNullOrEmpty(cfgBarMuseum.CollectionPicture3)
    SetActive(goExhibit3,isCollection3);
    if isCollection3 then
        rawImageExhibit3.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.CollectionPicture3..".png")
        txtExhibit3Name.text=LuaMgr.GetLangText(cfgBarMuseum.CollectionName3Lan)
    end
    this.SetRewardList()
end

this.SetMuseumInfoType2=function()
    SetActive(goType2Title1,cfgBarMuseum.LogoType==1)
    SetActive(goType2Title2,cfgBarMuseum.LogoType==2)
    rawImageType2Museum.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.MuseumPicture..".png");
    rawImageType2Title1.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.Logo..".png")
    rawImageType2Title2.texture=LuaMgr.GetTexture(imgPath..cfgBarMuseum.Logo..".png")
    txtType2Content.text=LuaMgr.GetLangText(cfgBarMuseum.MuseumIntroductionLan);
    this.SetRewardList2();
end

this.SetRewardList=function()
    local barQuest=this.checkInList[this.barIndex]
    if barQuest==nil then return end;
    if IsNull(barQuest.showReward) or #barQuest.showReward==0 then return end;
    if #barQuest.showReward<#this.items then
        for index=#barQuest.showReward+1,#this.items,1 do
            SetActive(this.items[index].gameObject,false);
        end
    end
    for i,v in ipairs(barQuest.showReward) do
        if this.items[i]==nil then
            this.items[i]=GoodsDataItem.New(tranContent)
        end
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemConfig.count0 = v.count;
        this.items[i]:SetData(1, itemConfig, 1, false, Vector3(0.5,0.5,1), false);
        SetActive(this.items[i].gameObject,true);
    end
    SetActive(goRewarded,this.questData[barQuest.id]~=nil and this.questData[barQuest.id].state==3)
end

this.SetRewardList2=function()
    local barQuest=this.checkInList[this.barIndex]
    if barQuest==nil then return end;
    if IsNull(barQuest.showReward) or #barQuest.showReward==0 then return end;
    if #barQuest.showReward<#this.itemsType2 then
        for index=#barQuest.showReward+1,#this.itemsType2,1 do
            SetActive(this.itemsType2[index].gameObject,false);
        end
    end
    for i,v in ipairs(barQuest.showReward) do
        if this.itemsType2[i]==nil then
            this.itemsType2[i]=GoodsDataItem.New(tranType2Content)
        end
        local itemConfig = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemConfig.count0 = v.count;
        this.itemsType2[i]:SetData(1, itemConfig, 1, false, Vector3(0.5,0.5,1), false);
        SetActive(this.itemsType2[i].gameObject,true);
    end
    SetActive(goType2Rewarded,this.questData[barQuest.id].state==3)
end


this.SetPopInfo=function(index)
    SetActive(goPopUp,true);
    txtPopContent.transform.anchoredPosition=Vector2(0,0)
    local popImageName=nil;
    local popName=nil;
    local PopContent=nil;
    if index==1 then
        popImageName=cfgBarMuseum.CollectionPicture1;
        popName=cfgBarMuseum.CollectionName1Lan;
        PopContent=cfgBarMuseum.CollectionText1Lan
    elseif index==2 then
        popImageName=cfgBarMuseum.CollectionPicture2;
        popName=cfgBarMuseum.CollectionName2Lan;
        PopContent=cfgBarMuseum.CollectionText2Lan
    elseif index==3 then
        popImageName=cfgBarMuseum.CollectionPicture3;
        popName=cfgBarMuseum.CollectionName3Lan;
        PopContent=cfgBarMuseum.CollectionText3Lan
    end
    rawImagePop.texture=LuaMgr.GetTexture(imgPath..popImageName..".png");
    txtPopName.text=LuaMgr.GetLangText(popName);
    txtPopContent.text=LuaMgr.GetLangText(PopContent);
end

this.OnBeginDrag=function()
    this.draging=false;
end


this.OnDrag=function(eventData)
    if this.isTips and  not this.draging and this.onDragBehaviour.verticalNormalizedPosition<=0 and eventData.delta.y>0 then
        this.draging=true
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("6901"));
    end
end

   
return vm({
    data = data,
    command = command,
    hook = hook
})
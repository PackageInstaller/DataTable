





require("ViewModel/Activity/QianLiJiangShan_DayItem")
require("ViewModel/Activity/QianLiJiangShan_CheckInItem")
local posList={Vector2(-524,-103),Vector2(-300,-42),Vector2(-95,-103),Vector2(110,-42),
           Vector2(315,-103),Vector2(520,-42),Vector2(725,-103)}

local this = {vm=nil,
              checkInItemObj=nil, 
              dayItemObj=nil,
              checkInUIList=nil,
              dayUIList=nil,
              

};
local animator=nil;
local curQuest=nil;
local dataQuest=nil;
local qSpineCharacter=nil;
local curCheckIndex=nil;
local lastCheckedIndex=nil;
local tweener=nil;
local isShow=false;
local desContent=nil;
local startTextIndex=nil;
local curRewardId=nil;

local tarGameObject = nil;
local tarRect = nil;
local good = nil;
local root = nil;
local Middle = nil;
local goPop = nil;
local Left = nil;
local Right = nil;
local ScrollView = nil;
local tranContent = nil;
local tranBG = nil;
local tranQSpine = nil;
local tranDayContent = nil;
local btnPopMask = nil;
local btnPopbg = nil;
local textTitle = nil;
local textInfo = nil;
local textTime = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    good = uiLink:Get("good");
    root = uiLink:Get("root");
    Middle = uiLink:Get("Middle");
    goPop = uiLink:Get("goPop");
    Left = uiLink:Get("Left");
    Right = uiLink:Get("Right");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    tranBG = uiLink:Get("tranBG"):GetComponent("RectTransform");
    tranQSpine = uiLink:Get("tranQSpine"):GetComponent("RectTransform");
    tranDayContent = uiLink:Get("tranDayContent"):GetComponent("RectTransform");
    btnPopMask = uiLink:Get("btnPopMask"):GetComponent("Button");
    btnPopbg = uiLink:Get("btnPopbg"):GetComponent("Button");
    textTitle = uiLink:Get("textTitle"):GetComponent("Text");
    textTime = uiLink:Get("textTime"):GetComponent("Text");
    textInfo = uiLink:Get("textInfo"):GetComponent("UIText");
    this.AddRegister(uiLink)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    good = nil;
    root = nil;
    Middle = nil;
    goPop = nil;
    Left = nil;
    Right = nil;
    ScrollView = nil;
    tranContent = nil;
    tranBG = nil;
    tranQSpine = nil;
    tranDayContent = nil;
    btnPopMask = nil;
    btnPopbg = nil;
    textTitle = nil;
    textInfo = nil;
    textTime = nil;
   

end






this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnPopMask",function()
        if isShow then return end;
        SetActive(goPop,false);
        animator:Play("Exit")
    end)
    uiLink:AddClickEvent("btnPopbg",function()
        LuaMgr.RemoveTimer(TimerConst.QianLiJiangShanText);
        textInfo.text=desContent
        if isShow then
            this.OnAskGetReward()
        end
    end)
   
end


local data = {
  bodyPath="";
}


local command = {
    
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour);
        this.checkInItemObj=vm.behaviour.transform:Find("template/checkInItem").gameObject;
        this.dayItemObj=vm.behaviour.transform:Find("template/dayItem").gameObject;
        this.checkInUIList=UIListView.New(tranBG)
        this.dayUIList=UIListView.New(tranDayContent)
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
        qSpineCharacter = tranQSpine:Find("Spine"):GetComponent("UISpineCharacter")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            curQuest=DataExHelper.Check_ConfigQuestEventByText("checkIn7qianlijiangshan")
            table.sort(curQuest,function(a,b) return a.id<b.id  end)
            curCheckIndex=nil;
            lastCheckedIndex=nil;
            SetActive(goPop,false);
            animator:Play("ani_QianLiJiangShanSignIn_enter",0,0)
            this.ParseData();
            this.CreatQSpine();
            this.SetTranContentPos(true);
        end
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then return end;
        UIListView.ClearItem("QianLiJiangShan_DayItem")
        UIListView.ClearItem("QianLiJiangShan_CheckInItem")
        qSpineCharacter:Clear()
        if tweener~=nil then
            tweener:Kill();
        end
        LuaMgr.RemoveTimer(TimerConst.QianLiJiangShanText);
    end,
}

this.CheckInCallBack=function(index)
    if isShow then return end;
    isShow=true;
    local item=curQuest[index]
    if dataQuest[item.id].state==2 then
        curRewardId=item.id;
        this.DOMoveQSpine(posList[index],function()
            this.ShowPictureScroll(item,true)
        end)
    elseif dataQuest[item.id].state==3 then
        isShow=false;
        this.ShowPictureScroll(item,false);
    else
        isShow=false;
    end
    
end


this.ShowPictureScroll=function(item,isAnimation)
    SetActive(goPop,true)
    animator:Play("QianLiJiangShanSignIn",0,0)
    textTitle.text=LuaMgr.GetLangText(item.namelan);
    desContent=LuaMgr.GetLangText(item.remarksLan);;
    if isAnimation and not IsNullOrEmpty(desContent) then
        local endLenth = LuaMgr.GetStringLength(desContent);
        startTextIndex=1;
        LuaMgr.RemoveTimer(TimerConst.QianLiJiangShanText);
        LuaMgr.AddTimer(TimerConst.QianLiJiangShanText, function()
            this.ShowText(endLenth)
        end, 0.1, -1, false);
    else
        textInfo.text=desContent
    end
end

this.ShowText=function(endLenth)
    if startTextIndex>endLenth then
        LuaMgr.RemoveTimer(TimerConst.QianLiJiangShanText);
        textInfo.text=desContent
        this.OnAskGetReward()
        return
    end
    local value = LuaMgr.Substring(desContent, startTextIndex);
    textInfo.text = value;
    startTextIndex = startTextIndex + 1;
end



this.OnAskGetReward=function()
    if curRewardId==nil then return end;
    DataExHelper.EX_GetAward(curRewardId,function()
        this.ParseData();
        HeroRedDataHelper.SetQianLiJiangShanRed();
        RedMgr.Singleton:RefreshOtherViewModel(UIName.ActivityOnViewModel);

    end)
end



this.ParseData=function()
    isShow=false;
    curRewardId=nil;
    dataQuest=DataMgr.Player.quests;
    this.SetTimer();
    this.SetCheckInList();
    this.SetDayList();
end



this.SetTranContentPos=function(isAnimation)
    local offWidth=-200;
    if lastCheckedIndex~=nil and lastCheckedIndex>=4 then
       offWidth=offWidth*4
    end
    if isAnimation then
        DOTWeen.To(function() return Vector2(-800,0)  end,function(vector)
            tranContent.anchoredPosition=vector
        end,Vector2(offWidth,0),0.5);
    else
        tranContent.anchoredPosition=Vector2(offWidth,0);
    end
end


this.SetCheckInList=function()
    local checkInList={}
    for i,v in ipairs(curQuest) do
        local state=dataQuest[v.id]==nil and 0 or dataQuest[v.id].state;
        local dayItem={
            checkInState=state,
            index=i,
            pos=posList[i],
            callBack=this.CheckInCallBack
        }
        if curCheckIndex==nil and state==2 then
            curCheckIndex=i;
        end
        if state==3 then
            lastCheckedIndex=i;
        end
        local dayData=UIListData.GetData(this.checkInItemObj,"QianLiJiangShan_CheckInItem",dayItem);
        table.insert(checkInList,dayData)
    end
    this.checkInUIList:SetData(checkInList);
    
end

this.SetDayList=function()
    local dayList={}
    for i,v in ipairs(curQuest) do
        local state=dataQuest[v.id]==nil and 0 or dataQuest[v.id].state;
        local dayItem={
            checkInState=state,
            isLastDay=i==#curQuest,
            showReward=v.showReward[1],
            index=i,
        }
        local dayData=UIListData.GetData(this.dayItemObj,"QianLiJiangShan_DayItem",dayItem);
        table.insert(dayList,dayData)
    end
    this.dayUIList:SetData(dayList);
end



this.SetTimer=function()
    local variables=DataExHelper.GetDataExByTag(ActivityKey.qianlijiangshan)
    local remainTime=variables.expireTime-LuaMgr.Timestamp();
    local d, h, m = GetTimeDHM(remainTime);
    textTime.text=string.format(ConfigMgr.LangGlobal("15506"),d,h,m);
end


this.CreatQSpine=function()
    qSpineCharacter:SetBattle("W0134","W0134001","",2,function()
            qSpineCharacter:Play("house_idle",true,nil)
    end)
    local pos=Vector2(-550,25)
    if lastCheckedIndex~=nil then
        pos=posList[lastCheckedIndex]
    end
    tranQSpine.anchoredPosition=pos+Vector2(-60,35);
end

this.DOMoveQSpine=function(tarPos,callBack)
    tarPos=tarPos+Vector2(-60,35);
    if tweener~=nil then
        tweener:Kill();
    end
    if tarPos.x-tranQSpine.anchoredPosition.x>=0 then
        tranQSpine.localScale=Vector3(1,1,1)
    else
        tranQSpine.localScale=Vector3(-1,1,1)
    end
    qSpineCharacter:Play("house_move",true,nil) 
    tweener=DOTWeen.To(function()return tranQSpine.anchoredPosition  end,function(vector)
        tranQSpine.anchoredPosition=vector
    end,tarPos,2)
    tweener.onComplete=function()
        qSpineCharacter:Play("house_idle",true,nil)
        if callBack~=nil then
            callBack();
        end
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})
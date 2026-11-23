






require("ViewModel/SawPuzzle/SawPuzzle_RawItem")
require("ViewModel/SawPuzzle/SawPuzzleMgr")
require("ViewModel/SawPuzzle/SawPuzzle_RewardItem")

local this = {
    vm=nil,
    rawUIList={},
    taskUIList={},
    rewardUIList={},
    rawItemObj=nil,
    taskItemObj=nil,
    rewardItemObj=nil;
};

local cfgPuzzleMap={};
local curPuzzleList=nil;
local rawIndex=nil;
local cfgTaskMap=nil;
local costId=nil;
local puzzleStatus=nil;
local animator=nil;
local barIndex=nil;
local isLockJJ=false;
local localRecord=nil;



local tarGameObject = nil;
local tarRect = nil;
local btn = nil;
local btnStart = nil;
local btnUnlock = nil;
local btnCloseTask = nil;
local root = nil;
local goUnlock = nil;
local goLock = nil;
local Left = nil;
local Middle = nil;
local goRawScrollView = nil;
local goTaskPanel = nil;
local Right = nil;
local rawImagePuzzle = nil;
local tranRawContent = nil;
local tranRewardContent = nil;
local tranTaskContent = nil;
local ScrollView = nil;
local btnTypeJC=nil;
local goTypeJC=nil;
local btnTypeJJ=nil;
local goTypeJJ=nil;
local rawImageLine=nil;
local goJJLock=nil;
local goTimer=nil;
local txtTimer=nil;



this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    btn = uiLink:Get("btn"):GetComponent("Button");
    btnStart = uiLink:Get("btnStart"):GetComponent("Button");
    btnUnlock = uiLink:Get("btnUnlock"):GetComponent("Button");
    btnCloseTask = uiLink:Get("btnCloseTask"):GetComponent("Button");
    root = uiLink:Get("root");
    goUnlock = uiLink:Get("goUnlock");
    goLock = uiLink:Get("goLock");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goRawScrollView = uiLink:Get("goRawScrollView");
    goTaskPanel = uiLink:Get("goTaskPanel");
    Right = uiLink:Get("Right");
    rawImagePuzzle = uiLink:Get("rawImagePuzzle"):GetComponent("RawImage");
    tranRawContent = uiLink:Get("tranRawContent"):GetComponent("RectTransform");
    tranRewardContent = uiLink:Get("tranRewardContent"):GetComponent("RectTransform");
    tranTaskContent = uiLink:Get("tranTaskContent"):GetComponent("RectTransform");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    btnTypeJC=uiLink:Get("btnTypeJC"):GetComponent("Button");
    goTypeJC=uiLink:Get("goTypeJC");
    btnTypeJJ=uiLink:Get("btnTypeJJ"):GetComponent("Button");
    goTypeJJ=uiLink:Get("goTypeJJ");
    rawImageLine= uiLink:Get("rawImageLine"):GetComponent("RawImage");
    goJJLock=uiLink:Get("goJJLock");
    goTimer=uiLink:Get("goTimer");
    txtTimer=uiLink:Get("txtTimer"):GetComponent("Text");
    this.AddRegister(uiLink)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    btn = nil;
    btnStart = nil;
    btnUnlock = nil;
    btnCloseTask = nil;
    root = nil;
    goUnlock = nil;
    goLock = nil;
    Left = nil;
    Middle = nil;
    goRawScrollView = nil;
    goTaskPanel = nil;
    Right = nil;
    rawImagePuzzle = nil;
    tranRawContent = nil;
    tranRewardContent = nil;
    tranTaskContent = nil;
    ScrollView = nil;
    btnTypeJC=nil;
    goTypeJC=nil;
    btnTypeJJ=nil;
    goTypeJJ=nil;
    rawImageLine=nil;
    goJJLock=nil;
  
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnStart",function()
        local rawId=this.rawUIList.itemList[rawIndex].data.id;
        local puzzle=ConfigMgr.Config.PuzzleMap[rawId];
        if puzzle.Close>0 and LuaMgr.Timestamp()>puzzle.Close then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7609"))
            return;
        end
        if not this.GetUnlockState(puzzle) then
            local unlockArray=puzzle.Unlock;
            if not IsNull(unlockArray) then
                if unlockArray[1]=="1" then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7602"))
                elseif unlockArray[1]=="2" then
                    local tipStr=ConfigMgr.LangGlobal("7606");
                    local unlockTime =os.date("%Y-%m-%d %H:%M:%S",puzzle.Open)
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,unlockTime));
                end
            end
            return;
        end
        LuaMgr.ShowLuaPanel(UIName.SawPuzzleViewModel,puzzle.ID);
        HeroParameter.SawPuzzleBarIndex=barIndex;
    end)











    uiLink:AddClickEvent("btnTypeJC",function()
        this.SwitchLeftBar(1);
    end)
    uiLink:AddClickEvent("btnTypeJJ",function()
        if  isLockJJ then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7601"));
            return;
        end
        this.SwitchLeftBar(2);
    end)
end


local data = {
    isBtnStartUIGray=false,
}


local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.rawUIList=UIListView.New(tranRawContent);
        this.taskUIList=UIListView.New(tranTaskContent);
        this.rewardUIList=UIListView.New(tranRewardContent);
        this.rawItemObj=vm.behaviour.transform:Find("template/rawItem").gameObject;
        this.taskItemObj=vm.behaviour.transform:Find("template/taskItem").gameObject;
        this.rewardItemObj=vm.behaviour.transform:Find("template/rewardItem").gameObject;
        animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
       
      
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            cfgPuzzleMap={}
            for i,v in pairs(ConfigMgr.Config.PuzzleMap) do
                if cfgPuzzleMap[v.Type]==nil then
                    cfgPuzzleMap[v.Type]={};
                end
                table.insert(cfgPuzzleMap[v.Type],v);
            end
            barIndex=nil;
            isLockJJ=true;
            rawIndex=1;;
            SetActive(goRawScrollView,true)
            SetActive(goTaskPanel,false)
       
            animator:Play("ui_ani_SawPuzzleSelectPanel_root",0,0);
            tranRawContent.anchoredPosition=Vector2(79,0)
            SawPuzzleMgr.ReadLocalData();
            this.ParseData();
            this.RefreshFirstJoinRed(4);
            HeroRedDataHelper.RefreshMiniGameRed();
        end
    end,
    before_deactive = function(vm)
       
    end,
    before_destroy=function()
        this.Clear();
        UIListView.ClearItem("SawPuzzle_RawItem")

        UIListView.ClearItem("SawPuzzle_RewardItem")
    end
    
}
this.RefreshFirstJoinRed=function (type)
    local config=ConfigMgr.Config.constants["GamePoint"]
    for index, value in ipairs(config) do
        if value[1]==tostring(type) and value[2]~="nil" then
PlayerPrefs.SetInt(DataMgr.Player.uid .. "#" .. value[1] .. "#" ..value[2],1);
            break;
        end
    end
end


this.ParseData=function()
    puzzleStatus=DataMgr.Player.puzzleStatus;
    local jjList=cfgPuzzleMap["2"];
    isLockJJ=true;
    for i,v in ipairs(jjList) do
        if this.GetUnlockState(v) then
            isLockJJ=false;
            break
        end
    end
    SetActive(goJJLock,isLockJJ)
    if HeroParameter.SawPuzzleBarIndex~=nil then
        this.SwitchLeftBar(HeroParameter.SawPuzzleBarIndex)
        HeroParameter.SawPuzzleBarIndex=nil;
    else
        this.SwitchLeftBar(1)
    end
end

this.SwitchLeftBar=function(index)
    if barIndex~=nil and barIndex==index then return end;
    barIndex=index;
    rawIndex=1;
    SetActive(goTypeJC,index==1)
    SetActive(goTypeJJ,index==2);
    curPuzzleList=cfgPuzzleMap[tostring(index)]
    table.sort(curPuzzleList,function(a, b) return tonumber(a.ID)<tonumber(b.ID) end)
    tranRawContent.anchoredPosition=Vector2(79,0);
    this.ShowRawList();
    this.SetRawInfo();
end

this.ShowRawList=function()
    local list={}
    for i,v in ipairs(curPuzzleList) do
        if v.Close==0 or (v.Close>0 and LuaMgr.Timestamp()<v.Close) then
            local pro=""
            local record=SawPuzzleMgr.CheckLocalRecord(v.ID)
            if record~=nil then
                pro=record.fixedPro;
            end
            local iconItem={
                id=v.ID,
                picName=v.Sprite,
                unlock=this.GetUnlockState(v);
                isRecord=SawPuzzleMgr.CheckLocalRecord(v.ID),
                isPass=puzzleStatus[v.ID]~=nil,
                fixedPro=pro,
                callback=this.ClickRawItem,
            }
            iconItem.isTime=iconItem.unlock and v.Close>0;
            local iconData=UIListData.GetData(this.rawItemObj,"SawPuzzle_RawItem",iconItem);
            table.insert(list,iconData);
        end
    end
    table.sort(list,function(a, b)
        if (a.data.unlock and b.data.unlock) or (not a.data.unlock and not b.data.unlock) then
            return tonumber(a.data.id)<tonumber(b.data.id)
        else
            return a.data.unlock and not b.data.unlock;
        end
    end)
    for i,v in ipairs(list) do
        v.data.index=i;
    end
    this.rawUIList:SetData(list);
end

this.GetUnlockState=function(puzzleItem)
    if IsNull(puzzleItem.Unlock) or #puzzleItem.Unlock==0 then return true end;
    if #puzzleItem.Unlock>1 then
        if puzzleItem.Unlock[1]=="1" then
            local key=puzzleItem.Unlock[2];
            return puzzleStatus[key]~=nil
        elseif puzzleItem.Unlock[1]=="2" then
            local startTime=tonumber(puzzleItem.Open)
            return LuaMgr.Timestamp()>=startTime;
        end
    end
end

this.UpdateRawListPosition=function()
    local height=-80;
    for i,v in ipairs(this.rawUIList.itemList) do
        v:SetScale(i==rawIndex)
        if i==rawIndex then
            height=height+150;
            v.transform.anchoredPosition=Vector2(-160,-height);
        elseif i==rawIndex+1 then
            height=height+214;
            v.transform.anchoredPosition=Vector2(-170,-height);
        else
            height=height+160;
            v.transform.anchoredPosition=Vector2(-170,-height);
        end
    end
    tranRawContent.sizeDelta=Vector2(600,height+300);
end


this.ClickRawItem=function(index)
    if rawIndex==index then return end;
    if not this.rawUIList.itemList[index].data.unlock then
        local rawID=this.rawUIList.itemList[index].data.id
        local unlockArray=ConfigMgr.Config.PuzzleMap[rawID].Unlock;
        if not IsNull(unlockArray) then
            if unlockArray[1]=="1" then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("7602"))
            elseif unlockArray[1]=="2" then
                local tipStr=ConfigMgr.LangGlobal("7606");
                local unlockTime =os.date("%Y-%m-%d %H:%M:%S",ConfigMgr.Config.PuzzleMap[rawID].Open)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,unlockTime));
            end
        end
        return
    end
    rawIndex=index;
    this.SetRawInfo();
end

this.SetRawInfo=function()
    local rawId=this.rawUIList.itemList[rawIndex].data.id;
    local puzzleItem=ConfigMgr.Config.PuzzleMap[rawId];
    rawImagePuzzle.texture=LuaMgr.GetTexture(Path.Image.."SawPuzzle/"..puzzleItem.Pic..".png");
    rawImageLine.texture=LuaMgr.GetTexture(Path.Image.."SawPuzzle/ui_xqpt_pintu"..puzzleItem.Type..".png");
    SetActive(goTimer,puzzleItem.Close>0)
    if puzzleItem.Close>0  then
        local tip=ConfigMgr.LangGlobal("7608")
        local endTime=os.date("*t",puzzleItem.Close)
        txtTimer.text=string.format(tip,endTime.year,endTime.month,endTime.day,endTime.hour,endTime.min,endTime.sec)
    end
    this.UpdateRawListPosition();
    local list={}
    if IsNull(puzzleItem.Reward) then return end;
    for i,v in ipairs(puzzleItem.Reward) do
        local rewardItem={
            id=v.id,
            count=v.count,
            isReward=puzzleStatus[puzzleItem.ID]~=nil,
        }
        local rewardData=UIListData.GetData(this.rewardItemObj,"SawPuzzle_RewardItem",rewardItem);
        table.insert(list,rewardData)
    end
    this.rewardUIList:SetData(list);
    local unlock= this.GetUnlockState(puzzleItem);
    this.vm.data.isBtnStartUIGray=not unlock;
end



























































return vm({
    data = data,
    command = command,
    hook = hook
})
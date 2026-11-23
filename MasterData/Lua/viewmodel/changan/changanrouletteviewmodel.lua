




require("ViewModel/Changan/Changan_RouletteRewardItem")

local this = {
    vm=nil,
    rewardUIList=nil
};



local itemPos={Vector2(-65,150),Vector2(-156,59),Vector2(-156,-65),Vector2(-65,-156),
               Vector2(59,-156),Vector2(150,-65),Vector2(150,59),Vector2(56,150), }
local goodItemObj=nil;
local groupId="2"
local cfgDrawActivityMap={}
local cfgDrawMap={}
local dataDrawProgress={}
local dataDrawRecords={}
local drawId="2001"
local surplusTotalCount=nil
local spineCharacter=nil;
local myCount=nil;
local maxDrawCount=nil;
local uiRotateCurve;

local imgGreenList={}
local isFastPlay=false;
local drawLoc=nil;
local isTurning=false;

local tarGameObject = nil;
local tarRect = nil;
local goodItem = nil;
local root = nil;
local goodRoot = nil;
local Middle = nil;
local Left = nil;
local Right = nil;
local uicazpbt = nil;
local btnMask = nil;
local btnOne = nil;
local btnTen = nil;
local btnClose = nil;
local tranItemList = nil;
local tranRoules = nil;
local tranpointer = nil;
local tranDoing = nil;
local tranFrush = nil;
local rawImageCostOne = nil;
local rawImageCostTen = nil;
local rawImageItem = nil;
local textTime = nil;
local textItem = nil;
local textCostOne=nil;
local textCostTen=nil;
local toggleFast=nil;
local textCountOne=nil;
local textCountTen=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    goodItem = uiLink:Get("goodItem");
    root = uiLink:Get("root");
    goodRoot = uiLink:Get("goodRoot");
    Middle = uiLink:Get("Middle");
    Left = uiLink:Get("Left");
    Right = uiLink:Get("Right");
    uicazpbt = uiLink:Get("uicazpbt");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnOne = uiLink:Get("btnOne"):GetComponent("Button");
    btnTen = uiLink:Get("btnTen"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    tranItemList = uiLink:Get("tranItemList"):GetComponent("RectTransform");
    tranRoules = uiLink:Get("tranRoules"):GetComponent("RectTransform");
    tranpointer = uiLink:Get("tranpointer"):GetComponent("RectTransform");
    tranDoing = uiLink:Get("tranDoing"):GetComponent("RectTransform");
    tranFrush = uiLink:Get("tranFrush"):GetComponent("RectTransform");
    rawImageCostOne = uiLink:Get("rawImageCostOne"):GetComponent("RawImage");
    rawImageCostTen = uiLink:Get("rawImageCostTen"):GetComponent("RawImage");
    rawImageItem = uiLink:Get("rawImageItem"):GetComponent("RawImage");
    textTime = uiLink:Get("textTime"):GetComponent("Text");
    textItem = uiLink:Get("textItem"):GetComponent("Text");
    textCostOne=uiLink:Get("textCostOne"):GetComponent("Text");
    textCostTen=uiLink:Get("textCostTen"):GetComponent("Text");
    textCountOne=uiLink:Get("textCountOne"):GetComponent("Text");
    textCountTen=uiLink:Get("textCountTen"):GetComponent("Text");
    toggleFast=uiLink:Get("toggleFast"):GetComponent("Toggle")
    uiLink:AddClickEvent("btnMask",this.BtnCloseCommand);
    uiLink:AddClickEvent("btnClose",this.BtnCloseCommand);
    uiLink:AddClickEvent("btnOne",this.BtnOneCommand);
    uiLink:AddClickEvent("btnTen",this.BtnTenCommand);
    uiLink:AddClickEvent("tranFrush",this.BtnFrushDrawCommand)
    uiLink:AddToggleClickEvent("toggleFast",this.TogFastCommand)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    goodItem = nil;
    root = nil;
    goodRoot = nil;
    Middle = nil;
    Left = nil;
    Right = nil;
    uicazpbt = nil;
    btnMask = nil;
    btnOne = nil;
    btnTen = nil;
    btnClose = nil;
    tranItemList = nil;
    tranRoules = nil;
    tranpointer = nil;
    tranDoing = nil;
    tranFrush = nil;
    rawImageCostOne = nil;
    rawImageCostTen = nil;
    rawImageItem = nil;
    textTime = nil;
    textItem = nil;
    textCostOne=nil;
    textCostTen=nil;
    toggleFast=nil;
    textCountOne=nil;
    textCountTen=nil;
end

this.BtnCloseCommand=function()
    if isTurning then return end;
    LuaMgr.HidePanel(UIName.ChanganRouletteViewModel)
end

this.BtnOneCommand=function()
    this.OnAskDrawReward(1)
end

this.BtnTenCommand=function()
    this.OnAskDrawReward(maxDrawCount)
end

this.BtnFrushDrawCommand=function()
    this.OnAskChangeDrawBox();
end

this.TogFastCommand=function(isOn)
    PlayerPrefs.SetInt(DataMgr.Player.uid.."CA_RouletteFast",isOn and 1 or 0)
    isFastPlay=isOn;
end

this.OnAskDrawReward=function(buyCount)

    if myCount<1 then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10200"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
        return
    end

    if surplusTotalCount<1 and tranDoing.gameObject.activeSelf then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10202"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
        return
    end

    if surplusTotalCount<1 then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10201"].NameLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipStr)
        return
    end
    if isTurning then return end;
    isTurning=true
    local askData={Group=tostring(groupId),Count=buyCount};
    ApiMgr.Request("draw/drawReward", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result.Reward);
        for i,v in ipairs(this.rewardUIList.itemList) do
            if v.data.contentId==re.result.RewardIDs[1] then
                drawLoc=i
                break
            end
        end
        local callBack=function()
            LuaMgr.ShowGetRewardPanel(data);
            this.ParseData();
            SetActive(tranFrush.gameObject,re.result.CanChange)
            SetActive(tranDoing.gameObject,not re.result.CanChange)
        end
        local endAngle=22.5+(drawLoc-1)*45;
    this.PlayAnimation(endAngle,callBack);

end, function() isTurning=false  end, true);

end


this.OnAskChangeDrawBox=function()
    local askData={Group=groupId};
    ApiMgr.Request("draw/changeBox", askData, true, function(result)
        SetActive(tranFrush.gameObject,false)
        SetActive(tranDoing.gameObject,true)
        this.ParseData();
    end,nil,true);

end

this.OnAskOpenBox=function()
    local askData={Group=groupId}
    ApiMgr.Request("draw/openBox", askData, true, function(result)
        local re=json.decode(result);
        SetActive(tranFrush.gameObject,re.result.CanChange)
        SetActive(tranDoing.gameObject,not re.result.CanChange)
    end,nil,true);
end



local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        this.rewardUIList=UIListView.New(tranItemList)
        goodItemObj=vm.behaviour.transform:Find("template/goodItem").gameObject;
        local characterTf=vm.behaviour.transform:Find("root/Middle/bg/character/body");
        spineCharacter=characterTf:GetComponent("UISpineCharacter")
        local drawingAdjustTool=characterTf:GetComponent("DrawingAdjustTool")
        uiRotateCurve=tranpointer:GetComponent("UIRotateByCurve")
        local path = HeroManager.SetCharacterDrawing(spineCharacter, "W0081","W0081002");
        if path ~= "" then
            drawingAdjustTool.Sprite=path;
        end
        for i=0,tranRoules.childCount-1,1 do
            table.insert(imgGreenList,tranRoules:GetChild(i):GetComponent("Image"))
        end
        LuaMgr.AddUpdate(this.Update);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.OnAskOpenBox();
            this.ParseData();
        end 
        
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetChanganRed();
        RedMgr.Singleton:RefreshOtherViewModel(UIName.ChanganMainViewModel);
    end,
    before_destroy=function()
        if spineCharacter~=nil then
            spineCharacter:Clear();
        end
        this.Clear()
        UIListView.ClearItem("Changan_RouletteRewardItem")
        LuaMgr.RemoveUpdate(this.Update);
    end
    
        
    
}

this.Update=function()
    if isTurning then
        this.SetWheelImgGreen();
    end
end

this.ParseData=function()
    isTurning=false;
    toggleFast.isOn=PlayerPrefs.GetInt(DataMgr.Player.uid.."CA_RouletteFast")>0
    isFastPlay=toggleFast.isOn
    cfgDrawActivityMap={};
    local activityMap=ConfigMgr.Config.DrawActivityMap;
    for i,v in pairs(activityMap) do
        if v.Group==groupId then
            cfgDrawActivityMap[i]=v;
        end
    end
    cfgDrawMap=ConfigMgr.Config.DrawMap;
    dataDrawProgress=DataMgr.Player.drawRewardProgress;
    dataDrawRecords=DataMgr.Player.drawRewardRecords;
    if dataDrawProgress[groupId]~=nil then
        drawId=dataDrawProgress[groupId]
    end
    this.SetRewardsList()
    this.SetBaseInfo()
end

this.SetBaseInfo=function()
    local roulettleVariables=DataMgr.Player.variables["group.212"]
    if roulettleVariables==nil then return end;
    local drawActivity=cfgDrawActivityMap[drawId];
    local iconPath=ConfigHelper.GetItemHomeIconPath(drawActivity.Consume[1].id)
    local iconTexture=LuaMgr.GetTexture(iconPath)
    local oneCost=drawActivity.Consume[1].count;
    rawImageCostOne.texture=iconTexture
    rawImageCostTen.texture=iconTexture
    rawImageItem.texture=iconTexture
    myCount=math.floor(DataHelper.GetItemCountById(drawActivity.Consume[1].id)/oneCost)
    maxDrawCount=myCount
    if maxDrawCount>surplusTotalCount then
        maxDrawCount=surplusTotalCount
    end
    maxDrawCount=maxDrawCount>10 and 10 or maxDrawCount
    textItem.text=LuaMgr.NumFormat(myCount)
    SetActive(btnTen.gameObject,myCount>1);
    textCountOne.text=myCount<1 and string.format(LuaMgr.GetLangText("ChanganRouletteViewModel_0"),1)
            or string.format(LuaMgr.GetLangText("ChanganRouletteViewModel_1"),maxDrawCount<1 and 1 or 1)
    textCountTen.text=myCount<1 and string.format(LuaMgr.GetLangText("ChanganRouletteViewModel_2"),1)
            or string.format(LuaMgr.GetLangText("ChanganRouletteViewModel_3"),maxDrawCount<1 and 1 or maxDrawCount)
    textCostOne.text=oneCost;
    
    if maxDrawCount<1 then
        textCostTen.text=oneCost*1;
    else
        textCostTen.text=oneCost*maxDrawCount;
    end
    local startTimeStr= os.date(LuaMgr.GetLangText("ChanganRouletteViewModel_4"),roulettleVariables.startTime)
    local endTimeStr= os.date(LuaMgr.GetLangText("ChanganRouletteViewModel_5"),roulettleVariables.expireTime)
    textTime.text=string.format("%s-%s",startTimeStr,endTimeStr)
end

this.SetRewardsList=function()
    local drawActivity=cfgDrawActivityMap[drawId];
    surplusTotalCount=0;
    local dataList={}
    for i,v in ipairs(drawActivity.Content) do
        local drawItem=cfgDrawMap[v];
        local reCount=this.GetRewardRemainCount(v)
        surplusTotalCount=surplusTotalCount+reCount;
        local goodItem={
            id=drawItem.Reward[1].id,
            count=drawItem.Reward[1].count,
            surplus=reCount,
            pos=itemPos[i],
            contentId=v
        }
        imgGreenList[i].enabled=false
        local drawData=UIListData.GetData(goodItemObj,"Changan_RouletteRewardItem",goodItem)
        table.insert(dataList,drawData)
    end
    this.rewardUIList:SetData(dataList,true);
end


this.GetRewardRemainCount=function(id)
    local count=cfgDrawMap[id].Time;
    if dataDrawRecords~=nil then
        local key=string.format("%s_%s",drawId,id);
        local hasBuyCount=dataDrawRecords[key];
        if hasBuyCount~=nil then
            count= count-hasBuyCount;
        end
    end
    return count;
end

this.SetWheelImgGreen=function()
    local angle=tranpointer.localEulerAngles.z
    for i,v in ipairs(imgGreenList) do
        local startAngle=(i-1)*45;
        local endAngle=i*45;
        if angle>startAngle and angle<endAngle then
            v.enabled=true;
        else
            v.enabled=false;
        end
    end
end

this.PlayAnimation=function(endAngle,callback)
    if(uiRotateCurve~=nil) then
        local onceTime=0.6;
        local turnCount=4;
        if isFastPlay then
            turnCount=3;
            onceTime=0.4
        end
        local angel=-360 * turnCount+endAngle-360;
        local time=(math.abs(angel)/360)*onceTime;
        uiRotateCurve:DOLocalRotate(angel,time,callback,isFastPlay);
    end
   
end


return vm({
    data = data,
    command = command,
    hook = hook
})
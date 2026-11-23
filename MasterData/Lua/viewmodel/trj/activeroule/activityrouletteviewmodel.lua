require("ViewModel/TRJ/ActiveRoule/TRJDrawItem2");
local this = {
    rotateUIList={};
    drawUIList={};
    drawItemObj=nil;
};
local drawActiveId="60001";
local isTurning=false;
local isNoMatch=false;
local itemPos={Vector2(-187,50),Vector2(-58,50),Vector2(71.5,50),Vector2(200,50),Vector2(200,-80),
               Vector2(200,-210),Vector2(71.5,-210),Vector2(-56,-210),Vector2(-187,-210),Vector2(-187,-80)
}


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.Middle = uiLink:Get("Middle");
    ui.goCost = uiLink:Get("goCost");
    ui.goFree = uiLink:Get("goFree");
    ui.goEff = uiLink:Get("goEff");
    ui.goPopPanel = uiLink:Get("goPopPanel");
    ui.tranRotateItems = uiLink:Get("tranRotateItems"):GetComponent("RectTransform");
    ui.tranRotateArea = uiLink:Get("tranRotateArea"):GetComponent("RectTransform");
    ui.btnTips = uiLink:Get("btnTips"):GetComponent("Button");
    ui.btnJump = uiLink:Get("btnJump"):GetComponent("Button");
    ui.btnRotate = uiLink:Get("btnRotate"):GetComponent("Button");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.txtTime = uiLink:Get("txtTime"):GetComponent("Text");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.txtTipText = uiLink:Get("txtTipText"):GetComponent("Text");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnRotate",function()
        this.OnAskRotate();
    end)
    uiLink:AddClickEvent("btnJump",function()

    end)
    uiLink:AddClickEvent("btnTips",function()
      SetActive(ui.goPopPanel,true);
        ui.txtTipText.text=ConfigMgr.LangGlobal("29884")
    end)
    uiLink:AddClickEvent("btnMask",function()
        SetActive(ui.goPopPanel,false);
    end)
end

this.OnAskRotate=function()
    if this.CheckReMainTime()<0 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("27105"));
        return;
    end
    if this.isSellOut then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10214"))
        return;
    end
    if isNoMatch then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10154"))
        return;
    end
    if isTurning then return end;
    isTurning=true;
    local askData={Group=this.cfgDrawActive.Group,Count=1};
    ApiMgr.Request("draw/drawReward", askData, true, function(result)
        local re=json.decode(result);
        local data=json.encode(re.result.Reward);
        HeroRedDataHelper.CheckRotateFLZPRed();
        local drawIndex=nil;
        for i,v in ipairs(this.cfgDrawActive.Content) do
            if v==re.result.RewardIDs[1] then
                drawIndex=i
                break
            end
        end
        if drawIndex==nil then
            LuaDebug.error("drawIndex is nil; Error")
            return;
        end
        local callBack=function()
            LuaMgr.ShowGetRewardPanel(data);
            NumTool.DelayHandler(function()
                if ui~=nil then
                    this.ParseData_Rotate();
                end
            end,0.5);
        end
        SetActive(ui.goEff,true);
        this.PlayRotateCurve(11-drawIndex,false,callBack);
    end, function() isTurning=false  end, true);
end

this.CheckReMainTime=function()
    local var=DataExHelper.GetDataExByTag(ActivityKey.FLZP)
    local remainTime = var.expireTime - LuaMgr.Timestamp()
    return remainTime;
end

local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.InitUI(vm.behaviour);
        this.drawUIList=UIListView.New(ui.tranRotateItems);
        this.drawItemObj=vm.behaviour.transform:Find("template/drawItem").gameObject;
        this.uiRotateCurve=vm.behaviour.transform:Find("root/Middle/other/curve"):GetComponent("UIRotateByCurve");
        this.rotateTFList={};
        for i=1,ui.tranRotateArea.childCount,1 do
            local child_i=ui.tranRotateArea:GetChild(i-1)
            local child_i_child=child_i:GetChild(0);
            if child_i~=nil then
                table.insert(this.rotateTFList,{obj=child_i.gameObject,child=child_i_child.gameObject});
            end
        end
    end,
        
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        for i,v in ipairs(this.rotateTFList) do
            SetActive(v.obj,false);
        end
        SetActive(ui.goPopPanel,false);
        LuaMgr.AddUIEventListener(UIEventConst.PropUse,this.SetDrawCostInfo)
        this.ParseData();
        LuaMgr.AddUpdate(this.Update);
    end,
    before_deactive = function(vm)
        this.drawUIList:Clear();
        this.rotatePlay=false;
        LuaMgr.RemoveUpdate(this.Update);
        LuaMgr.RemoveUIEventListener(UIEventConst.PropUse,this.SetDrawCostInfo)
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("TRJDrawItem2")
    end
}

this.Update=function()
    if not this.rotatePlay then return end;
    this.PlayRotateAnimation();
end


this.ParseData=function()
    this.ParseData_Rotate()
end
    
this.ParseData_Rotate=function()
    SetActive(ui.goEff,false);
    isTurning=false;
    this.cfgDrawActive=ConfigMgr.Config.DrawActivityMap[drawActiveId]
    if this.cfgDrawActive==nil then return end;
    this.dataDrawRecords=DataMgr.Player.drawRewardRecords;
    this.drawCount=1;
    this.maxFreeCount=0;
    for i,v in ipairs(this.cfgDrawActive.Consume) do
        if v.count==0 then
            this.maxFreeCount=this.maxFreeCount+1;
        end
    end
    this.SetDrawUIList();
    this.SetDrawCostInfo();
end

this.PlayRotateAnimation=function()
    local angle=360-this.uiRotateCurve.transform.localEulerAngles.z
    for i,v in ipairs(this.rotateTFList) do
        local startAngle=(i-1)*36;
        local endAngle=i*36;
        SetActive(v.obj,angle>startAngle and angle<endAngle)
    end
end

this.PlayRotateCurve=function(index,isFastPlay,callBack)
    this.rotatePlay=true;
    local endAngle=18+(index-1)*36;
    if(this.uiRotateCurve~=nil) then
        local onceTime=0.8;
        local turnCount=3;
        if isFastPlay then
            turnCount=1;
            onceTime=0.4
        end
        local angel=-360 * turnCount+endAngle-360;
        local time=(math.abs(angel)/360)*onceTime;
        this.uiRotateCurve:DOLocalRotate(angel,time,callBack,isFastPlay);
    end
end

this.SetDrawCostInfo=function()
    local remainTime = this.CheckReMainTime();
    if remainTime<0 then
        remainTime=0
    end
    local day,hour,min=GetTimeDHM2(remainTime)
    ui.txtTime.text=string.format(ConfigMgr.LangGlobal("10205"),day,hour)
    if this.drawCount>#this.cfgDrawActive.Consume then
        this.drawCount=#this.cfgDrawActive.Consume;
    end
    local cost=this.cfgDrawActive.Consume[this.drawCount];
    SetActive(ui.goFree,cost.count==0)
    SetActive(ui.goCost,cost.count>0)
    this.SetFreeCount();
    if cost.count==0 then

        return;
    end
    local itemPath=ConfigHelper.GetItemHomeIconPath(cost.id);
    ui.rawCostIcon.texture=LuaMgr.GetTexture(itemPath);
    local myCount=DataHelper.GetItemCountById(cost.id)
    isNoMatch=myCount<cost.count;
    ui.txtCostCount.text=isNoMatch and string.format("<color=#FF0000>%s</color>",cost.count) or cost.count;
    
end

this.SetFreeCount=function()
    local curFreeCount=this.drawCount-1;
    if curFreeCount>this.maxFreeCount then
        curFreeCount=this.maxFreeCount;
    end
    ui.txtCount.text=string.format("%s/%s",curFreeCount,this.maxFreeCount);
end


this.GetDrawRecordCount=function(id)
    local count=0;
    if this.dataDrawRecords~=nil then
        local key=string.format("%s_%s",drawActiveId,id);
        if this.dataDrawRecords[key]~=nil then
            count=this.dataDrawRecords[key];
        end
    end
    return count;
end

this.SetDrawUIList=function()
    this.drawUIList:Clear();
    local list={};
    this.isSellOut=true;
    for i,v in ipairs(this.cfgDrawActive.Content) do
        local  drawInfo=ConfigMgr.Config.DrawMap[v];
        local drawCount=this.GetDrawRecordCount(v);
        this.drawCount=this.drawCount+drawCount;
        if drawInfo~=nil then
            local drawItem={
                index=i,
                item=drawInfo.Reward,
                maxCount=drawInfo.Time,
                drawCount=drawCount,

                pos=itemPos[i],
                contentId=v,
                callBack=this.IconClickCallBack,
            }
            if drawItem.maxCount-drawItem.drawCount>0 then
                this.isSellOut=false;
            end
            local drawData=UIListData.GetData(this.drawItemObj,"TRJDrawItem2",drawItem);
            table.insert(list,drawData);
        end
    end
    this.drawUIList:SetData(list);
end

this.IconClickCallBack=function(index)
    local item=this.drawUIList.dataList[index].data.item[1];
    ConfigHelper.ShowItemTips(item.id);
end




return vm({
    data = data,
    command = command,
    hook = hook
})
require("ViewModel/Simulate/Simulate_LanternMatelItem")
local this = {
    vm = nil,
    lightPartUIList={};
    lightPartItemObj=nil;
};

local partPosList={Vector2(-748,-142),Vector2(-612,140),Vector2(-555,-49),Vector2(-293,84.8),Vector2(-200.8,-120.4),
                   Vector2(53.3,173),Vector2(116.8,-54.8),Vector2(375,89),Vector2(529,-105),Vector2(732,111),}

local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goInfo1 = uiLink:Get("goInfo1");
    ui.goInfo2 = uiLink:Get("goInfo2");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.imgItem1 = uiLink:Get("imgItem1"):GetComponent("Image");
    ui.imgItem2 = uiLink:Get("imgItem2"):GetComponent("Image");
    ui.txtItem1Count = uiLink:Get("txtItem1Count"):GetComponent("Text");
    ui.txtItem2Count = uiLink:Get("txtItem2Count"):GetComponent("Text");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.btnMake = uiLink:Get("btnMake"):GetComponent("Button");
    ui.btnJump = uiLink:Get("btnJump"):GetComponent("Button");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end



this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMake",function()
        if not this.isCanMake then
            return
        end;
        if not this.curIsMerge then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateLanternMainViewModel_0"));
            return;
        end
        this.isCanMake=false;
        SimulateRoomMgr.OnAskExchangeLightPart(this.lightPart.Id,1,function()
            this.lightPartUIList.itemList[this.curIndex]:UnLockFX();
            NumTool.DelayHandler(function()
                this.ParseData();
            end,1)
        end)
    end)
    uiLink:AddClickEvent("btnJump",function()
        if this.lightPart~=nil then
            LuaMgr.ShowLuaPanel(UIName.SimulateLanternMakeViewModel,this.lightPart.Id);
        end
    end)
end



local data = {
  
}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.lightPartUIList=UIListView.New(ui.tranContent);
        this.lightPartItemObj=vm.behaviour.transform:Find("template/lanternMatelItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.lightPartList={}
            for i,v in pairs(ConfigMgr.Config.SimulateMergeMap) do
                table.insert(this.lightPartList,v);
            end
            table.sort(this.lightPartList,function(a, b) return a.Sort<b.Sort end)
            this.curIndex=1;
            this.lightPart=nil;
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.lightPartUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_LanternMatelItem")
    end
}

this.ParseData=function()
    this.isCanMake=true;
    this.dataFlowerLight=DataMgr.Player.SimulateFlowerLight;
    this.SetLightPartUIList();
end









this.SetLightPartUIList=function()
    this.lightPartUIList:Clear();
    local list={}
    for i,v in ipairs(this.lightPartList) do
        local partItem={
            index=i,
            id=v.Id,
            iconName=v.Icon,
            name=LuaMgr.GetLangText(v.NameLan);
            myCount=SimulateRoomMgr.GetLanternPartCount(v.Id);
            isMerge=this.CheckIsCanMerge(v.Merge);
            isCur=i==this.curIndex;
            lockInfo=LuaMgr.GetLangText("SimulateLanternMainViewModel_1");
            pos=partPosList[i];
            callBack=this.LightPartCallBack;
        }
        local partData=UIListData.GetData(this.lightPartItemObj,"Simulate_LanternMatelItem",partItem)
        table.insert(list,partData)
    end
    this.lightPartUIList:SetData(list);
    this.SetLightPartInfo();
end

this.LightPartCallBack=function(index)
    if this.curIndex~=nil and this.curIndex==index then
        return
    end
    this.curIndex=index;
    for i,v in ipairs(this.lightPartUIList.itemList) do
        v:SetSelect(i==index);
    end
    this.SetLightPartInfo();
end


this.CheckIsCanMerge=function(mergeList)
    if IsNull(mergeList) then return true end;
    for i,v in ipairs(mergeList) do
        local count=SimulateRoomMgr.GetLanternMergeItemCount(v.id)
        if count<v.count then
            return false;
        end
    end
    return true;
end

this.SetLightPartInfo=function()
    this.lightPart= this.lightPartList[this.curIndex];
    local curMyCount=SimulateRoomMgr.GetLanternPartCount(this.lightPart.Id);
    this.curIsMerge=this.CheckIsCanMerge(this.lightPart.Merge);
    SetActive(ui.goInfo1,curMyCount<1);
    SetActive(ui.goInfo2,curMyCount>0);
    if curMyCount>0 then
        ui.txtName.text=LuaMgr.GetLangText(this.lightPart.NameLan)
        ui.txtDes.text=LuaMgr.GetLangText(this.lightPart.DescLan)
    else
        local iconName1=ConfigMgr.Config.SimulateCatchMaterialMap[this.lightPart.Merge[1].id].Icon;
        ui.imgItem1.sprite=LuaMgr.GetSprite("Simulate",iconName1);
        ui.txtItem1Count.text=string.format("%s/%s",SimulateRoomMgr.GetLanternMergeItemCount(this.lightPart.Merge[1].id),this.lightPart.Merge[1].count)
        local iconName2=ConfigMgr.Config.SimulateCatchMaterialMap[this.lightPart.Merge[2].id].Icon;
        ui.imgItem2.sprite=LuaMgr.GetSprite("Simulate",iconName2);
        ui.txtItem2Count.text=string.format("%s/%s",SimulateRoomMgr.GetLanternMergeItemCount(this.lightPart.Merge[2].id),this.lightPart.Merge[2].count)
    end
end



return vm({
    data = data,
    command = command,
    hook = hook
})
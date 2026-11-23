require("ViewModel/Simulate/Simulate_LanternPartItem")
require("ViewModel/Simulate/Simulate_LanternItem")
local this = {
    vm = nil,
    partUIList={};
    partItemObj=nil;
    lightBagUIList={};
    bagItemObj=nil;
    count=1;
    lightId=nil;
};

local maskInterval=1;
local lastClickTime=0;


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.goSpecial = uiLink:Get("goSpecial");
    ui.goMaskLightFx = uiLink:Get("goMaskLightFx");
    ui.goType1On = uiLink:Get("goType1On");
    ui.goType2On = uiLink:Get("goType2On");
    ui.goType3On = uiLink:Get("goType3On");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.imgLantern = uiLink:Get("imgLantern"):GetComponent("Image");
    ui.btnType1 = uiLink:Get("btnType1"):GetComponent("Button");
    ui.btnType2 = uiLink:Get("btnType2"):GetComponent("Button");
    ui.btnType3 = uiLink:Get("btnType3"):GetComponent("Button");
    ui.btnAdd = uiLink:Get("btnAdd"):GetComponent("Button");
    ui.btnLessen = uiLink:Get("btnLessen"):GetComponent("Button");
    ui.btnMax = uiLink:Get("btnMax"):GetComponent("Button");
    ui.btnMin = uiLink:Get("btnMin"):GetComponent("Button");
    ui.btnMake = uiLink:Get("btnMake"):GetComponent("Button");
    ui.btnBook = uiLink:Get("btnBook"):GetComponent("Button");
    ui.tranMaterList = uiLink:Get("tranMaterList"):GetComponent("RectTransform");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.txtCount = uiLink:Get("txtCount"):GetComponent("Text");
    ui.text = uiLink:Get("text"):GetComponent("Text");
    ui.txtTip = uiLink:Get("txtTip"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnType1",function()
        if this.curType~=1 then
            this.curType=1;
            this.SwitchType(1);
        end
    end)
    uiLink:AddClickEvent("btnType2",function()
        if this.curType~=2 then
            this.curType=2;
            this.SwitchType(2);
        end
    end)
    uiLink:AddClickEvent("btnType3",function()
        if this.curType~=3 then
            this.curType=3;
            this.SwitchType(3);
        end
    end)
    uiLink:AddClickEvent("btnMax",function()
        this.count=this.maxCount;
        this.UpdateMakeLanternCount();
    end)                
    uiLink:AddClickEvent("btnMin",function()
        this.count=1;
        this.UpdateMakeLanternCount();
    end)
    uiLink:AddClickEvent("btnAdd",function()
        if this.count<this.maxCount then
            this.count=this.count+1;
            this.UpdateMakeLanternCount();
        end
    end)
    uiLink:AddClickEvent("btnLessen",function()
        if this.count>1 then
            this.count=this.count-1;
            this.UpdateMakeLanternCount();
        end
    end)
    uiLink:AddClickEvent("btnMake",function()
        this.MakeLantern();
    end)
    uiLink:AddClickEvent("btnBook",function()
        LuaMgr.ShowLuaPanel(UIName.SimulateLanternBookViewModel)
    end)
end

this.MakeLantern=function()

    if UnityEngine.Time.realtimeSinceStartup-lastClickTime<maskInterval then
        return;
    end
AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/equip_starup.mp3");
    lastClickTime=UnityEngine.Time.realtimeSinceStartup;
    local style_part=this.partListDic["1"][this.curStyleIndex];
    local color_part=this.partListDic["2"][this.curColorIndex];
    local flower_part=this.partListDic["3"][this.curFlowerIndex];
    if this.CheckIsLock(style_part.Id) or this.CheckIsLock(color_part.Id) or this.CheckIsLock(flower_part.Id) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SimulateLanternMakeViewModel_0"));
        return;
    end
    SimulateRoomMgr.OnAskMakeLight(this.lightId,this.count,function()
        this.ParseData();
        SetActive(ui.goMaskLightFx,true)
        NumTool.DelayHandler(function()
            if ui~=nil and ui.goMaskLightFx~=nil then
                SetActive(ui.goMaskLightFx,false)
            end
        end,1)
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
        this.InitUI(vm.behaviour);
        this.partUIList=UIListView.New(ui.tranMaterList)
        this.partItemObj=vm.behaviour.transform:Find("template/partItem").gameObject;
        this.lightBagUIList=UIListView.New(ui.tranContent);
        this.bagItemObj=vm.behaviour.transform:Find("template/lanternItem").gameObject;
        RedMgr.Singleton:RegisterViewModel(UIName.SimulateLanternMakeViewModel)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.curType=nil;
            this.partIndex=nil;
this.curStyleIndex=1;
this.curColorIndex=1;
this.curFlowerIndex=1;
            this.count=1;
            this.maxCount=ConfigMgr.Config.SimulateConstants.SimulateMakeLimit;

            this.partListDic={}
            for i,v in pairs(ConfigMgr.Config.SimulateMergeMap) do
                if this.partListDic[tostring(v.Type)]==nil then
                    this.partListDic[tostring(v.Type)]={};
                end
                table.insert(this.partListDic[tostring(v.Type)],v);
            end
            for i,v in pairs(this.partListDic) do
                table.sort(v,function(a, b) return a.Sort<b.Sort end)
            end

            this.lightBagList={}
            for i,v in pairs(ConfigMgr.Config.SimulateHandBookMap) do
                table.insert(this.lightBagList,v);
            end
            table.sort(this.lightBagList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)

            local partId="s1";
            if vm.behaviour.Params.Length>0 then
                 partId=vm.behaviour.Params[0];
            end
            this.curType=ConfigMgr.Config.SimulateMergeMap[partId].Type;
            for i,v in ipairs(this.partListDic[tostring(this.curType)]) do
                if v.Id==partId then
                    this.partIndex=i;
                    break
                end
            end
            SetActive(ui.goMaskLightFx,false)
            this.ParseData();
            this.UpdateMakeLanternCount();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.partUIList:Clear();
        this.lightBagUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_LanternPartItem")
        UIListView.ClearItem("Simulate_LanternItem")
    end
}

this.SwitchType=function()
    SetActive(ui.goType1On,this.curType==1);
    SetActive(ui.goType2On,this.curType==2);
    SetActive(ui.goType3On,this.curType==3);
    if this.curType==1 then
        this.partIndex=this.curStyleIndex;
        elseif this.curType==2 then
        this.partIndex=this.curColorIndex;
        elseif this.curType==3 then
        this.partIndex=this.curFlowerIndex
    end
    this.SetLightPartList();
end

this.ParseData=function()
    SimulateRoomMgr.LightCollectRewardsRed();
    this.dataFlowerLight=DataMgr.Player.SimulateFlowerLight;
    this.SwitchType();
    this.UpdateStyleOrColorOrFlowerIndex();
    this.UpdateLantern();
    this.SetLightBagList();
end


this.CheckIsLock=function(partId)
    if IsNull(this.dataFlowerLight) or IsNull(this.dataFlowerLight.LightPart)  then
        return true
    end
    return this.dataFlowerLight.LightPart[partId]==nil;
end

this.SetLightPartList=function()
    local partList=this.partListDic[tostring(this.curType)];
    this.partUIList:Clear();
    local list={}
    for i,v in ipairs(partList) do
        local partItem={
            index=i,
            id=v.Id,
            iconName=v.Icon,
            name=LuaMgr.GetLangText(v.NameLan);
            isLock=this.CheckIsLock(v.Id);
            isCur=i==this.partIndex;
            callBack=this.LightPartCallBack;
        }
        local partData=UIListData.GetData(this.partItemObj,"Simulate_LanternPartItem",partItem);
        table.insert(list,partData);
    end
    this.partUIList:SetData(list);
end

this.LightPartCallBack=function(index)
    if this.partIndex~=nil and this.partIndex==index then
        return;
    end
    this.partIndex=index;
    this.UpdateStyleOrColorOrFlowerIndex();
    this.UpdateLantern();
    for i,v in ipairs(this.partUIList.itemList) do
        v:SetSelect(i==index);
    end
end

this.UpdateStyleOrColorOrFlowerIndex=function()
    if this.curType==1 then
        this.curStyleIndex=this.partIndex;
    elseif this.curType==2 then
        this.curColorIndex=this.partIndex;
    elseif this.curType==3 then
        this.curFlowerIndex=this.partIndex;
    end
end


this.CheckLanternLight=function(c,g,s)
    for i,v in pairs(ConfigMgr.Config.SimulateHandBookMap) do
        if v.Combine[1]==c and v.Combine[2]==g and v.Combine[3]==s then
            return v;
        end
    end
    return nil;
end


this.UpdateLantern=function()
    local style_part=this.partListDic["1"][this.curStyleIndex];
    local color_part=this.partListDic["2"][this.curColorIndex];
    local flower_part=this.partListDic["3"][this.curFlowerIndex];
    local makeLight=this.CheckLanternLight(color_part.Id,flower_part.Id,style_part.Id);
    if makeLight==nil then
        LuaDebug.error("Error: SimulateLanternMakeViewModel line 281")
        return 
    end
    ui.imgLantern.sprite=LuaMgr.GetSprite("Simulate",makeLight.Icon);






















    this.lightId=makeLight.Id;
    SetActive(ui.goSpecial,makeLight.IsSpecial>0)
end


this.UpdateMakeLanternCount=function()
    ui.txtTip.text=string.format(LuaMgr.GetLangText("SimulateLanternMakeViewModel_1"),this.count,this.maxCount);
    ui.txtCount.text=this.count;
end


this.SetLightBagList=function()
    this.lightBagUIList:Clear();
    local list={}
    for i,v in ipairs(this.lightBagList) do
        local myCount=SimulateRoomMgr.GetLanternCount(v.Id);
        if myCount>0 then
            local lanternItem={
                name=LuaMgr.GetLangText(v.NameLan),
                iconName=v.Icon;
                count=myCount;
                isSpecial=v.IsSpecial>0;
            }
            local lanternData=UIListData.GetData(this.bagItemObj,"Simulate_LanternItem",lanternItem)
            table.insert(list,lanternData)
        end
    end
    this.lightBagUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})
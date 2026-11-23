require("ViewModel/Simulate/Simulate_TechTreeItem")
require("ViewModel/Simulate/Simulate_TechAddTreeItem")

local this = {
    vm = nil,
    treeUIList={};
    treeItemObj=nil;
    previewUIList={};
    treeAddItem=nil;
};

local treePosList={Vector2(0,0),Vector2(0,182),Vector2(182,47),Vector2(111,-143),Vector2(-106,-151.5),
                   Vector2(-176.8,50),Vector2(269,-92.3),Vector2(-262,-90),Vector2(382.8,128),Vector2(433.3,-144),
                   Vector2(-427.1,-144),Vector2(-389.6,133.6),}


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.goPopPanel = uiLink:Get("goPopPanel");
    ui.goUnlockInfo = uiLink:Get("goUnlockInfo");
    ui.goPreviewPanel = uiLink:Get("goPreviewPanel");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.btnClosePopPanel = uiLink:Get("btnClosePopPanel"):GetComponent("Button");
    ui.btnCost = uiLink:Get("btnCost"):GetComponent("Button");
    ui.btnPreview = uiLink:Get("btnPreview"):GetComponent("Button");
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.tranTreeList = uiLink:Get("tranTreeList"):GetComponent("RectTransform");
    ui.tranPreviewContent = uiLink:Get("tranPreviewContent"):GetComponent("RectTransform");
    ui.imgTag = uiLink:Get("imgTag"):GetComponent("Image");
    ui.txtName = uiLink:Get("txtName"):GetComponent("Text");
    ui.txtDes = uiLink:Get("txtDes"):GetComponent("Text");
    ui.txtCostCount = uiLink:Get("txtCostCount"):GetComponent("Text");
    ui.rawCostIcon = uiLink:Get("rawCostIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
   uiLink:AddClickEvent("btnCost",function()
       if this.cfgTree==nil then
           return;
       end
       SimulateRoomMgr.OnAskTechTree(this.cfgTree.Id,function()
           this.ParseData(true);
       end)
   end)
    uiLink:AddClickEvent("btnClosePopPanel",function()
        SetActive(ui.goPopPanel,false)
    end)
    uiLink:AddClickEvent("btnMask",function()
        SetActive(ui.goPreviewPanel,false)
    end)
    uiLink:AddClickEvent("btnPreview",function()
        SetActive(ui.goPopPanel,false);
        SetActive(ui.goPreviewPanel,true);
        this.animator:Play("ani_SimulateTeachTreePanel_root_002",0,0)
        this.SetPreviewUIList();
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
        this.treeUIList=UIListView.New(ui.tranTreeList);
        this.previewUIList=UIListView.New(ui.tranPreviewContent)
        this.treeItemObj=vm.behaviour.transform:Find("template/treeItem").gameObject;
        this.treeAddItemObj=vm.behaviour.transform:Find("template/treeAddItem").gameObject;
        this.animator=vm.behaviour.transform:Find("root"):GetComponent("Animator");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.techList={};
            for i,v in pairs(ConfigMgr.Config.SimulateTechMap) do
                table.insert(this.techList,v);
            end
            table.sort(this.techList,function(a, b) return tonumber(a.Id)<tonumber(b.Id) end)
            SetActive(ui.goPreviewPanel,false);
            SetActive(ui.goPopPanel,false)
            this.animator:Play("ani_SimulateTeachTreePanel_root_001",0,0)
            RedMgr.Singleton:FrushRedCondition("17309");
            this.ParseData();
        end
        
    end,
    before_deactive = function(vm)
        print("before_deactive");
        this.treeUIList:Clear();
        this.previewUIList:Clear();
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Simulate_TechTreeItem")
        UIListView.ClearItem("Simulate_TechAddTreeItem")
    end
}

this.ParseData=function(isPop)
   this.dateTechTree=DataMgr.Player.SimulateArchitect.TechTree;
    this.SetTreeUIList();
    if isPop and this.treeIndex~=nil then
        this.TreeCallBack(this.treeIndex);
    else
        SetActive(ui.goPopPanel,false)
    end
end

this.SetTreeUIList=function()
    this.treeUIList:Clear();
    local list={}
    for i,v in ipairs(this.techList) do
        local techItem={
            index=i,
            type=i==1 and 0 or 1;
            iconName=v.BuffIcon,
            pos=treePosList[i],
            langId=v.UnlockDesc[1];
            state=this.GetTreeState(v),
            callBack=this.TreeCallBack,
        }
        local techData=UIListData.GetData(this.treeItemObj,"Simulate_TechTreeItem",techItem);
        table.insert(list,techData);
    end
    this.treeUIList:SetData(list);
end


this.GetTreeState=function(tree)
    if not IsNull(this.dateTechTree) and this.dateTechTree[tree.Id]~=nil then
        return 3
    end
    if tree.Unlock[1]=="0" then
        return 2
    end
    if tree.Unlock[1]=="1" and #tree.Unlock>1 then
        local preId=tree.Unlock[2]
        if not IsNull(this.dateTechTree) and this.dateTechTree[preId]~=nil then
            return 2;
        end
        return 1;
    end
    return 1;
end

this.TreeCallBack=function(index)
    this.treeIndex=index;
    local treeData= this.treeUIList.dataList[index].data
    if treeData.state==1 then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal(treeData.langId))
        return;
    end
    this.SetPopPanelInfo(index,treeData.state);
end

this.SetPopPanelInfo=function(index,state)
    SetActive(ui.goPopPanel,true);
    this.cfgTree=this.techList[index]
    ui.imgTag.sprite=LuaMgr.GetSprite("Simulate",this.cfgTree.BuffIcon.."_yl")
    ui.txtName.text=LuaMgr.GetLangText(this.cfgTree.BuffNameLan)
    ui.txtDes.text=LuaMgr.GetLangText(this.cfgTree.BuffDesLan)
    SetActive(ui.goUnlockInfo,state<3)
    if state<3 then

        local itemPath=ConfigHelper.GetItemHomeIconPath(this.cfgTree.Consume[1].id)
        ui.rawCostIcon.texture=LuaMgr.GetTexture(itemPath);
        ui.txtCostCount.text=this.cfgTree.Consume[1].count;
    end
end

this.SetPreviewUIList=function()
    this.previewUIList:Clear();
    local list={}
    for i,v in ipairs(this.techList) do
        if not IsNull(this.dateTechTree) and this.dateTechTree[v.Id]~=nil then
            local preItem={
                text=LuaMgr.GetLangText(v.BuffDesLan);
            }
            local preData=UIListData.GetData(this.treeAddItemObj,"Simulate_TechAddTreeItem",preItem);
            table.insert(list,preData);
        end
    end
    this.previewUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})
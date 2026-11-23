

local this = {
    buffItemList = {},
    buffDataList = {},
};
require("CollectorPractice/Version2/Common/UIChooseBuffVersion2Item")
local BUFF_PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/Version2/UIChooseBuffVersion2Item.prefab";
local tarGameObject = nil;
local tarRect = nil;
local UIChooseBuffVersion2ItemPrefab = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnMask = nil;
local ScrollView = nil;
local rectContent = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    UIChooseBuffVersion2ItemPrefab = LuaMgr.GetPrefab(BUFF_PREFAB_PATH);
    UIChooseBuffVersion2ItemPrefab:GetComponent("RectTransform"):SetParent(root:GetComponent("RectTransform"));
    SetActive(UIChooseBuffVersion2ItemPrefab,false);
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    uiLink:AddClickEvent("btnMask", function()
        LuaMgr.HidePanel(UIName.CollectorPracticeShowBuffDataVersion2ViewModel);
    end);
end

this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UIChooseBuffVersion2ItemPrefab = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnMask = nil;
    ScrollView = nil;
    rectContent = nil;
    for index, value in ipairs(this.buffItemList) do
        value:Destroy();
    end
    this = nil;
end

this.InitData = function()
    this.buffDataList = {};
end

this.InitPanel = function()
    for i = 1, #this.buffDataList, 1 do
        if i > #this.buffItemList then
            local temp = UIChooseBuffVersion2Item.New();
            temp.gameObject = LuaMgr.InstantiateGO(UIChooseBuffVersion2ItemPrefab, rectContent, false)
            temp:Init();
            table.insert(this.buffItemList, temp);
        end
        local data = {
            data = {},
        };
        data.data = table.Copy(CollectorPracticeMgrVersion2.GetBuffValueById(this.buffDataList[i]));
        data.data.fun = nil;
        data.data.isChoose = false;
        data.data.groupIndex = 0;
        this.buffItemList[i]:SetData(data);
    end
    for i = #this.buffDataList + 1, #this.buffItemList, 1 do
        this.buffItemList[i]:Hide();
    end

    local needWidth=(305 * #this.buffDataList + (#this.buffDataList - 1) * 30);
    local screenWidth=(LuaMgr.GetScreenAddWidth() + 1280);
    ScrollView:GetComponent("RectTransform").sizeDelta = Vector2(
        needWidth > screenWidth
        and screenWidth 
        or needWidth
        , 464)
    
if needWidth >= screenWidth then
        ScrollView.movementType = CS.UnityEngine.UI.ScrollRect.MovementType.Elastic;
    else
        ScrollView.movementType = CS.UnityEngine.UI.ScrollRect.MovementType.Clamped;
    end

    for i = 1, #this.buffDataList, 1 do
        this.buffItemList[i]:ShowFirstAnimation();
    end
end


local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        LuaMgr.AddPrefabRefCount(BUFF_PREFAB_PATH);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.InitData();
        table.insert(this.buffDataList, vm.behaviour.Params[0]);
        this.InitPanel();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
        end
    end,
    before_destroy = function(vm)
        LuaMgr.RemovePrefabRefCount(BUFF_PREFAB_PATH);
        this.Clear();
    end,
}

return vm({
    hook = hook
})
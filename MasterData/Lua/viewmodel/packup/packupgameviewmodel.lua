require("ViewModel/PackUp/PackUpGameItem")
require("ViewModel/PackUp/PackUpGameGrid")

local this = {
    vm = nil,
    puzzleUIList = {},
    gridUIList = {},
    itemObjList = {},
    exitType = nil,
};

local puzzleId = nil;
local isComplete = false;
local coKeyComplete = nil;
local coKeyEdge = nil;
local curPuzzle = nil;
local verticalLG = nil;


local tarGameObject  = nil
local tarRect        = nil
local tranGridItem   = nil
local tranPuzzleItem = nil
local animator       = nil
local Left           = nil
local Middle         = nil
local ScrollView     = nil
local tranContent    = nil
local goTools        = nil
local btnBack        = nil
local imgBG          = nil
local tranGrids      = nil
local tranItems      = nil
local tranZeroPos    = nil
local tranRect       = nil
local goExitePanel   = nil
local btnCancel      = nil
local btnExit        = nil
local textExitTip    = nil
local textTitle      = nil
local Right          = nil
local btnMask        = nil
local goExit         = nil
local goReward       = nil
local btnComfirm     = nil
local tranRewardBox  = nil


this.Init = function(prefab)
    local uiLink   = prefab.gameObject:GetComponent("UILink");
    tarGameObject  = prefab
    tarRect        = prefab.gameObject:GetComponent("RectTransform")
    tranGridItem   = uiLink:Get("tranGridItem");
    tranPuzzleItem = uiLink:Get("tranPuzzleItem");
    animator       = uiLink:Get("root"):GetComponent("Animator");
    Left           = uiLink:Get("Left");
    Middle         = uiLink:Get("Middle");
    ScrollView     = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent    = uiLink:Get("tranContent"):GetComponent("RectTransform");
    goTools        = uiLink:Get("goTools");
    btnBack        = uiLink:Get("btnBack"):GetComponent("Button");
    imgBG          = uiLink:Get("imgBG"):GetComponent("RawImage");
    tranGrids      = uiLink:Get("tranGrids"):GetComponent("RectTransform");
    tranItems      = uiLink:Get("tranItems"):GetComponent("RectTransform");
    tranZeroPos    = uiLink:Get("tranZeroPos"):GetComponent("RectTransform");
    tranRect       = uiLink:Get("tranRect"):GetComponent("RectTransform");
    goExitePanel   = uiLink:Get("goExitePanel");
    btnCancel      = uiLink:Get("btnCancel"):GetComponent("Button");
    btnExit        = uiLink:Get("btnExit"):GetComponent("Button");
    textExitTip    = uiLink:Get("textExitTip"):GetComponent("Text");
    textTitle      = uiLink:Get("textTitle"):GetComponent("Text");
    Right          = uiLink:Get("Right");
    btnMask        = uiLink:Get("btnMask"):GetComponent("Button");
    goExit         = uiLink:Get("goExit")
    goReward       = uiLink:Get("goReward")
    btnComfirm     = uiLink:Get("btnComfirm"):GetComponent("Button");
    tranRewardBox  = uiLink:Get("tranRewardBox"):GetComponent("Transform");
    this.AddRegister(uiLink);
end


this.Clear = function()
    tarGameObject  = nil
    tarRect        = nil
    tranGridItem   = nil
    tranPuzzleItem = nil;
    tranGrids      = nil;
    tranItems      = nil;
    tranZeroPos    = nil
    tranRect       = nil
    imgBG          = nil;
    animator       = nil;
    Left           = nil;
    Middle         = nil;
    goTools        = nil;
    goExitePanel   = nil;
    Right          = nil;
    ScrollView     = nil;
    tranContent    = nil;
    btnBack        = nil;
    btnCancel      = nil;
    btnExit        = nil;
    textExitTip    = nil;
    textTitle      = nil;
    btnMask        = nil;
    goExit         = nil;
    goReward       = nil;
    btnComfirm     = nil;
    tranRewardBox  = nil;
end

this.AddRegister = function(uiLink)
    uiLink:AddClickEvent("btnBack", this.BtnClearExecute)
    uiLink:AddClickEvent("btnCancel", function()
        SetActive(goExitePanel, false);
    end)
    uiLink:AddClickEvent("btnExit", function()
        SetActive(goExitePanel, false);
        if (this.exitType == 1) then
            PackUpMgr.ResetPlacedItems();
        else
            LuaMgr.Back();
        end
    end)
    uiLink:AddClickEvent("btnMask", function()
        if isComplete then
            this.CompleteCallBackExecute()
            return;
        end
        SetActive(goExitePanel, false);
    end)
    uiLink:AddClickEvent("btnComfirm", function()
        this.CompleteCallBackExecute()
    end)
end

this.BtnClearExecute = function()
    this.ShowTipPanel(1)
    this.exitType = 1
    textExitTip.text = ConfigMgr.LangGlobal("7607");
end

this.OnAskPuzzleAward = function()
    local askData = { EventId = puzzleId };
    ApiMgr.Request("packUpGame/award", askData, true, function(re)
        LuaMgr.Back()
        local re = json.decode(re);
        local data = json.encode(re.result.Rewards);
        LuaMgr.ShowItemRewared(data);



    end, nil, true, true)
end

this.OnBack = function()
    if isComplete then
        this.ShowTipPanel(2)
        return;
    end
    this.ShowTipPanel(1)
    this.exitType = nil
    textExitTip.text = ConfigMgr.LangGlobal("7300");
end

this.ShowTipPanel = function(type)
    SetActive(goExitePanel, true);
    SetActive(goExit, type == 1);
    SetActive(goReward, type ~= 1);
end

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.Init(vm.behaviour)
        this.puzzleUIList = UIListView.New(tranContent)
        this.gridUIList = UIListView.New(tranGrids)
        verticalLG = tranContent.transform:GetComponent("VerticalLayoutGroup");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length > 0 then
                local eventConfig = nil
                puzzleId = vm.behaviour.Params[0];
                for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
                    if v.id == puzzleId then
                        eventConfig = v
                        break
                    end
                end
                curPuzzle = ConfigMgr.Config.PackUpGameMap[eventConfig.eventParam];
                isComplete = false;
                this.vm.behaviour:UpdateTopBar("", this.OnBack)

                textTitle.text = LuaMgr.GetLangText(curPuzzle.NameLan)
                textExitTip.text = ConfigMgr.LangGlobal("7300");
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.puzzleUIList:Clear();
            this.gridUIList:Clear();
            UIListView.ClearItem("PackUpGameGrid")
            UIListView.ClearItem("PackUpGameItem")
        end
        if this.itemObjList ~= nil then
            for i = 1, #this.itemObjList do
                this.itemObjList[i]:Clear()
            end
            this.itemObjList = {}
        end
    end,
    before_destroy = function()
        this.Clear();








    end

}

this.ParseData = function()


    SetActive(goTools, true);
    SetActive(goExitePanel, false);
    this.InitPuzzle();
    local itemCount = 0
    for k, v in ipairs(curPuzzle.Reward) do
        local cache = this.itemObjList[k]
        if (cache == nil) then
            cache = GoodsDataItem.New(tranRewardBox);
            this.itemObjList[k] = cache;
        end
        local scale = Vector3(0.6, 0.6, 1);
        local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemData.count0 = v.count
        cache:SetData(1, itemData, 1, false, scale, false, false);
        SetActive(cache.gameObject, true)
        itemCount = itemCount + 1
    end
    if PackUpMgr.CheckGameIsComplete(curPuzzle.Id) then
        itemCount = 0
    end
    for i = itemCount + 1, #this.itemObjList do
        this.itemObjList[i]:Hide()
    end
end

this.InitPuzzle = function()
    PackUpMgr.InitPackage(this.vm.behaviour.transform, curPuzzle)
    this.SetGrids()
    this.SetPuzzleItemList();
    PackUpMgr.ResetPlacedItems();
end

this.SetGrids = function()
    local list = {}
    local objItem = tranGridItem.gameObject
    local index = 0
    local nullMap = {}
    local mapCacheTb = {}
    for k, v in pairs(curPuzzle.PackNull) do
        nullMap[v] = true
    end
    for i = 1, curPuzzle.PackSize[1], 1 do
        for j = 1, curPuzzle.PackSize[2], 1 do
            index = index + 1
            local gridItem = {
                pos = { i - 1, j - 1 },
                isOn = nullMap[index] ~= true,
            }
            local gridItemData = UIListData.GetData(objItem, "PackUpGameGrid", gridItem);
            table.insert(list, gridItemData);
            mapCacheTb[index] = gridItem.pos[1] .. "," .. gridItem.pos[2]
        end
    end
    this.gridUIList:SetData(list);
    PackUpMgr.gridUIList = this.gridUIList;
    PackUpMgr.InitPackGridMap(mapCacheTb)
end



this.SetPuzzleItemList = function()
    verticalLG.enabled = false
    local list = {}
    local objItem = tranPuzzleItem.gameObject
    local cacheList = NumTool.split(curPuzzle.ContentPic, ";")
    local mapCacheTb = {}
    local index = 0
    for i, v in ipairs(cacheList) do
        index = index + 1
        local puzzleItem = {
            config = ConfigMgr.Config.PackUpTypeMap[v],
            itemName = v .. "," .. i,
            finishcallback = function()
                isComplete = true;
                this.ShowTipPanel(2)
            end
        }
        mapCacheTb[index] = puzzleItem.itemName
        local puzzleItemData = UIListData.GetData(objItem, "PackUpGameItem", puzzleItem);
        table.insert(list, puzzleItemData);
    end
    this.puzzleUIList:SetData(list);
    PackUpMgr.puzzleUIList = this.puzzleUIList;
    PackUpMgr.puzzleScrollView = ScrollView;
    verticalLG.enabled = true
    PackUpMgr.InitPackItemMap(mapCacheTb)
end

this.CompleteCallBackExecute = function()

    AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/Character_StarUp.mp3")
    if not PackUpMgr.CheckGameIsComplete(curPuzzle.Id) then
        this.OnAskPuzzleAward();
    else
        LuaMgr.Back()
    end
end

return vm({
    data = nil,
    command = nil,
    hook = hook
})
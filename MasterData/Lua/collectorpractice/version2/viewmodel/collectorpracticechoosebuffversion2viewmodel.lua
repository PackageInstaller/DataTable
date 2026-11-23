

local this = {
    chooseBuffIds = {},
    chooseBuffCount = 0,
    chooseBuffIndexList = {},
    configType = 0,
    nowBuffId="",
    nextBuffId="",
    isRewardBuff=false,
};
require("CollectorPractice/Version2/Common/UIChooseBuffVersion2Item")
local BUFF_PREFAB_PATH = "Assets/_BundleResources/UI/CollectorPractice/Version2/UIChooseBuffVersion2Item.prefab";
local tarGameObject = nil;
local tarRect = nil;
local UIChooseBuffVersion2Item = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goShowBuffTips = nil;
local goGmGroup = nil;
local Right = nil;
local ScrollView = nil;
local rectContent = nil;
local btnBuffClick = nil;
local btnGmAddBuff = nil;
local imgNowBuffIcon = nil;
local imgNowBuffTipsIcon = nil;
local imgNextBuffIcon = nil;
local imgNextBuffTipsIcon = nil;
local textNowBuffCount = nil;
local textNextBuffCount = nil;
local inputBuffGm = nil;
local textTitle=nil;




local CONFIG = {
    [0] = {
getBuffCount = 1,
    }
}

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    UIChooseBuffVersion2Item = LuaMgr.GetPrefab(BUFF_PREFAB_PATH);
    UIChooseBuffVersion2Item:GetComponent("RectTransform"):SetParent(root:GetComponent("RectTransform"));
    SetActive(UIChooseBuffVersion2Item,false);
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goShowBuffTips = uiLink:Get("goShowBuffTips");
    goGmGroup = uiLink:Get("goGmGroup");
    Right = uiLink:Get("Right");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    btnBuffClick = uiLink:Get("btnBuffClick"):GetComponent("Button");
    btnGmAddBuff = uiLink:Get("btnGmAddBuff"):GetComponent("Button");
    imgNowBuffIcon = uiLink:Get("imgNowBuffIcon"):GetComponent("Image");
    imgNowBuffTipsIcon = uiLink:Get("imgNowBuffTipsIcon"):GetComponent("Image");
    imgNextBuffIcon = uiLink:Get("imgNextBuffIcon"):GetComponent("Image");
    imgNextBuffTipsIcon = uiLink:Get("imgNextBuffTipsIcon"):GetComponent("Image");
    textNowBuffCount = uiLink:Get("textNowBuffCount"):GetComponent("Text");
    textNextBuffCount = uiLink:Get("textNextBuffCount"):GetComponent("Text");
    inputBuffGm = uiLink:Get("inputBuffGm"):GetComponent("InputField");
    textTitle= uiLink:Get("textTitle"):GetComponent("Text");
    this.configType = 0;
    uiLink:AddClickEvent("btnBuffClick", function()
        this.ClickConfirm();
    end)
    uiLink:AddClickEvent("btnClickNowBuff", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShowBuffDataVersion2ViewModel,this.nowBuffId);
    end)
    uiLink:AddClickEvent("btnClickNextBuff", function()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeShowBuffDataVersion2ViewModel,this.nextBuffId);
    end)
    uiLink:AddClickEvent("btnGmAddBuff", function()

        local text = inputBuffGm.text;
        if text == "" then
            return;
        end
        local buffTable = split(text, ";");
        local tempData = {}
        tempData.BufferIds = buffTable;
        ApiMgr.Request("practice/upBuffer", tempData, true, function(result)
            this.CallBack();
        end, nil, true)
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    UIChooseBuffVersion2Item = nil;
    root = nil;
    Left = nil;
    Middle = nil;
    goShowBuffTips = nil;
    goGmGroup = nil;
    Right = nil;
    ScrollView = nil;
    rectContent = nil;
    btnBuffClick = nil;
    btnGmAddBuff = nil;
    imgNowBuffIcon = nil;
    imgNowBuffTipsIcon = nil;
    imgNextBuffIcon = nil;
    imgNextBuffTipsIcon = nil;
    textNowBuffCount = nil;
    textNextBuffCount = nil;
    inputBuffGm = nil;
    textTitle=nil;
    this=nil;
end


this.ClickConfirm = function()
    local config = CONFIG[this.configType];
    if this.chooseBuffCount == config.getBuffCount then
        local tempData = {}
        local chooseBuff = {};
        for index, value in ipairs(this.chooseBuffIds) do
            table.insert(chooseBuff, value);
        end
        tempData["EventID"] = DataMgr.Player.practiceStage2.stages[DataMgr.Player.practiceStage2.crtEventNo+1].EventID;
        tempData["Index"] = CollectorPracticeMgrVersion2.GetNotFinishStage();
        tempData["EventNo"]= DataMgr.Player.practiceStage2.crtEventNo;
        tempData["Params"] = chooseBuff;
        ApiMgr.Request("practice2/end_event", tempData, true, function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.CallBack();
                local data=DataMgr.Player.practiceStage2.stages;
                local nowNo=DataMgr.Player.practiceStage2.crtEventNo;
                local nowEvent=data[nowNo+1];
                local config=ConfigMgr.Config.YX2EventMap;
if nowEvent.state==1 then
                    local notFinishEventStage=nil;
                    for index, value in ipairs(nowEvent.Stage) do
                        if not value.Finish then
                            notFinishEventStage=value;
                            break;
                        end
                    end
if notFinishEventStage.EventID=="CHOOSE_BUFF" then
                        this.InitData();
                        this.InitSV(this.configType);
                        this.InitPanel(this.configType);
                    end
                else
                    LuaMgr.HidePanel(UIName.CollectorPracticeChooseBuffVersion2ViewModel)
LuaMgr.InvokeUIEventListeners(UIEventConst.CheckEventFinish);
                end
            end
        end, nil, true)
    end
end

this.InitDebugButton = function()
SetActive(goGmGroup, false)
end


this.CallBack = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshState);
end

this.ClickItem = function(itemOBJ)
    local config = CONFIG[this.configType];
if config.getBuffCount == 1 then
if this.chooseBuffCount == 0 then
            table.insert(this.chooseBuffIds, itemOBJ.data.Id);
            table.insert(this.chooseBuffIndexList, itemOBJ.data.groupIndex);
            this.SV.dataList[itemOBJ.data.groupIndex].data.isChoose = true;
            this.SV:Refresh();
            this.chooseBuffCount = this.chooseBuffCount + 1;
            this.ShowBuffTips(itemOBJ.data.Id);
        else
if itemOBJ.data.groupIndex == this.chooseBuffIndexList[1] then
                table.remove(this.chooseBuffIds, 1);
                table.remove(this.chooseBuffIndexList, 1);
                this.SV.dataList[itemOBJ.data.groupIndex].data.isChoose = false;
                this.SV:Refresh();
                this.chooseBuffCount = this.chooseBuffCount - 1;
                this.ShowBuffTips(nil);
            else
                this.SV.dataList[this.chooseBuffIndexList[1]].data.isChoose = false;
                this.chooseBuffIds[1] = itemOBJ.data.Id;
                this.chooseBuffIndexList[1] = itemOBJ.data.groupIndex;
                this.SV.dataList[this.chooseBuffIndexList[1]].data.isChoose = true;
                this.SV:Refresh();
                this.ShowBuffTips(itemOBJ.data.Id);
            end
        end
    else
        local isReply = false;
        local replyIndex = 0;
        for index, value in ipairs(this.chooseBuffIndexList) do
            if value == itemOBJ.data.groupIndex then
                isReply = true;
                replyIndex = index;
                break;
            end
        end
if isReply then
            table.remove(this.chooseBuffIds, replyIndex);
            table.remove(this.chooseBuffIndexList, replyIndex);
            this.SV.dataList[itemOBJ.data.groupIndex].data.isChoose = false;
            this.SV:Refresh();
            this.chooseBuffCount = this.chooseBuffCount - 1;
            this.ShowBuffTips(nil);
else
            if this.chooseBuffCount < config.getBuffCount then
                table.insert(this.chooseBuffIds, itemOBJ.data.Id);
                table.insert(this.chooseBuffIndexList, itemOBJ.data.groupIndex);
                this.SV.dataList[itemOBJ.data.groupIndex].data.isChoose = true;
                this.SV:Refresh();
                this.chooseBuffCount = this.chooseBuffCount + 1;
                this.ShowBuffTips(itemOBJ.data.Id);
            end
        end
    end
    this.CheckButtonState(this.configType);
end

this.CheckButtonState = function(configType)
    local config = CONFIG[configType];
    SetActive(btnBuffClick.gameObject, this.chooseBuffCount == config.getBuffCount)
end

this.ShowBuffTips = function(buffId)
    if buffId == nil then
        SetActive(goShowBuffTips, false);
    else
        SetActive(goShowBuffTips, true);
        local type = CollectorPracticeMgrVersion2.NormalBuffMap[buffId].Type[2];
        local nowValue = TableIsNull(CollectorPracticeMgrVersion2.HaveRewardBuff[type]) and 0 or #CollectorPracticeMgrVersion2.HaveRewardBuff[type]; 
        if nowValue < 3 or nowValue > 9 then
            SetActive(goShowBuffTips, false);
        else
local nowStage = nowValue // 3;

            local nowBuff = CollectorPracticeMgrVersion2.ReawrdTypeBuffMap[type][nowStage];
            this.nowBuffId=nowBuff.Id;
            imgNowBuffIcon.sprite = LuaMgr.GetSprite("BuffIcon", nowBuff.BuffIcon);
            textNowBuffCount.text = tostring((nowStage)*3);
            imgNowBuffTipsIcon.sprite = CollectorPracticeMgrVersion2.GetBuffTipsIconSprite(nowValue);

            local nextBuff = CollectorPracticeMgrVersion2.ReawrdTypeBuffMap[type][nowStage + 1];
            this.nextBuffId=nextBuff.Id;
            imgNextBuffIcon.sprite = LuaMgr.GetSprite("BuffIcon", nextBuff.BuffIcon);
            textNextBuffCount.text = tostring((nowStage + 1) * 3);
            imgNextBuffTipsIcon.sprite = CollectorPracticeMgrVersion2.GetBuffTipsIconSprite((nowStage + 1) * 3);
        end
    end
end

this.InitData = function()
    this.chooseBuffIds = {};
    this.chooseBuffCount = 0;
    this.chooseBuffIndexList = {};
if this.isRewardBuff then
        local buffData=DataMgr.Player.practiceStage2.chooseBuffs;
        this.chooseBuffCount=#buffData;
        for index, value in ipairs(buffData) do
            table.insert(this.chooseBuffIds,value);
        end
    end
end

this.InitPanel = function(configType)
    SetActive(goShowBuffTips, false);
    if this.isRewardBuff then
        textTitle.text=ConfigMgr.LangGlobal("7209")
    else
        textTitle.text=ConfigMgr.LangGlobal("7190")
    end

    for index, value in ipairs(this.SV.screenList) do
        value:ShowFirstAnimation();
    end
end


this.InitSV = function(configType)
    this.SV:Clear(false);
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    local scrollDatas = this.GetScrollViewDataByGrade(configType);
    this.ShowSVResult(scrollDatas);
    this.ShowBuffTips(nil);
end

this.GetScrollViewDataByGrade = function(configType)
    local config = CONFIG[configType];
    local scrollData = nil;
    local scrollDatas = {};
    local data = DataMgr.Player.practiceStage2.chooseBuffs;

    local tempData = {};
    for index, value in ipairs(data) do
        tempData = table.Copy(CollectorPracticeMgrVersion2.GetBuffValueById(value));
tempData.fun = (not this.isRewardBuff) and this.ClickItem or nil;
tempData.isChoose =this.isRewardBuff and true or false;
        tempData.groupIndex = index;
        scrollData = UIScrollData.GetData(UIChooseBuffVersion2Item, "UIChooseBuffVersion2Item", 305,
            464, tempData);
        table.insert(scrollDatas, scrollData);
    end
    return scrollDatas;
end


this.ShowSVResult = function(scrollDatas)
    local needWidth = 305 * (#scrollDatas);
    this.SV:SetParams(needWidth < this.scrollWidth and needWidth or this.scrollWidth, 464);
if needWidth >= this.scrollWidth then
        ScrollView.movementType = CS.UnityEngine.UI.ScrollRect.MovementType.Elastic;
    else
        ScrollView.movementType = CS.UnityEngine.UI.ScrollRect.MovementType.Clamped;
    end
    this.SV:SetData(scrollDatas);
    this.SV:MoveToIndex(math.ceil(#scrollDatas / 2), true);
    this.SV:Refresh()
end


local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        LuaMgr.AddPrefabRefCount(BUFF_PREFAB_PATH)
        this.SV = UIScrollView.New(ScrollView.gameObject);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
this.isRewardBuff=vm.behaviour.Params[0];
        this.InitData();
        this.InitSV(this.configType);
        this.InitPanel(this.configType);
        this.InitDebugButton();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.SV:Clear(true);
        end
    end,
    before_destroy = function(vm)
        LuaMgr.RemovePrefabRefCount(BUFF_PREFAB_PATH)
        this.Clear();
        UIScrollView.ClearItem("UIChooseBuffVersion2Item");
    end,
}

return vm({
    hook = hook
})
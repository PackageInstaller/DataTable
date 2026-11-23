

local this = {
    callBack = nil,
    chooseBuffIds = {},
    chooseBuffCount=0,
    chooseBuffIndexList={},
    grade = 0,
    haveBuff = {},
};
require("CollectorPractice/Common/UICollectorPracticeBuffItem")

local tarGameObject = nil;
local tarRect = nil;
local UICollectorPracticeBuffItemPrefab = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local textTips = nil;
local ScrollView = nil;
local rectContent = nil;
local btnBuffClick = nil;
local btnDeBuffClick = nil;
local goBufTipsBG = nil;
local goDeBufTipsBG = nil;
local goSpecialGroup = nil;
local rectBG2 = nil;
local rectBG3 = nil;
local specialTweener = nil;
local inputBuffGm=nil;
local goGmGroup=nil;
local CONFIG={
    [-1]={
state=tonumber("0011",2),
        showBuffCount=3,
getBuffCount=1,
    },
    [1]={
state=tonumber("0100",2),
        showBuffCount=-1,
getBuffCount=1,
    },
    [2]={
state=tonumber("0110",2),
        showBuffCount=-1,
getBuffCount=1,
    },
    [3]={
state=tonumber("1010",2),
        showBuffCount=5,
getBuffCount=2,
    }
}
local animator = nil;
local firstConfirm = true;
local PREFAB_PATH="Assets/_BundleResources/UI/CollectorPractice/UICollectorPracticeBuffItem.prefab";
this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    UICollectorPracticeBuffItemPrefab = LuaMgr.GetPrefab(PREFAB_PATH)
    LuaMgr.AddPrefabRefCount(PREFAB_PATH);
    SetActive(UICollectorPracticeBuffItemPrefab, false);
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    animator = uiLink:Get("root"):GetComponent("Animator");
    goBufTipsBG = uiLink:Get("goBufTipsBG");
    goDeBufTipsBG = uiLink:Get("goDeBufTipsBG");
    Right = uiLink:Get("Right");
    textTips = uiLink:Get("textTips"):GetComponent("Text");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    rectContent = uiLink:Get("rectContent"):GetComponent("RectTransform");
    btnBuffClick = uiLink:Get("btnBuffClick"):GetComponent("Button");
    btnDeBuffClick = uiLink:Get("btnDeBuffClick"):GetComponent("Button");
    goSpecialGroup = uiLink:Get("goSpecialGroup")
    rectBG2 = uiLink:Get("rectBG2"):GetComponent("RectTransform");
    rectBG3 = uiLink:Get("rectBG3"):GetComponent("RectTransform");
    inputBuffGm = uiLink:Get("inputBuffGm"):GetComponent("InputField");
    goGmGroup=uiLink:Get("goGmGroup");
    uiLink:AddClickEvent("btnBuffClick", function()
        this.ClickConfirm();
    end)
    uiLink:AddClickEvent("btnDeBuffClick", function()
        this.ClickConfirm();
    end)
    uiLink:AddClickEvent("btnMask", function()
        local config=CONFIG[this.grade];
        if this.chooseBuffCount == config.getBuffCount then
            if not firstConfirm then
                local tempData = {}
                local chooseBuff = {};
                for index, value in ipairs(this.chooseBuffIds) do
                    table.insert(chooseBuff, value);
                end
                local chooseGrades = {};
                if this.grade ~= -1 then
                    table.insert(chooseGrades, this.grade);
                else
                    chooseGrades = nil;
                end
                tempData.BufferIds = chooseBuff;
                tempData["Grades"] = chooseGrades;
                ApiMgr.Request("practice/upBuffer", tempData, true, function(result)
                    local re = json.decode(result)
                    if re.code == 0 then
                        this.CallBack();
                        LuaMgr.HidePanel(UIName.CollectorPracticeChooseBuffViewModel)
                    end
                end, nil, true)
            end
        end
    end)
    uiLink:AddClickEvent("btnGmAddBuff", function()
        local text=inputBuffGm.text;
        if text=="" then
            return;
        end
        local buffTable=split(text,";");
        local tempData={}
        tempData.BufferIds = buffTable;
        ApiMgr.Request("practice/upBuffer", tempData, true, function(result)

        end, nil, true)
    end)
end

this.ClickConfirm = function()
if animator:GetCurrentAnimatorStateInfo(0).normalizedTime < 1 then
        return
    end
    local config=CONFIG[this.grade];
    if this.chooseBuffCount == config.getBuffCount then
        if firstConfirm then
            local scrollDatas = {}
            for index, value in ipairs(this.chooseBuffIds) do
                local tempData = table.Copy(CollectorPracticeMgr.buffIdToBuffConfig[value]);
                tempData.fun = nil;
                tempData.isChoose = true;
                local scrollData = UIScrollData.GetData(UICollectorPracticeBuffItemPrefab, "UICollectorPracticeBuffItem", 272,
                    440, tempData);
                table.insert(scrollDatas, scrollData);
            end
            this.ShowSVResult(scrollDatas);
            this.ShowResult();
            SetActive(btnBuffClick.gameObject, false);
            SetActive(btnDeBuffClick.gameObject, false);
            firstConfirm = false;
        end
    end
end

this.InitDebugButton = function()
    SetActive(goGmGroup, LuaMgr.IsDebug())
end

this.Clear = function()
    LuaMgr.RemovePrefabRefCount(PREFAB_PATH);
    tarGameObject = nil
    tarRect = nil
    LuaMgr.DestroyImmediateGO(UICollectorPracticeBuffItemPrefab);
    UICollectorPracticeBuffItemPrefab = nil;
    root = nil;
    Left = nil;
    animator = nil;
    Middle = nil;
    goBufTipsBG = nil;
    goDeBufTipsBG = nil;
    inputBuffGm=nil;
    goGmGroup=nil;
    Right = nil;
    textTips = nil;
    ScrollView = nil;
    rectContent = nil;
    btnBuffClick = nil;
    btnDeBuffClick = nil;
    goSpecialGroup = nil;
    rectBG3 = nil;
    rectBG2 = nil;
end

this.CallBack = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.NeedRefreshBuff);
    if this.callBack ~= nil then
        this.callBack();
    end
end

this.ClickItem = function(itemOBJ)
    local config=CONFIG[this.grade];
if config.getBuffCount==1 then
if this.chooseBuffCount==0 then
            table.insert(this.chooseBuffIds,itemOBJ.data.Id);
            table.insert(this.chooseBuffIndexList,itemOBJ.data.groupIndex);
            this.SV.dataList[itemOBJ.data.groupIndex].data.isChoose=true;
            this.SV:Refresh();
            this.chooseBuffCount=this.chooseBuffCount+1;
        else
if itemOBJ.data.groupIndex==this.chooseBuffIndexList[1] then
                table.remove(this.chooseBuffIds,1);
                table.remove(this.chooseBuffIndexList,1);
                this.SV.dataList[itemOBJ.data.groupIndex].data.isChoose=false;
                this.SV:Refresh();
                this.chooseBuffCount=this.chooseBuffCount-1;
            else
                this.SV.dataList[this.chooseBuffIndexList[1]].data.isChoose=false;
                this.chooseBuffIds[1]=itemOBJ.data.Id;
                this.chooseBuffIndexList[1]=itemOBJ.data.groupIndex;
                this.SV.dataList[this.chooseBuffIndexList[1]].data.isChoose=true;
                this.SV:Refresh();
            end
        end
    else
        local isReply=false;
        local replyIndex=0;
        for index, value in ipairs(this.chooseBuffIndexList) do
            if value==itemOBJ.data.groupIndex then
                isReply=true;
                replyIndex=index;
                break;
            end
        end
if isReply then
            table.remove(this.chooseBuffIds,replyIndex);
            table.remove(this.chooseBuffIndexList,replyIndex);
            this.SV.dataList[itemOBJ.data.groupIndex].data.isChoose=false;
            this.SV:Refresh();
            this.chooseBuffCount=this.chooseBuffCount-1;
else
            if this.chooseBuffCount<config.getBuffCount then
                table.insert(this.chooseBuffIds,itemOBJ.data.Id);
                table.insert(this.chooseBuffIndexList,itemOBJ.data.groupIndex);
                this.SV.dataList[itemOBJ.data.groupIndex].data.isChoose=true;
                this.SV:Refresh();
                this.chooseBuffCount=this.chooseBuffCount+1;
            end
        end
    end
    this.CheckButtonState(this.grade);
end

this.InitData = function()
    this.chooseBuffIds = {};
    this.chooseBuffCount=0;
    this.haveBuff = {};    
    this.chooseBuffIndexList={};
    firstConfirm = true;
    local data = DataMgr.Player.practices.buffIds;
    for key, value in pairs(data) do
        this.haveBuff[value] = true;
    end
end

this.InitPanel = function(grade)
    SetActive(btnBuffClick.gameObject, false);
    SetActive(btnDeBuffClick.gameObject, false);
    SetActive(goSpecialGroup, false);
    local config=CONFIG[grade];
if (config.state & (1<<1))==(1<<1) then
        SetActive(goBufTipsBG, true);
        SetActive(goDeBufTipsBG, false);
    else
        SetActive(goBufTipsBG, false);
        SetActive(goDeBufTipsBG, true);
    end
    this.InitTipsText(grade)
if (config.state & (1<<2))==(1<<2) then
        SetActive(btnBuffClick.gameObject, false);
        SetActive(goSpecialGroup, true);
        this.StartAnimation();
        firstConfirm = false;
    else
        this.ShowAnimationOnFirst();
    end
end

this.InitTipsText=function (grade)
    if grade==-1 then
        textTips.text = ConfigMgr.LangGlobal("7143")
    elseif grade == 1 then
        textTips.text = ConfigMgr.LangGlobal("7145")
    elseif grade == 2 then
        textTips.text = ConfigMgr.LangGlobal("7146")
    elseif grade == 3 then
        textTips.text = ConfigMgr.LangGlobal("7144")
    end
end

this.StartAnimation = function()
animator:Play("ani_CollectorPracticeChooseBuffPanel_root_01", 0, 0)
    for index, value in ipairs(this.SV.screenList) do
        value:ChooseBuffShowAnim();
    end
    specialTweener = DOTWeen.To(function() return 0 end,
        function(rot)
            rectBG2.localRotation = Quaternion.Euler(0, 0, -rot);
            rectBG3.localRotation = Quaternion.Euler(0, 0, rot);
        end, 360, 30)
    specialTweener:SetEase(Ease.Linear)
    specialTweener:SetLoops(-1)

end

this.CheckButtonState = function(grade)
    local config=CONFIG[grade];
if (config.state & (1<<1))==(1<<1) then
        SetActive(btnBuffClick.gameObject, this.chooseBuffCount == config.getBuffCount)
    else
        SetActive(btnDeBuffClick.gameObject, this.chooseBuffCount == config.getBuffCount)
    end
end

this.InitSV = function(grade)
    this.SV:Clear(false); 
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    local scrollDatas=this.GetScrollViewDataByGrade(grade);
    this.ShowSVResult(scrollDatas);
end

this.GetScrollViewDataByGrade=function (grade)
    local nowDungeonID = DataMgr.Player.stageTreasure.StageId;
    local config=CONFIG[grade];
    local scrollData=nil;
    local scrollDatas = {};
    local tempData=nil;
    local getBuffCount=config.getBuffCount;
    local showBuffCount=config.showBuffCount;
    local data=nil;
if (config.state & (1<<0))==(1<<0) then
        data=this.CheckDataError(CollectorPracticeAllMgr.currentMapId,-1,"Init");
elseif (config.state & (1<<1))==(1<<1) then
        data=this.CheckDataError(CollectorPracticeAllMgr.currentMapId,1,nowDungeonID);
else
        data=this.CheckDataError(CollectorPracticeAllMgr.currentMapId,2,nowDungeonID);
    end
if (config.state & (1<<2))==(1<<2) then
        local randList = Shuffle(#data);
        local nowGetBuffCount=0;
        for i = 1, #randList, 1 do
            tempData = table.Copy(data[randList[i]]);
if this.haveBuff[tempData.Id] == nil then
                tempData.fun = nil;
                tempData.groupIndex=i;
                tempData.isChoose = true;
                table.insert(this.chooseBuffIds,tempData.Id);
                this.chooseBuffCount=this.chooseBuffCount+1;
                scrollData = UIScrollData.GetData(UICollectorPracticeBuffItemPrefab, "UICollectorPracticeBuffItem", 272,
                    440, tempData);
                table.insert(scrollDatas, scrollData);
                nowGetBuffCount=nowGetBuffCount+1;
                if nowGetBuffCount>=getBuffCount then
                    break;
                end
            end
        end
    else
        local len = #data;
        local buffIdToWeight={};
        local buffIdToIndex={};
        for i = 1, len do
            tempData = data[i];
            if this.haveBuff[tempData.Id] ~= nil then
                goto continue;
            end
            buffIdToWeight[tempData.Id]=tempData.Weight;
            buffIdToIndex[tempData.Id]=i;
            ::continue::
        end
        local buffIds={};
        local buffId=nil;
        for i = 1, showBuffCount, 1 do
            buffId=RamdomOnWeight(buffIdToWeight);
            table.insert(buffIds,buffId);
            buffIdToWeight[buffId] = nil
        end
        for i = 1, showBuffCount,1 do
            local index=buffIdToIndex[buffIds[i]];
            tempData = table.Copy(data[index]);
            tempData.groupIndex=i;
            tempData.fun = this.ClickItem;
            tempData.isChoose = false;
            scrollData = UIScrollData.GetData(UICollectorPracticeBuffItemPrefab, "UICollectorPracticeBuffItem", 272,
                440, tempData);
            table.insert(scrollDatas, scrollData);
        end
    end
    return scrollDatas;
end

this.CheckDataError=function (param1,param2,param3)
    if CollectorPracticeMgr.gradeToBuffData[param1]==nil or 
    CollectorPracticeMgr.gradeToBuffData[param1][param2] ==nil or
    CollectorPracticeMgr.gradeToBuffData[param1][param2][param3] ==nil
    then
        if param2==-1 then
            return CollectorPracticeMgr.gradeToBuffData["A000"][1]["Error"];
        else
            return CollectorPracticeMgr.gradeToBuffData["A000"][param2]["Error"];
        end

    else
        return CollectorPracticeMgr.gradeToBuffData[param1][param2][param3];
    end
end

this.ShowResult = function()
    textTips.text = ConfigMgr.LangGlobal("7146")
    SetActive(btnBuffClick.gameObject, true);
    SetActive(goSpecialGroup, true);
    this.StartAnimation();
end

this.ShowSVResult = function(scrollDatas)
    local needWidth = 272 * (#scrollDatas);
    this.SV:SetParams(needWidth < this.scrollWidth and needWidth or this.scrollWidth, 440);
if needWidth >= this.scrollWidth then
        ScrollView.movementType = CS.UnityEngine.UI.ScrollRect.MovementType.Elastic;
    else
        ScrollView.movementType = CS.UnityEngine.UI.ScrollRect.MovementType.Clamped;
    end
    this.SV:SetData(scrollDatas);
    this.SV:MoveToIndex(math.ceil(#scrollDatas / 2), true);
    this.SV:Refresh()
end

this.ShowAnimationOnFirst = function()
animator:Play("ani_CollectorPracticeChooseBuffPanel_root_02", 0, 0)
    for index, value in ipairs(this.SV.screenList) do
        value:ChooseBuffShowAnim();
    end
end

local hook = {
    before_awake = function(vm)
        this.Init(vm.behaviour.gameObject)
        this.SV = UIScrollView.New(ScrollView.gameObject);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        local grade = tonumber(vm.behaviour.Params[0]);
        this.grade = grade;
        this.callBack = vm.behaviour.Params[1];
        this.InitData();
        this.InitSV(grade);
        this.InitPanel(grade);
        this.InitDebugButton();
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params ~= nil then
            this.SV:Clear(true);
            if (specialTweener ~= nil) then
                specialTweener:Kill()
                specialTweener = nil;
            end
        end
    end,
    before_destroy = function(vm)
        this.Clear();
        UIScrollView.ClearItem("UICollectorPracticeBuffItem");
    end,
}

return vm({
    hook = hook
})
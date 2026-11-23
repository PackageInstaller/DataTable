local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local goSlotPos1 = nil;
local goSlotPos2 = nil;
local goSlotPos3 = nil;
local goSlotPos4 = nil;
local goSlotPos5 = nil;
local goSlotPos6 = nil;
local goSlotPos7 = nil;
local goSlotPos8 = nil;
local goSlotPos9 = nil;
local goSelect1 = nil;
local goSelect2 = nil;
local goSelect3 = nil;
local goSelect4 = nil;
local goSelect5 = nil;
local goSelect6 = nil;
local Right = nil;
local btnConfirm = nil;
local btnClose = nil;
local goCloseMask = nil;
local goFailImage = nil;
local imgDissolve = nil;
local this = {
    vm = nil,
}
require("ViewModel/MiniGames/MiniGameSportsExperrtsSlot")
local nowSelectVector = {};
local allSlotVector = {};
local notYetReturn = false;
local prefabMiniGameSportsExperrtsSlot = nil;
local firstChoose = true;
local imgMaterial = nil;
local dissolveController = nil;
local nullMaterial=nil;
local data = {
}
local command = {
}
local ParamThemeId;
local ParamEventType;
local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            prefabMiniGameSportsExperrtsSlot = vm.behaviour.transform:Find("template/SportExpertsSlot").gameObject;
            ParamThemeId = vm.behaviour.Params[0]
            ParamEventType = vm.behaviour.Params[1]
            this.Init(vm.behaviour);
            imgMaterial = imgDissolve.material;
            dissolveController = imgDissolve.gameObject:GetComponent("UIDissolveController");
            this.InitSlot();
        end
    end,
    after_awake = function()
    end,
    after_active = function()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
LuaMgr.InvokeUIEventListeners(UIEventConst.CollectorEventPanelClose);
            this.Clear();
        end
    end
}

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    goSlotPos1 = uiLink:Get("goSlotPos1");
    goSlotPos2 = uiLink:Get("goSlotPos2");
    goSlotPos3 = uiLink:Get("goSlotPos3");
    goSlotPos4 = uiLink:Get("goSlotPos4");
    goSlotPos5 = uiLink:Get("goSlotPos5");
    goSlotPos6 = uiLink:Get("goSlotPos6");
    goSlotPos7 = uiLink:Get("goSlotPos7");
    goSlotPos8 = uiLink:Get("goSlotPos8");
    goSlotPos9 = uiLink:Get("goSlotPos9");
    goSelect1 = uiLink:Get("goSelect1");
    goSelect2 = uiLink:Get("goSelect2");
    goSelect3 = uiLink:Get("goSelect3");
    goSelect4 = uiLink:Get("goSelect4");
    goSelect5 = uiLink:Get("goSelect5");
    goSelect6 = uiLink:Get("goSelect6");
    Right = uiLink:Get("Right");
    btnConfirm = uiLink:Get("btnConfirm"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    goCloseMask = uiLink:Get("goCloseMask");
    goFailImage = uiLink:Get("goFailImage");
    imgDissolve = uiLink:Get("imgDissolve"):GetComponent("Image");
    uiLink:AddClickEvent("btnConfirm", function()
        this.Confirm();
    end)
    uiLink:AddClickEvent("btnClose", function()
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7103"].NameLan)
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, tipStr, function()
            local data = {
                ThemeId = ParamThemeId,
                EventType = ParamEventType,
                Win = false,
            }
            ApiMgr.Request("scratch/choose", data, true, function()
                LuaMgr.HidePanel(UIName.MiniGameSportsExpertsViewModel)
            end, nil, true)
        end, nil)
    end)
    uiLink:AddClickEvent("goCloseMask", function()
        LuaMgr.HidePanel(UIName.MiniGameSportsExpertsViewModel)
    end)
end

this.InitSlot = function()
local constSlotPosVector = {
        goSlotPos1,
        goSlotPos2,
        goSlotPos3,
        goSlotPos4,
        goSlotPos5,
        goSlotPos6,
        goSlotPos7,
        goSlotPos8,
        goSlotPos9,
    };
    for i = 1, #DataMgr.Player.scratch.ChessBoard do
        local temp = MiniGameSportsExperrtsSlot.New(prefabMiniGameSportsExperrtsSlot,
            constSlotPosVector[i]:GetComponent("RectTransform"), this.ClickSlot);
        table.insert(allSlotVector, temp);
        allSlotVector[i]:SetData(DataMgr.Player.scratch.ChessBoard[i], i - 1);
    end
    nullMaterial=allSlotVector[1].goCoverImage:GetComponent("Image").material;
if not IsNull(DataMgr.Player.scratch.Choose) and (not TableIsNull(DataMgr.Player.scratch.Choose)) then
        local choose=DataMgr.Player.scratch.Choose;
        for key, value in pairs(choose) do
            for _, chooseNum in pairs(value) do
                SetActive(allSlotVector[chooseNum+1].goCoverImage, false);
            end
        end
        firstChoose=false
        SetActive(goSelect1,true)
        SetActive(goSelect2,true)
        SetActive(goSelect3,true)
    end
end

this.Clear = function()
    SetActive(goSelect1, false);
    SetActive(goSelect2, false);
    SetActive(goSelect3, false);
    SetActive(goSelect4, false);
    SetActive(goSelect5, false);
    SetActive(goSelect6, false);
    SetActive(goCloseMask, false)
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    goSlotPos1 = nil;
    goSlotPos2 = nil;
    goSlotPos3 = nil;
    goSlotPos4 = nil;
    goSlotPos5 = nil;
    goSlotPos6 = nil;
    goSlotPos7 = nil;
    goSlotPos8 = nil;
    goSlotPos9 = nil;
    goSelect1 = nil;
    goSelect2 = nil;
    goSelect3 = nil;
    goSelect4 = nil;
    goSelect5 = nil;
    goSelect6 = nil;
    imgDissolve = nil;
imgMaterial = nil;
dissolveController = nil;
    Right = nil;
    btnConfirm = nil;
    btnClose = nil;
    goCloseMask = nil;
    goFailImage = nil;
    for i = 1, #allSlotVector, 1 do
        allSlotVector[i]:Destroy();
    end
nowSelectVector = {};
allSlotVector = {};
notYetReturn = false;
    prefabMiniGameSportsExperrtsSlot = nil;
    firstChoose = true;
end

this.ClickSlot = function(self)
    if self.goCoverImage.activeSelf == false then
        return;
    end
if self.isSelect then
        self:Select(false);
        for i = 1, #nowSelectVector, 1 do
            if nowSelectVector[i].slotIndex == self.slotIndex then
                table.remove(nowSelectVector, i);
                break;
            end
        end
    else
if #nowSelectVector >= 3 then
            return;
        end
        self:Select(true);
        table.insert(nowSelectVector, self);
    end
    this.ShowSelectIcon();
end

this.ShowSelectIcon = function()
    if firstChoose then
        SetActive(goSelect1, #nowSelectVector >= 1 and true or false)
        SetActive(goSelect2, #nowSelectVector >= 2 and true or false)
        SetActive(goSelect3, #nowSelectVector >= 3 and true or false)
    else
        SetActive(goSelect4, #nowSelectVector >= 1 and true or false)
        SetActive(goSelect5, #nowSelectVector >= 2 and true or false)
        SetActive(goSelect6, #nowSelectVector >= 3 and true or false)
    end
end

this.SetFinsihMask = function(victory)
    SetActive(goCloseMask, true);
    if victory then
        SetActive(goFailImage, false);
    else
        SetActive(goFailImage, true);
    end
end

this.Confirm = function()
    if #nowSelectVector ~= 3 then
        return;
    end
    if notYetReturn then
        return;
    end
    if firstChoose then
        firstChoose = false;
    end
    notYetReturn = true;

    local animationSelectVector=table.Copy(nowSelectVector)
    for i = 1, #animationSelectVector, 1 do
        animationSelectVector[i]:Open();
        animationSelectVector[i].goCoverImage:GetComponent("Image").material=imgMaterial;
    end
    DOTWeen.To(function() return 0.15  end,function(vetor)
        dissolveController.dissolveStep=vetor
    end,0.85,1).onComplete=function()
        for i = 1, #animationSelectVector, 1 do
            animationSelectVector[i]:SetCoverImage(false);
            animationSelectVector[i].goCoverImage:GetComponent("Image").material=nil;
        end
        dissolveController.dissolveStep=0.15
    end;

    local tempSelect = {};
    for i = 1, 3, 1 do
        table.insert(tempSelect, nowSelectVector[i].slotIndex);
    end
    nowSelectVector = {};
    local data = {
        ThemeId = ParamThemeId,
        EventType = ParamEventType,
        Choose = tempSelect,
        Win = true,
    }
    ApiMgr.Request("scratch/choose", data, true, function(result)
        local re = json.decode(result);
        if re.code == 0 then
            notYetReturn = false;
if re.result.Items ~= nil and type(re.result.Items) == "table" then
                for index, value in pairs(re.result.Items) do
                    local item = ConfigMgr.Config.itemMap[value.id];
                    if item ~= nil and (item.type == 20 or item.type == 25 or item.type == 26) then

                        table.insert(CollectorPracticeMgr.RewardTab, value);
                    end
                end
            end
            if #CollectorPracticeMgr.RewardTab > 0 and not DataMgr.Player.scratch.IsFinished then
                LuaMgr.ShowLuaPanel(UIName.CollectorPracticeChipItemsPanel, function()
                end)
            end
if DataMgr.Player.scratch.IsFinished then
if not IsNull(re.result.Items) then
local co = coroutine_runner.start(function()
                            coroutine_runner.wait(1)
                            LuaMgr.HidePanel(UIName.MiniGameSportsExpertsViewModel)
                    end)
                    
                else
local co = coroutine_runner.start(function()
                        coroutine_runner.wait(1)
                        this.SetFinsihMask(false)
                    end)
                    
                end
            end
        end
    end, nil, true)
end
return vm({
    data = data,
    command = command,
    hook = hook
})
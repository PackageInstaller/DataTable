local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local goTurnTableTitle = nil;
local Middle = nil;
local goDecorationSlot = nil;
local goPointParent = nil;
local goPointSuccssfulList = nil;
local goPointBottomList = nil;
local goPointUpperList = nil;
local Right = nil;
local btnCheckToAntiClockWish = nil;
local goCheckToAntiClockWish = nil;
local btnCheckToClockWish = nil;
local goCheckToClockWish = nil;
local btnBack = nil;
local goFinishPanel = nil;
local goBtnFinishPanel = nil;
local btnBackAnimatior = nil;
local animatorCheckStateBtnGroup = nil;
local slotDissolveStepController = nil;
local textStep=nil;
local goControllerBottom = nil;
local goControllerUpper = nil;
local goLeftStepImg=nil;
local canReduceStep=false;
local uiRangeEffect=nil;
local UITurnTableflower=nil;
local goDebugButtonList=nil;
local btnDebugWin=nil;
local this = {
    vm = nil,
}
require("ViewModel/TeaTast/TurnTableGameBottomItem")
require("ViewModel/TeaTast/TurnTableGameUpperItem")
require("ViewModel/TeaTast/TurnTableGameResultItem")
local limitClicks = false;
local boardId = nil;
local limitCheckToWish = false;
local isClockWise = true;
local leftStep=0;
local stepLimit=true;
local startTime=0;
local finishCo=nil;
local pointMoveMap = {

    ["+0_+0"] = true,
    ["+1_+0"] = true,
    ["+1_-1"] = true,
    ["+0_-1"] = true,
    ["-1_+0"] = true,
    ["-1_+1"] = true,
    ["+0_+1"] = true,
    ["+2_+0"] = true,
    ["+2_-1"] = true,
    ["+2_-2"] = true,
    ["+1_-2"] = true,
    ["+0_-2"] = true,
    ["-1_-1"] = true,
    ["-2_+0"] = true,
    ["-2_+1"] = true,
    ["-2_+2"] = true,
    ["-1_+2"] = true,
    ["+0_+2"] = true,
    ["+1_+1"] = true,
    ["+3_+0"] = false,
    ["+3_-1"] = false,
    ["+3_-2"] = false,
    ["+3_-3"] = false,
    ["+2_-3"] = false,
    ["+1_-3"] = false,
    ["+0_-3"] = false,
    ["-1_-2"] = false,
    ["-2_-1"] = false,
    ["-3_+0"] = false,
    ["-3_+1"] = false,
    ["-3_+2"] = false,
    ["-3_+3"] = false,
    ["-2_+3"] = false,
    ["-1_+3"] = false,
    ["+0_+3"] = false,
    ["+1_+2"] = false,
    ["+2_+1"] = false,
}
local step1 = {
    "+0_+0",
}
local step2 = {
    "+1_+0",
    "+1_-1",
    "+0_-1",
    "-1_+0",
    "-1_+1",
    "+0_+1",
}
local step3 = {
    "+2_+0",
    "+2_-1",
    "+2_-2",
    "+1_-2",
    "+0_-2",
    "-1_-1",
    "-2_+0",
    "-2_+1",
    "-2_+2",
    "-1_+2",
    "+0_+2",
    "+1_+1",
}
local standLocalPositionMap = {

}
local resultNum = 0;
local bottomPointMap = {}
local resultPointMap = {}
local upperPointMap = {}
local startPlayerList = {}
local resultTitleMap = {}
local openResultEffect=true;
local startAnimationCo=nil;
local data = {
}
local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            boardId = vm.behaviour.Params[0]
            this.Init(vm.behaviour.gameObject);
            SetActive(goDebugButtonList, LuaMgr.IsDebug());
            this.InitStandLocalPosition();
            this.InitBottomPoint();
            this.InitResultPlayerObstacle();
            this.CheckFinish();
            isClockWise = true;
SetActive(goCheckToAntiClockWish, true);
            SetActive(goCheckToClockWish, false);
            uiRangeEffect.rawImage.color=UnityEngine.Color(255/255.0,255/255.0,255/255.0,0);
            textStep.text="";
            leftStep=tonumber(ConfigMgr.Config.GameBoardMap[boardId].MoveTimes);
            if leftStep<0 then
                stepLimit=false;
                SetActive(goLeftStepImg,false);
            else
                stepLimit=true;
                SetActive(goLeftStepImg,true);
            end

animatorCheckStateBtnGroup:Play("UI_TurnTablePanel_btnCheckToAntiClockWish", 0, 1);
            slotDissolveStepController.DissolveStep = 0
            LuaMgr.AddUIEventListener(UIEventConst.TopBarHelp,function ()
                this.CloseResultEffect();
            end
            )
startAnimationCo = coroutine_runner.start(function()
                limitClicks = true
                limitCheckToWish = true;
                coroutine_runner.wait(0.3)
                this.AppearBottom();
                coroutine_runner.wait(0.2);
                this.AppearUpper();
                coroutine_runner.wait(0.2);
                this.AppearAllResult();
                coroutine_runner.wait(0.2);
                this.ShowLeftStep(true);
                limitClicks = false
                limitCheckToWish = false;
                startAnimationCo=nil;
            end)
            startTime=LuaMgr.Timestamp();
            this.vm.behaviour:UpdateTopBar("", function ()
                this.BiliLog(0,nil);
                LuaMgr.Back();
            end)
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            SetActive(goFinishPanel, false);
            SetActive(goDecorationSlot, true);
            SetActive(goPointParent, true);
            SetActive(goPointSuccssfulList, true);
            SetActive(goPointBottomList, true);
            SetActive(goPointUpperList, true);
            if  startAnimationCo ~= nil then
                coroutine_runner.stop(startAnimationCo)
            end
            if finishCo~=nil then
                coroutine_runner.stop(finishCo)
                finishCo=nil;
            end
            this.Clear();
        end
    end
}

this.AppearBottom = function()
    for key, value in pairs(bottomPointMap) do
        value:Appear();
    end
end
this.AppearUpper = function()
    for key, value in pairs(upperPointMap) do
        value:Appear();
    end
end
this.AppearAllResult = function()
    for key, value in pairs(resultPointMap) do
        value:Appear(openResultEffect);
    end
end

this.CloseResultEffect=function (args)
    openResultEffect=false;




end

this.DisAppearAll = function()
    goControllerBottom.enabled = true;
    goControllerUpper.enabled = true;
    DOTWeen.To(function() return goControllerBottom.DissolveStep end,
        function(val) goControllerBottom.DissolveStep = val end,
        1, 1)
    DOTWeen.To(function() return goControllerUpper.DissolveStep end,
        function(val) goControllerUpper.DissolveStep = val end,
        1, 1)
end


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    goTurnTableTitle = uiLink:Get("goTurnTableTitle");
    Middle = uiLink:Get("Middle");
    goDecorationSlot = uiLink:Get("goDecorationSlot");
    goPointParent = uiLink:Get("goPointParent");
    goPointSuccssfulList = uiLink:Get("goPointSuccssfulList");
    goPointBottomList = uiLink:Get("goPointBottomList");
    goPointUpperList = uiLink:Get("goPointUpperList");
    Right = uiLink:Get("Right");
    btnCheckToAntiClockWish = uiLink:Get("btnCheckToAntiClockWish"):GetComponent("Button");
    goCheckToAntiClockWish = uiLink:Get("btnCheckToAntiClockWish")
    btnCheckToClockWish = uiLink:Get("btnCheckToClockWish"):GetComponent("Button");
    goCheckToClockWish = uiLink:Get("btnCheckToClockWish")
    btnBack = uiLink:Get("btnBack"):GetComponent("Button");
    btnBackAnimatior = uiLink:Get("btnBack"):GetComponent("Animator");
    animatorCheckStateBtnGroup = uiLink:Get("animatorCheckStateBtnGroup"):GetComponent("Animator");
    goFinishPanel = uiLink:Get("goFinishPanel");
    goBtnFinishPanel = uiLink:Get("goFinishPanel"):GetComponent("Button");
    slotDissolveStepController = uiLink:Get("goDecorationSlot"):GetComponent(typeof(CS.Laigu.Art.UIDissolveController));
    goControllerBottom = uiLink:Get("goControllerBottom"):GetComponent(typeof(CS.Laigu.Art.UIDissolveController));
    goControllerUpper = uiLink:Get("goControllerUpper"):GetComponent(typeof(CS.Laigu.Art.UIDissolveController));
    textStep=uiLink:Get("textStep"):GetComponent("Text");
    goLeftStepImg=uiLink:Get("goLeftStepImg");
    goControllerBottom.enabled = false;
    goControllerUpper.enabled = false;
    uiRangeEffect=uiLink:Get("UIRangeEffect"):GetComponent(typeof(CS.Laigu.Tools.UITools.UIRangeEffect));
    UITurnTableflower=uiLink:Get("UITurnTableflower")
    goDebugButtonList=uiLink:Get("goDebugButtonList")
    btnDebugWin= uiLink:Get("btnDebugWin"):GetComponent("Button");
    uiLink:AddClickEvent("btnCheckToAntiClockWish", this.CheckToAntiClockWish);
    uiLink:AddClickEvent("btnCheckToClockWish", this.CheckToClockWish);
    uiLink:AddClickEvent("goFinishPanel", this.Close);
    uiLink:AddClickEvent("btnBack", this.BackToStart);
    uiLink:AddClickEvent("btnDebugWin", this.DebugWin);
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    goTurnTableTitle = nil;
    Middle = nil;
    goDecorationSlot = nil;
    goPointParent = nil;
    goPointSuccssfulList = nil;
    goPointBottomList = nil;
    goPointUpperList = nil;
    Right = nil;
    btnCheckToAntiClockWish = nil;
    btnCheckToClockWish = nil;
    goCheckToAntiClockWish = nil;
    goCheckToClockWish = nil;
    btnBack = nil;
    goFinishPanel = nil;
    goBtnFinishPanel = nil;
    btnBackAnimatior = nil;
    animatorCheckStateBtnGroup = nil;
    standLocalPositionMap = {}
    textStep=nil;
    goLeftStepImg=nil;
    resultNum = 0;
    openResultEffect=true
    uiRangeEffect=nil;
    goDebugButtonList=nil;
    btnDebugWin=nil;
    finishCo=nil;
    for key, value in pairs(bottomPointMap) do
        value:Destroy();
    end
bottomPointMap = {}
    for key, value in pairs(resultPointMap) do
        value:Destroy();
    end
resultPointMap = {}
    for key, value in pairs(upperPointMap) do
        value:Destroy();
    end
upperPointMap = {}
startPlayerList = {}
    for key, value in pairs(resultTitleMap) do
        LuaMgr.DestroyImmediateGO(value);
    end
resultTitleMap = {}
    LuaMgr.RemoveTimer(TimerConst.DelayClose);
    LuaMgr.RemoveUIEventListener(UIEventConst.TopBarHelp,this.CloseResultEffect)
end

this.Close = function()
    LuaMgr.HidePanel(UIName.TurnTableViewModel)
    LuaMgr.ShowLuaPanel(UIName.TurnTableMainPageViewModel);
end

this.DebugWin=function ()
    if LuaMgr.IsDebug() then
        this.Victory();
    end
end

this.ShowLeftStep=function (setColor)
    if textStep == nil then
        return
    end
    if setColor then
        textStep.color=UnityEngine.Color(209/255.0,183/255.0,120/255.0,1)
    end
    if leftStep<=5 then
        textStep.color=UnityEngine.Color(159/255.0,61/255.0,7/255.0,1)
    end
    textStep.text=tostring(leftStep);
end

this.CheckToAntiClockWish = function()
    if limitCheckToWish then
        return;
    end
    limitCheckToWish = true;
    limitClicks = true;
    isClockWise = false;
    SetActive(goCheckToAntiClockWish, true);
    SetActive(goCheckToClockWish, true);
    animatorCheckStateBtnGroup:Play("UI_TurnTablePanel_btnCheckToClockWish", 0, 0)
    LuaMgr.AddTimer(TimerConst.DelayClose, function()
        limitCheckToWish = false;
        limitClicks = false;
        SetActive(goCheckToAntiClockWish, false);
        SetActive(goCheckToClockWish, true);
        LuaMgr.RemoveTimer(TimerConst.DelayClose);
    end, 1.15, 1, false)
end

this.CheckToClockWish = function()
    if limitCheckToWish then
        return;
    end
    limitCheckToWish = true;
    limitClicks = true;
    isClockWise = true;
    SetActive(goCheckToAntiClockWish, true);
    SetActive(goCheckToClockWish, true);
    animatorCheckStateBtnGroup:Play("UI_TurnTablePanel_btnCheckToAntiClockWish", 0, 0)
    LuaMgr.AddTimer(TimerConst.DelayClose, function()
        limitCheckToWish = false;
        limitClicks = false;
        SetActive(goCheckToAntiClockWish, true);
        SetActive(goCheckToClockWish, false);
        LuaMgr.RemoveTimer(TimerConst.DelayClose);
    end, 1.15, 1, false)
end

this.PostionToString = function(posX, posY)
    local firstString = tostring(posX);
    if posX >= 0 then
        firstString = "+" .. firstString;
    end
    local secondString = tostring(posY);
    if posY >= 0 then
        secondString = "+" .. secondString;
    end
    return firstString .. "_" .. secondString
end

this.StringToPostion = function(s)
    local list = Split(s, "_");
    local posPair = {
        posX = tonumber(list[1]),
        posY = tonumber(list[2]),
    }
    return posPair;
end

this.GetAdjacentStringPos = function(posX, posY)
    local offset = {
        { 1,  0 },
        { 1,  -1 },
        { 0,  -1 },
        { -1, 0 },
        { -1, 1 },
        { 0,  1 },
    }
    local result = {}
    for i = 1, 6, 1 do
        local s = this.PostionToString(posX + offset[i][1], posY + offset[i][2]);
        table.insert(result, s);
    end
    return result;
end

this.GetBottomPointCanMove = function(AdjacentStringPos)
    local canMoveVal = 0;
    for i = 1, 6, 1 do
        if pointMoveMap[AdjacentStringPos[i]] ~= nil and pointMoveMap[AdjacentStringPos[i]] then
            canMoveVal = canMoveVal + 1;
        end
    end
    return canMoveVal == 6;
end

this.GetBottomRotateAdjacentTargetPos = function(AdjacentStringPos)
    local targetIndex = nil;
    local targetPos = {};
if isClockWise then
        targetIndex = { 2, 3, 4, 5, 6, 1 };
else
        targetIndex = { 6, 1, 2, 3, 4, 5 };
    end
    for i = 1, 6, 1 do
        local targetPosPair = {
            startTarget = AdjacentStringPos[i],
            targetPositionString = AdjacentStringPos[targetIndex[i]],
        }
        table.insert(targetPos, targetPosPair);
    end
    return targetPos;
end

this.GetUpperRotateAdjacentTargetPos = function(AdjacentStringPos)
    local targetIndex = nil;
    local targetPos = {};
if isClockWise then
targetIndex = { 2, 3, 4, 5, 6, 1 };
else
        targetIndex = { 6, 1, 2, 3, 4, 5 };
    end
    for i = 1, 6, 1 do
if upperPointMap[AdjacentStringPos[i]] ~= nil and upperPointMap[AdjacentStringPos[i]].isPlayer then
            local targetPosPair = {
                startTarget = AdjacentStringPos[i],
                targetPositionString = AdjacentStringPos[targetIndex[i]],
                canMove = true,
            }
targetPos[i] = targetPosPair;
        end
    end
    for i = 1, 6, 1 do
if upperPointMap[AdjacentStringPos[i]] ~= nil and upperPointMap[AdjacentStringPos[i]].isPlayer then
if upperPointMap[AdjacentStringPos[targetIndex[i]]] ~= nil and upperPointMap[AdjacentStringPos[targetIndex[i]]].isObstacle then
targetPos[i].canMove = false;
                local indexList = {};




                if isClockWise then
                    for j = i - 1, 1, -1 do
                        table.insert(indexList, targetIndex[j]);
                    end
                    for j = 6, i, -1 do
                        table.insert(indexList, targetIndex[j]);
                    end
                else
                    for j = i + 1, 6, 1 do
                        table.insert(indexList, targetIndex[j]);
                    end
                    for j = 1, i, 1 do
                        table.insert(indexList, targetIndex[j]);
                    end
                end

                for j = 1, 6, 1 do
if upperPointMap[AdjacentStringPos[indexList[j]]] ~= nil and upperPointMap[AdjacentStringPos[indexList[j]]].isPlayer then
targetPos[indexList[j]].canMove = false;
                    else
                        break;
                    end
                end
            end
        end
    end
    return targetPos;
end

this.MoveFinish = function(transform, targetPos)
    DOTWeen.To(function() return transform.localPosition end,
        function(vect) transform.localPosition = vect end,
        targetPos, 0.5)
end

this.MoveNotFinish = function(transform, targetPos)
    local temp = (targetPos - transform.localPosition) / 2;
    DOTWeen.To(function() return transform.localPosition end,
        function(vect) transform.localPosition = vect end,
        transform.localPosition + ((targetPos - transform.localPosition) / 2), 0.25):SetLoops(2, LoopType.Yoyo):SetEase(
        Ease.OutQuad)

end

this.CheckFinish = function()
    for key, value in pairs(upperPointMap) do
if value.isPlayer then
if resultPointMap[key] ~= nil then
value:SetFinish(true);
            else
                value:SetFinish(false);
            end
        end
    end
end

this.AnimationFinish = function()
    limitClicks = false;
    if canReduceStep then
        leftStep=leftStep-1;
    end
    this.ShowLeftStep(false);
    this.CheckFinish();
    if this.CheckVictory() then
        limitClicks=true;
        this.Victory();
elseif stepLimit and leftStep<=0 then
        this.BiliLog(0,nil);
        LuaMgr.AddTimer(TimerConst.FeatureUnlockNext,function ()
            LuaMgr.ShowConfirmSmallViewModel(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7064"),function ()
                this.BackToStart();
            end,function ()
                LuaMgr.HidePanel(UIName.TurnTableViewModel)
                LuaMgr.ShowLuaPanel(UIName.TurnTableMainPageViewModel);
            end);
            LuaMgr.RemoveTimer(TimerConst.FeatureUnlockNext);
        end,0.5,1,false)
    end
    LuaMgr.RemoveTimer(TimerConst.DelayClose);
end

this.ClickBottomFun = function(clickPoint)
    if limitClicks then
        return;
    end
    canReduceStep=false;
    if stepLimit and leftStep<=0 then
        LuaMgr.ShowConfirmSmallViewModel(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7064"),function ()
            this.BackToStart();
        end,function ()
            LuaMgr.HidePanel(UIName.TurnTableViewModel)
            LuaMgr.ShowLuaPanel(UIName.TurnTableMainPageViewModel);
        end);
        return;
    end
    clickPoint:PlayEffect();
    limitClicks = true;
    local AdjacentStringPos = this.GetAdjacentStringPos(clickPoint.x, clickPoint.y)
    local bottomTargetPos = this.GetBottomRotateAdjacentTargetPos(AdjacentStringPos);
if this.GetBottomPointCanMove(AdjacentStringPos) then
        local upperTargetPos = this.GetUpperRotateAdjacentTargetPos(AdjacentStringPos);

        local tempBotomMap = {};
for index, value in ipairs(bottomTargetPos) do
            this.MoveFinish(bottomPointMap[value.startTarget].transform,
standLocalPositionMap[value.targetPositionString]);

tempBotomMap[value.targetPositionString] = bottomPointMap[value.startTarget];
            local posPair = this.StringToPostion(value.targetPositionString);
            bottomPointMap[value.startTarget].x = posPair.posX;
            bottomPointMap[value.startTarget].y = posPair.posY;
            bottomPointMap[value.startTarget] = nil;
        end
for key, value in pairs(tempBotomMap) do
            bottomPointMap[key] = value;
        end

        local tempUpperMap = {};
        for key, value in pairs(upperTargetPos) do
if value.canMove then
canReduceStep=true;
                this.MoveFinish(upperPointMap[value.startTarget].transform,
standLocalPositionMap[value.targetPositionString]);

tempUpperMap[value.targetPositionString] = upperPointMap[value.startTarget];
                local posPair = this.StringToPostion(value.targetPositionString);
                upperPointMap[value.startTarget].x = posPair.posX;
                upperPointMap[value.startTarget].y = posPair.posY;
                upperPointMap[value.startTarget] = nil;
            else
                this.MoveNotFinish(upperPointMap[value.startTarget].transform,
standLocalPositionMap[value.targetPositionString]);
            end
        end
for key, value in pairs(tempUpperMap) do
            upperPointMap[key] = value;
        end
    else
        for index, value in ipairs(bottomTargetPos) do
if pointMoveMap[value.startTarget] ~= nil and pointMoveMap[value.startTarget] then
                this.MoveNotFinish(bottomPointMap[value.startTarget].transform,
                    standLocalPositionMap[value.targetPositionString]);
            end
            if upperPointMap[value.startTarget] ~= nil and upperPointMap[value.startTarget].isPlayer then
                this.MoveNotFinish(upperPointMap[value.startTarget].transform,
                    standLocalPositionMap[value.targetPositionString]);
            end
        end
    end
    LuaMgr.AddTimer(TimerConst.DelayClose, this.AnimationFinish, 0.5, 1, false)
end

this.Victory = function()
    local netData = { BoardId = boardId }
    local Url = "board/finished"
    ApiMgr.Request(Url, netData, true,
        function(result)
            local re = json.decode(result)
            if re.code == 0 then
                this.BiliLog(1,re.result.Items);
finishCo = coroutine_runner.start(function()
                    limitClicks = true
                    limitCheckToWish = true;
                    SetActive(UITurnTableflower,false);
                    for key, value in pairs(bottomPointMap) do
                        value:ForeverStopEffect();
                    end
                    coroutine_runner.wait(0.2);
                    if uiRangeEffect~=nil then
                        uiRangeEffect:RunRangeEffect(function ()
                            SetActive(goDecorationSlot, false);
                            SetActive(goPointParent, false);
                            SetActive(goPointSuccssfulList, false);
                            SetActive(goPointBottomList, false);
                            SetActive(goPointUpperList, false);
                            uiRangeEffect.rawImage.color=UnityEngine.Color(255/255.0,255/255.0,255/255.0,1);
                            goControllerBottom.enabled = true;
                            local tween=DOTWeen.To(function() return goControllerBottom.DissolveStep end,
                                    function(val) goControllerBottom.DissolveStep = val end,
                                    1, 1.2):SetEase(Ease.OutCubic)
                        end,1,nil,nil);
                    end
                    coroutine_runner.wait(1.5);
                    if UITurnTableflower~=nil and goFinishPanel~=nil  then
                        SetActive(UITurnTableflower,true);
                        SetActive(goFinishPanel, true);
                    end
                    limitClicks = false
                    limitCheckToWish = false;
                    coroutine_runner.wait(0.4);
                    if not IsNull(re.result.Items) then
                        local items = {};
                        local reward = re.result.Items
                        for i, v in pairs(reward) do
                            local item = { ID = v.id, Count = v.count }
                            table.insert(items, item);
                        end

                        LuaMgr.ShowItemGetPanel(items);
                        finishCo=nil;
                    end
                end)
            end
        end,
        function(failCode)
            print("EnterDungeonError,ErrorCode:", failCode)
        end,
        false
    )
end

this.BiliLog=function (winType,Items)

    local firstItem = nil;
    if Items ~= nil and (not IsNull(Items)) then
        for i, v in pairs(Items) do
            firstItem = { ID = v.id, Count = v.count }
        end
    end
    local askData = {}
    local cp_param = {};
    askData["game_uid"] = (tostring(DataMgr.Player.uid) .. "|" .. tostring( startTime) .. "|" .. "foundation_tearoom_maze_end")
    askData["game_result"] = winType;
    askData["stage_type"] = tostring(ConfigMgr.Config.GameBoardMap[boardId].LevelType)
    askData["stage_id"] = tostring(boardId)
    askData["item_id"] = firstItem == nil and "" or firstItem.ID
    askData["item_num"] = firstItem == nil and "" or firstItem.Count
    askData["complete_time"] = tostring(LuaMgr.Timestamp() -  startTime);
    askData["cp_param"] = json.encode(cp_param)
    DataReportMgr.RequestBiliData("foundation_tearoom_maze_end", askData, nil, nil);
    startTime = LuaMgr.Timestamp();
end

this.InitStandLocalPosition = function()
    local transform = goPointParent:GetComponent("RectTransform");
    for key, value in pairs(pointMoveMap) do
        local obj = transform:Find(key);
        if obj ~= nil then
            standLocalPositionMap[key] = obj.localPosition;
        end
    end
end

this.InitBottomPoint = function()
    for key, value in pairs(pointMoveMap) do
        if value == true then
            local posPair = this.StringToPostion(key);
            local item = TurnTableGameBottomItem.New(goPointBottomList:GetComponent("RectTransform"));
            item:SetData(this.ClickBottomFun, posPair.posX, posPair.posY);
            item.transform.localPosition = standLocalPositionMap[key];
            bottomPointMap[key] = item;
        end
    end
end

this.InitResultPlayerObstacle = function()
    local configData = ConfigMgr.Config.GameBoardMap[boardId]
    for index, value in ipairs(configData.BoardBegin) do
if value[2] == "1" then
local item = TurnTableGameUpperItem.New(goPointUpperList:GetComponent("RectTransform"));
            local positionPair = this.StringToPostion(value[1]);
item:SetData(positionPair.posX, positionPair.posY, TurnTableGameUpperItemType.player);
local positionString = value[1];
item.transform.localPosition = standLocalPositionMap[positionString];
upperPointMap[positionString] = item;
table.insert(startPlayerList, positionString);
elseif value[2] == "2" then
local item = TurnTableGameUpperItem.New(goPointUpperList:GetComponent("RectTransform"));
            local positionPair = this.StringToPostion(value[1]);
item:SetData(positionPair.posX, positionPair.posY, TurnTableGameUpperItemType.obstacle);
local positionString = value[1];
item.transform.localPosition = standLocalPositionMap[positionString];
upperPointMap[positionString] = item;
        end
    end
    for index, value in ipairs(configData.BoardVic) do
        local objResult = TurnTableGameResultItem.New(goPointSuccssfulList:GetComponent("RectTransform"))
        local objTitle = LuaMgr.GetPrefab(
            "Assets/_BundleResources/UI/Home/TeaRoomNewTurnTableGame/TurnTableGameTitleItem.prefab");
        local positionString = value;
        objResult.transform.localPosition = standLocalPositionMap[positionString]
        resultPointMap[positionString] = objResult;

        objTitle:GetComponent("RectTransform"):SetParent(goTurnTableTitle:GetComponent("RectTransform"), false);
        objTitle:GetComponent("RectTransform").localPosition = standLocalPositionMap[positionString];
        resultTitleMap[positionString] = objTitle;
        resultNum = resultNum + 1;
    end
end

this.BackToStart = function()
    if limitClicks then
        return;
    end
    if (btnBackAnimatior ~= nil) then
        btnBackAnimatior:Play("UI_TurnTablePanel_btnBack", 0, 0)
    end
leftStep=tonumber(ConfigMgr.Config.GameBoardMap[boardId].MoveTimes);
    this.ShowLeftStep(true);
    local allPlayerPoint = {};
for key, value in pairs(upperPointMap) do
        if value.isPlayer then
            table.insert(allPlayerPoint, value);
        end
    end
    for i = 1, #allPlayerPoint, 1 do
local nowPositionString = this.PostionToString(allPlayerPoint[i].x, allPlayerPoint[i].y)
upperPointMap[nowPositionString] = nil;
    end
for i = 1, #allPlayerPoint, 1 do
local positionPair = this.StringToPostion(startPlayerList[i]);
allPlayerPoint[i].x = positionPair.posX;
        allPlayerPoint[i].y = positionPair.posY;
upperPointMap[startPlayerList[i]] = allPlayerPoint[i];
upperPointMap[startPlayerList[i]].transform.localPosition = standLocalPositionMap[startPlayerList[i]];
    end
    this.CheckFinish();
end
this.CheckVictory = function()
    local nowFinishNum = 0;
    for key, value in pairs(resultPointMap) do
if upperPointMap[key] ~= nil and upperPointMap[key].isPlayer then
            nowFinishNum = nowFinishNum + 1;
        end
    end
    return resultNum == nowFinishNum;
end

return vm({
    data = data,
    command = command,
    hook = hook
})
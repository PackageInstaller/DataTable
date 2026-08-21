---@class BattleSetupPanel : BattleSetupPanel_Generate
---##################### 【BattleSetupPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleSetupPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BattleSetupPanel = require "BattleSetupPanel_Generate"
local BattleCore = require "BattleCore"

function BattleSetupPanel:InitLogic(data)
    self._isFormation = false

    --通用DOTween动画时间
    self.commonFadeTime = 0.5
end

--function BattleSetupPanel:StartCreating(time)
--
--end

--function BattleSetupPanel:StartEnter(time)
--
--end

--function BattleSetupPanel:StartRemoving(time)
--
--end

--function BattleSetupPanel:StartExit(time)
--
--end

function BattleSetupPanel:OnOpen(data, initiative)
    self._isFormation = data.isFormation
    local battleMgr = BattleCore:getBattleMgr()
    local levelConfig = battleMgr:getLevelConfig()
    if levelConfig then
        self.levelNameText.text.text = levelConfig.nameKey
        self:refreshBattleCond(levelConfig)
    end
    self:refreshBtns()
    self:initBattleSetupGroup()
end

--function BattleSetupPanel:OnClose(initiative)
--
--end

-- function BattleSetupPanel:OnDestroy()
-- 	self.super:OnDestroy(self)
-- end

--function BattleSetupPanel:OnRefresh(data)
--
--end

---刷新关卡条件
function BattleSetupPanel:refreshBattleCond(levelConfig)
    local eventMgr = BattleCore:getEventMgr()
    for i = 1, 3 do
        local isOn = false
        if not self._isFormation then
            isOn = eventMgr.eventSaveData.star >= i
        end
        self["starOn"..i]:SetActive(isOn)
        self["starOff"..i]:SetActive(not isOn)
    end
    
    local deductIdList = eventMgr:getDeductStarIdList()
    self.targetBox.desTxt.text.text = levelConfig.victoryDesKey
    self.failCondDesTxt.text.text = levelConfig.failDesKey
    for i = 1, 2 do
        self["starTargetBox"..i].desTxt.text.text = levelConfig["starDesKey"..i]
        self["starTargetBox"..i].failMask:SetActive(false)
        self["starTargetBox"..i].desTxt.text.fontStyle = TMPro.FontStyles.Normal
        local targetId = levelConfig["triggerID"..i]
        for _, deductId in pairs(deductIdList) do
            if deductId == targetId then
                self["starTargetBox"..i].failMask:SetActive(true)
                self["starTargetBox"..i].desTxt.text.fontStyle = TMPro.FontStyles.Strikethrough
                break
            end
        end
    end

    self:FillTemplateContent(self.condBox, self.secAchContent, #levelConfig.achieve, function(index, condBox)
        local achConfig = Config.GetPveLevelAchieveInfo(levelConfig.achieve[index])
        condBox.desTxt.text.text = achConfig.achiveDesKey
        condBox.progTxt.text.text = ""
    end)
end

function BattleSetupPanel:refreshBtns()
    self.continueBtn:SetActive(not self._isFormation)
    self.retryBtn:SetActive(not self._isFormation)
    self.continueFormationBtn:SetActive(self._isFormation)
end

--退出动画
function BattleSetupPanel:Out()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeUI(self)
    end)
end

function BattleSetupPanel:initBattleSetupGroup()
    local idleOptimizerIsOn = UnityEngine.PlayerPrefs.GetInt(GE.LocalCustomDataKey.IdleOptimizerEnabled, 0)
    local timeLineIsOn = MyPrefs:GetInt(GE.LocalCustomDataKey.TimeLineIsOn, 1)
    local cameraIsOn = MyPrefs:GetInt(GE.LocalCustomDataKey.CameraIsOn, 1)
    -- local battlefieldGridIsOn = DisplayConfigMgr:GetBattlefieldGridStatus()

    local idleOptimizerBtnObj = idleOptimizerIsOn == 1 and self.idleOptimizationOn or self.idleOptimizationOff
    self:setBoxState(self.idleOptimizationState, idleOptimizerBtnObj, idleOptimizerIsOn)

    local skillAnimBtnObj = timeLineIsOn == 1 and self.skillAnimOn or self.skillAnimOff
    self:setBoxState(self.skillAnimState, skillAnimBtnObj, timeLineIsOn)

    local cameraSwitchBtnObj = cameraIsOn == 1 and self.cameraSwitchOn or self.cameraSwitchOff
    self:setBoxState(self.cameraSwitchState, cameraSwitchBtnObj, cameraIsOn)

    -- local battlefieldGridBtnObj = battlefieldGridIsOn and self.battlefieldGridOn or self.battlefieldGridOff
    -- self:setBoxState(self.idleOptimizationState, idleOptimizerBtnObj, idleOptimizerIsOn)
end

---设置按钮状态
---@param stateObj table 按钮状态对象
---@param btnObj table 按钮对象
---@param isOn number 是否开启
function BattleSetupPanel:setBoxState(stateObj, btnObj, isOn)
    stateObj.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    stateObj.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    stateObj.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--待机优化开关
function BattleSetupPanel:setIdleOptimizationBtnFunc(btnObj)
    self.idleOptimizationState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.idleOptimizationState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.idleOptimizationState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    DisplayConfigMgr:SetIdleOptiomizerStatus(isOn == 1)
end

--大招动画开关 
function BattleSetupPanel:setSkillAnimBtnFunc(btnObj)
    self.skillAnimState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.skillAnimState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.skillAnimState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    MyPrefs:SetInt(GE.LocalCustomDataKey.TimeLineIsOn, isOn)
end

--镜头切换开关
function BattleSetupPanel:setCameraSwitchBtnFunc(btnObj)
    self.cameraSwitchState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.cameraSwitchState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.cameraSwitchState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)

    MyPrefs:SetInt(GE.LocalCustomDataKey.CameraIsOn, isOn)
end

--战场网格开关
function BattleSetupPanel:setBattlefieldGridBtnFunc(btnObj)
    self.battlefieldGridState.rectTransform:DOAnchorPos(btnObj.rectTransform.anchoredPosition, self.commonFadeTime):SetEase(DG.Tweening.Ease.OutCubic)
    local isOn = string.find(btnObj.name, "On") and 1 or 0
    self.battlefieldGridState.offText.canvasGroup:DOFade(1 - isOn, self.commonFadeTime)
    self.battlefieldGridState.onText.canvasGroup:DOFade(isOn, self.commonFadeTime)
end

--[[
/BackBtn onClick 
--]]
function BattleSetupPanel:backBtn_ScaleButton_onClick(backBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:Out()
end

--[[
/ExitBtn onClick 
--]]
function BattleSetupPanel:exitBtn_ScaleButton_onClick(exitBtn)
    local battleMgr = BattleCore:getBattleMgr()
    if (self._isFormation) then
        battleMgr:clear()
        -- UIMgr:closeUI(self)
        -- StateMgr:ChangeToState(GameFlowState.GameState)
        --StateMgr:BackLastState()
        LoadingMgr:SetLoadingStart(function()
            StateMgr:BackLastState()
        end, nil, nil, "BattleSetupPanel")
        Me:BattleEnterLevelReq(0)
        return
    end
    battleMgr:getReporter():setResult(GE.BattleResultType.Exit)
    local orderReport = battleMgr:getReporter():getOrderReport()
    Me:battleResultReq(orderReport, {}, {}, function (resultData)
        battleMgr:clear()
        LoadingMgr:SetLoadingStart(function()
            StateMgr:BackLastState()
        end, nil, nil, "BattleSetupPanel2")
    end)
end

--[[
/RetryBtn onClick 
--]]
function BattleSetupPanel:retryBtn_ScaleButton_onClick(retryBtn)
    local battleMgr = BattleCore:getBattleMgr()
    ClientData:SetJumpOpenStory(true)
    if (self._isFormation) then
        battleMgr:clear()
        -- UIMgr:closeUI(self)
        LoadingMgr:SetLoadingStart(function()
            Me:setNowSelectLevel(Me:getNowSelectLevel(), GE.EnterBattleType.NextLevel)
            StateMgr:ChangeToState(GameFlowState.BattleState)
        end, nil, nil, "BattleSetupPanel3")
        return
    end
    battleMgr:getReporter():setResult(GE.BattleResultType.Restart)
    local orderReport = battleMgr:getReporter():getOrderReport()
    Me:battleResultReq(orderReport, {}, {}, function (resultData)
        battleMgr:clear()
        -- UIMgr:closeUI(self)
        LoadingMgr:SetLoadingStart(function()
            Me:setNowSelectLevel(Me:getNowSelectLevel(), GE.EnterBattleType.NextLevel)
            StateMgr:ChangeToState(GameFlowState.BattleState)
        end, nil, nil, "BattleSetupPanel4")
    end)
end

--[[
/ContinueBtn onClick 
--]]
function BattleSetupPanel:continueBtn_ScaleButton_onClick(continueBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:Out()
end

--[[
/MainPanel/MenuToggleGroup/BattleInfoToggle onValueChanged 
--]]
function BattleSetupPanel:battleInfoToggle_TabToggle_onValueChanged(battleInfoToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.battleInfoGroup:SetActive(isOn)
end

--[[
/MainPanel/MenuToggleGroup/BattleSetupToggle onValueChanged 
--]]
function BattleSetupPanel:battleSetupToggle_TabToggle_onValueChanged(battleSetupToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.battleSetupGroup:SetActive(isOn)
end

--[[
/MainPanel/MenuToggleGroup/SystemSetupToggle onValueChanged 
--]]
function BattleSetupPanel:systemSetupToggle_TabToggle_onValueChanged(systemSetupToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.sysSetupGroup:SetActive(isOn)
end

--[[
/MainPanel/ContinueFormationBtn onClick 
--]]
function BattleSetupPanel:continueFormationBtn_ScaleButton_onClick(continueFormationBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:Out()
end

--[[
/MainPanel/DetailPanel/SysSetupGroup/IdleOptimizationBox/BtnGroup/IdleOptimizationOn onClick 
--]]
function BattleSetupPanel:idleOptimizationOn_Button_onClick(idleOptimizationOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --待机优化开
    self:setIdleOptimizationBtnFunc(idleOptimizationOn)
end

--[[
/MainPanel/DetailPanel/SysSetupGroup/IdleOptimizationBox/BtnGroup/IdleOptimizationOff onClick 
--]]
function BattleSetupPanel:idleOptimizationOff_Button_onClick(idleOptimizationOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --待机优化关
    self:setIdleOptimizationBtnFunc(idleOptimizationOff)
end

--[[
/MainPanel/DetailPanel/BattleSetupGroup/SkillAnimBox/BtnGroup/SkillAnimOn onClick 
--]]
function BattleSetupPanel:skillAnimOn_Button_onClick(skillAnimOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --大招动画开
    -- DisplayConfigMgr:SetSkillAnimStatus(true)
    self:setSkillAnimBtnFunc(skillAnimOn)
end

--[[
/MainPanel/DetailPanel/BattleSetupGroup/SkillAnimBox/BtnGroup/SkillAnimOff onClick 
--]]
function BattleSetupPanel:skillAnimOff_Button_onClick(skillAnimOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --大招动画关
    -- DisplayConfigMgr:SetSkillAnimStatus(false)
    self:setSkillAnimBtnFunc(skillAnimOff)
end

--[[
/MainPanel/DetailPanel/BattleSetupGroup/CameraSwitchBox/BtnGroup/CameraSwitchOn onClick 
--]]
function BattleSetupPanel:cameraSwitchOn_Button_onClick(cameraSwitchOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --镜头切换开
    -- DisplayConfigMgr:SetCameraSwitchStatus(true)
    self:setCameraSwitchBtnFunc(cameraSwitchOn)
end

--[[
/MainPanel/DetailPanel/BattleSetupGroup/CameraSwitchBox/BtnGroup/CameraSwitchOff onClick 
--]]
function BattleSetupPanel:cameraSwitchOff_Button_onClick(cameraSwitchOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --镜头切换关
    -- DisplayConfigMgr:SetCameraSwitchStatus(false)
    self:setCameraSwitchBtnFunc(cameraSwitchOff)
end

--[[
/MainPanel/DetailPanel/BattleSetupGroup/BattlefieldGridBox/BtnGroup/BattlefieldGridOn onClick 
--]]
function BattleSetupPanel:battlefieldGridOn_Button_onClick(battlefieldGridOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --战场网格开
    -- DisplayConfigMgr:SetBattlefieldGridStatus(true)
    self:setBattlefieldGridBtnFunc(battlefieldGridOn)
end

--[[
/MainPanel/DetailPanel/BattleSetupGroup/BattlefieldGridBox/BtnGroup/BattlefieldGridOff onClick 
--]]
function BattleSetupPanel:battlefieldGridOff_Button_onClick(battlefieldGridOff)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --战场网格关
    -- DisplayConfigMgr:SetBattlefieldGridStatus(false)
    self:setBattlefieldGridBtnFunc(battlefieldGridOff)
end

return BattleSetupPanel

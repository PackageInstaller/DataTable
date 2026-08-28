-------------------------------------------------------------------------------
-- 预下载 - 测试答题弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-06-09 22:49:44
-------------------------------------------------------------------------------

local util             = require 'XLua.util'
local cs_coroutine     = require 'XLua.cs_coroutine'
local CoWait           = CS.Engine.Lib.CoWait
local Yielders         = CS.Engine.Lib.Yielders
local KTool            = CS.Engine.Lib.KTool
local BehaviourAction  = CS.Engine.Lib.BehaviourAction
local UIModule         = CS.Engine.UI.UIModule
local ResourceModule   = CS.Engine.Modules.ResourceModule
local GameObject       = CS.UnityEngine.GameObject
local PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
---@type Game.Native.URP.URPCameraController
local urpCameraController = CS.Game.Native.URP.URPCameraController.Instance
local DOTween = CS.DG.Tweening.DOTween
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
---@type PreDownloadMgr
local PreDownloadMgr = import('Game.UI.PreDownload.PreDownloadMgr'):GetInstance()
---@type PreDownloadUtils
local PreDownloadUtils = import('Game.UI.PreDownload.PreDownloadUtils')
---@type PreDownloadConstants
local PreDownloadConstants = import('Game.UI.PreDownload.PreDownloadConstants')
---@type GachaponUtils
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
local RESULT_CAMERA_TWEEN_TIME = 0.4
--- from: Assets/BundleResources/Prefabs/PreDownload/PredownloadTestQuestionsDialog.prefab
---@class PredownloadTestQuestionsDialog
---@field Env                           	PredownloadTestQuestionsDialog                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Root                          	UnityEngine.RectTransform               @ 根节点
---@field DialogueFrameNode             	UnityEngine.RectTransform               @ 对话框节点
---@field TxtLeftName                   	UnityEngine.RectTransform               @ 对话名字文本
---@field TxtContent                    	LetterTyperComp                         @ 对话内容文本
---@field ProgressAnimRoot              	UnityEngine.RectTransform               @ 进度动画节点
---@field ProgressText                  	TMPro.TextMeshProUGUI                   @ 进度文本
---@field ProgressImg                   	UnityEngine.UI.Image                    @ 进度图片
---@field Option4Text                   	UnityEngine.RectTransform               @ 选项4文本
---@field Option3Text                   	UnityEngine.RectTransform               @ 选项3文本
---@field Option2Text                   	UnityEngine.RectTransform               @ 选项2文本
---@field Option1Text                   	UnityEngine.RectTransform               @ 选项1文本
---@field Option4Btn                    	UnityEngine.RectTransform               @ 选项4按钮
---@field Option3Btn                    	UnityEngine.RectTransform               @ 选项3按钮
---@field Option2Btn                    	UnityEngine.RectTransform               @ 选项2按钮
---@field Option1Btn                    	UnityEngine.RectTransform               @ 选项1按钮
local PredownloadTestQuestionsDialog = Class('PredownloadTestQuestionsDialog')

local DO_PERFORM_BLOCKER_NAME = 'DO_PERFORM_BLOCKER_NAME'

local CHECK_DEFAULT_ANIMATOR_NAME = 'home_whitecat_idle'

local CHECK_ANIMATOR_NAME_MAP = {
    ["home_whitecat_01"] = true,
    ["home_whitecat_02"] = true,
    ["home_whitecat_03"] = true,
    ["home_whitecat_04"] = true,
    ["home_whitecat_05"] = true,
}


function PredownloadTestQuestionsDialog:__init()
    ---@type table[]
    self.testQuestions_   = nil
    ---@type Engine.Lib.CoWait
    self.doPerformCo_     = nil
    ---@type Engine.Lib.BehaviourAction
    self.behaviourAction_ = nil
    ---@type RoleInstance
    self.roleInstance_    = nil
    ---@type UnityEngine.Animator
    self.roleAnimator_    = nil
    self.questionIndex_   = 0
    self.signboardId_     = 0
    self.vmCamera = nil
    self.originPosition = nil
    self.originRotation = nil
end


function PredownloadTestQuestionsDialog:__delete()
    self.testQuestions_   = nil
    self.questionIndex_   = nil
    self.signboardId_     = nil
    self.roleInstance_    = nil
    self.roleAnimator_    = nil
    self.doPerformCo_     = nil
    self.behaviourAction_ = nil
    self.controller       = nil
    self.vmCamera = nil
    self.originPosition = nil
    self.originRotation = nil
end


function PredownloadTestQuestionsDialog:Awake()
    local parentTrans = UIModule.RootCanvas.transform.parent.transform
    local sceneRoot = parentTrans:Find("DownloadScene")
    self.vmCamera = sceneRoot:Find("CameraRoot/Camera_loc/MaidCoffeeTouchCamera")
end


function PredownloadTestQuestionsDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.Broadcast(Constants.EventNames.MainHomeCameraSwip, { isTrue = false })
        Events.Broadcast(Constants.EventNames.MainHomeRoleActivity, { isActivity = false })
        Events.Broadcast(Constants.EventNames.PREDOWNLOAD_HOME_CONTENT_SWITCH, {isHide = true})
        ---设置拉近相机的参数
        if self.vmCamera then
            self.originPosition = self.vmCamera.position
            self.originRotation = self.vmCamera.rotation
            KTool.SetActive(self.vmCamera.gameObject, false)
            local tweenSequence = DOTween.Sequence()
            --tweenSequence:Append(resultCamera:DOFieldOfView(targetParams.fieldOfView, RESULT_CAMERA_TWEEN_TIME))
            tweenSequence:Join(urpCameraController.mainCamera.transform:DOMove(Vector3.New(1.6, 1.3529, -2.91), RESULT_CAMERA_TWEEN_TIME))
            tweenSequence:Join(urpCameraController.mainCamera.transform:DORotateQuaternion(Quaternion.Euler(0, -180, 0), RESULT_CAMERA_TWEEN_TIME))
            tweenSequence:PlayForward()
        end
        -- wait camera focus
        local waitTime = 0.25
        coroutine.yield(Yielders.GetWaitForSeconds(waitTime))

        -- update progress
        self:UpdateTestProgress_()

        local showDialogue = function()

            -- switch status
            if not isNull(self.roleAnimator_) then
                self.roleAnimator_:SetBool("menuidle", true)
            end

            -- show dialogue
            CfUtils.SetActive(self.Root, true)
            CfUtils.PlayAnimator(self.Root, "Go")
            CfUtils.PlayAnimator(self.DialogueFrameNode, "Show")

            -- updat dialogue
            self:SetQuestionIndex(self:GetQuestionIndex())
        end

        -- check played story
        local isPlayedStory = CfUtils.GetLocalData(Constants.PlayerPrefsType.PreDownloadStoryTestEnter, '') == '1'
        if isPlayedStory then
            -- show navigatorBar
            CfUtils.SetTopCommonActive(true, false)
            showDialogue()
        else
            self:PlayTestEnterStory_(showDialogue)
        end
    end))
    return coWait
end


function PredownloadTestQuestionsDialog:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.Broadcast(Constants.EventNames.MainHomeCameraSwip, { isTrue = true })
        Events.Broadcast(Constants.EventNames.MainHomeRoleActivity, { isActivity = true })
        --设置拉近相机的参数还原
        if self.vmCamera then
            local tweenSequence = DOTween.Sequence()
            --tweenSequence:Append(resultCamera:DOFieldOfView(targetParams.fieldOfView, RESULT_CAMERA_TWEEN_TIME))
            tweenSequence:Join(urpCameraController.mainCamera.transform:DOMove(self.originPosition, RESULT_CAMERA_TWEEN_TIME))
            tweenSequence:Join(urpCameraController.mainCamera.transform:DORotateQuaternion(self.originRotation, RESULT_CAMERA_TWEEN_TIME))
            tweenSequence:PlayForward()
        end
        coroutine.yield(Yielders.GetWaitForSeconds(RESULT_CAMERA_TWEEN_TIME))
        KTool.SetActive(self.vmCamera.gameObject, true)
        -- revert status
        if not isNull(self.roleAnimator_) then
            self.roleAnimator_:SetInteger("menu", 0)
            self.roleAnimator_:SetBool("menuidle", false)
        end

        if self.isShowPredownloadTestResult_ then
            -- show result
            coroutine.yield(UIModule.OpenDialog({ id = Constants.UITypeIds.PredownloadTestResultDialog }))
            
        else
            Events.Broadcast(Constants.EventNames.PREDOWNLOAD_HOME_CONTENT_SWITCH, {isHide = false})

            -- hide dialogue
            CfUtils.PlayAnimator(self.Root, "Out")
            CfUtils.PlayAnimator(self.ProgressAnimRoot, "Out")
            CfUtils.PlayAnimator(self.DialogueFrameNode, "Hide")

            -- wait animator hide
            local waitTime = 0.15
            coroutine.yield(Yielders.GetWaitForSeconds(waitTime))

            local animTime = CfUtils.GetAnimatorTime(self.Root, "PredownloadTestQuestionsDialogOut")
            coroutine.yield(CS.UnityEngine.WaitForSeconds(math.max(animTime - waitTime, 0)))
        end
    end))
    return coWait
end


function PredownloadTestQuestionsDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.signboardId_  = PreDownloadConstants.HOME_SIGNBOARD_ID
        -- init vars
        self.testQuestions_ = {}
        local parentTrans = UIModule.RootCanvas.transform.parent.transform
        local sceneRoot = parentTrans:Find("DownloadScene")
        if sceneRoot then
            local roleTrans = sceneRoot:Find("Role")
            if roleTrans then
                self.roleInstance_ = roleTrans.gameObject
            end
        end
        self.roleAnimator_ = not isNull(self.roleInstance_) and self.roleInstance_.gameObject:GetComponentInChildren(typeof(CS.UnityEngine.Animator), true) or nil

        -- check questions cache
        local testQuestionsCache = CfUtils.GetLocalData(Constants.PlayerPrefsType.PreDownloadTestQuestions, '')
        if not string.isEmpty(testQuestionsCache) then

            -- load questions cache
            self.testQuestions_ = table.deserialize(testQuestionsCache)

            -- check question index
            for questionIndex, questionData in ipairs(self.testQuestions_) do
                if checkInt(questionData.choiceId) == 0 then
                    self.questionIndex_ = questionIndex
                    break
                end
            end

            -- done question
            if self:GetQuestionIndex() == 0 then
                self.questionIndex_ = #self.testQuestions_
            end

        else
            ---@type PreDownloadTestQuestionVo[]
            local allQuestionConfs = CfUtils.GetWholeVo(AutoIds.IdSetting3103, 'PreDownloadTestQuestionVo')

            -- init questions data
            for confIndex, questionVo in ipairs(allQuestionConfs) do
                self.testQuestions_[confIndex] = {
                    questionId = questionVo.id,
                    choiceId   = 0,
                }
            end

            -- save questions cache
            self:SaveTestQuestionsCache_()

            -- reset question index
            self.questionIndex_ = 1
        end

        -- add listeners
        SetButtonAction(self.Option1Btn, function() self:OnQuestionChoice_('choiceOneId') end)  -- 1 is option id key
        SetButtonAction(self.Option2Btn, function() self:OnQuestionChoice_('choiceTwoId') end)  -- 2 is option id key
        SetButtonAction(self.Option3Btn, function() self:OnQuestionChoice_('choiceThreeId') end)  -- 3 is option id key
        SetButtonAction(self.Option4Btn, function() self:OnQuestionChoice_('choiceFourId') end)  -- 4 is option id key

        -- update listen
        self.behaviourAction_ = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
        self.behaviourAction_.UpdateAction = Bind(self, self.OnBehaviourActionUpdate_)

        -- init views
        self.TxtContent:Init()
        CfUtils.SetActive(self.Root, false)
    end))
    return coWait
end


function PredownloadTestQuestionsDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        UIRaycastBlocker:RemoveCondition(DO_PERFORM_BLOCKER_NAME)

        if not isNull(self.behaviourAction_) then
            self.behaviourAction_.UpdateAction = nil
            self.behaviourAction_ = nil
        end
        
        if self.doPerformCo_ ~= nil then
            cs_coroutine.stop(self.doPerformCo_)
            self.doPerformCo_ = nil
        end

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end))
    return coWait
end


-------------------------------------------------
-- get / set

function PredownloadTestQuestionsDialog:GetQuestionIndex()
    return self.questionIndex_
end
function PredownloadTestQuestionsDialog:SetQuestionIndex(value)
    self.questionIndex_ = checkInt(value)
    self:UpdateTestQuestions_()
end


-------------------------------------------------
-- private methods

function PredownloadTestQuestionsDialog:SaveTestQuestionsCache_()
    local testQuestionsCache = ''
    if self.testQuestions_ then
        testQuestionsCache = table.serialize(self.testQuestions_)
    end
    CfUtils.WriteLocalData(Constants.PlayerPrefsType.PreDownloadTestQuestions, testQuestionsCache)
end


function PredownloadTestQuestionsDialog:CleanTestQuestionsCache_()
    CfUtils.WriteLocalData(Constants.PlayerPrefsType.PreDownloadTestQuestions, '')
end


function PredownloadTestQuestionsDialog:UpdateTestQuestions_()
    local questionData = self.testQuestions_[self:GetQuestionIndex()] or {}
    ---@type PreDownloadTestQuestionVo
    local questionConf = CfUtils.GetCfVo(AutoIds.IdSetting3103, 'PreDownloadTestQuestionVo', questionData.questionId)
    
    -- update question text
    CfUtils.FillText(self.Option1Text, questionConf.choiceOne)
    CfUtils.FillText(self.Option2Text, questionConf.choiceTwo)
    CfUtils.FillText(self.Option3Text, questionConf.choiceThree)
    CfUtils.FillText(self.Option4Text, questionConf.choiceFour)

    -- update role action
    if not isNull(self.roleAnimator_) then
        self.roleAnimator_:SetInteger("menu", checkInt(questionConf.action))
    end

    -- update question title
    local txtContent = self.TxtContent
    txtContent:ResetArgs()
    txtContent:SetText("")
    txtContent.PendingTime     = 0.02
    txtContent.AppearDuration  = 0.2
    txtContent.IgnoreTimeScale = true
    txtContent.TextWillFill    = questionConf.title
    txtContent:StartType()

    ---@type RoleShowVo
    local roleShowVo = CfUtils.GetCfVo(AutoIds.IdSetting1810, "RoleShowVo", self.signboardId_)
    CfUtils.FillText(self.TxtLeftName, roleShowVo.name)
end


function PredownloadTestQuestionsDialog:UpdateTestProgress_()
    local questionData  = self.testQuestions_[self:GetQuestionIndex()] or {}
    local isChoiceDone  = checkInt(questionData.choiceId) > 0
    local questionCount = self:GetQuestionIndex() - (isChoiceDone and 0 or 1)

    -- update progress text
    local questionTotal = #self.testQuestions_
    CfUtils.FillText(self.ProgressText, string.format('%d/%d', questionCount, questionTotal))

    -- update progress progress
    self.ProgressImg.fillAmount = (questionCount / questionTotal)
end


---@param choiceIdKey integer
function PredownloadTestQuestionsDialog:OnQuestionChoice_(choiceIdKey)
    self.doPerformCo_ = CoWait.Start():Coroutine(util.cs_generator(function()
        --- append blocker
        UIRaycastBlocker:AddCondition(DO_PERFORM_BLOCKER_NAME)

        -- hide questions
        CfUtils.PlayAnimator(self.Root, "Out")
        local hideAnimTime = CfUtils.GetAnimatorTime(self.Root, "PredownloadTestQuestionsDialogOut")
        coroutine.yield(CS.UnityEngine.WaitForSeconds(hideAnimTime))

        -- update question choice
        local questionData = self.testQuestions_[self:GetQuestionIndex()] or {}
        ---@type PreDownloadTestQuestionVo
        local questionConf = CfUtils.GetCfVo(AutoIds.IdSetting3103, 'PreDownloadTestQuestionVo', questionData.questionId)
        questionData.choiceId = questionConf[choiceIdKey]
        self:SaveTestQuestionsCache_()

        local questionTotal = #self.testQuestions_
        local allChoiceDone = self:GetQuestionIndex() == questionTotal
        if allChoiceDone then
            -- request result
            self:UpdateTestProgress_()
            self:ToRequestTestRequest_()

            -- remove blocker
            UIRaycastBlocker:RemoveCondition(DO_PERFORM_BLOCKER_NAME)
        else
            -- next question
            self:SetQuestionIndex(self:GetQuestionIndex() + 1)
            self:UpdateTestProgress_()

            -- show questions
            CfUtils.PlayAnimator(self.Root, "Go")
            local showAnimTime = CfUtils.GetAnimatorTime(self.Root, "PredownloadTestQuestionsDialog")
            coroutine.yield(CS.UnityEngine.WaitForSeconds(showAnimTime))

            -- remove blocker
            UIRaycastBlocker:RemoveCondition(DO_PERFORM_BLOCKER_NAME)
        end

        self.doPerformCo_ = nil
    end))
end


function PredownloadTestQuestionsDialog:ToRequestTestRequest_()
    local scoreDict = {}
    local baseScore = checkInt(PreDownloadUtils.GetParamsVoValue(PreDownloadConstants.ParamsKeyType.QUESTIONS_BASE_SCORE))
    for _, questionData in ipairs(self.testQuestions_) do
        local choiceId  = checkInt(questionData.choiceId)
        local testScore = scoreDict[tostring(choiceId)] or 0
        scoreDict[tostring(choiceId)] = testScore + baseScore
    end

    GameUtils.Request(Interfaces.PreDownloadMMPI, {score = table.serialize(scoreDict), userId = PreDownloadUtils.GetUserId()}, function(request, response)
        if checkInt(response.errCode) ~= 0 then return end
        
        local preDownloadComp = PreDownloadMgr:GetPreDownloadComponent()

        -- update replayTimes
        local mmpiReplayTimes = preDownloadComp:GetMmpiReplayTimes()
        if checkInt(preDownloadComp:GetMmpiResultId()) > 0 then
            preDownloadComp:SetMmpiReplayTimes(mmpiReplayTimes - 1)
        end
        
        -- update resultId
        local mmpiResultId = checkInt(response.data.mmpiId)
        preDownloadComp:SetMmpiResultId(mmpiResultId)
        
        ---- update catData
        --local catResultData = checkTable(response.data.cat)
        --preDownloadComp:SetCatData(catResultData)

        -- clean questions cache
        self:CleanTestQuestionsCache_()
        
        -- play finish story
        self:PlayTestFinishStory_(function()
            self.isShowPredownloadTestResult_ = true
            self.controller:Close()
        end)
    end)
end


---@param finishCB fun():void
function PredownloadTestQuestionsDialog:PlayTestFinishStory_(finishCB)
    self.doPerformCo_ = cs_coroutine.start(function()
        --- append blocker
        UIRaycastBlocker:AddCondition(DO_PERFORM_BLOCKER_NAME)

        -- preload result prefab
        local resultPrefabPath   = PreDownloadConstants.QuestionsResultPrefabDefine.PREfAB
        local resultPrefabLoader = ResourceModule.LoadBundleAsync(resultPrefabPath, function(loader, ok, resultObject)
            if ok and not isNull(resultObject) then
                PreDownloadMgr:InsetLoader(resultPrefabPath, loader)
            end
        end)

        local storyLoader, storyGo = nil, nil

        coroutine.yield(PreDownloadUtils.LoadAndPlayTL(PreDownloadConstants.StoryStagePrefabPath.TEST_FINISH,
            function(loader, go) 
                storyGo     = go
                storyLoader = loader
                KTool.SetActive(storyGo, true)
                KTool.ResetTransform(storyGo.transform)

                -- remove blocker
                UIRaycastBlocker:RemoveCondition(DO_PERFORM_BLOCKER_NAME)

                -- hide navigatorBar
                CfUtils.SetTopCommonActive(false, false)

                -- hide home role
                if not isNull(self.roleInstance_) then
                    KTool.SetActive(self.roleInstance_.gameObject, false)
                end

                CfUtils.SetActive(self.Root, false)
            end
        ))

        if not isNull(storyLoader) then
            storyLoader:Release()
        end
        if not isNull(storyGo) then
            KTool.SafeDelete(storyGo)
        end

        -- show home role
        if not isNull(self.roleInstance_) then
            KTool.SetActive(self.roleInstance_.gameObject, true)
        end

        -- show navigatorBar
        CfUtils.SetTopCommonActive(true, false)

        Events.Broadcast(Constants.EventNames.PreDownloadDataUpdate)

        -- finish callback
        if finishCB then finishCB() end
        
        self.doPerformCo_ = nil
    end)
end


---@param finishCB fun():void
function PredownloadTestQuestionsDialog:PlayTestEnterStory_(finishCB)
    --- append blocker
    UIRaycastBlocker:AddCondition(DO_PERFORM_BLOCKER_NAME)
    
    local storyLoader, storyGo = nil, nil

    coroutine.yield(PreDownloadUtils.LoadAndPlayTL(PreDownloadConstants.StoryStagePrefabPath.TEST_ENTER,
        function(loader, go) 
            storyGo     = go
            storyLoader = loader
            KTool.SetActive(storyGo, true)
            KTool.ResetTransform(storyGo.transform)

            -- remove blocker
            UIRaycastBlocker:RemoveCondition(DO_PERFORM_BLOCKER_NAME)

            -- hide navigatorBar
            CfUtils.SetTopCommonActive(false, false)

            -- hide home role
            if not isNull(self.roleInstance_) then
                KTool.SetActive(self.roleInstance_.gameObject, false)
            end
        end
    ))

    if not isNull(storyLoader) then
        storyLoader:Release()
    end
    if not isNull(storyGo) then
        KTool.SafeDelete(storyGo)
    end

    -- show home role
    if not isNull(self.roleInstance_) then
        KTool.SetActive(self.roleInstance_.gameObject, true)
    end

    -- show navigatorBar
    CfUtils.SetTopCommonActive(true, false)

    -- write playedStory
    CfUtils.WriteLocalData(Constants.PlayerPrefsType.PreDownloadStoryTestEnter, '1')

    -- finish callback
    if finishCB then finishCB() end
end


-------------------------------------------------
-- hander methodds

function PredownloadTestQuestionsDialog:OnBehaviourActionUpdate_()
    if isNull(self.roleAnimator_) then return end

    local animatorInfo = self.roleAnimator_:GetCurrentAnimatorStateInfo(0)
    if isNull(animatorInfo)  then return end

    if self.isBeginQuestionAni_ then
        if animatorInfo:IsName(CHECK_DEFAULT_ANIMATOR_NAME) then
            self.roleAnimator_:SetInteger("menu", 0)
            self.isBeginQuestionAni_ = false
        end
    else
        for aniName, _ in pairs(CHECK_ANIMATOR_NAME_MAP) do
            if animatorInfo:IsName(aniName) then
                self.isBeginQuestionAni_ = true
                break
            end
        end
    end
end


return PredownloadTestQuestionsDialog

-------------------------------------------------------------------------------
-- 预下载 - 测试结果弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-06-11 18:42:54
-------------------------------------------------------------------------------

local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine'
local CoWait = CS.Engine.Lib.CoWait
local Yielders = CS.Engine.Lib.Yielders
local KCookie = CS.Engine.Lib.KCookie
local KTool = CS.Engine.Lib.KTool
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local UIModule = CS.Engine.UI.UIModule
local ResourceModule = CS.Engine.Modules.ResourceModule
local UniCamera = CS.UnityEngine.Camera
local UniLight = CS.UnityEngine.Light
local UniAnimator = CS.UnityEngine.Animator
local PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local AutoPNGWriter = CS.Game.Native.Corder.AutoPNGWriter
local NamedAnimancer = CS.Animancer.NamedAnimancerComponent
local QuickTap = CS.HedgehogTeam.EasyTouch.QuickTap
local EasyTouch = CS.HedgehogTeam.EasyTouch.EasyTouch
local DOTween = CS.DG.Tweening.DOTween
---@type Game.Native.URP.URPCameraController
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance

local UINavigationBarRoot = CS.UINavigationBarRoot

---@type PreDownloadMgr
local PreDownloadMgr = import('Game.UI.PreDownload.PreDownloadMgr'):GetInstance()
---@type PreDownloadUtils
local PreDownloadUtils = import('Game.UI.PreDownload.PreDownloadUtils')
---@type PreDownloadConstants
local PreDownloadConstants = import('Game.UI.PreDownload.PreDownloadConstants')
---@type GachaponUtils
local GachaponUtils = import('Game.Gachapon.GachaponUtils')
---@type ConstantsCatHouse
local ConstantsCatHouse = import("Game.CatHouse.ConstantsCatHouse")
---@type CriWareUtils
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

local function GetSceneElement(sceneIns, nodePath)
    local pathList = string.split2(nodePath, "/")
    local rootName = table.remove(pathList, 1)
    local rootNode = KTool.DFSFindObject(sceneIns, rootName)
    if not isNull(rootNode) then
        if #pathList > 1 then
            local cellPath = table.concat(pathList, "/")
            local trans = rootNode.transform:Find(cellPath)
            if not isNull(rootNode) then
                return trans.gameObject
            end
        else
            return rootNode.gameObject
        end
    end
    return nil
end

--- from: Assets/BundleResources/Prefabs/PreDownload/PredownloadTestResultDialog.prefab
---@class PredownloadTestResultDialog
---@field Env                            PredownloadTestResultDialog
---@field controller                        Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field RetestNumTxt                    UnityEngine.RectTransform               @ 重试次数文本
---@field RetestGroup                    UnityEngine.RectTransform               @ 重试组节点
---@field BtnRetest                        UnityEngine.RectTransform               @ 重试按钮
---@field BtnShare                        UnityEngine.RectTransform               @ 分享按钮
---@field Root                            UnityEngine.RectTransform               @ 界面根节点
local PredownloadTestResultDialog = Class('PredownloadTestResultDialog')

local RESULT_TIMELINE_BLOCKER_NAME = 'RESULT_TIMELINE_BLOCKER_NAME'

local HOME_SCENE_EXCLUDE_ELEMENTS = {
    'Camera',
    'CameraRoot',
    'Directional Light',
}

local RESULT_CAMERA_TWEEN_TIME = 0.2

local ResultCameraFocusParams = {
    localPosition = Vector3.New(-0.42, 0.77, -1.09),
    localRotation = Quaternion.New(40.86, 26.94, 0.57),
    localScale = Vector3.New(1, 1, 1),
    fieldOfView = 32.258, -- is vertical AxisMode
}

function PredownloadTestResultDialog:__init()
    ---@type UnityEngine.GameObject
    self.resultPrefabeGo_ = nil
    ---@type UnityEngine.Camera
    self.resultCameraComp_ = nil
    ---@type UnityEngine.GameObject[]
    self.loadedObjects_ = nil
    ---@type UnityEngine.GameObject
    self.resultPanelGo_ = nil
    self.cameraInitParams_ = nil
end

function PredownloadTestResultDialog:__delete()
    self.resultPrefabeGo_ = nil
    self.resultCameraComp_ = nil
    self.loadedObjects_ = nil
    self.resultPanelGo_ = nil
    self.controller = nil
end

function PredownloadTestResultDialog:Awake()
end

function PredownloadTestResultDialog:OnFocus(focus)
    -- custom back button
    if focus then
        KTool.SetActive(UINavigationBarRoot.Instance.gameObject, true)
        CfUtils.SetTopCommonActive(true, false)
        CfUtils.SetTopCommonCb(function()
            local isPlayedStory = CfUtils.GetLocalData(Constants.PlayerPrefsType.PreDownloadStoryTestLeave, '') == '1'
            if not isPlayedStory then
                KCookie.Set(Constants.UICacheDataKeys.PREDOWNLOAD_STORY_TEST_LEAFE, 1)
            end

            -- 没播过剧情的话，优先退出播一次剧情
            if not isPlayedStory or self:GetResultPanelIndex() == 1 then
                UIModule.BackDialog()
                if isPlayedStory then
                    ---如果未下载过资源的情况下
                    Events.Broadcast("StartPackageDownload")
                end
            else
                Events.Broadcast(Constants.EventNames.PREDOWNLOAD_TEST_RESULT_PANEL_SWITCH, { panelIndex = 1 })
            end
        end)
    else
        CfUtils.SetTopCommonCb(nil)
    end
end

function PredownloadTestResultDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.Broadcast(Constants.EventNames.PREDOWNLOAD_HOME_CONTENT_SWITCH, { isHide = true })

        -- default result panel
        Events.Broadcast(Constants.EventNames.PREDOWNLOAD_TEST_RESULT_PANEL_SWITCH, { panelIndex = 1 })

        Events.Broadcast(Constants.EventNames.MainHomeCameraSwip, { isTrue = false })
        Events.Broadcast(Constants.EventNames.MainHomeRoleActivity, { isActivity = false })
    end))
    return coWait
end

function PredownloadTestResultDialog:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.Broadcast(Constants.EventNames.PREDOWNLOAD_HOME_CONTENT_SWITCH, { isHide = false })

        Events.Broadcast(Constants.EventNames.MainHomeCameraSwip, { isTrue = true })
        Events.Broadcast(Constants.EventNames.MainHomeRoleActivity, { isActivity = true })
        local parentTrans = UIModule.RootCanvas.transform.parent.transform
        local sceneRoot = parentTrans:Find("DownloadScene")
        if sceneRoot then
            local roleTrans = sceneRoot:Find("Role")
            if roleTrans then
                KTool.SetActive(roleTrans.gameObject, true)
            end
        end
    end))
    return coWait
end

function PredownloadTestResultDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.loadedObjects_ = {}

        -- retest button listen
        SetButtonAction(self.BtnRetest, function()
            local preDownloadComp = PreDownloadMgr:GetPreDownloadComponent()
            local retestLeftTimes = preDownloadComp:GetMmpiReplayTimes()
            -- if retestLeftTimes > 0 then  -- 晨导：现在不要限制重试次数了
            -- show questions
            GameUtils.SecondConfirm(localize('猫球的外观会根据结果变更，是否要重新测试？'), function()
                UIModule.OpenDialog({ id = Constants.UITypeIds.PredownloadTestQuestionsDialog })
                self.controller:Close()
            end, nil, nil, 4)
            -- else
            --     GameUtils.Toast(localize('测试次数已用完'))
            -- end
        end)

        -- share button listen
        SetButtonAction(self.BtnShare, function()
            local preDownloadComp = PreDownloadMgr:GetPreDownloadComponent()
            local testResultId = preDownloadComp:GetMmpiResultId()
            ---@type PreDownloadTestResultVo
            local testResultConf = CfUtils.GetCfVo(AutoIds.IdSetting3101, "PreDownloadTestResultVo", testResultId)
            GameUtils.ShareScreenShot({
                prefabPath = 'Prefabs/PreDownload/PredownloadShareShowDialog.prefab',
                imgQuaily = 80, -- 因为有半透明pad屏幕，质量太低会比较模糊
                finishCB = function(filePath)
                    GachaponUtils.OpenDialogAction(Constants.UITypeIds.CommonSharePreviewDialog, {
                        filePath = filePath,
                        shareType = Constants.ShareType.PRE_DOWNLOAD_TEST,
                        shareMsgArgs = {
                            _testResult1_ = tostring(testResultConf.title),
                            _testResult2_ = tostring(testResultConf.catTitle),
                        },
                    })
                end
            })
        end)

        self.resultPanelSwitchCB_ = Events.AddListener(Constants.EventNames.PREDOWNLOAD_TEST_RESULT_PANEL_SWITCH, function(data)
            self:SetResultPanelIndex(data.panelIndex)
        end)

        KTool.SetActive(self.BtnShare.gameObject, PreDownloadUtils.IsShowShareButton())

        CfUtils.SetActive(self.RetestGroup.transform:Find('NumberGroup'), false)  -- 晨导：现在不要限制重试次数了

        -- load result prefab
        local resultPrefabPath = PreDownloadConstants.QuestionsResultPrefabDefine.PREfAB
        local resultPrefabLoader = PreDownloadMgr:PopupLoader(resultPrefabPath)
        if not resultPrefabLoader then
            resultPrefabLoader = ResourceModule.LoadBundleAsync(resultPrefabPath, nil, true)
            while not resultPrefabLoader.IsCompleted do
                coroutine.yield(Yielders.EndOfFrame)
            end
        end
        self.resultPrefabeGo_ = resultPrefabLoader:Instantiate(false, nil, false)
        resultPrefabLoader:Release()

        -- hide homeScene elements
        self:HideHomeSceneElements_()

        -- hide fake catPrefab
        local fakeCatTrans = self.resultPrefabeGo_.transform:Find('PlayerMainNew/fake_30301')
        if not isNull(fakeCatTrans) then
            CfUtils.SetActive(fakeCatTrans, false)
        end

        -- result panels
        local resultPanel = PreDownloadConstants.QuestionsResultPrefabDefine.PANEL
        self.resultPanelGo_ = self.resultPrefabeGo_.transform:Find(resultPanel).gameObject

        -- switch camera
        local resultCameraPath = PreDownloadConstants.QuestionsResultPrefabDefine.CAMERA
        local resultCameraTrans = self.resultPrefabeGo_.transform:Find(resultCameraPath)
        self.resultCameraComp_ = resultCameraTrans.gameObject:GetComponent(typeof(UniCamera))
        URPCameraController:InitCameraStack(self.resultCameraComp_)

        -- add easyTouch
        EasyTouch.AddCamera(self.resultCameraComp_, false)

        -- save cameraInitParams
        self.cameraInitParams_ = {
            localPosition = Vector3.New(resultCameraTrans.localPosition.x, resultCameraTrans.localPosition.y, resultCameraTrans.localPosition.z),
            localRotation = Quaternion.New(resultCameraTrans.eulerAngles.x, resultCameraTrans.eulerAngles.y, resultCameraTrans.eulerAngles.z),
            localScale = Vector3.New(resultCameraTrans.localScale.x, resultCameraTrans.localScale.y, resultCameraTrans.localScale.z),
            fieldOfView = self.resultCameraComp_.fieldOfView,
        }

        -- show resultPrefab
        CfUtils.SetActive(self.resultPrefabeGo_, true)

        -- play result timeline
        self:PlayResultTimeline_()
    end))
    return coWait
end

function PredownloadTestResultDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        Events.RemoveListener(Constants.EventNames.PREDOWNLOAD_TEST_RESULT_PANEL_SWITCH, self.resultPanelSwitchCB_)

        if not isNull(self.behaviourAction_) then
            self.behaviourAction_.UpdateAction = nil
            self.behaviourAction_ = nil
        end

        if self.playResultTimelineCo_ ~= nil then
            UIRaycastBlocker:RemoveCondition(RESULT_TIMELINE_BLOCKER_NAME)
            cs_coroutine.stop(self.playResultTimelineCo_)
            self.playResultTimelineCo_ = nil
        end

        if self.resultCameraComp_ then
            EasyTouch.RemoveCamera(self.resultCameraComp_)
            self.resultCameraComp_ = nil
        end

        for objPath, loadedObj in pairs(self.loadedObjects_ or {}) do
            CfUtils.SafeDelete(loadedObj)
        end

        if self.resultPrefabeGo_ then
            CfUtils.SafeDelete(self.resultPrefabeGo_)
            self.resultPrefabeGo_ = nil
        end

        self:ShowHomeSceneElements_()

        CfUtils.ResetNavigatorCustomBackAction()

        CriWareUtils.PlayRandomBGMFromCDList()

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end))
    return coWait
end


-------------------------------------------------
-- get / set

function PredownloadTestResultDialog:GetResultPanelIndex()
    return self.resultPanelIndex_
end
function PredownloadTestResultDialog:SetResultPanelIndex(index)
    self.resultPanelIndex_ = checkInt(index)
    -- mark testResult end
    CfUtils.WriteLocalData(Constants.PlayerPrefsType.PreDownloadTestResultEnd, '1')
    -- switch retest group
    CfUtils.SetActive(self.RetestGroup, self:IsRetestGroupVisible())
    -- doTween camera
    local resultCamera = URPCameraController.mainCamera -- self.resultCameraComp_
    if not isNull(resultCamera) then
        local cameraTrans = resultCamera.transform
        local targetParams = self:GetResultPanelIndex() == 1 and self.cameraInitParams_ or ResultCameraFocusParams
        local tweenSequence = DOTween.Sequence()
        tweenSequence:Append(resultCamera:DOFieldOfView(targetParams.fieldOfView, RESULT_CAMERA_TWEEN_TIME))
        tweenSequence:Join(cameraTrans:DOMove(targetParams.localPosition, RESULT_CAMERA_TWEEN_TIME))
        tweenSequence:Join(cameraTrans:DORotate(targetParams.localRotation, RESULT_CAMERA_TWEEN_TIME))
        tweenSequence:PlayForward()
    end
end

function PredownloadTestResultDialog:IsRetestGroupVisible()
    local isPlayedStory = CfUtils.GetLocalData(Constants.PlayerPrefsType.PreDownloadStoryTestLeave, '') == '1'
    local viewResultEnd = CfUtils.GetLocalData(Constants.PlayerPrefsType.PreDownloadTestResultEnd, '')
    return self:GetResultPanelIndex() == 1 and viewResultEnd == '1' and isPlayedStory
end


-------------------------------------------------
-- private

function PredownloadTestResultDialog:HideHomeSceneElements_()
    local parentTrans = UIModule.RootCanvas.transform.parent.transform
    local sceneRoot = parentTrans:Find("DownloadScene")
    for _, elementPath in ipairs(HOME_SCENE_EXCLUDE_ELEMENTS) do
        local elementGo = GetSceneElement(sceneRoot, elementPath)
        if not isNull(elementGo) then
            CfUtils.SetActive(elementGo, false)
        end
    end
end

function PredownloadTestResultDialog:ShowHomeSceneElements_()
    local parentTrans = UIModule.RootCanvas.transform.parent.transform
    local sceneRoot = parentTrans:Find("DownloadScene")
    for _, elementPath in ipairs(HOME_SCENE_EXCLUDE_ELEMENTS) do
        local elementGo = GetSceneElement(sceneRoot, elementPath)
        if not isNull(elementGo) then
            CfUtils.SetActive(elementGo, true)
        end
    end
end

function PredownloadTestResultDialog:PlayResultTimeline_(finishCB)
    ---@return UnityEngine.GameObject
    local MakeLoadPrefab = function(prefabPath)
        local prefabLoader = ResourceModule.LoadBundleAsync(prefabPath, nil, true)
        while not prefabLoader.IsCompleted do
            coroutine.yield(Yielders.EndOfFrame)
        end

        local prefabIns = nil
        if not isNull(prefabLoader.ResultObject) then
            prefabIns = prefabLoader:Instantiate(false, nil, false)
            self.loadedObjects_[prefabPath] = prefabIns
        end
        prefabLoader:Release()
        return prefabIns
    end

    self.playResultTimelineCo_ = cs_coroutine.start(function() xTry(function()
        --- append blocker
        UIRaycastBlocker:AddCondition(RESULT_TIMELINE_BLOCKER_NAME)

        -- load timeline prefab
        local resultTlPath = PreDownloadConstants.QuestionsResultTimelineDefine.PREFAB
        local resultTlIns = MakeLoadPrefab(resultTlPath)

        -- load cat prefab
        local resultCatGo = nil
        local catAnimancerComp = nil
        local isCatTouchPlaying = false
        ---@param catGo UnityEngine.GameObject
        cs_coroutine.yield_return(PreDownloadUtils.LoadResultCatModelAsync(function(catGo)
            resultCatGo = catGo
            self.loadedObjects_['resultCatGo'] = resultCatGo

            ---@type Animancer.NamedAnimancerComponent
            catAnimancerComp = resultCatGo:GetComponent(typeof(NamedAnimancer))
            if not isNull(catAnimancerComp) then
                catAnimancerComp.enabled = false
            end
        end, resultTlIns))

        ---@type UnityEngine.Playables.PlayableDirector
        local tlDirector = resultTlIns:GetComponent(typeof(PlayableDirector))

        -- bind tracks
        local catTrack = PreDownloadConstants.QuestionsResultTimelineDefine.CAT_TRACK
        local catPlace = PreDownloadConstants.QuestionsResultTimelineDefine.CAT_PLACE
        resultCatGo.transform:SetParent(resultTlIns.transform:Find(catPlace), false)
        GachaponUtils.BindTimeline(tlDirector, catTrack, resultCatGo)

        -- remove blocker
        UIRaycastBlocker:RemoveCondition(RESULT_TIMELINE_BLOCKER_NAME)

        -- play result timeline
        CfUtils.SetActive(resultCatGo, true)
        CfUtils.SetActive(resultTlIns, true)
        tlDirector.time = 0
        tlDirector:Play()
        CriWareUtils.PlaySeById('sfx_story_00_rujing')
        coroutine.yield(Yielders.GetWaitForSeconds(tlDirector.duration))

        if not isNull(catAnimancerComp) then
            catAnimancerComp.enabled = true

            -- cat quickTap
            local quickTapComp = KTool.GetOrAddComponent(resultCatGo, typeof(QuickTap))
            quickTapComp.onTap:RemoveAllListeners()
            quickTapComp.onTap:AddListener(function()
                if not catAnimancerComp:IsPlaying("idle") or isCatTouchPlaying then
                    return
                end
                local playState = catAnimancerComp:TryPlay(string.format("touch%d", math.random(3)))
                if not isNull(playState) then
                    isCatTouchPlaying = true
                    playState.Events:SetEndAction(function()
                        playState.Events:SetEndAction(nil)
                        isCatTouchPlaying = false
                        catAnimancerComp:TryPlay('idle')
                    end)
                end
            end)

            -- update listen
            local catAniRandomTime = os.time()
            self.behaviourAction_ = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
            self.behaviourAction_.UpdateAction = function()
                local offsetSeconds = os.time() - catAniRandomTime
                if offsetSeconds >= 12 then
                    if catAnimancerComp:IsPlaying("idle") then
                        local playState = catAnimancerComp:TryPlay(string.format("touch%d", math.random(3)))
                        if not isNull(playState) then
                            playState.Events:SetEndAction(function()
                                playState.Events:SetEndAction(nil)
                                catAnimancerComp:TryPlay("idle")
                            end)
                        end
                    end
                    catAniRandomTime = os.time()
                end
            end
        end

        -- finish callback
        if finishCB then finishCB() end
    end) end)
end

return PredownloadTestResultDialog

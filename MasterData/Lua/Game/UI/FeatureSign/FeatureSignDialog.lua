---
--- Created by Eric.
--- DateTime: 2022/7/4 16:01
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local FeatureSignComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.FeatureSignComponent)
local ResourceModule = CS.Engine.Modules.ResourceModule
local PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local support = require 'Frame.support'
local GameObject = CS.UnityEngine.GameObject
local cs_coroutine = require 'XLua.cs_coroutine'
local MonoHelper = CS.Engine.Lib.MonoHelper
local PlayableDirectorType = typeof(CS.UnityEngine.Playables.PlayableDirector)
local TimeLinePlayerType  = typeof(CS.Engine.TimeLine.TimeLinePlayer)
local CriSoundMgr = CS.Engine.Lib.CriSoundMgr
local CriWareUtils =  import('Game.Entry.CriWareUtilsFix')
local Yielders = CS.Engine.Lib.Yielders
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local Camera = CS.UnityEngine.Camera
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

------------ import ------------

------------ define ------------
local GiftType = {
    Leave = 2,
    Letter = 4,
}

local MusicTL = {
    "Gift_TL_01",
    "Gift_TL_02_01",
    "Gift_TL_02_02",
    "Gift_TL_03",
}

------------ define ------------


--- from:  > name: ThankChooseGiftWhite
---@class FeatureSignDialog
---@field Env                           	FeatureSignDialog
---@field controller                    	Engine.UI.UILuaDialog
---@field TxtDescription                	UnityEngine.UI.Text
---@field DialogGroup                   	UnityEngine.RectTransform
---@field BtnGroup2                     	UnityEngine.RectTransform
---@field Group2                        	UnityEngine.RectTransform
---@field BtnGroup1                     	UnityEngine.RectTransform
---@field Group1                        	UnityEngine.RectTransform
---@field UIFX_ThankChooseGiftWhite     	UnityEngine.RectTransform
---@field ClickHandGroup                	UnityEngine.RectTransform
---@field ImgBg                         	UnityEngine.RectTransform
---@field BtnSkip                       	UnityEngine.RectTransform
local FeatureSignDialog = Class("FeatureSignDialog")
function FeatureSignDialog:__init()
    self.timeLineGoList = {}
    self.giftInfo = {}
    self.data = {}
    self.multiRewardsNodeList = {}
    self.coList = {}
    self.go = nil
end

function FeatureSignDialog:__delete()
    self.timeLineGoList = nil
    self.giftInfo = nil
    self.data = nil
    self.multiRewardsNodeList = nil
    self.coList = nil
    self.go = nil
    self.controller = nil
end

function FeatureSignDialog:Awake()
    FeatureSignComponent.isInFeatureSign = true
    self.EventFresh = Events.AddListener(Constants.EventNames.FeatureSignFresh, Bind(self, self.SetGiftInfo))

    self:LoadRes()
    local parameters  = self.controller.Argument.parameters
    if parameters then
        --URPCameraController:SetMainCameraActive(false)
        --KTool.SetActive(URPCameraController.mainCamera.gameObject, false)
        self:SetGiftInfo(parameters.info)
        self:StageOne()
    end
end

function FeatureSignDialog:SetGiftInfo(info, isStageTwo)
    self.giftInfo = info
    if isStageTwo then
        self:StageTwo()
    end
end

function FeatureSignDialog:SetMusic(tlIndex)
    for i, v in pairs(MusicTL) do
        if i == tlIndex then
            CriWareUtils.PlaySeById(v)
        else
            CriWareUtils.StopById(v)
        end
    end
end

function FeatureSignDialog:StageOne()
    KTool.SetActive(self.BtnSkip.gameObject, true)
    KTool.SetActive(self.timeLineGoList["1"].gameObject, true)
    KTool.SetActive(self.timeLineGoList["2_1"].gameObject, false)
    KTool.SetActive(self.timeLineGoList["2_2"].gameObject, false)
    KTool.SetActive(self.timeLineGoList["3"].gameObject, false)
    KTool.SetActive(self.DialogGroup.gameObject, false)
    KTool.SetActive(self.ClickHandGroup.gameObject, false)
    KTool.SetActive(self.UIFX_ThankChooseGiftWhite.gameObject, false)
    KTool.SetActive(self.Group1.gameObject, false)
    KTool.SetActive(self.Group2.gameObject, false)
    local cam = KTool.GetOrAddComponent(self.timeLineGoList["1"].transform:Find("camPar/cam").gameObject, typeof(Camera))
    URPCameraController:InitCameraStack(cam)
    self:SetMusic(1)
    local co = cs_coroutine.start(function()
        local director = self.timeLineGoList["1"].gameObject:GetComponent(PlayableDirectorType)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(director.duration))
        self:StageTwo()
    end)
    table.insert(self.coList, co)
    SetButtonAction(self.BtnSkip, function()
        self:StageTwo()
        cs_coroutine.stop(co)
    end)

end

function FeatureSignDialog:StageTwo()
    --local co = cs_coroutine.start(function()
        self.isFinish = false
        self.data = CfUtils.GetCfVo(AutoIds.IdSetting960, "LoginRewardVo", self.giftInfo.giftId)
        KTool.SetActive(self.BtnSkip.gameObject, false)
        KTool.SetActive(self.timeLineGoList["1"].gameObject, false)
        KTool.SetActive(self.timeLineGoList["2_1"].gameObject, true)
        KTool.SetActive(self.timeLineGoList["2_2"].gameObject, false)
        KTool.SetActive(self.timeLineGoList["3"].gameObject, false)
        KTool.SetActive(self.DialogGroup.gameObject, false)
        KTool.SetActive(self.ClickHandGroup.gameObject, true)
        KTool.SetActive(self.UIFX_ThankChooseGiftWhite.gameObject, false)
        KTool.SetActive(self.Group1.gameObject, false)
        KTool.SetActive(self.Group2.gameObject, false)

        local cam1 = KTool.GetOrAddComponent(self.timeLineGoList["2_1"].transform:Find("camPar/cam").gameObject, typeof(Camera))
        URPCameraController:InitCameraStack(cam1)
        self:SetMusic(2)

    --region 刷新奖励，台词

        local hasWords = self:HasWords()
        local hasSound = self:HasSound()
    --print("------>>"..table.dump(self.data))
        local isMultipleRewards = self:isMultipleRewards()
        if hasWords then
            local text = self.data.words
            if checkNumber(self.data.giftType) == GiftType.Leave then
                local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
                local leaveNum = playerComponent.playerDojo.offlineDays
                text = string.fmt(text, { _leaveNum_ = leaveNum })
            end
            self.TxtDescription.text = text
        end
        if isMultipleRewards then
            local goCount = self.Group2.transform.childCount - 1 --减去默认prefab的数量
            if goCount > #self.data.rewards then
                for i = #self.data.rewards + 1, goCount do --复用时隐藏多出来的
                    KTool.SetActive(self.multiRewardsNodeList[i], false)
                end
            end
            for i = 1, #self.data.rewards do
                local go
                go = self.multiRewardsNodeList[i]
                if not go then
                    go = CfUtils.InstantiateGo(self.BtnGroup2, self.Group2.gameObject)
                    self.multiRewardsNodeList[i] = go.gameObject
                end
                self:FreshRewardNode(go, self.data.rewards[i])
                KTool.SetActive(go, true)
            end

            if checkNumber(self.data.giftType) == GiftType.Letter then
                local go
                go = CfUtils.InstantiateGo(self.BtnGroup2, self.Group2.gameObject)
                self.multiRewardsNodeList[#self.data.rewards + 1] = go.gameObject
                local letterData = CfUtils.GetCfVo(AutoIds.IdSetting961, "LetterVo", self.data.letter)

            	self:FreshRewardNode(go, {
                    goodsId = letterData.goodsId,
                    goodsNum = 1,
                })
                KTool.SetActive(go, true)

            end
        else
            self:FreshRewardNode(self.BtnGroup1, self.data.rewards[1])
        end
        --endregion

        SetButtonAction(self.ClickHandGroup, function ()
            KTool.SetActive(self.ClickHandGroup.gameObject, false)
            KTool.SetActive(self.DialogGroup.gameObject, hasWords)
            KTool.SetActive(self.UIFX_ThankChooseGiftWhite.gameObject, true)
            KTool.SetActive(self.Group1.gameObject, not isMultipleRewards)
            KTool.SetActive(self.Group2.gameObject, isMultipleRewards)
            if hasSound then
                if self.playedVoice then
                    CriSoundMgr.Stop(self.playedVoice.CueInfo)
                end
                self.playedVoice = CriWareUtils.PlayVoiceById(self.data.sound, self.TxtDescription.gameObject)
            end
            KTool.SetActive(self.timeLineGoList["2_1"].gameObject, false)
            KTool.SetActive(self.timeLineGoList["2_2"].gameObject, true)
            if checkNumber(self.data.giftType) == GiftType.Letter then
                self.isLetter = true
            else
                self.isFinish = true
            end
            local cam2 = KTool.GetOrAddComponent(self.timeLineGoList["2_2"].transform:Find("camPar/cam").gameObject, typeof(Camera))
            URPCameraController:InitCameraStack(cam2)
            self:SetMusic(3)
        end)

        --self.__lateUpdateHandle = Bind(self, self.LateUpdate)
        --MonoHelper.AddLateUpdateListener(self.__lateUpdateHandle)
        --self.ClickHandGroup.onSingleFingerDown:RemoveAllListeners()
        --self.ClickHandGroup.onSingleFingerDown:AddListener(function(position)
        --    if isNull(position) then
        --        return
        --    end
        --    --if self.enableTouch then
        --    --    self.enableTouch = false
        --    --    self.director:Evaluate()
        --    --    self:Resume()
        --    KTool.SetActive(self.ClickHandGroup.gameObject, false)
        --    KTool.SetActive(self.DialogGroup.gameObject, hasWords)
        --    KTool.SetActive(self.UIFX_ThankChooseGiftWhite.gameObject, true)
        --    KTool.SetActive(self.Group1.gameObject, not isMultipleRewards)
        --    KTool.SetActive(self.Group2.gameObject, isMultipleRewards)
        --    if hasSound then
        --        if self.playedVoice then
        --            CriSoundMgr.Stop(self.playedVoice.CueInfo)
        --        end
        --        self.playedVoice = CriWareUtils.PlayVoiceById(self.data.sound, self.TxtDescription.gameObject)
        --    end
        --    KTool.SetActive(self.timeLineGoList["2_1"].gameObject, false)
        --    KTool.SetActive(self.timeLineGoList["2_2"].gameObject, true)
        --    if checkNumber(self.data.type) == GiftType.Letter then
        --        self.isLetter = true
        --    else
        --        self.isFinish = true
        --    end
        --    local cam2 = KTool.GetOrAddComponent(self.timeLineGoList["2_2"].transform:Find("camPar/cam").gameObject, typeof(Camera))
        --    URPCameraController:InitCameraStack(cam2)
        --    --end
        --end)
        SetButtonAction(self.ImgBg, function ()
            if self.isFinish then
                self.isFinish = false
                local hasFeatureSign = FeatureSignComponent:CheckFeatureSign()
                if not hasFeatureSign then
                    self:StageThree()
                else
                    --self.director.
                    --cs_coroutine.stop(co)
                    --return
                end
            elseif self.isLetter then
                local data = clone(self.data)
                UIModule.OpenDialog({ id = Constants.UITypeIds.FeatureSignLetter, parameters = { giftData = data, cb = function ()
                    self.isLetter = false
                    self.isFinish = true
                end}},
                        {
                            --{ id = Constants.UITypeIds.UIHomeView },
                        })
            end
        end)

    --end)
    --table.insert(self.coList, co)
end

function FeatureSignDialog:FreshRewardNode(gameObject, rewardData)
    --print("rewardData------->>"..table.dump(rewardData, nil, 3))
    local icon = gameObject.transform:Find("AnimRoot/Icon/ImgIcon")
    local num = gameObject.transform:Find("AnimRoot/TxtNumber")
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(rewardData.goodsId)
    if vo then
        SetButtonAction(gameObject, function()
            if isTable(vo) then
                GameUtils.ShowCommonTipsBoard(gameObject, vo.name, vo.desc, vo.quality, vo.id)
            end
        end)
        KTool.SetActive(num, checkNumber(rewardData.goodsNum) > 0)
        CfUtils.FillImage(icon, vo.photoPath)
        CfUtils.FillText(num, "x"..tostring(rewardData.goodsNum))
    end
end


function FeatureSignDialog:StageThree()
    KTool.SetActive(self.BtnSkip, false)
    KTool.SetActive(self.timeLineGoList["1"].gameObject, false)
    KTool.SetActive(self.timeLineGoList["2_1"].gameObject, false)
    KTool.SetActive(self.timeLineGoList["2_2"].gameObject, false)
    KTool.SetActive(self.timeLineGoList["3"].gameObject, true)
    KTool.SetActive(self.DialogGroup.gameObject, false)
    KTool.SetActive(self.ClickHandGroup.gameObject, false)
    KTool.SetActive(self.UIFX_ThankChooseGiftWhite.gameObject, false)
    KTool.SetActive(self.Group1.gameObject, false)
    KTool.SetActive(self.Group2.gameObject, false)
    local cam = KTool.GetOrAddComponent(self.timeLineGoList["3"].transform:Find("camPar/cam").gameObject, typeof(Camera))
    URPCameraController:InitCameraStack(cam)
    self:SetMusic(4)

    local co = cs_coroutine.start(function()
        local director = self.timeLineGoList["3"].gameObject:GetComponent(PlayableDirectorType)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(director.duration))
        GameUtils.ShowBlackOverlay()
        CfUtils.SetActive(self.timeLineGoList['3'], false)
        UIModule.BackDialog()
    end)
    table.insert(self.coList, co)
end

function FeatureSignDialog:LoadRes()
    local loader = ResourceModule.LoadBundleSync("Timeline/Prefab/GiftTLPack.prefab", nil, true)
    if loader.IsSuccess then
        ---@type UnityEngine.GameObject
        local go = GameObject.Instantiate(loader.ResultObject)
        loader:Retain(go)
        loader:Release()
        go.transform.localPosition = Vector3.New(-4, -0.2, 12)
        go.transform.localRotation = Quaternion.Euler(0, 62, 0)
        self.go = go
        for i = 1, 3 do
            if i == 2 then
                self.timeLineGoList["2_1"] = go.transform:Find("2_1")
                self.timeLineGoList["2_2"] = go.transform:Find("2_2")
            else
                self.timeLineGoList[tostring(i)] = go.transform:Find(i)
            end
        end
        --self.director = self.timeLineGoList[2].gameObject:GetComponent(PlayableDirectorType)
        --self.timelineNotificationReceiver = self.timeLineGoList[2].gameObject:GetComponent(typeof(CS.TimelineNotificationReceiver))
        --self.__ProcessNotify = Bind(self, self.ProcessNotify)
        --self.timelineNotificationReceiver:CustomOnNotify("+", self.__ProcessNotify)

    else
        loader:Release(true)
    end
end

function FeatureSignDialog:isMultipleRewards()
    return table.count(self.data.rewards) > 1
end

function FeatureSignDialog:HasWords()
    return not(string.isEmpty(self.data.words) or self.data.words == "")
end

function FeatureSignDialog:HasSound()
    return not (string.isEmpty(self.data.sound) or self.data.sound == "")
end

function FeatureSignDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        ---@type CardProgressionUtils
        local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
        ---@type CardProgressionControllerRole
        local controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
        if controllerEnv then
            local state = checkNumber(CfUtils.GetLocalData(Constants.UICacheDataKeys.HOME_BOARD_STATE, '1'))
            if state <= 2 then
                local func = state == 1 and controllerEnv.IsLoadRoleComplete or controllerEnv.IsLoadCatComplete
                while not func(controllerEnv) do
                    coroutine.yield()
                end
            end
            controllerEnv:FreshExtraPrefabShowState(false)
            Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, false)
            --Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })
        else
            printError('===>')
        end
    end))
    return coWait
end

function FeatureSignDialog:DisposeLoadRes()
    self.timeLineGoList = nil
    if not isNull(self.go) then
        KTool.SafeDelete(self.go, true)
    end
    for k, v in pairs(self.coList) do
        if not isNull(v) then
            cs_coroutine.stop(v)
        end
    end
end

function FeatureSignDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        FeatureSignComponent.isInFeatureSign = false
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = true })
        --KTool.SetActive(URPCameraController.mainCamera.gameObject, true)
        --URPCameraController:SetMainCameraActive(true)

        if self.playedVoice then
            CriSoundMgr.Stop(self.playedVoice.CueInfo)
        end
        self:DisposeLoadRes()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return FeatureSignDialog
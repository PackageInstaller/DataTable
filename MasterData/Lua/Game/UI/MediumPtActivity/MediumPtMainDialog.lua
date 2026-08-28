---
--- Created by Eric.
--- DateTime: 2022/6/10 11:29
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local MediumPTActivityComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MediumPTActivityComponent)
local StoreUtils = import('Game.UI.Store.StoreUtils')
local StoreConstants = import('Game.UI.Store.StoreConstants')
local ActivityConstants = import("Game.Activity.ActivityConstants")
local KCookie = CS.Engine.Lib.KCookie
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
local StoreUtils = import('Game.UI.Store.StoreUtils')

------------ import ------------

------------ define ------------
local BGM = "bgm_instance_swimsuit"
------------ define ------------


--- from: Assets/BundleResources/Prefabs/MediumPt/MediumPtMainDialog.prefab > name: MediumPtMainDialog
---@class MediumPtMainDialog
---@field Env                           	MediumPtMainDialog                      
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnChapterEnd                 	UnityEngine.RectTransform               	@ 0    
---@field CgEnd                         	UnityEngine.RectTransform               	@ 1    
---@field TextTimeClose                 	UnityEngine.UI.Text                     	@ 2    
---@field ActivityCloseNode             	UnityEngine.RectTransform               	@ 3    
---@field BtnExplain                    	UnityEngine.RectTransform               	@ 4    
---@field FinalChapterfn                	UnityEngine.RectTransform               	@ 5    
---@field ImgRole4fn                    	UnityEngine.RectTransform               	@ 6    
---@field ImgRole3fn                    	UnityEngine.RectTransform               	@ 7    
---@field ImgRole2fn                    	UnityEngine.RectTransform               	@ 8    
---@field ImgRole1fn                    	UnityEngine.RectTransform               	@ 9    
---@field Final                         	UnityEngine.RectTransform               	@ 10   
---@field Normal                        	UnityEngine.RectTransform               	@ 11   
---@field PtcChallenge                  	UnityEngine.RectTransform               	@ 12   
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 13   
---@field ImgPoint                      	UnityEngine.RectTransform               	@ 14   
---@field BtnChallenge                  	UnityEngine.RectTransform               	@ 15   
---@field BtnReview                     	UnityEngine.RectTransform               	@ 16   
---@field BtnStore                      	UnityEngine.RectTransform               	@ 17   
---@field BtnReward                     	UnityEngine.RectTransform               	@ 18   
---@field ReviewCompleted               	UnityEngine.RectTransform               	@ 19   
---@field ReviewUnderway                	UnityEngine.RectTransform               	@ 20   
---@field ReviewGroup                   	UnityEngine.RectTransform               	@ 21   
---@field TextTime                      	UnityEngine.UI.Text                     	@ 22   
---@field ActivityTimeGroup             	UnityEngine.RectTransform               	@ 23   
---@field TextNumberProgressfn          	TMPro.TextMeshProUGUI                   	@ 24   
---@field TextNumberProgress            	TMPro.TextMeshProUGUI                   	@ 25   
---@field UIFX_MediumPt_Memory          	UnityEngine.RectTransform               	@ 26   
---@field FinalChapter                  	UnityEngine.RectTransform               	@ 27   
---@field ImgRole4                      	UnityEngine.RectTransform               	@ 28   
---@field ImgRole3                      	UnityEngine.RectTransform               	@ 29   
---@field ImgRole2                      	UnityEngine.RectTransform               	@ 30   
---@field ImgRole1                      	UnityEngine.RectTransform               	@ 31   
local MediumPtMainDialog = Class("MediumPtMainDialog")
function MediumPtMainDialog:__init()
    self.plotMap= {}--当期活动剧情数据   key：入口类型（表中pos字段）  value对应入口类型的所有数据
    self.coList = {}
    self.isReviewPrologue = false


end

function MediumPtMainDialog:__delete()
    self.plotMap = nil
    self.coList = nil
    self.isReviewPrologue = nil

    self.controller = nil
end

function MediumPtMainDialog:Awake()
    CriWareUtils.PlayMusicById(BGM)
    self.EventPlot = Events.AddListener(Constants.EventNames.MediumPtMainPlot, Bind(self, self.FreshBaseUI))
    self.EventPlotPlay = Events.AddListener(Constants.EventNames.IsPlotPlaying, Bind(self, self.PlotPlaying))
    GameUtils.BindRedPoint(Constants.RedPointConst.MediumPTReward, self.BtnReward, true)

end

function MediumPtMainDialog:FreshRedPoint()
    GameUtils.SetRedPointNum(Constants.RedPointConst.MediumPTReward, 0)
    for i, v in pairs(MediumPTActivityComponent.rewardsInfo) do
        if checkNumber(v.status) == Constants.GetStatus.Can then
            GameUtils.SetRedPointNum(Constants.RedPointConst.MediumPTReward, 1)
            break
        end
    end
end

function MediumPtMainDialog:PlotPlaying(isPlotPlaying)
    KTool.SetActive(URPCameraController.mainCamera, not isPlotPlaying)
    KTool.SetActive(self.controller.gameObject, not isPlotPlaying)
    if isPlotPlaying then
        --CriWareUtils.StopById(BGM)


    else
        CriWareUtils.PlayMusicById(BGM)
        local percent = math.floor(self:GetPlotProgress() * 100 + 0.5)
        local isCompleted = percent >= 100
        local plotQuest =  MediumPTActivityComponent:GetPlotQuest()--MediumPTActivityComponent.plotQuest
        local isFinalPlotNull = checkNumber(plotQuest["9"]) == 0
        local finalChapter
        local isInReview = MediumPTActivityComponent:IsInReview()
        if isInReview then
            finalChapter = self.FinalChapterfn.transform:Find("FinalChapter")
        else
            finalChapter = self.FinalChapter.transform:Find("FinalChapter")
        end
        local co = cs_coroutine.start(function()
            cs_coroutine.yield_return(Yielders.EndOfFrame)
            if isCompleted and isFinalPlotNull then
                if not self.isReviewPrologue then --屏蔽
                    CfUtils.PlayAnimator(finalChapter, "Unlocking")
                else
                    CfUtils.PlayAnimator(finalChapter, "Memory")
                end
                self.isReviewPrologue = false

            else
                CfUtils.PlayAnimator(finalChapter, isCompleted and "Memory" or "Idle")
            end
        end)
        table.insert(self.coList, co)
    end
end

function MediumPtMainDialog:OnFocus(focus)
    if focus then
        CfUtils.RefreshTopGoods({
            Constants.Currency.HpId,
            9000045,
            9000046
        })
    end
end

function MediumPtMainDialog:InitPlotData()
    local currentActivityId = checkNumber(MediumPTActivityComponent.activityConf.id)
    local vo = CfUtils.GetWholeVo(AutoIds.IdSetting2553, "MediumPTPlotVo")
    for i, v in pairs(vo) do
        if v.activityId == currentActivityId then
            local pos = checkString(v.pos)
            if not self.plotMap[pos] then
                self.plotMap[pos] = {

                }
            end
            table.insert(self.plotMap[pos], v)
        end
    end
end

function MediumPtMainDialog:GetPlotProgress()
    local plotQuest =  MediumPTActivityComponent:GetPlotQuest()--MediumPTActivityComponent.plotQuest
    local current = 0
    local total = 0
    for k, v in pairs(self.plotMap) do
        if not (k == "8" or k == "9") then--排除序章终章
            total = total + table.count(v)
            if not isNull(plotQuest[k]) then
                for i, b in pairs(v) do
                    if checkNumber(b.id) == checkNumber(plotQuest[k]) then
                        current = current + i
                    end
                end
            end
        end
    end
    --print(current.."------"..total)
    local progress = current/total
    return progress
end

function MediumPtMainDialog:FreshBaseUI()
    local plotQuest = MediumPTActivityComponent:GetPlotQuest()--MediumPTActivityComponent.plotQuest
    --print("----->>"..table.dump(plotQuest))
    local finalId =  MediumPTActivityComponent.activityConf.storyEndId
    local isPassAllFinalPlot = checkNumber(plotQuest["9"]) == checkNumber(finalId)
    local isInReview = MediumPTActivityComponent:IsInReview()
    if isInReview and isPassAllFinalPlot then--剧情回顾完成自动退出
        MediumPTActivityComponent.isInReview = false
        MediumPTActivityComponent:ResetReviewData()
        plotQuest = MediumPTActivityComponent:GetPlotQuest()
        isPassAllFinalPlot = checkNumber(plotQuest["9"]) == checkNumber(finalId)
        isInReview = MediumPTActivityComponent.isInReview
    end
    local isGetFinalRewards = MediumPTActivityComponent.isDrawPlotRewards == Constants.GetStatus.Has

    KTool.SetActive(self.CgEnd, isPassAllFinalPlot)
    KTool.SetActive(self.Normal, (not isPassAllFinalPlot) and (not isInReview))
    KTool.SetActive(self.Final, (not isPassAllFinalPlot) and isInReview)
    --KTool.SetActive(self.FinalChapter, not isInReview)
    --KTool.SetActive(self.FinalChapterfn, isInReview)
    --KTool.SetActive(self.ActivityTimeGroup, not isInReview)
    KTool.SetActive(self.ReviewGroup, isInReview)
    KTool.SetActive(self.BtnReview, isGetFinalRewards)
    CfUtils.SetUISwitchText(self.BtnReview.transform:Find("Text"), isInReview and 2 or 1)
    CfUtils.SetUISwitchImage(self.BtnReview.transform:Find("ImgIcon"), isInReview and 2 or 1)
    local percent = math.floor(self:GetPlotProgress() * 100 + 0.5)
    local isCompleted = percent >= 100
    local co = cs_coroutine.start(function()
        cs_coroutine.yield_return(Yielders.EndOfFrame)
        if isInReview then
            KTool.SetActive(self.ReviewCompleted, isCompleted)
            KTool.SetActive(self.ReviewUnderway, not isCompleted)
            self.TextNumberProgressfn.text = string.format("%s<size=22>%%</size>", checkNumber(percent))
            CfUtils.PlayAnimator(self.FinalChapterfn.transform:Find("FinalChapter"), isCompleted and "Memory" or "Idle")
        else
            KTool.SetActive(self.ReviewCompleted, false)
            KTool.SetActive(self.ReviewUnderway, false)
            self.TextNumberProgress.text = string.format("%s<size=22>%%</size>", checkNumber(percent))
            CfUtils.PlayAnimator(self.FinalChapter.transform:Find("FinalChapter"), isCompleted and "Memory" or "Idle")
        end
    end)
    table.insert(self.coList, co)
    local curTime = os.time()
    local isEnd = MediumPTActivityComponent:IsEnd()
    KTool.SetActive(self.ActivityCloseNode, isEnd)
    KTool.SetActive(self.PtcChallenge, not isEnd)
    KTool.SetActive(self.ImgPoint, not isEnd)
    CfUtils.SetUISwitchImage(self.ImgIcon, isEnd and 2 or 1)

    if isEnd then
        self.TextTimeClose.text = StoreUtils.FormatTime(MediumPTActivityComponent.activityPlotQuest.closeTime - curTime, true)
        --self.TextTimeClose.text = CfUtils.GetTimeHMS4(MediumPTActivityComponent.activityPlotQuest.closeTime - curTime)
    end
    --if not isGetFinalRewards then
        --local curTime = os.time()
        local startTime =  MediumPTActivityComponent.activityPlotQuest.startTime
        local endTime =  MediumPTActivityComponent.activityPlotQuest.endTime
        CfUtils.FillText(self.TextTime.transform, os.date("%Y.%m.%d", startTime).." 5:00:00 ~ "..os.date("%Y.%m.%d", endTime).." 4:59:59")
        --self.TextTime.text = CfUtils.GetTimeHMS4(MediumPTActivityComponent.activityPlotQuest.closeTime)
    --end



    --print("plotQuest------->>"..table.dump(plotQuest, nil, 3))
    --print("plotMap------->>"..table.dump(self.plotMap, nil, 3))
    self:SetButtonClickAction()
    for pos, list in pairs(self.plotMap) do
        --print("pppppp=======>>"..pos)
        local plotId
        if pos == "8" then--序章
            local prologueId = self.plotMap[pos][1].id
            if not (checkNumber(plotQuest[pos]) == prologueId) then--未通过序章
                if isInReview then
                    MediumPTActivityComponent:EnterPlotNoReq(pos, prologueId)
                else
                    MediumPTActivityComponent:EnterPlot(pos, prologueId, nil, function ()
                        self:FreshBaseUI()
                    end)
                end
            end
        elseif pos == "9" then--终章
            SetButtonAction(self.BtnChapterEnd, function ()
                self:FinalRewardPrepare()
            end)
            SetButtonAction(self.FinalChapterfn, function ()
                self:FinalRewardPrepare()
            end)
            SetButtonAction(self.FinalChapter, function ()
                self:FinalRewardPrepare()
            end)
            if isInReview then
                
            else
                local notGet = MediumPTActivityComponent.isDrawPlotRewards ~= Constants.GetStatus.Has
                local finalId =  MediumPTActivityComponent.activityConf.storyEndId
                if notGet then
                    if checkNumber(plotQuest[pos]) == checkNumber(finalId) then--终章数据不为空，但不是最后
                        local activityUuid = MediumPTActivityComponent.activityPlotQuest.activityUuid
                        GameUtils.Request(
                                Interfaces.ActivityPlotQuestPlotDrawReward,
                                { activityUuid = activityUuid },
                                function(request, response)
                                    if checkInt(response.errCode) == 0 then
                                        MediumPTActivityComponent.isDrawPlotRewards = Constants.GetStatus.Has
                                        GoodsUtils.DrawRewards(response.data.rewards,true)
                              --[[          ----刷新货币栏
                                        GameUtils.UpdateNavBarShowGoods({
                                            Constants.Currency.HpId,
                                            9000045,
                                            9000046
                                        })]]
                                        --打开通用获取UI
                                        UIModule.OpenDialog(
                                                {
                                                    id = Constants.UITypeIds.UICommonRewardPop,
                                                    parameters = { rewards = response.data.rewards }
                                                }
                                        )
                                        self:FreshBaseUI()
                                    end
                                end
                        )

                    end
                end
            end

            --if canGet then
            --    if not plotQuest[pos] then--终章数据为空
            --        plotId = self.plotMap[pos][1].id
            --        SetButtonAction(self.FinalChapter, function ()
            --            MediumPTActivityComponent:EnterPlot(pos, plotId, nil, function ()
            --                self:FreshBaseUI()
            --            end)
            --        end)
            --    else
            --        if plotQuest[pos] ~= finalId then--终章数据不为空，但不是最后
            --            plotId = plotQuest[pos] + 1
            --            SetButtonAction(self.FinalChapter, function ()
            --                MediumPTActivityComponent:EnterPlot(pos, plotId, nil, function ()
            --                    if plotId == finalId then
            --                        GameUtils.Request(
            --                                Interfaces.ActivityPlotQuestPlotDrawReward,
            --                                { activityUuid = self.activityPlotQuest.activityUuid },
            --                                function(request, response)
            --                                    if checkInt(response.errCode) == 0 then
            --                                        MediumPTActivityComponent.isDrawPlotRewards = Constants.GetStatus.Has
            --                                        GoodsUtils.DrawRewards(response.data.rewards)
            --                                        ----刷新货币栏
            --                                        --GameUtils.UpdateNavBarShowGoods({
            --                                        --    Constants.Currency.HpId,
            --                                        --    Constants.Currency.GoldId,
            --                                        --    Constants.Currency.FreeDiamondId,
            --                                        --})
            --                                        --打开通用获取UI
            --                                        UIModule.OpenDialog(
            --                                                {
            --                                                    id = Constants.UITypeIds.UICommonRewardPop,
            --                                                    parameters = { rewards = response.data.rewards }
            --                                                }
            --                                        )
            --                                        self:FreshBaseUI()
            --                                    end
            --                                end
            --                        )
            --                    end
            --                end)
            --            end)
            --        else
            --            --SetButtonAction(self.FinalChapter, function ()
            --            --    GameUtils.Toast(localize("打开奖励"))
            --            --    --todo 打开奖励界面
            --            --
            --            --end)
            --
            --        end
            --    end
            --else

            --end
        else--角色入口
            local plotLuaIndex
            local roleGoName = "ImgRole"..pos
            if isInReview then
                roleGoName = roleGoName.."fn"
            end
            if not plotQuest[pos] then--当前入口通关数据为空
                --plotData = self.plotMap[pos][1]
                plotLuaIndex = 1
            else
                plotId = plotQuest[pos] + 1--初值默认到下一关
                for i, v in pairs(list) do
                    if checkNumber(v.id) == plotId then
                        --plotData = v
                        plotLuaIndex = i
                    end
                    if checkNumber(plotQuest[pos]) == checkNumber(v.id) then
                        if v.endFlag == 1 then
                            --plotId = plotQuest[pos]
                            --plotData = v
                            plotLuaIndex = i
                            break
                        end
                    end
                end
            end
            self:FreshRoleNode(self[roleGoName], plotLuaIndex, list, pos)

        end
    end

end

function MediumPtMainDialog:SetButtonClickAction()
    SetButtonAction(self.BtnStore, function ()
        local activityUuid = MediumPTActivityComponent.activityPlotQuest.activityUuid
        CfUtils.DialogOpen(Constants.UITypeIds.UIActivityCommonShopDialog, { activityUuid = activityUuid , topGoods = { 9000046} },
                {{ id = Constants.UITypeIds.MediumPtMainDialog}}
        )



--[[        StoreUtils.OpenVarietyStore(
                StoreConstants.OpenIds.PT_2,
                {
                    { id = Constants.UITypeIds.MediumPtMainDialog },
                },
                {activityUuid = activityUuid, activityType = ActivityConstants.ActivityType.PTMedium}
        )]]
    end)

    SetButtonAction(self.BtnExplain, function ()
        local activityConf = MediumPTActivityComponent.activityConf
        CfUtils.ShowModuleToast(activityConf.ruleId)
    end)

    SetButtonAction(self.BtnReview, function ()
        local isInReview = MediumPTActivityComponent:IsInReview()
        if isInReview then--退出
            MediumPTActivityComponent.isInReview = false
            MediumPTActivityComponent:ResetReviewData()
            self:FreshBaseUI()
        else
            MediumPTActivityComponent.isInReview = true
            self:FreshBaseUI()
        end

    end)

    SetButtonAction(self.BtnReward, function ()
        UIModule.OpenDialog(
                { id = Constants.UITypeIds.CommonActivityListDialog,
                parameters = { isShowCV = false }
                
                  --parameters = {
                  --    plotLuaIndex = plotLuaIndex,
                  --    plotDataList = plotDataList,
                  --    pos = pos,
                  --}
                },
                {
                    {id = Constants.UITypeIds.MediumPtMainDialog},
                    --{id = Constants.UITypeIds.ForgingChallengePopup},
                }
        )
    end)

    SetButtonAction(self.ActivityTimeGroup, function ()
        self.isReviewPrologue = true
        --print("---->>click")
        MediumPTActivityComponent:EnterPlotNoReq("8", self.plotMap["8"][1].id)
    end)

    SetButtonAction(self.BtnChallenge, function ()
        local isEnd = MediumPTActivityComponent:IsEnd()
        if isEnd then
            GameUtils.Toast(localize("活动已结束"))
            return
        end
        local time = CfUtils.GetAnimatorTime(self.UIFX_MediumPt_Memory, "MediumPt_Memory_1")
        --print("========>>"..time)
        cs_coroutine.start(function()
            UIRaycastBlocker:AddCondition("MediumPtMainDialogBtnChallenge")
            CfUtils.PlayAnimator(self.UIFX_MediumPt_Memory, "Part1")
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(time-0.2))
            UIModule.OpenDialog(
                    { id = Constants.UITypeIds.MediumPtClearChooseDialog,
                        --parameters = {
                        --    plotLuaIndex = plotLuaIndex,
                        --    plotDataList = plotDataList,
                        --    pos = pos,
                        --}
                    },
                    {
                        --{id = Constants.UITypeIds.MediumPtMainDialog},
                        --{id = Constants.UITypeIds.ForgingDialog},
                        --{id = Constants.UITypeIds.ForgingChallengePopup},
                    }
            )
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.2))
            CfUtils.PlayAnimator(self.UIFX_MediumPt_Memory, "Default")
            UIRaycastBlocker:RemoveCondition("MediumPtMainDialogBtnChallenge")
        end)
        KCookie.Set("MediumPtClearChooseDialogAnimPlay", 1)

    end)

end


function MediumPtMainDialog:FinalRewardPrepare()
    UIModule.OpenDialog({ id = Constants.UITypeIds.MediumPtRewardDialog, parameters = {plotMap = self.plotMap} })
end

function MediumPtMainDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local activityUuid = MediumPTActivityComponent.activityPlotQuest.activityUuid
        cs_coroutine.yield_return(GameUtils.Request(
                Interfaces.ActivityPlotQuestHome,
                { activityUuid = activityUuid },
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        MediumPTActivityComponent:InitHomeData(response.data)
                        Events.Broadcast(Constants.EventNames.MediumPtQuestFresh)
                        self:InitPlotData()
                        --                MediumPTActivityComponent:InitTestFakeData()
                        self:FreshBaseUI()
                        self:FreshRedPoint()
                    end
                end
        ))
    end))
    return coWait
end
function MediumPtMainDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --coroutine.yield(self:Initialize())

    end))
    return coWait
end

function MediumPtMainDialog:FreshRoleNode(gameObject, plotLuaIndex, plotDataList, pos)
    local plotQuest = MediumPTActivityComponent:GetPlotQuest()--MediumPTActivityComponent.plotQuest
    local plotData = plotDataList[plotLuaIndex]
    local isEnd = checkNumber(plotData.id) == checkNumber(plotQuest[pos]) --plotData.endFlag == 1
    --print(pos..tostring(isEnd).."----->>"..table.dump(plotQuest))
    local node = gameObject.transform:Find("Node")
    --local imgEnd = gameObject.transform:Find("ImgEnd")
    local consume = node.transform:Find("Consume")
    local consumeIcon = consume.transform:Find("ImgIcon")
    local consumeText = consume.transform:Find("Text")
    local textDesc = node.transform:Find("TextDesc")
    local roleSpine = gameObject.transform:Find("RoleSpine")
    local roleSpine1 = gameObject.transform:Find("RoleSpine1")
    local co = cs_coroutine.start(function()
        UIRaycastBlocker:AddCondition("MediumPtMainDialogFreshRoleNode")
        local entryName = isEnd and "Win_Entry" or "Entry"
        if roleSpine1 then
            CfUtils.PlaySpine(roleSpine1, entryName, false)
        end
        CfUtils.PlaySpine(roleSpine, entryName, false)
        local waitTime = CfUtils.GetSpineTime(roleSpine, entryName)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(waitTime))
        local idleName = isEnd and "Win_Idle" or "Idle"
        CfUtils.PlaySpine(roleSpine, idleName, true)
        if roleSpine1 then
            CfUtils.PlaySpine(roleSpine1, idleName, true)
        end
        UIRaycastBlocker:RemoveCondition("MediumPtMainDialogFreshRoleNode")
    end)
    table.insert(self.coList, co)
    local slider = node.transform:Find("Slider"):GetComponent("Slider")
    slider.value = plotLuaIndex / #plotDataList
    --KTool.SetActive(imgEnd, isEnd)
    KTool.SetActive(node, not isEnd)
    local isNoConsume = checkNumber(plotData.unlockItem) == 0
    KTool.SetActive(consume, checkNumber(plotData.unlockItem) == 0)
    if not isNoConsume then
        local currencyVo = GoodsConfMgr:GetGoodsVoById(plotData.unlockItem)
        CfUtils.FillImage(consumeIcon, currencyVo.photoPath)
        CfUtils.FillText(consumeText, plotData.unlockNum)
    end
    CfUtils.FillText(textDesc, plotData.plotDesc)
    SetButtonAction(node, function ()
        if not isEnd then
            UIModule.OpenDialog(
                    { id = Constants.UITypeIds.MediumPtUnlockDialog,
                      parameters = {
                          plotLuaIndex = plotLuaIndex,
                          plotDataList = plotDataList,
                          pos = pos,
                      }
                    },
                    {
                        --{id = Constants.UITypeIds.ForgingDialog},
                        --{id = Constants.UITypeIds.ForgingChallengePopup},
                    }
            )
        end
    end)
end

function MediumPtMainDialog:DisposeCo()
    for k, v in pairs(self.coList) do
        if not isNull(v) then
            cs_coroutine.stop(v)
        end
    end
end

function MediumPtMainDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:DisposeCo()
        Events.RemoveListener(Constants.EventNames.MediumPtMainPlot, self.EventPlot)
        Events.RemoveListener(Constants.EventNames.IsPlotPlaying, self.EventPlotPlay)
        GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.MediumPTReward)

        --CriWareUtils.StopById(BGM)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return MediumPtMainDialog
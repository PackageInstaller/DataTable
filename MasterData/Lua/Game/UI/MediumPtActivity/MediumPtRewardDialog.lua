---
--- Created by Eric.
--- DateTime: 2022/6/14 10:43
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local MediumPTActivityComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MediumPTActivityComponent)

------------ import ------------

------------ define ------------
local pos = "9"
------------ define ------------


--- from: Assets/BundleResources/Prefabs/MediumPt/MediumPtRewardDialog.prefab
---@class MediumPtRewardDialog
---@field Env                           	MediumPtRewardDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field SelectReward                  	UnityEngine.RectTransform
---@field NotSelectReward               	UnityEngine.RectTransform
---@field CommonBtnConsumePop           	UnityEngine.RectTransform
---@field TextDesc                      	UnityEngine.UI.Text
---@field TextNumber                    	TMPro.TextMeshProUGUI
---@field Select                        	UnityEngine.RectTransform
---@field NotSelect                     	UnityEngine.RectTransform
---@field ImgPoint2                     	UnityEngine.RectTransform
---@field ImgPoint1                     	UnityEngine.RectTransform
---@field ProgressGroup                 	UnityEngine.RectTransform
---@field BtnUnlockGroup                	UnityEngine.RectTransform
---@field RewardGroup                   	UnityEngine.RectTransform
---@field CommonGoodsList               	UnityEngine.RectTransform
---@field TittleDialog                  	UnityEngine.UI.Text
---@field TxtTittle                     	UnityEngine.UI.Text
---@field BtnClose                      	UnityEngine.RectTransform
local MediumPtRewardDialog = Class("MediumPtRewardDialog")
function MediumPtRewardDialog:__init()
    self.plotMap = {}
end

function MediumPtRewardDialog:__delete()
    self.plotMap = nil



    self.controller = nil
end

function MediumPtRewardDialog:Awake()
    local parameters = self.controller.Argument.parameters
    if not isNull(parameters) then
        self.plotMap = parameters.plotMap
        --self.plotDataList = parameters.plotDataList
        --self.pos = parameters.pos
        self:FreshBaseUI()
        SetButtonAction(self.BtnClose, function()
            UIModule.BackDialog()
        end)
    end
    self.EventPlotPlay = Events.AddListener(Constants.EventNames.IsPlotPlaying, Bind(self, self.PlotPlaying))


end

function MediumPtRewardDialog:PlotPlaying(isPlotPlaying)
    KTool.SetActive(self.controller.gameObject, not isPlotPlaying)
end

function MediumPtRewardDialog:FreshBaseUI()
    local isInReview = MediumPTActivityComponent:IsInReview()
    local finalId =  MediumPTActivityComponent.activityConf.storyEndId
    local isFinishRolePlot = MediumPTActivityComponent:IsFinishRolePlot()
    local plotQuest = MediumPTActivityComponent:GetPlotQuest()
    print(tostring(isFinishRolePlot).."=======>>"..table.dump(plotQuest))
    local hasGet = checkNumber(plotQuest[pos]) == checkNumber(finalId)

    local isShowUnlockGroup = (not hasGet) and isFinishRolePlot
    --if isInReview then
    --    isShowUnlockGroup = isFinishRolePlot and checkNumber(plotQuest[pos]) ~= checkNumber(finalId)
    --else
    --    isShowUnlockGroup = (not hasGet) and isFinishRolePlot
    --end
    KTool.SetActive(self.ProgressGroup, not isInReview)
    KTool.SetActive(self.RewardGroup, not isInReview)
    KTool.SetActive(self.BtnUnlockGroup, isShowUnlockGroup)
    KTool.SetActive(self.Select, isShowUnlockGroup)
    KTool.SetActive(self.NotSelect, not isShowUnlockGroup)
    --
    --if isInReview then
    --
    --else--非回顾
        KTool.SetActive(self.SelectReward, hasGet)
        KTool.SetActive(self.NotSelectReward, not hasGet)
        CfUtils.SetUISwitchImage(self.ImgPoint1, isShowUnlockGroup and 2 or 1)
        CfUtils.SetUISwitchImage(self.ImgPoint2, hasGet and 2 or 1)
        local rewardEnv = CfUtils.GetLuaScr(self.CommonGoodsList, "Game.Behaviours.CommonGoodsList")
        local activityConf = MediumPTActivityComponent.activityConf
        local rewardsData = activityConf.rewards--parse_rewards(activityConf.rewardItem, activityConf.rewardNum)
        rewardEnv:FreshBaseUI(rewardsData, nil, hasGet, true)
        if isFinishRolePlot then
            --if hasGet then

            --else
                local plotLuaIndex
                local plotId
                local list =  self.plotMap[pos]
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
                local plotData = clone(list[plotLuaIndex])
                if isInReview then
                    plotData.unlockItem = 0
                end
                --self.NowNumber.text = self.plotLuaIndex
                --self.MaxNumber.text = #self.plotDataList
                local text = hasGet and localize("剧情已全部完成") or plotData.plotDesc
                CfUtils.FillText(self.TittleDialog ,text)
                self.TextNumber.text = string.format("<color=#606060>%s</color>/%s", plotLuaIndex, #list)
                local isNoConsume = checkNumber(plotData.unlockItem) == 0
                KTool.SetActive(self.CommonBtnConsumePop, not isNoConsume)
                if not isNoConsume then
                    CfUtils.FillCommonBtnConsumePopNode(self.CommonBtnConsumePop.gameObject, plotData.unlockItem, checkNumber(plotData.unlockNum))
                end
                SetButtonAction(self.BtnUnlockGroup.transform:Find("BtnAnimation"), function()
                    local isEnd = MediumPTActivityComponent:IsEnd()
                    if isEnd then
                        GameUtils.Toast(localize("活动已结束"))
                        return
                    end

                    local canUnlock
                    if isNoConsume then
                        canUnlock = true
                    else
                        local hasNum = GoodsUtils.GetThingNo(plotData.unlockItem)
                        canUnlock = hasNum >= checkNumber(plotData.unlockNum)
                    end
                    if canUnlock then
                        if isInReview then
                            MediumPTActivityComponent:EnterPlotNoReq(pos, plotData.id, function ()
                                Events.Broadcast(Constants.EventNames.MediumPtMainPlot)
                            end ,
                                    function ()
                                        UIModule.BackDialog()
                                    end)
                        else
                            MediumPTActivityComponent:EnterPlot(pos, plotData.id, function ()
                                if not isNoConsume then
                                    GoodsUtils.ConsumeGoods({
                                        {
                                            goodsId = plotData.unlockItem,
                                            goodsNum = plotData.unlockNum
                                        }
                                    })
                                end
                            end ,
                                    function ()
                                        Events.Broadcast(Constants.EventNames.MediumPtMainPlot)
                                        UIModule.BackDialog()
                                    end)
                        end
                    else
                        local currencyVo = GoodsConfMgr:GetGoodsVoById(plotData.unlockItem)
                        GameUtils.Toast(localize("_name_不足",{_name_ = currencyVo.name}))
                    end
                end)

            --end
        
        else
            local plotLuaIndex
            local plotId
            local list =  self.plotMap[pos]
            if not plotQuest[pos] then--当前入口通关数据为空
                plotLuaIndex = 1
            else
                plotId = plotQuest[pos] + 1--初值默认到下一关
                for i, v in pairs(list) do
                    if checkNumber(v.id) == plotId then
                        plotLuaIndex = i
                    end
                    if checkNumber(plotQuest[pos]) == checkNumber(v.id) then
                        if v.endFlag == 1 then
                            plotLuaIndex = i
                            break
                        end
                    end
                end
            end
            local plotData = clone(list[plotLuaIndex])
            if isInReview then
                plotData.unlockItem = 0
            end
            local text = hasGet and localize("剧情已全部完成") or plotData.plotDesc
            CfUtils.FillText(self.TittleDialog ,text)
        end

    --end




end

function MediumPtRewardDialog:OnFocus(focus)
end

function MediumPtRewardDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function MediumPtRewardDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.IsPlotPlaying, self.EventPlotPlay)

        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return MediumPtRewardDialog
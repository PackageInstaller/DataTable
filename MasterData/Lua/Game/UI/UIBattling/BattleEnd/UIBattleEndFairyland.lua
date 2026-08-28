---
--- 乱流幻境战斗结算界面进度
--- Author: dawanfan
--- Date: 2024-1-23 11:43:12
---


local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local Time = CS.UnityEngine.Time
local cs_coroutine = require("XLua.cs_coroutine")
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")
local Yielders = CS.Engine.Lib.Yielders
local UIModule = CS.Engine.UI.UIModule
local Vector2 = CS.UnityEngine.Vector2

--- from: Assets/BundleResources/Prefabs/UIBattling/BattleEnd/UIBattleEndActionFairyland.prefab > name: UIBattleEndActionFairyland
---@class UIBattleEndFairyland
---@field Env                           	UIBattleEndFairyland                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ProgressRewardGroup           	UnityEngine.RectTransform               
---@field Slilder                       	UnityEngine.RectTransform               
---@field RewardProgressText            	UnityEngine.RectTransform               
local UIBattleEndFairyland = Class("UIBattleEndFairyland")

function UIBattleEndFairyland:__init()
    self.progressRewardsScr = {}
    self.progress = 0
end

function UIBattleEndFairyland:__delete()
    self.progressRewardsScr = {}
    self.progress = 0
end

function UIBattleEndFairyland:Awake()
    
end

function UIBattleEndFairyland:Start()
    
end

function UIBattleEndFairyland:OnDestroy()
    
end

function UIBattleEndFairyland:Initialization()
    local data = BattleEndMgr.showData.response
    if IsNull(data) then
        return
    end

    ---@type FairylandQuestRewardsVo[]
    self.questProgressRewardVo = FairylandUtils.GetQuestProgressRewardVos(FairylandUtils.CurrentEnterQuestId) --CfUtils.GetCfVo(AutoIds.IdSetting6161, "FairylandQuestRewardsVo", FairylandUtils.CurrentEnterQuestId)


    ---@type FairylandComponent
    local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
    self.progress = FairylandComponent.dojo:GetRewardProgress()
    if BattleEndMgr.showData.isPassed then
        self.progress = self.progress - 1
    end

    for i = 1, 3 do
        local rewardItemGo = self.ProgressRewardGroup.transform:Find("RewardItem" .. i)
        if self.questProgressRewardVo[i] ~= nil then
            CfUtils.SetActive(rewardItemGo, true)
            self.progressRewardsScr[i] = CfUtils.GetLuaScr(rewardItemGo, "Game.UI.Fairyland.FairylandSceneProgressRewardItem")
            self.progressRewardsScr[i]:Init(i)
            self.progressRewardsScr[i]:Refresh(self.progress)
        else
            CfUtils.SetActive(rewardItemGo, false)
        end
    end

    if #self.progressRewardsScr == 2 then
        self.progressRewardsScr[1].controller.transform.anchoredPosition = Vector2(65, 18.5)
        self.progressRewardsScr[2].controller.transform.anchoredPosition = Vector2(315, 18.5)
    end

    CfUtils.FillText(self.RewardProgressText, string.format("<color=#ffffff><size=50>%s</color></size>/%s", self.progress, self.questProgressRewardVo[#self.questProgressRewardVo].progress))
    CfUtils.SetSliderPercent(self.Slilder, self.progress / self.questProgressRewardVo[#self.questProgressRewardVo].progress)

end

function UIBattleEndFairyland:ShowFairylandProgressReward()

    local takedRewardNum = 0
    for _, vo in pairs(self.questProgressRewardVo) do
        if self.progress >= vo.progress then
            takedRewardNum = takedRewardNum + 1
        end
    end

    ---@type FairylandComponent
    local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
    local targetProgress = FairylandComponent.dojo:GetRewardProgress()
    local totalProgress = self.questProgressRewardVo[#self.questProgressRewardVo].progress

    local time = 0
    local targetTime = 0.5
    local percent = self.progress / totalProgress
    while time < targetTime do
        cs_coroutine.yield_return()
        time = time + Time.deltaTime
        self.progress = self.progress + (targetProgress - self.progress) * time / targetTime
        percent = self.progress / totalProgress

        CfUtils.SetSliderPercent(self.Slilder, percent)
    end

    self.progress = targetProgress
    CfUtils.SetSliderPercent(self.Slilder, self.progress / totalProgress)
    CfUtils.FillText(self.RewardProgressText, string.format("<color=#ffffff><size=50>%s</color></size>/%s", targetProgress, totalProgress))

    --- 有新的
    if self.questProgressRewardVo[takedRewardNum + 1] and self.questProgressRewardVo[takedRewardNum + 1].progress <= self.progress then
        self.progressRewardsScr[takedRewardNum + 1]:SetState(ConstantsFairyland.ProgressRewardState.CanTake)

        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))

        GameUtils.ShowDialogAndYield({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = BattleEndMgr:GetBattleEndRewardsList() } })

        self.progressRewardsScr[takedRewardNum + 1]:SetState(ConstantsFairyland.ProgressRewardState.Taked)
    end

end


return UIBattleEndFairyland

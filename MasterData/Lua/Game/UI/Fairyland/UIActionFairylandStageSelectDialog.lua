---
--- 乱流幻境进入界面
--- Author: dawanfan
--- Date: 2024-1-11 14:12:02
---

local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = import('XLua.cs_coroutine')

local UIModule = CS.Engine.UI.UIModule
---@type FairylandComponent
local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
local DreamlandUtils = import('Game.UI.FightReady.UIDreamland.DreamlandUtils')
local Yielders = CS.Engine.Lib.Yielders
local cs_coroutine = import('XLua.cs_coroutine')
local KCookie = CS.Engine.Lib.KCookie
local UICommonUtils    = UICommonUtils

local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")
local CountDownTime = 2592000 --30 * 86400 30天的秒数
local CDTimerModule = CS.Engine.Modules.CDTimerModule

local UIActionFairylandStageSelectDialogNodeScriptPath = "Game.UI.Fairyland.UIActionFairylandStageSelectDialogNode"

--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandStageSelectDialog.prefab > name: ActionFairylandStageSelectDialog
---@class UIActionFairylandStageSelectDialog
---@field Env                           	UIActionFairylandStageSelectDialog      
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ButtonGiveUp                  	UnityEngine.RectTransform               	@ 0    
---@field EnterText                     	UnityEngine.RectTransform               	@ 1    
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 2    
---@field ChallengeRewards              	UnityEngine.RectTransform               	@ 3    
---@field ProgressRewards               	UnityEngine.RectTransform               	@ 4    
---@field ConsumeImage                  	UnityEngine.RectTransform               	@ 5    
---@field ConsumeText                   	UnityEngine.RectTransform               	@ 6    
---@field ButtonGo                      	UnityEngine.RectTransform               	@ 7    
---@field LoopList                      	SuperScrollView.LoopListView2           	@ 8    
---@field TextQuestDescription          	UnityEngine.RectTransform               	@ 9    
---@field ScrollRectGoods1              	UnityEngine.RectTransform               	@ 10   
local UIActionFairylandStageSelectDialog = Class("UIActionFairylandStageSelectDialog")

function UIActionFairylandStageSelectDialog:__init()
    self._currentSelectedIndex = -1
    self._fairylandQuestVos = nil
end

function UIActionFairylandStageSelectDialog:__delete()
    self._currentSelectedIndex = -1
end

function UIActionFairylandStageSelectDialog:Awake()
    SetButtonAction(self.ButtonGo, Bind(self, self.OnBtnGoClick))
    SetButtonAction(self.ButtonGiveUp, Bind(self, self.OnBtnGiveUpClick))
end

function UIActionFairylandStageSelectDialog:OnFocus(focus) end

function UIActionFairylandStageSelectDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FillSelf()
    end))
    return coWait
end

function UIActionFairylandStageSelectDialog:OnInitialize()
    
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()
                self:InitData()
                self:StartTimeDown()

                coroutine.yield(Yielders.EndOfFrame)

            end
        )
    )

    return coWait
end

function UIActionFairylandStageSelectDialog:InitData()
    self._fairylandQuestVos = CfUtils.GetCf(AutoIds.IdSetting6160, "FairylandQuestVo", true)
    -- 获取初始选中标签
    self._currentSelectedIndex = 0
    if FairylandUtils.CurrentEnterQuestId > 0 then
        for index, fairylandVo in ipairs(self._fairylandQuestVos) do
            if fairylandVo.id == FairylandUtils.CurrentEnterQuestId then
                self._currentSelectedIndex = index - 1
                break
            end
        end
    end
end

function UIActionFairylandStageSelectDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:ClearTimeDown()
        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function UIActionFairylandStageSelectDialog:FillSelf()
    self:RefreshLoopList()
    self:RefreshQuestInfo()
end

function UIActionFairylandStageSelectDialog:RefreshQuestInfo()
    local fairylandQuestVo = self._fairylandQuestVos[self._currentSelectedIndex + 1]
    local secretInfo = FairylandComponent.dojo.secretInfo[fairylandQuestVo.id]
    
    if secretInfo.status == ConstantsFairyland.QuestStatus.Close then
        CfUtils.SetActive(self.ButtonGiveUp, false)
        CfUtils.SetActive(self.CommonBtnConsumePop, true)
        CfUtils.FillCommonBtnConsumePopNode(self.CommonBtnConsumePop, secretInfo.consume[1].goodsId, secretInfo.consume[1].num)
        CfUtils.FillText(self.EnterText, localize("进入副本"))
    else
        CfUtils.SetActive(self.ButtonGiveUp, true)
        CfUtils.SetActive(self.CommonBtnConsumePop, false)
        CfUtils.FillText(self.EnterText, localize("继续副本"))
    end

    CfUtils.FillCfText(self.TextQuestDescription, self._fairylandQuestVos[self._currentSelectedIndex + 1].story)
    self:RefreshRewards()
end

function UIActionFairylandStageSelectDialog:RefreshRewards()
    local fairylandQuestVo = self._fairylandQuestVos[self._currentSelectedIndex + 1]
    local secretInfo = FairylandComponent.dojo.secretInfo[fairylandQuestVo.id]
    self.ScrollRectGoods1.enabled = #secretInfo.showProgressRewards > 3
    UICommonUtils.FillCommonGoodsListLight(self.ProgressRewards, secretInfo.showProgressRewards, false, false, true, false, true) 
    UICommonUtils.FillCommonGoodsListLight(self.ChallengeRewards, secretInfo.showChallengeRewards, false, false, true, false, true) 
end

function UIActionFairylandStageSelectDialog:RefreshLoopList()
    if not self._isInit then
        self.LoopList:InitListView(1, Bind(self, self.OnRefreshPlaceIndex))
        self._isInit = true
    else
        GameUtils.ReloadData(self.LoopList, 1)
    end
end

---@param listView SuperScrollView.LoopListView2
---@param index number
---@param row number
---@param column number
function UIActionFairylandStageSelectDialog:OnRefreshPlaceIndex(listView, index, row, column)
    if index < 0 then
        return nil
    end

    local cell = listView:NewListViewItem("Cell")
    local data = {
        index = index,
        input = self._fairylandQuestVos[index + 1]
    }
    local scr = CfUtils.GetLuaScr(cell, UIActionFairylandStageSelectDialogNodeScriptPath)
    if scr then
        scr:Refresh(data, self._currentSelectedIndex, function (index)
            self:OnSelectQuest(index)
        end)
    else
        printError(string.format("[UI][UIActionFairylandEntryDialog][OnRefreshPlaceIndex] lua script %s not found", UIActionFairylandStageSelectDialogNodeScriptPath))
    end

    return cell
end

function UIActionFairylandStageSelectDialog:OnSelectQuest(index)
    if index < 0 then
        return
    end

    if self._currentSelectedIndex >= 0 then
        local go = self.LoopList:GetShownItemByItemIndex(self._currentSelectedIndex)
        if go then
            local scr = CfUtils.GetLuaScr(go, UIActionFairylandStageSelectDialogNodeScriptPath)
            if scr then
                scr:Select(false)
            end
        end
    end
    
    local go = self.LoopList:GetShownItemByItemIndex(index)
    if go then
        self._currentSelectedIndex = index
        local scr = CfUtils.GetLuaScr(go, UIActionFairylandStageSelectDialogNodeScriptPath)
        if scr then
            scr:Select(true)
        end
    end

    self:RefreshQuestInfo()
end


function UIActionFairylandStageSelectDialog:OnBtnGoClick()
    local fairylandQuestVo = self._fairylandQuestVos[self._currentSelectedIndex + 1]
    local secretInfo = FairylandComponent.dojo.secretInfo[fairylandQuestVo.id]

    if secretInfo == nil then
        return
    end

    if secretInfo.status == ConstantsFairyland.QuestStatus.Close then
        FairylandComponent:RequestEnterQuest(fairylandQuestVo.id)
        
    else
        UIModule.AddUIPage({ id = Constants.UITypeIds.UIActionFairylandStageSelectDialog})
        FairylandUtils.CurrentEnterQuestId = fairylandQuestVo.id
    
        -- GameUtils.OpenLoadingPanel(
        --     UIArgs(Constants.UITypeIds.FairylandSceneEnter, nil),
        --     {}, Constants.LoadingType.Others, false
        -- )
        FairylandUtils.EnterFairylandScene({questId=fairylandQuestVo.id})
    end
end

function UIActionFairylandStageSelectDialog:OnBtnGiveUpClick()
    local fairylandQuestVo = self._fairylandQuestVos[self._currentSelectedIndex + 1]
    GameUtils.SecondConfirm(localize("是否放弃当前副本进度重头再来？"), function() 
        FairylandComponent:RequestGiveUpQuest(fairylandQuestVo.id, function ()
            self:FillSelf()
            
        end)
    end)

end

function UIActionFairylandStageSelectDialog:ClearTimeDown()
    if not isNull(self._timeDown) then
        CDTimerModule.GetInstance():RemoveCD(self._timeDown)
        self._timeDown = nil
    end
end

function UIActionFairylandStageSelectDialog:StartTimeDown()
    self:ClearTimeDown()
    local maxNum = checkNumber(FairylandComponent:GetConfigParamsById(ConstantsFairyland.ParameterKey.TICKET_LIMIT))
    self._timeDown = CDTimerModule.GetInstance():AddCD(1, function(count, id)
        if FairylandComponent.dojo.hpData.hp < maxNum then
            FairylandComponent.dojo.hpData.lastCdTime = FairylandComponent.dojo.hpData.lastCdTime - 1
            if FairylandComponent.dojo.hpData.lastCdTime == 0 then
                FairylandComponent.dojo.hpData.hp = FairylandComponent.dojo.hpData.hp + 1
                FairylandComponent.dojo.hpData.lastCdTime = checkNumber(FairylandComponent:GetConfigParamsById(ConstantsFairyland.ParameterKey.TICKET_RECOVER_TIME))
                Events.Broadcast(Constants.EventNames.EveryThingChangeEventName, nil)
            elseif FairylandComponent.dojo.hpData.lastCdTime < 0 then
                FairylandComponent.dojo.hpData.lastCdTime = checkNumber(FairylandComponent:GetConfigParamsById(ConstantsFairyland.ParameterKey.TICKET_RECOVER_TIME))
            end
        else
            FairylandComponent.dojo.hpData.lastCdTime = 0
        end
    end, CountDownTime, false, true)
end

return UIActionFairylandStageSelectDialog

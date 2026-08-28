---
--- Created by Eric.
--- DateTime: 2022/6/14 17:17
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local MediumPTActivityComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MediumPTActivityComponent)
local KCookie = CS.Engine.Lib.KCookie

------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/MediumPt/MediumPtClearChooseDialog.prefab
---@class MediumPtClearChooseDialog
---@field Env                           	MediumPtClearChooseDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextName                      	UnityEngine.UI.Text
---@field ImgEnemy                      	Engine.UI.RawImageAlterable
---@field AnimationRoot                 	UnityEngine.RectTransform
---@field FontStyleButton               	UnityEngine.RectTransform
---@field CommonBtnConsumePop           	UnityEngine.RectTransform
---@field CommonGoodsList               	UnityEngine.RectTransform
---@field Root                          	UnityEngine.RectTransform
---@field ListView                      	SuperScrollView.LoopListView2
local MediumPtClearChooseDialog = Class("MediumPtClearChooseDialog")
function MediumPtClearChooseDialog:__init()
    self.questIds = nil
    self.selectLuaIndex = 0

end

function MediumPtClearChooseDialog:__delete()
    self.questIds = nil
    self.selectLuaIndex = 0

    self.controller = nil
end

function MediumPtClearChooseDialog:Awake()

    self.EventHPChange = Events.AddListener(Constants.EventNames.EveryThingChangeEventName, Bind(self, self.HpUpdate))
    self.EventQuestFresh = Events.AddListener(Constants.EventNames.MediumPtQuestFresh, Bind(self, self.QuestFresh))

    local activityConf = MediumPTActivityComponent.activityConf
    self.questIds = parse_strings(CfUtils.GetIdGroupData(AutoIds.IdSetting2551, activityConf.id, "ids")[1])
    --print("questIds---->>"..table.dump(self.questIds))
    self:SetSelectLevelIndex()

    local activityUuid = MediumPTActivityComponent.activityPlotQuest.activityUuid

    SetButtonAction(self.FontStyleButton, function()
        UIModule.OpenDialog({ id = Constants.UITypeIds.UIFightTeamChoose,
                              parameters = { levelId = self.questIds[self.selectLuaIndex], freeTimesRemain = 0, activityUuid = activityUuid } },
                {
                    { id = Constants.UITypeIds.MediumPtMainDialog },
                    { id = Constants.UITypeIds.MediumPtClearChooseDialog },
                })
    end)
end

function MediumPtClearChooseDialog:QuestFresh()
    self:SetSelectLevelIndex()
    self:FreshBaseUI()

end

function MediumPtClearChooseDialog:HpUpdate(goodsId)
    if goodsId == Constants.Currency.HpId then
        self:OnClickQuest()
    end
end


function MediumPtClearChooseDialog:SetSelectLevelIndex()
    local cacheLevelId = KCookie.Get("MediumPTQuest")
    if cacheLevelId then
        self.selectLuaIndex = checkNumber(table.keyof(self.questIds, checkString(cacheLevelId)))
    else
        for k, v in pairs(self.questIds) do
            local isUnlockQuest = QuestConfMgr:GetInstance():IsUnlockQuest(v)
            if isUnlockQuest then
                self.selectLuaIndex = checkNumber(k)
            end
        end
    end
end

function MediumPtClearChooseDialog:FreshBaseUI()
    local activityConf = MediumPTActivityComponent.activityConf
    self.ImgEnemy:LoadSprite(activityConf.bossIcon)
    self.TextName.text = activityConf.bossName
    if not self.ListView.IsListViewInit then
        self.ListView:InitListView(#self.questIds, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.ListView, #self.questIds)
    end
    self.ListView:MovePanelToItemIndex(self.selectLuaIndex - 1)
end

function MediumPtClearChooseDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local luaIndex = index + 1
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.DailyQuest.DailyQuestCell")
    if nodeEnv then
        local questId = self.questIds[luaIndex]
        nodeEnv:FreshBaseUI({ questId = questId })
        local isSelected = luaIndex == self.selectLuaIndex
        nodeEnv:FreshSelectStatus(isSelected)
        nodeEnv:SetBtnCallBack(function()
            local isUnlockQuest = QuestConfMgr:GetInstance():IsUnlockQuest(questId)
            if isUnlockQuest then
                if luaIndex ~= self.selectLuaIndex then
                    --屏蔽掉重复点击当前选择的toggle
                    nodeEnv:FreshSelectStatus(true)
                    local preNodeGo = self.ListView:GetShownItemByItemIndex(self.selectLuaIndex - 1)
                    if preNodeGo then
                        local preNodeEnv = CfUtils.GetLuaScr(preNodeGo.gameObject, "Game.UI.DailyQuest.DailyQuestCell")
                        preNodeEnv:FreshSelectStatus(false)
                    end
                    self.selectLuaIndex = luaIndex
                    self:OnClickQuest()
                end
            else
                --提示时优先判断主线，未解锁提示文字“通关主线X-X后解锁”
                --主线通关时，判断前一难度，未解锁提示文字“通关前一难度后解锁”
                local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
                local isAchieveCondition1 = QuestConfMgr:GetInstance():IsPassQuest(questVo.unlockRegion)
                if isAchieveCondition1 then
                    GameUtils.Toast(localize("通关前一难度后解锁"))
                else
                    GameUtils.Toast(GameUtils.GetUnlockDescr(Constants.CommonUnlockType.PassQuest, checkString(questVo.unlockRegion)))
                end
                return
            end
        end)
    end
    return cell
end

function MediumPtClearChooseDialog:OnClickQuest()
    local questId = self.questIds[self.selectLuaIndex]
    --local dailyTypeVo = CfUtils.GetCfVo(AutoIds.IdSetting310, "DailyTypeVo", self.type)--日常副本类型表
    --local dailyQuestDojo = dailyQuestComponent:GetDailyQuestDojoByType(self.type)
    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
    --dailyQuestDojo.freeTimesRemain = 0--测试用
    --消耗
    --self.freeTimesRemain = checkNumber(dailyQuestDojo.freeTimesRemain)
    --CfUtils.FillCfText(self.TxtNumber.gameObject, string.format("%d/%d", self.freeTimesRemain, dailyTypeVo.freeTimes))
    --local hasFreeTimes = self.freeTimesRemain > 0
    KTool.SetActive(self.CommonBtnConsumePop, true)
    --if not hasFreeTimes then
        local consumeEnv = CfUtils.GetLuaScr(self.CommonBtnConsumePop, "Game.UI.Common.CommonBtnConsumePop")
        if consumeEnv then
            consumeEnv:RefreshUI(questVo.costItem, questVo.costNum, false)
        end
    --end

    --奖励
    local rewardData = RewardConfMgr:GetInstance():GetTeamShowRewardData(questId)
    if not rewardData then
        return
    end
    local t = {}
    local count = 1
    for i = 1, table.count(rewardData) do
        local data = rewardData[i]
        if data.type == Constants.TeamShowRewardType.StarType then
            --领取过的不显示
            if not QuestConfMgr:GetInstance():IsPassAndCompleteAllCdtQuest(questId) then
                table.insert(t, rewardData[i])
                count = count + 1
            end
        elseif data.type == Constants.TeamShowRewardType.FristType then
            --领取过的不显示
            if not QuestConfMgr:GetInstance():IsPassQuest(questId) then
                table.insert(t, rewardData[i])
                count = count + 1
            end
        else
            table.insert(t, rewardData[i])
            count = count + 1
        end
    end
    local rewardEnv = CfUtils.GetLuaScr(self.CommonGoodsList, "Game.Behaviours.CommonGoodsList")
    rewardEnv:FreshBaseUI(t)
end

function MediumPtClearChooseDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local cacheAnimStatus = KCookie.Get("MediumPtClearChooseDialogAnimPlay")
        local isPlay = false
        if not isNull(cacheAnimStatus) then
            if checkNumber(cacheAnimStatus) == 1 then
                isPlay = true
            end
            if isPlay then
                CfUtils.PlayAnimator(self.AnimationRoot, "Part2")
            end
            KCookie.Set("MediumPtClearChooseDialogAnimPlay")
        end
        self:FreshBaseUI()
        self:OnClickQuest()
    end))
    return coWait
end

function MediumPtClearChooseDialog:OnFocus(focus)
    if focus then
        CfUtils.RefreshTopGoods({
            Constants.Currency.HpId,
            9000045,
            9000046
        })
    end
end

function MediumPtClearChooseDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function MediumPtClearChooseDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.RemoveListener(Constants.EventNames.EveryThingChangeEventName, self.EventHPChange)
        Events.RemoveListener(Constants.EventNames.MediumPtQuestFresh, self.EventQuestFresh)


        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return MediumPtClearChooseDialog
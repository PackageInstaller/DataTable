---
--- Created by Eric.
--- DateTime: 2022/11/14 11:38
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
---@type ActivityUtils
local ActivityUtils = import("Game.Activity.ActivityUtils")
------------ import ------------

------------ define ------------
local CONST_CardCount = 12
local cardCountPerLine = CONST_CardCount/2
------------ define ------------


--- from: Assets/BundleResources/Prefabs/Activity/ActivityTurnOverCards101501.prefab
---@class ActivityTurnOverCards
---@field Env                           	ActivityTurnOverCards
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgIcon                       	UnityEngine.RectTransform
---@field BtnGet                        	UnityEngine.RectTransform
---@field CardCell                      	UnityEngine.RectTransform
---@field CardLine2                     	UnityEngine.RectTransform
---@field CardLine1                     	UnityEngine.RectTransform
---@field TxtIntroduction               	UnityEngine.RectTransform
---@field TxtTime                       	UnityEngine.RectTransform
---@field BtnRoleNameNode               	UnityEngine.RectTransform
---@field BossDrawingNode               	UnityEngine.RectTransform
---@field ImgBgRole                     	UnityEngine.RectTransform
---@field TextPlayExplain               	UnityEngine.RectTransform
local ActivityTurnOverCards = Class("ActivityTurnOverCards")
function ActivityTurnOverCards:__init()
    self.cardNodeMap = {}
    self.isNewTurn = false--新一轮翻牌
    self.data = {}--home数据
    self._data = {}--活动数据
    self.matchIndices = {}--匹配的两个卡牌索引


end

function ActivityTurnOverCards:__delete()
    self.cardNodeMap = nil
    self.isNewTurn = nil
    self.data = nil
    self._data = nil
    self.matchIndices = nil



    self.controller = nil
end



function ActivityTurnOverCards:Awake()

end

function ActivityTurnOverCards:Refresh(data)
    if not data then
        return
    end
    self._data = data
    self.activityData = CfUtils.GetCfVo(AutoIds.IdSetting2837, "FlipCardActivityVo", self._data.activityContentId)
    print("11---->>"..table.dump(self.activityData, nil, 3))

    GameUtils.Request(
            Interfaces.ActivityFlipCardHome,
            {activityUuid = self._data.id},
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    print("---->>"..table.dump(response.data, nil, 3))
                    self.data = response.data
                    self:FreshBaseUI()

                end
            end
    )


    --SetButtonAction(self.BtnEntry, function()
    --    KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self._data.id)
    --
    --end)
end

function ActivityTurnOverCards:GetMatchIndex(id)
    id = checkNumber(id)
    local matchIndex = 0--没有匹配的返回0
    local key = table.keyof(self.data.openedCardIds, id)
    if table.keyof(self.data.openedCardIds, id) ~= nil then
        matchIndex = checkNumber(key)
    end
    return matchIndex
end

function ActivityTurnOverCards:HasOpened(index)
    index = checkString(index)
    return table.haskey(self.data.openedCardIds, index)
end

function ActivityTurnOverCards:HasGet(index)
    local hasGet = false
    index = checkString(index)

    if self:HasOpened(index) then
        local count = 0
        for i, v in pairs(self.data.openedCardIds) do
            if v == self.data.cardIds[index] then
                count = count + 1
            end
        end
        if count >= 2 then
            hasGet = true
        end
    end
    return hasGet
end

function ActivityTurnOverCards:isTargetItemEnough()
    return (GoodsUtils.GetThingNo(self.activityData.consume) >= self.activityData.cost)
end

function ActivityTurnOverCards:FreshBaseUI()
    --region 时间
    local startTime =  self._data.startTime
    local closeTime =  self._data.closeTime
    CfUtils.FillText(self.TxtTime, ActivityUtils.ConventActivityDurationTime(startTime, closeTime))
    --CfUtils.FillText(self.TxtTime, os.date("%Y.%m.%d", startTime).."-"..os.date("%Y.%m.%d  %H:%M", closeTime))
    --endregion


    --region 立绘
    local hasShowCard = self.activityData.rewardImg ~= 0
    KTool.SetActive(self.BossDrawingNode, hasShowCard)
    KTool.SetActive(self.BtnRoleNameNode, hasShowCard)
    KTool.SetActive(self.ImgBgRole, not hasShowCard)
    --endregion

    local titleImgUrl = checkString(self._data.titleImage)
    if string.len(titleImgUrl) > 0 then
        CfUtils.FillWebRawImage(self.ImgTitleName, titleImgUrl)
    end

    local currencyData = GoodsConfMgr:GetGoodsVoById(self.activityData.consume)
    CfUtils.FillText(self.TxtIntroduction, localize("消耗_num_张_name_翻牌1次", {_num_ = self.activityData.cost, _name_ = currencyData.name}));
    CfUtils.FillImage(self.ImgIcon, currencyData.photoPath)
    SetButtonAction(self.BtnGet, function ()
        KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self._data.id)
        UIModule.OpenDialog({ id = Constants.UITypeIds.ActivityTurnOverCardsTaskPopup, parameters = {activityUuid = self._data.id, cb = function (status)
            CfUtils.RefreshTopGoods({ self.activityData.consume })
            self:FreshTaskRedPoint(status)
        end}},

                {
                    --{id = Constants.UITypeIds.UIActivityMainDialog}
                })
    end)

    SetButtonAction(self.TextPlayExplain, function()
        CfUtils.ShowModuleToast(self.activityData.ruleID)
    end)

    self:FreshCard()

end

function ActivityTurnOverCards:FreshCard()
    for i = 1, CONST_CardCount do
        local go = self.cardNodeMap[tostring(i)]
        if isNull(go) then
            local parent = i<=cardCountPerLine and self.CardLine1 or self.CardLine2
            go = CfUtils.InstantiateGo(self.CardCell, parent.gameObject)
            self.cardNodeMap[tostring(i)] = go.gameObject
        end
        local goEnv = CfUtils.GetLuaScr(go, "Game.Activity.TurnOverCards.ActivityTurnOverCardsNode")
        if goEnv then
            local id = self.data.cardIds[checkString(i)]
            local hasOpened = self:HasOpened(i)
            local hasGet = self:HasGet(i)

            if self.isNewTurn then
                if i == CONST_CardCount then
                    self.isNewTurn = false
                end
                CriWareUtils.PlaySe("Audio/UI_General", "ui_pai_close")
                goEnv:PlayCloseAnim()
            else

            end
            goEnv:FreshBaseUI({
                id = id,
                hasOpened = hasOpened,
                hasGet = hasGet,
            })
            goEnv:SetBtnCallBack(function()
                if not hasOpened then
                    local isTargetItemEnough = self:isTargetItemEnough()
                    if isTargetItemEnough then
                        GameUtils.Request(
                                Interfaces.ActivityFlipCardFlipCard,
                                {activityUuid = self._data.id, index = i},
                                function(request, response)
                                    if checkInt(response.errCode) == 0 then
                                        GoodsUtils.DrawRewards({
                                            {
                                                goodsId = self.activityData.consume,
                                                num = -self.activityData.cost,
                                            },
                                        }, true)
                                        UIRaycastBlocker:AddCondition("ActivityTurnOverCards")
                                        cs_coroutine.start(function()
                                            local matchIndex = self:GetMatchIndex(id)
                                            local isMatch = matchIndex ~= 0
                                            if isMatch then
                                                cs_coroutine.yield_return(goEnv:PlayOpenAnim())
                                                local matchGo = self.cardNodeMap[tostring(matchIndex)]
                                                local matchGoEnv = CfUtils.GetLuaScr(matchGo, "Game.Activity.TurnOverCards.ActivityTurnOverCardsNode")
                                                CriWareUtils.PlaySe("Audio/UI_General", "ui_pai_spark")
                                                matchGoEnv:PlayMatchAnim()
                                                cs_coroutine.yield_return(goEnv:PlayMatchAnim())
                                                cs_coroutine.yield_return(Yielders.EndOfFrame)
                                                UIRaycastBlocker:RemoveCondition("ActivityTurnOverCards")
                                                GoodsUtils.DrawRewards(response.data.rewards)
                                                self.isNewTurn = not isNull(response.data.newCardIds)
                                                if self.isNewTurn then
                                                    self.data.cardIds = response.data.newCardIds
                                                    self.data.openedCardIds = {}
                                                end
                                                UIModule.OpenDialog(
                                                        {
                                                            id = Constants.UITypeIds.UICommonRewardPop,
                                                            parameters = { rewards = response.data.rewards, cb = function()
                                                                if self.isNewTurn then
                                                                    self:FreshCard()
                                                                end
                                                            end }
                                                        }
                                                )
                                                goEnv:PlayMatchCloseAnim()
                                                goEnv:FreshBaseUI({
                                                    id = id,
                                                    hasOpened = true,
                                                    hasGet = true,
                                                })
                                                matchGoEnv:PlayMatchCloseAnim()
                                                matchGoEnv:FreshBaseUI({
                                                    id = id,
                                                    hasOpened = true,
                                                    hasGet = true,
                                                })
                                            else
                                                self.data.openedCardIds[tostring(i)] = id
                                                CriWareUtils.PlaySe("Audio/UI_General", "ui_pai_open")
                                                cs_coroutine.yield_return(goEnv:PlayOpenAnim())
                                                UIRaycastBlocker:RemoveCondition("ActivityTurnOverCards")
                                            end

                                            self:FreshActivityRedPoint()

                                            print("---->>"..table.dump(response.data, nil, 3))



                                        end)
                                    end
                                end
                        )
                    else
                        local currencyData = GoodsConfMgr:GetGoodsVoById(self.activityData.consume)
                        GameUtils.Toast(localize("_name_不足", {_name_ = currencyData.name}))
                        --CfUtils.FillText(self.TxtIntroduction, string.format("消耗%s张%s翻牌1次", self.activityData.cost, currencyData.name))
                    end
                end
            end)
        end
        KTool.SetActive(go, true)
    end

    CfUtils.RefreshTopGoods({ self.activityData.consume })
    self:FreshRedPoint()

end

function ActivityTurnOverCards:FreshRedPoint()
    self:FreshTaskRedPoint()
    self:FreshActivityRedPoint()
end


function ActivityTurnOverCards:FreshActivityRedPoint()
    local isActive
    local isCardActive = self:isTargetItemEnough()
    local isTaskActive = self.data.taskRedDotHint >= 0 and true or false
    isActive = isCardActive or isTaskActive
    Events.Broadcast(Constants.EventNames.ActivityRedPointChange, self._data.id, isActive and 0 or -1)
end

function ActivityTurnOverCards:FreshTaskRedPoint(status)
    print("FreshTaskRedPoint======>>"..tostring(status))
    if isNull(self.data) then
        return
    end
    local redPointGo = GameUtils.GetRedPointGo(self.BtnGet)
    local isActive
    if isNull(status) then
        isActive = self.data.taskRedDotHint >=0
    else
        isActive = status
        self.data.taskRedDotHint = status and 0 or -1
    end
    KTool.SetActive(redPointGo, isActive)
end

function ActivityTurnOverCards:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return ActivityTurnOverCards
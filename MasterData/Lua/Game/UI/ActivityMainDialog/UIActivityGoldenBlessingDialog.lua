---
--- DateTime: 2024/1/15 16:22
---
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
---@type ActivityUtils
local ActivityUtils = import("Game.Activity.ActivityUtils")

local UIActivityGoldenBlessingCellNodePath = 'Game.UI.ActivityMainDialog.UIActivityGoldenBlessingCellNode'

--- from: Assets/BundleResources/Prefabs/Activity/ActivityBlessingPanel140002.prefab > name: ActivityBlessingPanel140002
---@class UIActivityGoldenBlessingDialog
---@field Env                           	UIActivityGoldenBlessingDialog          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field redPoint                      	UnityEngine.RectTransform               	@ 0    
---@field ImgSymbol                     	UnityEngine.RectTransform               	@ 1    
---@field FX_glow2                      	UnityEngine.RectTransform               	@ 2    
---@field BtnReward                     	UnityEngine.RectTransform               	@ 3    
---@field LoopListView                  	SuperScrollView.LoopListView2           	@ 4    
---@field BtnGoTo                       	UnityEngine.RectTransform               	@ 5    
---@field TxtNum                        	UnityEngine.RectTransform               	@ 6    
---@field DescriptionText               	UnityEngine.RectTransform               	@ 7    
---@field TxtTime                       	TMPro.TextMeshProUGUI                   	@ 8    右侧, 活动时间 文本
---@field Image                         	UnityEngine.RectTransform               	@ 9    
local UIActivityGoldenBlessingDialog = Class('UIActivityGoldenBlessingDialog')
function UIActivityGoldenBlessingDialog:__init()
    self.activityDt = nil
    self.data = nil
end

function UIActivityGoldenBlessingDialog:__delete()
    self.activityDt = nil
    self.data = nil
end

function UIActivityGoldenBlessingDialog:OnEventSdkEvent(parameters)
    if parameters.event == Constants.EventNames.EVENT_SDK_PAY then
        if not isNull(self) then
            self:Refresh(self.activityDt)
        end
    end
end

function UIActivityGoldenBlessingDialog:Awake()
    CfUtils.SetActive(self.controller.gameObject, false)
    self.__EventSdkEvent = Events.AddListener(Constants.EventNames.EVENT_SDK, Bind(self, self.OnEventSdkEvent))
    SetButtonAction(self.BtnReward, function()
        if self.data then
            --local hasDot = checkNumber(self.activityDt.redDotHint)
            --print('===>>', hasDot)
            --for i, v in pairs(self.data.tasks) do
            --    print("===>>", v.rewardsHasDrawn, v.payRewardsHasDrawn, v.dailyPoint, self.data.dailyPoint, (checkNumber(v.rewardsHasDrawn) == 0 and checkNumber(v.dailyPoint) >= checkNumber(self.data.dailyPoint)))
            --    if (checkNumber(v.rewardsHasDrawn) == 0 and checkNumber(v.dailyPoint) <= checkNumber(self.data.dailyPoint)) or (checkNumber(v.payRewardsHasDrawn) == 0 and checkNumber(v.hasBuy) == 1 )then
            --        hasDot = hasDot + 1
            --    end
            --end
            --print("===>>", hasDot)
            --hasDot = hasDot - 1
            --if hasDot >= 0 then
            --    hasDot = 0
            --else
            --    hasDot = -1
            --end
            --print("===>>", hasDot)
            --ActivityUtils.UpdateActivityMainRedPointState(self:GetActivityId(), hasDot)
            local hasDrawnDailyFreeRewards = checkNumber(self.data.hasDrawnDailyFreeRewards)
            if hasDrawnDailyFreeRewards == 0 then
                ---未领取
                GameUtils.Request(Interfaces.ActivityGoldenBlessingDailyDraw, { activityUuid = self:GetActivityId() }, function(request, response)
                    if checkNumber(response.errCode) == 0 then
                        local responseData = checkTable(response.data)
                        self.data.hasDrawnDailyFreeRewards = 1
                        local hasDot = checkNumber(self.activityDt.redDotHint)
                        for i, v in pairs(self.data.tasks) do
                            if (checkNumber(v.rewardsHasDrawn) == 0 and checkNumber(v.dailyPoint) <= checkNumber(self.data.dailyPoint)) or (checkNumber(v.payRewardsHasDrawn) == 0 and checkNumber(v.hasBuy) == 1 )then
                                hasDot = hasDot + 1
                            end
                        end
                        ActivityUtils.UpdateActivityMainRedPointState(self:GetActivityId(), hasDot - 1)
                        ---活跃度的显示调整
                        self:FreshActivityPointUI()
                        if isSet(responseData, "rewards") then
                            if #responseData.rewards > 0 then
                                GoodsUtils.DrawRewards(responseData.rewards)
                                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = responseData.rewards } })
                            else
                                GameUtils.Toast(localize("沒有可领取的物品"))
                            end
                        end
                    end
                end)
            else
                GameUtils.Toast(localize('奖励已经领取'))
            end
        end
    end)
    SetButtonAction(self.BtnGoTo, function()
        ---前往日常任务
        UIModule.OpenDialog(UIArgs(Constants.UITypeIds.UITasksDialog), { { id = Constants.UITypeIds.UIActivityMainDialog } })
    end)
end

function UIActivityGoldenBlessingDialog:GetActivityId()
    return checkInt(self.activityDt.id)
end

function UIActivityGoldenBlessingDialog:RefreshBaseView()
    CfUtils.FillText(self.TxtTime, ActivityUtils.ConventActivityDurationTime(self.activityDt.startTime, self.activityDt.endTime))
    CfUtils.FillText(self.DescriptionText, string.trim(self.activityDt.detail) ~= "" and self.activityDt.detail or "TO BE CONTINUE")
    if not CfUtils.IsActive(self.controller) then
        CfUtils.SetActive(self.controller, true)
    end
    local titleImgUrl = checkString(self.activityDt.titleImage)
    try(function()
        if string.len(titleImgUrl) > 0 then
            CfUtils.FillWebRawImage(self.Image, titleImgUrl)
        end
    end).catch (function(ex)
        print(ex)
    end)
end

function UIActivityGoldenBlessingDialog:Refresh(activityDojo, isForceFreshDot)
    self.activityDt = activityDojo
    isForceFreshDot = checkBool(isForceFreshDot)
    self:RefreshBaseView()
    GameUtils.Request(Interfaces.ActivityGoldenBlessingHome, { activityUuid = self:GetActivityId() },
            function(request, response)
                if checkNumber(response.errCode) == 0 then
                    CfUtils.SetActive(self.controller.gameObject, true)
                    self.data = response.data
                    ---活跃度的显示调整
                    self:FreshActivityPointUI()
                    self:FreshListView()
                    if isForceFreshDot then
                        ----更新页签的小红点
                        self:FreshTaskHitDot()
                    end
                end
            end
    )
end

function UIActivityGoldenBlessingDialog:FreshActivityPointUI()
    CfUtils.FillText(self.TxtNum, checkNumber(self.data.dailyPoint))
    local hasDrawnDailyFreeRewards = checkNumber(self.data.hasDrawnDailyFreeRewards)
    CfUtils.SetActive(self.redPoint, hasDrawnDailyFreeRewards == 0)
    CfUtils.SetActive(self.FX_glow2, hasDrawnDailyFreeRewards == 0)
    CfUtils.SetUISwitchImage(self.ImgSymbol, hasDrawnDailyFreeRewards == 0 and 2 or 1)
    if hasDrawnDailyFreeRewards == 1 then
        CfUtils.PlayAnimation(self.BtnReward.transform:Find("AnimRoot"), "SpecialGiftPackageDialog_BtnReward_Default")
        ---已领取
    else
        CfUtils.PlayAnimation(self.BtnReward.transform:Find("AnimRoot"), "SpecialGiftPackageDialog_BtnReward_Loop")
    end
end

function UIActivityGoldenBlessingDialog:OnGetItemByIndex(loopListView, index)
    if index < 0 then
        return nil
    end
    local position = index + 1
    local data = self.data.tasks[position]
    if not data then
        return
    end
    local cell = loopListView:NewListViewItem("Cell")
    if not isNull(cell) then
        ---@type UIActivityGoldenBlessingCellNode
        local env = CfUtils.GetLuaScr(cell, UIActivityGoldenBlessingCellNodePath)
        if not isNull(env) then
            env:FreshUI(data, self.data.dailyPoint, Bind(self, self.OnBuyActionButton))
        end
    end
    return cell
end

function UIActivityGoldenBlessingDialog:OnBuyActionButton(cellData, buyType)
    if buyType == 1 then
        if table.count(cellData.prices) > 0 then
            local goodsId = checkNumber(table.takeFirst(table.keys(cellData.prices)))
            local dojo = cellData.prices[tostring(goodsId)]
            if dojo then
                local productId = cellData.productId
                local price = checkNumber(dojo.current)
                ---@type ServerDifferenceMgr
                local ServerDifferenceMgr = import('Game.Setting.ServerDifferenceMgr'):GetInstance()
                ServerDifferenceMgr:WrapPrimaryCurrencyBuy({
                    currency = goodsId,
                    current = price,
                }, function(isSuccess)
                    isSuccess = checkBool(isSuccess)
                    if not isSuccess then
                        return
                    end
                    ----请求兑换的逻辑
                    GameUtils.Request(Interfaces.ActivityGoldenBlessingGoldenBuy, {
                        activityUuid =  self:GetActivityId(),
                        productId = productId,
                        num = price,
                        currency = goodsId,
                    }, function(request, resp)
                        if checkNumber(resp.errCode) == 0 then
                            local reward = checkTable(resp.data.rewards)
                            GoodsUtils.DrawRewards({ {
                                                         goodsId = goodsId,
                                                         num = - price,
                                                         productId = productId,
                                                     } })
                            if #reward > 0 then
                                GoodsUtils.DrawRewards(reward)
                                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = reward } })
                            end
                            if not isNull(self) then
                                self:Refresh(self.activityDt, true)
                            end
                        end
                    end)
                end)
            end
        else
            ---@type SDKService
            local SDKService = import('Game.Entry.SDKService')
            local productId = cellData.productId
            local channelProductId = cellData.channelProductId
            local price = cellData.price
            local data = cellData.channelProducts
            if checkNumber(cellData.hasBuy) == 1 then
                return
            end
            SDKService:GetInstance():PayMoney({
                productId = productId,
                channelProductId = channelProductId,
                productDesc = localize('活跃点礼包'),
                payAmount = checkNumber(price),
                data = {
                    productId = productId,
                    channelProductId = channelProductId,
                    channelProducts = data,
                    price = checkNumber(price)
                }
            })
        end
    else
        --免费奖励的领取
        GameUtils.Request(Interfaces.ActivityGoldenBlessingTaskDraw, { activityUuid = self:GetActivityId(), taskId = cellData.taskId}, function(request, response)
            if checkNumber(response.errCode) == 0 then
                local responseData = checkTable(response.data)
                cellData.rewardsHasDrawn = 1
                ----更新页签的小红点
                self:FreshTaskHitDot()
                --ActivityUtils.UpdateActivityMainRedPointState(self:GetActivityId(), checkNumber(self.activityDt.redDotHint) - 1)
                self:FreshListView()
                if isSet(responseData, "rewards") then
                    if #responseData.rewards > 0 then
                        GoodsUtils.DrawRewards(responseData.rewards)
                        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = responseData.rewards } })
                    else
                        GameUtils.Toast(localize("沒有可领取的物品"))
                    end
                end
            end
        end)
    end
end

function UIActivityGoldenBlessingDialog:FreshTaskHitDot()
    ----更新页签的小红点
    local hasDot = checkNumber(self.activityDt.redDotHint)
    for i, v in pairs(self.data.tasks) do
        if (checkNumber(v.rewardsHasDrawn) == 0 and checkNumber(v.dailyPoint) <= checkNumber(self.data.dailyPoint)) or (checkNumber(v.payRewardsHasDrawn) == 0 and checkNumber(v.hasBuy) == 1 )then
            hasDot = hasDot + 1
        end
    end
    if checkNumber(self.data.hasDrawnDailyFreeRewards) == 0 then
        hasDot = hasDot + 1
    end
    hasDot = hasDot - 1
    if hasDot >= 0 then
        hasDot = 0
    else
        hasDot = -1
    end
    ActivityUtils.UpdateActivityMainRedPointState(self:GetActivityId(), hasDot)
end
---FreshListView
---刷新列表信息
function UIActivityGoldenBlessingDialog:FreshListView()
    if not self.LoopListView.IsListViewInit then
        print(#self.data.tasks)
        self.LoopListView:InitListView(#self.data.tasks, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.LoopListView, #self.data.tasks)
    end
end

function UIActivityGoldenBlessingDialog:OnDestroy()
    if self.__EventSdkEvent then
        Events.RemoveListener(Constants.EventNames.EVENT_SDK, self.__EventSdkEvent)
        self.__EventSdkEvent = nil
    end
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
end

return UIActivityGoldenBlessingDialog
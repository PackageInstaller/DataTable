--- from: Assets/BundleResources/Prefabs/Activity/ActivityWeekendGiftDialog12002601.prefab > name: ActivityWeekendGiftDialog12002601
---@class ActivityWeekendGiftDialog
---@field Env                           	ActivityWeekendGiftDialog               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgTitleName                  	UnityEngine.RectTransform               	@ 0    
---@field TxtTime                       	UnityEngine.RectTransform               	@ 1    
---@field DescrText                     	UnityEngine.RectTransform               	@ 2    
---@field LowCommonGoodsListLight       	UnityEngine.RectTransform               	@ 3    
---@field LowFinish                     	UnityEngine.RectTransform               	@ 4    
---@field LowReceive                    	UnityEngine.RectTransform               	@ 5    
---@field HighCommonGoodsListLight      	UnityEngine.RectTransform               	@ 6    
---@field HighFinish                    	UnityEngine.RectTransform               	@ 7    
---@field HighReceive                   	UnityEngine.RectTransform               	@ 8    
---@field BtnTopUp                      	UnityEngine.RectTransform               	@ 9    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 10   
---@field RewardText                    	UnityEngine.RectTransform               	@ 11   
---@field BtnShop                       	UnityEngine.RectTransform               	@ 12   
---@field PointTxtNum                   	UnityEngine.RectTransform               	@ 13   
---@field BtnIllustrate                 	UnityEngine.RectTransform               	@ 14   
---@field redPoint                 	        UnityEngine.RectTransform               	@ 15   
local ActivityWeekendGiftDialog = Class('ActivityWeekendGiftDialog')
local ActivityUtils = import("Game.Activity.ActivityUtils")
---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
local OverseaStoreConstants = import('Game.OverseaStore.OverseaStoreConstants')
local OverseaStoreUtils = import('Game.OverseaStore.OverseaStoreUtils')
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine'
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
function ActivityWeekendGiftDialog:__init()
    self.weekGiftData = nil
    self.co = nil
end

function ActivityWeekendGiftDialog:__delete()
    self.weekGiftData = nil
    if self.co then
        
    end
end


function ActivityWeekendGiftDialog:Awake()
    local conf = OverseaStoreConstants.StorePanelConfigs[OverseaStoreConstants.StoreType.TopUp]
    local isOpen =  CfUtils.IsOpneByFunctionId(conf.functionId)
    local storeType = isOpen and  OverseaStoreConstants.StoreType.TopUp or  OverseaStoreConstants.StoreType.PrimaryCurrency
    SetButtonAction(self.BtnTopUp , function ()
        OverseaStoreUtils.OpenStore(storeType, {{id =  Constants.UITypeIds.UIActivityMainDialog}})
    end)
    SetButtonAction(self.BtnShop , function ()
        OverseaStoreUtils.OpenStore(storeType, {{id =  Constants.UITypeIds.UIActivityMainDialog}})
    end)
    SetButtonAction(self.FontStyleButton , function ()
        if isNull(self.weekGiftData) then
            return
        end
        if self:IsHasDraw() then
            GameUtils.Toast(localize("奖励已经领取"))
            return
        end
        local leftSendTime = self:GetLeftTime()
        if leftSendTime > 0 then
            GameUtils.Toast(localize("未到领取时间"))
            return
        end
        local currentPoint = self:GetCuurentPoint()
        local needPoint = self:GetNeedPoint()
        if currentPoint < needPoint then
            GameUtils.Toast(localize("活跃度不足"))
            return
        end

         if self:isUpgrade() then
            self:DrawWeekendGift()
            return
        end

        GameUtils.SecondConfirm(localize("任意充值一笔金额即可将普通礼物盒升级至<color=#e71f55>_name_</color>,是否前往充值?", {_name_ = localize("豪华礼物盒")})  , function ()
            local OverseaStoreConstants = import('Game.OverseaStore.OverseaStoreConstants')
            local OverseaStoreUtils = import('Game.OverseaStore.OverseaStoreUtils')
            OverseaStoreUtils.OpenStore(storeType,{{id =  Constants.UITypeIds.UIActivityMainDialog}})
        end , 
        function ()
            self:DrawWeekendGift()
        end,
        "",
        15
    )
    end)
    SetButtonAction(self.BtnIllustrate , function ()
        if isNull(self.weekGiftData) then
            return
        end
        CfUtils.ShowModuleToast(self.weekGiftData.ruleId)
    end)
end

function ActivityWeekendGiftDialog:DrawWeekendGift()
    GameUtils.Request(Interfaces.Activity2DrawWeekendGift  , { activityUuid = self._collectionDojo.id }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        local rewards = response.data.rewards
        GoodsUtils.DrawRewards(response.data.rewards)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })
        self.weekGiftData.bought = 1
        ActivityUtils.UpdateActivityMainRedPointState(self._collectionDojo.id , -1)
        local activityDojo =  ActivityMgr:GetActivityComponent():GetDojoByActivityId(self._collectionDojo.id)
        activityDojo.redDotHint = -1
        self.weekGiftData.hasDrawn = 1
        KTool.SetActive(self.redPoint.gameObject, false)
        self:InitUI()
    end)

end

-- 是否升级
function ActivityWeekendGiftDialog:isUpgrade()
    return  checkInt(self.weekGiftData.bought) == 1
end

-- 可以领取的时间
function ActivityWeekendGiftDialog:GetLeftTime()
    local leftTime = self.weekGiftData.drawLeftSeconds - os.time()
    return leftTime
end

function ActivityWeekendGiftDialog:GetCuurentPoint()
    return checkInt(self.weekGiftData.dailyPoint) 
end
function ActivityWeekendGiftDialog:GetNeedPoint()
    return checkInt(self.weekGiftData.targetDailyPoint)
end


-- 是否已经领取
function ActivityWeekendGiftDialog:IsHasDraw()
    return checkInt(self.weekGiftData.hasDrawn) == 1
end
-- 获取领取低端的奖励
function ActivityWeekendGiftDialog:GetLowReward()
    return self.weekGiftData.freeRewards
end
-- 获取领取高端的奖励
function ActivityWeekendGiftDialog:GetHightReward()
    return self.weekGiftData.buyRewards
end

function ActivityWeekendGiftDialog:IsCanDraw()
    local isCan = false
    local isHasDraw = self:IsHasDraw()
    local leftTime = self:GetLeftTime()
    local currentPoint = self:GetCuurentPoint()
    local needPoint  = self:GetNeedPoint()
    if (not isHasDraw) and leftTime <= 0 and currentPoint >= needPoint then
        isCan = true
    end
    return isCan
end


function ActivityWeekendGiftDialog:InitUI()
    local isUpgrade = self:isUpgrade()
    local isHasDraw = self:IsHasDraw()
    local leftTime = self:GetLeftTime()
    local currentPoint = self:GetCuurentPoint()
    local needPoint  = self:GetNeedPoint()
    -- 升级显示的标志是 没有升级并且奖励没有领取
    CfUtils.SetActive(self.BtnTopUp , (not isUpgrade) and (not isHasDraw) ) 
    local lowRewards = self:GetLowReward()
    CfUtils.RefreshCommonGoodsListLight(self.LowCommonGoodsListLight , lowRewards)
    local hightRewards = self:GetHightReward()
    CfUtils.RefreshCommonGoodsListLight(self.HighCommonGoodsListLight , hightRewards)
    
    --[[
        奖励有一下几种状态
        1. 已经升级
            1.1 已经升级，已经领取
            1.2 已经升级，可以领取
            1.3 已经升级，时间到了 ， 点数不足
            1.4 已经升级，时间不到 
        2. 未升级
            2.1 未升级，已经领取
            2.2 未升级，可以领取
            2.3 已经升级，时间到了 ， 点数不足
            2.4 已经升级，时间不到 
    ]] 
    if isUpgrade then
        if isHasDraw then
            KTool.SetActive(self.HighFinish , true) 
            KTool.SetActive(self.HighReceive , false) 
            KTool.SetActive(self.LowFinish , false)   
            KTool.SetActive(self.LowReceive , false)
            CfUtils.FillText(self.RewardText  , localize("已领取"))
            CfUtils.SetButtonStyle(self.FontStyleButton , "B1") 
        elseif (not isHasDraw ) and leftTime <= 0 and currentPoint >= needPoint then        
            KTool.SetActive(self.HighFinish , false) 
            KTool.SetActive(self.HighReceive , true) 
            KTool.SetActive(self.LowFinish , false)   
            KTool.SetActive(self.LowReceive , false)
            CfUtils.SetButtonStyle(self.FontStyleButton , "B1") 
            CfUtils.FillText(self.RewardText  , localize("领取"))
            CfUtils.SetActive(self.redPoint , true)
        else 
            if leftTime <= 0 then
                CfUtils.FillText(self.RewardText , localize("领取"))
            else 
                CfUtils.FillText(self.RewardText , localize("_time_后领取" , {_time_ = CfUtils.GetTimeHMS10(leftTime)}))
            end
            CfUtils.SetButtonStyle(self.FontStyleButton , "B17")
            KTool.SetActive(self.HighFinish , false) 
            KTool.SetActive(self.HighReceive , true) 
            KTool.SetActive(self.LowFinish , false)   
            KTool.SetActive(self.LowReceive , false)
        end
    else
        if isHasDraw then
            KTool.SetActive(self.HighFinish , false) 
            KTool.SetActive(self.HighReceive , false) 
            KTool.SetActive(self.LowFinish , true)   
            KTool.SetActive(self.LowReceive , false)
            CfUtils.FillText(self.RewardText  , localize("已领取"))
            CfUtils.SetButtonStyle(self.FontStyleButton , "B1") 
        elseif (not isHasDraw ) and leftTime <= 0  and currentPoint >= needPoint then
            KTool.SetActive(self.HighFinish , false) 
            KTool.SetActive(self.HighReceive , false) 
            KTool.SetActive(self.LowFinish , false)   
            KTool.SetActive(self.LowReceive , true)
            CfUtils.SetButtonStyle(self.FontStyleButton , "B1") 
            CfUtils.FillText(self.RewardText  , localize("领取"))
            CfUtils.SetActive(self.redPoint , true)

        else 
            if leftTime <= 0 then
                CfUtils.FillText(self.RewardText , localize("领取"))
            else 
                CfUtils.FillText(self.RewardText , localize("_time_领取" , {_time_ = CfUtils.GetTimeHMS11(leftTime)}))
            end
            CfUtils.SetButtonStyle(self.FontStyleButton , "B17")
            KTool.SetActive(self.HighFinish , false) 
            KTool.SetActive(self.HighReceive , false) 
            KTool.SetActive(self.LowFinish , false)   
            KTool.SetActive(self.LowReceive , true)
        end
    end
    if currentPoint >= needPoint then
        CfUtils.FillText(self.PointTxtNum ,string.format("%d/%d" , currentPoint , needPoint))
    else    
        CfUtils.FillText(self.PointTxtNum ,string.format("<color=#ff1454>%d</color>/%d", currentPoint , needPoint))
    end
end

--region public
---刷新自身
---@param activityDojo ActivityDojo
function ActivityWeekendGiftDialog:Refresh(collectionDojo)
    self._collectionDojo = collectionDojo
    
    GameUtils.Request(Interfaces.Activity2WeekendGift ,  {activityUuid = self._collectionDojo.id} , function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        self.weekGiftData = response.data 
        self.weekGiftData.drawLeftSeconds = os.time() + self.weekGiftData.drawLeftSeconds
        local leftTime = self:GetLeftTime()
        if leftTime > 0 then
            if self.co then
                cs_coroutine.stop(self.co)
                self.co = nil
            end
            if leftTime > 0 then
                self.co = cs_coroutine.start(function ()
                    leftTime = self:GetLeftTime()
                    while leftTime > 0 do
                        local delayTime = 1
                        if leftTime > 86400 then
                            delayTime = 3600
                        elseif leftTime > 3600 then
                            delayTime = 60
                        end
                        cs_coroutine.yield_return(WaitForSeconds(delayTime))
                        
                        CfUtils.FillText(self.RewardText , localize("_time_领取" , {_time_ = CfUtils.GetTimeHMS11(leftTime)}))                        
                    end
                    ActivityUtils.UpdateActivityMainRedPointState(self._collectionDojo.id , 0)
                    local activityDojo =  ActivityMgr:GetActivityComponent():GetDojoByActivityId(self._collectionDojo.id)
                    activityDojo.redDotHint = 0
                    KTool.SetActive(self.redPoint, true)
                    CfUtils.FillText(self.RewardText , localize("领取"))
                    CfUtils.SetButtonStyle(self.FontStyleButton , "B1") 
                end)
            end
        end
        if not self:IsCanDraw() then
            ActivityUtils.UpdateActivityMainRedPointState(self._collectionDojo.id , -1)
            ---@type ActivityMgr
            local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
            ActivityMgr:UpdateFirstOrEverydayEnterRedPoint(self._collectionDojo.id , false)
            local activityDojo =  ActivityMgr:GetActivityComponent():GetDojoByActivityId(self._collectionDojo.id)
            activityDojo.redDotHint = -1
        end
        self:InitUI()
    end)
    self:RefreshActvityUI(self._collectionDojo)
end
--region private
---刷新UI
---@param activityDojo ActivityDojo
function ActivityWeekendGiftDialog:RefreshActvityUI(activityDojo)
    CfUtils.FillText(self.TxtTime, ActivityUtils.ConventActivityDurationTime(activityDojo.startTime, activityDojo.endTime))
    CfUtils.FillText(self.DescrText, activityDojo.detail)
    -- 网络标题
    local titleImgUrl = checkString(activityDojo.titleImage)
    if string.len(titleImgUrl) > 0 then
        CfUtils.FillWebRawImage(self.ImgTitleName, titleImgUrl)
    end
end 



function ActivityWeekendGiftDialog:Start()

end


function ActivityWeekendGiftDialog:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityWeekendGiftDialog
--这个Logic下的lua文件是负责广告部分的逻辑，暂时没有去进行细致地了解
---@class AdLogic
local AdLogic = class("AdLogic")

local AdState =
{
    Loading = 0,
    Loaded = 1,
    FailedToLoad = 2,
    Opening = 3,
    FailedToShow = 4,
    EarnedReward = 5,
    Closed =  6,
    Canceled =  7,
}

function AdLogic:ctor()
    self.Timer = {}
end

function AdLogic.Init()
    if GV.GlobalConfig.IsInternalFormal() then
        return
    end
    
    DAdManager.Instance:Init()
    --if UnityEngine.Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
    --    --DAdManager.Instance:MoPubInit("9da601fb2392424096ef4ba2b2de9e9a")
    --elseif UnityEngine.Application.platform == UnityEngine.RuntimePlatform.Android then
    --    DAdManager.Instance:MoPubInit("d605d67d8a33415da517ffa80265abf5")
    --end
end

function AdLogic.PreloadRewardAd()
    if GV.GlobalConfig.IsInternalFormal() then
        return
    end
    
    DAdManager.Instance:LoadRewardAd(SDKMgr:getRewardAdUnit(), function (code)
        if code == AdState.FailedToLoad then
            LuaLogger.ws("RewardAd FailedToLoad")
            --DLuaTimer:DoAfter(30, function ()
            --    AdLogic.PreloadRewardAd()
            --end)
        elseif code == AdState.FailedToShow then
            LuaLogger.es("RewardAd FailedToShow")
            --DLuaTimer:DoAfter(30, function ()
            --    AdLogic.PreloadRewardAd()
            --end)
        end
    end)
end

function AdLogic.DealFreeGoldButton(mono, freeGoldBtn)
    if GV.GlobalConfig.IsInternalFormal() then
        freeGoldBtn:SetActive(false)
        return
    end

    if GV.IsIOSLogic and SDKMgr.IOSNoAd or not Me:hasFreeGoldAdTimes() then
        freeGoldBtn:SetActive(false)
        return
    end

    freeGoldBtn:SetActive(true)

    local canUseAdCard, reason = Me:checkUseAdCard()
    print("canUseAdCard, reason", canUseAdCard, reason)
    if canUseAdCard or reason == ActionFailReason.AdCardAlreadyUsed then
        if AdLogic.Timer[freeGoldBtn] then
            DTimer.Instance:RemoveTimer(AdLogic.Timer[freeGoldBtn])
        end
        freeGoldBtn:FadeInOut(3)
        if canUseAdCard then
            freeGoldBtn.text.text = LocalStrEnum.UI_StorePanel_AdLogic_UseAdCard
            UICommonUtils.ResetButtonListener(mono, freeGoldBtn.button, function ()
                Me:getRewardByUseAdCard(function (success, data)
                    if success then
                        UICommonUtils.PopRewardToast(data.rewards)
                        AdLogic.DealFreeGoldButton(mono, freeGoldBtn)
                    end
                end)
            end)
        else
            local next_time = Me.goldStoreInfo.adLimitTime
            if Me.goldStoreInfo.adNextGotTime > 0 then
                next_time = Me.goldStoreInfo.adNextGotTime
            end
            local leftSeconds = math.ceil(next_time - EngineUtil.ServerTime_Seconds())
            freeGoldBtn.text.text = string.format(LocalStrEnum.UI_StorePanel_AdLogic_UseAdCardLeft, DLuaUtil.SecondsToTimeStr2(leftSeconds))
            AdLogic.Timer[freeGoldBtn] = DLuaTimer:DoRepeat(1, leftSeconds, function ()
                leftSeconds = leftSeconds - 1
                freeGoldBtn.text.text = string.format(LocalStrEnum.UI_StorePanel_AdLogic_UseAdCardLeft, DLuaUtil.SecondsToTimeStr2(leftSeconds))

                if leftSeconds <= 0 then
                    AdLogic.Timer[freeGoldBtn] = nil
                    AdLogic.DealFreeGoldButton(mono, freeGoldBtn)
                end
            end)
            UICommonUtils.ResetButtonListener(mono, freeGoldBtn.button, function ()
            end)
        end
        return
    end

    if Me:canShowNextRewardAd() then
        freeGoldBtn:FadeInOut(3)
        freeGoldBtn.text.text = LocalStrEnum.FreeAdReward
        
        UICommonUtils.ResetButtonListener(mono, freeGoldBtn.button, function ()
            if not DAdManager.Instance:IsAnyRewardAdLoaded() then
                UICommonUtils.PopPromptBox(LocalStrEnum.RewardAdNotPrepared)
                return
            end

            UICommonUtils.PopPromptOkCancelBox(LocalStrEnum.NoticeRewardAdShouldToEnd, function ()
                DAdManager.Instance:ShowAnyRewardAd(function (code)
                    LuaLogger.ds("AdLogic", code, code == AdState.EarnedReward)
                    if code == AdState.EarnedReward then
                        Me:getRewardByWatchRewardAd(function ()
                            UICommonUtils.PopToast(LocalStrEnum.GetAdReward10Yuanbao)
                            AdLogic.DealFreeGoldButton(mono, freeGoldBtn)
                        end)
                    else
                    end
                end)    
            end)
        end)
    elseif not AdLogic.Timer[freeGoldBtn] then
        freeGoldBtn:StopFadeInOut()
        --freeGoldBtn.text:SetAlpha(1)
        freeGoldBtn.text:CrossFadeAlpha(1, 0, true);
        freeGoldBtn.button.onClick:RemoveAllListeners()

        local leftSeconds = math.ceil(Me:secondBeforeShowNextRewardAd()) + 6 -- 这里得到的时间差有时候有五六秒，暂不明原因
        freeGoldBtn.text.text = string.format(LocalStrEnum.NextFreeAdRewardTime, DLuaUtil.SecondsToTimeStr(leftSeconds))
        AdLogic.Timer[freeGoldBtn] = DLuaTimer:DoRepeat(1, leftSeconds, function ()
            leftSeconds = leftSeconds - 1
            freeGoldBtn.text.text = string.format(LocalStrEnum.NextFreeAdRewardTime, DLuaUtil.SecondsToTimeStr(leftSeconds))

            if leftSeconds <= 0 then
                AdLogic.Timer[freeGoldBtn] = nil
                AdLogic.DealFreeGoldButton(mono, freeGoldBtn)
            end
        end)
    end
end

function AdLogic.ReleaseFreeGoldButton(freeGoldBtn)
    if GV.GlobalConfig.IsInternalFormal() then
        return
    end
    
    local timerInfo = AdLogic.Timer[freeGoldBtn]
    if not timerInfo then
        return
    end

    DTimer.Instance:RemoveTimer(timerInfo)
    AdLogic.Timer[freeGoldBtn] = nil
end

return AdLogic
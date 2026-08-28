---
--- Created by Eric.
--- DateTime: 2022/6/30 16:59
---

------------ import ------------
local ECSComponent = import("Frame.ECS.ECSComponent")
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------

------------ define ------------


---@class FeatureSignComponent
local FeatureSignComponent = Class("FeatureSignComponent", ECSComponent)
function FeatureSignComponent:__init()
    self.name = "FeatureSignComponent"
    self.isInFeatureSign = false
    self.festivalSignInInfo = {}


end

function FeatureSignComponent:__delete()
    self.name = nil
    self.isInFeatureSign = nil
    self.festivalSignInInfo = nil



end

function FeatureSignComponent:RequestFestivalSignInInfo()
    GameUtils.Request(
            Interfaces.PlayerFestivalSignInInfo,
            {},
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    self.festivalSignInInfo = checkTable(response.data.info)
                end
            end
    )
end

function FeatureSignComponent:InitFestivalSignInInfo(data)
    self.festivalSignInInfo = checkTable(data)
    --self.festivalSignInInfo = {
    --    {
    --        ["type"] = 1,
    --        ["giftId"] = 1001,
    --    }
    --}

end

---HasFeatureSign
---是否存在签到奖励的逻辑
function FeatureSignComponent:HasFeatureSign()
    if table.count(self.festivalSignInInfo) == 0 then
        return false
    end
    local I18NModule    = CS.Engine.I18N.I18NModule
    local currentLang   = I18NModule.Lang
    if currentLang == 'zh_CN' then
        local KTool = CS.Engine.Lib.KTool
        if not KTool.UNITY_IOS() then
            return false
        end
    end
    return true
end

function FeatureSignComponent:CheckFeatureSign()
    --没有特殊签到数据，返回false
    -- print("------>>"..table.dump(self.festivalSignInInfo, false, 2))
    --if not self.hasAdd then
    --    self.hasAdd = true
    --    self.festivalSignInInfo = {
    --        {
    --            ["giftId"] = 1001,
    --            ["type"] = 1,
    --        },
    --    }
    --end
    local HasFeatureSign = self:HasFeatureSign()
    if not HasFeatureSign then
        return false
    end
    local I18NModule    = CS.Engine.I18N.I18NModule
    local currentLang   = I18NModule.Lang
    if currentLang == 'zh_CN' then
        local KTool = CS.Engine.Lib.KTool
        if not KTool.UNITY_IOS() then
            return false
        end
    end
    local rewards
    local info = clone(self.festivalSignInInfo[1])
    --table.remove(self.festivalSignInInfo, 1)
    --if self.isInFeatureSign then
    --    Events.Broadcast(Constants.EventNames.FeatureSignFresh, info, true)
    --else
    --    UIModule.OpenDialog({ id = Constants.UITypeIds.FeatureSignDialog, parameters = { info = info}},
    --            {
    --                { id = Constants.UITypeIds.UIHomeView },
    --            })
    --end
    GameUtils.Request(
            Interfaces.PlayerReceiveFestivalGift,
            {
                giftId = info.giftId
            },
            function(request, response)
                if checkNumber(response.errCode) == 0 then
                    --数据维护
                    table.remove(self.festivalSignInInfo, 1)
                    rewards = response.data.rewards
                    GoodsUtils.DrawRewards(rewards)
                    if self.isInFeatureSign then
                        Events.Broadcast(Constants.EventNames.FeatureSignFresh, info, true)
                    else
                        UIModule.OpenDialog({ id = Constants.UITypeIds.FeatureSignDialog, parameters = { info = info}},
                                {
                                    { id = Constants.UITypeIds.UIHomeView },
                                })
                    end
                end
            end
    )
    return true
end

function FeatureSignComponent:IsInFeatureSign()
    return self.isInFeatureSign
end





return FeatureSignComponent
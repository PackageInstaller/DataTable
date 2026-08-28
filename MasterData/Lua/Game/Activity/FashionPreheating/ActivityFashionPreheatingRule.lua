local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
---@type ActivityFashionPreheatingUtils
local ActivityFashionPreheatingUtils = import("Game.Activity.FashionPreheating.ActivityFashionPreheatingUtils")
local GameObject = CS.UnityEngine.GameObject
--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Activity/ActivityNewReleaseMember.prefab > name: ActivityNewReleaseMember
---@class ActivityFashionPreheatingRule
---@field Env                           	ActivityFashionPreheatingRule           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TxtDesc                       	UnityEngine.RectTransform               	@ 0    
---@field RoleCell                      	UnityEngine.RectTransform               	@ 1    
---@field ButtonClose                   	UnityEngine.RectTransform               	@ 2    
---@field RareContent                   	UnityEngine.RectTransform               	@ 3    
---@field CommonContent                 	UnityEngine.RectTransform               	@ 4    
local ActivityFashionPreheatingRule = Class('ActivityFashionPreheatingRule')

function ActivityFashionPreheatingRule:__init()
    self.bigPrizeRecord = nil
    self.activityContentId = nil
    self.ruleDescr = nil
end


function ActivityFashionPreheatingRule:__delete()
    self.bigPrizeRecord = nil
    self.activityContentId = nil
    self.ruleDescr = nil
end


function ActivityFashionPreheatingRule:Awake()
end


function ActivityFashionPreheatingRule:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self:InitData(initParams)
        self:InitView()
        SetButtonAction(self.ButtonClose , function ()
            UIModule.CloseDialog(self.controller)
        end)
        printInfo('--enter this')
    end)
end

function ActivityFashionPreheatingRule:InitData(initParams)
    self.bigPrizeRecord = initParams.bigPrizeRecord or {}
    self.activityContentId = initParams.activityContentId or {}
    self.preview = initParams.preview
    local ruleId = initParams.ruleId or {}
    self.ruleDescr = ActivityMgr.GetActivityRule(ruleId)
end

function ActivityFashionPreheatingRule:InitView()
    CfUtils.FillText(self.TxtDesc , self.ruleDescr)
    if isNull(self.preview) then
        local rareVos = ActivityFashionPreheatingUtils.GetBigReardsVo(self.activityContentId)
        local commonVos = ActivityFashionPreheatingUtils.GetCommonReardsVo(self.activityContentId)
        for i =1 , #rareVos do
            local go =  GameObject.Instantiate(self.RoleCell , self.RareContent)
            go.name = "RoleCell" .. i
            ---@type ActivityFashionPreheatingRuleCell
            local Env =  CfUtils.GetLuaScr(go , "Game.Activity.FashionPreheating.ActivityFashionPreheatingRuleCell")
            local count = self:GetCardSkinNum(rareVos[i].rewardId)
            Env:RefreshUI(rareVos[i] ,count  )
            KTool.SetActive(go , true)
        end

        for i =1 , #commonVos do
            local go =  GameObject.Instantiate(self.RoleCell , self.CommonContent)
            go.name = "RoleCell" .. i
            ---@type ActivityFashionPreheatingRuleCell
            local Env =  CfUtils.GetLuaScr(go , "Game.Activity.FashionPreheating.ActivityFashionPreheatingRuleCell")
            Env:RefreshUI(commonVos[i])
            KTool.SetActive(go , true)
        end
    else
        for i, v in pairs(self.preview) do
            local go
            if checkInt(v.isGrand) == 1 then
                go =  GameObject.Instantiate(self.RoleCell , self.RareContent)
            else
                go =  GameObject.Instantiate(self.RoleCell , self.CommonContent)
            end
            go.name = "RoleCell" .. i
            ---@type ActivityFashionPreheatingRuleCell
            local Env =  CfUtils.GetLuaScr(go , "Game.Activity.FashionPreheating.ActivityFashionPreheatingRuleCell")
            Env:RefreshUI({
                showProbability = checkNumber(v.displayNum),
                rewardId = checkNumber(v.itemId),
                rewardNum = checkNumber(v.itemNum)
            })
            KTool.SetActive(go , true)
        end
    end
end

function ActivityFashionPreheatingRule:GetCardSkinNum(cardSkinId)
    cardSkinId = checkInt(cardSkinId)
    local count = 0
    for k, v in pairs(self.bigPrizeRecord) do
        if cardSkinId == checkInt(v.cardSkinId) then
            count = count + 1
        end  
    end
    return count

end


function ActivityFashionPreheatingRule:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActivityFashionPreheatingRule

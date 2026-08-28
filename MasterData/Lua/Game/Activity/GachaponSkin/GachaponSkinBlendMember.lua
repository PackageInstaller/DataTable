local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
---@type ActivityFashionPreheatingUtils
local ActivityFashionPreheatingUtils = import("Game.Activity.FashionPreheating.ActivityFashionPreheatingUtils")
local GameObject = CS.UnityEngine.GameObject
--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinBlendMember.prefab > name: GachaponSkinBlendMember
---@class GachaponSkinBlendMember
---@field Env                           	GachaponSkinBlendMember
---@field controller                    	Engine.UI.UILuaDialog
---@field TxtDesc                       	UnityEngine.RectTransform               	@ 0    
---@field RoleCell                      	UnityEngine.RectTransform               	@ 1    
---@field ButtonClose                   	UnityEngine.RectTransform               	@ 2    
---@field RareContent                   	UnityEngine.RectTransform               	@ 3    
---@field CommonContent                 	UnityEngine.RectTransform               	@ 4    
local GachaponSkinBlendMember = Class('GachaponSkinBlendMember')

function GachaponSkinBlendMember:__init()
    self.bigPrizeRecord = nil
    self.activityContentId = nil
    self.ruleDescr = nil
end


function GachaponSkinBlendMember:__delete()
    self.bigPrizeRecord = nil
    self.activityContentId = nil
    self.ruleDescr = nil
end


function GachaponSkinBlendMember:Awake()
end


function GachaponSkinBlendMember:OnInitialize()
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

function GachaponSkinBlendMember:InitData(initParams)
    self.activityContentId = initParams.activityContentId or {}
    local ruleId = initParams.ruleId or {}
    self.ruleDescr = ActivityMgr.GetActivityRule(ruleId)
end

function GachaponSkinBlendMember:InitView()
    CfUtils.FillText(self.TxtDesc , self.ruleDescr)
    local scheduleVo = CfUtils.GetCfVo(AutoIds.IdSetting6724, "GachaponSkinScheduleVo", self.activityContentId)
    if isNotNull(scheduleVo) then
        local pools = string.split(scheduleVo.teamId,';')
        local rareVos = self:GetShowRewardVos(pools[1])
        local commonVos = self:GetShowRewardVos(pools[2])
        for i =1 , #rareVos do
            local go =  GameObject.Instantiate(self.RoleCell , self.RareContent)
            go.name = "RoleCell" .. i
            ---@type ActivityFashionPreheatingRuleCell
            local Env =  CfUtils.GetLuaScr(go , "Game.Activity.FashionPreheating.ActivityFashionPreheatingRuleCell")
            Env:RefreshUI(rareVos[i])
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
    end
end

function GachaponSkinBlendMember:GetShowRewardVos(teamId)
    teamId = checkNumber(teamId)
    local data = {}
    local allVos = CfUtils.GetCf(AutoIds.IdSetting6723,"GachaponSkinRewardPoolVo",true)
    for i, v in pairs(allVos) do
        if v.teamId == teamId then
            v.showProbability = v.displayNum
            v.rewardId = v.itemId
            v.rewardNum = v.itemNum
            table.insert(data,v)
        end
    end
    return data
end

function GachaponSkinBlendMember:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return GachaponSkinBlendMember

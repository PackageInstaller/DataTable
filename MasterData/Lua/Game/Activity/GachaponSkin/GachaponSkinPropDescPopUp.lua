local UIModule = CS.Engine.UI.UIModule

---@type ActivityGachaponSkinMgr
local Mgr = import("Game.Activity.GachaponSkin.ActivityGachaponSkinMgr"):GetInstance()

--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinPropDescPopUp.prefab > name: GachaponSkinPropDescPopUp
---@class GachaponSkinPropDescPopUp
---@field Env                           	GachaponSkinPropDescPopUp               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CloseEmpty                    	UnityEngine.RectTransform               	@ 0    
---@field ButtonClose                   	UnityEngine.RectTransform               	@ 1    
---@field TxtMain                       	UnityEngine.RectTransform               	@ 2    
---@field ExtraItems                    	UnityEngine.RectTransform               	@ 3    
---@field NormalGoodsList               	UnityEngine.RectTransform               	@ 4    
local GachaponSkinPropDescPopUp = Class("GachaponSkinPropDescPopUp")

---@class GachaponSkinPropDescPopUp.GroupItem
---@field TxtCount                        UnityEngine.RectTransform
---@field GoodGroup                        UnityEngine.RectTransform
---@field GoodGroup_2                    UnityEngine.RectTransform

function GachaponSkinPropDescPopUp:__init()
    self.controller = nil
end

function GachaponSkinPropDescPopUp:__delete()
    self.controller = nil
end

function GachaponSkinPropDescPopUp:Awake()
    SetButtonAction(self.ButtonClose, function()
        UIModule.CloseDialog(self.controller)
    end)
    SetButtonAction(self.CloseEmpty, function()
        UIModule.CloseDialog(self.controller)
    end)
    
    --self.groupItems = {}
    --for i = 1, 5 do
    --    local groupItem = {}
    --    groupItem.TxtCount = self["TxtCount" .. i]
    --    groupItem.GoodGroup = self["GoodGroup" .. i]
    --    groupItem.GoodGroup_2 = self["GoodGroup" .. i .. "_2"]
    --    self.groupItems[i] = groupItem
    --end
end

function GachaponSkinPropDescPopUp:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.data = initParams
        self.activity = Mgr.Sever:GetActivityByUuid(self.data.activityUuid)
        local requestBack = false
        Mgr.Sever:RequestActivitySkinLotteryProbability(self.data.activityUuid, function(data)
            requestBack = true
            self:RefreshUI()
        end, function(errCode)
            requestBack = true
        end)
        
        while not requestBack do
            CoYield()
        end
    end)
end

---@param focus boolean
function GachaponSkinPropDescPopUp:OnFocus(focus)
    --LuaBehaviour 没有
end
function GachaponSkinPropDescPopUp:RefreshUI()
    self:RefreshExtra()
    self:RefreshNormal()

    local row = CfUtils.GetCfLine(AutoIds.IdSetting6180, self.activity.activityContentId or 1)
    if isNotNull(row) then
        local ruleId = parse_number(row, "ruleID")
        ---@type ActivityMgr
        local ActivityMgr = import("Game.Activity.ActivityMgr"):GetInstance()
        local rule = ActivityMgr.GetActivityRule(ruleId)
        CfUtils.FillText(self.TxtMain, rule)
    end
end

function GachaponSkinPropDescPopUp:RefreshExtra()
    local extraProbabilityList = Mgr.Sever.lotteryData.extraProbabilityList

    for i, v in ipairs(extraProbabilityList) do
        local group = self.ExtraItems:Find("Group" .. i)
        if group then
            local GoodGroup1 = group:Find("Layout/GoodGroup")
            local GoodGroup2 = group:Find("Layout/GoodGroup2")
            local rewardProbaityData = v.rewardGroup[1]
            --local TxtCount = group:Find("Text1")
            --CfUtils.FillText(TxtCount, localize("第_num_次", {_num_ = v.num}))
            ---@type GoodNodeWithProbability
            local goodNodeEnv = CfUtils.GetLuaScr(GoodGroup1, "Game.Activity.GachaponSkin.GoodNodeWithProbability")
            if goodNodeEnv then
                goodNodeEnv:RefreshData({
                    goodsId = rewardProbaityData.rewards[1].goodsId,
                    text = "x" .. rewardProbaityData.rewards[1].num,
                    isShowNo = true,
                }, rewardProbaityData.probability)
            end
            
            rewardProbaityData = v.rewardGroup[2]
            if rewardProbaityData then
                ---@type GoodNodeWithProbability
                local goodNodeEnv_2 = CfUtils.GetLuaScr(GoodGroup2, "Game.Activity.GachaponSkin.GoodNodeWithProbability")
                if goodNodeEnv_2 then
                    goodNodeEnv_2:RefreshData({
                        goodsId = rewardProbaityData.rewards[1].goodsId,
                        text = "x" .. rewardProbaityData.rewards[1].num,
                        isShowNo = true,
                    }, rewardProbaityData.probability)
                end
            else
                CfUtils.SetActive(GoodGroup2, false)
            end
        end
        --local groupItem = self.groupItems[i]
        --if groupItem then
        --    local rewardProbaityData = v.rewardGroup[1]
        --    CfUtils.FillText(groupItem.TxtCount, localize("第%1次", v.num))
        --    ---@type GoodNodeWithProbability
        --    local goodNodeEnv = CfUtils.GetLuaScr(groupItem.GoodGroup, "Game.Activity.GachaponSkin.GoodNodeWithProbability")
        --    if goodNodeEnv then
        --        goodNodeEnv:RefreshData({
        --            goodsId = rewardProbaityData.rewards[1].goodsId,
        --            text = "x" .. rewardProbaityData.rewards[1].num,
        --            isShowNo = true,
        --        }, rewardProbaityData.probability)
        --    end
        --
        --    rewardProbaityData = v.rewardGroup[2]
        --    ---@type GoodNodeWithProbability
        --    local goodNodeEnv_2 = CfUtils.GetLuaScr(groupItem.GoodGroup_2, "Game.Activity.GachaponSkin.GoodNodeWithProbability")
        --    if goodNodeEnv_2 then
        --        goodNodeEnv_2:RefreshData({
        --            goodsId = rewardProbaityData.rewards[1].goodsId,
        --            text = "x" .. rewardProbaityData.rewards[1].num,
        --            isShowNo = true,
        --        }, rewardProbaityData.probability)
        --    end
        --end
    end
end

function GachaponSkinPropDescPopUp:RefreshNormal()
    self.probabilityList = Mgr.Sever.lotteryData.probabilityList
    ---@type SimpleLoopList
    local normalGoodsListEnv = CfUtils.GetLuaScr(self.NormalGoodsList, "Game.Activity.GachaponSkin.SimpleLoopList")
    if normalGoodsListEnv then
        normalGoodsListEnv:Initialize(#self.probabilityList, Bind(self, self.OnRefreshListItem))
    end
end

function GachaponSkinPropDescPopUp:OnRefreshListItem(go, index)
    local probability = self.probabilityList[index]
    ---@type GoodNodeWithProbability
    local goodNodeEnv = CfUtils.GetLuaScr(go, "Game.Activity.GachaponSkin.GoodNodeWithProbability")
    if goodNodeEnv then
        goodNodeEnv:RefreshData({
            goodsId = probability.rewards[1].goodsId,
            text = "x" .. probability.rewards[1].num,
            isShowNo = true,
        }, probability.probability)
    end
end

return GachaponSkinPropDescPopUp
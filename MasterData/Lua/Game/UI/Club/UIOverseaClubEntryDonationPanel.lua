-------------------------------------------------------------------------------
-- 社团 - 社团首页 - 捐献面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-30 20:43:24
-------------------------------------------------------------------------------

local ROOT_ANIM_NAME = {
    IDLE = 'OverseaClubDonationDialog_Idle',
    SHOW = 'OverseaClubDonationDialog_Entry',
}

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubDonationDialog.prefab > name: OverseaClubDonationDialog
---@class UIOverseaClubEntryDonationPanel
---@field Env                           	UIOverseaClubEntryDonationPanel         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 0    动画根节点
---@field build2EffectNode              	UnityEngine.RectTransform               	@ 1    高级捐赠 特效节点
---@field build2DisableMask             	UnityEngine.RectTransform               	@ 2    高级捐赠 失效节点
---@field build2ConsumeTxt              	UnityEngine.RectTransform               	@ 3    高级捐赠 消耗数量
---@field build2ConsumeIcon             	UnityEngine.RectTransform               	@ 4    高级捐赠 消耗图标
---@field build2ConsumeNode             	UnityEngine.RectTransform               	@ 5    高级捐赠 消耗节点
---@field build2TimeNode                	UnityEngine.RectTransform               	@ 6    高级捐赠 时间节点
---@field build2RewardNode              	UnityEngine.RectTransform               	@ 7    高级捐赠 奖励节点
---@field build2DonationBtn             	UnityEngine.RectTransform               	@ 8    高级捐赠按钮
---@field build1EffectNode              	UnityEngine.RectTransform               	@ 9    普通捐赠 特效节点
---@field build1DisableMask             	UnityEngine.RectTransform               	@ 10   普通捐赠 失效节点
---@field build1ConsumeTxt              	UnityEngine.RectTransform               	@ 11   普通捐赠 消耗数量
---@field build1ConsumeIcon             	UnityEngine.RectTransform               	@ 12   普通捐赠 消耗图标
---@field build1ConsumeNode             	UnityEngine.RectTransform               	@ 13   普通捐赠 消耗节点
---@field build1TimeNode                	UnityEngine.RectTransform               	@ 14   普通捐赠 时间节点
---@field build1RewardNode              	UnityEngine.RectTransform               	@ 15   普通捐赠 奖励节点
---@field build1DonationBtn             	UnityEngine.RectTransform               	@ 16   普通捐赠按钮
local UIOverseaClubEntryDonationPanel = Class('UIOverseaClubEntryDonationPanel')


function UIOverseaClubEntryDonationPanel:__init()
    ---@type CommonGoodsList
    self.build1RewardsList_ = nil
    ---@type CommonGoodsList
    self.build2RewardsList_ = nil
end


function UIOverseaClubEntryDonationPanel:__delete()
    self.build1RewardsList_ = nil
    self.build2RewardsList_ = nil
end


function UIOverseaClubEntryDonationPanel:Awake()
    self.build1RewardsList_ = CfUtils.GetLuaScr(self.build1RewardNode, Constants.UILuaTablePath.ComGoodsList)
    self.build2RewardsList_ = CfUtils.GetLuaScr(self.build2RewardNode, Constants.UILuaTablePath.ComGoodsList)
    SetButtonAction(self.build1DonationBtn, Bind(self, self.OnClickDonationButtonHandler_, ClubUtils.BuildType.NORMAL))
    SetButtonAction(self.build2DonationBtn, Bind(self, self.OnClickDonationButtonHandler_, ClubUtils.BuildType.ADVANCED))
end


function UIOverseaClubEntryDonationPanel:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        self:RefreshPanel()
    end)
end


function UIOverseaClubEntryDonationPanel:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- public

function UIOverseaClubEntryDonationPanel:RefreshPanel()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    local goodsConfMgr = GoodsConfMgr:GetInstance()

    -- build1/2 update state
    self:UpdateBuildState_()
    
    local clubExpRewardId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.CLUB_EXP_ID)
    local build1ClubExpNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD1_GET_EXP)
    local build2ClubExpNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD2_GET_EXP)

    -- build1 rewards info
    local build1RewardId   = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD1_GET_GID)
    local build1RewardNum  = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD1_GET_GNUM)
    local build1ConsumeId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD1_USE_GID)
    local build1ConsumeNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD1_USE_GNUM)
    self.build1RewardsList_:FreshBaseUI({
        {goodsId = build1RewardId, num = build1RewardNum},
        {goodsId = clubExpRewardId, num = build1ClubExpNum},
    }, nil, nil, nil, nil, nil, false)
    
    -- build1 rewards info
    local build2RewardId   = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD2_GET_GID)
    local build2RewardNum  = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD2_GET_GNUM)
    local build2ConsumeId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD2_USE_GID)
    local build2ConsumeNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD2_USE_GNUM)
    self.build2RewardsList_:FreshBaseUI({
        {goodsId = build2RewardId, num = build2RewardNum},
        {goodsId = clubExpRewardId, num = build2ClubExpNum},
    }, nil, nil, nil, nil, nil, false)

    -- build1/2 consume info
    CfUtils.FillImage(self.build1ConsumeIcon, goodsConfMgr:GetGoodsVoById(build1ConsumeId).photoPath)
    CfUtils.FillImage(self.build2ConsumeIcon, goodsConfMgr:GetGoodsVoById(build2ConsumeId).photoPath)
    CfUtils.FillText(self.build1ConsumeTxt, build1ConsumeNum)
    CfUtils.FillText(self.build2ConsumeTxt, build2ConsumeNum)
end


-------------------------------------------------
-- private

function UIOverseaClubEntryDonationPanel:UpdateBuildState_()
    local clubHomeDojo    = ClubUtils.GetClubComp():GetHomeDojo()
    local build1LeftTimes = clubHomeDojo:GetBuildLeftTimes(ClubUtils.BuildType.NORMAL)
    local build2LeftTimes = clubHomeDojo:GetBuildLeftTimes(ClubUtils.BuildType.ADVANCED)
    local isBuild1Usable  = build1LeftTimes > 0
    local isBuild2Usable  = build2LeftTimes > 0

    CfUtils.SetActive(self.build1ConsumeNode, isBuild1Usable)
    CfUtils.SetActive(self.build1EffectNode, isBuild1Usable)
    CfUtils.SetActive(self.build1TimeNode, not isBuild1Usable)
    CfUtils.SetActive(self.build1DisableMask, not isBuild1Usable)

    CfUtils.SetActive(self.build2ConsumeNode, isBuild2Usable)
    CfUtils.SetActive(self.build2EffectNode, isBuild2Usable)
    CfUtils.SetActive(self.build2TimeNode, not isBuild2Usable)
    CfUtils.SetActive(self.build2DisableMask, not isBuild2Usable)
end


-------------------------------------------------
-- handler

function UIOverseaClubEntryDonationPanel:OnClickDonationButtonHandler_(buildType)
    local clubHomeDojo   = ClubUtils.GetClubComp():GetHomeDojo()
    local buildLeftTimes = clubHomeDojo:GetBuildLeftTimes(buildType)

    -- 剩余次数检测
    if buildLeftTimes <= 0 then
        GameUtils.Toast(localize('今日已建设'))
        return
    end

    -- 消耗道具检测
    local buildConsumeId  = ClubUtils.GetParamValue(ClubUtils.ParamsId['BUILD'..buildType..'_USE_GID'])
    local buildConsumeNum = ClubUtils.GetParamValue(ClubUtils.ParamsId['BUILD'..buildType..'_USE_GNUM'])
    local _, errorTips = GoodsUtils.CheckGoodConsume({{goodsId = buildConsumeId, num = buildConsumeNum}})
    if errorTips then
        GameUtils.Toast(errorTips)
        return
    end

    -- 社团建造
    local requestData = {buildType = buildType}
    GameUtils.Request(Interfaces.OverseaClubBuild, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
            
            -- update leftTimes
            clubHomeDojo:SetBuildLeftTimes(buildType, checkInt(responseData.leftBuildTimes))
            self:UpdateBuildState_()

            -- update clubExp
            local addclubExp = checkInt(responseData.contributionPoint) - clubHomeDojo.contributionPoint
            if addclubExp > 0 then
                ClubUtils.GetClubComp():AddClubExp(addclubExp)
            end

            -- update myself point
            local clubExpRewardId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.CLUB_EXP_ID)
            local clubExpRewardNum = ClubUtils.GetParamValue(ClubUtils.ParamsId['BUILD'..buildType..'_GET_EXP'])
            clubHomeDojo:AddMySelfPoint(clubExpRewardNum)

            -- update consume
            GoodsUtils.ConsumeGoods({{goodsId = buildConsumeId, num = buildConsumeNum}}, true)

            -- update clubCoin
            local buildRewardId  = ClubUtils.GetParamValue(ClubUtils.ParamsId['BUILD'..buildType..'_GET_GID'])
            local buildRewardNum = ClubUtils.GetParamValue(ClubUtils.ParamsId['BUILD'..buildType..'_GET_GNUM'])
            local haveRewardNum  = GoodsUtils.GetThingNo(buildRewardId)
            local finalRewardNum = checkInt(responseData.clubPoint)
            local addClubCoinNum = finalRewardNum - haveRewardNum
            if addClubCoinNum > 0 then
                -- draw rewards
                GoodsUtils.DrawRewards({
                    {goodsId = buildRewardId, num = addClubCoinNum}
                })
            end

            -- show rewards
            local rewardList = {
                {goodsId = clubExpRewardId, num = clubExpRewardNum},
                {goodsId = buildRewardId, num = buildRewardNum},
            }
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
        end
    end)
end


return UIOverseaClubEntryDonationPanel

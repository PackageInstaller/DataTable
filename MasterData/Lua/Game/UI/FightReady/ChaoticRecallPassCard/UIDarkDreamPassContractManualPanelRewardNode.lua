-------------------------------------------------------------------------------
-- Pass卡 - 奖励界面 - 奖励列表奖励节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 16:59:47
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.FightReady.ChaoticRecallPassCard.ChaoticRecallPassCardUtils')
local goodsConfMgr  = GoodsConfMgr:GetInstance()

--- from: Assets/BundleResources/Prefabs/ResidentEvent/DarkDreamPassContractManual.prefab > name: Cell1
---@class UIDarkDreamPassContractManualPanelRewardNode                       
---@field Env                           	UIDarkDreamPassContractManualPanelRewardNode
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CanDrawUIFX                   	UnityEngine.RectTransform               	@ 0    可领取特效（悬浮节点没有）
---@field ReceiveBtn                    	UnityEngine.RectTransform               	@ 1    可领取按钮
---@field Paid3GoodsUIFX                	UnityEngine.RectTransform               	@ 2    付费道具3 特效
---@field Paid3GoodsRed                 	UnityEngine.RectTransform               	@ 3    付费道具3 红点
---@field Paid3GoodsLock                	UnityEngine.RectTransform               	@ 4    付费道具3 锁定
---@field Paid3GoodsNode                	UnityEngine.RectTransform               	@ 5    付费道具3 节点
---@field Paid3GoodsRoot                	UnityEngine.RectTransform               	@ 6    付费道具3根节点
---@field Paid2GoodsUIFX                	UnityEngine.RectTransform               	@ 7    付费道具2 特效
---@field Paid2GoodsRed                 	UnityEngine.RectTransform               	@ 8    付费道具2 红点
---@field Paid2GoodsLock                	UnityEngine.RectTransform               	@ 9    付费道具2 锁定
---@field Paid2GoodsNode                	UnityEngine.RectTransform               	@ 10   付费道具2 节点
---@field Paid2GoodsRoot                	UnityEngine.RectTransform               	@ 11   付费道具2根节点
---@field Paid1GoodsUIFX                	UnityEngine.RectTransform               	@ 12   付费道具1 特效
---@field Paid1GoodsRed                 	UnityEngine.RectTransform               	@ 13   付费道具1 红点
---@field Paid1GoodsLock                	UnityEngine.RectTransform               	@ 14   付费道具1 锁定
---@field Paid1GoodsNode                	UnityEngine.RectTransform               	@ 15   付费道具1 节点
---@field Paid1GoodsRoot                	UnityEngine.RectTransform               	@ 16   付费道具1根节点
---@field FreeGoodsUIFX                 	UnityEngine.RectTransform               	@ 17   免费道具 特效
---@field FreeGoodsRed                  	UnityEngine.RectTransform               	@ 18   免费道具 红点
---@field FreeGoodsLock                 	UnityEngine.RectTransform               	@ 19   免费道具 锁定
---@field FreeGoodsNode                 	UnityEngine.RectTransform               	@ 20   免费道具 节点
---@field FreeGoodsRoot                 	UnityEngine.RectTransform               	@ 21   免费道具根节点
---@field LevelTxt                      	UnityEngine.RectTransform               	@ 22   等级文本
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 23   （悬浮节点没有）
local UIDarkDreamPassContractManualPanelRewardNode = Class("UIDarkDreamPassContractManualPanelRewardNode")


function UIDarkDreamPassContractManualPanelRewardNode:__init()
    ---@type GoodNodeMB @ 免费道具节点lua
    self.freeGoodsNodeEnv_ = nil

    ---@type GoodNodeMB @ 付费道具1节点lua
    self.paid1GoodsNodeEnv_ = nil

    ---@type GoodNodeMB @ 付费道具2节点lua
    self.paid2GoodsNodeEnv_ = nil

    ---@type GoodNodeMB @ 付费道具2节点lua
    self.paid3GoodsNodeEnv_ = nil
end


function UIDarkDreamPassContractManualPanelRewardNode:__delete()
    self.freeGoodsNodeEnv_  = nil
    self.paid1GoodsNodeEnv_ = nil
    self.paid2GoodsNodeEnv_ = nil
    self.paid3GoodsNodeEnv_ = nil
end


function UIDarkDreamPassContractManualPanelRewardNode:Awake()
    self.freeGoodsNodeEnv_  = CfUtils.GetLuaScr(self.FreeGoodsNode, Constants.UILuaTablePath.GoodNodeMB)
    self.paid1GoodsNodeEnv_ = CfUtils.GetLuaScr(self.Paid1GoodsNode, Constants.UILuaTablePath.GoodNodeMB)
    self.paid2GoodsNodeEnv_ = CfUtils.GetLuaScr(self.Paid2GoodsNode, Constants.UILuaTablePath.GoodNodeMB)
    self.paid3GoodsNodeEnv_ = CfUtils.GetLuaScr(self.Paid3GoodsNode, Constants.UILuaTablePath.GoodNodeMB)
end


function UIDarkDreamPassContractManualPanelRewardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return ContractRecallPassCardHomeDojo
function UIDarkDreamPassContractManualPanelRewardNode:GetHomeDojo()
    return self.homeDojo_
end
---@param luaIndex ContractRecallPassCardHomeDojo
function UIDarkDreamPassContractManualPanelRewardNode:SetHomeDojo(homeDojo)
    self.homeDojo_ = homeDojo
end


---@return integer
function UIDarkDreamPassContractManualPanelRewardNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIDarkDreamPassContractManualPanelRewardNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UIDarkDreamPassContractManualPanelRewardNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UIDarkDreamPassContractManualPanelRewardNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function UIDarkDreamPassContractManualPanelRewardNode:GetClickDrawCB()
    return self.clickDrawCallback_
end
---@param callback fun(luaIndex:integer):void
function UIDarkDreamPassContractManualPanelRewardNode:SetClickDrawCB(callback)
    self.clickDrawCallback_ = callback
end


-------------------------------------------------
-- private

function UIDarkDreamPassContractManualPanelRewardNode:UpdateCellInfo_()
    local cellData  = self:GetCellData()
    local drawIndex = self:GetLuaIndex()

    ---@type ChaoticRecallPassCardRewardVo
    local rewardVo = checkTable(cellData.rewardVo)
    local rewardId = checkInt(rewardVo.rewardId)

    -- update level text
    local passLevel = checkInt(rewardVo.passLevel)
    CfUtils.FillText(self.LevelTxt, passLevel)

    -- update rewards
    self:UpdateFreeRewardsState_(cellData, drawIndex)
    self:UpdatePaidRewardsState_(cellData, drawIndex)

    -- update state
    local hasCanDraw = self:GetHomeDojo():HasCanDrawRewardsAt(drawIndex)
    CfUtils.SetActive(self.CanDrawUIFX, hasCanDraw)
    CfUtils.SetActive(self.ReceiveBtn, hasCanDraw)
end


function UIDarkDreamPassContractManualPanelRewardNode:UpdateFreeRewardsState_(cellData, drawIndex)
    ---@type ChaoticRecallPassCardRewardVo
    local rewardVo = checkTable(cellData.rewardVo)
    local isUnlock = self:GetHomeDojo():IsUnlockFreeRewardsAt(drawIndex)
    local isDrawn  = self:GetHomeDojo():IsDrawnFreeRewardsAt(drawIndex)

    -- update goods
    local goodsData = cellData.showFreeRewards[1]
    if goodsData then
        CfUtils.SetActive(self.FreeGoodsRoot, true)
        CfUtils.SetActive(self.FreeGoodsLock, false)
        CfUtils.SetActive(self.FreeGoodsUIFX, not isDrawn and isUnlock)
        CfUtils.SetActive(self.FreeGoodsRed, not isDrawn and isUnlock)
        self.freeGoodsNodeEnv_:SetSanXingGainShow(isDrawn)
        self.freeGoodsNodeEnv_:Reload(goodsData)
        self.freeGoodsNodeEnv_:SetClickCallback(function()
            self:OnClickRewardsNodeCallback_(self.FreeGoodsNode, isDrawn, isUnlock, rewardVo.freeDrawId, goodsData)
        end)
    else
        CfUtils.SetActive(self.FreeGoodsRoot, false)
    end
end


function UIDarkDreamPassContractManualPanelRewardNode:UpdatePaidRewardsState_(cellData, drawIndex)
    ---@type ChaoticRecallPassCardRewardVo
    local rewardVo = checkTable(cellData.rewardVo)
    local isUnlock = self:GetHomeDojo():IsUnlockPaidRewardsAt(drawIndex)
    local isDrawn  = self:GetHomeDojo():IsDrawnPaidRewardsAt(drawIndex)
    local isBought = self:GetHomeDojo().isBoughtPassCard

    local goodsData1 = cellData.showPaidRewards[1]
    local goodsData2 = cellData.showPaidRewards[2]
    local goodsData3 = cellData.showPaidRewards[3]
    
    -- update goods1
    if goodsData1 then
        CfUtils.SetActive(self.Paid1GoodsRoot, true)
        CfUtils.SetActive(self.Paid1GoodsLock, not isBought)
        CfUtils.SetActive(self.Paid1GoodsUIFX, not isDrawn and isUnlock)
        CfUtils.SetActive(self.Paid1GoodsRed, not isDrawn and isUnlock)
        self.paid1GoodsNodeEnv_:SetSanXingGainShow(isDrawn)
        self.paid1GoodsNodeEnv_:Reload(goodsData1)
        self.paid1GoodsNodeEnv_:SetClickCallback(function()
            self:OnClickRewardsNodeCallback_(self.Paid1GoodsNode, isDrawn, isUnlock, rewardVo.paidDrawId, goodsData1)
        end)
    else
        CfUtils.SetActive(self.Paid1GoodsRoot, false)
    end

    -- update goods2
    if goodsData2 then
        CfUtils.SetActive(self.Paid2GoodsRoot, true)
        CfUtils.SetActive(self.Paid2GoodsLock, not isBought)
        CfUtils.SetActive(self.Paid2GoodsUIFX, not isDrawn and isUnlock)
        CfUtils.SetActive(self.Paid2GoodsRed, not isDrawn and isUnlock)
        self.paid2GoodsNodeEnv_:SetSanXingGainShow(isDrawn)
        self.paid2GoodsNodeEnv_:Reload(goodsData2)
        self.paid2GoodsNodeEnv_:SetClickCallback(function()
            self:OnClickRewardsNodeCallback_(self.Paid2GoodsNode, isDrawn, isUnlock, rewardVo.paidDrawId, goodsData2)
        end)
    else
        CfUtils.SetActive(self.Paid2GoodsRoot, false)
    end

    -- update goods3
    if goodsData3 then
        CfUtils.SetActive(self.Paid3GoodsRoot, true)
        CfUtils.SetActive(self.Paid3GoodsLock, not isBought)
        CfUtils.SetActive(self.Paid3GoodsUIFX, not isDrawn and isUnlock)
        CfUtils.SetActive(self.Paid3GoodsRed, not isDrawn and isUnlock)
        self.paid3GoodsNodeEnv_:SetSanXingGainShow(isDrawn)
        self.paid3GoodsNodeEnv_:Reload(goodsData3)
        self.paid3GoodsNodeEnv_:SetClickCallback(function()
            self:OnClickRewardsNodeCallback_(self.Paid3GoodsNode, isDrawn, isUnlock, rewardVo.paidDrawId, goodsData3)
        end)
    else
        CfUtils.SetActive(self.Paid3GoodsRoot, false)
    end
end


function UIDarkDreamPassContractManualPanelRewardNode:OnClickRewardsNodeCallback_(goodsNodeGo, isDrawn, isUnlock, drawId, goodsData)
    if isDrawn then
        GameUtils.Toast(localize('奖励已领取'))
        return
    end

    if not isUnlock then
        local goodsId = goodsData.goodsId
        local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
        GameUtils.ShowCommonTipsBoard(goodsNodeGo, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
        -- GameUtils.Toast(localize('奖励未解锁'))
        return
    end

    if self:GetClickDrawCB() then
        self:GetClickDrawCB()(self:GetLuaIndex(), drawId)
    end
end


return UIDarkDreamPassContractManualPanelRewardNode

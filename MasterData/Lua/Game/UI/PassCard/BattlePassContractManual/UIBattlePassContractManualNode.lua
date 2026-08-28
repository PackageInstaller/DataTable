-------------------------------------------------------------------------------
-- Pass卡 - 奖励界面 - 奖励列表奖励节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 16:59:47
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.PassCard.PassCardUtils')
local passCardComp  = PassCardUtils.GetComp()
local goodsConfMgr  = GoodsConfMgr:GetInstance()

--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassContractManual.prefab > name: Cell1
---@class UIBattlePassContractManualNode                       
---@field Env                           	UIBattlePassContractManualNode          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CanDrawUIFX                   	UnityEngine.RectTransform               @ 可领取特效（悬浮节点没有）
---@field ReceiveBtn                    	UnityEngine.RectTransform               @ 可领取按钮
---@field DeluxeGoodsUIFX               	UnityEngine.RectTransform               @ 豪华道具特效
---@field DeluxeGoodsRed                	UnityEngine.RectTransform               @ 豪华道具红点
---@field DeluxeGoodsLock               	UnityEngine.RectTransform               @ 豪华道具锁定
---@field DeluxeGoodsNode               	UnityEngine.RectTransform               @ 豪华道具节点
---@field NormalGoodsUIFX               	UnityEngine.RectTransform               @ 普通道具特效
---@field NormalGoodsRed                	UnityEngine.RectTransform               @ 普通道具红点
---@field NormalGoodsLock               	UnityEngine.RectTransform               @ 普通道具锁定
---@field NormalGoodsNode               	UnityEngine.RectTransform               @ 普通道具节点
---@field FreeGoodsUIFX                 	UnityEngine.RectTransform               @ 免费道具特效
---@field FreeGoodsRed                  	UnityEngine.RectTransform               @ 免费道具红点
---@field FreeGoodsLock                 	UnityEngine.RectTransform               @ 免费道具锁定
---@field FreeGoodsNode                 	UnityEngine.RectTransform               @ 免费道具节点
---@field LevelTxt                      	UnityEngine.RectTransform               @ 等级文本
---@field AnimRoot                      	UnityEngine.RectTransform               @ （悬浮节点没有）
local UIBattlePassContractManualNode = Class("UIBattlePassContractManualNode")


function UIBattlePassContractManualNode:__init()
    ---@type GoodNodeMB @ 免费道具节点lua
    self.freeGoodsNodeEnv_ = nil

    ---@type GoodNodeMB @ 普通道具节点lua
    self.normalGoodsNodeEnv_ = nil

    ---@type GoodNodeMB @ 豪华道具节点lua
    self.deluxeGoodsNodeEnv_ = nil
end


function UIBattlePassContractManualNode:__delete()
    self.freeGoodsNodeEnv_   = nil
    self.normalGoodsNodeEnv_ = nil
    self.deluxeGoodsNodeEnv_ = nil
end

function UIBattlePassContractManualNode:ResetGoodNodeTransform(goodNode)
    local rect = goodNode.gameObject:GetComponent("RectTransform")
    rect.pivot = Vector2.New(0.5, 0.5)
    rect.anchoredPosition = Vector3.New(0, 0, 0)
    rect.anchorMax = Vector2.New(0.5, 0.5)
    rect.anchorMin = Vector2.New(0.5, 0.5)
    rect.localScale = Vector3.New(1, 1, 1)
    CfUtils.SetActive(goodNode, true)
end 


function UIBattlePassContractManualNode:Awake()
    self.FreeGoodsNode   = self.FreeGoodsNodeStub:InstantiatePrefab("GoodNode")
    self.NormalGoodsNode = self.NormalGoodsNodeStub:InstantiatePrefab("GoodNode")
    self.DeluxeGoodsNode = self.DeluxeGoodsNodeStub:InstantiatePrefab("GoodNode")
    self:ResetGoodNodeTransform(self.FreeGoodsNode)
    self:ResetGoodNodeTransform(self.NormalGoodsNode)
    self:ResetGoodNodeTransform(self.DeluxeGoodsNode)
    
    self.freeGoodsNodeEnv_   = CfUtils.GetLuaScr(self.FreeGoodsNode, Constants.UILuaTablePath.GoodNodeMB)
    self.normalGoodsNodeEnv_ = CfUtils.GetLuaScr(self.NormalGoodsNode, Constants.UILuaTablePath.GoodNodeMB)
    self.deluxeGoodsNodeEnv_ = CfUtils.GetLuaScr(self.DeluxeGoodsNode, Constants.UILuaTablePath.GoodNodeMB)
end


function UIBattlePassContractManualNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIBattlePassContractManualNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIBattlePassContractManualNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UIBattlePassContractManualNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UIBattlePassContractManualNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function UIBattlePassContractManualNode:GetClickDrawCB()
    return self.clickDrawCallback_
end
---@param callback fun(luaIndex:integer):void
function UIBattlePassContractManualNode:SetClickDrawCB(callback)
    self.clickDrawCallback_ = callback
end


-------------------------------------------------
-- private

function UIBattlePassContractManualNode:UpdateCellInfo_()
    local cellData  = self:GetCellData()
    local drawIndex = self:GetLuaIndex()

    ---@type PassCardRewardVo
    local rewardVo = checkTable(cellData.rewardVo)
    local rewardId = checkInt(rewardVo.rewardId)

    -- update level text
    local passLevel = checkInt(rewardVo.passLevel)
    CfUtils.FillText(self.LevelTxt, passLevel)

    -- update rewards
    self:UpdateFreeRewardsState_(cellData, drawIndex)
    self:UpdateNormalRewardsState_(cellData, drawIndex)
    self:UpdateDeluxeRewardsState_(cellData, drawIndex)

    -- update state
    local hasCanDraw = passCardComp:HasCanDrawRewardsAt(drawIndex)
    CfUtils.SetActive(self.CanDrawUIFX, hasCanDraw)
    CfUtils.SetActive(self.ReceiveBtn, hasCanDraw)
end

function UIBattlePassContractManualNode:UpdateFreeRewardsState_(cellData, drawIndex)
    ---@type PassCardRewardVo
    local rewardVo = checkTable(cellData.rewardVo)
    local isUnlock = passCardComp:IsUnlockFreeRewardsAt(drawIndex)
    local isDrawn  = passCardComp:IsDrawnFreeRewardsAt(drawIndex)

    -- update state
    CfUtils.SetActive(self.FreeGoodsLock, false)
    CfUtils.SetActive(self.FreeGoodsUIFX, not isDrawn and isUnlock)
    CfUtils.SetActive(self.FreeGoodsRed, not isDrawn and isUnlock)
    self.freeGoodsNodeEnv_:SetSanXingGainShow(isDrawn)

    local goodsData = checkTable(cellData.freeGoodsData)
    CfUtils.RefeshGoodGo(self.FreeGoodsNode, goodsData.goodsId, goodsData.text, 1, nil, function()
        self:OnClickRewardsNodeCallback_(self.FreeGoodsNode, isDrawn, isUnlock, rewardVo.freeDrawId, cellData.freeGoodsData)
    end)
end


function UIBattlePassContractManualNode:UpdateNormalRewardsState_(cellData, drawIndex)
    ---@type PassCardRewardVo
    local rewardVo = checkTable(cellData.rewardVo)
    local isUnlock = passCardComp:IsUnlockNormalRewardsAt(drawIndex)
    local isDrawn  = passCardComp:IsDrawnNormalRewardsAt(drawIndex)
    local isBought = passCardComp:IsUnlockNormalPass()

    -- update state
    CfUtils.SetActive(self.NormalGoodsLock, not isBought)
    CfUtils.SetActive(self.NormalGoodsUIFX, not isDrawn and isUnlock)
    CfUtils.SetActive(self.NormalGoodsRed, not isDrawn and isUnlock)
    self.normalGoodsNodeEnv_:SetSanXingGainShow(isDrawn)

    local goodsData = checkTable(cellData.normalGoodsData)
    CfUtils.RefeshGoodGo(self.NormalGoodsNode, goodsData.goodsId, goodsData.text, 1, nil, function()
        self:OnClickRewardsNodeCallback_(self.NormalGoodsNode, isDrawn, isUnlock, rewardVo.normalDrawId, cellData.normalGoodsData)
    end)
end


function UIBattlePassContractManualNode:UpdateDeluxeRewardsState_(cellData, drawIndex)
    ---@type PassCardRewardVo
    local rewardVo = checkTable(cellData.rewardVo)
    local isUnlock = passCardComp:IsUnlockDeluxeRewardsAt(drawIndex)
    local isDrawn  = passCardComp:IsDrawnDeluxeRewardsAt(drawIndex)
    local isBought = passCardComp:IsUnlockDeluxePass()

    -- update state
    CfUtils.SetActive(self.DeluxeGoodsLock, not isBought)
    CfUtils.SetActive(self.DeluxeGoodsUIFX, not isDrawn and isUnlock)
    CfUtils.SetActive(self.DeluxeGoodsRed, not isDrawn and isUnlock)
    self.deluxeGoodsNodeEnv_:SetSanXingGainShow(isDrawn)

    local goodsData = checkTable(cellData.deluxeGoodsData)
    CfUtils.RefeshGoodGo(self.DeluxeGoodsNode, goodsData.goodsId, goodsData.text, 1, nil, function()
        self:OnClickRewardsNodeCallback_(self.DeluxeGoodsNode, isDrawn, isUnlock, rewardVo.deluxeDrawId, cellData.deluxeGoodsData)
    end)
end


function UIBattlePassContractManualNode:OnClickRewardsNodeCallback_(goodsNodeGo, isDrawn, isUnlock, drawId, freeGoodsData)
    if isDrawn then
        GameUtils.Toast(localize('奖励已领取'))
        return
    end

    if not isUnlock then
        local goodsId = freeGoodsData.goodsId
        local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
        GameUtils.ShowCommonTipsBoard(goodsNodeGo, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
        -- GameUtils.Toast(localize('奖励未解锁'))
        return
    end

    if self:GetClickDrawCB() then
        self:GetClickDrawCB()(self:GetLuaIndex(), drawId)
    end
end


return UIBattlePassContractManualNode

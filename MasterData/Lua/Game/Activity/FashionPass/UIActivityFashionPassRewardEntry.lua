-------------------------------------------------------------------------------
-- Pass卡 - 奖励界面 - 奖励列表奖励节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 16:59:47
-------------------------------------------------------------------------------

local UIModule = CS.Engine.UI.UIModule
local goodsConfMgr  = GoodsConfMgr:GetInstance()

--- from: Assets/BundleResources/Prefabs/Activity/ActivitySkinPassDialog12002701.prefab > name: Cell1
---@class UIActivityFashionPassRewardEntry                       
---@field Env                           	UIActivityFashionPassRewardEntry        
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
---@field BtnAreaBase                   	UnityEngine.RectTransform               	@ 24   
---@field BtnAreaAdvance                	UnityEngine.RectTransform               	@ 25   
local UIActivityFashionPassRewardEntry = Class("UIActivityFashionPassRewardEntry")


function UIActivityFashionPassRewardEntry:__init()
    ---@type GoodNodeMB @ 免费道具节点lua
    self.freeGoodsNodeEnv_ = nil

    ---@type GoodNodeMB @ 付费道具1节点lua
    self.paid1GoodsNodeEnv_ = nil

    ---@type GoodNodeMB @ 付费道具2节点lua
    self.paid2GoodsNodeEnv_ = nil

    ---@type GoodNodeMB @ 付费道具2节点lua
    self.paid3GoodsNodeEnv_ = nil
end


function UIActivityFashionPassRewardEntry:__delete()
    self.freeGoodsNodeEnv_  = nil
    self.paid1GoodsNodeEnv_ = nil
    self.paid2GoodsNodeEnv_ = nil
    self.paid3GoodsNodeEnv_ = nil
end


function UIActivityFashionPassRewardEntry:Awake()
    self.freeGoodsNodeEnv_  = CfUtils.GetLuaScr(self.FreeGoodsNode, Constants.UILuaTablePath.GoodNodeMB)
    self.paid1GoodsNodeEnv_ = CfUtils.GetLuaScr(self.Paid1GoodsNode, Constants.UILuaTablePath.GoodNodeMB)
    self.paid2GoodsNodeEnv_ = CfUtils.GetLuaScr(self.Paid2GoodsNode, Constants.UILuaTablePath.GoodNodeMB)
    self.paid3GoodsNodeEnv_ = CfUtils.GetLuaScr(self.Paid3GoodsNode, Constants.UILuaTablePath.GoodNodeMB)
end


function UIActivityFashionPassRewardEntry:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return ActivityFashionPassComponent
function UIActivityFashionPassRewardEntry:GetComp()
    return self.comp
end

---@param comp ActivityFashionPassComponent
function UIActivityFashionPassRewardEntry:SetComp(comp)
    self.comp = comp
end


---@return integer
function UIActivityFashionPassRewardEntry:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIActivityFashionPassRewardEntry:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UIActivityFashionPassRewardEntry:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UIActivityFashionPassRewardEntry:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function UIActivityFashionPassRewardEntry:GetClickDrawCB()
    return self.clickDrawCallback_
end
---@param callback fun(luaIndex:integer):void
function UIActivityFashionPassRewardEntry:SetClickDrawCB(callback)
    self.clickDrawCallback_ = callback
end


-------------------------------------------------
-- private

function UIActivityFashionPassRewardEntry:UpdateCellInfo_()
    local cellData  = self:GetCellData()
    local drawIndex = self:GetLuaIndex()

    -- update level text
    local passLevel = checkInt(cellData.level)
    CfUtils.FillText(self.LevelTxt, passLevel)

    -- update rewards
    self:UpdateFreeRewardsState_(cellData, drawIndex)
    self:UpdatePaidRewardsState_(cellData, drawIndex)

    -- update state
    local isBought = self:GetComp():HasBoughtPassCard()
    local canDrawBase = not cellData.baseRewardHasDrawn
    local canDrawAdvance = not cellData.advanceRewardHasDrawn and isBought
    local hasCanDraw = cellData.unlock and (canDrawBase or canDrawAdvance)
    CfUtils.SetActive(self.CanDrawUIFX, hasCanDraw)
    CfUtils.SetActive(self.ReceiveBtn, hasCanDraw)

    -- 基础领取按钮区域
    ---@type FashionPassBaseRewardVo
    local baseRewardVo = checkTable(cellData.baseRewardVo)
    local baseProductId = baseRewardVo.id
    CfUtils.SetActive(self.BtnAreaBase, canDrawBase)
    SetButtonAction(self.BtnAreaBase, function()
        if canDrawBase then
            self.comp:RequestDrawLevelReward(baseProductId, function(rewards)
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = DeepCopy(rewards) } })
                if self.clickDrawCallback_ then
                    self.clickDrawCallback_()
                end
            end)
        end
    end)

    -- 进阶领取按钮区域
    ---@type FashionPassAdvanceRewardVo
    local advanceRewardVo = checkTable(cellData.advanceRewardVo)
    local advanceProductId = advanceRewardVo.id
    CfUtils.SetActive(self.BtnAreaAdvance, canDrawAdvance)
    SetButtonAction(self.BtnAreaAdvance, function()
        if canDrawAdvance then
            self.comp:RequestDrawLevelReward(advanceProductId, function(rewards)
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = DeepCopy(rewards) } })
                if self.clickDrawCallback_ then
                    self.clickDrawCallback_()
                end
            end)
        end
    end)
end


function UIActivityFashionPassRewardEntry:UpdateFreeRewardsState_(cellData, drawIndex)
    ---@type FashionPassBaseRewardVo
    local rewardVo = checkTable(cellData.baseRewardVo)
    local isUnlock = cellData.unlock
    local isDrawn  = cellData.baseRewardHasDrawn

    -- update goods
    local goodsData = rewardVo.rewards[1]
    if goodsData then
        local goodsInfo = DeepCopy(goodsData)
        goodsInfo.text = "x"..goodsInfo.goodsNum
        CfUtils.SetActive(self.FreeGoodsRoot, true)
        CfUtils.SetActive(self.FreeGoodsLock, false)
        CfUtils.SetActive(self.FreeGoodsUIFX, not isDrawn and isUnlock)
        CfUtils.SetActive(self.FreeGoodsRed, not isDrawn and isUnlock)
        self.freeGoodsNodeEnv_:SetSanXingGainShow(isDrawn)
        self.freeGoodsNodeEnv_:Reload(goodsInfo)
        self.freeGoodsNodeEnv_:SetClickCallback(function()
            self:OnClickRewardsNodeCallback_(self.FreeGoodsNode, goodsData)
        end)
    else
        CfUtils.SetActive(self.FreeGoodsRoot, false)
    end
end


function UIActivityFashionPassRewardEntry:UpdatePaidRewardsState_(cellData, drawIndex)
    ---@type FashionPassAdvanceRewardVo
    local rewardVo = checkTable(cellData.advanceRewardVo)
    local isUnlock = cellData.unlock
    local isDrawn  = cellData.advanceRewardHasDrawn
    local isBought = self:GetComp():HasBoughtPassCard()

    
    for i = 1, 3, 1 do
        local goodsData = rewardVo.rewards[i]
        if goodsData then
            local goodsInfo = DeepCopy(goodsData)
            goodsInfo.text = "x"..goodsInfo.goodsNum
            CfUtils.SetActive(self['Paid'..i..'GoodsRoot'], true)
            CfUtils.SetActive(self['Paid'..i..'GoodsLock'], not isBought)
            CfUtils.SetActive(self['Paid'..i..'GoodsUIFX'], not isDrawn and isUnlock and isBought)
            CfUtils.SetActive(self['Paid'..i..'GoodsRed'], not isDrawn and isUnlock and isBought)
            self['paid'..i..'GoodsNodeEnv_']:SetSanXingGainShow(isDrawn)
            self['paid'..i..'GoodsNodeEnv_']:Reload(goodsInfo)
            self['paid'..i..'GoodsNodeEnv_']:SetClickCallback(function()
                self:OnClickRewardsNodeCallback_(self['Paid'..i..'GoodsNode'], goodsData)
            end)
        else
            CfUtils.SetActive(self['Paid'..i..'GoodsRoot'], false)
        end
    end
end


function UIActivityFashionPassRewardEntry:OnClickRewardsNodeCallback_(goodsNodeGo, goodsData)
    local goodsId = goodsData.goodsId
    local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
    GameUtils.ShowCommonTipsBoard(goodsNodeGo, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
end

return UIActivityFashionPassRewardEntry

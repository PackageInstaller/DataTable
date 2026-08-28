-------------------------------------------------------------------------------
-- Pass卡 - 购买弹窗 - Pass卡节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-01 20:04:52
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.PassCard.PassCardUtils')
local passCardComp  = PassCardUtils.GetComp()
local goodsConfMgr  = GoodsConfMgr:GetInstance()
local cs_coroutine = require 'XLua.cs_coroutine'
local RewardListCellName = 'Cell'
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassBuyManual.prefab > name: LeftGroup
---@class UIBattlePassBuyManualNode         
---@field Env                           	UIBattlePassBuyManualNode               
---@field controller                    	Engine.Modules.LuaBehaviour    
---@field ImgCardIcon                   	UnityEngine.RectTransform             	    @ 0    (RightGroup only)
---@field ImgBgHead                     	UnityEngine.RectTransform               	@ 1    (RightGroup only)
---@field ItemReward2                   	UnityEngine.RectTransform               	@ 2    (RightGroup only)
---@field ItemReward1                   	UnityEngine.RectTransform               	@ 3    (RightGroup only)
---@field RewardLoopView                	nil                                     	@ 4    (LeftGroup only)         
---@field PriceIcon                     	UnityEngine.RectTransform               	@ 5    
---@field PriceTxt                      	UnityEngine.RectTransform               	@ 6    
---@field Group2                        	UnityEngine.RectTransform               	@ 7    
---@field Group1                        	UnityEngine.RectTransform               	@ 8    
---@field BtnBuy                        	UnityEngine.RectTransform               	@ 9    
---@field TxtTips                       	UnityEngine.RectTransform               	@ 10   
---@field OriginImgIconOld              	UnityEngine.RectTransform               	@ 11   
---@field OriginTxtnumOld               	UnityEngine.RectTransform               	@ 12   
---@field  Discount_2                   	UnityEngine.RectTransform               	@ 13   
---@field DiscountTextDesc              	UnityEngine.RectTransform               	@ 14   
local UIBattlePassBuyManualNode = Class('UIBattlePassBuyManualNode')


function UIBattlePassBuyManualNode:__init()
    ---@type table[] @ 奖励列表
    self.passRewardsList_ = nil
    self.co = nil
    if self.co then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
end


function UIBattlePassBuyManualNode:__delete()
    self.passRewardsList_ = nil
end


function UIBattlePassBuyManualNode:Awake()
    SetButtonAction(self.BtnBuy, Bind(self, self.OnClickBuyButtonHandler_))
    if isNotNull(self.RewardLoopView) then
        SetListViewAction(self.RewardLoopView, Bind(self, self.OnUpdateRewardListCellHandler_), RewardListCellName)    
    end
end


function UIBattlePassBuyManualNode:Start()
end


function UIBattlePassBuyManualNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return PassCardUtils.PassType
function UIBattlePassBuyManualNode:GetPassType()
    return checkInt(self.passType_)
end
function UIBattlePassBuyManualNode:SetPassType(passType)
    self.passType_ = checkInt(passType)
    self:UpdatePassInfo_()
end


---@return fun(passType:PassCardUtils.PassType):void
function UIBattlePassBuyManualNode:GetClickBuyCb()
    return self.clickBuyCallback_
end
function UIBattlePassBuyManualNode:SetClickBuyCb(callback)
    self.clickBuyCallback_ = callback
end


-------------------------------------------------
-- private

function UIBattlePassBuyManualNode:UpdatePassInfo_()
    local scheduleId = passCardComp:GetHomeDojo().scheduleId
    local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)

    if self:GetPassType() == PassCardUtils.PassType.NORMAL then
        self:UpdateNormalPassInfo_(passPlanVo)

    elseif self:GetPassType() == PassCardUtils.PassType.DELUXE then
        self:UpdateDeluxePassnfo_(passPlanVo)
    end
end


---@param passPlanVo PassCardPlanVo
function UIBattlePassBuyManualNode:UpdateNormalPassInfo_(passPlanVo)
    -- update tips
    CfUtils.FillText(self.TxtTips, passPlanVo.normalPassDescr)

    -- update state
    local hasNormalPass = passCardComp:IsUnlockNormalPass()
    CfUtils.SetActive(self.Group1, not hasNormalPass)
    CfUtils.SetActive(self.Group2, hasNormalPass)
    -- update price
    if not hasNormalPass then
        local productDojo  = passCardComp:GetNormalProductDojo()
        if #checkTable(productDojo.prices) > 0 then
            local priceData = checkTable(productDojo.prices[1])
            local usableGoodComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.UsableGoodComponent)
            local good = usableGoodComponent:GetGoodShortestTimeByEffectType(504)
            if good and checkInt(good.remainTime) > 0 then
                ---@type LimitGoodsVo
                local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(good.goodsId)

                CfUtils.FillText(self.OriginTxtnumOld, tostring(priceData.num))
                CfUtils.FillImage(self.OriginImgIconOld, goodsConfMgr:GetPhotoPathById(priceData.goodsId))
                CfUtils.SetActive(self.OriginImgIconOld, true)
                CfUtils.SetActive(self.OriginTxtnumOld, true)
                CfUtils.FillText(self.PriceTxt, tostring(priceData.num - goodsVo.effectNum))
                CfUtils.FillImage(self.PriceIcon, goodsConfMgr:GetPhotoPathById(priceData.goodsId))
                CfUtils.SetActive(self.PriceIcon, true)
                CfUtils.SetActive(self.Discount_2 , true)
                CfUtils.FillImage(self.ImgPropsIcon , goodsVo.photoPath )
                self:AddCoTime(good)
            else 
                CfUtils.SetActive(self.OriginImgIconOld, false)
                CfUtils.SetActive(self.OriginTxtnumOld, false)
                CfUtils.SetActive(self.Discount_2 , false)
                CfUtils.FillText(self.PriceTxt, tostring(priceData.num))
                CfUtils.FillImage(self.PriceIcon, goodsConfMgr:GetPhotoPathById(priceData.goodsId))
                CfUtils.SetActive(self.PriceIcon, true)
                self:AddCoTime()
            end
        else
            self:AddCoTime()
            CfUtils.SetActive(self.OriginImgIconOld, false)
            CfUtils.SetActive(self.OriginTxtnumOld, false)
            CfUtils.SetActive(self.Discount_2 , false)
            local priceData = CfUtils.GetPayData(productDojo.price, productDojo.channelProductId) or {}
            CfUtils.FillText(self.PriceTxt, string.fmt('<size=40>%1</size>%2', priceData.currencySymbol, priceData.price))
            CfUtils.SetActive(self.PriceIcon, false)
        end
    end

    -- update rewards
    self.passRewardsList_ = {}
    for _, rewardData in ipairs(passCardComp:GetAllNormalRewardDataList()) do
        local goodsId = rewardData.goodsId
        local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
        table.insert(self.passRewardsList_, {
            num     = rewardData.num,
            goodsId = goodsId,
            goodsVo = goodsVo,
        })
    end
    GameUtils.ReloadData(self.RewardLoopView, #self.passRewardsList_)
end
function UIBattlePassBuyManualNode:AddCoTime(usableGoodDojo)
    if self.co then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
    if isNull(usableGoodDojo) then
        return
    end
    self.co = cs_coroutine.start(function()
        while usableGoodDojo.remainTime > 0 do
            cs_coroutine.yield_return(WaitForSeconds(1))
            CfUtils.FillText(self.DiscountTextDesc  , localize("折扣倒计时：_time_" , {_time_ = CfUtils.GetTimeHMS2( usableGoodDojo.remainTime )})) 
        end
        self:UpdatePassInfo_()
    end)
end

---@param passPlanVo PassCardPlanVo
function UIBattlePassBuyManualNode:UpdateDeluxePassnfo_(passPlanVo)
    local scheduleId = passCardComp:GetHomeDojo().scheduleId
    local passPlanVo = PassCardUtils.GetPassCardPlanVo(scheduleId)

    -- update tips
    CfUtils.FillText(self.TxtTips, passPlanVo.deluxePassDescr)

    -- update state
    local hasNormalPass = passCardComp:IsUnlockNormalPass()
    local hasDeluxePass = passCardComp:IsUnlockDeluxePass()
    CfUtils.SetActive(self.Group1, not hasDeluxePass)
    CfUtils.SetActive(self.Group2, hasDeluxePass)
    -- update price
    if not hasDeluxePass then
        local productDojo  = hasNormalPass and passCardComp:GetDeluxeDiffProductDojo() or passCardComp:GetDeluxeProductDojo()
        if #checkTable(productDojo.prices) > 0 then
            if not hasNormalPass then
                local usableGoodComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.UsableGoodComponent)
                local good = usableGoodComponent:GetGoodShortestTimeByEffectType(504)
                local priceData = checkTable(productDojo.prices[1])
                if good and checkInt(good.remainTime) > 0 then
                    ---@type LimitGoodsVo
                    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(good.goodsId)
                    CfUtils.FillText(self.OriginTxtnumOld, tostring(priceData.num))
                    CfUtils.FillImage(self.OriginImgIconOld, goodsConfMgr:GetPhotoPathById(priceData.goodsId))
                    CfUtils.SetActive(self.OriginImgIconOld, true)
                    CfUtils.SetActive(self.OriginTxtnumOld, true)
                    CfUtils.SetActive(self.Discount_2 , true)
                    CfUtils.FillText(self.PriceTxt, tostring(priceData.num - goodsVo.effectNum))
                    CfUtils.FillImage(self.PriceIcon, goodsConfMgr:GetPhotoPathById(priceData.goodsId))
                    CfUtils.SetActive(self.PriceIcon, true)
                    CfUtils.FillImage(self.ImgPropsIcon , goodsVo.photoPath)
                    self:AddCoTime(good)
                else 
                    CfUtils.SetActive(self.Discount_2 , false)
                    CfUtils.SetActive(self.OriginImgIconOld, false)
                    CfUtils.SetActive(self.OriginTxtnumOld, false)
                    CfUtils.FillText(self.PriceTxt, tostring(priceData.num))
                    CfUtils.FillImage(self.PriceIcon, goodsConfMgr:GetPhotoPathById(priceData.goodsId))
                    CfUtils.SetActive(self.PriceIcon, true)
                    self:AddCoTime()
                end
            else 
                CfUtils.SetActive(self.Discount_2 , false)
                CfUtils.SetActive(self.OriginImgIconOld, false)
                CfUtils.SetActive(self.OriginTxtnumOld, false)
                local priceData = checkTable(productDojo.prices[1])
                CfUtils.FillText(self.PriceTxt, tostring(priceData.num))
                CfUtils.FillImage(self.PriceIcon, goodsConfMgr:GetPhotoPathById(priceData.goodsId))
                CfUtils.SetActive(self.PriceIcon, true)
                self:AddCoTime()
            end
        else
            CfUtils.SetActive(self.Discount_2 , false)
            CfUtils.SetActive(self.OriginImgIconOld, false)
            CfUtils.SetActive(self.OriginTxtnumOld, false)
            local priceData = CfUtils.GetPayData(productDojo.price, productDojo.channelProductId) or {}
            CfUtils.FillText(self.PriceTxt, string.fmt('<size=40>%1</size>%2', priceData.currencySymbol, priceData.price))
            CfUtils.SetActive(self.PriceIcon, false)
            self:AddCoTime()
        end
    end

    -- update rewards
    local allRewardDataMap = passCardComp:GetAllDeluxeRewardDataMap()
    local deluxeShowGoods  = checkTable(passPlanVo.deluxeShowGoods)
    self:UpdateRewardNode_(self.ItemReward1, checkTable(allRewardDataMap[tostring(deluxeShowGoods[1])]))
    self:UpdateRewardNode_(self.ItemReward2, checkTable(allRewardDataMap[tostring(deluxeShowGoods[2])]))

    -- update lobby
    if passCardComp:IsPassLobbyIsCard() then
        local lobbyCardId = passCardComp:GetPassLobbyCardId()
        local lobbyCardVo = lobbyCardId > 0 and CardConfMgr:GetInstance():GetCardByRefId(lobbyCardId) or nil
        local lobbySkinVo = lobbyCardVo and CardConfMgr:GetInstance():GetCardSkinBySkinId(lobbyCardVo.defaultSkin) or nil
        if lobbySkinVo then
            CfUtils.FillImage(self.ImgCardIcon, lobbySkinVo.buffHead)
        end
    else
        local lobbyGodosId = passCardComp:GetPassLobbyCardId()
        if lobbyGodosId > 0 then
            local lobbyGodosIcon = GoodsUtils.GetGoodsIconById(lobbyGodosId)
            CfUtils.FillImage(self.ImgCardIcon, lobbyGodosIcon)
        end
    end
end


---@param goodsNode UnityEngine.Transform
---@param goodsData table
function UIBattlePassBuyManualNode:UpdateRewardNode_(goodsNode, goodsData)
    local goodsIconImg = goodsNode:Find('ImgIcon')
    local goodsNameTxt = goodsNode:Find('TxtIconName')
    local goodsNumTxt  = goodsNode:Find('TxtIconNum')
    local cardHeadNode = goodsNode:Find('ImgBgHead')
    local cardHeadIcon = goodsNode:Find('ImgBgHead/ImgCardIcon')

    local goodsId   = checkInt(goodsData.goodsId)
    local goodsVo   = goodsConfMgr:GetGoodsVoById(goodsId)
    local goodsType = GoodsUtils.GetIdType(goodsId)
    local goodsNum  = checkInt(goodsData.num)
    CfUtils.FillText(goodsNameTxt, goodsVo and goodsVo.name or goodsId)
    CfUtils.FillText(goodsNumTxt, string.fmt('x%1', goodsNum))

    if goodsType == Constants.IDType.CharacterCard then
        CfUtils.SetActive(goodsIconImg, false)
        CfUtils.SetActive(cardHeadNode, true)
        local cardVo = CardConfMgr:GetInstance():GetCardByRefId(goodsId)
        local skinVo = CardConfMgr:GetInstance():GetCardSkinBySkinId(cardVo.defaultSkin)
        CfUtils.FillImage(cardHeadIcon, skinVo.buffHead)

    else
        CfUtils.SetActive(goodsIconImg, true)
        CfUtils.SetActive(cardHeadNode, false)
        CfUtils.FillImage(goodsIconImg, goodsVo and goodsVo.photoPath or '')
    end

    SetButtonAction(goodsNode, function()
        GameUtils.ShowCommonTipsBoard(goodsNode, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
    end)
end


-------------------------------------------------
-- handler

function UIBattlePassBuyManualNode:OnClickBuyButtonHandler_()
    if self:GetClickBuyCb() then
        self:GetClickBuyCb()(self:GetPassType())
    end
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIBattlePassBuyManualNode:OnUpdateRewardListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(RewardListCellName)
    local cellData = checkTable(self.passRewardsList_[luaIndex])
    self:UpdateRewardNode_(cellNode.transform:Find('Root/Item'), cellData)
    return cellNode
end


return UIBattlePassBuyManualNode

-------------------------------------------------------------------------------
-- Pass卡 - 购买弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-01 20:04:52
-------------------------------------------------------------------------------

local SDKService        = import('Game.Entry.SDKService')
local IdolLive3D_Utils  = import('Game.IdolLive3D.IdolLive3D_Utils')
local IdolLive3D_Loader = import('Game.IdolLive3D.IdolLive3D_Loader')
local PassCardUtils     = import('Game.UI.PassCard.PassCardUtils')
local passCardComp      = PassCardUtils.GetComp()
local serverDifferenceMgr = import('Game.Setting.ServerDifferenceMgr'):GetInstance()
local KTool = CS.Engine.Lib.KTool

local PassNodePath = 'Game.UI.PassCard.BattlePassBuyManual.UIBattlePassBuyManualNode'

local RootAnimName = {
    SHOW = 'BattlePassBuyManual_Entry',
    HIDE = 'BattlePassBuyManual_Out',
}

--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassBuyManual.prefab > name: BattlePassBuyManual
---@class UIBattlePassBuyManualDialog
---@field Env                           	UIBattlePassBuyManualDialog             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field InteractiveGroup              	UnityEngine.RectTransform               	@ 0    可交互标识
---@field CardNameTxt                   	UnityEngine.RectTransform               	@ 1    卡牌名字文本
---@field BossDrawingNode               	Game.Native.Common.DrawingNode          	@ 2    卡牌立绘节点
---@field BtnRoleNameNode               	UnityEngine.RectTransform               	@ 3    卡牌名字节点
---@field RightGroup                    	UnityEngine.RectTransform               	@ 4    豪华Pass卡节点
---@field LeftGroup                     	UnityEngine.RectTransform               	@ 5    普通Pass卡节点
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 6    动画根节点
---@field LobbySpecialIcon              	UnityEngine.RectTransform               	@ 7    展示角色 开服限定图标
---@field LobbyCardSlogan               	UnityEngine.RectTransform               	@ 8    展示角色 介绍节点
---@field LobbyRootNode                 	UnityEngine.RectTransform               	@ 9    展示角色 根节点
---@field GoodsRootNode                 	UnityEngine.RectTransform               	@ 10   展示道具 根节点
---@field GoodsRewardNameTxt            	UnityEngine.RectTransform               	@ 11   展示道具 名称文本
local UIBattlePassBuyManualDialog = Class('UIBattlePassBuyManualDialog')


function UIBattlePassBuyManualDialog:__init()
    ---@type UIBattlePassBuyManualNode
    self.normalPassNodeEnv_ = nil

    ---@type UIBattlePassBuyManualNode
    self.deluxePassNodeEnv_ = nil

    ---@type PassCardUtils.PassType
    self.targetBuyPassType_ = nil

    ---@type PassCardHomeProductDojo
    self.targetProductDojo_ = nil
end


function UIBattlePassBuyManualDialog:__delete()
    self.normalPassNodeEnv_ = nil
    self.deluxePassNodeEnv_ = nil
    self.targetBuyPassType_ = nil
    self.targetProductDojo_ = nil
end


function UIBattlePassBuyManualDialog:Awake()
    self.OnEventSdkEvent_   = Events.AddListener(Constants.EventNames.EVENT_SDK, Bind(self, self.OnEventSdkEventHandler_))
    self.normalPassNodeEnv_ = CfUtils.GetLuaScr(self.LeftGroup, PassNodePath)
    self.deluxePassNodeEnv_ = CfUtils.GetLuaScr(self.RightGroup, PassNodePath)
    SetButtonAction(self.InteractiveGroup, Bind(self, self.OnClickLobbyInteractiveHandler_))
end


function UIBattlePassBuyManualDialog:OnDestroy()
    Events.RemoveListener(Constants.EventNames.EVENT_SDK, self.OnEventSdkEvent_)
    self:FixedSdkPayCheckClean_()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- public

function UIBattlePassBuyManualDialog:DoShow()
    local isLobbyCard = passCardComp:IsPassLobbyIsCard()
    CfUtils.SetActive(self.LobbyRootNode, isLobbyCard)
    CfUtils.SetActive(self.LobbyCardSlogan, isLobbyCard)
    CfUtils.SetActive(self.GoodsRootNode, not isLobbyCard)
    if isLobbyCard then
        self:UpdateLobbyCard_()
    else
        self:UpdateLobbyGoods_()
    end
    self:UpdateAllPassInfo_()
    CfUtils.WaitPlayAnimationTo(self.AnimRoot, RootAnimName.SHOW)
end


function UIBattlePassBuyManualDialog:DoHide()
    self:FixedSdkPayCheckClean_()
    CfUtils.WaitPlayAnimationTo(self.AnimRoot, RootAnimName.HIDE, function()
        Events.Broadcast(PassCardUtils.EventName.PASS_CARD_BUY_DIALOG, false)
    end)
end


-------------------------------------------------
-- private

function UIBattlePassBuyManualDialog:UpdateLobbyGoods_()
    local lobbyGodosId = passCardComp:GetPassLobbyCardId()
    if lobbyGodosId == 0 then return end

    local lobbyGodosName = GoodsUtils.GetGoodsNameById(lobbyGodosId)
    CfUtils.FillText(self.GoodsRewardNameTxt, lobbyGodosName)
end


function UIBattlePassBuyManualDialog:UpdateLobbyCard_()
    local lobbyCardId = passCardComp:GetPassLobbyCardId()
    if lobbyCardId == 0 then return end

    local lobbyCardVo = CardConfMgr:GetInstance():GetCardByRefId(lobbyCardId)
    if not lobbyCardVo then return end

    -- update card name
    local roleNameEnv = CfUtils.GetLuaScr(self.BtnRoleNameNode, Constants.UILuaTablePath.RoleNameNode)
    roleNameEnv:RefreshSelf(lobbyCardId, lobbyCardVo.rare, function(showCard)

        ---@type BattlePassEntryDialog
        local entryDialog = CfUtils.DialogGet(Constants.UITypeIds.UIBattlePassEntryDialog)
        if entryDialog then
            entryDialog.Argument.parameters.isShowBuyDialog = true
        end

        -- open preview
        local GachaponUtils = import('Game.Gachapon.GachaponUtils')
        GachaponUtils.OpenDetail(showCard, { UIArgs(Constants.UITypeIds.UIBattlePassEntryDialog) })
    end)

    -- update card draw
    self.BossDrawingNode:Execute(checkInt(lobbyCardVo.defaultSkin))

    -- update card name
    CfUtils.FillText(self.CardNameTxt, lobbyCardVo.name)

    -- update live3d mark
    self:RefreshLive3DBtn_( lobbyCardVo.defaultSkin )

    -- update special icon
    local passCardHomeDojo = passCardComp:GetHomeDojo()
    local passCardPlanVo   = PassCardUtils.GetPassCardPlanVo(passCardHomeDojo.scheduleId)
    CfUtils.SetActive(self.LobbySpecialIcon, passCardPlanVo.specialIcon == 1)
end


function UIBattlePassBuyManualDialog:UpdateAllPassInfo_()
    self:UpdateNormalPassInfo_()
    self:UpdateDeluxePassInfo_()
end


function UIBattlePassBuyManualDialog:UpdateNormalPassInfo_()
    self.normalPassNodeEnv_:SetPassType(PassCardUtils.PassType.NORMAL)
    self.normalPassNodeEnv_:SetClickBuyCb(Bind(self, self.OnClickNormalBuyCallback_))
end


function UIBattlePassBuyManualDialog:UpdateDeluxePassInfo_()
    self.deluxePassNodeEnv_:SetPassType(PassCardUtils.PassType.DELUXE)
    self.deluxePassNodeEnv_:SetClickBuyCb(Bind(self, self.OnClickDeluxeBuyCallback_))
end


function UIBattlePassBuyManualDialog:FixedSdkPayCheckClean_()
    if self.coFixedSdkPayCheck_ then
        CoStop(self.coFixedSdkPayCheck_)
        self.coFixedSdkPayCheck_ = nil
    end
end
function UIBattlePassBuyManualDialog:FixedSdkPayCheckStart_()
    self:FixedSdkPayCheckClean_()
    self.coFixedSdkPayCheck_ = CoStart(function()
        CoYield(1)  -- 延迟1秒，等待sdk支付的成功消息

        if self.targetBuyPassType_ ~= nil then
            local isSync = false
            passCardComp:SyncPassHomeData(function()
                isSync = true
                self.coFixedSdkPayCheck_ = nil

                -- 是否还未收到支付成功消息，为空就是已处理
                if self.targetBuyPassType_ ~= nil then
                    local channelProductId = self.targetProductDojo_.channelProductId

                    if self.targetBuyPassType_ == PassCardUtils.PassType.NORMAL then
                        -- 判断服务器最新数据是否处理为已几所需，未解锁则继续请求检测
                        if passCardComp:IsUnlockNormalPass() then
                            self:OnEventSdkEventHandler_({event = Constants.EventNames.EVENT_SDK_PAY, productId = channelProductId, isSyncHome = true})
                        else
                            self:FixedSdkPayCheckStart_()
                        end

                    elseif self.targetBuyPassType_ == PassCardUtils.PassType.DELUXE then
                        -- 判断服务器最新数据是否处理为已几所需，未解锁则继续请求检测
                        if passCardComp:IsUnlockDeluxePass() then
                            self:OnEventSdkEventHandler_({event = Constants.EventNames.EVENT_SDK_PAY, productId = channelProductId, isSyncHome = true})
                        else
                            self:FixedSdkPayCheckStart_()
                        end
                    end

                end
            end)
            while not isSync do
                CoYield()
            end
        else
            self.coFixedSdkPayCheck_ = nil
        end
    end)
end


-------------------------------------------------
-- handler

function UIBattlePassBuyManualDialog:OnEventSdkEventHandler_(parameters)
    --- sdk pay succeed
    if parameters.event == Constants.EventNames.EVENT_SDK_PAY then
        if self.targetBuyPassType_ and self.targetProductDojo_ and parameters.productId == self.targetProductDojo_.channelProductId then

            -- update passType
            passCardComp:UpdatePassCardType(self.targetBuyPassType_)
            self:UpdateAllPassInfo_()

            if self.targetBuyPassType_ == PassCardUtils.PassType.DELUXE then
                -- update passExp
                local addPassCardExp = PassCardUtils.ConvertPassUpgradeExp() * 10
                local newPassCardExp = passCardComp:GetHomeDojo().passCardTotalExp + addPassCardExp
                -- 如果是通过home请求同步来的最新数据，则不再本地增加经验值，会出现重复加的问题
                if not parameters.isSyncHome then
                    passCardComp:UpdatePassCardExp(newPassCardExp)
                end

                -- show rewards
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = {
                    {goodsId = passCardComp:GetPassExpGoodsId(), num = addPassCardExp},
                }})
            end
  
            -- 发送打点日志
            if self.targetBuyPassType_ == PassCardUtils.PassType.DELUXE then
                xRecord.af_internal("pay_senior_pass")
            elseif self.targetBuyPassType_ == PassCardUtils.PassType.NORMAL then
                xRecord.af_internal("pay_normal_pass")
            end

            self.targetBuyPassType_ = nil
            self.targetProductDojo_ = nil
            self:FixedSdkPayCheckClean_()
        end
    end
end


---@param passType PassCardUtils.PassType
function UIBattlePassBuyManualDialog:OnClickNormalBuyCallback_(passType)
    if passCardComp:IsUnlockNormalPass() then
        return
    end

    xRecord.record('3-018')
    self.targetBuyPassType_ = PassCardUtils.PassType.NORMAL
    self.targetProductDojo_ = passCardComp:GetNormalProductDojo()
    if #checkTable(self.targetProductDojo_.prices) > 0 then
        self:DoDiamondBuyPassProduct_(self.targetProductDojo_)
    else
        self:FixedSdkPayCheckStart_()
        local passProductDojo = self.targetProductDojo_
        local passProductName = PassCardUtils.GetParamDescr(PassCardUtils.ParamsId.NORMAL_PARSS_NAME)
        SDKService:GetInstance():PayMoney({
            productId        = passProductDojo.productId,
            channelProductId = passProductDojo.channelProductId,
            productDesc      = passProductName,
            payAmount        = passProductDojo.price,
            data             = passProductDojo.originData
        })
    end
end


---@param passType PassCardUtils.PassType
function UIBattlePassBuyManualDialog:OnClickDeluxeBuyCallback_(passType)
    if passCardComp:IsUnlockDeluxePass() then
        return
    end

    xRecord.record('3-019')
    self.targetBuyPassType_ = PassCardUtils.PassType.DELUXE
    self.targetProductDojo_ = passCardComp:IsUnlockNormalPass() and passCardComp:GetDeluxeDiffProductDojo() or passCardComp:GetDeluxeProductDojo()
    if #checkTable(self.targetProductDojo_.prices) > 0 then
        self:DoDiamondBuyPassProduct_(self.targetProductDojo_)
    else
        self:FixedSdkPayCheckStart_()
        local passProductDojo = self.targetProductDojo_
        local passProductName = PassCardUtils.GetParamDescr(PassCardUtils.ParamsId.DELUXE_PARSS_NAME)
        SDKService:GetInstance():PayMoney({
            productId        = passProductDojo.productId,
            channelProductId = passProductDojo.channelProductId,
            productDesc      = passProductName,
            payAmount        = passProductDojo.price,
            data             = passProductDojo.originData
        })
    end
end


---@param passProductDojo PassCardHomeProductDojo
function UIBattlePassBuyManualDialog:DoDiamondBuyPassProduct_(passProductDojo)
    local toBuyPassProduct = function()
        local requestData = {productId = passProductDojo.productId}
        GameUtils.Request(Interfaces.OverseaPassCardDiamondBuy, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)

                -- 消耗钻石
                
                if checkInt(responseData.usedDiscountItemId) > 0 then
                     ---@type UsableGoodComponent
                    local usableGoodComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.UsableGoodComponent)
                    local goods = usableGoodComponent:GetGoodsEffectType(504)

                    local oneGoods = goods[tostring(responseData.usedDiscountItemId)]
                    ---@type LimitGoodsVo
                    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(oneGoods.goodsId)
                    if checkInt(oneGoods.goodsId) > 0 then
                        local onePassProductDojo = clone(passProductDojo)
                        onePassProductDojo.prices[1].num = onePassProductDojo.prices[1].num - goodsVo.effectNum
                        GoodsUtils.ConsumeGoods(onePassProductDojo.prices , true)
                    else 
                        GoodsUtils.ConsumeGoods(passProductDojo.prices, true)        
                    end 
                    usableGoodComponent:DeleteGoodsNo(oneGoods)
                else
                    GoodsUtils.ConsumeGoods(passProductDojo.prices, true)
                end
                -- 刷新界面
                self.targetBuyPassType_ = checkInt(responseData.bought)
                self:OnEventSdkEventHandler_({event = Constants.EventNames.EVENT_SDK_PAY, productId = passProductDojo.channelProductId})
                local name = ""
                if targetBuyPassType_ == PassCardUtils.PassType.DELUXE then
                    name = "Contract->Deluxe"
                elseif targetBuyPassType_ == PassCardUtils.PassType.NORMAL then
                    name = "Contract->Advanced"
                end
                
                if string.len(name) > 0  then
                    local game_order_id = tostring(os.time()) 
                    local payment_time = tostring(os.time()) 
                    local product_id = tostring(passProductDojo.productId) 
                    local product_name = name
                    local price = tostring( - passProductDojo.prices[1].num) 
                    local currency = tostring(passProductDojo.prices[1].goodsId) 
                    local quantity = "1"
                    local SDKService = import('Game.Entry.SDKService'):GetInstance()
                    local marketTable = {
                        game_order_id = game_order_id,
                        payment_time = payment_time,
                        product_id = product_id,
                        product_name = product_name,
                        price = price,
                        currency = currency,
                        quantity = quantity
                    }
                    SDKService:IngamemarketActivity(marketTable)
                end
               
            end
        end)
    end
    local usableGoodComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.UsableGoodComponent)
    local good = usableGoodComponent:GetGoodShortestTimeByEffectType(504)
    local reduceNum = 0
    if isNotNull(good) and (not passCardComp:IsUnlockNormalPass()) then
        ---@type LimitGoodsVo
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(good.goodsId)
        reduceNum = goodsVo.effectNum
    end
    local _, errorTips = GoodsUtils.CheckGoodConsume(passProductDojo.prices)
    if errorTips then
        if serverDifferenceMgr:IsSecondaryCurrencyEnable() then
            local priceData = checkTable(passProductDojo.prices[1])
            serverDifferenceMgr:WrapPrimaryCurrencyBuy({currency = priceData.goodsId, current = priceData.num - reduceNum}, function(isSuccess)
                if checkBool(isSuccess) then
                    toBuyPassProduct()
                end
            end)
        else
            GameUtils.Toast(errorTips)
        end
        return
    end
    local priceData = checkTable(passProductDojo.prices[1])
    local consumeVo = GoodsConfMgr:GetInstance():GetGoodsVoById(priceData.goodsId)
    local text = localize("确认花费_Num__Name_购买商品?", {_Num_ = priceData.num -  reduceNum, _Name_ = consumeVo.name})
    GameUtils.SecondConfirm(text, toBuyPassProduct, nil)
end


function UIBattlePassBuyManualDialog:RefreshLive3DBtn_( skinID_ )
    local skinId = skinID_
    local btnTF = self.InteractiveGroup
    -- !! 目前没灰色

    if isNotNull(IdolLive3D_Utils.GetLive3DCardVoRow(skinId)) then -- 这个皮肤支持 深度互动
        --if IdolLive3D_Utils.IsBuyThisSkinsLive3D(skinId) == false then -- 没额外购买这个皮肤的 深度互动服务
            -- todo: 置灰
        --end
        KTool.SetActive( btnTF.gameObject, true )
    else 
        KTool.SetActive( btnTF.gameObject, false )
    end 
end



--- 看板形象深度互动
function UIBattlePassBuyManualDialog:OnClickLobbyInteractiveHandler_()
    local lobbyCardId = passCardComp:GetPassLobbyCardId()
    if lobbyCardId == 0 then
        return
    end

    local lobbyCardVo = CardConfMgr:GetInstance():GetCardByRefId(lobbyCardId)
    if not lobbyCardVo then
        return
    end

    ---@type BattlePassEntryDialog
    local entryDialog = CfUtils.DialogGet(Constants.UITypeIds.UIBattlePassEntryDialog)
    if entryDialog then
        entryDialog.Argument.parameters.isShowBuyDialog = true
    end

    ---
    local skinId = checkInt(lobbyCardVo.defaultSkin)
    IdolLive3D_Loader.TryOpenScene( skinId )        -- !! 目前(2024/08/08) 这个按钮似乎无法进入深度互动,  设计如此
end


return UIBattlePassBuyManualDialog

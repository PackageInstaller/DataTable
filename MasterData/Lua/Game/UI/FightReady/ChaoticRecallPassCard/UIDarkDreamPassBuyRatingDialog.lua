-------------------------------------------------------------------------------
-- 噩梦回响Pass卡 - 购买等级弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-17 16:49:32
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.FightReady.ChaoticRecallPassCard.ChaoticRecallPassCardUtils')
local goodsConfMgr  = GoodsConfMgr:GetInstance()
local serverDifferenceMgr = import('Game.Setting.ServerDifferenceMgr'):GetInstance()

local RewardsGridCellName = 'GoodNode'

--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassBuyRating.prefab > name: DarkDreamPassBuyRating
---@class UIDarkDreamPassBuyRatingDialog
---@field Env                           	UIDarkDreamPassBuyRatingDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field AchieveNumTxt                 	UnityEngine.RectTransform               	@ 0    目标等级文本
---@field Achieve                       	UnityEngine.RectTransform               	@ 1    
---@field CurrentNumTxt                 	UnityEngine.RectTransform               	@ 2    当前等级文本
---@field Current                       	UnityEngine.RectTransform               	@ 3    
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 4    
---@field LevelPromotion                	UnityEngine.RectTransform               	@ 5    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 6    关闭按钮
---@field FontStyleWithIconButton       	Game.Native.Common.FontStyleButton      	@ 7    重置按钮
---@field FontStyleWithGoodIconButton   	UnityEngine.RectTransform               	@ 8    购买按钮
---@field BtnAddTen                     	UnityEngine.RectTransform               	@ 9    购买数量 加十按钮
---@field BtnMinusTen                   	UnityEngine.RectTransform               	@ 10   购买数量 减十按钮
---@field BtnMinus                      	UnityEngine.RectTransform               	@ 11   购买数量 减一按钮
---@field BtnAdd                        	UnityEngine.RectTransform               	@ 12   购买数量 加一按钮
---@field InputFieldNumber              	TMPro.TMP_InputField                    	@ 13   购买数量 输入框
---@field BuyNum                        	UnityEngine.RectTransform               	@ 14   
---@field ItemGridView                  	SuperScrollView.LoopGridView            	@ 15   物品网格视图
---@field ImgBgList                     	UnityEngine.RectTransform               	@ 16   
---@field CommonPopupBoardDialog        	UnityEngine.RectTransform               	@ 17   
---@field Root                          	UnityEngine.RectTransform               	@ 18   
---@field Panel                         	UnityEngine.RectTransform               	@ 19   
---@field EmptyClose                    	UnityEngine.RectTransform               	@ 20   空白区域
---@field UIEfectCaptured               	UGUI.Effects.UIEffectCapturedImage      	@ 21   
local UIDarkDreamPassBuyRatingDialog = Class('UIDarkDreamPassBuyRatingDialog')


function UIDarkDreamPassBuyRatingDialog:__init() 
    ---@type ContractRecallPassCardHomeDojo
    self.passHomeDojo_ = nil

    ---@type table[] @ 奖励数据列表
    self.rewardsDataList_ = nil
end


function UIDarkDreamPassBuyRatingDialog:__delete()
    self.passHomeDojo_    = nil
    self.rewardsDataList_ = nil
end


function UIDarkDreamPassBuyRatingDialog:Awake()
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.EmptyClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.BtnAdd, Bind(self, self.OnClickBuyCountChangeButtonHandler_, 1))
    SetButtonAction(self.BtnMinus, Bind(self, self.OnClickBuyCountChangeButtonHandler_, -1))
    SetButtonAction(self.BtnAddTen, Bind(self, self.OnClickBuyCountChangeButtonHandler_, 10))
    SetButtonAction(self.BtnMinusTen, Bind(self, self.OnClickBuyCountChangeButtonHandler_, -10))
    SetButtonAction(self.FontStyleWithIconButton, Bind(self, self.OnClickRefreshBuyNumButtonHandler_))
    SetButtonAction(self.FontStyleWithGoodIconButton, Bind(self, self.OnClickLevelBuyButtonHandler_))
    SetGridViewAction(self.ItemGridView, Bind(self, self.OnUpdateRewardsGridCellHandler_))
    self.InputFieldNumber.onValueChanged:AddListener(Bind(self, self.OnValueChangedBuyNumInputHandler_))
end


function UIDarkDreamPassBuyRatingDialog:OnInitialize()
    return CoWaitDo(function()
        -- init var
        local initParams   = CfUtils.DialogSafeParameters(self.controller)
        self.passHomeDojo_ = initParams.passCardHomeDojo

        local passCardLevelMax = self:GetHomeDojo().passCardLevelMax
        local passCardLevelNum = self:GetHomeDojo().passCardLevelNow
        self:SetBuyLevelMax(passCardLevelMax - passCardLevelNum)

        -- init view
        self:UpdateCurrentLevel_()
        self:CheckBuyLevelNum_(1)

        if initParams.isReopen then
            CfUtils.SetActive(self.UIEfectCaptured, false)
        end
    end)
end


function UIDarkDreamPassBuyRatingDialog:OnFinalize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        initParams.isReopen = true
        self.InputFieldNumber.onValueChanged:RemoveAllListeners()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return ContractRecallPassCardHomeDojo
function UIDarkDreamPassBuyRatingDialog:GetHomeDojo()
    return self.passHomeDojo_
end


---@return integer
function UIDarkDreamPassBuyRatingDialog:GetBuyLevelMax()
    return checkInt(self.buyLevelCount_)
end
function UIDarkDreamPassBuyRatingDialog:SetBuyLevelMax(levelMax)
    self.buyLevelCount_ = checkInt(levelMax)
end


---@return integer
function UIDarkDreamPassBuyRatingDialog:GetBuyLevelNum()
    return checkInt(self.buyLevelNum_)
end
function UIDarkDreamPassBuyRatingDialog:SetBuyLevelNum(levelNum)
    self.buyLevelNum_ = checkInt(levelNum)
    self:UpdateBuyLevelInfo_()
end


---@return table[]
function UIDarkDreamPassBuyRatingDialog:GetRewardsDataList()
    return checkTable(self.rewardsDataList_)
end
function UIDarkDreamPassBuyRatingDialog:SetRewardsDataList(dataList)
    self.rewardsDataList_ = checkTable(dataList)
    self:UpdateRewardsGridView_()
end


-------------------------------------------------
-- private

---@param buyLevelNum integer
function UIDarkDreamPassBuyRatingDialog:CheckBuyLevelNum_(buyLevelNum)
    local oldBuyLevelNum = self:GetBuyLevelNum()
    local newBuyLevelNum = checkInt(buyLevelNum)

    -- limit check
    if self:GetBuyLevelMax() > 0 then
        newBuyLevelNum = math.max(1, math.min(newBuyLevelNum, self:GetBuyLevelMax()))
    else
        newBuyLevelNum = 0
    end

    -- check change
    if oldBuyLevelNum ~= newBuyLevelNum then
        self:SetBuyLevelNum(newBuyLevelNum)
    end
end


function UIDarkDreamPassBuyRatingDialog:UpdateBuyLevelInfo_()
    local buyLevelNum = self:GetBuyLevelNum()
    local oldLevelNum = self:GetHomeDojo().passCardLevelNow
    local newLevelNum = oldLevelNum + buyLevelNum
    
    -- update input text
    self.InputFieldNumber.text = tostring(buyLevelNum)

    -- update target level
    CfUtils.FillText(self.AchieveNumTxt, newLevelNum)
    
    -- update consume info
    local consumeId  = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_BUY_CONSUME_ID)
    local consumeNum = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_BUY_CONSUME_NUM) * buyLevelNum
    CfUtils.FillFontStyleWithGoodIconButtonNode(self.FontStyleWithGoodIconButton, consumeId, consumeNum)
    
    -- update rewards list
    local hasPaidPassCard = self:GetHomeDojo().isBoughtPassCard
    local rewardsDataMap  = PassCardUtils.GetLevelRewardDataMap(hasPaidPassCard, oldLevelNum + 1, newLevelNum)
    self:SetRewardsDataList(table.values(rewardsDataMap))
end


function UIDarkDreamPassBuyRatingDialog:UpdateCurrentLevel_()
    local passCardLevelNum = self:GetHomeDojo().passCardLevelNow
    CfUtils.FillText(self.CurrentNumTxt, passCardLevelNum)
end


function UIDarkDreamPassBuyRatingDialog:UpdateRewardsGridView_()
    local dataLength = #self:GetRewardsDataList()
    GameUtils.ReloadData(self.ItemGridView, dataLength)
end


-------------------------------------------------
-- handler

function UIDarkDreamPassBuyRatingDialog:OnClickCloseButtonHandler_()
    CfUtils.DialogBack()
end


---@param changeNum integer
function UIDarkDreamPassBuyRatingDialog:OnClickBuyCountChangeButtonHandler_(changeNum)
    self:CheckBuyLevelNum_(self:GetBuyLevelNum() + checkInt(changeNum))
end


---@param targetNum integer
function UIDarkDreamPassBuyRatingDialog:OnValueChangedBuyNumInputHandler_(targetNum)
    self:CheckBuyLevelNum_(checkInt(targetNum))
end


function UIDarkDreamPassBuyRatingDialog:OnClickRefreshBuyNumButtonHandler_()
    self:CheckBuyLevelNum_(1)
end


---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopGridViewItem
function UIDarkDreamPassBuyRatingDialog:OnUpdateRewardsGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(RewardsGridCellName)
    local cellData = self:GetRewardsDataList()[luaIndex]
    -- update cell
    local goodsId  = checkInt(cellData.goodsId)
    local goodsNum = checkInt(cellData.num)
    CfUtils.RefeshGoodGo(cellNode.gameObject, goodsId, 'x'..goodsNum, 0.65, nil, function()
        local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
        GameUtils.ShowCommonTipsBoard(cellNode.gameObject, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
    end)
    return cellNode
end


function UIDarkDreamPassBuyRatingDialog:OnClickLevelBuyButtonHandler_()
    local buyLevelNum = self:GetBuyLevelNum()
    local consumeId   = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_BUY_CONSUME_ID)
    local consumeNum  = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_BUY_CONSUME_NUM) * buyLevelNum
    local consumeData = { goodsId = consumeId, num = consumeNum }

    local doLevelBuy = function()
        local requestData = {num = buyLevelNum}
        GameUtils.Request(Interfaces.OverseaNightmarePassCardBuyLevel, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)

                -- update consume
                GoodsUtils.ConsumeGoods({{goodsId = consumeId, num = consumeNum}}, true)
                
                -- update passExp
                local addPassCardExp = buyLevelNum * PassCardUtils.ConvertPassUpgradeExp()
                local newPassCardExp = self:GetHomeDojo().passCardTotalExp + addPassCardExp
                self:GetHomeDojo():UpdatePassCardExp(newPassCardExp)

                CoStart(function()
                    -- close self
                    CoYield(CfUtils.DialogBack())

                    -- show rewards
                    local passExpGoodsId = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.EXP_POINT_ID)
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = {
                        {goodsId = passExpGoodsId, num = addPassCardExp}
                    }})
                end)
            end
        end)
    end

    -- check consume
    local _, errorTips = GoodsUtils.CheckGoodConsume({consumeData})
    if errorTips then
        if serverDifferenceMgr:IsSecondaryCurrencyEnable() then
            local primaryId    = checkInt(checkTable(CfUtils.GetCfVo(AutoIds.IdSetting10, "BaseArgVo", 17)).num)
            local secondaryId  = checkInt(checkTable(CfUtils.GetCfVo(AutoIds.IdSetting10, "BaseArgVo", 19)).num)
            local convertRatio = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting10, "BaseArgVo", 20).num)
            local ownCount     = GoodsUtils.GetThingNo(secondaryId)
            local needCount    = consumeNum - ownCount
            local convertNum   = math.ceil(convertRatio * (needCount))
            ---@type CommonCurrencyExchangePopup.InputData
            local data = {
                leftId         = primaryId,
                leftNum        = convertNum,
                rightId        = secondaryId,
                rightNum       = needCount,
                onConfirmClick = function()
                    local requestData = {num = convertNum}
                    GameUtils.Request(Interfaces.StoreDiamondChanges, requestData, function(request, response)
                        if checkInt(response.errCode) == 0 then
                            local consume = {goodsId = Constants.Currency.PayDiamondId, num = convertNum}
                            GoodsUtils.ConsumeGoods({consume})
                            GoodsUtils.DrawRewards(response.data.rewards)
                            doLevelBuy()
                        end
                    end)
                end
            }
            serverDifferenceMgr:OpenCurrencyExchangePopup(data)
        else
            GameUtils.Toast(errorTips)
        end
        return
    end

    local consumeVo  = GoodsConfMgr:GetInstance():GetGoodsVoById(consumeData.goodsId)
    local consumeTip = localize("确认花费_Num__Name_购买商品?", {_Num_ = consumeData.num, _Name_ = consumeVo.name})
    GameUtils.SecondConfirm(consumeTip, doLevelBuy)
end


return UIDarkDreamPassBuyRatingDialog

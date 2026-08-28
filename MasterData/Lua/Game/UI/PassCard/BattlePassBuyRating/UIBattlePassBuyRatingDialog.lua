-------------------------------------------------------------------------------
-- Pass卡 - 购买等级弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-03 21:34:16
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.PassCard.PassCardUtils')
local passCardComp  = PassCardUtils.GetComp()
local goodsConfMgr  = GoodsConfMgr:GetInstance()
local serverDifferenceMgr = import('Game.Setting.ServerDifferenceMgr'):GetInstance()

local RewardsGridCellName = 'GoodNode'

--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassBuyRating.prefab > name: BattlePassBuyRating
---@class UIBattlePassBuyRatingDialog
---@field Env                           	UIBattlePassBuyRatingDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field AchieveNumTxt                 	UnityEngine.RectTransform               @ 目标等级文本
---@field Achieve                       	UnityEngine.RectTransform               @
---@field CurrentNumTxt                 	UnityEngine.RectTransform               @ 当前等级文本
---@field Current                       	UnityEngine.RectTransform               @
---@field AnimRoot                      	UnityEngine.RectTransform               @
---@field LevelPromotion                	UnityEngine.RectTransform               @
---@field BtnClose                      	UnityEngine.RectTransform               @ 关闭按钮
---@field FontStyleWithIconButton       	Game.Native.Common.FontStyleButton      @ 重置按钮
---@field FontStyleWithGoodIconButton   	UnityEngine.RectTransform               @ 购买按钮
---@field BtnAddTen                     	UnityEngine.RectTransform               @ 购买数量 加十按钮
---@field BtnMinusTen                   	UnityEngine.RectTransform               @ 购买数量 减十按钮
---@field BtnMinus                      	UnityEngine.RectTransform               @ 购买数量 减一按钮
---@field BtnAdd                        	UnityEngine.RectTransform               @ 购买数量 加一按钮
---@field InputFieldNumber              	TMPro.TMP_InputField                    @ 购买数量 输入框
---@field BuyNum                        	UnityEngine.RectTransform               @
---@field ItemGridView                  	SuperScrollView.LoopGridView            @ 物品网格视图
---@field ImgBgList                     	UnityEngine.RectTransform               @
---@field CommonPopupBoardDialog        	UnityEngine.RectTransform               @
---@field Root                          	UnityEngine.RectTransform               @
---@field Panel                         	UnityEngine.RectTransform               @
---@field EmptyClose                    	UnityEngine.RectTransform               @ 空白区域
---@field UIEfectCaptured               	UGUI.Effects.UIEffectCapturedImage      @ 
local UIBattlePassBuyRatingDialog = Class('UIBattlePassBuyRatingDialog')


function UIBattlePassBuyRatingDialog:__init() 
    ---@type table[] @ 奖励数据列表
    self.rewardsDataList_ = nil
end


function UIBattlePassBuyRatingDialog:__delete()
    self.rewardsDataList_ = nil
end


function UIBattlePassBuyRatingDialog:Awake()
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


function UIBattlePassBuyRatingDialog:OnInitialize()
    return CoWaitDo(function()
        -- init var
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        local passCardLevelMax = passCardComp:GetPassLevelMax()
        local passCardLevelNum = passCardComp:GetHomeDojo().passCardLevel
        self:SetBuyLevelMax(passCardLevelMax - passCardLevelNum)

        -- init view
        self:UpdateCurrentLevel_()
        self:CheckBuyLevelNum_(1)

        if initParams.isReopen then
            CfUtils.SetActive(self.UIEfectCaptured, false)
        end
    end)
end


function UIBattlePassBuyRatingDialog:OnFinalize()
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

---@return integer
function UIBattlePassBuyRatingDialog:GetBuyLevelMax()
    return checkInt(self.buyLevelCount_)
end
function UIBattlePassBuyRatingDialog:SetBuyLevelMax(levelMax)
    self.buyLevelCount_ = checkInt(levelMax)
end


---@return integer
function UIBattlePassBuyRatingDialog:GetBuyLevelNum()
    return checkInt(self.buyLevelNum_)
end
function UIBattlePassBuyRatingDialog:SetBuyLevelNum(levelNum)
    self.buyLevelNum_ = checkInt(levelNum)
    self:UpdateBuyLevelInfo_()
end


---@return table[]
function UIBattlePassBuyRatingDialog:GetRewardsDataList()
    return checkTable(self.rewardsDataList_)
end
function UIBattlePassBuyRatingDialog:SetRewardsDataList(dataList)
    self.rewardsDataList_ = checkTable(dataList)
    self:UpdateRewardsGridView_()
end


-------------------------------------------------
-- private

---@param buyLevelNum integer
function UIBattlePassBuyRatingDialog:CheckBuyLevelNum_(buyLevelNum)
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


function UIBattlePassBuyRatingDialog:UpdateBuyLevelInfo_()
    local buyLevelNum = self:GetBuyLevelNum()
    local oldLevelNum = passCardComp:GetHomeDojo().passCardLevel
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
    local passTypes  = { PassCardUtils.PassType.FREE }
    local scheduleId = passCardComp:GetHomeDojo().scheduleId
    if passCardComp:IsUnlockNormalPass() then
        table.insert(passTypes, PassCardUtils.PassType.NORMAL)
    end
    if passCardComp:IsUnlockDeluxePass() then
        table.insert(passTypes, PassCardUtils.PassType.DELUXE)
    end
    local rewardsDataMap = PassCardUtils.GetLevelRewardDataMap(scheduleId, passTypes, oldLevelNum + 1, newLevelNum)
    self:SetRewardsDataList(table.values(rewardsDataMap))
end


function UIBattlePassBuyRatingDialog:UpdateCurrentLevel_()
    local passCardLevelNum = passCardComp:GetHomeDojo().passCardLevel
    CfUtils.FillText(self.CurrentNumTxt, passCardLevelNum)
end


function UIBattlePassBuyRatingDialog:UpdateRewardsGridView_()
    local dataLength = #self:GetRewardsDataList()
    GameUtils.ReloadData(self.ItemGridView, dataLength)
end


-------------------------------------------------
-- handler

function UIBattlePassBuyRatingDialog:OnClickCloseButtonHandler_()
    CfUtils.DialogBack()
end


---@param changeNum integer
function UIBattlePassBuyRatingDialog:OnClickBuyCountChangeButtonHandler_(changeNum)
    self:CheckBuyLevelNum_(self:GetBuyLevelNum() + checkInt(changeNum))
end


---@param targetNum integer
function UIBattlePassBuyRatingDialog:OnValueChangedBuyNumInputHandler_(targetNum)
    self:CheckBuyLevelNum_(checkInt(targetNum))
end


function UIBattlePassBuyRatingDialog:OnClickRefreshBuyNumButtonHandler_()
    self:CheckBuyLevelNum_(1)
end


---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopGridViewItem
function UIBattlePassBuyRatingDialog:OnUpdateRewardsGridCellHandler_(gridView, luaIndex)
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


function UIBattlePassBuyRatingDialog:OnClickLevelBuyButtonHandler_()
    local buyLevelNum = self:GetBuyLevelNum()
    local consumeId   = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_BUY_CONSUME_ID)
    local consumeNum  = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LEVEL_BUY_CONSUME_NUM) * buyLevelNum
    local consumeData = { goodsId = consumeId, num = consumeNum }

    GoodsUtils.CheckCurrencyConsume(consumeData, function()
        local requestData = {num = buyLevelNum}
        GameUtils.Request(Interfaces.OverseaPassCardBuyLevel, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)

                -- update consume
                GoodsUtils.ConsumeGoods({{goodsId = consumeId, num = consumeNum}}, true)
                
                -- update passExp
                local addPassCardExp = buyLevelNum * PassCardUtils.ConvertPassUpgradeExp()
                local newPassCardExp = passCardComp:GetHomeDojo().passCardTotalExp + addPassCardExp
                passCardComp:UpdatePassCardExp(newPassCardExp)

                CoStart(function()
                    -- close self
                    CoYield(CfUtils.DialogBack())

                    -- show rewards
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = {
                        {goodsId = passCardComp:GetPassExpGoodsId(), num = addPassCardExp}
                    }})
                end)
            end
        end)
    end)
end


return UIBattlePassBuyRatingDialog

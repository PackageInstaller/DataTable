-------------------------------------------------------------------------------
-- 噩梦回响Pass卡 - 购买等级弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-17 16:49:32
-------------------------------------------------------------------------------

local goodsConfMgr  = GoodsConfMgr:GetInstance()
local serverDifferenceMgr = import('Game.Setting.ServerDifferenceMgr'):GetInstance()

local RewardsGridCellName = 'GoodNode'

--- from: Assets/BundleResources/Prefabs/Activity/ActivitySkinPassBuyRating.prefab > name: ActivitySkinPassBuyRating
---@class UIActivityFashionPassBuyLevelDialog
---@field Env                           	UIActivityFashionPassBuyLevelDialog     
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
local UIActivityFashionPassBuyLevelDialog = Class('UIActivityFashionPassBuyLevelDialog')


function UIActivityFashionPassBuyLevelDialog:__init() 
    ---@type ActivityFashionPassComponent
    self.comp = nil

    ---@type table[] @ 奖励数据列表
    self.rewardsDataList_ = nil
end


function UIActivityFashionPassBuyLevelDialog:__delete()
    self.comp    = nil
    self.rewardsDataList_ = nil
end


function UIActivityFashionPassBuyLevelDialog:Awake()
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


function UIActivityFashionPassBuyLevelDialog:OnInitialize()
    return CoWaitDo(function()
        -- init var
        self.comp = self.controller.Argument.parameters.comp

        local canBuyLevelNum = self.comp:CanBuyLevelNumMax()
        self:SetBuyLevelMax(canBuyLevelNum)

        -- init view
        self:UpdateCurrentLevel_()
        self:CheckBuyLevelNum_(1)

        -- if initParams.isReopen then
        --     CfUtils.SetActive(self.UIEfectCaptured, false)
        -- end
    end)
end


function UIActivityFashionPassBuyLevelDialog:OnFinalize()
    return CoWaitDo(function()
        -- local initParams = CfUtils.DialogSafeParameters(self.controller)
        -- initParams.isReopen = true
        self.InputFieldNumber.onValueChanged:RemoveAllListeners()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function UIActivityFashionPassBuyLevelDialog:GetBuyLevelMax()
    return checkInt(self.buyLevelCount_)
end
function UIActivityFashionPassBuyLevelDialog:SetBuyLevelMax(levelMax)
    self.buyLevelCount_ = checkInt(levelMax)
end


---@return integer
function UIActivityFashionPassBuyLevelDialog:GetBuyLevelNum()
    return checkInt(self.buyLevelNum_)
end
function UIActivityFashionPassBuyLevelDialog:SetBuyLevelNum(levelNum)
    self.buyLevelNum_ = checkInt(levelNum)
    self:UpdateBuyLevelInfo_()
end


---@return table[]
function UIActivityFashionPassBuyLevelDialog:GetRewardsDataList()
    return checkTable(self.rewardsDataList_)
end
function UIActivityFashionPassBuyLevelDialog:SetRewardsDataList(dataList)
    self.rewardsDataList_ = checkTable(dataList)
    self:UpdateRewardsGridView_()
end


-------------------------------------------------
-- private

---@param buyLevelNum integer
function UIActivityFashionPassBuyLevelDialog:CheckBuyLevelNum_(buyLevelNum)
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


function UIActivityFashionPassBuyLevelDialog:UpdateBuyLevelInfo_()
    local buyLevelNum = self:GetBuyLevelNum()
    local oldLevelNum = self.comp:GetLevelAndExp()
    local newLevelNum = oldLevelNum + buyLevelNum
    
    -- update input text
    self.InputFieldNumber.text = tostring(buyLevelNum)

    -- update target level
    CfUtils.FillText(self.AchieveNumTxt, newLevelNum)
    
    -- update consume info
    local goodsId, goodsNum = self.comp:GetBuyLevelConsumeGoodsIdAndNum()
    local consumeId  = goodsId
    local consumeNum = goodsNum * buyLevelNum
    CfUtils.FillFontStyleWithGoodIconButtonNode(self.FontStyleWithGoodIconButton, consumeId, consumeNum)
    
    -- update rewards list
    local rewardsDataList  = self.comp:GetLevelRewardDataList(oldLevelNum + 1, newLevelNum)
    self:SetRewardsDataList(rewardsDataList)
end


function UIActivityFashionPassBuyLevelDialog:UpdateCurrentLevel_()
    local passCardLevelNum = self.comp:GetLevelAndExp()
    CfUtils.FillText(self.CurrentNumTxt, passCardLevelNum)
end


function UIActivityFashionPassBuyLevelDialog:UpdateRewardsGridView_()
    local dataLength = #self:GetRewardsDataList()
    GameUtils.ReloadData(self.ItemGridView, dataLength)
end


-------------------------------------------------
-- handler

function UIActivityFashionPassBuyLevelDialog:OnClickCloseButtonHandler_()
    CfUtils.DialogBack()
end


---@param changeNum integer
function UIActivityFashionPassBuyLevelDialog:OnClickBuyCountChangeButtonHandler_(changeNum)
    self:CheckBuyLevelNum_(self:GetBuyLevelNum() + checkInt(changeNum))
end


---@param targetNum integer
function UIActivityFashionPassBuyLevelDialog:OnValueChangedBuyNumInputHandler_(targetNum)
    self:CheckBuyLevelNum_(checkInt(targetNum))
end


function UIActivityFashionPassBuyLevelDialog:OnClickRefreshBuyNumButtonHandler_()
    self:CheckBuyLevelNum_(1)
end


---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopGridViewItem
function UIActivityFashionPassBuyLevelDialog:OnUpdateRewardsGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(RewardsGridCellName)
    local cellData = self:GetRewardsDataList()[luaIndex]
    -- update cell
    local goodsId  = checkInt(cellData.goodsId)
    local goodsNum = checkInt(cellData.goodsNum)
    CfUtils.RefeshGoodGo(cellNode.gameObject, goodsId, 'x'..goodsNum, 0.65, nil, function()
        local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
        GameUtils.ShowCommonTipsBoard(cellNode.gameObject, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
    end)
    return cellNode
end


function UIActivityFashionPassBuyLevelDialog:OnClickLevelBuyButtonHandler_()
    local buyLevelNum = self:GetBuyLevelNum()
    local comp = self.comp
    local goodsId, goodsNum = comp:GetBuyLevelConsumeGoodsIdAndNum()
    local consumeId  = goodsId
    local consumeNum = goodsNum * buyLevelNum
    local consumeData = { goodsId = consumeId, num = consumeNum }

    local doLevelBuy = function()
        local requestData = {num = buyLevelNum}
        comp:RequestBuyLevel(buyLevelNum, function(addExp)
            -- update consume
            GoodsUtils.ConsumeGoods({{goodsId = consumeId, num = consumeNum}}, true)

            print("发送事件 ", Constants.EventNames.FashionPassBuyLevelSuccessEvent)
            Events.Broadcast(Constants.EventNames.FashionPassBuyLevelSuccessEvent)

            CoStart(function()
                -- close self
                CoYield(CfUtils.DialogBack())
                
                -- show rewards
                local passExpGoodsId = comp:GetExpGoodsId()
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = {
                    {goodsId = passExpGoodsId, num = addExp}
                }})
            end)
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


return UIActivityFashionPassBuyLevelDialog

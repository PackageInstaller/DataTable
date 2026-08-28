-------------------------------------------------------------------------------
-- 夜巡迷宫 - 商店界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-16 16:54:13
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local ProductListCellPath = 'Game.Grocery.Cell.GroceryBaseNodeListCell'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/PatrolStoreEventDialog130201.prefab > name: PatrolStoreEventDialog130201
---@class PatrolMazeStoreEventDialog
---@field Env                           	PatrolMazeStoreEventDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	               	@ 根节点
---@field AnimNode                      	UnityEngine.RectTransform               	               	@ 动画节点
---@field ProductListView               	Engine.UI.AutoFixSizeListView           	           	    @ 商品列表
---@field LeaveBtn                      	UnityEngine.RectTransform               	               	@ 离开按钮
local PatrolMazeStoreEventDialog = Class('PatrolMazeStoreEventDialog')


function PatrolMazeStoreEventDialog:__init()
    ---@type PatrolMazeAreaDojo @ 当前所在区域dojo
    self.mapAreaDojo_ = nil

    ---@type PatrolMazeFloorPathDojo @ 路径节点dojo
    self.floorPathDojo_ = nil

    ---@type PatrolMazeFloorLevelDojo @ 层级节点dojo
    self.floorLevelDojo_ = nil

    ---@type boolean @ 防止改层级 @see UINavigatorBar.OnBackButtonAction
    self.isBatch = true
end


function PatrolMazeStoreEventDialog:__delete()
    self.mapAreaDojo_    = nil
    self.floorPathDojo_  = nil
    self.floorLevelDojo_ = nil
end


function PatrolMazeStoreEventDialog:Awake()
    SetButtonAction(self.LeaveBtn, Bind(self, self.OnClickLeaveButtonHandler_))
end


function PatrolMazeStoreEventDialog:OnFocus(focus)
    if focus then
        CfUtils.RefreshTopGoods({ PatrolMazeUtils.GetCurrencyId() })
    end
end


function PatrolMazeStoreEventDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams     = self.controller.Argument.parameters or {}
        self.mapAreaDojo_    = initParams.areaDojo
        self.floorPathDojo_  = initParams.pathDojo
        self.floorLevelDojo_ = initParams.levelDojo

        CfUtils.RefreshTopGoods({ PatrolMazeUtils.GetCurrencyId() })
    end)
end


function PatrolMazeStoreEventDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function PatrolMazeStoreEventDialog:OnShow()
    return CoWaitDo(function()
        SetFixSizeListViewAction(self.ProductListView, Bind(self, self.OnUpdateProductListCellHandler_))

        if #self:GetProductList() > 0 then
            self:UpdateProductList_()
        else
            local requestData = {areaId = self.mapAreaDojo_.areaId, floor = self.floorPathDojo_.floorNum, level = self.floorLevelDojo_.floorLevel}
            GameUtils.Request(Interfaces.OverseaMazeMallHome, requestData, function(request, response)
                if checkInt(response.errCode) == 0 then
                    local responseData = checkTable(response.data)
                    self.floorLevelDojo_:FillProductsInfo(responseData)
                    self:UpdateProductList_()
                end
            end)
        end
    end)
end


--- 自定义后退按钮行为，注意：一定要配合 self.isBatch 定义
function PatrolMazeStoreEventDialog:HandleBackAction()
    self:OnClickLeaveButtonHandler_()
end


-------------------------------------------------
-- get / set

function PatrolMazeStoreEventDialog:GetProductList()
    return self.floorLevelDojo_.producttDojoList
end


-------------------------------------------------
-- public

function PatrolMazeStoreEventDialog:Close()
    CfUtils.DialogBack()
end


-------------------------------------------------
-- private

function PatrolMazeStoreEventDialog:UpdateProductList_()
    local listDataLength = #self:GetProductList()
    GameUtils.ReloadData(self.ProductListView, listDataLength)
end


-------------------------------------------------
-- handler

function PatrolMazeStoreEventDialog:OnClickLeaveButtonHandler_()
    GameUtils.SecondConfirm(localize('离开后将无法再次进来，是否结束购买？'), function()
        local mapAreaId = self.mapAreaDojo_.areaId
        local floorNum  = self.floorPathDojo_.floorNum
        local levelNum  = self.floorLevelDojo_.floorLevel
        patrolMazeComp:MoveMazeByStoreOver(mapAreaId, floorNum, levelNum, function()
            self:Close()
            Events.Broadcast(PatrolMazeUtils.EventsName.MAZE_CONTINUE_STEP)
        end)
    end)
end


---@param cellNode UnityEngine.GameObject
---@param luaIndex integer
function PatrolMazeStoreEventDialog:OnUpdateProductListCellHandler_(cellNode, luaIndex)
    ---@type PatrolMazeQuestProducttDojo
    local productDojo = checkTable(self:GetProductList()[luaIndex])
    ---@type GroceryBaseNodeListCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, ProductListCellPath)
    if isNotNull(cellEnv) then
        cellEnv:RefreshCell({
            icon         = productDojo.goodsId,
            num          = productDojo.goodsNum,
            stock        = productDojo.totalStock,
            currentStock = productDojo.currentStock,
            prices       = productDojo.priceDataList,
        }, luaIndex)
        cellEnv:SetClickCallback(Bind(self, self.OnClickProductListCellHandler_))
    end
end


function PatrolMazeStoreEventDialog:OnClickProductListCellHandler_(luaIndex)
    ---@type PatrolMazeQuestProducttDojo
    local productDojo = checkTable(self:GetProductList()[luaIndex])
    CfUtils.DialogOpen(Constants.UITypeIds.UICommonBuyItemDialog, {
        goodsId   = productDojo.goodsId,
        goodsNum  = productDojo.goodsNum,
        prices    = productDojo.priceDataList,
        maxBuyNum = productDojo.currentStock,
        buyCb     = function(price, buyNum)
            local mapAreaId   = self.mapAreaDojo_.areaId
            local floorNum    = self.floorPathDojo_.floorNum
            local levelNum    = self.floorLevelDojo_.floorLevel
            local requestData = {areaId = mapAreaId, floor = floorNum, level = levelNum, productId = productDojo.productId}
            GameUtils.Request(Interfaces.OverseaMazeMallBuy, requestData, function(request, response)
                if checkInt(response.errCode) == 0 then
                    local responseData = checkTable(response.data)
                    
                    -- update stock
                    if productDojo.totalStock ~= -1 then
                        productDojo.currentStock = productDojo.currentStock - checkInt(buyNum)
                    end

                    -- update consume
                    local consumeData = { {goodsId = price.currency, num = price.current} }
                    GoodsUtils.ConsumeGoods(consumeData)

                    -- update cell
                    local cellNode = self.ProductListView:GetShownItemByItemIndex(luaIndex - 1)
                    self:OnUpdateProductListCellHandler_(cellNode, luaIndex)

                    -- draw rewards
                    local rewardList = checkTable(responseData.rewards)
                    GoodsUtils.DrawRewards(rewardList, true)

                    -- show rewards
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
                end
            end)
        end
    })
end


return PatrolMazeStoreEventDialog

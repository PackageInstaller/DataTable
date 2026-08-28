---
--- Created by Eric.
--- DateTime: 2021/10/15 18:17
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local MazeMgr = import('Game.Maze.MazeMgr')

------------ import ------------

------------ define ------------
local LoopViewMaxCellCountMystical = 3--循环列表最多显示cell数量
local LoopViewMaxCellCountSupply = 12--循环列表最多显示cell数量

------------ define ------------


---@class PatrolStoreEventDialog
---@field FontStyleButton               	UnityEngine.RectTransform
---@field StoreScrollMystical           	Engine.UI.AutoFixSizeListView
---@field MysticalStorePanel            	UnityEngine.RectTransform
---@field StoreScrollSupply             	Engine.UI.AutoFixSizeListView
---@field SupplyStorePanel              	UnityEngine.RectTransform
local PatrolStoreEventDialog = Class("PatrolStoreEventDialog")
function PatrolStoreEventDialog:__init()
    self.data = {}
    self.goodsList = {}--由map转为list
    self:ResetAnimData()

end

function PatrolStoreEventDialog:__delete()
    self.data = nil
    self.goodsList = nil
    for i = 1, LoopViewMaxCellCountMystical do
        self["isAnimatedMystical"..i] = nil
    end
    for i = 1, LoopViewMaxCellCountSupply do
        self["isAnimatedSupply"..i] = nil
    end
    self.controller = nil
end

function PatrolStoreEventDialog:ResetAnimData()
    for i = 1, LoopViewMaxCellCountMystical do
        self["isAnimatedMystical"..i] = false
    end
    for i = 1, LoopViewMaxCellCountSupply do
        self["isAnimatedSupply"..i] = false
    end
end

function PatrolStoreEventDialog:Awake()

end

function PatrolStoreEventDialog:OnFocus(focus)
    if focus then
        if self.data and self.data.type == 4 then --神秘商店(外商店）
            CfUtils.RefreshTopGoods({
                Constants.Currency.FreeDiamondId,
            })
        end
        --print("storeData--->>"..table.dump(MazeMgr:GetInstance():GetCurrentChooseInfo()))
        --print("storeData--->>"..table.dump(MazeMgr:GetInstance().currentInfo, nil, 3))
        --print("coin--->>"..MazeMgr.coin)
    end
end

function PatrolStoreEventDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument = self.controller.Argument
        if not isNull(argument.parameters) then
            --self.data = argument.parameters.data
            --self.data = DeepCopy(MazeMgr:GetInstance():GetCurrentChooseInfo())
            ----self.key = argument.parameters.key
            ----print("arg----->>"..table.dump(argument.parameters))
            --self:FreshBaseUI()
            SetButtonAction(self.FontStyleButton, function ()
                GameUtils.SecondConfirm
                (
                        localize("是否确认结束购物，直接到下一巡逻"),
                        function()
                            MazeMgr:GetInstance():MazeBuyOver()
                            UIModule.CloseDialog(self.controller)
                        end
                )
            end)
        end
    end))
    return coWait
end

function PatrolStoreEventDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.data = DeepCopy(MazeMgr:GetInstance():GetCurrentChooseInfo())
        self:FreshBaseUI()
    end))
    return coWait
end

function PatrolStoreEventDialog:FreshBaseUI()
    self.goodsList = {}
    for k, v in pairs(self.data.goods) do
        local goodData = {
            goodsId = k,
            num = v,
        }
        table.insert(self.goodsList, goodData)
    end
    --printInfo("storeData======>>"..table.dump(self.data, nil, 3))
    if self.data.type == 4 then --神秘商店(外商店）
        CfUtils.RefreshTopGoods({
            Constants.Currency.FreeDiamondId,
        })
        KTool.SetActive(self.MysticalStorePanel, true)
        KTool.SetActive(self.SupplyStorePanel, false)
        self.StoreScrollMystical:InitListView(0, Bind(self, self.OnGetItemByIndexMystical), nil, nil)
        self.StoreScrollMystical:SetListItemCount(table.count(self.goodsList))
        --if not self.StoreScrollMystical.IsListViewInit then
        --    self.StoreScrollMystical:InitGridView(#self.goodsList, Bind(self, self.OnGetItemByIndexMystical))
        --else
        --    GameUtils.ReloadData(self.StoreScrollMystical, #self.goodsList)
        --end
    elseif self.data.type == 5 then--补给商店（内商店）
        KTool.SetActive(self.MysticalStorePanel, false)
        KTool.SetActive(self.SupplyStorePanel, true)
        self.StoreScrollSupply:InitListView(0, Bind(self, self.OnGetItemByIndexSupply), nil, nil)
        self.StoreScrollSupply:SetListItemCount(table.count(self.goodsList))
        --if not self.StoreScrollSupply.IsListViewInit then
        --    self.StoreScrollSupply:InitGridView(#self.goodsList, Bind(self, self.OnGetItemByIndexSupply))
        --else
        --    GameUtils.ReloadData(self.StoreScrollSupply, #self.goodsList)
        --end
    end
end



function PatrolStoreEventDialog:OnGetItemByIndexMystical(go, index)
    if index < 0 then
        return nil
    end

    local cell = go--listView:NewListViewItem("Cell")
    --printInfo("=====>>"..index)
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.Patrol.PatrolStoreMysticalCell")
    if nodeEnv then
        local luaIndex = index + 1
        --@region 刚进入列表时播放延时出现动画
        if not isNull(self["isAnimatedMystical"..luaIndex]) then
            if not self["isAnimatedMystical"..luaIndex] then
                self["isAnimatedMystical"..luaIndex] = true
                CfUtils.PlayDelayShowAnimate(cell.transform:Find("StoreBtnNode/AnimRoot"), luaIndex)
            else
                CfUtils.PlayDelayShowAnimate(cell.transform:Find("StoreBtnNode/AnimRoot"), 0)
            end
        else
            CfUtils.PlayDelayShowAnimate(cell.transform:Find("StoreBtnNode/AnimRoot"), 0)
        end
        --@endregion
        local data = self.goodsList[luaIndex]
        --print("----->>"..table.dump(data))
        nodeEnv:FreshBaseUI(data)
        nodeEnv:SetBtnCallBack(function()
            if data.num > 0 then
                local mazeGoodVo = CfUtils.GetCfVo(AutoIds.IdSetting363, "MazeGoodsVo", data.goodsId)
                local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(mazeGoodVo.itemId)

                local haveDiamondNum = GoodsUtils.GetThingNo(mazeGoodVo.goodsConsum)
                local currencyVo = GoodsConfMgr:GetInstance():GetGoodsVoById(mazeGoodVo.goodsConsum)
                if haveDiamondNum >= mazeGoodVo.newPrice then
                    GameUtils.SecondConfirm
                    (
                            localize("确认花费_Num__Name_购买_Name1_？？",{_Num_ = mazeGoodVo.newPrice, _Name_ = currencyVo.name, _Name1_ = vo.name}),
                            function()
                                MazeMgr:GetInstance():MazeMoveToBuy(data.goodsId, function(jsonData)
                                    UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = jsonData.rewards } })
                                    GoodsUtils.DrawRewards(jsonData.rewards)
                                    --扣砖石
                                    GoodsUtils.DrawRewards({
                                        [1] = {
                                            goodsId = mazeGoodVo.goodsConsum,
                                            num = -(mazeGoodVo.newPrice),
                                        }
                                    })
                                    data.num = 0
                                    nodeEnv:FreshSoldOutStatus(true)
                                end)
                            end
                    )
                else
                    GameUtils.Toast(localize("_Name_不足",{_Name_ = currencyVo.name}))
                end
            end
        end)
    end
    return cell
end

function PatrolStoreEventDialog:OnGetItemByIndexSupply(go, index)
    if index < 0 then
        return nil
    end
    --local cell = listView:NewListViewItem("ItemPrefab1")
    local cell = go
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.Patrol.PatrolStoreSupplyCell")
    if nodeEnv then
        local luaIndex = index + 1
        --@region 刚进入列表时播放延时出现动画
        --if not isNull(self["isAnimatedSupply"..luaIndex]) then
        --    if not self["isAnimatedSupply"..luaIndex] then
        --        self["isAnimatedSupply"..luaIndex] = true
        --        CfUtils.PlayDelayShowAnimate(cell.transform:Find("StoreBtnNode/AnimRoot"), luaIndex)
        --    else
        --        CfUtils.PlayDelayShowAnimate(cell.transform:Find("StoreBtnNode/AnimRoot"), 0)
        --    end
        --else
        --    CfUtils.PlayDelayShowAnimate(cell.transform:Find("StoreBtnNode/AnimRoot"), 0)
        --end
        --@endregion
        local data = self.goodsList[luaIndex]
        nodeEnv:FreshBaseUI(data)
        nodeEnv:SetBtnCallBack(function()
            if data.num > 0 then
                local mazeGoodVo = CfUtils.GetCfVo(AutoIds.IdSetting364, "MazeGoodsVo", data.goodsId)
                --local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(mazeGoodVo.itemId)

                local haveDiamondNum = GoodsUtils.GetThingNo(checkNumber(mazeGoodVo.goodsConsum))
                local currencyVo = GoodsConfMgr:GetInstance():GetGoodsVoById(mazeGoodVo.goodsConsum)
                if haveDiamondNum >= mazeGoodVo.newPrice then
                    GameUtils.SecondConfirm
                    (
                            localize("确认花费_Num__Name_购买_Name1_？？",{_Num_ = mazeGoodVo.newPrice, _Name_ = currencyVo.name, _Name1_ = mazeGoodVo.name}),
                            function()
                                MazeMgr:GetInstance():MazeMoveToBuy(data.goodsId, function(jsonData)
                                    local rewards = jsonData.mazeGoods
                                    if rewards then
                                        for k, v in pairs(rewards) do
                                            --mazeBagComp:Additem(v, Constants.IDType.MazeItem)
                                            v.idAreaType = Constants.IDArea.Maze
                                        end
                                    end
                                    --data.num = 0
                                    UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })
                                    --扣迷宫币
                                    --MazeMgr:GetInstance():SetMazeCurrencyNum(MazeMgr:GetInstance():GetMazeCurrencyNum() - mazeGoodVo.newPrice)
                                    --print("remainCoin=====>>"..MazeMgr:GetInstance():GetMazeCurrencyNum())

                                    nodeEnv:FreshSoldOutStatus(true)
                                    Events.Broadcast(Constants.EventNames.EveryThingChangeEventName, checkNumber(Constants.Currency.MazeCurrency))
                                end)
                            end
                    )
                else
                    GameUtils.Toast(localize("_Name_不足",{_Name_ = currencyVo.name}))
                end
            end
        end)
    end
    return cell
end


function PatrolStoreEventDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return PatrolStoreEventDialog
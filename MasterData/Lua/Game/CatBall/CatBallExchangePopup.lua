
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
local checkNumber = checkNumber
local SetButtonAction = SetButtonAction
local Bind = Bind
local SetToggleValueChanged = SetToggleValueChanged
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CatBallUtils
local CatBallUtils     = import("Game.CatBall.CatBallUtils")
---@type GoodsConfMgr
local goodsConfMgr     = GoodsConfMgr:GetInstance()
local tInsert          = table.insert
--endregion

--region define

local NeedCatBallFragmentCountId = 1
local ConsumeId  = 3
local ConsumeNumId = 4
local Cell    = "Cell"
local EnvPath = "Game.CatBall.CatBallExchangePopupCell"

local GoodsStatus = {
    Normal       = 1, --- 正常状态
    Selected     = 2, --- 选择
    CannotSelect = 3, --- 不能选择
}

local MergeMode = {
    Single   = 1, --- 单个合成
    Multiple = 2, --- 多个合成
}

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballExchangePopup.prefab > name: OverseaManageCatballExchangePopup
---@class CatBallExchangePopup
---@field Env                           	CatBallExchangePopup                    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TxtTips                       	UnityEngine.UI.Text                     
---@field Fuzzy                         	UnityEngine.RectTransform               
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               
---@field MergeButton                   	Game.Native.Common.FontStyleButton               
---@field TextDesc                      	CustomText                              
---@field SingleMerge                   	UnityEngine.RectTransform               
---@field ImgQuality_Center             	Game.Native.Common.UISwitchImage        
---@field MiddleImgQuality              	UnityEngine.RectTransform               
---@field MiddleImgEmpty                	UnityEngine.RectTransform               
---@field CommonTabToggleUp             	UnityEngine.RectTransform               
---@field ToggleNode                    	UnityEngine.UI.Toggle               
---@field EmptyNode                     	UnityEngine.RectTransform               
---@field ScrollView                    	SuperScrollView.LoopGridView            
---@field TextTitle                     	UnityEngine.RectTransform               
---@field BtnExplain                    	UnityEngine.RectTransform               
---@field BtnClose                      	UnityEngine.RectTransform               
local CatBallExchangePopup = Class('CatBallExchangePopup')


function CatBallExchangePopup:__init()
    self._mergeMode = MergeMode.Single
    self._selectedGoodsId2Num = {}
    self._singleMergeNodeInfoList = {}
    self._selectQuality = nil
    self._isShowTips = false
end


function CatBallExchangePopup:__delete()
    self.controller = nil
end


function CatBallExchangePopup:OnFocus(focus)
    if focus then
        CfUtils.RefreshTopGoods(self._currency)
    end
end


function CatBallExchangePopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
    end))
    return coWait
end


function CatBallExchangePopup:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        GameUtils.HidePreviousDialogs(self.controller)
        self:FreshUI()
    end))
    return coWait
end

function CatBallExchangePopup:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        GameUtils.ShowPreviousDialogs()
    end))
    return coWait
end


function CatBallExchangePopup:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CatBallExchangePopup:OnInit()
    self:InitData()
    self:InitAction()
    self:InitUI()
    -- self.TxtTips.text = self:GetTipsText()
end

function CatBallExchangePopup:InitData()

    self:InitCurrency()

    self:InitDataList()
    self._mergeNeedNum             = checkNumber(CatBallUtils.GetCatBallParams(NeedCatBallFragmentCountId))
    self._consumeId                = checkNumber(CatBallUtils.GetCatBallParams(ConsumeId))
    self._consumeNum               = checkNumber(CatBallUtils.GetCatBallParams(ConsumeNumId))

    self:InitToggleData()
end

function CatBallExchangePopup:InitDataList(cb)
    local goodsDataList       = {}
    local originGoodsDataList = {}

    ---@type CatEggComponent
    local catEggComponent    = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    local playerCatId2Dojo   = catEggComponent:GetCats()
    local catId2Star = {}
    local starMax = 0
    for playerCatId, dojo in pairs(playerCatId2Dojo) do
        local catId = dojo.catId
        catId2Star[checkNumber(dojo.catId)] = checkNumber(dojo.star)
        if starMax == 0 then
            ---@type CatBallVo
            local vo = CatBallUtils.GetCatBallVo(catId)
            starMax = vo.starMax
        end
    end
    self._catId2Star = catId2Star
    self._starMax = starMax
    local convertBackpack = catEggComponent:GetConvertBackpack()
    for goodsId, goodsNum in pairs(convertBackpack) do
        goodsNum = checkNumber(goodsNum)
        if goodsNum > 0 then
            local goodsData = self:GetGoodsData(goodsId, goodsNum)
            if cb == nil or cb(goodsData) then
                tInsert(goodsDataList, goodsData)
            end
            tInsert(originGoodsDataList, goodsData)
            
        end
    end

    self:SortGoodsDataList(originGoodsDataList)
    self:SortGoodsDataList(goodsDataList)
    self._originGoodsDataList      = originGoodsDataList
    self._goodsDataList            = goodsDataList
end

function CatBallExchangePopup:SortGoodsDataList(goodsDataList)
    table.sort(goodsDataList, function(a, b) return a.quality > b.quality end)
end

function CatBallExchangePopup:InitCurrency()
    local t = {
        ---猫球升星、融合界面显示的新海币
        checkNumber(CatBallUtils.GetCatBallParams(7)),
    }
    self._currency = t
end

function CatBallExchangePopup:InitToggleData()
    self._toggleData = {
        {
            text = localize("单次融合"),
            func = function()
                self._mergeMode = MergeMode.Single
                self:SwitchMergeMode()
            end
        },
        {
            text = localize("多次融合"),
            func = function()
                self._mergeMode = MergeMode.Multiple
                self:SwitchMergeMode()
            end
        },
    }
end

function CatBallExchangePopup:InitAction()
    SetButtonAction(self.BtnClose,         Bind(self, self.OnClickBtnCloseAction))
    SetButtonAction(self.Fuzzy,            Bind(self, self.OnClickBtnCloseAction))
    -- SetButtonAction(self.SwitchButton,     Bind(self, self.SwitchMergeMode))
    SetButtonAction(self.MergeButton,      Bind(self, self.OnClickMergeButtonAction))
    SetButtonAction(self.BtnExplain,       Bind(self, self.OnClickBtnExplainAction))
    SetToggleValueChanged(self.ToggleNode, Bind(self, self.OnClickToggleNodeAction))

end

function CatBallExchangePopup:InitUI()
    ---@type CommonTabToggleUp
    local env = CfUtils.GetLuaScr(self.CommonTabToggleUp.gameObject, "Game.Behaviours.CommonTabToggleUp")
    env:FillToggles(self._toggleData)
end

--endregion 


--region logic 

function CatBallExchangePopup:FreshUI()
    self:FreshMergeStateUI()
    self:FreshScrollView()
end

function CatBallExchangePopup:FreshMaxStarCatBallFilterState(isFilter)
    self.ToggleNode.isOn = isFilter

end

function CatBallExchangePopup:FreshMergeStateUI()
    -- self.Text.Status = self._mergeMode

    local isSingle = self._mergeMode == MergeMode.Single
    KTool.SetActive(self.SingleMerge.gameObject, isSingle)
    if isSingle then
        self:FreshSingeMergeNodes()
    end

    local totalSelectNum = 0
    for index, value in pairs(self._selectedGoodsId2Num) do
        totalSelectNum = totalSelectNum + value
    end
    if totalSelectNum <= 0 then
        self._selectQuality = nil
    end
    local isHighlight = totalSelectNum >= self._mergeNeedNum
    self:FreshMiddleNode(isHighlight)
    self:FreshMergeBtn(isHighlight, totalSelectNum)
end 


function CatBallExchangePopup:FreshSingeMergeNodes()
    for i = 1, self._mergeNeedNum do
        local nodeInfo = self._singleMergeNodeInfoList[i]
        if nodeInfo == nil then
            local child    = self.SingleMerge:GetChild(i - 1)
            local ImgEmpty = child:Find("ImgEmpty").gameObject
            local GoodNode = child:Find("GoodNode").gameObject
            nodeInfo = {ImgEmpty = ImgEmpty, GoodNode = GoodNode, goodsData = nil}
            self._singleMergeNodeInfoList[i] = nodeInfo
        end

        self:FreshSingeMergeNode(nodeInfo, i)
    end
end

function CatBallExchangePopup:FreshSingeMergeNode(nodeInfo, infoIndex)
    local goodsData = nodeInfo.goodsData
    local isEmpty = goodsData == nil
    KTool.SetActive(nodeInfo.ImgEmpty, isEmpty)
    KTool.SetActive(nodeInfo.GoodNode, not isEmpty)
    if not isEmpty then
        CfUtils.RefeshGoodGo2(nodeInfo.GoodNode, goodsData.goodsId, nil, nil, nil, function ()

            local selectNum, goodsId
            local nodeCount = 0
            for index, value in ipairs(self._singleMergeNodeInfoList) do
                if index == infoIndex then
                    --- 该道具选择的数量减1
                    local goodsData = value.goodsData
                    goodsId   = goodsData.goodsId
                    selectNum = self:UpdateGoodsNum(goodsData, -1)
                    --- 清除绑定的道具数据
                    self._singleMergeNodeInfoList[index].goodsData = nil

                elseif value.goodsData then
                    nodeCount = nodeCount + 1

                end
            end

            ---有效的节点数量为0的话
            if nodeCount == 0 then
                self._selectQuality = nil
                self:FreshUI()

            --- 该道具选择数量为0的时候刷新下对应的列表cell数据
            else
                --- 刷新UI
                self:FreshSingeMergeNode(self._singleMergeNodeInfoList[infoIndex], infoIndex)

                self:FreshMergeStateUI()
                
                --- 获取该道具id 对于的列表下标
                for index, value in ipairs(self._goodsDataList) do
                    if goodsId == value.goodsId then
                        self:FreshCellSelectState(index, selectNum)
                        break
                    end
                end
            end

        end)
    end
    
end

function CatBallExchangePopup:FreshMiddleNode(isHighlight)
    KTool.SetActive(self.MiddleImgEmpty.gameObject, not isHighlight)
    KTool.SetActive(self.MiddleImgQuality.gameObject, isHighlight)
    if isHighlight then
        self.ImgQuality_Center.Status = self._selectQuality
    end

end

function CatBallExchangePopup:FreshMergeBtn(isHighlight, totalSelectNum)
    self.MergeButton:ResetFontStyle(isHighlight and "B6" or "B18")

    local isMulti = self._mergeMode == MergeMode.Multiple
    KTool.SetActive(self.CommonBtnConsumePop.gameObject, isHighlight)
    
    totalSelectNum = isHighlight and totalSelectNum or 0
    KTool.SetActive(self.TextDesc.gameObject, isMulti and totalSelectNum > 0)
    self._totalSelectNum = totalSelectNum
    local times = math.floor(totalSelectNum / self._mergeNeedNum)
    if isHighlight then
        local consumeNum = self._consumeNum * times
        self._mergeConsumeNum = consumeNum
        
        UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, self._consumeId, consumeNum)
    else
        self._totalSelectNum = totalSelectNum
        self._mergeConsumeNum = 0
    end

    if isMulti then
        self.TextDesc.text = localize("可批量融合_num_次", {_num_ = times})
    end
end

function CatBallExchangePopup:FreshScrollView()
    local ScrollView = self.ScrollView
    local count = #self._goodsDataList
    local isShow = count > 0
    KTool.SetActive(ScrollView.gameObject, isShow)
    KTool.SetActive(self.EmptyNode.gameObject, not isShow)
    if not isShow then
        return
    end
    if not ScrollView.IsListViewInit then
        ScrollView:InitGridView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end

end

function CatBallExchangePopup:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(Cell)
    local node = GetLuaBehaviour(cell.gameObject, EnvPath)
    
    ---@type CatBallExchangePopupCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
        nodeEnv:SetBtnClickCallback(Bind(self, self.OnCellBtnClickAction))
        nodeEnv:SetBtnReduceClickCallback(Bind(self, self.OnCellBtnReduceClickAction))
        nodeEnv:SetBtnReducePressCallback(Bind(self, self.OnCellBtnReducePressAction))

    else
        nodeEnv = node.Env

    end

    if nodeEnv then
        local position = index + 1
        local goodsData = self._goodsDataList[position]
        nodeEnv:FreshUI(goodsData, position)
        local goodsId = goodsData.goodsId
        local selectNum = self._selectedGoodsId2Num[goodsId] or 0
        local isCannotSelect = self._selectQuality ~= nil and self._selectQuality ~= goodsData.quality
        nodeEnv:FreshSelectState(selectNum, isCannotSelect, self._mergeMode == MergeMode.Single)

    end

    return cell
end

function CatBallExchangePopup:FreshCellSelectState(position, selectNum)
    local node = self.ScrollView:GetShownItemByItemIndex(position - 1)
    if isNull(node) then return end
    ---@type CatBallExchangePopupCell
    local env  = CfUtils.GetLuaScr(node, EnvPath)
    if isNull(env) then return end
    env:FreshSelectState(selectNum, false, self._mergeMode == MergeMode.Single)

end

---UpdateGoodsNum
---@param goodsData table 道具数据
---@param difference number 差值
function CatBallExchangePopup:UpdateGoodsNum(goodsData, difference)
    local goodsId                      = goodsData.goodsId 
    local ownNum                       = goodsData.num 
    local goodsSelectNum               = (self._selectedGoodsId2Num[goodsId] or 0) + difference
    goodsSelectNum                     = math.max(0, math.min(goodsSelectNum, ownNum))
    self._selectedGoodsId2Num[goodsId] = goodsSelectNum > 0 and goodsSelectNum or nil
    return goodsSelectNum
end

function CatBallExchangePopup:FreshUIBySelectNum(goodsData, difference, env)
    local goodsSelectNum = self:UpdateGoodsNum(goodsData, difference)
    if goodsSelectNum <= 0 then
        self:FreshUI()
    else
        self:FreshMergeStateUI()
        env:FreshSelectState(goodsSelectNum, false, false)
    end
end


function CatBallExchangePopup:SwitchMergeMode()
    -- self._mergeMode = self._mergeMode == MergeMode.Single and MergeMode.Multiple or MergeMode.Single
    self:ClearSelectData()
    self:FreshUI()

end

function CatBallExchangePopup:ClearSelectData()
    self._selectedGoodsId2Num = {}
    self._selectQuality = nil
    for index, value in ipairs(self._singleMergeNodeInfoList) do
        value.goodsData = nil
    end
end

function CatBallExchangePopup:ClearSelectDataBySingle()
    local selectedGoodsId2Num = self._selectedGoodsId2Num

    local goodsId2OwnNum = {}
    local goodsId2UseNum = {}
    for goodsId, num in pairs(selectedGoodsId2Num) do
        local ownNum = GoodsUtils.GetThingNo(goodsId)
        goodsId2OwnNum[goodsId] = ownNum
        goodsId2UseNum[goodsId] = 0
    end

    local singleMergeNodeInfoList = self._singleMergeNodeInfoList
    for index, value in pairs(singleMergeNodeInfoList) do
        local goodsData = value.goodsData
        if goodsData then
            local goodsId = goodsData.goodsId
            local ownNum  = goodsId2OwnNum[goodsId]
            goodsData.num = ownNum
            if ownNum <= 0 then
                selectedGoodsId2Num[goodsId] = nil
                singleMergeNodeInfoList[index] = nil
            elseif goodsId2UseNum[goodsId] == ownNum then 
                selectedGoodsId2Num[goodsId] = selectedGoodsId2Num[goodsId] - 1
                singleMergeNodeInfoList[index] = nil
            else
                goodsId2UseNum[goodsId] = goodsId2UseNum[goodsId] + 1
            end
        end
    end

    if next(selectedGoodsId2Num) == nil then
        self._selectQuality = nil
    end

end

--endregion 


--region get/set 

function CatBallExchangePopup:GetGoodsData(goodsId, goodsNum)
    ---@type CatBallGoodsVo
    local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
    local cardId = goodsVo.cardId
    ---@type CatBallVo
    local vo = CatBallUtils.GetCatBallVo(cardId)
    return {goodsVo = goodsVo, goodsId = goodsId, num = goodsNum, quality = vo.rare, star = self._catId2Star[goodsVo.cardId] or 0}
end

function CatBallExchangePopup:GetTipsText()
    if self._tipsText then
        return self._tipsText
    end

    local row = CfUtils.GetCfLine(AutoIds.IdSetting12, Constants.SystemToggleIds.Id3011)
    if isNotNull(row) then
        self._tipsText = parse_localizeText(row, "descr", true, "")
    end

    return self._tipsText
end

---endregion 


--region handler 

function CatBallExchangePopup:OnClickBtnCloseAction()
    -- self.controller:Close()
    CfUtils.DialogBack()
end

function CatBallExchangePopup:OnClickToggleNodeAction(isOn)
    local dataList = isOn and {} or self._originGoodsDataList
    if isOn then
        local starMax = self._starMax
        if starMax > 0 then
            for index, value in ipairs(self._originGoodsDataList) do
               if value.star == starMax then
                    table.insert(dataList, value)
               end 
            end
        end
        self._goodsDataList = dataList

    else
        self._goodsDataList = self._originGoodsDataList

    end
    self:FreshScrollView()

end


function CatBallExchangePopup:OnClickMergeButtonAction()
    if self._mergeConsumeNum == 0 then
        GameUtils.Toast(localize("未满足融合条件"))
        return
    end

    local consumes = {{goodsId = self._consumeId, num = self._mergeConsumeNum}}
    local realConsumes, errorTip = GoodsUtils.CheckGoodConsume(consumes)
    if errorTip then
        GameUtils.Toast(errorTip)
        return 
    end

    local goods = {}
    local overflowCount = self._totalSelectNum % self._mergeNeedNum
    for goodsId, num in pairs(self._selectedGoodsId2Num) do
        if overflowCount > 0 then
            local isOverflow = overflowCount >= num
            if isOverflow then
                overflowCount, num = (overflowCount - num), 0
            else
                overflowCount, num = 0, (num - overflowCount)
            end
            
            self._selectedGoodsId2Num[goodsId] = num
        end
        if num > 0 then
            table.insert(goods, {goodsId = goodsId, num = num})
            table.insert(realConsumes, {goodsId = goodsId, num = -1 * num})
        end
    end

    local interface = Interfaces.OverseaCatBallFragmentFusion
    
    -- if true then
    --     local response = table.deserialize([[{"data":{"rewards":[{"goodsId":670103002,"num":1}]},"errCode":0,"errMsg":"","timestamp":1691067383}]])
    --     self:HandleFragmentFusion(response.data, realConsumes)
    --     return
    -- end
    GameUtils.Request(interface, {goods = table.serialize(goods)}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        self:HandleFragmentFusion(response.data, realConsumes, goods)
        
    end)
end

function CatBallExchangePopup:HandleFragmentFusion(responseData, realConsumes, goods)
    Events.Broadcast("OverseaCatBallFragmentFusion.RequestComplete")
    ---是否勾选满星
    local isOn    = self.ToggleNode.isOn
    local rewards = responseData.rewards or {}
    GoodsUtils.DrawRewards(realConsumes)
    GoodsUtils.DrawRewards(rewards)

    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewards}, nil, false)

    self:InitDataList(function(goodsData) 
        if not isOn then
            return true
        else
            return  goodsData.star == self._starMax
        end
    end)

    if self._mergeMode == MergeMode.Single then
        self:ClearSelectDataBySingle()
    else
        self:ClearSelectData()
    end

    self:FreshUI()
end

---OnCellBtnClickAction
---@param goodsData table
---@param position number
---@param env CatBallExchangePopupCell
function CatBallExchangePopup:OnCellBtnClickAction(goodsData, position, env)
    local goodsId = goodsData.goodsId 
    local ownNum  = goodsData.num
    -- ---@type GoodsVo
    -- local goodsVo = goodsData.goodsVo
    local quality = goodsData.quality
    local isFirstSelect, goodsSelectNum
    local isSingle = self._mergeMode == MergeMode.Single
    if isSingle then
        --- 单选模式点击 右侧已选道具 减去数量
        local totalSelectNum = 0
        for key, value in pairs(self._selectedGoodsId2Num) do
            totalSelectNum = totalSelectNum + value
        end
        if totalSelectNum >= self._mergeNeedNum then
            GameUtils.Toast(localize("已满足融合所需数量"))
            return
        end
        goodsSelectNum = self._selectedGoodsId2Num[goodsId] or 0
        if goodsSelectNum >= ownNum then
            GameUtils.Toast(localize("该猫球基因数量不足"))
            return
        end
        
        isFirstSelect = self._selectQuality == nil
        if isFirstSelect then
            self._selectQuality = quality
        elseif quality ~= self._selectQuality then
            GameUtils.Toast(localize("该猫球基因品质不符"))
            return
        end
        -- goodsSelectNum = goodsSelectNum + 1
        -- self._selectedGoodsId2Num[goodsId] = goodsSelectNum
        goodsSelectNum = self:UpdateGoodsNum(goodsData, 1)

        for index, nodeInfo in ipairs(self._singleMergeNodeInfoList) do
            if nodeInfo.goodsData == nil then
                nodeInfo.goodsData = goodsData
                break
            end
        end

    elseif self._mergeMode == MergeMode.Multiple then
        goodsSelectNum = self._selectedGoodsId2Num[goodsId] or 0
        isFirstSelect = self._selectQuality == nil
        --- 多选模式 不是第一次选择 并且 选择的道具不是上次选择的道具
        if not isFirstSelect and quality ~= self._selectQuality then
            GameUtils.Toast(localize("暂不能选择该猫球基因"))
            return
        end
        if goodsSelectNum >= ownNum then
            GameUtils.Toast(localize("该猫球基因选择数量已达到上限"))
            return
        end

        if isFirstSelect then
            self._selectQuality = quality
        end
        
        -- goodsSelectNum = ownNum
        goodsSelectNum = self:UpdateGoodsNum(goodsData, ownNum)

    end

    if isFirstSelect then
        self:FreshScrollView()
    else
        --- 刷新点击的UI
        local isCannotSelect = self._selectQuality ~= nil and self._selectQuality ~= goodsData.quality
        env:FreshSelectState(goodsSelectNum, isCannotSelect, isSingle)
    end   
    self:FreshMergeStateUI()
end

---OnCellBtnReduceClickAction
---@param goodsData table
---@param position number
---@param env CatBallExchangePopupCell
function CatBallExchangePopup:OnCellBtnReduceClickAction(goodsData, position, env)
    self:FreshUIBySelectNum(goodsData, -1, env)

end
function CatBallExchangePopup:OnCellBtnReducePressAction(goodsData, position, num, env)
    self:FreshUIBySelectNum(goodsData, -num, env)
end

function CatBallExchangePopup:OnClickBtnExplainAction()
    -- self._isShowTips = not self._isShowTips
    -- KTool.SetActive(self.TxtTips.gameObject, self._isShowTips)
    CfUtils.ShowModuleToast(Constants.SystemToggleIds.Id3011)
    
end

---endregion 


return CatBallExchangePopup

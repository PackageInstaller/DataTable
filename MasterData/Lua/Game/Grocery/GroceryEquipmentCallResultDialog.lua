-------------------------------------------------------------------------------
-- 杂货铺 - 装备抽取 - 抽取结果展示弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-27 14:53:49
-------------------------------------------------------------------------------

---@type GroceryConstants
local GroceryConstants = import('Game.Grocery.GroceryConstants')
---@type BackpackComponent
local backpackComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.BackpackComponent)

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverseaStore/OverseaStoreEquipDrawResultDialog.prefab
---@class GroceryEquipmentCallResultDialog
---@field Env                           	GroceryEquipmentCallResultDialog        
---@field controller                    	Engine.UI.UILuaDialog                   
---@field DrawContentTenNode            	UnityEngine.RectTransform               @ 十抽容器节点
---@field DrawContentOneNode            	UnityEngine.RectTransform               @ 单抽容器节点
---@field StopButton                    	UnityEngine.RectTransform               @ 停止按钮
---@field QuantityEquipNumberText       	UnityEngine.RectTransform               @ 装备数量文本
---@field QuantityEquipNode             	UnityEngine.RectTransform               @ 装备数量节点
---@field QuantityGoodsNumberText       	UnityEngine.RectTransform               @ 物品数量文本
---@field QuantityGoodsNode             	UnityEngine.RectTransform               @ 物品数量节点
---@field QuantityNode                  	UnityEngine.RectTransform               @ 背包数量节点
---@field ClickClose                    	UnityEngine.RectTransform               @ 空白关闭区域
local GroceryEquipmentCallResultDialog = Class('GroceryEquipmentCallResultDialog')

local ResultCellLuaPath = 'Game.Grocery.Cell.GroceryEquipmentCallResultCell'


function GroceryEquipmentCallResultDialog:__init()
    ---@type fun():void
    self.stopCallback_ = nil
    ---@type fun():void
    self.closeCallback_ = nil
    ---@type UnityEngine.Coroutine
    self.autoPlayCo_ = false
    ---@type GroceryEquipmentCallResultCell[]
    self.resultCells_ = {}
    ---@type DG.Tweening.Tweener
    self.packInfoTween_ = nil
    ---@type boolean
    self.hasDecompose_ = nil
end


function GroceryEquipmentCallResultDialog:__delete()
    self.stopCallback_  = nil
    self.closeCallback_ = nil
    self.autoPlayCo_    = nil
    self.resultCells_   = nil
    self.packInfoTween_ = nil
    self.hasDecompose_  = nil
    self.controller     = nil
end


function GroceryEquipmentCallResultDialog:Awake()
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.StopButton, Bind(self, self.OnClickStopButtonHandler_))
end


function GroceryEquipmentCallResultDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.stopCallback_  = initParams.stopCb
        self.closeCallback_ = initParams.closeCb

        -- update currencyIdList
        local currencyIdList = checkTable(initParams.currencyIdList)
        CfUtils.RefreshTopGoods(currencyIdList)

        -- update displayDataList
        self:SetDisplayDataList(initParams.displayList)

        -- check hasDecompose
        self.hasDecompose_ = false
        for _, displayData in ipairs(self:GetDisplayDataList()) do
            local decomposes  = checkTable(displayData.decompose)
            if #decomposes > 0 then
                self.hasDecompose_ = true
                break
            end 
        end

        if self.hasDecompose_ then
            self:UpdateEquipPackInfo_()--initParams.oldQquipPackNum)
            self:UpdateGoodsPackInfo_(initParams.oldGoodsPackNum)
        else
            self:UpdateEquipPackInfo_()
            self:UpdateGoodsPackInfo_()
        end

        -- play show sound
        GameUtils.GetCriWareUtils().PlaySeById(GroceryConstants.CallEquipAnimSoundDefine.RESULT_SHOW)
        
        local isAutoPlayMode = checkBool(initParams.isAutoMode)
        if isAutoPlayMode then
            CfUtils.SetActive(self.ClickClose, false)
            CfUtils.SetActive(self.StopButton, false)
            self:StartAutoPlayCountdown_()
        end
    end)
end


function GroceryEquipmentCallResultDialog:OnFinalize()
    return CoWaitDo(function()
        Events.Broadcast('DestoryCommonTipsBord')
        self:CloseAutoPlayCountdown_()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@type table[]
function GroceryEquipmentCallResultDialog:GetDisplayDataList()
    return checkTable(self.displayDataList_)
end
function GroceryEquipmentCallResultDialog:SetDisplayDataList(dataList)
    self.displayDataList_ = checkTable(dataList)
    self:UpdateDisplayDataList_()
end


-------------------------------------------------
-- public

function GroceryEquipmentCallResultDialog:Close()
    if self.closeCallback_ then
        self.closeCallback_()
    end
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function GroceryEquipmentCallResultDialog:CloseAutoPlayCountdown_()
    if self.packInfoTween_ then
        self.packInfoTween_:Kill()
        self.packInfoTween_ = nil
    end
    if self.autoPlayCo_ ~= nil then
        CoStop(self.autoPlayCo_)
        self.autoPlayCo_ = nil
    end
end


function GroceryEquipmentCallResultDialog:StartAutoPlayCountdown_()
    self.autoPlayCo_ = CoStart(function()

        local playingCount = #self.resultCells_
        if playingCount > 0 then
            if self.hasDecompose_ then
                -- 分解吸入到UI节点时：更新最新的背包数
                self.packInfoTween_ = CfUtils.DoTween(1.2, nil, function()
                    -- self:UpdateEquipPackInfo_()
                    self:UpdateGoodsPackInfo_()
                end)
                -- play move sound
                CfUtils.DoTween(0.8, nil, function()
                    GameUtils.GetCriWareUtils().PlaySeById(GroceryConstants.CallEquipAnimSoundDefine.RESULT_MOVE)
                end)
            end
            -- 做分解吸入
            for _, resultCell in ipairs(self.resultCells_) do
                resultCell:DoShowAnimation(self.QuantityGoodsNumberText, function()
                    playingCount = playingCount - 1
                end)
            end
            while playingCount > 0 do
                CoYield()
            end
        else
            -- 增加容错，避免返回 displayRewards 为空时，这个界面打开后瞬间关闭的报错问题，故此稍作停留一下
            local rootAnimNode = self.controller.transform:Find('Root')
            local rootAnimTime = CfUtils.GetAnimationTime(rootAnimNode, 'OverseaStoreEquipDrawResultDialog_Go')
            CoYield(rootAnimTime)
        end
        
        self.autoPlayCo_ = nil
        self:Close()
    end)
end


---@param showPackNum integer | nil
function GroceryEquipmentCallResultDialog:UpdateEquipPackInfo_(showPackNum)
    local equipPackId = Constants.BackpackTypeId.EQUIP
    local packLimit   = backpackComp:GetPacketLimitByPacketId(equipPackId)
    local packOwned   = showPackNum or backpackComp:GetGoodsNumByPacketId(equipPackId)
    local countColor  = packOwned >= packLimit and '#ff43c3' or '#ffffff'
    local packNumText = string.fmt('<color=_color_>_num_</color> / _max_', {_color_ = countColor, _num_ = packOwned, _max_ = packLimit})
    CfUtils.FillText(self.QuantityEquipNumberText, packNumText)
end


---@param showPackNum integer | nil
function GroceryEquipmentCallResultDialog:UpdateGoodsPackInfo_(showPackNum)
    local goodsPackId = Constants.BackpackTypeId.MATERIAL
    local packLimit   = backpackComp:GetPacketLimitByPacketId(goodsPackId)
    local packOwned   = showPackNum or backpackComp:GetGoodsNumByPacketId(goodsPackId)
    local countColor  = packOwned >= packLimit and '#ff43c3' or '#ffffff'
    local packNumText = string.fmt('<color=_color_>_num_</color> / _max_', {_color_ = countColor, _num_ = packOwned, _max_ = packLimit})
    CfUtils.FillText(self.QuantityGoodsNumberText, packNumText)
end


function GroceryEquipmentCallResultDialog:UpdateDisplayDataList_()
    self.resultCells_ = {}
    local displayDataList = self:GetDisplayDataList()
    if #displayDataList <= 0 then
        CfUtils.SetActive(self.DrawContentOneNode, false)
        CfUtils.SetActive(self.DrawContentTenNode, false)

    elseif #displayDataList == 1 then
        CfUtils.SetActive(self.DrawContentOneNode, true)
        CfUtils.SetActive(self.DrawContentTenNode, false)
        local resultCell  = CfUtils.GetLuaScr(self.DrawContentOneNode:Find('Cell'), ResultCellLuaPath)
        self.resultCells_[1] = resultCell
    else
        CfUtils.SetActive(self.DrawContentOneNode, false)
        CfUtils.SetActive(self.DrawContentTenNode, true)
        for cellIndex = 1, 10 do
            local resultCell = CfUtils.GetLuaScr(self.DrawContentTenNode:Find('Cell'..cellIndex), ResultCellLuaPath)
            self.resultCells_[cellIndex] = resultCell
        end
    end

    -- update resultCell list
    for dataIndex, displayData in ipairs(displayDataList) do
        local resultCell = self.resultCells_[dataIndex]
        if resultCell then
            resultCell:SetDisplayData(displayData)
        end
    end
end


-------------------------------------------------
-- handler

function GroceryEquipmentCallResultDialog:OnClickCloseButtonHandler_()
    self:Close()
end


function GroceryEquipmentCallResultDialog:OnClickStopButtonHandler_()
    if self.stopCallback_ then
        self.stopCallback_()
    end
    CfUtils.SetActive(self.StopButton)
end


return GroceryEquipmentCallResultDialog

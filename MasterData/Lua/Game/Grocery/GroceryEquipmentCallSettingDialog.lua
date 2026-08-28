-------------------------------------------------------------------------------
-- 杂货铺 - 装备抽取 - 连续抽设置弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-22 15:33:29
-------------------------------------------------------------------------------

local ScreenVo = import('Game.Setting.Vo.ScreenVo')
local cardConfMgr = CardConfMgr:GetInstance()

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverseaStore/OverseaStoreEquipDrawScreen.prefab
---@class GroceryEquipmentCallSettingDialog
---@field Env                           	GroceryEquipmentCallSettingDialog       
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ContentTypeListCell           	UnityEngine.RectTransform               @ 筛选类型节点
---@field ContentTypeList               	UnityEngine.RectTransform               @ 筛选类型列表
---@field QuantityValueText             	UnityEngine.RectTransform               @ 次数：数量文本框
---@field QuantityInputField            	TMPro.TMP_InputField                    @ 次数：数量输入框
---@field QuantityReduceBtn             	UnityEngine.RectTransform               @ 次数：减10次按钮
---@field QuantityAddBtn                	UnityEngine.RectTransform               @ 次数：加10次按钮
---@field ChooseNumberNode              	UnityEngine.RectTransform               @ 次数：数量区节点
---@field QuantityLabel                 	UnityEngine.RectTransform               @ 次数：次数选项
---@field UnlimitedLabel                	UnityEngine.RectTransform               @ 次数：无限选项
---@field DecompTips                    	UnityEngine.RectTransform               @ 分解提示
---@field BtnConfirm                    	UnityEngine.RectTransform               @ 确认按钮
---@field BtnClose                      	UnityEngine.RectTransform               @ 关闭按钮
---@field PopupTitle                    	UnityEngine.RectTransform               @ 背景板标题节点
---@field PopupBoard                    	UnityEngine.RectTransform               @ 背景板节点
---@field RootNode                      	UnityEngine.RectTransform               @ UI根节点
---@field BackBlock                     	UnityEngine.RectTransform               @ 半透明底背
local GroceryEquipmentCallSettingDialog = Class('GroceryEquipmentCallSettingDialog')

local AUTO_TIMES_INTERVAL = 10  -- 自动抽数量间隔
local AUTO_TIMES_LIMIT    = 100 * AUTO_TIMES_INTERVAL  -- 自动抽数量上限
local DECOMPOSE_INDEX     = {
    RARE = 1,
    PART = 2,
    SUIT = 3,
}


function GroceryEquipmentCallSettingDialog:__init()
    ---@type table
    self.equipGroceryData_ = nil
    ---@type table[]
    self.selectedGroup_ = nil
    ---@type fun():void
    self.settingSavedCB_ = nil
    ---@type ScreenToggle
    self.unlimitedToggle_ = nil
    ---@type ScreenToggle
    self.quantityToggle_ = nil
end


function GroceryEquipmentCallSettingDialog:__delete()
    self.equipGroceryData_ = nil
    self.selectedGroup_    = nil
    self.settingSavedCB_   = nil
    self.unlimitedToggle_  = nil
    self.quantityToggle_   = nil
    self.controller        = nil
end


function GroceryEquipmentCallSettingDialog:Awake()
    self.quantityToggle_  = CfUtils.GetLuaScr(self.QuantityLabel, Constants.UILuaTablePath.ScreenToggle)
    self.unlimitedToggle_ = CfUtils.GetLuaScr(self.UnlimitedLabel, Constants.UILuaTablePath.ScreenToggle)
    self.quantityToggle_.onChangeCB = Bind(self, self.OnQuantityToggleChangeHandler_)
    self.unlimitedToggle_.onChangeCB = Bind(self, self.OnUnlimitedToggleChangeHandler_)

    self.QuantityInputField.interactable = false  -- 禁用输入。因为必须要10的倍数，手动输入不好控制

    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.BackBlock, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.BtnConfirm, Bind(self, self.OnClickConfirmButtonHandler_))
    SetButtonAction(self.QuantityAddBtn, Bind(self, self.OnClickChangeCallTimesButtonHandler_, AUTO_TIMES_INTERVAL))
    SetButtonAction(self.QuantityReduceBtn, Bind(self, self.OnClickChangeCallTimesButtonHandler_, -AUTO_TIMES_INTERVAL))
end


function GroceryEquipmentCallSettingDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.equipGroceryData_ = initParams.equipGroceryData
        self.settingSavedCB_   = initParams.savedCB

        local decomposeSetting = checkTable(self.equipGroceryData_.decompose)
        local selectRareIdList = {}
        local selectSuitIdList = {}
        local selectPartIdList = {}
        for dataIndex, rareId in ipairs(decomposeSetting.quality or {}) do
            selectRareIdList[dataIndex] = checkInt(rareId)
        end
        for dataIndex, suitId in ipairs(decomposeSetting.suit or {}) do
            selectSuitIdList[dataIndex] = checkInt(suitId)
        end
        for dataIndex, partId in ipairs(decomposeSetting.position or {}) do
            selectPartIdList[dataIndex] = checkInt(partId)
        end
        self.selectedGroup_ = {
            [DECOMPOSE_INDEX.RARE] = selectRareIdList,
            [DECOMPOSE_INDEX.SUIT] = selectSuitIdList,
            [DECOMPOSE_INDEX.PART] = selectPartIdList,
        }

        local callTimesSetting = checkInt(decomposeSetting.callTimes)
        self:SetAutoCallTimes(callTimesSetting > 0 and callTimesSetting or AUTO_TIMES_INTERVAL)
        self:SetEndlessAutoCall(callTimesSetting == -1)

        self:UpdateContentTypeList_()
    end)
end


function GroceryEquipmentCallSettingDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function GroceryEquipmentCallSettingDialog:GetAutoCallTimes()
    return checkInt(self.autoCallTimes_)
end
function GroceryEquipmentCallSettingDialog:SetAutoCallTimes(times)
    self.autoCallTimes_ = checkInt(times)
    self:UpdateAutoCallTimes_()
end


---@return boolean
function GroceryEquipmentCallSettingDialog:IsEndlessAutoCall()
    return checkBool(self.isEndlessAutoCall_)
end
function GroceryEquipmentCallSettingDialog:SetEndlessAutoCall(isEndless)
    self.isEndlessAutoCall_ = checkBool(isEndless)
    self:UpdateEndlessCallState_()
end


-------------------------------------------------
-- public

function GroceryEquipmentCallSettingDialog:Close()
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function GroceryEquipmentCallSettingDialog:UpdateContentTypeList_()
    local rareScreenVo = cardConfMgr:GetAllScreenVo(Constants.UIFilterType.Equip)[1]

    ---@type ScreenVo
    local partScreenVo = ScreenVo.New()
    partScreenVo.type  = localize('部  位:')
    ---@param equipmentPartVo EquipmentPartVo
    for voIndex, equipmentPartVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting3051, 'EquipmentPartVo')) do
        partScreenVo.condition[voIndex]     = equipmentPartVo.id
        partScreenVo.conditionName[voIndex] = equipmentPartVo.dec
    end
    
    ---@type ScreenVo
    local suitScreenVo = ScreenVo.New()
    suitScreenVo.type  = localize('套  装:')
    ---@param equipFilterVo EquipFilterVo
    for voIndex, equipFilterVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting102, 'EquipFilterVo')) do
        suitScreenVo.condition[voIndex]     = equipFilterVo.id
        suitScreenVo.conditionName[voIndex] = equipFilterVo.name
    end
    
    -- package data
    local screenList = {
        [DECOMPOSE_INDEX.RARE] = rareScreenVo,
        [DECOMPOSE_INDEX.SUIT] = suitScreenVo,
        [DECOMPOSE_INDEX.PART] = partScreenVo,
    }

    -- update typeList
    local typeListNode = self.ContentTypeList.gameObject
    local typeCellNode = self.ContentTypeListCell.gameObject
    ---@param screenVo ScreenVo
    for screenIndex, screenVo in ipairs(screenList) do
        screenVo.id = screenIndex

        local typeCell = typeListNode.transform:Find(screenIndex)
        if isNull(typeCell) then
            typeCell = typeListNode:AddChild(typeCellNode)
        end
        typeCell.name = screenIndex
        CfUtils.SetActive(typeCell, true)

        ---@type UIScreenType
        local env = CfUtils.GetLuaScr(typeCell, Constants.UILuaTablePath.UIScreenType)
        if not isNull(env) then
            env:FreshNode(screenVo, self.selectedGroup_)
        end
    end
end


function GroceryEquipmentCallSettingDialog:UpdateAutoCallTimes_()
    self.QuantityInputField.text = tostring(self:GetAutoCallTimes())
end


function GroceryEquipmentCallSettingDialog:UpdateEndlessCallState_()
    if self:GetAutoCallTimes() == 0 then  -- default
        self.quantityToggle_:OnValueChange(false)
        self.unlimitedToggle_:OnValueChange(false)
        CfUtils.SetActive(self.ChooseNumberNode, false)
    else
        local isEndlessAutoCall = self:IsEndlessAutoCall()
        self.quantityToggle_:OnValueChange(not isEndlessAutoCall)
        self.unlimitedToggle_:OnValueChange(isEndlessAutoCall)
        CfUtils.SetActive(self.ChooseNumberNode, not isEndlessAutoCall)
    end
end


-------------------------------------------------
-- handler

function GroceryEquipmentCallSettingDialog:OnClickCloseButtonHandler_()
    self:Close()
end


---@param isToggleOn boolean
function GroceryEquipmentCallSettingDialog:OnQuantityToggleChangeHandler_(isToggleOn)
    self:SetEndlessAutoCall(false)
end


---@param isToggleOn boolean
function GroceryEquipmentCallSettingDialog:OnUnlimitedToggleChangeHandler_(isToggleOn)
    self:SetEndlessAutoCall(true)
end


---@param callTimes integer
function GroceryEquipmentCallSettingDialog:OnClickChangeCallTimesButtonHandler_(callTimes)
    if callTimes > 0 then
        if self:GetAutoCallTimes() < AUTO_TIMES_LIMIT then
            self:SetAutoCallTimes(self:GetAutoCallTimes() + callTimes)
        else
            GameUtils.Toast(localize('为什么不试试用无限制呢'))
        end
    else
        if self:GetAutoCallTimes() > AUTO_TIMES_INTERVAL then
            self:SetAutoCallTimes(self:GetAutoCallTimes() + callTimes)
        end
    end
end


function GroceryEquipmentCallSettingDialog:OnClickConfirmButtonHandler_()
    if not self:IsEndlessAutoCall() and self:GetAutoCallTimes() <= 0 then
        GameUtils.Toast(localize('请设置连续次数'))
        return
    end

    local decomposeSetting = {
        quality   = checkTable(self.selectedGroup_[DECOMPOSE_INDEX.RARE]),
        suit      = checkTable(self.selectedGroup_[DECOMPOSE_INDEX.SUIT]),
        position  = checkTable(self.selectedGroup_[DECOMPOSE_INDEX.PART]),
        callTimes = self:IsEndlessAutoCall() and -1 or self:GetAutoCallTimes(),
    }

    local groceryData = self.equipGroceryData_
    local requestData = {poolId = groceryData.poolId, decompose = table.serialize(decomposeSetting)}
    GameUtils.Request(Interfaces.GroceryDecompose, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            GameUtils.Toast(localize('已设定连续抽取'))

            -- update cache
            self.equipGroceryData_.decompose = decomposeSetting

            -- call savedCB
            if self.settingSavedCB_ then
                self.settingSavedCB_()
            end

            -- close
            self:Close()
        end
    end)
end


return GroceryEquipmentCallSettingDialog

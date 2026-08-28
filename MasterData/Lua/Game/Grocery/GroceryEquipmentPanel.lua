-------------------------------------------------------------------------------
-- 杂货铺 - 装备抽取面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-16 18:38:03
-------------------------------------------------------------------------------

local ResourceModule = CS.Engine.Modules.ResourceModule
---@type GroceryConstants
local GroceryConstants = import('Game.Grocery.GroceryConstants')
---@type GroceryUtils
local GroceryUtils = import('Game.Grocery.GroceryUtils')
---@type GroceryMgr
local groceryMgr = import('Game.Grocery.GroceryMgr'):GetInstance()
---@type GoodsConfMgr
local goodsConfMgr = GoodsConfMgr:GetInstance()

--- from: Assets/BundleResources/Prefabs/OverseaStore/OverseaStoreEquipDrawEntryDialog.prefab
---@class GroceryEquipmentPanel
---@field Env                           	GroceryEquipmentPanel                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnContinuousNodeSourceText   	UnityEngine.RectTransform               @ 批量购买按钮：次数文本
---@field BtnContinuousNode             	UnityEngine.RectTransform               @ 批量购买按钮
---@field BtnTenNodeSourceText2         	UnityEngine.RectTransform               @ 十次购买按钮：购买节点2
---@field BtnTenNodeSourceImage2        	UnityEngine.RectTransform               @ 十次购买按钮：价格文本2
---@field BtnTenNodeSourceText          	UnityEngine.RectTransform               @ 十次购买按钮：购买节点
---@field BtnTenNodeSourceImage         	UnityEngine.RectTransform               @ 十次购买按钮：价格文本
---@field BtnTenNode                    	UnityEngine.RectTransform               @ 十次购买按钮
---@field BtnOneNodeFreeNode            	UnityEngine.RectTransform               @ 单次购买按钮：免费节点
---@field BtnOneNodeChargeNode          	UnityEngine.RectTransform               @ 单次购买按钮：购买节点
---@field BtnOneNodeSourceText          	UnityEngine.RectTransform               @ 单次购买按钮：价格文本
---@field BtnOneNodeSourceImage         	UnityEngine.RectTransform               @ 单次购买按钮：货币图标
---@field BtnOneNode                    	UnityEngine.RectTransform               @ 单次购买按钮
---@field BtnAutoDrawAnimRoot           	UnityEngine.RectTransform               @ 自动购买按钮：动画根节点
---@field BtnAutoDraw                   	UnityEngine.RectTransform               @ 自动购买按钮
---@field BtnDetails                    	UnityEngine.RectTransform               @ 详情按钮
---@field UIContainer                   	UnityEngine.RectTransform               @ 背景prefab容器
local GroceryEquipmentPanel = Class('GroceryEquipmentPanel')

local AUTO_DRAW_ANIM = {
    ON     = 'ON',
    OFF    = 'OFF',
    OFF_ON = 'OFF-ON',
    ON_OFF = 'ON-OFF',
}

local PRELOAD_ASSETS_BLOCKER = 'GroceryEquipmentPanel_PRELOAD_ASSETS_BLOCKER'

local DRAW_EQUIP_COOKIE_KEY = 'GroceryEquipmentPanel_DRAW_EQUIP_COOKIE_KEY'

local BG_NODE_ANIM_DEFINES = {
    [GroceryConstants.GroceryType.EquipmentGold] = {
        SHOW = 'OverseaStoreEquipDrawCoinDialogGo',
        IDLE = 'OverseaStoreEquipDrawCoinDialog_Idle',
    },
    [GroceryConstants.GroceryType.EquipmentPVPHigh] = {
        SHOW = 'OverseaStoreEquipDrawBlueDialogGo',
        IDLE = 'OverseaStoreEquipDrawBlueDialog_Idle',
    },
    [GroceryConstants.GroceryType.EquipmentPVPMiddle] = {
        SHOW = 'OverseaStoreEquipDrawRedDialogGo',
        IDLE = 'OverseaStoreEquipDrawRedDialog_Idle',
    },
    [GroceryConstants.GroceryType.EquipmentPVPLow] = {
        SHOW = 'OverseaStoreEquipDrawGreenDialogGo',
        IDLE = 'OverseaStoreEquipDrawGreenDialog_Idle',
    },
}


function GroceryEquipmentPanel:__init()
    ---@type table<string, UnityEngine.GameObject>
    self.backgroundNodeMap_ = {}
    ---@type table<string, table>
    self.equipmentDataMap_ = {}
    ---@type UnityEngine.GameObject
    self.preloadAssetsCo_ = nil
    ---@type boolean
    self.isFromDrawEquip_ = false
end


function GroceryEquipmentPanel:__delete()
    self.backgroundNodeMap_ = nil
    self.equipmentDataMap_  = nil
    self.preloadAssetsCo_   = nil
    self.isFromDrawEquip_   = nil
end


function GroceryEquipmentPanel:Awake()
    -- init equipmentData map
    local allEquipmentDatas = groceryMgr:GetGroceryComponent():GetEquipmentData()
    for _, equipmentData in ipairs(allEquipmentDatas) do
        local equipPoolType  = checkInt(equipmentData.poolType)
        local subGroceryType = GroceryConstants.EquipmentPoolTypeToGroceryType[equipPoolType]
        if subGroceryType then
            self.equipmentDataMap_[subGroceryType] = equipmentData
        end
    end
end


function GroceryEquipmentPanel:Start()
    SetButtonAction(self.BtnDetails, Bind(self, self.OnClickDetailsButtonHandler_))
    SetButtonAction(self.BtnOneNode, Bind(self, self.OnClickOneDrawButtonHandler_))
    SetButtonAction(self.BtnTenNode, Bind(self, self.OnClickTenDrawButtonHandler_))
    SetButtonAction(self.BtnAutoDraw, Bind(self, self.OnClickAutoDrawButtonHandler_))
    SetButtonAction(self.BtnContinuousNode, Bind(self, self.OnClickBatchButtonHandler_))

    self.isFromDrawEquip_ = checkInt(CfUtils.CookieLoad(DRAW_EQUIP_COOKIE_KEY)) == 1
    CfUtils.CookieSave(DRAW_EQUIP_COOKIE_KEY, nil)
end


function GroceryEquipmentPanel:OnDestroy()
    CfUtils.ConditionRemove(PRELOAD_ASSETS_BLOCKER)
    if self.preloadAssetsCo_ ~= nil then
        CoStop(self.preloadAssetsCo_)
        self.preloadAssetsCo_ = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return GroceryConstants.GroceryType
function GroceryEquipmentPanel:GetSubGroceryType()
    return checkString(self.subGroceryType_)
end
function GroceryEquipmentPanel:SetSubGroceryType(groceryType)
    local oldGroceryType = self:GetSubGroceryType()
    self.subGroceryType_ = checkString(groceryType)
    CoStart(function()
        self:UpdateBackgroundPanel_(oldGroceryType, self:GetSubGroceryType())
    end)
end


---@return table
function GroceryEquipmentPanel:GetSubGroceryData()
    return checkTable(self.subGroceryData_)
end
function GroceryEquipmentPanel:SetSubGroceryData(groceryData)
    self.subGroceryData_ = checkTable(groceryData)
    self:UpdateEquipmentPanel_()
    self:UpdateFreeCallState_()
end


---@return boolean
function GroceryEquipmentPanel:IsCanFreeOneCall()
    local equipGroceryData = self:GetSubGroceryData()
    return checkInt(equipGroceryData.dailyFreeCall) == 1  -- 1可抽取 2已抽取
end


---@return boolean
function GroceryEquipmentPanel:IsOpenAutoCall()
    return checkBool(self.isOpenAutoCall_)
end
function GroceryEquipmentPanel:SetOpenAutoCall(isOpenAuto)
    self.isOpenAutoCall_ = checkBool(isOpenAuto)
    self:UpdateAutoCallState_()
end


---@return integer
function GroceryEquipmentPanel:GetAutoCallTimes()
    return checkInt(self.autoCallTimes_)
end
function GroceryEquipmentPanel:SetAutoCallTimes(callTimes)
    self.autoCallTimes_ = checkInt(callTimes)
    self:UpdateAutoCallTimes_()
end


---@return integer[]
function GroceryEquipmentPanel:GetCurrencyIdList()
    return checkTable(self.currencyIdList_)
end
function GroceryEquipmentPanel:SetCurrencyIdList(idList)
    self.currencyIdList_ = checkTable(idList)
    CfUtils.RefreshTopGoods(self:GetCurrencyIdList())
end


-------------------------------------------------
-- public

---@param groceryType GroceryConstants.GroceryType
function GroceryEquipmentPanel:Refresh(groceryType)
    -- parent not refresh return
    if groceryType == GroceryConstants.GroceryType.Equipment then
        return
    end

    -- reset groceryData
    self:SetSubGroceryData(self.equipmentDataMap_[groceryType])
    
    -- reset groceryType
    self:SetSubGroceryType(groceryType)
    
    -- reset openAutoCall
    local localAutoKey = string.fmt(Constants.PlayerPrefsType.GroceryEquipAutoCall, {_type_ = self:GetSubGroceryType()})
    local localAutoVar = checkInt(CfUtils.GetLocalData(localAutoKey, 0))
    local decomposeMap = checkTable(self:GetSubGroceryData().decompose)
    local hasDecompose = next(decomposeMap) ~= nil
    self:SetOpenAutoCall(hasDecompose and localAutoVar == 1)

    -- reset autoCallTimes
    self:SetAutoCallTimes(decomposeMap.callTimes)
end


---@param groceryType GroceryConstants.GroceryType
function GroceryEquipmentPanel:RefreshCurrencyBar(groceryType)
    -- parent not refresh return
    if groceryType == GroceryConstants.GroceryType.Equipment then
        return
    end

    local equipGroceryData = self:GetSubGroceryData()
    local oneConsumeData   = checkTable(equipGroceryData.oneConsume)
    local currencyIdList   = { oneConsumeData.goodsId }

    -- check call prop
    ---@type GroceryEquipmentVo
    local equipmentVo = CfUtils.GetCfVo(AutoIds.IdSetting3075, "GroceryEquipmentVo", equipGroceryData.poolId) or {}
    if checkInt(equipmentVo.substituteProp) > 0 then
        table.insert(currencyIdList, equipmentVo.substituteProp)
    end
    self:SetCurrencyIdList(currencyIdList or {Constants.Currency.FreeDiamondId})
end


-------------------------------------------------
-- private

---@param oldGroceryType GroceryConstants.GroceryType | nil
---@param newGroceryType GroceryConstants.GroceryType
function GroceryEquipmentPanel:UpdateBackgroundPanel_(oldGroceryType, newGroceryType)
    -- close old background
    if oldGroceryType and self.backgroundNodeMap_[oldGroceryType] then
        local oldBackgroundNode = self.backgroundNodeMap_[oldGroceryType]
        CfUtils.SetActive(oldBackgroundNode, false)
    end

    local newBackgroundNode = self.backgroundNodeMap_[newGroceryType]
    if not newBackgroundNode then
        ---@type GroceryConstants.GroceryNodeConfig
        local groceryConfig = GroceryConstants.GroceryNodeConfigs[newGroceryType]
        if groceryConfig then
            -- create background
            newBackgroundNode = GameUtils.LoadBundleAsyncById(groceryConfig.prefabId, self.UIContainer.gameObject, false)
            self.backgroundNodeMap_[newGroceryType] = newBackgroundNode
        end
    end

    -- open new background
    if newBackgroundNode then
        local groceryUpImg = newBackgroundNode.transform:Find('Root/ImgTitle/ImgUp')
        if not isNull(groceryUpImg) then
            local equipGroceryData = self:GetSubGroceryData()
            CfUtils.SetActive(groceryUpImg, checkInt(equipGroceryData.isUp) == 1)
        end
        CfUtils.SetActive(newBackgroundNode, true)
        
        local bgNodeAnimDefine = BG_NODE_ANIM_DEFINES[self:GetSubGroceryType()]
        if bgNodeAnimDefine then
            local animName = self.isFromDrawEquip_ and bgNodeAnimDefine.IDLE or bgNodeAnimDefine.SHOW
            CfUtils.PlayAnimation(newBackgroundNode.transform:Find('Root'), animName)
            self.isFromDrawEquip_ = false
        end
    end
end


function GroceryEquipmentPanel:UpdateFreeCallState_()
    local isCanFreeCall = self:IsCanFreeOneCall()
    CfUtils.SetActive(self.BtnOneNodeFreeNode, isCanFreeCall)
    CfUtils.SetActive(self.BtnOneNodeChargeNode, not isCanFreeCall)
    CfUtils.SetActive(self.BtnOneNode, self:IsCanFreeOneCall() or self:IsOpenAutoCall() == false)
end


function GroceryEquipmentPanel:UpdateAutoCallState_()
    local isOpenAutoCall = self:IsOpenAutoCall()
    local autoDrawAnim   = isOpenAutoCall and AUTO_DRAW_ANIM.ON or AUTO_DRAW_ANIM.OFF
    CfUtils.PlayAnimator(self.BtnAutoDrawAnimRoot, autoDrawAnim)
    CfUtils.SetActive(self.BtnContinuousNode, isOpenAutoCall)
    CfUtils.SetActive(self.BtnTenNode, not isOpenAutoCall)
    self:UpdateFreeCallState_()
end


function GroceryEquipmentPanel:UpdateAutoCallTimes_()
    local autoCallTimes = self:GetAutoCallTimes()
    local autoCallText  = autoCallTimes == -1 and localize('无限制') or localize('_num_次', {_num_ = autoCallTimes})
    CfUtils.FillText(self.BtnContinuousNodeSourceText, autoCallText)
end


---@param isOneConsume boolean
---@param consumeDatas table[] @ { { goodsId : integer, num : integer }, ... }
function GroceryEquipmentPanel:UpdateConsumeInfo_(isOneConsume, consumeDatas)
    local isMultiple = #checkTable(consumeDatas) > 1
    local sourceImgs = {isOneConsume and self.BtnOneNodeSourceImage or self.BtnTenNodeSourceImage}
    local sourceTxts = {isOneConsume and self.BtnOneNodeSourceText or self.BtnTenNodeSourceText}
    if not isOneConsume then
        CfUtils.SetActive(self.BtnTenNodeSourceImage2, isMultiple)
        CfUtils.SetActive(self.BtnTenNodeSourceText2, isMultiple)
        if isMultiple then
            table.insert(sourceImgs, self.BtnTenNodeSourceImage2)
            table.insert(sourceTxts, self.BtnTenNodeSourceText2)
        end
    end
    for consumeIndex, consumeData in ipairs(consumeDatas or {}) do
        local consumeId   = checkInt(consumeData.goodsId)
        local consumeNum  = checkInt(consumeData.num)
        local goodsVo     = goodsConfMgr:GetGoodsVoById(consumeId)
        CfUtils.FillImage(sourceImgs[consumeIndex], goodsVo.photoPath)
        CfUtils.FillText(sourceTxts[consumeIndex], consumeNum)
    end
end


function GroceryEquipmentPanel:UpdateEquipmentPanel_()
    local equipGroceryData = self:GetSubGroceryData()
    local oneConsumeDatas  = GroceryUtils.GetCallEquipConsumeDatas(1, equipGroceryData)
    local tenConsumeDatas  = GroceryUtils.GetCallEquipConsumeDatas(2, equipGroceryData)
    if self:IsCanFreeOneCall() then
        oneConsumeDatas = {equipGroceryData.oneConsume}
    end
    self:UpdateConsumeInfo_(true, oneConsumeDatas)
    self:UpdateConsumeInfo_(false, tenConsumeDatas)
    
    local previewList = checkTable(equipGroceryData.preview)
    CfUtils.SetActive(self.BtnDetails, #previewList > 0)
end


---@param callType integer @ 1：单抽、2：十连
---@param callTimes integer @ 抽卡次数（-1无尽模式）
---@param isDecomposeMode boolean @ 是否分解模式
function GroceryEquipmentPanel:OpenDrawEquipDialog_(callType, callTimes, isDecomposeMode)
    if callTimes == 0 then
        GameUtils.Toast(localize("正经人谁抽0次啊"))
        return
    end

    local isEnoughConsumes = true
    local equipGroceryData = self:GetSubGroceryData()
    local callConsumeDatas = GroceryUtils.GetCallEquipConsumeDatas(callType, equipGroceryData)
    for _, callConsumeData in ipairs(callConsumeDatas) do
        local haveConsumeNum = GoodsUtils.GetThingNo(callConsumeData.goodsId)
        if haveConsumeNum < checkInt(callConsumeData.num) then
            local goodsVo = goodsConfMgr:GetGoodsVoById(callConsumeData.goodsId)
            GameUtils.Toast(localize("_name_不足", {_name_ = goodsVo.name}))
            isEnoughConsumes = false
            break
        end
    end
    if not isEnoughConsumes then
        return
    end

    CfUtils.CookieSave(DRAW_EQUIP_COOKIE_KEY, 1)

    ---@param assetsLoaderMap table<string, Engine.Modules.AbstractResourceLoader> @ 资源加载器的map（key：资源路径，value：加载器）
    self:PreloadAnimAssets_(function(assetsLoaderMap)
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaStoreEquipDrawOpenDialog, {
            groceryData     = self:GetSubGroceryData(),
            equipCallType   = callType,
            equipCallTimes  = callTimes,
            isDecomposeMode = isDecomposeMode == true,
            currencyIdList  = self:GetCurrencyIdList(),
            openGroceryType = self:GetSubGroceryType(),
            assetsLoaderMap = assetsLoaderMap,
        }, { {id = Constants.UITypeIds.GroceryDialog} }, true)
    end)
end


function GroceryEquipmentPanel:PreloadAnimAssets_(finishCb)
    ---@type table<string, Engine.Modules.AbstractResourceLoader> @ 资源加载器的map（key：资源路径，value：加载器）
    local assetsLoaderMap = {}

    local preloadDict = {
        [GroceryConstants.CallEquipAnimTimelineDefine.TIMELINE_1.PREFAB] = true
    }

    local loadedAssetsNum  = 0
    local preloadAssetsNum = table.count(preloadDict)

    -- append scene blocker
    CfUtils.ConditionAppend(PRELOAD_ASSETS_BLOCKER)

    self.preloadAssetsCo_ = CoStart(function()

        -- to preload assets
        for prefabPath, _ in pairs(preloadDict) do
            printInfo("<EquipmentCall> pre-loader toLoad : " .. prefabPath)
            ResourceModule.LoadBundleAsync(prefabPath, function(loader, isOk, resultObject)
                if isOk then
                    printInfo("<EquipmentCall> pre-loader finish : " .. prefabPath)
                    assetsLoaderMap[prefabPath] = loader
                    loadedAssetsNum = loadedAssetsNum + 1
                end
            end)
        end

        -- wait preload all
        while loadedAssetsNum < preloadAssetsNum do
            CoYield()
        end
        
        -- remove scene blocker
        CfUtils.ConditionRemove(PRELOAD_ASSETS_BLOCKER)

        self.preloadAssetsCo_ = nil

        if finishCb then finishCb(assetsLoaderMap) end
    end)
end


-------------------------------------------------
-- handler

function GroceryEquipmentPanel:OnClickDetailsButtonHandler_()
    local equipGroceryData = self:GetSubGroceryData()
    CfUtils.DialogOpen(Constants.UITypeIds.GroceryEquipmentPreviewDialog, {equipGroceryData = equipGroceryData})
end


function GroceryEquipmentPanel:OnClickOneDrawButtonHandler_()
    if GoodsUtils.IsPacketFilledById(Constants.BackpackTypeId.EQUIP) then
        GameUtils.Toast(localize('装备仓库已满'))
        return
    end
    self:OpenDrawEquipDialog_(1, 1)
end


function GroceryEquipmentPanel:OnClickTenDrawButtonHandler_()
    if GoodsUtils.IsPacketFilledById(Constants.BackpackTypeId.EQUIP) then
        GameUtils.Toast(localize('装备仓库已满'))
        return
    end
    self:OpenDrawEquipDialog_(2, 10)
end


function GroceryEquipmentPanel:OnClickAutoDrawButtonHandler_()
    local localAutoKey = string.fmt(Constants.PlayerPrefsType.GroceryEquipAutoCall, {_type_ = self:GetSubGroceryType()})
    if self:IsOpenAutoCall() then
        -- close autoCall
        CfUtils.WaitPlayAnimatorTo(self.BtnAutoDrawAnimRoot, AUTO_DRAW_ANIM.OFF_ON, function()
            CfUtils.WriteLocalData(localAutoKey, 0)
            self:SetOpenAutoCall(false)
        end)
    else
        local equipGroceryData = self:GetSubGroceryData()
        CfUtils.DialogOpen(Constants.UITypeIds.GroceryEquipmentCallSettingDialog, {equipGroceryData = equipGroceryData, savedCB = function()
            CfUtils.WaitPlayAnimatorTo(self.BtnAutoDrawAnimRoot, AUTO_DRAW_ANIM.ON_OFF, function()
                -- update autoCallTimes
                local equipGroceryData = self:GetSubGroceryData()
                local decomposeSetting = checkTable(equipGroceryData.decompose)
                self:SetAutoCallTimes(decomposeSetting.callTimes)

                -- open autoCall
                CfUtils.WriteLocalData(localAutoKey, 1)
                self:SetOpenAutoCall(true)
            end)
        end})
    end
end


function GroceryEquipmentPanel:OnClickBatchButtonHandler_()
    if GoodsUtils.IsPacketFilledById(Constants.BackpackTypeId.EQUIP) then
        GameUtils.Toast(localize('装备仓库已满'))
        return
    end
    if GoodsUtils.IsPacketFilledById(Constants.BackpackTypeId.MATERIAL) then
        GameUtils.Toast(localize('材料仓库已满'))
        return
    end
    self:OpenDrawEquipDialog_(2, self:GetAutoCallTimes(), true)
end


return GroceryEquipmentPanel

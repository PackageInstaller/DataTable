
------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type GoodsConfMgr
local goodsConfMgr     = GoodsConfMgr:GetInstance()
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.Modules.ResourceModule
local ResourceModule   = CS.Engine.Modules.ResourceModule
---@type Engine.Lib.Yielders
local Yielders         = CS.Engine.Lib.Yielders
---@type EquipmentComponent
local equipComp        = GameUtils.GetEntityCompByType(ECSComponentType.Constants.EquipmentComponent)
---@type Engine.UI.UIRaycastBlocker
local Blocker          = CS.Engine.UI.UIRaycastBlocker.Instance
------------ import ------------


------------ define ------------
local checkNumber         = checkNumber
local CellEnvPath         = "Game.UI.Cultivate.Equip.UICultivateEquipBackpackCellNode"
local QualityNodeEnvPath  = "Game.UI.Cultivate.Equip.UICultivateEquipReclaimQualityNode"
local SetPanelEnvPath     = "Game.UI.Cultivate.Equip.UICultivateEquipSettingPanel"
local EquipComparedViewEnvPath     = "Game.UI.Cultivate.Equip.UICultivateEquipComparedView"
local FilterNodePath = "Game.Behaviours.UICommonFilterMB"

local RestoreKey = "UICultivateEquipReclaimDialog"

local FilTerType = {
    NORMAL = 0, NORMAL_SELECT_SUIT = 1, SUIT = 2,
}

local GoodsId = Constants.Currency.GoldId
    
local EquipmentType     = Constants.IDType.Equipment
local EquipmentCoreType = Constants.IDType.EquipmentCore

local DynamicLoadEffectPath = {
    Boom      = "Effect/prefab/ui_prefab/UIFX_UICultivateEquipReclaimDialogBoom.prefab",
    BoomBoom2 = "Effect/prefab/ui_prefab/UIFX_UICultivateEquipReclaimDialogBoomBoom2.prefab",
    BoomMove  = "Effect/prefab/ui_prefab/UIFX_UICultivateEquipReclaimDialogBoomMove.prefab",
}

local RightAnimName = {
    Idle = "UICultivateEquipReclaimDialogRightPanelIdle",
    Loop = "UICultivateEquipReclaimDialogRightPanelLoop",
    Go   = "UICultivateEquipReclaimDialogRightPanelGo",
}

local ConditionName = "UICultivateEquipReclaimDialog.PlayReclaimAni"
local EquipReclaimMaxLimit = 200
------------ define ------------

--- from: Assets/BundleResources/Prefabs/Cultivate/UICultivateEquipReclaimDialog.prefab
---@class UICultivateEquipReclaimDialog
---@field Env                           	UICultivateEquipReclaimDialog                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ImgHook                       	UnityEngine.RectTransform               
---@field BtnSelect                     	UnityEngine.RectTransform               
---@field FontStyleButton               	Game.Native.Common.FontStyleButton      
---@field FXPoint                       	UnityEngine.RectTransform               
---@field IconEffect                    	UnityEngine.RectTransform               
---@field GoodsTextNumber               	TMPro.TextMeshProUGUI                   
---@field ImgIcon                       	Engine.UI.RawImageAlterable             
---@field ImgQuality                    	Engine.UI.ImageAlterable                
---@field BtnGoods                      	UnityEngine.RectTransform               
---@field Node                          	UnityEngine.RectTransform               
---@field Quantity                      	UnityEngine.RectTransform               
---@field Content                       	UnityEngine.RectTransform               
---@field Empty                         	UnityEngine.RectTransform               
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
---@field RightPanel                    	UnityEngine.Animation                   
---@field EmptyNode                     	UnityEngine.RectTransform               
---@field ScrollView                    	Engine.UI.AutoFixSizeListView           
---@field CloseButton                   	UnityEngine.RectTransform               
---@field SuitText                      	UnityEngine.UI.Text                     
---@field Button                        	UnityEngine.RectTransform               
---@field Container                     	UnityEngine.RectTransform               
---@field Root                          	UnityEngine.Animation                   
local UICultivateEquipReclaimDialog = Class('UICultivateEquipReclaimDialog')


function UICultivateEquipReclaimDialog:__init()
    ---------------------------------
    --- UI 节点
    ---装备品质数量节点
    self.qualityNodes     = {}

    ---------------------------------
    --- 筛选相关数据
    ---参与筛选的品质 -> 结果
    -- self.filterQuality2Res = {}

    ---------------------------------
    --- 装备选择相关数据
    ---选择过的装备Id -> 结果
    self.selectId2Res     = {}
    ---选择过的核心Id -> 结果
    self.selectCoreId2Res = {}
    ---各个装备品质个数
    self.qualityCounts    = {}
    ---选择的装备数量
    self.selectCount      = 0
    ---总售卖货币
    self.totalSellMoney   = 0

    self.playedCanReclaimAni = false
    
    ---是否全选
    self.isSelectAll      = false

    --- 套装数据列表
    self.suitDataList = nil

    self.equipConfFieldCache = {}
    self.coreConfFieldCache = {}

    self.effectNodes = {}

    -- self.isShowSetting = false
end


function UICultivateEquipReclaimDialog:__delete()
    for i, v in pairs(self.effectNodes) do
        if not isNull(v) then
            KTool.SafeDelete(v)
        end
    end
end


function UICultivateEquipReclaimDialog:Awake()
end


-- function UICultivateEquipReclaimDialog:OnFocus(focus)

-- end


function UICultivateEquipReclaimDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        GameUtils.UpdateNavBarShowGoods({Constants.Currency.GoldId}, true)

        self:InitData()
        self:InitAction()
        self:InitFilerNodeData()
    end))
    return coWait
end

function UICultivateEquipReclaimDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        xTry(function ()
            self:FreshUI()
            self:FreshImgIcon()
            
        end)
    end))
    return coWait
end


function UICultivateEquipReclaimDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        for key, func in pairs(self.eventConf) do
            Events.RemoveListener(key, func)
        end
        self.eventConf = nil
        GameUtils.RestoreHealthNodes()

        if self.loadPanelCo then
            cs_coroutine.stop(self.loadPanelCo)
            self.loadPanelCo = nil
        end

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function UICultivateEquipReclaimDialog:InitData()
    local param    = self.controller.Argument.parameters
    ---{{id, goodsId, goodsType}}
    local dataList = param.dataList
    -- EquipUtils.SortEquipReclaimBackpackData(dataList, Constants.SortType.Quality, false)
    self.dataList  = dataList
    self.showDataList = clone(dataList)
end


function UICultivateEquipReclaimDialog:InitAction()
    SetButtonAction(self.BtnSelect,       Bind(self, self.OnClickBtnSelectAction))
    SetButtonAction(self.Button,          Bind(self, self.OnClickButtonAction))
    SetButtonAction(self.BtnGoods,        Bind(self, self.OnClickBtnGoodsAction))
    SetButtonAction(self.CloseButton,     Bind(self, self.OnClickCloseButtonAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickFontStyleButtonAction))

    local ImgBg = self.Container.transform:Find("BgGroup/ImgBg")
    if not isNull(ImgBg) then
        SetButtonAction(ImgBg, function ()
            self:FreshComparedViewShowState(false)
        end)
    end

    -- local FilterNode = self.FilterNode
    for i = Constants.QualityType.Whit, Constants.QualityType.Orange, 1 do
    --     local BtnNode = FilterNode:Find(string.format("BtnNode%s", i))
    --     local ImgHook = BtnNode:Find("ImgHook")
    --     SetButtonAction(BtnNode, function ()
    --         local isSelect = not self.filterQuality2Res[i]
    --         if not isSelect then
    --             self.filterQuality2Res[i] = nil
    --         else
    --             self.filterQuality2Res[i] = true
    --         end
    --         KTool.SetActive(ImgHook.gameObject, isSelect)

    --         self:FreshEquipFilterState()
    --     end)

        table.insert(self.qualityCounts, 0)
    end

    self.eventConf = {
        [Constants.EventNames.UICultivateEquipSuitFilterEntry]    = Bind(self, self.OnEntryEquipSuitFilterListener),
        [Constants.EventNames.UICultivateEquipSuitFilterComplete] = Bind(self, self.OnSuitFilterSelectCompleteListener),
        [Constants.EventNames.UICommonPopupWindowClose] = Bind(self, self.OnEventCloseRewardDialogListener),
    }
    for key, func in pairs(self.eventConf) do
        Events.AddListener(key, func)
    end

end

---InitSuitDataList
---初始化套装位置数据列表
---@param ownEquipPartMap table<number, table> table<装备的位置, 在该位置上拥有的装备列表>
function UICultivateEquipReclaimDialog:InitSuitDataList(ownEquipPartMap)
    --- 过滤方法
    local function filter(dojo)
        return checkNumber(dojo.playerCardId) == 0 and checkNumber(dojo.locked) == 0
    end

    local t = {}
    for part = 1, Constants.CardEquipmentNo do
        local playerEquipIds = ownEquipPartMap[part] or {}
        for i, playerEquipId in ipairs(playerEquipIds) do
            ---@type EquipDojo
            local equipDojo = equipComp:GetEquipById(playerEquipId)
            if filter(equipDojo) then
                table.insert(t, EquipUtils.GenerateEquipDataByDojo(equipDojo, self.equipConfFieldCache))
                
            end
        end
    end
    
    local part = -1
    local playerEquipCoreIds = ownEquipPartMap[part] or {}
    for i, coreId in ipairs(playerEquipCoreIds) do
        ---@type EquipmentCoreDojo
        local equipmentCoreDojo = equipComp:GetEquipCoreById(coreId)
        if filter(equipmentCoreDojo) then
            table.insert(t, EquipUtils.GenerateCoreDataByDojo(equipmentCoreDojo, self.coreConfFieldCache))
        end
        
    end
    
    EquipUtils.SortEquipReclaimBackpackData(t, Constants.SortType.Quality, false)

    return t
end

function UICultivateEquipReclaimDialog:InitShowDataList()
    -- local filterQuality2Res = self.filterQuality2Res
    -- local isAll             = next(filterQuality2Res) == nil
    local dataList          = self.filterType == FilTerType.SUIT and self.suitDataList or self.dataList

    -- ---检查是否选择指定品质
    -- ---@param v any
    -- local function checkIsSelectQuality(v)
    --     return filterQuality2Res[v.quality] ~= nil
    -- end 

    local t = {}
    for i, v in ipairs(dataList) do
        table.insert(t, v)
        -- if isAll or checkIsSelectQuality(v) then
        -- end
    end

    return t
end


function UICultivateEquipReclaimDialog:InitFilerNodeData()
    ---@type UICommonFilterMB
    local nodeEnv = CfUtils.GetLuaScr(self.FilterNode.gameObject, FilterNodePath)
    if nodeEnv == nil then return end
    -- nodeEnv:SetDefGroups(self:InitDefGroups())
    nodeEnv:SetFilterClass(Constants.UIFilterType.EquipReclaimFastSelect)
end


function UICultivateEquipReclaimDialog:InitSettingPanel()
    ---@type UICultivateEquipSettingPanel
    local env = CfUtils.GetLuaScr(self.SettingPanel, SetPanelEnvPath)
    if isNull(env) then return end
    self.fastSelectRule = {}
    env:FreshUI(Constants.UIFilterType.EquipReclaimFastSelect, self.fastSelectRule)
    env:SetLeftBtnClickCallback(function(luaEnv)
        -- self.isShowSetting = false
        -- KTool.SetActive(self.SettingPanel.gameObject, false)
        -- luaEnv:CloseView()
        luaEnv:ResetUI()
        self:ResetSelectState()
        self:FreshUI()

    end)
    env:SetRightBtnClickCallback(Bind(self, self.OnFastSelectAction))
end

---------------------------------------------------
--- init end --
---------------------------------------------------

---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function UICultivateEquipReclaimDialog:FreshUI()
    self.showDataList = self:InitShowDataList()
    self:FreshFilterNode(self:GetDataList())
    self:FreshChooseEquip()
end

function UICultivateEquipReclaimDialog:FreshFilterNode(dataList)
    ---@type UICommonFilterMB
    local nodeEnv = CfUtils.GetLuaScr(self.FilterNode.gameObject, FilterNodePath)
    if nodeEnv == nil then return end
    -- self.showDataList = self:InitShowDataList()
    -- self:FreshListUI()
    nodeEnv:SetCallback(dataList , Bind(self, self.OnClickFilterCellAction), Constants.UISortType.EquipCultivate)
    nodeEnv:RestoreState(RestoreKey, Bind(self, self.OnClickFilterCellAction))
end


function UICultivateEquipReclaimDialog:FreshListUI()
    local len  = #self:GetDataList()
    KTool.SetActive(self.EmptyNode.gameObject, len <= 0)
    KTool.SetActive(self.ScrollView.gameObject, len > 0)
    if len > 0 then
        local List = self.ScrollView
        if not List.mLoopListView.IsListViewInit then
            List:InitListView(len, Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(List, len)
        end
    end

end

function UICultivateEquipReclaimDialog:OnGetItemByIndex(cell, idx)
    if idx < 0 then
        return nil
    end

    ---@type UICultivateEquipBackpackCellNode
    local nodeEnv = CfUtils.GetLuaScr(cell, CellEnvPath)
    if isNull(nodeEnv) then
        return nil
    end
    
    if nodeEnv.clickAction == nil then
        nodeEnv:SetClickCallback(Bind(self, self.OnClickCellAction))
        nodeEnv:SetLongTapCallback(Bind(self, self.OnLongTapCellAction))
    end
    local index = idx + 1
    local dataList = self:GetDataList()
    local data = dataList[index]
    nodeEnv:RefreshUI(data, false, false, index)

    local id2Res   = data.goodsType == EquipmentCoreType and self.selectCoreId2Res or self.selectId2Res
    local isSelect = id2Res[data.id] == true
    nodeEnv:SetCheckState(isSelect)

    return cell

end

---RefreshCellShowStateByIndex
---刷新cell选中状态
---@param cellIndex number
---@param isShow boolean
function UICultivateEquipReclaimDialog:FreshCellShowStateByIndex(cellIndex, isShow)
    local item = self.ScrollView:GetShownItemByItemIndex(cellIndex - 1)
    if item == nil then return end
    item.Env:SetCheckState(isShow)
end

function UICultivateEquipReclaimDialog:FreshSuitFilterBtnShowState(isActive)
    KTool.SetActive(self.CloseButton.gameObject, isActive)

end

function UICultivateEquipReclaimDialog:FreshChooseEquip()
    self.TextNumber.text = string.format("<color=#3c3c3c>%s</color>/%s", self.selectCount, EquipReclaimMaxLimit)
    local isSelect       = self.selectCount > 0
    KTool.SetActive(self.Empty.gameObject, not isSelect)
    KTool.SetActive(self.Content.gameObject, isSelect)
    
    self:FreshChooseEquipContent()
    self:FreshGoodsTextNumber()

    if self.playedCanReclaimAni ~= isSelect then
        self.playedCanReclaimAni = isSelect
        self:PlayCanReclaimAni(isSelect)
    end
    
end

function UICultivateEquipReclaimDialog:FreshChooseEquipContent()
    ---@type UnityEngine.GameObject
    local parent = self.Quantity.gameObject
    for i, v in ipairs(self.qualityCounts) do
        local node = self.qualityNodes[i]
        if isNull(node) then
            node = parent:AddChild(self.Node.gameObject)
            self.qualityNodes[i] = node
        end
        KTool.SetActive(node, v > 0)
        if v > 0 then
            self:FreshChooseEquipQualityNode(node, i, v)
        end
    end
end

--- FreshChooseEquipQualityNode
---@param node UnityEngine.GameObject
---@param count number
function UICultivateEquipReclaimDialog:FreshChooseEquipQualityNode(node, quality, count)
    ---@type UICultivateEquipReclaimQualityNode
    local env = CfUtils.GetLuaScr(node, QualityNodeEnvPath)
    if isNull(env) then
        return
    end
    env:FreshUI(quality, count)

end

function UICultivateEquipReclaimDialog:FreshGoodsTextNumber()
    self.GoodsTextNumber.text = self.totalSellMoney
end

function UICultivateEquipReclaimDialog:PlayCanReclaimAni(isPlay)
    KTool.SetActive(self.IconEffect.gameObject, isPlay)
    local aniName = isPlay and RightAnimName.Loop or RightAnimName.Idle
    self.RightPanel:Play(aniName)
end

function UICultivateEquipReclaimDialog:FreshImgIcon()
    ---@type GoodsVo
    local goodsVo = goodsConfMgr:GetGoodsVoById(GoodsId)
    self.ImgIcon:LoadSprite(goodsVo.photoPath)
end

function UICultivateEquipReclaimDialog:FreshSelectAllState()
    KTool.SetActive(self.ImgHook.gameObject, self.isSelectAll)
end

--- FreshEquipFilterState
--- 刷新装备筛选状态
function UICultivateEquipReclaimDialog:FreshEquipFilterState()
    -- self.showDataList = self:InitShowDataList()

    -- self:FreshListUI()
end

---------------------------------------------------
--- ui logic end --
---------------------------------------------------

---------------------------------------------------
--- handle data begin --
---------------------------------------------------

--- HandleSelectData
--- 处理选择数据
---@param goodsNodeData table {id: number, goodsId: number, goodsType: Constants.IDType, level: number}
---@param id number
---@param isSelect boolean 
function UICultivateEquipReclaimDialog:HandleSelectData(goodsNodeData, id, isSelect, isFastSelect)
    local goodsType       = goodsNodeData.goodsType
    local isCore          = goodsType == EquipmentCoreType
    local id2Res          = isCore and self.selectCoreId2Res or self.selectId2Res
    if isFastSelect then
        if id2Res[id] then
            return true
        end
    end
    id2Res[id] = isSelect
    local delta           = isSelect and 1 or -1
    local selectCount     = self.selectCount + delta
    if selectCount > EquipReclaimMaxLimit then
        return false
    end
    self.selectCount      = selectCount
    
    
    ----------------------------------------
    --- 处理各个品质对应数量
    local quality         = goodsNodeData.quality
    self.qualityCounts[quality] = self.qualityCounts[quality] + delta
    
    ----------------------------------------
    --- 处理选择的售卖价格
    local sellMoney = 0
    local goodsId         = goodsNodeData.refId
    if isCore then
        ---@type EquipCoreVo
        local vo = cardConfMgr:GetEquipCoreVoById(goodsId)
        sellMoney = vo.sellMoney
    else
        ---@type EquipVo
        local vo = cardConfMgr:GetEquipVoById(goodsId)
        ---@type EquipLevelConsumeVo
        local equipLevelConsumeVo = cardConfMgr:GetEquipLevelConsumeVo(vo.levelUpType, quality, goodsNodeData.level)
        sellMoney = equipLevelConsumeVo.sellMoney
    end
    self.totalSellMoney = self.totalSellMoney + (isSelect and sellMoney or -sellMoney)
    return true
end

--- ResetSelectState
--- 重置选择状态
function UICultivateEquipReclaimDialog:ResetSelectState()
    self.selectId2Res     = {}
    self.selectCoreId2Res = {}
    self.selectCount      = 0
    self.totalSellMoney   = 0
    for i, v in ipairs(self.qualityCounts) do
        self.qualityCounts[i] = 0
    end
end

---------------------------------------------------
--- handle data end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------
function UICultivateEquipReclaimDialog:GetFilterType()
    return self.filterType

end
function UICultivateEquipReclaimDialog:SetFilterType(filterType)
    self.filterType = filterType

end

function UICultivateEquipReclaimDialog:GetDataList()
    -- return self.filterType == FilTerType.SUIT and self.suitDataList or self.dataList
    return self.showDataList
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function UICultivateEquipReclaimDialog:OnClickFilterCellAction(data)
    -- if self.filterType == FilTerType.SUIT then
    --     self.suitDataList = data
    -- else
    --     self.dataList = data
    -- end
    self.showDataList = data
    -- self.showDataList = self:InitShowDataList()
    self:FreshListUI()
    -- local dataList          = self.filterType == FilTerType.SUIT and self.suitDataList or self.dataList
end

function UICultivateEquipReclaimDialog:OnClickButtonAction()
    local parameters = {
        part = 0,
    }
    UIModule.OpenDialog({ id = Constants.UITypeIds.UICultivateEquipSuitFilterDialog, parameters = parameters })
end

function UICultivateEquipReclaimDialog:OnClickCloseButtonAction()
    ---------------------------
    --- update cache data
    self:SetFilterType(FilTerType.NORMAL)
    self.curSelectSuitId = nil
    self.showDataList = self:InitShowDataList()
    ---------------------------

    ---------------------------
    --- update ui
    
    self.SuitText.text = localize("套装")

    self:FreshSuitFilterBtnShowState(false)

    self:FreshListUI()
    ---------------------------
end

function UICultivateEquipReclaimDialog:OnClickBtnGoodsAction()
    local vo = goodsConfMgr:GetGoodsVoById(GoodsId)
    if isTable(vo) then
        GameUtils.ShowCommonTipsBoard(self.BtnGoods.gameObject, vo.name, vo.desc, vo.quality, vo.id)
    end

end

function UICultivateEquipReclaimDialog:OnClickFontStyleButtonAction()
    if self.selectCount <= 0 then
        GameUtils.Toast(localize("无可回收的情绪涂鸦"))
        return
    end

    ---
    local id2SuitIdMap, coreId2SuitIdMap = equipComp:GetId2SuitIdMap()
    local suitId2WaitRemoveEquip, suitId2WaitRemoveCore = {}, {}
    local foodEquipmentList     = {}
    local foodEquipmentCoreList = {}
    for id, res in pairs(self.selectId2Res) do
        if res then
            table.insert(foodEquipmentList, id)
            local diySuitIdMap = id2SuitIdMap[tostring(id)]
            if diySuitIdMap then
                for i, diySuitId in pairs(diySuitIdMap) do
                    diySuitId = checkNumber(diySuitId)
                    suitId2WaitRemoveEquip[diySuitId] = suitId2WaitRemoveEquip[diySuitId] or {}
                    id = checkInt(id)
                    suitId2WaitRemoveEquip[diySuitId][id] = id
                end
            end
        end
    end

    for id, res in pairs(self.selectCoreId2Res) do
        if res then
            table.insert(foodEquipmentCoreList, id)
            local diySuitIdMap = coreId2SuitIdMap[tostring(id)]
            if diySuitIdMap then
                for i, diySuitId in pairs(diySuitIdMap) do
                    diySuitId = checkNumber(diySuitId)
                    suitId2WaitRemoveCore[diySuitId] = checkInt(id)
                end
            end
        end
    end

    local function RequestRecycle()
        local requestData = {
            playerEquipmentId     = next(foodEquipmentList) == nil     and "" or table.concat(foodEquipmentList, ','),
            playerEquipmentCoreId = next(foodEquipmentCoreList) == nil and "" or table.concat(foodEquipmentCoreList, ','),
        }
        GameUtils.Request(Interfaces.EquipmentRecycle, requestData, function(req, responseTable)
            local code = checkNumber(responseTable.errCode)
            if code ~= 0 then return end
            ------------------------
            --- 更新全局缓存
            equipComp:RemoveInlaidDiySuitEquip(suitId2WaitRemoveEquip, suitId2WaitRemoveCore)
            equipComp:RemoveEquipsByIdList(foodEquipmentList)
            equipComp:RemoveEquipCoresByIdList(foodEquipmentCoreList)
            
            local rewards = responseTable.data.rewards
            -- local rewards = {{goodsId = GoodsId, num = 10}}
            self.rewards  = rewards
            -- GoodsUtils.DrawRewards(responseTable.data.rewards)
        
            --------------------------
    
            --------------------------
            --- 清理本地缓存
            local clearDataByList = function(list)
                if list == nil then return end 
                local count = #list
                for i = count, 1, -1 do
                    local data = list[i]
                    local id2Res = data.goodsType == EquipmentCoreType and self.selectCoreId2Res or self.selectId2Res
                    if id2Res[data.id] then
                        table.remove(list, i)
                    end
                end
            end
            clearDataByList(self.dataList)
            clearDataByList(self.suitDataList)
            
            -- self.showDataList = self:InitShowDataList()
            self.isSelectAll = false
            self:ResetSelectState()
        
            --------------------------
            --- 更新UI
            -- self:FreshUI()
            UIModule.OpenDialog({id = Constants.UITypeIds.UICommonRewardPop, parameters = {rewards = rewards}})
     
        end)
    end

    local isNeedSecondPop = false
    for i, v in ipairs(self.qualityCounts) do
        if i >= Constants.QualityType.Purple and v > 0 then
            isNeedSecondPop = true
            break
        end
    end
    if isNeedSecondPop then
        GameUtils.SecondConfirm(localize("已选择的涂鸦中包含紫色及以上品质，是否进行回收？"), function()
            RequestRecycle()
        end)
        return
    end
    RequestRecycle()
end

function UICultivateEquipReclaimDialog:OnClickBtnSelectAction(selectRule)
    if self.isLoadPanel then
        return
    end
    -- if self.isShowSetting == true then return end
    -- self.isShowSetting = true
    if isNull(self.SettingPanel) then
        self.isLoadPanel = true
        self.loadPanelCo = cs_coroutine.start(function ()
            self.SettingPanel = GameUtils.LoadBundleAsyncById(Constants.UIModulePrefabsIds.UICultivateEquipSettingPanel, self.Container.gameObject)
            self:InitSettingPanel()
            self.isLoadPanel = false
            self.loadPanelCo = nil
        end)
    else
        KTool.SetActive(self.SettingPanel.gameObject, true)
    end

end

function UICultivateEquipReclaimDialog:OnClickCellAction(data)
    local index           = data.index
    local goodsNodeData   = data.goodsNodeData
    local id              = goodsNodeData.id
    local id2Res          = goodsNodeData.goodsType == EquipmentCoreType and self.selectCoreId2Res or self.selectId2Res
    local isSelect        = not id2Res[id]

    ----------------------------------------
    --- 处理选择后的数据
    local res = self:HandleSelectData(goodsNodeData, id, isSelect)

    ----------------------------------------
    --- 处理选择后的UI
    if res then
        self:FreshCellShowStateByIndex(index, isSelect)
        self:FreshChooseEquip()
    else
        GameUtils.Toast(localize("已达到单次回收数量上限"))
    end

end

function UICultivateEquipReclaimDialog:OnLongTapCellAction(data)
    local goodsNodeData   = data.goodsNodeData
    local id              = goodsNodeData.id
    local goodsType       = goodsNodeData.goodsType
    local part            = goodsNodeData.part
    local equipType, curDojo       
    -- print(table.toString(goodsNodeData))
    if goodsType == Constants.IDType.Equipment then
        curDojo = equipComp:GetEquipById(id)
        equipType = Constants.UICultivateEquipType.Equip
    elseif goodsType  == Constants.IDType.EquipmentCore then
        equipType = Constants.UICultivateEquipType.Core
        curDojo = equipComp:GetEquipCoreById(id)
    end
    
    self:LoadComparedView(curDojo, nil, equipType, part)
end

function UICultivateEquipReclaimDialog:LoadComparedView(curDojo, compareDojo, equipType, part)
    if self.ComparedView then
        self:FreshComparedView(curDojo, compareDojo, equipType, part)
        return
    end
    if self.ComparedViewCo then
        return
    end
    self.ComparedViewCo = cs_coroutine.start(function()
        self.ComparedView = GameUtils.LoadBundleAsyncById(Constants.UIModulePrefabsIds.UICultivateEquipComparedView, self.Container.gameObject, false, true)
        self:FreshComparedView(curDojo, compareDojo, equipType, part)
        self.ComparedViewCo = nil
    end)
end

function UICultivateEquipReclaimDialog:StopComparedViewCo()
    if not isNull(self.ComparedViewCo) then
        cs_coroutine.stop(self.ComparedViewCo)
        self.ComparedViewCo = nil
    end
end

function UICultivateEquipReclaimDialog:FreshComparedView(curDojo, compareDojo, equipType, part)
    ---@type UICultivateEquipComparedView
    local mbEnv = CfUtils.GetLuaScr(self.ComparedView, EquipComparedViewEnvPath)
    if not isNull(mbEnv) then
        mbEnv:RefreshEquipCultivateUI(curDojo, compareDojo, equipType, part)

        GameUtils.UpdateUIShowState(self.ComparedView.gameObject, true)
    end
end

---FreshComparedViewShowState
---刷新比较界面显示状态
---@param isShow boolean
function UICultivateEquipReclaimDialog:FreshComparedViewShowState(isShow)
    if self.ComparedView == nil then return end
    GameUtils.UpdateUIShowState(self.ComparedView.gameObject, isShow)
end


function UICultivateEquipReclaimDialog:OnEntryEquipSuitFilterListener()
    self:SetFilterType(FilTerType.NORMAL_SELECT_SUIT)
end

function UICultivateEquipReclaimDialog:OnSuitFilterSelectCompleteListener(suitId, ownEquipPartMap)
    ---------------------------
    --- update cache data
    self:SetFilterType(FilTerType.SUIT)
    self.curSelectSuitId = checkInt(suitId)
    
    self.suitDataList = self:InitSuitDataList(ownEquipPartMap)
    self.showDataList = self:InitShowDataList()

    ---------------------------
    --- update ui
    local name = CfUtils.GetCfVo(AutoIds.IdSetting102, "EquipFilterVo", suitId).name
    self.SuitText.text = name

    self:FreshSuitFilterBtnShowState(true)

    self:FreshListUI()
    ---------------------------
end

function UICultivateEquipReclaimDialog:OnEventCloseRewardDialogListener()
    if self.rewards == nil then
        return
    end
--     *点击回收（播放完“恭喜获得“后）
--      UICultivateEquipReclaimDialog==》Root==》Container=》RightPanel=》animation：播放UICultivateEquipReclaimDialogRightPanelGo
--      UICultivateEquipReclaimDialog==》Root==》Container=》RightPanel=》CanGett=》FXPoint：加载UIFX_UICultivateEquipReclaimDialogBoom（播放后销毁）
--      同时加载飞行粒子（无论距离，飞行时长0.5s）
--      UICultivateEquipReclaimDialog==》Root==》Container=》RightPanel=》CanGett=》FXPoint：加载UIFX_UICultivateEquipReclaimDialogBoomMove，飞行到货币栏，金币图标的中间。
--      飞行粒子到达指定坐标后（销毁飞行粒子，刷新货币）
--      货币栏，金币图标的中间：加载UIFX_UICultivateEquipReclaimDialogBoomBoom2（播放后销毁）

    Blocker:AddCondition(ConditionName)
    cs_coroutine.start(function ()
        local icon            = self:GetIcon()
        local parent          = self.FXPoint.gameObject
        local boomLoader      = ResourceModule.LoadBundleAsync(DynamicLoadEffectPath.Boom, nil, true)
        local boomMoveLoader  = ResourceModule.LoadBundleAsync(DynamicLoadEffectPath.BoomMove, nil, true)
        local boomBoom2Loader = ResourceModule.LoadBundleAsync(DynamicLoadEffectPath.BoomBoom2, nil, true)
        while not boomLoader.IsCompleted or not boomMoveLoader.IsCompleted do
            cs_coroutine.yield_return(Yielders.EndOfFrame)
        end
        local boomGo = self:InstantiateGoByLoader(boomLoader, parent)
        self.RightPanel:Play(RightAnimName.Go)
        local boomMoveGo = self:InstantiateGoByLoader(boomMoveLoader, parent)

        local iconPosition = icon.transform.position
        boomMoveGo.transform:DOMove(iconPosition, 0.5)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))
        while not boomBoom2Loader.IsCompleted do
            cs_coroutine.yield_return(Yielders.EndOfFrame)
        end
        GoodsUtils.DrawRewards(self.rewards)
        KTool.SafeDelete(boomGo)
        KTool.SafeDelete(boomMoveGo)
        
        -- self.Root:Play("UICultivateEquipReclaimDialogRootOpen")
        self:FreshUI()
        -- self:FreshListUI()
        -- self:FreshChooseEquip()
        -- self:FreshSelectAllState()

        local boomBoom2Go = self:InstantiateGoByLoader(boomBoom2Loader, parent)
        boomBoom2Go.transform.position = iconPosition
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))
        
        KTool.SafeDelete(boomBoom2Go)
        Blocker:RemoveCondition(ConditionName)
        
    end)
end

function UICultivateEquipReclaimDialog:GetIcon()
    local UINavigationBarRoot = CS.UINavigationBarRoot
    local UINavigatorBarPath = "Game.Main.UINavigatorBar"
    ---@type UINavigatorBar
    local navigatorBar = CfUtils.GetLuaScr(UINavigationBarRoot.Instance.gameObject, UINavigatorBarPath)
    return navigatorBar:GetAssetNodeIconById(GoodsId)
end

function UICultivateEquipReclaimDialog:InstantiateGoByLoader(loader, parent)
    local go
    if loader.IsSuccess then
        ---如果加载时parent存在，但是加载完成之后，parent已经被销毁，则当前对象也要销毁
        go = loader:Instantiate()
        if not KTool.IsNull(go) then
            KTool.SetParent(go, parent, false)
        end
    end
    loader:Release()
    return go
end

--- OnFastSelectAction
---@param luaEnv UICultivateEquipSettingPanel
function UICultivateEquipReclaimDialog:OnFastSelectAction(luaEnv)
    local selectRule = luaEnv.selectRule
    if self.selectCount >= EquipReclaimMaxLimit then
        GameUtils.Toast(localize("已达到单次回收数量上限"))
        return
    end
    
    local dataList         = self:GetDataList()

    local list = EquipUtils.ScreenEquipReclaimFastSelect(dataList, selectRule)
    for i, v in ipairs(list) do
        if not self:HandleSelectData(v, v.id, true, true) then
            break
        end
    end

    -- self:FreshUI()
    self:FreshListUI()
    self:FreshChooseEquip()
    -- self:FreshSelectAllState()
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return UICultivateEquipReclaimDialog

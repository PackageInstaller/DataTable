------------ import ------------
local util = require "XLua.util"
local CoWait = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local UINavigationBarRoot = CS.UINavigationBarRoot
local RectTransform = CS.UnityEngine.RectTransform
local SortType = Constants.SortType
------------ import ------------

------------ define ------------
local GoodsNodePrefabName = "Cell" -- 物品 Node 节点名
local CellNodeMBPath = "Game.UI.Backpack.BackpackCellNode" -- 物品 Node 的 脚本路径
local BackpackItemInfoPanel = "Game.UI.Backpack.BackpackItemInfoPanel" -- 物品详情节点脚本路径
local BackpackBatchSellPanel = "Game.UI.Backpack.BackpackBatchSellPanel" -- 物品详情节点脚本路径
local CommonTabToggleLeft = "Game.Behaviours.CommonTabToggleLeft" -- 通用 toggle 脚本
local NavigationBarRootPath = 'Game.Main.UINavigatorBar'
--- 筛选类型
local FilTerType = {
    Normal = 0,
    Suit = 1
}
--- 排序点击类型
local SortTabType = {
    Quality = 1,
    Level = 2,
}
--- 数据类型
local DataType = {
    Item = 1, -- 道具
    Equip = 2, -- 装备
    LimitItem = 3, -- 可使用
    BattleFood = 4, --战斗料理
}

local EQUIP_TYPE     = 5 ---装备页签id
local CARD_CORE_TYPE = 6 ---卡牌核心页签id

--- 需要隐藏批量出售
local HideBulkSaleConf = {
    [EQUIP_TYPE]     = true,
    [CARD_CORE_TYPE] = true,
}
------------ define ------------

--- from: Assets/BundleResources/Prefabs/Backpack/Backpack.prefab
---@class Backpack
---@field Env                           	Backpack                                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BulkSalePanel                 	UnityEngine.RectTransform               
---@field BtnBulkSale                   	UnityEngine.RectTransform               
---@field Root_ClickBreak               	UnityEngine.RectTransform               
---@field ItemListContent               	UnityEngine.RectTransform               
---@field TxtTabName                    	UnityEngine.RectTransform               
---@field TxtNum                        	UnityEngine.RectTransform               
---@field PlusIcon                      	UnityEngine.RectTransform               
---@field Button                        	UnityEngine.RectTransform               
---@field CommonFilterNode              	UnityEngine.RectTransform               
---@field Group1                        	UnityEngine.RectTransform               
---@field SortBar                       	UnityEngine.RectTransform               
---@field TogglePanel                   	UnityEngine.RectTransform               
---@field ItemsPanel                    	UnityEngine.RectTransform               
---@field ItemEmptyPanel                	UnityEngine.RectTransform               
---@field ItemGridView                  	SuperScrollView.LoopGridView            
---@field DescrPanel                    	UnityEngine.RectTransform               
local Backpack = Class("Backpack")

function Backpack:__init(controller)
    self.controller = controller
    self.isItemsPage = true --是否处于道具界面
    self.SortType = nil
    self.__EquipFilterTabAction = nil
    self.isAscOrder = nil
    self.navigatorBar = nil
    self.eventSuitFilter = nil -- 装备筛选事件
    self.rectTransItemGridView = nil -- 物品下拉列表的Rect
    self.descPanel = nil -- 物品详情界面
    self.selectIndex = 1 -- 选中物品的 Index
    self.tabIndex = 1 ---初始选中的页签位置id
    self.data = nil ---当前选中页签的道具信息
    self.packetProgress = nil
    self.togglesData = nil
    self.isBatch = false
    self.consume = nil
    self.batchData = nil
    self.levelUpFinishEvent = nil
end

function Backpack:__delete()
    self.controller = nil
    self.isItemsPage = nil
    self.SortType = nil
    self.isAscOrder = nil
    self.__EquipFilterTabAction = nil
    self.eventSuitFilter = nil
    self.rectTransItemGridView = nil
    self.descPanel = nil
    self.selectIndex = nil
    self.filterNode = nil
    self.packetProgress = nil
    self.data = nil
    self.togglesData = nil
    self.isBatch = false
    self.consume = nil
    self.batchData = nil
    self.levelUpFinishEvent = nil
end

function Backpack:InitComponent()
    self.consume = {} ---用来记录卖出的资源数据
    --SetButtonAction(self.PlusIcon, Bind(self, self.OnExtendPacketAction))
    self.rectTransItemGridView = self.ItemGridView.gameObject:GetComponent(typeof(RectTransform))
    local descPanelLB = GetLuaBehaviour(self.DescrPanel.gameObject, BackpackItemInfoPanel)
    if descPanelLB then
        descPanelLB:Init()
        self.descPanel = descPanelLB.Env
    end

    SetButtonAction(self.BtnBulkSale, Bind(self, self.OnBatchAction))

    --self:FillFilter()
end

function Backpack:HandleBackAction()
    if self.isBatch then
        self.isBatch = false
        ---@type UINavigatorBar
        local navigatorBarEnv = CfUtils.GetLuaScr(UINavigationBarRoot.Instance.gameObject, NavigationBarRootPath)
        if navigatorBarEnv then
            navigatorBarEnv:CustomTitleName(localize('背包'))
        end
        KTool.SetActive(self.BtnBulkSale.gameObject, true)
        KTool.SetActive(self.BulkSalePanel.gameObject, false)
        self.consume = {} ---记录的数据重置
        KTool.SetActive(self.DescrPanel.gameObject, true)
        KTool.SetActive(self.SortBar.gameObject, true)
        ---@type UnityEngine.RectTransform
        local rectTrans = KTool.GetComponent(self.SortBar.gameObject, typeof(RectTransform))
        --print('--->>', rectTrans.offsetMin, rectTrans.offsetMax, rectTrans.anchoredPosition)
        rectTrans.offsetMax = Vector2.New(0, 0)
        self:SetGridTransformSize(Vector2.New(0, 48), Vector2.New(-565, -100))
        local loopViewWidth = self.rectTransItemGridView.rect.width
        local gridSizeWithPadding = self.ItemGridView.ItemSize.x + self.ItemGridView.ItemPadding.x
        self.ItemGridView.MFixedRowOrColumnCount = math.floor(loopViewWidth / gridSizeWithPadding)
        self.batchData = nil
        GameUtils.ReloadData(self.ItemGridView, 0)
        ---@type BackpackVo
        local packet = self.togglesData[self.tabIndex]
        self:FreshUI(packet)
        self:FreshTabToggle()
        self:SetGoodNodeBeSelected()
    else
        UIModule.BackDialog()
    end
end

function Backpack:SetGridTransformSize(min, max)
    ---@type UnityEngine.RectTransform
    local trans = self.rectTransItemGridView
    trans.offsetMax = max
    trans.offsetMin = min
end

function Backpack:OnBatchAction()
    self.isBatch = true
    ---@type UINavigatorBar
    local navigatorBarEnv = CfUtils.GetLuaScr(UINavigationBarRoot.Instance.gameObject, NavigationBarRootPath)
    if navigatorBarEnv then
        navigatorBarEnv:CustomTitleName(localize('批量出售'))
    end
    KTool.SetActive(self.BtnBulkSale.gameObject, false)
    KTool.SetActive(self.BulkSalePanel.gameObject, true)
    KTool.SetActive(self.DescrPanel.gameObject, false)
    --KTool.SetActive(self.SortBar.gameObject, false)
    ---@type UnityEngine.RectTransform
    local rectTrans = KTool.GetComponent(self.SortBar.gameObject, typeof(RectTransform))
    --print('--->>', rectTrans.offsetMin, rectTrans.offsetMax, rectTrans.anchoredPosition)
    rectTrans.anchoredPosition = Vector2.New(0, -42)
    --rectTrans.offsetMax = Vector2.New(-134, 0)
    rectTrans.offsetMax = Vector2.New(-168, 0)
    self:SetGridTransformSize(Vector2.New(0, 48), Vector2.New(-718, -100))
    local loopViewWidth = self.rectTransItemGridView.rect.width
    local gridSizeWithPadding = self.ItemGridView.ItemSize.x + self.ItemGridView.ItemPadding.x
    self.ItemGridView.MFixedRowOrColumnCount = math.floor(loopViewWidth / gridSizeWithPadding)
    self.batchData = self.data
    local t = {}
    ---@type GoodsConfMgr
    local goodsConfMgr = GoodsConfMgr:GetInstance()
    for i, v in pairs(self.data) do
        local goodsVo = goodsConfMgr:GetGoodsVoById(v.goodsId)
        if not (goodsVo.type == Constants.IDType.Equipment and (checkNumber(v.vo.locked) == 1 or checkNumber(v.vo.playerCardId) > 0)) then
            if goodsVo and checkNumber(goodsVo.sellitem) > 0 then
                table.insert(t, v)
            end
        end
    end
    self.data = t
    ---@type BackpackBatchSellPanel
    local env = CfUtils.GetLuaScr(self.BulkSalePanel.gameObject, BackpackBatchSellPanel)
    if env and #t > 0 then
        self.selectIndex = -1
        self:SetGoodNodeBeSelected()
    else
        self:SetGoodNodeBeSelected()
    end
    self:FreshGridView()
    self:FreshTabToggle()
end

---OnExtendPacketAction
---扩展背包的功能
function Backpack:OnExtendPacketAction()
    ---@type BackpackVo
    local packet = self.togglesData[self.tabIndex]
    ---@type BackpackComponent
    local backpackComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.BackpackComponent)
    local curNo = backpackComponent:GetPacketExtendNumber(packet.id)
    local maxNo = #packet.costNum
    if curNo == maxNo then
        ---已达上限
        GameUtils.Toast(localize('当前背包扩展已达上限'))
        return
    end
    local goodsId = checkNumber(packet.costItemId)
    local costNum = checkNumber(packet.costNum[curNo + 1])
    local cellNum = checkNumber(packet.cellNum)
    local haveNo = GoodsUtils.GetThingNo(goodsId)
    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
    GameUtils.SecondConfirm(localize('是否消耗_count__name_扩充_num_格_type_栏', { _count_ = costNum, _name_ = vo.name, _num_ = cellNum, _type_ = packet.name }), function()
        if haveNo < costNum then
            GameUtils.Toast(localize('当前扩展所需的_name_不足', { _name_ = tostring(vo.name) }))
            return
        end
        GameUtils.Request(Interfaces.BackpackExtend, { backpackTypeId = packet.id }, function(request, response)
            if checkNumber(response.errCode) == 0 then
                ---success
                GoodsUtils.DrawRewards({ { goodsId = goodsId, num = -costNum } }, false)
                backpackComponent:UpdatePacketExtendNumber(packet.id)
                --local num = self.packetProgress[tostring(self.tabIndex)]
                --self.packetProgress[tostring(self.tabIndex)] = checkNumber(num) + cellNum
                --fresh ui
                self:FreshUI(packet)
                self:FreshTabToggle()
                GameUtils.Toast(localize('购买成功'))
            end
        end)
    end, function()

    end)
end

function Backpack:InitListener()
    ----- SortBar
    ----- 三个筛选按钮
    --self.__EquipFilterTabAction = function(index, isOn)
    --    if index == SortTabType.Quality then
    --        self:OnClickRareButtonAction()
    --    elseif index == SortTabType.Level then
    --        self:OnClickLevelButtonAction()
    --    end
    --end
    ----- 套装筛选 的 事件
    --self.eventSuitFilter = Events.AddListener(Constants.EventNames.UICultivateEquipSuitFilterComplete, Bind(self, self.OnSuitFilterComplete))
    self.EventEveryThingChangeEventName = Events.AddListener(Constants.EventNames.EveryThingChangeEventName, Bind(self, self.OnEveryThingChangeEventName))
    self.levelUpFinishEvent = Events.AddListener(Constants.EventNames.CardProgressEquipLevelUpFinish, Bind(self, self.LevelUpFinishEventHandler))
    self.starUpFinishEvent = Events.AddListener(Constants.EventNames.CardProgressEquipStarUpFinish, function(equipDojo)
        self:LevelUpFinishEventHandler(equipDojo)
    end)
end

function Backpack:RemoveListener()
    Events.RemoveListener(Constants.EventNames.UICultivateEquipSuitFilterComplete, self.eventSuitFilter)
    Events.RemoveListener(Constants.EventNames.EveryThingChangeEventName, self.EventEveryThingChangeEventName)
    Events.RemoveListener(Constants.EventNames.CardProgressEquipLevelUpFinish, self.levelUpFinishEvent)
    Events.RemoveListener(Constants.EventNames.CardProgressEquipStarUpFinish, self.starUpFinishEvent)
end

---升级结束事件处理
function Backpack:LevelUpFinishEventHandler(equipDojo)
    ---重新剧新下列表
    if not self.isBatch then
        --print('---->>', equipDojo)
        ---剧新状态当前页签
        self:FreshUI(self.togglesData[self.tabIndex], true)
    end
end

function Backpack:FillLeftToggle()
    local togglesData = GoodsUtils.GetBasicPackets()
    for i, v in pairs(togglesData) do
        v.func = function(data, position)
            ---通用点击的逻辑
            if self.isBatch then
                if checkNumber(data.id) == EQUIP_TYPE then
                    GameUtils.Toast(localize("装备不支持批量售卖"))
                    return 0
                end
            end
            self:OnTabActionEvent(data, position)
        end
    end
    self.togglesData = togglesData
    ---@type CommonTabToggleLeft
    local nodeEnv = CfUtils.GetLuaScr(self.TogglePanel.gameObject, CommonTabToggleLeft)
    if not KTool.IsNull(nodeEnv) then
        nodeEnv:SetAfterAction(function()
            nodeEnv:FreshListView()
        end)
        ---@param data BackpackVo
        ---@param env CommonTabToggleLeftCell
        nodeEnv:FillToggles(togglesData, self.tabIndex, function(isSelected, index, curIndex, data, env)
            if self.isBatch then
                env:SetQuantityVisible(false)
            else
                ---@type BackpackComponent
                local backpackComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.BackpackComponent)
                local limit = backpackComponent:GetPacketLimitByPacketId(data.id)
                if table.count(self.packetProgress) > 0 then
                    local pro = checkNumber(self.packetProgress[tostring(data.id)])
                    if pro > limit then
                        env:FreshPacketText(string.format('<color=#ff47ba>%d</color>/%d', pro, tostring(limit)))
                    else
                        env:SetQuantityVisible(false)
                    end
                else
                    env:SetQuantityVisible(false)
                end
                env:FreshRedPointStatus(backpackComponent:IsBackpackTypeRedPoint(data.id))
            end
        end)
    end
end

---OnTabActionEvent
---@param data BackpackVo
---@param position number
---@param isForce boolean
function Backpack:OnTabActionEvent(data, position, isForce)
    if self.tabIndex == position and checkBool(isForce) == false then
        return
    end
    self.tabIndex = position
    if self.isBatch then
        self.selectIndex = -1
        if self.consume then
            for i, v in pairs(self.consume) do
                v.position = -1
            end
        end
    else
        self.selectIndex = 1
    end
    self:FreshUI(data)
end

function Backpack:InitializeProgressingData()
    --if not self.isBatch then
        ---@type BackpackComponent
        local backpackComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.BackpackComponent)
        self.packetProgress = {}
        for i, packet in pairs(self.togglesData) do
            local t = backpackComponent:GetGoodsByPacketId(packet.id)
            self.data = {}
            local pro = 0
            local isEquip = 0
            for i, v in pairs(t) do
                local stack = checkNumber(v.vo.stackMax)
                if stack > 0 then
                    ---存在堆叠数量
                    local cellNo = math.floor((checkNumber(v.num) + stack - 1) / stack)
                    pro = pro + cellNo
                else
                    pro = pro + 1
                end
            end
            self.packetProgress[tostring(packet.id)] = pro
        end
    --end
end

---InitializeData
---@param packet BackpackVo
function Backpack:InitializeData(packet)
    ---@type BackpackComponent
    local backpackComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.BackpackComponent)
    self:InitializeProgressingData()
    local t = backpackComponent:GetGoodsByPacketId(packet.id)
    self.data = {}
    local pro = 0
    local isEquip = 0
    for i, v in pairs(t) do
        local stack = checkNumber(v.vo.stackMax)
        if stack > 0 then
            ---存在堆叠数量
            local cellNo = math.floor((checkNumber(v.num) + stack - 1) / stack)
            for i = 1, cellNo do
                local v = clone(v)
                v.tId = string.format('%d_%d', v.goodsId, i)
                if i == cellNo then
                    v.num = checkNumber(v.num) - (i - 1) * stack
                else
                    v.num = stack
                end
                table.insert(self.data, v)
            end
            pro = pro + cellNo
        else
            local idType = GoodsUtils.GetIdType(v.goodsId)
            local goodsId = checkNumber(v.goodsId)
            if checkNumber(idType) == Constants.IDType.Equipment then
                isEquip = 1
                goodsId = checkNumber(v.vo.id)
            end
            v.tId = tostring(goodsId)
            pro = pro + 1
            table.insert(self.data, v)
        end
    end
    if self.isBatch then
        local t = {}
        ---@type GoodsConfMgr
        local goodsConfMgr = GoodsConfMgr:GetInstance()
        for i, v in pairs(self.data) do
            local goodsVo = goodsConfMgr:GetGoodsVoById(v.goodsId)
            if not (goodsVo.type == Constants.IDType.Equipment and (checkNumber(v.vo.locked) == 1 or checkNumber(v.vo.playerCardId) > 0)) then
                if goodsVo and checkNumber(goodsVo.sellitem) > 0 then
                    table.insert(t, v)
                end
            end
        end
        self.data = t
        self.batchData = self.data
    end
    if checkNumber(packet.id) == EQUIP_TYPE then
        local cardConfMgr = CardConfMgr:GetInstance()
        local baseEquipId = 4010111
        table.sort(self.data, function(a, b)
            ---@type EquipDojo
            local dojo1 = a.vo
            local dojo2 = b.vo
            local aKey = 10
            local bKey = 10
            if checkNumber(dojo1.playerCardId) > 0 then
                aKey = 11
            end
            ---已穿戴的情况下
            if checkNumber(dojo2.playerCardId) > 0 then
                bKey = 11
            end
            if aKey == 11 and bKey == 11 then
                --同时穿戴的情况下
                aKey = checkNumber(dojo1.playerCardId)
                bKey = checkNumber(dojo2.playerCardId)
                ----同一张的情况下，以部位排序,这个要取装备配置数据浪费啊
                if aKey == bKey then
                    ---@type EquipVo
                    local equip1Vo = cardConfMgr:GetEquipVoById(dojo1.equipmentId)
                    ---@type EquipVo
                    local equip2Vo = cardConfMgr:GetEquipVoById(dojo2.equipmentId)
                    aKey = aKey + checkNumber(equip1Vo.part)
                    bKey = bKey + checkNumber(equip2Vo.part)
                end
            end
            if checkNumber(dojo1.playerCardId) == 0 and checkNumber(dojo2.playerCardId) == 0 then
                ---未穿戴的
                ---@type EquipVo
                local equip1Vo = cardConfMgr:GetEquipVoById(dojo1.equipmentId)
                ---@type EquipVo
                local equip2Vo = cardConfMgr:GetEquipVoById(dojo2.equipmentId)
                aKey = aKey + checkNumber(equip1Vo.rare)
                bKey = bKey + checkNumber(equip2Vo.rare)
                if aKey == bKey then
                    aKey = aKey + checkNumber(equip1Vo.equipId) - baseEquipId
                    bKey = bKey + checkNumber(equip2Vo.equipId) - baseEquipId
                end
            end
            return aKey > bKey
        end)
    else
        table.sort(self.data, function(a, b)
            local aKey = checkNumber(a.goodsId)
            local bKey = checkNumber(b.goodsId)
            if aKey == bKey then
                aKey = checkNumber(a.num)
                bKey = checkNumber(b.num)
            end
            return aKey > bKey
        end)
    end

end

function Backpack:FreshUI(data, isKeepIndex)
    isKeepIndex = checkBool(isKeepIndex)
    self:InitializeData(data)
    self:FreshPacketLimit(data)
    self:FreshGridView(data, isKeepIndex)
    self:SetGoodNodeBeSelected(self.selectIndex)
end

---FreshGridView
---@param packet BackpackVo
---@param isKeepIndex boolean 是否保持选中磁态
function Backpack:FreshGridView(packet, isKeepIndex)
    KTool.SetActive(self.ItemGridView.gameObject, #self.data > 0)
    KTool.SetActive(self.ItemEmptyPanel.gameObject, #self.data == 0)
    if not self.isBatch then
        if not isKeepIndex then
            if #self.data > 0 then
                self.selectIndex = 1
            else
                self.selectIndex = -1
            end
        end
        local packetId = packet.id
        if HideBulkSaleConf[packetId] then
            KTool.SetActive(self.BtnBulkSale.gameObject, false)
        else
            KTool.SetActive(self.BtnBulkSale.gameObject, #self.data > 0)
        end
    end
    self:RefreshScrollView(self.data)
end

function Backpack:SetDescriptionEmptyState(visibility)
    visibility = checkBool(visibility)
    KTool.SetActive(self.DescrPanel.gameObject, visibility)
    KTool.SetActive(self.ItemsPanel.gameObject, visibility)
end

---FreshPacketLimit
---@param data BackpackVo
function Backpack:FreshPacketLimit(data)
    ---@type BackpackComponent
    local backpackComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.BackpackComponent)
    local limit = backpackComponent:GetPacketLimitByPacketId(data.id)
    CfUtils.FillText(self.TxtTabName, data.name)
    --KTool.SetActive(self.PlusIcon.gameObject, checkNumber(data.isSaled) == 1)
    --if self.packetProgress and not self.isBatch then
    if self.packetProgress then
        local pro = checkNumber(self.packetProgress[tostring(data.id)])
        if pro > limit then
            CfUtils.FillText(self.TxtNum, string.format('<color=#ff47ba>%d</color>/%d', pro, tostring(limit)))
        else
            CfUtils.FillText(self.TxtNum, string.format('<color=#ffffff>%d</color>/%d', pro, tostring(limit)))
        end
    end
end

function Backpack:FreshTabToggle()
    ---@type CommonTabToggleLeft
    local env = CfUtils.GetLuaScr(self.TogglePanel.gameObject, CommonTabToggleLeft)
    if isNull(env) then
        return
    end
    env:FillToggles(self.togglesData, self.tabIndex)
end

--
-----FillFilter
-----初始化筛选器
--function Backpack:FillFilter()
--    self.filterNode = nil
--    self.filterClass = Constants.UIFilterType.Equip
--    local transFilterNode = self.SortBar:Find(Path_FilterNode)
--    if transFilterNode then
--        local goFilterNode = transFilterNode.gameObject
--        local commonFilterNode = GetLuaBehaviour(goFilterNode, CommonFilterMB)
--        if commonFilterNode then
--            commonFilterNode:Init()
--            self.filterNode = commonFilterNode.Env
--            self.filterNode:SetFilterClass(Constants.UIFilterType.Equip)
--            --- 回调函数
--            self.filterNode:SetCallback(
--                    self:GetTarots(),
--                    function(data)
--                        self.chips = data
--                        self:RefreshScrollView(self.chips)
--                    end,
--                    Constants.UISortType.Equip)
--        end
--    end
--end
------------ Init ------------

------------ LifeCycle ------------

function Backpack:Awake()
    self:InitComponent()
    self:InitListener()
end

function Backpack:OnInitialize()
    --- @type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(
            util.cs_generator(
                    function()
                        local argument = self.controller.Argument.parameters
                        if argument then
                            self.tabIndex = checkNumber(argument.type)
                        end
                        self:SetGridTransformSize(Vector2.New(0, 48), Vector2.New(-565, -100))
                        ---@type BackpackBatchSellPanel
                        local env = CfUtils.GetLuaScr(self.BulkSalePanel.gameObject, BackpackBatchSellPanel)
                        if env then
                            env:SetNumberEditAction(function(isRequest)
                                if isRequest == 1 then
                                    local consume = {}
                                    for k, v in pairs(self.consume) do
                                        local goodsId = checkNumber(v.data.goodsId)
                                        local idType = GoodsUtils.GetIdType(goodsId)
                                        local equipId
                                        local storeKey = goodsId
                                        if checkNumber(idType) == Constants.IDType.Equipment then
                                            ---如果是装备的情况下
                                            equipId = v.data.vo.id
                                            storeKey = checkNumber(equipId)
                                        end
                                        if consume[tostring(storeKey)] then
                                            consume[tostring(storeKey)] = { goodsId = goodsId, num = checkNumber(consume[tostring(storeKey)].num) + checkNumber(v.data.preNo), equipId = equipId }
                                        else
                                            consume[tostring(storeKey)] = { goodsId = goodsId, num = checkNumber(v.data.preNo), equipId = equipId }
                                        end
                                    end
                                    GameUtils.Request(Interfaces.BackpackSell, {
                                        consume = table.serialize(table.values(consume))
                                    }, function(request, response)
                                        if checkNumber(response.errCode) == 0 then
                                            ---成功了
                                            local data = checkTable(response.data)
                                            local rewards = checkTable(data.rewards)
                                            local t = {}
                                            for i, v in pairs(table.values(consume)) do
                                                table.insert(t, { goodsId = v.goodsId, num = -v.num, playerItemId = v.equipId })
                                            end
                                            GoodsUtils.DrawRewards(t)
                                            if #rewards > 0 then
                                                GoodsUtils.DrawRewards(data.rewards)
                                                UIModule.OpenDialog(
                                                        {
                                                            id = Constants.UITypeIds.UICommonRewardPop,
                                                            parameters = { rewards = data.rewards }
                                                        }
                                                )
                                            end
                                            ---@type BackpackVo
                                            local packet = self.togglesData[self.tabIndex]
                                            self.consume = {} ---记录的数据重置
                                            self.selectIndex = -1
                                            self:FreshUI(packet)
                                        end
                                    end)
                                else
                                    self.ItemGridView:RefreshAllShownItem()
                                end
                            end)
                        end
                        self:FillLeftToggle()
                        self.descPanel:NotSelectedGood()
                    end))
    return coWait
end

function Backpack:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --- 设置列表每行 元素个数
        local loopViewWidth = self.rectTransItemGridView.rect.width
        local gridSizeWithPadding = self.ItemGridView.ItemSize.x + self.ItemGridView.ItemPadding.x
        self.ItemGridView.MFixedRowOrColumnCount = math.floor(loopViewWidth / gridSizeWithPadding)
        self:OnTabActionEvent(self.togglesData[self.tabIndex], self.tabIndex, true)
    end))
    return coWait
end

function Backpack:OnFocus(focus)
    if focus then
        ---@type UINavigatorBar
        local navigatorBarEnv = CfUtils.GetLuaScr(UINavigationBarRoot.Instance.gameObject, NavigationBarRootPath)
        if navigatorBarEnv then
            navigatorBarEnv:CustomTitleName(self.isBatch and localize('批量出售') or localize('背包'))
        end
    end
end
function Backpack:OnFinalize()
    local coWait = CoWait.Start():Coroutine(
            util.cs_generator(
                    function()
                        local argument = self.controller.Argument.parameters
                        if isNotNull(argument) then
                            argument.type = self.tabIndex
                        end
                        self:RemoveListener()
                        self.controller = nil -- 删除lua层引⽤用到的c#对象 否则不不会产⽣生c# gc回收到对象 self:Delete()
                        self:Delete()
                        self = nil -- lua层的gc需要
                    end
            )
    )
    return coWait
end

------------ LifeCycle ------------
---OnClickSuitButtonAction
--- 筛选按钮点击事件
function Backpack:OnClickSuitButtonAction()
    UIModule.OpenDialog(
            { id = Constants.UITypeIds.UICultivateEquipSuitFilterDialog,
              parameters = { showType = 1, callBack = function()
                  --self:SetSortNodeState(true)
                  KTool.SetActive(self.Root_ClickBreak.gameObject, false)
              end } })
    --self:SetSortNodeState(false)
    KTool.SetActive(self.Root_ClickBreak.gameObject, true)
end

---SetSortNodeState
---显示/隐藏 装备筛选条
function Backpack:SetSortNodeState(boolean)
    KTool.SetActive(self.SortNodes.gameObject, boolean)
end

---RefreshScrollView
---刷线滑动列表
---@param result table
function Backpack:RefreshScrollView(result)
    if self.ItemGridView.IsListViewInit then
        GameUtils.ReloadData(self.ItemGridView, 0)
        GameUtils.ReloadData(self.ItemGridView, table.count(result))
    else
        self.ItemGridView:InitGridView(table.count(result), Bind(self, self.OnGetItemByIndex))
    end
end

---ResetFilterIconState
---重置过滤的icon状态
function Backpack:ResetFilterIconState()

end

---OnClickLevelButtonAction
---装备筛选等级排序按钮
function Backpack:OnClickLevelButtonAction()
    self:RefreshScrollViewBySortType(SortType.Level)
end

---OnClickRareButtonAction
---装备筛选品质排序
function Backpack:OnClickRareButtonAction()
    self:RefreshScrollViewBySortType(SortType.Quality)
end

---RefreshScrollViewBySortType
---由筛选刷新物品展示SV
---@param sortType number
function Backpack:RefreshScrollViewBySortType(sortType)
    if self.sortType ~= sortType then
        self.sortType = sortType
        self.isAscOrder = true
        self:ResetFilterIconState()
    end
    -----等级排序
    --local rotateZ = self.isAscOrder and 0 or 180 -- 0 小到大 
    --if sortType == SortType.Level then
    --    self.img_LevelSort:DOLocalRotate(Vector3.New(0, 0, rotateZ), 0.12)
    --elseif sortType == SortType.Quality then
    --    self.img_RareSort:DOLocalRotate(Vector3.New(0, 0, rotateZ), 0.12)
    --end
    --self.isAscOrder = not self.isAscOrder
    self.chips = self:GetTarots()
    self:RefreshScrollView(self.chips)
end

---UpdateShowListShowState
---更新 ItemList 显示
---@param data table
function Backpack:UpdateShowListShowState(data)
    --KTool.SetActive(self.SortBar.gameObject, (not isEmpty) and self.type_SVList == DataType.Equip)
end

---ShowItemTimeLimitList
---展示可使用物品
function Backpack:ShowItemTimeLimitList()
    self:UpdateShowListShowState(self.itemsTimeLimit)
    self:RefreshScrollView(self.itemsTimeLimit)
end

---ShowItemList
---展示 物品列表
function Backpack:ShowItemList()
    self:UpdateShowListShowState(self.data)
    self:RefreshScrollView(self.data)
end

---ShowDescriptionPanel
---展示物品详情面板
---@param data table
function Backpack:ShowDescriptionPanel(data)
    xTry(function()
        self.descPanel:ApplyCommonComponent(data)
        self.descPanel:ShowItemInfo(data)
    end)
end


---OnGetItemByIndex
---道具列表
function Backpack:OnGetItemByIndex(gridView, index, row, column)
    if index < 0 then
        return
    end
    local cell = gridView:NewListViewItem(GoodsNodePrefabName)
    local position = index + 1
    local data = self.data[position]
    local goodNodeMB = GetLuaBehaviour(cell.gameObject, CellNodeMBPath)
    if not IsNull(goodNodeMB) then
        if IsNull(goodNodeMB.Env) then
            goodNodeMB:Init()
        end
        ---@type BackpackCellNode
        local env = goodNodeMB.Env
        env:SetCallback(Bind(self, self.OnCellClickAction))
        env:FreshUI(data, position, position == self.selectIndex, self.consume[data.tId] ~= nil)
        if self.isBatch and self.consume[data.tId] ~= nil then
            local consume = self.consume[data.tId].data
            if consume then
                env:FreshBatchSellTxt(tostring(consume.preNo))
            end
        end
    end
    return cell
end

function Backpack:OnCellClickAction(data, position)
    self:SetGoodNodeBeSelected(position)
    self.ItemGridView:RefreshAllShownItem()
end

---OnEveryThingChangeEventName
---物品发生改变
function Backpack:OnEveryThingChangeEventName(id)
    if not isNull(id) then
        return
    end
    ---@type BackpackVo
    local packet = self.togglesData[self.tabIndex]
    self:InitializeData(packet)
    self:FreshTabToggle()
    self:FreshPacketLimit(packet)
    if self.selectIndex > #self.data then
        if #self.data == 0 then
            self.selectIndex = 0
        else
            self.selectIndex = 1
        end
    end
    self:FreshGridView(packet, true)
    self:SetGoodNodeBeSelected(self.selectIndex)
end
------------ SortData ------------

---DataSort
---物品需求顺序
---@param data table
---@param isAsc boolean
function Backpack:DataSort(data, isAsc)
    local commonChecker = function(a, b, fieldNames, ascSortFlag)
        local fieldNameCount = #fieldNames
        local loopTimes = fieldNameCount - 1
        ascSortFlag = math.min(math.max(ascSortFlag or loopTimes, 1), loopTimes)
        for i = 1, fieldNameCount - 1 do
            local fieldName = fieldNames[i]
            local aFiled, bFiled = checkNumber(a[fieldName]), checkNumber(b[fieldName])
            if i <= ascSortFlag then
                if aFiled ~= bFiled then
                    if isAsc then
                        return aFiled > bFiled
                    else
                        return aFiled < bFiled
                    end
                end
            else
                if aFiled ~= bFiled then
                    return aFiled > bFiled
                end
            end
        end
        local fieldName = fieldNames[fieldNameCount]
        return checkNumber(a[fieldName]) > checkNumber(b[fieldName])
    end
    local fieldNames = { "quality", "level", "refId", "id" }
    ---稀有度/goodsId 排序
    table.sort(data, function(a, b)
        return commonChecker(a, b, fieldNames, 1)
    end)
end

------------ SortData ------------

---SetGoodNodeBeSelected
---点选物品
---@param index number
function Backpack:SetGoodNodeBeSelected(index)
    --if index and index == self.selectIndex then
    --    return
    --end
    if not IsNull(index) and checkNumber(index) > 0 then
        if self.isBatch then
            local data = self.data[index]
            if self.consume[data.tId] then
                data.preNo = 0
                ---是取消的操作
                self.consume[data.tId] = nil
                if table.count(self.consume) > 0 then
                    local key = table.keys(self.consume)[1]
                    self.selectIndex = self.consume[key].position
                else
                    self.selectIndex = -1
                end
            else
                ---选中的操作
                self.selectIndex = index
                data.preNo = checkNumber(data.num)
                self.consume[data.tId] = { data = data, position = index }
            end
        else
            self.selectIndex = index
        end
    end
    if self.isBatch then
        ---@type BackpackBatchSellPanel
        local env = CfUtils.GetLuaScr(self.BulkSalePanel.gameObject, BackpackBatchSellPanel)
        if env then
            if self.data and self.data[self.selectIndex] then
                env:SetEmpty(false, true, false)
                local data = self.data[self.selectIndex]
                env:FreshUI(data)
            else
                if table.count(self.consume) > 0 then
                    env:SetEmpty(false, true, true)
                    env:FreshSellStateUI()
                else
                    local hasData = self.data and #self.data > 0
                    env:SetEmpty(hasData, false, hasData)
                end
            end
        end
    else
        if self.data and self.data[self.selectIndex] then
            KTool.SetActive(self.descPanel.gameObject, true)
            local data = self.data[self.selectIndex]
            self:ShowDescriptionPanel(data)
        else
            self.descPanel:NotSelectedGood()
        end
    end
end

return Backpack
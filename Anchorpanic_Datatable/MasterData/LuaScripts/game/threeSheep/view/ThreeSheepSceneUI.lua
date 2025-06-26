-- @FileName:   ThreeSheepSceneUI.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-03 17:48:19
-- @Copyright:   (LY) 2024 锚点降临

module('game.threeSheep.view.ThreeSheepSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("threeSheep/ThreeSheepSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isBlur = 0
escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = false

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
    -- self:setBg("")
    -- self:setTxtTitle(_TT(138601))
    self:setUICode(LinkCode.ThreeSheep)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.m_startView = fightUI.FightStartView.new()
    self.m_startView:initData(self:getChildGO('StartGroup'))

    self.mBtnProps = self:getChildGO("mBtnProps")
    self.mPropsGroup = self:getChildTrans("mPropsGroup")

    self.mImgLine = self:getChildGO("mImgLine")
    self.mBanklineGroup = self:getChildTrans("mBanklineGroup")
    self.mBankGroup = self:getChildTrans("mBankGroup")

    self.mCardItem = self:getChildGO("mCardItem")
    self.mCardLayer = self:getChildGO("mCardLayer")
    self.mCardSceneGroup = self:getChildTrans("mCardSceneGroup")

    self.mDepotGroup_1 = self:getChildTrans("mDepotGroup_1")
    self.mDepotGroup_2 = self:getChildGO("mDepotGroup_2")

    self.mBtnPause = self:getChildGO("mBtnPause")
    self.mGroupPause = self:getChildGO("mGroupPause")

    self.mGroupStar = self:getChildTrans("mGroupStar")

    self.mBtnReplay = self:getChildGO("mBtnReplay")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnFinish = self:getChildGO("mBtnFinish")

    self.mEditorToggleGo = self:getChildGO("mEditorToggle")
    self.mEditorToggle = self.mEditorToggleGo:GetComponent(ty.Toggle)
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPause, self.onPauseClick)

    self:addUIEvent(self.mBtnReplay, self.onReplayClick)
    self:addUIEvent(self.mBtnPlay, self.onPlayClick)
    self:addUIEvent(self.mBtnFinish, self.onFinishClick)
end

--激活
function active(self, args)
    super.active(self)

    self:AddEventListener()

    self:refreshView(args)

    self.mGroupPause:SetActive(false)

    if GameManager.IS_DEBUG and not GameManager.HIDE_DEBUG_INFO and recruit.RecruitManager.debugUpInfo then
        self.mEditorToggleGo:SetActive(true)
        self.mEditorToggle.isOn = false

        local onToggle = function (val)
            self:onEditorToggle(val)
        end
        self.mEditorToggle.onValueChanged:AddListener(onToggle)
    else
        self.mEditorToggleGo:SetActive(false)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()

    self.mEditorToggle.onValueChanged:RemoveAllListeners()

    self:clearData()
end

-- 添加界面UI特效 (isSort 非ui粒子，设置为true)
function addEffect(self, effectName, parentTrans, localPosX, localPosY, callFun, isSort)
    if not self.mEffectList then
        self.mEffectList = {}
    end

    local effectData = {effectSn = nil, effectName = nil, effectGo = nil}
    table.insert(self.mEffectList, effectData)
    local function _loadAysnCall(effectGo)
        if (effectGo) then
            local effectTrans = effectGo.transform
            effectData.effectGo = effectGo
            effectData.effectGo:SetActive(true)

            gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
            if (localPosX and localPosY) then
                gs.TransQuick:Pos(effectTrans, gs.Vector3(localPosX, localPosY, parentTrans.position.z))
            end

            if isSort then
                local rootCanvas = effectGo:GetComponentInParent(ty.Canvas)
                local order = rootCanvas.sortingOrder + 1

                local renderArray = gs.GoUtil.GetRendererComsInChildren(effectGo)
                local len = renderArray.Length - 1
                for i = 0, len do
                    local render = renderArray[i]
                    render.sortingOrder = render.sortingOrder + order
                end
            end

            if (callFun) then
                callFun(true, effectData.effectGo)
            end
        else
            if (effectName) then
                self:removeEffect(effectName)
            end
            if (callFun) then
                callFun(false, nil)
            end
        end
    end
    effectData.effectName = effectName
    effectData.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)), _loadAysnCall)
end

function clearData(self)
    self:clearCard()
    self:clearProps()
    self:clearBankLine()
    self:clearDepot()
    self:clearStarItem()
    self:clearSceneLayerItem()

    self.m_RevokeCardList = nil
    self.m_ScenePosList = nil
end

function AddEventListener(self)

end

function RemoveEventListener(self)

end

function onEditorToggle(self, val)
    for card_id, card_item in pairs(self.m_CardList) do
        card_item:onEditor(val)
    end
end

function refreshView(self, args)
    self:clearData()

    self.m_DupConfigVo = args

    self.m_RemoveNum = 0

    local function _finishCall()
        self.m_startView:setActive(false)

        self:createSceneCard()
        self:createPropsItem()
        self:createBankLine()
    end
    self.m_startView:setActive(true)
    self.m_startView:start(_finishCall)
end

-- 暂停
function onPauseClick(self)
    self.mGroupPause:SetActive(true)
    self:updateStarInfo()
end

-- 继续
function onPlayClick(self)
    self.mGroupPause:SetActive(false)
end

-- 重新开始
function onReplayClick(self)
    self.mGroupPause:SetActive(false)
    self:refreshView(self.m_DupConfigVo)
end

-- 提前结算
function onFinishClick(self)
    self.mGroupPause:SetActive(false)
    self:settlemenGame()
end

---从代销栏移除
function removeBankCardList(self, card_id)
    local remove_index, grid_id = nil, nil
    for _grid_id, grid_list in pairs(self.m_BankCardList) do
        for index, grid in pairs(grid_list) do
            if grid.id == card_id then
                remove_index = index
                grid_id = _grid_id
                break
            end
        end
    end

    if remove_index then
        table.remove(self.m_BankCardList[grid_id], remove_index)
    end
end

function clearDepot(self)
    if self.m_DepotItemList then
        for k, v in pairs(self.m_DepotItemList) do
            v.depotItem:poolRecover()
        end
    end

    self.m_DepotItemList = nil
end

--占用仓库位置
function occupyDepotTrans(self, card_item, index)
    local layer_index = nil
    local parent_trans = nil
    local isBreak = false
    for lay_index, depotData in pairs(self.m_DepotItemList) do
        if index == nil then
            for i = 1, 3 do
                if depotData.item_list[i] == nil then
                    index = i
                    isBreak = true
                end
            end
        else
            if depotData.item_list[index] == nil then
                isBreak = true
            end
        end

        if isBreak then
            layer_index = lay_index

            parent_trans = depotData.depotItem:getTrans()
            depotData.item_list[index] = card_item
            break
        end
    end

    if not isBreak then
        local depotItem = SimpleInsItem:create(self.mDepotGroup_2, self.mDepotGroup_1, "ThreeSheepSceneUI_depotItem")
        local depotData = {depotItem = depotItem, item_list = {}}
        table.insert(self.m_DepotItemList, depotData)

        layer_index = table.nums(self.m_DepotItemList)
        depotItem:getGo().name = layer_index

        if index == nil then
            index = 1
        end

        depotData.item_list[index] = card_item
        parent_trans = depotItem:getTrans()
    end

    return parent_trans, layer_index, index
end

---点击移出三个
function onClickRemove(self)
    if table.nums(self.m_RevokeCardList) < 3 then
        gs.Message.Show(_TT(138607))
        return false
    end

    local refreshMask_list = {}
    if not table.empty(self.m_DepotItemList) then
        refreshMask_list = self.m_DepotItemList[#self.m_DepotItemList].item_list
    end

    local startTrans = self:getChildTrans("mTweenLayer")
    local tempRectList = {}
    for i = 1, 3 do
        local bankCard = self.m_RevokeCardList[#self.m_RevokeCardList]
        local item = bankCard.item

        local parent_trans, layer_index, index = self:occupyDepotTrans(item, i)
        local anchoredPosition = gs.Vector2(68 * (index - 1) + (8 * index) + 34, -48)

        --动画处理
        item:addOnParent01(startTrans)

        local go = gs.GameObject.Instantiate(item:getGo(), startTrans)
        local go_rect = go:GetComponent(ty.RectTransform)
        go_rect.anchorMax = gs.Vector2(0, 1)
        go_rect.anchorMin = gs.Vector2(0, 1)
        go_rect.anchoredPosition = item:getTrans():GetComponent(ty.RectTransform).anchoredPosition

        tempRectList[i] = {temp_rect = go_rect, item = item, parent_trans = parent_trans, layer_index = layer_index, index = index}
        ------------------------
        item:addOnParent01(parent_trans)
        item:refreshInfo(false)
        item:getTrans():GetComponent(ty.RectTransform).anchoredPosition = anchoredPosition

        -- --从撤销列表中移除
        table.remove(self.m_RevokeCardList, #self.m_RevokeCardList)

        self:removeBankCardList(bankCard.data.id)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mDepotGroup_1)

    ---开始动画
    for i = 1, 3 do
        local rect = tempRectList[i].temp_rect
        local item = tempRectList[i].item
        local parent_trans = tempRectList[i].parent_trans
        local lastLayer_index = tempRectList[i].layer_index - 1
        local index = tempRectList[i].index

        item:addOnParent01(startTrans)
        ----------开始动画
        self.m_CanUseProps = false
        item:moveUIPos(rect, item:getTrans():GetComponent(ty.RectTransform).anchoredPosition, 0.3, function ()
            self.m_CanUseProps = true

            item:refreshInfo(true)
            item:addOnParent01(parent_trans)
            item:setScale(1, 1, 1)
            item:recoverClick()

            if self.m_DepotItemList[lastLayer_index] and self.m_DepotItemList[lastLayer_index].item_list[index] then
                self.m_DepotItemList[lastLayer_index].item_list[index]:refreshMask(true)
            end

            gs.GameObject.Destroy(rect.gameObject)
        end)
    end
    tempRectList = nil

    return true
end

--撤回
function onClickRevoke(self)
    if table.empty(self.m_RevokeCardList) then
        gs.Message.Show(_TT(138606))
        return false
    end

    local revokeCard_info = self.m_RevokeCardList[1]
    local revokeCard_data = revokeCard_info.data
    local revokeCard_item = self.m_RevokeCardList[1].item

    ---如果是从仓库出来的，判断仓库有不有可以摆放的位置，没有再创建
    local lastLayer_index, index = nil
    local parent_trans = revokeCard_info.parent_trans
    if revokeCard_info.depot_index then
        parent_trans, lastLayer_index, index = self:occupyDepotTrans(revokeCard_item, revokeCard_info.depot_index)
        lastLayer_index = lastLayer_index - 1
    end

    ---动画处理
    local startTrans = self:getChildTrans("mTweenLayer")
    revokeCard_item:addOnParent01(startTrans)
    local selfRect = revokeCard_item:getTrans():GetComponent(ty.RectTransform)

    local go = gs.GameObject.Instantiate(revokeCard_item:getGo(), startTrans)
    local go_rect = go:GetComponent(ty.RectTransform)
    go_rect.anchorMax = gs.Vector2(0, 1)
    go_rect.anchorMin = gs.Vector2(0, 1)
    go_rect.anchoredPosition = selfRect.anchoredPosition

    revokeCard_item:addOnParent01(parent_trans)
    revokeCard_item:refreshInfo(false)

    selfRect.anchoredPosition = self.m_RevokeCardList[1].revoke_pos

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mDepotGroup_1)

    revokeCard_item:addOnParent01(startTrans)

    self.m_CanUseProps = false
    revokeCard_item:moveUIPos(go_rect, selfRect.anchoredPosition, 0.3, function ()
        self.m_CanUseProps = true

        revokeCard_item:setScale(1, 1, 1)
        revokeCard_item:recoverClick()
        revokeCard_item:refreshInfo(true)
        revokeCard_item:addOnParent01(parent_trans)

        if lastLayer_index ~= nil and index ~= nil then
            if self.m_DepotItemList[lastLayer_index] ~= nil and self.m_DepotItemList[lastLayer_index].item_list[index] ~= nil then
                self.m_DepotItemList[lastLayer_index].item_list[index]:refreshMask(true)
            end
        end

        gs.GameObject.Destroy(go.gameObject)
    end)

    ---数据处理
    self:removeBankCardList(revokeCard_data.id)

    if revokeCard_info.depot_index == nil then
        --添加进场景中
        self.m_SceneCardList[revokeCard_data.layer][revokeCard_data.id] = revokeCard_item
    end

    --从撤销列表中移除
    table.remove(self.m_RevokeCardList, 1)

    self:refreshCardMask()

    return true
end

---重新洗牌
function refreshCard(self)
    local tween = function (item, ui_pos, finishCall)
        item:moveUIPos(item:getTrans():GetComponent(ty.RectTransform), ui_pos, 0.9, finishCall)
    end

    for layer, card_list in pairs(self.m_SceneCardList) do
        for _, card_item in pairs(card_list) do
            card_item:getChildGO("mClick"):SetActive(false)
        end
    end
    self.m_CanUseProps = false
    self:setTimeout(1.8, function ()
        self.m_CanUseProps = true

        for layer, card_list in pairs(self.m_SceneCardList) do
            for _, card_item in pairs(card_list) do
                card_item:recoverClick()
            end
        end
    end)

    for layer, card_list in pairs(self.m_SceneCardList) do
        for _, card_item in pairs(card_list) do
            tween(card_item, gs.Vector2(892 / 2, -496 / 2))
            -- tween(card_item, gs.Vector2(layer * 68, -496 / 2))
        end
    end

    self:setTimeout(0.9, function ()
        for layer, card_list in pairs(self.m_SceneCardList) do
            for _, card_item in pairs(card_list) do
                local data = card_item:getData()
                local parent = self:getLayerTrans(data.layer)
                card_item:addOnParent01(parent)

                local ui_pos = data.pos
                tween(card_item, ui_pos)
            end
        end

        local grid_id_list = {}
        for layer, card_list in pairs(self.m_SceneCardList) do
            for _, card_item in pairs(card_list) do
                table.insert(grid_id_list, card_item:getData().grid_id)
            end
        end

        local function getRandom_grid (old_grid)
            if table.nums(grid_id_list) == 1 then
                return grid_id_list[1]
            end

            local isOnlyOld = true
            for k, v in pairs(grid_id_list) do
                if v ~= old_grid then
                    isOnlyOld = false
                    break
                end
            end

            if isOnlyOld then
                table.remove(grid_id_list, 1)
                return grid_id_list[1]
            end

            local random_index = math.random(1, #grid_id_list)
            local grid_id = grid_id_list[random_index]
            if old_grid == grid_id then
                return getRandom_grid(old_grid)
            end

            table.remove(grid_id_list, random_index)
            return grid_id
        end

        for layer, card_list in pairs(self.m_SceneCardList) do
            for _, card_item in pairs(card_list) do
                local grid_id = getRandom_grid(card_item:getData().grid_id)
                local cardConfig = threeSheep.ThreeSheepManager:getCardConfig(grid_id)
                if cardConfig then
                    card_item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(cardConfig:getIconPath())

                    card_item:getData().grid_id = grid_id
                end
            end
        end
    end)

    return true
end

--初始化所有卡牌位置
function initScenePosList(self)
    self.m_ScenePosList = {}
    for id, cardConfig in pairs(self.m_DupConfigVo.map_list) do
        table.insert(self.m_ScenePosList, {id = id, pos = {x = cardConfig.pos[1], y = cardConfig.pos[2]}, layer = cardConfig.layer, grid_id = cardConfig.grid_id, isOccupy = false})
    end
end

function creatSceneLayerItem(self)
    self:clearSceneLayerItem()

    local maxLayer = 0
    for _, card_pos in pairs(self.m_ScenePosList) do
        if card_pos.layer > maxLayer then
            maxLayer = card_pos.layer
        end
    end

    for i = 1, maxLayer do
        layer_trans = SimpleInsItem:create(self.mCardLayer, self.mCardSceneGroup, "ThreeSheepSceneUI_layerItem")
        layer_trans:getTrans():SetSiblingIndex(i - 1)
        layer_trans.m_go.name = i

        self.m_CardLayerList[i] = layer_trans
    end
end

function clearSceneLayerItem(self)
    if self.m_CardLayerList then
        for layer, v in pairs(self.m_CardLayerList) do
            v:poolRecover()
        end
    end
    self.m_CardLayerList = {}
end

function getLayerTrans(self, layer)
    local layer_trans = self.m_CardLayerList[layer]
    if not layer_trans then
        layer_trans = SimpleInsItem:create(self.mCardLayer, self.mCardSceneGroup, "ThreeSheepSceneUI_layerItem")
        layer_trans:getTrans():SetSiblingIndex(layer - 1)
        layer_trans.m_go.name = layer

        self.m_CardLayerList[layer] = layer_trans
    end
    return layer_trans:getTrans()
end

--创建所有卡牌
function createSceneCard(self)
    self:initScenePosList()
    self:creatSceneLayerItem()

    ---------------------------------创建卡牌
    if gs.Application.isEditor then
        threeSheep.ThreeSheepCardItem = require("game/threeSheep/view/item/ThreeSheepCardItem")
    end

    self:clearCard()

    ------------创建固定卡牌
    for _, card_pos in pairs(self.m_ScenePosList) do
        if card_pos.grid_id ~= 0 then
            if not self.m_SceneCardList[card_pos.layer] then
                self.m_SceneCardList[card_pos.layer] = {}
            end

            local item = threeSheep.ThreeSheepCardItem:create(self.mCardItem, self:getLayerTrans(card_pos.layer), "ThreeSheepSceneUI_cardItem")
            item:setData({id = card_pos.id, layer = card_pos.layer, grid_id = card_pos.grid_id, pos = card_pos.pos, click_call = self.onCardGoInBank, call_class = self})

            self.m_SceneCardList[card_pos.layer][card_pos.id] = item
            self.m_CardList[card_pos.id] = item

            table.remove(self.m_ScenePosList[card_pos.layer], index)
        end
    end

    -------------创建随机卡牌
    local layer_list = nil --需要随机的层
    local gridInfo_list = nil --需要随机的格子库
    local gridInfo = nil --需要生成的格子信息

    local create_num = nil --需要生成的格子数量

    local create_rule = table.copy(self.m_DupConfigVo.create_list)
    for _, rule in pairs(create_rule) do
        layer_list = rule[1]
        gridInfo_list = rule[2]

        for k, gridInfo in pairs(gridInfo_list) do
            if table.empty(layer_list) then
                break
            end

            local createCard_id = gridInfo[1]--需要生成的格子id
            create_num = gridInfo[2]

            for i = 1, create_num do
                local random_pos = self:getSceneCardRandomPos(layer_list) --随机出来的位置信息
                if random_pos ~= nil then
                    if not self.m_SceneCardList[random_pos.layer] then
                        self.m_SceneCardList[random_pos.layer] = {}
                    end

                    local item = threeSheep.ThreeSheepCardItem:create(self.mCardItem, self:getLayerTrans(random_pos.layer), "ThreeSheepSceneUI_cardItem")
                    item:setData({id = random_pos.id, layer = random_pos.layer, grid_id = createCard_id, pos = random_pos.pos, click_call = self.onCardGoInBank, call_class = self})

                    self.m_SceneCardList[random_pos.layer][random_pos.id] = item
                    self.m_CardList[random_pos.id] = item
                end
            end
        end
    end

    self:refreshCardMask()
end

function tweenPoolRecover(self, card_id)
    if self.m_CardList[card_id] then
        local item = self.m_CardList[card_id]
        local pos = item:getTrans().position
        self:addEffect("fx_threeSheep_show", self:getChildTrans("mTweenLayer"), pos.x, pos.y)

        self.m_CardList[card_id]:tweenPoolRecover()
        self.m_CardList[card_id] = nil

    else
        logAll(card_id, "回收失败--")
    end
end

function clearCard(self)
    if self.m_CardList then
        for _, card in pairs(self.m_CardList) do
            card:poolRecover()
        end
    end

    self.m_BankCardList = {} --仓库的卡牌
    self.m_CardList = {} --所有的卡牌
    self.m_SceneCardList = {} --场景中的卡牌
end

--刷新卡牌的遮挡效果
function refreshCardMask(self)
    for layer, card_list in pairs(self.m_SceneCardList) do
        for _, card in pairs(card_list) do
            local isMask = false
            local lastLayer = layer + 1
            for i = lastLayer, #self.m_SceneCardList do
                for _, lastCard in pairs(self.m_SceneCardList[i]) do
                    if card:checkCardMask(lastCard:getGo()) then
                        isMask = true
                        break
                    end
                end

                if isMask then
                    break
                end
            end

            card:refreshMask(isMask)
        end
    end
end

--获取卡牌随机位置
function getSceneCardRandomPos(self, layer_list)
    local list = {}
    for _, layer in pairs(layer_list) do
        for _, pos in pairs(self.m_ScenePosList) do
            if pos.isOccupy == false and layer == pos.layer then
                table.insert(list, pos)
            end
        end
    end
    -- end

    if table.empty(list) then
        return nil
    end

    local pos_index = math.random(1, #list)
    local random_pos = list[pos_index]
    random_pos.isOccupy = true

    return random_pos
end

--放入仓库代销栏
function onCardGoInBank(self, data, item)
    --先从场景中移除
    if self.m_SceneCardList[data.layer] ~= nil and self.m_SceneCardList[data.layer][data.id] ~= nil then
        self.m_SceneCardList[data.layer][data.id] = nil
        self:refreshCardMask()
    end

    local Revoke_parent = item:getTrans().parent

    --开始动画之前操作
    local selfRect = item:getTrans():GetComponent(ty.RectTransform)
    local revoke_anchoredPosition = selfRect.anchoredPosition

    local startTrans = self:getChildTrans("mTweenLayer")
    local endTrans = self.mBankGroup.transform
    item:addOnParent01(startTrans)

    local go = gs.GameObject.Instantiate(item:getGo(), startTrans)
    local go_rect = go:GetComponent(ty.RectTransform)
    go_rect.anchorMax = gs.Vector2(0, 1)
    go_rect.anchorMin = gs.Vector2(0, 1)
    go_rect.anchoredPosition = selfRect.anchoredPosition

    item:addOnParent(endTrans)
    ---强制刷新布局
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(endTrans)

    item:refreshInfo(false)

    item:addOnParent01(startTrans)
    local endAnchoredPosition = selfRect.anchoredPosition
    item:addOnParent(endTrans)

    ----------开始动画
    self.m_CanUseProps = false
    item:moveUIPos(go_rect, endAnchoredPosition, 0.3, function ()
        self.m_CanUseProps = true

        item:setScale(1, 1, 1)

        item:refreshInfo(true)
        item:refreshMask(false)

        gs.GameObject.Destroy(go)
        go = nil
        ------------------------------------------------------数据处理
        --判断是不是从仓库代销栏出来的
        local depot_index = nil --不为空，代表它是从仓库进来的
        if not table.empty(self.m_DepotItemList) then
            local remove_index, layer_index = nil, nil
            for lay_index, depot_data in pairs(self.m_DepotItemList) do
                for index, depot_item in pairs(depot_data.item_list) do
                    if depot_item:getData().id == item:getData().id then
                        remove_index = index
                        depot_index = index
                        break
                    end
                end

                if remove_index ~= nil then
                    layer_index = lay_index
                    break
                end
            end

            if remove_index then
                local click_lay = self.m_DepotItemList[layer_index].item_list
                click_lay[remove_index] = nil
                if table.empty(click_lay) then
                    self.m_DepotItemList[layer_index].depotItem:poolRecover()
                    self.m_DepotItemList[layer_index] = nil
                end

                local next_index = layer_index - 1
                if not table.empty(self.m_DepotItemList[next_index]) then
                    local last_lay = self.m_DepotItemList[next_index].item_list
                    if last_lay[remove_index] then
                        last_lay[remove_index]:refreshMask(false)
                    end
                end
            end
        end

        if not self.m_BankCardList[data.grid_id] then
            self.m_BankCardList[data.grid_id] = {}
        end

        table.insert(self.m_BankCardList[data.grid_id], data)

        --检测仓库卡牌是不是可以消除
        if table.nums(self.m_BankCardList[data.grid_id]) == 3 then
            for _, card_info in pairs(self.m_BankCardList[data.grid_id]) do
                self:tweenPoolRecover(card_info.id)

                --移除撤销列表缓存
                local remove_list = {}
                for index, revoke_card_info in pairs(self.m_RevokeCardList) do
                    if revoke_card_info.data.id == card_info.id then
                        table.insert(remove_list, index)
                    end
                end

                for _, remove_index in pairs(remove_list) do
                    table.remove(self.m_RevokeCardList, remove_index)
                end
            end

            --移除代销栏缓存
            self.m_BankCardList[data.grid_id] = nil

            self.m_RemoveNum = self.m_RemoveNum + 1

            AudioManager:playSoundEffect("arts/audio/UI/minigames/mng_yang_2.prefab")

        else
            --从仓库点进来的，仓库item再为空的时候会回收掉，所以 Revoke_parent 有可能为空
            table.insert(self.m_RevokeCardList, 1, {data = data, depot_index = depot_index, parent_trans = Revoke_parent, item = item, revoke_pos = revoke_anchoredPosition})--加入撤回缓存列表
        end

        local isOver = false
        if table.empty(self.m_CardList) then----检测是否全部消除成功
            isOver = true
        else
            local bankCardNum = 0
            for grid_id, grid_list in pairs(self.m_BankCardList) do
                bankCardNum = bankCardNum + table.nums(grid_list)
            end

            if bankCardNum >= self.m_DupConfigVo.slot then --仓库放满了
                isOver = true
            end
        end

        if isOver then
            self:settlemenGame()
        end
    end)
end

--创建道具
function createPropsItem(self)
    self.m_PropsNum = {} ---道具的剩余使用次数
    self.m_RevokeCardList = {} --上一个点击的卡牌的信息
    self.m_DepotItemList = {} --仓库数据
    self.m_CanUseProps = true

    self:clearProps()

    for i = 1, 3 do
        local item = SimpleInsItem:create(self.mBtnProps, self.mPropsGroup, "ThreeSheepSceneUI_propsItem")
        table.insert(self.m_PropsItemList, item)

        item:getGo():GetComponent(ty.AutoRefImage):SetImg(string.format("arts/ui/pack/threeSheep/threeSheep0%s.png", i))

        local props_config = self.m_DupConfigVo:getPropItemConfig(i)
        self.m_PropsNum[i] = props_config.num

        item.refreshText = function ()
            item:setText("mTextNum", props_config.lanId, nil, self.m_PropsNum[i], props_config.num)
        end

        item.refreshText()

        item:addUIEvent(nil, function ()
            if not self.m_CanUseProps then
                return
            end

            if self.m_PropsNum[i] <= 0 then
                gs.Message.Show(_TT(138605))
                return
            end

            local isCanUse = false
            if i == 1 then
                isCanUse = self:onClickRemove()
            elseif i == 2 then
                isCanUse = self:refreshCard()
            elseif i == 3 then
                isCanUse = self:onClickRevoke()
            end

            if isCanUse then
                self.m_PropsNum[i] = self.m_PropsNum[i] - 1
                item.refreshText()
            end
        end)
    end
end

function clearProps(self)
    if self.m_PropsItemList then
        for k, v in pairs(self.m_PropsItemList) do
            v:poolRecover()
        end
    end

    self.m_PropsItemList = {}
end

function createBankLine(self)
    self:clearBankLine()

    for i = 1, self.m_DupConfigVo.slot + 1 do
        local item = SimpleInsItem:create(self.mImgLine, self.mBanklineGroup, "ThreeSheepSceneUI_BankItem")
        self.m_BankLineList[i] = item
    end
end

function clearBankLine(self)
    if self.m_BankLineList then
        for _, item in pairs(self.m_BankLineList) do
            item:poolRecover()
        end
    end

    self.m_BankLineList = {}
end

--结算
function settlemenGame(self)
    local star = self:refreshStar()

    local cache_star = threeSheep.ThreeSheepManager:getDupPassStar(self.m_DupConfigVo.tid)
    if star > cache_star then
        GameDispatcher:dispatchEvent(EventName.ONREQ_THREESHEEP_PASS_DUP, {dup_id = self.m_DupConfigVo.tid, star = star})
    else
        GameDispatcher:dispatchEvent(EventName.THREESHEEP_OPEN_SETTLEMENTPANEL, {dupId = self.m_DupConfigVo.tid, first = false, star = star})
    end
end

--刷新当前的星星数量
function refreshStar(self)
    local star = 0
    for i = 1, #self.m_DupConfigVo.star_list do
        local starConfig = threeSheep.ThreeSheepManager:getStarConfigVo(self.m_DupConfigVo.star_list[i])
        if starConfig.point == 999 and table.empty(self.m_CardList) then
            star = starConfig.star
            break
        else
            if self.m_RemoveNum >= starConfig.point then
                star = starConfig.star
            end
        end
    end

    return star
end

-------------------暂停界面

-- 更新星级
function updateStarInfo(self)
    local starCount = self:refreshStar()

    local list = self.m_DupConfigVo.star_list
    self:clearStarItem()
    for i = 1, #list do
        local item = SimpleInsItem:create(self:getChildGO("GroupTaskItem"), self.mGroupStar, "ThreeSheepScenePanelStarItem")
        local starConfig = threeSheep.ThreeSheepManager:getStarConfigVo(list[i])

        local isMeet = starCount >= starConfig.star
        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end
        item:getChildGO("mImgStar"):SetActive(isMeet)
        item:setText("mTextDesc", nil, string.format("<color=#%s>%s</color>", color, _TT(starConfig.des)))

        table.insert(self.mStarItemList, item)
    end
end

function clearStarItem(self)
    if self.mStarItemList then
        for k, v in pairs(self.mStarItemList) do
            v:poolRecover()
        end
    end
    self.mStarItemList = {}
end

return _M

--[[
-----------------------------------------------------
@filename       : OrganizeBackpacksPanel
@Description    : 整理背包主界面
@date           : 2024-9-19 16:34:00
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module("organizeBackpacks.OrganizeBackpacksPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("organizeBackpacks/OrganizeBackpacksPanel.prefab")
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("整理箱包")
    self:setUICode(LinkCode.OrganizeBackpacks)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    --关卡信息
    self.mData = nil
    --游戏道具
    self.mItemList = {}
    --当前玩家选择的道具
    self.mSelectitem = nil
    --当前玩家选择的道具数据
    self.mSelectitemVo = nil
    --游戏内当前关卡信息
    self.mLevelInfoData = nil
    --所有背包箱体状态  用于打开与关闭左右下道具
    self.mALLBagState = {}
    --所有背包道具的状态 用于判定是否通关与放置逻辑判定
    self.mALLBagItemState = {}

    self.mEditor = true
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mItem = self:getChildGO("mItem")
    self.mClickOpenL = self:getChildGO("mClickOpenL")
    self.mClickOpenR = self:getChildGO("mClickOpenR")
    self.mClickOpenD = self:getChildGO("mClickOpenD")
    self.mGroupItem = self:getChildTrans("mGroupItem")
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgLeft = self:getChildGO("mImgLeft"):GetComponent(ty.AutoRefImage)
    self.mImgDwon = self:getChildGO("mImgDwon"):GetComponent(ty.AutoRefImage)
    self.mImgRight = self:getChildGO("mImgRight"):GetComponent(ty.AutoRefImage)
    self.mImgMiddle = self:getChildGO("mImgMiddle"):GetComponent(ty.AutoRefImage)

    self.mEmptyClick = self:getChildGO("mEmptyClick")
end
-- 激活
function active(self, args)
    super.active(self, args)
    self.mData = organizeBackpacks.OrganizeBackpacksManager:getStageVoById(args)
    self.mLevelInfoData = organizeBackpacks.OrganizeBackpacksManager:getLevelInfoByID(self.mData.id)
    MoneyManager:setMoneyTidList({})

    self:updateView()

    if self.mEditor then
        self:refresEditorTile()
    end

    self.mEmptyClick:SetActive(false)
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self.mSelectitem = nil
    self.mSelectitemVo = nil
    self.mALLBagState = {}

    self:clearEditorTile()

    self:onClearAllHandler()

    MoneyManager:setMoneyTidList()
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mClickOpenL, self.onClickhandler, nil, organizeBackpacks.BagType.Left)
    self:addUIEvent(self.mClickOpenR, self.onClickhandler, nil, organizeBackpacks.BagType.Right)
    self:addUIEvent(self.mClickOpenD, self.onClickhandler, nil, organizeBackpacks.BagType.Down)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ORGANIZE_BACKPACKS_GAME_DUP_VIEW)
end

function refresEditorTile(self)
    local tileImg = self:getChildGO("mEditorTile")
    for type, bagVo in pairs(self.mLevelInfoData:getLevelBagDic()) do
        local levleBagVo = organizeBackpacks.OrganizeBackpacksManager:getLevelItemInfoByID(bagVo.itemName)
        for name, postDic in pairs(levleBagVo:getAllPosDic()) do
            for i, pos in ipairs(postDic) do
                local tileItem = SimpleInsItem:create(tileImg, self:getBagNodeByType(type).transform, "OrganizeBackpacksPanel_editor_tile")
                tileItem:setPos(pos[1] * 17, -pos[2] * 17)
                tileItem:getGo():GetComponent(ty.Image).color = gs.ColorUtil.GetColor("FFFFFFFF")

                table.insert(self.m_EditorTileList, tileItem)
            end
        end
    end
end

function clearEditorTile(self)
    if self.m_EditorTileList then
        for _, tileItem in pairs(self.m_EditorTileList) do
            tileItem:recover()
        end
    end
    self.m_EditorTileList = {}
end

function updateView(self)
    if not self.mLevelInfoData then
        return
    end
    for _, type in pairs(organizeBackpacks.BagType) do
        if type == organizeBackpacks.BagType.Center then
            self.mALLBagState[type] = true
        else
            self.mALLBagState[type] = false
        end
    end
    self:updateBagState()
    self:onClearAllHandler()
    self.mImgBg:SetImg(UrlManager:getBgPath("organizeBackpacks/organizeBackpacks_bg_0"..self.mData:getType() .. ".jpg"), true)
    for k, itemData in pairs(self.mLevelInfoData:getLevelItemDic()) do
        local item = SimpleInsItem:create(self.mItem, self.mGroupItem, itemData.itemName)
        table.insert(self.mItemList, item)

        item:setPos(itemData.initPos[1], itemData.initPos[2] * -1)
        item:getGo().name = itemData.itemName .. k
        item:setArgs(itemData.itemName)
        self.mALLBagItemState[item:getGo().name] = {type = nil, index = nil, postList = {}}
        local imgComp = item:getGo():GetComponent(ty.AutoRefImage)
        imgComp:SetImg(UrlManager:getPackPath("organizeBackpacks/"..itemData.itemName..".png"), true)
        imgComp.alphaHitTestMinimumThreshold = 0.5

        local event = item:getGo():GetComponent(ty.LongPressOrClickEventTrigger)

        local function onLongClick()
            local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(gs.Vector3(event.EventData.position.x, event.EventData.position.y, 0))
            local localPos = self.mGroupItem.transform:InverseTransformPoint(mouseWorldPos)

            local anch_pos = gs.Vector2(localPos.x, localPos.y) + self.m_click_diff_pos
            gs.TransQuick:UIPos(self.mSelectitem:GetComponent(ty.RectTransform), anch_pos.x, anch_pos.y)
        end

        local function up()
            self:onCheckSelectItemHandler()
            self:onCheckResultHandler()
        end

        local function on()
            self.mSelectitem = item:getGo()
            self.mSelectitemVo = item:getArgs()
            self.mSelectitem.transform:SetAsLastSibling()
            gs.TransQuick:Scale0(self.mSelectitem.transform, 1.2)

            local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(gs.Vector3(event.EventData.position.x, event.EventData.position.y, 0))
            local localPos = self.mGroupItem.transform:InverseTransformPoint(mouseWorldPos)
            if self.m_click_diff_pos == nil then
                local rect = self.mSelectitem:GetComponent(ty.RectTransform)
                local anchoredPosition = rect.anchoredPosition
                self.m_click_diff_pos = anchoredPosition - gs.Vector2(localPos.x, localPos.y)

                self.m_selectInitPos = rect.anchoredPosition
            end

            local anch_pos = gs.Vector2(localPos.x, localPos.y) + self.m_click_diff_pos
            gs.TransQuick:UIPos(self.mSelectitem:GetComponent(ty.RectTransform), anch_pos.x, anch_pos.y)
        end

        event.onDrag:AddListener(onLongClick)
        event.onPointerUp:AddListener(up)
        event.onPointerDown:AddListener(on)

        if self.mEditor then
            local levleBagVo = organizeBackpacks.OrganizeBackpacksManager:getLevelItemInfoByID(itemData.itemName)
            if levleBagVo then
                local tileImg = self:getChildGO("mEditorTile")

                if not self.m_EditorTileList then
                    self.m_EditorTileList = {}
                end

                for name, postDic in pairs(levleBagVo:getAllPosDic()) do
                    for i, pos in ipairs(postDic) do
                        local tileItem = SimpleInsItem:create(tileImg, item:getTrans(), "OrganizeBackpacksPanel_editor_tile")
                        tileItem:setPos(pos[1] * 17, -pos[2] * 17)
                        tileItem:getGo():GetComponent(ty.Image).color = gs.ColorUtil.GetColor("2d3646FF")

                        table.insert(self.m_EditorTileList, tileItem)
                    end
                end
            end
        end
    end
end

function updateBagState(self)
    for type, bagVo in pairs(self.mLevelInfoData:getLevelBagDic()) do
        if type == organizeBackpacks.BagType.Left then
            self.mImgLeft.gameObject:SetActive(type == organizeBackpacks.BagType.Left)
            self.mImgLeft:SetImg(UrlManager:getBgPath("organizeBackpacks/"..bagVo.itemName..".png"), true)
            gs.TransQuick:UIPos(self.mImgLeft.gameObject.transform, bagVo.InitOffsetPos[1], bagVo.InitOffsetPos[2])
        elseif type == organizeBackpacks.BagType.Right then
            self.mImgRight.gameObject:SetActive(type == organizeBackpacks.BagType.Right)
            self.mImgRight:SetImg(UrlManager:getBgPath("organizeBackpacks/"..bagVo.itemName..".png"), true)
            gs.TransQuick:UIPos(self.mImgRight.gameObject.transform, bagVo.InitOffsetPos[1], bagVo.InitOffsetPos[2])
        elseif type == organizeBackpacks.BagType.Down then
            self.mImgDwon.gameObject:SetActive(type == organizeBackpacks.BagType.Down)
            self.mImgDwon:SetImg(UrlManager:getBgPath("organizeBackpacks/"..bagVo.itemName..".png"), true)
            gs.TransQuick:UIPos(self.mImgDwon.gameObject.transform, bagVo.InitOffsetPos[1], bagVo.InitOffsetPos[2])
        elseif type == organizeBackpacks.BagType.Center then
            self.mImgMiddle.gameObject:SetActive(type == organizeBackpacks.BagType.Center)
            self.mImgMiddle:SetImg(UrlManager:getBgPath("organizeBackpacks/"..bagVo.itemName..".png"), true)
            gs.TransQuick:UIPos(self.mImgDwon.gameObject.transform, bagVo.InitOffsetPos[1], bagVo.InitOffsetPos[2])
        end
    end
end

function onClickhandler(self, type)
    local typeVo = self.mLevelInfoData:getLevelBagDic()[type]
    if typeVo then
        local isOpen = self.mALLBagState[type]
        local trans = self:getBagNodeByType(type).gameObject.transform
        if trans then
            local posX = (not isOpen) and typeVo.endOffsetPos[1] or typeVo.InitOffsetPos[1]
            local posY = (not isOpen) and typeVo.endOffsetPos[2] or typeVo.InitOffsetPos[2]
            gs.TransQuick:UIPos(trans, posX, posY)
            self.mALLBagState[type] = not isOpen
        end
    end
end

function onCheckResultHandler(self)
    for k, v in pairs(self.mALLBagItemState) do
        if not v.type then
            logAll(k)
            return
        end
    end
    GameDispatcher:dispatchEvent(EventName.PASS_CUR_LEVEL, self.mData.id)
end

--手指松开时检查是否符合当前位置条件进行放置
function onCheckSelectItemHandler(self)
    if self.mSelectitem then
        gs.TransQuick:Scale0(self.mSelectitem.transform, 1)
        local itemData = organizeBackpacks.OrganizeBackpacksManager:getLevelItemInfoByID(self.mSelectitemVo)
        local itemAllPos = itemData:getAllPosDic()
        if not table.empty(itemAllPos) then
            local levelBagDic = self.mLevelInfoData:getLevelBagDic()

            local firstGird = nil
            for name, itemPosList in pairs(itemAllPos) do
                firstGird = itemPosList[1]
                break
            end

            if firstGird then
                local isBreak = false
                for type, _ in pairs(levelBagDic) do
                    local levelBagVo = organizeBackpacks.OrganizeBackpacksManager:getLevelItemInfoByID(levelBagDic[type].itemName)
                    local bgAllPos = levelBagVo:getAllPosDic()

                    if self.mALLBagState[type] then
                        if self:checkPosIsInTarget(type, endPos) then
                            local leftTopgrid = self:getSelectItemLeftTopPointOnBgGrid(type)
                            local firtOnBgGrid_x = leftTopgrid[1] + firstGird[1]
                            local firtOnBgGrid_y = leftTopgrid[2] + firstGird[2]

                            for name, postDic in pairs(bgAllPos) do
                                for i, pos in ipairs(postDic) do
                                    if pos[1] == firtOnBgGrid_x and pos[2] == firtOnBgGrid_y then
                                        local isCan, poslist = self:checkIsCanIn(leftTopgrid, itemAllPos, postDic)
                                        if isCan then
                                            self.mALLBagItemState[self.mSelectitem.name] = {type = type, index = name, postList = poslist}
                                            isBreak = true
                                            break
                                        else
                                            if not self.mALLBagItemState[self.mSelectitem.name].type then
                                                self.mALLBagItemState[self.mSelectitem.name] = {type = nil, index = nil, postList = {}}
                                            end

                                            gs.TransQuick:UIPos(self.mSelectitem:GetComponent(ty.RectTransform), self.m_selectInitPos.x, self.m_selectInitPos.y)
                                            self.m_selectInitPos = nil
                                        end
                                    end
                                end

                                if isBreak then
                                    break
                                end
                            end
                        end
                    end

                    if isBreak then
                        break
                    end
                end
            end

        end
        self.mSelectitem = nil
        self.mSelectitemVo = nil
        self.m_click_diff_pos = nil
    end
end

function checkIsCanIn(self, leftTopgrid, curList, targetList)
    local list = {}
    for name, namePosList in pairs(curList) do
        for _, pos in ipairs(namePosList) do
            local isOK = false
            local tempPosX = pos[1] + leftTopgrid[1]
            local tempPosY = pos[2] + leftTopgrid[2]
            for i, pos in ipairs(targetList) do
                if pos[1] == tempPosX and pos[2] == tempPosY then
                    isOK = true
                    table.insert(list, {tempPosX, tempPosY})
                    break
                end
            end
            if not isOK then
                return false, list
            end
        end
    end
    return true, list
end

--获取背景背包道具
function getBagNodeByType(self, type)
    if type == organizeBackpacks.BagType.Left then
        return self.mImgLeft
    elseif type == organizeBackpacks.BagType.Right then
        return self.mImgRight
    elseif type == organizeBackpacks.BagType.Down then
        return self.mImgDwon
    elseif type == organizeBackpacks.BagType.Center then
        return self.mImgMiddle
    end
end

--计算当前拖拽道具左上角在背包哪个格子
function getSelectItemLeftTopPointOnBgGrid(self, type)
    if not self.mSelectitem then
        return
    end

    local tileImg = self:getChildGO("mEditorTile")
    local rectTrans = tileImg:GetComponent(ty.RectTransform)
    rectTrans.parent = self.mSelectitem.transform

    rectTrans.anchoredPosition = gs.VEC2_ZERO

    local targetItem = self:getBagNodeByType(type)
    rectTrans.parent = targetItem.transform

    local anchoredPosition = rectTrans.anchoredPosition

    local grid_x = math.abs(math.floor(anchoredPosition.x / 17))
    local grid_y = math.abs(math.floor(anchoredPosition.y / 17))

    return {grid_x, grid_y}
end

--检测是否超出当前背包区域
function checkPosIsInTarget(self, type)
    local targetItem = self:getBagNodeByType(type)

    local localPos = targetItem.transform:InverseTransformPoint(self.mSelectitem.transform.position)

    local targetY = targetItem.transform.rect.height / 2
    local targetX = targetItem.transform.rect.width / 2

    local topPos = localPos.y + self.mSelectitem.transform.rect.height / 2
    local downPos = localPos.y - self.mSelectitem.transform.rect.height / 2
    local rightPos = localPos.x + self.mSelectitem.transform.rect.width / 2
    local LeftPos = localPos.x - self.mSelectitem.transform.rect.width / 2

    if topPos <= targetY and downPos >= -targetY and rightPos <= targetX and LeftPos >= -targetX then
        return true
    end
    return false
end

function onClearAllHandler(self)
    if #self.mItemList > 0 then
        for _, item in ipairs(self.mItemList) do
            local event = item:getGo():GetComponent(ty.LongPressOrClickEventTrigger)
            event.onDrag:RemoveAllListeners()
            event.onPointerUp:RemoveAllListeners()
            event.onPointerDown:RemoveAllListeners()
            item:poolRecover()
        end
        self.mItemList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

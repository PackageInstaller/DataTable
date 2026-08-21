-- @FileName:   BlockGridItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("game.block.view.BlockGridItem", Class.impl(SimpleInsItem))

-- 设置data
function setData(self, configVo, id, dragClass, drag, drayEnd)
    self.m_id = id
    self.m_configVo = configVo

    self.m_dragClass = dragClass
    self.m_dragCall = drag
    self.m_drayEndCall = drayEnd

    self:configUI()
    self:onAddPointerEvent()

    self.m_go.name = self.m_configVo.id

    local Color_list =
    {
        "CDDEDDFF",
        "EF7BF9FF",
        "63C56CFF",
        "F97B85FF",
        "D9D173FF",
        "F09F66FF",
        "7786D6FF",
    }

    self.m_iconColor = Color_list[math.random(1, #Color_list)]

    self:createGrid()
    self:showIcon(true)
end

function setData2(self, configVo, color, size_x, size_y, height)
    self.m_configVo = configVo
    self.m_iconColor = color

    self:configUI()

    self:createIcon(size_x, size_y, height)
end

function recover(self)
    super.recover(self)

    self:onRemovePointerEvent()

    if self.m_iconList then
        for r, colDic in pairs(self.m_iconList) do
            for c, v in pairs(colDic) do
                v:poolRecover()
            end
        end
    end

    self.m_iconList = nil
end

function configUI(self)
    self.mLongPressComponent = self:getGo():GetComponent(ty.LongPressOrClickEventTrigger)

    self.mRect = self:getGo():GetComponent(ty.RectTransform)
    self.mImgIcon = self:getChildGO("mImgIcon")
    self.mIconGroup = self:getChildTrans("mIconGroup")

    self.mIconRect = self.mImgIcon:GetComponent(ty.RectTransform)
    self.m_initSize = {width = self.mIconRect.rect.width, height = self.mIconRect.rect.height}
end

function getDataConfigVo(self)
    return self.m_configVo
end

function getColor(self)
    return self.m_iconColor
end

function setAnchors(self, anchorMin, anchorMax)
    self.mRect.anchorMin = anchorMin
    self.mRect.anchorMax = anchorMax
end

function setAnchoredPosition(self, anchoredPosition)
    self.mRect.anchoredPosition = anchoredPosition
end

function getAnchoredPosition(self)
    return self.mRect.anchoredPosition
end

function createGrid(self)
    local width, height = self.m_initSize.width, self.m_initSize.height
    local size_x, size_y = width + 1, height + 2

    self:createIcon(size_x, size_y, height)
end

function createIcon(self, size_x, size_y, height)
    local interval_x, interval_y = size_x / 2, size_y * (3 / 4)
    local pos_x, pos_y = 0, 0

    self.m_iconList = {}
    for _, pos in pairs(self.m_configVo.shape_list) do
        local item = SimpleInsItem:create(self.mImgIcon, self.mIconGroup, "BlockGridItem_Icon")
        item:getGo():GetComponent(ty.Image).color = gs.ColorUtil.GetColor(self.m_iconColor)

        pos_y = pos[2] * interval_y
        if pos[2] % 2 == 0 then
            if pos[1] ~= 0 then
                pos_x = pos[1] * size_x
            else
                pos_x = 0
            end
        else
            if pos[1] > 0 then
                pos_x = pos[1] * size_x - interval_x
            elseif pos[1] < 0 then
                pos_x = pos[1] * size_x + interval_x
            else
                pos_x = 0
            end
        end
        item:setPos(pos_x, pos_y)
        item.m_go.name = pos[1] .. "_" .. pos[2]

        if self.m_iconList[pos[2]] == nil then
            self.m_iconList[pos[2]] = {}
        end
        self.m_iconList[pos[2]][pos[1]] = item
    end

    self.mRect:SetSizeWithCurrentAnchors(gs.RectTransform.Axis.Vertical, 168.3)
end

function getAllIcon(self)
    return self.m_iconList
end

-- 增加长按事件
function onAddPointerEvent(self)
    local function _onPointerUpHandler()
        self:onPointerUp()
    end
    self.mLongPressComponent.onPointerUp:AddListener(_onPointerUpHandler)

    local function _onDragHandler()
        self:onDragHandler()
    end
    self.mLongPressComponent.onDrag:AddListener(_onDragHandler)
end

-- 移除长按事件
function onRemovePointerEvent(self)
    self.mLongPressComponent.onPointerUp:RemoveAllListeners()
    self.mLongPressComponent.onDrag:RemoveAllListeners()
end

function onPointerUp(self)
    if self.m_drayEndCall then
        self.m_drayEndCall(self.m_dragClass, self)
    end
end

function onDragHandler(self)
    if self.m_dragCall then
        self.m_dragCall(self.m_dragClass, self)
    end
end

function showIcon(self, active)
    self.mIconGroup.gameObject:SetActive(active)
end

return _M

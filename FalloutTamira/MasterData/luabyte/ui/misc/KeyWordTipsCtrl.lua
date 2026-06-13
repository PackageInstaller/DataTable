--用于关键字弹窗
local M = BaseClass("KeyWordTipsCtrl")
local uiWidth = 0
local uiHeight = 400 --UI框的高度为400
local halfScreenWidth = 0
local halfScreenHeight = 0

local PIVOT = { UP_CENTER = 1, LEFT_CENTER = 2, DOWN_CENTER = 3, RIGHT_CENTER = 4 }
local checkOrders = { PIVOT.DOWN_CENTER, PIVOT.UP_CENTER, PIVOT.LEFT_CENTER, PIVOT.RIGHT_CENTER }

function M:__init(view)
    view.clickArea:onClick(Bind(self, self.Close))
end

function M:Show(title, content, centerX, centerY)
    self.view:SetActive(true)
    self.view.txt_title:SetText(title)
    self.view.txt_content:SetText(content)
    self.view.txt_content:SetActive(true)
    local canvas = self.view.transform:GetCanvas(true)
    local windSize = self.view.container.sizeDelta
    local sizeData = canvas:rectTransform().rect
    halfScreenWidth = sizeData.width * 0.5
    halfScreenHeight = sizeData.height * 0.5
    uiWidth = windSize.x
    uiHeight = windSize.y
    centerX = centerX or 0
    centerY = centerY or 0
    local pos = self.view.transform:InverseTransformPoint(Vector3(centerX, centerY, 0))
    centerX = pos.x
    centerY = pos.y
    self:_CheckPos(centerX, centerY)
end

function M:Close()
    self.view:SetActive(false)
end

function M:GetActive()
    return self.view:GetActive()
end

function M:Transform()
    return self.view.transform
end

--check位置
function M:_CheckPos(centerX, centerY)
    for _, pivot in ipairs(checkOrders) do
        local tmpPivot, offsetX = self:_Check(centerX, centerY, pivot)
        if tmpPivot then
            self:_SetPos(pivot, centerX + offsetX, centerY)
            break
        end
    end
end

function M:_SetPos(pivot, centerX, centerY, finalPivotX)
    local containerTrans = self.view.container
    local pivotV = Vector2()
    if pivot == PIVOT.UP_CENTER then
        pivotV:Set(finalPivotX and finalPivotX or 0.5, 1)
    elseif pivot == PIVOT.LEFT_CENTER then
        pivotV:Set(finalPivotX and finalPivotX or 0, 0.5)
    elseif pivot == PIVOT.DOWN_CENTER then
        pivotV:Set(finalPivotX and finalPivotX or 0.5, 0)
    elseif pivot == PIVOT.RIGHT_CENTER then
        pivotV:Set(finalPivotX and finalPivotX or 1, 0.5)
    end
    containerTrans.pivot = pivotV
    containerTrans:SetLocalPos(centerX, centerY, 0)
end

--高是否合法
function M:_Check(x, y, pivot)
    local offsetX, halfWidth = 0, uiWidth * 0.5
    if pivot == PIVOT.UP_CENTER then               --pivot (0.5,1)
        if (x - halfWidth) < -halfScreenWidth then --check 左边
            offsetX = -halfScreenWidth - (x - halfWidth)
        end
        if (x + halfWidth) > halfScreenWidth then --check 右边
            offsetX = halfScreenWidth - (x + halfWidth)
        end
        return (y - uiHeight) >= -halfScreenHeight, offsetX
    elseif pivot == PIVOT.DOWN_CENTER then         --pivot (0.5,0)
        if (x - halfWidth) < -halfScreenWidth then --check 左边
            offsetX = -halfScreenWidth - (x - halfWidth)
        end
        if (x + halfWidth) > halfScreenWidth then --check 右边
            offsetX = halfScreenWidth - (x + halfWidth)
        end
        return (y + uiHeight) < halfScreenHeight, offsetX
    elseif pivot == PIVOT.LEFT_CENTER then          --pivot (0,0.5)
        local halfHeight = uiHeight * 0.5
        if (y + halfHeight) > halfScreenHeight then --check 上边
            offsetX = halfScreenHeight - (y + halfHeight)
        end
        if (y - halfHeight) < -halfScreenHeight then --check 下边
            offsetX = -halfScreenHeight - (y - halfHeight)
        end
        return (x + uiWidth) < halfScreenWidth, offsetX
    elseif pivot == PIVOT.RIGHT_CENTER then         --pivot (1,0.5)
        local halfHeight = uiHeight * 0.5
        if (y + halfHeight) > halfScreenHeight then --check 上边
            offsetX = halfScreenHeight - (y + halfHeight)
        end
        if (y - halfHeight) < -halfScreenHeight then --check 下边
            offsetX = -halfScreenHeight - (y - halfHeight)
        end
        return (x - uiWidth) > -halfScreenWidth, offsetX
    end
    return false
end

function M:OnDispose()
    if self.view then
        self.view:OnDispose()
        self.view = nil
    end
end

return M

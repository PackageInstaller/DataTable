local EmojiText = BaseClass("GameUIText", GameUIText)
local M = EmojiText

function M:SetOnClick(onClick)
    self.unity_uitext.onHrefClick = onClick
end

function M:GetTextWidth(content)
    return self.unity_uitext:GetTextWidth(content)
end

function M:SetDoText(content, duration, ease)
    if not ease then
        ease = 1
    end
    return self.unity_uitext:SetDoText(content, duration, ease)
end

function M:GetTextAnchoredPosition()
    return self.unity_uitext:GetTextAnchoredPosition()
end

function M:GetTextSize()
    return self.unity_uitext:GetTextSize()
end

function M:GetRectSizeDelta()
    return self.unity_uitext:GetRectSizeDelta()
end

function M:OnDestroy()
    self.unity_uitext.onHrefClick = nil
    M.super.OnDestroy(self)
end

function M:ShowHrefWordTips(hrefName, worldPos, alignDir, tipsPivot)
    if string.isNullOrEmpty(hrefName) then return end
    local arr = string.split(hrefName, "|", 1)
    if not arr or #arr < 2 then return end

    local size = self:GetTextSize()
    local canvas = self.transform:GetCanvas(true)
    UIContextMgr:GetInstance():Show(UIDefine.UIComTips, {
        worldPos = worldPos,
        title = tonumber(arr[1]),
        content = tonumber(arr[2]),
        canvasTrans = canvas.transform,
        alignDir = alignDir or Vector2.New(-0.5, 0),
        tipsPivot = tipsPivot or Vector2.New(1, 0.5),
        rectSize = Vector2.New(size.x + 20, size.y + 20),
    })
end

return EmojiText

module("TabData", Class.impl())

function ctor(self)
    -- 按钮宽度
    self.width = 0
    -- 按钮高度
    self.height = 0
    -- 按钮文字
    self.content = ""
    -- 未选中按钮资源
    self.normalSource = ""
    -- 选中按钮资源
    self.selectSource = ""
    -- 按钮上的字大小
    self.fontSize = 24
    -- 按钮文字是否加粗
    self.bold = false
    -- 按钮对应类型
    self.type = nil

    -- 按钮文字的普通颜色
    self.fontNormalColor = nil
    -- 按钮文字的选中颜色
    self.fontSelectColor = nil
    -- 按钮文字通用的偏移量（左下右上）
    self.fontOffsetNomal = nil
    -- 按钮文字选中的偏移量（左下右上）
    self.fontOffsetSelect = nil
    -- 按钮文字的行间距（竖状有效）
    self.fontLineSpace = 1
    -- 按钮文字的内对其方式
    self.textAlignment = gs.TextAnchor.UpperLeft

    -- 未选中的左侧图标
    self.nomalIcon = nil
    -- 选中的左侧图标
    self.selectIcon = nil
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:__reset()
    LuaPoolMgr:poolRecover(self)
end

function setData(self, cusWidth, cusHeight, cusContent, cusNormalSource, cusSelectSource, cusFontSize, cusIsBold, cusType, fontNormalColor, fontSelectColor, fontOffsetNomal, fontOffsetSelect, fontLineSpace, customSource, cusTextAlignment, nomalIcon, selectIcon)
    self.width = cusWidth
    self.height = cusHeight
    self.content = cusContent
    self.normalSource = customSource and cusNormalSource or UrlManager:getCommonNewPath(cusNormalSource)
    self.selectSource = customSource and cusSelectSource or UrlManager:getCommonNewPath(cusSelectSource)
    self.fontSize = cusFontSize
    self.bold = cusIsBold
    self.type = cusType
    self.fontNormalColor = fontNormalColor
    self.fontSelectColor = fontSelectColor
    self.fontOffsetNomal = fontOffsetNomal
    self.fontOffsetSelect = fontOffsetSelect
    self.fontLineSpace = fontLineSpace
    self.textAlignment = cusTextAlignment
    self.nomalIcon = nomalIcon and UrlManager:getTabIcon(nomalIcon) or nil
    self.selectIcon = nomalIcon and UrlManager:getTabIcon(selectIcon) or nil
    return self
end

function __reset(self)
    self.width = 0
    self.height = 0
    self.content = ""
    self.normalSource = ""
    self.selectSource = ""
    self.fontSize = 0
    self.bold = false
    self.type = nil
    self.fontNormalColor = nil
    self.fontSelectColor = nil
    self.fontOffsetNomal = nil
    self.fontOffsetSelect = nil
    self.fontLineSpace = 1
    self.nomalIcon = nil
    self.selectIcon = nil
end

return _M
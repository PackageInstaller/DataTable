module('HtmlUtil', Class.impl())

m_defaultColor = ColorUtil.WHITE_NUM

function ctor(self)
end

-- 设置颜色
function color(self, str, color)
	if(color == nil) then
		color = self.m_defaultColor
	end
	return "<color=#" .. color .. ">" .. str .. "</color>"
end

-- 设置大小
function size(self, str, size)
	return "<size=" .. size .. ">" .. str .. "</size>"
end

-- 设置颜色和大小
function colorAndSize(self, str, color, size)
	return "<size=" .. size .. ">" .. self:color(str, color) .. "</size>"
end

-- 设置斜体
function itial(self, str)
	return "<i>" .. str .. "</i>"
end

-- 设置加粗
function bold(self, str)
	return "<b>" .. str .. "</b>"
end

return _M

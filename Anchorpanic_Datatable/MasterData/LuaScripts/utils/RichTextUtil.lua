module('RichTextUtil', Class.impl())

-- 默认显示的表情大小
m_defaultEmojiSize = 100
m_defaultColor = ColorUtil.WHITE_NUM
m_startSign = "<"
m_endSign = ">"
m_splitSign = "|"
m_paramSign = "&"
m_paramFormatSign = "%"

-- 使富文本重新生产正则表达式
gs.RichTextManager.StartSign = m_startSign
gs.RichTextManager.EndSign = m_endSign
gs.RichTextManager.SplitSign = "\\" .. m_splitSign
gs.RichTextManager.RegexTag = ""

function ctor(self)
end

-- 设置颜色
function color(self, str, color)
	if(color == nil) then
		color = self.m_defaultColor
	end
	color = string.lower(color)
	return HtmlUtil:color(str, string.sub(color, 1, 6))
end

-- 设置大小
function size(self, str, size)
	return HtmlUtil:size(str, size)
end

-- 设置斜体
function itial(self, str)
	return HtmlUtil:itial(str, size)
end

-- 设置加粗
function bold(self, str)
	return HtmlUtil:bold(str, size)
end

-- 强制设置下划线（只设置下划线颜色，str为纯文本或者表情，不支持自定义加载）
function underline(self, str, color)
	if(color == nil) then
		color = self.m_defaultColor
	end
	color = string.lower(color)
	return "<material=UnderLine" .. self.m_splitSign .. "#" .. string.sub(color, 1, 6) .. ">" .. str .. "</material>"
end

-- 设置超链接（同时设置下划线和文本颜色，str只为纯文本）
function href(self, str, color, linkName, paramsTable)
	if(color == nil) then
		color = self.m_defaultColor
	end
	color = string.lower(color)
	if(linkName == nil) then
		-- 不附带链接
		linkName = " "
	else
		linkName = linkName .. self:createParamStr(paramsTable)
	end
	return self.m_startSign .. "0x01" .. self.m_splitSign .. "#"  .. string.sub(color, 1, 6) .. self.m_splitSign .. linkName .. "=" .. str .. self.m_endSign
end

-- 设置表情（sourceIndex为图片序号，支持点击）
function emote(self, sourceIndex, size, linkName, paramsTable)
	if(linkName == nil) then
		-- 不附带链接
		linkName = ""
	else
		linkName = self.m_splitSign .. linkName .. self:createParamStr(paramsTable)
	end
	if(size == nil) then
		-- 默认字体宽
		size = ""
	else
		size = self.m_splitSign .. size
	end
	return self.m_startSign .. sourceIndex .. size .. linkName .. self.m_endSign
end

-- 设置表情（新建一个Text节点显示，sourceIndex为图片序号，支持点击）
function textEmote(self, sourceIndex, size, linkName, paramsTable)
	if(linkName == nil) then
		-- 不附带链接
		linkName = " "
	else
		linkName = linkName .. self:createParamStr(paramsTable)
	end
	if(size == nil) then
		-- 默认字体宽
		size = ""
	else
		size = self.m_splitSign .. size
	end
	return self.m_startSign .. "0x04" .. size .. self.m_splitSign .. linkName .. "=" .. sourceIndex .. self.m_endSign
end

-- 设置自定义图片（sourceName包括后缀，支持点击）
function customImage(self, sourceName, width, height, linkName, paramsTable)
	if(linkName == nil) then
		-- 不附带链接
		linkName = " "
	else
		linkName = linkName .. self:createParamStr(paramsTable)
	end
	if(width == nil) then
		-- 默认字体宽
		width = ""
	end
	if(height == nil) then
		-- 默认字体高
		height = ""
	end
	return self.m_startSign .. "0x02" .. self.m_splitSign .. height .. self.m_splitSign .. width .. self.m_splitSign .. linkName .. "=" .. sourceName .. self.m_endSign
end

-- 设置自定义GameObject（sourceName包括后缀，暂不支持点击）
function customGameObject(self, sourceName, width, height)
	local linkName = " "
	if(width == nil) then
		-- 默认字体宽
		width = ""
	end
	if(height == nil) then
		-- 默认字体高
		height = ""
	end
	return self.m_startSign .. "0x03" .. self.m_splitSign .. height .. self.m_splitSign .. width .. self.m_splitSign .. linkName .. "=" .. sourceName .. self.m_endSign
end

-- 获取参数字符串（paramsTable为key-value的表）
function createParamStr(self, paramsTable)
	local str = ""
	if(paramsTable ~= nil) then
		for key, value in pairs(paramsTable) do
			local keyType = type(key)
			local valueType = type(value)
			if((keyType == "number" or keyType == "string") and (valueType == "number" or valueType == "string")) then
				str = str .. self.m_paramSign .. tostring(key) .. self.m_paramFormatSign .. tostring(value)
			end
		end
	end
	return str
end

-- 获取参数字符串（paramsTable为key-value的表）
function praseParamStr(self, linkStr)
	local linkName = ""
	local paramsTable = {}
	local arr = string.split(linkStr, self.m_paramSign)
	for key, value in pairs(arr) do
		if(key == 1) then
			linkName = value
		else
			local tempArr = string.split(value, self.m_paramFormatSign)
			paramsTable[tempArr[1]] = tempArr[2]
		end
	end
	return linkName, paramsTable
end

function registerCallBack(self, richTextComponent)
	richTextComponent:SetEventCall(notice.HrefUtil, notice.HrefUtil.__hrefEventCall)
end

return _M

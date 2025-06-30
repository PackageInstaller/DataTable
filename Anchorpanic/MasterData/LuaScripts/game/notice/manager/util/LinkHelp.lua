module("notice.LinkHelp", Class.impl())

--  获取解析后的内容
function getPraseContent(self, content, noticeParamList)
	return self:buildRichText(content, noticeParamList)
end

function buildRichText(self, content, noticeParamList)
	local valueList = {}
	local type
	local tempContent
	local propsList
	
	local len = #noticeParamList
	for i = 1, len do
		local noticeParamVo = noticeParamList[i]
		type = noticeParamVo.type
		tempContent = noticeParamVo.value
		propsList = noticeParamVo.propsList
		
		if(type == notice.ParamType.COUNT_COLOR) then 						--数量，颜色码
			table.insert(valueList, self:decodeNumOrStr(tempContent))
		elseif(type == notice.ParamType.STR_COLOR) then						--文本内容，颜色码
			table.insert(valueList, self:decodeNumOrStr(tempContent))
		elseif(type == notice.ParamType.PLAYERID_PLAYERNAME_VIP) then		--玩家id，玩家名字，vip
			table.insert(valueList, self:decodePlayer(tempContent))
		elseif(type == notice.ParamType.PROPS) then							--道具结构字段
			table.insert(valueList, self:decodePropsLink(propsList))
		end
	end
	local richText = string.noticeSubstituteArr(content, valueList)
	return richText
end

--  字符串颜色替换
function decodeNumOrStr(self, content)
	local list = string.split(content, notice.serverSplitSign)
	if(#list == 1) then
		return list[1]
	end
	local color = ColorUtil:getPropColor(tonumber(list[2]))
	return RichTextUtil:color(list[1], color)
end

-- 玩家id，玩家名字，vip
function decodePlayer(self, content)
	local list = string.split(content, notice.serverSplitSign)
	local id = list[1]
	local playerName = list[2]
	local vip = tonumber(list[3])
	local preStr = ""
	if(vip > 0) then
		preStr = preStr .. RichTextUtil:customImage("icon_vip.png", 60, 30, notice.HrefUtil.HREF_OPEN_VIP)
	end
	
	local color
	local temName = preStr
	if(id == role.RoleManager:getRoleVo().playerId) then
		color = notice.selfNameColor
	else
		color = notice.otherNameColor
	end
	playerName = self:delNewlineOrEnter(self:trim(playerName))
	temName = temName .. RichTextUtil:underline(RichTextUtil:href(playerName, color, notice.HrefUtil.HREF_ROLE, {id = id}), color)
	return temName
end

--  解析道具信息
function decodePropsLink(self, propsList)
	local str = ""
	if(propsList and #propsList > 0) then
		local len = #propsList
		for i = 1, len do
			local propsVo = propsList[i]
			str = str .. RichTextUtil:href("[" .. propsVo:getName() .. "]", ColorUtil:getPropColor(propsVo.color), notice.HrefUtil.HREF_PROPS, {id = propsVo.id, tid = propsVo.tid})
		end
	end
	return str
end

--  解析加入联盟
-- function decodeGuildLink(self, content)
-- 	local strlist = string.split(content, notice.serverSplitSign)
-- 	local eventParamList = strlist
-- 	local decodeStr = RichTextUtil:href("[我要充钱]", ColorUtil.GREEN_NUM, notice.HrefUtil.HREF_APPLY_GUILD, eventParamList)
-- 	return decodeStr
-- end
-- --  解析vip等级
-- function decodeVip(self, content)
-- 	local vipLvl = content
-- 	local decodeStr = RichTextUtil:customImage("icon_vip.png", 60, 30, notice.HrefUtil.HREF_OPEN_VIP) .. vipLvl
-- 	return decodeStr
-- end
-- 去掉回车字符 或换行符
function delNewlineOrEnter(self, str)
	str = string.gsub(str, "%\n", "")
	str = string.gsub(str, "%\r", "")
	return str
end

-- 去掉左右空格
function trim(self, str)
	str = string.gsub(str, "^[ \t\n\r]+", "")
	return string.gsub(str, "[ \t\n\r]+$", "")
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]

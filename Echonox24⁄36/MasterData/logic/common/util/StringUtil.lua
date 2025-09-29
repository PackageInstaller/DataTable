-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/StringUtil.lua

module("logic.common.util.StringUtil", package.seeall)

local blackBlockRegex = "[\\u2586\\u2587\\u2588\\u258b\\u258a\\u2589\\u25a0]"
local blackBlockRes = {
	"[fhdt01]",
	"[fhdt02]",
	"[fhdt03]",
	"[fhdt04]",
	"[fhdt05]",
	"[fhdt06]",
	"[fhdt07]",
	"[fhdt08]",
	"[fhdt09]",
	"[fhdt10]"
}
local blackBlockTMPRes = {
	"<sprite name=\"fhdt01\">",
	"<sprite name=\"fhdt02\">",
	"<sprite name=\"fhdt03\">",
	"<sprite name=\"fhdt04\">",
	"<sprite name=\"fhdt05\">",
	"<sprite name=\"fhdt06\">",
	"<sprite name=\"fhdt07\">",
	"<sprite name=\"fhdt08\">",
	"<sprite name=\"fhdt09\">",
	"<sprite name=\"fhdt10\">"
}

function replaceAllRed(text)
	return string.gsub(text, "&(.-)&", "<color=#ff3e48>%1</color>")
end

function replaceAllToColor(text, colorStr)
	local str = string.format("<color=%s>%%1</color>", colorStr)

	return string.gsub(text, "&(.-)&", str)
end

function replaceAllSup(text)
	return string.gsub(text, "@(.-)@", "<sup>%1</sup>")
end

function replaceMiddleBracketsToColor(text, colorStr)
	local function kReplaceDescFunction(descPatternResult)
		if string.nilorempty(colorStr) then
			colorStr = "#D4692D"
		end

		local matchContent = string.sub(descPatternResult, 2, -2)

		return string.format("<color=%s>%s</color>", colorStr, matchContent)
	end

	return string.gsub(text, "%b[]", kReplaceDescFunction)
end

function replaceAllSub(text)
	return string.gsub(text, "$(.-)$", "<sub>%1</sub>")
end

function randomReplaceBlackBlock(text)
	return StringUtilExtension.ReplaceAllBlcakBlock(text, blackBlockRegex, blackBlockRes)
end

function replaceAllGraphicText(text)
	for s in string.gmatch(text, "~(.-)~") do
		local regexTxt = string.format("~%s~", s)
		local iconRes = GraphicTextConfig.instance:getIconByRegexTxt(regexTxt)
		local replaceTxt = string.format("[%s]", iconRes)

		text = string.gsub(text, regexTxt, replaceTxt)
	end

	return text
end

function replaceAllGraphicText2(text)
	for s in string.gmatch(text, "&(.-)&") do
		local regexTxt = string.format("&%s&", s)
		local iconRes = GraphicTextConfig.instance:getIconByRegexTxt(regexTxt)
		local replaceTxt = string.format("[%s]", iconRes)

		text = string.gsub(text, regexTxt, replaceTxt)
	end

	return text
end

function replaceAllGraphicTmpText(text)
	for s in string.gmatch(text, "&(.-)&") do
		local regexTxt = string.format("&%s&", s)
		local iconRes = GraphicTextConfig.instance:getIconByRegexTxt(regexTxt)
		local replaceTxt = string.format("<sprite name=%s>", iconRes)

		text = string.gsub(text, regexTxt, replaceTxt)
	end

	return text
end

function randomReplaceTMPToBlackBlock(text, colorStr)
	local stringLength = getStrLen(text)
	local subStr = ""

	if not string.nilorempty(colorStr) then
		colorStr = string.format(" color=%s>", colorStr)
	else
		colorStr = nil
	end

	for i = 1, stringLength do
		local str = blackBlockTMPRes[math.random(1, #blackBlockTMPRes)]

		if colorStr then
			str = string.gsub(str, ">", colorStr)
		end

		subStr = string.format("%s%s", subStr, str)
	end

	return subStr
end

function replaceTMPBlackBlock(text, colorStr)
	if string.nilorempty(colorStr) then
		return StringUtilExtension.ReplaceAllBlcakBlock(text, blackBlockRegex, blackBlockTMPRes)
	else
		local t = {}
		local repStr = string.format(" color=%s>", colorStr)

		for _, val in ipairs(blackBlockTMPRes) do
			local str = string.gsub(val, ">", repStr)

			table.insert(t, str)
		end

		return StringUtilExtension.ReplaceAllBlcakBlock(text, blackBlockRegex, t)
	end
end

function randomReplaceToBlackBlock(text)
	local stringLength = getStrLen(text)
	local subStr = ""

	for i = 1, stringLength do
		subStr = string.format("%s%s", subStr, blackBlockRes[math.random(1, #blackBlockRes)])
	end

	return subStr
end

function filterSpecialStr(s)
	local ss = {}
	local hasSpecial = true

	for k = 1, #s do
		local c = string.byte(s, k)

		if not c then
			break
		end

		if c >= 48 and c <= 57 or c >= 65 and c <= 90 or c >= 97 and c <= 122 then
			ss[#ss + 1] = string.char(c)
		elseif c >= 228 and c <= 233 then
			local c1 = string.byte(s, k + 1)
			local c2 = string.byte(s, k + 2)

			if c1 and c2 then
				local a1, a2, a3, a4 = 128, 191, 128, 191

				if c == 228 then
					a1 = 184
				elseif c == 233 then
					a2, a4 = 190, c1 ~= 190 and 191 or 165
				end

				if a1 <= c1 and c1 <= a2 and a3 <= c2 and c2 <= a4 then
					k = k + 2
					ss[#ss + 1] = string.char(c, c1, c2)
				end
			end
		end
	end

	if #ss > 0 then
		local len = 0

		for k, v in pairs(ss) do
			len = len + #v
		end

		if #s == len then
			hasSpecial = false
		end
	end

	return hasSpecial, ss
end

function utfstrlen(str)
	local len = #str
	local left = len
	local cnt = 0
	local arr = {
		0,
		192,
		224,
		240,
		248,
		252
	}

	while left ~= 0 do
		local tmp = string.byte(str, -left)
		local i = #arr

		while arr[i] do
			if tmp >= arr[i] then
				left = left - i

				break
			end

			i = i - 1
		end

		cnt = cnt + 1
	end

	return cnt
end

function getShortName(sName, nMaxCount, nShowCount)
	if sName == nil or nMaxCount == nil then
		return
	end

	local sStr = sName
	local tCode = {}
	local tName = {}
	local nLenInByte = #sStr
	local nWidth = 0

	if nShowCount == nil then
		nShowCount = nMaxCount - 3
	end

	for i = 1, nLenInByte do
		local curByte = string.byte(sStr, i)
		local byteCount = 0

		if curByte > 0 and curByte <= 127 then
			byteCount = 1
		elseif curByte >= 192 and curByte < 223 then
			byteCount = 2
		elseif curByte >= 224 and curByte <= 239 then
			byteCount = 3
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
		end

		local char

		if byteCount > 0 then
			char = string.sub(sStr, i, i + byteCount - 1)
			i = i + byteCount - 1
		end

		if byteCount == 1 then
			nWidth = nWidth + 1

			table.insert(tName, char)
			table.insert(tCode, 1)
		elseif byteCount > 1 then
			nWidth = nWidth + 2

			table.insert(tName, char)
			table.insert(tCode, 2)
		end
	end

	if nMaxCount < nWidth then
		local _sN = ""
		local _len = 0

		for i = 1, #tName do
			_sN = _sN .. tName[i]
			_len = _len + tCode[i]

			if nShowCount <= _len then
				break
			end
		end

		sName = _sN .. "..."
	end

	return sName
end

function getStringTruncat(oldStr, maxLength, endWith)
	local endStr = endWith and endWith or "..."

	return StringUtilExtension.StringTruncat(oldStr, maxLength, endStr)
end

function getLess10With0(time)
	time = tonumber(time)

	return time and time < 10 and "0" .. time or time
end

function getStringLength(inputstr)
	if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then
		return nil
	end

	local length = 0
	local i = 1

	while true do
		local curByte = string.byte(inputstr, i)
		local byteCount = 1
		local offset = 1

		if curByte > 239 then
			byteCount = 4
			offset = 2
		elseif curByte > 223 then
			byteCount = 3
			offset = 2
		elseif curByte > 128 then
			byteCount = 2
			offset = 2
		else
			byteCount = 1
			offset = 1
		end

		i = i + byteCount
		length = length + offset

		if i > #inputstr then
			break
		end
	end

	return length
end

function getStrLen(inputstr)
	if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then
		return 0
	end

	local length = 0
	local i = 1

	while true do
		local curByte = string.byte(inputstr, i)
		local byteCount = 1

		byteCount = curByte > 239 and 4 or curByte > 223 and 3 or curByte > 128 and 2 or 1
		i = i + byteCount
		length = length + 1

		if i > #inputstr then
			break
		end
	end

	return length
end

function getCharacterLimit(inputstr, maxLength)
	local curLen = StringUtil.getStringLength(inputstr)
	local limitLen = maxLength

	if not curLen then
		return limitLen
	end

	if maxLength <= curLen then
		limitLen = StringUtil.getStrLen(inputstr)
	end

	return limitLen
end

function toUniqueKey(str1, str2)
	return str1 .. "_" .. str2
end

function trim(input)
	return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
end

function getServerName(serverName, serverIp)
	local displayText = serverName or ""

	if enableDebug and serverIp then
		displayText = string.format("%s(%s)", serverName, serverIp)
	end

	return displayText
end

function convertLevel(playerLevel)
	return string.format("%d-%d", playerLevel / 10, playerLevel % 10)
end

function splitTitleAndContent(text)
	if string.nilorempty(text) then
		return
	end

	local titleList = {}
	local contentList = {}

	text = string.gsub(text, "<color=#", "&@&")

	for title in string.gmatch(text, "#(.-)#") do
		table.insert(titleList, title)
	end

	text = string.gsub(text, "&@&", "<color=#")
	text = string.gsub(text, "\r\n#(.-)#\r\n", "##")
	text = string.gsub(text, "#(.-)#\r\n", "##")

	local pos = 0

	for st, sp in function()
		return string.find(text, "##", pos, true)
	end do
		if st - 1 > 0 then
			table.insert(contentList, string.sub(text, pos, st - 1))
		end

		pos = sp + 1
	end

	table.insert(contentList, string.sub(text, pos))

	return titleList, contentList
end

function splitSummaryInfo(s)
	local i, j = string.find(s, "<summary>")

	if not i then
		return s
	end

	local k, l = string.find(s, "</summary>")

	if not k then
		return s
	end

	return string.sub(s, i + 9, k - 1), string.sub(s, l + 1)
end

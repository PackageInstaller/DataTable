local string = string or {}

--[[@todo: 把input 转为bool
@param: input 不为nil, 不是"false" 都返回true
@return: bool
]]
function string.tobool(input)
    if input == nil or input == "false" then
        return false
    end
    return true
end

--[[@todo: 判断是否是浮点型
@param: num 数值或者数值字符串都可以
@return: bool
--]]
function string.isFloat(num)
    local baseNum = tonumber(num)
    local intNum = math.floor(baseNum)
    if baseNum ~= intNum then
        return true
    end
    return false
end

--[[@todo: 分隔字符串，返回分隔后的table
@param: str 分隔字符串
@param: delimiter 分隔符
@return: table 失败返回nil
]]
function string.split(str, delimiter)
    if (delimiter == "") then
        return nil
    end
    local pos, arr = 0, {}
    for st, sp in function()
        return string.find(str, delimiter, pos, true)
    end do
        table.insert(arr, string.sub(str, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(str, pos))
    return arr
end

-- 首字母大写
function string.first2Upper(str)
    return (str:gsub("^%l", string.upper))
end

--获取文件名
function string.getFileName(str)
    local idx = str:match(".+()%.%w+$")
    if (idx) then
        return str:sub(1, idx - 1)
    else
        return str
    end
end

--通过路径获取带后缀文件名，比较正确的
function string.getFileNameByPath(path)
    return string.match(path, ".+/([^/]*%.%w+)$")
end

--获取路径
function string.stripfilename(path)
    -- return string.match(path, "(.+)/[^/]*%.%w+$") -- *nix system
    return string.match(path, "(.+)\\[^\\]*%.%w+$") -- windows
end

-- 使用传入的各个参数替换指定的字符串内的“{n}”标记
function string.substitute(str, ...)
    local args = { ... }
    for i, v in ipairs(args) do
        local regExp = "{" .. (i - 1) .. "}"
        str = string.gsub(str, regExp, args[i])
    end
    return str
end

-- 使用传入的参数列表替换指定的字符串内的“{n}”标记
function string.substituteArr(str, strArr)
    if (str == nil) then
        str = ""
    end
    if (strArr ~= nil) then
        local len = #strArr
        for i = 1, len do
            local regExp = "{" .. (i - 1) .. "}"
            str = string.gsub(str, regExp, strArr[i])
        end
    end
    return str
end

-- 公告专用：使用传入的参数列表替换指定的字符串内的“{n}”标记
function string.noticeSubstituteArr(str, strArr)
    local str = string.gsub(str, "%{.-%}", "|")
    local _strArr = string.split(str, "|")
    if (#strArr + 1 == #_strArr) then
        local tempStr = ""
        for i = 1, #_strArr do
            if (i == #_strArr) then
                tempStr = tempStr .. _strArr[i]
            else
                tempStr = tempStr .. _strArr[i] .. strArr[i]
            end
        end
        return tempStr
    else
        return ""
    end
end

-- 连接字符串数组
function string.concatenateArr(str, strArr)
    if (str == nil) then
        str = ""
    end
    if (strArr ~= nil) then
        for key, value in ipairs(strArr) do
            str = str .. value
        end
    end
    return str
end

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function string.ends(String, End)
    return End == "" or string.sub(String, -string.len(End)) == End
end

function string.getWidth(str)
    local lenInByte = #str
    local strWidth = 0
    local i = 1
    while (i <= lenInByte)
    do
        local curByte = string.byte(str, i)
        local byteCount = 0
        local byteWidth = 0
        if curByte > 0 and curByte < 128 then
            byteCount = 1                           --1字节字符
            byteWidth = 10                          --1字节字符宽度
        elseif curByte >= 192 and curByte < 224 then
            byteCount = 2                           --1字节字符
            byteWidth = 14                          --双字节字符宽度
        elseif curByte >= 224 and curByte < 240 then
            byteCount = 3                           --1字节字符
            byteWidth = 18                          --3字节汉字宽度
        elseif curByte >= 240 and curByte < 248 then
            byteCount = 4                           --1字节字符
            byteWidth = 22                          --4字节字符宽度
        end
        string.sub(str, i, i + byteCount - 1)
        i = i + byteCount                           -- 重置下一字节的索引
        strWidth = strWidth + byteWidth
    end
    return strWidth
end

-- 省略缩写(str 省略原文，count 省略仅存文字长度)
function string.omit(str, maxLen)
    maxLen = maxLen or 4
    local charNum = string.getStringCharCount(str)
    if charNum > maxLen then
        local byteSize = 0
        local index = 1
        for i = 1, maxLen do
            local byteCount = 0
            local curByte = string.byte(str, index)
            if curByte > 0 and curByte < 128 then
                byteCount = 1                        --1字节字符
            elseif curByte >= 192 and curByte < 224 then
                byteCount = 2                        --双字节字符
            elseif curByte >= 224 and curByte < 240 then
                byteCount = 3                        --汉字
            elseif curByte >= 240 and curByte < 248 then
                byteCount = 4                        --4字节字符
            end
            byteSize = byteSize + byteCount
            index = index + byteCount                -- 重置下一字节的索引
        end
        return string.sub(str, 1, byteSize) .. '...'
    else
        return str
    end
end

--计算字符串字符个数
function string.getStringCharCount(str)
    local lenInByte = #str
    local charCount = 0
    local i = 1
    while (i <= lenInByte)
    do
        local curByte = string.byte(str, i)
        local byteCount = 1
        if curByte > 0 and curByte < 128 then
            byteCount = 1                        --1字节字符
        elseif curByte >= 192 and curByte < 224 then
            byteCount = 2                        --双字节字符
        elseif curByte >= 224 and curByte < 240 then
            byteCount = 3                        --汉字
        elseif curByte >= 240 and curByte < 248 then
            byteCount = 4                        --4字节字符
        end

        local char = string.sub(str, i, i + byteCount - 1)
        i = i + byteCount                                  -- 重置下一字节的索引
        charCount = charCount + 1                          -- 字符的个数（长度）
    end
    return charCount
end
-- 转字符数组
function string.toCharArray(str)
    local list = {}
    local len = string.len(str)
    local i = 1
    local shift = 1
    while i <= len do
        local c = string.byte(str, i)
        shift = 1
        if c > 0 and c <= 127 then
            shift = 1
        elseif (c >= 192 and c <= 223) then
            shift = 2
        elseif (c >= 224 and c <= 239) then
            shift = 3
        elseif (c >= 240 and c <= 247) then
            shift = 4
        end
        --LOG_ERROR("st", "c=%s shift=%d", c, shift)
        table.insert(list, string.sub(str, i, i + shift - 1))
        i = i + shift
    end
    return list
end

--转货币数字（每三位数加一个逗号分隔）
function string.toMoneyStr(numTmp)
    local resultNum = numTmp

    if type(numTmp) == "number" then
        local inter, point = math.modf(numTmp)
        local strNum = tostring(inter)
        local newStr = ""
        local numLen = string.len(strNum)
        if numLen >= 6 then  -- 策划说，超过10万才给点
            local count = 0
            for i = numLen, 1, -1 do
                if count % 3 == 0 and count ~= 0 then
                    newStr = string.format("%s,%s", string.sub(strNum, i, i), newStr)
                else
                    newStr = string.format("%s%s", string.sub(strNum, i, i), newStr)
                end
                count = count + 1
            end
            if point > 0 then
                --@desc 存在小数点，
                local strPoint = string.format("%.2f", point)
                resultNum = string.format("%s%s", newStr, string.sub(strPoint, 2, string.len(strPoint)))
            else
                resultNum = newStr
            end
        end
    end
    return resultNum
end

function string.replaceSpacesToFullAngle(str)
    if (str) then
        return string.gsub(str, " ", "　")
    end
    return str
end

-- 删除所有空格（\u{00A0} ：不换行空格的Unicode编码）
function string.deleteSpaces(str)
    if (str) then
        if (gs.Application.platform ~= gs.RuntimePlatform.IPhonePlayer) then
            -- \u{00A0} 这种编码ios不支持
            str = string.gsub(str, "u{00A0}", "")
        end
        str = string.gsub(str, "　", "")
        str = string.gsub(str, " ", "")
    end
    return str
end

--判断是不是空
function string.NullOrEmpty(str)
    if str == nil or str == "" then
        return true
    end
    return false
end

-- 星期几文本
function string.getWeekNumParseWeekStr(weekStr, num)
    local weekList = string.split(weekStr, ",")
    return weekList[num]
end

-- local __mDayTypeStr = {53613, 53614, 53615, 53616, 53617, 53618, 53619}
-- --周幾的阿拉伯數字轉換為語言表配置的文本
-- --例如傳入7 返回的是日 6返回六
-- function string.getWeekNumParseWeekStr(weekNum)
--     return _TT(__mDayTypeStr[weekNum])
-- end

local __mNumTypeStr = { 53613, 53614, 53615, 53616, 53617, 53618, 53622, 53623, 53624 }
--123456789的阿拉伯數字轉換為語言表配置的文本
--例如傳入7 返回的是七 6返回六 9返回九
function string.getNumParseStr(num)
    return _TT(__mNumTypeStr[num])
end

-- 罗马数字转换
local romanStrlist = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ" }
function string.getRomanConversion(num)
    return romanStrlist[num]
end

-- 单数转换例如1变成01 双数以上照旧
function string.singleNumConverZeroNum(num)
    num = tonumber(num)
    if num > 0 then
        if num < 10 then
            return "0" .. num
        else
            return tostring(num)
        end
    elseif num < 0 then
        num = math.abs(num)
        return "-" .. string.singleNumConverZeroNum(num)
    else
        return "0"
    end

end

-- 判断字符是否以指定的前缀开头
function string.startsWith(path, prefix)
    return string.sub(path, 1, string.len(prefix)) == prefix
end

-- 替换字符中的前缀
function string.replacePrefix(path, prefix, newPrefix)
    if string.startsWith(path, prefix) then
        return newPrefix .. string.sub(path, string.len(prefix) + 1)
    else
        return path
    end
end

local units = {
    "", "万", "亿", "兆", "京", "垓", "秭", "穰", "沟", "涧",
    "正", "载", "极", "恒河沙", "阿僧祇", "那由他", "不可思议", "无量大数"
}
--1000 0000 0000 00000000
function string.formatChineseNumber(num, decimalPlaces, formatCount)
    -- if type(num) ~= "number" then
    --     return "0"
    -- end
    if type(num) == "string" then
        num = tonumber(num)
    end

    if num == 0 then
        return "0"
    end

    local isNegative = false
    if num < 0 then
        isNegative = true
        num = math.abs(num)
    end

    if formatCount ~= nil and #tostring(num) <= formatCount then
        return num
    end

    local unitIndex = 0
    local divisor = 1

    while num >= 10000 and unitIndex < #units do
        num = num / 10000
        unitIndex = unitIndex + 1
    end

    decimalPlaces = decimalPlaces or 2
    local decimalFormat = "%." .. decimalPlaces .. "f"

    local result = string.format(decimalFormat, num)

    if decimalPlaces > 0 then
        result = result:gsub("0+$", ""):gsub("%.$", "")
    end

    if unitIndex > 0 then
        result = result .. units[unitIndex + 1]
    end

    if isNegative then
        result = "-" .. result
    end

    return result
end


-- 把科学计数法转化为完整字符串数值显示(14位后不精确，仅补0)
function string.formatSciNotationNumber(str)
    -- 提取开头的非数字字符作为前缀
    local prefix = str:match("^[^0-9+-]*") or ""
    local number_str = str:sub(#prefix + 1)

    local digits = number_str
    local e_index = number_str:find("[eE]")
    if e_index then
        local mantissa = number_str:sub(1, e_index - 1)
        local exponent = tonumber(number_str:sub(e_index + 1))
        local integer_part, fractional_part = mantissa:match("^(%d*)%.?(%d*)$")

        -- 确保integer_part和fractional_part都有值
        integer_part = integer_part or ""
        fractional_part = fractional_part or ""

        -- 移除小数点并补零
        digits = integer_part .. fractional_part
        if exponent > 0 then
            if #fractional_part > exponent then
                -- 指数小于小数位数
                local move_point = integer_part .. fractional_part:sub(1, exponent)
                local remain = fractional_part:sub(exponent + 1)
                digits = move_point .. "." .. remain
            else
                -- 指数大于等于小数位数
                digits = integer_part .. fractional_part .. string.rep("0", exponent - #fractional_part)
            end
        else
            -- 负指数
            exponent = -exponent
            digits = "0." .. string.rep("0", exponent - 1) .. integer_part .. fractional_part
        end
    end

    -- 返回前缀 + 转换后的数字
    return prefix .. digits
end
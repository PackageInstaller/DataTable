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
    if(str)then
        return string.gsub(str, " ", "　")
    end
    return str
end

-- 删除所有空格（\u{00A0} ：不换行空格的Unicode编码）
function string.deleteSpaces(str)
    if(str)then
        if(gs.Application.platform ~= gs.RuntimePlatform.IPhonePlayer)then
            -- \u{00A0} 这种编码ios不支持
            str = string.gsub(str, "\u{00A0}", "")
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

-- 罗马数字转换
local romanStrlist = {"Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ", "Ⅵ", "Ⅶ", "Ⅷ", "Ⅸ", "Ⅹ"}
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
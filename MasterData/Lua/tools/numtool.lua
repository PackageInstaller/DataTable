




NumTool=
{
delayHandlerIndex=100000;
}



function NumTool.GetStringLength(inputstr)
    if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then
        return 0
    end
local length = 0
    local i = 1
    while true do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if curByte > 239 then
byteCount = 4
        elseif curByte > 223 then
byteCount = 3
        elseif curByte > 128 then
byteCount = 2
        else
byteCount = 1
        end


        i = i + byteCount
        length = length + 1
        if i > #inputstr then
            break
        end
    end
    return length
end




function NumTool.split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    for st,sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end


function NumTool.En_string_insert(str,insertStr)
    local len = #str;
    local left = len;
    local cnt = 0;
    local arr={0,0xc0,0xe0,0xf0,0xf8,0xfc};
    local indx = -left;
    local newstr = "";
    while left ~= 0 do
        local tmp=string.byte(str,-left);
        local i=#arr;
        while arr do
            if tmp>=arr then
                left=left-i;
                break;
            end
            i=i-1;
        end
        local substr = string.sub(str,indx,-left - 1);
        if left ~= 0 then
            newstr = newstr .. substr .. insertStr;
        else
            newstr = newstr .. substr;
        end


        indx = -left;
        cnt=cnt+1;
    end
    return newstr;
end


function NumTool.GetLen(ptable)
    local index=0;
    if IsNull(ptable) or next(ptable)==nil then return index end;
    for i,v in pairs(ptable) do
        index=index+1;
    end
    return index;
end

function NumTool.GetMaxNum(num)
    if type(num) ~= "number" then
        return "Error param must is number type"
    end
    if num > 10 or num < 1 then
        return "Error num than 10 maxize or num than 1 minize"
    end
    local codeLans = {
        "NumTool_0",
        "NumTool_1",
        "NumTool_3",
        "NumTool_4",
        "NumTool_5",
        "NumTool_6",
        "NumTool_7",
        "NumTool_8",
        "NumTool_9",
        "NumTool_10",
    }
    return LuaMgr.GetLangText(codeLans[num]);
end

function NumTool.GetChinaUpper(num)
    local str=ConfigMgr.LangGlobal("16008");
    local strArray=NumTool.split(str,";")
    if num>#strArray or num==0 then
        return nil;
    end
    return strArray[num];
end



function NumTool.DelayHandler(fun,time)
    NumTool.delayHandlerIndex=NumTool.delayHandlerIndex+1;
    local timerId=NumTool.delayHandlerIndex;
    LuaMgr.AddTimer(timerId,function()
        if fun~=nil then
            fun();
        end
    end,time,1,false)
    return timerId;
end

function NumTool.RemoveDelayHandler(timerId)
    LuaMgr.RemoveTimer(timerId);
end


function NumTool.GetDayText(index)
    local str=ConfigMgr.LangGlobal("22630")
    local list=NumTool.split(str,";");
    if index>#list or index==0 then
        return nil;
    end
    return list[index];
end


function NumTool.FindIndex(array, target)
    for i, v in ipairs(array) do
        if v == target then
            return i
        end
    end
    return -1
end

function NumTool.Round(num)
    if num >= 0 then
        return math.floor(num + 0.5)
    else
        return math.ceil(num - 0.5)
    end
end


return NumTool;
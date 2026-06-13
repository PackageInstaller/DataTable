local MathUtil = {}
local CS_LuaUtils = CS.GameX.LuaUtils

local function CheckBitNumber(num, pos)
    return CS_LuaUtils.CheckBitNumber(num, pos)
end

local function GetPreciseDecimal(num, n)
    if type(num) ~= "number" then
        return num;
    end
    n = n or 0;
    n = math.floor(n)
    if n < 0 then
        n = 0;
    end
    local nDecimal = 10 ^ n
    local nTemp = math.floor(num * nDecimal);
    local nRet = nTemp / nDecimal;
    return nRet;
end

MathUtil.CheckBitNumber = CheckBitNumber
MathUtil.GetPreciseDecimal = GetPreciseDecimal

return MathUtil

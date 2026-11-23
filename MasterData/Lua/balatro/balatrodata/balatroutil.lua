




BalatroUtil = {}
BalatroUtil.__newindex = BalatroUtil


BalatroUtil.Text = "Text"
BalatroUtil.Button = "Button"
BalatroUtil.GameObject = "GameObject"
BalatroUtil.Transform = "Transform"
BalatroUtil.RectTransform = "RectTransform"
BalatroUtil.Image = "Image"
BalatroUtil.OnDragEvent = "OnDragEvent"
BalatroUtil.OnDragBehaviour = "OnDragBehaviour"
BalatroUtil.ScrollRect = "ScrollRect"
BalatroUtil.Animator = "Animator"
BalatroUtil.InputField = "InputField"
BalatroUtil.Slider = "Slider"
BalatroUtil.HorizontalLayoutGroup = "HorizontalLayoutGroup"
BalatroUtil.UIRotateByCurve = "UIRotateByCurve"
BalatroUtil.CanvasGroup = "CanvasGroup"
BalatroUtil.RedIconListener = "RedIconListener"



BalatroUtil.AlataGeneralBrand = "BalatroGeneralBrand"
BalatroUtil.AlataOther = "BalatroOther"





BalatroUtil.EffectType = {
GeneralBrand = 1,
BalatroBrand = 2,
Scene = 3
}


BalatroUtil.BrandType = {
FlushStraight = 1,
Quadra = 2,
Gourd = 3,
Flush = 4,
Straight = 5,
Triple = 6,
TwoDouble = 7,
Double = 8,
Normal = 9,
Penta = 10,
FlushPenta = 11,
FlushGourd = 12
}

BalatroUtil.BrandTypeUpReason = {
    RoundEnd = 1
}


BalatroUtil.Style = {
Hearts = 1,
Spades = 2,
Clubs = 3,
Diamonds = 4,
Other = 5
}


BalatroUtil.ShowType = {
Normal = 1,
Super = 2,
Rate = 3,
Score = 4,
Lucky = 5
}


BalatroUtil.MajorType = {}


BalatroUtil.ConditionType = {
Stytle = 1,
BrandType = 2,
BrandPoint = 3,
DiscardTimes = 4,
PlaycardTimes = 5,
PlaycardNum = 6,
MissingcardNum = 7,
BalatroBrand = 8,
BrandDeskIndex = 9,
Chance = 10,
Symbol = 11,
Score = 12,
PlaycardSeq = 13,
PointLimit = 14,
PropsBrand = 15,
BrandTypeTimes = 16,
BaseScore = 17,
BaseRate = 18,
Operate = 19,
GoalScore = 20,
BrandTypeCount = 21,
FirstDealBrand = 22,
Other = 30
}


BalatroUtil.ResultType = {
Rate = 1,
Score = 2,
DiscardTimes = 3,
PlaycardTimes = 4,
HandBrandLimit = 5,
PropbrandIncrease = 6,
BrandTypeLV = 7,
PropsBrand = 8,
GetBrandCount = 9,
DestroyHandBrand = 10,
BalatroBrand = 11,
Cripple = 12,
GetBrand = 13,
PlaycardCount = 14,
BaseScore = 15,
BaseRate = 16,
BaseDiscardTimes = 17
}


BalatroUtil.DeskIndexType = {
First = 1,
Last = 100
}


BalatroUtil.PointLimit = {
Max = 1,
Min = 2
}


BalatroUtil.PlaycardSeq = {
First = 1,
Last = 100
}

BalatroUtil.CalSymbolType = {
Add = 1,
Multiply = 2,
LessThan = 3,
GreaterThan = 4,
Equal = 5,
Division = 6
}


BalatroUtil.ConditonSymbol = {
And = 1,
Or = 2,
All = 3,
Map = 4,
LessThan = 5,
GreaterThan = 6,
Equal = 7
}

BalatroUtil.ActionType = {
RangeRandom = 1,
Increase = 2,
Rate = 3,
DestroySelf = 4,

StyleChange = 10,
BrandTyleChaneg = 11
}


BalatroUtil.CalMajor = {
Game = 1,
Playcard = 2,
HandBrand = 3,
PropsBrand = 4,
BrandPool = 5,
BalatroBrand = 6
}

BalatroUtil.DiscardType = {
    None = 0,
ByInitactive = 1,
ByScene = 2
}


BalatroUtil.CalFrequency = {
OnceTime = 1,
EveryTimePlay = 2,
EveryRoundStart = 3,
EveryRoundEnd = 4,
RoundEnd_EveryTime = 5,
RoundEnd_EveryPhase = 6,
BeforePlaycard = 7
}


BalatroUtil.OperateType = {
Playcard = 1,
Discard = 2
}


BalatroUtil.LuaDataType = {
    Nil = "nil",
    Number = "number",
    String = "string",
    Boolean = "boolean",
    Table = "table",
    Function = "function",
    Thread = "thread",
    Userdata = "userdata"
}


BalatroUtil.StepType = {
Idle = 0,
GameStart = 1,
GameEnd = 2,
PhaseStart = 3,
PhaseEnd = 4,
RoundStart = 5,
RoundEnd = 6,
PlaycardBefore = 7,
PlaycardAfter = 8,
DiscardBefore = 9,
DiscardAfter = 10
}


BalatroUtil.ShowPoint = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
BalatroUtil.ShowPointStr = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"}
BalatroUtil.RealPoint = {2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11}

BalatroUtil.Rare = {
    R = 1,
    SR = 2,
    SSR = 3,
    None = 4
}

BalatroUtil.RoundStatus = {
Victory = 1,
Defeat = 2,
GameOverDefeat = 3,
    Other = 4,
    Exit = 5,
    GameOverVictory = 6
}


BalatroUtil.RewardStatus = {
    None = 1,
    CanGet = 2,
    Got = 3
}


BalatroUtil.BalatroOwnStatus = {
None = 1,
Old = 2,
New = 3
}

BalatroUtil.AudioName = {
    "Balatro_CalPerBrand",
    "Balatro_Choose",
    "Balatro_ChooseBrand",
    "Balatro_GetProp",
    "Balatro_StartGame",
    "Balatro_UseProp",
    "Warnning"
}


BalatroUtil.BrandPreviewType = {
    None = 0,
BalatroBrand = 1,
PropsBrand = 2
}







BalatroUtil.Add = function(num1, num2)
    return tonumber(num1) + tonumber(num2)




































end


BalatroUtil.Sub = function(num1, num2)
    return tonumber(num1) + tonumber(num2)




































end


BalatroUtil.Muli = function(num1, num2)
    return tonumber(num1) * tonumber(num2)


























end

BalatroUtil.ToScientific = function(value)
    local num = tonumber(value)
    if num == nil then
        return "0"
    end
    if num < 100000000 then
        local str = ""
        if num == math.floor(num) then
            str = tostring(num)
        else
            str = string.format("%s", num)
        end
        return str
    end
return string.format("%.2e", num)
end





BalatroUtil.Compare = function(num1, num2)

    if type(num1) == BalatroUtil.LuaDataType.Number and type(num2) == BalatroUtil.LuaDataType.Number then
        if num1 == num2 then
            return 0
        end
        return num1 - num2 > 0 and 1 or -1
    end
    local num1Str = tostring(num1)
    local num2Str = tostring(num2)
    if #num1Str > #num2Str then
        return 1
    elseif #num1Str < #num2Str then
        return -1
    else

        for i = 1, #num1Str do
            if num1Str:sub(i, i) > num2Str:sub(i, i) then
                return 1
            elseif num1Str:sub(i, i) < num2Str:sub(i, i) then
                return -1
            end
        end
        return 0
    end
end




function BalatroUtil.SplitNumbers(input)
    if input == "" then
        return nil
    end
    local delimiter = ";"
    local result = {}
    local start = 1
    local delim_start, delim_end

    while true do
        delim_start, delim_end = string.find(input, delimiter, start)
        if not delim_start then

            local lastPart = string.sub(input, start)
if lastPart ~= "" then
                table.insert(result, tonumber(lastPart))
            end
            break
        end


        local part = string.sub(input, start, delim_start - 1)
if part ~= "" then
            table.insert(result, tonumber(part))
        end
        start = delim_end + 1
    end

    if #result == 0 then
        return nil
    end
    if #result == 1 then
        return result[1]
    end
    return result
end







BalatroUtil.SortBrandByPoint = function(brandData1, brandData2)
    if brandData1:GetShowPoint() ~= brandData2:GetShowPoint() then
        return brandData1:GetShowPoint() < brandData2:GetShowPoint()
    end
    return brandData1:GetStyle() < brandData2:GetStyle()
end

BalatroUtil.SortBrandByPointDescend = function(brandData1, brandData2)
    if brandData1:GetShowPoint() ~= brandData2:GetShowPoint() then
        return brandData1:GetShowPoint() > brandData2:GetShowPoint()
    end
    return brandData1:GetStyle() < brandData2:GetStyle()
end




BalatroUtil.SortBrandByStyle = function(brandData1, brandData2)
    if brandData1:GetStyle() ~= brandData2:GetStyle() then
        return brandData1:GetStyle() < brandData2:GetStyle()
    end
    return brandData1:GetShowPoint() < brandData2:GetShowPoint()
end

BalatroUtil.SortBrandByStyleDescend = function(brandData1, brandData2)
    if brandData1:GetStyle() ~= brandData2:GetStyle() then
        return brandData1:GetStyle() > brandData2:GetStyle()
    end
    return brandData1:GetShowPoint() < brandData2:GetShowPoint()
end



BalatroUtil.SortBalatroBrand = function(data1, data2)
    return data1:GetConfig().Order > data2:GetConfig().Order
end




function BalatroUtil.PlaySound(nameIndex)
    local name = BalatroUtil.AudioName[nameIndex]
    local path = string.format("%sUI/%s.mp3", Path.audio_PATH, name)
    AudioMgr.Singleton:PlayUISFX(path)
end




function BalatroUtil.ColorText(color, text)
    local hasHash = string.find(color, "#") ~= nil
    if hasHash then
        local validHex = string.match(color, "^#%x%x%x%x%x%x$")
        if validHex then
            return string.format("<color=%s>%s</color>", color, text)
        end
    else
        local validHex = string.match(color, "^%x%x%x%x%x%x$")
        if validHex then
            return string.format("<color=#%s>%s</color>", color, text)
        end
    end
    LuaDebug.error("无效的颜色：" .. color)
    return text
end




function TableToString(t, indent)
    if type(t) ~= "table" then
        local val = t == nil and "nil" or tostring(t)
        return val
    end

    indent = indent or 0
    local indentString = string.rep(" ", indent)
    local result = ""

    for k, v in pairs(t) do
        local keyStr = k == nil and "nil" or tostring(k)
        local keyType = type(k)
        
        if type(v) == "table" then
            result = result .. indentString .. keyStr .. ":\n"
            result = result .. TableToString(v, indent + 4)
        else
            local valStr = v == nil and "nil" or tostring(v)
            if keyType == "string" or keyType == "number" then
                result = result .. indentString .. keyStr .. ": " .. valStr .. "\n"
            else
                result = result .. indentString .. "[non-string-key] " .. keyStr .. ": " .. valStr .. "\n"
            end
        end
    end

    return result
end

table.tostring = function(t)
    return TableToString(t, 0)
end



function string.Trim(str, chars)
    chars = chars or "%s"
    chars = "%" .. chars .. "%s"
    return str:gsub("^[" .. chars .. "]*(.-)[" .. chars .. "]*$", "%1")
end


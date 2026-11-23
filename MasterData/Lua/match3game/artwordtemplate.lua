




ArtWordTemplate = {}
ArtWordTemplate.__index = ArtWordTemplate

ArtWordTemplate.NumSpriteCache = {}

local objs = {}
function ArtWordTemplate.New(prefab, count, atlaName, spritePrefix, needPrifix)

    local self = setmetatable({}, ArtWordTemplate)
    self.gameObject = prefab
    self.atlaName = atlaName
    self.spritePrefix = spritePrefix
    self.needPrifix = needPrifix or false
    self:InitObjDatas(count)
    UITool.Parse(self.gameObject, self, objs)
    self:InitObjItems(count)
    return self
end

function ArtWordTemplate.CacheNumSprite(atlaName, spritePrefix)
    if ArtWordTemplate.NumSpriteCache[atlaName] == nil then
        ArtWordTemplate.NumSpriteCache[atlaName] = {}
        for i = 0, 9 do
            local sprite = LuaMgr.GetSprite(atlaName, string.format("%s%d", spritePrefix, i))
            ArtWordTemplate.NumSpriteCache[atlaName][i] = sprite
        end
    end
end

function ArtWordTemplate:InitObjDatas(count)
    objs = {}
    for i = 1, count do
        local tempData = {}
        tempData.path = "Number" .. i
        tempData.type = UITool.Image
        objs["numberImage" .. i] = tempData
    end
end

function ArtWordTemplate:InitObjItems(count)
    self.numberImages = {}
    for i = 1, count do
        local tempImageItem = self["numberImage" .. i]
        self.numberImages[i] = tempImageItem
    end
end


function ArtWordTemplate:SetNum(number, existPrefix)
    if number < 0 then
        return
    end
    for key, numberImage in pairs(self.numberImages) do
        SetActive(numberImage.gameObject, false)
    end
    local tempNums = self:SplitNumberWithDecimal(number)
    for key, value in pairs(tempNums) do
        local numberImage = self.numberImages[key]
        SetActive(numberImage.gameObject, true)
        numberImage.sprite = LuaMgr.GetSprite(self.atlaName, string.format("%s%d", self.spritePrefix, value))
    end
end

function ArtWordTemplate:SplitNumberWithDecimal(num)
    local result = {}
    local decimalIndex = nil

    if num == math.floor(num) then
        local tempCount = num
        local integerDigits = {}
        if tempCount == 0 then
            table.insert(integerDigits, 0)
        else
            while tempCount > 0 do
                local digit = tempCount % 10
                table.insert(integerDigits, 1, digit)
                tempCount = math.floor(tempCount / 10)
            end
        end
        for _, digit in ipairs(integerDigits) do
            table.insert(result, digit)
        end
        if self.needPrifix == true and num < 10 then
            table.insert(result, 1, 0)
        end
    else

        local integerPart = math.floor(num)

        local decimalPart = num - integerPart

        local tempCount = integerPart
        local integerDigits = {}
        if tempCount == 0 then
            table.insert(integerDigits, 0)
        else
            while tempCount > 0 do
                local digit = tempCount % 10
                table.insert(integerDigits, 1, digit)
                tempCount = math.floor(tempCount / 10)
            end
        end
        for _, digit in ipairs(integerDigits) do
            table.insert(result, digit)
        end
        decimalIndex = #result + 1

        table.insert(result, ".")
        local decimalDigits = {}

        local maxPrecision = 2
        local precision = 0
        while decimalPart > 0 and precision < maxPrecision do
            decimalPart = decimalPart * 10
            local digit = math.floor(decimalPart)
            table.insert(decimalDigits, digit)
            decimalPart = decimalPart - digit
            precision = precision + 1
        end


        for _, digit in ipairs(decimalDigits) do
            table.insert(result, digit)
        end
    end
    return result, decimalIndex
end

function ArtWordTemplate.Clear()
    ArtWordTemplate.NumSpriteCache = {}
end
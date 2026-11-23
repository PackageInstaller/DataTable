













BalatroJumpWordItem = {}
BalatroJumpWordItem.__index = BalatroJumpWordItem

local objs = {
    animator = {path = "", type = BalatroUtil.Animator},
    canvansGroup = {path = "", type = BalatroUtil.CanvasGroup},
    animRoot = {path = "Anim", type = BalatroUtil.GameObject},
    wordTemplate = {path = "Anim/WordPrefab", type = BalatroUtil.GameObject}
}

function BalatroJumpWordItem.New(obj, parent, isNew)

    local self = {}
    setmetatable(self, BalatroJumpWordItem)
    if isNew then
        self.gameObject = LuaMgr.InstantiateGO(obj, parent, false)
    else
        self.gameObject = obj
    end
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.gameObject, true)
    self.wordImageItems = {}
    return self
end

function BalatroJumpWordItem:SetData(data)
    self.data = data
    if self.gameObject == nil then
        return
    end
    local numType = data.NumType
    local symbol = data.Symbol
    local number = tonumber(string.format("%.2f", data.Number))
    local allNumber = data.AllNumber
    for key, value in pairs(self.wordImageItems) do
        SetActive(value.gameObject, false)
    end
    if numType ~= BalatroUtil.ResultType.Rate and numType ~= BalatroUtil.ResultType.Score then
        return
    end

    local nextIndex = 1
    if not allNumber then
        if numType == BalatroUtil.ResultType.Rate then
            self:CheckImage(nextIndex)
            self.wordImageItems[nextIndex].sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, "ui_jj_xcp_djbl_01")
            SetActive(self.wordImageItems[nextIndex].gameObject, true)
            nextIndex = nextIndex + 1
        end

        self:CheckImage(nextIndex)
        if numType == BalatroUtil.ResultType.Rate and symbol == BalatroUtil.CalSymbolType.Add then
            self.wordImageItems[nextIndex].sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, "ui_jj_xcp_djjh_02")
            SetActive(self.wordImageItems[nextIndex].gameObject, true)
            nextIndex = nextIndex + 1
        elseif numType == BalatroUtil.ResultType.Rate and symbol == BalatroUtil.CalSymbolType.Multiply then
            self.wordImageItems[nextIndex].sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, "ui_jj_xcp_djch_01")
            SetActive(self.wordImageItems[nextIndex].gameObject, true)
            nextIndex = nextIndex + 1
        elseif numType == BalatroUtil.ResultType.Score and symbol == BalatroUtil.CalSymbolType.Add then
            self.wordImageItems[nextIndex].sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, "ui_jj_xcp_djjh_01")
            SetActive(self.wordImageItems[nextIndex].gameObject, true)
            nextIndex = nextIndex + 1
        end
    end

    local tempNums, decimalIndex = self:SplitNumberWithDecimal(number)
    for key, value in pairs(tempNums) do
        self:CheckImage(nextIndex)
        if numType == BalatroUtil.ResultType.Rate then
            if decimalIndex ~= nil and ((allNumber == true and nextIndex == decimalIndex) or (not allNumber and nextIndex == decimalIndex + 2)) then
                self.wordImageItems[nextIndex].sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, "ui_jj_xcp_djszl_10")
            else
                self.wordImageItems[nextIndex].sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, string.format("ui_jj_xcp_djszl_0%d", value))
            end
        else
            if decimalIndex ~= nil and ((allNumber == true and nextIndex == decimalIndex) or (not allNumber and nextIndex == decimalIndex + 1)) then
                self.wordImageItems[nextIndex].sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, "ui_jj_xcp_djsz_10")
            else
                self.wordImageItems[nextIndex].sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, string.format("ui_jj_xcp_djsz_0%d", value))
            end
        end
        SetActive(self.wordImageItems[nextIndex].gameObject, true)
        nextIndex = nextIndex + 1
    end
    for key, value in pairs(self.wordImageItems) do
        value:SetNativeSize()
    end
    self:PlayAnim(data.AnimName)
end

function BalatroJumpWordItem:SplitNumberWithDecimal(num)
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

function BalatroJumpWordItem:CheckImage(nextIndex)
    if #self.wordImageItems < nextIndex then
        local tempObj = LuaMgr.InstantiateGO(self.wordTemplate, self.animRoot.transform, false)
        local tempImg = tempObj.transform:GetComponent(BalatroUtil.Image)
        table.insert(self.wordImageItems, tempImg)
    end
end

function BalatroJumpWordItem:IsInvalid()
    return self.animRoot.activeSelf == false
end

function BalatroJumpWordItem:PlayAnim(name)
    if name ~= nil then
        self.animator:Play(name)
        return
    end
    self.animator:Play("UIBalatro_JumpWordBalatro")
end
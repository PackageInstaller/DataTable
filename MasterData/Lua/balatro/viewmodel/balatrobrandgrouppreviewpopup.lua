







require("Balatro/ViewModel/BalatroBrandItem")
local objs = {
    itemTemplete = {path = "template/BrandItem", type = BalatroUtil.GameObject},
    exitBtn = {path = "root/Middle/ExitBtn", type = BalatroUtil.Button},
    brandItemParent = {path = "root/Middle/Content", type = BalatroUtil.Transform}
}

local this = {
    rowSpacing = 100,
    radius = 200,
    startAngle = -5,
    angleRange = 8,
    brandItemCaches = {}
}

local Deg2Rad = math.pi / 180

this.before_awake = function()
    LuaMgr.AddClick(this.exitBtn, this.OnClickBack)
end




this.SortBrandData = function(data1, data2)
    if data1:GetShowPoint() == data2:GetShowPoint() then
        return data1:GetID() > data2:GetID()
    end
    return data1:GetShowPoint() > data2:GetShowPoint()
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroBrandGroupPreviewPopup)
end

this.before_active = function()
    this.allBrandDatas = {}
    local brandDatas1 = BalatroDataMgr.GetMainBrandPool()
    local brandDatas2 = BalatroDataMgr.GetSecondBrandPool()
    for key, value in pairs(brandDatas1) do
        if value:IsDestroy() == false then
            table.insert(this.allBrandDatas, value)
        end
    end
    for key, value in pairs(brandDatas2) do
        if value:IsDestroy() == false then
            table.insert(this.allBrandDatas, value)
        end
    end
    table.sort(this.allBrandDatas, this.SortBrandData)

    this.allBrandDataDic = {}
    this.GroupBrandData()
    this.DrawBrandItem()
end

this.GroupBrandData = function()
    local rowCount = 4
    local totalCount = #this.allBrandDatas

    local perRowCount = math.floor(totalCount / rowCount)
    local remainCount = totalCount - perRowCount * rowCount
    if remainCount == 0 then
        for key, value in pairs(this.allBrandDatas) do
            local divisionRes = key / perRowCount
            local rowIndex = math.floor(divisionRes)
            if rowIndex * perRowCount ~= key then
                rowIndex = rowIndex + 1
            end
            if this.allBrandDataDic[rowIndex] == nil then
                this.allBrandDataDic[rowIndex] = {}
            end
            table.insert(this.allBrandDataDic[rowIndex], value)
        end
    else
        local rowIndex = rowCount
        for i = totalCount, 1, -1 do
            if this.allBrandDataDic[rowIndex] == nil then
                this.allBrandDataDic[rowIndex] = {}
            end
            local value = this.allBrandDatas[i]
            table.insert(this.allBrandDataDic[rowIndex], 1, value)
            if rowIndex <= remainCount then
                if #this.allBrandDataDic[rowIndex] >= perRowCount + 1 then
                    rowIndex = rowIndex - 1
                end
            else
                if #this.allBrandDataDic[rowIndex] >= perRowCount then
                    rowIndex = rowIndex - 1
                end
            end
        end
    end
end

this.DrawBrandItem = function()
    local circlePosX = 0
    local circlePosY = -2515
    local index = 1
    for key, brandDatas in pairs(this.allBrandDataDic) do

        local leftCount = 0
        local count = #brandDatas
        local isEven = false
        leftCount = math.floor(count / 2)
        if count % 2 == 0 then
            isEven = true
        end

        local deltaAngleRad = this.angleRange * -2 / (count - 1) * Deg2Rad
        local deltaAngle = this.angleRange / leftCount
        local startX = -370
        local startY = 118
        local lastPosX = startX
        local lastPosY = startY - (key - 1) * 87

        local lastAngle = this.angleRange
        for i = 1, count do
            if i > 1 then
                local cosAngle = math.cos(deltaAngleRad)
                local sinAngle = math.sin(deltaAngleRad)
                local tempX = lastPosX - circlePosX
                local tempY = lastPosY - circlePosY
                lastPosX = tempX * cosAngle - tempY * sinAngle + circlePosX
                lastPosY = tempX * sinAngle + tempY * cosAngle + circlePosY
            end
            local brandData = brandDatas[i]
            local brandItem = this.GetBrandItem(index, i)
            brandItem:SetData(BalatroBrandItem.SizeType.Small, brandData:GetResName(false), brandData)
            brandItem:SetUsedFlag()
            local rectTrans = brandItem:GetRectTrans()
            rectTrans.anchoredPosition = Vector2(lastPosX + (key - 1) * 13, lastPosY)
            rectTrans.eulerAngles = Vector3(0, 0, lastAngle)

            lastAngle = lastAngle - deltaAngle

            local centerIndex1 = leftCount + 1
            if isEven == false and i == centerIndex1 then
                lastAngle = 0
            end
            index = index + 1
        end
    end
end



this.GetBrandItem = function(index, nameIndex)
    local item = this.brandItemCaches[index]
    if index > #this.brandItemCaches then
        item = BalatroBrandItem.New(this.itemTemplete, this.brandItemParent, nil, nameIndex)
        table.insert(this.brandItemCaches, index, item)
    end
    item.gameObject.name = string.format("BalatroBrandItem_%s", tostring(nameIndex))
    item:SetSiblingIndex(index - 1)
    return item
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroRefreshBrandGroup, this.before_active)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack)
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroRefreshBrandGroup, this.before_active)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
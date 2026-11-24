require("ViewModel/JiYeChangSheng/ViewItem/JYCSNovelItem")
local objs = {
    itemPrefab = {path = "template/ItemPrefab", type = UITool.GameObject},
    circleDragTrans = {path = "root/Middle/CircleDragTrans", type = UITool.OnDragEvent},
    circleParent = {path = "root/Middle/CircleParent", type = UITool.RectTransform},
    canIntroObj = {path = "root/Middle/IntroBtn/CanIntroBtn", type = UITool.GameObject},
    decoration = {path = "root/Middle/Decoration", type = UITool.Image},
    introBtn = {path = "root/Middle/IntroBtn", type = UITool.Button},
    gotoNewBtn = {path = "root/Right/GotoNewBtn", type = UITool.Button},
    middleTrans = {path = "root/Middle", type = UITool.RectTransform},
    referenceTrans = {path = "root/Middle/ReferenceTrans", type = UITool.RectTransform}
}

local this = {

    novelItems = {},

    novelItemCache = {},

    lastNovelItem = nil,

    newNovelItem = nil,
    decorationSpriteName = {"ui_hd_jycs_jq_sj_hl", "ui_hd_jycs_jq_sj_kl", "ui_hd_jycs_jq_sj_zz", "ui_hd_jycs_jq_sj_lh"},
    fixAngle = 4.47,
    circleRadius = 2457,
    defaultCircleAngle = 0,
    minCircleAngle = 0,
    maxCircleAngle = 0,
    currentCircleAngle = 0,
    lastDragPointerAngle = 0,
    circleTweenTime = 0.4,
    circleTweener = nil
}
this.before_awake = function()
    local onBeginDrag = function(eventData)
        this.StopCircleTween()
        this.lastDragPointerAngle = this.GetPointerAngle(eventData.position)
    end
    local onDrag = function(eventData)
        local pointerAngle = this.GetPointerAngle(eventData.position)
        local deltaAngle = this.NormalizeAngle(pointerAngle - this.lastDragPointerAngle)
        this.lastDragPointerAngle = pointerAngle
        this.SetCircleAngle(this.currentCircleAngle + deltaAngle)
    end
    local onEndDrag = function()
        this.UpdateGotoNewBtn()
    end
    this.circleDragTrans:SetData(1, nil, onDrag, nil)
    this.circleDragTrans:SetDragData(onBeginDrag, onEndDrag)
    RedMgr.Singleton:RegisterViewModel(UIName.JYCSNovelPanel)
end

this.before_active = function()
    this.StopCircleTween()
    this.RecycleItem()
    this.lastNovelItem = nil
    this.newNovelItem = nil
    local allNovelDatas, newNovelData = JYCSData.GetAllNovelDatas()
    this.minCircleAngle = -360
    this.maxCircleAngle = 360
    this.SetCircleAngle(this.defaultCircleAngle)
    for i = 1, #allNovelDatas do
        local data = allNovelDatas[i]
        data.OnClickBtn = this.OnClickNovelItem
        local item = this.GetNovelItem()
        item:SetData(data)
        item:SetItemPos(this.GetNovelItemPos(i))
        item.gameObject.name = string.format("%s_%d", data.id, data.Index)
        SetActive(item.gameObject, true)
        if data == newNovelData then
            this.newNovelItem = item
        end
    end
    this.RefreshCircleAngleRange()
    this.SetCircleAngle(this.defaultCircleAngle)
    this.introBtn.interactable = false
    SetActive(this.canIntroObj, false)
    local decorationIndex = math.random(1, #this.decorationSpriteName)
    local decorationName = this.decorationSpriteName[decorationIndex]
    this.decoration.sprite = LuaMgr.GetSprite(JYCSConst.AtlasName, decorationName)
    this.MoveToNewNovel()
end





this.OnClickNovelItem = function(item)
    if this.lastNovelItem ~= nil then
        this.lastNovelItem:SetSelected(false)
    end
    this.lastNovelItem = item
    this.lastNovelItem:SetSelected(true)
    this.introBtn.interactable = true
    SetActive(this.canIntroObj, true)
end

this.OnClickIntroBtn = function()
    if this.lastNovelItem == nil then
        return
    end
    local callback = function()
        LuaMgr.ShowLuaPanel(UIName.JYCSNovelPanel)
    end
    local novelID = this.lastNovelItem.data.eventParam
    LuaMgr.PlayNovel(novelID, callback)
    if this.newNovelItem ~= nil and this.newNovelItem.data.eventParam == novelID then
        local redID = string.format("%s_%s", JYCSConst.RedPoint.Novel, novelID)
        RedMgr.Singleton:FrushRedCondition(redID)
    end
end

this.OnClickGotoNewBtn = function()
    this.MoveToNewNovel()
end

this.MoveToNewNovel = function()
    if this.newNovelItem == nil or this.newNovelItem.data == nil then
        this.MoveCircleToAngle(this.defaultCircleAngle)
        return
    end
    local targetAngle = this.GetCircleAngleToMiddle(this.newNovelItem)
    this.MoveCircleToAngle(targetAngle)
end





this.GetNovelItem = function()
    local item = table.remove(this.novelItemCache)
    if item == nil then
        local obj = LuaMgr.InstantiateGO(this.itemPrefab, this.circleParent, false)
        item = JYCSNovelItem.New(obj)
    end
    table.insert(this.novelItems, item)
    return item
end





this.GetCircleAngleToMiddle = function(item)
    if item == nil or IsObjectNull(item.rectTrans) or IsObjectNull(this.middleTrans) then
        return this.defaultCircleAngle
    end
    local circleScreenPos = LuaMgr.World2Screen(this.circleParent.position)
    local itemScreenPos = LuaMgr.World2Screen(item.rectTrans.position)
    local middleScreenPos = LuaMgr.World2Screen(this.middleTrans.position)
    local itemAngle = math.deg(math.atan(itemScreenPos.y - circleScreenPos.y, itemScreenPos.x - circleScreenPos.x))
    local middleAngle = math.deg(math.atan(middleScreenPos.y - circleScreenPos.y, middleScreenPos.x - circleScreenPos.x))
    return this.currentCircleAngle + this.NormalizeAngle(middleAngle - itemAngle)
end

this.RefreshCircleAngleRange = function()
    local minAngle = this.defaultCircleAngle
    local maxAngle = this.defaultCircleAngle
    if #this.novelItems > 0 then
        local firstAngle = this.GetCircleAngleToMiddle(this.novelItems[1])
        local lastAngle = this.GetCircleAngleToMiddle(this.novelItems[#this.novelItems])
        minAngle = math.min(minAngle, firstAngle, lastAngle)
        maxAngle = math.max(maxAngle, firstAngle, lastAngle)
    end
    this.minCircleAngle = minAngle
    this.maxCircleAngle = maxAngle
end

this.GetNovelItemPos = function(index)
    local referencePos = RectTransformTool.ToContainer(this.referenceTrans, this.circleParent, LuaMgr.UICamera())
    local p1x = referencePos.x
    local p1y = referencePos.y
    local totalRad = math.rad(this.fixAngle * (index - 1))
    local targetX, targetY = this.GetNextCirclePoint(p1x, p1y, totalRad)
    return Vector2(targetX, targetY)
end

this.GetPointerAngle = function(screenPos)
    local centerScreenPos = LuaMgr.World2Screen(this.circleParent.position)
    local deltaX = screenPos.x - centerScreenPos.x
    local deltaY = screenPos.y - centerScreenPos.y
    if math.abs(deltaX) <= 0.001 and math.abs(deltaY) <= 0.001 then
        return this.lastDragPointerAngle
    end
    return math.deg(math.atan(deltaY, deltaX))
end

this.NormalizeAngle = function(angle)
    while angle > 180 do
        angle = angle - 360
    end
    while angle < -180 do
        angle = angle + 360
    end
    return angle
end

this.SetCircleAngle = function(angle)
    angle = math.max(this.minCircleAngle, math.min(this.maxCircleAngle, angle))
    this.currentCircleAngle = angle
    this.circleParent.localEulerAngles = Vector3(0, 0, angle)
    this.UpdateGotoNewBtn()
    this.SetNovelItemAngel(this.circleParent.localEulerAngles * -1)
end

this.SetNovelItemAngel = function(angle)
    for i = 1, #this.novelItems do
        local item = this.novelItems[i]
        item:SetItemAngle(angle)
    end
end

this.MoveCircleToAngle = function(targetAngle)
    this.StopCircleTween()
    targetAngle = math.max(this.minCircleAngle, math.min(this.maxCircleAngle, targetAngle))
    if math.abs(targetAngle - this.currentCircleAngle) <= 0.01 then
        this.SetCircleAngle(targetAngle)
        return
    end
    this.circleTweener =
        DOTWeen.To(
        function()
            return this.currentCircleAngle
        end,
        function(angle)
            this.SetCircleAngle(angle)
        end,
        targetAngle,
        this.circleTweenTime
    ):SetEase(Ease.OutCubic)
    this.circleTweener.onComplete = function()
        this.circleTweener = nil
        this.SetCircleAngle(targetAngle)
    end
end

this.StopCircleTween = function()
    if this.circleTweener ~= nil then
        this.circleTweener:Kill(false)
        this.circleTweener = nil
    end
end

this.IsNewNovelInScreen = function()
    if this.newNovelItem == nil or IsObjectNull(this.newNovelItem.rectTrans) then
        return false
    end
    local rectTrans = this.newNovelItem.rectTrans
    local rect = rectTrans.rect
    local minX = math.huge
    local minY = math.huge
    local maxX = -math.huge
    local maxY = -math.huge
    local addCorner = function(x, y)
        local worldPos = rectTrans:TransformPoint(Vector3(x, y, 0))
        local screenPos = LuaMgr.World2Screen(worldPos)
        minX = math.min(minX, screenPos.x)
        minY = math.min(minY, screenPos.y)
        maxX = math.max(maxX, screenPos.x)
        maxY = math.max(maxY, screenPos.y)
    end
    addCorner(rect.xMin, rect.yMin)
    addCorner(rect.xMin, rect.yMax)
    addCorner(rect.xMax, rect.yMin)
    addCorner(rect.xMax, rect.yMax)
    return maxX >= 0 and minX <= UnityEngine.Screen.width and maxY >= 0 and minY <= UnityEngine.Screen.height
end

this.UpdateGotoNewBtn = function()
    if this.gotoNewBtn == nil then
        return
    end
    SetActive(this.gotoNewBtn.gameObject, this.newNovelItem ~= nil and this.IsNewNovelInScreen() == false)
end

this.GetNextCirclePoint = function(px, py, rad)
    local c = math.cos(rad)
    local s = math.sin(rad)
    local x = px * c + py * s
    local y = -px * s + py * c
    return x, y
end





this.RecycleItem = function()
    for i = 1, #this.novelItems do
        local item = this.novelItems[i]
        item:Clear()
        SetActive(item.gameObject, false)
        table.insert(this.novelItemCache, item)
    end
    this.novelItems = {}
end

this.DestroyItems = function()
    for i = 1, #this.novelItems do
        this.novelItems[i]:Destroy()
    end
    for i = 1, #this.novelItemCache do
        this.novelItemCache[i]:Destroy()
    end
    this.novelItems = {}
    this.novelItemCache = {}
    this.lastNovelItem = nil
    this.newNovelItem = nil
end



local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.introBtn, this.OnClickIntroBtn)
        LuaMgr.AddClick(this.gotoNewBtn, this.OnClickGotoNewBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
        this.StopCircleTween()
    end,
    before_destroy = function()
        this.StopCircleTween()
        this.circleDragTrans:SetData(1, nil, nil, nil)
        this.circleDragTrans:SetDragData(nil, nil)
        LuaMgr.RemoveClick(this.introBtn, this.OnClickIntroBtn)
        LuaMgr.RemoveClick(this.gotoNewBtn, this.OnClickGotoNewBtn)
        this.DestroyItems()
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
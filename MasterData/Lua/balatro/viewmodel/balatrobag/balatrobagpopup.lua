





require("Balatro/ViewModel/BalatroBag/BrandBagItemGroup")
require("Balatro/ViewModel/BalatroBag/BrandBagTips")
BalatroBagPopup = {}
BalatroBagPopup.__index = BalatroBagPopup
local this = {
    scrollView = nil,
    tipsTopData = nil,
    tipsBottomData = nil
}
local objs = {
    rowGroup = {path = "template/Group", type = BalatroUtil.GameObject},
    brandItem = {path = "template/BalatroBagBrandItem", type = BalatroUtil.GameObject},
    maskBtn = {path = "root/Mask", type = BalatroUtil.Button},
    scrollViewObj = {path = "root/Middle/ScrollView", type = BalatroUtil.OnDragBehaviour},
    content = {path = "root/Middle/ScrollView/Viewport/Content", type = BalatroUtil.GameObject},
    tipsTop = {path = "root/Middle/TipsTop", type = BalatroUtil.GameObject},
    tipsBottom = {path = "root/Middle/TipsBottom", type = BalatroUtil.GameObject},
    exitBtn = {path = "root/Middle/ExitBtn", type = BalatroUtil.Button}
}

this.before_awake = function()
    this.LoadItemScrollView()
    this.tipsTopData = BrandBagTips.New(this.tipsTop)
    this.tipsBottomData = BrandBagTips.New(this.tipsBottom)
end

this.before_active = function()
    this.CloseBrandInfoTips()
    this.LoadItemScrollView()
end

this.before_deactive = function()
end

this.ScreenAdapter = function()
    this.scrollWidth = 996
end

this.OnClickBack = function()
    this.CloseBrandInfoTips()
    LuaMgr.HidePanel(UIName.BalatroBagPopup)
end

this.OnClickMask = function ()
    this.CloseBrandInfoTips()
end

this.LoadItemScrollView = function()
    local validBrands = BalatroDataMgr.GetOwnerBaltatroBrand(true)
    if not validBrands then
        return
    end
    local validBrandCount = #validBrands
    local rowMaxCount = 5
    local viewportMaxCount = 15
    local rowCount = 3
    if validBrandCount > viewportMaxCount then
        if validBrandCount % rowMaxCount == 0 then
            rowCount = math.floor(validBrandCount / rowMaxCount)
        else
            rowCount = math.floor(validBrandCount / rowMaxCount) + 1
        end
    end
    if this.scrollView == nil then
        this.scrollView = UIScrollView.New(this.scrollViewObj.gameObject)
    end
    local groupWidth, groupHight = 950, 190
    local scrollDatas = {}
    for i = 1, rowCount do
        local groupData = {}
        groupData.item = this.brandItem
        groupData.list = {}
        groupData.itemCount = rowMaxCount
        local lastPos = (i - 1) * rowMaxCount
        for j = 1, rowMaxCount do
            local tempBrand = validBrands[lastPos + j]
            if (tempBrand ~= nil) then
                table.insert(groupData.list, tempBrand)
            end
        end
        local scrollData = UIScrollData.GetData(this.rowGroup, "BrandBagItemGroup", groupWidth, groupHight, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(this.scrollWidth, 596)
    this.scrollView:SetData(scrollDatas, true)
    this.scrollViewObj.onBeginDrag = this.OnBeginDrag
end

this.OnBeginDrag = function(index, eventData)
    SetActive(this.tipsTop, false)
    SetActive(this.tipsBottom, false)
end


this.OpenBrandInfoTips = function(params)
    if not params or params.Length < 1 then
        return
    end

    local brandItem = params[0]

    local tempTips = nil
    local offsetY = 0
    SetActive(this.tipsTop, false)
    SetActive(this.tipsBottom, false)
    if RaycastTool.GetMousePosition().y < LuaMgr.ScreenHeight() / 2 then
        tempTips = this.tipsTopData
        offsetY = 60
    else
        tempTips = this.tipsBottomData
        offsetY = -153
    end
    if tempTips == nil then
        LuaDebug.error("this.OpenBrandInfoTips : UI绑定异常")
        return
    end

    local newPos = Vector3.zero
    local brandItemData = brandItem:GetData()
    local gameObject = brandItem:GetGameObject()
    local transferPos = RectTransformTool.ToContainer(gameObject.transform, tempTips.gameObject.transform.parent)
    print(transferPos.x, transferPos.y)
    tempTips:SetData(brandItemData)
    newPos.x = transferPos.x
    newPos.y = transferPos.y + offsetY
    tempTips.gameObject.transform.localPosition = newPos
    SetActive(tempTips.gameObject, true)
    tempTips:SetData(brandItemData)
end

this.CloseBrandInfoTips = function()
    SetActive(this.tipsTop, false)
    SetActive(this.tipsBottom, false)
end

this.Update = function()
    if RaycastTool.GetMouseButtonDown(0) then
        this.screenPos = RaycastTool.GetMousePosition()
    end
    if RaycastTool.GetMouseButtonUp(0) then
        local tempScreenPos = RaycastTool.GetMousePosition()
        local deltaPosX = tempScreenPos.x - this.screenPos.x
        local deltaPosY = tempScreenPos.y - this.screenPos.y
        if math.abs(deltaPosX) > 0.2 or math.abs(deltaPosY) > 0.1 then

            this.CloseBrandInfoTips()
            return
        end
        local selectObj = RaycastTool.CurrentSelectedGameObject()
        if selectObj == nil or string.find(selectObj.name, this.brandItem.name, 1, true) == nil then
            this.CloseBrandInfoTips()
        end
    end
end

local data = {}
local command = {}
local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.exitBtn, this.OnClickBack)
        LuaMgr.AddClick(this.maskBtn, this.CloseBrandInfoTips)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroBagOpenTips, this.OpenBrandInfoTips)
        this.ScreenAdapter()
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
        LuaMgr.AddUpdate(this.Update)
    end,
    before_deactive = function(vm)
        this.before_deactive()
		LuaMgr.RemoveUpdate(this.Update)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack)
        LuaMgr.RemoveClick(this.maskBtn, this.CloseBrandInfoTips)
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroBagOpenTips, this.OpenBrandInfoTips)
        UIScrollView.ClearItem("BrandBagItemGroup")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)
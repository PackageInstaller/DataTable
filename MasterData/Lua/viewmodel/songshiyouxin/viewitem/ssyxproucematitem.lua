require("ViewModel/SongShiYouXin/ViewItem/SSYXMakeMatItem")









SSYXProuceMatItem = {}
SSYXProuceMatItem.__index = SSYXProuceMatItem

local objs = {
    noBagObj = {path = "Group/NoBagObj", type = UITool.GameObject},
    bagObj = {path = "Group/BagObj", type = UITool.Transform},
    selectFlag = {path = "Group/SelectFlag", type = UITool.GameObject}
}

SSYXProuceMatItem.New = function(obj)

    local self = {}
    setmetatable(self, SSYXProuceMatItem)
    if obj ~= nil then
        self.gameObject = obj
        self:Init()
    end
    return self
end

function SSYXProuceMatItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.selectBtn = self.gameObject:GetComponent(UITool.Button)
    self.matItem = SSYXMakeMatItem.New(self.noBagObj)
    self.goodsItem = GoodsDataItem.New(self.bagObj)
    if self.selectBtn ~= nil then
        self.OnClickBtn = function()
            if self.data.OnSelectItem ~= nil then
                self.data.OnSelectItem(self)
            end
        end
        LuaMgr.AddClick(self.selectBtn, self.OnClickBtn)
    end
end

function SSYXProuceMatItem:SetData(data)
    self.data = data
    self.bagObj.gameObject:SetActive(self.data.IsInBag == true)
    self.noBagObj.gameObject:SetActive(self.data.IsInBag == false)
    if self.data.IsInBag == true then
        local id = self.data.ID
        local showCount = self.data.Count
        local itemConfig = ConfigMgr.Config.itemMap[id]
        if (itemConfig ~= nil) then
            local itemData = table.Copy(itemConfig)
            itemData.count0 = showCount
            self.goodsItem:SetData(1, itemData, 1, false, self.data.Scale, false, showCount <= 0)
            self.goodsItem:SetCount(self.data.NumText or "0", Vector2(-10, 10), Vector3.one)
            self.goodsItem:SetIconBg(false)
            SetActive(self.goodsItem.goodsBtn.gameObject, false)
        end
    else
        self.matItem:SetData(self.data)
    end
end

function SSYXProuceMatItem:SetSelectFlag(isSelected)
    SetActive(self.selectFlag.gameObject, isSelected == true)
end

function SSYXProuceMatItem:ClearItems()
end

function SSYXProuceMatItem:Clear()
    self:ClearItems()
end

function SSYXProuceMatItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end
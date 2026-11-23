

















CommonRewardItem = {}
CommonRewardItem.__index = CommonRewardItem


CommonRewardItem.Status = {
    None = 0,
    CanGet = 1,
    Got = 2,
    Lock = 3,
    First = 4,
    Complete = 5
}


CommonRewardItem.ResetStatusSlibing = {
    None = 1,
CanGet = 2,
Got = 4,
Lock = 8,
First = 16
}

local objs = {}

CommonRewardItem.New = function(prefab, notInstantiate, scale, resetStatusSlibing, parent)

    local self = {}
    setmetatable(self, CommonRewardItem)
    if scale == nil then
        scale = 0.8
    end
    self.resetStatusSlibing = resetStatusSlibing or (CommonRewardItem.ResetStatusSlibing.CanGet | CommonRewardItem.ResetStatusSlibing.Got)
    self.goodsItemScale = Vector3(scale, scale, scale)
    if notInstantiate == true then
        self.gameObject = prefab
        self:Init()
    end
    if notInstantiate == false and parent ~= nil then
        self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
        self:Init()
    end
    return self
end

function CommonRewardItem:Init()
    self.rewardItems = {}
    UITool.Parse(self.gameObject, self, objs)
    self.normalTrans = self.gameObject.transform:Find("NormalObj")
    self.canGetTrans = self.gameObject.transform:Find("CanGetObj")
    self.gotTrans = self.gameObject.transform:Find("GotObj")
    self.lockTrans = self.gameObject.transform:Find("LockObj")
    self.firstTrans = self.gameObject.transform:Find("FirstObj")
    local goosParent = self.gameObject.transform:Find("Group")
    if IsNull(goosParent) then
        goosParent = self.gameObject.transform
    end

    self.goodsItem = GoodsDataItem.New(goosParent)
    if self.normalTrans ~= nil and (self.resetStatusSlibing & CommonRewardItem.ResetStatusSlibing.None) ~= 0 then
        self.normalTrans:SetSiblingIndex(self.gameObject.transform.childCount - 1)
    end
    if self.canGetTrans ~= nil and (self.resetStatusSlibing & CommonRewardItem.ResetStatusSlibing.CanGet) ~= 0 then
        self.canGetTrans:SetSiblingIndex(self.gameObject.transform.childCount - 1)
    end
    if self.gotTrans ~= nil and (self.resetStatusSlibing & CommonRewardItem.ResetStatusSlibing.Got) ~= 0 then
        self.gotTrans:SetSiblingIndex(self.gameObject.transform.childCount - 1)
    end
    if self.lockTrans ~= nil and (self.resetStatusSlibing & CommonRewardItem.ResetStatusSlibing.Lock) ~= 0 then
        self.lockTrans:SetSiblingIndex(self.gameObject.transform.childCount - 1)
    end
    if self.firstTrans ~= nil and (self.resetStatusSlibing & CommonRewardItem.ResetStatusSlibing.First) ~= 0 then
        self.firstTrans:SetSiblingIndex(self.gameObject.transform.childCount - 1)
    end
end

function CommonRewardItem:SetData(data)
    if data ~= nil then
        self.data = data.data
    end
    if type(self.data.scale) == "number" then
        self.goodsItemScale = Vector3(self.data.scale, self.data.scale, self.data.scale)
    elseif self.data.scale ~= nil then
        self.goodsItemScale = self.data.scale
    end
    self:SetItem()
end

function CommonRewardItem:SetData1(data)
    if data ~= nil then
        self.data = data
    end
    if type(self.data.scale) == "number" then
        self.goodsItemScale = Vector3(self.data.scale, self.data.scale, self.data.scale)
    elseif self.data.scale ~= nil then
        self.goodsItemScale = self.data.scale
    end
    self:SetItem()
end

function CommonRewardItem:SetItem()
    local id = self.data.id
    local showCount = self.data.count
    local itemConfig = ConfigMgr.Config.itemMap[id]
    if (itemConfig ~= nil) then
        local itemData = table.Copy(itemConfig)
        itemData.count0 = showCount
        self.goodsItem:SetData(1, itemData, 1, false, self.goodsItemScale, false, showCount <= 0)
        self.goodsItem:SetCount(nil, Vector2(-10, 10), Vector3.one)
        self.goodsItem:SetIconBg(false)
    end
    self:RefreshStatus()
end


function CommonRewardItem:SetStatus(status)
    self.data.status = status
    self:RefreshStatus()
end

function CommonRewardItem:RefreshStatus()
    if self.normalTrans ~= nil then
        SetActive(self.canGetTrans.gameObject, self.data.status == CommonRewardItem.Status.None or self.data.status == nil)
    end
    if self.canGetTrans ~= nil then
        SetActive(self.canGetTrans.gameObject, self.data.status == CommonRewardItem.Status.CanGet)
    end
    if self.gotTrans ~= nil then
        SetActive(self.gotTrans.gameObject, self.data.status == CommonRewardItem.Status.Got)
    end
    if self.lockTrans ~= nil then
        SetActive(self.lockTrans.gameObject, self.data.status == CommonRewardItem.Status.Lock)
    end
    if self.firstTrans ~= nil then
        SetActive(self.firstTrans.gameObject, self.data.status == CommonRewardItem.Status.First)
    end
end

function CommonRewardItem:ClearItems()
end

function CommonRewardItem:Clear()
    self:ClearItems()
end

function CommonRewardItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.data = nil
    self.gameObject = nil
end

local BigMiddleScrollView = BaseClass("BigMiddleScrollView", UIBaseComponent)
local M = BigMiddleScrollView

function M:__init(bigMiddleScrollView)
    self._dataList = {}
    self._itemList = {}
    self._itemViewDic = {}
    self._itemType = nil
    self._itemViewType = nil
    self._isDataLua = true
    self._createItemCallback = nil
    self._csBigMiddleScrollView = bigMiddleScrollView
    self._dragCallback = nil
    if IsNull(bigMiddleScrollView) then
        Logger.LogError("MiddleScrollView is nil ")
    end

    self._cellUpdateCallBack = nil
end

function M:OnCreate(unity_bigMiddleScrollView)
    self._dataList = {}
    self._itemList = {}
    self._itemViewDic = {}
    self._itemType = nil
    self._itemViewType = nil
    self._isDataLua = true
    self._createItemCallback = nil
    self._csBigMiddleScrollView = unity_bigMiddleScrollView
    self._dragCallback = nil
    if IsNull(unity_bigMiddleScrollView) then
        Logger.LogError("MiddleScrollView is nil ")
    end

    self._cellUpdateCallBack = nil
end

function M:Init(itemType, itemViewType, dragCallback)
    self._cellUpdateCallBack = function(go, idx)
        if not self._isDataLua then
            idx = idx - 1

            if idx < 0 then
                idx = 0
            end
        end

        self:_CellUpdate(go, idx)
    end
    self._csBigMiddleScrollView:Init(self._cellUpdateCallBack)
    self._itemType = itemType
    self._itemViewType = itemViewType
    self._dragCallback = dragCallback
    self._getDataCallback = nil
end

function M:InitByFunc(callback)
    self._cellUpdateCallBack = callback
    self._csBigMiddleScrollView:Init(self._cellUpdateCallBack)
end

--当容器改变时，可以调用此方法刷新布局
function M:ReFreshLayout()
    self._csBigMiddleScrollView:ReFreshLayout()
end

--设置数据长度或获取数据方法  和SetDataList二选一
function M:SetData(length, getDataCallback)
    self._dataList = nil
    self._getDataCallback = getDataCallback
    self._csBigMiddleScrollView:ShowList(length)
end

--设置数据列表  和SetData二选一 , filterCallback 可选，用于筛选
function M:SetDataList(dataList, filterCallback)
    if not dataList then
        dataList = {}
    end

    self._isDataLua = true
    -- CS List , so the index is going to be from 0
    if type(dataList) == "userdata" then
        self._isDataLua = false
    end

    self._dataList = dataList
    self._csBigMiddleScrollView:ShowList(#dataList)
end

--获得所有数据
function M:GetDataList()
    return self._dataList
end

--主动刷新
function M:UpdateList()
    self._csBigMiddleScrollView:UpdateList()
end

--当创建ITEM时调用
function M:SetCreateItemCallback(callback)
    self._createItemCallback = callback
end

function M:GetItems()
    return self._itemList
end

-- 获取当前的中间选中的item的索引，并+1转换成lua的索引
function M:GetCurCenterId()
    return self._csBigMiddleScrollView:GetCurCenterId() + 1;
end

-- 中间item的索引变化时回调注册
function M:SetCenterChangedAction(centerChangedAction)
    local actionWrap = function (curItemIdForm0)
        centerChangedAction(curItemIdForm0 + 1, self:GetItemByIdx(curItemIdForm0))
        self:UpdateList()
    end
    self._csBigMiddleScrollView:SetCenterChangedAction(actionWrap)
end

function M:_CellUpdate(go, idx)
    local itemView = nil
    if self._itemViewDic[go] then
        itemView = self._itemViewDic[go]
    else
        itemView = self._itemViewType.New(go.transform)
        self._itemViewDic[go] = itemView
    end

    local item = self._itemList[go]
    if item == nil then
        item = self._itemType.New(itemView)
        self._itemList[go] = item
        if item.SetCircularScroll then
            item:SetCircularScroll(self)
        end
        if self._createItemCallback then
            self._createItemCallback(item)
        end
    end

    local luaIdx = idx
    if self._dataList ~= nil then
        local data = self._dataList[luaIdx]
        item:UpdateItem(data, idx)
    elseif self._getDataCallback then
        local data = self._getDataCallback(luaIdx)
        item:UpdateItem(data, idx)
    end

    if self._dragCallback then
        self._dragCallback(luaIdx)
    end
end

function M:OnDestroy()
    M.super.OnDestroy(self)
    self:Dispose()
end

function M:Dispose()
    if self._hasDestoryed then
        return
    end
    self._hasDestoryed = true
    if self._itemList ~= nil then
        for i, v in pairs(self._itemList) do
            if v.OnDestroy then
                v:OnDestroy()
            elseif v.Dispose then
                v:Dispose()
            elseif v.OnDispose then
                v:OnDispose()
            end
        end
    end

    self._dataList = nil
    self._itemList = nil
    self._itemViewDic = nil
    self._itemType = nil
    self._itemViewType = nil
    if self._csBigMiddleScrollView then
        self._csBigMiddleScrollView:DisposeAll()
    end
    self._csBigMiddleScrollView = nil
    self._getDataCallback = nil
    self._cellUpdateCallBack = nil
    self._dragCallback = nil
end

function M:GetItemByIdx(idx)
    if self._itemList then
        for _, item in pairs(self._itemList) do
            local itemIdx = tonumber(item.view:GetName()) or -1
            if itemIdx == idx then return item end
        end
    end
    return nil
end

function M:SetActive(v)
    self._csBigMiddleScrollView.gameObject:SetActive(v)
end

function M:SetHeightAndWidth(width, height)
    self._csBigMiddleScrollView.cellWidth = width
    self._csBigMiddleScrollView.cellHeight = height
end

-- 跳转指定索引并选择
function M:GoToItemByIndex(index, isReset)
    if isReset == nil then isReset = false end -- 如果isReset为false，重置上一次记录的索引为-1
    local curindex = index - 1
    self._csBigMiddleScrollView:SetCenterChild(curindex, isReset)
end

-- 中间选项左移，step步长，默认为一
function M:MoveLeftArrow(step)
    if step == nil then
        step = 1
    end
    self._csBigMiddleScrollView:MoveLeftArrow(step)
end


-- 中间选项右移，step步长，默认为一
function M:MoveRightArrow(step)
    if step == nil then
        step = 1
    end
    self._csBigMiddleScrollView:MoveRightArrow(step)
end

function M:SetCenterChild(idx)
    idx = idx - 1 --转换为c#索引 从0开始
    if  idx < 0 then
        idx = 0
    end
    self._csBigMiddleScrollView:SetCenterChild(idx)
end

return BigMiddleScrollView

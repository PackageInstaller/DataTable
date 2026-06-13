---使用说明
---1、View中绑定UNITY 中的CircularScrollView ，如 view.unity_circularView
---2、创建 local CircularScrollViewClass = require("UI.Component.CircularScrollView")
---        local circularView = CircularScrollViewClass.New(view.unity_circularView)
---        circularView.Init(require("XXXXItemCtrl"),require("XXXXXItemView")))
---        XXXXItemCtrl 需要实现UpdateItem(data)方法
---2、设置数据 circularView:SetDataList(dataList) dataList为具体数据
---         或：circularView:SetData(length,getDataCallback) length 为数据长度，getDataCallback为获取
---             数据函数，参数为index ，即由调用者自己来返回数据
---3、Item显示 XXXXItemCtrl 需要实现UpdateItem(data)方法,刷新方法在这里实现
---4、XXXXItemCtrl 构造函数为view  (XXXXXItemView实例) ,
local CircularScrollView = BaseClass("CircularScrollView", UIBaseComponent)
local M = CircularScrollView

function M:__init(circularScrollView)
    self._dataList = {}
    self._itemList = {}
    self._itemViewDic = {}
    self._itemType = nil
    self._itemViewType = nil
    self._isDataLua = true
    self._createItemCallback = nil
    self._csUICircularScrollView = circularScrollView
    self._dragCallback = nil
    if IsNull(circularScrollView) then
        Logger.LogError("circularScrollView is nil ")
    end

    self._cellUpdateCallBack = nil
end

function M:OnCreate(unity_circularScrollView)
    self._dataList = {}
    self._itemList = {}
    self._itemViewDic = {}
    self._itemType = nil
    self._itemViewType = nil
    self._isDataLua = true
    self._createItemCallback = nil
    self._csUICircularScrollView = unity_circularScrollView
    self._dragCallback = nil
    if IsNull(unity_circularScrollView) then
        Logger.LogError("circularScrollView is nil ")
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
    self._csUICircularScrollView:Init(self._cellUpdateCallBack)
    self._itemType = itemType
    self._itemViewType = itemViewType
    self._dragCallback = dragCallback
    self._getDataCallback = nil
end

function M:InitByFunc(callback)
    self._cellUpdateCallBack = callback
    self._csUICircularScrollView:Init(self._cellUpdateCallBack)
end

--当容器改变时，可以调用此方法刷新布局
function M:ReFreshLayout()
    self._csUICircularScrollView:ReFreshLayout()
end

--设置数据长度或获取数据方法  和SetDataList二选一
function M:SetData(length, getDataCallback)
    self._dataList = nil
    self._getDataCallback = getDataCallback
    self._csUICircularScrollView:ShowList(length)
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
    self._csUICircularScrollView:ShowList(#dataList)
end

--获得所有数据
function M:GetDataList()
    return self._dataList
end

--主动刷新
function M:UpdateList()
    self._csUICircularScrollView:UpdateList()
end

--当创建ITEM时调用
function M:SetCreateItemCallback(callback)
    self._createItemCallback = callback
end

function M:GetItems()
    return self._itemList
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
    if self._csUICircularScrollView then
        self._csUICircularScrollView:DisposeAll()
    end
    self._csUICircularScrollView = nil
    self._getDataCallback = nil
    self._cellUpdateCallBack = nil
    self._dragCallback = nil
end

function M:GetItemByIdx(idx)
    if self._itemList then
        for _, item in pairs(self._itemList) do
            local itemIdx = tonumber(item:GetName()) or -1
            if itemIdx == idx then return item end
        end
    end
    return nil
end

function M:SetActive(v)
    self._csUICircularScrollView.gameObject:SetActive(v)
end

function M:SetHeightAndWidth(width, height)
    self._csUICircularScrollView.cellWidth = width
    self._csUICircularScrollView.cellHeight = height
end

function M:SetHorizontalNormalizedByIndex(index)
    self._csUICircularScrollView:SetHorizontalNormalizedByIndex(index)
end

function M:SetDragState(value)
    self._csUICircularScrollView:SetDragState(value)
end

function M:SetVerticalNormalizedByIndex(index)
    self._csUICircularScrollView:SetVerticalNormalizedByIndex(index)
end

function M:MoveNextPosition()
    self._csUICircularScrollView:MoveNextPosition()
end

function M:MoveLastPosition()
    self._csUICircularScrollView:MoveLastPosition()
end

function M:ListPageValueInit(value)
    self._csUICircularScrollView:ListPageValueInit(value)
end

function M:BtnLeftGo()
    self._csUICircularScrollView:BtnLeftGo()
end

function M:BtnRightGo()
    self._csUICircularScrollView:BtnRightGo()
end

function M:AlignmentContentPosition(idx, pos)
    if not pos then pos = 0 end
    self._csUICircularScrollView:AlignmentContentPosition(idx, pos)
end

function M:SetHorizontal(canDrag)
    self._csUICircularScrollView:SetHorizontal(canDrag);
end

function M:SetVertical(canDrag)
    self._csUICircularScrollView:SetVertical(canDrag);
end

return CircularScrollView

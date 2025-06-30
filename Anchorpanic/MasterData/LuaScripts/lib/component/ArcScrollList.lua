module('lib.component.ArcScrollList', Class.impl())
--[[_s
@todo: 弧型Scroll处理器
@author: ZDH
]]
function init(self, go)
    self.UIObject = go
    self.scroll = go:GetComponent(ty.ArcScrollListView)
    self.scroll.SelectEvent = function(index)
        self.selectIndex = index + 1
        if not table.empty(self.items) then
            for i = 1, #self.items do
                if i == self.selectIndex then
                    self.items[i]:onSelect()
                else
                    self.items[i]:onNormal()
                end
            end
        end
        if self.mSelectEvent then 
            self.mSelectEvent(index + 1)
        end
    end
    self.scroll.DragSelectEvent = function (index)
        if not table.empty(self.items) then
            for i = 1, #self.items do
                if i == index + 1 then
                    self.items[i]:onSelect()
                else
                    self.items[i]:onNormal()
                end
            end
        end
        if self.mDragSelectEvent then
            self.mDragSelectEvent(index + 1)
        end
    end

    self.items = {}
    self.selectIndex = -1
end

function setData(self, param)
    self.data = param
    if not self.scroll then
        return
    end

    self.scroll:SetData(#self.data)
    if self.renerderClass ~= nil then
        local itemList = self.scroll.itemList
        for i = 1, #self.data do
            local item = self.items[i]
            if item == nil then
                item = self.renerderClass:new()
                item:init(i, itemList[i - 1].gameObject, self)
                self.items[i] = item
            end
            item:SetData(self.data[i])

            if i == self.selectIndex then
                item:onSelect()
            else
                item:onNormal()
            end
        end
    end
end

function SetMaxIndex(self,index)
     if self.scroll then
        self.scroll.MaxSelectIndex = index
    end
end

function UpdateRedState(self, index, value)
    if not self.items[index] then return end
    self.items[index]:UpdateRedState(value)
end

function SelectIndex(self, index)
    if self.scroll then
        self.scroll.SelectIndex = index - 1
    end
end

function GetSelectIndex(self)
    return self.scroll.SelectIndex
end

function SetSelectEvent(self, event)
    self.mSelectEvent = event
end

function SetDragSelectEvent(self, event)
    self.mDragSelectEvent = event
end

function SetBottomDragEvent(self,event)
    self.scroll.BottomDragEvent = event
end

function getData(self)
    return self.data
end

function setRenerder(self, class)
    self.renerderClass = class
end

-- 销毁
function deActive(self)
    self.scroll:deActive()
    self.scroll = nil

    for k, v in pairs(self.items) do
        v:deActive()
        v = nil
    end
    self.items = nil
    self.mSelectEvent = nil
    self.mDragSelectEvent = nil
end

return _M
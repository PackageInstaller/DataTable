module("cycle.CycleGroupItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleGroupItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mNodeItems = {}
    self.mMapItems = {}
end

function configUI(self)
    super.configUI(self)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)

    self:clearChildList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function setData(self, cusParent)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
end

function updateRowDic(self,row,dic)
    self.row = row
    self:clearChildList()
    for i = 1, 7 do
        local nodel = cycle.CycleNodeItem:poolGet()
        nodel:setData(self.UIObject.transform, self.mData)
        table.insert(self.mNodeItems, nodel)
    end

    for k, v in pairs(dic) do
        local map = cycle.CycleMapItem:poolGet()
        map:setData(self.mNodeItems[v.col].UIObject.transform, v, self.mNodeItems[1])
        cycle.CycleManager:setMapClassIdCopyData(v.id,map)
        table.insert(self.mMapItems, map)
    end

    cycle.CycleManager:setMapClassCopyData(self.row,self.mGroupItems)
end

function clearChildList(self)
    self:clearMapItems()
    self:clearEmptyItems()
end

function clearEmptyItems(self)
    for i = 1, #self.mNodeItems do
        self.mNodeItems[i]:poolRecover()
    end
    self.mNodeItems = {}
end

function clearMapItems(self)
    for i = 1, #self.mMapItems do
        self.mMapItems[i]:poolRecover()
    end
    self.mMapItems = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

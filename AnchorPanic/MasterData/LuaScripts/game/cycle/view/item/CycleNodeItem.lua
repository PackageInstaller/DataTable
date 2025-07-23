module("cycle.CycleNodeItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleNodeItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
end

function configUI(self)
    super.configUI(self)
end

function active(self)
    super.active(self)
end


function deActive(self)
    super.deActive(self)
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

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData

    self:updateView()
end

function updateView(self)
    
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

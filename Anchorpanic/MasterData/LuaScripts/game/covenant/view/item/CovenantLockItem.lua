module("covenant.CovenantLockItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("covenant/item/CovenantLockItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function setData(self,cusParent,id)
    self:setParentTrans(cusParent)
    self.mLockTxt.text = _TT(id)
end

function configUI(self)
    self.mLockTxt = self:getChildGO("LockTxt"):GetComponent(ty.Text)
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


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

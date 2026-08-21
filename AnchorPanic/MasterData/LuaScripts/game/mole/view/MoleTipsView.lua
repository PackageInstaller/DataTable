
module('mole.MoleTipsView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mole/MoleTipsView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtContent.text = _TT(139152)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
end


return _M

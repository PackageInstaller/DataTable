--[[ 
-----------------------------------------------------
@filename       : ShowAwardEmptyItem
@Description    : 空节点奖励展示用于虚拟列表
@date           : 2024-08-01 15:50:03
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module("ShowAwardEmptyItem", Class.impl("lib.component.BaseItemRender"))

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

function initData(self)
    self.mGrid = nil
end
function onDelete(self)
    super.onDelete(self)
    self:clean()
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

function setData(self,propsVo)
    super.setData(self, propsVo)
    self:updateView()
end


function updateView(self)
    self:clean()
    self.mGrid = PropsGrid:createByData({ tid = self.data.tid, num = self.data.num, parent = self.UITrans,scale = 1, showUseInTip = true })
    -- self.mGrid:setIsShowName(true)
    -- self.mGrid:setTween(true)
end

function clean(self)
    if (self.mGrid) then
        self.mGrid:poolRecover()
        self.mGrid = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
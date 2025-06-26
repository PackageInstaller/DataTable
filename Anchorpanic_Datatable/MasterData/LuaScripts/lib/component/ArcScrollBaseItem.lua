module('lib.component.ArcScrollBaseItem', Class.impl("lib.component.BaseNode"))
--[[_s
@todo: 弧形Scroll Item模板类
@author: ZDH
]]
function init(self, index, go, listView)
    self.index = index
    self.ListView = listView
    self.UIObject = go

    self:initData()
end

function initData(self)
    super.initData(self, self.UIObject)

    if self.UIObject:GetComponent(ty.Button) then
        self:addOnClick(self.UIObject, function()
            self.ListView:SelectIndex(self.index)
        end)
    end
end

--设置数据
function SetData(self, data)
    self.data = data
    self:onUpdate()
end

--更新数据显示(子类继承)
function onUpdate(self)
end

--选中(子类继承)
function onSelect(self)

end
--未选中(子类继承)
function onNormal(self)

end

-- 移除侦听点击事件
function removeOnClick(self)
    gs.UIComponentProxy.RemoveListener(self.UIObject)
end

-- 销毁
function deActive(self)
    self:removeSelf()

    self.UIObject = nil

    self.m_childGos = nil
    self.m_childTrans = nil
end

return _M

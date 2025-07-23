module("formation.FormationPreviewManager", Class.impl(formation.FormationManager))

-- 修改切换列表
CHANGE_SELECT = "CHANGE_SELECT"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
    self.selectMonster = nil
end

-- 阵型类型
function getType(self)
    return formation.TYPE.NORMAL
end

function setSelectMonster(self, id)
    self.selectMonster = id
end

function getSelectMonster(self)
    return self.selectMonster
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
end

return _M
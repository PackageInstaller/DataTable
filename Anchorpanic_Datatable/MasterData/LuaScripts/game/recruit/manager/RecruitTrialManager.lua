--[[ 
-----------------------------------------------------
@filename       : RecruitTrialManager
@Description    : 主线探索数据管理器
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("recruit.RecruitTrialManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__init()
end

function __init(self)
end

-- 战斗结算界面用
function getDupName(self, tileId)
    return _TT(580)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(580):	"战员试用"
	语言包: _TT(63025):	"主线探索"
]]

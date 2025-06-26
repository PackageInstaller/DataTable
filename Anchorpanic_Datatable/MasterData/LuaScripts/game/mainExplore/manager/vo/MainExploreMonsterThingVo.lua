--[[ 
-----------------------------------------------------
@filename       : MainExploreMonsterThingVo
@Description    : 主线探索实体怪物数据
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreMonsterThingVo", Class.impl(mainExplore.MainExploreBaseThingVo))

--对象唤醒时回调
function onAwake(self)
	super.onAwake(self)
end

--对象回收时回调
function onRecover(self)
	super.onRecover(self)
end

--对象删除时回调
function onDelete(self)
	super.onDelete(self)
end

function initData(self)
	super.initData(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

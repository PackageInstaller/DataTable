--[[ 
-----------------------------------------------------
@filename       : MainExploreMonsterThingVo
@Description    : 主线探索实体玩家数据
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExplorePlayerThingVo", Class.impl(mainExplore.MainExploreBaseThingVo))

-- 移动变化（改变本身，且强制同步Agent）
MOVE_CHANGE_NOW = "MOVE_CHANGE_NOW"

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

function setPlayerConfigVo(self, playerConfigVo)
	self.mPlayerConfigVo = playerConfigVo
end

function getPlayerConfigVo(self)
	return self.mPlayerConfigVo
end

-- 设置坐标
function setPositionNow(self, pos)
	self:setPosXYZNow(pos.x, pos.y, pos.z)
end

-- 设置坐标
function setPosXYZNow(self, cusX, cusY, cusZ)
	self.mPos.x = cusX
	self.mPos.y = cusY
	self.mPos.z = cusZ
	self:dispatchEvent(self.MOVE_CHANGE_NOW)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

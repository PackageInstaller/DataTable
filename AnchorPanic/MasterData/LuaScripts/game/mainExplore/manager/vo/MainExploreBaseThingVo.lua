--[[ 
-----------------------------------------------------
@filename       : MainExploreBaseThingVo
@Description    : 主线探索实体基类数据
@date           : 2022-3-29 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreBaseThingVo", Class.impl("lib.event.EventDispatcher"))

-- 移动变化（只改变本身，无法改变Agent）
MOVE_CHANGE = "MOVE_CHANGE"
-- 朝向变化
DIR_CHANGE = "DIR_CHANGE"
-- 大小变化
SCALE_CHANGE = "SCALE_CHANGE"

function ctor(self)
	super.ctor(self)
end

function dtor(self)
	super.dtor(self)
end

--对象唤醒时回调
function onAwake(self)
	self.mId = SnMgr:getSn()
	self:initData()
end

--对象回收时回调
function onRecover(self)
	SnMgr:disposeSn(self.mId)
	self.mId = nil
end

--对象删除时回调
function onDelete(self)
	SnMgr:disposeSn(self.mId)
	self.mId = nil
end

function initData(self)
	self.mPos = math.Vector3(0, 0, 0)
	self.mAngle = math.Vector3(0, 0, 0)
	self.mScale = math.Vector3(1, 1, 1)
end

-- 对象唯一id
function getID(self)
	return self.mId
end

-- 设置物件类型
function setType(self, type)
	self.mType = type
end

-- 获取物件类型
function getType(self)
	return self.mType
end

-- 设置事件配置
function setEventConfigVo(self, eventConfigVo)
	self.mEventConfigVo = eventConfigVo
end

-- 获取事件配置
function getEventConfigVo(self)
	return self.mEventConfigVo
end

-- 设置坐标
function setPosition(self, pos)
	self:setPosXYZ(pos.x, pos.y, pos.z)
end

-- 设置坐标
function setPosXYZ(self, cusX, cusY, cusZ)
	self.mPos.x = cusX
	self.mPos.y = cusY
	self.mPos.z = cusZ
	self:dispatchEvent(self.MOVE_CHANGE)
end

-- 获取坐标
function getPosition(self)
	return self.mPos
end

-- 设置朝向
function setRotation(self, cusRotation)
	self:setRotationXYZ(cusRotation.eulerAngles.x, cusRotation.eulerAngles.y, cusRotation.eulerAngles.z)
end

-- 设置朝向
function setRotationXYZ(self, cusX, cusY, cusZ)
	self.mAngle.x = cusX
	self.mAngle.y = cusY
	self.mAngle.z = cusZ
	self:dispatchEvent(self.DIR_CHANGE)
end

-- 获取朝向
function getRotation(self)
    return self.mAngle
end

-- 设置大小
function setScale(self, cusScale)
	self:setScaleXYZ(cusScale.x, cusScale.y, cusScale.z)
end

-- 设置大小
function setScaleXYZ(self, cusX, cusY, cusZ)
	self.mScale.x = cusX
	self.mScale.y = cusY
	self.mScale.z = cusZ
	self:dispatchEvent(self.SCALE_CHANGE)
end

-- 获取大小
function getScale(self)
    return self.mScale
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

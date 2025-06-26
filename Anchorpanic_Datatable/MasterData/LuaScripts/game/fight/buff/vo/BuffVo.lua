--[[
****************************************************************************
Brief  :BuffVo 中的数据对象
Author :James Ou
Date   :2020-02-17
****************************************************************************
]]
module("Buff.BuffVo", Class.impl())
-------------------------------
--构造函数
function ctor(self)
	self.mc_sn = SnMgr:getSn()
	self:init()
end

function init(self)
	-- 带buff实体
	self.m_entity = nil
	-- 施法者
	self.m_casterID = nil
	self.m_refID = nil
	self.m_overCount = 0
end

function dtor(self)
	SnMgr:disposeSn(self.mc_sn)
	self.mc_sn = nil
end

function sn(self)
	return self.mc_sn
end
-- 被回收
function onRecover(self)
	self:removeEft()
	self:init()
end

function addOverCount( self )
	self.m_overCount = self.m_overCount+1
end
function reductionOverCount( self )
	self.m_overCount = self.m_overCount-1
end

function overCount( self )
	return self.m_overCount
end

function getRefID(self)
	return self.m_refID
end

function setRefID( self, refID )
	self.m_refID = refID
end
-- 设置施法者
function setCaster(self, casterID)
	-- -- 这情况可能有问题
	-- if self.m_casterID~=nil and self.m_casterID~=casterID then
	-- end
	self.m_casterID = casterID
end
function getCaster(self)
	return self.m_casterID
end

-- 设置buff的载体角色
function setEntity(self, entity)
	self.m_entity = entity
end
function getEntity(self)
	return self.m_entity
end
--添加特效
function addEft(self)
	GameDispatcher:dispatchEvent(EventName.BUFF_ADD_EFT, self)
end
-- 移除特效
function removeEft(self)
	GameDispatcher:dispatchEvent(EventName.BUFF_REMOVE_EFT, self)
end

-- 移除特效
function updateEft(self)
	GameDispatcher:dispatchEvent(EventName.BUFF_UPDATE_EFT, self)
end

return _M


 
--[[ 替换语言包自动生成，请勿修改！
]]

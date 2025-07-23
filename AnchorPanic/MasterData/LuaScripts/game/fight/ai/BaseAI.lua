module("fight.BaseAI", Class.impl())

function ctor(self,cusVo)
	self.vo = cusVo;
	self.id = self.vo.id;
	self:init();
	RateLooper:addFrame(1,0,self,self.step);
end

function dtor(self)
	RateLooper:removeFrame(self,self.step);
end

function step(self)
	self:findTarget();
	if self.target == nil then
		return;
	end;

	local attack = self:tryToAttack();
	if attack.succ == false then
		self:tryToMove(attack.range);
	end
end

function init(self)
	self.targetAI = require("game/fight/ai/target/Target_1");
	self.moveAI = require("game/fight/ai/move/Move_1").new(self.vo);
end

function findTarget(self)
	--后面要根据target状态判断是否需要重新寻找目标，如死了，虚化了等状态导致不能被攻击时
	if self.target == nil then
		self.target = self.targetAI:findTarget(self.vo);
	end
end

function tryToAttack(self)
	return {succ = false,range = 1};
end

function tryToMove(self,cusRange)
	local targetTile = fight.SceneUtil.removeRangeTargetTile(self.vo,self.target,cusRange);
	if targetTile ~= nil then
		self.moveAI:moveTo(targetTile);
	end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

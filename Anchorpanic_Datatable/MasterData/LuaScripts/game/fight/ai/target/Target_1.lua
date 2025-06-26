module("fight.Target_1", Class.impl())

function ctor(self)

end

function dtor(self)

end

function findTarget(cusSelfVo)
	local _dic = fight.SceneManager:getAllThing();
	local _tempVo = nil;
	local _minDis = 0;
	for _,v in pairs(_dic) do
		if v.isAtt ~= cusSelfVo.isAtt and v:isDead() == false then
			if _tempVo == nil then
				_tempVo = v;
				_minDis = cusSelfVo.position:distance(v:nextPos());
			else
				local _tempDis = cusSelfVo.position:distance(v:nextPos());
				if _tempDis < _minDis then
					_minDis = _tempDis;
					_tempVo = v;
				end
			end
		end
	end
	return _tempVo;
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

module('TestCtrl', Class.impl(Controller))
--构造函数
function ctor(self)
    self:_createSkillTest()
end

function gameStartCallBack(self)
	for k, v in ipairs(self.gModuleList) do
		if v ~= nil and next(v) then
			for k2, v2 in ipairs(v) do
				v2:gameStartCallBack()
			end
		end
	end
end

function _createSkillTest(self)
    -- require("protocol/Init").init()
    self.gModuleList = {
        require('game/socket/Init'),
        require('game/map/Init'),
        require('game/fight/Init'),
    }
    self:gameStartCallBack()

    require('game/fight/skill/performLogic/SkillPerfInit')
    require('test/TestSkillPerformUI').new()

    local function _onGlobalUpdate(self, deltaTime)	
		STravelHandle:updateTravel(deltaTime)
		-- BuffHandler:updateBuff(deltaTime)
    end
    LoopManager:addFrame(1,-1, self, _onGlobalUpdate)
end

return _M

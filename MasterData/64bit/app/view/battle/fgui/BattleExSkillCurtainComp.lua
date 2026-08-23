local CriSprite = require("app.view.common.CriSprite")
local BattleConst = require("app.view.battle.const.BattleConst")
local BattleExSkillCurtainComp = class("BattleExSkillCurtainComp", require("app.fairyGUI.battle.UI_BattleExSkillCurtainComp"))

function BattleExSkillCurtainComp:ctor()
	self._actor = nil
	self._isDelete = false
	self._timeScale = 1
	self._criEnd = false
	self._tranEnd = false

	self:setSize(display.width, display.height)
	self.m_enterTransition:setHook("In", handler(self, self.startPlayCri))
end

function BattleExSkillCurtainComp:startPlayCri()
	local var_2_0 = self._actor:getBaseKnightInfo().id .. "superskill_1334x750_1667"

	if cc.FileUtils:getInstance():isFileExist((g.core.common.Path:getCriMoviePath(var_2_0, "battle"))) then
		local var_2_1 = CriSprite.new({
			fullScreenState = 1,
			movieName = var_2_0,
			moduleName = "battle",
			listener = handler(self, self.criSpriteEvent)
		})

		self.m_criSprite:addNode(var_2_1)
		var_2_1:setPlaySpeed(self._timeScale)
		self:newScheduleOnce(handler(self, self.scheduleEnd), var_2_1:getTotalTime() * 0.001 + 0.2)
	else
		self._criEnd = true

		if self._tranEnd then
			self:onDelete()
		end
	end
end

function BattleExSkillCurtainComp:scheduleEnd()
	if not self._criEnd then
		self._criEnd = true

		if self._tranEnd then
			self:onDelete()
		end
	end
end

function BattleExSkillCurtainComp:updateView(arg_4_1)
	arg_4_1 = arg_4_1 or {}
	self._callback = arg_4_1.callback
	self._timeScale = arg_4_1.timeScale or 1
	self._knightInfo = arg_4_1.knightInfo
	self._actor = arg_4_1.actor

	self.m_sideTypeController:setSelectedIndex(arg_4_1.identity - 1)

	if arg_4_1.identity ~= 1 then
		self.m_criSprite:setScaleX(-1)
	end

	self.m_enterTransition:play(handler(self, self.tranEnd))
end

function BattleExSkillCurtainComp:tranEnd()
	self._tranEnd = true

	if self._criEnd then
		self:onDelete()
	end
end

function BattleExSkillCurtainComp:criSpriteEvent(arg_6_1)
	if arg_6_1 == BattleConst.SPINE_EVENT.COMPLETE then
		self._criEnd = true

		if self._tranEnd then
			self:onDelete()
		end
	end
end

function BattleExSkillCurtainComp:onDelete()
	if self._isDelete then
		return
	end

	self._isDelete = true

	if self._callback then
		self._callback()
	end

	self:removeFromParent()
end

return BattleExSkillCurtainComp

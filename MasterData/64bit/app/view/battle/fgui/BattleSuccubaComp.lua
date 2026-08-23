local var_0_0 = loadCfg("core.config.cfg.succuba_parameter_info")
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_2 = BattleConst.SUCCUBA_PARAM
local BattleEffect = require("app.view.battle.BattleEffect")
local BattleSuccubaComp = class("BattleSuccubaComp", require("app.fairyGUI.battle.UI_BattleSuccubaComp"))

function BattleSuccubaComp:ctor()
	self:addClickListener(handler(self, self._onClick))

	self._succubaDataList = {}
	self._succubaValue = var_0_0.get(var_0_2.INIT_ENERGY_VALUE).parameter
	self._succubaMaxValue = var_0_0.get(var_0_2.MAX_ENERGY_VALUE).parameter
	self._fullEff = nil
	self._skillBtnList = {}

	self:_initBtn()
	self:_initData()
end

function BattleSuccubaComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self.onHideDetail, self)
end

function BattleSuccubaComp:updateSuccubaView(arg_3_1, arg_3_2)
	self._battleLayer = arg_3_2
	self._data = arg_3_1
	self._succubaValue = var_0_0.get(var_0_2.INIT_ENERGY_VALUE).parameter
	self._succubaMaxValue = var_0_0.get(var_0_2.MAX_ENERGY_VALUE).parameter

	self:initSuccubaSkill(arg_3_1)
	self:addSuccubaValue(0)
end

function BattleSuccubaComp:_initBtn()
	for iter_4_0 = 1, BattleConst.SUCCUBA_SKILL_NUM do
		self["m_skillComp" .. iter_4_0].tag = iter_4_0

		table.insert(self._skillBtnList, self["m_skillComp" .. iter_4_0])
	end
end

function BattleSuccubaComp:_initData()
	self.m_valueTxt:setText(self._succubaValue)
end

function BattleSuccubaComp:initSuccubaSkill(arg_6_1)
	arg_6_1 = arg_6_1 or {}

	for iter_6_0 = 1, BattleConst.SUCCUBA_SKILL_NUM do
		if arg_6_1[iter_6_0] then
			self._succubaDataList[iter_6_0] = self._succubaDataList[iter_6_0] or {}
			self._succubaDataList[iter_6_0].succubaId = arg_6_1[iter_6_0].id and arg_6_1[iter_6_0].id or nil

			self._skillBtnList[iter_6_0]:initSuccubaSkill(self._succubaDataList[iter_6_0])
		else
			self._skillBtnList[iter_6_0]:initSuccubaSkill()
		end
	end
end

function BattleSuccubaComp:setBattleData(arg_7_1)
	self._battleData = arg_7_1
end

function BattleSuccubaComp:onHideDetail()
	self.m_stateController:setSelectedIndex(0)
end

function BattleSuccubaComp:updateSuccubaSkillCD(arg_9_1, arg_9_2, arg_9_3)
	for iter_9_0 = 1, BattleConst.SUCCUBA_SKILL_NUM do
		local var_9_0 = self._skillBtnList[iter_9_0]

		if (arg_9_3 and var_9_0:getSkillId() or var_9_0:getSuccubaId()) == arg_9_1 then
			var_9_0:updateRoundCD(arg_9_2)

			break
		end
	end

	local var_9_1 = self._battleData:getSuccubaInfo(1)
	local var_9_2 = var_9_1:getSuccubaSort()

	for iter_9_1 = 1, BattleConst.SUCCUBA_SKILL_NUM do
		if var_9_2[iter_9_1] then
			local var_9_3 = var_9_2[iter_9_1]

			self._succubaDataList[iter_9_1] = self._succubaDataList[iter_9_1] or {}
			self._succubaDataList[iter_9_1].succubaId = var_9_3 and var_9_3 or nil

			self._skillBtnList[iter_9_1]:initSuccubaSkill(self._succubaDataList[iter_9_1], var_9_1:getCdTime(var_9_3))
		else
			self._skillBtnList[iter_9_1]:initSuccubaSkill()
		end
	end
end

function BattleSuccubaComp:updateCurSuccuba(arg_10_1)
	self._succubaValue = math.max(arg_10_1, 0)

	self.m_valueTxt:setText(self._succubaValue)

	if self._succubaValue >= self._succubaMaxValue then
		if not self._fullEff then
			self._fullEff = BattleEffect.new({
				isLoop = true,
				path = g.core.common.Path:getEffSpine("eff_ui_BattleSuccuba_full")
			})

			self.m_eff:addNode(self._fullEff)
		end

		self.m_eff:setVisible(true)
	elseif self._fullEff then
		self.m_eff:setVisible(false)
	end
end

function BattleSuccubaComp:addSuccubaValue(arg_11_1)
	self._succubaValue = math.min(math.max(self._succubaValue + arg_11_1, 0), self._succubaMaxValue)

	self:updateCurSuccuba(self._succubaValue)
end

function BattleSuccubaComp:_onClick()
	self.m_stateController:setSelectedIndex(1)
end

return BattleSuccubaComp

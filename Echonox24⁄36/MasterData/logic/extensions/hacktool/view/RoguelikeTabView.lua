-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/RoguelikeTabView.lua

module("logic.extensions.hacktool.view.RoguelikeTabView", package.seeall)

local M = class("RoguelikeTabView")

function M:ctor(container)
	self._go = container.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self:init()
end

function M:init()
	local registry = self._viewElementsRegistry

	self._btnNoMapSimulation = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_-1043568061"))
	self._btnExecEffect = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_1375262880"))
	self._btnExecFuncEffect = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_795284209"))
	self._btnClearEffect = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_-854332130"))
	self._btnClearFuncEffect = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_2095732446"))
	self._btnGetProp = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_-1336351215"))
	self._btnSuccess = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_261135782"))
	self._btnFail = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_343626908"))
	self._btnRunGroupSimulation = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_-1587256746"))
	self._btnRunGroupDice = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_-246924212"))
	self._btnEquipDice = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_-995247585"))
	self._btnEquipDiceReview = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_1362109239"))
	self._inputEffectId = Astral.InputFieldAdapter.Get(registry:findUIElement("hacktoolpanel_-1136755161"))
	self._inputClearEffectId = Astral.InputFieldAdapter.Get(registry:findUIElement("hacktoolpanel_-1510977196"))
	self._inputEffectCode = Astral.InputFieldAdapter.Get(registry:findUIElement("hacktoolpanel_-976009608"))
	self._inputEffectParam = Astral.InputFieldAdapter.Get(registry:findUIElement("hacktoolpanel_971560095"))
	self._inputPropId = Astral.InputFieldAdapter.Get(registry:findUIElement("hacktoolpanel_722563248"))
	self._inputDicePattern = Astral.InputFieldAdapter.Get(registry:findUIElement("hacktoolpanel_-40048392"))
	self._btnDicePattern = UIComponentType.ButtonAdapter(registry:findUIElement("hacktoolpanel_-1381758399"))

	self:bindEvents()
end

function M:bindEvents()
	self._btnNoMapSimulation:AddClickListener(self.onNoMapSimulationClick, self)
	self._btnExecEffect:AddClickListener(self.onExecEffectClick, self)
	self._btnExecFuncEffect:AddClickListener(self.onExecFuncEffectClick, self)
	self._btnClearEffect:AddClickListener(self.onClearEffectClick, self)
	self._btnClearFuncEffect:AddClickListener(self.onClearFuncEffectClick, self)
	self._btnGetProp:AddClickListener(self.onGetPropClick, self)
	self._btnSuccess:AddClickListener(self.onSuccessClick, self)
	self._btnFail:AddClickListener(self.onFailClick, self)
	self._btnRunGroupSimulation:AddClickListener(self.onRunGroupSimulationClick, self)
	self._btnEquipDice:AddClickListener(self.onEquipDiceClick, self)
	self._btnEquipDiceReview:AddClickListener(self.onEquipDiceReviewClick, self)
	self._btnRunGroupDice:AddClickListener(self.onRunGroupDiceClick, self)
	self._btnDicePattern:AddClickListener(self.onDicePatternClick, self)
end

function M:OnDestroy()
	self._btnNoMapSimulation:RemoveClickListener()
	self._btnExecEffect:RemoveClickListener()
	self._btnExecFuncEffect:RemoveClickListener()
	self._btnClearEffect:RemoveClickListener()
	self._btnClearFuncEffect:RemoveClickListener()
	self._btnGetProp:RemoveClickListener()
	self._btnSuccess:RemoveClickListener()
	self._btnFail:RemoveClickListener()
	self._btnRunGroupSimulation:RemoveClickListener()
	self._btnEquipDice:RemoveClickListener()
	self._btnEquipDiceReview:RemoveClickListener()
	self._btnRunGroupDice:RemoveClickListener()
	self._btnDicePattern:RemoveClickListener()
end

function M:onNoMapSimulationClick()
	ViewMgr.instance:open(ViewName.RogueHackToolSelectRole)
end

function M:onExecEffectClick()
	local effectId = self._inputEffectId:GetText()

	if effectId ~= nil and effectId ~= "" then
		effectId = tonumber(effectId)

		RoguelikeController.instance:getEffectParams({
			effectId
		}, function(roleId, attr)
			self:sendRoguelikeTakeEffect(effectId, roleId, attr)
		end)
	end
end

function M:sendRoguelikeTakeEffect(effectId, roleId, attr)
	local info = {}

	info.cmd = GameEnum.GMCmdEnum.RoguelikeTakeEffect
	info.value = {}
	info.value.e = effectId
	info.value.hero = roleId
	info.value.attr = attr
	info.value.x = 1

	HackToolAgent.instance:sendGmRequest(info)
end

function M:sendRoguelikeDropEffect(effectId)
	local info = {}

	info.cmd = GameEnum.GMCmdEnum.RoguelikeDropEffect
	info.value = {}
	info.value.e = effectId

	HackToolAgent.instance:sendGmRequest(info)
end

function M:sendRoguelikeMockEffect(program, params)
	local info = {}

	info.cmd = GameEnum.GMCmdEnum.RoguelikeMockEffect
	info.value = {}
	info.value.program = program
	info.value.params = params

	local needSelect, needSelectAttr, isAll
	local selectable = string.find(program, "SELECTABLE")

	if selectable or program == "AddChosenAttribute" or program == "SelectedHeroToRiseAttribute" then
		needSelect = true
	end

	needSelectAttr = needSelectAttr or program == "AddChosenAttribute" or program == "SelectedHeroToRiseAttribute"

	if string.find(program, "ALL") then
		isAll = true
	end

	local function callback(info, roleId, attr)
		info.value.hero = hero
		info.value.attr = attr

		HackToolAgent.instance:sendGmRequest(info)
	end

	if needSelect and not isAll then
		ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
			1,
			function(idx)
				ViewMgr.instance:close(ViewName.RogueSelectPropAndRole)

				local roleProp = RogueMgr.instance:getModel():getRoleMoByIndex(idx)

				if needSelectAttr then
					ViewMgr.instance:open(ViewName.RoguePropSelect, function(attr)
						callback(info, roleProp:getRoleId(), attr)
					end, roleProp)
				elseif tempCallback then
					callback(info, roleProp:getRoleId(), -1)
				end
			end,
			firstEffectCo.description,
			firstEffectId
		})
	elseif callback then
		callback(info, 0, -1)
	end
end

function M:sendClearPreMockEffect()
	local info = {}

	info.cmd = GameEnum.GMCmdEnum.ClearPreMockEffect
	info.value = {}

	HackToolAgent.instance:sendGmRequest(info)
end

function M:onExecFuncEffectClick()
	local effectParam = self._inputEffectParam:GetText()
	local param = self._inputEffectCode:GetText()

	if effectParam ~= nil and effectParam ~= "" then
		self:sendRoguelikeMockEffect(effectParam, param)
	end
end

function M:onClearEffectClick()
	local effectId = self._inputClearEffectId:GetText()

	if effectId ~= nil and effectId ~= "" then
		effectId = tonumber(effectId)

		self:sendRoguelikeDropEffect(effectId)
	end
end

function M:onClearFuncEffectClick()
	self:sendClearPreMockEffect()
end

function M:onGetPropClick()
	local propId = self._inputPropId:GetText()

	if propId ~= nil and propId ~= "" then
		propId = tonumber(propId)

		ViewMgr.instance:open(ViewName.RogueSelectPropAndRole, {
			2,
			{
				propId
			}
		})
		ViewMgr.instance:close(ViewName.HackToolView)
	end
end

function M:onSuccessClick()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SKIP_TO_JUDGE_RESULT, true)
	ViewMgr.instance:close(ViewName.HackToolView)
end

function M:onFailClick()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SKIP_TO_JUDGE_RESULT, false)
	ViewMgr.instance:close(ViewName.HackToolView)
end

function M:onRunGroupSimulationClick()
	print("跑团模拟")
end

function M:onRunGroupDiceClick()
	ViewMgr.instance:open(ViewName.RogueHackToolDice)
	print("扔骰子模拟")
end

function M:onEquipDiceClick()
	ViewMgr.instance:close(ViewName.HackToolView)
	ViewMgr.instance:open(ViewName.EquipTimingTest)
	print("校时器骰子模拟")
end

function M:onEquipDiceReviewClick()
	ViewMgr.instance:close(ViewName.HackToolView)
	ViewMgr.instance:open(ViewName.EquipTimingReviewTest)
	print("校时器骰子模拟查看")
end

function M:onDicePatternClick()
	local txt = self._inputDicePattern:GetText()

	RogueMgr.instance:setTempDicePatterns(txt)
	print("设置骰子结果为", txt)
end

return M

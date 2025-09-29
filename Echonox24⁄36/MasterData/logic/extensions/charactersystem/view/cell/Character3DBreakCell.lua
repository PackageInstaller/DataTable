-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/cell/Character3DBreakCell.lua

module("logic.extensions.charactersystem.view.cell.Character3DBreakCell", package.seeall)

local M = class("Character3DBreakCell")

function M:ctor(container)
	self._go = container.gameObject
	self._heroId = nil
	self._breakIndex = nil
	self._breakCO = nil
end

function M:Awake()
	self:_buildUI()
end

function M:OnEnable()
	self:_bindEvents()
end

function M:OnDisable()
	self:_unbindEvents()
end

function M:onDestroy()
	self:_unbindEvents()
end

function M:_buildUI()
	self._textName = goutil.findChildTextComponent(self._go, "top/txtName")
	self._textDesc = goutil.findChildComponent(self._go, "txtContent", UIComponentType.TextMeshProUGUI)
	self._goDoing = goutil.findChild(self._go, "top/contract_break_point/doing")
	self._goDone = goutil.findChild(self._go, "top/contract_break_point/done")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "click"))
	self._goTips = goutil.findChild(self._go, "tipsGo") or self._go

	goutil.setActive(self._goDoing, false)
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:_onClick()
	local skillEnhanceMO, targetSkillId
	local cfgBreakAttrCO = HeroBreakConfig.instance:getAttrCO(self._heroId, self._breakIndex)

	if not cfgBreakAttrCO then
		printWarn(string.format("角色[%s]没有配置合约,level[%s]", self._heroId, self._breakIndex))

		return
	end

	targetSkillId = cfgBreakAttrCO.skillId

	if targetSkillId > 0 then
		skillEnhanceMO = SkillEnhanceMO.New(targetSkillId)

		for i = 1, self._breakIndex do
			local cfg = HeroBreakConfig.instance:getAttrCO(self._heroId, i)

			if cfg and cfg.attrGrowEnhance <= 0 and cfg.skillId == targetSkillId and cfg.skillEnhanceId > 0 then
				skillEnhanceMO:addSkillEnhanceCode(cfg.skillEnhanceId)
			end
		end
	end

	if skillEnhanceMO then
		skillEnhanceMO:rebuild()
		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, self._goTips, true)
	end
end

function M:_refreshView()
	goutil.setActive(self._go, self._breakCO ~= nil)

	if self._breakCO ~= nil then
		self._textName.text = string.format("%s：", langF("anchor_break_title", CommEnum.Num2RomeNum[self._breakIndex]))
		self._textDesc.text = self:_getDesc()

		local doneTranf = self._goDone.transform

		for index = 0, doneTranf.childCount - 1 do
			local goSign = doneTranf:GetChild(index).gameObject

			goutil.setActive(goSign, self._breakIndex >= index + 1)
		end
	end
end

function M:_getDesc()
	local desc
	local breakCO = self._breakCO

	if breakCO and breakCO.attrGrowEnhance > 0 then
		local num = math.floor(breakCO.attrGrowEnhance * 100)

		desc = langF("tip_character_anchor_tip_2", num)
	elseif breakCO and breakCO.skillId > 0 then
		if breakCO.skillEnhanceId > 0 then
			local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(breakCO.skillEnhanceId)

			desc = skillEnhanceCOWrapper:getDescription(true)
		else
			local mo = SkillEnhanceMO.getSharedMO(breakCO.skillId)

			desc = mo:getDescription()

			SkillEnhanceMO.releaseSharedMO(mo)
		end
	end

	desc = desc and string.format("<line-indent=22%%>%s", desc)

	return desc
end

function M:setActive(active)
	goutil.setActive(self._go, active)
end

function M:setData(heroId, breakIndex)
	self._heroId = heroId
	self._breakIndex = breakIndex
	self._breakCO = HeroBreakConfig.instance:getAttrCO(self._heroId, self._breakIndex)

	self:setActive(true)
	self:_refreshView()
end

return M

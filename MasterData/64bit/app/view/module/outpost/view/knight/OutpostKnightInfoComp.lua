local OutpostKnightInfoComp = class("OutpostKnightInfoComp", require("app.fairyGUI.outpost.UI_OutpostKnightInfoComp"))

function OutpostKnightInfoComp:ctor()
	self._struct = nil
	self._attrs = {}

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrRenderer))
	self.m_detailAttrBtn:addClickListener(handler(self, self.onClickAttrDetail))
	self.m_elemIcon:addClickListener(handler(self, self.onClickElemDetail))
end

function OutpostKnightInfoComp:onClickAttrDetail()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.knight.OutpostKnightAttrTip").new({
		struct = self._struct
	})))
end

function OutpostKnightInfoComp:onClickElemDetail()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.knight.OutpostElementTipPop").new()))
end

function OutpostKnightInfoComp:playEnter()
	self.m_enterTransition:stop()
	self.m_enterTransition:play()
end

function OutpostKnightInfoComp:updateWithStruct(arg_5_1)
	self._struct = arg_5_1

	self.m_starComp:initStar({
		index = 14,
		gap = -7,
		style = 1,
		num = arg_5_1:getStar()
	})

	local var_5_0 = arg_5_1:getCfg()

	self.m_nameTxt:setText(var_5_0.name)
	self.m_levelTxt:setText(arg_5_1:getLevel())
	self.m_elemIcon:setURL(g.core.common.Path:getKnightElementIcon(var_5_0.classical))
	self.m_qualityIcon:setURL("ui://outpost/pic_hxsz_mzpinzhi" .. var_5_0.quality + 1)
	self.m_qualityLoader:setURL("ui://text_new/pic_pinzhi_" .. var_5_0.quality + 1)

	self._attrs = arg_5_1:getBaseShowAttr()

	self.m_attrList:setNumItems(#self._attrs)

	local var_5_1
	local var_5_2

	if var_5_0.skill_2 == 0 or var_5_0.passive_skill_1 == 0 then
		var_5_1 = arg_5_1:getCfg(arg_5_1:getStar() + 1)

		if var_5_0.skill_2 == 0 then
			var_5_2 = var_5_1.skill_2 or var_5_0.skill_2
		end
	end

	self.m_skill1:updateSkill(var_5_2, arg_5_1, false)

	if var_5_0.skill_2 == 0 then
		self.m_skill1:setGrayed(true)
	else
		self.m_skill1:setGrayed(false)
	end

	self.m_skill2:updateSkill((var_5_0.passive_skill_1 == 0 or nil) and (var_5_1.passive_skill_1 or var_5_0.passive_skill_1), arg_5_1, true)

	if var_5_0.passive_skill_1 == 0 then
		self.m_skill2:setGrayed(true)
	else
		self.m_skill2:setGrayed(false)
	end
end

function OutpostKnightInfoComp:_onAttrRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateAttr(self._attrs[arg_6_1 + 1])
end

return OutpostKnightInfoComp

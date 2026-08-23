local var_0_0 = g.core.model.User.blazingArenaData
local BlazingArenaBorrowPop = class("BlazingArenaBorrowPop", require("app.fairyGUI.blazingArena.UI_BlazingArenaBorrowPop"), function()
	return fgui.GComponent:create({
		resName = "BlazingArenaBorrowPop",
		pkgName = "blazingArena"
	}, ...)
end)

function BlazingArenaBorrowPop:ctor(arg_2_1)
	self:showAtCenter()
	self:_initBtn()
	self:_initListView()
	self:_initView()
end

function BlazingArenaBorrowPop:onLoad()
	self.m_enterTransition:play()
end

function BlazingArenaBorrowPop:_initBtn()
	self.m_closeBtn:addClickListener(handler(self, self._onCloseBtnClick))
end

function BlazingArenaBorrowPop:_initListView()
	self.m_uniteTokenList:setVirtual()
	self.m_uniteTokenList:doFairyBatching(false)
	self.m_uniteTokenList:setItemRenderer(handler(self, self._onRenderUniteTokenList))
	self.m_petList:setVirtual()
	self.m_petList:doFairyBatching(false)
	self.m_petList:setItemRenderer(handler(self, self._onRenderPetList))
end

function BlazingArenaBorrowPop:_onRenderUniteTokenList(arg_6_1, arg_6_2)
	arg_6_2:updateIconComp(g.core.common.Goods.TYPE_UNITETOKEN, self._uniteTokenList[arg_6_1 + 1].cfg.id, self._uniteTokenList[arg_6_1 + 1].level, self._uniteTokenList[arg_6_1 + 1].advanceStage)
end

function BlazingArenaBorrowPop:_onRenderPetList(arg_7_1, arg_7_2)
	arg_7_2:updateIconComp(g.core.common.Goods.TYPE_PET, self._petList[arg_7_1 + 1].cfg.id, self._petList[arg_7_1 + 1].level, self._petList[arg_7_1 + 1].advanceStage)
end

function BlazingArenaBorrowPop:_initView()
	self._uniteTokenList = var_0_0:getHelpShortList(g.core.common.Goods.TYPE_UNITETOKEN)

	self.m_uniteTokenList:setNumItems(#self._uniteTokenList)

	self._petList = var_0_0:getHelpShortList(g.core.common.Goods.TYPE_PET)

	self.m_petList:setNumItems(#self._petList)

	local var_8_0 = var_0_0:getBorrowFreshDay()

	self.m_borrowDayText1:setText(g.core.lang:get(431419, {
		day = g.core.lang:get(120 + var_8_0 - 1)
	}))
	self.m_borrowDayText2:setText(g.core.lang:get(431420, {
		day = g.core.lang:get(120 + var_8_0)
	}))

	local var_8_1 = var_0_0:getShortInfo(g.core.common.Goods.TYPE_UNITETOKEN)
	local var_8_2 = var_0_0:getShortInfo(g.core.common.Goods.TYPE_PET)

	self.m_borrowTipsText1:enableRich()
	self.m_borrowTipsText1:setText(g.core.lang:get(431427, {
		num1 = var_8_1[1].limitNum,
		star1 = var_8_1[1].list[1].cfg.star,
		num2 = var_8_2[1].limitNum,
		star2 = var_8_2[1].list[1].cfg.star
	}))
	self.m_borrowTipsText2:enableRich()
	self.m_borrowTipsText2:setText(g.core.lang:get(431427, {
		num1 = var_8_1[var_8_0].limitNum,
		star1 = var_8_1[var_8_0].list[1].cfg.star,
		num2 = var_8_2[var_8_0].limitNum,
		star2 = var_8_2[var_8_0].list[1].cfg.star
	}))
	var_0_0:saveBorrowUnitNumAndDay()
end

function BlazingArenaBorrowPop:_onCloseBtnClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return BlazingArenaBorrowPop

local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.richmanData
local RichmanMonsterPop = class("RichmanMonsterPop", require("app.fairyGUI.richman.UI_RichmanMonsterPop"), function()
	return fgui.GComponent:create({
		resName = "RichmanMonsterPop",
		pkgPath = "ui/richman/richman",
		pkgName = "richman"
	})
end)

function RichmanMonsterPop:ctor()
	self.m_monsterList:setVirtual()
	self.m_monsterList:setItemRenderer(handler(self, self._renderMonsterItem))
	self.m_monsterList:doFairyBatching(false)
	self.m_closeBtn:setClickCallBack(handler(self, self._onClosePop))
	self.m_closeGraph:addClickListener(handler(self, self._onClosePop))
	self:showAtCenter()
	self.m_rewardDescTxt:setText(g.core.lang:get(426026))
end

function RichmanMonsterPop:onLoad()
	var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_WAIT)
	self:newScheduleOnce(function()
		var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end, 0.5)
	self.m_enterTransition:play()
	self:showRichmanMonster()
end

function RichmanMonsterPop:_renderMonsterItem(arg_5_1, arg_5_2)
	arg_5_2:onRichManMonsterCellRenderer(self._monsterList[arg_5_1 + 1])
end

function RichmanMonsterPop:showRichmanMonster()
	self._monsterList = var_0_2:getMonsterEventList()

	self.m_monsterList:setNumItems(#self._monsterList)
	self.m_monsterNumTxt:setText(g.core.lang:get(426027, {
		num = #self._monsterList,
		maxNum = var_0_2:getMaxMonsterNum()
	}))
end

function RichmanMonsterPop:_onClosePop()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function RichmanMonsterPop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return RichmanMonsterPop

local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.const.ConstMgr.BAG_TYPE
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.const.ConstMgr.KnightSoulConst
local var_0_5 = g.core.config.ksoul_book_chapter_info
local KnightSoulUpPop = class("KnightSoulUpPop", require("app.fairyGUI.knightSoul.UI_KnightSoulUpPop"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulUpPop",
		pkgName = "knightSoul",
		pkgPath = "ui/knightSoul/knightSoul"
	}, ...)
end)

function KnightSoulUpPop:ctor(arg_2_1)
	if not arg_2_1 then
		return
	end

	self:showAtCenter()

	self._bookStruct = arg_2_1.bookStruct
	self._bookStatus = arg_2_1.bookStatus
	self._chapterId = self._bookStruct:getChapter()
	self._bookId = self._bookStruct:getId()
	self._ksoulList = {}

	self.m_activateBtn:addClickListener(handler(self, self._onClickActivate))
	self.m_ksoulList:setVirtual()
	self.m_ksoulList:setItemRenderer(handler(self, self._onRenderKsoulList))
	self:_initView()
	self:_updateView()
end

function KnightSoulUpPop:_initView()
	self.m_starComp:initStar({
		style = 2,
		num = 0,
		index = 3,
		max = var_0_4.MAX_STAR_NUM
	})
	self.m_nameTxt:setText(g.core.lang:get(410615, {
		name = self._bookStruct:getName()
	}))
end

function KnightSoulUpPop:_updateView()
	if not self._bookStruct then
		return
	end

	self.m_starComp:setStarNum(self._bookStruct:getStarNum())
	self.m_attributes:updateAttributes(self._bookStruct)

	self._ksoulList = self._bookStruct:getNeedKnightSoulList()

	self.m_ksoulList:setNumItems(#self._ksoulList)
	self.m_isMaxController:setSelectedIndex(self._bookStatus == var_0_4.BOOK_STATUS.MAX_STAR and 1 or 0)
end

function KnightSoulUpPop:_onClickActivate()
	if self._bookStatus == var_0_4.BOOK_STATUS.NOT_MAX_STAR then
		local var_5_0, var_5_1 = self._bookStruct:isCanStarUp()

		if var_5_1 == var_0_4.UNABLE_STAR_UP_TYPE.CARD_NUM then
			g.core.module.ModuleManager:tip(g.core.lang:get(410609))
		elseif var_5_1 == var_0_4.UNABLE_STAR_UP_TYPE.HONOR_NUM then
			g.core.module.ModuleManager:tip(g.core.lang:get(410613, {
				num = var_0_5.get(self._chapterId).star_honor
			}))
		end
	elseif self._bookStatus == var_0_4.BOOK_STATUS.STAR_UP_ABLE then
		g.core.network.GameNetProxy:send_C2S_KSoul_BookUpgrade({
			book_id = self._bookId,
			chapter_id = self._chapterId
		})
	end
end

function KnightSoulUpPop:_onRenderKsoulList(arg_6_1, arg_6_2)
	arg_6_2:getChild("icon"):updateIcon({
		overrideClick = true,
		type = var_0_1.KSOUL,
		value = self._ksoulList[arg_6_1 + 1]
	})

	local var_6_0 = var_0_0:getOwnNum(var_0_1.KSOUL, self._ksoulList[arg_6_1 + 1])

	arg_6_2:setGrayed(var_6_0 == 0)
	arg_6_2:getChild("ownTxt"):setText(var_6_0 .. "/1")
end

function KnightSoulUpPop:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_K_SOUL_BOOKUPGRADE, self._onS2CBookUpgrade, self)
end

function KnightSoulUpPop:_onS2CBookUpgrade()
	self._bookStatus = self._bookStruct:getStatusIndex()

	self:_updateView()
end

return KnightSoulUpPop

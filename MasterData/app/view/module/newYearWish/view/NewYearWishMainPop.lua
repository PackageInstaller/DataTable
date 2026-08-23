local var_0_0 = 3
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.model.User.newYearWishData
local NewYearWishMainPop = class("NewYearWishMainPop", require("app.fairyGUI.newYearWish.UI_NewYearWishMainPop"), function()
	return fgui.GComponent:create({
		resName = "NewYearWishMainPop",
		pkgPath = "ui/newYearWish/newYearWish",
		isFullScreen = true,
		pkgName = "newYearWish"
	}, ...)
end)

function NewYearWishMainPop:ctor(arg_2_1)
	self._params = arg_2_1
	self._clickErrTimes = 0
	self.m_guideClickTrans = self.m_guideClickComp:getTransition("click")
	self._effSpineNode = nil

	self.m_guideClickComp:setVisible(false)
	self:addClickListener(handler(self, self._onClickBlankArea))
	self.m_touchAreaComp:addClickListener(handler(self, self._onClickDraw))
end

function NewYearWishMainPop:onLoad()
	self._effSpineNode = self.m_effDad:addEffectSpine({
		anim = "idle",
		name = "xinnian_chouqian_01",
		remove = false,
		isLoop = false
	})

	g.core.network.GameNetProxy:send_C2S_NewYearWish_GetInfo({})
end

function NewYearWishMainPop:_onClickBlankArea()
	self._clickErrTimes = self._clickErrTimes + 1

	if self._clickErrTimes >= var_0_0 and not self.m_guideClickTrans:isPlaying() then
		self.m_guideClickTrans:play()
		self.m_guideClickComp:setVisible(true)
	end
end

function NewYearWishMainPop:_onClickDraw(arg_5_1)
	arg_5_1:stopPropagation()
	self.m_guideClickTrans:stop()
	self.m_guideClickComp:setVisible(false)

	if var_0_2:isDrawEnable() then
		self:setTouchable(false)
		self._effSpineNode:setAnimation(0, "play", false)
		self._effSpineNode:addSpineEventListener(handler(self, self._onSpineEvent))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.NEW_YEAR_WISH_DRAW)
		g.core.network.GameNetProxy:send_C2S_NewYearWish_Draw({})
	else
		var_0_1:onlyPopSelfByDisplay(self)
	end
end

function NewYearWishMainPop:_onSpineEvent(arg_6_1)
	if arg_6_1.type == "complete" then
		self._effSpineNode:removeFromParent(true)

		self._effSpineNode = nil

		local var_6_0

		if self._params then
			var_6_0 = self._params.endcall
			self._params = nil
		end

		var_0_1:onlyPopSelfByDisplay(self)

		if var_0_2:hasAwardCanGet() then
			local var_6_1 = clone(var_0_2:getActInfo())

			if var_6_0 then
				var_6_1.endcall = var_6_0
			end

			var_0_1:pushModule(g.view.entrance.NEW_YEAR_WISH_RESULT, var_6_1)
		end
	end
end

return NewYearWishMainPop

local var_0_0 = g.core.model.User.newSlgDevelopData
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local NewSlgEmbryoLineUpPop = class("NewSlgEmbryoLineUpPop", require("app.fairyGUI.newSlg.UI_NewSlgEmbryoLineUpPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgEmbryoLineUpPop",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgEmbryoLineUpPop:ctor(arg_2_1)
	self._isBack = arg_2_1 and arg_2_1.isBack
	self._embryoTypeMap = var_0_0:getEmbryoTypeMap()
	self._oldAuthority = var_0_0:getTotalAuthority()

	self.m_knightBtn:addClickListener(handler(self, self._onClickKnightBtn))
	self.m_artifactBtn:addClickListener(handler(self, self._onClickArtifactBtn))
	self.m_petBtn:addClickListener(handler(self, self._onClickPetBtn))
	self.m_uniteTokenBtn:addClickListener(handler(self, self._onClickUniteTokenBtn))
	self.m_succubaBtn:addClickListener(handler(self, self._onClickSuccubaBtn))
	self.m_topBarComp:hideHomeBtn()
	self.m_topBarComp:setResInfoById(345)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function NewSlgEmbryoLineUpPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_STATIONMAINCITY, handler(self, self._onRcvNewSlgStationMainCity), self)
	self:_updateView()
	self:_refreshRedPoint()

	if self._isBack then
		self.m_backTransition:play()
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_donghua)
		self.m_enterTransition:play()
		self.m_eff:addEffectSpine({
			isLoop = false,
			name = "eff_ui_newSlg_layer",
			remove = true,
			anim = "play"
		})
	end
end

function NewSlgEmbryoLineUpPop:_refreshRedPoint()
	var_0_3:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_knightBtn,
		customData = {
			embryoType = var_0_2.TYPE_KNIGHT
		}
	})
	var_0_3:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_artifactBtn,
		customData = {
			embryoType = var_0_2.TYPE_ARTIFACT
		}
	})
	var_0_3:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_petBtn,
		customData = {
			embryoType = var_0_2.TYPE_PET
		}
	})
	var_0_3:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_uniteTokenBtn,
		customData = {
			embryoType = var_0_2.TYPE_UNITETOKEN
		}
	})
	var_0_3:dispatchEvent(var_0_4.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_succubaBtn,
		customData = {
			embryoType = var_0_2.TYPE_SUCCUBA
		}
	})
end

function NewSlgEmbryoLineUpPop:_onRcvNewSlgStationMainCity(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = var_0_0:getTotalAuthority()

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_SHOW, false, {
		authorityChange = {
			index = 2,
			oldValue = self._oldAuthority,
			newValue = var_6_0
		}
	})

	self._oldAuthority = var_6_0

	self:_updateView()
end

function NewSlgEmbryoLineUpPop:_updateView()
	self.m_mainCityComp:updateView()
	self.m_knightBtn:setTitle(g.core.lang:get(429531, {
		num = var_0_0:getAuthorityByType(var_0_2.TYPE_KNIGHT)
	}))
	self.m_artifactBtn:setTitle(g.core.lang:get(429531, {
		num = var_0_0:getAuthorityByType(var_0_2.TYPE_ARTIFACT)
	}))
	self.m_petBtn:setTitle(g.core.lang:get(429531, {
		num = var_0_0:getAuthorityByType(var_0_2.TYPE_PET)
	}))
	self.m_uniteTokenBtn:setTitle(g.core.lang:get(429531, {
		num = var_0_0:getAuthorityByType(var_0_2.TYPE_UNITETOKEN)
	}))
	self.m_succubaBtn:setTitle(g.core.lang:get(429531, {
		num = var_0_0:getAuthorityByType(var_0_2.TYPE_SUCCUBA)
	}))
end

function NewSlgEmbryoLineUpPop:_pushDeployLayer(arg_8_1)
	var_0_1:replaceModule(g.view.entrance.NEW_SLG_EMBRYO_DEPLOY_POP, {
		embryoType = arg_8_1
	})
end

function NewSlgEmbryoLineUpPop:_onClickKnightBtn()
	self:_pushDeployLayer(var_0_2.TYPE_KNIGHT)
end

function NewSlgEmbryoLineUpPop:_onClickArtifactBtn()
	self:_pushDeployLayer(var_0_2.TYPE_ARTIFACT)
end

function NewSlgEmbryoLineUpPop:_onClickPetBtn()
	self:_pushDeployLayer(var_0_2.TYPE_PET)
end

function NewSlgEmbryoLineUpPop:_onClickUniteTokenBtn()
	self:_pushDeployLayer(var_0_2.TYPE_UNITETOKEN)
end

function NewSlgEmbryoLineUpPop:_onClickSuccubaBtn()
	self:_pushDeployLayer(var_0_2.TYPE_SUCCUBA)
end

return NewSlgEmbryoLineUpPop

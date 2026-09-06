-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxpopView.lua

module("logic.extensions.assistancebox.view.AssistanceboxpopView", package.seeall)

local AssistanceboxpopView = class("AssistanceboxpopView", ViewComponent)

function AssistanceboxpopView:ctor()
	AssistanceboxpopView.super.ctor(self)

	self._sliderSpeed = 0.01
end

function AssistanceboxpopView:unbindEvents()
	AssistanceboxpopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._box)
	GameUtil.rmClickHandler(self._btnClose)
end

function AssistanceboxpopView:bindEvents()
	AssistanceboxpopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._box, self.onBoxClick, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AssistanceboxpopView:buildUI()
	AssistanceboxpopView.super.buildUI(self)

	self._box = self:getGo("box")
	self._boxImg = self:getImg("box")
	self._slider = self:getSlider("progress/slider")
	self._sliderDown = self:getSlider("progress/slider_2")
	self._txtProgress = self:getTxt("txtProgress")
	self._openTip = self:getGo("openTip")
	self._success = self:getGo("success")
	self._txtRemain = self:getTxt("txtRemain")
	self._btnClose = self:getBtn("btnClose")
end

function AssistanceboxpopView:onExit()
	AssistanceboxpopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGetAssistanceBoxInfo, self.refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnGetAssistanceBoxHelpSuccess, self.onHelpSuccess, self)
	removetimer(self._sliderMove, self)
	UIEffectManager.instance:stopEffect(self._effect)

	self.isShowHelp = nil
end

function AssistanceboxpopView:onEnter()
	AssistanceboxpopView.super.onEnter(self)

	local params = self:getOpenParam()

	self.boxOwnerId = params[1]
	self.boxToken = params[2]

	GlobalDispatcher:addListener(GlobalNotify.OnGetAssistanceBoxInfo, self.refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.OnGetAssistanceBoxHelpSuccess, self.onHelpSuccess, self)
	AssistanceBoxController.instance:sendGetOtherBoxInfo(self.boxOwnerId, self.boxToken)
end

function AssistanceboxpopView:refreshUI()
	GameUtil.SetActive(self._success, false)

	local info = AssistanceBoxModel.instance.otherInfo

	if info then
		local boxId = info.boxId
		local boxCfg = AssistanceBoxConfig.instance:getDefineCfgById(boxId) or {}
		local needCount = checknumber(boxCfg.needCount)

		uGuiUtil.clearImage(self._box)

		if not string.nilorempty(boxCfg.closeRes) then
			uGuiUtil.setSpriteToImage(self._box, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("assistancebox", boxCfg.closeRes))
		end

		if not info.headInfo then
			local headInfo = {}
			local num = #headInfo

			self._slider:SetValue(num / needCount)
			self._sliderDown:SetValue(num / needCount)

			self._txtProgress.text = langPara("已助力%s人，还差%s人", num, needCount - num)

			local todayGainPrizeCount = checknumber(AssistanceBoxModel.instance.todayGainPrizeCount)
			local total = checknumber(AssistanceBoxConfig.instance:getParamValue("DAILY_HELP_TIME"))
			local left = total - todayGainPrizeCount

			self._txtRemain.text = langPara("今日剩余助力奖励次数:%s", left)
		end
	else
		TipsFacade.instance:openCommonTips(lang("助力宝箱不存在"))
		self:close()
	end
end

function AssistanceboxpopView:onBoxClick()
	self.needSliderValue = nil
	self.nowSliderValue = nil

	local info = AssistanceBoxModel.instance.otherInfo

	if info and not self.isShowHelp then
		local boxId = info.boxId
		local boxCfg = AssistanceBoxConfig.instance:getDefineCfgById(boxId) or {}
		local effectName

		if boxCfg.closeRes == "board_zlbx_baoxiang01" then
			effectName = "fx_ui_zlbx_yh_diji"
		elseif boxCfg.closeRes == "board_zlbx_baoxiang03" then
			effectName = "fx_ui_zlbx_yh_gaoji"
		end

		local needCount = checknumber(boxCfg.needCount)

		if not info.headInfo then
			local headInfo = {}
			local num = #headInfo

			if num < needCount then
				self.needSliderValue = (num + 1) / needCount
				self.nowSliderValue = num / needCount

				self._slider:SetValue(self.nowSliderValue)
				self._sliderDown:SetValue(self.needSliderValue)
				settimer(0.02, self._sliderMove, self)

				self.isShowHelp = true

				if effectName then
					self._boxImg.enabled = false
					self._effect = UIEffectManager.instance:playEffect(self, "20220729/lingwenbaoxiang/" .. effectName .. ".prefab", nil, 0, -5, false, nil, GameUtil.handler(function()
						self._isEffectShowEnd = true
						self._boxImg.enabled = true

						self:_onHelpShowEnd()
					end, self))

					self._effect:setParent(self._box.transform)
					self._effect:setScale(1, 1, 1)
				end
			else
				TipsFacade.instance:openCommonTips(lang("助力进度已满"))
				AssistanceBoxController.instance:sendBoxHelp(self.boxOwnerId, self.boxToken)
				self:close()
			end
		end
	else
		self:close()
	end
end

function AssistanceboxpopView:_sliderMove()
	self.nowSliderValue = self.nowSliderValue + self._sliderSpeed

	self._slider:SetValue(self.nowSliderValue)

	if self.nowSliderValue >= self.needSliderValue then
		removetimer(self._sliderMove, self)

		self._sliderMoveEnd = true

		self:_onHelpShowEnd()
	end
end

function AssistanceboxpopView:_onHelpShowEnd()
	if self._sliderMoveEnd and self._isEffectShowEnd then
		AssistanceBoxController.instance:sendBoxHelp(self.boxOwnerId, self.boxToken)
	end
end

function AssistanceboxpopView:onHelpSuccess()
	self:refreshUI()
	GameUtil.SetActive(self._success, true)
	self:close()
end

return AssistanceboxpopView

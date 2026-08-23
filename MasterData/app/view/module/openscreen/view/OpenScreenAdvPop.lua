local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.view.entrance.ModuleGotoProxy
local var_0_4 = g.core.model.User.openScreenData
local var_0_5 = g.core.const.ConstMgr.OpenScreenConst
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local var_0_7 = g.core.common.ServerTime
local md5 = require("cocos.framework.extends.md5")
local var_0_9 = g.core.common.Path
local OpenScreenAdvPop = class("OpenScreenAdvPop", require("app.fairyGUI.openscreen.UI_OpenScreenAdvPop"), function()
	return fgui.GComponent:create({
		resName = "OpenScreenAdvPop",
		pkgPath = "ui/openscreen/openscreen",
		pkgName = "openscreen"
	})
end)

function OpenScreenAdvPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self:showAtCenter()
	self.m_maskComp:setSize(display.width, display.height)
	self:_initUIListener()
end

function OpenScreenAdvPop:_initUIListener()
	self.m_maskComp:addClickListener(handler(self, self._onClickClose))
	self.m_touchComp:addClickListener(handler(self, self._onClickGotoModule))
end

function OpenScreenAdvPop:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_DOWNLOAD_PIC_FINISH, handler(self, self._onRcvDownloadPic), self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:_updateMainView()
end

function OpenScreenAdvPop:_updateMainView()
	local var_5_0 = var_0_4:getCurAdv()

	if not var_5_0 then
		self:_onClickClose()

		return
	end

	if var_5_0.info.type == var_0_5.HINT_TYPE.ONCE then
		var_0_4:tagCurOpenScreenAd()
	end

	if var_5_0.info.adv_pic_type == var_0_5.ADV_TYPE.IMAGE then
		self.m_picLoader:setURL(var_0_9:getOpenScreenPic((tostring(var_5_0.info.image))))
	elseif var_5_0.info.adv_pic_type == var_0_5.ADV_TYPE.REMOTE_IMAGE then
		local var_5_1 = MultilingualMgr:getUseLang() or config.DEFAULT_LANG
		local var_5_2 = "gm_adv/" .. var_5_1 .. "/"
		local var_5_3 = cc.FileUtils:getInstance()

		var_5_3:removeDirectory(var_5_3:getWritablePath() .. "gm_adv/" .. var_5_1 .. "/")
		var_5_3:createDirectory(var_5_3:getWritablePath() .. var_5_2)

		local var_5_4 = var_5_3:getWritablePath() .. var_5_2 .. tostring(var_5_0.info.id) .. ".png"

		if io.exists(var_5_4) then
			self.m_picLoader:setURL(var_5_4)
		else
			g.core.network.GameHttpProxy:sendHttpRequest(require("app.core.utils.Utf8").urlencodeString(var_5_0.info.image), "GET", {
				success = function(arg_6_0)
					io.writefile(var_5_4, arg_6_0, "w+b")
					var_0_1:dispatchEvent(var_0_0.EVENT_DOWNLOAD_PIC_FINISH, {
						name = var_5_4
					})
				end,
				fail = function()
					return
				end,
				cancel = function()
					return
				end
			}, self)
		end
	end

	if var_5_0.info.time_type == var_0_5.TIME_TYPE.END_TIME then
		self.m_timeDescTxt:setText(g.core.lang:get(406508))
		self.m_activityTimeTxt:setText((g.core.lang:get(307025, {
			startTime = var_0_7:getTimeStringEx(var_5_0.info.start_time, true),
			endTime = var_0_7:getTimeStringEx(var_5_0.info.end_time, true)
		})))
	elseif var_5_0.info.time_type == var_0_5.TIME_TYPE.EXPIRE_TIME then
		self.m_timeDescTxt:setText(g.core.lang:get(406509))
		self.m_activityTimeTxt:setText((g.core.lang:get(307025, {
			startTime = var_0_7:getTimeStringEx(var_5_0.info.start_time, true),
			endTime = var_0_7:getTimeStringEx(var_5_0.info.show_end_time, true)
		})))
	end

	self.m_showTimeController:setSelectedIndex(var_5_0.info.time_type ~= var_0_5.TIME_TYPE.UNOPEN and 1 or 0)
end

function OpenScreenAdvPop:_onRcvDownloadPic(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = var_0_4:getCurAdv()

	if not var_9_0 then
		return
	end

	if var_9_0.info.adv_pic_type == var_0_5.ADV_TYPE.REMOTE_IMAGE then
		local var_9_1 = cc.FileUtils:getInstance():getWritablePath() .. ("gm_adv/" .. (MultilingualMgr:getUseLang() or config.DEFAULT_LANG) .. "/") .. tostring(var_9_0.info.id) .. ".png"

		if arg_9_3 and arg_9_3.name ~= var_9_1 then
			return
		end

		if io.exists(var_9_1) then
			self.m_picLoader:setURL(var_9_1)
		end
	end
end

function OpenScreenAdvPop:_onClickGotoModule(arg_10_1)
	arg_10_1:stopPropagation()

	local var_10_0 = var_0_4:getCurAdv()

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0.info.skipType

	if var_10_0.info.skipType == var_0_5.SKIP_TYPE.IN_GAME_URL then
		if device.isSdkEnabled() then
			local var_10_2 = tostring(var_10_0.info.route_id)

			if var_10_0.info.no_login == 0 then
				var_10_2 = var_10_2 .. "?" .. self:getLinkParams(var_10_0.info.id)
			end

			g.core.platform.PlatformProxy:openWebViewWithoutUser(var_10_2)
		end
	elseif var_10_1 == var_0_5.SKIP_TYPE.OUT_GAME_URL then
		local var_10_3 = tostring(var_10_0.info.route_id)

		if var_10_0.info.no_login == 0 then
			var_10_3 = var_10_3 .. "?" .. self:getLinkParams(var_10_0.info.id)
		end

		g.core.platform.PlatformProxy:openURL(var_10_3)
	elseif var_10_1 == var_0_5.SKIP_TYPE.PRIVATE_SPACE then
		if not g.core.platform.PlatformProxy:checkNewPrivateFunction(true) then
			return
		end

		g.core.platform.PlatformProxy:openSystemBrowser(tostring(var_10_0.info.route_id) .. "&biz_name=" .. g.core.platform.PlatformProxy:getGameId() .. "&userid=" .. g.core.platform.PlatformProxy:getSdkAccount())
	elseif var_10_0.info.route_id and tonumber(var_10_0.info.route_id) > 0 then
		var_0_3:gotoModule(tonumber(var_10_0.info.route_id))
	end
end

function OpenScreenAdvPop:getLinkParams(arg_11_1)
	local var_11_0 = g.core.platform.PlatformProxy:justGetLinkParamString(arg_11_1)
	local var_11_1 = md5.new()

	var_11_1:update(var_11_0 .. "95235e2f39dfa132b26388f53d1f99ab")

	return var_11_0 .. "&" .. "sign=" .. md5.tohex(var_11_1:finish())
end

function OpenScreenAdvPop:_onClickClose()
	if var_0_4:checkAllComplete() then
		var_0_2:popComponent()

		if self._closeCallBack then
			self._closeCallBack()
		end
	else
		var_0_4:goNext()
		self:_updateMainView()
		self.m_nextTransition:play()
	end
end

function OpenScreenAdvPop:_onCrossDayUpdate()
	var_0_4:reloadBaseInfo()

	if g.core.model.User.homeData:isHomeCrossDay() then
		var_0_2:popComponent()
	end
end

return OpenScreenAdvPop

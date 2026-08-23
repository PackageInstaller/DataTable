local UserTitleData = class("UserTitleData")
local var_0_1 = g.core.lang
local var_0_2 = g.core.config.title_info
local var_0_3 = g.core.model.User
local UserConst = require("app.view.module.user.const.UserConst")
local UserCommentConst = require("app.view.module.user.const.UserCommentConst")
local var_0_6 = g.core.const.ConstMgr.PlatformConst.REGION
local UserBindAccountConst = require("app.view.module.user.const.UserBindAccountConst")

function UserTitleData:ctor()
	self:initData()
end

function UserTitleData:initData()
	self._wearTitleIds = {}
	self._allTitlesCfgDataMap = {}
	self._allTitlesCfgData = {}
	self._menuInfos = {}
	self._bindAccountData = {}
	self._bindAccountAwarded = {}
	self._privateSpaceData = {}
	self._recordCommentDt = nil

	self:_init()
end

function UserTitleData:_init()
	self._allTitlesCfgDataMap = {}
	self._allTitlesCfgData = {}

	local var_3_0 = g.core.platform.ServerListProxy:isTesting()

	for iter_3_0 = 1, var_0_2.getLength() do
		local var_3_1 = clone(var_0_2.indexOf(iter_3_0))

		if var_3_1.put == 1 and g.core.utils.Tools.isOpIdMatchWithInfo(var_3_1, var_0_2) and not (var_3_0 and (var_3_1.id == 52001 or var_3_1.id == 52002)) then
			self._allTitlesCfgDataMap[var_3_1.title_type] = self._allTitlesCfgDataMap[var_3_1.title_type] or {}

			table.insert(self._allTitlesCfgDataMap[var_3_1.title_type], {
				cfgData = var_3_1
			})
		end
	end

	self:_checkSpData()
	self:_setMenuData()
end

function UserTitleData:_checkSpData()
	if g.core.platform.PlatformProxy:isXiaoQiChannel() or g.core.platform.PlatformProxy:isBuleChannel() then
		UserBindAccountConst.btnConfig[config.PUBLISH_REGION].android = {
			{
				selIndex = 4,
				showName = "Google",
				resultName = "google",
				SDKName = "Google"
			}
		}

		for iter_4_0, iter_4_1 in ipairs(g.core.const.ConstMgr.ShareConst.SHARE_REGION_CFG[config.PUBLISH_REGION]) do
			if iter_4_1 == "7" then
				table.remove(g.core.const.ConstMgr.ShareConst.SHARE_REGION_CFG[config.PUBLISH_REGION], iter_4_0)

				break
			end
		end
	end
end

function UserTitleData:getAllOwnTitle()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self._allTitlesCfgDataMap) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			if iter_5_3.isOwn then
				table.insert(var_5_0, iter_5_3)
			end
		end
	end

	self:_sortTitlesData(var_5_0)

	return var_5_0
end

function UserTitleData:resetAllOwnTitle(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		iter_6_1.weared = false

		table.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function UserTitleData:isTitleWearing(arg_7_1)
	for iter_7_0, iter_7_1 in pairs((clone(var_0_3:getAllWearingTitleIds()))) do
		if iter_7_1 == arg_7_1 then
			return true
		end
	end

	return false
end

function UserTitleData:isOwnTitle(arg_8_1)
	for iter_8_0, iter_8_1 in pairs((clone(var_0_3:getAllTitles()))) do
		if iter_8_1.id == arg_8_1 then
			if clone(var_0_2.get(arg_8_1)).time_type == 2 then
				if iter_8_1.status > g.core.common.ServerTime:getTime() then
					return true, iter_8_1.status
				end
			else
				return true, iter_8_1.status
			end
		end
	end

	return false, nil
end

function UserTitleData:getTitleDataByType(arg_9_1)
	local var_9_0 = {}

	if (arg_9_1 or UserConst.TITLE_TYPE_INDEX.ALL) ~= UserConst.TITLE_TYPE_INDEX.ALL then
		var_9_0 = clone(self._allTitlesCfgDataMap[arg_9_1 or UserConst.TITLE_TYPE_INDEX.ALL])

		self:_sortTitlesData(var_9_0)
	else
		for iter_9_0, iter_9_1 in pairs(self._allTitlesCfgDataMap) do
			for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
				table.insert(var_9_0, iter_9_3)
			end
		end

		self:_sortTitlesData(var_9_0)
	end

	for iter_9_4 = #var_9_0, 1, -1 do
		if var_9_0[iter_9_4].cfgData.show == 1 and not var_9_0[iter_9_4].isOwn then
			table.remove(var_9_0, iter_9_4)
		end
	end

	return var_9_0
end

function UserTitleData:_sortTitlesData(arg_10_1)
	table.sort(arg_10_1, function(arg_11_0, arg_11_1)
		local var_11_0 = not self:judgeUserTitleNewSetting(arg_11_0.cfgData.id) and 1 or 0
		local var_11_1 = not self:judgeUserTitleNewSetting(arg_11_1.cfgData.id) and 1 or 0
		local var_11_2 = arg_11_0.isOwn and 1 or 0
		local var_11_3 = arg_11_1.isOwn and 1 or 0

		if (arg_11_0.weared and 1 or 0) ~= (arg_11_1.weared and 1 or 0) then
			return (arg_11_1.weared and 1 or 0) < (arg_11_0.weared and 1 or 0)
		end

		if var_11_2 ~= var_11_3 then
			return var_11_3 < var_11_2
		end

		if arg_11_0.cfgData.quality ~= arg_11_1.cfgData.quality then
			return arg_11_0.cfgData.quality > arg_11_1.cfgData.quality
		end

		if arg_11_0.cfgData.id ~= arg_11_1.cfgData.id then
			return arg_11_0.cfgData.id > arg_11_1.cfgData.id
		end
	end)
end

function UserTitleData:updateTitleDataByState()
	for iter_12_0, iter_12_1 in pairs(self._allTitlesCfgDataMap) do
		for iter_12_2, iter_12_3 in pairs(iter_12_1) do
			iter_12_3.isOwn = not not self:isOwnTitle(iter_12_3.cfgData.id)
			iter_12_3.weared = not not self:isTitleWearing(iter_12_3.cfgData.id)
		end
	end
end

function UserTitleData:getTitleCfgInfoById(arg_13_1)
	return (clone(var_0_2.get(arg_13_1)))
end

function UserTitleData:getTitleInfoById(arg_14_1)
	local var_14_0 = {}

	if arg_14_1 then
		var_14_0.cfgInfo = clone(var_0_2.get(arg_14_1))
		var_14_0.isOwn = false
		var_14_0.weared = false

		local var_14_1, var_14_2 = self:isOwnTitle(arg_14_1)

		if self:isOwnTitle(arg_14_1) then
			var_14_0.isOwn = true
			var_14_0.ownTime = var_14_2
		end

		if self:isTitleWearing(arg_14_1) then
			var_14_0.weared = true
		end
	end

	return var_14_0
end

function UserTitleData:getTitleAttrsById(arg_15_1)
	local var_15_0 = {}
	local var_15_1 = var_0_2.get(arg_15_1)

	if arg_15_1 and arg_15_1 > 0 then
		if var_15_1.activate_talent == 0 then
			return var_15_0
		end

		local var_15_2 = g.core.config.talent_skill_info.get(var_15_1.activate_talent)

		for iter_15_0 = 1, 3 do
			if var_15_2["affect_type_" .. iter_15_0] > 0 then
				local var_15_3, var_15_4 = g.core.lang:getAttr(var_15_2["affect_type_" .. iter_15_0], var_15_2["affect_value_" .. iter_15_0])
				local var_15_5, var_15_6, var_15_7, var_15_8

				if var_15_2["affect_target_" .. iter_15_0] == 2 then
					var_15_5 = var_0_1:get(105508)

					if not var_15_5 then
						var_15_5 = var_0_1:get(105509)
						var_15_6 = var_15_4
						var_15_7 = var_15_0
						var_15_8 = {}
					end
				end

				var_15_8.name = var_15_5 .. var_15_3
				var_15_8.value = var_15_4

				table.insert(var_15_0, var_15_8)
			end
		end
	end

	return var_15_0
end

function UserTitleData:getTitleAllAttrsData()
	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_2 = {}
	local var_16_3 = {}
	local var_16_4 = {}
	local var_16_5 = {}

	local function var_16_6(arg_17_0, arg_17_1)
		local var_17_0, var_17_1

		if arg_17_1 then
			var_17_0 = var_16_1 or var_16_0

			if arg_17_1 then
				var_17_1 = var_16_3 or var_16_2
			end
		end

		local var_17_2 = g.core.config.talent_skill_info.get(arg_17_0)

		for iter_17_0 = 1, 3 do
			if var_17_2["affect_type_" .. iter_17_0] > 0 then
				if var_17_1[var_17_2["affect_type_" .. iter_17_0] .. "_" .. var_17_2["affect_target_" .. iter_17_0]] then
					var_17_1[var_17_2["affect_type_" .. iter_17_0] .. "_" .. var_17_2["affect_target_" .. iter_17_0]].value = var_17_1[var_17_2["affect_type_" .. iter_17_0] .. "_" .. var_17_2["affect_target_" .. iter_17_0]].value + var_17_2["affect_value_" .. iter_17_0]
				else
					local var_17_3 = {
						type = var_17_2["affect_type_" .. iter_17_0],
						value = var_17_2["affect_value_" .. iter_17_0],
						target = var_17_2["affect_target_" .. iter_17_0],
						forever = arg_17_1
					}

					var_17_0[#var_17_0 + 1] = var_17_3
					var_17_1[var_17_2["affect_type_" .. iter_17_0] .. "_" .. var_17_2["affect_target_" .. iter_17_0]] = var_17_3
				end
			end
		end
	end

	for iter_16_0, iter_16_1 in ipairs((self:getAllOwnTitle())) do
		local var_16_7 = var_0_2.get(iter_16_1.cfgData.id)

		if var_16_7.activate_talent ~= 0 then
			var_16_6(var_16_7.activate_talent, true)
		end
	end

	if #var_16_0 > 0 then
		var_16_4[#var_16_4 + 1] = {
			type = 0,
			value = g.core.lang:get(105506)
		}
	end

	for iter_16_2 = 1, math.ceil(#var_16_0 / 2) do
		local var_16_8 = {}

		for iter_16_3 = 1, 2 do
			if var_16_0[(iter_16_2 - 1) * 2 + iter_16_3] then
				table.insert(var_16_8, var_16_0[(iter_16_2 - 1) * 2 + iter_16_3])
			end
		end

		var_16_4[#var_16_4 + 1] = var_16_8
	end

	if #var_16_1 > 0 then
		var_16_4[#var_16_4 + 1] = {
			type = 0,
			value = g.core.lang:get(105507)
		}
	end

	for iter_16_4 = 1, math.ceil(#var_16_1 / 2) do
		local var_16_9 = {}

		for iter_16_5 = 1, 2 do
			if var_16_1[(iter_16_4 - 1) * 2 + iter_16_5] then
				table.insert(var_16_9, var_16_1[(iter_16_4 - 1) * 2 + iter_16_5])
			end
		end

		var_16_4[#var_16_4 + 1] = var_16_9
	end

	for iter_16_6, iter_16_7 in ipairs(var_16_4) do
		for iter_16_8 = 1, 2 do
			if iter_16_7[iter_16_8] then
				table.insert(var_16_5, iter_16_7[iter_16_8])
			end
		end
	end

	table.sort(var_16_5, function(arg_18_0, arg_18_1)
		if arg_18_0.type ~= arg_18_1.type then
			return arg_18_0.type < arg_18_1.type
		end

		return false
	end)

	return var_16_5
end

function UserTitleData:setMenuData()
	self:_setMenuData()
end

function UserTitleData:_setMenuData()
	local var_20_0 = g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].HIDE_GIFT_CODE_BTN
	local var_20_1 = g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].HIDE_DELETE_ACCOUNT
	local var_20_2 = g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].HIDE_BIND_ACCOUNT_BTN
	local var_20_3 = g.core.platform.PlatformProxy:hasCustomerService() ~= true
	local var_20_4 = false
	local var_20_5 = g.core.platform.PlatformProxy:getOpId()
	local var_20_6 = false
	local var_20_7 = {
		[g.core.const.ConstMgr.PlatformConst.REGION.SEA] = true,
		[g.core.const.ConstMgr.PlatformConst.REGION.JAPAN] = true,
		[g.core.const.ConstMgr.PlatformConst.REGION.TW] = true
	}
	local var_20_8 = not g.core.platform.PlatformProxy:isChannelOfChina() and not g.core.platform.ServerListProxy:isTesting() and not var_20_7[config.PUBLISH_REGION]

	if g.core.platform.PlatformProxy:isChannelOfChina() then
		var_20_2 = true
	end

	local ChannelConst = require("app.core.platform.const.ChannelConst")
	local var_20_10 = g.core.platform.PlatformProxy:getCurChannel()

	if var_20_10.name == ChannelConst.ChannelNames.HUAWEI then
		var_20_6 = true
	end

	if var_20_10.sdkChanel ~= ChannelConst.ChannelNames.YOOZOO and var_20_10.name ~= ChannelConst.ChannelNames.AIMUY then
		var_20_3 = true
		var_20_4 = true
	end

	if var_20_10.sdkChanel ~= ChannelConst.ChannelNames.YOOZOO then
		var_20_1 = true
	end

	if not g.core.platform.PlatformProxy:isChannelOfChina() then
		var_20_4 = true
	end

	if g.core.platform.PlatformProxy:isChannelOfEn() then
		if tostring(var_20_5) == "2757" then
			var_20_3 = false
			var_20_1 = true
		elseif tostring(var_20_5) == "2941" then
			var_20_3 = true
			var_20_1 = true
		elseif tostring(var_20_5) == "3239" then
			var_20_3 = true
			var_20_2 = true
		end
	end

	local var_20_11 = g.core.platform.PlatformProxy:getChannelKey()

	if g.core.platform.PlatformProxy:isXiaoQiChannel() then
		var_20_2 = true
		var_20_3 = true
	end

	if var_20_7[config.PUBLISH_REGION] then
		var_20_1 = false
	end

	local var_20_12 = {
		{
			funcRef = "_onShowAgreement",
			icon = "ui://user/icon_xx_yinsixieyi",
			isShow = config.SHOW_USER_PROXY,
			title = var_0_1:get(105511)
		},
		{
			funcRef = "_onShowGameCodePop",
			icon = "ui://user/icon_xx_duihuanma",
			isShow = not var_20_0 and not g.core.platform.ServerListProxy:isTesting(),
			title = var_0_1:get(105513)
		},
		{
			funcRef = "_onShowUser",
			isShow = not var_20_3,
			title = var_0_1:get(105514),
			icon = g.core.platform.PlatformProxy:isChannelOfChina() and "ui://user/icon_xx_yinsixieyi" or "ui://user/icon_xx_xiaoyoujingling"
		},
		{
			funcRef = "_onSwitchAccount",
			isShow = true,
			icon = "ui://user/icon_xx_qiehuanzhanghao",
			title = var_0_1:get(105515)
		},
		{
			funcRef = "_onShowQuestionPage",
			redId = 171,
			icon = "ui://user/icon_xx_qiehuanzhanghao",
			isShow = var_0_3.questionnaireData:isShowQuestion(),
			title = var_0_1:get(105520)
		}
	}
	local var_20_13 = {
		funcRef = "_onShowTwitterPage",
		redId = 167,
		icon = "ui://user/icon_xx_bangdingshouji",
		funcId = 25028,
		isShow = var_20_8
	}

	if config.PUBLISH_REGION == var_0_6.JAPAN then
		var_20_13.title = var_0_1:get(105521) or var_0_1:get(105523)
	end

	var_20_12[6] = var_20_13

	local var_20_14 = {
		funcRef = "_onShoDiscordPage",
		redId = 168,
		icon = "ui://user/icon_xx_bangdingshouji",
		funcId = 25029,
		isShow = not g.core.platform.PlatformProxy:isChannelOfChina() and not g.core.platform.ServerListProxy:isTesting()
	}

	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR then
		var_20_14.title = var_0_1:get(105535) or var_0_1:get(105522)
	end

	var_20_12[7] = var_20_14
	var_20_12[8] = {
		funcRef = "_onExitGameAccount",
		icon = "ui://user/icon_xx_qiehuanzhanghao",
		isShow = not var_20_1 and device.platform ~= "android" and g.core.platform.ServerListProxy:isTesting(),
		title = var_0_1:get(101908)
	}
	var_20_12[9] = {
		funcRef = "_onBindAccount",
		redId = 314,
		icon = "ui://user/icon_xx_bangdingshouji",
		isShow = config.PCSDK_ENABLED ~= true and not var_20_2,
		title = var_0_1:get(105524)
	}

	local var_20_15 = {
		funcRef = "_onShowThirdTip",
		isShow = g.core.platform.PlatformProxy:isChannelOfChina(),
		title = var_0_1:get(105525)
	}

	var_20_15.icon = g.core.platform.PlatformProxy:isChannelOfChina() and "ui://user/icon_xx_yinsixieyi"
	var_20_12[10] = var_20_15

	local var_20_16 = {
		funcRef = "_onShowCollectInfoTip",
		isShow = g.core.platform.PlatformProxy:isChannelOfChina(),
		title = var_0_1:get(105526)
	}

	var_20_16.icon = g.core.platform.PlatformProxy:isChannelOfChina() and "ui://user/icon_xx_yinsixieyi"
	var_20_12[11] = var_20_16

	local var_20_17 = {
		funcRef = "_onShowPermissionPop",
		isShow = g.core.platform.PlatformProxy:isChannelOfChina(),
		title = var_0_1:get(105527)
	}

	var_20_17.icon = g.core.platform.PlatformProxy:isChannelOfChina() and "ui://user/icon_xx_yinsixieyi"
	var_20_12[12] = var_20_17

	local var_20_18 = {
		funcRef = "_onShowPhoneBindPop",
		isShow = not var_20_4,
		title = var_0_1:get(105528)
	}

	var_20_18.icon = g.core.platform.PlatformProxy:isChannelOfChina() and "u_onShowPermissionPopi://user/icon_xx_yinsixieyi"
	var_20_12[13] = var_20_18

	local var_20_19 = {
		funcRef = "_onOpenBilibili",
		isShow = self:isChannelOfBiliBili(),
		title = var_0_1:get(105531)
	}

	var_20_19.icon = g.core.platform.PlatformProxy:isChannelOfChina() and "ui://user/icon_xx_xiaoyoujingling"
	var_20_12[14] = var_20_19

	local var_20_20 = {
		funcRef = "_onOpenTap",
		isShow = self:isChannelOfTap(),
		title = var_0_1:get(105532)
	}

	var_20_20.icon = g.core.platform.PlatformProxy:isChannelOfChina() and "ui://user/icon_xx_xiaoyoujingling"
	var_20_12[15] = var_20_20

	local var_20_21 = {
		funcRef = "_onLogoffTip",
		isShow = var_20_6,
		title = var_0_1:get(105530)
	}

	var_20_21.icon = g.core.platform.PlatformProxy:isChannelOfChina() and "ui://user/icon_xx_xiaoyoujingling"
	var_20_12[16] = var_20_21
	var_20_12[17] = {
		funcRef = "_onOpenWXPage",
		redId = 2001,
		icon = "ui://user/icon_xx_qiyeweixin",
		isShow = self:isShowWX(),
		title = var_0_1:get(105536)
	}
	var_20_12[18] = {
		funcRef = "_onOpenHYPage",
		redId = 1128,
		icon = "ui://user/icon_xx_qiyeweixin",
		isShow = self:isShowHY(),
		title = var_0_1:get(105537)
	}

	local var_20_22 = {
		funcRef = "_onClickUnBind",
		icon = "ui://user/icon_xx_jiechubangding"
	}

	var_20_22.isShow = device.isOHOS() and g.core.platform.PlatformProxy:isShowUnbind(handler(self, function(arg_21_0, arg_21_1)
		if arg_21_1 then
			table.insert(arg_21_0._menuInfos, arg_21_1)
		else
			table.insert(arg_21_0._menuInfos, arg_21_1)
		end
	end))
	var_20_22.title = var_0_1:get(105539)
	var_20_12[19] = var_20_22

	local var_20_23 = {
		funcRef = "_onClickUnBind",
		icon = "ui://user/icon_xx_jiechubangding",
		title = var_0_1:get(105539)
	}

	var_20_23.isShow = g.core.platform.PlatformProxy:isShowUnbind(handler(self, function(arg_22_0, arg_22_1)
		var_20_23.isShow = arg_22_1

		if arg_22_1 then
			table.insert(arg_22_0._menuInfos, var_20_23)
		end
	end))
	self._menuInfos = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_12) do
		if iter_20_1.isShow then
			table.insert(self._menuInfos, iter_20_1)
		end
	end
end

function UserTitleData:isShowWX()
	if g.core.platform.ServerListProxy:isTesting() then
		return false
	end

	if config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		return false
	end

	local ChannelConst = require("app.core.platform.const.ChannelConst")
	local var_23_1 = g.core.platform.PlatformProxy:getCurChannel()

	return var_23_1.name == ChannelConst.ChannelNames.TAPTAP or var_23_1.name == ChannelConst.ChannelNames.YOOZOO or var_23_1.name == ChannelConst.ChannelNames.HAOYOUKB
end

function UserTitleData:isShowHY()
	local var_24_0, var_24_1

	if config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		do return false end

		var_24_0 = g.core.platform.PlatformProxy:getCurChannel()
		var_24_1 = var_24_0.name
	end

	return var_24_1 == require("app.core.platform.const.ChannelConst").ChannelNames.HUANYOU and var_24_0.debugName ~= "HUANYOU-WEB-ANDROID"
end

function UserTitleData:isChannelOfBiliBili()
	if g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.BILI then
		return true
	end

	return false
end

function UserTitleData:isChannelOfTap()
	if g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.TAPTAP then
		return true
	end

	return false
end

function UserTitleData:getMenuData()
	return self._menuInfos
end

function UserTitleData:setTitleState(arg_28_1)
	g.core.common.Storage:save("newTitleBool.json", {
		data = arg_28_1
	})
end

function UserTitleData:setNewTitleId(arg_29_1)
	g.core.common.Storage:save("newTitleValue.json", {
		data = arg_29_1
	})
end

function UserTitleData:getTitleState()
	local var_30_0 = g.core.common.Storage:load("newTitleValue.json")

	if not var_30_0 then
		return false
	end

	return var_30_0.data ~= 0
end

function UserTitleData:getNewTitleId()
	local var_31_0 = g.core.common.Storage:load("newTitleValue.json")

	if not var_31_0 then
		return 0
	end

	return var_31_0.data
end

function UserTitleData:isHasNewTitle(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs((var_0_2.match(function(arg_33_0)
		return arg_33_0.title_type == arg_32_1
	end))) do
		if iter_32_1.id == self:getNewTitleId() then
			return true
		end
	end

	return false
end

function UserTitleData:isHasGetTitleNew(arg_34_1)
	if arg_34_1 and arg_34_1.id then
		if self:isOwnTitle(arg_34_1.id) and not self:judgeUserTitleNewSetting(arg_34_1.id) then
			return true
		end
	else
		for iter_34_0, iter_34_1 in ipairs((self:getAllOwnTitle())) do
			if not self:judgeUserTitleNewSetting(iter_34_1.cfgData.id) then
				return true
			end
		end
	end

	return false
end

function UserTitleData:_getUserTitleNewSettingStr(arg_35_1)
	return "UserTitleNewRecord" .. tostring(arg_35_1) .. "_" .. tostring((g.core.model.User:getId())) .. "_" .. tostring(g.core.platform.ServerListProxy:getSelectedServer().sid)
end

function UserTitleData:setUserTitleNewSettingRecord(arg_36_1)
	local var_36_0 = self._userTitleNewSetConfig

	if not self._userTitleNewSetConfig then
		var_36_0 = g.core.common.Storage:load("UserTitleNewRecord.json", false)
		var_36_0 = var_36_0 or {}
	end

	self._userTitleNewSetConfig = var_36_0
	self._userTitleNewSetConfig[self:_getUserTitleNewSettingStr(arg_36_1)] = "1"

	g.core.common.Storage:save("UserTitleNewRecord.json", self._userTitleNewSetConfig, false)
end

function UserTitleData:judgeUserTitleNewSetting(arg_37_1)
	local var_37_0 = g.core.common.Storage:load("UserTitleNewRecord.json", false) or {}
	local var_37_1 = self:_getUserTitleNewSettingStr(arg_37_1)

	if var_37_0[var_37_1] and var_37_0[var_37_1] == "1" then
		return true
	end

	return false
end

function UserTitleData:setBindAccountData(arg_38_1)
	self._bindAccountData = arg_38_1 or {}
end

function UserTitleData:setAccountBind(arg_39_1)
	if UserBindAccountConst.RETURN_MAP[arg_39_1] then
		self._bindAccountData[UserBindAccountConst.RETURN_MAP[arg_39_1]] = 1
	end
end

function UserTitleData:isAccountBind(arg_40_1)
	return self._bindAccountData[arg_40_1] and self._bindAccountData[arg_40_1] == 1
end

function UserTitleData:isCanBindAccountAward()
	if g.core.platform.PlatformProxy:isChannelOfChina() then
		return false, {}
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.REWARD_BIND_ACCOUNT) or not g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0() then
		return false
	end

	if g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].HIDE_BIND_ACCOUNT_BTN then
		return false
	end

	local var_41_0 = {}
	local var_41_1 = false

	if UserBindAccountConst.defaultRegion[config.PUBLISH_REGION] then
		if UserBindAccountConst.defaultRegion[config.PUBLISH_REGION].stateFunc and UserBindAccountConst.defaultRegion[config.PUBLISH_REGION].stateFunc() and not self._bindAccountAwarded[UserBindAccountConst.NORMAL_BIND] then
			var_41_1 = true

			table.insert(var_41_0, UserBindAccountConst.NORMAL_BIND)
		end
	elseif self._bindAccountData[UserBindAccountConst.default.resultName] == 1 and not self._bindAccountAwarded[UserBindAccountConst.NORMAL_BIND] then
		var_41_1 = true

		table.insert(var_41_0, UserBindAccountConst.NORMAL_BIND)
	end

	if not self._bindAccountAwarded[UserBindAccountConst.OTHER_BIND] then
		for iter_41_0, iter_41_1 in ipairs((UserBindAccountConst.btnConfig[config.PUBLISH_REGION] or nil) and (UserBindAccountConst.btnConfig[config.PUBLISH_REGION][device.platform] or UserBindAccountConst.btnConfig[config.PUBLISH_REGION].android)) do
			if self._bindAccountData[iter_41_1.resultName] == 1 then
				var_41_1 = true

				table.insert(var_41_0, UserBindAccountConst.OTHER_BIND)
			end
		end
	end

	return var_41_1, var_41_0
end

function UserTitleData:isNotOneAccountBind()
	if g.core.platform.PlatformProxy:isChannelOfChina() then
		return false
	end

	if config.PCSDK_ENABLED then
		return false
	end

	if UserBindAccountConst.defaultRegion[config.PUBLISH_REGION] then
		if UserBindAccountConst.defaultRegion[config.PUBLISH_REGION].stateFunc and UserBindAccountConst.defaultRegion[config.PUBLISH_REGION].stateFunc() then
			return false
		end
	end

	if self._bindAccountData[UserBindAccountConst.default.resultName] == 1 or not g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0() then
		return false
	end

	for iter_42_0, iter_42_1 in ipairs((UserBindAccountConst.btnConfig[config.PUBLISH_REGION] or nil) and (UserBindAccountConst.btnConfig[config.PUBLISH_REGION][device.platform] or UserBindAccountConst.btnConfig[config.PUBLISH_REGION].android)) do
		if self._bindAccountData[iter_42_1.resultName] == 1 then
			return false
		end
	end

	return true
end

function UserTitleData:bindAccountAward(arg_43_1)
	self._bindAccountAwarded[arg_43_1.account_type] = true
end

function UserTitleData:setAccountAwardState(arg_44_1)
	for iter_44_0, iter_44_1 in ipairs(arg_44_1.award_record) do
		self._bindAccountAwarded[iter_44_1.id] = iter_44_1.num == 1
	end
end

function UserTitleData:hasGetGtaAward()
	return self._bindAccountAwarded[UserBindAccountConst.NORMAL_BIND] or false
end

function UserTitleData:hasGetOtherAward()
	return self._bindAccountAwarded[UserBindAccountConst.OTHER_BIND] or false
end

function UserTitleData:setScorePushState()
	self._pushScore = true
end

function UserTitleData:checkScorePush()
	if g.core.platform.PlatformProxy:isChannelOfKr() then
		local var_48_0 = tonumber(g.core.platform.PlatformProxy:getOpId())

		if var_48_0 == 2670 or var_48_0 == 2731 or var_48_0 == 2728 or var_48_0 == 2757 then
			return
		end
	end

	if self._pushScore and g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0() then
		self._pushScore = false

		if g.core.const.ConstMgr.PlatformConst.REGION.CHINA == config.PUBLISH_REGION and not device.isAndroid() or g.core.const.ConstMgr.PlatformConst.REGION.CHINA ~= config.PUBLISH_REGION then
			g.core.platform.PlatformProxy:getStoreReview()
		end
	end
end

function UserTitleData:setSpecialShowActionIsHide(arg_49_1)
	local var_49_0 = g.core.common.Storage:load("specialShow.json", true) or {}

	var_49_0.hide = arg_49_1

	g.core.common.Storage:save("specialShow.json", var_49_0)
end

function UserTitleData:setSpecialSkillActionIsHide(arg_50_1)
	local var_50_0 = g.core.common.Storage:load("specialSkill.json", true) or {}

	var_50_0.hide = arg_50_1

	g.core.common.Storage:save("specialSkill.json", var_50_0)
end

function UserTitleData:setSuccubaShowActionIsHide(arg_51_1)
	local var_51_0 = g.core.common.Storage:load("succubaShow.json", true) or {}

	var_51_0.hide = arg_51_1

	g.core.common.Storage:save("succubaShow.json", var_51_0)
end

function UserTitleData:getSuccubaSkillIsHide()
	return (g.core.common.Storage:load("succubaShow.json", true) or {}).hide or 0
end

function UserTitleData:isSuccubaSkillHide()
	local var_53_0 = g.core.common.Storage:load("succubaShow.json", true) or {
		hide = 0
	}

	if not var_53_0 or var_53_0.hide == 2 then
		return false
	end

	if var_53_0.hide == 0 and self:isFirstSuccubaSkill() then
		self:setSuccubaSkillIsFirstDay()

		return false
	end

	return true
end

function UserTitleData:isFirstSuccubaSkill()
	local var_54_0 = g.core.common.Storage:load("succubaShow.json", true)

	if not var_54_0 then
		return true
	end

	return var_54_0.day ~= g.core.common.ServerTime:getDate()
end

function UserTitleData:setSuccubaSkillIsFirstDay()
	local var_55_0 = g.core.common.Storage:load("succubaShow.json", true)

	if not var_55_0 then
		var_55_0 = {}

		self:setSuccubaShowActionIsHide(false)
	end

	var_55_0.day = g.core.common.ServerTime:getDate()

	g.core.common.Storage:save("succubaShow.json", var_55_0, true)
end

function UserTitleData:getSpecialShowActionIsHide()
	return (g.core.common.Storage:load("specialShow.json", true) or {}).hide or 2
end

function UserTitleData:isSpecialShowActionHide(arg_57_1)
	local var_57_0 = g.core.common.Storage:load("specialShow.json", true)

	if not var_57_0 or var_57_0.hide == 2 or var_57_0.hide == false then
		return false
	end

	if var_57_0.hide == 0 and self:isFirstSpecialShowAction(arg_57_1) then
		self:setSpecialShowActionIsFirstDay(arg_57_1)

		return false
	end

	return true
end

function UserTitleData:setSpecialShowActionIsFirstDay(arg_58_1)
	local var_58_0 = g.core.common.Storage:load("specialShow.json", true)

	if not var_58_0 then
		var_58_0 = {}

		self:setSpecialShowActionIsHide(2)
	end

	var_58_0.day = var_58_0.day or {}
	var_58_0.day[arg_58_1] = g.core.common.ServerTime:getDate()

	g.core.common.Storage:save("specialShow.json", var_58_0, true)
end

function UserTitleData:isFirstSpecialShowAction(arg_59_1)
	local var_59_0 = g.core.common.Storage:load("specialShow.json", true)

	if not var_59_0 then
		return true
	end

	var_59_0.day = var_59_0.day or {}

	return var_59_0.day[arg_59_1] ~= g.core.common.ServerTime:getDate()
end

function UserTitleData:setSpecialSkillIsHide(arg_60_1)
	local var_60_0 = g.core.common.Storage:load("specialSkill.json", true) or {}

	var_60_0.hide = arg_60_1

	g.core.common.Storage:save("specialSkill.json", var_60_0, true)
end

function UserTitleData:getSpecialSkillIsHide()
	return (g.core.common.Storage:load("specialSkill.json", true) or {}).hide or 0
end

function UserTitleData:isSpecialSkillHide()
	local var_62_0 = g.core.common.Storage:load("specialSkill.json", true)

	if not var_62_0 or var_62_0.hide == 2 then
		return false
	end

	if var_62_0.hide == 0 and self:isFirstSpecialSkill() then
		self:setSpecialSkillIsFirstDay()

		return false
	end

	return true
end

function UserTitleData:setSpecialSkillIsFirstDay()
	local var_63_0 = g.core.common.Storage:load("specialSkill.json", true)

	if not var_63_0 then
		var_63_0 = {}

		self:setSpecialSkillActionIsHide(2)
	end

	var_63_0.day = g.core.common.ServerTime:getDate()

	g.core.common.Storage:save("specialSkill.json", var_63_0, true)
end

function UserTitleData:isFirstSpecialSkill()
	local var_64_0 = g.core.common.Storage:load("specialSkill.json", true)

	if not var_64_0 then
		return true
	end

	return var_64_0.day ~= g.core.common.ServerTime:getDate()
end

function UserTitleData:setWXPageOpen(arg_65_1)
	g.core.common.Storage:save("bindWx.json", {
		show = not arg_65_1
	}, true)
end

function UserTitleData:showWXPageRed()
	if not self:isShowWX() then
		return false
	end

	local var_66_0 = g.core.common.Storage:load("bindWx.json", true)

	if not var_66_0 then
		return true
	end

	return var_66_0.show
end

function UserTitleData:setPrivateSpaceInfo(arg_67_1)
	self._privateSpaceData = arg_67_1
end

function UserTitleData:isNeedShowVipPrivatePop()
	return self._privateSpaceData.is_vip_wecom_pop
end

function UserTitleData:isNeedShowGeneralPrivatePop()
	return self._privateSpaceData.is_general_wecom_pop
end

function UserTitleData:checkAndShowCommentArea(arg_70_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TAPTAP_COMMIT) then
		return
	end

	self._recordCommentDt = self._recordCommentDt or g.core.common.Storage:load("comment_record_cache.json") or {}

	local var_70_0 = self._recordCommentDt[tostring(arg_70_1)] or 0

	if var_70_0 >= UserCommentConst[arg_70_1] then
		return
	end

	if (self._recordCommentDt.checkCanPopTime or 0) <= g.core.common.ServerTime:getTime() then
		self._recordCommentDt[tostring(arg_70_1)] = var_70_0 + 1

		g.core.platform.PlatformProxy:openTapTapCommentArea()
		g.core.common.Storage:save("comment_record_cache.json", self._recordCommentDt)
	end
end

function UserTitleData:setLastShowTime(arg_71_1)
	self._recordCommentDt = self._recordCommentDt or g.core.common.Storage:load("comment_record_cache.json") or {}
	self._recordCommentDt.checkCanPopTime = g.core.common.ServerTime:getTime() + arg_71_1 * 86400

	g.core.common.Storage:save("comment_record_cache.json", self._recordCommentDt)
end

function UserTitleData:checkRecruitPopComment(arg_72_1)
	if arg_72_1.num == 1 then
		for iter_72_0, iter_72_1 in ipairs(arg_72_1.recruit_info) do
			if iter_72_1.is_up and iter_72_1.r_type ~= 3 then
				self:checkAndShowCommentArea(UserCommentConst.KEYS.UP_ONE_RECRUIT_TIMES)
			end
		end
	else
		local var_72_0 = g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_72_1.recruit_type)

		if var_72_0.up_content_value_2 > 0 then
			local var_72_1 = {
				[var_72_0.up_content_type .. "_" .. var_72_0.up_content_value] = false,
				[var_72_0.up_content_type_2 .. "_" .. var_72_0.up_content_value_2] = false
			}
			local var_72_2 = {
				[var_72_0.up_content_type .. "_" .. var_72_0.up_content_value] = true,
				[var_72_0.up_content_type_2 .. "_" .. var_72_0.up_content_value_2] = true
			}

			for iter_72_2, iter_72_3 in ipairs((g.core.common.Goods:convertAwards(arg_72_1.awards))) do
				if var_72_2[iter_72_3.type .. "_" .. iter_72_3.value] then
					var_72_1[iter_72_3.type .. "_" .. iter_72_3.value] = true
				end
			end

			if var_72_1[var_72_0.up_content_type .. "_" .. var_72_0.up_content_value] and var_72_1[var_72_0.up_content_type_2 .. "_" .. var_72_0.up_content_value_2] then
				self:checkAndShowCommentArea(UserCommentConst.KEYS.UP_TEN_RECRUIT_TIMES_DOUBLE)
			end
		else
			for iter_72_4, iter_72_5 in ipairs(arg_72_1.recruit_info) do
				if iter_72_5.is_up == 1 and arg_72_1.recruit_info.r_type ~= 3 then
					self:checkAndShowCommentArea(UserCommentConst.KEYS.UP_TEN_RECRUIT_TIMES)
				end
			end
		end
	end
end

return UserTitleData

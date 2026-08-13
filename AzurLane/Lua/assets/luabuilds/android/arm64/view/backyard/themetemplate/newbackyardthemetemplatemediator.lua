class = var_0_10000

local var_0_0 = "NewBackYardThemeTemplateMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.FETCH_ALL_THEME = "NewBackYardThemeTemplateMediator:FETCH_ALL_THEME"
var_0_1.ON_CHARGE = "NewBackYardThemeTemplateMediator:ON_CHARGE"
var_0_1.ON_SHOPPING = "NewBackYardShopMediator:ON_SHOPPING"
var_0_1.ON_LIKE_THEME = "NewBackYardThemeTemplateMediator:ON_LIKE_THEME"
var_0_1.ON_COLECT_THEME = "NewBackYardThemeTemplateMediator:ON_COLECT_THEME"
var_0_1.ON_APPLY_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_APPLY_TEMPLATE"
var_0_1.ON_UPLOAD_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_UPLOAD_TEMPLATE"
var_0_1.ON_CANCEL_UPLOAD_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_CANCEL_UPLOAD_TEMPLATE"
var_0_1.ON_DELETE_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_DELETE_TEMPLATE"
var_0_1.GET_TEMPLATE_PLAYERINFO = "NewBackYardThemeTemplateMediator:GET_TEMPLATE_PLAYERINFO"
var_0_1.ON_DISPLAY_PLAYER_INFO = "NewBackYardThemeTemplateMediator:ON_DISPLAY_PLAYER_INFO"
var_0_1.ON_SEARCH = "NewBackYardThemeTemplateMediator:ON_SEARCH"
var_0_1.ON_REFRESH = "NewBackYardThemeTemplateMediator:ON_REFRESH"
var_0_1.ON_GET_THEMPLATE_DATA = "NewBackYardThemeTemplateMediator:ON_GET_THEMPLATE_DATA"
var_0_1.ON_GET_SPCAIL_TYPE_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_GET_SPCAIL_TYPE_TEMPLATE"
var_0_1.GO_DECORATION = "NewBackYardThemeTemplateMediator:GO_DECORATION"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_DECORATION, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_2_1(var_2_0, var_2_2, var_2_10005.COURTYARD, {
			openDecoration = true
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_SPCAIL_TYPE_TEMPLATE, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.BACKYARD_GET_SPECIFIED_TYPE_TEMPLATE, {
			type = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_THEMPLATE_DATA, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.BACKYARD_GET_THEME_TEMPLATE_DATA, {
			templateId = arg_4_1,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REFRESH, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		local var_5_0 = arg_1_0
		local var_5_1 = var_5.sendNotification

		GAME = var_2_10008

		var_5_1(var_5_0, var_2_10008.BACKYARD_REFRESH_SHOP_TEMPLATE, {
			timeType = arg_5_3,
			type = arg_5_1,
			page = arg_5_2,
			force = arg_5_4
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SEARCH, function(arg_6_0, arg_6_1, arg_6_2)
		BackYardConst = var_2_10003

		if arg_6_1 ~= var_2_10003.THEME_TEMPLATE_TYPE_CUSTOM then
			BackYardConst = var_3

			if arg_6_1 == var_3.THEME_TEMPLATE_TYPE_COLLECTION then
				local var_6_0 = arg_1_0.viewComponent

				var_3.SearchKeyChange(var_6_0, arg_6_2)
			else
				BackYardConst = var_3

				if arg_6_1 == var_3.THEME_TEMPLATE_TYPE_SHOP then
					local var_6_1 = arg_1_0
					local var_6_2 = var_3.sendNotification

					GAME = var_2_10006

					var_6_2(var_6_1, var_2_10006.BACKYARD_SEARCH_THEME_TEMPLATE, {
						str = arg_6_2
					})
				end
			end

			return
		end
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10006

		var_7_1(var_7_0, var_2_10006.BUY_FURNITURE, {
			furnitureIds = arg_7_1,
			type = arg_7_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_DISPLAY_PLAYER_INFO, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_1_0.contextData.pos = arg_8_2
		arg_1_0.contextData.themeName = arg_8_3

		local var_8_0 = arg_1_0
		local var_8_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_8_2 = var_2_10007.FRIEND_SEARCH
		local var_8_3 = {}

		SearchFriendCommand = var_2_10009
		var_8_3.type = var_2_10009.SEARCH_TYPE_RESUME
		var_8_3.keyword = arg_8_1

		var_8_1(var_8_0, var_8_2, var_8_3)

		return
	end)
	arg_1_0:bind(var_0_1.GET_TEMPLATE_PLAYERINFO, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_1_0
		local var_9_1 = var_3.sendNotification

		GAME = var_2_10006

		var_9_1(var_9_0, var_2_10006.BACKYARD_GET_THEME_TEMPLATE_PLAYE_INFO, {
			type = arg_9_1,
			templateId = arg_9_2.id,
			userId = arg_9_2:GetUserId()
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPLOAD_TEMPLATE, function(arg_10_0, arg_10_1)
		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_10_0 = var_2_10002(var_2_10004)
		local var_10_1 = var_2.getData(var_10_0)
		local var_10_2

		if not var_2.CanUploadBackYardThemeTemplate(var_10_1) then
			var_10_1 = var_2
			var_10_2 = var_2.GetBanUploadBackYardThemeTemplateTime(var_10_1)
			var_2_10006 = arg_1_0.contextData.msgBox
			var_10_0 = var_10_0.ExecuteAction

			local var_10_3 = "SetUp"

			var_2_10008 = {
				hideNo = true
			}
			i18n = var_2_10009
			var_2_10008.content = var_2_10009("backyard_theme_ban_upload_tip", var_10_2)

			var_10_0(var_2_10006, var_10_3, var_2_10008)

			return
		end

		getProxy = var_10_2
		DormProxy = var_10_1

		local var_10_4 = var_10_2(var_10_1)
		local var_10_5 = var_3.GetUploadThemeTemplateCnt(var_10_4)

		BackYardConst = var_10_0

		if var_10_5 >= var_10_0.MAX_UPLOAD_THEME_CNT then
			local var_10_6 = arg_1_0.contextData.msgBox
			local var_10_7 = var_3.ExecuteAction

			var_2_10006 = "SetUp"

			local var_10_8 = {
				hideNo = true
			}

			i18n = var_2_10008
			var_10_8.content = var_2_10008("backyard_theme_upload_over_maxcnt")

			var_10_7(var_10_6, var_2_10006, var_10_8)

			return
		end

		local var_10_9 = arg_1_0
		local var_10_10 = var_3.sendNotification

		GAME = var_2_10006

		var_10_10(var_10_9, var_2_10006.BACKYARD_UPLOAD_THEME_TEMPLATE, {
			templateId = arg_10_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_CANCEL_UPLOAD_TEMPLATE, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0.contextData.msgBox
		local var_11_1 = var_2.ExecuteAction
		local var_11_2 = "SetUp"
		local var_11_3 = {}

		i18n = var_2_10007
		var_11_3.content = var_2_10007("backyard_theme_cancel_template_upload_tip")

		function var_11_3.onYes()
			local var_12_0 = arg_1_0
			local var_12_1 = var_0.sendNotification

			GAME = var_3_10003

			var_12_1(var_12_0, var_3_10003.BACKYARD_UNLOAD_THEME_TEMPLATE, {
				templateId = arg_11_1.id
			})

			return
		end

		var_11_1(var_11_0, var_11_2, var_11_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_DELETE_TEMPLATE, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_1_0.contextData.msgBox
		local var_13_1 = var_2.ExecuteAction
		local var_13_2 = "SetUp"
		local var_13_3 = {}

		i18n = var_2_10007
		var_13_3.content = var_2_10007("backyard_theme_delete_themplate_tip")

		function var_13_3.onYes()
			local var_14_0 = arg_1_0
			local var_14_1 = var_0.sendNotification

			GAME = var_3_10003

			var_14_1(var_14_0, var_3_10003.BACKYARD_DELETE_THEME_TEMPLATE, {
				templateId = arg_13_1.id
			})

			return
		end

		var_13_1(var_13_0, var_13_2, var_13_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_APPLY_TEMPLATE, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_15_1:OwnThemeTemplateFurniture()

		local function var_15_1()
			local var_16_0 = arg_1_0
			local var_16_1 = var_0.sendNotification

			GAME = var_3_10003

			var_16_1(var_16_0, var_3_10003.BACKYARD_APPLY_THEME_TEMPLATE, {
				template = arg_15_1
			})

			return
		end

		if not var_15_0 then
			local var_15_2 = arg_1_0.contextData.msgBox
			local var_15_3 = var_5.ExecuteAction
			local var_15_4 = "SetUp"
			local var_15_5 = {}

			BackYardThemeTemplateMsgBox = var_2_10010
			var_15_5.type = var_2_10010.TYPE_IMAGE
			i18n = var_10
			var_15_5.content = var_10("backyard_theme_apply_tip1")
			var_15_5.srpiteName = arg_15_1:GetTextureIconName()
			var_15_5.md5 = arg_15_1:GetIconMd5()
			i18n = var_10
			var_15_5.confirmTxt = var_10("backyard_theme_word_buy")
			i18n = var_10
			var_15_5.cancelTxt = var_10("backyard_theme_word_apply")
			var_15_5.onYes = arg_15_2
			var_15_5.onCancel = var_15_1

			var_15_3(var_15_2, var_15_4, var_15_5)

			return
		end

		var_15_1()

		return
	end)
	arg_1_0:bind(var_0_1.ON_LIKE_THEME, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_1_0
		local var_17_1 = var_3.sendNotification

		GAME = var_2_10006

		var_17_1(var_17_0, var_2_10006.BACKYARD_LIKE_THEME_TEMPLATE, {
			templateId = arg_17_1.id,
			uploadTime = arg_17_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_COLECT_THEME, function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		local var_18_0 = arg_1_0
		local var_18_1 = var_4.sendNotification

		GAME = var_2_10007

		var_18_1(var_18_0, var_2_10007.BACKYARD_COLLECT_THEME_TEMPLATE, {
			templateId = arg_18_1.id,
			isCancel = arg_18_2,
			uploadTime = arg_18_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHARGE, function(arg_19_0, arg_19_1)
		PlayerConst = var_2_10002

		local var_19_1

		if arg_19_1 == var_2_10002.ResDiamond then
			pg = var_19_1

			local var_19_0 = var_19_1.m02

			var_19_1 = var_19_1.sendNotification
			GAME = var_2_10005
			var_2_10005 = var_2_10005.GO_SCENE
			SCENE = var_2_10006
			var_2_10006 = var_2_10006.CHARGE

			local var_19_2 = {}

			ChargeScene = var_2_10008
			var_19_2.wrap = var_2_10008.TYPE_DIAMOND

			var_19_1(var_19_0, var_2_10005, var_2_10006, var_19_2)
		else
			PlayerConst = var_19_1

			if arg_19_1 == var_19_1.ResDormMoney then
				pg = var_2

				local var_19_3 = var_2.m02
				local var_19_4 = var_2.sendNotification

				GAME = var_2_10005

				local var_19_5 = var_2_10005.GO_SCENE

				SCENE = var_2_10006

				var_19_4(var_19_3, var_19_5, var_2_10006.EVENT)
			end
		end

		return
	end)
	arg_1_0:bind(var_0_1.FETCH_ALL_THEME, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_1_0
		local var_20_1 = var_2.sendNotification

		GAME = var_2_10005

		var_20_1(var_20_0, var_2_10005.GET_ALL_BACKYARD_THEME_TEMPLATE, {
			callback = function(arg_21_0, arg_21_1, arg_21_2)
				local var_21_0 = arg_1_0.viewComponent

				var_3.SetShopThemeTemplate(var_21_0, arg_21_0)

				local var_21_1 = arg_1_0.viewComponent

				var_3.SetCustomThemeTemplate(var_21_1, arg_21_1)

				local var_21_2 = arg_1_0.viewComponent

				var_3.SetCollectionThemeTemplate(var_21_2, arg_21_2)
				arg_20_1()

				return
			end
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.SetDorm

	getProxy = var_4
	DormProxy = var_1_10006

	local var_1_2 = var_4(var_1_10006)

	var_1_1(var_1_0, var_4.getData(var_1_2))

	local var_1_3 = arg_1_0.viewComponent
	local var_1_4 = var_1.SetPlayer

	getProxy = var_4
	PlayerProxy = var_1_2

	local var_1_5 = var_4(var_1_2)

	var_1_4(var_1_3, var_4.getData(var_1_5))

	return
end

function var_0_1.listNotificationInterests(arg_22_0)
	local var_22_0 = {}

	PlayerProxy = var_1_10002
	var_22_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_22_0[2] = var_2.FRIEND_SEARCH_DONE
	GAME = var_2
	var_22_0[3] = var_2.BACKYARD_REFRESH_SHOP_TEMPLATE_DONE
	GAME = var_2
	var_22_0[4] = var_2.BACKYARD_GET_SPECIFIED_TYPE_TEMPLATE_DONE
	GAME = var_2
	var_22_0[5] = var_2.BUY_FURNITURE_DONE
	GAME = var_2
	var_22_0[6] = var_2.BACKYARD_APPLY_THEME_TEMPLATE_DONE
	GAME = var_2
	var_22_0[7] = var_2.BACKYARD_SEARCH_THEME_TEMPLATE_DONE
	GAME = var_2
	var_22_0[8] = var_2.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO
	GAME = var_2
	var_22_0[9] = var_2.BACKYARD_UNLOAD_THEME_TEMPLATE_DONE
	GAME = var_2
	var_22_0[10] = var_2.BACKYARD_DELETE_THEME_TEMPLATE_DONE
	GAME = var_2
	var_22_0[11] = var_2.BACKYARD_UPLOAD_THEME_TEMPLATE_DONE
	DormProxy = var_2
	var_22_0[12] = var_2.THEME_TEMPLATE_UPDATED
	DormProxy = var_2
	var_22_0[13] = var_2.DORM_UPDATEED
	DormProxy = var_2
	var_22_0[14] = var_2.THEME_TEMPLATE_DELTETED
	DormProxy = var_2
	var_22_0[15] = var_2.COLLECTION_THEME_TEMPLATE_ADDED
	DormProxy = var_2
	var_22_0[16] = var_2.COLLECTION_THEME_TEMPLATE_DELETED
	DormProxy = var_2
	var_22_0[17] = var_2.SHOP_THEME_TEMPLATE_DELETED
	GAME = var_2
	var_22_0[18] = var_2.BACKYARD_REFRESH_SHOP_TEMPLATE_ERRO

	return var_22_0
end

function var_0_1.handleNotification(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1
	local var_23_2 = arg_23_1.getBody(var_23_1)
	local var_23_3 = arg_23_1:getType()

	PlayerProxy = var_23_1

	if var_23_0 == var_23_1.UPDATED then
		var_1_10007 = arg_23_0.viewComponent

		var_5.PlayerUpdated(var_1_10007, var_23_2)
	else
		DormProxy = var_5

		local var_23_4

		if var_23_0 == var_5.THEME_TEMPLATE_UPDATED then
			getProxy = var_23_4
			DormProxy = var_1_10007
			var_23_4 = var_23_4(var_1_10007)

			local var_23_5 = var_23_2.type

			var_1_10007 = var_23_2.template
			BackYardConst = var_1_10008

			if var_23_5 == var_1_10008.THEME_TEMPLATE_TYPE_SHOP then
				local var_23_6 = arg_23_0.viewComponent

				var_1_10008.ShopThemeTemplateUpdate(var_23_6, var_1_10007)
			else
				BackYardConst = var_1_10008

				if var_23_5 == var_1_10008.THEME_TEMPLATE_TYPE_COLLECTION then
					local var_23_7 = arg_23_0.viewComponent

					var_1_10008.CollectionThemeTemplateUpdate(var_23_7, var_1_10007)
				else
					BackYardConst = var_1_10008

					if var_23_5 == var_1_10008.THEME_TEMPLATE_TYPE_CUSTOM then
						local var_23_8 = arg_23_0.viewComponent

						var_1_10008.CustomThemeTemplateUpdate(var_23_8, var_1_10007)
					end
				end
			end
		else
			GAME = var_23_4

			local var_23_9

			if var_23_0 == var_23_4.FRIEND_SEARCH_DONE then
				if var_23_2.list[1] then
					var_1_10007 = arg_23_0
					var_23_9 = arg_23_0.addSubLayers
					Context = var_1_10008
					var_1_10008 = var_1_10008.New

					local var_23_10 = {}

					FriendInfoLayer = var_1_10011
					var_23_10.viewComponent = var_1_10011
					FriendInfoMediator = var_1_10011
					var_23_10.mediator = var_1_10011

					local var_23_11 = {
						backyardView = true,
						friend = var_23_2.list[1],
						pos = arg_23_0.contextData.pos,
						msg = arg_23_0.contextData.themeName
					}
					local var_23_12 = arg_23_0.viewComponent

					var_23_11.groupName = var_12.getGroupName(var_23_12)
					var_23_10.data = var_23_11

					var_23_9(var_1_10007, var_1_10008(var_23_10))

					var_23_9 = arg_23_0.contextData
					var_23_9.pos = nil
					var_23_9 = arg_23_0.contextData
					var_23_9.themeName = nil
				end
			else
				GAME = var_23_9

				if var_23_0 == var_23_9.BACKYARD_REFRESH_SHOP_TEMPLATE_DONE then
					if var_23_2.existNew then
						BackYardThemeTempalteUtil = var_5

						var_5.ClearAllCacheAsyn()
					end

					getProxy = var_5
					DormProxy = var_1_10007
					var_1_10008 = var_5(var_1_10007)

					local var_23_13 = var_5.GetShopThemeTemplates(var_1_10008)

					var_1_10009 = arg_23_0.viewComponent

					var_1_10007.OnShopTemplatesUpdated(var_1_10009, var_23_13)
				else
					DormProxy = var_5

					local var_23_14

					if var_23_0 == var_5.DORM_UPDATEED then
						getProxy = var_23_14
						DormProxy = var_1_10007
						var_23_14 = var_23_14(var_1_10007)
						var_1_10008 = arg_23_0.viewComponent

						var_6.UpdateDorm(var_1_10008, var_23_14:getData())
					else
						GAME = var_23_14

						if var_23_0 == var_23_14.BUY_FURNITURE_DONE then
							local var_23_15 = arg_23_0.viewComponent

							var_5.FurnituresUpdated(var_23_15, var_23_3)
						else
							GAME = var_5

							local var_23_17

							if var_23_0 == var_5.BACKYARD_APPLY_THEME_TEMPLATE_DONE then
								local var_23_16 = arg_23_0

								var_23_17 = arg_23_0.sendNotification
								GAME = var_1_10008
								var_1_10008 = var_1_10008.GO_SCENE
								SCENE = var_1_10009

								var_23_17(var_23_16, var_1_10008, var_1_10009.COURTYARD)

								pg = var_23_17

								local var_23_18 = var_23_17.TipsMgr.GetInstance()

								var_23_17 = var_23_17.ShowTips
								i18n = var_1_10008

								var_23_17(var_23_18, var_1_10008("backyard_theme_apply_success"))
							else
								GAME = var_23_17

								if var_23_0 == var_23_17.BACKYARD_SEARCH_THEME_TEMPLATE_DONE then
									local var_23_19 = arg_23_0.viewComponent

									var_5.ShopSearchKeyChange(var_23_19, var_23_2.template)
								else
									GAME = var_5

									if var_23_0 == var_5.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO then
										local var_23_20 = arg_23_0.viewComponent

										var_5.ClearShopSearchKey(var_23_20)
									else
										GAME = var_5

										local var_23_22

										if var_23_0 == var_5.BACKYARD_UNLOAD_THEME_TEMPLATE_DONE then
											pg = var_23_22

											local var_23_21 = var_23_22.TipsMgr.GetInstance()

											var_23_22 = var_23_22.ShowTips
											i18n = var_1_10008

											var_23_22(var_23_21, var_1_10008("backyard_theme_unload_success"))
										else
											DormProxy = var_23_22

											if var_23_0 == var_23_22.THEME_TEMPLATE_DELTETED then
												local var_23_23 = arg_23_0.viewComponent

												var_5.DeleteCustomThemeTemplate(var_23_23, var_23_2.templateId)
											else
												GAME = var_5

												local var_23_25

												if var_23_0 == var_5.BACKYARD_DELETE_THEME_TEMPLATE_DONE then
													pg = var_23_25

													local var_23_24 = var_23_25.TipsMgr.GetInstance()

													var_23_25 = var_23_25.ShowTips
													i18n = var_1_10008

													var_23_25(var_23_24, var_1_10008("backyard_theme_delete_success"))
												else
													GAME = var_23_25

													local var_23_27

													if var_23_0 == var_23_25.BACKYARD_UPLOAD_THEME_TEMPLATE_DONE then
														pg = var_23_27

														local var_23_26 = var_23_27.TipsMgr.GetInstance()

														var_23_27 = var_23_27.ShowTips
														i18n = var_1_10008

														var_23_27(var_23_26, var_1_10008("backyard_theme_upload_success"))
													else
														DormProxy = var_23_27

														if var_23_0 == var_23_27.COLLECTION_THEME_TEMPLATE_ADDED then
															local var_23_28 = arg_23_0.viewComponent

															var_5.AddCollectionThemeTemplate(var_23_28, var_23_2.template)
														else
															DormProxy = var_5

															if var_23_0 == var_5.COLLECTION_THEME_TEMPLATE_DELETED then
																local var_23_29 = arg_23_0.viewComponent

																var_5.DeleteCollectionThemeTemplate(var_23_29, var_23_2.id)
															else
																DormProxy = var_5

																if var_23_0 == var_5.SHOP_THEME_TEMPLATE_DELETED then
																	local var_23_30 = arg_23_0.viewComponent

																	var_5.DeleteShopThemeTemplate(var_23_30, var_23_2.id)
																else
																	GAME = var_5

																	if var_23_0 == var_5.BACKYARD_REFRESH_SHOP_TEMPLATE_ERRO then
																		local var_23_31 = arg_23_0.viewComponent

																		var_5.OnShopTemplatesErro(var_23_31)
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1

local var_0_0 = class("NewBackYardThemeTemplateMediator", import("...base.ContextMediator"))

var_0_0.FETCH_ALL_THEME = "NewBackYardThemeTemplateMediator:FETCH_ALL_THEME"
var_0_0.ON_CHARGE = "NewBackYardThemeTemplateMediator:ON_CHARGE"
var_0_0.ON_SHOPPING = "NewBackYardShopMediator:ON_SHOPPING"
var_0_0.ON_LIKE_THEME = "NewBackYardThemeTemplateMediator:ON_LIKE_THEME"
var_0_0.ON_COLECT_THEME = "NewBackYardThemeTemplateMediator:ON_COLECT_THEME"
var_0_0.ON_APPLY_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_APPLY_TEMPLATE"
var_0_0.ON_UPLOAD_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_UPLOAD_TEMPLATE"
var_0_0.ON_CANCEL_UPLOAD_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_CANCEL_UPLOAD_TEMPLATE"
var_0_0.ON_DELETE_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_DELETE_TEMPLATE"
var_0_0.GET_TEMPLATE_PLAYERINFO = "NewBackYardThemeTemplateMediator:GET_TEMPLATE_PLAYERINFO"
var_0_0.ON_DISPLAY_PLAYER_INFO = "NewBackYardThemeTemplateMediator:ON_DISPLAY_PLAYER_INFO"
var_0_0.ON_SEARCH = "NewBackYardThemeTemplateMediator:ON_SEARCH"
var_0_0.ON_REFRESH = "NewBackYardThemeTemplateMediator:ON_REFRESH"
var_0_0.ON_GET_THEMPLATE_DATA = "NewBackYardThemeTemplateMediator:ON_GET_THEMPLATE_DATA"
var_0_0.ON_GET_SPCAIL_TYPE_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_GET_SPCAIL_TYPE_TEMPLATE"
var_0_0.GO_DECORATION = "NewBackYardThemeTemplateMediator:GO_DECORATION"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_DECORATION, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD, {
			openDecoration = true
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_SPCAIL_TYPE_TEMPLATE, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.BACKYARD_GET_SPECIFIED_TYPE_TEMPLATE, {
			type = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_GET_THEMPLATE_DATA, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.BACKYARD_GET_THEME_TEMPLATE_DATA, {
			templateId = arg_4_1,
			callback = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REFRESH, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		arg_1_0:sendNotification(GAME.BACKYARD_REFRESH_SHOP_TEMPLATE, {
			timeType = arg_5_3,
			type = arg_5_1,
			page = arg_5_2,
			force = arg_5_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SEARCH, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM or arg_6_1 == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
			arg_1_0.viewComponent:SearchKeyChange(arg_6_2)
		elseif arg_6_1 == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			arg_1_0:sendNotification(GAME.BACKYARD_SEARCH_THEME_TEMPLATE, {
				str = arg_6_2
			})
		end

		return
	end)
	arg_1_0:bind(var_0_0.ON_SHOPPING, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:sendNotification(GAME.BUY_FURNITURE, {
			furnitureIds = arg_7_1,
			type = arg_7_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_DISPLAY_PLAYER_INFO, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_1_0.contextData.pos = arg_8_2
		arg_1_0.contextData.themeName = arg_8_3

		arg_1_0:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GET_TEMPLATE_PLAYERINFO, function(arg_9_0, arg_9_1, arg_9_2)
		arg_1_0:sendNotification(GAME.BACKYARD_GET_THEME_TEMPLATE_PLAYE_INFO, {
			type = arg_9_1,
			templateId = arg_9_2.id,
			userId = arg_9_2:GetUserId()
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPLOAD_TEMPLATE, function(arg_10_0, arg_10_1)
		local var_10_0 = getProxy(PlayerProxy):getData()

		if not var_10_0:CanUploadBackYardThemeTemplate() then
			arg_1_0.contextData.msgBox:ExecuteAction("SetUp", {
				hideNo = true,
				content = i18n("backyard_theme_ban_upload_tip", (var_10_0:GetBanUploadBackYardThemeTemplateTime()))
			})

			return
		end

		local var_10_1 = getProxy(DormProxy)

		if var_10_1:GetUploadThemeTemplateCnt() >= BackYardConst.MAX_UPLOAD_THEME_CNT then
			arg_1_0.contextData.msgBox:ExecuteAction("SetUp", {
				hideNo = true,
				content = i18n("backyard_theme_upload_over_maxcnt")
			})

			return
		end

		arg_1_0:sendNotification(GAME.BACKYARD_UPLOAD_THEME_TEMPLATE, {
			templateId = arg_10_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CANCEL_UPLOAD_TEMPLATE, function(arg_11_0, arg_11_1)
		arg_1_0.contextData.msgBox:ExecuteAction("SetUp", {
			content = i18n("backyard_theme_cancel_template_upload_tip"),
			onYes = function()
				arg_1_0:sendNotification(GAME.BACKYARD_UNLOAD_THEME_TEMPLATE, {
					templateId = arg_11_1.id
				})

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_DELETE_TEMPLATE, function(arg_13_0, arg_13_1)
		arg_1_0.contextData.msgBox:ExecuteAction("SetUp", {
			content = i18n("backyard_theme_delete_themplate_tip"),
			onYes = function()
				arg_1_0:sendNotification(GAME.BACKYARD_DELETE_THEME_TEMPLATE, {
					templateId = arg_13_1.id
				})

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_APPLY_TEMPLATE, function(arg_15_0, arg_15_1, arg_15_2)
		if not arg_15_1:OwnThemeTemplateFurniture() then
			arg_1_0.contextData.msgBox:ExecuteAction("SetUp", {
				type = BackYardThemeTemplateMsgBox.TYPE_IMAGE,
				content = i18n("backyard_theme_apply_tip1"),
				srpiteName = arg_15_1:GetTextureIconName(),
				md5 = arg_15_1:GetIconMd5(),
				confirmTxt = i18n("backyard_theme_word_buy"),
				cancelTxt = i18n("backyard_theme_word_apply"),
				onYes = arg_15_2,
				onCancel = function()
					arg_1_0:sendNotification(GAME.BACKYARD_APPLY_THEME_TEMPLATE, {
						template = arg_15_1
					})

					return
				end
			})

			return
		end

		;(function()
			arg_1_0:sendNotification(GAME.BACKYARD_APPLY_THEME_TEMPLATE, {
				template = arg_15_1
			})

			return
		end)()

		return
	end)
	arg_1_0:bind(var_0_0.ON_LIKE_THEME, function(arg_17_0, arg_17_1, arg_17_2)
		arg_1_0:sendNotification(GAME.BACKYARD_LIKE_THEME_TEMPLATE, {
			templateId = arg_17_1.id,
			uploadTime = arg_17_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_COLECT_THEME, function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		arg_1_0:sendNotification(GAME.BACKYARD_COLLECT_THEME_TEMPLATE, {
			templateId = arg_18_1.id,
			isCancel = arg_18_2,
			uploadTime = arg_18_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CHARGE, function(arg_19_0, arg_19_1)
		if arg_19_1 == PlayerConst.ResDiamond then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})
		elseif arg_19_1 == PlayerConst.ResDormMoney then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		end

		return
	end)
	arg_1_0:bind(var_0_0.FETCH_ALL_THEME, function(arg_20_0, arg_20_1)
		arg_1_0:sendNotification(GAME.GET_ALL_BACKYARD_THEME_TEMPLATE, {
			callback = function(arg_21_0, arg_21_1, arg_21_2)
				arg_1_0.viewComponent:SetShopThemeTemplate(arg_21_0)
				arg_1_0.viewComponent:SetCustomThemeTemplate(arg_21_1)
				arg_1_0.viewComponent:SetCollectionThemeTemplate(arg_21_2)
				arg_20_1()

				return
			end
		})

		return
	end)
	arg_1_0.viewComponent:SetDorm(getProxy(DormProxy):getData())
	arg_1_0.viewComponent:SetPlayer(getProxy(PlayerProxy):getData())

	return
end

function var_0_0.listNotificationInterests(arg_22_0)
	return {
		PlayerProxy.UPDATED,
		GAME.FRIEND_SEARCH_DONE,
		GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_DONE,
		GAME.BACKYARD_GET_SPECIFIED_TYPE_TEMPLATE_DONE,
		GAME.BUY_FURNITURE_DONE,
		GAME.BACKYARD_APPLY_THEME_TEMPLATE_DONE,
		GAME.BACKYARD_SEARCH_THEME_TEMPLATE_DONE,
		GAME.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO,
		GAME.BACKYARD_UNLOAD_THEME_TEMPLATE_DONE,
		GAME.BACKYARD_DELETE_THEME_TEMPLATE_DONE,
		GAME.BACKYARD_UPLOAD_THEME_TEMPLATE_DONE,
		DormProxy.THEME_TEMPLATE_UPDATED,
		DormProxy.DORM_UPDATEED,
		DormProxy.THEME_TEMPLATE_DELTETED,
		DormProxy.COLLECTION_THEME_TEMPLATE_ADDED,
		DormProxy.COLLECTION_THEME_TEMPLATE_DELETED,
		DormProxy.SHOP_THEME_TEMPLATE_DELETED,
		GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_ERRO
	}
end

function var_0_0.handleNotification(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1:getBody()

	if var_23_0 == PlayerProxy.UPDATED then
		arg_23_0.viewComponent:PlayerUpdated(var_23_1)
	elseif var_23_0 == DormProxy.THEME_TEMPLATE_UPDATED then
		local var_23_2 = getProxy(DormProxy)

		if var_23_1.type == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			arg_23_0.viewComponent:ShopThemeTemplateUpdate(var_23_1.template)
		elseif var_23_1.type == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
			arg_23_0.viewComponent:CollectionThemeTemplateUpdate(var_23_1.template)
		elseif var_23_1.type == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
			arg_23_0.viewComponent:CustomThemeTemplateUpdate(var_23_1.template)
		end
	elseif var_23_0 == GAME.FRIEND_SEARCH_DONE then
		if var_23_1.list[1] then
			arg_23_0:addSubLayers(Context.New({
				viewComponent = FriendInfoLayer,
				mediator = FriendInfoMediator,
				data = {
					backyardView = true,
					friend = var_23_1.list[1],
					pos = arg_23_0.contextData.pos,
					msg = arg_23_0.contextData.themeName,
					groupName = arg_23_0.viewComponent:getGroupName()
				}
			}))

			arg_23_0.contextData.pos = nil
			arg_23_0.contextData.themeName = nil
		end
	elseif var_23_0 == GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_DONE then
		if var_23_1.existNew then
			BackYardThemeTempalteUtil.ClearAllCacheAsyn()
		end

		local var_23_3 = getProxy(DormProxy)

		arg_23_0.viewComponent:OnShopTemplatesUpdated((var_23_3:GetShopThemeTemplates()))
	elseif var_23_0 == DormProxy.DORM_UPDATEED then
		arg_23_0.viewComponent:UpdateDorm(getProxy(DormProxy):getData())
	elseif var_23_0 == GAME.BUY_FURNITURE_DONE then
		arg_23_0.viewComponent:FurnituresUpdated((arg_23_1:getType()))
	elseif var_23_0 == GAME.BACKYARD_APPLY_THEME_TEMPLATE_DONE then
		arg_23_0:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD)
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_apply_success"))
	elseif var_23_0 == GAME.BACKYARD_SEARCH_THEME_TEMPLATE_DONE then
		arg_23_0.viewComponent:ShopSearchKeyChange(var_23_1.template)
	elseif var_23_0 == GAME.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO then
		arg_23_0.viewComponent:ClearShopSearchKey()
	elseif var_23_0 == GAME.BACKYARD_UNLOAD_THEME_TEMPLATE_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_unload_success"))
	elseif var_23_0 == DormProxy.THEME_TEMPLATE_DELTETED then
		arg_23_0.viewComponent:DeleteCustomThemeTemplate(var_23_1.templateId)
	elseif var_23_0 == GAME.BACKYARD_DELETE_THEME_TEMPLATE_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_delete_success"))
	elseif var_23_0 == GAME.BACKYARD_UPLOAD_THEME_TEMPLATE_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_upload_success"))
	elseif var_23_0 == DormProxy.COLLECTION_THEME_TEMPLATE_ADDED then
		arg_23_0.viewComponent:AddCollectionThemeTemplate(var_23_1.template)
	elseif var_23_0 == DormProxy.COLLECTION_THEME_TEMPLATE_DELETED then
		arg_23_0.viewComponent:DeleteCollectionThemeTemplate(var_23_1.id)
	elseif var_23_0 == DormProxy.SHOP_THEME_TEMPLATE_DELETED then
		arg_23_0.viewComponent:DeleteShopThemeTemplate(var_23_1.id)
	elseif var_23_0 == GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_ERRO then
		arg_23_0.viewComponent:OnShopTemplatesErro()
	end

	return
end

return var_0_0

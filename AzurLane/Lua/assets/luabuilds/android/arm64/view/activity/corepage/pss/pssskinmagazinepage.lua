local var_0_0 = class("PSSSkinMagazinePage", import("view.activity.CorePage.CorSkinMagazineTemplatePage"))

var_0_0.EXPAND_WIDTH = 975
var_0_0.CLOSE_WIDTH = 225
var_0_0.DURATION_PARAMETER = 2500

function var_0_0.OnFirstFlush(arg_1_0)
	arg_1_0.super.OnFirstFlush(arg_1_0)
	setText(arg_1_0._tf:Find("AD/Text"), i18n("black5_bundle_desc"))
	setText(arg_1_0._tf:Find("AD/btn/name"), i18n("black5_bundle_button"))
	onButton(arg_1_0, arg_1_0._tf:Find("AD/btn"), function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_GIFT
		})

		return
	end, SFX_PANEL)

	if not arg_1_0.activity:GetConfigClientSetting("packageID") then
		return false
	end

	local var_1_0 = Goods.Create({
		shop_id = arg_1_0.activity:GetConfigClientSetting("packageID")
	}, Goods.TYPE_GIFT_PACKAGE_ACT)

	SetActive(arg_1_0._tf:Find("AD/btn/red"), var_1_0:isTip())
	SetActive(arg_1_0._tf:Find("AD/btn"), var_1_0:getBuyCount() ~= 1)
	SetActive(arg_1_0._tf:Find("AD/Text"), var_1_0:getBuyCount() ~= 1)
	SetActive(arg_1_0._tf:Find("AD/Image"), var_1_0:getBuyCount() ~= 1)

	return
end

return var_0_0

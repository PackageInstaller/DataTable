module("bootstrap.view.BootstrapMsgBoxView", package.seeall)

local var_0_0 = class("BootstrapMsgBoxView")

var_0_0.KEY_LAUNCHER = 1
var_0_0.KEY_REPAIR = 2
var_0_0.KEY_QUIT = 3
var_0_0.KEY_RESTART = 4

function var_0_0.buildUI(arg_1_0)
	var_0_0.go = arg_1_0

	local var_1_0 = UnityEngine.GameObject.Find("UIROOT/TOPMOST")

	var_0_0.go.transform:SetParent(var_1_0.transform, false)

	var_0_0.txtTitle = var_0_0.go.transform:Find("content/txtTitle"):GetComponent(typeof(UnityEngine.UI.Text))
	var_0_0.txtContent = var_0_0.go.transform:Find("content/ScrollView/Viewport/Content"):GetComponent(typeof(UnityEngine.UI.Text))
	var_0_0.btnRight = Astral.ButtonAdapter.GetFrom(var_0_0.go, "content/btnConfirm")
	var_0_0.txtBtnRight = var_0_0.go.transform:Find("content/btnConfirm/Text"):GetComponent(typeof(UnityEngine.UI.Text))
	var_0_0.btnLeft = Astral.ButtonAdapter.GetFrom(var_0_0.go, "content/btnCancel")
	var_0_0.txtBtnLeft = var_0_0.go.transform:Find("content/btnCancel/Text"):GetComponent(typeof(UnityEngine.UI.Text))
	var_0_0.btnClose = Astral.ButtonAdapter.GetFrom(var_0_0.go, "content/btnClose")

	var_0_0.btnClose.gameObject:SetActive(true)

	var_0_0.currentKey = var_0_0.KEY_LAUNCHER

	var_0_0.go:SetActive(false)
end

function var_0_0.destroyUI()
	var_0_0.unbindEvents()
	UnityEngine.GameObject.Destroy(var_0_0.go)

	var_0_0.go = nil
	var_0_0.txtTitle = nil
	var_0_0.txtContent = nil
	var_0_0.btnRight = nil
	var_0_0.txtBtnRight = nil
	var_0_0.btnLeft = nil
	var_0_0.txtBtnLeft = nil
	var_0_0.btnClose = nil
end

function var_0_0.onEnter()
	var_0_0.bindEvents()

	var_0_0.txtTitle.text = BootstrapLanguage.getTipsTextByKey("tips")
	var_0_0.txtContent.text = ""
	var_0_0.txtBtnRight.text = ""
	var_0_0.txtBtnLeft.text = ""
end

function var_0_0.bindEvents()
	var_0_0.btnRight:AddClickListener(var_0_0.onMsgBoxOkBtnClick, var_0_0)
	var_0_0.btnLeft:AddClickListener(var_0_0.onMsgBoxCancelBtnClick, var_0_0)
	var_0_0.btnClose:AddClickListener(var_0_0.onMsgBoxCancelBtnClick, var_0_0)
end

function var_0_0.unbindEvents()
	var_0_0.btnRight:RemoveClickListener()
	var_0_0.btnLeft:RemoveClickListener()
	var_0_0.btnClose:RemoveClickListener()
end

function var_0_0.show(arg_6_0, arg_6_1)
	var_0_0.currentKey = arg_6_1 or var_0_0.KEY_LAUNCHER

	if arg_6_0 and (Astral.OSDef.RunOS == Astral.OSDef.Android or Astral.OSDef.RunOS == Astral.OSDef.IOS) then
		BootstrapUtil.hideTransition()
	end

	var_0_0.go:SetActive(arg_6_0)
end

function var_0_0.setTxtContent(arg_7_0)
	var_0_0.txtContent.text = arg_7_0
end

function var_0_0.setBtnTxt(arg_8_0, arg_8_1)
	var_0_0.txtBtnRight.text = arg_8_0
	var_0_0.txtBtnLeft.text = arg_8_1
end

function var_0_0.onMsgBoxOkBtnClick()
	local var_9_0 = var_0_0.currentKey

	if var_9_0 == var_0_0.KEY_LAUNCHER then
		BootstrapViewLogic.instance:onMsgBoxOkBtnClick()
	elseif var_9_0 == var_0_0.KEY_REPAIR then
		BootstrapLoadingView.onMsgBoxOkBtnClick()
	elseif var_9_0 == var_0_0.KEY_QUIT then
		var_0_0.show(false)
		UnityEngine.Caching.ClearCache()
		Astral.FileUtils.Instance:DeleteDirectory(Astral.FileUtils.Instance.LocalResRootPath)

		local var_9_1 = UnityEngine.Application.persistentDataPath .. "/UnityCache/"

		Astral.FileUtils.Instance:DeleteDirectory(var_9_1)
		SystemUtil.Quit()
	elseif var_9_0 == var_0_0.KEY_RESTART then
		var_0_0.show(false)
		SystemUtil.restart()
	elseif enableErrorLog then
		printError("unhandle key", var_9_0)
	end
end

function var_0_0.onMsgBoxCancelBtnClick()
	local var_10_0 = var_0_0.currentKey

	if var_10_0 == var_0_0.KEY_LAUNCHER then
		BootstrapViewLogic.instance:onMsgBoxCancelBtnClick()
	elseif var_10_0 == var_0_0.KEY_REPAIR then
		BootstrapViewLogic.onMsgBoxCancelBtnClick()
	elseif var_10_0 == var_0_0.KEY_RESTART then
		var_0_0.show(false)
		SystemUtil.restart()
	elseif var_10_0 == var_0_0.KEY_QUIT then
		var_0_0.show(false)
	elseif enableErrorLog then
		printError("unhandle key", var_10_0)
	end
end

return var_0_0

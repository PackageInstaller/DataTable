-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapMsgBoxView.lua

module("bootstrap.BootstrapMsgBoxView", package.seeall)

local BootstrapMsgBoxView = _M

BootstrapMsgBoxView.TxtVersion = UnityEngine.GameObject.Find("UIROOT/FULLSCREEN/_txtVersion"):GetComponent(typeof(UnityEngine.UI.Text))
BootstrapMsgBoxView.TxtVersionContent = UnityEngine.GameObject.Find("UIROOT/FULLSCREEN/_txtVersionContent"):GetComponent(typeof(UnityEngine.UI.Text))

function BootstrapMsgBoxView.setTxtVersionActive(active)
	BootstrapMsgBoxView.TxtVersion.gameObject:SetActive(active)
	BootstrapMsgBoxView.TxtVersionContent.gameObject:SetActive(active)

	if active then
		BootstrapMsgBoxView.setVersionCode()
	end
end

function BootstrapMsgBoxView.setVersionCode()
	if BootstrapMsgBoxView.TxtVersion.text == "" then
		BootstrapMsgBoxView.TxtVersion.text = string.format("<color=black>V%s-%s-%s</color>", BootstrapUtil.getGameHotUpdateVersionCode(), BootstrapUtil.getGameVersionName(), BootstrapUtil.getGameVersionCode())
	end
end

function BootstrapMsgBoxView.buildUI()
	_M.go = BootstrapResPreLoad.bootstrapPrefab[BootstrapResPreLoad.bootstrapmsgboxview]
	_M.txtContent = _M.go.transform:Find("imgBg/img/txtContent"):GetComponent(typeof(UnityEngine.UI.Text))
	_M.btnRight = Framework.ButtonAdapter.GetFrom(_M.go, "btnRight")
	_M.txtBtnRight = _M.go.transform:Find("btnRight/Text"):GetComponent(typeof(UnityEngine.UI.Text))
	_M.btnLeft = Framework.ButtonAdapter.GetFrom(_M.go, "btnLeft")
	_M.txtBtnLeft = _M.go.transform:Find("btnLeft/Text"):GetComponent(typeof(UnityEngine.UI.Text))
	_M.btnClose = Framework.ButtonAdapter.GetFrom(_M.go, "btnClose")
end

function BootstrapMsgBoxView.destroyUI()
	_M.unbindEvents()
	UnityEngine.GameObject.Destroy(_M.go)

	BootstrapResPreLoad.bootstrapPrefab[BootstrapResPreLoad.bootstrapmsgboxview] = nil
	_M.go = nil
	_M.txtContent = nil
	_M.btnRight = nil
	_M.txtBtnRight = nil
	_M.btnLeft = nil
	_M.txtBtnLeft = nil
	_M.btnClose = nil
end

function BootstrapMsgBoxView.onEnter()
	_M.bindEvents()

	_M.txtContent.text = ""
	_M.txtBtnRight.text = ""
	_M.txtBtnLeft.text = ""
end

function BootstrapMsgBoxView.bindEvents()
	_M.btnRight:AddClickListener(BootstrapLauncher.onMsgBoxOkBtnClick, BootstrapLauncher.instance)
	_M.btnLeft:AddClickListener(BootstrapLauncher.onMsgBoxCancelBtnClick, BootstrapLauncher.instance)
	_M.btnClose:AddClickListener(BootstrapLauncher.onMsgBoxCancelBtnClick, BootstrapLauncher.instance)
end

function BootstrapMsgBoxView.unbindEvents()
	_M.btnRight:RemoveClickListener()
	_M.btnLeft:RemoveClickListener()
	_M.btnClose:RemoveClickListener()
end

function BootstrapMsgBoxView.show(orNot)
	_M.go:SetActive(orNot)
end

function BootstrapMsgBoxView.setTxtContent(msg)
	if enableDebug then
		msg = msg or "nil"

		printError("BootstrapMsgBoxView.setTxtContent() - msg:" .. msg)
	end

	_M.txtContent.text = msg
end

function BootstrapMsgBoxView.setBtnTxt(txtBtnRight, txtBtnLeft)
	if enableDebug then
		txtBtnRight = txtBtnRight or "nil"
		txtBtnLeft = txtBtnLeft or "nil"

		forcePrint("BootstrapMsgBoxView.setBtnTxt() - txtBtnRight:" .. txtBtnRight .. ",txtBtnLeft:" .. txtBtnLeft)
	end

	_M.txtBtnRight.text = txtBtnRight
	_M.txtBtnLeft.text = txtBtnLeft

	if txtBtnRight == "nil" then
		_M.btnRight.gameObject:SetActive(false)
		Framework.TransformUtil.SetLocalPos(_M.btnLeft.gameObject.transform, 0, -175, 0)
	end

	if txtBtnLeft == "nil" then
		_M.btnLeft.gameObject:SetActive(false)
		Framework.TransformUtil.SetLocalPos(_M.btnRight.gameObject.transform, 0, -175, 0)
	end

	if txtBtnRight ~= "nil" and txtBtnLeft ~= "nil" then
		_M.btnRight.gameObject:SetActive(true)
		_M.btnLeft.gameObject:SetActive(true)
		Framework.TransformUtil.SetLocalPos(_M.btnLeft.gameObject.transform, -229, -175, 0)
		Framework.TransformUtil.SetLocalPos(_M.btnRight.gameObject.transform, 229, -175, 0)
	end
end

return BootstrapMsgBoxView

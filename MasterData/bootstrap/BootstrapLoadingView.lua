-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapLoadingView.lua

module("bootstrap.BootstrapLoadingView", package.seeall)

local BootstrapLoadingView = _M

function BootstrapLoadingView.buildUI()
	_M.go = BootstrapResPreLoad.bootstrapPrefab[BootstrapResPreLoad.bootstraploading]
	_M.txtContent = _M.go.transform:Find("txtpercent"):GetComponent(typeof(UnityEngine.UI.Text))
	_M.persent = Framework.SliderAdapter.GetFrom(_M.go, "progressBar")
	_M.effect = _M.go.transform:Find("progressBar/dot/Image/fx_10140_xiaonuo_gensui")
	_M.img = _M.go.transform:Find("Image")
	_M.logo = _M.go.transform:Find("logo")
	_M.youxizhonggao = _M.go.transform:Find("youxizhonggao")
	_M.whiteBg = _M.go.transform:Find("WhiteBg")

	if _M.logo then
		_M.logo.gameObject:SetActive(false)
	end

	if _M.youxizhonggao then
		_M.youxizhonggao.gameObject:SetActive(false)
	end

	if _M.txtContent then
		_M.txtContent.gameObject:SetActive(false)
	end

	if _M.img then
		_M.img.gameObject:SetActive(false)
	end

	if _M.persent then
		_M.persent.gameObject:SetActive(false)
	end

	GoUtil.SetSortingOrder(_M.effect.gameObject, 400)
end

function BootstrapLoadingView.destroyUI()
	_M.unbindEvents()
	UnityEngine.GameObject.Destroy(_M.go)

	BootstrapResPreLoad.bootstrapPrefab[BootstrapResPreLoad.bootstraploading] = nil
	_M.go = nil
	_M.txtContent = nil
	_M.persent = nil
	_M.img = nil
	_M.logo = nil
	_M.whiteBg = nil
	_M.youxizhonggao = nil
	_M._isPlayingLogo = nil
	_M._logoShowTime = nil
	_M._isShowingWarinng = nil
	_M._showWarningTime = nil
	_M._logoAndWarningFinishCallback = nil
	_M._logoAndWarningFinishCallbackObj = nil

	UpdateBeat:Remove(BootstrapLoadingView._progressPersentVal)
	UpdateBeat:Remove(BootstrapLoadingView._checkLogoAnimFinished)
	UpdateBeat:Remove(BootstrapLoadingView._checkWarningFinished)

	_M.effect = nil
end

function BootstrapLoadingView.onEnter()
	_M.bindEvents()

	_M.txtContent.text = ""

	_M.showPersent(false)
end

function BootstrapLoadingView.bindEvents()
	return
end

function BootstrapLoadingView.unbindEvents()
	return
end

function BootstrapLoadingView.setLogoAndWarningFinishCallback(callback, callbackTarget)
	_M._logoAndWarningFinishCallback = callback
	_M._logoAndWarningFinishCallbackObj = callbackTarget
end

function BootstrapLoadingView.showLogo(orNot)
	if _M.logo then
		_M.logo.gameObject:SetActive(orNot or false)
	end

	if orNot then
		_M._isPlayingLogo = true
		_M._logoShowTime = 3.5

		UpdateBeat:Add(BootstrapLoadingView._checkLogoAnimFinished)
	else
		_M._isPlayingLogo = false

		UpdateBeat:Remove(BootstrapLoadingView._checkLogoAnimFinished)
	end

	if _M.whiteBg then
		_M.whiteBg.gameObject:SetActive(false)
	end
end

function BootstrapLoadingView.showWraning(orNot)
	if _M.youxizhonggao then
		_M.youxizhonggao.gameObject:SetActive(orNot or false)
	end

	if orNot then
		_M._isShowingWarinng = true
		_M._showWarningTime = 2

		UpdateBeat:Add(BootstrapLoadingView._checkWarningFinished)
	else
		_M._isShowingWarinng = false

		UpdateBeat:Remove(BootstrapLoadingView._checkWarningFinished)
	end

	if _M.whiteBg then
		_M.whiteBg.gameObject:SetActive(false)
	end
end

function BootstrapLoadingView.showUpdateOrLoad(orNot)
	if _M.whiteBg then
		_M.whiteBg.gameObject:SetActive(false)
	end

	if _M.txtContent then
		_M.txtContent.gameObject:SetActive(orNot or false)
	end

	if _M.img then
		_M.img.gameObject:SetActive(orNot or false)
	end

	if _M.persent then
		_M.persent.gameObject:SetActive(orNot or false)
	end
end

function BootstrapLoadingView.show(orNot)
	_M.go:SetActive(orNot)
end

function BootstrapLoadingView.setTxtContent(msg)
	_M.txtContent.text = msg
end

function BootstrapLoadingView.showPersent(orNot)
	_M.persent.gameObject:SetActive(orNot)
end

function BootstrapLoadingView.setPersentVal(val)
	_M.persent:SetValue(val)
end

function BootstrapLoadingView.startLoadingProgress(txt, callback, callbackObj)
	BootstrapLoadingView._isProgressFinished = nil
	BootstrapLoadingView._curProgress = 0
	BootstrapLoadingView._progressTxt = txt
	BootstrapLoadingView._curProgressSpd = 0.5

	UpdateBeat:Add(BootstrapLoadingView._progressPersentVal)
	_M.persent:SetValue(0)

	if BootstrapLoadingView._progressTxt then
		BootstrapLoadingView.setTxtContent(string.format(BootstrapLoadingView._progressTxt, 0))
	end

	BootstrapLoadingView._progFinishCallback = callback
	BootstrapLoadingView._progFinishCallbackObj = callbackObj
end

function BootstrapLoadingView.stopLoadingProgress()
	local callabck = BootstrapLoadingView._progFinishCallback
	local callabckObj = BootstrapLoadingView._progFinishCallbackObj

	_M.persent:SetValue(1)
	UpdateBeat:Remove(BootstrapLoadingView._progressPersentVal)

	BootstrapLoadingView._isProgressFinished = nil
	BootstrapLoadingView._curProgress = nil
	BootstrapLoadingView._totalProgress = nil
	BootstrapLoadingView._progressTxt = nil
	BootstrapLoadingView._progFinishCallback = nil
	BootstrapLoadingView._progFinishCallbackObj = nil

	if callabck then
		if callabckObj then
			BootstrapLoadingView._progFinishCallback(callabckObj)
		else
			callabck()
		end
	end
end

function BootstrapLoadingView.setProgressPersentVal(val)
	BootstrapLoadingView._totalProgress = val

	if val >= 1 then
		BootstrapLoadingView._curProgressSpd = 2
	end
end

function BootstrapLoadingView._progressPersentVal()
	if not BootstrapLoadingView._totalProgress then
		return
	end

	if BootstrapLoadingView._isProgressFinished then
		BootstrapLoadingView.stopLoadingProgress()

		return
	end

	BootstrapLoadingView._curProgress = BootstrapLoadingView._curProgress + BootstrapLoadingView._curProgressSpd * UnityEngine.Time.deltaTime

	if BootstrapLoadingView._curProgress >= BootstrapLoadingView._totalProgress then
		BootstrapLoadingView._curProgress = BootstrapLoadingView._totalProgress
	end

	if BootstrapLoadingView._curProgress >= 1 then
		BootstrapLoadingView._curProgress = 1
		BootstrapLoadingView._isProgressFinished = true
	end

	_M.persent:SetValue(BootstrapLoadingView._curProgress)

	if BootstrapLoadingView._progressTxt then
		BootstrapLoadingView.setTxtContent(string.format(BootstrapLoadingView._progressTxt, math.ceil(BootstrapLoadingView._curProgress * 100)))
	end
end

function BootstrapLoadingView._checkLogoAnimFinished()
	if not _M._isPlayingLogo then
		return
	end

	_M._logoShowTime = _M._logoShowTime or 3.5
	_M._logoShowTime = _M._logoShowTime - UnityEngine.Time.deltaTime

	if _M._logoShowTime <= 0 then
		BootstrapLoadingView.showLogo(false)
		BootstrapLoadingView.showWraning(true)
	end
end

function BootstrapLoadingView._checkWarningFinished()
	if not _M._isShowingWarinng then
		return
	end

	_M._showWarningTime = _M._showWarningTime or 2
	_M._showWarningTime = _M._showWarningTime - UnityEngine.Time.deltaTime

	if _M._showWarningTime <= 0 then
		BootstrapLoadingView.showWraning(false)
		BootstrapLoadingView.showUpdateOrLoad(true)

		if _M._logoAndWarningFinishCallback then
			_M._logoAndWarningFinishCallback(_M._logoAndWarningFinishCallbackObj)
		end
	end
end

return BootstrapLoadingView

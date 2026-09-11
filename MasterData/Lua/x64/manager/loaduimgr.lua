local LoadUIMgr = class("LoadUIMgr")

function LoadUIMgr:Ctor()
	self._waittingDlg = nil

	self:OnCtor()
end

function LoadUIMgr:OnCtor()
	print("Initialize Load UI Mgr")

	self._waittingDlg = Object.Instantiate(Asset.Load("UI/Loading"), manager.ui.uiLoad.transform)

	SetActive(self._waittingDlg, false)

	self._uiImage = self._waittingDlg.transform:Find("content").gameObject

	SetActive(self._uiImage, false)

	self._isLoad = false
	self.isForceShow_ = false
end

function LoadUIMgr:ShowLoad(arg_3_1)
	if self._waittingDlg == nil then
		return
	end

	arg_3_1 = self.isForceShow_ and true or arg_3_1

	if self._isLoad == arg_3_1 then
		return
	end

	if self.loadingTimer_ then
		self.loadingTimer_:Stop()

		self.loadingTimer_ = nil
	end

	if arg_3_1 then
		self._isLoad = true
		self.loadingTimer_ = Timer.New(function()
			SetActive(self._uiImage, true)

			self.loadingTimer_ = nil
		end, 1.5, 1)

		self.loadingTimer_:Start()
		SetActive(self._waittingDlg, true)
	else
		self._isLoad = false

		SetActive(self._waittingDlg, false)
		SetActive(self._uiImage, false)
	end
end

function LoadUIMgr:ForceShowLoad(arg_5_1)
	self.isForceShow_ = arg_5_1
end

function LoadUIMgr:Dispose()
	if self.loadingTimer_ then
		self.loadingTimer_:Stop()

		self.loadingTimer_ = nil
	end

	Object.Destroy(self._waittingDlg)

	self._waittingDlg = nil
end

return LoadUIMgr

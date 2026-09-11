local LanguagePackageItem = class("LanguagePackageItem", ReduxView)

function LanguagePackageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LanguagePackageItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.comps_:GetController("status")
end

function LanguagePackageItem:AddUIListener()
	self:AddBtnListenerScale(self.downloadBtn_, nil, function()
		if gameContext:IsOpenRoute("setting") then
			manager.notify:CallUpdateFunc("JumpToLanguageManageUI")
			self:Back()

			return
		end

		if AssetPendDownLoadManager.instance:GetVoicePackageSize(self.info_.affix) + 200 > LuaForUtil.GetFreeDiskSpace() then
			ShowMessageBox({
				content = GetTips("VOICE_STORAGE_FULL"),
				OkCallback = function()
					return
				end,
				CancelCallback = function()
					return
				end,
				MaskCallback = function()
					return
				end
			})
		else
			OpenDownLoadPage(nil, self.info_.affix, self.needSetParent_)
		end
	end)
	self:AddBtnListenerScale(self.deleteBtn_, nil, function()
		ShowMessageBox({
			content = string.format(GetTips("VOICE_DELETE_INFO"), GetI18NText(self.info_.name)),
			OkCallback = function()
				VoicePackageManager.Instance:DeleteDownLoadPackage(self.info_.affix)
				manager.assetPend:UpdateAssetPendSize()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DELETED, self.info_.affix)
				self:RefreshData(self.info_, self.needSetParent_)
			end,
			CancelCallback = function()
				return
			end,
			MaskCallback = function()
				return
			end
		})
	end)
end

function LanguagePackageItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function LanguagePackageItem:Render()
	self:RefreshData(self.info_, self.needSetParent_)
end

function LanguagePackageItem:RefreshData(arg_14_1, arg_14_2)
	if arg_14_1 then
		self.needSetParent_ = arg_14_2
		self.info_ = arg_14_1
		self.nameText_.text = GetI18NText(arg_14_1.name)

		if VoicePackageManager.Instance:IsHavePackage(arg_14_1.affix) then
			self.spaceText_.text = ""

			if SettingData:GetSoundSettingData().voice_language == arg_14_1.id then
				self.statusController_:SetSelectedState("in_use")

				self.tipText_.text = GetTips("TIP_USING")
			else
				self.statusController_:SetSelectedState("downloaded")

				if table.indexof(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list, arg_14_1.id) == 1 then
					SetActive(self.deleteBtn_.gameObject, false)
				end

				self.tipText_.text = GetTips("DOWNLOADED")
			end
		else
			self.statusController_:SetSelectedState("not_downloaded")

			self.spaceText_.text = string.format("(%.2fMB)", AssetPendDownLoadManager.instance:GetVoicePackageSize(arg_14_1.affix))
			self.tipText_.text = GetTips("NOT_DOWNLOADED")
		end
	end
end

function LanguagePackageItem:Dispose()
	self.params_ = nil

	LanguagePackageItem.super.Dispose(self)
end

return LanguagePackageItem

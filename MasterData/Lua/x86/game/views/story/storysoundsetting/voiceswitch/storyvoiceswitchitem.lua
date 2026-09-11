local StoryVoiceSwitchItem = class("StoryVoiceSwitchItem", ReduxView)

function StoryVoiceSwitchItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StoryVoiceSwitchItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.comps_:GetController("status")
end

function StoryVoiceSwitchItem:AddUIListener()
	self:AddToggleListener(self.toggle_, function(arg_4_0)
		if arg_4_0 then
			manager.notify:CallUpdateFunc(GAME_VOICE_SETTING, self.info_.id)
		end
	end)
	self:AddBtnListenerScale(self.downloadBtn_, nil, function()
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
			OpenDownLoadPage(nil, self.info_.affix, true)
		end
	end)
end

function StoryVoiceSwitchItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StoryVoiceSwitchItem:Render()
	self:RefreshData(self.info_)
end

function StoryVoiceSwitchItem:RefreshData(arg_11_1, arg_11_2)
	if arg_11_1 then
		self.info_ = arg_11_1
		self.nameText_.text = GetI18NText(arg_11_1.name)

		if VoicePackageManager.Instance:IsHavePackage(arg_11_1.affix) then
			self.spaceText_.text = ""

			if arg_11_2 == arg_11_1.id then
				self.statusController_:SetSelectedState("in_use")

				self.toggle_.isOn = true
			else
				self.statusController_:SetSelectedState("downloaded")
			end
		else
			self.statusController_:SetSelectedState("not_downloaded")
			SetActive(self.downloadBtn_.gameObject, false)

			self.spaceText_.text = string.format("(%.2fMB)", AssetPendDownLoadManager.instance:GetVoicePackageSize(arg_11_1.affix))
		end
	end
end

function StoryVoiceSwitchItem:Dispose()
	self.params_ = nil

	StoryVoiceSwitchItem.super.Dispose(self)
end

return StoryVoiceSwitchItem

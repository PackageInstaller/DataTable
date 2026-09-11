local SelectMusicPopup = class("SelectMusicPopup", ReduxView)

function SelectMusicPopup:UIName()
	return "Widget/BackHouseUI/IdolDance/IdolDancePlayerPopUI"
end

function SelectMusicPopup:UIParent()
	return manager.ui.uiPop.transform
end

function SelectMusicPopup:Init()
	self:BindCfgUI()

	self.musicUIList = LuaList.New(handler(self, self.RenderMusicItem), self.uiList_, IdolDanceMusicItem)
	self.playStateController = self.controllers_:GetController("state")

	function self.musicItemSelectFunc(arg_4_0)
		self.select = arg_4_0

		self.musicUIList:Refresh()
		self:RefreshView()
		DIYBridge:RestartBGM(arg_4_0)
	end

	self:AddBtnListener(self.emptyAreaBtn_, nil, function()
		if self.backIfClickBG then
			self:OnClosePopup()
		end
	end)
end

function SelectMusicPopup:OnEnter()
	self.select = DIYBridge.music
	self.onSelectMusic = self.params_.onSelectMusic
	self.backIfClickBG = true

	DIYBridge:RestartBGM(self.select)
	self.musicUIList:StartScroll(#IdolStageMusicCfg.all)
	self:RefreshView()
end

function SelectMusicPopup:OnExit()
	manager.audio:StopBGM()
end

function SelectMusicPopup:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:OnClosePopup()
	end)
end

function SelectMusicPopup:OnBehind()
	manager.windowBar:HideBar()
end

function SelectMusicPopup:Dispose()
	self.musicUIList:Dispose()
	SelectMusicPopup.super.Dispose(self)
end

function SelectMusicPopup:OnClosePopup()
	if self.select and self.onSelectMusic and not self:onSelectMusic(self.select) then
		JumpTools.Back()
	end
end

function SelectMusicPopup:RefreshView(arg_13_1)
	arg_13_1 = arg_13_1 or self.select
	self.name_.text = nullable(IdolStageMusicCfg, arg_13_1, "music_name")

	self:UpdateMusicThumbnail(arg_13_1)

	self.duration_.text = manager.time:DescCdTime2(IdolTraineeTools.GetMusicDuration(arg_13_1) or 0)
end

function SelectMusicPopup:UpdateMusicThumbnail(arg_14_1)
	local var_14_0
	local var_14_1 = nullable(IdolStageMusicCfg, arg_14_1, "music_record")

	if var_14_1 then
		if MusicAlbumRecordCfg[MusicRecordCfg[var_14_1].album].cover then
			var_14_0 = "TextureConfig/IllustratedHandbook/musicCD/" .. MusicAlbumRecordCfg[MusicRecordCfg[var_14_1].album].cover
		end
	end

	if var_14_0 == nil then
		local var_14_2 = nullable(IdolStageMusicCfg, arg_14_1, "cover")

		if var_14_2 and var_14_2 ~= "" then
			var_14_0 = "TextureConfig/Music/Music_icon/" .. var_14_2
		end
	end

	self.thumbnail_.spriteSync = var_14_0
end

function SelectMusicPopup:RenderMusicItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(IdolStageMusicCfg.all[arg_15_1])
	arg_15_2:SetSelected(self.select == arg_15_2.music)
	arg_15_2:SetOnClick(self.musicItemSelectFunc)
end

function SelectMusicPopup:PlayBGM(arg_16_1)
	if IdolStageMusicCfg[arg_16_1] then
		manager.audio:PlayBGM(IdolStageMusicCfg[arg_16_1].cue_sheet, IdolStageMusicCfg[arg_16_1].cue_name, IdolStageMusicCfg[arg_16_1].awb_name)
		self.playStateController:SetSelectedState("play")
	end
end

function SelectMusicPopup:StopBGM()
	manager.audio:StopBGM()
	self.playStateController:SetSelectedState("stop")
end

function SelectMusicPopup:SetSelectMusic(arg_18_1)
	self.select = arg_18_1

	self.musicUIList:Refresh()
	self:RefreshView()
	DIYBridge:RestartBGM(self.select)
end

return SelectMusicPopup

local IlluMusicSongItem = class("IlluMusicSongItem", ReduxView)

function IlluMusicSongItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.handler = arg_1_2

	self:Init()
end

function IlluMusicSongItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.expand = false
	self.rectTransform = self.gameObject_:GetComponent(typeof(RectTransform))
end

function IlluMusicSongItem:InitUI()
	self:BindCfgUI()

	self.expandController = ControllerUtil.GetController(self.transform_, "expand")
	self.playController = ControllerUtil.GetController(self.transform_, "play")
end

function IlluMusicSongItem:AddUIListener()
	self:AddBtnListener(self.m_expandBtn, nil, function()
		self:SetExpand(not self.expand)
	end)
	self:AddBtnListener(self.m_playBtn, nil, function()
		if self.handler and self.handler.PlayMusic then
			self.handler:PlayMusic(self.id)
		end
	end)
end

function IlluMusicSongItem:RefreshUI(arg_7_1)
	self.id = arg_7_1
	self.m_info.text = GetI18NText(MusicRecordCfg[arg_7_1].detail)

	local var_7_0 = UnityEngine.TextGenerator.New()
	local var_7_1 = self.m_title:GetGenerationSettings(self.m_title.transform.rect.size)
	local var_7_2 = GetI18NText(MusicRecordCfg[arg_7_1].musicName)
	local var_7_3 = var_7_0:GetPreferredWidth(var_7_2, var_7_1) / self.m_title.pixelsPerUnit

	if var_7_3 > self.m_title.transform.rect.size.x then
		var_7_2 = var_7_2 .. "..."

		local var_7_4 = utf8len(var_7_2)

		while var_7_3 > self.m_title.transform.rect.size.x do
			if var_7_4 <= 4 then
				var_7_2 = GetI18NText(MusicRecordCfg[arg_7_1].musicName)

				break
			end

			var_7_4 = var_7_4 - 1 - 3
			var_7_2 = utf8sub(var_7_2, 1, var_7_4) .. "..."
			var_7_3 = var_7_0:GetPreferredWidth(var_7_2, var_7_1) / self.m_title.pixelsPerUnit
		end
	end

	self.m_title.text = var_7_2

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_info.transform)
	self:SetExpand(self.expand)
end

function IlluMusicSongItem:RefreshSongsState(arg_8_1)
	self.playController:SetSelectedIndex(self.id == arg_8_1 and 1 or 0)
end

function IlluMusicSongItem:GetMusicId()
	return self.id
end

function IlluMusicSongItem:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function IlluMusicSongItem:SetExpand(arg_11_1)
	self.expand = arg_11_1

	if arg_11_1 then
		self.expandController:SetSelectedIndex(1)
	else
		self.expandController:SetSelectedIndex(0)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_info.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)

	if self.handler and self.handler.ForceRebuild then
		self.handler:ForceRebuild()
	end
end

function IlluMusicSongItem:GetAnchoredPosition()
	return self.rectTransform.anchoredPosition
end

function IlluMusicSongItem:Dispose()
	IlluMusicSongItem.super.Dispose(self)
end

return IlluMusicSongItem

local MusicSelectItem = class("MusicSelectItem", ReduxView)

function MusicSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MusicSelectItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.music_item_list = {}
end

function MusicSelectItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "toggle")
	self.linkTagController_ = self.controller_:GetController("linkTag")
	self.newTagController_ = self.controller_:GetController("newTag")
	self.finishController_ = self.controller_:GetController("finishbg")
	self.isSelect = false
end

function MusicSelectItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnClickBtn()
	end)
end

function MusicSelectItem:OnClickBtn()
	if self.isSelect then
		return
	end

	manager.notify:Invoke(MUSIC_TREE_CLICK_ITEM, self.mainActivityID, self.musicActivityID)
end

function MusicSelectItem:GetMusicActivityID()
	return self.musicActivityID
end

function MusicSelectItem:SetData(arg_8_1, arg_8_2)
	self.mainActivityID = arg_8_1
	self.musicActivityID = arg_8_2

	self:RefreshUI()
	self:RefreshSelectInfo()
end

function MusicSelectItem:RefreshUI()
	local var_9_0 = ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.musicActivityID][1]]
	local var_9_1 = MusicData:GetTagImagePath(ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.musicActivityID][1]].id)

	if var_9_1 then
		self.linkTagController_:SetSelectedState("show")

		self.linkImage_.sprite = getSpriteWithoutAtlas(var_9_1)
	else
		self.linkTagController_:SetSelectedState("hide")
	end

	self.authorText_.text = GetI18NText(var_9_0.creator_name)
	self.nameText_.text = GetI18NText(var_9_0.name)

	self:BindRed(true)
	self:UpdateFinishState()
end

function MusicSelectItem:UpdateFinishState()
	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[self.musicActivityID]) do
		if MusicData:GetIsComplete(iter_10_1) ~= 0 then
			var_10_0 = true

			break
		end
	end

	self.finishController_:SetSelectedState(var_10_0 and "finish" or "normal")
end

function MusicSelectItem:RefreshSelectInfo()
	self.selectController_:SetSelectedState(self.isSelect and "on" or "off")
end

function MusicSelectItem:ChangeSelectState(arg_12_1)
	self.isSelect = arg_12_1

	self:RefreshSelectInfo()
end

function MusicSelectItem:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

function MusicSelectItem:BindRed(arg_14_1)
	if arg_14_1 then
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.MUSIC_OPEN, self.musicActivityID))
	else
		manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.MUSIC_OPEN, self.musicActivityID))
	end
end

function MusicSelectItem:Dispose()
	MusicSelectItem.super.Dispose(self)
end

return MusicSelectItem

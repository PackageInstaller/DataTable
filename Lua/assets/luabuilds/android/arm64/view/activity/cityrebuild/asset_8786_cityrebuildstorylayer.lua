local CityRebuildStoryLayer = class("CityRebuildStoryLayer", import("view.base.BaseUI"))

function CityRebuildStoryLayer:getUIName()
	return "CityRebuildStoryUI"
end

function CityRebuildStoryLayer:init()
	self.bg = self._tf:Find("bg")
	self.closeBtn = self._tf:Find("panel/closeBtn")
	self.storyList = UIItemList.New(self._tf:Find("panel/storyScroll/Viewport/Content"), self._tf:Find("panel/storyScroll/Viewport/Content/story"))

	setText(self._tf:Find("panel/desc"), i18n("ninja_game_storydialog"))
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CityRebuildStoryLayer:didEnter()
	self:InitData()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	self:Refresh()

	return
end

function CityRebuildStoryLayer:InitData()
	self.activityId = ActivityConst.NINJA_CITY_ACT_ID
	self.cityRebuildProxy = getProxy(CityRebuildProxy)
	self.cityRebuildData = self.cityRebuildProxy:GetData(self.activityId)
	self.ids = {}
	self.storyCfgs = {}

	for iter_6_0, iter_6_1 in ipairs(pg.activity_ninja_building.all) do
		if pg.activity_ninja_building[iter_6_1].story ~= "" then
			table.insert(self.ids, iter_6_1)
			table.insert(self.storyCfgs, pg.activity_ninja_building[iter_6_1].story)
		end
	end

	return
end

function CityRebuildStoryLayer:Refresh()
	self.storyList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = self.storyCfgs[arg_8_1 + 1]
			local var_8_1 = self.cityRebuildData:IsRepairedOrRecruited(self.ids[arg_8_1 + 1])

			setActive(arg_8_2:Find("normal"), var_8_1)
			setActive(arg_8_2:Find("lock"), not var_8_1)

			if var_8_1 then
				GetImageSpriteFromAtlasAsync(self.storyCfgs[arg_8_1 + 1][6], "", arg_8_2:Find("normal/mask/pic"))
				setScrollText(arg_8_2:Find("normal/nameBg/name"), self.storyCfgs[arg_8_1 + 1][5])
				onButton(self, arg_8_2, function()
					pg.NewStoryMgr.GetInstance():Play(var_8_0[1], nil, true)

					return
				end, SFX_PANEL)
			else
				setScrollText(arg_8_2:Find("lock/mask/Text"), self.storyCfgs[arg_8_1 + 1][4])
			end
		end

		return
	end)
	self.storyList:align(#self.storyCfgs)

	return
end

function CityRebuildStoryLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return CityRebuildStoryLayer

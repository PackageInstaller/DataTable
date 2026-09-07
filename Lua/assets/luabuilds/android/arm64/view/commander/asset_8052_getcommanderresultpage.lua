local GetCommanderResultPage = class("GetCommanderResultPage", import("view.base.BaseSubView"))

function GetCommanderResultPage:getUIName()
	return "GetCommanderResultUI"
end

function GetCommanderResultPage:OnLoaded()
	self.treePanel = CommanderTreePage.New(self._tf, self.event)
	self.uiList = UIItemList.New(self._tf:Find("frame/list"), self._tf:Find("frame/list/tpl"))
	self.uiList1 = UIItemList.New(self._tf:Find("frame/list1"), self._tf:Find("frame/list/tpl"))

	setText(self._tf:Find("frame/Text"), i18n("word_click_to_close"))

	return
end

function GetCommanderResultPage:OnInit()
	self.paintings = {}

	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function GetCommanderResultPage:Show(arg_5_1)
	GetCommanderResultPage.super.Show(self)
	self:UpdateCommanders(arg_5_1)

	return
end

function GetCommanderResultPage:UpdateCommanders(arg_6_1)
	self.uiList:align(0)
	self.uiList1:align(0)

	local var_6_0

	if #arg_6_1 <= 5 then
		var_6_0 = self.uiList1 or self.uiList
	end

	var_6_0:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateCommander(arg_6_1[arg_7_1 + 1], arg_7_2)
		end

		return
	end)
	var_6_0:align((#arg_6_1 <= 5 or nil) and (#arg_6_1 or 10))

	return
end

function GetCommanderResultPage:UpdateCommander(arg_8_1, arg_8_2)
	if arg_8_1 then
		local var_8_0 = arg_8_1:getPainting()
		local var_8_1 = arg_8_2:Find("info/mask/paint")

		arg_8_2:Find("info/frame"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/CommanderBuildResultUI_atlas", ({
			"",
			"",
			"R",
			"SR",
			"SSR"
		})[arg_8_1:getRarity()])

		setCommanderPaintingPrefab(var_8_1, var_8_0, "result2")
		self:UpdateTalent(arg_8_1, arg_8_2)

		self.paintings[var_8_0] = var_8_1

		setText(arg_8_2:Find("info/Text"), arg_8_1:getName())
	end

	setActive(arg_8_2:Find("empty"), arg_8_1 == nil)
	setActive(arg_8_2:Find("info"), arg_8_1)

	return
end

function GetCommanderResultPage:UpdateTalent(arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:getTalents()
	local var_9_1 = UIItemList.New(arg_9_2:Find("info/talent"), arg_9_2:Find("info/talent/tpl"))

	var_9_1:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = var_9_0[arg_10_1 + 1]

			GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. var_9_0[arg_10_1 + 1]:getConfig("icon"), "", arg_10_2)
			onButton(self, arg_10_2, function()
				self.treePanel:ExecuteAction("Show", var_10_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_9_1:align(#var_9_0)

	return
end

function GetCommanderResultPage:OnDestroy()
	if self.treePanel then
		self.treePanel:Destroy()

		self.treePanel = nil
	end

	for iter_12_0, iter_12_1 in ipairs(self.paintings) do
		retCommanderPaintingPrefab(iter_12_1, iter_12_0)
	end

	self.paintings = {}

	return
end

return GetCommanderResultPage

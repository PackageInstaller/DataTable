local CommanderTreePage = class("CommanderTreePage", import("...base.BaseSubView"))

function CommanderTreePage:getUIName()
	return "CommanderTreeUI"
end

function CommanderTreePage:OnInit()
	self.treePanel = self._tf
	self.treeList = UIItemList.New(self.treePanel:Find("bg/frame/bg/talents"), self.treePanel:Find("bg/frame/bg/talents/telent"))
	self.treeTalentDesTxt = self.treePanel:Find("bg/frame/bg/desc/Text"):GetComponent(typeof(Text))
	self.treePanelCloseBtn = self.treePanel:Find("bg/frame/close_btn")

	setActive(self.treePanel, false)
	onButton(self, self.treePanel, function()
		self:closeTreePanel()

		return
	end, SFX_PANEL)
	onButton(self, self.treePanelCloseBtn, function()
		self:closeTreePanel()

		return
	end, SFX_PANEL)
	setText(self._tf:Find("Text"), i18n("commander_choice_talent_4"))

	return
end

function CommanderTreePage:Show(arg_5_1)
	setActive(self.treePanel, true)
	self.treePanel:SetAsLastSibling()

	local function var_5_0(arg_6_0)
		self.treeTalentDesTxt.text = arg_6_0:getConfig("desc")

		return
	end

	local var_5_1 = arg_5_1:getTalentList()

	self.treeList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = CommanderTalent.New({
				origin = false,
				id = var_5_1[arg_7_1 + 1]
			})

			onToggle(self, arg_7_2, function(arg_8_0)
				if arg_8_0 then
					var_5_0(var_7_0)
				end

				return
			end, SFX_PANEL)
			setText(arg_7_2:Find("name"), var_7_0:getConfig("name"))
			triggerToggle(arg_7_2, arg_5_1.id == var_7_0.id)
			setActive(arg_7_2:Find("curr"), arg_5_1.id == var_7_0.id)
			setActive(arg_7_2:Find("arr"), arg_7_1 ~= #var_5_1 - 1)
			GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. var_7_0:getConfig("icon"), "", arg_7_2)
		end

		return
	end)
	self.treeList:align(#var_5_1)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CommanderTreePage:Hide()
	self:closeTreePanel()

	return
end

function CommanderTreePage:closeTreePanel()
	setActive(self.treePanel, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function CommanderTreePage:OnDestroy()
	return
end

return CommanderTreePage

local IslandOtherCardPage = class("IslandOtherCardPage", import(".IslandSelfCardPage"))

function IslandOtherCardPage:OnShow(arg_1_1)
	self.userId = arg_1_1

	IslandOtherCardPage.super.OnShow(self)

	return
end

function IslandOtherCardPage:GetContext()
	return Context.New({
		mediator = IslandOtherCardMediator,
		viewComponent = IslandOtherCardAttach,
		data = {
			isIslandPage = true,
			container = self._tf,
			onClose = function()
				self:Hide()

				return
			end,
			userId = self.userId
		}
	})
end

return IslandOtherCardPage

local MainTagsView = class("MainTagsView", import("..base.MainBaseView"))

function MainTagsView:Ctor(arg_1_1, arg_1_2)
	MainTagsView.super.Ctor(self, arg_1_1, arg_1_2)

	self.monthCardTag = findTF(self._tf, "monthcard")
	self.sellTag = findTF(self._tf, "sell")
	self.skinTag = findTF(self._tf, "skin")
	self.buildTag = findTF(self._tf, "build")
	self.tecShipGiftTag = findTF(self._tf, "tecshipgift")
	self.mallTip = findTF(self._tf, "tip")

	return
end

function MainTagsView:Init()
	local var_2_0 = {}

	table.insert(var_2_0, function(arg_3_0)
		TagTipHelper.TecShipGiftTip(self.tecShipGiftTag)
		onNextTick(arg_3_0)

		return
	end)
	table.insert(var_2_0, function(arg_4_0)
		TagTipHelper.MonthCardTagTip(self.monthCardTag)
		onNextTick(arg_4_0)

		return
	end)
	table.insert(var_2_0, function(arg_5_0)
		TagTipHelper.SkinTagTip(self.skinTag)
		onNextTick(arg_5_0)

		return
	end)
	table.insert(var_2_0, function(arg_6_0)
		TagTipHelper.FuDaiTagTip(self.sellTag)
		onNextTick(arg_6_0)

		return
	end)
	table.insert(var_2_0, function(arg_7_0)
		TagTipHelper.GiftPackagesTag({
			self.mallTip
		})
		onNextTick(arg_7_0)

		return
	end)
	table.insert(var_2_0, function(arg_8_0)
		TagTipHelper.FreeBuildTicketTip(self.buildTag)
		onNextTick(arg_8_0)

		return
	end)
	seriesAsync(var_2_0)

	return
end

function MainTagsView:Refresh()
	self:Init()

	return
end

return MainTagsView

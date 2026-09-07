local BannerScrollRect4IslandDrawAward = class("BannerScrollRect4IslandDrawAward", import("view.newMain.page.BannerScrollRect"))

function BannerScrollRect4IslandDrawAward:UpdateDotPosition(arg_1_1, arg_1_2)
	return
end

function BannerScrollRect4IslandDrawAward:TriggerDot(arg_2_1, arg_2_2)
	arg_2_1:GetComponent(typeof(LayoutElement)).preferredWidth = arg_2_2 and 26 or 8

	setActive(arg_2_1:Find("dot"), not arg_2_2)
	setActive(arg_2_1:Find("line"), arg_2_2)

	if arg_2_2 then
		existCall(self.triggerDotCall, self.index)
	end

	return
end

function BannerScrollRect4IslandDrawAward:SetUp(arg_3_1)
	BannerScrollRect4IslandDrawAward.super.SetUp(self)

	if arg_3_1 and arg_3_1 > 0 then
		self:Pause()

		self.uniqueLT = LeanTween.delayedCall(arg_3_1, System.Action(function()
			self:Resume()

			return
		end))
	end

	return
end

function BannerScrollRect4IslandDrawAward:SetTriggerDotCall(arg_5_1)
	self.triggerDotCall = arg_5_1

	return
end

function BannerScrollRect4IslandDrawAward:Reset()
	BannerScrollRect4IslandDrawAward.super.Reset(self)

	self.triggerDotCall = nil

	return
end

function BannerScrollRect4IslandDrawAward:Dispose()
	BannerScrollRect4IslandDrawAward.super.Dispose(self)

	return
end

return BannerScrollRect4IslandDrawAward

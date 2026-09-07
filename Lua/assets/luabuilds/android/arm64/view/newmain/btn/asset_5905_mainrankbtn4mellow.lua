local MainRankBtn4Mellow = class("MainRankBtn4Mellow", import(".MainRankBtn"))

function MainRankBtn4Mellow:Ctor(arg_1_1, arg_1_2)
	MainRankBtn4Mellow.super.Ctor(self, arg_1_1, arg_1_2)

	self.rankImage = arg_1_1:Find("root/Image"):GetComponent(typeof(Image))

	return
end

function MainRankBtn4Mellow:Flush()
	local var_2_0 = self:IsActive()

	setActive(self._tf:Find("root/lock"), not var_2_0)

	self.rankImage.color = var_2_0 and Color(1, 1, 1, 1) or Color(0.3, 0.3, 0.3, 1)

	return
end

return MainRankBtn4Mellow

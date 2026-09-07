local MainActivityBtnView4Mellow = class("MainActivityBtnView4Mellow", import("...theme_classic.view.MainActivityBtnView"))

function MainActivityBtnView4Mellow:Ctor(arg_1_1, arg_1_2)
	MainActivityBtnView4Mellow.super.Ctor(self, arg_1_1, arg_1_2)

	self.mapEventTr = arg_1_1:Find("right/1/act/act_battle")
	self.mapBtn = MainActivityBtnMellowAdapt.New(MainActMapBtn.New(self.mapEventTr, self.event, true, true))
	self.mapSubEventTr = arg_1_1:Find("right/1/act/act_sub_battle")
	self.mapSubBtn = MainActivityBtnMellowAdapt.New(MainActSubMapBtn.New(self.mapSubEventTr, self.event, true, true))
	self.voteEventTr = arg_1_1:Find("right/1/act/act_vote")
	self.voteBtn = MainActivityBtnMellowAdapt.New(NewMainVoteEntranceBtn.New(self.voteEventTr, self.event))
	self.subActEventTr = arg_1_1:Find("right/1/act/act_sub")
	self.subActBtn = MainActivityBtnMellowAdapt.New(MainSubActBtn.New(self.subActEventTr, self.event, true, true))

	return
end

function MainActivityBtnView4Mellow:InitBtns()
	self.actBtnTpl = self._tf:Find("right/activity/tpl")

	MainActivityBtnView4Mellow.super.InitBtns(self)

	self.activityBtns = _.map(_.select(self.activityBtns, function(arg_3_0)
		return not isa(arg_3_0, MainActMapBtn)
	end), function(arg_4_0)
		return MainActivityBtnMellowAdapt.New(arg_4_0)
	end)
	self.specailBtns = _.map(self.specailBtns, function(arg_5_0)
		assert(_G[arg_5_0.__cname .. "MellowAdapt"])

		return _G[arg_5_0.__cname .. "MellowAdapt"].New(arg_5_0)
	end)

	return
end

function MainActivityBtnView4Mellow:GetBtn(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.activityBtns) do
		if isa(iter_6_1.activityBtn, arg_6_1) then
			return iter_6_1
		end
	end

	for iter_6_2, iter_6_3 in ipairs(self.specailBtns) do
		if isa(iter_6_3.spActBtn, arg_6_1) then
			return iter_6_3
		end
	end

	return nil
end

function MainActivityBtnView4Mellow:Flush()
	local var_7_0, var_7_1 = self:FilterActivityBtns()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		iter_7_1:Init(iter_7_0)
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		iter_7_3:Clear()
	end

	local var_7_2, var_7_3 = self:FilterSpActivityBtns()

	for iter_7_4, iter_7_5 in ipairs(var_7_2) do
		iter_7_5:Init()
	end

	for iter_7_6, iter_7_7 in ipairs(var_7_3) do
		iter_7_7:Clear()
	end

	if self.mapBtn:InShowTime() then
		self.mapBtn:Init()
	else
		self.mapBtn:Clear()
	end

	if self.mapSubBtn:InShowTime() then
		self.mapSubBtn:Init()
	else
		self.mapSubBtn:Clear()
	end

	if self.voteBtn:InShowTime() then
		self.voteBtn:Init()
	else
		self.voteBtn:Hide()
	end

	if self.subActBtn:InShowTime() then
		self.subActBtn:Init()
	else
		self.subActBtn:Clear()
	end

	return
end

function MainActivityBtnView4Mellow:GetDirection()
	return Vector2.zero
end

function MainActivityBtnView4Mellow:Dispose()
	MainActivityBtnView4Mellow.super.Dispose(self)
	self.mapBtn:Dispose()

	self.mapBtn = nil

	self.mapSubBtn:Dispose()

	self.mapSubBtn = nil

	self.voteBtn:Dispose()

	self.voteBtn = nil

	self.subActBtn:Dispose()

	self.subActBtn = nil

	return
end

return MainActivityBtnView4Mellow

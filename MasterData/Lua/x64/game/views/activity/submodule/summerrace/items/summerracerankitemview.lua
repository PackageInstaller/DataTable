local SummerRaceRankItemView = class("SummerRaceRankItemView", ReduxView)

function SummerRaceRankItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SummerRaceRankItemView:Init()
	self:BindCfgUI()
	self:BindItemRuntime_()
	self:AddUIListener()
end

function SummerRaceRankItemView:BindItemRuntime_()
	self.rankController_ = self.gameObject_:GetComponent(typeof(Controller))
	self.commonPortrait_ = self.headGo_ ~= nil and CommonHeadPortrait.New(self.headGo_) or nil
end

function SummerRaceRankItemView:AddUIListener()
	self:AddBtnListener(self.checkBtn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_, self.rankData_)
		end
	end)
end

function SummerRaceRankItemView:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.rankData_ = arg_6_1
	self.index_ = arg_6_2
	self.clickHandler_ = arg_6_3

	self:RefreshView()
end

function SummerRaceRankItemView:RefreshView()
	if self.rankData_ == nil then
		return
	end

	local var_7_0 = tonumber(self.rankData_.rank) or self.index_ or 0

	self.rankLabel_.text = tostring(var_7_0)
	self.nickLabel_.text = tostring(self.rankData_.playerName or self.rankData_.nick or "")
	self.scoreLabel_.text = tostring(self.rankData_.score or 0)
	self.layerLabel_.text = tostring(self.rankData_.layerText or self.rankData_.difficulty or "")

	if self.rankController_ ~= nil then
		self.rankController_:SetSelectedIndex(var_7_0 < 4 and var_7_0 or 0)
	end

	if self.commonPortrait_ ~= nil then
		local var_7_1 = PlayerData:GetPlayerInfo()
		local var_7_2 = self.rankData_.portrait

		if not self.rankData_.portrait then
			if self.rankData_.isSelf then
				var_7_2 = var_7_1.portrait or nil
			end
		end

		local var_7_3 = self.rankData_.frame

		if not self.rankData_.frame then
			var_7_3 = self.rankData_.icon_frame

			if not self.rankData_.icon_frame then
				if self.rankData_.isSelf then
					var_7_3 = var_7_1.icon_frame or nil
				end
			end
		end

		self.commonPortrait_:RenderHead(var_7_2 or 0)
		self.commonPortrait_:RenderFrame(var_7_3 or 0)
	end
end

function SummerRaceRankItemView:Dispose()
	if self.commonPortrait_ ~= nil then
		self.commonPortrait_:Dispose()

		self.commonPortrait_ = nil
	end

	self.rankData_ = nil
	self.clickHandler_ = nil

	self:RemoveAllListeners()
	SummerRaceRankItemView.super.Dispose(self)
end

return SummerRaceRankItemView

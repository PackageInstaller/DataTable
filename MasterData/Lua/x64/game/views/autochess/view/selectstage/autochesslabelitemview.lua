local AutoChessLabelItemView = class("AutoChessLabelItemView", ReduxView)

function AutoChessLabelItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.labelItemList_ = {}

	self:Init()
end

function AutoChessLabelItemView:Init()
	self:BindCfgUI()
end

function AutoChessLabelItemView:RefreshLabelData(arg_3_1, arg_3_2)
	local var_3_0, var_3_1 = self:GetAllLabel(arg_3_2)
	local var_3_2 = 0
	local var_3_3 = 0

	for iter_3_0 = 1, #var_3_0 / 3 + 1 do
		for iter_3_1 = 1, 3 do
			var_3_2 = var_3_2 + 1

			if self.labelItemList_[iter_3_1] == nil then
				self.labelItemList_[iter_3_1] = {}
			end

			if self.labelItemList_[iter_3_1][iter_3_0] == nil then
				if var_3_0[var_3_2] then
					local var_3_4 = Object.Instantiate(self.labelGo_, self.transform_)
					local var_3_5 = 0

					var_3_5 = self.labelItemList_[iter_3_1][iter_3_0 - 1] and self:RandomPos(self.labelItemList_[iter_3_1][iter_3_0 - 1]:GetLocalPosX(), (iter_3_1 > 1 or nil) and self.labelItemList_[iter_3_1 - 1][iter_3_0]:GetLocalPosX(), self.labelGo_.transform.rect.width) or self:RandomPos(nil, (iter_3_1 > 1 or nil) and self.labelItemList_[iter_3_1 - 1][iter_3_0]:GetLocalPosX(), self.labelGo_.transform.rect.width)
					var_3_4.transform.localPosition = Vector3.New(var_3_5, var_3_4.transform.localPosition.y + (iter_3_1 - 1) * 80, var_3_4.transform.localPosition.z)

					local var_3_8 = AutoChessSubLabelView.New(var_3_4)

					var_3_8:SetData(var_3_0[var_3_2], var_3_1[var_3_2], arg_3_1, self.transform_.rect.width)

					self.labelItemList_[iter_3_1][iter_3_0] = var_3_8

					if var_3_3 < var_3_5 then
						var_3_3 = var_3_5
					end
				end
			elseif var_3_0[var_3_2] then
				self.labelItemList_[iter_3_1][iter_3_0]:SetData(var_3_0[var_3_2], var_3_1[var_3_2], arg_3_1, self.transform_.rect.width)
			else
				self.labelItemList_[iter_3_1][iter_3_0]:SetActive(false)
			end
		end
	end

	local var_3_9 = math.max(var_3_3 - (self.transform_.rect.width / 2 + self.labelGo_.transform.rect.width / 2), self.transform_.rect.width + self.labelGo_.transform.rect.width / 2)

	for iter_3_2, iter_3_3 in pairs(self.labelItemList_) do
		for iter_3_4, iter_3_5 in pairs(iter_3_3) do
			iter_3_5:SetMaxWidth(var_3_9)
		end
	end
end

function AutoChessLabelItemView:GetAllLabel(arg_4_1)
	local var_4_1 = {}
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in pairs((AutoChessTools.GetTeamTag(arg_4_1))) do
		if iter_4_1 > 1 then
			table.insert(var_4_1, iter_4_1)
			table.insert(var_4_2, iter_4_0)
		end
	end

	return var_4_2, var_4_1
end

function AutoChessLabelItemView:RandomPos(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 0
	local var_5_1 = arg_5_2
	local var_5_2 = arg_5_2

	if arg_5_2 then
		var_5_1 = arg_5_2 - arg_5_3 / 4
		var_5_2 = arg_5_2 + arg_5_3 / 4
	end

	var_5_0 = arg_5_1 and arg_5_1 + arg_5_3 or self.transform_.rect.width / 2 + arg_5_3 / 2

	if arg_5_2 then
		if var_5_2 < var_5_0 + arg_5_3 / 4 then
			return math.random(var_5_0 + arg_5_3 / 4, var_5_0 + arg_5_3 / 4 + 300)
		elseif var_5_1 < var_5_0 + arg_5_3 / 4 then
			return math.random(var_5_2, var_5_2 + 300)
		elseif math.random(1, 2) == 1 then
			return math.random(var_5_0 + arg_5_3 / 4, var_5_1)
		else
			return math.random(var_5_2, var_5_2 + 300)
		end
	else
		return math.random(var_5_0 + arg_5_3 / 4, var_5_0 + 300)
	end
end

function AutoChessLabelItemView:OnExit()
	for iter_6_0, iter_6_1 in pairs(self.labelItemList_) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			iter_6_3:OnExit()
		end
	end
end

function AutoChessLabelItemView:Dispose()
	for iter_7_0, iter_7_1 in pairs(self.labelItemList_) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			iter_7_3:Dispose()
		end
	end

	AutoChessLabelItemView.super.Dispose(self)
end

return AutoChessLabelItemView

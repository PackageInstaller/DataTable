local DreamlandSpinePlayer = class("DreamlandSpinePlayer")

function DreamlandSpinePlayer:Ctor()
	self.holdSpinePlayRecorder = {}
	self.effects = {}
	self.timers = {}
	self.isPlayEffect = {}

	return
end

function DreamlandSpinePlayer:Play(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.root = arg_2_1
	self.spineAnimUIList = arg_2_3

	if arg_2_4.type == DreamlandData.EXPLORE_TYPE_HOLD then
		self:PlayInterActionAnimHold(arg_2_4.sub_type, arg_2_3[arg_2_2.name], self.holdSpinePlayRecorder[arg_2_2.name], arg_2_2)

		self.holdSpinePlayRecorder[arg_2_2.name] = not defaultValue(self.holdSpinePlayRecorder[arg_2_2.name], false)
	else
		self:PlayInterActionAnimOnce(arg_2_4.sub_type, arg_2_3[arg_2_2.name], arg_2_2)
	end

	return
end

function DreamlandSpinePlayer:PlayInterActionAnimHold(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_3 then
		local var_3_0 = DreamlandUtil.GetSpineNormalAction(arg_3_1[1])

		arg_3_2:SetAction(var_3_0, 0)

		if arg_3_1[1] == DreamlandData.EXPLORE_SUBTYPE_EFFECT then
			self:RemoveEffect(arg_3_1[2])
		end

		if arg_3_1[1] == DreamlandData.EXPLORE_SUBTYPE_UNION then
			if self.spineAnimUIList[arg_3_1[2]] then
				self.spineAnimUIList[arg_3_1[2]]:SetAction(var_3_0, 0)
			end
		end
	elseif arg_3_1[1] == DreamlandData.EXPLORE_SUBTYPE_3SEC then
		self:PlayAction(arg_3_2, "action", "normal2")
	elseif arg_3_1[1] == DreamlandData.EXPLORE_SUBTYPE_EFFECT then
		self:PlayerEffect(-1, arg_3_1[2])
	else
		local var_3_1 = DreamlandUtil.GetSpineInterAction(arg_3_1[1])

		arg_3_2:SetAction(var_3_1, 0)

		if arg_3_1[1] == DreamlandData.EXPLORE_SUBTYPE_UNION then
			if self.spineAnimUIList[arg_3_1[2]] then
				self.spineAnimUIList[arg_3_1[2]]:SetAction(var_3_1, 0)
			end
		end
	end

	return
end

function DreamlandSpinePlayer:PlayInterActionAnimOnce(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1[1] == DreamlandData.EXPLORE_SUBTYPE_EFFECT then
		self:PlayerEffect(arg_4_1[3], arg_4_1[2])
	else
		local var_4_0 = DreamlandUtil.GetSpineInterAction(arg_4_1[1])
		local var_4_1 = DreamlandUtil.GetSpineNormalAction(arg_4_1[1])

		self:PlayAction(arg_4_2, var_4_0, var_4_1)

		if arg_4_1[1] == DreamlandData.EXPLORE_SUBTYPE_UNION then
			if self.spineAnimUIList[arg_4_1[2]] then
				self:PlayAction(self.spineAnimUIList[arg_4_1[2]], var_4_0, var_4_1)
			end
		end
	end

	return
end

function DreamlandSpinePlayer:PlayerEffect(arg_5_1, arg_5_2)
	if self.isPlayEffect[arg_5_2] then
		return
	end

	pg.UIMgr.GetInstance():LoadingOn()
	self:RemoveEffect(arg_5_2)
	PoolMgr.GetInstance():GetUI(arg_5_2, true, function(arg_6_0)
		self.effects[arg_5_2] = arg_6_0

		setParent(arg_6_0, self.root)
		setActive(arg_6_0, true)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	if arg_5_1 > 0 then
		self:AddTimer(arg_5_2, arg_5_1)
	end

	return
end

function DreamlandSpinePlayer:AddTimer(arg_7_1, arg_7_2)
	self.isPlayEffect[arg_7_1] = true
	self.timers[arg_7_1] = Timer.New(function()
		self:RemoveEffect(arg_7_1)

		self.isPlayEffect[arg_7_1] = false

		return
	end, arg_7_2, 1)

	self.timers[arg_7_1]:Start()

	return
end

function DreamlandSpinePlayer:RemoveTimer(arg_9_1)
	if self.timers[arg_9_1] then
		self.timers[arg_9_1]:Stop()

		self.timers[arg_9_1] = nil
	end

	return
end

function DreamlandSpinePlayer:RemoveEffect(arg_10_1)
	self:RemoveTimer()

	if self.effects[arg_10_1] then
		setActive(self.effects[arg_10_1], false)
		PoolMgr.GetInstance():ReturnUI(arg_10_1, self.effects[arg_10_1])

		self.effects[arg_10_1] = nil
	end

	return
end

function DreamlandSpinePlayer:PlayAction(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_1:SetActionCallBack(nil)
	arg_11_1:SetActionCallBack(function(arg_12_0)
		if arg_12_0 == "finish" then
			arg_11_1:SetActionCallBack(nil)
			arg_11_1:SetAction(arg_11_3, 0)

			if arg_11_4 then
				arg_11_4()
			end
		end

		return
	end)
	arg_11_1:SetAction(arg_11_2, 0)

	return
end

function DreamlandSpinePlayer:ClearEffects()
	for iter_13_0, iter_13_1 in pairs(self.effects) do
		self:RemoveEffect(iter_13_0)
	end

	return
end

function DreamlandSpinePlayer:Clear()
	self.holdSpinePlayRecorder = {}

	for iter_14_0, iter_14_1 in pairs(self.timers) do
		iter_14_1:Stop()
	end

	self.timers = {}

	for iter_14_2, iter_14_3 in pairs(self.effects) do
		PoolMgr.GetInstance():ReturnUI(iter_14_2, iter_14_3)
	end

	self.effects = {}
	self.isPlayEffect = {}

	return
end

function DreamlandSpinePlayer:Dispose()
	self:Clear()

	return
end

return DreamlandSpinePlayer

local DanceGameDanmakuSubView = class("DanceGameDanmakuSubView", BaseView)
local var_0_1 = class("DanceGameDanmakuSubView")

function var_0_1:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.kp = arg_1_1
	self.ki = arg_1_2 or 0
	self.kd = arg_1_3 or 0
	self.v = 0
	self.expect = 0
	self.pause = 0
end

function var_0_1:Update(arg_2_1)
	local var_2_0 = (self.monitorValue and self.monitorValue() or self.v) - self.expect

	if self.pause > 0 then
		-- block empty
	else
		local var_2_1 = self.kp * arg_2_1 * math.random()

		if var_2_0 > 0 then
			var_2_1 = -var_2_1
		elseif var_2_0 == 0 then
			var_2_1 = (math.random() * 2 - 1) * arg_2_1
		end

		self.v = var_2_1 + self.v
	end

	self.pause = self.pause - arg_2_1
end

function DanceGameDanmakuSubView:Ctor(arg_3_1)
	self.gameObject_ = arg_3_1
	self.transform_ = arg_3_1.transform
	self.pool = {}
	self.danmaku = {}
	self.ticker = nil
	self.danmakuAmountControl = var_0_1.New(1.5)

	function self.danmakuAmountControl.monitorValue()
		return #self.danmaku
	end

	self:Init()
end

function DanceGameDanmakuSubView:Init()
	self:BindCfgUI()
end

function DanceGameDanmakuSubView:Dispose()
	self:ClearAllDanmaku()

	for iter_6_0, iter_6_1 in pairs(self.pool) do
		Object.Destroy(iter_6_1.obj)
	end

	self.danmaku = nil
	self.pool = nil
end

function DanceGameDanmakuSubView:OnEnter()
	return
end

function DanceGameDanmakuSubView:OnExit()
	self:StopUpdateTicker()
end

function DanceGameDanmakuSubView:Update(arg_9_1)
	self:UpdateActiveDanmaku(arg_9_1)
	self:UpdateGenDanmakuTask(arg_9_1)
end

function DanceGameDanmakuSubView:StartUpdateTicker()
	self:StopUpdateTicker()

	local var_10_0 = Time.time

	self.ticker = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		self:Update(Time.time - var_10_0)

		var_10_0 = Time.time
	end, -1, true)
end

function DanceGameDanmakuSubView:StopUpdateTicker()
	if self.ticker then
		FuncTimerManager.inst:RemoveFuncTimer(self.ticker)

		self.ticker = nil
	end
end

local function var_0_2(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.anchoredPosition

	return arg_13_0.anchoredPosition.x >= 0 and arg_13_0.rect.height >= var_13_0.y and var_13_0.y > -arg_13_1.rect.height
end

local function var_0_3(arg_14_0, arg_14_1)
	arg_14_0.obj.transform.anchoredPosition = arg_14_0.obj.transform.anchoredPosition + Vector2.left * (arg_14_1 * arg_14_0.speed)
end

function DanceGameDanmakuSubView:UpdateActiveDanmaku(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(self.danmaku) do
		if var_0_2(iter_15_1.obj.transform, self.viewport_) then
			var_0_3(iter_15_1, arg_15_1)
		else
			self:RecycleDanmaku(iter_15_1)

			self.danmaku[iter_15_0] = nil
		end
	end
end

function DanceGameDanmakuSubView:ClaimDanmakuFromPool()
	if self.pool[1] then
		return table.remove(self.pool)
	end

	local var_16_0 = Object.Instantiate(self.danmakuPrefab_, self.viewport_)

	return {
		speed = 1,
		active = false,
		obj = var_16_0,
		text = var_16_0:GetComponent("Text")
	}
end

function DanceGameDanmakuSubView:ClearAllDanmaku()
	for iter_17_0, iter_17_1 in pairs(self.danmaku) do
		self:RecycleDanmaku(iter_17_1)

		self.danmaku[iter_17_0] = nil
	end
end

function DanceGameDanmakuSubView:RecycleDanmaku(arg_18_1)
	arg_18_1.active = false

	SetActive(arg_18_1.obj, false)
	table.insert(self.pool, arg_18_1)
end

function DanceGameDanmakuSubView:GenDanmaku(arg_19_1, arg_19_2)
	local var_19_0 = self:ClaimDanmakuFromPool()

	SetActive(var_19_0.obj, true)

	var_19_0.text.text = arg_19_1
	var_19_0.speed = arg_19_2

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(var_19_0.obj.transform)
	self:ArrangeDanmaku(var_19_0)

	var_19_0.active = true

	table.insert(self.danmaku, var_19_0)
end

function DanceGameDanmakuSubView:ArrangeDanmaku(arg_20_1)
	local var_20_0 = {}

	for iter_20_0 = 0.25 * arg_20_1.obj.transform.rect.height * math.random(), self.viewport_.rect.height - arg_20_1.obj.transform.rect.height, 1.1 * arg_20_1.obj.transform.rect.height do
		table.insert(var_20_0, {
			weight = 0,
			y = -iter_20_0
		})
	end

	for iter_20_1, iter_20_2 in pairs(self.danmaku) do
		for iter_20_3, iter_20_4 in pairs(var_20_0) do
			if iter_20_4.y <= iter_20_2.obj.transform.anchoredPosition.y + arg_20_1.obj.transform.rect.height and iter_20_4.y >= iter_20_2.obj.transform.anchoredPosition.y - iter_20_2.obj.transform.rect.height - arg_20_1.obj.transform.rect.height then
				iter_20_4.weight = iter_20_4.weight + iter_20_2.obj.transform.rect.width
			end
		end
	end

	CommonTools.UniversalSortEx(var_20_0, {
		ascend = true,
		map = function(self)
			return self.weight
		end
	}, {
		map = function(self)
			return self.y
		end
	})

	arg_20_1.obj.transform.anchoredPosition = Vector2(self.viewport_.rect.width + arg_20_1.obj.transform.rect.width, var_20_0[1].y)
end

function DanceGameDanmakuSubView:SetDanmakuFilter(arg_23_1)
	self.danmakuFilter = arg_23_1
end

local var_0_4 = 2

function DanceGameDanmakuSubView:UpdateGenDanmakuTask(arg_24_1)
	self.danmakuAmountControl:Update(arg_24_1)

	local var_24_0 = math.min(var_0_4, math.round(self.danmakuAmountControl.v) - #self.danmaku)
	local var_24_2 = self.danmakuFilter and IdolBulletComment.get_id_list_by_comment_type[self.danmakuFilter] or IdolBulletComment.all

	if var_24_0 > 0 then
		local var_24_3 = IdolBulletComment[var_24_2[math.random(var_24_2 and #var_24_2 or 0)]]

		self:GenDanmaku(var_24_3.comment_desc, var_24_3.comment_speed * 100)

		self.danmakuAmountControl.pause = 1 / var_24_0 * math.random()
	end
end

function DanceGameDanmakuSubView:SetExpectDanmakuAmount(arg_25_1)
	self.danmakuAmountControl.expect = arg_25_1
end

return DanceGameDanmakuSubView

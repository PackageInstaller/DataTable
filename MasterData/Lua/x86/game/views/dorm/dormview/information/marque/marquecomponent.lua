local MarqueComponent = class("MarqueComponent", ReduxView)

function MarqueComponent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MarqueComponent:BuildContext()
	self.context = {
		totalLength = 0,
		contentWidth = 0,
		curDuration = 0,
		curSpeedPerTimeUnit = 0,
		timerPerChar = 6,
		startTime = 0
	}
end

function MarqueComponent:Init()
	self.marqueList = {}
	self.choosePool = {}

	self:BuildContext()
	self:BindCfgUI()
end

function MarqueComponent:SetMarqueList(arg_4_1)
	self.marqueList = arg_4_1
end

function MarqueComponent:StartMarque()
	if #self.marqueList > 0 then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.marqueContainer_.transform)

		self.context.contentWidth = self.marqueContainer_.rect.width
		self.context.startTime = 0
		self.context.curDuration = 0
		self.context.curSpeedPerTimeUnit = 0
		self.context.totalLength = 0

		self:StopMarque()
		self:TryNext()

		self.marqueTimer = FrameTimer.New(function()
			self:TryNext()
		end, 1, -1)

		self.marqueTimer:Start()
	end
end

function MarqueComponent:TryNext()
	local var_7_0 = false

	if self.context.startTime == 0 then
		var_7_0 = true
	elseif Time.time - self.context.startTime > self.context.curDuration then
		var_7_0 = true
	end

	if var_7_0 then
		local var_7_1 = self:AcquireNewMarque()

		self.marqueTxt_.text = var_7_1

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.marqueTxt_.transform)

		local var_7_2 = string.len(var_7_1)

		self.context.curSpeedPerTimeUnit = self.context.contentWidth / self.context.timerPerChar
		self.context.totalLength = self.context.contentWidth + self.marqueTxt_.transform.rect.width
		self.context.startTime = Time.time
		self.context.curDuration = self.context.totalLength / self.context.curSpeedPerTimeUnit
		self.marqueTxt_.transform.anchoredPosition = Vector3.New(self.context.contentWidth, 0, 0)
	else
		self.marqueTxt_.transform.anchoredPosition = Vector3.New(self.context.contentWidth - (Time.time - self.context.startTime) * self.context.curSpeedPerTimeUnit, 0, 0)
	end
end

function MarqueComponent:StopMarque()
	if self.marqueTimer then
		self.marqueTimer:Stop()

		self.marqueTimer = nil
	end
end

function MarqueComponent:AcquireNewMarque()
	if #self.choosePool == 0 then
		self:RebuildMarqueChoosePool()
	end

	local var_9_0 = math.random(1, #self.choosePool)

	table.remove(self.choosePool, var_9_0)

	return self.marqueList[self.choosePool[var_9_0]]
end

function MarqueComponent:RebuildMarqueChoosePool()
	self.choosePool = {}

	for iter_10_0 = 1, #self.marqueList do
		table.insert(self.choosePool, iter_10_0)
	end
end

function MarqueComponent:Hide()
	self.transform_.parent.gameObject:SetActive(false)
end

function MarqueComponent:Dispose()
	self:StopMarque()
	MarqueComponent.super.Dispose(self)
end

return MarqueComponent

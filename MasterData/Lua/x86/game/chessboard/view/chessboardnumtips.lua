local ChessBoardNumTips = class("ChessBoardNumTips", ReduxView)

function ChessBoardNumTips:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBoardNumTips:Init()
	self:InitUI()
end

function ChessBoardNumTips:InitUI()
	self:BindCfgUI()

	self.tipsList = {}

	for iter_3_0 = 1, 3 do
		self.tipsList[iter_3_0] = ChessBoardNumTipsItem.New(self[string.format("tips%sObj_", iter_3_0)])
	end

	self.playTipsIndex = 1
	self.willPlayTipsList = {}
	self.canShowAni = true
end

function ChessBoardNumTips:ShowTips(arg_4_1)
	table.insert(self.willPlayTipsList, arg_4_1)
	self:ShowAni()
end

function ChessBoardNumTips:ShowAni()
	if not self.canShowAni then
		return
	end

	local var_5_0 = self.willPlayTipsList[1]

	if not self.willPlayTipsList[1] then
		return
	end

	if var_5_0 then
		table.remove(self.willPlayTipsList, 1)
	end

	self.canShowAni = false

	self.tipsList[self.playTipsIndex]:RefreshUI(var_5_0)

	self.playTipsIndex = self.playTipsIndex % 3 + 1

	self:AddCDTimer()
end

function ChessBoardNumTips:AddCDTimer()
	self:DelCDTimer()

	self.cdTimer = Timer.New(function()
		self.canShowAni = true

		self:ShowAni()
	end, 0.5)

	self.cdTimer:Start()
end

function ChessBoardNumTips:DelCDTimer()
	if self.cdTimer then
		self.cdTimer:Stop()

		self.cdTimer = nil
	end
end

function ChessBoardNumTips:Dispose()
	self:DelCDTimer()

	for iter_9_0, iter_9_1 in pairs(self.tipsList) do
		iter_9_1:Dispose()
	end

	self.super.Dispose(self)
end

return ChessBoardNumTips

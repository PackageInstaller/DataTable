local SummerRaceEnemyWaveItemView = class("SummerRaceEnemyWaveItemView", ReduxView)

function SummerRaceEnemyWaveItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SummerRaceEnemyWaveItemView:Init()
	self:BindCfgUI()

	self.resultController_ = self.controllerEx_:GetController("result")

	self:AddUIListener()
end

function SummerRaceEnemyWaveItemView:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.index_, self.waveData_, "battleInfo")
		end
	end)
end

function SummerRaceEnemyWaveItemView:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.waveData_ = arg_5_1
	self.index_ = arg_5_2
	self.clickHandler_ = arg_5_3

	self:RefreshView()
end

function SummerRaceEnemyWaveItemView:RefreshView()
	local var_6_1 = tostring(self.waveData_.enemyAvatarPath or "")

	self.enemyNameText_.text = tostring(self.waveData_.enemyName or "")
	self.enemyCountText_.text = tostring(self.waveData_.waveText or "")

	local var_6_2 = self.timeText_

	if tonumber(self.waveData_.enemyCount) and self.waveData_.enemyCount > 1 then
		var_6_2.text = "x" .. tostring(self.waveData_.enemyCount or 0) or ""
	end

	self.icon_.spriteSync = var_6_1 ~= "" and var_6_1 or nil

	self.resultController_:SetSelectedState("win")
end

function SummerRaceEnemyWaveItemView:Dispose()
	self.waveData_ = nil
	self.clickHandler_ = nil

	SummerRaceEnemyWaveItemView.super.Dispose(self)
end

return SummerRaceEnemyWaveItemView

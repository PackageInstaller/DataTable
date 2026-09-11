local SnowballGameResultPopup = class("SnowballGameResultPopup", ReduxView)

function SnowballGameResultPopup:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameResultPopup"
end

function SnowballGameResultPopup:UIParent()
	return manager.ui.uiPop.transform
end

function SnowballGameResultPopup:Init()
	self:BindCfgUI()

	self.modeController = ControllerUtil.GetController(self.transform_, "mode")
	self.rewardController = ControllerUtil.GetController(self.transform_, "reward")

	self:AddBtnListener(self.okBtn_, nil, function()
		JumpTools.Back()

		if self.OkCallback then
			self.OkCallback()
		end
	end)
end

local var_0_1 = {
	"normal",
	"hard",
	"infinite"
}

local function var_0_2(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_1.level_score + 1 do
		if arg_5_0 <= (arg_5_1.level_score[iter_5_0] or math.huge) then
			return arg_5_1.level_reward[iter_5_0] or arg_5_1.level_reward[#arg_5_1.level_score]
		end
	end
end

function SnowballGameResultPopup:OnEnter()
	local var_6_0 = self.params_.level
	local var_6_1 = SnowballGameCfg[self.params_.level]
	local var_6_2 = self.params_.hitGuestCount or 0

	self.modeController:SetSelectedState(var_0_1[var_6_1.level_mode])

	self.OkCallback = self.params_.OkCallback

	local var_6_3 = GameSetting.activity_snowball_score_difficulty_factor.value[var_6_1.level_mode] or 1
	local var_6_4 = math.ceil(self.params_.extraTime)
	local var_6_5 = self.params_.score + math.floor(var_6_4 * GameSetting.activity_snowball_score_countdown_bonus.value[1])
	local var_6_6 = math.ceil(var_6_5 * var_6_3)

	self.score_.text = var_6_5

	if var_6_3 == 1 then
		self.scale_.gameObject:SetActive(false)
	else
		self.scale_.gameObject:SetActive(true)

		self.scale_.text = "x" .. var_6_3

		if self.textAni then
			LeanTween.cancel(self.textAni.id)
		end

		local var_6_7 = LeanTween.value(var_6_5, var_6_6, 2):setEase(LeanTweenType.easeInOutQuad):setDelay(1.5)

		var_6_7:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
			self.score_.text = math.floor(arg_7_0)
		end))
		var_6_7:setOnComplete(System.Action(function()
			self.score_.text = var_6_6
			self.textAni = nil
		end))

		self.textAni = var_6_7
	end

	self.time_.text = manager.time:DescCDTime(var_6_1.time_limit - var_6_4)

	local var_6_8 = var_0_2(var_6_6, var_6_1)

	self.rewardController:SetSelectedState(var_6_8 ~= nil and "show" or "hide")

	if var_6_8 then
		self.rewardIcon_.sprite = ItemTools.getItemLittleSprite(var_6_8[1])
		self.reward_.text = string.format("+%d", var_6_8[2])
	end

	local var_6_9 = {}
	local var_6_10 = 1

	for iter_6_0, iter_6_1 in pairs(self.params_.enemyList) do
		var_6_9[var_6_10] = {
			id = iter_6_0,
			count = iter_6_1
		}
		var_6_10 = var_6_10 + 1
	end

	var_6_9[var_6_10] = {
		count = var_6_2,
		id = SnowballGameMgr.GetInstance():GetGuestCfgID()
	}

	local var_6_11 = {
		level = var_6_0,
		score = var_6_6,
		seconds = var_6_1.time_limit - var_6_4
	}

	var_6_11.heroId = SnowballGameMgr.GetInstance():GetPlayerCfgID()
	var_6_11.enemy_list = var_6_9

	SnowballGameAction.LevelClearAction(var_6_11)
end

function SnowballGameResultPopup:OnExit()
	if self.textAni then
		LeanTween.cancel(self.textAni.id)

		self.textAni = nil
	end
end

return SnowballGameResultPopup

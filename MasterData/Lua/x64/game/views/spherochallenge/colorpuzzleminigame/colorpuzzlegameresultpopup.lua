local ColorPuzzleGameResultPopup = class("ColorPuzzleGameResultPopup", ReduxView)

function ColorPuzzleGameResultPopup:UIName()
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleResultPopup"
end

function ColorPuzzleGameResultPopup:UIParent()
	return manager.ui.uiPop.transform
end

function ColorPuzzleGameResultPopup:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()

		if self.okCallback then
			self.okCallback()
		end
	end)

	self.rewardItem = {}

	for iter_3_0 = 1, self.reward_.childCount do
		local var_3_0 = self.reward_:GetChild(iter_3_0 - 1).gameObject
		local var_3_1 = {
			gameObject = var_3_0
		}

		self:BindCfgUI(var_3_0, var_3_1)

		self.rewardItem[iter_3_0] = var_3_1
	end
end

function ColorPuzzleGameResultPopup:OnEnter()
	self.okCallback = self.params_.okCallback
	self.levelName_.text = GetI18NText(ActivityHeroChallengeColor[self.params_.level].name)
	self.time_.text = manager.time:DescCDTime(self.params_.time)

	for iter_5_0, iter_5_1 in ipairs(self.rewardItem) do
		local var_5_0 = nullable(self.params_.rewards, iter_5_0)
		local var_5_1 = nullable(var_5_0, "num") or 0

		if var_5_0 and var_5_1 > 0 then
			SetActive(iter_5_1.gameObject, true)

			iter_5_1.icon_.sprite = ItemTools.getItemLittleSprite(var_5_0.id)
			iter_5_1.count_.text = var_5_1
		else
			SetActive(iter_5_1.gameObject, false)
		end
	end
end

return ColorPuzzleGameResultPopup

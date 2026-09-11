local HeroClueEnterTaskItem_3_6 = class("HeroClueEnterTaskItem_3_6", (import("game.views.heroClue.HeroClueEnterTaskItem")))

function HeroClueEnterTaskItem_3_6:InitController()
	self.statusController_ = self.controllerEx_:GetController("state")
	self.typeController_ = self.controllerEx_:GetController("type")
end

function HeroClueEnterTaskItem_3_6:InitReward()
	self.rewardItem_ = CommonItemView.New(self.rewardItem_, true)
	self.itemData_ = clone(ItemTemplateData)

	function self.itemData_:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end
end

return HeroClueEnterTaskItem_3_6

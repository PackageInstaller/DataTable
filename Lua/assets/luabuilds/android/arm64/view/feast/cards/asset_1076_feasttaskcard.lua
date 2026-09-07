local FeastTaskCard = class("FeastTaskCard")

function FeastTaskCard:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_2
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.nameTxt = self._tf:Find("name/Text"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("desc"):GetComponent(typeof(Text))
	self.progressTxt = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.progress = self._tf:Find("progress/bar")
	self.uilist = UIItemList.New(self._tf:Find("awards"), self._tf:Find("awards/award"))
	self.getBtn = self._tf:Find("btns/get")
	self.gotBtn = self._tf:Find("btns/got")
	self.goBtn = self._tf:Find("btns/go")
	self.sprites = {
		GetSpriteFromAtlas("ui/feasttask_atlas", "t_frame_1"),
		GetSpriteFromAtlas("ui/feasttask_atlas", "t_frame_2")
	}
	self.barSprites = {
		GetSpriteFromAtlas("ui/feasttask_atlas", "t_progress_1"),
		GetSpriteFromAtlas("ui/feasttask_atlas", "t_progress_2")
	}
	self.tags = {
		i18n("feast_task_tag_daily"),
		i18n("feast_task_tag_activity")
	}
	self.barImg = self._tf:Find("progress/bar"):GetComponent(typeof(Image))
	self.bgImg = self._tf:GetComponent(typeof(Image))

	return
end

function FeastTaskCard:Flush(arg_2_1)
	local var_2_0 = getProxy(TaskProxy)
	local var_2_1 = var_2_0:getTaskById(arg_2_1) or var_2_0:getFinishTaskById(arg_2_1)
	local var_2_2 = var_2_1:IsActRoutineType() and 1 or 2

	self.nameTxt.text = self.tags[var_2_2] .. var_2_1:getConfig("name")
	self.descTxt.text = var_2_1:getConfig("desc")
	self.bgImg.sprite = self.sprites[var_2_2]
	self.barImg.sprite = self.barSprites[var_2_2]

	local var_2_3 = var_2_1:getProgress()
	local var_2_4 = var_2_1:getConfig("target_num")

	self.progressTxt.text = var_2_3 .. "/" .. var_2_4

	setFillAmount(self.progress, var_2_3 / var_2_4)

	local var_2_5 = var_2_1:getConfig("award_display")

	self.uilist:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = {
				type = var_2_5[arg_3_1 + 1][1],
				id = var_2_5[arg_3_1 + 1][2],
				count = var_2_5[arg_3_1 + 1][3]
			}

			updateDrop(arg_3_2, var_3_0)
			onButton(self.binder, arg_3_2, function()
				self.binder:emit(BaseUI.ON_DROP, var_3_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.uilist:align(#var_2_5)

	local var_2_6 = var_2_1:isFinish()
	local var_2_7 = var_2_1:isReceive()

	setActive(self.getBtn, var_2_6 and not var_2_7)
	setActive(self.gotBtn, var_2_6 and var_2_7)
	setActive(self.goBtn, not var_2_6)
	onButton(self.binder, self.getBtn, function()
		self.binder:emit(FeastMediator.ON_SUBMIT, arg_2_1)

		return
	end, SFX_PANEL)
	onButton(self.binder, self.goBtn, function()
		self.binder:emit(FeastMediator.ON_GO, var_2_1)

		return
	end, SFX_PANEL)

	return
end

function FeastTaskCard:Dispose()
	self.sprites = nil
	self.barSprites = nil

	return
end

return FeastTaskCard

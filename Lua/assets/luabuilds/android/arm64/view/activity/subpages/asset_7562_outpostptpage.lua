local OutPostPtPage = class("OutPostPtPage", import(".MaoziPtPage"))

function OutPostPtPage:OnInit()
	OutPostPtPage.super.OnInit(self)

	self.getBtn1 = self._tf:Find("AD/switcher/phase2/get_btn")

	return
end

function OutPostPtPage:OnFirstFlush()
	OutPostPtPage.super.OnFirstFlush(self)
	setActive(self.displayBtn, true)

	local var_2_0 = self.displayBtn:Find("Image1")
	local var_2_1, var_2_2 = self:GetActTask()
	local var_2_3 = var_2_1 and var_2_1:isReceive() and var_2_2

	setActive(var_2_0, not var_2_3)
	setActive(self.displayBtn:Find("Image2"), var_2_3)

	if var_2_1 and not var_2_1:isReceive() then
		blinkAni(go(var_2_0), 0.8, -1, 0.3)
	else
		LeanTween.cancel(go(var_2_0))
	end

	onButton(self, self.displayBtn, function()
		if var_2_1 and var_2_1:isReceive() and not var_2_3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("undermist_tip"))

			return
		end

		if var_2_1 and not var_2_3 then
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = "activity",
				targetId = var_2_1.id
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn1, function()
		triggerButton(self.getBtn)

		return
	end, SFX_PANEL)

	return
end

function OutPostPtPage:OnUpdateFlush()
	OutPostPtPage.super.OnUpdateFlush(self)
	setActive(self.getBtn1, (self.ptData:CanGetAward()))

	return
end

function OutPostPtPage:GetActTask()
	local var_6_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.OUTPOST_TASK)

	if not var_6_0 or var_6_0:isEnd() then
		return
	end

	local var_6_1 = _.flatten(var_6_0:getConfig("config_data"))
	local var_6_2 = getProxy(TaskProxy)
	local var_6_3
	local var_6_4 = false

	for iter_6_0 = #var_6_1, 1, -1 do
		local var_6_5 = var_6_2:getTaskById(var_6_1[iter_6_0]) or var_6_2:getFinishTaskById(var_6_1[iter_6_0])

		if var_6_5 then
			var_6_3 = var_6_5

			if iter_6_0 == #var_6_1 then
				var_6_4 = true
			end

			break
		end
	end

	return var_6_3, var_6_4
end

return OutPostPtPage

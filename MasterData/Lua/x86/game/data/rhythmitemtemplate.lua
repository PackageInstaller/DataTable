DormRhythmItemTemplate = class("DormRhythmItemTemplate")

function DormRhythmItemTemplate:Ctor(arg_1_1, arg_1_2, arg_1_3)
	if arg_1_1 then
		self.go = Object.Instantiate(arg_1_1.itemGo, arg_1_1.parentTrs)
		self.trs = self.go.transform

		self.trs:SetAsFirstSibling()

		self.parentTrs = arg_1_1.parentTrs
		self.index = arg_1_2.index
		self.controller = ControllerUtil.GetController(self.trs, "state")
		self.type = arg_1_2.type

		if self.type == 1 then
			self.controller:SetSelectedState("left")
		elseif self.type == 2 then
			self.controller:SetSelectedState("right")
		end

		self.totalNum = arg_1_2.totalNum

		self:SetInitialPosition()

		self.effectTrs = self.trs:Find("effect_glow").gameObject:GetComponent("RectTransform")

		local var_1_0, var_1_1 = DormRhythmGameData:GetDeterLength()
		local var_1_2 = math.random(var_1_0[1], var_1_0[2]) * 10

		self.rectTransform = self.go:GetComponent("RectTransform")
		self.rectTransform.sizeDelta = Vector2(var_1_2, self.trs.rect.height)
		self.effectTrs.localScale = Vector3((var_1_2 + 40) / 140, 1, 1)
		self.effectController = ControllerUtil.GetController(self.trs, "effect")
		self.stageCfg = arg_1_3
	else
		print("传入对象数据错误")
	end
end

function DormRhythmItemTemplate:Tick()
	if self.go then
		self:UpdatePos()
	end
end

function DormRhythmItemTemplate:SetInitialPosition()
	if self.trs then
		self.trs.localPosition = Vector3(self.parentTrs.rect.width / 2, 0, 0)
	end
end

function DormRhythmItemTemplate:UpdatePos()
	if self.trs then
		self.trs.localPosition = Vector3.New(self.trs.localPosition.x - DormRhythmGameData:GetGameSpeed(), self.trs.localPosition.y, 0)

		if self.trs.localPosition.x <= -self.parentTrs.rect.width / 2 then
			DormRhythmGameData:DisPoseItem(self.index)

			return
		end

		if self.trs.localPosition.x < 0 - DormRhythmGameData:GetJudgeWidth() / 2 and not self.hasCheck then
			self.hasCheck = true

			local var_4_0 = self:IsLast()

			if not self.hasHit then
				DormRhythmGameData:UpdateBatterNum(false, var_4_0)
			end

			if var_4_0 then
				manager.notify:Invoke(BREAK_GAME_LAST_SUCCESS)
			end
		end
	end
end

function DormRhythmItemTemplate:IsLast()
	return self.totalNum == self.stageCfg[DormRhythmGameData:GetLevelData().levelID].total_check
end

function DormRhythmItemTemplate:CheckHit(arg_6_1)
	if self.trs then
		if self.trs.localPosition.x >= arg_6_1.judgeWidth / 2 and self.trs.localPosition.x - self.trs.rect.width <= -arg_6_1.judgeWidth / 2 then
			if arg_6_1.buttonType ~= self.type then
				return false, true
			else
				if not self.hasHit then
					self.effectController:SetSelectedState("none")

					if self.type == DormConst.DORM_RHYTHM_BUTTON_TYPE.left then
						self.effectController:SetSelectedState("blue")
					else
						self.effectController:SetSelectedState("red")
					end
				end

				return true, true
			end
		end

		return false
	end
end

function DormRhythmItemTemplate:Dispose()
	Object.Destroy(self.go)

	self.go = nil
	self.trs = nil
end

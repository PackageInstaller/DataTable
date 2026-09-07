pg = pg or {}
pg.ChangeSkinMgr = singletonClass("ChangeSkinMgr")

local var_0_0 = 1
local var_0_1 = 2
local var_0_2 = 3
local var_0_3 = 4

function pg.ChangeSkinMgr:Init(arg_1_1)
	self._go = nil
	self._spineContent = nil
	self._mvContent = nil
	self._live2dContent = nil
	self._spineUI = nil
	self._loadObject = nil
	self._loadObjectName = nil

	self:initUI(arg_1_1)

	return
end

function pg.ChangeSkinMgr:initUI(arg_2_1)
	if self._go == nil then
		PoolMgr.GetInstance():GetUI("ChangeSkinUI", true, function(arg_3_0)
			self._go = arg_3_0

			self._go:SetActive(false)
			self._go.transform:SetParent(GameObject.Find("OverlayCamera/Overlay/UITop").transform, false)

			self._spineContent = findTF(self._go, "ad/spine")
			self._mvContent = findTF(self._go, "ad/mv")
			self._live2dContent = findTF(self._go, "ad/live2d")
			self._animatorContent = findTF(self._go, "ad/animator")

			arg_2_1()

			return
		end)
	end

	return
end

function pg.ChangeSkinMgr.preloadChangeAction(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ShipSkin.GetChangeSkinAction(arg_4_1)

	if var_4_0 and var_4_0 ~= "" then
		arg_4_0._isloading = true

		local var_4_1 = "changeskin/" .. var_4_0

		PoolMgr.GetInstance():GetPrefab("changeskin/" .. var_4_0, "", true, function(arg_5_0)
			if var_4_1 then
				PoolMgr.GetInstance():ReturnPrefab(var_4_1, "", arg_5_0, false)
			end

			if arg_4_2 then
				arg_4_2()
			end

			arg_4_0._isloading = false

			return
		end)
	elseif arg_4_2 then
		arg_4_2()
	end

	return
end

function pg.ChangeSkinMgr:isAble()
	return not self._isloading and not self._inPlaying
end

function pg.ChangeSkinMgr:play(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if self._inPlaying then
		return
	end

	self._inPlaying = true
	self.changeIndex = ShipSkin.GetChangeSkinIndex(arg_7_1)
	self.changeState = ShipSkin.GetChangeSkinState(arg_7_1)
	self.changAction = ShipSkin.GetChangeSkinAction(arg_7_1)
	self.delayIn = ShipSkin.GetChangeSkinCustomDataId(arg_7_1, "delay_in")
	self.finishDelay = ShipSkin.GetChangeSkinCustomDataId(arg_7_1, "finish_delay")

	if not self.finishDelay or self.finishDelay == "" or self.finishDelay <= 0 then
		self.finishDelay = 0.5
	end

	if self.changeState == var_0_0 then
		self._loadObjectName = "changeskin/" .. self.changAction

		PoolMgr.GetInstance():GetPrefab(self._loadObjectName, "", true, function(arg_8_0)
			self._go:SetActive(true)

			self._loadObject = arg_8_0
			self._spineUI = tf(arg_8_0)

			self._spineUI:SetParent(self._spineContent, false)
			setActive(self._spineUI, true)

			self._spineAnimUI = GetComponent(findTF(self._spineUI, "ad/spine"), typeof(SpineAnimUI))

			self._spineAnimUI:SetAction("change_" .. self.changeIndex, 0)
			self._spineAnimUI:SetActionCallBack(function(arg_9_0)
				if arg_9_0 == "action" then
					if arg_7_2 then
						arg_7_2()
					end
				elseif arg_9_0 == "finish" then
					if arg_7_3 then
						arg_7_3()
					end

					self:finish(arg_7_4)
				else
					print("触发音效" .. arg_9_0)
					pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. arg_9_0)
				end

				return
			end)

			return
		end)
	elseif self.changeState == var_0_1 then
		-- block empty
	elseif self.changeState == var_0_2 then
		-- block empty
	elseif self.changeState == var_0_3 then
		self._loadObjectName = self.changAction and #self.changAction > 0 and "changeskin/" .. self.changAction or "changeskin/changeempty"

		PoolMgr.GetInstance():GetPrefab(self._loadObjectName, "", true, function(arg_10_0)
			self._go:SetActive(true)

			self._loadObject = arg_10_0
			self._aniamtorTf = tf(arg_10_0)

			self._aniamtorTf:SetParent(self._spineContent, false)
			setActive(self._aniamtorTf, true)

			self._animatorCom = GetComponent(findTF(self._aniamtorTf, "ad/animator"), typeof(Animator))
			self._dftEventCom = GetComponent(findTF(self._aniamtorTf, "ad/animator"), typeof(DftAniEvent))

			self._animatorCom:SetTrigger("change_" .. self.changeIndex)
			self._dftEventCom:SetTriggerEvent(function(arg_11_0)
				if arg_7_2 then
					arg_7_2()
				end

				return
			end)
			self._dftEventCom:SetEndEvent(function(arg_12_0)
				if arg_7_3 then
					arg_7_3()
				end

				if self.delayIn then
					self:finish(nil)
					onDelayTick(function()
						if arg_7_4 then
							arg_7_4()
						end

						return
					end, self.delayIn)
				else
					self:finish(arg_7_4)
				end

				return
			end)
			self:localizationUI(self._aniamtorTf, self.changAction, self.changeIndex)

			return
		end)
	end

	return
end

function pg.ChangeSkinMgr.localizationUI(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 == "changeAsmr" then
		setText(findTF(arg_14_1, "ad/animator/desc"), i18n("change_skin_asmr_desc_" .. arg_14_3))
	end

	return
end

function pg.ChangeSkinMgr:finish(arg_15_1)
	if LeanTween.isTweening(self._go) then
		LeanTween.cancel(self._go)
	end

	LeanTween.delayedCall(self.finishDelay, System.Action(function()
		if self._spineAnimUI then
			self._spineAnimUI:SetActionCallBack(nil)

			self._spineAnimUI = nil
		end

		if self._loadObject then
			PoolMgr.GetInstance():ReturnPrefab(self._loadObjectName, "", self._loadObject, true)
		end

		self._inPlaying = false

		if self._go then
			self._go:SetActive(false)
		end

		if arg_15_1 then
			arg_15_1()
		end

		return
	end))

	return
end

return

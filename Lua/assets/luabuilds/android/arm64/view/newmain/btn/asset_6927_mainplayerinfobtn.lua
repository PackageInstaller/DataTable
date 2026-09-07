local MainPlayerInfoBtn = class("MainPlayerInfoBtn", import(".MainBaseBtn"))

function MainPlayerInfoBtn:Ctor(arg_1_1, arg_1_2)
	MainPlayerInfoBtn.super.Ctor(self, arg_1_1, arg_1_2)

	self.playerInfoBtn = findTF(self._tf, "iconBack")
	self.playerNameTxt = findTF(self._tf, "name"):GetComponent(typeof(Text))
	self.playerLevelTxt = findTF(self._tf, "level"):GetComponent(typeof(Text))
	self.expSlider = findTF(self._tf, "exp"):GetComponent(typeof(Slider))

	return
end

function MainPlayerInfoBtn:GetTarget()
	return self.playerInfoBtn
end

function MainPlayerInfoBtn:OnClick()
	self:emit(NewMainMediator.GO_SCENE, SCENE.PLAYER_INFO)

	return
end

function MainPlayerInfoBtn:Flush(arg_4_1)
	self:UpdateLevelAndName()
	self:UpdateExp()

	if not arg_4_1 then
		self.playerNameTxt.enabled = false
		self.playerNameTxt.enabled = true
		self.playerLevelTxt.enabled = false
		self.playerLevelTxt.enabled = true
	end

	return
end

function MainPlayerInfoBtn:UpdateLevelAndName()
	local var_5_0 = getProxy(PlayerProxy):getRawData()

	self.playerNameTxt.text = var_5_0.name
	self.playerLevelTxt.text = "LV." .. var_5_0.level

	return
end

function MainPlayerInfoBtn:UpdateExp()
	local var_6_0 = getProxy(PlayerProxy):getRawData()

	self.expSlider.value = var_6_0.level == var_6_0:getMaxLevel() and 1 or var_6_0.exp / getConfigFromLevel1(pg.user_level, var_6_0.level).exp_interval

	return
end

return MainPlayerInfoBtn

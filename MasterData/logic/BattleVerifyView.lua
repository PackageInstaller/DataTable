-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleVerifyView.lua

module("logic.extensions.battle.view.BattleVerifyView", package.seeall)

local BattleVerifyView = class("BattleVerifyView", ViewComponent)

function BattleVerifyView:buildUI()
	self._main = self:getGo("main")
	self._btnClickCustomInput = UICustomInput.Get(self:getGo("main/btnClick"))
	self._txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "main/tip/txtVerifyEffect")
	self._imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "main/btnClick")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "main/txtLv")
	self._tip = self:getGo("main/tip")
end

function BattleVerifyView:bindEvents()
	self._btnClickCustomInput:AddListener(self._onClickExplain, self)
end

function BattleVerifyView:unbindEvents()
	self._btnClickCustomInput:RemoveListener()
end

function BattleVerifyView:onEnter()
	goutil.setActive(self._tip, false)
	goutil.setActive(self._main, false)

	local battleSettlementType = self:getFirstParam()

	if battleSettlementType == BattleSettlementModel.Enum.Legend then
		local planId = LegendModel.instance:getVerifyPlanId()
		local isShow = planId > 0
		local verifyCfg

		if isShow then
			verifyCfg = PetverifyController.instance:getCurrPlanBuff(planId)
			isShow = isShow and self:_setIcon(planId, verifyCfg)
		end

		goutil.setActive(self._main, isShow)

		if verifyCfg then
			local color = "60ee85"
			local verifyName = string.format(verifyCfg.name, color)
			local verifyDes = string.format(verifyCfg.des, color)

			self._txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)
			self._txtLv.text = string.format("Lv.%d", verifyCfg.level)
		else
			self._txtVerifyEffect.text = "未激活鼓舞"
			self._txtLv.text = "Lv.0"
		end
	end
end

function BattleVerifyView:onExit()
	self:_removeIcon()
end

function BattleVerifyView:_setIcon(planId, verifyCfg)
	local bossBuff, iconName

	if verifyCfg then
		bossBuff = verifyCfg.buffId
	else
		local plans = PetVerifyBuffConfig.instance:getBuffListById(planId)

		if not plans then
			return false
		end

		bossBuff = plans[1].buffId
	end

	local tempStr = string.split(bossBuff, ":")
	local buffId = tempStr[1]
	local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

	self._imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))

	return true
end

function BattleVerifyView:_removeIcon()
	self._imgEffect:ClearImage()
end

function BattleVerifyView:_onClickExplain(hover)
	if hover then
		if not self._tip.activeSelf then
			self._tip:SetActive(true)
		else
			self._tip:SetActive(false)
		end
	elseif self._tip.activeSelf then
		self._tip:SetActive(false)
	end
end

return BattleVerifyView

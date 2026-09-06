-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/view/AssistUpgradeView.lua

module("logic.extensions.petassist.view.AssistUpgradeView", package.seeall)

local AssistUpgradeView = class("AssistUpgradeView", ViewComponent)

function AssistUpgradeView:ctor()
	AssistUpgradeView.super.ctor(self)

	self.teamAttrsList = nil
end

function AssistUpgradeView:buildUI()
	AssistUpgradeView.super.buildUI(self)

	self.viewBoxGo = self:getGo("viewBoxGo")
	self.titleIma = self:getGo("titleIma"):GetComponent("UIImageSpriteChange")
	self.assistGo = self:getGo("assistGo")
	self.assistAttrItem = self:getGo("assistAttrItem")
	self.teamAttrTran = self:getGo("teamAttrTran").transform
	self.teamAttrItem = self:getGo("teamAttrItem")

	self.assistGo:SetActive(false)
	self.assistAttrItem:SetActive(false)
	self.teamAttrItem:SetActive(false)
end

function AssistUpgradeView:bindEvents()
	AssistUpgradeView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):AddClickListener(self.close, self)
end

function AssistUpgradeView:unbindEvents()
	AssistUpgradeView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):RemoveClickListener()
end

function AssistUpgradeView:onEnter()
	local param = self._viewPresentor._openParam

	if param == nil or param[1] == nil then
		printError("未传入参数！！！")

		return
	end

	if self.teamAttrsList and #self.teamAttrsList > 0 then
		for i = 1, #self.teamAttrsList do
			if self.teamAttrsList[i] and self.teamAttrsList[i].itemGo then
				self.teamAttrsList[i].itemGo:SetActive(false)
			end
		end
	end

	if checknumber(param[1]) == 1 then
		self.teamAttrsList = self.teamAttrsList or {}

		if param[2] == nil then
			printError("未传入变更集！！！")
		else
			self:showPetTeamOneKeyUpgrade(param[2])
		end
	elseif checknumber(param[1]) == 2 then
		self.teamAttrsList = self.teamAttrsList or {}

		if param[2] == nil or param[2].teamType == nil then
			printError("未传入战队类型参数！！！")
			self:ShowPetTeamUpgrade({
				teamType = 1
			})
		else
			self:ShowPetTeamUpgrade(param[2])
		end
	end
end

function AssistUpgradeView:showPetTeamOneKeyUpgrade(changeInfo)
	self.titleIma:SetState(0)

	local attrsList = PetAssistModel.instance:GetTeamChangeAttrsByChangeInfo(changeInfo)

	if attrsList == nil or #attrsList == 0 then
		return
	end

	for i = 1, #attrsList do
		if self.teamAttrsList[i] == nil then
			local attrGo = UnityEngine.GameObject.Instantiate(self.teamAttrItem, self.teamAttrTran)

			self.teamAttrsList[i] = {
				itemGo = attrGo,
				nameTxt = goutil.findChildTextComponent(attrGo, "attrNameTxt"),
				oldTxt = goutil.findChildTextComponent(attrGo, "oldCountTxt"),
				newTxt = goutil.findChildTextComponent(attrGo, "newCountTxt")
			}
		end

		self.teamAttrsList[i].itemGo:SetActive(true)

		self.teamAttrsList[i].nameTxt.text = attrsList[i].name
		self.teamAttrsList[i].oldTxt.text = tostring(attrsList[i].oldCount)
		self.teamAttrsList[i].newTxt.text = string.format("<color=#%s>%s</color>", (attrsList[i].oldCount > attrsList[i].newCount or nil) and "FF0000FF", attrsList[i].newCount)
	end
end

function AssistUpgradeView:ShowPetTeamUpgrade(addInfo)
	if addInfo == nil or addInfo.teamType == nil then
		return
	end

	self.assistGo:SetActive(false)

	local attrsList

	if checknumber(addInfo.petId) > 0 then
		self.titleIma:SetState(1)

		attrsList = PetAssistModel.instance:GetTeamChangeAttrs(addInfo.teamType, addInfo)
	else
		self.titleIma:SetState(0)

		attrsList = PetAssistModel.instance:GetTeamChangeAttrs(addInfo.teamType)
	end

	if attrsList == nil or #attrsList == 0 then
		return
	end

	for i = 1, #attrsList do
		if self.teamAttrsList[i] == nil then
			local attrGo = UnityEngine.GameObject.Instantiate(self.teamAttrItem, self.teamAttrTran)

			self.teamAttrsList[i] = {
				itemGo = attrGo,
				nameTxt = goutil.findChildTextComponent(attrGo, "attrNameTxt"),
				oldTxt = goutil.findChildTextComponent(attrGo, "oldCountTxt"),
				newTxt = goutil.findChildTextComponent(attrGo, "newCountTxt")
			}
		end

		self.teamAttrsList[i].itemGo:SetActive(true)

		self.teamAttrsList[i].nameTxt.text = attrsList[i].name
		self.teamAttrsList[i].oldTxt.text = tostring(attrsList[i].oldCount)
		self.teamAttrsList[i].newTxt.text = string.format("<color=#%s>%s</color>", (attrsList[i].oldCount > attrsList[i].newCount or nil) and "FF0000FF", attrsList[i].newCount)
	end
end

function AssistUpgradeView:onExit()
	removetimer(self.PlayStarEffect, self)
end

function AssistUpgradeView:destroyUI()
	AssistUpgradeView.super.destroyUI(self)

	for _, item in pairs(self.teamAttrsList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.teamAttrsList = nil
end

return AssistUpgradeView

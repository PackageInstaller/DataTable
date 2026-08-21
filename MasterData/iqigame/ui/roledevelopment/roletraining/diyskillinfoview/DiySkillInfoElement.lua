-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\DiySkillInfoView\\DiySkillInfoElement.lua

local DiySkillDetailsView = require("IQIGame.UI.DiySkill.DetailsView.DiySkillDetailsView")
local equipReplacePanelClass = require("IQIGame/UI/Equip/EquipReplacePanel")
local DiySkillInfoElement = {
	isContrast = false
}

function DiySkillInfoElement.New(view, contrastEvent, cancelContrastEvent)
	local obj = Clone(DiySkillInfoElement)

	obj:__Init(view, contrastEvent, cancelContrastEvent)

	return obj
end

function DiySkillInfoElement:__Init(view, contrastEvent, cancelContrastEvent)
	self.gameObject = view
	self.contrastEvent = contrastEvent
	self.cancelContrastEvent = cancelContrastEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UGUIUtil.SetText(self.intensifyText, DiySkillStrengthenUIApi:GetIntensityButtonText())
	UGUIUtil.SetText(self.dischargeText, DiySkillStrengthenUIApi:GetDischargeBtnText())

	self.detailElement = DiySkillDetailsView.New(self.SkillInfoScroll)
	self.replacePanel = equipReplacePanelClass.New(self.equipReplacePanel, self)

	self.replacePanel:Hide()
	self:__SetStaticText()
	self:__PrepareEventProxy()
	self:__AddListeners()
end

function DiySkillInfoElement:__SetStaticText()
	return
end

function DiySkillInfoElement:__PrepareEventProxy()
	function self.__OnDischargeButtonClickEventProxy()
		self:__OnDischargeButtonClickEventHandler()
	end

	function self.__OnReplaceButtonClickEventProxy()
		self:__OnReplaceButtonClickEventHandler()
	end

	function self.__OnIntensityButtonClickEventProxy()
		self:__OnIntensityButtonClickEventHandler()
	end

	function self.__OnContrastButtonClickEventProxy()
		if self.isContrast then
			self.isContrast = false

			self.cancelContrastEvent()
		else
			self.isContrast = true

			self.contrastEvent(self.curSkillData)
		end

		self:UpdateContrastState(true, self.isContrast)
	end

	function self.delegateOnClickOpenBagBtn()
		EventDispatcher.Dispatch(EventID.ShowDiyBagEvent, self.curSkillPos, self.curHeroCid)
	end

	function self.delegateOnClickButtonEquip()
		EventDispatcher.Dispatch(EventID.ShowDiyBagEvent, self.curSkillPos, self.curHeroCid)
	end
end

function DiySkillInfoElement:__AddListeners()
	self.dischargeButton:GetComponent("Button").onClick:AddListener(self.__OnDischargeButtonClickEventProxy)
	self.ReplaceButton:GetComponent("Button").onClick:AddListener(self.__OnReplaceButtonClickEventProxy)
	self.IntensityButton:GetComponent("Button").onClick:AddListener(self.__OnIntensityButtonClickEventProxy)
	self.ContrastButton:GetComponent("Button").onClick:AddListener(self.__OnContrastButtonClickEventProxy)
	self.openBagBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickOpenBagBtn)
	self.buttonEquip:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonEquip)
end

function DiySkillInfoElement:__RemoveListeners()
	self.dischargeButton:GetComponent("Button").onClick:RemoveListener(self.__OnDischargeButtonClickEventProxy)
	self.ReplaceButton:GetComponent("Button").onClick:RemoveListener(self.__OnReplaceButtonClickEventProxy)
	self.IntensityButton:GetComponent("Button").onClick:RemoveListener(self.__OnIntensityButtonClickEventProxy)
	self.ContrastButton:GetComponent("Button").onClick:RemoveListener(self.__OnContrastButtonClickEventProxy)
	self.openBagBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickOpenBagBtn)
	self.buttonEquip:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonEquip)
end

function DiySkillInfoElement:Dispose()
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.curSkillData = nil
end

function DiySkillInfoElement:Show(heroCid, skillPos, skillData, isContrast, isLimit)
	self.curSkillData = skillData

	if not self.curSkillData then
		self:ShowEmpty()

		return
	end

	self.curHeroCid = heroCid
	self.curSkillPos = skillPos

	LuaUtility.SetGameObjectShow(self.gameObject, true)
	LuaUtility.SetGameObjectShow(self.emptySkillInfo, false)
	LuaUtility.SetGameObjectShow(self.EquippedTipsParent, true)
	LuaUtility.SetGameObjectShow(self.BottomBtnParent, true)

	if isContrast then
		self.detailElement:ShowCompare(heroCid, skillPos, self.curSkillData)
	else
		self.detailElement:Show(self.curSkillData)
	end

	self:__RefreshWareState(self.curSkillData)
	self:__RefreshBtnState()

	if not self.DIYBagParent.activeSelf then
		LuaUtility.SetGameObjectShow(self.dischargeButton, false)
		LuaUtility.SetGameObjectShow(self.openBagBtn, true)
		LuaUtility.SetGameObjectShow(self.EquippedTipsParent, false)
	else
		LuaUtility.SetGameObjectShow(self.openBagBtn, false)
	end

	self.ReplaceButton:GetComponent("Button").interactable = not isLimit
end

function DiySkillInfoElement:ShowEmpty()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	LuaUtility.SetGameObjectShow(self.emptySkillInfo, true)
	LuaUtility.SetGameObjectShow(self.EquippedTipsParent, false)
	LuaUtility.SetGameObjectShow(self.BottomBtnParent, false)
	self.detailElement:Hide()
end

function DiySkillInfoElement:Hide()
	self.gameObject:SetActive(false)
end

function DiySkillInfoElement:__RefreshWareState(skillData)
	local needShow = skillData.heroCid ~= 0

	LuaUtility.SetGameObjectShow(self.EquippedTipsParent, needShow)

	if not needShow then
		return
	end

	local headPath = SkinModule.GetHeroCurrentSkinImgPath(skillData.heroCid, Constant.SkinImageType.DetailsHeadIcon)

	AssetUtil.LoadImage_SetNativeSize(self, headPath, self.equippedHeroHeadImg)
	UGUIUtil.SetText(self.equippedTipsText, DiySkillStrengthenUIApi:GetWareStateText(CfgHeroTable[skillData.heroCid].Name))
end

function DiySkillInfoElement:__OnDischargeButtonClickEventHandler()
	RoleDevelopmentModule.RoleSkillUnload(self.curHeroCid, self.curSkillPos)
end

function DiySkillInfoElement:__OnReplaceButtonClickEventHandler()
	if not self.curSkillData.heroCid or self.curSkillData.heroCid == 0 then
		RoleDevelopmentModule.RoleSkillWear(self.curHeroCid, self.curSkillPos, self.curSkillData.id)

		return
	end

	self.replacePanel:Refresh(Constant.EquipReplacePanelType.DiySkill, self.curHeroCid, self.curSkillData.heroCid, function()
		RoleDevelopmentModule.RoleSkillWear(self.curHeroCid, self.curSkillPos, self.curSkillData.id)
	end)
	self.replacePanel:Show()
end

function DiySkillInfoElement:__OnIntensityButtonClickEventHandler()
	UIModule.Open(Constant.UIControllerName.DiySkillStrengthenUI, Constant.UILayer.UI, {
		tabIndex = 2,
		skillData = self.curSkillData
	})
end

function DiySkillInfoElement:__RefreshBtnState()
	local skill = RoleDevelopmentModule.GetCurHeroSkill(self.curHeroCid)[self.curSkillPos]
	local isEmpty = skill == nil

	if isEmpty then
		UGUIUtil.SetText(self.replaceText, DiySkillStrengthenUIApi:GetEquipBtnText(true))
		self.dischargeButton:SetActive(false)
		self.ReplaceButton:SetActive(not RoleDevelopmentModule.GetSkillHasEquipedOnHero(self.curHeroCid, self.curSkillData))
		self:UpdateContrastState(false)
	elseif skill.id == self.curSkillData.id then
		self.dischargeButton:SetActive(true)
		self.ReplaceButton:SetActive(false)
		self:UpdateContrastState(self.isContrast, self.isContrast)
	else
		self.dischargeButton:SetActive(false)
		UGUIUtil.SetText(self.replaceText, DiySkillStrengthenUIApi:GetEquipBtnText(false))
		self.ReplaceButton:SetActive(not RoleDevelopmentModule.GetSkillHasEquipedOnHero(self.curHeroCid, self.curSkillData) or RoleDevelopmentModule.GetHeroDiySkillPosIsSameSkill(self.curHeroCid, self.curSkillData, self.curSkillPos))
		self:UpdateContrastState(true, self.isContrast)
	end
end

function DiySkillInfoElement:UpdateContrastState(active, isContrast)
	if not active then
		return
	end

	self.commonState:SetActive(not isContrast)
	self.packUpState:SetActive(isContrast)
end

return DiySkillInfoElement

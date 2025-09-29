-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseWorkerSelectRoleCell.lua

module("logic.extensions.houseworker.view.HouseWorkerSelectRoleCell", package.seeall)

local M = class("HouseWorkerSelectRoleCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._selectBtn = ButtonAdapter.Get(goutil.findChild(self._go, "click"))

	self._selectBtn:AddClickListener(self._onClickSelect, self)

	self._emptyGo = goutil.findChild(self._go, "btnAdd")
	self._heroPanelGo = goutil.findChild(self._go, "Content")
	self._heroIcon = goutil.findChildImageComponent(self._go, "Content/roleMask/imgRole")

	local attr1Img = goutil.findChildImageComponent(self._go, "Content/imgIcon1")
	local attr2Img = goutil.findChildImageComponent(self._go, "Content/imgIcon2")

	self._attrGroup = {}

	table.insert(self._attrGroup, attr1Img)
	table.insert(self._attrGroup, attr2Img)

	self._nameTxt = goutil.findChildTextComponent(self._go, "Content/txtName")
	self._moodIconGo = goutil.findChild(self._go, "Content/mood")
	self._warningGo = goutil.findChild(self._go, "Content/warning")
	self._buffPanelGo = goutil.findChild(self._go, "Content/buffList")
	self._workTypeImg = goutil.findChildImageComponent(self._go, "Content/workType/imgTtpe")
	self._workTypeTxt = goutil.findChildTextComponent(self._go, "Content/workType/txtType")

	goutil.setActive(self._workTypeTxt.gameObject, false)

	self._imgSelectGo = goutil.findChild(self._go, "Content/imgSelect")
	self._selectIndexGo = goutil.findChild(self._go, "Content/count")
	self._selectIndexTxt = goutil.findChildTextComponent(self._go, "Content/count/txtCount")
	self._moodCell = Astral.LuaComponentContainer.Add(self._moodIconGo, HouseHeroMoodCell)
	self._poachingRoot = goutil.findChild(self._go, "Content/poaching")
	self._notPoachingGo = goutil.findChild(self._go, "Content/poaching/notPoaching")
	self._poachingBtn = ButtonAdapter.Get(goutil.findChild(self._go, "Content/poaching/btnPoaching"))
	self._poachingBtnText = goutil.findChildTextComponent(self._go, "Content/poaching/btnPoaching/Text")

	self._poachingBtn:AddClickListener(self._onClickPoaching, self)
	goutil.setActive(self._emptyGo, false)
	goutil.setActive(self._buffPanelGo, false)
	goutil.setActive(self._heroPanelGo, true)

	for index, value in ipairs(self._attrGroup) do
		goutil.setActive(value.gameObject, false)
	end

	self._goNotSettled = goutil.findChild(self._go, "Content/warning_notSettled")
	self._goSettledOther = goutil.findChild(self._go, "Content/warning_settledOther")
end

function M:setData(heroMo)
	self._heroMo = heroMo
	self._heroId = heroMo:getId()

	self:refreshCell()
end

function M:setSelectIndex(index)
	if index and index > 0 then
		goutil.setActive(self._imgSelectGo, true)
		goutil.setActive(self._selectIndexGo, true)

		self._selectIndexTxt.text = index
	else
		goutil.setActive(self._imgSelectGo, false)
		goutil.setActive(self._selectIndexGo, false)
	end
end

function M:setClickCallBack(clickCallBackFunc, clickCallBackHandle)
	self._clickCallBackFunc = clickCallBackFunc
	self._clickCallBackHandle = clickCallBackHandle
end

function M:refreshCell()
	self._jobData = HouseWorkerModel.instance:getScheduleByHeroId(self._heroId)

	if self._jobData then
		local jobConfig = HouseWorkerModel.instance:getJobConfigByJobCode(self._jobData.job)

		IconLoader.setSprite(self._workTypeImg, IconType.DynSpriteAtlas_Room, HouseEnum.RoomType2SignRes[jobConfig.roomType])
		goutil.setActive(self._workTypeImg.gameObject, true)
	else
		goutil.setActive(self._workTypeImg.gameObject, false)
	end

	local characterCO = self._heroMo:getCharacterCo()
	local modelCO = self._heroMo:getModelCo()

	self._nameTxt.text = self._heroMo:getName()

	local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(self._heroId)

	if heroFeatureMo then
		self._moodCell:updateMood(heroFeatureMo:getMood())
	end

	IconLoader.setSprite(self._heroIcon, IconType.RoleCard, modelCO.halfIconName)

	local skillList = HeroHouseFeatureModel.instance:getFeatureSkillByHeroId(self._heroId)

	for i, v in ipairs(self._attrGroup) do
		local show = i <= #skillList

		if show then
			local skill = skillList[i]

			if skill and skill.isUnlock then
				local itemImg = self._attrGroup[i]

				goutil.setActive(itemImg.gameObject, true)

				local skillCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseSkill, skill.skillId)

				if skillCO then
					IconLoader.setSprite(itemImg, IconType.DynSpriteAtlas_Room, string.format("room_peculiarity_%s", skillCO.icon))
				else
					printError(string.format("hero[%s],无法从[%s]找到[%s]的配置", self._heroId, ConfigName.HouseSkill, skill.skillId))
				end
			else
				show = false
			end
		end

		goutil.setActive(v.gameObject, show)
	end

	self._eduState = HeroHouseFeatureModel.instance:getHeroThoughtEduState(self._heroId)

	goutil.setActive(self._selectBtn.gameObject, self._eduState == HouseMainEnum.HeroThoughtEduState.CanWork)
	goutil.setActive(self._poachingRoot, self._eduState ~= HouseMainEnum.HeroThoughtEduState.CanWork)
	goutil.setActive(self._notPoachingGo, self._eduState == HouseMainEnum.HeroThoughtEduState.RefuseWork)
	goutil.setActive(self._poachingBtn.gameObject, self._eduState ~= HouseMainEnum.HeroThoughtEduState.CanWork)

	self._poachingBtnText.text = self._eduState == HouseMainEnum.HeroThoughtEduState.RefuseWork and lang("tip_see_why") or lang("tip_poach")
end

function M:setNotSettled(isNotSettled)
	goutil.setActive(self._goNotSettled, isNotSettled)
end

function M:setSettledOther(isSettledOther)
	goutil.setActive(self._goSettledOther, isSettledOther)
end

function M:OnDestroy()
	self._selectBtn:RemoveClickListener()
	self._poachingBtn:RemoveClickListener()
end

function M:_onClickSelect()
	if self._eduState ~= HouseMainEnum.HeroThoughtEduState.CanWork then
		printWarn(string.format("角色[%s]处于不可进驻状态[%s]", self._heroId, self._eduState))

		return
	end

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandle, self._heroId)
	end
end

function M:_onClickPoaching()
	if self._eduState == HouseMainEnum.HeroThoughtEduState.CanEdu then
		ToolTipsMgr.showPoachingPayTips(self._heroId)

		return
	elseif self._eduState == HouseMainEnum.HeroThoughtEduState.RefuseWork then
		local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(self._heroId)
		local formula = heroFeatureMo:getThoughtEduFormula()
		local cfgThoughtEdu = HouseConfig.instance:getConfigByKey(ConfigName.HouseThoughtEdu, formula)
		local reasonStr = cfgThoughtEdu and cfgThoughtEdu.textList or ""
		local dialog = Dialog.showMessage(lang("tip_not_poach_why"), reasonStr)
	end
end

return M

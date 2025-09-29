-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/MaterialDungeonTabCellComp.lua

module("logic.extensions.dungeon.view.materialdungeon.MaterialDungeonTabCellComp", package.seeall)

local M = class("MaterialDungeonTabCellComp", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._rectTrContent = registry:findUIElement("resource_tab_-723083097", UIComponentType.RectTransform)
	self._goNormal = registry:findUIElement("resource_tab_-1474926255")
	self._goSelect = registry:findUIElement("resource_tab_-4797556")
	self._goLock = registry:findUIElement("resource_tab_-509321316")
	self._btnSelect = registry:findUIElement("resource_tab_1203585366", UIComponentType.ButtonAdapter)

	self._btnSelect:AddClickListener(self._clickSelect, self)

	self._icon1Img = registry:findUIElement("resource_tab_-1713108302", UIComponentType.Image)
	self._imgIconCurrency = registry:findUIElement("resource_tab_467904973", UIComponentType.Image)
	self._imgCareerSign = registry:findUIElement("career_1390243743", UIComponentType.Image)
	self._txtName1 = registry:findUIElement("resource_tab_1716329683", UIComponentType.Text)
	self._txtName2 = registry:findUIElement("resource_tab_-1228951121", UIComponentType.Text)
	self._txtName3 = registry:findUIElement("resource_tab_2060746809", UIComponentType.Text)

	local btn_skill_bonusGo = goutil.findChild(self._go, "content/btn_skill_bonus")

	goutil.setActive(goutil.findChild(btn_skill_bonusGo, "btnDown"), true)

	self._btnSkillUp = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnUp"))
	self._btnSkillDown = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnDown"))

	goutil.setActive(self._btnSkillUp.gameObject, false)
	goutil.setActive(self._btnSkillDown.gameObject, false)
	self._btnSkillUp:AddClickListener(self._onOpenSkillSmallTips, self)
end

function M:getTransform()
	return self._trs
end

function M:_clickSelect()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.MaterialDungeonChapter1 + self._chapterMo:getChapterId() - 1001, true) then
		return false
	end

	local chapterUnlock = self._chapterMo:getIsChapterUnlock()

	if not chapterUnlock then
		local weekDays = self._chapterMo:getWeekDays()
		local weekStr = ""

		for i, v in ipairs(weekDays or {}) do
			if i == 1 then
				weekStr = string.format("周%s", DungeonEnum.WeekDay[v])
			else
				weekStr = string.format("%s,周%s", weekStr, DungeonEnum.WeekDay[v])
			end
		end

		local hint = string.format(lang("tip_copy_s"), weekStr)

		FloatWordMgr.instance:show(string.format("%s%s%s", self._chapterMo:getName(), hint, lang("tip_open")))

		return
	end

	if self._curSelectTab == self._curIndex then
		return
	end

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex)
	end
end

function M:updateData(data, index)
	self._curIndex = index
	self._chapterMo = data

	self:_refreshView()
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:setSelectTab(selectTab)
	self._curSelectTab = selectTab
end

function M:_refreshView()
	local isSelect = self._curSelectTab == self._curIndex
	local left = isSelect and 20 or 0
	local bottom = self._rectTrContent.offsetMin.y

	self._rectTrContent.offsetMin = Vector2.New(left, bottom)

	local scale = isSelect and 1.05 or 1

	RectTransformUtils.SetScale(self._trs, scale, scale, 1)
	goutil.setActive(self._goSelect, isSelect)
	goutil.setActive(self._goNormal, not isSelect)
	goutil.setActive(self._btnSkillUp.gameObject, self._curIndex == 1 and AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type4))

	local chapterName = self._chapterMo:getName()

	self._txtName1.text = chapterName
	self._txtName2.text = chapterName
	self._txtName3.text = chapterName

	local chapterUnlock = self._chapterMo:getIsChapterUnlock()

	goutil.setActive(self._goLock, not chapterUnlock)

	if not chapterUnlock then
		local systemOpenCode = GameEnum.SystemEnum.MaterialDungeonChapter1 + self._chapterMo:getChapterId() - 1001

		if not SystemOpenFacade.instance:isOpen(systemOpenCode, false) then
			local systemCO = SystemOpenConfig.instance:getSystemOpenCOById(systemOpenCode)

			if systemCO:geUnlockLevel() ~= 0 then
				-- block empty
			end

			if systemCO:getUnlockDuplicateCode() ~= 0 then
				local dungeonMo = DungeonModel.instance:getDungeonMoById(systemCO:getUnlockDuplicateCode())
			end
		else
			local weekDays = self._chapterMo:getWeekDays()
			local weekStr = ""

			for i, v in ipairs(weekDays or {}) do
				if i == 1 then
					weekStr = string.format("周%s", DungeonEnum.WeekDay[v])
				else
					weekStr = string.format("%s,周%s", weekStr, DungeonEnum.WeekDay[v])
				end
			end
		end
	end

	IconLoader.setSprite(self._icon1Img, IconType.DynSpriteAtlas_Material, self._chapterMo:getIconRes1())

	local itemId = self._chapterMo:getIconItem()

	if itemId > 0 then
		local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

		if itemCo then
			IconLoader.setSprite(self._imgIconCurrency, IconType.ItemIcon, itemCo.icon)
		end
	end

	goutil.setActive(self._imgIconCurrency.gameObject, itemId > 0)

	local career = self._chapterMo:getCareer()

	if career > 0 then
		IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CommEnum.Career2Icon[career])
	end

	goutil.setActive(self._imgCareerSign.gameObject, career > 0)
end

function M:OnDestroy()
	self._btnSelect:RemoveClickListener()
	self._btnSkillUp:RemoveClickListener()
end

function M:_onOpenSkillSmallTips()
	local param = {}

	param.obj = self._btnSkillUp.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type4

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

return M

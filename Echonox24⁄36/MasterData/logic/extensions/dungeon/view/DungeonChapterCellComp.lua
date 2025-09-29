-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonChapterCellComp.lua

module("logic.extensions.dungeon.view.DungeonChapterCellComp", package.seeall)

local M = class("DungeonChapterCellComp", CellBaseComponent)
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

	self._contentGo = registry:findUIElement("instance_entrance_item_copy_1823790894")
	self._bgImg = registry:findUIElement("instance_entrance_item_228606474", UIComponentType.ImageBigBG)
	self._progress2Go = registry:findUIElement("instance_entrance_item_765421504")

	goutil.setActive(self._progress2Go, false)

	self._progress1Img = registry:findUIElement("instance_entrance_item_-547501789", UIComponentType.Image)
	self._progress2Img = registry:findUIElement("instance_entrance_item_-1000824366", UIComponentType.Image)
	self._selectPanelGo = registry:findUIElement("instance_entrance_item_copy_-508306884")
	self._lockGo = registry:findUIElement("instance_entrance_item_14020248")
	self._lockTxt = registry:findUIElement("instance_entrance_item_-488175843", UIComponentType.Text)
	self._chapterIndexTxt = registry:findUIElement("instance_entrance_item_copy_553672996", UIComponentType.Text)
	self._chapterNameTxt = registry:findUIElement("instance_entrance_item_copy_801980460", UIComponentType.Text)
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("instance_entrance_item_2118022105"))
	self._normalPosGo = registry:findUIElement("instance_entrance_item_copy_1463130471")
	self._selectPosGo = registry:findUIElement("instance_entrance_item_copy_109380221")
	self._anim = self._go:GetComponent(ComponentType.Animation)

	self._btnClick:AddClickListener(self._clickSelf, self)
end

function M:_clickSelf()
	if not self._isUnlock then
		FloatWordMgr.instance:show(self._lockTips)

		return
	end

	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex)
	end
end

function M:updateData(data, index, curSelectId)
	self._curIndex = index
	self._chapterMoList = data
	self._curSelectChapterId = curSelectId

	self:_refreshView()
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:_updateChapterLockPanel()
	self._lockTips = nil

	local chapterMo = self._chapterMoList[1]
	local chapterCo = chapterMo:getChapterCO()
	local str = ""

	if chapterCo.unlockLv > 0 then
		local color = PlayerModel.instance:getLevel() >= chapterCo.unlockLv and "#1FF0D3" or "999999"

		str = self:connectStr(str, string.format("<color=%s>玩家等级达到%s</color>", color, chapterCo.unlockLv))

		if not (PlayerModel.instance:getLevel() >= chapterCo.unlockLv) then
			self._lockTips = string.format("需要主管等级达到%s", chapterCo.unlockLv)
		end
	end

	if chapterCo.unlockChaperId > 0 then
		local preChapterMo = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(chapterCo.unlockChaperId, 1)
		local color = preChapterMo:getIsChaterPassed() and "#1FF0D3" or "999999"
		local tempStr = string.format("<color=%s>通关主线章节%s</color>", color, chapterCo.unlockChaperId)

		str = self:connectStr(str, tempStr)

		if not self._lockTips and not preChapterMo:getIsChaterPassed() then
			self._lockTips = "需要全部通关上一章节"
		end
	end

	if chapterCo.unlockCondition then
		for i, v in ipairs(chapterCo.unlockCondition) do
			if v.type == "characterLv" then
				local splitStr = string.split(v.value, "_")
				local heroId = tonumber(splitStr[1])
				local level = tonumber(splitStr[2])
				local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)
				local color = heroData and level <= heroData:getLevel() and "#1FF0D3" or "999999"
				local heroCO = CharacterConfig.instance:getCfgInfoByID(heroId)

				str = self:connectStr(str, string.format("<color=%s>%s等级达到%s</color>", color, heroCO.name, level))
			end

			if v.type == "tacitLv" then
				local splitStr = string.split(v.value, "_")
				local heroId = tonumber(splitStr[1])
				local tacitLv = tonumber(splitStr[2])
				local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)
				local color = heroData and tacitLv <= heroData:getTacit() and "#1FF0D3" or "999999"
				local heroCO = CharacterConfig.instance:getCfgInfoByID(heroId)

				str = self:connectStr(str, string.format("<color=%s>%s默契达到%s级</color>", color, heroCO.name, tacitLv))
			end
		end
	end

	self._lockTxt.text = str
	self._isUnlock = chapterMo:getIsChapterUnlock()

	goutil.setActive(self._lockGo, not self._isUnlock)
end

function M:connectStr(str1, str2)
	if str1 ~= "" then
		return string.format("%s\n%s", str1, str2)
	else
		return str2
	end
end

function M:playAnim(intervalTime)
	intervalTime = intervalTime >= 0 and intervalTime or 0

	settimer(intervalTime, self._playAnim, self, false)
end

function M:setContentStatus(status)
	goutil.setActive(self._contentGo, status)
end

function M:_playAnim()
	self:setContentStatus(true)
	self._anim:Play("instance_entrance_item")
end

function M:_refreshView()
	local chapterMo = self._chapterMoList[1]

	self:_updateChapterLockPanel()
	self._bgImg:SetImage(string.format("ui/bigbg/instance_chapter/%s.png", self._chapterMoList[1]:getChapterIconRes()), nil, self)

	self._progress1Img.fillAmount = self._chapterMoList[1]:getStarCount() / self._chapterMoList[1]:getTotalStarCount()

	goutil.setActive(self._selectPanelGo, self._curSelectChapterId == self._curIndex)

	if self._curSelectChapterId == self._curIndex then
		Astral.TransformUtil.SetAnchoredPos(self._contentGo.transform, self._selectPosGo.transform.anchoredPosition.x, 0)
		goutil.setActive(self._selectPanelGo, true)
	else
		Astral.TransformUtil.SetAnchoredPos(self._contentGo.transform, self._normalPosGo.transform.anchoredPosition.x, 0)
		goutil.setActive(self._selectPanelGo, false)
	end

	self._chapterIndexTxt.text = string.format("第%d章", chapterMo:getChapterId())
	self._chapterNameTxt.text = chapterMo:getName()
end

function M:OnDestroy()
	removetimer(self._playAnim, self)
	self._btnClick:RemoveClickListener()
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseHeroMoodCell.lua

module("logic.extensions.houseworker.view.HouseHeroMoodCell", package.seeall)

local M = class("HouseHeroMoodCell")

function M:ctor(comContainer)
	self._go = comContainer.gameObject

	self:_onInit()
end

function M:_onInit()
	self._fillImg = goutil.findChildImageComponent(self._go, "fill")
	self._moodIcon = goutil.findChildImageComponent(self._go, "moodIcon")
	self._moodText = goutil.findChildTextComponent(self._go, "txtMood")
end

function M:setVisible(visible)
	goutil.setActive(self._go, visible)
end

function M:updateMood(mood)
	local type = HouseWorkerModel.instance:getMoodInterval(mood)
	local maxMood = HouseConfig.instance:getHouseConst("MoodMax").numValue

	if type == 1 then
		IconLoader.setSprite(self._moodIcon, IconType.DynSpriteAtlas_Room, "room_mood_1")

		self._fillImg.color = Astral.ColorUtil.ParseColor("#9EBF9A")
	elseif type == 2 then
		IconLoader.setSprite(self._moodIcon, IconType.DynSpriteAtlas_Room, "room_mood_2")

		self._fillImg.color = Astral.ColorUtil.ParseColor("#C1B063")
	else
		IconLoader.setSprite(self._moodIcon, IconType.DynSpriteAtlas_Room, "room_mood_3")

		self._fillImg.color = Astral.ColorUtil.ParseColor("#E44B4B")
	end

	self._moodIcon.color = Astral.ColorUtil.ParseColor("#FFFFFF")
	self._fillImg.fillAmount = mood / maxMood

	if self._moodText then
		self._moodText.text = string.format("%s/%s", math.floor(mood), maxMood)
	end
end

function M:updateMoodDesc(mood)
	local type = HouseWorkerModel.instance:getMoodInterval(mood)

	if self._moodText then
		local colorStr = "#FE5D5D"

		if type == 1 then
			colorStr = "#6BD0B9"
		elseif type == 2 then
			colorStr = "#ECD581"
		end

		self._moodText.color = parsecolor(colorStr)
		self._moodText.text = HouseEnum.MoodType2Desc[type]
	end
end

return M

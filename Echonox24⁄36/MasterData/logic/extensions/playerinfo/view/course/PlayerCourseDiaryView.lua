-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseDiaryView.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseDiaryView", package.seeall)

local M = class("PlayerCourseDiaryView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	self._imgBg = self:getBigBg("player_course_trailing_panel_651768278")
	self._txtDate = self:getText("player_course_trailing_panel_1991363782")
	self._txtWeek = self:getText("player_course_trailing_panel_-76125310")
	self._txtWeather = self:getText("player_course_trailing_panel_1961048573")
	self._txtContent = self:getText("player_course_trailing_panel_-1487078236")
	self._btnPre = self:getBtn("player_course_trailing_panel_908663854")
	self._btnNext = self:getBtn("player_course_trailing_panel_1474684889")
	self._goPre = self._btnPre.gameObject
	self._goNext = self._btnNext.gameObject
	self._particle = {
		goutil.findChildComponent(self.mainGO, "Content/UIParticle/01", typeof(UnityEngine.ParticleSystem)),
		goutil.findChildComponent(self.mainGO, "Content/UIParticle/02", typeof(UnityEngine.ParticleSystem))
	}
	self._ani = goutil.addComponentOnce(goutil.findChild(self.mainGO, "Content"), ComponentType.Animation)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
end

function M:unbindEvents()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
end

function M:onEnter()
	self:_initData()
	self:_showDiaryDetail()
end

function M:onExit()
	self:_clearRedPoint()
	self._imgBg:ClearImage()

	self._diaryList = nil
	self._curIndex = nil
end

function M:playerEffect(index)
	if self._particle[index].isPlaying then
		self._particle[index]:Simulate(0)
	end

	self._particle[index]:Play()
end

function M:_initData()
	self._lookedIds = {}

	local diary = PlayerCourseModel.instance:getMainlineDiary()

	if diary and #diary > 0 then
		self._diaryList = PlayerCourseConfig.instance:getDiaryCfgs(diary)

		PlayerCourseUtil.sortDairy(self._diaryList)

		self._diaryCount = #self._diaryList
		self._curIndex = 1
	else
		self._diaryCount = 0
		self._curIndex = 0
	end
end

function M:_showDiaryDetail()
	if not self._diaryList or self._curIndex > self._diaryCount then
		return
	end

	local diary = self._diaryList[self._curIndex]

	self._lookedIds[diary.id] = true

	local title = string.split(diary.title, "#")

	self._txtDate.text = StringUtil.randomReplaceBlackBlock(title[1])
	self._txtWeek.text = StringUtil.randomReplaceBlackBlock(title[2])
	self._txtWeather.text = title[3]
	self._txtContent.text = StringUtil.randomReplaceBlackBlock(diary.content)

	self._imgBg:SetImage(string.format("ui/bigbg/playerinfo/course_trailing/%s.png", diary.bg), nil, self)
	goutil.setActive(self._goPre, self._curIndex > 1)
	goutil.setActive(self._goNext, self._curIndex < self._diaryCount and self._curIndex ~= 0)
end

function M:_onClickPre()
	self:playerEffect(2)
	settimer(0.25, function()
		if self._curIndex > 1 then
			self._curIndex = self._curIndex - 1

			self:_showDiaryDetail()
		end

		self._ani:Stop()
		self._ani:Play("player_course_trailing_panel_content_open")
	end, self, false)
end

function M:_onClickNext()
	self:playerEffect(1)
	settimer(0.25, function()
		if self._curIndex < self._diaryCount then
			self._curIndex = self._curIndex + 1

			self:_showDiaryDetail()
		end

		self._ani:Stop()
		self._ani:Play("player_course_trailing_panel_content_open")
	end, self, false)
end

function M:_clearRedPoint()
	local hasRed = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.MainlineDiary)

	if hasRed then
		local ids = {}
		local needClear = false

		for id, _ in pairs(self._lookedIds) do
			local isIn = RedDotModel.instance:getIdIsInDetail(GameEnum.RedPointEnum.MainlineDiary, id)

			if isIn then
				needClear = true

				table.insert(ids, id)
			end
		end

		if needClear then
			RedDotAgent.instance:sendRemoveRedPointRequest(GameEnum.RedPointEnum.MainlineDiary, ids)
		end
	end
end

return M

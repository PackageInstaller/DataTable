local LevelAmbushView = class("LevelAmbushView", import("..base.BaseSubView"))

function LevelAmbushView:getUIName()
	return "LevelAmbushView"
end

function LevelAmbushView:OnInit()
	self:InitData()
	self:InitUI()
	setActive(self._tf, true)

	return
end

function LevelAmbushView:InitData()
	self.chapter = self.contextData.chapterVO
	self.fleet = self.chapter.fleet
	self.template = pg.expedition_data_template[self.chapter:getChapterCell(self.fleet.line.row, self.fleet.line.column).attachmentId]

	return
end

function LevelAmbushView:InitUI()
	local var_4_0 = findTF(self._tf, "window")

	GetImageSpriteFromAtlasAsync("enemies/" .. self.template.icon, "", (findTF(self._tf, "window/ship/icon")))
	setText(findTF(self._tf, "window/ship/lv/Text"), self.template.level)
	setText(findTF(self._tf, "window/evade/rate"), math.floor(self.chapter:getAmbushDodge(self.fleet) * 100) .. "%")
	onButton(self, findTF(self._tf, "window/fight_button"), function()
		self:emit(LevelMediator2.ON_OP, {
			arg1 = 0,
			type = ChapterConst.OpAmbush,
			id = self.fleet.id
		})
		self:Destroy()

		return
	end, SFX_UI_WEIGHANCHOR_ATTACK)
	onButton(self, findTF(self._tf, "window/dodge_button"), function()
		self:emit(LevelMediator2.ON_OP, {
			arg1 = 1,
			type = ChapterConst.OpAmbush,
			id = self.fleet.id
		})
		self:Destroy()

		return
	end, SFX_UI_WEIGHANCHOR_AVOID)

	var_4_0.localScale = Vector3(1, 0, 1)

	LeanTween.scaleY(var_4_0.gameObject, 1, 0.3):setOnComplete(System.Action(self.onComplete))

	return
end

function LevelAmbushView:OnDestroy()
	return
end

function LevelAmbushView:SetFuncOnComplete(arg_8_1)
	self.onComplete = arg_8_1

	return
end

return LevelAmbushView

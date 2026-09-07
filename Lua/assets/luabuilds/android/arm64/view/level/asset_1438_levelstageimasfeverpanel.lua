local LevelStageIMasFeverPanel = class("LevelStageIMasFeverPanel", import("view.base.BaseSubPanel"))

function LevelStageIMasFeverPanel:getUIName()
	return "LevelStageIMasFeverPanel"
end

function LevelStageIMasFeverPanel:OnInit()
	self.fillImg = self._tf:Find("Fill")
	self.banner = self._tf:Find("Banner")

	setActive(self.banner, false)

	return
end

local var_0_1 = {
	[0] = 0,
	0.38,
	0.5471839,
	0.7228736,
	1
}
local var_0_2 = {
	"Yellow",
	"Red",
	"Blue"
}

function LevelStageIMasFeverPanel:UpdateView(arg_3_1, arg_3_2)
	local var_3_0 = getProxy(ChapterProxy):GetLastDefeatedEnemy(arg_3_1.id)
	local var_3_1 = arg_3_1.defeatEnemies
	local var_3_2 = pg.gameset.doa_fever_count.key_value
	local var_3_3 = var_0_1[Mathf.Min(pg.gameset.doa_fever_count.key_value, arg_3_1.defeatEnemies)]

	seriesAsync({
		function(arg_4_0)
			LeanTween.cancel(go(self.fillImg))

			if not var_3_0 or var_3_1 > var_3_2 then
				arg_4_0()

				do return end

				local var_4_0 = self.fillImg:GetComponent(typeof(Image))
			end

			local var_4_1 = var_0_1[math.max(var_3_1 - 1, 0)]

			LeanTween.value(go(self.fillImg), 0, 1, 1):setOnUpdate(System.Action_float(function(arg_5_0)
				var_4_0.fillAmount = Mathf.Lerp(var_4_1, var_3_3, arg_5_0)

				return
			end)):setOnComplete(System.Action(arg_4_0))

			return
		end,
		function(arg_6_0)
			self.fillImg:GetComponent(typeof(Image)).fillAmount = var_3_3

			if var_3_0 and var_3_1 == var_3_2 then
				self:ShowPanel(arg_3_1)
			end

			existCall(arg_3_2)

			return
		end
	})

	return
end

function LevelStageIMasFeverPanel:ShowPanel(arg_7_1)
	self.viewParent:emit(LevelUIConst.FROZEN)
	pg.UIMgr.GetInstance():OverlayPanel(self.banner)

	local var_7_1 = arg_7_1:GetBuffOfLinkAct()
	local var_7_2 = self.banner:Find((var_7_1 or nil) and var_0_2[table.indexof(pg.gameset.doa_fever_buff.description, var_7_1)])
	local var_7_3 = var_7_2:Find("Character")

	setImageSprite(var_7_3, LoadSprite("ui/LevelStageIMasFeverPanel_atlas", "character" .. tostring((math.random(1, 7)))))
	setActive(self.banner, true)
	setActive(var_7_2, true)

	var_7_3:GetComponent(typeof(Image)).enabled = true

	local function var_7_4()
		self:ClosePanel()

		return
	end

	var_7_2:GetComponent(typeof(DftAniEvent)):SetEndEvent(var_7_4)
	onButton(self, self.banner, var_7_4)

	self.showingPanel = true

	return
end

function LevelStageIMasFeverPanel:ClosePanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.banner, self._tf)
	setActive(self.banner, false)
	self.viewParent:emit(LevelUIConst.UN_FROZEN)

	self.showingPanel = nil

	return
end

function LevelStageIMasFeverPanel:OnDestroy()
	if self.showingPanel then
		self:ClosePanel()
	end

	return
end

return LevelStageIMasFeverPanel

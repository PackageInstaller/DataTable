local MapBuilderSSSS = class("MapBuilderSSSS", import(".MapBuilderNormal"))
local var_0_1 = "ssss_buttons"

function MapBuilderSSSS:GetType()
	return MapBuilder.TYPESSSS
end

function MapBuilderSSSS:OnInit()
	MapBuilderSSSS.super.OnInit(self)
	PoolMgr.GetInstance():GetUI(var_0_1, false, function(arg_3_0)
		self.buttons = arg_3_0

		return
	end)

	self.mainLayer = self._parentTf:Find("main")
	self.rightChapter = self._parentTf:Find("main/right_chapter/event_btns/BottomList")
	self.leftChapter = self._parentTf:Find("main/left_chapter/buttons")
	self.challengeBtn = tf(self.buttons):Find("btn_challenge")
	self.missionBtn = tf(self.buttons):Find("btn_mission")

	onButton(self, self.challengeBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelUIConst.SWITCH_ACT_MAP, Map.ACTIVITY_HARD)

		return
	end, SFX_PANEL)
	onButton(self, self.missionBtn, function()
		if self:isfrozen() then
			return
		end

		self:emit(LevelMediator2.ON_GO_TO_TASK_SCENE, {
			page = TaskScene.PAGE_TYPE_ACT
		})

		return
	end, SFX_PANEL)
	setParent(self.buttons, self.mainLayer)

	return
end

function MapBuilderSSSS:OnHide()
	setParent(self.challengeBtn, self.buttons)
	setParent(self.missionBtn, self.buttons)
	setActive(self.buttons, false)
	MapBuilderSSSS.super.OnHide(self)

	return
end

function MapBuilderSSSS:OnShow()
	MapBuilderSSSS.super.OnShow(self)
	setActive(self.buttons, true)
	setParent(self.challengeBtn, self.leftChapter)
	self.challengeBtn:SetSiblingIndex(5)
	setParent(self.missionBtn, self.rightChapter)
	self.missionBtn:SetSiblingIndex(0)

	return
end

local var_0_2 = {
	18993,
	18994,
	18995,
	18996,
	18997
}

function MapBuilderSSSS:UpdateButtons()
	MapBuilderSSSS.super.UpdateButtons(self)

	local var_8_0 = self.data:getConfig("type")

	setActive(self.sceneParent.actEliteBtn, false)
	setActive(self.challengeBtn, var_8_0 ~= Map.ACTIVITY_HARD)
	setActive(self.missionBtn, var_8_0 == Map.ACTIVITY_HARD)

	if var_8_0 == Map.ACTIVITY_HARD then
		local var_8_1 = _.any(var_0_2, function(arg_9_0)
			return tobool((getProxy(TaskProxy):getTaskById(arg_9_0)))
		end)

		setActive(self.missionBtn, var_8_1)

		if var_8_1 then
			setActive(self.missionBtn:Find("Tip"), _.any(var_0_2, function(arg_10_0)
				local var_10_0 = getProxy(TaskProxy):getTaskById(arg_10_0)

				return var_10_0 and var_10_0:isFinish()
			end))
		end
	end

	return
end

function MapBuilderSSSS:OnDestroy()
	PoolMgr.GetInstance():ReturnUI(var_0_1, self.buttons)
	MapBuilderSSSS.super.OnDestroy(self)

	return
end

return MapBuilderSSSS

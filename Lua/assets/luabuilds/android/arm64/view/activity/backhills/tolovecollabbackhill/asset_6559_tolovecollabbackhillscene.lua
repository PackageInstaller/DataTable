local ToLoveCollabBackHillScene = class("ToLoveCollabBackHillScene", import("..TemplateMV.BackHillTemplate"))

function ToLoveCollabBackHillScene:getUIName()
	return "ToLoveCollabBackHillUI"
end

function ToLoveCollabBackHillScene:init()
	self.top = self._tf:Find("top")
	self._map = self._tf:Find("map")
	self._upper = self._tf:Find("upper")

	return
end

function ToLoveCollabBackHillScene:didEnter()
	onButton(self, self._tf:Find("upper/task"), function()
		self:emit(ToLoveCollabBackHillMediator.TASK)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("upper/jinianzhang"), function()
		self:emit(ToLoveCollabBackHillMediator.TROPHY)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("upper/help"), function()
		self:emit(ToLoveCollabBackHillMediator.PUZZLE)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/return_btn"), function()
		self:emit(ToLoveCollabBackHillScene.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/return_main_btn"), function()
		self:emit(ToLoveCollabBackHillScene.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.tolove_main_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("upper/xiaoyouxi"), function()
		self:emit(ToLoveCollabBackHillMediator.MINI_GAME)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("upper/tebiezuozhan"), function()
		local var_11_0 = getProxy(ChapterProxy)
		local var_11_1, var_11_2 = var_11_0:getLastMapForActivity()

		if var_11_1 then
			if not var_11_0:getMapById(var_11_1):isUnlock() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				goto label_11_0
			end
		end

		self:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.LEVEL, {
			chapterId = var_11_2,
			mapIdx = var_11_1
		})

		::label_11_0::

		return
	end, SFX_PANEL)
	self:UpdateView()

	return
end

function ToLoveCollabBackHillScene:UpdateView()
	local var_12_0 = getProxy(ActivityProxy)

	setActive(self._tf:Find("upper/task/tips"), ToLoveCollabTaskMediator.GetTaskRedTip())

	local var_12_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)
	local var_12_2 = false

	for iter_12_0, iter_12_1 in ipairs(var_12_1.data1_list) do
		if not table.contains(var_12_1.data2_list, iter_12_1) then
			var_12_2 = true

			break
		end
	end

	setActive(self._tf:Find("upper/jinianzhang/tips"), (#var_12_1:GetPicturePuzzleIds() == #var_12_1.data2_list and var_12_1.data1 ~= 1 or nil) and true)
	setActive(self._tf:Find("upper/help/tips"), PuzzleConnectMediator.GetRedTip())
	setActive(self._tf:Find("upper/xiaoyouxi/tips"), ToLoveGameVo.ShouldShowTip())

	return
end

function ToLoveCollabBackHillScene:willExit()
	return
end

function ToLoveCollabBackHillScene.IsShowMainTip()
	local var_14_0 = getProxy(ActivityProxy)

	return (function()
		return ToLoveCollabTaskMediator.GetTaskRedTip()
	end)() or (function()
		local var_16_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)
		local var_16_1 = false

		for iter_16_0, iter_16_1 in ipairs(var_16_0.data1_list) do
			if not table.contains(var_16_0.data2_list, iter_16_1) then
				var_16_1 = true

				break
			end
		end

		return (#var_16_0:GetPicturePuzzleIds() == #var_16_0.data2_list and var_16_0.data1 ~= 1 or nil) and true
	end)() or (function()
		return PuzzleConnectMediator.GetRedTip()
	end)() or (function()
		return ToLoveGameVo.ShouldShowTip()
	end)()
end

return ToLoveCollabBackHillScene

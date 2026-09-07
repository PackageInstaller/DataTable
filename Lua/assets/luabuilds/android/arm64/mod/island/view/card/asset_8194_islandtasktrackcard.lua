local IslandTaskTrackCard = class("IslandTaskTrackCard")

IslandTaskTrackCard.TYPES = {
	OTHER = 2,
	MAIN = 1
}

function IslandTaskTrackCard:Ctor(arg_1_1, arg_1_2, arg_1_3)
	pg.DelegateInfo.New(self)

	self.event = arg_1_2
	self.type = arg_1_3
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.iconTF = self._tf:Find("title/icon")
	self.nameTF = self._tf:Find("title/name")
	self.finishedTF = self._tf:Find("target/finished")
	self.unFinishTF = self._tf:Find("target/unfinish")
	self.targetUIList = UIItemList.New(self.unFinishTF, self.unFinishTF:Find("tpl"))

	self.targetUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateTargetItem(arg_2_1, arg_2_2)
		end

		return
	end)

	self.targetBtnUIList = UIItemList.New(self._tf:Find("btns"), self._tf:Find("btns/tpl"))

	self.targetBtnUIList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			self:UpdateTargetBtnItem(arg_3_1, arg_3_2)
		end

		return
	end)

	return
end

function IslandTaskTrackCard:UpdateTargetItem(arg_4_1, arg_4_2)
	local var_4_0 = self.task:GetTargetList()[arg_4_1 + 1]
	local var_4_1 = var_4_0:IsFinish()

	setActive(arg_4_2:Find("status/unfinish"), not var_4_1)
	setActive(arg_4_2:Find("status/finished"), var_4_1)

	if var_4_1 then
		arg_4_2:GetComponent(typeof(Animation)):Play("Island3dTaskTrackPanel_tpl_finish_in")
	else
		arg_4_2:GetComponent(typeof(Animation)):Play("Island3dTaskTrackPanel_tpl_unfinished_in")
	end

	GetOrAddComponent(arg_4_2:Find("content"), "CanvasGroup").alpha = var_4_1 and 0.5 or 1

	local var_4_2 = self:GetMapTip(tonumber(var_4_0:GetTrackParma()))

	if var_4_2 and not var_4_1 then
		setText(arg_4_2:Find("content/Text"), var_4_2)
		setText(arg_4_2:Find("content/num"), "")
	else
		setText(arg_4_2:Find("content/Text"), HXSet.hxLan(var_4_0:getConfig("name")))

		local var_4_3 = var_4_0:GetProgress()
		local var_4_4 = var_4_0:GetTargetNum()

		setText(arg_4_2:Find("content/num"), "(" .. (var_4_3 < var_4_4 and setColorStr(var_4_3, "#dd374e") or var_4_3) .. "/" .. var_4_4 .. ")")
	end

	return
end

function IslandTaskTrackCard:Update(arg_5_1, arg_5_2)
	self.unlock = arg_5_2
	self.task = arg_5_1

	setActive(self._tf, self.task)

	if not self.task then
		return
	end

	self.curMapId = getProxy(IslandProxy):GetIsland():GetMapId()

	local var_5_0 = self.task:GetShowType()

	GetImageSpriteFromAtlasAsync("island/islandtasktype", "track_" .. IslandTaskType.ShowTypeFields[var_5_0], self.iconTF)
	setImageColor(self._tf:Find("title/bg"), Color.NewHex(IslandTaskType.ShowTypeTrackColors[var_5_0]))
	setText(self.nameTF, HXSet.hxLan(self.task:GetName()))
	self:UpdateTarget()
	self:TrackUI()

	return
end

function IslandTaskTrackCard:UpdateProgress(arg_6_1)
	self.task = arg_6_1

	if not self.task then
		return
	end

	self:UpdateTarget()
	self:TrackUI()

	return
end

function IslandTaskTrackCard:UpdateTarget()
	local var_7_0 = not self.task:IsSubmitImmediately() and self.task:IsFinish()
	local var_7_1 = #self.task:GetTargetList()

	self.targetUIList:align(var_7_1)
	self.targetBtnUIList:align(var_7_1 + (var_7_0 and 1 or 0))
	setActive(self.finishedTF, var_7_0)

	if var_7_0 then
		local var_7_2 = self:GetMapTip(tonumber(self.task:GetTraceParam()))

		if var_7_2 then
			setText(self.finishedTF:Find("Text"), var_7_2)
		else
			setText(self.finishedTF:Find("Text"), HXSet.hxLan(self.task:GetFinishedDesc()))
		end
	end

	return
end

function IslandTaskTrackCard:RemoveTask()
	self:UnTrackUI()
	setActive(self._tf, false)

	return
end

function IslandTaskTrackCard:TrackUI()
	if not self.unlock then
		return
	end

	local var_9_0 = tonumber((self.task:GetTraceParam()))

	if var_9_0 then
		if _IslandCore then
			_IslandCore:GetController():NotifiyCore(ISLAND_EVT.TRACKING, {
				id = var_9_0,
				typ = self.task:GetType(),
				trackType = self.type
			})
		end
	else
		self:UnTrackUI()
	end

	return
end

function IslandTaskTrackCard:UnTrackUI()
	if not self.unlock then
		return
	end

	if _IslandCore then
		_IslandCore:GetController():NotifiyCore(ISLAND_EVT.UNTRACKING, self.type)
	end

	return
end

function IslandTaskTrackCard:GetMapTip(arg_11_1)
	if not arg_11_1 then
		return nil
	end

	local var_11_0 = pg.island_world_objects[arg_11_1]

	if not pg.island_world_objects[arg_11_1] then
		return nil
	end

	if self.curMapId == var_11_0.mapId then
		return nil
	end

	return i18n("island_word_go") .. pg.island_map[var_11_0.mapId].name
end

function IslandTaskTrackCard:_SkipBtn(arg_12_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_main_btns[arg_12_1].ability_id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_systemnoopen_tips"))

		return
	end

	if pg.island_main_btns[arg_12_1].open_page ~= "" then
		self:emit(IslandMediator.OPEN_PAGE, pg.island_main_btns[arg_12_1].open_page, pg.island_main_btns[arg_12_1].page_param)
	end

	return
end

function IslandTaskTrackCard:_SkipObj(arg_13_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockMap(pg.island_world_objects[arg_13_1].mapId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_placenoopen_tips"))

		return
	end

	self:emit(IslandBaseMediator.SWITCH_MAP, pg.island_world_objects[arg_13_1].mapId, pg.island_map[pg.island_world_objects[arg_13_1].mapId].born_object)

	return
end

function IslandTaskTrackCard:UpdateTargetBtnItem(arg_14_1, arg_14_2)
	local var_14_0 = self.task:GetTargetList()[arg_14_1 + 1]
	local var_14_1 = arg_14_2:Find("btn")

	removeOnButton(var_14_1)
	setActive(var_14_1, false)

	if var_14_0 then
		local var_14_2 = tonumber(pg.island_task_target[var_14_0.id].tips)
		local var_14_3 = tonumber(pg.island_task_target[var_14_0.id].jump_ui)

		if not var_14_0:IsFinish() then
			if var_14_3 then
				setActive(var_14_1, true)
				onButton(self, var_14_1, function()
					self:_SkipBtn(var_14_3)

					return
				end, SFX_PANEL)
			elseif var_14_2 then
				if IslandMainBtnTipHelper.IsUnlock("map") and self.curMapId ~= pg.island_world_objects[var_14_2].mapId then
					setActive(var_14_1, true)
					onButton(self, var_14_1, function()
						self:_SkipObj(var_14_2)

						return
					end, SFX_PANEL)
				end
			end
		end
	else
		setActive(var_14_1, false)

		local var_14_4 = tonumber(self.task:getConfig("complete_data"))

		if var_14_4 and var_14_4 ~= 0 then
			if IslandMainBtnTipHelper.IsUnlock("map") and self.curMapId ~= pg.island_world_objects[var_14_4].mapId then
				setActive(var_14_1, true)
				onButton(self, var_14_1, function()
					self:_SkipObj(var_14_4)

					return
				end, SFX_PANEL)
			end
		end
	end

	return
end

function IslandTaskTrackCard:emit(...)
	self.event:emit(...)

	return
end

function IslandTaskTrackCard:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return IslandTaskTrackCard

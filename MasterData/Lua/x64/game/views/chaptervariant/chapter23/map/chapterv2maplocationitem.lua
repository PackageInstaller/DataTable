local ChapterV2MapLocationItem = class("ChapterV2MapLocationItem", BaseView)

function ChapterV2MapLocationItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.showTagController_ = self.controllerEx_:GetController("tag")
	self.choiceController_ = self.controllerEx_:GetController("choice")
	self.stageController_ = self.controllerEx_:GetController("gobtn")
	self.iconController_ = self.controllerEx_:GetController("information")
	self.tagStateController_ = self.controllerEx_:GetController("tagstate")
	self.mainTagLockController_ = self.controllerEx_:GetController("maintaglock")
	self.locationLockController_ = self.controllerEx_:GetController("locationlock")
	self.hasPlayerController_ = self.controllerEx_:GetController("hasplayer")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.physicalStrengthItemController_ = self.controllerEx_:GetController("PhysicalStrengthItem")
	self.clickTag_ = false
	self.uiTagList_ = LuaList.New(handler(self, self.IndexItemTag), self.tagUiListGo_, ChapterV2MapSubTagItem)
end

function ChapterV2MapLocationItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		self.clickTag_ = not self.clickTag_

		manager.notify:Invoke(CHAPTER_MAP_LOCATION_CLICK, self.locationId_)
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		if self.selectTag_ then
			if self.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
				local var_4_0, var_4_1 = ChapterV2MapTools.IsEventUnlock(self.tagCfg_.behaviour_parameters[1])

				if var_4_0 then
					Debug.Log("触发TagID:" .. self.selectTag_ .. "事件ID：" .. self.tagCfg_.behaviour_parameters[1])
					manager.notify:Invoke(CHAPTER_MAP_LOCATION_EVENT_CLICK, self.tagCfg_.behaviour_parameters[1])
				else
					ShowTips(ConditionCfg[var_4_1].desc)
				end
			elseif self.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.TELEPORT then
				Debug.Log("触发TagID:" .. self.selectTag_ .. "传送地图ID：" .. self.tagCfg_.behaviour_parameters[1])
				ChapterV2MapTools.GoMap(self.tagCfg_.behaviour_parameters[1])
			else
				Debug.LogError("ChapterV2MapLocationItem 未知的tag_behaviour tagID:" .. self.selectTag_ .. "tag_behaviour:" .. self.tagCfg_.tag_behaviour)
			end
		end
	end)
end

function ChapterV2MapLocationItem:SetData(arg_5_1, arg_5_2)
	self.locationId_ = arg_5_1
	self.isSelect_ = arg_5_2
	self.taglist_ = ChapterV2MapData:GetLocationActiveTagList(self.locationId_)
	self.gameObject_.name = arg_5_1 .. "_locationItem"

	self:RefreshUI()
	self:RefreshCostUI()
end

function ChapterV2MapLocationItem:RefreshUI()
	local var_6_0 = Asset.Load(ChapterV2MapTools.GetIconPrefabPath() .. self.locationId_)

	if var_6_0 and not self.locationGo_ then
		GameObject.Instantiate(var_6_0, self.prefabRoot_)

		self.locationGo_ = var_6_0
	end

	self.transform_:SetLocalPosition(Vector2(ChapterV2MapLocationCfg[self.locationId_].position[1], ChapterV2MapLocationCfg[self.locationId_].position[2]))

	self.nameText_.text = ChapterV2MapLocationCfg[self.locationId_].name

	self.showTagController_:SetSelectedState(tostring(#self.taglist_ > 0 and ChapterV2MapTagCfg[self.taglist_[1]].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBMENU))

	local var_6_1 = ChapterV2MapConst.ICONTYPE.NONE

	for iter_6_0, iter_6_1 in ipairs(self.taglist_) do
		if ChapterV2MapTagCfg[iter_6_1].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
			if var_6_1 > ChapterV2MapEventCfg[ChapterV2MapTagCfg[iter_6_1].behaviour_parameters[1]].type then
				var_6_1 = ChapterV2MapEventCfg[ChapterV2MapTagCfg[iter_6_1].behaviour_parameters[1]].type
			end
		elseif ChapterV2MapTagCfg[iter_6_1].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBMENU then
			for iter_6_2, iter_6_3 in ipairs(ChapterV2MapTagCfg[iter_6_1].behaviour_parameters) do
				if ChapterV2MapTagCfg[iter_6_3].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBLOCATION then
					for iter_6_4, iter_6_5 in ipairs(ChapterV2MapData:GetLocationActiveTagList(ChapterV2MapTagCfg[iter_6_3].tag_id) or {}) do
						if ChapterV2MapEventCfg[ChapterV2MapTagCfg[iter_6_5].behaviour_parameters[1]] and var_6_1 > ChapterV2MapEventCfg[ChapterV2MapTagCfg[iter_6_5].behaviour_parameters[1]].type then
							var_6_1 = ChapterV2MapEventCfg[ChapterV2MapTagCfg[iter_6_5].behaviour_parameters[1]].type
						end
					end
				end
			end
		end
	end

	self.iconController_:SetSelectedState(tostring(var_6_1))
	self.mainTagLockController_:SetSelectedState(tostring(not (#self.taglist_ > 0)))
	self.locationLockController_:SetSelectedState(tostring(not ChapterV2MapTools.GetMapLocationUnlock(self.locationId_)))

	if self.taglist_[1] then
		self:OnClickMainBtn()
	end

	self:BindRedPoint()
end

function ChapterV2MapLocationItem:OnClickMainBtn()
	self.selectController_:SetSelectedState(tostring(self.isSelect_))

	if self.isSelect_ then
		if self.clickTag_ and not self.clickSubTag_ then
			self.selectTag_ = self.taglist_[1]

			trace("选中一级地点上挂载的tagID列表为：%o", self.taglist_)

			self.tagCfg_ = ChapterV2MapTagCfg[self.taglist_[1]]

			if self.tagCfg_ then
				self.physicalStrengthItemController_:SetSelectedState(tostring("off"))
				self.stageGoTrs_:SetParent(self.mainGoRoot_)
				SetActive(self.stageGoTrs_, true)

				self.stageGoTrs_.localPosition = Vector3.zero

				if self.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBMENU then
					self:RefreshSubMenu()
				else
					self.stageController_:SetSelectedState(tostring(self.clickTag_))

					if self.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.TELEPORT then
						self.tagStateController_:SetSelectedState("teleport")
					elseif self.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
						local var_7_0 = ChapterV2MapEventCfg[self.tagCfg_.behaviour_parameters[1]]

						if ChapterV2MapEventCfg[self.tagCfg_.behaviour_parameters[1]] then
							if ChapterV2MapTools.IsEventInteractable(var_7_0.id) then
								if var_7_0.type == ChapterV2MapConst.ICONTYPE.MAIN or var_7_0.type == ChapterV2MapConst.ICONTYPE.SIDE then
									if StageTools.StageIsCleared(var_7_0.params[1]) then
										self.tagStateController_:SetSelectedState("completeStage")
									else
										self:RefreshCostUI()

										if BattleChapterStageCfg[var_7_0.params[1]].cost > 0 then
											self.tagStateController_:SetSelectedState("costStage")
										else
											self.tagStateController_:SetSelectedState("freeStage")
										end
									end

									self.stageTitleText_.text = BattleChapterStageCfg[var_7_0.params[1]].name
								elseif var_7_0.type == ChapterV2MapConst.ICONTYPE.EVENT then
									self.tagStateController_:SetSelectedState("event")
								end
							else
								ShowTips("CHAPTER_V2_EVENT_NOT_INTERACTABLE")
							end
						end
					end
				end
			else
				ShowTips("CHAPTER_V2_LOCATION_EMPTY_EVENT")
			end
		elseif not self.clickSubTag_ then
			self.choiceController_:SetSelectedState(tostring(self.clickTag_))
			self.stageController_:SetSelectedState(tostring(self.clickTag_))
		elseif not self.clickTag_ and self.clickSubTag_ then
			self.clickTag_ = false
			self.clickSubTag_ = false

			self.stageGoTrs_:SetParent(self.mainGoRoot_)
			SetActive(self.stageGoTrs_, false)
			self.choiceController_:SetSelectedState(tostring(self.clickTag_))
			self.stageController_:SetSelectedState(tostring(self.clickTag_))
		end
	else
		self.clickTag_ = false
		self.clickSubTag_ = false

		self.stageGoTrs_:SetParent(self.mainGoRoot_)
		SetActive(self.stageGoTrs_, false)
		self.choiceController_:SetSelectedState(tostring(self.clickTag_))
		self.stageController_:SetSelectedState(tostring(self.clickTag_))
	end
end

function ChapterV2MapLocationItem:OnClickSubTag(arg_8_1, arg_8_2)
	if self.isSelect_ then
		self.clickSubTag_ = not self.clickSubTag_
		self.selectTag_ = arg_8_2

		local var_8_0 = ChapterV2MapData:GetLocationActiveTagList(arg_8_2)

		trace("选中二级地点上挂载的tagID列表为：%o", var_8_0)

		for iter_8_0, iter_8_1 in ipairs(self.uiTagList_:GetItemList()) do
			iter_8_1:SetSelectedState(iter_8_1.tagId_ == self.selectTag_ and ChapterV2MapTagCfg[iter_8_1.tagId_])
		end

		if ChapterV2MapTagCfg[var_8_0[1]] then
			arg_8_1:SetSelectedState(self.clickSubTag_)

			self.tagCfg_ = ChapterV2MapTagCfg[var_8_0[1]]

			self.stageGoTrs_:SetParent(arg_8_1.stageRoot_)

			self.stageGoTrs_.localPosition = Vector3.zero

			self.choiceController_:SetSelectedState("true")
			self.stageController_:SetSelectedState(tostring(self.clickSubTag_))
			self.physicalStrengthItemController_:SetSelectedState("on")
			SetActive(self.stageGoTrs_, self.clickSubTag_)

			if ChapterV2MapTagCfg[var_8_0[1]].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.TELEPORT then
				self.tagStateController_:SetSelectedState("teleport")
			elseif ChapterV2MapTagCfg[var_8_0[1]].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
				local var_8_1 = ChapterV2MapEventCfg[ChapterV2MapTagCfg[var_8_0[1]].behaviour_parameters[1]]

				if ChapterV2MapEventCfg[ChapterV2MapTagCfg[var_8_0[1]].behaviour_parameters[1]] then
					if ChapterV2MapTools.IsEventInteractable(var_8_1.id) then
						if var_8_1.type == ChapterV2MapConst.ICONTYPE.MAIN or var_8_1.type == ChapterV2MapConst.ICONTYPE.SIDE then
							if StageTools.StageIsCleared(var_8_1.params[1]) then
								self.tagStateController_:SetSelectedState("completeStage")
							else
								self:RefreshCostUI()

								if BattleChapterStageCfg[var_8_1.params[1]].cost > 0 then
									self.tagStateController_:SetSelectedState("costStage")
								else
									self.tagStateController_:SetSelectedState("freeStage")
								end
							end

							self.stageTitleText_.text = BattleChapterStageCfg[var_8_1.params[1]].name
						elseif var_8_1.type == ChapterV2MapConst.ICONTYPE.EVENT then
							self.tagStateController_:SetSelectedState("event")
						end
					else
						ShowTips("CHAPTER_V2_EVENT_NOT_INTERACTABLE")
					end
				end
			end
		else
			ShowTips("CHAPTER_V2_LOCATION_EMPTY_EVENT")
		end
	else
		self.clickSubTag_ = false

		SetActive(self.stageGoTrs_, false)
		arg_8_1:SetSelectedState(false)
		self.choiceController_:SetSelectedState("false")
		self.stageController_:SetSelectedState("false")
	end
end

function ChapterV2MapLocationItem:IndexItemTag(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.subTagList_[arg_9_1], self.clickTag_ == self.subTagList_[arg_9_1])
	arg_9_2:SetClickCallBack(function(arg_10_0, arg_10_1)
		self:OnClickSubTag(arg_10_0, arg_10_1)
	end)
end

function ChapterV2MapLocationItem:RefreshSubMenu()
	self.subTagList_ = {}

	for iter_11_0, iter_11_1 in ipairs(self.tagCfg_.behaviour_parameters) do
		if ChapterV2MapTagCfg[iter_11_1].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBLOCATION then
			table.insert(self.subTagList_, iter_11_1)
		end
	end

	trace("选中一级地点上挂载的二级地点列表为：%o", self.subTagList_)

	if #self.subTagList_ > 0 then
		self.choiceController_:SetSelectedState(tostring(self.clickTag_))
	else
		self.choiceController_:SetSelectedState("false")
	end

	self.uiTagList_:StartScroll(#self.subTagList_)
end

function ChapterV2MapLocationItem:SetClickTag(arg_12_1)
	self.clickTag_ = arg_12_1
end

function ChapterV2MapLocationItem:RefreshCostUI()
	if not self.tagCfg_ then
		return
	end

	local var_13_0 = ChapterV2MapEventCfg[self.tagCfg_.behaviour_parameters[1]]

	if ChapterV2MapEventCfg[self.tagCfg_.behaviour_parameters[1]] and (var_13_0.type == ChapterV2MapConst.ICONTYPE.MAIN or var_13_0.type == ChapterV2MapConst.ICONTYPE.SIDE) then
		self.costIcon_.sprite = ItemTools.getItemSprite(CurrencyConst.CURRENCY_TYPE_VITALITY)
		self.costText_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < BattleChapterStageCfg[var_13_0.params[1]].cost and "<color=#FF000B>" .. tostring(BattleChapterStageCfg[var_13_0.params[1]].cost) .. "</color>" or tostring(BattleChapterStageCfg[var_13_0.params[1]].cost)
	end
end

function ChapterV2MapLocationItem:Dispose()
	self:UnbindRedPoint()

	if self.uiTagList_ then
		self.uiTagList_:Dispose()
	end

	Object.Destroy(self.gameObject_)
	ChapterV2MapLocationItem.super.Dispose(self)
end

function ChapterV2MapLocationItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.nameText_.transform, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_LOCATION, self.locationId_))
end

function ChapterV2MapLocationItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.nameText_.transform)
end

return ChapterV2MapLocationItem

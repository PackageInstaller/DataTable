local var_0_0 = class("ChapterV2MapLocationItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.showTagController_ = arg_1_0.controllerEx_:GetController("tag")
	arg_1_0.choiceController_ = arg_1_0.controllerEx_:GetController("choice")
	arg_1_0.stageController_ = arg_1_0.controllerEx_:GetController("gobtn")
	arg_1_0.iconController_ = arg_1_0.controllerEx_:GetController("information")
	arg_1_0.tagStateController_ = arg_1_0.controllerEx_:GetController("tagstate")
	arg_1_0.mainTagLockController_ = arg_1_0.controllerEx_:GetController("maintaglock")
	arg_1_0.locationLockController_ = arg_1_0.controllerEx_:GetController("locationlock")
	arg_1_0.hasPlayerController_ = arg_1_0.controllerEx_:GetController("hasplayer")
	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("select")
	arg_1_0.physicalStrengthItemController_ = arg_1_0.controllerEx_:GetController("PhysicalStrengthItem")
	arg_1_0.clickTag_ = false
	arg_1_0.uiTagList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItemTag), arg_1_0.tagUiListGo_, ChapterV2MapSubTagItem)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		arg_2_0.clickTag_ = not arg_2_0.clickTag_

		manager.notify:Invoke(CHAPTER_MAP_LOCATION_CLICK, arg_2_0.locationId_)
	end)
	arg_2_0:AddBtnListener(arg_2_0.goBtn_, nil, function()
		if arg_2_0.selectTag_ then
			if arg_2_0.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
				local var_4_0, var_4_1 = ChapterV2MapTools.IsEventUnlock(arg_2_0.tagCfg_.behaviour_parameters[1])

				if var_4_0 then
					Debug.Log("触发TagID:" .. arg_2_0.selectTag_ .. "事件ID：" .. arg_2_0.tagCfg_.behaviour_parameters[1])
					manager.notify:Invoke(CHAPTER_MAP_LOCATION_EVENT_CLICK, arg_2_0.tagCfg_.behaviour_parameters[1])
				else
					local var_4_2 = ConditionCfg[var_4_1]

					ShowTips(var_4_2.desc)
				end
			elseif arg_2_0.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.TELEPORT then
				Debug.Log("触发TagID:" .. arg_2_0.selectTag_ .. "传送地图ID：" .. arg_2_0.tagCfg_.behaviour_parameters[1])
				ChapterV2MapTools.GoMap(arg_2_0.tagCfg_.behaviour_parameters[1])
			else
				Debug.LogError("ChapterV2MapLocationItem 未知的tag_behaviour tagID:" .. arg_2_0.selectTag_ .. "tag_behaviour:" .. arg_2_0.tagCfg_.tag_behaviour)
			end
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.locationId_ = arg_5_1
	arg_5_0.isSelect_ = arg_5_2
	arg_5_0.taglist_ = ChapterV2MapData:GetLocationActiveTagList(arg_5_0.locationId_)
	arg_5_0.gameObject_.name = arg_5_1 .. "_locationItem"

	arg_5_0:RefreshUI()
	arg_5_0:RefreshCostUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = ChapterV2MapLocationCfg[arg_6_0.locationId_]
	local var_6_1 = Asset.Load(ChapterV2MapTools.GetIconPrefabPath() .. arg_6_0.locationId_)

	if var_6_1 and not arg_6_0.locationGo_ then
		GameObject.Instantiate(var_6_1, arg_6_0.prefabRoot_)

		arg_6_0.locationGo_ = var_6_1
	end

	arg_6_0.transform_:SetLocalPosition(Vector2(var_6_0.position[1], var_6_0.position[2]))

	arg_6_0.nameText_.text = var_6_0.name

	arg_6_0.showTagController_:SetSelectedState(tostring(#arg_6_0.taglist_ > 0 and ChapterV2MapTagCfg[arg_6_0.taglist_[1]].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBMENU))

	local var_6_2 = ChapterV2MapConst.ICONTYPE.NONE

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.taglist_) do
		local var_6_3 = ChapterV2MapTagCfg[iter_6_1]

		if var_6_3.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
			local var_6_4 = var_6_3.behaviour_parameters[1]
			local var_6_5 = ChapterV2MapEventCfg[var_6_4]

			if var_6_2 > var_6_5.type then
				var_6_2 = var_6_5.type
			end
		elseif var_6_3.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBMENU then
			for iter_6_2, iter_6_3 in ipairs(var_6_3.behaviour_parameters) do
				local var_6_6 = ChapterV2MapTagCfg[iter_6_3]

				if var_6_6.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBLOCATION then
					local var_6_7 = ChapterV2MapData:GetLocationActiveTagList(var_6_6.tag_id) or {}

					for iter_6_4, iter_6_5 in ipairs(var_6_7) do
						local var_6_8 = ChapterV2MapTagCfg[iter_6_5]
						local var_6_9 = ChapterV2MapEventCfg[var_6_8.behaviour_parameters[1]]

						if var_6_9 and var_6_2 > var_6_9.type then
							var_6_2 = var_6_9.type
						end
					end
				end
			end
		end
	end

	arg_6_0.iconController_:SetSelectedState(tostring(var_6_2))
	arg_6_0.mainTagLockController_:SetSelectedState(tostring(not (#arg_6_0.taglist_ > 0)))
	arg_6_0.locationLockController_:SetSelectedState(tostring(not ChapterV2MapTools.GetMapLocationUnlock(arg_6_0.locationId_)))

	if arg_6_0.taglist_[1] then
		arg_6_0:OnClickMainBtn()
	end

	arg_6_0:BindRedPoint()
end

function var_0_0.OnClickMainBtn(arg_7_0)
	arg_7_0.selectController_:SetSelectedState(tostring(arg_7_0.isSelect_))

	if arg_7_0.isSelect_ then
		if arg_7_0.clickTag_ and not arg_7_0.clickSubTag_ then
			arg_7_0.selectTag_ = arg_7_0.taglist_[1]

			trace("选中一级地点上挂载的tagID列表为：%o", arg_7_0.taglist_)

			arg_7_0.tagCfg_ = ChapterV2MapTagCfg[arg_7_0.taglist_[1]]

			if arg_7_0.tagCfg_ then
				arg_7_0.physicalStrengthItemController_:SetSelectedState(tostring("off"))
				arg_7_0.stageGoTrs_:SetParent(arg_7_0.mainGoRoot_)
				SetActive(arg_7_0.stageGoTrs_, true)

				arg_7_0.stageGoTrs_.localPosition = Vector3.zero

				if arg_7_0.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBMENU then
					arg_7_0:RefreshSubMenu()
				else
					arg_7_0.stageController_:SetSelectedState(tostring(arg_7_0.clickTag_))

					if arg_7_0.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.TELEPORT then
						arg_7_0.tagStateController_:SetSelectedState("teleport")
					elseif arg_7_0.tagCfg_.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
						local var_7_0 = ChapterV2MapEventCfg[arg_7_0.tagCfg_.behaviour_parameters[1]]

						if var_7_0 then
							if ChapterV2MapTools.IsEventInteractable(var_7_0.id) then
								if var_7_0.type == ChapterV2MapConst.ICONTYPE.MAIN or var_7_0.type == ChapterV2MapConst.ICONTYPE.SIDE then
									if StageTools.StageIsCleared(var_7_0.params[1]) then
										arg_7_0.tagStateController_:SetSelectedState("completeStage")
									else
										arg_7_0:RefreshCostUI()

										if BattleChapterStageCfg[var_7_0.params[1]].cost > 0 then
											arg_7_0.tagStateController_:SetSelectedState("costStage")
										else
											arg_7_0.tagStateController_:SetSelectedState("freeStage")
										end
									end

									arg_7_0.stageTitleText_.text = BattleChapterStageCfg[var_7_0.params[1]].name
								elseif var_7_0.type == ChapterV2MapConst.ICONTYPE.EVENT then
									arg_7_0.tagStateController_:SetSelectedState("event")
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
		elseif not arg_7_0.clickSubTag_ then
			arg_7_0.choiceController_:SetSelectedState(tostring(arg_7_0.clickTag_))
			arg_7_0.stageController_:SetSelectedState(tostring(arg_7_0.clickTag_))
		elseif not arg_7_0.clickTag_ and arg_7_0.clickSubTag_ then
			arg_7_0.clickTag_ = false
			arg_7_0.clickSubTag_ = false

			arg_7_0.stageGoTrs_:SetParent(arg_7_0.mainGoRoot_)
			SetActive(arg_7_0.stageGoTrs_, false)
			arg_7_0.choiceController_:SetSelectedState(tostring(arg_7_0.clickTag_))
			arg_7_0.stageController_:SetSelectedState(tostring(arg_7_0.clickTag_))
		end
	else
		arg_7_0.clickTag_ = false
		arg_7_0.clickSubTag_ = false

		arg_7_0.stageGoTrs_:SetParent(arg_7_0.mainGoRoot_)
		SetActive(arg_7_0.stageGoTrs_, false)
		arg_7_0.choiceController_:SetSelectedState(tostring(arg_7_0.clickTag_))
		arg_7_0.stageController_:SetSelectedState(tostring(arg_7_0.clickTag_))
	end
end

function var_0_0.OnClickSubTag(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.isSelect_ then
		arg_8_0.clickSubTag_ = not arg_8_0.clickSubTag_
		arg_8_0.selectTag_ = arg_8_2

		local var_8_0 = arg_8_2
		local var_8_1 = ChapterV2MapData:GetLocationActiveTagList(var_8_0)

		trace("选中二级地点上挂载的tagID列表为：%o", var_8_1)

		local var_8_2 = var_8_1[1]
		local var_8_3 = ChapterV2MapTagCfg[var_8_2]

		for iter_8_0, iter_8_1 in ipairs(arg_8_0.uiTagList_:GetItemList()) do
			iter_8_1:SetSelectedState(iter_8_1.tagId_ == arg_8_0.selectTag_ and ChapterV2MapTagCfg[iter_8_1.tagId_])
		end

		if var_8_3 then
			arg_8_1:SetSelectedState(arg_8_0.clickSubTag_)

			arg_8_0.tagCfg_ = var_8_3

			arg_8_0.stageGoTrs_:SetParent(arg_8_1.stageRoot_)

			arg_8_0.stageGoTrs_.localPosition = Vector3.zero

			arg_8_0.choiceController_:SetSelectedState("true")
			arg_8_0.stageController_:SetSelectedState(tostring(arg_8_0.clickSubTag_))
			arg_8_0.physicalStrengthItemController_:SetSelectedState("on")
			SetActive(arg_8_0.stageGoTrs_, arg_8_0.clickSubTag_)

			if var_8_3.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.TELEPORT then
				arg_8_0.tagStateController_:SetSelectedState("teleport")
			elseif var_8_3.tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT then
				local var_8_4 = ChapterV2MapEventCfg[var_8_3.behaviour_parameters[1]]

				if var_8_4 then
					if ChapterV2MapTools.IsEventInteractable(var_8_4.id) then
						if var_8_4.type == ChapterV2MapConst.ICONTYPE.MAIN or var_8_4.type == ChapterV2MapConst.ICONTYPE.SIDE then
							if StageTools.StageIsCleared(var_8_4.params[1]) then
								arg_8_0.tagStateController_:SetSelectedState("completeStage")
							else
								arg_8_0:RefreshCostUI()

								if BattleChapterStageCfg[var_8_4.params[1]].cost > 0 then
									arg_8_0.tagStateController_:SetSelectedState("costStage")
								else
									arg_8_0.tagStateController_:SetSelectedState("freeStage")
								end
							end

							arg_8_0.stageTitleText_.text = BattleChapterStageCfg[var_8_4.params[1]].name
						elseif var_8_4.type == ChapterV2MapConst.ICONTYPE.EVENT then
							arg_8_0.tagStateController_:SetSelectedState("event")
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
		arg_8_0.clickSubTag_ = false

		SetActive(arg_8_0.stageGoTrs_, false)
		arg_8_1:SetSelectedState(false)
		arg_8_0.choiceController_:SetSelectedState("false")
		arg_8_0.stageController_:SetSelectedState("false")
	end
end

function var_0_0.IndexItemTag(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.subTagList_[arg_9_1]

	arg_9_2:SetData(var_9_0, arg_9_0.clickTag_ == var_9_0)
	arg_9_2:SetClickCallBack(function(arg_10_0, arg_10_1)
		arg_9_0:OnClickSubTag(arg_10_0, arg_10_1)
	end)
end

function var_0_0.RefreshSubMenu(arg_11_0)
	arg_11_0.subTagList_ = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.tagCfg_.behaviour_parameters) do
		if ChapterV2MapTagCfg[iter_11_1].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.SUBLOCATION then
			table.insert(arg_11_0.subTagList_, iter_11_1)
		end
	end

	trace("选中一级地点上挂载的二级地点列表为：%o", arg_11_0.subTagList_)

	if #arg_11_0.subTagList_ > 0 then
		arg_11_0.choiceController_:SetSelectedState(tostring(arg_11_0.clickTag_))
	else
		arg_11_0.choiceController_:SetSelectedState("false")
	end

	arg_11_0.uiTagList_:StartScroll(#arg_11_0.subTagList_)
end

function var_0_0.SetClickTag(arg_12_0, arg_12_1)
	arg_12_0.clickTag_ = arg_12_1
end

function var_0_0.RefreshCostUI(arg_13_0)
	if not arg_13_0.tagCfg_ then
		return
	end

	local var_13_0 = ChapterV2MapEventCfg[arg_13_0.tagCfg_.behaviour_parameters[1]]

	if var_13_0 and (var_13_0.type == ChapterV2MapConst.ICONTYPE.MAIN or var_13_0.type == ChapterV2MapConst.ICONTYPE.SIDE) then
		arg_13_0.costIcon_.sprite = ItemTools.getItemSprite(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < BattleChapterStageCfg[var_13_0.params[1]].cost then
			arg_13_0.costText_.text = "<color=#FF000B>" .. tostring(BattleChapterStageCfg[var_13_0.params[1]].cost) .. "</color>"
		else
			arg_13_0.costText_.text = tostring(BattleChapterStageCfg[var_13_0.params[1]].cost)
		end
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:UnbindRedPoint()

	if arg_14_0.uiTagList_ then
		arg_14_0.uiTagList_:Dispose()
	end

	Object.Destroy(arg_14_0.gameObject_)
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.BindRedPoint(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.nameText_.transform, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_LOCATION, arg_15_0.locationId_))
end

function var_0_0.UnbindRedPoint(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.nameText_.transform)
end

return var_0_0

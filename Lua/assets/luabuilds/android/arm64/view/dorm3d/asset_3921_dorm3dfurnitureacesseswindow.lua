local Dorm3dFurnitureAcessesWindow = class("Dorm3dFurnitureAcessesWindow", import("view.base.BaseUI"))

function Dorm3dFurnitureAcessesWindow:getUIName()
	return "Dorm3dFurnitureAcessesWindow"
end

function Dorm3dFurnitureAcessesWindow:init()
	return
end

function Dorm3dFurnitureAcessesWindow:didEnter()
	onButton(self, self._tf:Find("Mask"), function()
		existCall(self.contextData.onClose)
		self:closeView()

		return
	end)
	onButton(self, self._tf:Find("Window/Close"), function()
		existCall(self.contextData.onClose)
		self:closeView()

		return
	end, SFX_CANCEL)
	setText(self._tf:Find("Window/Title"), self.contextData.title)
	setText(self._tf:Find("Window/Acesses/Text"), i18n("dorm3d_furniture_window_acesses"))
	self:ShowSingleItemBox(self.contextData)
	self:ShowCommonObtainWindow(self.contextData)

	return
end

function Dorm3dFurnitureAcessesWindow:ShowSingleItemBox(arg_6_1)
	local var_6_0 = self._tf:Find("Window/Icon")

	updateDrop(var_6_0, arg_6_1.drop)
	GetImageSpriteFromAtlasAsync("weaponframes", "dorm3d_" .. ItemRarity.Rarity2Print((arg_6_1.drop:getConfig("rarity"))), var_6_0)
	setText(self._tf:Find("Window/Name"), arg_6_1.name or arg_6_1.drop.cfg.name or "")
	setText(self._tf:Find("Window/Count"), i18n("child_msg_owned", setColorStr(arg_6_1.drop.count, "#39bfff")))
	setText(self._tf:Find("Window/Content"), arg_6_1.drop.cfg.desc)

	return
end

function Dorm3dFurnitureAcessesWindow:ShowCommonObtainWindow(arg_7_1)
	local var_7_0 = defaultValue(arg_7_1.showGOBtn, false)

	self.obtainSkipList = self.obtainSkipList or UIItemList.New(self._tf:Find("Window/List"), self._tf:Find("Window/List"):GetChild(0))

	self.obtainSkipList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = arg_7_1.list[arg_8_1 + 1][2]
			local var_8_1 = arg_7_1.list[arg_8_1 + 1][3]

			arg_8_2:Find("Mask/Text"):GetComponent("ScrollText"):SetText((HXSet.hxLan(arg_7_1.list[arg_8_1 + 1][1])))
			setActive(arg_8_2:Find("Button"), var_7_0 and arg_7_1.list[arg_8_1 + 1][2][1] ~= "" and arg_7_1.list[arg_8_1 + 1][2][1] ~= "COLLECTSHIP")

			if arg_7_1.list[arg_8_1 + 1][2][1] ~= "" then
				onButton(self, arg_8_2:Find("Button"), function()
					if var_8_1 and var_8_1 ~= 0 then
						local var_9_0 = getProxy(ActivityProxy):getActivityById(var_8_1)

						if not var_9_0 or var_9_0:isEnd() then
							pg.TipsMgr.GetInstance():ShowTips(i18n("collection_way_is_unopen"))

							return
						end
					else
						if var_8_0[1] == "SHOP" and var_8_0[2].warp == NewShopsScene.TYPE_MILITARY_SHOP then
							if not pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getData().level, "MilitaryExerciseMediator") then
								pg.TipsMgr.GetInstance():ShowTips(i18n("military_shop_no_open_tip"))

								do return end

								goto label_9_0
							end
						end

						if var_8_0[1] == "LEVEL" and var_8_0[2] then
							local var_9_1 = getProxy(ChapterProxy)
							local var_9_2 = var_9_1:getChapterById(var_8_0[2].chapterid)

							if var_9_2:isUnlock() then
								local var_9_3 = var_9_1:getActiveChapter()

								if var_9_3 and var_9_3.id ~= var_8_0[2].chapterid then
									pg.TipsMgr.GetInstance():ShowTips(i18n("collect_chapter_is_activation"))

									return
								else
									local var_9_4 = {
										mapIdx = var_9_2:getConfig("map")
									}

									if var_9_2.active then
										var_9_4.chapterId = var_9_2.id
									else
										var_9_4.openChapterId = var_8_0[2].chapterid
									end

									pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, var_9_4)
								end
							else
								pg.TipsMgr.GetInstance():ShowTips(i18n("acquisitionmode_is_not_open"))

								return
							end
						elseif var_8_0[1] == "COLLECTSHIP" then
							if arg_7_1.mediatorName == CollectionMediator.__cname then
								pg.m02:sendNotification(CollectionMediator.EVENT_OBTAIN_SKIP, {
									toggle = 2,
									displayGroupId = var_8_0[2].shipGroupId
								})
							else
								pg.m02:sendNotification(GAME.GO_SCENE, SCENE.COLLECTSHIP, {
									toggle = 2,
									displayGroupId = var_8_0[2].shipGroupId
								})
							end
						elseif var_8_0[1] == "SHOP" then
							pg.m02:sendNotification(GAME.GO_SCENE, SCENE[var_8_0[1]], var_8_0[2])
						else
							pg.m02:sendNotification(GAME.GO_SCENE, SCENE[var_8_0[1]], var_8_0[2])
						end
					end

					::label_9_0::

					self:closeView()

					return
				end, SFX_PANEL)
			end
		end

		return
	end)
	self.obtainSkipList:align(#arg_7_1.list)

	return
end

function Dorm3dFurnitureAcessesWindow:willExit()
	return
end

return Dorm3dFurnitureAcessesWindow

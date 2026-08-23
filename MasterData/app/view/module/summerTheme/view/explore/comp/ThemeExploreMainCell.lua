local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = {
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.SUMMER] = 0,
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.GRYPH] = 0,
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.HORUS] = 1,
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.NEWYEAR] = 2,
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.LEVIA] = 3,
	[g.core.const.ConstMgr.ThemeConst.THEME_VALUE.IFURITO] = 4
}
local ThemeExploreMainCell = class("ThemeExploreMainCell", require("app.fairyGUI.summerTheme.UI_ThemeExploreMainCell"))

function ThemeExploreMainCell:playUnlockEff()
	self.m_unlockEffHolder:addEffectSpine({
		remove = true,
		name = "eff_ui_explore_unlock",
		isLoop = false
	})
end

function ThemeExploreMainCell:setCellView(arg_2_1, arg_2_2)
	self.m_typeController:setSelectedIndex((arg_2_2 or nil) and (var_0_1[arg_2_2] or 0))

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_2_0
	self._chapterId = arg_2_1.data.id

	local var_2_1 = g.core.common.Storage:load("theme_explore_unlock_eff.json", true) or {}
	local var_2_2 = arg_2_1.info

	self.m_titleTxt:setText(arg_2_1.info.name)
	self.m_picLoader:setURL(g.core.common.Path:getThemeExplorePic(var_2_2.img))
	self.m_infoComp:updateInfo(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = self._activeThemeValue,
			chapter = arg_2_1.data.id
		}
	})

	if arg_2_1.isOpen then
		self.m_lockController:setSelectedIndex(1)

		local var_2_3, var_2_4, var_2_5 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getChapterRewardBox(arg_2_1.data.id)

		self.m_progressTxt:setText(math.floor(var_2_5 / arg_2_1.data.allBoxNum * 100) .. "%")
		self.m_progress:setMax(arg_2_1.data.allBoxNum)
		self.m_progress:setValue(var_2_5)

		if not var_2_1[var_2_0 .. "_" .. self._chapterId] then
			self.m_unlockEffHolder:addEffectSpine({
				remove = true,
				name = "eff_ui_explore_unlock",
				isLoop = false
			})

			var_2_1[var_2_0 .. "_" .. self._chapterId] = true

			g.core.common.Storage:save("theme_explore_unlock_eff.json", var_2_1, true)
		end
	else
		self.m_lockController:setSelectedIndex(0)

		if arg_2_1.isTimeOpen then
			self.m_lockDesc:setText(g.core.lang:get(405731, {
				name = g.core.config.activity_theme_explore_info.get(arg_2_1.data.perChapterId).name,
				num = g.core.config.activity_theme_explore_info.get(arg_2_1.data.id).pre_reward
			}))
		else
			local var_2_6, var_2_7, var_2_8, var_2_9 = g.core.common.ServerTime:getLeftTimeParts(arg_2_1.data.openTime)

			if var_2_6 >= 1 then
				self.m_lockDesc:setText(g.core.lang:get(405732, {
					num = var_2_6 + 1
				}))
			else
				self.m_lockDesc:setText(g.core.lang:get(405733))
			end
		end
	end
end

function ThemeExploreMainCell:onExpand(arg_3_1)
	self.m_isOpenController:setSelectedIndex(1)
	self.m_closeTransition:stop()

	if arg_3_1 then
		self.m_openTransition:play(arg_3_1)
	else
		self.m_openTransition:play()
	end
end

function ThemeExploreMainCell:onUnExpand(arg_4_1)
	self.m_isOpenController:setSelectedIndex(0)
	self.m_openTransition:stop()

	if arg_4_1 then
		self.m_closeTransition:play(arg_4_1)
	else
		self.m_closeTransition:play()
	end
end

return ThemeExploreMainCell

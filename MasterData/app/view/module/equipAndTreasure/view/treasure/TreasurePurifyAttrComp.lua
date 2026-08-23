local var_0_0 = g.core.model.User.treasureData
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local TreasurePurifyAttrComp = class("TreasurePurifyAttrComp", require("app.fairyGUI.equipAndTreasure.UI_TreasurePurifyAttrComp"))

function TreasurePurifyAttrComp:updatePurifyAttr(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = arg_1_1.holes or {}

	self.m_lockBtn:setTreasureId(arg_1_1.id, arg_1_3)

	local var_1_1 = var_0_0:getCurPurifyOpenNum(arg_1_1.id)[1]

	self.m_attrBg:setURL(TreasureConst.PURIFY_QUALITY.NONE)

	if arg_1_3 <= var_1_1.curNum then
		if var_1_0[arg_1_3] then
			if var_1_0[arg_1_3].tmp and var_1_0[arg_1_3].tmp.id then
				self.m_attrBg:setURL(TreasureConst.PURIFY_QUALITY[var_0_0:getAttrQuality(var_1_0[arg_1_3].tmp.id, var_1_0[arg_1_3].tmp.init_value, var_1_0[arg_1_3].tmp.group)])
			elseif var_1_0[arg_1_3].cur and var_1_0[arg_1_3].cur.id then
				self.m_attrBg:setURL(TreasureConst.PURIFY_QUALITY[var_0_0:getAttrQuality(var_1_0[arg_1_3].cur.id, var_1_0[arg_1_3].cur.init_value, var_1_0[arg_1_3].cur.group)])
			else
				self.m_attrBg:setURL(TreasureConst.PURIFY_QUALITY.NONE)
			end
		end

		if arg_1_2 then
			if var_1_0[arg_1_3] then
				if var_1_0[arg_1_3].lock then
					if var_1_0[arg_1_3].cur.id > 0 then
						self.m_stateController:setSelectedIndex(3)

						local var_1_2, var_1_3 = g.core.lang:getAttr(var_1_0[arg_1_3].cur.id, var_1_0[arg_1_3].cur.init_value)

						self.m_attrName:setText(var_1_2)
						self.m_attrValue:setText(var_1_3)

						local var_1_4, var_1_5 = g.core.lang:getAttr(var_1_0[arg_1_3].cur.id, var_0_0:getAttrPurifyCfg(var_1_0[arg_1_3].cur.id, var_1_0[arg_1_3].cur.group).max_num, true)

						self.m_maxValue:setText(g.core.lang:get(202062, {
							num = var_1_5
						}))
					else
						self.m_stateController:setSelectedIndex(0)
					end
				else
					if arg_1_4 then
						self.m_effholder:addEffectSpine({
							anim = "play",
							name = "eff_ui_purify_txtLine",
							remove = true,
							isLoop = false
						})
					end

					local var_1_6 = var_1_0[arg_1_3].cur
					local var_1_7 = var_1_0[arg_1_3].tmp

					if var_1_0[arg_1_3].cur.id > 0 or var_1_7 and var_1_7.id > 0 then
						local var_1_8 = ""
						local var_1_9 = ""

						if var_1_6.id == 0 then
							var_1_8 = g.core.lang:get(202065)
						else
							var_1_8, var_1_9 = g.core.lang:getAttr(var_1_6.id, var_1_6.init_value)
						end

						local var_1_10 = ""
						local var_1_11 = ""

						if not var_1_7 or var_1_7.id == 0 then
							var_1_10 = g.core.lang:get(202065)
						else
							var_1_10, var_1_11 = g.core.lang:getAttr(var_1_7.id, var_1_7.init_value)
						end

						self.m_stateController:setSelectedIndex(2)
						self.m_curAttrTxt:setText(var_1_8 .. var_1_9)
						self.m_tmpAttrTxt:setText(var_1_10 .. var_1_11)

						local var_1_12 = 0

						var_1_12 = var_1_6.id > 0 and var_0_0:getPurifyScore(var_1_6.id, var_1_6.init_value, var_1_6.group) or 0

						local var_1_13 = 0

						var_1_13 = var_1_7 and var_1_7.id > 0 and var_0_0:getPurifyScore(var_1_7.id, var_1_7.init_value, var_1_7.group) or 0

						if var_1_12 < var_1_13 then
							self.m_isUpStateController:setSelectedIndex(0)
						elseif var_1_13 < var_1_12 then
							self.m_isUpStateController:setSelectedIndex(1)
						else
							self.m_isUpStateController:setSelectedIndex(2)
						end
					else
						self.m_stateController:setSelectedIndex(0)
					end
				end
			else
				self.m_stateController:setSelectedIndex(0)
			end
		elseif var_1_0[arg_1_3] and var_1_0[arg_1_3].cur and var_1_0[arg_1_3].cur.id > 0 then
			self.m_stateController:setSelectedIndex(1)
			self.m_lockBtn:setLock(var_1_0[arg_1_3].lock)

			local var_1_14, var_1_15 = g.core.lang:getAttr(var_1_0[arg_1_3].cur.id, var_1_0[arg_1_3].cur.init_value)

			self.m_attrName:setText(var_1_14)
			self.m_attrValue:setText(var_1_15)

			local var_1_16, var_1_17 = g.core.lang:getAttr(var_1_0[arg_1_3].cur.id, var_0_0:getAttrPurifyCfg(var_1_0[arg_1_3].cur.id, var_1_0[arg_1_3].cur.group).max_num, true)

			self.m_maxValue:setText(g.core.lang:get(202062, {
				num = var_1_17
			}))
		else
			self.m_stateController:setSelectedIndex(0)
		end
	else
		self.m_stateController:setSelectedIndex(4)

		if arg_1_3 <= var_1_1.nextNum then
			self.m_openLockTxt:setText(g.core.lang:get(202063, {
				num = var_1_1.nextOpenLastPurifyNum
			}))
		else
			self.m_openLockTxt:setText(g.core.lang:get(202064))
		end
	end
end

return TreasurePurifyAttrComp

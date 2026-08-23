local var_0_0 = g.core.const.ConstMgr.RecruitConst
local var_0_1 = g.core.model.User.recruitData
local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local RecruitLimitCommonUIPetCfg = require("app.view.module.recruit.const.RecruitLimitCommonUIPetCfg")
local RecruitPetLimitComOneComp = class("RecruitPetLimitComOneComp", require("app.fairyGUI.recruitPet.UI_RecruitPetLimitComOneComp"), RecruitLimitCompBase)

function RecruitPetLimitComOneComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitPetLimitComOneComp)
		RecruitLimitCompBase.ctor(self)
	end

	self._originBtnPos = self.m_knightBtn1:getPosition()
	self._fixed = false
end

function RecruitPetLimitComOneComp:_initKnightTipBtn()
	for iter_2_0, iter_2_1 in ipairs(var_0_1:getDisplayInfoById(self._recruitCfg.id).displays) do
		if not self["m_knightBtn" .. iter_2_0] then
			break
		end

		self["_petId" .. iter_2_0] = iter_2_1.knight_id

		if self["m_knightBtn" .. iter_2_0] then
			self["m_knightBtn" .. iter_2_0]:updateComp(iter_2_1, true, true)
		end
	end
end

function RecruitPetLimitComOneComp:_initOtherUI()
	local var_3_0 = RecruitLimitCommonUIPetCfg.getUICfg(self._recruitCfg.id)

	self.m_titleLoader:setURL(var_3_0.titleRes)

	local var_3_1 = self.m_titleLoader:getPosition()

	self.m_titleLoader:setPosition(cc.pAdd((var_3_0.titleAdpatMode or nil) and self:_getPosXByAdaptMode(var_3_0.titleAdpatMode, self.m_titleLoader), var_3_0.titleOffset))
	self.m_leftBgLoader:setURL(var_3_0.leftBgRes)
	self.m_rightBgLoader:setURL(var_3_0.rightBgRes)
	self.m_limitTipLoader:setURL(var_3_0.limitTimesTipBgRes)

	if var_3_0.limitTimesTipBgOffset then
		self.m_limitTipLoader:setPosition(cc.pAdd(self.m_limitTipLoader:getPosition(), var_3_0.limitTimesTipBgOffset))
	end

	if var_3_0.petBtnAdaptMode then
		local var_3_2 = self:_getPosXByAdaptMode(var_3_0.petBtnAdaptMode, self.m_knightBtn1)

		var_3_2.x = var_3_2.x - self.m_knightBtn1:getSize().width / 2

		self.m_knightBtn1:setPosition(var_3_2)
		self.m_enterTransition:setValue("tipEndPosX", {
			var_3_2.x,
			var_3_2.y
		})
	end

	if var_3_0.petBtnOffset then
		-- block empty
	end

	local var_3_3 = 0

	if var_3_0.showMask and var_3_0.maskImgRes then
		var_3_3 = 1

		self.m_maskLoader:setURL(var_3_0.maskImgRes)
	end

	self.m_isShowMaskController:setSelectedIndex(var_3_3)
	require("app.view.module.recruit.const.RecruitFuncCfg").addBtnTip(self, var_0_0.RECRUIT_TAB_TYPE.PET_TAB)
end

function RecruitPetLimitComOneComp:_getPosXByAdaptMode(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2:getPosition()

	if arg_4_1 == 1 then
		var_4_0.x = arg_4_2:getSize().width / 2
	elseif arg_4_1 == 2 then
		var_4_0.x = self:getSize().width - arg_4_2:getSize().width / 2
	end

	return var_4_0
end

function RecruitPetLimitComOneComp:playRecruitAction(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_5 then
		return
	end

	self._content = arg_5_1
	self._highQuality = 0

	local var_5_0 = true

	for iter_5_0 = 1, #arg_5_1.awards do
		local var_5_1 = g.core.common.Goods:convert(arg_5_1.awards[iter_5_0])
		local var_5_2 = math.min(2, var_5_1.quality)

		if arg_5_1.awards[iter_5_0].type == g.core.common.Goods.TYPE_PET then
			arg_5_1.awards[iter_5_0].isNew = g.core.model.User.recruitData:checkIsNewPet(arg_5_1.awards[iter_5_0].value)
			var_5_2 = var_5_1.quality
			var_5_0 = false
		end

		self._highQuality = math.max(self._highQuality, var_5_2)
		arg_5_1.awards[iter_5_0].quality = var_5_1.quality
		arg_5_1.awards[iter_5_0].id = iter_5_0
	end

	if var_5_0 then
		self._highQuality = math.min(2, self._highQuality)
	end

	arg_5_3:playShow("PetTouchSpineComp", {
		quality = self._highQuality,
		content = self._content
	}, handler(self, self._goToRewardLayer), handler(self, self._goToRewardLayer))
end

function RecruitPetLimitComOneComp:_goToRewardLayer(arg_6_1)
	local var_6_0 = clone(arg_6_1.content)

	var_6_0.cfg = self._recruitCfg
	var_6_0.matchQuality = self._recruitCfg.gacha_display_quality

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_PET_REWARD, var_6_0)
end

function RecruitPetLimitComOneComp:_updateLuck()
	local var_7_0 = g.core.model.User.recruitData:getGuaranteedInfos(self._recruitType, true, true)

	if var_7_0 then
		if self._subComps.curLuckText then
			self._subComps.curLuckText:setText(var_7_0.totalTimes - var_7_0.times)
		end

		if self._subComps.maxLuckText then
			self._subComps.maxLuckText:setText("/" .. var_7_0.totalTimes)
		end

		if self._subComps.extLuckProg then
			self._subComps.extLuckProg:setSize(cc.size((var_7_0.totalTimes - var_7_0.times) / var_7_0.totalTimes * 192, 4))
		end

		if self._subComps.extLuckText then
			local var_7_1 = g.core.model.User.recruitData:getGuaranteedInfoByGuaranteedType(self._recruitType, 7) or {
				times = 0,
				totalTimes = 0
			}
			local var_7_2 = var_7_1.totalTimes - var_7_1.times

			self._subComps.extLuckText:setText(var_7_1.totalTimes - var_7_1.times)
			self._subComps.extLuckIcon:setVisible(false)

			if self._subComps.extLuckLight then
				local var_7_3 = self._subComps.extLuckLight

				self._subComps.extLuckLight:setVisible(var_7_2 > 0)

				self._effLoop = self._effLoop or var_7_3:addEffectSpine({
					isLoop = true,
					name = "eff_ui_recruit_guarantee"
				})
			end
		end
	end
end

return RecruitPetLimitComOneComp

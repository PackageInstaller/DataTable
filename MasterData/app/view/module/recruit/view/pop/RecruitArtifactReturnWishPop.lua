local RecruitWishPopBase = require("app.view.module.recruit.view.pop.RecruitWishPopBase")
local RecruitArtifactReturnWishPop = class("RecruitArtifactReturnWishPop", require("app.fairyGUI.recruitArtifact.UI_RecruitArtifactReturnWishPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitArtifactReturnWishPop",
		pkgPath = "ui/recruitArtifact/recruitArtifact",
		pkgName = "recruitArtifact"
	})
end, RecruitWishPopBase)

function RecruitArtifactReturnWishPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	RecruitWishPopBase.ctor(self, arg_2_1, arg_2_2)

	self._callBack = arg_2_3
end

function RecruitArtifactReturnWishPop:onUnload()
	if self._callBack then
		self._callBack()
	end
end

function RecruitArtifactReturnWishPop:_sort()
	local function var_4_0(arg_5_0, arg_5_1)
		if arg_5_0:getUpValue() ~= arg_5_1:getUpValue() then
			return arg_5_0:getUpValue() > arg_5_1:getUpValue()
		end

		if arg_5_0:getQuality() ~= arg_5_1:getQuality() then
			return arg_5_0:getQuality() > arg_5_1:getQuality()
		end

		if arg_5_0:isOwn() ~= arg_5_1:isOwn() then
			return arg_5_0:isOwn()
		end

		if arg_5_0:getState() ~= arg_5_1:getState() and (arg_5_0:getState() == 1 or arg_5_1:getState() == 1) then
			return arg_5_0:getState() == 1
		end

		return arg_5_0:getId() < arg_5_1:getId()
	end

	for iter_4_0, iter_4_1 in ipairs(self._members) do
		table.sort(iter_4_1, var_4_0)
	end
end

function RecruitArtifactReturnWishPop:_updateOtherUI()
	local var_6_0 = g.core.model.User.recruitData:getDrawInfo(self._recruitId)

	if var_6_0:getRecruitType() == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT then
		self.m_percentComp:updatePercentByPercent(g.core.config.recruit_knight_wish_rule_info.get(g.core.config.recruit_knight_info.get(self._recruitId).wish_rule_id).value / 100)
	end

	local var_6_1 = self.m_memberComp1:getStruct()

	if not var_6_1 then
		return
	end

	var_6_1:setRecruitId(self._recruitId)

	local var_6_2 = var_6_1:getCurLuckTimes(var_6_0)

	self.m_tipText:setText(g.core.lang:get(108707))
	self.m_light:setVisible(var_6_2 > 0)
end

function RecruitArtifactReturnWishPop:_onConfirmBtnClicked()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(self._wishInfos) do
		if type(iter_7_1) ~= type(self._oldWishInfos[iter_7_0]) then
			local var_7_1 = {
				pos = iter_7_0
			}

			if type(iter_7_1) == "table" then
				var_7_1.r_value = iter_7_1.r_value
				var_7_1.r_type = iter_7_1.r_type
			else
				var_7_1.r_value = 0
				var_7_1.r_type = 0
			end

			var_7_0[#var_7_0 + 1] = var_7_1
		elseif type(iter_7_1) == "table" and (iter_7_1.r_value ~= self._oldWishInfos[iter_7_0].r_value or iter_7_1.r_type ~= self._oldWishInfos[iter_7_0].r_type) then
			var_7_0[#var_7_0 + 1] = {
				pos = iter_7_0,
				r_value = iter_7_1.r_value,
				r_type = iter_7_1.r_type
			}
		end
	end

	if not next(var_7_0) then
		if #self._oldWishInfos < 1 or type(self._oldWishInfos[1]) ~= "table" or self._oldWishInfos[1].r_type == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(108713))
		else
			self:_closeByAnim()
		end

		return
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_0) do
		if iter_7_3.r_type == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(108713))

			return
		end
	end

	g.core.network.GameNetProxy:send_C2S_NewRecruit_Luck({
		id = self._recruitId,
		wish = var_7_0
	})
end

return RecruitArtifactReturnWishPop

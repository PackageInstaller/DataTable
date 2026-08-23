local var_0_0 = g.core.const.ConstMgr.DailyRecruitConst
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.recruitData
local DailyRecruitPreviewPop = class("DailyRecruitPreviewPop", require("app.fairyGUI.recruitDaily.UI_DailyRecruitPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "DailyRecruitPreviewPop",
		pkgName = "recruitDaily",
		pkgPath = "ui/recruitDaily/recruitDaily"
	})
end)

function DailyRecruitPreviewPop:ctor()
	self._showList = {}
	self._isInit = false
	self._maxQuality = 0

	self:initData()
	self:initView()
end

function DailyRecruitPreviewPop:initData()
	self._showList = {}

	local var_3_0 = var_0_2:getDailyRecruitInfo()
	local var_3_1 = var_3_0.level

	local function var_3_2(arg_4_0)
		return arg_4_0.if_locked ~= 0 and var_3_1 < arg_4_0.unlock_level
	end

	local var_3_3 = 0

	for iter_3_0, iter_3_1 in g.core.config.daily_recruit_pool_info.ipairs() do
		if iter_3_1.pool_id == var_3_0.pool_show then
			local var_3_4 = var_0_1:convert({
				type = iter_3_1.reward_type,
				value = iter_3_1.reward_value,
				size = iter_3_1.reward_size
			})

			self._showList[var_3_4.quality] = self._showList[var_3_4.quality] or {}

			table.insert(self._showList[var_3_4.quality], {
				info = iter_3_1,
				good = var_3_4,
				isLock = var_3_2(iter_3_1)
			})

			var_3_3 = math.max(var_3_3, var_3_4.quality)
		end
	end

	for iter_3_2, iter_3_3 in pairs(self._showList) do
		table.sort(iter_3_3, function(arg_5_0, arg_5_1)
			if (arg_5_0.isLock and 1 or 0) ~= (arg_5_1.isLock and 1 or 0) then
				return (arg_5_0.isLock and 1 or 0) < (arg_5_1.isLock and 1 or 0)
			end

			return arg_5_0.info.id < arg_5_1.info.id
		end)

		if not var_0_2:isDailyRecruitMaxLevel() then
			table.insert(iter_3_3, {
				isNull = true
			})
		end
	end

	self._maxQuality = var_3_3
end

function DailyRecruitPreviewPop:initView()
	self:showAtCenter()
	self.m_popPanel:setTitle(g.core.lang:get(410003, {
		level = var_0_2:getDailyRecruitInfo().level
	}))
	self.m_showList:setIniter()
	self.m_showList:setItemRenderer(handler(self, self._onShowListRenderer))
end

function DailyRecruitPreviewPop:_onShowListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updatePreviewCell(self._maxQuality - arg_7_1, self._showList[self._maxQuality - arg_7_1] or {})
end

function DailyRecruitPreviewPop:onLoad()
	self:updateView()
end

function DailyRecruitPreviewPop:updateView()
	self.m_showList:setNumItems(self._maxQuality - var_0_0.StartQuality + 1)
end

return DailyRecruitPreviewPop

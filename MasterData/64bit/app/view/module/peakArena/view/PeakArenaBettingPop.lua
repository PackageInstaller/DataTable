local var_0_0 = g.core.config.resource_info
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst.HonorTitleType
local var_0_2 = g.core.lang
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.model.User
local var_0_5 = g.core.model.User.resourceData
local var_0_6 = g.core.model.User.peakArenaData
local var_0_7 = g.core.common.Path
local PeakArenaBettingPop = class("PeakArenaBettingPop", require("app.fairyGUI.peakArena.UI_PeakArenaBettingPop"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaBettingPop",
		pkgName = "peakArena",
		pkgPath = "ui/peakArena/peakArena"
	}, ...)
end)

function PeakArenaBettingPop:ctor(arg_2_1)
	self._userId = arg_2_1
	self._betNum = var_0_6:getMyBetNum(arg_2_1)
	self._ownNum = var_0_5:getResourceById(var_0_3.RESOURCE.TYPE_PA_STARLIGHT_STAMP)
	self._remainBetNum = var_0_6:getRemainBetNum()
	self._honorTitleTypeArr = self:_getHonorTitleArr()
	self._peakStageUserStruct = var_0_6:getPeakStageUserStructWithId(arg_2_1)

	self.m_baseResItemComp:updateResBtn({
		type = var_0_3.TYPE_RESOURCE,
		value = var_0_3.RESOURCE.TYPE_PA_STARLIGHT_STAMP,
		clickFunc = function()
			return
		end
	})
	self.m_betBtn:addClickListener(handler(self, self._onClickBetBtn))
	self.m_payoffList:setVirtual()
	self.m_payoffList:setItemRenderer(handler(self, self._onPayoffListRenderer))
	self.m_userIconComp:setTouchCallFunc(function()
		return
	end)
	self:showAtCenter()
end

function PeakArenaBettingPop:onLoad()
	local var_5_0 = var_0_6:getUserSnapshotWithId(self._userId)

	if self._userId == var_0_4:getId() then
		self.m_userIconComp:updateAsSelf()
	else
		self.m_userIconComp:updateAsUser(var_5_0)
	end

	self.m_nameTxt:setText((var_5_0 or nil) and (var_5_0.name or ""))
	self.m_powerTxt:setText((var_0_2:get(307040, {
		num = (var_5_0 or nil) and (var_5_0.fight_value or 0)
	})))
	self.m_myBetNumTxt:setText((var_0_2:get(307038, {
		num = var_0_6:getMyBetNum(self._userId)
	})))

	local var_5_1 = self:_getCanBetNum()

	self.m_subAddNumComp:initMinMaxNum({
		min = 0,
		max = var_5_1,
		cur = var_5_1,
		callback = handler(self, self._onChangeBetNum)
	})
	self.m_wantBetNumTxt:setText((var_0_2:get(307041, {
		wantBet = var_5_1,
		remain = self._remainBetNum
	})))
	self.m_iconLoader:setURL((var_0_7:getResourceIconById(var_0_0.get(var_0_3.RESOURCE.TYPE_PA_STARLIGHT_STAMP).icon, true)))
	self.m_payoffList:setNumItems(#self._honorTitleTypeArr)
end

function PeakArenaBettingPop:_onS2CPlayBets()
	self.m_baseResItemComp:updateResNum(false)
end

function PeakArenaBettingPop:_onChangeBetNum()
	self.m_wantBetNumTxt:setText((var_0_2:get(307041, {
		wantBet = self.m_subAddNumComp:getCurNum(),
		remain = self._remainBetNum
	})))
	self.m_payoffList:setNumItems(#self._honorTitleTypeArr)
end

function PeakArenaBettingPop:_onPayoffListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell({
		honorTitleType = self._honorTitleTypeArr[arg_8_1 + 1],
		betNum = self._betNum,
		addNum = self.m_subAddNumComp:getCurNum(),
		odds = self._peakStageUserStruct:calcBetOdds(self._honorTitleTypeArr[arg_8_1 + 1]),
		showBg = arg_8_1 % 2 == 0
	})
end

function PeakArenaBettingPop:_onClickBetBtn()
	local var_9_0 = self.m_subAddNumComp:getCurNum()
	local var_9_1 = var_0_0.get(var_0_3.RESOURCE.TYPE_PA_STARLIGHT_STAMP)

	if var_9_0 < 1 then
		g.core.module.ModuleManager:tip(var_0_2:get(307053, {
			resName = var_9_1.name
		}))

		return
	elseif not var_0_6:isBetTime() then
		g.core.module.ModuleManager:tip(var_0_2:get(307054))

		return
	end

	local var_9_2 = self._userId
	local var_9_3 = var_0_6:getUserSnapshotWithId(self._userId).name or ""

	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = var_0_2:get(307051),
		desc = var_0_2:get(307052, {
			num = var_9_0,
			resName = var_9_1.name,
			name = var_9_3
		}),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_PeakArena_PlayBets({
				target = var_9_2,
				bets = var_9_0
			})
			g.core.module.ModuleManager:popModule()
		end
	})))
end

function PeakArenaBettingPop:_getHonorTitleArr()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(var_0_1) do
		if iter_11_1 ~= var_0_1.NONE then
			table.insert(var_11_0, iter_11_1)
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_1 < arg_12_0
	end)

	return var_11_0
end

function PeakArenaBettingPop:_getCanBetNum()
	return math.min(self._ownNum, self._remainBetNum)
end

return PeakArenaBettingPop

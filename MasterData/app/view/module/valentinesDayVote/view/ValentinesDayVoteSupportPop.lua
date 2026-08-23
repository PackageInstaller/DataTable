local ValentinesDayVoteSupportPop = class("ValentinesDayVoteSupportPop", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteSupportPop"), function()
	return fgui.GComponent:create({
		resName = "ValentinesDayVoteSupportPop",
		pkgPath = "ui/valentinesDayVote/valentinesDayVote",
		pkgName = "valentinesDayVote"
	}, ...)
end)
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_2 = g.core.const.ConstMgr.ValentinesDayVoteConst
local var_0_3 = g.core.model.User.valentinesDayVoteData

function ValentinesDayVoteSupportPop:ctor(arg_2_1)
	self:getView():center(true)

	if arg_2_1 then
		self._data = arg_2_1.data or {}
	end

	local var_2_0 = self._data.knight:getBaseInfo()

	self._knightId = self._data.id
	self._type = g.core.common.Goods.TYPE_ITEM
	self._value = g.core.common.Goods.ITEM.TYPE_SUPPORT_TICKET

	self.m_spineComp:removeChildren()
	self.m_spineComp:addChild((DrawKnight.new({
		isShowBg = true,
		resId = var_2_0.res_id
	})))

	local var_2_1 = g.core.config.knight_favorability_info.get(var_2_0.advance_id)

	self.m_ageTxt:setText(var_2_1.age)
	self.m_birthTxt:setText((g.core.lang:get(1057, {
		month = var_2_1.brithday_month,
		day = var_2_1.brithday_day
	})))
	self.m_heightTxt:setText(var_2_1.height .. g.core.lang:get(112005))
	self.m_weightTxt:setText(var_2_1.weight)
	self.m_descriptionTxt:setTitle(var_2_0.description)
	self.m_groupController:setSelectedIndex(var_2_0.group)
	self.m_groupNameTxt:setText((g.core.lang:get(108100 + var_2_0.group)))
	self.m_nameTxt:setText(var_2_0.name)
	self.m_rankTxt:setText(self._data.rank)
	self.m_scoreTxt:setText(self._data.score)
	self.m_ticketTxt:setText(self._data.myScore)
	self.m_voteBtn:addClickListener(handler(self, self._onClickVoteBtn))
	self.m_itemCountComp:addClickListener(handler(self, self._onShowGift))
	self.m_closeBtn:setClickCallBack(handler(self, self._closePop))
	self:_updateVoteNum()
end

function ValentinesDayVoteSupportPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._updateVoteNum), self)
	self.m_enterTransition:play()
end

function ValentinesDayVoteSupportPop:receiveCompEvent(arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or {}
end

function ValentinesDayVoteSupportPop:onUnload()
	return
end

function ValentinesDayVoteSupportPop:_onClickVoteBtn()
	if var_0_3:getActivityStage() ~= var_0_2.ACTIVITY_STAGE.VOTE then
		-- block empty
	end

	local var_6_0 = self.m_addNumComp:getCurNum()

	if var_6_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_Support_Vote({
			knight_id = self._knightId,
			vote_num = var_6_0
		})
		g.core.module.ModuleManager:popByDisplay(self)
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._type,
			value = self._value,
			size = g.core.model.User.bagData:getOwnNum(self._type, self._value)
		})
	end
end

function ValentinesDayVoteSupportPop:_onShowGift()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.valentinesDayVote.view.ValentinesDayVoteGiftPop").new(), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function ValentinesDayVoteSupportPop:_closePop()
	self.m_backTransition:play(handler(self, function()
		g.core.module.ModuleManager:popByDisplay(self)
	end))
end

function ValentinesDayVoteSupportPop:_updateVoteNum()
	local var_10_0 = g.core.model.User.bagData:getOwnNum(self._type, self._value)

	self.m_addNumComp:initMinMaxNum({
		cur = 1,
		min = 1,
		max = math.min(var_10_0, 9999)
	})
	self.m_itemCountComp:updateRes({
		type = self._type,
		value = self._value,
		size = var_10_0
	})
end

return ValentinesDayVoteSupportPop

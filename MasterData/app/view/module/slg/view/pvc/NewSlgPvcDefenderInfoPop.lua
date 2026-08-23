local NewSlgPvcDefenderInfoPop = class("NewSlgPvcDefenderInfoPop", require("app.fairyGUI.newSlg.UI_NewSlgPvcDefenderInfoPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgPvcDefenderInfoPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = g.core.model.User.newSlgData

function NewSlgPvcDefenderInfoPop:ctor(arg_2_1)
	self:showAtCenter()

	self._id = arg_2_1.id
	self._type = arg_2_1.type
	self._txtAuthority = self:getChild("Txt_authority")
	self._titleTxt = self:getChild("titleTxt")
	self._listInfo = self:getChild("List_info")

	self._listInfo:setVirtual(self)
	self._listInfo:setItemRenderer(handler(self, self._onRenderListInfoCell))

	self._defArr = {}

	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))
end

function NewSlgPvcDefenderInfoPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYDEFINFO, handler(self, self._onRcvNewSlgGetCityDefInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSMONSTERTEAM, handler(self, self._onRcvNewSlgGetBossDefInfo), self)

	if self._type == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetCityDefInfo({
			city_id = self._id
		})
	elseif self._type == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS then
		g.core.network.GameNetProxy:send_C2S_NewSlg_BossMonsterTeam({
			boss_id = self._id
		})
	end
end

function NewSlgPvcDefenderInfoPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgPvcDefenderInfoPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgPvcDefenderInfoPop:_updateView()
	local var_6_0 = g.core.lang:get(428876, {
		num1 = #self._defArr,
		num2 = #self._defArr
	})

	self._titleTxt:setText((self._type == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY and var_0_1:isInfiniteCity(self._id) or nil) and g.core.lang:get(428877))

	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(self._defArr) do
		var_6_1 = var_6_1 + iter_6_1.authority
	end

	self._txtAuthority:setText(var_6_1)
	self._listInfo:setNumItems(#self._defArr)
end

function NewSlgPvcDefenderInfoPop:_onRenderListInfoCell(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._defArr[arg_7_1 + 1])
end

function NewSlgPvcDefenderInfoPop:_onRcvNewSlgGetCityDefInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._defArr = arg_8_4.def_teams or {}

	self:_updateView()
end

function NewSlgPvcDefenderInfoPop:_onRcvNewSlgGetBossDefInfo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0_1:getBossInfoById(arg_9_4.boss_id)

	arg_9_4.team.authority = math.floor(var_0_1:getBossTotalAuthority(arg_9_4.boss_id) / var_9_0.num)
	self._defArr = {}

	for iter_9_0 = 1, var_9_0.num do
		table.insert(self._defArr, arg_9_4.team)
	end

	self:_updateView()
end

return NewSlgPvcDefenderInfoPop

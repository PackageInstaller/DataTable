local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local var_0_2 = g.core.model.User.fogNightmareData
local FogNightmareStagePop = class("FogNightmareStagePop", require("app.fairyGUI.fogNightmare.UI_FogNightmareStagePop"), function()
	return fgui.GComponent:create({
		pkgName = "fogNightmare",
		isFullScreen = true,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareStagePop"
	}, ...)
end)

function FogNightmareStagePop:ctor(arg_2_1)
	self._stageStruct = arg_2_1.stage
	self._floorStruct = arg_2_1.floor
	self._firstAwards = self._floorStruct:getFirstAwards()
	self._waves = self._stageStruct:getAllWave()
	self._selectWaves = 0
	self._curShowComp = nil
	self._buffs = {}
	self._childComps = {}

	self:_initView()
	self:showAtCenter()
	self.m_enterTransition:play()
	self.m_effectNode:addEffectSpine({
		name = "eff_ui_fogNightmare_StageTitle",
		isLoop = false,
		anim = "title"
	})
	self.m_effectBg:addEffectSpine({
		name = "eff_ui_fogNightmare_StageBg",
		isLoop = false,
		anim = "bg"
	})
	self.m_knightLoader:setURL((g.core.common.Path:getKnightPicById(arg_2_1.knightResId)))
end

function FogNightmareStagePop:_initView()
	self.m_firstAwardsList:setVirtual(self)
	self.m_firstAwardsList:doFairyBatching(false)
	self.m_firstAwardsList:setItemRenderer(handler(self, self._onRendererAwardItem))
	self.m_buffList:setVirtual(self)
	self.m_buffList:doFairyBatching(false)
	self.m_buffList:setItemRenderer(handler(self, self._onRendererBuffItem))
	self.m_waveList:doFairyBatching(false)
	self.m_waveList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickWaveItem))
	self.m_btnLine:addClickListener(handler(self, self._onLineBtnClicked))
	self.m_btnLoad:addClickListener(handler(self, self._onLoadBtnClicked))
	self.m_btnStage:addClickListener(handler(self, self._onBtnStageClicked))
	self.m_btnPic:addClickListener(handler(self, self._onPicBtnClicked))
	self.m_rewardBtn:addClickListener(handler(self, self._onRewardBtnClicked))
end

function FogNightmareStagePop:_onRendererAwardItem(arg_4_1, arg_4_2)
	local var_4_0 = clone(self._firstAwards[arg_4_1 + 1])

	var_4_0.scaleIndex = 4

	arg_4_2:updateIcon(var_4_0)
end

function FogNightmareStagePop:_onRendererBuffItem(arg_5_1, arg_5_2)
	arg_5_2:updateView(self._buffs[arg_5_1 + 1])
end

function FogNightmareStagePop:_onRendererWaveItem(arg_6_1, arg_6_2)
	arg_6_2:getChild("tipText"):setText(g.core.lang:get(500000 + (arg_6_1 + 1)))
	arg_6_2:setTitle(arg_6_1 + 1)
end

function FogNightmareStagePop:_onClickWaveItem()
	local var_7_0 = self.m_waveList:getSelectedIndex()

	if var_7_0 == self._selectWaves then
		return
	end

	self._selectWaves = var_7_0

	self:_showChildComp(self._selectWaves + 1)
end

function FogNightmareStagePop:_onLineBtnClicked()
	local var_8_0 = var_0_2:getFormationData()

	var_8_0:updateSelectInfos()

	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_0_2:getFormationData():getPoolMember().knights) do
		local var_8_2 = {
			knight = iter_8_1,
			keepsake = iter_8_1:getDevelopStruct(var_0_1.KNIGHT_DEVELOP_KEY.KEEPSAKE)
		}
		local var_8_3

		if iter_8_1:getOwner().id == g.core.model.User:getId() then
			var_8_1[2] = var_8_2
			var_8_3 = 2 + 1
		else
			var_8_1[1] = var_8_2
		end
	end

	var_8_0:updateKnightTempPoss(var_8_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreKnightPoolPop").new({
		showBtn = false,
		lastPoolDatas = var_8_1,
		lineUpMembers = clone(var_8_1)
	}), {
		touchDisappear = true
	})
end

function FogNightmareStagePop:_onLoadBtnClicked()
	g.core.network.GameNetProxy:send_C2S_Fog_Back({
		type = 1,
		floor = self._floorStruct:getFloorId(),
		stage = self._stageStruct:getStageId()
	})
end

function FogNightmareStagePop:_onBtnStageClicked()
	if self._waves[self._selectWaves + 1]:isFinish() then
		g.core.module.ModuleManager:tip(g.core.lang:get(500156))

		return
	end

	self._curShowComp:_doClickAction({
		floor = self._floorStruct,
		stage = self._stageStruct,
		wave = self._selectWaves + 1
	})
end

function FogNightmareStagePop:_onPicBtnClicked()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FOG_NIGHTMARE_KEEPSAKE_BOOK)
end

function FogNightmareStagePop:_onRewardBtnClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareStageRewardPop").new(), {
		touchDisappear = true
	})
end

function FogNightmareStagePop:_addCustomEvent()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, self._checkWavePass, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_BACK, self._onFogBackSucc, self)
end

function FogNightmareStagePop:onLoad()
	self:_addCustomEvent()
	self:updateView()
	self:_checkWavePass()

	if var_0_2:getIsEnterFormation() then
		self:_onResetLeave()
	end
end

function FogNightmareStagePop:_checkWavePass()
	if self._stageStruct:isFinishAllWave() then
		g.core.module.ModuleManager:popByDisplay(self)
	else
		local var_15_0 = self._stageStruct:getCurWaves()
		local var_15_1 = self._selectWaves

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if iter_15_1:getWaveId() - 1 == self._selectWaves then
				var_15_1 = iter_15_1:getWaveId() - 1

				break
			end
		end

		var_15_1 = var_15_1 or var_15_0[1]:getWaveId() - 1
		self._selectWaves = nil

		self.m_waveList:setSelectedIndex(var_15_1)
		self:_onClickWaveItem()
	end
end

function FogNightmareStagePop:_onResetLeave()
	self._curShowComp:_doClickAction({
		floor = self._floorStruct,
		stage = self._stageStruct,
		wave = self._selectWaves + 1
	})
end

function FogNightmareStagePop:updateView()
	local var_17_0 = var_0_2:getTowerData()

	self.m_floorText:setText(g.core.lang:get(500140, {
		floor = self._floorStruct:getFloorId()
	}))

	self._buffs = var_17_0:getAllBuffs((self._stageStruct:getStageId())) or {}
	self._buffs = clone(self._buffs)

	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(self._buffs) do
		local var_17_2 = iter_17_1.buffIds or {}

		for iter_17_2 = 1, #var_17_2 do
			local var_17_3 = clone(iter_17_1)

			var_17_3.buff_id = var_17_2[iter_17_2]

			table.insert(var_17_1, var_17_3)
		end
	end

	self._buffs = var_17_1

	self.m_buffList:setNumItems((table.nums(self._buffs)))
	self.m_firstAwardsList:setNumItems(#self._firstAwards)
	self.m_waveList:setNumItems(#self._waves)
	self.m_waveList:setVisible(#self._waves > 1)
	self.m_proText:setText(var_17_0:getCurrentMaxFloorNum() .. "/" .. #var_17_0:getPhaseRewardData())
end

function FogNightmareStagePop:_showChildComp(arg_18_1)
	if arg_18_1 >= 2 then
		-- block empty
	end

	if self._curShowComp then
		self._curShowComp:setVisible(false)
	end

	local var_18_0 = self._waves[arg_18_1]
	local var_18_1 = self._waves[arg_18_1]:getCurEffects()[1]
	local var_18_2 = var_18_1:getCompName()
	local var_18_3 = self._childComps[var_18_2]

	if not self._childComps[var_18_2] then
		var_18_3 = require("app.view.module.fogNightmare.view.explore.comp.stageWaveComp." .. var_18_2).new()

		self.m_childCompRoot:addChild(var_18_3)

		self._childComps[var_18_2] = var_18_3
	end

	var_18_3:updateComp(var_18_1, #self._waves)
	var_18_3:setVisible(true)

	local var_18_4 = var_18_0:getStageTypeCfg()

	self.m_btnStage:setTitle(var_18_4.btn_str)

	self._curShowComp = var_18_3

	self.m_titleLoader:setURL("ui://text_new/txt_wjmy_guanqia_title" .. var_18_4.id)
	self.m_hasLoadController:setSelectedIndex(var_18_0:canRecall() and 1 or 0)
end

function FogNightmareStagePop:_onFogBackSucc(arg_19_1, arg_19_2, arg_19_3)
	g.core.module.ModuleManager:tip(g.core.lang:get(500196))
	self._stageStruct:revertToStartState()
	self:updateView()
end

function FogNightmareStagePop:receiveCompEvent(arg_20_1, arg_20_2)
	if arg_20_1 == "Event_fog_click_buff_icon" then
		-- block empty
	end
end

return FogNightmareStagePop

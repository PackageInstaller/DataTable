local ServantRankLayer = class("ServantRankLayer", function()
	return cc.Layer:create()
end)
local playermodel = require("model.playermodel")
local servant_data = require("data.servant_data")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local var_0_8 = require("controller.servant_rank_manager").getInstance()
local var_0_9 = config._DEBUG and 0 or 1
local var_0_10 = "role1/"
local var_0_11 = 640
local var_0_13 = 640
local var_0_14 = 128
local var_0_15 = var_0_8.FIGHT_TYPE
local var_0_16 = var_0_8.RANK_TYPE
local var_0_17 = var_0_8.PVP_TYPE
local var_0_18 = var_0_8.RANK_TYPE_SET
local var_0_19 = "servantrank/"
local var_0_20 = {
	{
		on = "servantrank/" .. "btn_score_on.png",
		off = "servantrank/" .. "btn_score_off.png",
		type = var_0_8.PVP_TYPE.SCORE
	},
	{
		on = "servantrank/" .. "btn_arena_on.png",
		off = "servantrank/" .. "btn_arena_off.png",
		type = var_0_8.PVP_TYPE.ARENA
	},
	{
		on = "servantrank/" .. "btn_versus_on.png",
		off = "servantrank/" .. "btn_versus_off.png",
		type = var_0_8.PVP_TYPE.VERSUS
	}
}
local var_0_21 = {
	"servantrank/" .. "img_rare_r.png",
	"servantrank/" .. "img_rare_sr.png",
	"servantrank/" .. "img_rare_ur.png",
	"servantrank/" .. "img_rare_mr.png",
	"servantrank/" .. "img_rare_sp.png"
}
local var_0_22 = {
	"servantrank/" .. "img_first.png",
	"servantrank/" .. "img_second.png",
	"servantrank/" .. "img_third.png"
}
local var_0_23 = {
	DRAK_MATTER = 5,
	LIGHT_ENERGY = 4,
	OTHER = 99,
	QUANTUM = 3,
	IMAGINARY_NUMBER = 6,
	ANTIMATTER = 7,
	MIMESIS = 12,
	THERMAL_ENERGY = 2,
	ELECTROMAGNETISM = 1
}
local var_0_24 = {
	var_0_23.MIMESIS,
	var_0_23.DRAK_MATTER,
	var_0_23.ANTIMATTER,
	var_0_23.QUANTUM,
	var_0_23.LIGHT_ENERGY,
	var_0_23.ELECTROMAGNETISM,
	var_0_23.THERMAL_ENERGY,
	var_0_23.OTHER
}

function ServantRankLayer:create(...)
	local var_2_0 = ServantRankLayer.new(...)

	var_2_0:init(...)

	return var_2_0
end

function ServantRankLayer:init(...)
	self:initData(...)
	self:initUI()
	self:registerEvents()
end

function ServantRankLayer:initData(arg_4_1)
	self.btnPvps = {}
	self.rankDatas = {}
	self.isRequesting = false

	if arg_4_1 then
		self.rankType = arg_4_1.rankType or var_0_16.NORMAL
	end

	if arg_4_1 then
		self.fightType = arg_4_1.fightType or var_0_15.PVE
	end

	if arg_4_1 then
		self.mode = arg_4_1.mode or 0
	end

	if arg_4_1 then
		self.chapter = arg_4_1.chapter or 0
	end

	if arg_4_1 then
		self.pvpType = arg_4_1.pvpType or var_0_17.ARENA
	end

	self.filterTypes = {}

	for iter_4_0, iter_4_1 in ipairs(var_0_24) do
		self.filterTypes[#self.filterTypes + 1] = iter_4_1
	end
end

function ServantRankLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ServantRankLayer.json" or "ServantRankLayer.ExportJson")

	self:addChild(self.rootNode)

	self.rootPanel = self.rootNode:getChildByName("rootPanel")
	self.panelMain = self.rootPanel:getChildByName("panelMain")
	self.imgBg = self.panelMain:getChildByName("imgBg")

	self.imgBg:loadTexture("mainScenebg/bg_servantrank.png")

	self.imgTitle = self.panelMain:getChildByName("imgTitle")
	self.panelTop = self.panelMain:getChildByName("panelTop")

	self.panelTop:getChildByName("imgHorcrux"):setVisible(false)

	self.btnMine = self.imgTitle:getChildByName("btnMine")
	self.btnFilter = self.imgTitle:getChildByName("btnFilter")
	self.btnShop = self.imgTitle:getChildByName("btnShop")
	self.imgBottom = self.panelMain:getChildByName("imgBottom")

	self.imgBottom:setTouchEnabled(true)
	self.imgBottom:setSwallowsTouches(true)
	self.imgBottom:setLocalZOrder(1)

	self.btnExit = self.imgBottom:getChildByName("btnExit")
	self.listViewPvpBtns = self.panelMain:getChildByName("listViewPvpBtns")
	self.listViewRank = self.panelMain:getChildByName("listViewRank")
	self.panelFilter = self.panelMain:getChildByName("panelFilter")
	self.panelFilterInner = self.panelFilter:getChildByName("panel")
	self.panelRankItem = self.panelMain:getChildByName("panelRankItem")

	self.panelRankItem:retain()
	self.panelRankItem:removeFromParent()
	self:initListViewPvp()
	self:fullScreen()

	if self.fightType == var_0_15.PVP then
		self:onBtnPvp(self.btnPvps[self.rankType - 1] or self.btnPvps[1])
	end

	self.listViewPvpBtns:setVisible(self.fightType == var_0_15.PVP)
end

function ServantRankLayer:fullScreen()
	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self.imgTitle:setPositionType(0)
	self.imgTitle:setPositionY(self.imgTitle:getPositionY() - GameDisplay.statusbar_height)
	self.panelTop:setPositionType(0)
	self.panelTop:setPositionY(self.imgTitle:getPositionY() - 160)
end

function ServantRankLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.btnMine, handler(self, self.onBtnMine))
	Utility:addClickEventListener(self.btnFilter, handler(self, self.onBtnFilter))
	Utility:addClickEventListener(self.btnExit, handler(self, self.onBtnExit))
	Utility:addClickEventListener(self.btnShop, handler(self, self.onBtnShop))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_SERVANT_RANK, handler(self, self.handleServantRankList))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_SERVANT_BEST_TEAMMATE, handler(self, self.handleServantBestTeammate))
end

function ServantRankLayer:initListViewPvp()
	self.listViewPvpBtns:removeAllChildren()

	for iter_8_0, iter_8_1 in ipairs(var_0_20) do
		local var_8_0 = ccui.Button:create(iter_8_1.off, iter_8_1.on, iter_8_1.on, var_0_9)

		var_8_0.pvpType = iter_8_1.type

		Utility:addClickEventListener(var_8_0, handler(self, self.onBtnPvp))
		self.listViewPvpBtns:pushBackCustomItem(var_8_0)

		self.btnPvps[#self.btnPvps + 1] = var_8_0
	end

	self.listViewPvpBtns:setSwallowsTouches(true)
	self.listViewPvpBtns:setLocalZOrder(2)
end

function ServantRankLayer:onBtnPvp(arg_9_1)
	if Utility:indexOf(self.btnPvps, arg_9_1) < 0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(self.btnPvps) do
		if arg_9_1 == iter_9_1 then
			iter_9_1:setTouchEnabled(false)
			iter_9_1:setBright(false)
		else
			iter_9_1:setTouchEnabled(true)
			iter_9_1:setBright(true)
		end
	end

	self.rankType = var_0_18[arg_9_1.pvpType]
	self.pvpType = arg_9_1.pvpType

	var_0_8:requestGetServantRank(self.fightType, self.mode, self.chapter, arg_9_1.pvpType, nil, nil)
end

function ServantRankLayer:onBtnMine()
	self.isMine = not self.isMine

	if self.isMine then
		self.btnMine:loadTextures(var_0_19 .. "btn_own_on.png", nil, var_0_19 .. "btn_own_on.png", var_0_9)
	else
		self.btnMine:loadTextures(var_0_19 .. "btn_own_off.png", nil, var_0_19 .. "btn_own_off.png", var_0_9)
	end

	self:filterRankData(var_0_8:getRankDatas(self.rankType, self.mode, self.chapter))
	self:updateTableView()
end

function ServantRankLayer:onBtnFilter()
	if not self.initFilter then
		self:initPanelFilter()

		self.initFilter = true
	end

	self:updatePanelFilter()
	self:showPanelFilter()
end

function ServantRankLayer:initPanelFilter()
	self.panelFilter:setLocalZOrder(5)
	self.panelFilter:setContentSize(GameDisplay.size)
	self.panelFilterInner:setAnchorPoint(0.5, 0.5)
	self.panelFilterInner:setPosition(self.panelMain:getContentSize().width / 2, self.panelMain:getContentSize().height / 2 + 300)

	local var_12_0 = self.panelFilterInner:getChildByName("btnFilter")

	var_12_0:setVisible(false)

	local var_12_1, var_12_2 = var_12_0:getPosition()
	local var_12_3 = var_12_0:getContentSize().width
	local var_12_4 = (self.panelFilterInner:getContentSize().width - var_12_3 * 4) / 5

	for iter_12_0, iter_12_1 in ipairs(var_0_24) do
		local var_12_5 = ccui.Button:create(var_0_19 .. "btn_talent_on.png", nil, var_0_19 .. "btn_talent_on.png", var_0_9)

		var_12_5:setPosition(var_12_4 + var_12_3 / 2 + (iter_12_0 - 1) % 4 * (var_12_4 + var_12_3), var_12_2 - math.floor((iter_12_0 - 1) / 4) * 50)
		self.panelFilterInner:addChild(var_12_5)
		Utility:addClickEventListener(var_12_5, handler(self, self.onBtnFilterPop))
		var_12_5:setName("btn_" .. iter_12_0)
		var_12_5:setTitleFontName("fonts/newkj.ttf")
		var_12_5:setTitleFontSize(24)

		var_12_5.isSelected = true
	end

	Utility:addClickEventListener(self.panelFilter, handler(self, self.onBtnCancel))

	local var_12_6 = self.panelFilterInner:getChildByName("btnCancel")

	var_12_6:setTitleFontName("fonts/newkj.ttf")
	Utility:addClickEventListener(var_12_6, handler(self, self.onBtnCancel))

	local var_12_7 = self.panelFilterInner:getChildByName("btnConfirm")

	var_12_7:setTitleFontName("fonts/newkj.ttf")
	Utility:addClickEventListener(var_12_7, handler(self, self.onBtnConfirm))
end

function ServantRankLayer:onBtnCancel()
	self:hidePanelFilter()
end

function ServantRankLayer:onBtnConfirm()
	self:hidePanelFilter()

	self.filterTypes = {}

	for iter_14_0, iter_14_1 in ipairs(var_0_24) do
		if self.panelFilterInner:getChildByName("btn_" .. iter_14_0).isSelected then
			self.filterTypes[#self.filterTypes + 1] = iter_14_1
		end
	end

	self:filterRankData(var_0_8:getRankDatas(self.rankType, self.mode, self.chapter))
	self:updateTableView()
end

function ServantRankLayer:updatePanelFilter()
	for iter_15_0, iter_15_1 in ipairs(var_0_24) do
		local var_15_0 = self.panelFilterInner:getChildByName("btn_" .. iter_15_0)
		local var_15_1 = Utility:indexOf(self.filterTypes, iter_15_1)

		var_15_0:setTitleText(L_SORT_ATTR[iter_15_1] or "其他")

		if var_15_1 > 0 then
			var_15_0:loadTextures(var_0_19 .. "btn_talent_on.png", nil, var_0_19 .. "btn_talent_on.png", var_0_9)
			var_15_0:setTitleColor(cc.c3b(0, 0, 0))

			var_15_0.isSelected = true
		else
			var_15_0:loadTextures(var_0_19 .. "btn_talent_off.png", nil, var_0_19 .. "btn_talent_off.png", var_0_9)
			var_15_0:setTitleColor(cc.c3b(255, 255, 255))

			var_15_0.isSelected = false
		end
	end
end

function ServantRankLayer:showPanelFilter()
	self.panelFilter:setVisible(true)
	self.panelFilterInner:setScale(1, 0)
	self.panelFilterInner:runAction(cc.Spawn:create(cc.ScaleTo:create(0.2, 1, 1), cc.FadeIn:create(0.2)))
end

function ServantRankLayer:hidePanelFilter()
	self.panelFilter:setVisible(false)
end

function ServantRankLayer:onBtnFilterPop(arg_18_1)
	arg_18_1.isSelected = not arg_18_1.isSelected

	if arg_18_1.isSelected then
		arg_18_1:loadTextures(var_0_19 .. "btn_talent_on.png", nil, var_0_19 .. "btn_talent_on.png", var_0_9)
		arg_18_1:setTitleColor(cc.c3b(0, 0, 0))
	else
		arg_18_1:loadTextures(var_0_19 .. "btn_talent_off.png", nil, var_0_19 .. "btn_talent_off.png", var_0_9)
		arg_18_1:setTitleColor(cc.c3b(255, 255, 255))
	end
end

function ServantRankLayer:onBtnExit()
	KeyCodeManager:onKeyReleasedCallFunc()
end

function ServantRankLayer:onBtnShop()
	LayerManager:switchShowLayer("MarketLayer", {})
end

function ServantRankLayer:filterRankData(arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_1 = not (self.isMine and not playermodel.haveServant[iter_21_1.servantId])

		if var_21_1 and not self:judgeTypeFixed(iter_21_1.servantId) then
			var_21_1 = false
		end

		if var_21_1 then
			var_21_0[#var_21_0 + 1] = iter_21_1
		end
	end

	self.rankDatas = var_21_0
end

function ServantRankLayer:judgeTypeFixed(arg_22_1)
	local var_22_0 = global_get_model_attr(servant_data[arg_22_1].modelid)
	local var_22_1 = false

	for iter_22_0, iter_22_1 in ipairs(self.filterTypes) do
		if iter_22_1 == var_0_23.OTHER then
			for iter_22_2, iter_22_3 in pairs(ATTR_ID) do
				if iter_22_3 == var_22_0 and Utility:indexOf(var_0_24, iter_22_2) < 0 then
					var_22_1 = true

					break
				end
			end
		end

		if ATTR_ID[iter_22_1] == var_22_0 then
			var_22_1 = true

			break
		end
	end

	return var_22_1
end

function ServantRankLayer:initTableView()
	self.tableView = cc.TableView:create(cc.size(var_0_11, self.listViewRank:getContentSize().height + GameDisplay.height - GameDisplay.origin_design_y - 10))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setDelegate()
	self.tableView:setPosition(self.listViewRank:getPosition())
	self.panelMain:addChild(self.tableView)
	self.tableView:registerScriptHandler(handler(self, self.numberOfCells), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(handler(self, self.cellSizeForIndex), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(handler(self, self.updateCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:setLocalZOrder(0)
	self.tableView:reloadData()
end

function ServantRankLayer:updateTableView()
	if not self.tableView then
		self:initTableView()
	end

	self.tableView:reloadData()
end

function ServantRankLayer:numberOfCells(arg_25_1)
	return #self.rankDatas
end

function ServantRankLayer:cellSizeForIndex(arg_26_1, arg_26_2)
	return var_0_13, var_0_14
end

function ServantRankLayer:tabelViewDidScroll(arg_27_1)
	return
end

function ServantRankLayer:updateCellAtIndex(arg_28_1, arg_28_2)
	local var_28_0 = arg_28_1:dequeueCell()
	local var_28_1 = true

	if not var_28_0 then
		var_28_0 = cc.TableViewCell:create()
		var_28_1 = false
	end

	if var_28_1 then
		self:updateOneItem(var_28_0, arg_28_2)
	else
		self:createOneItem(var_28_0, arg_28_2)
	end

	return var_28_0
end

function ServantRankLayer:createOneItem(arg_29_1, arg_29_2)
	local var_29_0 = self.panelRankItem:clone()

	var_29_0:setName("panelRankItem")
	var_29_0:setPositionY(8)
	var_29_0:setSwallowsTouches(false)

	local var_29_1 = var_29_0:getChildByName("labelRank")

	var_29_1:setFontName("fonts/newkj.ttf")
	var_29_1:setFontSize(25)

	local var_29_2 = var_29_0:getChildByName("labelName")

	var_29_2:setFontName("fonts/number.ttf")
	var_29_2:setFontSize(25)

	local var_29_3 = var_29_0:getChildByName("labelScore")

	var_29_3:setFontName("fonts/number.ttf")
	var_29_3:setFontSize(24)
	var_29_3:setPositionX(var_29_3:getPositionX() - 15)
	var_29_0:getChildByName("imgHorcrux"):setVisible(false)
	var_29_0:getChildByName("listViewStars"):setVisible(false)

	local var_29_4 = var_29_0:getChildByName("imgServant")
	local var_29_5 = var_29_0:getChildByName("imgCareer")
	local var_29_6 = var_29_0:getChildByName("imgRare")
	local var_29_7 = var_29_0:getChildByName("labelName")
	local var_29_8 = var_29_0:getChildByName("labelScore")

	var_29_4:setPositionX(var_29_4:getPositionX() + 30)
	var_29_5:setPositionX(var_29_5:getPositionX() + 100)
	var_29_6:setPositionX(var_29_6:getPositionX() + 100)
	var_29_7:setPositionX(var_29_7:getPositionX() + 100)
	arg_29_1:addChild(var_29_0)
	self:updateOneItem(arg_29_1, arg_29_2)
end

function ServantRankLayer:updateOneItem(arg_30_1, arg_30_2)
	local var_30_0 = self.rankDatas[arg_30_2 + 1]
	local var_30_1 = arg_30_1:getChildByName("panelRankItem")

	if not self.rankDatas[arg_30_2 + 1] then
		var_30_1:setVisible(false)
	else
		var_30_1:setVisible(true)
	end

	local var_30_2 = var_30_1:getChildByName("imgBorder")
	local var_30_3 = var_30_1:getChildByName("labelRank")
	local var_30_4 = var_30_1:getChildByName("imgRank")
	local var_30_5 = var_30_1:getChildByName("imgServant")
	local var_30_6 = var_30_1:getChildByName("imgHorcrux")
	local var_30_7 = var_30_1:getChildByName("imgCareer")
	local var_30_8 = var_30_1:getChildByName("imgRare")
	local var_30_9 = var_30_1:getChildByName("labelName")

	var_30_1:getChildByName("labelScore"):setString("" .. (var_30_0.score or 0))
	var_30_4:setVisible(var_30_0.rank < 4)
	var_30_3:setVisible(var_30_0.rank > 3)
	var_30_3:setString("" .. var_30_0.rank)

	if var_30_0.rank < 4 then
		var_30_4:loadTexture(var_0_22[var_30_0.rank], var_0_9)
	end

	self:updateRankAni(var_30_1, var_30_0)

	local var_30_10 = var_30_0.servantId
	local var_30_11

	if var_30_0.horcruxId and var_30_0.horcruxId ~= 0 then
		var_30_11 = var_30_0.horcruxId or 30517005

		if not var_30_10 or not servant_data[var_30_10] or not servant_data[var_30_10].modelid then
			print("miss servant mode data", var_30_10)
		elseif model_data[servant_data[var_30_10].modelid] then
			var_30_5:loadTexture(var_0_10 .. model_data[servant_data[var_30_10].modelid].cute_Q .. ".png")
			var_30_8:loadTexture(var_0_21[servant_data[var_30_10].roll_rarity or 1], var_0_9)
			var_30_7:loadTexture(CAREER_ICON[servant_data[var_30_10].career .. "_" .. global_get_model_attr(servant_data[var_30_10].modelid)], var_0_9)
			var_30_9:setString(major_factor_data[servant_data[var_30_10].major].easy_name)
		end
	end

	print("miss mode id", servant_data[var_30_10].modelid)

	if not var_30_11 or not horcrux_data[var_30_11] or not horcrux_data[var_30_11].model then
		print("miss horcrux mode data", var_30_11)
	elseif model_data[horcrux_data[var_30_11].model].cute_Q then
		var_30_6:loadTexture(var_0_10 .. model_data[horcrux_data[var_30_11].model].cute_Q .. ".png")
		self:updateHorcruxStars(var_30_1, 5)
	else
		print("miss mode id", horcrux_data[var_30_11].model)
	end

	Utility:addClickEventListener(var_30_1, handler(self, self.onPanelRankItem), var_30_0.servantId)
end

function ServantRankLayer:updateRankAni(arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1:getChildByName("imgRank")
	local var_31_1 = var_31_0:getChildByName("imgCrown")

	if not var_31_1 then
		var_31_1 = ccui.ImageView:create("servantrank/img_crown.png", var_0_9)

		var_31_1:setPosition(var_31_0:getContentSize().width / 2 - 5, var_31_0:getContentSize().height + 8)
		var_31_0:addChild(var_31_1)
		var_31_1:setName("imgCrown")
	end

	if arg_31_2.rank == 1 then
		var_31_1:setVisible(true)
		var_31_1:stopAllActions()
		var_31_1:setPosition(var_31_0:getContentSize().width / 2 - 5, var_31_0:getContentSize().height + 8)
		var_31_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(0, 4)), cc.MoveBy:create(0.5, cc.p(0, -4)))))
	else
		var_31_1:setVisible(false)
	end
end

function ServantRankLayer:updateHorcruxStars(arg_32_1, arg_32_2)
	local var_32_0 = arg_32_1:getChildByName("listViewStars")

	var_32_0:setClippingEnabled(false)
	var_32_0:setItemModel((var_32_0:getChildByName("imgStar")))
	var_32_0:removeAllChildren()

	for iter_32_0 = 1, arg_32_2 - 1 do
		var_32_0:pushBackDefaultItem()
	end
end

function ServantRankLayer:onPanelRankItem(arg_33_1, arg_33_2)
	LayerManager:pushInLayer("PopBestTeammatesLayer", {
		servantId = arg_33_2,
		fightType = self.fightType,
		rankType = self.rankType,
		mode = self.mode,
		chapter = self.chapter,
		pvpType = self.pvpType
	})
end

function ServantRankLayer:onEnter()
	if self.fightType == var_0_15.PVE then
		var_0_8:requestGetServantRank(self.fightType, self.mode, self.chapter, self.pvpType, 0, nil)
	end
end

function ServantRankLayer:onExit()
	self.panelRankItem:release()
	EventManager:unsubscribe(self)
end

function ServantRankLayer:handleServantRankList(arg_36_1)
	self.isRequesting = false

	if not arg_36_1 then
		return
	end

	if arg_36_1.result == 1 then
		var_0_8:updateRankDatas(self.rankType, arg_36_1.rankitems, self.mode, self.chapter)
		self:filterRankData(var_0_8:getRankDatas(self.rankType, self.mode, self.chapter))
		self:updateTableView()
	else
		global_ShowBlockWords("参数错误")
	end
end

function ServantRankLayer:handleServantBestTeammate(arg_37_1)
	return
end

return ServantRankLayer

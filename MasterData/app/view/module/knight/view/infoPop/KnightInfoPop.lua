local var_0_0 = g.core.model.User.knightsData
local var_0_2 = g.core.const.ConstMgr.SpineConst
local KnightInfoPop = class("KnightInfoPop", require("app.fairyGUI.knight.UI_KnightInfoPop"), function()
	return fgui.GComponent:create({
		resName = "KnightInfoPop",
		pkgPath = "ui/knight/knight",
		isFullScreen = true,
		pkgName = "knight"
	}, ...)
end)

function KnightInfoPop:ctor(arg_2_1)
	if arg_2_1.knightAdvId then
		self._knightStruct = var_0_0:getKnight({
			advance_id = arg_2_1.knightAdvId
		})
	elseif arg_2_1.knightId then
		self._knightStruct = g.core.model.User.knightsData:getKnight({
			base_id = arg_2_1.knightId
		})
	elseif arg_2_1.knightStruct then
		self._knightStruct = arg_2_1.knightStruct
		self._matchInfos = arg_2_1.matchInfos
		self._knightPos = arg_2_1.knightPos
	end

	self._isOthers = arg_2_1.isOthers or false

	self:showAtCenter()
	self:_updateView()
end

function KnightInfoPop:onLoad()
	self:_updateView()
end

function KnightInfoPop:_updateView()
	if not self._knightStruct then
		return
	end

	local var_4_0 = self._knightStruct
	local var_4_1 = self._knightStruct:getBaseInfo()
	local var_4_2

	if self._isOthers then
		var_4_2 = fgui.UIPackage:createObject("knight", "BaseKnightNameComp")

		var_4_2:updateComp(var_4_0)
	else
		var_4_2 = fgui.UIPackage:createObject("knight", "KnightInfoPopNameComp")

		var_4_2:setKnight(var_4_0)
	end

	local var_4_3 = var_4_0:getSkin()
	local var_4_4 = var_4_3 ~= 0 and var_4_3 or var_4_1.res_id
	local var_4_5

	if g.core.utils.Rule.isKnightDetailPopUseSpine() and g.core.config.knight_info.fetch(var_4_4) then
		var_4_5 = require("app.view.common.DrawKnight").new({
			isShowBg = false,
			baseId = var_4_4
		})

		var_4_5:setScale(0.8)
	else
		var_4_5 = fgui.UIPackage:createObject("base_new", "BaseKnightPicComp")

		var_4_5:updateKnight({
			resId = var_4_4
		})
		var_4_5:setAlphaRect(var_0_2.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
		var_4_5:setPivot(0.5, 0.5, true)
	end

	self.m_infoPopBase:setPopView({
		quality = var_4_0:getQuality(),
		tabParam = {
			{
				package = "knight",
				compName = "KnightInfoPopInfoComp",
				title = g.core.lang:get(201097),
				selfParam = {
					isOther = self._isOthers,
					knightPos = self._knightPos
				}
			},
			{
				package = "knight",
				compName = "KnightInfoPopTalentComp",
				title = g.core.lang:get(201019)
			},
			{
				package = "knight",
				compName = "KnightInfoPopAssctComp",
				title = g.core.lang:get(201020),
				selfParam = self._matchInfos
			}
		},
		commonParam = var_4_0,
		itemComp = var_4_5,
		nameComp = var_4_2
	})
end

return KnightInfoPop

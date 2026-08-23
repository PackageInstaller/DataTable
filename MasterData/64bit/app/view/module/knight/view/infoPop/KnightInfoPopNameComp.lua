local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.config.fragment_info
local var_0_4 = g.core.common.Path
local KnightInfoPopNameComp = class("KnightInfoPopNameComp", require("app.fairyGUI.knight.UI_KnightInfoPopNameComp"))

function KnightInfoPopNameComp:ctor()
	self._classical = 0
	self._fragmentId = nil

	self.m_addBtn:addClickListener(handler(self, self._onAddClick))
	self.m_touchRect:addClickListener(handler(self, self._onAddClick))
	self.m_elementLoader:addClickListener(handler(self, self._onClickElemDetail))
end

function KnightInfoPopNameComp:setKnight(arg_2_1)
	local var_2_0 = arg_2_1:getBaseInfo()
	local var_2_1 = arg_2_1:isOwn()

	self.m_stateController:setSelectedIndex(0)

	local var_2_2 = var_2_0.name

	if arg_2_1:isMain() then
		var_2_2 = arg_2_1:getIsOtherUser() and arg_2_1:getOtherUserName() or g.core.model.User:getName()
	end

	if var_2_1 then
		self.m_nameComp:updateNameComp({
			starTag = 0,
			name = var_2_2,
			quality = var_2_0.quality,
			maxStar = var_0_2.STAR_MAX,
			curStar = var_2_0.star,
			addNum = arg_2_1:getAdvStageAndLevel(),
			classical = var_2_0.classical,
			knightCfg = var_2_0
		})

		self._classical = 0
	else
		self.m_nameComp:updateNameComp({
			name = var_2_2,
			quality = var_2_0.quality,
			maxStar = var_0_2.STAR_MAX,
			curStar = var_2_0.star
		})
		self.m_stateController:setSelectedIndex(2)
		self.m_nameTxt:setText(var_2_2)
		self.m_qualityIcon:setURL(var_0_4:getQualityArtTxtURL(var_2_0.quality))

		self._knightCfg = var_2_0
		self._classical = var_2_0.classical

		if self._classical ~= 0 then
			self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(self._classical))
		else
			self.m_elementLoader:setURL("")
		end
	end

	if not arg_2_1:isMain() and not arg_2_1:isMaxStar() then
		local var_2_3
		local var_2_4

		if var_2_0.type == 1 then
			var_2_3 = 0
			var_2_4 = 0
		elseif var_2_1 then
			local var_2_6

			var_2_6, var_2_3, var_2_4 = arg_2_1:canStarUp()
		else
			local var_2_8

			var_2_8, var_2_3, var_2_4 = arg_2_1:canCompose()
		end

		self.m_progTxt:setText(var_2_3 .. "/" .. var_2_4)
		self.m_progBar:setPercent({
			cur = var_2_3,
			max = var_2_4
		})

		self._fragmentId = var_2_0.fragment_id

		self.m_fragIcon:setURL((var_0_4:getIconByTypeValue(g.core.common.Goods.TYPE_FRAGMENT, self._fragmentId, true)))
		self.m_fragName:setText(var_0_3.get(self._fragmentId).name)
	else
		self.m_stateController:setSelectedIndex(1)
	end

	self.m_isElementLeaderController:setSelectedIndex(arg_2_1:isElementLeader() and 1 or 0)
end

function KnightInfoPopNameComp:_onAddClick()
	if self._fragmentId then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_0_1.TYPE_FRAGMENT,
			value = self._fragmentId,
			size = var_0_0:getOwnNum(var_0_1.TYPE_FRAGMENT, self._fragmentId)
		})
	end
end

function KnightInfoPopNameComp:setIsOthers(arg_4_1)
	if arg_4_1 == 0 then
		self.m_isOtherController:setSelectedIndex(0)
	else
		self.m_isOtherController:setSelectedIndex(1)
	end
end

function KnightInfoPopNameComp:_onClickElemDetail()
	if self._classical == 0 or not self._knightCfg then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.BaseClassicalDetailPop").new({
		classical = self._classical,
		knightCfg = self._knightCfg
	})))
end

return KnightInfoPopNameComp

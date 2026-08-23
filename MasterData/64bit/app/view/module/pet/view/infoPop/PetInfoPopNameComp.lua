local var_0_0 = g.core.model.User.bagData
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr.PetConst
local var_0_3 = g.core.config.fragment_info
local var_0_4 = g.core.common.Path
local PetInfoPopNameComp = class("PetInfoPopNameComp", require("app.fairyGUI.pet.UI_PetInfoPopNameComp"))

function PetInfoPopNameComp:ctor()
	self._fragmentId = nil

	self.m_addBtn:addClickListener(handler(self, self._onAddClick))
	self.m_touchRect:addClickListener(handler(self, self._onAddClick))
end

function PetInfoPopNameComp:setPet(arg_2_1)
	local var_2_0 = arg_2_1:getCfg()
	local var_2_1 = arg_2_1:isOwn()

	self.m_stateController:setSelectedIndex(0)

	if var_2_1 then
		self.m_nameComp:updateNameComp({
			starTag = 0,
			name = var_2_0.name,
			quality = var_2_0.quality,
			maxStar = var_0_2.STAR_MAX,
			curStar = var_2_0.star,
			addNum = arg_2_1:getBigSmallStage()
		})
	else
		self.m_stateController:setSelectedIndex(2)
		self.m_nameTxt:setText(var_2_0.name)
		self.m_qualityIcon:setURL(var_0_4:getQualityArtTxtURL(var_2_0.quality))
	end

	if not arg_2_1:isMaxStar() then
		local var_2_2
		local var_2_3

		if var_2_1 then
			local var_2_5

			var_2_5, var_2_2, var_2_3 = arg_2_1:canStarUp()
		else
			local var_2_7

			var_2_7, var_2_2, var_2_3 = arg_2_1:isComposeEnable()
		end

		self.m_progTxt:setText(var_2_2 .. "/" .. var_2_3)
		self.m_progBar:setPercent({
			cur = var_2_2,
			max = var_2_3
		})

		self._fragmentId = var_2_0.fragment_id

		self.m_fragIcon:setURL((var_0_4:getIconByTypeValue(g.core.common.Goods.TYPE_FRAGMENT, self._fragmentId, true)))
		self.m_fragName:setText(var_0_3.get(self._fragmentId).name)
	else
		self.m_stateController:setSelectedIndex(1)
	end
end

function PetInfoPopNameComp:_onAddClick()
	if self._fragmentId then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_0_1.TYPE_FRAGMENT,
			value = self._fragmentId,
			size = var_0_0:getOwnNum(var_0_1.TYPE_FRAGMENT, self._fragmentId)
		})
	end
end

function PetInfoPopNameComp:setIsOthers(arg_4_1)
	if arg_4_1 == 0 then
		self.m_isOtherController:setSelectedIndex(0)
	else
		self.m_isOtherController:setSelectedIndex(1)
	end
end

return PetInfoPopNameComp

local var_0_0 = g.core.module.ModuleManager
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_2 = g.core.model.User.explorationData
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.common.Path
local ExplorationBagCardCell = class("ExplorationBagCardCell", require("app.fairyGUI.exploration.UI_ExplorationBagCardCell"))

function ExplorationBagCardCell:ctor()
	self:addClickListener(handler(self, self._onClickStruct))
end

function ExplorationBagCardCell:_onClickStruct()
	local var_2_0 = self.m_showTypeController:getSelectedIndex()

	if var_2_0 == var_0_3.ExplorationConst.BAG_TYPE.KNIGHT then
		var_0_0:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightStruct = self._struct
		}), {
			touchDisappear = true
		})
	elseif var_2_0 == var_0_3.ExplorationConst.BAG_TYPE.ARTIFACT then
		var_0_0:pushPopup(require("app.view.module.artifact.view.ArtifactInfoPop").new({
			onlyId = self._struct:getServerOnlyId()
		}), {
			touchDisappear = true
		})
	elseif var_2_0 == var_0_3.ExplorationConst.BAG_TYPE.UNITE_TOKEN then
		var_0_0:pushPopup(require("app.view.module.uniteToken.view.UniteTokenInfoPop").new({
			tokenData = self._struct
		}), {
			touchDisappear = true,
			hideContinue = true
		})
	elseif var_2_0 == var_0_3.ExplorationConst.BAG_TYPE.PET then
		var_0_0:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
			petStruct = self._struct
		}), {
			touchDisappear = true,
			hideContinue = true
		})
	end
end

function ExplorationBagCardCell:updateByKnight(arg_3_1)
	self._struct = arg_3_1

	self.m_showTypeController:setSelectedIndex(var_0_3.ExplorationConst.BAG_TYPE.KNIGHT)
	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_3_1:getBaseInfo().classical))
	self.m_cardIcon:setIcon(var_0_4:getKnightBookPicRes(arg_3_1:getResInfo().painted_id))
	self.m_starComp:initStar({
		index = 3,
		style = 1,
		num = arg_3_1:getStarLv(),
		max = var_0_3.KNIGHT_CONST.STAR_MAX
	})
	self.m_isUsingController:setSelectedIndex(var_0_2:getFormationData():isUsingKnight(arg_3_1:getServerId()) and 1 or 0)
	self:_updateQuality(arg_3_1:getQuality())
	self:_updateIsHelp(var_0_2:getFormationData():isOtherUserKnight(arg_3_1:getServerId()))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			sid = arg_3_1:getServerId()
		}
	})
end

function ExplorationBagCardCell:updateByArtifact(arg_4_1)
	self._struct = arg_4_1

	self.m_isUsingController:setSelectedIndex(var_0_2:getFormationData():isUsingArtifact(arg_4_1:getServerOnlyId()) and 1 or 0)
	self.m_showTypeController:setSelectedIndex(var_0_3.ExplorationConst.BAG_TYPE.ARTIFACT)
	self.m_cardIcon:setIcon(var_0_4:getArtifactRebornImg(arg_4_1:getCfg().res_id))
	self.m_starComp:initStar({
		index = 3,
		style = 1,
		num = arg_4_1:getStar(),
		max = arg_4_1:getMaxStar()
	})
	self:_updateQuality(arg_4_1:getQuality())
	self:_updateIsHelp(false)
end

function ExplorationBagCardCell:updateByUniteToken(arg_5_1)
	self._struct = arg_5_1

	self.m_isUsingController:setSelectedIndex(var_0_2:getFormationData():isUsingUniteToken(arg_5_1:getAdvanceId()) and 1 or 0)
	self.m_showTypeController:setSelectedIndex(var_0_3.ExplorationConst.BAG_TYPE.UNITE_TOKEN)
	self.m_cardIcon:setIcon(var_0_4:getUniteTokenCardImg(arg_5_1:getCfg().res_id))
	self.m_starComp:initStar({
		index = 3,
		style = 1,
		num = arg_5_1:getStarLevel(),
		max = var_0_3.UniteTokenConst.STAR_MAX
	})
	self:_updateQuality(arg_5_1:getQuality())
	self:_updateIsHelp(false)
end

function ExplorationBagCardCell:updateByPet(arg_6_1)
	self._struct = arg_6_1

	self.m_isUsingController:setSelectedIndex(var_0_2:getFormationData():isUsingPet(arg_6_1:getSid()) and 1 or 0)
	self.m_showTypeController:setSelectedIndex(var_0_3.ExplorationConst.BAG_TYPE.PET)
	self.m_cardIcon:setIcon(var_0_4:getPetPictorialBook(arg_6_1:getCfg().resource))
	self.m_starComp:initStar({
		index = 3,
		style = 1,
		num = arg_6_1:getStarNum(),
		max = var_0_3.PetConst.STAR_MAX
	})
	self:_updateQuality(arg_6_1:getQuality())
	self:_updateIsHelp(false)
end

function ExplorationBagCardCell:_updateQuality(arg_7_1)
	self.m_quality:setURL(var_0_4:getExplorationShowCardQuality(arg_7_1))
end

function ExplorationBagCardCell:_updateIsHelp(arg_8_1)
	self.m_isHelpController:setSelectedIndex(arg_8_1 and 1 or 0)
end

return ExplorationBagCardCell

local var_0_0 = g.core.model.User.fogNightmareData
local PetConst = require("app.view.module.pet.const.PetConst")
local FogNightmareExploreLineUpPetComp = class("FogNightmareExploreLineUpPetComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreLineUpPetComp"))

function FogNightmareExploreLineUpPetComp:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
end

function FogNightmareExploreLineUpPetComp:updateComp(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.m_petIcon:updateIcon({
			struct = arg_2_1
		})
		self.m_nameText:setText(arg_2_1:getCfg().name)

		local var_2_0 = arg_2_2.curFormation
		local var_2_1, var_2_2

		if not arg_2_2.curFormation then
			var_2_0 = 0
			var_2_1 = var_0_0:getFormationData()
			var_2_2 = arg_2_1
		end

		self.m_stateController:setSelectedIndex(var_2_1:checkPetInAllFormation(var_2_2, g.core.config.multi_team_formation_info.get(g.core.const.ConstMgr.LineUpConst.MulTeamType.FOG_NIGHTMARE).pet_repeat == 1 and var_2_0 or nil) and 1 or 0)
		self.m_starComp:initStar({
			gap = 0,
			style = 1,
			index = 3,
			num = arg_2_1:getStarNum(),
			max = PetConst.STAR_MAX
		})
	end
end

return FogNightmareExploreLineUpPetComp

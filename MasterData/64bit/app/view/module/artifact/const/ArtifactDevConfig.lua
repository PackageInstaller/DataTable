local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")

return {
	DEV_LIST = {
		[ArtifactConst.DEV_TYPE.INFO] = {
			compNew = "artifact/ArtifactBaseInfoComp",
			title = g.core.lang:get(205501),
			cond = function()
				return "", true
			end,
			show = function()
				return true
			end,
			index = ArtifactConst.DEV_TYPE.INFO,
			resInfoId = {
				83,
				84
			}
		},
		[ArtifactConst.DEV_TYPE.ENHANCE] = {
			compNew = "artifact/ArtifactStrengthenComp",
			title = g.core.lang:get(205502),
			cond = function()
				if g.core.config.function_info.fetch(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_ENHANCE) then
					return g.core.common.ModuleUnlock:getUnlockComment(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_ENHANCE)
				else
					g.core.module.ModuleManager:tip("no functionId: " .. g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_ENHANCE)

					return "", true
				end
			end,
			show = function()
				return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_ENHANCE)
			end,
			index = ArtifactConst.DEV_TYPE.ENHANCE,
			resInfoId = {
				89,
				90
			}
		},
		[ArtifactConst.DEV_TYPE.STAR_UP] = {
			compNew = "artifact/ArtifactBreakThroughComp",
			title = g.core.lang:get(205503),
			cond = function()
				if g.core.config.function_info.fetch(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP) then
					return g.core.common.ModuleUnlock:getUnlockComment(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP)
				else
					g.core.module.ModuleManager:tip("no functionId: " .. g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP)

					return "", true
				end
			end,
			show = function()
				return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP)
			end,
			index = ArtifactConst.DEV_TYPE.STAR_UP,
			resInfoId = {
				91,
				92
			}
		},
		[ArtifactConst.DEV_TYPE.WEAPON_SPIRIT] = {
			compNew = "artifact/ArtifactWeaponSpiritComp",
			specialResInfo = true,
			title = g.core.lang:get(205503),
			cond = function()
				if g.core.config.function_info.fetch(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP) then
					return g.core.common.ModuleUnlock:getUnlockComment(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP)
				else
					g.core.module.ModuleManager:tip("no functionId: " .. g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_STARUP)

					return "", true
				end
			end,
			show = function(arg_8_0)
				return g.core.model.User.artifactData:getArtifactByAdvacnceId(arg_8_0):isHasWeaponSpirit()
			end,
			index = ArtifactConst.DEV_TYPE.WEAPON_SPIRIT,
			resInfoId = {
				91,
				92
			}
		}
	}
}

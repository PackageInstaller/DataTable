local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactStarUpSuccessComp = class("ArtifactStarUpSuccessComp", require("app.fairyGUI.artifact.UI_ArtifactStarUpSuccessComp"))

function ArtifactStarUpSuccessComp:ctor()
	return
end

function ArtifactStarUpSuccessComp:updateComp(arg_2_1)
	if arg_2_1 then
		local var_2_0 = arg_2_1:getCfg()
		local var_2_1 = arg_2_1:getStarAttrs()

		self.m_starComp:initStar({
			style = 2,
			index = 3,
			max = arg_2_1:getMaxStar(),
			num = var_2_0.star
		})

		if var_2_1 and #var_2_1 > 0 then
			for iter_2_0 = 1, ArtifactConst.ATTR_NUM do
				var_2_1[iter_2_0].iconType = 2

				if self["m_totalAttrComp" .. iter_2_0] then
					if var_2_1[iter_2_0] then
						self["m_totalAttrComp" .. iter_2_0]:setVisible(true)
						self["m_totalAttrComp" .. iter_2_0]:updateAttr(var_2_1[iter_2_0])
					else
						self["m_totalAttrComp" .. iter_2_0]:setVisible(false)
					end
				end
			end
		end

		self.m_skillIcon:updateIcon({
			overClick = true,
			artifact = arg_2_1
		})
		self.m_skillLevelTxt:setText(var_2_0.star)
	end
end

return ArtifactStarUpSuccessComp

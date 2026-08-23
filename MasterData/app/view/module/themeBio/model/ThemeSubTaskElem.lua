local var_0_0 = g.core.model.User.themeData
local ThemeSubTaskElem = class("ThemeSubTaskElem")

function ThemeSubTaskElem:ctor(arg_1_1, arg_1_2)
	self._refSubChain = arg_1_1
	self._activeThemeValue = arg_1_2
	self._themeBioData = var_0_0:getThemeData(self._activeThemeValue):getThemeBioData()
end

function ThemeSubTaskElem:getTitle()
	return self._refSubChain.name
end

function ThemeSubTaskElem:getTemplate()
	return "ui://themeBio/ThemeBioTreeSubCell"
end

function ThemeSubTaskElem:getTaskType()
	local var_4_0 = false

	if self._refSubChain and self._refSubChain.type == 4 then
		for iter_4_0, iter_4_1 in ipairs(self._refSubChain.missions) do
			local var_4_1 = self._themeBioData:getMission(iter_4_1)

			if var_4_1.isFirst and not var_4_1.finish then
				var_4_0 = false

				break
			end

			if not var_4_1.isFirst and not var_4_1.isLast and not var_4_1.finish then
				var_4_0 = true

				break
			end
		end
	end

	return var_4_0 and 2 or 1
end

function ThemeSubTaskElem:getChainState()
	if self._refSubChain.finish then
		return 1
	end

	if self._refSubChain.type == 2 and not self._themeBioData:getMission(self._refSubChain.missions[1]).unlock then
		return 2
	end

	return 0
end

function ThemeSubTaskElem:getSubChain()
	return self._refSubChain
end

return ThemeSubTaskElem

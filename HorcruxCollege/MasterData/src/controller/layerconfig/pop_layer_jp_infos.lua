return {
	ActivityPassLevelTaskTemplateLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (ActivityPassLevelTaskTemplateLayer:create(...))
		end,
		textures = {}
	}
}

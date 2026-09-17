if require("controller.l2d_manager"):isVersion4() then
	require("view.Layer.L2dLayerVer4")
else
	require("view.Layer.L2dLayerVer2")
end

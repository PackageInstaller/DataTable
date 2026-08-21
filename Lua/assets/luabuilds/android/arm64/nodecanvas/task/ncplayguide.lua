local var_0_0 = class("NcPlayGuide", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	pg.NewGuideMgr.GetInstance():Play(arg_1_0:GetStringArg("guide"), {}, function()
		arg_1_0:EndAction()

		return
	end, nil)

	return
end

return var_0_0

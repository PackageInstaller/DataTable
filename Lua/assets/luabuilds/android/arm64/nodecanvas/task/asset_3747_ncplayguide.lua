local NcPlayGuide = class("NcPlayGuide", import("..base.NodeCanvasBaseTask"))

function NcPlayGuide:OnExecute()
	pg.NewGuideMgr.GetInstance():Play(self:GetStringArg("guide"), {}, function()
		self:EndAction()

		return
	end, nil)

	return
end

return NcPlayGuide

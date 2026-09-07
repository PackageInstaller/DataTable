local GMTProxy = class("GMTProxy", import(".NetProxy"))

function GMTProxy:register()
	self:on(50115, function(arg_2_0)
		pg.GMTMgr.GetInstance():showGMT(arg_2_0.timestamp)

		return
	end)

	return
end

return GMTProxy

local var_0_0 = {
	isLowGradeDevice = function()
		return g.core.common.DeviceCheck.CUR_LEVEL == 0
	end,
	getDevicePerformLevel = function()
		return g.core.common.DeviceCheck.CUR_LEVEL
	end
}

function var_0_0.changeDevicePerformance()
	var_0_0.setTextureSetting()
	var_0_0.resetWwiseBanks()
end

function var_0_0.setTextureSetting()
	if var_0_0.isLowGradeDevice() then
		if not cc.Configuration:getInstance():supportsETC2() then
			cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A4444)
		end

		cc.Director:getInstance():getTextureCache():setAutoSize(209715200)
	else
		cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
		cc.Director:getInstance():getTextureCache():setAutoSize(419430400)
	end
end

function var_0_0.setTextureLow(arg_5_0)
	if g.core.resource.ResourceManager:getDeviceRealQuality() == 0 then
		if arg_5_0 then
			cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
			cc.Director:getInstance():getTextureCache():setAutoSize(419430400)
		else
			cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A4444)
			cc.Director:getInstance():getTextureCache():setAutoSize(209715200)
		end
	end
end

function var_0_0.resetWwiseBanks()
	g.core.sound.SoundManager:resetLoadBanks()
end

return var_0_0

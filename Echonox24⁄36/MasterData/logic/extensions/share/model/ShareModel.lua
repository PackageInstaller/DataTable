-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/model/ShareModel.lua

module("logic.extensions.share.model.ShareModel", package.seeall)

local ShareModel = class("ShareModel", BaseModel)

function ShareModel:ctor()
	self._shareQRCodes = false
	self._shareSnapshot = false
end

function ShareModel:onInit()
	return
end

function ShareModel:onReset()
	self._shareQRCodes = false
end

function ShareModel:getShareSnapShotGadget()
	if not self._shareSnapshot then
		self._shareSnapshot = ShareSnapshot.New()
	end

	return self._shareSnapshot
end

function ShareModel:_loadShareQRCode()
	return
end

function ShareModel:setShareQRCodes(qrCodes)
	self._shareQRCodes = qrCodes

	if enableLog then
		for i = 1, #self._shareQRCodes do
			print("===------------=====second channel id====----------------=====" .. self._shareQRCodes[i])
		end
	end
end

function ShareModel:isShareQRcode(platformId, secondId)
	if Astral.OSDef.RunOS == Astral.OSDef.IOS then
		return true, platformId
	end

	return true, secondId
end

function ShareModel:getShareDirectoryPath()
	if Astral.OSDef.isEditor then
		return string.format("%s/share/", UnityEngine.Application.persistentDataPath)
	elseif Astral.OSDef.RunOS == Astral.OSDef.Android then
		return string.format("%s/share/", UnityEngine.Application.persistentDataPath)
	else
		return string.format("%s/share/", UnityEngine.Application.persistentDataPath)
	end
end

ShareModel.instance = ShareModel.New()

return ShareModel

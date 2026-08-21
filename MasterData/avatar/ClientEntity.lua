-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\ClientEntity.lua

local ResServerErrorNotice = require("ClientData/ResServerErrorNotice")
local strClassName = "ClientEntity"
local ClientEntity = Class(strClassName)

function ClientEntity:ctor()
	return
end

function ClientEntity:onErrorCodeResp(agent, msgID)
	local errorKey = string.sub(msgID, 9)

	if ResServerErrorNotice[errorKey] and ResServerErrorNotice[errorKey].notice_info then
		MsgManager.notice(ResServerErrorNotice[errorKey].notice_info)
	elseif not IS_PUBLISH_VERSION then
		local msg = utils.format(Lang.get(1807), agent, msgID)

		MsgManager.notice(msg)
	end

	if self.catchSvrError then
		self:catchSvrError(msgID)
	end

	return true
end

function ClientEntity:onHotfixVersionNotify(hotfix, total, current)
	local versionId = hotfix.id
	local md5 = hotfix.control.md5
	local data = hotfix.data.str

	if data and md5 ~= HotfixMD5 then
		if current == 1 then
			self.HotfixData = ""
		end

		self.HotfixData = self.HotfixData .. data

		if total <= current then
			local ClientMd5 = Framework.Tools.LuaToolkit.md5(self.HotfixData)

			if ClientMd5 and md5 and HotfixMD5 ~= ClientMd5 then
				if ClientMd5 .. "\x00" ~= md5 then
					return
				end

				local f = loadstring(self.HotfixData)

				if f then
					ClientUtils.trycall(f)
				end

				HotfixMD5 = ClientMd5
			end
		end
	end
end

function ClientEntity:destroy()
	return
end

return ClientEntity

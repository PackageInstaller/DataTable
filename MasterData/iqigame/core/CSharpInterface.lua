-- chunkname: @IQIGame\\Core\\CSharpInterface.lua

CSharpInterface = {}

function CSharpInterface.SendHearBeat()
	net_user.ping()
	NetManager.PingCheckTimeOut(NetworkChannelName.Game)
end

function CSharpInterface.AddBGM(bgmCid)
	return LuaUtility.PlayBGMWithID(bgmCid)
end

function CSharpInterface.ReplaceBGM(bgmSerialID, bgmCid)
	LuaUtility.ReplaceBGM(bgmSerialID, bgmCid)
end

function CSharpInterface.RemoveBGM(bgmSerialID)
	LuaUtility.RemoveBGM(bgmSerialID)
end

function CSharpInterface.GetFixedTextI18NValue(id)
	if CSharpInterface.AutoTextI18NAvailable == nil then
		local hasData = false

		for i, v in pairsCfg(CfgAutoTextI18NTable) do
			hasData = true

			break
		end

		CSharpInterface.AutoTextI18NAvailable = hasData
	end

	if not CSharpInterface.AutoTextI18NAvailable then
		return nil
	end

	local cfgAutoTextI18NData = CfgAutoTextI18NTable[id]

	if cfgAutoTextI18NData ~= nil then
		return cfgAutoTextI18NData.Text
	end

	return nil
end

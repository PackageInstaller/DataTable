-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/ViewBlockKey.lua

module("logic.common.datadef.ViewBlockKey", package.seeall)

local _blockKeyId = 10000

function getBlockId()
	_blockKeyId = _blockKeyId + 1

	return _blockKeyId
end

Default = getBlockId()
Guide = getBlockId()
Anim = getBlockId()
Login = getBlockId()
Store = getBlockId()
Share = getBlockId()
Signin = getBlockId()
LoginPopUp = getBlockId()
Story = getBlockId()
CharacterSys = getBlockId()
MainUI = getBlockId()
ControlAction = getBlockId()
CharacterSysAuthority = getBlockId()
RoguePlot = getBlockId()
TacitReward = getBlockId()
Retireve = getBlockId()
Battle = getBlockId()

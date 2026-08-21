-- chunkname: @IQIGame\\Module\\Battle\\BattleEffectModule.lua

local BattleUnitTransferFeatureData = require("IQIGame/Module/Battle/TransferFeature/BattleUnitTransferFeatureData")

BattleEffectModule = {
	screenEffectTimeTable = {}
}
BattleEffectModule.CommonSpineTransferPath = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"

function BattleEffectModule.Init(battleScene)
	BattleEffectModule.battleScene = battleScene

	BattleEffectModule.__InitScreenEffectArgs()
	BattleEffectModule.__InitTransferFeatureArgs()
end

function BattleEffectModule.Revert()
	BattleEffectModule.__RevertTransferFeature()
	BattleEffectModule.__RevertScreenEffect()
end

function BattleEffectModule.Dispose()
	BattleEffectModule.__DisposeScreenEffectArgs()
	BattleEffectModule.__DisposeTransferFeatureArgs()

	BattleEffectModule.battleScene = nil
end

function BattleEffectModule.__InitScreenEffectArgs()
	BattleEffectModule.screenEffectTimeTable = {}
	BattleEffectModule.screenEffectParent = BattleEffectModule.battleScene.battleCameraCom.transform
end

function BattleEffectModule.PlayScreenEffect(effectID, duration)
	local effectGo = BattleScatteredResModule.GetScreenEffectObj(effectID)

	if effectGo == nil then
		logError("屏幕特效播放失败，找不到对应ID的屏幕特效 {0}", effectID)

		return
	end

	local timer = BattleEffectModule.screenEffectTimeTable[effectID]

	if timer ~= nil then
		return
	end

	timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
		BattleEffectModule.__StopScreenEffect(effectID)
	end, duration, 1, true)
	BattleEffectModule.screenEffectTimeTable[effectID] = timer

	effectGo.gameObject.transform:SetParent(BattleEffectModule.screenEffectParent)

	effectGo.gameObject.transform.localScale = Vector3.one
	effectGo.gameObject.layer = UnityEngine.LayerMask.NameToLayer("Screen")

	effectGo.gameObject:SetActive(true)
	timer:Start()
end

function BattleEffectModule.__StopScreenEffect(effectID)
	BattleScatteredResModule.RecoveryScreenEffect(effectID)

	BattleEffectModule.screenEffectTimeTable[effectID] = nil
end

function BattleEffectModule.__RevertScreenEffect()
	for _, timer in pairs(BattleEffectModule.screenEffectTimeTable) do
		if timer ~= nil then
			timer:Stop()
		end
	end

	BattleEffectModule.screenEffectTimeTable = {}
end

function BattleEffectModule.__DisposeScreenEffectArgs()
	for _, timer in pairs(BattleEffectModule.screenEffectTimeTable) do
		if timer ~= nil then
			timer:Stop()
		end
	end

	BattleEffectModule.screenEffectTimeTable = nil
	BattleEffectModule.screenEffectParent = nil
end

function BattleEffectModule.PlaySceneEffect(effectID, position)
	local effectCfg = CfgEffectTable[effectID]

	if effectCfg == nil then
		logError("播放场景特效失败，找不到对应的特效配置ID： {0}", effectID)

		return
	end

	local delay = effectCfg.PlayTimeDelay == nil and 0 or effectCfg.PlayTimeDelay
	local playTime = effectCfg.PlayTime == nil and 0 or effectCfg.PlayTime

	GameEntry.Effect:PlayNormalEffect(effectID, position, delay, playTime)
end

function BattleEffectModule.__InitTransferFeatureArgs()
	BattleEffectModule.transferMixDriver = GameEntry.RenderingComponent.TransferDriver
	BattleEffectModule.transferMixerInstances = {}
	BattleEffectModule.battleUnitTransferFeatureData = {}

	BattleEffectModule.__LoadTransferConfigInstance(BattleEffectModule.CommonSpineTransferPath, function()
		BattleEffectModule.dataTransferMixer = BattleEffectModule.transferMixerInstances[cfgPath]

		log("加载通用 BattleSpineTransfer 配置成功")
	end)
end

function BattleEffectModule.RecordProperties(behaviorGo)
	BattleEffectModule.transferMixDriver:RecordProperties(BattleEffectModule.dataTransferMixer, behaviorGo)
end

function BattleEffectModule.RevertTransferFeature(behaviorGo)
	BattleEffectModule.transferMixDriver:RestoreProperties(behaviorGo)
end

function BattleEffectModule.PlayTransferFeature(transferResID, battleUnitView, finishEvent)
	local transferCfgData = CfgTransferResourceTable[transferResID]

	if transferCfgData == nil then
		return
	end

	BattleEffectModule.__DoPlayTransferFeature(transferCfgData, battleUnitView.roleEffect.gameObject, finishEvent)
end

function BattleEffectModule.RemoveTransferFeature(transferResID, battleUnitView)
	local transferCfgData = CfgTransferResourceTable[transferResID]

	if transferCfgData == nil then
		return
	end

	BattleEffectModule.transferMixDriver:StopFeature(transferCfgData.Group, battleUnitView.roleEffect.gameObject)
end

function BattleEffectModule.__DoPlayTransferFeature(transferCfgData, behaviorGo, finishEvent)
	local transferConfigPath = transferCfgData.Path

	if LuaUtility.StrIsNullOrEmpty(transferConfigPath) then
		transferConfigPath = BattleEffectModule.CommonSpineTransferPath
	end

	local transferMixer = BattleEffectModule.transferMixerInstances[transferConfigPath]

	if transferMixer ~= nil then
		BattleEffectModule.transferMixDriver:PlayFeature(transferCfgData.Group, transferMixer, behaviorGo, transferCfgData.PlayMode, transferCfgData.SoleFlag, transferCfgData.Overlay, finishEvent)

		return
	end

	BattleEffectModule.__LoadTransferConfigInstance(transferCfgData.Path, function()
		BattleEffectModule.__DoPlayTransferFeature(transferCfgData, behaviorGo, finishEvent)
	end)
end

function BattleEffectModule.__LoadTransferConfigInstance(path, callback)
	if LuaUtility.StrIsNullOrEmpty(path) then
		return
	end

	local function success(_asset)
		BattleEffectModule.transferMixerInstances[path] = _asset

		if callback ~= nil then
			callback()
		end
	end

	local function fail()
		logError("Battle 加载Transfer " .. path .. " 失败")
	end

	BattleEffectModule.battleScene:LoadAsset(path, success, fail)
end

function BattleEffectModule.__RevertTransferFeature()
	BattleEffectModule.battleUnitTransferFeatureData = {}

	BattleEffectModule.transferMixDriver:Clear()
end

function BattleEffectModule.__DisposeTransferFeatureArgs()
	BattleEffectModule.transferMixDriver:Clear()

	BattleEffectModule.transferMixDriver = nil
	BattleEffectModule.dataTransferMixer = nil

	for _, _instance in pairs(BattleEffectModule.transferMixerInstances) do
		_instance = nil
	end

	BattleEffectModule.transferMixerInstances = nil
end

function BattleEffectModule.InitBattleUnitRendererFeatureComponent(battleUnitID, behaviorGo)
	local roleEffect = LuaCodeInterface.GameObjectGetOrAddComponent(behaviorGo, typeof(RoleEffect))

	roleEffect:SetEnable(true)
	BattleEffectModule.RecordProperties(behaviorGo)

	BattleEffectModule.battleUnitTransferFeatureData[battleUnitID] = BattleUnitTransferFeatureData.New(battleUnitID)

	return roleEffect
end

function BattleEffectModule.DisposeBattleUnitRendererFeatureComponent(battleUnitView)
	if battleUnitView.roleEffect == nil then
		return
	end

	BattleEffectModule.RevertTransferFeature(battleUnitView.roleEffect.gameObject)
	battleUnitView.roleEffect:SetEnable(false)

	if battleUnitView.hideSpine then
		return
	end

	battleUnitView.roleEffect:ClearProperties()
end

function BattleEffectModule.AddRendererFeatureByBuff(battleUnitID, buffData)
	local transferFeatureData = BattleEffectModule.battleUnitTransferFeatureData[battleUnitID]

	if transferFeatureData == nil then
		return
	end

	transferFeatureData:AddBuffSourceData(buffData)
end

function BattleEffectModule.RemoveRendererFeatureByBuff(battleUnitID, buffCid)
	local transferFeatureData = BattleEffectModule.battleUnitTransferFeatureData[battleUnitID]

	if transferFeatureData == nil then
		return
	end

	transferFeatureData:RemoveBuffSourceData(buffCid)
end

function BattleEffectModule.AddRendererFeatureByFightStatus(battleUnitID, status)
	local transferFeatureData = BattleEffectModule.battleUnitTransferFeatureData[battleUnitID]

	if transferFeatureData == nil then
		return
	end

	transferFeatureData:AddFightStatusSourcesData(status)
end

function BattleEffectModule.RemoveRendererFeatureByFightStatus(battleUnitID, status)
	local transferFeatureData = BattleEffectModule.battleUnitTransferFeatureData[battleUnitID]

	if transferFeatureData == nil then
		return
	end

	transferFeatureData:RemoveFightStatusSourcesData(status)
end

function BattleEffectModule.AddRendererFeatureByManual(battleUnitID, transferResID, userdata)
	local transferFeatureData = BattleEffectModule.battleUnitTransferFeatureData[battleUnitID]

	if transferFeatureData == nil then
		return
	end

	if userdata == nil then
		userdata = BattleEffectModule.GetManualRendererFeatureArgs(transferResID)
	end

	transferFeatureData:AddManualSourceData(transferResID, userdata)
	BattleEffectModule.RefreshUnitRendererFeature(battleUnitID)
end

function BattleEffectModule.RemoveRendererFeatureByManual(battleUnitID, transferResID, userdata)
	local transferFeatureData = BattleEffectModule.battleUnitTransferFeatureData[battleUnitID]

	if transferFeatureData == nil then
		return
	end

	if userdata == nil then
		userdata = BattleEffectModule.GetManualRendererFeatureArgs(transferResID)
	end

	transferFeatureData:RemoveManualSourceData(transferResID, userdata)
	BattleEffectModule.RefreshUnitRendererFeature(battleUnitID)
end

function BattleEffectModule.RemoveTransferFeatureByType(battleUnitID, sourceType)
	local transferFeatureData = BattleEffectModule.battleUnitTransferFeatureData[battleUnitID]

	if transferFeatureData == nil then
		return
	end

	transferFeatureData:RemoveSourceDataByType(sourceType)
	BattleEffectModule.RefreshUnitRendererFeature(battleUnitID)
end

function BattleEffectModule.RefreshUnitRendererFeature(battleUnitID)
	local transferFeatureData = BattleEffectModule.battleUnitTransferFeatureData[battleUnitID]

	if transferFeatureData == nil then
		return
	end

	local battleUnitView = BattleModule.battleScene:GetBattleUnitViewByID(battleUnitID)

	if battleUnitView == nil then
		return
	end

	transferFeatureData:Apply(function(_isAdd, _transferResID)
		if _isAdd then
			battleUnitView:PlayTransferFeature(_transferResID)
		else
			battleUnitView:RemoveTransferFeature(_transferResID)
		end
	end)
end

function BattleEffectModule.GetManualRendererFeatureArgs(transferResID)
	local resultArgs = {
		transferResID = transferResID
	}

	if transferResID == BattleConstant.RendererFeatureID.Selected then
		resultArgs.args = "Selected"
	elseif transferResID == BattleConstant.RendererFeatureID.AttackTarget then
		resultArgs.args = "AttackTarget"
	elseif transferResID == BattleConstant.RendererFeatureID.FriendTarget then
		resultArgs.args = "FriendTarget"
	elseif transferResID == BattleConstant.RendererFeatureID.SelfTarget then
		resultArgs.args = "SelfTarget"
	elseif transferResID == BattleConstant.RendererFeatureID.MoveStealth then
		resultArgs.args = "MoveStealth"
	else
		resultArgs.args = "None"
	end

	return resultArgs
end

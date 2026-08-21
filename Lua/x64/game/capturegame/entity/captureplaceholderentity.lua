local var_0_0 = class("CapturePlaceHolderEntity", CaptureEntityBase)

function var_0_0.GetType(arg_1_0)
	return CaptureGameConst.EntityType.PlaceHolder
end

function var_0_0.InitGameObject(arg_2_0)
	return (Asset.Instantiate("CaptureGame/Placeholder/Holder"))
end

function var_0_0.Init(arg_3_0)
	arg_3_0.context = {
		isInFocus = false,
		index = -1,
		rePos = false,
		entity = arg_3_0.entity,
		transform = arg_3_0.entity.obj.transform,
		gameObject = arg_3_0.entity.obj,
		skin = {
			curSkin = -1
		}
	}

	arg_3_0:OnInit()
	arg_3_0:AddListener()
	CaptureGameMgr:GetPlaceHolderMgr():AddPlaceHolder(arg_3_0)
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.context.placeHolderTransform = arg_4_0.context.transform:Find("PlaceHolder").transform
	arg_4_0.context.placeHolderModel = arg_4_0.context.transform:Find("HolderModel").gameObject
	arg_4_0.context.focusCamera = arg_4_0.context.transform:Find("FocusCamera/focusVM").gameObject:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	arg_4_0.context.colliderObj = arg_4_0.context.transform:Find("HolderModel/HolderCollider").gameObject
	arg_4_0.context.holderController = arg_4_0.context.transform:Find("HolderModel/Capture_HeroPos"):GetComponent(typeof(ControllerExSpace.ControllerExCollection)):GetController("state")

	arg_4_0:FocusSelf(false, true)
end

function var_0_0.ReposAnchor(arg_5_0)
	if arg_5_0.context.rePos then
		return
	end

	arg_5_0.context.rePos = true

	local var_5_0 = CaptureGameMgr:GetCameraMgr():GetMainCam()
	local var_5_1 = arg_5_0.context.transform:Find("FocusCamera/focusVM")
	local var_5_2 = arg_5_0.context.transform.position - var_5_0.transform.right * 0.5 - var_5_0.transform.forward * 7

	var_5_2.y = CaptureGameMgr:GetCameraMgr():GetInitY()
	var_5_1.position = var_5_2
	var_5_1.forward = var_5_0.transform.forward
	var_5_1.right = var_5_0.transform.right
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0.context.trigger = arg_6_0.context.colliderObj:AddComponent(typeof(CaptureEntityTrigger))

	function arg_6_0.context.trigger.onPointerClick(arg_7_0, arg_7_1)
		CaptureGameMgr:GetPlaceHolderMgr():SetCurrentSelect(arg_6_0.context.index)
		CaptureGameMgr:OpenSettingPanel(true)
	end
end

function var_0_0.FocusSelf(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		arg_8_0:ReposAnchor()
	end

	if arg_8_2 or arg_8_1 ~= arg_8_0.context.isInFocus then
		local var_8_0 = CaptureGameConst.CaptureGameCameraPriority.FocusLayer

		if not arg_8_1 then
			var_8_0 = CaptureGameConst.CaptureGameCameraPriority.DisableLayer
		end

		arg_8_0.context.focusCamera.Priority = var_8_0
	end

	arg_8_0.context.isInFocus = arg_8_1
end

function var_0_0.SwitchSkin(arg_9_0, arg_9_1)
	local var_9_0 = true

	if arg_9_1 and arg_9_0.context.skin.curSkin and arg_9_0.context.skin.curSkin ~= arg_9_1 then
		var_9_0 = true
	end

	arg_9_0.context.skin.curSkin = arg_9_1

	if arg_9_0:HasSkin() then
		arg_9_0.context.holderController:SetSelectedState("selected")

		if var_9_0 then
			arg_9_0:PlayEffect()
		end
	else
		arg_9_0.context.holderController:SetSelectedState("empty")
	end
end

function var_0_0.PlayEffect(arg_10_0)
	manager.audio:PlayUIAudioByVoice("hero_change")
	LuaForUtil.PlayEffect(arg_10_0.context.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function var_0_0.HasSkin(arg_11_0)
	return arg_11_0.context.skin.curSkin ~= -1
end

function var_0_0.Hide(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, not arg_12_1)
end

function var_0_0.EnableCollider(arg_13_0, arg_13_1)
	arg_13_0.context.colliderObj:SetActive(arg_13_1)
end

function var_0_0.GetSkinEntityId(arg_14_0)
	return arg_14_0.context.skin.curSkin
end

function var_0_0.GetPlaceHolderTransform(arg_15_0)
	return arg_15_0.context.placeHolderTransform
end

function var_0_0.SetIndex(arg_16_0, arg_16_1)
	arg_16_0.context.index = arg_16_1
end

function var_0_0.GetIndex(arg_17_0)
	return arg_17_0.context.index
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.context.placeHolderTransform = nil
	arg_18_0.context.placeHolderModel = nil
	arg_18_0.context.focusCamera = nil
	arg_18_0.context.colliderObj = nil
	arg_18_0.context.holderController = nil

	arg_18_0.context.trigger:RemoveAllListeners()

	arg_18_0.context.trigger = nil
	arg_18_0.context.transform = nil
	arg_18_0.context.gameObject = nil

	arg_18_0.context.entity:Dispose()

	arg_18_0.context.entity = nil

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0

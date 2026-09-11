local CapturePlaceHolderEntity = class("CapturePlaceHolderEntity", CaptureEntityBase)

function CapturePlaceHolderEntity:GetType()
	return CaptureGameConst.EntityType.PlaceHolder
end

function CapturePlaceHolderEntity:InitGameObject()
	return (Asset.Instantiate("CaptureGame/Placeholder/Holder"))
end

function CapturePlaceHolderEntity:Init()
	self.context = {
		isInFocus = false,
		index = -1,
		rePos = false,
		entity = self.entity,
		transform = self.entity.obj.transform,
		gameObject = self.entity.obj,
		skin = {
			curSkin = -1
		}
	}

	self:OnInit()
	self:AddListener()
	CaptureGameMgr:GetPlaceHolderMgr():AddPlaceHolder(self)
end

function CapturePlaceHolderEntity:OnInit()
	self.context.placeHolderTransform = self.context.transform:Find("PlaceHolder").transform
	self.context.placeHolderModel = self.context.transform:Find("HolderModel").gameObject
	self.context.focusCamera = self.context.transform:Find("FocusCamera/focusVM").gameObject:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	self.context.colliderObj = self.context.transform:Find("HolderModel/HolderCollider").gameObject
	self.context.holderController = self.context.transform:Find("HolderModel/Capture_HeroPos"):GetComponent(typeof(ControllerExSpace.ControllerExCollection)):GetController("state")

	self:FocusSelf(false, true)
end

function CapturePlaceHolderEntity:ReposAnchor()
	if self.context.rePos then
		return
	end

	self.context.rePos = true

	local var_5_0 = CaptureGameMgr:GetCameraMgr():GetMainCam()
	local var_5_1 = self.context.transform:Find("FocusCamera/focusVM")

	;(self.context.transform.position - var_5_0.transform.right * 0.5 - var_5_0.transform.forward * 7).y = CaptureGameMgr:GetCameraMgr():GetInitY()
	var_5_1.position = self.context.transform.position - var_5_0.transform.right * 0.5 - var_5_0.transform.forward * 7
	var_5_1.forward = var_5_0.transform.forward
	var_5_1.right = var_5_0.transform.right
end

function CapturePlaceHolderEntity:AddListener()
	self.context.trigger = self.context.colliderObj:AddComponent(typeof(CaptureEntityTrigger))

	function self.context.trigger.onPointerClick(arg_7_0, arg_7_1)
		CaptureGameMgr:GetPlaceHolderMgr():SetCurrentSelect(self.context.index)
		CaptureGameMgr:OpenSettingPanel(true)
	end
end

function CapturePlaceHolderEntity:FocusSelf(arg_8_1, arg_8_2)
	if arg_8_1 then
		self:ReposAnchor()
	end

	if arg_8_2 or arg_8_1 ~= self.context.isInFocus then
		if not arg_8_1 then
			self.context.focusCamera.Priority = CaptureGameConst.CaptureGameCameraPriority.DisableLayer
		end
	end

	self.context.isInFocus = arg_8_1
end

function CapturePlaceHolderEntity:SwitchSkin(arg_9_1)
	local var_9_0 = true

	if arg_9_1 and self.context.skin.curSkin and self.context.skin.curSkin ~= arg_9_1 then
		var_9_0 = true
	end

	self.context.skin.curSkin = arg_9_1

	if self:HasSkin() then
		self.context.holderController:SetSelectedState("selected")

		if var_9_0 then
			self:PlayEffect()
		end
	else
		self.context.holderController:SetSelectedState("empty")
	end
end

function CapturePlaceHolderEntity:PlayEffect()
	manager.audio:PlayUIAudioByVoice("hero_change")
	LuaForUtil.PlayEffect(self.context.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function CapturePlaceHolderEntity:HasSkin()
	return self.context.skin.curSkin ~= -1
end

function CapturePlaceHolderEntity:Hide(arg_12_1)
	SetActive(self.gameObject_, not arg_12_1)
end

function CapturePlaceHolderEntity:EnableCollider(arg_13_1)
	self.context.colliderObj:SetActive(arg_13_1)
end

function CapturePlaceHolderEntity:GetSkinEntityId()
	return self.context.skin.curSkin
end

function CapturePlaceHolderEntity:GetPlaceHolderTransform()
	return self.context.placeHolderTransform
end

function CapturePlaceHolderEntity:SetIndex(arg_16_1)
	self.context.index = arg_16_1
end

function CapturePlaceHolderEntity:GetIndex()
	return self.context.index
end

function CapturePlaceHolderEntity:Dispose()
	self.context.placeHolderTransform = nil
	self.context.placeHolderModel = nil
	self.context.focusCamera = nil
	self.context.colliderObj = nil
	self.context.holderController = nil

	self.context.trigger:RemoveAllListeners()

	self.context.trigger = nil
	self.context.transform = nil
	self.context.gameObject = nil

	self.context.entity:Dispose()

	self.context.entity = nil

	CapturePlaceHolderEntity.super.Dispose(self)
end

return CapturePlaceHolderEntity

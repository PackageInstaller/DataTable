-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaChallenger.lua

module("logic.extensions.arena.view.ArenaChallenger", package.seeall)

local ArenaChallenger = class("ArenaChallenger")

function ArenaChallenger.AddOnce(go)
	local component = ArenaChallenger.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, ArenaChallenger)

	return component
end

function ArenaChallenger.Remove(go)
	Framework.LuaComponentContainer.Remove(go, ArenaChallenger)
end

function ArenaChallenger.Get(go)
	return (Framework.LuaComponentContainer.Get(go, ArenaChallenger))
end

function ArenaChallenger:ctor(container)
	self._container = container.gameObject

	self:onBuildUI()
	self:onEvent()
end

function ArenaChallenger:onBuildUI()
	self._isloaded = true
	self._btnMopup = GameUtil.asBtn(goutil.findChild(self._container, "btnMopup"))
	self._btnFight = GameUtil.asBtn(goutil.findChild(self._container, "btnFight"))
	self._btnRole = GameUtil.asBtn(goutil.findChild(self._container, "raycast"))
	self._Txt_name = goutil.findChildTextComponent(self._container, "Txt_name")
	self._Txt_maxZdl = goutil.findChildTextComponent(self._container, "Txt_maxZdl")
	self._Txt_position = goutil.findChildTextComponent(self._container, "Txt_position")
	self._Txt_bestPos = goutil.findChildTextComponent(self._container, "Txt_bestPos")
	self._imgBestPos = goutil.findChild(self._container, "imgBestPos")
	self._objPoint = goutil.findChild(self._container, "Obj_Point").transform
	self._InfoBg = goutil.findChild(self._container, "InfoBg"):GetComponent(goutil.Type_UIImage)
end

function ArenaChallenger:SetActive(boo)
	GameUtil.SetActive(self._objPoint, boo)
end

function ArenaChallenger:OnDestroy()
	self:unEvent()
	self:_destroyCharactor()
	self:_destroyShadow()
end

function ArenaChallenger:onEnter()
	return
end

function ArenaChallenger:onExit()
	self:_removeAvatar()
end

function ArenaChallenger:onEvent()
	self._btnMopup:AddClickListener(self._onClickMopup, self)
	self._btnFight:AddClickListener(self._onClickFight, self)
	self._btnRole:AddClickListener(self._onClickFight, self)
end

function ArenaChallenger:unEvent()
	self._btnMopup:RemoveClickListener()
	self._btnFight:RemoveClickListener()
	self._btnRole:RemoveClickListener()
end

function ArenaChallenger:initChallenger(challengerDat, clickCall)
	self.clickCall = clickCall
	self._challengerDat = challengerDat
	self._Txt_name.text = self._challengerDat._userName
	self._Txt_maxZdl.text = self._challengerDat._maxZdl
	self._Txt_position.text = self._challengerDat._position
	self._Txt_bestPos.text = not self._challengerDat._userId and "本赛季最高排名\n<color=#ffffff>" .. ArenaModel.instance:getBestPosition() .. "</color>" or ""
	self._InfoBg.color = self._challengerDat._userId and Color.New(0.2901960784313726, 0.2784313725490196, 0.3411764705882353, 1) or Color.New(0.8941176470588236, 0.6823529411764706, 0.10980392156862745, 1)

	local mainPlayerPosition = ArenaModel.instance:getPosition()

	GameUtil.SetActive(self._btnMopup, self._challengerDat._userId ~= nil and mainPlayerPosition < self._challengerDat._position)
	GameUtil.SetActive(self._btnFight, self._challengerDat._userId ~= nil and mainPlayerPosition > self._challengerDat._position)
	GameUtil.SetActive(self._imgBestPos, not self._challengerDat._userId)

	if not self._resShadowPath then
		self._resShadowPath = CommonResPath.CharacterShadow

		getres(self._resShadowPath, self._onRoleShadowLoaded, self, ResType.AssetBundle, true)
	end

	self:_createAvatar()

	local avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(self._challengerDat.gender, self._challengerDat._clothes)

	self._avatar:updateByMo(avatarMo)
end

function ArenaChallenger:_createAvatar()
	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)
		self._avatar.useType = AvatarUseType.Scene

		self._avatar:setParent(self._objPoint.transform)
		self._avatar:setLayer(SceneLayer.UI3D_Value)
		self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end
end

function ArenaChallenger:_removeAvatar()
	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function ArenaChallenger:_onAvatarLoaded(avatar)
	if avatar == self._avatar then
		ArenaController.instance:localNotify("RoleResLoadFinish")

		local animator = avatar.animatorCtrl:getAnimator()

		if animator then
			animator:SetBool("ui", false)
		end

		self:_udpateMatParam()
	end
end

function ArenaChallenger:_udpateMatParam()
	self:_changePlayerNakeMat()
	self:_changePlayerFaceMat()
	self:_changePlayerHairMat()
end

function ArenaChallenger:_changePlayerNakeMat()
	for k, v in pairs(self._avatar.avatarmo:getOwnNakeParts()) do
		local nakeparts = self._avatar:getBoneByName(AvatarNakePartTypeName[v])

		if nakeparts then
			local skinedMeshRenderer = nakeparts:GetComponent(ComponentType.SkinnedMeshRenderer)

			if skinedMeshRenderer and skinedMeshRenderer.material then
				skinedMeshRenderer.material:SetFloat("_worldLight", 0)
			end
		end
	end
end

function ArenaChallenger:_changePlayerFaceMat()
	local faceObje = self._avatar:getBoneByName(self._avatar and self._avatar.avatarmo and self._avatar.avatarmo.skeleton and self._avatar.avatarmo.skeleton == 2 and AnimatorHash.maleBlendShapeName or AnimatorHash.femaleBlendShapeName)

	if faceObje then
		local skinedMeshRenderer = faceObje:GetComponent(ComponentType.SkinnedMeshRenderer)

		if skinedMeshRenderer and skinedMeshRenderer.material then
			skinedMeshRenderer.material:SetFloat("_worldLight", 0)
		end
	end
end

function ArenaChallenger:_changePlayerHairMat()
	local var_19_0 = self._avatar

	if self._avatar then
		var_19_0 = self._avatar.pendantsCtrl

		if self._avatar.pendantsCtrl then
			local _pendants = self._avatar.pendantsCtrl._pendants

			if not _pendants then
				return
			end

			local hair = _pendants[AvatarPendantType.Hair]

			if not hair then
				return
			end

			local hairGo = hair:getGameObject()

			if not hairGo then
				return
			end

			local hairGoRender = hairGo:GetComponentsInChildren(ComponentType.SkinnedMeshRenderer)

			if not hairGoRender then
				return
			end

			for i = 0, hairGoRender.Length - 1 do
				if hairGoRender[i] and hairGoRender[i].material then
					hairGoRender[i].material:SetFloat("_worldLight", 0)
				end
			end
		end
	end
end

function ArenaChallenger:_onRoleShadowLoaded(res)
	if not self._resShadowPath then
		self:_destroyShadow()

		return
	end

	if res and res.IsSuccess then
		self._charactorShadowRes = res

		self._charactorShadowRes:Retain()

		self._charactorShadow = goutil.clone(res:GetMainAsset())

		goutil.addChildToParent(self._charactorShadow, self._objPoint)
		goutil.setActive(self._charactorShadow, true)
		Framework.GameObjectUtil.SetLayerRecursively(self._charactorShadow, SceneLayer.UI3D_Value)
		Framework.TransformUtil.SetLocalPos(self._charactorShadow.transform, -0.02, 0.02, 0)
		Framework.TransformUtil.SetLocalScale(self._charactorShadow.transform, 0.7, 0.7, 1)
		Framework.TransformUtil.SetLocalRotation(self._charactorShadow.transform, 0, 0, 0)
	end
end

function ArenaChallenger:_onClickFight()
	if self.clickCall then
		self.clickCall()
	end

	if not self._challengerDat._userId then
		ArenaModel.instance:setOpenArenaFmtViewTag(true)
		ArenaAgent.instance:sendGetMyArenaFormationReq()

		return
	end

	if FormationFacade.instance:isCurFormationEmpty() then
		TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), function()
			UIStateManager.instance:push(ViewName.FormationView)
		end, lang("fight_goto_fmt"))

		return true
	end

	local mainPlayerPosition = ArenaModel.instance:getPosition()
	local userId = checknumber(self._challengerDat._userId)

	if userId == -1 then
		ArenaController.instance:startArenaFight(self._challengerDat._position, true)
	elseif mainPlayerPosition < self._challengerDat._position then
		self:_onClickMopup()
	elseif userId <= 0 then
		ArenaModel.instance:setCurChallengerPos(self._challengerDat._position)
		ArenaModel.instance:setCurChallengerUserId(userId)
		ArenaController.instance:startArenaFight(ArenaModel.instance:getCurChallengerPos())
	else
		ArenaModel.instance:setCurChallengerUserId(userId)
		ArenaModel.instance:setCurChallengerPos(self._challengerDat._position)
		UIStateManager.instance:push("arenamission", self._challengerDat._userId, self._challengerDat._userName)
	end
end

function ArenaChallenger:_onClickMopup()
	if self.clickCall then
		self.clickCall()
	end

	UIStateManager.instance:push(ViewName.ArenaSweepSelectView)
end

function ArenaChallenger:_destroyCharactor()
	self:_removeAvatar()

	self._resPath = nil
end

function ArenaChallenger:_destroyShadow()
	if self._charactorShadow then
		goutil.destroy(self._charactorShadow, true)

		self._charactorShadow = nil
	end

	if self._charactorShadowRes then
		self._charactorShadowRes:Release()

		self._charactorShadowRes = nil
	end

	self._resShadowPath = nil
end

return ArenaChallenger

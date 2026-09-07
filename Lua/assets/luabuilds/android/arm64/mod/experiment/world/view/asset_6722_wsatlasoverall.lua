local WSAtlasOverall = class("WSAtlasOverall", import(".WSAtlas"))

WSAtlasOverall.windowSize = Vector2(1747, 776)
WSAtlasOverall.Fields = {
	tfMarkScene = "userdata",
	tfActiveMarkRect = "userdata"
}
WSAtlasOverall.Listeners = {
	onUpdateActiveEntrance = "OnUpdateActiveEntrance"
}

function WSAtlasOverall:Dispose()
	if self.tfActiveMarkRect then
		self:RemoveExtraMarkPrefab(self.tfActiveMarkRect)
		Destroy(self.tfActiveMarkRect)
	end

	self:RemoveExtraMarkPrefab(self.tfMarkScene)
	WSAtlasOverall.super.Dispose(self)

	return
end

function WSAtlasOverall:LoadScene(arg_2_1)
	gcAll(true)
	SceneOpMgr.Inst:LoadSceneAsync("scenes/worldoverview", "WorldOverview", LoadSceneMode.Additive, function(arg_3_0, arg_3_1)
		self.transform = tf(arg_3_0:GetRootGameObjects()[0])

		setActive(self.transform, false)

		self.tfEntity = self.transform:Find("entity")
		self.tfMapScene = self.tfEntity:Find("map_scene")
		self.tfMapSelect = self.tfMapScene:Find("selected_layer")
		self.tfSpriteScene = self.tfEntity:Find("sprite_scene")
		self.tfMarkScene = self.tfEntity:Find("mark_scene")
		self.defaultSprite = self.tfEntity:Find("decolation_layer/edge"):GetComponent("SpriteRenderer").material
		self.addSprite = self.tfEntity:Find("map_scene/mask_layer"):GetComponent("SpriteRenderer").material

		self:UpdateCenterEffectDisplay()
		self:BuildActiveMark()

		self.cmPointer = self.tfEntity:Find("Plane"):GetComponent(typeof(PointerInfo))

		local var_3_0 = nowWorld()

		self.cmPointer:AddColorMaskClickListener(function(arg_4_0, arg_4_1)
			local var_4_0 = var_3_0:ColorToEntrance(arg_4_0)

			if var_4_0 then
				self.onClickColor(var_4_0, arg_4_1.position)
			end

			return
		end)

		self.tfCamera = self.transform:Find("Main Camera")

		CameraFittingSettin(self.tfCamera)

		return existCall(arg_2_1)
	end)

	return
end

function WSAtlasOverall:ReturnScene()
	if self.tfEntity then
		SceneOpMgr.Inst:UnloadSceneAsync("scenes/worldoverview", "WorldOverview")

		self.cmPointer = nil
	end

	return
end

function WSAtlasOverall:BuildActiveMark()
	WSAtlasOverall.super.BuildActiveMark(self)
	self:DoUpdatExtraMark(self.tfActiveMark, "overview_player", true)

	self.tfActiveMarkRect = tf(GameObject.New())
	self.tfActiveMarkRect.gameObject.layer = Layer.UI
	self.tfActiveMarkRect.name = "active_mark_rect"

	self.tfActiveMarkRect:SetParent(self.tfSpriteScene, false)
	setActive(self.tfActiveMarkRect, false)
	self:DoUpdatExtraMark(self.tfActiveMarkRect, "overview_player_rect", true)

	return
end

function WSAtlasOverall:OnUpdateActiveEntrance(arg_7_1, arg_7_2, arg_7_3)
	WSAtlasOverall.super.OnUpdateActiveEntrance(self, arg_7_1, arg_7_2, arg_7_3)

	if arg_7_3 then
		self.tfActiveMarkRect.localPosition = self.tfActiveMark.localPosition
	end

	setActive(self.tfActiveMarkRect, arg_7_3)

	return
end

function WSAtlasOverall:UpdateStaticMark(arg_8_1, arg_8_2)
	self:RemoveExtraMarkPrefab(self.tfMarkScene)

	for iter_8_0, iter_8_1 in pairs(arg_8_1 or {}) do
		if iter_8_1 then
			local var_8_0 = self.atlas:GetEntrance(iter_8_0)

			if var_8_0:HasPort() then
				local var_8_1 = arg_8_2[1] or arg_8_2[2]

				if var_8_1 then
					self:LoadExtraMarkPrefab(self.tfMarkScene, var_8_1, function(arg_9_0)
						tf(arg_9_0).localPosition = WorldConst.CalcModelPosition(var_8_0, self.spriteBaseSize)

						return
					end)
				end
			end
		end
	end

	WSAtlasOverall.super.UpdateStaticMark(self, arg_8_1)

	return
end

function WSAtlasOverall:UpdateTargetEntrance(arg_10_1)
	local var_10_0 = self.atlas:GetEntrance(arg_10_1)
	local var_10_1 = self.atlas:GetActiveEntrance()

	self.tfActiveMark.localEulerAngles = Vector3(0, calcPositionAngle(var_10_0.config.area_pos[1] - var_10_1.config.area_pos[1], var_10_0.config.area_pos[2] - var_10_1.config.area_pos[2]), 0)

	return
end

return WSAtlasOverall

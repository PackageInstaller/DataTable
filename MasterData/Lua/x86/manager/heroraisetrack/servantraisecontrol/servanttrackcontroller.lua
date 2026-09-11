local ServantTrackController = class("ServantTrackController")

function ServantTrackController:Init(arg_1_1)
	self.animation = {
		Fade = "WeaponServant_end_02",
		Back = "WeaponServant_end_01",
		Light = "WeaponServant_star_02",
		Gray = "WeaponServant_star_01"
	}
	self.context = {
		isFirstHide = true,
		servantID = -1,
		animFadeTime = 0.1,
		curAnimName = "",
		obj = arg_1_1
	}

	SetActive(arg_1_1, false)

	if not isNil(arg_1_1) then
		self.context.animator = arg_1_1:GetComponent("Animator")
		self.context.adaptiveSpriteComps = arg_1_1:GetComponent(typeof(AdaptiveServantSprite))

		self:InitServantTrans()
	end
end

function ServantTrackController:InitServantTrans()
	if isNil(self.context.obj) then
		return
	end
end

function ServantTrackController:SetServantID(arg_3_1)
	if isNil(self.context.adaptiveSpriteComps) then
		return
	end

	local var_3_0 = false
	local var_3_1 = self.context.obj.activeInHierarchy

	if arg_3_1 ~= self.context.servantID then
		self.context.servantID = arg_3_1 or -1

		if arg_3_1 then
			local var_3_2
			local var_3_3
			local var_3_4
			local var_3_5 = WeaponServantCfg[arg_3_1]

			if WeaponServantCfg[arg_3_1] then
				pcall(function()
					if var_3_5.show_offset_x and var_3_5.show_offset_x ~= "" and tonumber(var_3_5.show_offset_x) then
						var_3_2 = tonumber(var_3_5.show_offset_x)
					end

					if var_3_5.show_offset_y and var_3_5.show_offset_y ~= "" and tonumber(var_3_5.show_offset_y) then
						var_3_3 = tonumber(var_3_5.show_offset_y)
					end

					if var_3_5.show_tiling_scale and var_3_5.show_tiling_scale ~= "" and tonumber(var_3_5.show_tiling_scale) then
						var_3_4 = tonumber(var_3_5.show_tiling_scale)
					end
				end)
			end

			local var_3_6 = not not var_3_4

			if self.context.oldAtlas ~= nil and self.context.oldAtlas ~= "" then
				unloadSpriteWithoutAtlas(self.context.oldAtlas)
			end

			self.context.oldAtlas = "TextureConfig/WeaponServant/Portrait/" .. arg_3_1

			self.context.adaptiveSpriteComps:SetSprite(AtlasManager.GetSpriteWithoutAtlas(self.context.oldAtlas), var_3_2 ~= nil, var_3_3 ~= nil, var_3_2 or 0, var_3_3 or 0, var_3_6, var_3_4 or 1)
			SetActive(self.context.obj, true)

			var_3_0 = true
		else
			SetActive(self.context.obj, false)
		end
	else
		SetActive(self.context.obj, arg_3_1 ~= nil)

		var_3_0 = arg_3_1 ~= nil
	end

	if var_3_0 and not var_3_1 then
		self:PlayCurrentAnim()
	end
end

function ServantTrackController:PlayCurrentAnim()
	if not self.animation[self.context.curAnimName] then
		return
	end

	if isNil(self.context.animator) then
		return
	end

	self.context.animator:CrossFade(self.animation[self.context.curAnimName], self.context.animFadeTime)
end

function ServantTrackController:PlayAnim(arg_6_1, arg_6_2)
	if arg_6_1 == "Gray" and self.context.curAnimName == "Light" then
		arg_6_1 = "Back"
	end

	if arg_6_1 == "Fade" and self.context.isFirstHide then
		return
	elseif self.context.isFirstHide then
		SetActive(self.context.obj, true)

		self.context.isFirstHide = false
	end

	if not self.animation[arg_6_1] then
		return
	end

	if isNil(self.context.animator) then
		return
	end

	if self.context.curAnimName ~= arg_6_1 or arg_6_2 or false then
		self.context.animator:CrossFade(self.animation[arg_6_1], self.context.animFadeTime)

		if arg_6_1 == "Back" then
			arg_6_1 = "Gray"
		end

		self.context.curAnimName = arg_6_1
	end
end

function ServantTrackController:CheckValid()
	if isNil(self.context.obj) then
		self.context.oldAtlas = nil

		return false
	end

	return true
end

function ServantTrackController:Dispose()
	self.context.oldAtlas = nil
	self.context.animator = nil
	self.context.adaptiveSpriteComps = nil

	if not isNil(self.context.obj) then
		Object.Destroy(self.context.obj)

		self.context.obj = nil
	end
end

return ServantTrackController

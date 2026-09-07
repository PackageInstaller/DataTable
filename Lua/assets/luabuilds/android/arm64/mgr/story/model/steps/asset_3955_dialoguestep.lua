local DialogueStep = class("DialogueStep", import(".StoryStep"))

DialogueStep.SIDE_LEFT = 0
DialogueStep.SIDE_RIGHT = 1
DialogueStep.SIDE_MIDDLE = 2
DialogueStep.ACTOR_TYPE_PLAYER = 0
DialogueStep.ACTOR_TYPE_FLAGSHIP = -1
DialogueStep.ACTOR_TYPE_TB = -2
DialogueStep.PAINTING_ACTION_MOVE = "move"
DialogueStep.PAINTING_ACTION_SHAKE = "shake"
DialogueStep.PAINTING_ACTION_ZOOM = "zoom"
DialogueStep.PAINTING_ACTION_ROTATE = "rotate"

local var_0_1 = pg.ship_skin_template

local function var_0_2(arg_1_0)
	local var_1_0 = string.lower(arg_1_0)

	if var_1_0 == "#a9f548" or var_1_0 == "#a9f548ff" then
		return "#5CE6FF"
	elseif var_1_0 == "#ff5c5c" then
		return "#FF9B93"
	elseif var_1_0 == "#ffa500" then
		return "#FFC960"
	elseif var_1_0 == "#ffff4d" then
		return "#FEF15E"
	elseif var_1_0 == "#696969" then
		return "#BDBDBD"
	elseif var_1_0 == "#a020f0" then
		return "#C3ABFF"
	elseif var_1_0 == "#ffffff" then
		return "#FFFFFF"
	else
		return arg_1_0
	end

	return
end

function DialogueStep:Ctor(arg_2_1)
	DialogueStep.super.Ctor(self, arg_2_1)

	self.actor = arg_2_1.actor
	self.nameColor = arg_2_1.nameColor and var_0_2(arg_2_1.nameColor) or COLOR_WHITE
	self.specialTbId = nil

	if arg_2_1.tbActor then
		self.specialTbId = self.actor
		self.actor = DialogueStep.ACTOR_TYPE_TB
	end

	self.actorName = arg_2_1.actorName
	self.subActorName = arg_2_1.factiontag
	self.subActorNameColor = arg_2_1.factiontagColor or "#FFFFFF"
	self.withoutActorName = arg_2_1.withoutActorName
	self.say = arg_2_1.say
	self.sayColor = arg_2_1.sayColor or COLOR_WHITE
	self.dynamicBgType = arg_2_1.dynamicBgType
	self.fontSize = arg_2_1.fontsize
	self.side = arg_2_1.side
	self.dir = arg_2_1.dir

	if self.dir == 0 then
		self.dir = 1
	end

	self.expression = arg_2_1.expression
	self.typewriter = arg_2_1.typewriter
	self.painting = arg_2_1.painting
	self.fadeInPaintingTime = arg_2_1.fadeInPaintingTime or 0.15
	self.fadeOutPaintingTime = arg_2_1.fadeOutPaintingTime or 0.15
	self.actorPosition = arg_2_1.actorPosition
	self.dialogShake = arg_2_1.dialogShake
	self.moveSideData = arg_2_1.paintingFadeOut
	self.paingtingGray = arg_2_1.paingtingGray
	self.glitchArt = arg_2_1.paintingNoise
	self.hideOtherPainting = arg_2_1.hideOther
	self.subPaintings = arg_2_1.subActors
	self.disappearSeq = {}
	self.disappearTime = {
		0,
		0
	}

	if self.subPaintings and #self.subPaintings > 0 and arg_2_1.disappearSeq then
		self.disappearSeq = arg_2_1.disappearSeq
		self.disappearTime = arg_2_1.disappearTime or {
			0,
			0
		}
	end

	self.hideRecordIco = arg_2_1.hideRecordIco
	self.paingtingScale = arg_2_1.actorScale
	self.paingtingYFlip = arg_2_1.actorYFlip
	self.hidePainting = arg_2_1.withoutPainting
	self.hidePaintingWithName = arg_2_1.hidePainting
	self.actorShadow = arg_2_1.actorShadow
	self.actorAlpha = arg_2_1.actorAlpha
	self.showNPainting = arg_2_1.hidePaintObj
	self.hasPaintbg = arg_2_1.hasPaintbg
	self.showWJZPainting = arg_2_1.hidePaintEquip
	self.hideDialogFragment = arg_2_1.hideDialogFragment
	self.nohead = arg_2_1.nohead
	self.live2d = arg_2_1.live2d
	self.live2dIdleIndex = arg_2_1.live2dIdleIndex
	self.live2dParams = arg_2_1.live2dParams
	self.spine = arg_2_1.spine
	self.spinePos = arg_2_1.spinePos or {
		0,
		0,
		0
	}
	self.spineOrderIndex = arg_2_1.spineOrderIndex
	self.live2dOffset = arg_2_1.live2dOffset
	self.contentBGAlpha = arg_2_1.dialogueBgAlpha or 1
	self.canMarkNode = arg_2_1.canMarkNode
	self.portrait = arg_2_1.portrait
	self.miniPortrait = false

	if self.portrait and (self.portrait == "zhihuiguan" or self.portrait == "tongxunqi") then
		self.miniPortrait = true
	end

	self.glitchArtForPortrait = arg_2_1.portraitNoise

	if self.hidePainting or self.actor == nil then
		self.actor = nil
		self.hideOtherPainting = true
	end

	if self.hidePaintingWithName or self.actor == nil then
		if self.actorName == nil then
			self.actorName = self:GetName()
		end

		self.actor = nil
		self.hideOtherPainting = true
	end

	self.paintRwIndex = arg_2_1.paintRwIndex or 0
	self.action = arg_2_1.action or {}

	return
end

function DialogueStep:GetSpinePosition()
	return BuildVector3(self.spinePos)
end

function DialogueStep:GetL2dParams()
	if not self.live2dParams then
		return nil
	end

	return {
		name = self.live2dParams[1],
		value = self.live2dParams[2]
	}
end

function DialogueStep:SetDefaultSide()
	self.side = defaultValue(self.side, DialogueStep.SIDE_LEFT)

	return
end

function DialogueStep:GetBgName()
	if self.dynamicBgType and self.dynamicBgType == DialogueStep.ACTOR_TYPE_TB and getProxy(EducateProxy) and getProxy(NewEducateProxy) then
		if not pg.NewStoryMgr.GetInstance():IsReView() then
			local var_6_0 = ""

			if not getProxy(NewEducateProxy):GetCurChar() then
				local var_6_1, var_6_2, var_6_3 = getProxy(EducateProxy):GetStoryInfo()

				var_6_0 = var_6_3
			else
				local var_6_4, var_6_5, var_6_6 = getProxy(NewEducateProxy):GetStoryInfo()

				var_6_0 = var_6_6
			end

			do return (self:Convert2StoryBg(var_6_0)) end

			goto label_6_0
		end
	end

	do return DialogueStep.super.GetBgName(self) end

	::label_6_0::

	return
end

function DialogueStep:Convert2StoryBg(arg_7_1)
	return ({
		educate_tb_3 = "bg_project_tb_room3",
		educate_tb_2 = "bg_project_tb_room2",
		educate_tb_1 = "bg_project_tb_room1"
	})[arg_7_1] or arg_7_1
end

function DialogueStep:GetPaintingRwIndex()
	if not self.glitchArt then
		return 0
	end

	if not self.expression then
		return 0
	end

	return self.paintRwIndex
end

function DialogueStep:IsMiniPortrait()
	return self.miniPortrait
end

function DialogueStep:ExistPortrait()
	return self.portrait ~= nil
end

function DialogueStep:GetPortrait()
	if type(self.portrait) == "number" then
		return pg.ship_skin_template[self.portrait].painting
	elseif type(self.portrait) == "string" then
		return self.portrait
	else
		return nil
	end

	return
end

function DialogueStep:ShouldHideDialogue()
	return self.hideDialogFragment
end

function DialogueStep:ShouldGlitchArtForPortrait()
	return self.glitchArtForPortrait
end

function DialogueStep:GetMode()
	return Story.MODE_DIALOGUE
end

function DialogueStep:GetContentBGAlpha()
	return self.contentBGAlpha
end

function DialogueStep:GetSpineExPression()
	if self.expression then
		return self.expression
	end

	return
end

function DialogueStep:GetExPression()
	if self.expression then
		return self.expression
	else
		local var_17_0 = self:GetPainting()

		if var_17_0 and ShipExpressionHelper.DefaultFaceless(var_17_0) then
			return ShipExpressionHelper.GetDefaultFace(var_17_0)
		end
	end

	return
end

function DialogueStep:ShouldAddHeadMaskWhenFade()
	if self:ShouldAddGlitchArtEffect() then
		return false
	end

	if self:IsNoHeadPainting() then
		return false
	end

	if not self:GetExPression() then
		return false
	end

	return true
end

function DialogueStep:ShouldGrayingPainting(arg_19_1)
	return arg_19_1:GetPainting() ~= nil and not self:IsSameSide(arg_19_1)
end

function DialogueStep:ShouldGrayingOutPainting(arg_20_1)
	return self:GetPainting() ~= nil and not self:IsSameSide(arg_20_1)
end

function DialogueStep:ShouldFadeInPainting()
	if not self:GetPainting() then
		return false
	end

	if self:IsLive2dPainting() or self:IsSpinePainting() then
		return false
	end

	local var_21_0 = self:GetFadeInPaintingTime()

	if not var_21_0 or var_21_0 <= 0 then
		return false
	end

	return true
end

function DialogueStep:GetTypewriter()
	return self.typewriter
end

function DialogueStep:ShouldFaceBlack()
	return self.actorShadow
end

function DialogueStep:GetPaintingData()
	local var_24_0 = self.painting or {}
	local var_24_1 = {}

	var_24_1.alpha = var_24_0.alpha or 0.3
	var_24_1.time = var_24_0.time or 1

	return var_24_1
end

function DialogueStep:GetFadeInPaintingTime()
	return self.fadeInPaintingTime
end

function DialogueStep:GetFadeOutPaintingTime()
	return self.fadeOutPaintingTime
end

function DialogueStep:GetPaintingDir()
	return (self.dir or 1) * (self.paingtingScale or 1)
end

function DialogueStep:ShouldFlipPaintingY()
	return self.paingtingYFlip ~= nil
end

function DialogueStep:GetTag()
	if self.glitchArt == true then
		return 2
	else
		return 1
	end

	return
end

function DialogueStep:GetPaintingAlpha()
	return self.actorAlpha
end

function DialogueStep:GetPaitingOffst()
	return self.actorPosition
end

function DialogueStep:GetSound()
	return self.sound
end

function DialogueStep:GetPaintingActions()
	return self.action
end

function DialogueStep:GetPaintingMoveToSide()
	return self.moveSideData
end

function DialogueStep:ShouldMoveToSide()
	return self.moveSideData ~= nil
end

function DialogueStep:GetPaintingAction(arg_36_1)
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs((self:GetPaintingActions())) do
		if iter_36_1.type == arg_36_1 then
			table.insert(var_36_0, iter_36_1)
		end
	end

	return var_36_0
end

function DialogueStep:GetSide()
	return self.side
end

function DialogueStep:GetContent()
	if not self.say then
		return "..."
	end

	local var_38_0 = self.say

	if self:ShouldReplacePlayer() then
		var_38_0 = self:ReplacePlayerName(var_38_0)
	end

	if self:ShouldReplaceTb() then
		var_38_0 = self:ReplaceTbName(var_38_0)
	end

	if self:ShouldReplaceDorm() then
		var_38_0 = self:ReplaceDormName(var_38_0)
	end

	if self:ShouldReplaceCar2026() then
		var_38_0 = self:ReplaceCar2026Name(var_38_0)
	end

	var_38_0 = PLATFORM_CODE ~= PLATFORM_US and SwitchSpecialChar(HXSet.hxLan(var_38_0), true) or HXSet.hxLan(var_38_0)

	return var_38_0
end

function DialogueStep:GetContentColor()
	return self.sayColor or COLOR_WHITE
end

function DialogueStep:GetNameWithColor()
	local var_40_0 = self:GetName()

	if not var_40_0 then
		return nil
	end

	return setColorStr(var_40_0, (self:GetNameColor()))
end

function DialogueStep:GetNameColor()
	return self.nameColor or COLOR_WHITE
end

function DialogueStep:GetNameColorCode()
	return string.gsub(self:GetNameColor(), "#", "")
end

function DialogueStep:GetCustomActorName()
	if type(self.actorName) == "number" and self.actorName == 0 and getProxy(PlayerProxy) then
		return getProxy(PlayerProxy):getRawData().name
	elseif type(self.actorName) == "number" then
		return ShipGroup.getDefaultShipNameByGroupID(self.actorName)
	elseif type(self.actorName) == "string" then
		return self.actorName
	else
		return ""
	end

	return
end

function DialogueStep:GetPortraitName()
	if not self:ExistPortrait() then
		return ""
	end

	if type(self.portrait) ~= "number" then
		return ""
	end

	local var_44_0 = var_0_1[self.portrait]

	if not var_0_1[self.portrait] then
		return ""
	end

	local var_44_2 = ShipGroup.getDefaultShipConfig(var_44_0.ship_group)

	return not var_44_2 and var_44_0.name or Ship.getShipName(var_44_2.id)
end

function DialogueStep:GetName()
	local var_45_0 = self.actorName and self:GetCustomActorName() or self:GetPaintingAndName() or ""

	if not var_45_0 or var_45_0 == "" then
		var_45_0 = self:GetPortraitName()
	end

	if not var_45_0 or var_45_0 == "" or self.withoutActorName then
		return nil
	end

	if self:ShouldReplacePlayer() then
		var_45_0 = self:ReplacePlayerName(var_45_0)
	end

	if self:ShouldReplaceTb() then
		var_45_0 = self:ReplaceTbName(var_45_0)
	end

	if self:ShouldReplaceCar2026() then
		var_45_0 = self:ReplaceCar2026Name(var_45_0)
	end

	return (HXSet.hxLan(var_45_0))
end

function DialogueStep:GetPainting()
	local var_46_0, var_46_1 = self:GetPaintingAndName()

	return var_46_1
end

function DialogueStep:ExistPainting()
	return self:GetPainting() ~= nil
end

function DialogueStep:ShouldShakeDailogue()
	return self.dialogShake ~= nil
end

function DialogueStep:GetShakeDailogueData()
	return self.dialogShake
end

function DialogueStep:IsSameSide(arg_50_1)
	local var_50_0 = self:GetPrevSide(arg_50_1)
	local var_50_1 = self:GetSide()

	return var_50_0 ~= nil and var_50_1 ~= nil and var_50_0 == var_50_1
end

function DialogueStep:GetPrevSide(arg_51_1)
	local var_51_0 = arg_51_1:GetSide()

	return (self.moveSideData or nil) and self.moveSideData.side
end

function DialogueStep:GetPaintingIcon()
	local var_52_0 = self.actor == DialogueStep.ACTOR_TYPE_FLAGSHIP and getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getRawData().character):getPrefab() or (self.actor ~= DialogueStep.ACTOR_TYPE_PLAYER or nil) and (self.actor ~= DialogueStep.ACTOR_TYPE_TB or nil) and (self.actor or nil) and (not self.hideRecordIco or nil) and var_0_1[self.actor].prefab

	if var_52_0 == nil and self:ExistPortrait() and not self.hideRecordIco then
		var_52_0 = self:GetPortrait()
	end

	return var_52_0
end

function DialogueStep:GetPaintingAndName()
	local var_53_0
	local var_53_1

	if not UnGamePlayState and self.actor == DialogueStep.ACTOR_TYPE_FLAGSHIP then
		local var_53_2 = getProxy(BayProxy):getShipById(getProxy(PlayerProxy):getRawData().character)

		var_53_0 = var_53_2:getName()
		var_53_1 = var_53_2:getPainting()
	elseif not UnGamePlayState and self.actor == DialogueStep.ACTOR_TYPE_PLAYER then
		var_53_0 = getProxy(PlayerProxy) and getProxy(PlayerProxy):getRawData().name or ""
	elseif not UnGamePlayState and self.actor == DialogueStep.ACTOR_TYPE_TB then
		if pg.NewStoryMgr.GetInstance():IsReView() then
			assert(self.defaultTb and self.defaultTb > 0, "<<< defaultTb is nil >>>")

			var_53_0 = pg.secretary_special_ship[self.defaultTb].name or ""
			var_53_1 = pg.secretary_special_ship[self.defaultTb].prefab
		elseif self.specialTbId then
			assert(pg.secretary_special_ship[self.specialTbId])

			var_53_0 = pg.secretary_special_ship[self.specialTbId].name or ""
			var_53_1 = pg.secretary_special_ship[self.specialTbId].prefab
		else
			if getProxy(NewEducateProxy) then
				if getProxy(NewEducateProxy):GetCurChar() then
					var_53_1, var_53_0 = getProxy(NewEducateProxy):GetStoryInfo()

					goto label_53_0
				end
			end

			if EducateProxy and getProxy(EducateProxy) then
				var_53_1, var_53_0 = getProxy(EducateProxy):GetStoryInfo()
			else
				var_53_0 = ""
			end
		end
	else
		if self.actor then
			if var_0_1[self.actor] == nil then
				var_53_1 = nil
				var_53_0 = nil

				goto label_53_0
			end
		end

		local var_53_4 = var_0_1[self.actor]
		local var_53_5 = ShipGroup.getDefaultShipConfig(var_0_1[self.actor].ship_group)

		var_53_0 = not var_53_5 and var_53_4.name or Ship.getShipName(var_53_5.id)
		var_53_1 = var_53_4.painting
	end

	::label_53_0::

	return HXSet.hxLan(var_53_0), var_53_1
end

function DialogueStep:GetShipSkinId()
	if self.actor == DialogueStep.ACTOR_TYPE_FLAGSHIP then
		return getProxy(BayProxy):GetShipPhantom(getProxy(PlayerProxy):getRawData():GetFlagShipPhantomMark()):getSkinId()
	elseif self.actor == DialogueStep.ACTOR_TYPE_PLAYER then
		return nil
	elseif not self.actor then
		return nil
	else
		return self.actor
	end

	return
end

function DialogueStep:IsShowNPainting()
	return self.showNPainting
end

function DialogueStep:IsShowWJZPainting()
	return self.showWJZPainting
end

function DialogueStep:ShouldGrayPainting()
	return self.paingtingGray
end

function DialogueStep:ShouldAddGlitchArtEffect()
	return self.glitchArt
end

function DialogueStep:HideOtherPainting()
	return self.hideOtherPainting
end

function DialogueStep:GetSubPaintings()
	return _.map(self.subPaintings or {}, function(arg_61_0)
		assert(pg.ship_skin_template[arg_61_0.actor])

		local var_61_0 = {
			actor = arg_61_0.actor,
			name = pg.ship_skin_template[arg_61_0.actor].painting,
			expression = arg_61_0.expression,
			pos = arg_61_0.pos
		}

		var_61_0.dir = arg_61_0.dir or 1
		var_61_0.paintingNoise = arg_61_0.paintingNoise or false
		var_61_0.showNPainting = arg_61_0.hidePaintObj or false

		return var_61_0
	end)
end

function DialogueStep:NeedDispppearSubPainting()
	return #self.disappearSeq > 0
end

function DialogueStep:GetDisappearSeq()
	return self.disappearSeq
end

function DialogueStep:GetDisappearTime()
	return self.disappearTime[1], self.disappearTime[2]
end

function DialogueStep:IsNoHeadPainting()
	return self.nohead
end

function DialogueStep:GetFontSize()
	return self.fontSize
end

function DialogueStep:IsSpinePainting()
	local var_67_0

	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		do return false end

		var_67_0 = tobool
	end

	return var_67_0(self:GetPainting() ~= nil and self.spine)
end

function DialogueStep:IsHideSpineBg()
	return self.spine == 1
end

function DialogueStep:GetSpineOrderIndex()
	if self:IsSpinePainting() then
		return self.spineOrderIndex
	else
		return nil
	end

	return
end

function DialogueStep:IsLive2dPainting()
	local var_70_0

	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		do return false end

		var_70_0 = tobool
	end

	return var_70_0(self:GetPainting() ~= nil and self.live2d)
end

function DialogueStep:GetLive2dPos()
	if self.live2dOffset then
		return Vector3(self.live2dOffset[1], self.live2dOffset[2], self.live2dOffset[3])
	end

	return
end

function DialogueStep:GetVirtualShip()
	local var_72_0 = self:GetShipSkinId()

	return StoryShip.New({
		skin_id = var_72_0
	})
end

function DialogueStep:GetLive2dAction()
	if type(self.live2d) == "string" then
		if pg.character_voice[self.live2d] then
			return pg.character_voice[self.live2d].l2d_action
		end

		return self.live2d
	else
		return nil
	end

	return
end

function DialogueStep:GetL2dIdleIndex()
	return self.live2dIdleIndex
end

function DialogueStep:GetSubActorName()
	if self.subActorName and self.subActorName ~= "" then
		return " " .. setColorStr(HXSet.hxLan(self.subActorName), self.subActorNameColor)
	else
		return ""
	end

	return
end

function DialogueStep:IsSamePainting(arg_76_1)
	return (function()
		return self:GetPainting() == arg_76_1:GetPainting() and self:IsShowNPainting() == arg_76_1:IsShowNPainting() and self:IsShowWJZPainting() == arg_76_1:IsShowWJZPainting()
	end)() and self:IsLive2dPainting() == arg_76_1:IsLive2dPainting() and self:IsSpinePainting() == arg_76_1:IsSpinePainting() and not (function()
		return arg_76_1:ShouldAddGlitchArtEffect() or self:ShouldAddGlitchArtEffect()
	end)()
end

function DialogueStep:ExistCanMarkNode()
	local var_79_0

	if self.canMarkNode ~= nil and type(self.canMarkNode) == "table" then
		var_79_0 = self.canMarkNode[1]

		if self.canMarkNode[1] then
			if self.canMarkNode[1] ~= "" then
				var_79_0 = self.canMarkNode[2] and type(self.canMarkNode[2]) == "table"
			end
		end
	end

	return var_79_0
end

function DialogueStep:GetCanMarkNodeData()
	local var_80_0 = {}

	for iter_80_0, iter_80_1 in ipairs(self.canMarkNode[2] or {}) do
		table.insert(var_80_0, iter_80_1 .. "")
	end

	return {
		name = self.canMarkNode[1],
		marks = var_80_0
	}
end

function DialogueStep:OnClear()
	return
end

function DialogueStep:GetUsingPaintingNames()
	local var_82_0 = {}
	local var_82_1 = self:GetPainting()

	if var_82_1 ~= nil then
		table.insert(var_82_0, var_82_1)
	end

	for iter_82_0, iter_82_1 in ipairs((self:GetSubPaintings())) do
		table.insert(var_82_0, iter_82_1.name)
	end

	return var_82_0
end

return DialogueStep

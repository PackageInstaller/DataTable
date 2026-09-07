local CryptolaliaMainView = class("CryptolaliaMainView")

function CryptolaliaMainView:Ctor(arg_1_1)
	setmetatable(self, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			return (var_2_0[arg_2_1] or nil) and (var_2_0[arg_2_1] or arg_1_1[arg_2_1])
		end
	})

	self.downloadBtnAnim = self.downloadBtn:GetComponent(typeof(Animation))

	return
end

function CryptolaliaMainView:Flush(arg_3_1, arg_3_2, arg_3_3)
	if not self.cryptolalia or self.cryptolalia.id ~= arg_3_1.id then
		self.shipName.text = arg_3_1:GetShipName()
		self.nameTxt.text = arg_3_1:GetName()
		self.descTxt.text = arg_3_1:GetDescription()

		self.auditionTxt:SetText(arg_3_1:GetAuditionTitle())
		self:LoadCryptolaliaSpriteForShipGroup(arg_3_1:GetShipGroupId())

		local var_3_0 = not arg_3_1:IsForever() and arg_3_1:IsLock()

		setActive(self.timeLimit, var_3_0)
		self:RemoveTimer()
		self:AddTimer(arg_3_1, var_3_0)
	end

	self.authorTxt.text = "CV:" .. arg_3_1:GetCvAuthor(arg_3_2)

	self:FlushState(arg_3_1, arg_3_2, arg_3_3)

	self.cryptolalia = arg_3_1

	return
end

function CryptolaliaMainView:AddTimer(arg_4_1, arg_4_2)
	if arg_4_2 then
		local var_4_0 = ""

		self.timer = Timer.New(function()
			local var_5_0 = arg_4_1:GetExpiredTimeStr()

			if var_4_0 ~= var_5_0 then
				var_4_0 = var_5_0
				self.timeTxt.text = var_5_0
			end

			return
		end, 1, -1)

		self.timer:Start()
		self.timer.func()
	else
		self.timeTxt.text = ""
	end

	return
end

function CryptolaliaMainView:FlushState(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0

	if arg_6_3 then
		var_6_0 = Cryptolalia.STATE_DOWNLOADING or arg_6_1:GetState(arg_6_2)
	end

	setActive(self.lockBtn, Cryptolalia.STATE_LOCK == var_6_0)
	setActive(self.downloadBtn, Cryptolalia.STATE_DOWNLOADABLE == var_6_0)

	if self.state and self.state == Cryptolalia.STATE_LOCK and var_6_0 == Cryptolalia.STATE_DOWNLOADABLE then
		self.downloadBtnAnim:Stop()
		self.downloadBtnAnim:Play("anim_Cryptolalia_dowmload")
	end

	setSlider(self.downloadingBtn, 0, 1, 0)
	setActive(self.downloadingBtn, var_6_0 == Cryptolalia.STATE_DOWNLOADING)
	setActive(self.playBtn, Cryptolalia.STATE_PLAYABLE == var_6_0)
	setActive(self.deleteBtn, Cryptolalia.STATE_PLAYABLE == var_6_0)
	setText(self.deleteBtn:Find("label"), i18n("cryptolalia_delete_res", arg_6_1:GetResSize(arg_6_2)))
	setActive(self.stateBtn, Cryptolalia.STATE_PLAYABLE ~= var_6_0)
	setActive(self.switchBtn, var_6_0 ~= Cryptolalia.STATE_DOWNLOADING and PLATFORM_CODE == PLATFORM_CH and arg_6_1:IsMultiVersion())

	local var_6_1 = Vector2(0, 0)
	local var_6_2 = Vector2(20, -9.2)
	local var_6_3 = arg_6_2 == Cryptolalia.LANG_TYPE_CH

	setAnchoredPosition(self.switchBtn:Find("ch"), arg_6_2 == Cryptolalia.LANG_TYPE_CH and var_6_1 or var_6_2)
	setAnchoredPosition(self.switchBtn:Find("jp"), var_6_3 and var_6_2 or var_6_1)
	setActive(self.listBtn, var_6_0 ~= Cryptolalia.STATE_DOWNLOADING)

	self.stateBtnTxt.text = Cryptolalia.STATE_LOCK == var_6_0 and i18n("cryptolalia_lock_res") or Cryptolalia.STATE_PLAYABLE ~= var_6_0 and i18n("cryptolalia_not_download_res") or ""
	self.state = var_6_0

	return
end

local function var_0_1(arg_7_0, arg_7_1, arg_7_2)
	LoadSpriteAtlasAsync("CryptolaliaShip/" .. arg_7_1, "cd", function(arg_8_0)
		if arg_7_0.exited then
			return
		end

		arg_7_0.cdImg.sprite = arg_8_0

		arg_7_0.cdImg:SetNativeSize()
		arg_7_2()

		return
	end)

	return
end

function CryptolaliaMainView:LoadCryptolaliaSpriteForShipGroup(arg_13_1)
	self.cg.blocksRaycasts = false

	parallelAsync({
		function(arg_14_0)
			var_0_1(self, arg_13_1, arg_14_0)

			return
		end
	}, function()
		self.cg.blocksRaycasts = true

		return
	end)

	return
end

function CryptolaliaMainView:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CryptolaliaMainView:Dispose()
	self.exited = true

	self:RemoveTimer()

	return
end

return CryptolaliaMainView

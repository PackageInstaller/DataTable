pg = pg or {}
pg.SceneAnimMgr = singletonClass("SceneAnimMgr")

function pg.SceneAnimMgr.Ctor(arg_1_0)
	arg_1_0.loadingList = {}
	arg_1_0.dormCallbackList = {}

	return
end

function pg.SceneAnimMgr.Init(arg_2_0, arg_2_1)
	print("initializing sceneanim manager...")
	LoadAndInstantiateAsync("ui", "SceneAnimUI", function(arg_3_0)
		arg_2_0._go = arg_3_0

		arg_2_0._go:SetActive(false)

		arg_2_0._tf = arg_2_0._go.transform

		arg_2_0._tf:SetParent(pg.UIMgr.GetInstance().OverlayToast, false)

		arg_2_0.container = arg_2_0._tf:Find("container")

		if arg_2_1 then
			arg_2_1()
		end

		return
	end, true, true)

	return
end

function pg.SceneAnimMgr:SixthAnniversaryJPCoverGoScene(arg_4_1)
	self.playing = true

	setActive(self._tf, true)

	local var_4_0 = "SixthAnniversaryJPCoverUI"

	PoolMgr.GetInstance():GetUI("SixthAnniversaryJPCoverUI", true, function(arg_5_0)
		local var_5_0 = arg_5_0.transform

		setParent(arg_5_0.transform, self.container, false)
		setActive(arg_5_0.transform, true)

		local var_5_1 = arg_5_0.transform:Find("houshanyunwu"):GetComponent(typeof(SpineAnimUI))

		var_5_1:SetActionCallBack(function(arg_6_0)
			if arg_6_0 == "finish" then
				PoolMgr.GetInstance():ReturnUI(var_4_0, arg_5_0)

				self.playing = nil

				setActive(var_5_0, false)
				setActive(self._tf, false)
			elseif arg_6_0 == "action" then
				pg.m02:sendNotification(GAME.GO_SCENE, arg_4_1)
			end

			return
		end)
		var_5_1:SetAction("action", 0)

		return
	end)

	return
end

function pg.SceneAnimMgr:OtherWorldCoverGoScene(arg_7_1, arg_7_2)
	self.playing = true

	setActive(self._tf, true)

	local var_7_0 = "OtherworldCoverUI"

	PoolMgr.GetInstance():GetUI("OtherworldCoverUI", true, function(arg_8_0)
		local var_8_0 = arg_8_0.transform

		setParent(arg_8_0.transform, self.container, false)
		setActive(arg_8_0.transform, true)

		local var_8_1 = arg_8_0.transform:Find("yuncaizhuanchang"):GetComponent(typeof(SpineAnimUI))

		var_8_1:SetActionCallBack(function(arg_9_0)
			if arg_9_0 == "finish" then
				PoolMgr.GetInstance():ReturnUI(var_7_0, arg_8_0)

				self.playing = nil

				setActive(var_8_0, false)
				setActive(self._tf, false)
			elseif arg_9_0 == "action" then
				pg.m02:sendNotification(GAME.GO_SCENE, arg_7_1, arg_7_2)
			end

			return
		end)
		var_8_1:SetAction("action", 0)

		return
	end)

	return
end

function pg.SceneAnimMgr:CommonSceneChange(arg_10_1, arg_10_2)
	table.insert(self.loadingList, {
		arg_10_1,
		arg_10_2
	})

	if not self.playing then
		self:DoSceneChange()
	end

	return
end

function pg.SceneAnimMgr:DoSceneChange()
	self.playing = true

	setActive(self._tf, true)
	pg.UIMgr.GetInstance():LoadingOn(false)

	local var_11_0, var_11_1 = unpack(table.remove(self.loadingList, 1))
	local var_11_2 = self.container:Find(var_11_0)
	local var_11_3 = {}

	if not var_11_2 then
		table.insert(var_11_3, function(arg_12_0)
			PoolMgr.GetInstance():GetUI(var_11_0, true, function(arg_13_0)
				var_11_2 = arg_13_0.transform

				setParent(var_11_2, self.container, false)
				arg_12_0()

				return
			end)

			return
		end)
	end

	table.insert(var_11_3, function(arg_14_0)
		self:StartLoading(var_11_0, var_11_2, arg_14_0)

		return
	end)
	table.insert(var_11_3, function(arg_15_0)
		local function var_15_1()
			if #self.loadingList > 0 and self.loadingList[1][1] == var_11_0 then
				var_11_0, var_11_1 = unpack(table.remove(self.loadingList, 1))

				var_11_1(var_15_1)
			else
				arg_15_0()
			end

			return
		end

		var_11_1(nil)
		self:LoopLoading(var_11_0, var_11_2)

		return
	end)
	table.insert(var_11_3, function(arg_17_0)
		self:EndLoading(var_11_0, var_11_2, arg_17_0)

		return
	end)
	seriesAsync(var_11_3, function()
		PoolMgr.GetInstance():ReturnUI(var_11_0, var_11_2.gameObject)
		pg.UIMgr.GetInstance():LoadingOff()

		if #self.loadingList > 0 then
			self:DoSceneChange()
		else
			self.playing = nil

			setActive(self._tf, false)
		end

		return
	end)

	return
end

function pg.SceneAnimMgr.StartLoading(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	switch(arg_19_1, {
		Dorm3DLoading = function()
			GetComponent(arg_19_2, typeof(Animator)):SetBool("Finish", false)

			local var_20_0 = arg_19_2:Find("bg"):GetComponent(typeof(Image)).material

			var_20_0:SetInt("_DissolveTexFlip", 1)
			LeanTween.value(1, 0, 0.6):setOnUpdate(System.Action_float(function(arg_21_0)
				var_20_0:SetFloat("_Dissolve", arg_21_0)

				return
			end)):setEase(LeanTweenType.easeOutCubic)
			arg_19_2:GetComponent("DftAniEvent"):SetTriggerEvent(arg_19_3)
			quickPlayAnimator(arg_19_2, "anim_dorm3d_loading_in")

			return
		end,
		IslandplaneLoading = function()
			arg_19_2:GetComponent("DftAniEvent"):SetTriggerEvent(arg_19_3)
			quickPlayAnimation(arg_19_2, "anim_planeLoading_in")
			arg_19_2:Find("load"):GetComponent("SkeletonAnimation").state:SetAnimation(0, "cut_in", false)

			return
		end,
		IslandcarLoading = function()
			arg_19_2:GetComponent("DftAniEvent"):SetTriggerEvent(arg_19_3)
			quickPlayAnimation(arg_19_2, "anim_planeLoading_in")
			arg_19_2:Find("load"):GetComponent("SkeletonAnimation").state:SetAnimation(0, "cut_in", false)

			return
		end,
		jufengyuziyouqundao = function()
			arg_19_2 = arg_19_2:Find("scale")

			arg_19_2:GetComponent("DftAniEvent"):SetTriggerEvent(arg_19_3)
			quickPlayAnimator(arg_19_2, "jufeng")

			return
		end,
		jufengyuziyouqundao_fullscreen = function()
			arg_19_2 = arg_19_2:Find("scale")

			arg_19_2:GetComponent("DftAniEvent"):SetTriggerEvent(arg_19_3)
			quickPlayAnimator(arg_19_2, "jufeng")

			return
		end,
		jiarihangxianshanyaohaibin = function()
			arg_19_2 = arg_19_2:Find("scale")

			arg_19_2:GetComponent("DftAniEvent"):SetTriggerEvent(arg_19_3)
			quickPlayAnimator(arg_19_2, "manyou")

			return
		end
	}, function()
		return
	end)

	return
end

function pg.SceneAnimMgr.LoopLoading(arg_28_0, arg_28_1, arg_28_2)
	switch(arg_28_1, {
		Dorm3DLoading = function()
			pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_loading_loop")

			return
		end,
		IslandplaneLoading = function()
			arg_28_2:Find("load"):GetComponent("SkeletonAnimation").state:SetAnimation(0, "normal", true)

			return
		end,
		IslandcarLoading = function()
			arg_28_2:Find("load"):GetComponent("SkeletonAnimation").state:SetAnimation(0, "normal", true)

			return
		end
	}, function()
		return
	end)

	return
end

function pg.SceneAnimMgr.EndLoading(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	switch(arg_33_1, {
		Dorm3DLoading = function()
			local var_34_0 = arg_33_2:Find("bg"):GetComponent(typeof(Image)).material

			var_34_0:SetInt("_DissolveTexFlip", 0)
			LeanTween.value(0, 1, 0.6):setOnUpdate(System.Action_float(function(arg_35_0)
				var_34_0:SetFloat("_Dissolve", arg_35_0)

				return
			end)):setEase(LeanTweenType.easeInOutCubic)
			arg_33_2:GetComponent("DftAniEvent"):SetEndEvent(arg_33_3)
			GetComponent(arg_33_2, typeof(Animator)):SetBool("Finish", true)

			return
		end,
		IslandplaneLoading = function()
			arg_33_2:GetComponent("DftAniEvent"):SetEndEvent(arg_33_3)
			quickPlayAnimation(arg_33_2, "anim_planeLoading_out")

			return
		end,
		IslandcarLoading = function()
			arg_33_2:GetComponent("DftAniEvent"):SetEndEvent(arg_33_3)
			quickPlayAnimation(arg_33_2, "anim_planeLoading_out")

			return
		end,
		jufengyuziyouqundao = function()
			arg_33_3()

			return
		end,
		jufengyuziyouqundao_fullscreen = function()
			arg_33_3()

			return
		end,
		jiarihangxianshanyaohaibin = function()
			arg_33_3()

			return
		end
	}, function()
		return
	end)

	return
end

function pg.SceneAnimMgr.RegisterDormNextCall(arg_42_0, arg_42_1)
	function arg_42_0.dormNextCall()
		arg_42_0.dormNextCall = nil

		return arg_42_1()
	end

	return
end

function pg.SceneAnimMgr:Dorm3DSceneChange(arg_44_1)
	table.insert(self.dormCallbackList, arg_44_1)

	if not self.playing then
		pg.UIMgr.GetInstance():LoadingOn(false)
		self:DoDorm3DSceneChange()
	end

	existCall(self.dormNextCall)

	return
end

function pg.SceneAnimMgr:DoDorm3DSceneChange(arg_45_1)
	self.playing = true

	setActive(self._tf, true)

	local var_45_0 = "Dorm3DLoading"
	local var_45_1 = {}

	if not arg_45_1 then
		table.insert(var_45_1, function(arg_46_0)
			PoolMgr.GetInstance():GetUI(var_45_0, true, function(arg_47_0)
				arg_45_1 = arg_47_0.transform

				setParent(arg_45_1, self.container, false)
				arg_46_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_45_1, function()
		local var_48_0 = arg_45_1:Find("bg"):GetComponent(typeof(Image)).material
		local var_48_1 = arg_45_1:GetComponent("DftAniEvent")

		var_48_1:SetTriggerEvent(function(arg_49_0)
			local function var_49_1()
				if #self.dormCallbackList > 0 then
					table.remove(self.dormCallbackList, 1)(var_49_1)
				else
					GetComponent(arg_45_1, typeof(Animator)):SetBool("Finish", true)
					var_48_0:SetInt("_DissolveTexFlip", 0)
					LeanTween.value(0, 1, 0.6):setOnUpdate(System.Action_float(function(arg_51_0)
						var_48_0:SetFloat("_Dissolve", arg_51_0)

						return
					end)):setEase(LeanTweenType.easeInOutCubic)
				end

				return
			end

			;(nil)()
			pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_loading_loop")

			return
		end)
		var_48_1:SetEndEvent(function(arg_52_0)
			if #self.dormCallbackList > 0 then
				quickPlayAnimator(arg_45_1, "anim_dorm3d_loading_in")
				self:DoDorm3DSceneChange(arg_45_1)
			else
				PoolMgr.GetInstance():ReturnUI(var_45_0, arg_45_1.gameObject)

				self.playing = nil

				setActive(self._tf, false)
				pg.UIMgr.GetInstance():LoadingOff()
			end

			return
		end)
		GetComponent(arg_45_1, typeof(Animator)):SetBool("Finish", false)
		var_48_0:SetInt("_DissolveTexFlip", 1)
		LeanTween.value(1, 0, 0.6):setOnUpdate(System.Action_float(function(arg_53_0)
			var_48_0:SetFloat("_Dissolve", arg_53_0)

			return
		end)):setEase(LeanTweenType.easeOutCubic)

		return
	end)

	return
end

function pg.SceneAnimMgr:IsPlaying()
	return self.playing
end

function pg.SceneAnimMgr:Dispose()
	setActive(self._tf, false)

	self.playing = nil

	return
end

return

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

function pg.SceneAnimMgr.SixthAnniversaryJPCoverGoScene(arg_4_0, arg_4_1)
	arg_4_0.playing = true

	setActive(arg_4_0._tf, true)
	PoolMgr.GetInstance():GetUI("SixthAnniversaryJPCoverUI", true, function(arg_5_0)
		local var_5_0 = arg_5_0.transform

		setParent(arg_5_0.transform, arg_4_0.container, false)
		setActive(arg_5_0.transform, true)

		local var_5_1 = arg_5_0.transform:Find("houshanyunwu"):GetComponent(typeof(SpineAnimUI))

		var_5_1:SetActionCallBack(function(arg_6_0)
			if arg_6_0 == "finish" then
				PoolMgr.GetInstance():ReturnUI(var_0, arg_5_0)

				arg_4_0.playing = nil

				setActive(var_5_0, false)
				setActive(arg_4_0._tf, false)
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

function pg.SceneAnimMgr.OtherWorldCoverGoScene(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.playing = true

	setActive(arg_7_0._tf, true)
	PoolMgr.GetInstance():GetUI("OtherworldCoverUI", true, function(arg_8_0)
		local var_8_0 = arg_8_0.transform

		setParent(arg_8_0.transform, arg_7_0.container, false)
		setActive(arg_8_0.transform, true)

		local var_8_1 = arg_8_0.transform:Find("yuncaizhuanchang"):GetComponent(typeof(SpineAnimUI))

		var_8_1:SetActionCallBack(function(arg_9_0)
			if arg_9_0 == "finish" then
				PoolMgr.GetInstance():ReturnUI(var_0, arg_8_0)

				arg_7_0.playing = nil

				setActive(var_8_0, false)
				setActive(arg_7_0._tf, false)
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

function pg.SceneAnimMgr.CommonSceneChange(arg_10_0, arg_10_1, arg_10_2)
	table.insert(arg_10_0.loadingList, {
		arg_10_1,
		arg_10_2
	})

	if not arg_10_0.playing then
		arg_10_0:DoSceneChange()
	end

	return
end

function pg.SceneAnimMgr.DoSceneChange(arg_11_0)
	arg_11_0.playing = true

	setActive(arg_11_0._tf, true)
	pg.UIMgr.GetInstance():LoadingOn(false)

	local var_11_0, var_11_1 = unpack(table.remove(arg_11_0.loadingList, 1))

	if not arg_11_0.container:Find(var_11_0) then
		table.insert({}, function(arg_12_0)
			PoolMgr.GetInstance():GetUI(var_11_0, true, function(arg_13_0)
				var_0 = arg_13_0.transform

				setParent(var_0, arg_11_0.container, false)
				arg_12_0()

				return
			end)

			return
		end)
	end

	table.insert({}, function(arg_14_0)
		arg_11_0:StartLoading(var_11_0, var_0, arg_14_0)

		return
	end)
	table.insert({}, function(arg_15_0)
		var_11_1(function()
			if #arg_11_0.loadingList > 0 and arg_11_0.loadingList[1][1] == var_11_0 then
				var_11_0, var_11_1 = unpack(table.remove(arg_11_0.loadingList, 1))

				var_11_1(var_0)
			else
				arg_15_0()
			end

			return
		end)
		arg_11_0:LoopLoading(var_11_0, var_0)

		return
	end)
	table.insert({}, function(arg_17_0)
		arg_11_0:EndLoading(var_11_0, var_0, arg_17_0)

		return
	end)
	seriesAsync({}, function()
		PoolMgr.GetInstance():ReturnUI(var_11_0, var_0.gameObject)
		pg.UIMgr.GetInstance():LoadingOff()

		if #arg_11_0.loadingList > 0 then
			arg_11_0:DoSceneChange()
		else
			arg_11_0.playing = nil

			setActive(arg_11_0._tf, false)
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

			arg_19_2:Find("bg"):GetComponent(typeof(Image)).material:SetInt("_DissolveTexFlip", 1)
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

			arg_33_2:Find("bg"):GetComponent(typeof(Image)).material:SetInt("_DissolveTexFlip", 0)
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

function pg.SceneAnimMgr.Dorm3DSceneChange(arg_44_0, arg_44_1)
	table.insert(arg_44_0.dormCallbackList, arg_44_1)

	if not arg_44_0.playing then
		pg.UIMgr.GetInstance():LoadingOn(false)
		arg_44_0:DoDorm3DSceneChange()
	end

	existCall(arg_44_0.dormNextCall)

	return
end

function pg.SceneAnimMgr.DoDorm3DSceneChange(arg_45_0, arg_45_1)
	arg_45_0.playing = true

	setActive(arg_45_0._tf, true)

	local var_45_0 = "Dorm3DLoading"

	if not arg_45_1 then
		table.insert({}, function(arg_46_0)
			PoolMgr.GetInstance():GetUI(var_45_0, true, function(arg_47_0)
				arg_45_1 = arg_47_0.transform

				setParent(arg_45_1, arg_45_0.container, false)
				arg_46_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, function()
		local var_48_0 = arg_45_1:Find("bg"):GetComponent(typeof(Image)).material
		local var_48_1 = arg_45_1:GetComponent("DftAniEvent")

		var_48_1:SetTriggerEvent(function(arg_49_0)
			(function()
				if #arg_45_0.dormCallbackList > 0 then
					table.remove(arg_45_0.dormCallbackList, 1)(var_0)
				else
					GetComponent(arg_45_1, typeof(Animator)):SetBool("Finish", true)
					var_48_0:SetInt("_DissolveTexFlip", 0)
					LeanTween.value(0, 1, 0.6):setOnUpdate(System.Action_float(function(arg_51_0)
						var_48_0:SetFloat("_Dissolve", arg_51_0)

						return
					end)):setEase(LeanTweenType.easeInOutCubic)
				end

				return
			end)()
			pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_loading_loop")

			return
		end)
		var_48_1:SetEndEvent(function(arg_52_0)
			if #arg_45_0.dormCallbackList > 0 then
				quickPlayAnimator(arg_45_1, "anim_dorm3d_loading_in")
				arg_45_0:DoDorm3DSceneChange(arg_45_1)
			else
				PoolMgr.GetInstance():ReturnUI(var_45_0, arg_45_1.gameObject)

				arg_45_0.playing = nil

				setActive(arg_45_0._tf, false)
				pg.UIMgr.GetInstance():LoadingOff()
			end

			return
		end)
		GetComponent(arg_45_1, typeof(Animator)):SetBool("Finish", false)
		arg_45_1:Find("bg"):GetComponent(typeof(Image)).material:SetInt("_DissolveTexFlip", 1)
		LeanTween.value(1, 0, 0.6):setOnUpdate(System.Action_float(function(arg_53_0)
			var_48_0:SetFloat("_Dissolve", arg_53_0)

			return
		end)):setEase(LeanTweenType.easeOutCubic)

		return
	end)

	return
end

function pg.SceneAnimMgr.IsPlaying(arg_54_0)
	return arg_54_0.playing
end

function pg.SceneAnimMgr.Dispose(arg_55_0)
	setActive(arg_55_0._tf, false)

	arg_55_0.playing = nil

	return
end

return

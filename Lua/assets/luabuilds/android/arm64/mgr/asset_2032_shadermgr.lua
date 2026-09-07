pg = pg or {}
pg.ShaderMgr = singletonClass("ShaderMgr")

local var_0_0 = pg.ShaderMgr

function pg.ShaderMgr.Init(arg_1_0, arg_1_1)
	print("initializing shader manager...")
	Shader.DisableKeyword("LOW_DEVICE_PERFORMANCE")

	local var_1_0 = {
		function(arg_2_0)
			ResourceMgr.Inst:LoadShaderAndCached("shader", arg_2_0, false, false)

			return
		end,
		function(arg_3_0)
			ResourceMgr.Inst:LoadShaderAndCached("l2dshader", arg_3_0, false, false)

			return
		end,
		function(arg_4_0)
			ResourceMgr.Inst:LoadShaderAndCached("spineshader", arg_4_0, false, false)

			return
		end,
		function(arg_5_0)
			arg_5_0()

			return
		end
	}

	;(function(arg_6_0)
		if not EDITOR_TOOL then
			seriesAsync({
				function(arg_7_0)
					ResourceMgr.Inst:unloadUnusedAssetBundles()
					onDelayTick(arg_7_0, 0.0001)

					return
				end,
				function(arg_8_0)
					ResourceMgr.Inst:loadAssetBundleAsync("custom_builtin", function(arg_9_0)
						arg_9_0:Unload(false)
						onDelayTick(arg_8_0, 0.0001)

						return
					end)

					return
				end,
				function(arg_10_0)
					var_0_0.cacheCustomBuiltin = UnityEngine.AssetBundle.LoadFromFile(PathMgr.getAssetBundle("custom_builtin"))

					arg_10_0()

					return
				end
			}, arg_6_0)
		else
			ResourceMgr.Inst:LoadShaderAndCached("custom_builtin", arg_6_0, false, false)
		end

		return
	end)(function()
		parallelAsync(var_1_0, function()
			arg_1_1()

			return
		end)

		return
	end)

	return
end

function pg.ShaderMgr.GetShader(arg_13_0, arg_13_1)
	return (ResourceMgr.Inst:GetShader(arg_13_1))
end

function pg.ShaderMgr:GetBlurMaterialSync()
	if self.blurMaterial ~= nil then
		return self.blurMaterial
	else
		self.blurMaterial = Material.New((self:GetShader("Hidden/MobileBlur")))

		self.blurMaterial:SetVector("_Parameter", Vector4.New(1, -1, 0, 0))

		return self.blurMaterial
	end

	return
end

function pg.ShaderMgr:BlurTexture(arg_15_1)
	local var_15_0 = ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.RenderTexture"), "GetTemporary", {
		typeof("System.Int32"),
		typeof("System.Int32"),
		typeof("System.Int32")
	}, {
		Screen.width * 0.25,
		Screen.height * 0.25,
		0
	})
	local var_15_1 = ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.RenderTexture"), "GetTemporary", {
		typeof("System.Int32"),
		typeof("System.Int32"),
		typeof("System.Int32")
	}, {
		Screen.width * 0.25,
		Screen.height * 0.25,
		0
	})

	var_15_0.filterMode = ReflectionHelp.RefGetField(typeof("UnityEngine.FilterMode"), "Bilinear")

	local var_15_2 = self:GetBlurMaterialSync()

	ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.Graphics"), "Blit", {
		typeof("UnityEngine.RenderTexture"),
		typeof("UnityEngine.RenderTexture"),
		typeof("UnityEngine.Material"),
		typeof("System.Int32")
	}, {
		arg_15_1,
		var_15_0,
		var_15_2,
		0
	})

	for iter_15_0 = 0, 1 do
		var_15_2:SetVector("_Parameter", Vector4.New(1 + iter_15_0, -1 - iter_15_0, 0, 0))
		ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.Graphics"), "Blit", {
			typeof("UnityEngine.RenderTexture"),
			typeof("UnityEngine.RenderTexture"),
			typeof("UnityEngine.Material"),
			typeof("System.Int32")
		}, {
			var_15_0,
			var_15_1,
			var_15_2,
			1
		})
		ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.Graphics"), "Blit", {
			typeof("UnityEngine.RenderTexture"),
			typeof("UnityEngine.RenderTexture"),
			typeof("UnityEngine.Material"),
			typeof("System.Int32")
		}, {
			var_15_1,
			var_15_0,
			var_15_2,
			2
		})
	end

	ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.RenderTexture"), "ReleaseTemporary", {
		typeof("UnityEngine.RenderTexture")
	}, {
		var_15_1
	})

	return var_15_0
end

function pg.ShaderMgr:SetSpineUIOutline(arg_16_1, arg_16_2)
	local var_16_0 = Material.New((self:GetShader("M02/Unlit Colored_Alpha_UI_Outline")))

	var_16_0:SetColor("_OutlineColor", arg_16_2)
	var_16_0:SetFloat("_OutlineWidth", 5.75)
	var_16_0:SetFloat("_ThresholdEnd", 0.2)

	GetComponent(arg_16_1, "SkeletonGraphic").material = var_16_0

	return
end

function pg.ShaderMgr.DelSpineUIOutline(arg_17_0, arg_17_1)
	GetComponent(arg_17_1, "SkeletonGraphic").material = nil

	return
end

return

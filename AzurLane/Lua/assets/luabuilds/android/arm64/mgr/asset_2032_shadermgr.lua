pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.ShaderMgr = var_0_10001("ShaderMgr")

local var_0_1 = var_0.ShaderMgr

function var_0.ShaderMgr.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing shader manager...")

	Shader = var_1_10002

	var_1_10002.DisableKeyword("LOW_DEVICE_PERFORMANCE")

	local function var_1_0(arg_2_0)
		ResourceMgr = var_2_10001

		local var_2_0 = var_2_10001.Inst

		var_1.LoadShaderAndCached(var_2_0, "shader", arg_2_0, false, false)

		return
	end

	local function var_1_1(arg_3_0)
		ResourceMgr = var_2_10001

		local var_3_0 = var_2_10001.Inst

		var_1.LoadShaderAndCached(var_3_0, "l2dshader", arg_3_0, false, false)

		return
	end

	local function var_1_2(arg_4_0)
		ResourceMgr = var_2_10001

		local var_4_0 = var_2_10001.Inst

		var_1.LoadShaderAndCached(var_4_0, "spineshader", arg_4_0, false, false)

		return
	end

	local function var_1_3(arg_5_0)
		arg_5_0()

		return
	end

	local function var_1_4(arg_6_0)
		EDITOR_TOOL = var_2_10001

		if not var_2_10001 then
			seriesAsync = var_2_10002

			var_2_10002({
				function(arg_7_0)
					ResourceMgr = var_3_10001

					local var_7_0 = var_3_10001.Inst

					var_1.unloadUnusedAssetBundles(var_7_0)

					onDelayTick = var_1

					var_1(arg_7_0, 0.0001)

					return
				end,
				function(arg_8_0)
					ResourceMgr = var_3_10001

					local var_8_0 = var_3_10001.Inst

					var_1.loadAssetBundleAsync(var_8_0, "custom_builtin", function(arg_9_0)
						arg_9_0:Unload(false)

						onDelayTick = var_1

						var_1(arg_8_0, 0.0001)

						return
					end)

					return
				end,
				function(arg_10_0)
					local var_10_0 = var_0_1

					UnityEngine = var_3_10002

					local var_10_1 = var_3_10002.AssetBundle.LoadFromFile

					PathMgr = var_3_10004
					var_10_0.cacheCustomBuiltin = var_10_1(var_3_10004.getAssetBundle("custom_builtin"))

					arg_10_0()

					return
				end
			}, arg_6_0)
		else
			ResourceMgr = var_2_10002

			local var_6_0 = var_2_10002.Inst

			var_2.LoadShaderAndCached(var_6_0, "custom_builtin", arg_6_0, false, false)
		end

		return
	end

	local var_1_5 = {
		var_1_0,
		var_1_1,
		var_1_2,
		var_1_3
	}

	var_1_4(function()
		parallelAsync = var_2_10000

		var_2_10000(var_1_5, function()
			arg_1_1()

			return
		end)

		return
	end)

	return
end

function var_0_1.GetShader(arg_13_0, arg_13_1)
	ResourceMgr = var_1_10002

	local var_13_0 = var_1_10002.Inst

	return (var_2.GetShader(var_13_0, arg_13_1))
end

function var_0_1.GetBlurMaterialSync(arg_14_0)
	if arg_14_0.blurMaterial ~= nil then
		return arg_14_0.blurMaterial
	else
		local var_14_0 = arg_14_0:GetShader("Hidden/MobileBlur")

		Material = var_1_10002
		arg_14_0.blurMaterial = var_1_10002.New(var_14_0)

		local var_14_1 = arg_14_0.blurMaterial
		local var_14_2 = var_2.SetVector
		local var_14_3 = "_Parameter"

		Vector4 = var_1_10006

		var_14_2(var_14_1, var_14_3, var_1_10006.New(1, -1, 0, 0))

		return arg_14_0.blurMaterial
	end

	return
end

function var_0_1.BlurTexture(arg_15_0, arg_15_1)
	ReflectionHelp = var_1_10002

	local var_15_0 = var_1_10002.RefCallStaticMethod

	typeof = var_1_10004

	local var_15_1 = var_1_10004("UnityEngine.RenderTexture")
	local var_15_2 = "GetTemporary"
	local var_15_3 = {}

	typeof = var_1_10007
	var_15_3[1] = var_1_10007("System.Int32")
	typeof = var_7
	var_15_3[2] = var_7("System.Int32")
	typeof = var_7
	var_15_3[3] = var_7("System.Int32")

	local var_15_4 = {
		nil,
		nil,
		0
	}

	Screen = var_1_10008
	var_15_4[1] = var_1_10008.width * 0.25
	Screen = var_8
	var_15_4[2] = var_8.height * 0.25

	local var_15_5 = var_15_0(var_15_1, var_15_2, var_15_3, var_15_4)

	ReflectionHelp = var_1_10003

	local var_15_6 = var_1_10003.RefCallStaticMethod

	typeof = var_15_2

	local var_15_7 = var_15_2("UnityEngine.RenderTexture")
	local var_15_8 = "GetTemporary"
	local var_15_9 = {}

	typeof = var_8
	var_15_9[1] = var_8("System.Int32")
	typeof = var_8
	var_15_9[2] = var_8("System.Int32")
	typeof = var_8
	var_15_9[3] = var_8("System.Int32")

	local var_15_10 = {
		nil,
		nil,
		0
	}

	Screen = var_9
	var_15_10[1] = var_9.width * 0.25
	Screen = var_9
	var_15_10[2] = var_9.height * 0.25

	local var_15_11 = var_15_6(var_15_7, var_15_8, var_15_9, var_15_10)

	ReflectionHelp = var_15_1

	local var_15_12 = var_15_1.RefGetField

	typeof = var_15_8
	var_15_5.filterMode = var_15_12(var_15_8("UnityEngine.FilterMode"), "Bilinear")

	local var_15_13 = arg_15_0:GetBlurMaterialSync()

	ReflectionHelp = var_15_7

	local var_15_14 = var_15_7.RefCallStaticMethod

	typeof = var_7

	local var_15_15 = var_7("UnityEngine.Graphics")
	local var_15_16 = "Blit"
	local var_15_17 = {}

	typeof = var_10
	var_15_17[1] = var_10("UnityEngine.RenderTexture")
	typeof = var_10
	var_15_17[2] = var_10("UnityEngine.RenderTexture")
	typeof = var_10
	var_15_17[3] = var_10("UnityEngine.Material")
	typeof = var_10
	var_15_17[4] = var_10("System.Int32")

	var_15_14(var_15_15, var_15_16, var_15_17, {
		arg_15_1,
		var_15_5,
		var_15_13,
		0
	})

	for iter_15_0 = 0, 1 do
		local var_15_18 = var_15_13
		local var_15_19 = var_15_13.SetVector
		local var_15_20 = "_Parameter"

		Vector4 = var_1_10013

		var_15_19(var_15_18, var_15_20, var_1_10013.New(1 + iter_15_0, -1 - iter_15_0, 0, 0))

		ReflectionHelp = var_15_19

		local var_15_21 = var_15_19.RefCallStaticMethod

		typeof = var_15_18

		local var_15_22 = var_15_18("UnityEngine.Graphics")
		local var_15_23 = "Blit"

		var_1_10013 = {}
		typeof = var_1_10014
		var_1_10013[1] = var_1_10014("UnityEngine.RenderTexture")
		typeof = var_1_10014
		var_1_10013[2] = var_1_10014("UnityEngine.RenderTexture")
		typeof = var_1_10014
		var_1_10013[3] = var_1_10014("UnityEngine.Material")
		typeof = var_1_10014
		var_1_10013[4] = var_1_10014("System.Int32")

		var_15_21(var_15_22, var_15_23, var_1_10013, {
			var_15_5,
			var_15_11,
			var_15_13,
			1
		})

		ReflectionHelp = var_15_21

		local var_15_24 = var_15_21.RefCallStaticMethod

		typeof = var_15_22

		local var_15_25 = var_15_22("UnityEngine.Graphics")
		local var_15_26 = "Blit"

		var_1_10013 = {}
		typeof = var_1_10014
		var_1_10013[1] = var_1_10014("UnityEngine.RenderTexture")
		typeof = var_1_10014
		var_1_10013[2] = var_1_10014("UnityEngine.RenderTexture")
		typeof = var_1_10014
		var_1_10013[3] = var_1_10014("UnityEngine.Material")
		typeof = var_1_10014
		var_1_10013[4] = var_1_10014("System.Int32")

		var_15_24(var_15_25, var_15_26, var_1_10013, {
			var_15_11,
			var_15_5,
			var_15_13,
			2
		})
	end

	ReflectionHelp = var_5

	local var_15_27 = var_5.RefCallStaticMethod

	typeof = var_7

	local var_15_28 = var_7("UnityEngine.RenderTexture")
	local var_15_29 = "ReleaseTemporary"
	local var_15_30 = {}

	typeof = var_10
	var_15_30[1] = var_10("UnityEngine.RenderTexture")

	var_15_27(var_15_28, var_15_29, var_15_30, {
		var_15_11
	})

	return var_15_5
end

function var_0_1.SetSpineUIOutline(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetShader(var_16_0, "M02/Unlit Colored_Alpha_UI_Outline")

	GetComponent = var_1_10004

	local var_16_2 = var_1_10004(arg_16_1, "SkeletonGraphic")

	Material = var_16_0

	local var_16_3 = var_16_0.New(var_16_1)

	var_5.SetColor(var_16_3, "_OutlineColor", arg_16_2)
	var_5:SetFloat("_OutlineWidth", 5.75)
	var_5:SetFloat("_ThresholdEnd", 0.2)

	var_16_2.material = var_5

	return
end

function var_0_1.DelSpineUIOutline(arg_17_0, arg_17_1)
	GetComponent = var_1_10002
	var_1_10002(arg_17_1, "SkeletonGraphic").material = nil

	return
end

return

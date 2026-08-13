class = var_0_10000

local var_0_0 = "WSAtlas"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	tfCamera = "userdata",
	atlas = "table",
	staticEntranceDic = "table",
	transform = "userdata",
	onClickColor = "function",
	tfMapSelect = "userdata",
	defaultSprite = "userdata",
	tfEntity = "userdata",
	cmPointer = "userdata",
	addSprite = "userdata",
	tfSpriteScene = "userdata",
	tfMapScene = "userdata",
	tfActiveMark = "userdata",
	selectEntrance = "table"
}
var_0_1.Listeners = {
	onUpdatePressingAward = "OnUpdatePressingAward",
	onUpdateActiveEntrance = "OnUpdateActiveEntrance",
	onUpdateProgress = "OnUpdateProgress"
}
Vector2 = var_1
var_0_1.spriteBaseSize = var_1(2048, 1347)

function var_0_1.Setup(arg_1_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:RemoveAtlasListener()
	arg_2_0:UpdateStaticMark()
	arg_2_0:ActiveSelect(arg_2_0.selectEntrance, false)

	if arg_2_0.tfActiveMark then
		arg_2_0:DestroyActiveMark()
	end

	eachChild = var_1

	local var_2_0 = arg_2_0.tfMapScene

	var_1(var_3.Find(var_2_0, "lock_layer"), function(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.RemoveExtraMarkPrefab(var_3_0, arg_3_0)

		return
	end)
	arg_2_0:ReturnScene()
	arg_2_0:Clear()

	return
end

function var_0_1.Init(arg_4_0)
	arg_4_0.staticEntranceDic = {}

	return
end

function var_0_1.UpdateAtlas(arg_5_0, arg_5_1)
	if arg_5_0.atlas ~= arg_5_1 then
		arg_5_0:RemoveAtlasListener()

		arg_5_0.atlas = arg_5_1

		arg_5_0:AddAtlasListener()
		arg_5_0:UpdateModelMask()

		local var_5_0 = arg_5_0
		local var_5_1 = arg_5_0.OnUpdateActiveEntrance
		local var_5_2
		local var_5_3
		local var_5_4 = arg_5_0.atlas

		var_5_1(var_5_0, var_5_2, var_5_3, var_7.GetActiveEntrance(var_5_4))
		arg_5_0:OnUpdatePressingAward()
	end

	return
end

function var_0_1.AddAtlasListener(arg_6_0)
	if arg_6_0.atlas then
		local var_6_0 = arg_6_0.atlas
		local var_6_1 = var_1.AddListener

		WorldAtlas = var_1_10004

		var_6_1(var_6_0, var_1_10004.EventUpdateProgress, arg_6_0.onUpdateProgress)

		local var_6_2 = arg_6_0.atlas
		local var_6_3 = var_1.AddListener

		WorldAtlas = var_4

		var_6_3(var_6_2, var_4.EventUpdateActiveEntrance, arg_6_0.onUpdateActiveEntrance)

		local var_6_4 = arg_6_0.atlas
		local var_6_5 = var_1.AddListener

		WorldAtlas = var_4

		var_6_5(var_6_4, var_4.EventAddPressingEntrance, arg_6_0.onUpdatePressingAward)
	end

	return
end

function var_0_1.RemoveAtlasListener(arg_7_0)
	if arg_7_0.atlas then
		local var_7_0 = arg_7_0.atlas
		local var_7_1 = var_1.RemoveListener

		WorldAtlas = var_1_10004

		var_7_1(var_7_0, var_1_10004.EventUpdateProgress, arg_7_0.onUpdateProgress)

		local var_7_2 = arg_7_0.atlas
		local var_7_3 = var_1.RemoveListener

		WorldAtlas = var_4

		var_7_3(var_7_2, var_4.EventUpdateActiveEntrance, arg_7_0.onUpdateActiveEntrance)

		local var_7_4 = arg_7_0.atlas
		local var_7_5 = var_1.RemoveListener

		WorldAtlas = var_4

		var_7_5(var_7_4, var_4.EventAddPressingEntrance, arg_7_0.onUpdatePressingAward)
	end

	return
end

function var_0_1.LoadScene(arg_8_0, arg_8_1)
	assert = var_1_10002

	var_1_10002(false, "overwrite by subclass")

	return
end

function var_0_1.ReturnScene(arg_9_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite by subclass")

	return
end

function var_0_1.ShowOrHide(arg_10_0, arg_10_1)
	setActive = var_1_10002

	var_1_10002(arg_10_0.transform, arg_10_1)

	return
end

function var_0_1.GetMapScreenPos(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.cmPointer

	return var_2.GetMapScreenPos(var_11_0, arg_11_1)
end

function var_0_1.UpdateSelect(arg_12_0, arg_12_1)
	arg_12_0:ActiveSelect(arg_12_0.selectEntrance, false)
	arg_12_0:ActiveSelect(arg_12_1, true)

	return
end

function var_0_1.ActiveSelect(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.selectEntrance = arg_13_2 and arg_13_1 or nil

	if not arg_13_1 or arg_13_0.staticEntranceDic[arg_13_1.id] then
		return
	end

	if arg_13_1:HasPort() then
		-- block empty
	else
		setActive = var_3

		local var_13_0 = arg_13_0.tfMapSelect

		var_3(var_5.Find(var_13_0, "A" .. arg_13_1:GetColormaskUniqueID() .. "_2"), arg_13_2)
	end

	return
end

function var_0_1.ActiveStatic(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.staticEntranceDic[arg_14_1.id] = arg_14_2

	if arg_14_1 == arg_14_0.selectEntrance then
		return
	end

	if arg_14_1:HasPort() then
		-- block empty
	else
		local var_14_0 = arg_14_0.tfMapSelect
		local var_14_1 = var_3.Find(var_14_0, "A" .. arg_14_1:GetColormaskUniqueID() .. "_2")

		LeanTween = var_4

		local var_14_2 = var_4.cancel

		go = var_6

		var_14_2(var_6(var_14_1))

		local var_14_3 = var_14_1:GetComponent("SpriteRenderer").color

		var_14_3.a = arg_14_2 and 0 or 1

		local var_14_4 = var_14_1:GetComponent("SpriteRenderer")

		var_14_4.color = var_14_3

		if arg_14_2 then
			setActive = var_14_4

			var_14_4(var_14_1, true)

			LeanTween = var_14_4
			var_14_4 = var_14_4.alpha
			go = var_7

			local var_14_5 = var_14_4(var_7(var_14_1), 0.75, 1)
			local var_14_6 = var_14_4.setFrom(var_14_5, 0)

			var_14_4.setLoopPingPong(var_14_6)
		else
			setActive = var_14_4

			var_14_4(var_14_1, arg_14_0.selectEntrance == arg_14_1)
		end
	end

	return
end

Color = var_1
var_0_1.pressingMaskColor = var_1.New(0.027450980392156862, 0.27450980392156865, 0.5490196078431373, 0.5019607843137255)
Color = var_1
var_0_1.openMaskColor = var_1.New(0, 0, 0, 0)
Color = var_1
var_0_1.lockMaskColor = var_1.New(0, 0, 0, 0.4)

function var_0_1.UpdateModelMask(arg_15_0)
	pairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.atlas.entranceDic) do
		arg_15_0:UpdateEntranceMask(iter_15_1)
	end

	return
end

function var_0_1.UpdateEntranceMask(arg_16_0, arg_16_1)
	if arg_16_1:HasPort() then
		-- block empty
	else
		local var_16_0 = arg_16_0.tfMapScene
		local var_16_1 = var_2.Find(var_16_0, "lock_layer/A" .. arg_16_1:GetColormaskUniqueID())
		local var_16_2 = var_2.GetComponent(var_16_1, "SpriteRenderer")

		if arg_16_1:IsPressing() then
			var_16_2.color = var_0_1.pressingMaskColor
			var_16_2.material = arg_16_0.addSprite
		elseif arg_16_0.atlas.transportDic[arg_16_1.id] and arg_16_1:IsOpen() then
			var_16_2.color = var_0_1.openMaskColor
			var_16_2.material = arg_16_0.defaultSprite
		else
			var_16_2.color = var_0_1.lockMaskColor
			var_16_2.material = arg_16_0.defaultSprite
		end
	end

	return
end

function var_0_1.SetSairenMarkActive(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:DoUpdatExtraMark(arg_17_1, "dsj_srgr", arg_17_2, function(arg_18_0)
		if arg_17_2 then
			local var_18_0 = arg_18_0:GetComponent("SpriteRenderer")
			local var_18_1 = arg_17_1

			var_18_0.sprite = var_2.GetComponent(var_18_1, "SpriteRenderer").sprite
		end

		return
	end)

	return
end

function var_0_1.OnUpdateProgress(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	pairs = var_1_10004

	for iter_19_0 in var_1_10004(arg_19_3) do
		local var_19_0 = arg_19_0.atlas
		local var_19_1 = var_8.GetEntrance(var_19_0, iter_19_0)

		arg_19_0:UpdateEntranceMask(var_19_1)
	end

	arg_19_0:UpdateCenterEffectDisplay()

	return
end

function var_0_1.BuildActiveMark(arg_20_0)
	tf = var_1_10001
	GameObject = var_1_10003
	arg_20_0.tfActiveMark = var_1_10001(var_1_10003.New())

	local var_20_0 = arg_20_0.tfActiveMark.gameObject

	Layer = var_1_10002
	var_20_0.layer = var_1_10002.UI
	arg_20_0.tfActiveMark.name = "active_mark"

	local var_20_1 = arg_20_0.tfActiveMark

	var_1.SetParent(var_20_1, arg_20_0.tfSpriteScene, false)

	setActive = var_1

	var_1(arg_20_0.tfActiveMark, false)

	return
end

function var_0_1.DestroyActiveMark(arg_21_0)
	arg_21_0:RemoveExtraMarkPrefab(arg_21_0.tfActiveMark)

	Destroy = var_1

	var_1(arg_21_0.tfActiveMark)

	return
end

function var_0_1.LoadExtraMarkPrefab(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	PoolMgr = var_1_10004

	local var_22_0 = var_1_10004.GetInstance()

	var_4.GetPrefab(var_22_0, "world/mark/" .. arg_22_2, arg_22_2, true, function(arg_23_0)
		IsNil = var_2_10001

		if var_2_10001(arg_22_1) then
			local var_23_0 = var_0

			var_1.ReturnPrefab(var_23_0, "world/mark/" .. arg_22_2, arg_22_2, arg_23_0, true)
		else
			arg_23_0.name = arg_22_2
			tf = var_1

			local var_23_1 = var_1(arg_23_0)

			var_1.SetParent(var_23_1, arg_22_1, false)

			setActive = var_1

			var_1(arg_23_0, true)

			existCall = var_1

			local var_23_2 = arg_22_3

			tf = var_4

			var_1(var_23_2, var_4(arg_23_0))
		end

		return
	end)

	return
end

function var_0_1.RemoveExtraMarkPrefab(arg_24_0, arg_24_1)
	PoolMgr = var_1_10002

	local var_24_0 = var_1_10002.GetInstance()

	eachChild = var_1_10003

	var_1_10003(arg_24_1, function(arg_25_0)
		local var_25_0 = var_24_0
		local var_25_1 = var_1.ReturnPrefab
		local var_25_2 = "world/mark/" .. arg_25_0.name
		local var_25_3 = arg_25_0.name

		go = var_2_10006

		var_25_1(var_25_0, var_25_2, var_25_3, var_2_10006(arg_25_0), true)

		return
	end)

	return
end

function var_0_1.DoUpdatExtraMark(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_1:Find(arg_26_2) then
		setActive = var_1_10006

		var_1_10006(var_5, arg_26_3)

		existCall = var_1_10006

		var_1_10006(arg_26_4, var_5)
	elseif arg_26_3 then
		arg_26_0:LoadExtraMarkPrefab(arg_26_1, arg_26_2, arg_26_4)
	end

	return
end

function var_0_1.OnUpdateActiveEntrance(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_3 then
		var_1_10004 = arg_27_0.tfActiveMark
		WorldConst = var_1_10005
		var_1_10004.localPosition = var_1_10005.CalcModelPosition(arg_27_3, arg_27_0.spriteBaseSize)
	end

	setActive = var_1_10004

	var_1_10004(arg_27_0.tfActiveMark, arg_27_3)

	return
end

function var_0_1.UpdateStaticMark(arg_28_0, arg_28_1)
	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.staticEntranceDic) do
		local var_28_0 = arg_28_0
		local var_28_1 = arg_28_0.ActiveStatic
		local var_28_2 = arg_28_0.atlas

		var_28_1(var_28_0, var_10.GetEntrance(var_28_2, iter_28_0), false)
	end

	pairs = var_2

	for iter_28_2, iter_28_3 in var_2(arg_28_1 or {}) do
		if iter_28_3 then
			local var_28_3 = arg_28_0
			local var_28_4 = arg_28_0.ActiveStatic
			local var_28_5 = arg_28_0.atlas

			var_28_4(var_28_3, var_10.GetEntrance(var_28_5, iter_28_2), true)
		end
	end

	return
end

function var_0_1.OnUpdatePressingAward(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_3 = arg_29_3 or arg_29_0.atlas.transportDic
	pairs = var_1_10004

	for iter_29_0, iter_29_1 in var_1_10004(arg_29_3) do
		if iter_29_1 then
			local var_29_0 = arg_29_0
			local var_29_1 = arg_29_0.UpdateEntranceMask
			local var_29_2 = arg_29_0.atlas

			var_29_1(var_29_0, var_12.GetEntrance(var_29_2, iter_29_0))
		end
	end

	return
end

function var_0_1.UpdateCenterEffectDisplay(arg_30_0)
	nowWorld = var_1_10001

	local var_30_0 = var_1_10001()
	local var_30_1 = var_1.CheckAreaUnlock(var_30_0, 5)

	setActive = var_1_10002

	local var_30_2 = arg_30_0.tfEntity

	var_1_10002(var_4.Find(var_30_2, "decolation_layer/DSJ_xuanwo"), not var_30_1)

	setActive = var_1_10002

	local var_30_3 = arg_30_0.tfEntity

	var_1_10002(var_4.Find(var_30_3, "decolation_layer/DSJ_xuanwo_jianhua"), var_30_1)

	return
end

return var_0_1

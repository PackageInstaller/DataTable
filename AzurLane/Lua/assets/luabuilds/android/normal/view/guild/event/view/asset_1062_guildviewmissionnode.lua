class = var_0_10000

local var_0_0 = var_0_10000("GuildViewMissionNode")
local var_0_1 = 200
local var_0_2 = 150
local var_0_3 = 100

var_0_0.LINE_LEFT = 1
var_0_0.LINE_RIGHT = 2
var_0_0.TOP_LINK = 3
var_0_0.BOTTOM_LINK = 4
var_0_0.CENTER_LINK = 5
var_0_0.TOP_HRZ_LINK = 6
var_0_0.BOTTOM_HRZ_LINK = 7

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1.go
	tf = var_2
	arg_1_0._tf = var_2(arg_1_0._go)
	arg_1_0.slot = arg_1_1.slot
	arg_1_0.data = arg_1_1.data
	arg_1_0.parent = arg_1_1.parent
	arg_1_0.childs = {}
	arg_1_0.offset = 0

	local var_1_0 = arg_1_0._tf

	arg_1_0.lineContainer = var_2.Find(var_1_0, "lines")
	arg_1_0.lines = {}

	local var_1_1 = arg_1_0._tf

	arg_1_0.subLockBg = var_2.Find(var_1_1, "sub_lock")

	local var_1_2 = arg_1_0._tf

	arg_1_0.subUnlockBg = var_2.Find(var_1_2, "sub_unlock")

	local var_1_3 = arg_1_0._tf

	arg_1_0.unlockBg = var_2.Find(var_1_3, "unlock")

	local var_1_4 = arg_1_0._tf

	arg_1_0.lockBg = var_2.Find(var_1_4, "lock")

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_2.Find(var_1_5, "Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_7(var_1_6, var_4(var_1_10005))

	local var_1_8 = arg_1_0._tf

	arg_1_0.selected = var_2.Find(var_1_8, "selected")

	local var_1_9 = arg_1_0._tf

	arg_1_0.tip = var_2.Find(var_1_9, "tip")

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0:UpdateStyle()
	arg_2_0:CalcOffset()
	arg_2_0:SetPosition()

	return
end

function var_0_0.IsFinish(arg_3_0)
	local var_3_0 = arg_3_0.data

	return var_1.IsFinish(var_3_0)
end

function var_0_0.IsUnLock(arg_4_0)
	if not arg_4_0.parent then
		return true
	else
		local var_4_0

		if arg_4_0:ParentIFinish() then
			var_4_0 = arg_4_0:IsActive()
		end

		return var_4_0
	end

	return
end

function var_0_0.ParentIFinish(arg_5_0)
	if not arg_5_0.parent then
		return false
	end

	local var_5_0 = arg_5_0.parent

	return var_1.IsFinish(var_5_0)
end

function var_0_0.ParentIsFinishByServer(arg_6_0)
	if not arg_6_0.parent then
		return false
	end

	local var_6_0 = arg_6_0.parent.data

	return var_1.IsFinishedByServer(var_6_0)
end

function var_0_0.IsActive(arg_7_0)
	local var_7_0 = arg_7_0.data

	return var_1.IsActive(var_7_0)
end

function var_0_0.GetParentId(arg_8_0)
	if not arg_8_0.parent then
		return 0
	end

	return arg_8_0.parent.data.id
end

function var_0_0.UpdateData(arg_9_0, arg_9_1)
	arg_9_0.data = arg_9_1

	arg_9_0:UpdateStyle()
	arg_9_0:UpdateLineStyle()

	ipairs = var_2

	for iter_9_0, iter_9_1 in var_2(arg_9_0.childs) do
		iter_9_1:UpdateStyle()
		iter_9_1:UpdateLineStyle()
	end

	return
end

function var_0_0.UpdateStyle(arg_10_0)
	local var_10_0 = arg_10_0:IsFinish()
	local var_10_1 = not arg_10_0:IsUnLock()
	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.IsMain(var_10_2)

	setActive = var_10_2

	var_10_2(arg_10_0.subLockBg, not var_10_0 and not var_10_3 and var_10_1)

	setActive = var_10_2

	var_10_2(arg_10_0.subUnlockBg, not var_10_0 and not var_10_3 and not var_10_1)

	setActive = var_10_2

	var_10_2(arg_10_0.unlockBg, not var_10_0 and var_10_3 and not var_10_1)

	setActive = var_10_2

	var_10_2(arg_10_0.lockBg, not var_10_0 and var_10_3 and var_10_1)

	local var_10_4 = arg_10_0.nameTxt
	local var_10_5

	if var_10_1 then
		var_10_5 = ""
	else
		local var_10_6 = arg_10_0.data

		var_10_5 = var_5.GetName(var_10_6)
	end

	var_10_4.text = var_10_5

	arg_10_0:UpdateTip()

	return
end

function var_0_0.UpdateTip(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1

	if arg_11_0.IsUnLock(var_11_0) then
		var_11_0 = arg_11_0.data

		if var_1.CanFormation(var_11_0) then
			var_11_0 = arg_11_0
			var_11_1 = not arg_11_0.IsFinish(var_11_0)
		end
	end

	setActive = var_11_0

	var_11_0(arg_11_0.tip, var_11_1)

	return
end

local var_0_4 = {
	"blue",
	"gray",
	"yellow"
}

function var_0_0.UpdateLineStyle(arg_12_0)
	local var_12_0

	local function var_12_1(arg_13_0, arg_13_1)
		if arg_13_0.gameObject.name == "line" then
			local var_13_0 = arg_13_0
			local var_13_1 = arg_13_0.GetComponent

			typeof = var_2_10004
			Image = var_2_10005

			local var_13_2 = var_13_1(var_13_0, var_2_10004(var_2_10005))

			GetSpriteFromAtlas = var_13_0
			var_13_2.sprite = var_13_0("ui/guildmissionui_atlas", arg_13_1 .. "_line")
		elseif arg_13_0.gameObject.name == "head" then
			local var_13_3 = arg_13_0
			local var_13_4 = arg_13_0.GetComponent

			typeof = var_2_10004
			Image = var_2_10005

			local var_13_5 = var_13_4(var_13_3, var_2_10004(var_2_10005))

			GetSpriteFromAtlas = var_13_3
			var_13_5.sprite = var_13_3("ui/guildmissionui_atlas", arg_13_1)
		elseif arg_13_0.gameObject.name == "adapter" then
			eachChild = var_2

			var_2(arg_13_0, function(arg_14_0)
				var_12_1(arg_14_0, arg_13_1)

				return
			end)
		end

		return
	end

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.IsFinish(var_12_2)

	ipairs = var_12_2

	for iter_12_0, iter_12_1 in var_12_2(arg_12_0.childs) do
		local var_12_4 = arg_12_0.lines[iter_12_1]
		local var_12_5 = iter_12_1
		local var_12_6 = iter_12_1.IsMain(var_12_5)

		ipairs = var_12_5

		for iter_12_2, iter_12_3 in var_12_5(var_12_4) do
			local var_12_7

			if (not var_12_3 or not var_0_4[2]) and (not var_12_6 or not var_0_4[3]) then
				var_12_7 = var_0_4[1]
			end

			var_12_1(iter_12_3.tf, var_12_7)
		end
	end

	local var_12_8

	if not arg_12_0.lines[arg_12_0] then
		var_12_8 = {}
	end

	local var_12_9 = arg_12_0:IsMain()
	local var_12_10 = true

	if arg_12_0.parent then
		local var_12_11 = arg_12_0.parent

		var_12_10 = var_6.IsFinish(var_12_11)
	end

	ipairs = var_6

	for iter_12_4, iter_12_5 in var_6(var_12_8) do
		local var_12_12

		if iter_12_5.type == var_0_0.LINE_LEFT then
			var_12_12 = (var_12_3 or var_12_10) and var_0_4[2] or var_12_9 and var_0_4[3] or var_0_4[1]
		else
			var_12_12 = var_12_3 and var_0_4[2] or var_12_9 and var_0_4[3] or var_0_4[1]
		end

		var_12_1(iter_12_5.tf, var_12_12)
	end

	return
end

function var_0_0.Selected(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.selected, arg_15_1)

	return
end

function var_0_0.CalcOffset(arg_16_0)
	if not arg_16_0.parent then
		arg_16_0.offset = 0

		return
	end

	if #arg_16_0.parent.childs == 2 then
		local var_16_0 = arg_16_0:IsMain()
		local var_16_1 = arg_16_0:GetParentOffset()
		local var_16_2 = 1
		local var_16_3 = -1

		math = var_1_10005

		local var_16_4 = var_1_10005.abs(var_16_1 + var_16_2)

		math = var_6

		if var_6.abs(var_16_1 + var_16_3) <= var_16_4 then
			arg_16_0.offset = var_16_0 and var_16_3 or var_16_2
		elseif var_16_4 < var_6 then
			arg_16_0.offset = var_16_0 and var_16_2 or var_16_3
		end
	elseif #arg_16_0.parent.childs == 1 then
		local var_16_5 = arg_16_0.parent

		arg_16_0.offset = 0 - var_1.GetFirstNodeOffset(var_16_5)
	end

	return
end

function var_0_0.GetLocalPosition(arg_17_0)
	local var_17_0

	if arg_17_0.parent then
		var_17_0 = arg_17_0:GetOffset()

		local var_17_1 = (arg_17_0.slot - 1) * (var_0_1 + arg_17_0._tf.sizeDelta.x)
		local var_17_2 = arg_17_0.parent
		local var_17_3 = var_3.GetLocalPosition(var_17_2)
		local var_17_4 = arg_17_0:IsMain() and 0 or var_0_3
		local var_17_5 = var_17_3.y + var_17_0 * var_0_2 + (var_17_0 > 0 and var_17_4 or -var_17_4)

		Vector3 = var_6

		return var_6(var_17_1, var_17_5, 0)
	else
		Vector3 = var_17_0

		return var_17_0(0, 0, 0)
	end

	return
end

function var_0_0.SetPosition(arg_18_0)
	local var_18_0 = arg_18_0:GetLocalPosition()

	arg_18_0._tf.anchoredPosition = var_18_0

	return
end

function var_0_0.AddChild(arg_19_0, arg_19_1)
	table = var_1_10002

	var_1_10002.insert(arg_19_0.childs, arg_19_1)

	return
end

function var_0_0.GetChilds(arg_20_0)
	return arg_20_0.childs
end

function var_0_0.HasParent(arg_21_0)
	return arg_21_0.parent ~= nil
end

function var_0_0.HasChild(arg_22_0)
	return #arg_22_0.childs > 0
end

function var_0_0.IsMain(arg_23_0)
	local var_23_0 = arg_23_0.data

	return var_1.IsMain(var_23_0)
end

function var_0_0.GetOffset(arg_24_0)
	return arg_24_0.offset
end

function var_0_0.GetParentOffset(arg_25_0)
	assert = var_1_10001

	var_1_10001(arg_25_0.parent)

	local var_25_0 = arg_25_0.parent

	return var_1.GetOffset(var_25_0)
end

function var_0_0.GetFirstNodeOffset(arg_26_0)
	local var_26_0 = 0
	local var_26_1 = arg_26_0

	while var_26_1.parent ~= nil do
		var_26_0 = var_26_0 + var_26_1:GetOffset()
		var_26_1 = var_26_1.parent
	end

	return var_26_0
end

function var_0_0.AddLine(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	tf = var_1_10004
	arg_27_1 = var_1_10004(arg_27_1)
	SetParent = var_4

	var_4(arg_27_1, arg_27_0.lineContainer)

	if arg_27_2 == var_0_0.LINE_LEFT then
		if arg_27_0:IsMain() then
			Vector2 = var_4
			arg_27_1.anchorMax = var_4(0, 0.5)
			Vector2 = var_4
			arg_27_1.anchorMin = var_4(0, 0.5)
			Vector2 = var_4
			arg_27_1.pivot = var_4(1, 0.5)
			Vector2 = var_4
			arg_27_1.anchoredPosition = var_4(0, 0)
		else
			Vector2 = var_4
			arg_27_1.pivot = var_4(1, 0.5)

			if arg_27_0:GetOffset() > 0 then
				Vector2 = var_4
				arg_27_1.anchorMax = var_4(0.5, 0)
				Vector2 = var_4
				arg_27_1.anchorMin = var_4(0.5, 0)
				Vector3 = var_4
				arg_27_1.eulerAngles = var_4(0, 0, 90)
				Vector2 = var_4
				arg_27_1.anchoredPosition = var_4(0, 0)
			else
				Vector2 = var_4
				arg_27_1.anchorMax = var_4(0.5, 1)
				Vector2 = var_4
				arg_27_1.anchorMin = var_4(0.5, 1)
				Vector3 = var_4
				arg_27_1.eulerAngles = var_4(0, 0, -90)
				Vector2 = var_4
				arg_27_1.anchoredPosition = var_4(0, 0)
			end
		end
	elseif arg_27_2 == var_0_0.LINE_RIGHT then
		Vector2 = var_4
		arg_27_1.anchorMax = var_4(1, 0.5)
		Vector2 = var_4
		arg_27_1.anchorMin = var_4(1, 0.5)
		Vector2 = var_4
		arg_27_1.pivot = var_4(0, 0.5)
		Vector2 = var_4
		arg_27_1.anchoredPosition = var_4(0, 0)
	elseif arg_27_2 == var_0_0.TOP_LINK then
		Vector2 = var_4
		arg_27_1.anchorMax = var_4(1, 0.5)
		Vector2 = var_4
		arg_27_1.anchorMin = var_4(1, 0.5)
		Vector2 = var_4
		arg_27_1.pivot = var_4(1, 0.5)

		local var_27_0 = arg_27_0.lines[arg_27_0][1].tf.sizeDelta.x

		Vector2 = var_6
		arg_27_1.anchoredPosition = var_6(var_27_0, 0)
		Vector3 = var_6
		arg_27_1.eulerAngles = var_6(0, 0, -90)

		local var_27_1 = arg_27_3:GetLocalPosition().y - arg_27_0:GetLocalPosition().y

		if arg_27_3:IsMain() then
			Vector2 = var_7
			arg_27_1.sizeDelta = var_7(var_27_1, arg_27_1.sizeDelta.y)
		else
			Vector2 = var_7
			arg_27_1.sizeDelta = var_7(var_27_1 - var_27_0 - arg_27_0._tf.sizeDelta.y / 2, arg_27_1.sizeDelta.y)
		end
	elseif arg_27_2 == var_0_0.BOTTOM_LINK then
		Vector2 = var_4
		arg_27_1.anchorMax = var_4(1, 0.5)
		Vector2 = var_4
		arg_27_1.anchorMin = var_4(1, 0.5)
		Vector2 = var_4
		arg_27_1.pivot = var_4(1, 0.5)

		local var_27_2 = arg_27_0.lines[arg_27_0][1].tf.sizeDelta.x

		Vector2 = var_6
		arg_27_1.anchoredPosition = var_6(var_27_2, 0)
		Vector3 = var_6
		arg_27_1.eulerAngles = var_6(0, 0, 90)

		local var_27_3 = arg_27_3:GetLocalPosition().y - arg_27_0:GetLocalPosition().y

		if arg_27_3:IsMain() then
			Vector2 = var_7
			arg_27_1.sizeDelta = var_7(-var_27_3, arg_27_1.sizeDelta.y)
		else
			Vector2 = var_7
			arg_27_1.sizeDelta = var_7(-var_27_3 - var_27_2 - arg_27_0._tf.sizeDelta.y / 2, arg_27_1.sizeDelta.y)
		end
	elseif arg_27_2 == var_0_0.TOP_HRZ_LINK then
		local var_27_4 = arg_27_0.lines[arg_27_3][1].tf
		local var_27_5 = arg_27_0.lines[arg_27_0][1].tf.sizeDelta.x
		local var_27_6 = var_27_4.sizeDelta.x + var_27_4.anchoredPosition.y

		Vector2 = var_8
		arg_27_1.anchoredPosition = var_8(var_27_4.anchoredPosition.x, var_27_6)

		local var_27_7 = arg_27_3:GetLocalPosition()
		local var_27_8 = arg_27_0:GetLocalPosition()
		local var_27_9
		local var_27_10

		if arg_27_3:IsMain() then
			var_27_9 = var_27_7.x - var_27_8.x - 2 * var_27_5 - arg_27_0._tf.sizeDelta.x
		else
			var_27_10 = var_27_7.x + arg_27_0._tf.sizeDelta.x / 2
			nextNodeLposX = nextNodeLposX
			var_27_9 = var_27_10 - var_27_8.x - arg_27_0._tf.sizeDelta.x - var_27_5
		end

		Vector2 = var_27_10
		arg_27_1.sizeDelta = var_27_10(var_27_9, arg_27_1.sizeDelta.y)
	elseif arg_27_2 == var_0_0.BOTTOM_HRZ_LINK then
		local var_27_11 = arg_27_0.lines[arg_27_3][1].tf
		local var_27_12 = arg_27_0.lines[arg_27_0][1].tf.sizeDelta.x
		local var_27_13 = var_27_11.anchoredPosition.y - var_27_11.sizeDelta.x

		Vector2 = var_8
		arg_27_1.anchoredPosition = var_8(var_27_11.anchoredPosition.x, var_27_13)

		local var_27_14 = arg_27_3:GetLocalPosition()
		local var_27_15 = arg_27_0:GetLocalPosition()
		local var_27_16
		local var_27_17

		if arg_27_3:IsMain() then
			var_27_16 = var_27_14.x - var_27_15.x - 2 * var_27_12 - arg_27_0._tf.sizeDelta.x
		else
			var_27_17 = var_27_14.x + arg_27_0._tf.sizeDelta.x / 2
			nextNodeLposX = nextNodeLposX
			var_27_16 = var_27_17 - var_27_15.x - arg_27_0._tf.sizeDelta.x - var_27_12
		end

		Vector2 = var_27_17
		arg_27_1.sizeDelta = var_27_17(var_27_16, arg_27_1.sizeDelta.y)
	elseif arg_27_2 == var_0_0.CENTER_LINK then
		local var_27_18 = arg_27_3:GetLocalPosition()
		local var_27_19 = arg_27_0:GetLocalPosition()
		local var_27_20 = arg_27_0.lines[arg_27_0][1].tf.sizeDelta.x
		local var_27_21 = var_27_18.x - var_27_19.x - arg_27_0._tf.sizeDelta.x - 2 * var_27_20

		Vector2 = var_9
		arg_27_1.anchorMax = var_9(1, 0.5)
		Vector2 = var_9
		arg_27_1.anchorMin = var_9(1, 0.5)
		Vector2 = var_9
		arg_27_1.anchoredPosition = var_9(var_27_20, 0)
		Vector2 = var_9
		arg_27_1.sizeDelta = var_9(var_27_21, arg_27_1.sizeDelta.y)
	end

	local var_27_22

	if not arg_27_0.lines[arg_27_3] then
		var_27_22 = arg_27_0.lines
		var_27_22[arg_27_3] = {}
	end

	table = var_27_22

	var_27_22.insert(arg_27_0.lines[arg_27_3], {
		tf = arg_27_1,
		type = arg_27_2
	})

	return
end

return var_0_0

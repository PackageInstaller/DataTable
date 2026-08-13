class = var_0_10000

local var_0_0 = "IdolMasterView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = "backyard"
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_4 = "event:/ui/sou"
local var_0_5 = "event:/ui/xueqiu"
local var_0_6 = 60
local var_0_7 = 100
local var_0_8 = 10
local var_0_9 = {
	{
		20,
		3
	},
	{
		40,
		4
	},
	{
		60,
		5
	},
	{
		10000,
		5
	}
}
local var_0_10 = {
	{
		10700031,
		10700030
	},
	{
		10700041,
		10700040
	},
	{
		10700051,
		10700050
	},
	{
		10700061,
		10700060
	},
	{
		10700071,
		10700070
	}
}
local var_0_11 = {
	{
		10700011,
		10700010
	},
	{
		10700021,
		10700020
	}
}
local var_0_12 = "EVENT_SEND_GIFT"
local var_0_13 = "EVENT_FANS_ACTION"
local var_0_14 = {
	1,
	2,
	3,
	4,
	5,
	6
}
local var_0_15 = {
	1,
	2
}
local var_0_16 = {
	3,
	4,
	5,
	6
}
local var_0_17 = 3
local var_0_18 = "dafuweng_event"
local var_0_19 = "stand2"
local var_0_20 = "normal"
local var_0_21 = "work"
local var_0_22 = "wrong"
local var_0_23 = "end1"
local var_0_24 = "end2"
local var_0_25 = "gift"
local var_0_26 = "normal"
local var_0_27 = "walk"
local var_0_28 = 3
local var_0_29 = "type_fans_fail"
local var_0_30 = "type_fans_success"
local var_0_31 = 4
local var_0_32 = {}

Vector3 = var_0_10032
var_0_32[1] = var_0_10032(160, 160)
Vector3 = var_32
var_0_32[2] = var_32(160, -30)
Vector3 = var_32
var_0_32[3] = var_32(160, -210)
Vector3 = var_32
var_0_32[4] = var_32(160, -400)

local var_0_33 = 350

local function var_0_34(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		Ctor = function(arg_2_0)
			arg_2_0._giftTf = arg_1_0
			arg_2_0._event = arg_1_2
			arg_2_0._workerTf = arg_1_1

			local var_2_0 = "jiu-work"

			PoolMgr = var_2_10002

			local var_2_1 = var_2_10002.GetInstance()

			var_2.GetSpineChar(var_2_1, var_2_0, true, function(arg_3_0)
				local var_3_0 = arg_3_0.transform

				Vector3 = var_3_10002
				var_3_0.localScale = var_3_10002.one

				local var_3_1 = arg_3_0.transform

				Vector3 = var_2
				var_3_1.localPosition = var_2.zero

				local var_3_2 = arg_3_0.transform

				var_1.SetParent(var_3_2, arg_2_0._workerTf, false)

				local var_3_3 = arg_3_0
				local var_3_4 = arg_3_0.GetComponent

				typeof = var_4
				SpineAnimUI = var_3_10006

				local var_3_5 = var_3_4(var_3_3, var_4(var_3_10006))

				arg_2_0.wokerSpine = {
					model = arg_2_0.model,
					anim = var_3_5,
					name = var_2_0
				}

				local var_3_6 = arg_2_0

				var_2.changeWorkerAction(var_3_6, var_0_20, 0, nil)

				return
			end)

			arg_2_0.selectedGifts = {}
			arg_2_0.gifts = {}
			arg_2_0.delegateGifts = {}

			for iter_2_0 = 1, #var_0_14 do
				local var_2_2 = iter_2_0

				findTF = var_2_3

				local var_2_3 = var_2_3(arg_2_0._giftTf, var_0_14[iter_2_0])

				table = var_2_10008

				var_2_10008.insert(arg_2_0.gifts, {
					tf = var_2_3,
					index = iter_2_0
				})

				GetOrAddComponent = var_2_10008

				local var_2_4 = var_2_10008(var_2_3, "EventTriggerListener")

				var_2_10008.AddPointDownFunc(var_2_4, function(arg_4_0, arg_4_1)
					local var_4_0 = arg_2_0

					var_2.selectGift(var_4_0, var_2_2)

					return
				end)

				table = var_9

				var_9.insert(arg_2_0.delegateGifts, var_2_10008)
			end

			arg_2_0:updateSelected()

			return
		end,
		changeWorkerAction = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
			local var_5_0 = arg_5_0.wokerSpine.anim

			var_4.SetActionCallBack(var_5_0, nil)

			local var_5_1 = arg_5_0.wokerSpine.anim

			var_4.SetAction(var_5_1, arg_5_1, 0)

			local var_5_2 = arg_5_0.wokerSpine.anim

			var_4.SetActionCallBack(var_5_2, function(arg_6_0)
				if arg_6_0 == "finish" then
					if arg_5_2 == 1 then
						local var_6_0 = arg_5_0.wokerSpine.anim

						var_1.SetActionCallBack(var_6_0, nil)

						local var_6_1 = arg_5_0.wokerSpine.anim

						var_1.SetAction(var_6_1, var_0_20, 0)
					end

					if arg_5_3 then
						arg_5_3()
					end
				end

				return
			end)

			if arg_5_2 ~= 1 and arg_5_3 then
				arg_5_3()
			end

			return
		end,
		selectGift = function(arg_7_0, arg_7_1)
			table = var_2_10002

			if var_2_10002.contains(var_0_15, arg_7_1) then
				for iter_7_0 = #arg_7_0.selectedGifts, 1, -1 do
					local var_7_0 = arg_7_0.selectedGifts[iter_7_0]

					table = var_2_10007

					if var_2_10007.contains(var_0_15, var_7_0) and var_7_0 ~= arg_7_1 then
						table = var_2_10007

						var_2_10007.remove(arg_7_0.selectedGifts, iter_7_0)
					end
				end
			elseif #arg_7_0.selectedGifts == 2 then
				table = var_2

				if not var_2.contains(arg_7_0.selectedGifts, arg_7_1) then
					local var_7_1 = false

					for iter_7_1 = 1, #arg_7_0.selectedGifts do
						table = var_2_10007

						if var_2_10007.contains(var_0_15, arg_7_0.selectedGifts[iter_7_1]) then
							var_7_1 = true

							break
						end
					end

					if not var_7_1 then
						table = var_3

						var_3.remove(arg_7_0.selectedGifts, 1)
					end
				end
			end

			local var_7_2 = 0

			for iter_7_2 = 1, #arg_7_0.selectedGifts do
				if arg_7_0.selectedGifts[iter_7_2] == arg_7_1 then
					var_7_2 = iter_7_2
				end
			end

			if var_7_2 == 0 then
				table = var_3

				var_3.insert(arg_7_0.selectedGifts, arg_7_1)
				arg_7_0:moveJiujiu(arg_7_1)
				arg_7_0:changeWorkerAction(var_0_21, 1)
			else
				table = var_3

				var_3.remove(arg_7_0.selectedGifts, var_7_2)
			end

			if #arg_7_0.selectedGifts >= var_0_17 then
				local var_7_3 = arg_7_0._event
				local var_7_4 = var_3.emit
				local var_7_5 = var_0_12

				Clone = var_2_10007

				var_7_4(var_7_3, var_7_5, var_2_10007(arg_7_0.selectedGifts), function(arg_8_0)
					if not arg_8_0 then
						local var_8_0 = arg_7_0

						var_1.changeWorkerAction(var_8_0, var_0_22, 1)
					end

					return
				end)

				arg_7_0.selectedGifts = {}

				arg_7_0:moveJiujiu(-1)
			end

			arg_7_0:updateSelected()

			return
		end,
		start = function(arg_9_0)
			arg_9_0.selectedGifts = {}

			arg_9_0:updateSelected()

			return
		end,
		updateSelected = function(arg_10_0)
			for iter_10_0 = 1, #arg_10_0.gifts do
				local var_10_0 = arg_10_0.gifts[iter_10_0].index

				table = var_2_10006

				if var_2_10006.contains(arg_10_0.selectedGifts, var_10_0) then
					setActive = var_2_10006
					findTF = var_8

					var_2_10006(var_8(arg_10_0.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive = var_2_10006
					findTF = var_8

					var_2_10006(var_8(arg_10_0.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(arg_11_0, arg_11_1)
			if arg_11_1 == -1 then
				local var_11_0 = arg_11_0._workerTf

				Vector3 = var_2_10003
				var_11_0.anchoredPosition = var_2_10003.New(-290, 30, 0)

				local var_11_1 = arg_11_0._workerTf

				Vector3 = var_3
				var_11_1.localScale = var_3.New(-1, 1, 1)
			else
				local var_11_2 = arg_11_0.gifts[arg_11_1].tf
				local var_11_3 = arg_11_0._workerTf.parent

				var_3.x = var_3.InverseTransformPoint(var_11_3, var_11_2.position).x + 22
				var_3.y = var_3.y - 50
				arg_11_0._workerTf.anchoredPosition = var_3

				local var_11_4 = arg_11_0._workerTf

				Vector3 = var_11_3
				var_11_4.localScale = var_11_3.New(1, 1, 1)
			end

			return
		end,
		destroy = function(arg_12_0)
			if arg_12_0.delegateGifts and #arg_12_0.delegateGifts > 0 then
				for iter_12_0 = 1, #arg_12_0.delegateGifts do
					ClearEventTrigger = var_2_10005

					var_2_10005(arg_12_0.delegateGifts[iter_12_0])
				end

				arg_12_0.delegateGifts = {}
			end

			PoolMgr = var_1

			local var_12_0 = var_1.GetInstance()

			var_1.ReturnSpineChar(var_12_0, arg_12_0.wokerSpine.name, arg_12_0.wokerSpine.model)

			return
		end
	}

	var_3.Ctor(var_1_0)

	return var_3
end

local function var_0_35(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {
		Ctor = function(arg_14_0)
			arg_14_0._groupTf = arg_13_1
			arg_14_0._groupIndex = arg_13_2
			arg_14_0._groupTf.anchoredPosition = var_0_32[arg_13_2]
			arg_14_0._event = arg_13_3
			arg_14_0.modelData = {}
			SetActive = var_1

			var_1(arg_14_0._groupTf, true)
			arg_14_0:createIdol(arg_13_0[1], arg_13_0[2])

			arg_14_0.fans = {}
			arg_14_0.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			Ship = var_2_10003

			local var_15_0 = var_2_10003.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			})
			local var_15_1 = var_3.getPrefab(var_15_0)

			PoolMgr = var_5

			local var_15_2 = var_5.GetInstance()

			var_5.GetSpineChar(var_15_2, var_15_1, true, function(arg_16_0)
				local var_16_0 = arg_16_0.transform

				Vector3 = var_3_10002
				var_16_0.localScale = var_3_10002.one

				local var_16_1 = arg_16_0.transform

				Vector3 = var_2
				var_16_1.localPosition = var_2.zero

				local var_16_2 = arg_16_0.transform
				local var_16_3 = var_1.SetParent

				findTF = var_3_10004

				var_16_3(var_16_2, var_3_10004(arg_15_0._groupTf, "idolPos"), false)

				local var_16_4 = arg_16_0
				local var_16_5 = arg_16_0.GetComponent

				typeof = var_4
				SpineAnimUI = var_6

				local var_16_6 = var_16_5(var_16_4, var_4(var_6))

				arg_15_0.modelData = {
					model = arg_15_0.model,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = var_16_6
				}

				local var_16_7 = arg_15_0

				var_2.changeCharAction(var_16_7, var_0_19, 0, nil)

				return
			end)

			return
		end,
		changeCharAction = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
			if arg_17_0.modelData.actionName == arg_17_1 then
				return
			end

			arg_17_0.modelData.actionName = arg_17_1

			local var_17_0 = arg_17_0.modelData.anim

			var_4.SetActionCallBack(var_17_0, nil)

			local var_17_1 = arg_17_0.modelData.anim

			var_4.SetAction(var_17_1, arg_17_1, 0)

			local var_17_2 = arg_17_0.modelData.anim

			var_4.SetActionCallBack(var_17_2, function(arg_18_0)
				if arg_18_0 == "finish" then
					if arg_17_2 == 1 then
						local var_18_0 = arg_17_0.modelData.anim

						var_1.SetActionCallBack(var_18_0, nil)

						local var_18_1 = arg_17_0.modelData.anim

						var_1.SetAction(var_18_1, var_0_19, 0)
					end

					if arg_17_3 then
						arg_17_3()
					end
				end

				return
			end)

			if arg_17_2 ~= 1 and arg_17_3 then
				arg_17_3()
			end

			return
		end,
		createFans = function(arg_19_0, arg_19_1)
			SetActive = var_2_10002

			var_2_10002(arg_19_1, true)

			SetParent = var_2_10002

			local var_19_0 = arg_19_1

			findTF = var_5

			var_2_10002(var_19_0, var_5(arg_19_0._groupTf, "fansPos"))

			if #arg_19_0.fans > 0 then
				local var_19_1 = arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x + var_0_33

				math = var_4
				var_2.x = var_19_1 + var_4.random() * 200 + 22
				Vector3 = var_3
				arg_19_1.anchoredPosition = var_3.New(var_2.x, var_2.y, var_2.z)
			else
				Vector3 = var_2
				arg_19_1.anchoredPosition = var_2.New((#arg_19_0.fans + 1) * var_0_33 + 200, 0, 0)
			end

			table = var_2

			local var_19_2 = var_2.insert
			local var_19_3 = arg_19_0.fans
			local var_19_4 = {
				tf = arg_19_1
			}

			math = var_2_10006
			var_19_4.speed = var_2_10006.random() + 2.5

			var_19_2(var_19_3, var_19_4)

			local var_19_5 = arg_19_0.fans[#arg_19_0.fans]
			local var_19_6 = "jiu-fan"

			math = var_19_3

			local var_19_7 = var_19_6 .. var_19_3.random(1, 4)

			PoolMgr = var_4

			local var_19_8 = var_4.GetInstance()

			var_4.GetSpineChar(var_19_8, var_19_7, true, function(arg_20_0)
				local var_20_0 = arg_20_0.transform

				Vector3 = var_3_10002
				var_20_0.localScale = var_3_10002.one

				local var_20_1 = arg_20_0.transform

				Vector3 = var_2
				var_20_1.localPosition = var_2.zero

				local var_20_2 = arg_20_0.transform
				local var_20_3 = var_1.SetParent

				findTF = var_3_10004

				var_20_3(var_20_2, var_3_10004(var_19_5.tf, "spinePos"), false)

				local var_20_4 = arg_20_0
				local var_20_5 = arg_20_0.GetComponent

				typeof = var_4
				SpineAnimUI = var_6

				local var_20_6 = var_20_5(var_20_4, var_4(var_6))

				var_19_5.modelData = {
					model = arg_20_0,
					anim = var_20_6,
					modelName = var_19_7
				}

				return
			end)

			return
		end,
		changeFansAction = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
			if not arg_21_1.modelData or arg_21_1.modelData.actionName == arg_21_2 then
				return
			end

			arg_21_1.modelData.actionName = arg_21_2

			local var_21_0 = arg_21_1.modelData.anim

			var_5.SetActionCallBack(var_21_0, nil)

			local var_21_1 = arg_21_1.modelData.anim

			var_5.SetAction(var_21_1, arg_21_2, 0)

			local var_21_2 = arg_21_1.modelData.anim

			var_5.SetActionCallBack(var_21_2, function(arg_22_0)
				if arg_22_0 == "finish" then
					if arg_21_3 == 1 then
						local var_22_0 = arg_21_1.modelData.anim

						var_1.SetActionCallBack(var_22_0, nil)

						local var_22_1 = arg_21_1.modelData.anim

						var_1.SetAction(var_22_1, var_0_26, 0)
					end

					if arg_21_4 then
						arg_21_4()
					end
				end

				return
			end)

			if arg_21_3 ~= 1 and arg_21_4 then
				arg_21_4()
			end

			return
		end,
		getWantedGifts = function(arg_23_0)
			if #arg_23_0.fans > 0 and arg_23_0.fans[1].gifts and not arg_23_0.fans[1].leave then
				return arg_23_0.fans[1].gifts
			end

			return nil
		end,
		clearFans = function(arg_24_0)
			for iter_24_0 = 1, #arg_24_0.fans do
				PoolMgr = var_2_10005

				local var_24_0 = var_2_10005.GetInstance()

				var_2_10005.ReturnSpineChar(var_24_0, arg_24_0.fans[iter_24_0].modelData.modelName, arg_24_0.fans[iter_24_0].modelData.model)

				Destroy = var_2_10005

				var_2_10005(arg_24_0.fans[iter_24_0].tf)
			end

			arg_24_0.fans = {}

			return
		end,
		start = function(arg_25_0)
			return
		end,
		step = function(arg_26_0, arg_26_1)
			arg_26_0.stepTime = arg_26_1

			for iter_26_0 = #arg_26_0.fans, 1, -1 do
				local var_26_0 = arg_26_0.fans[iter_26_0].tf
				local var_26_1 = var_6.tf.anchoredPosition.x

				if (iter_26_0 - 1) * var_0_33 < var_26_1 then
					var_8.x = var_8.x - var_6.speed
					var_6.tf.anchoredPosition = var_8

					arg_26_0:changeFansAction(var_6, var_0_27, 0, nil)
				elseif iter_26_0 == 1 and not var_6.leave then
					if var_6.gifts == nil then
						var_6.gifts = arg_26_0:createWantedGifts()
						var_6.time = arg_26_1 + var_0_8
						LoadSprite = var_9

						local var_26_2 = var_9("ui/minigameui/idolmasterui_atlas", "pack" .. var_6.gifts[1])

						setImageSprite = var_10
						findTF = var_12

						var_10(var_12(var_6.tf, "score/pack"), var_26_2)
						arg_26_0:changeFansAction(var_6, var_0_25, 0, nil)
					end
				elseif not var_6.leave then
					arg_26_0:changeFansAction(var_6, var_0_26, 0, nil)
				end
			end

			if #arg_26_0.fans > 0 then
				if arg_26_0.fans[1].time and arg_26_1 > var_2.time and not var_2.leave then
					var_2.leave = true

					arg_26_0:fanLeave(var_2, var_0_29, function()
						table = var_3_10000

						var_3_10000.remove(arg_26_0.fans, 1)

						return
					end)
				else
					arg_26_0:showFansWanted(var_2)
				end

				local var_26_3 = var_2.tf

				var_3.SetSiblingIndex(var_26_3, #arg_26_0.fans - 1)
			end

			return
		end,
		showFansWanted = function(arg_28_0, arg_28_1)
			if arg_28_1.leave then
				return
			end

			if not arg_28_1.time then
				return
			end

			math = var_2_10003

			local var_28_0 = var_2_10003.ceil(var_2 - arg_28_0.stepTime) < 0 and 0 or var_2 - arg_28_0.stepTime
			local var_28_1 = arg_28_1.gifts
			local var_28_2 = var_28_0 <= 5

			setActive = var_2_10006
			findTF = var_2_10008

			var_2_10006(var_2_10008(arg_28_1.tf, "wanted"), true)

			setActive = var_2_10006
			findTF = var_8

			var_2_10006(var_8(arg_28_1.tf, "wanted/bg1"), not var_28_2)

			setActive = var_2_10006
			findTF = var_8

			var_2_10006(var_8(arg_28_1.tf, "wanted/bgTime1"), not var_28_2)

			setActive = var_2_10006
			findTF = var_8

			var_2_10006(var_8(arg_28_1.tf, "wanted/time1"), not var_28_2)

			setActive = var_2_10006
			findTF = var_8

			var_2_10006(var_8(arg_28_1.tf, "wanted/bg2"), var_28_2)

			setActive = var_2_10006
			findTF = var_8

			var_2_10006(var_8(arg_28_1.tf, "wanted/bgTime2"), var_28_2)

			setActive = var_2_10006
			findTF = var_8

			var_2_10006(var_8(arg_28_1.tf, "wanted/time1"), var_28_2)

			if var_28_0 < 0 then
				var_28_0 = 0
			end

			setText = var_6
			findTF = var_8

			local var_28_3 = var_8(arg_28_1.tf, "wanted/time1")

			math = var_9

			local var_28_4 = var_9.abs

			math = var_11

			var_6(var_28_3, var_28_4(var_11.ceil(var_28_0)) .. "S")

			setText = var_6
			findTF = var_28_3

			local var_28_5 = var_28_3(arg_28_1.tf, "wanted/time2")

			math = var_9

			local var_28_6 = var_9.abs

			math = var_11

			var_6(var_28_5, var_28_6(var_11.ceil(var_28_0)) .. "S")

			for iter_28_0 = 1, #var_28_1 do
				LoadSprite = var_28_7

				local var_28_7 = var_28_7("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_28_1[iter_28_0])

				setImageSprite = var_11
				findTF = var_13

				var_11(var_13(arg_28_1.tf, "wanted/item" .. iter_28_0), var_28_7)
			end

			return
		end,
		checkGifts = function(arg_29_0, arg_29_1)
			if arg_29_0:getWantedGifts() then
				for iter_29_0 = 1, #arg_29_1 do
					table = var_2_10007

					if not var_2_10007.contains(var_2, arg_29_1[iter_29_0]) then
						return false
					end
				end

				local var_29_0 = arg_29_0.fans[1]

				var_29_0.leave = true

				arg_29_0:fanLeave(var_29_0, var_0_30, function()
					table = var_3_10000

					var_3_10000.remove(arg_29_0.fans, 1)

					return
				end)

				return true
			end

			return false
		end,
		createWantedGifts = function(arg_31_0)
			Clone = var_2_10001

			local var_31_0 = var_2_10001(var_0_16)
			local var_31_1 = {}

			table = var_3

			local var_31_2 = var_3.insert
			local var_31_3 = var_31_1
			local var_31_4 = var_0_15

			math = var_2_10007

			var_31_2(var_31_3, var_31_4[var_2_10007.random(1, #var_0_15)])

			for iter_31_0 = 1, 2 do
				table = var_31_5

				local var_31_5 = var_31_5.remove
				local var_31_6 = var_31_0

				math = var_10
				var_31_5 = var_31_5(var_31_6, var_10.random(1, #var_31_0))
				table = var_2_10008

				var_2_10008.insert(var_31_1, var_31_5)
			end

			return var_31_1
		end,
		fanLeave = function(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
			setActive = var_2_10004
			findTF = var_2_10006

			var_2_10004(var_2_10006(arg_32_1.tf, "wanted"), false)

			local var_32_0

			if var_0_29 == arg_32_2 then
				var_32_0 = var_0_24
			elseif var_0_30 then
				var_32_0 = var_0_23
				setText = var_5
				findTF = var_7

				var_5(var_7(arg_32_1.tf, "score"), "+" .. var_0_7)

				setActive = var_5
				findTF = var_7

				var_5(var_7(arg_32_1.tf, "score"), true)
			end

			arg_32_0:changeFansAction(arg_32_1, var_32_0, 1, function()
				PoolMgr = var_3_10000

				local var_33_0 = var_3_10000.GetInstance()

				var_0.ReturnSpineChar(var_33_0, arg_32_1.modelData.modelName, arg_32_1.modelData.model)

				local var_33_1 = arg_32_0._event

				var_0.emit(var_33_1, var_0_13, arg_32_2)

				Destroy = var_0

				var_0(arg_32_1.tf)
				arg_32_3()

				return
			end)

			return
		end,
		reset = function(arg_34_0)
			arg_34_0:clearFans()

			arg_34_0.wantedData = {}

			return
		end,
		destroy = function(arg_35_0)
			if arg_35_0.modelData then
				PoolMgr = var_1

				local var_35_0 = var_1.GetInstance()

				var_1.ReturnSpineChar(var_35_0, arg_35_0.modelData.id, arg_35_0.modelData.model)
			end

			return
		end
	}

	var_4.Ctor(var_13_0)

	return var_4
end

local function var_0_36(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = {
		Ctor = function(arg_37_0)
			arg_37_0._containerTf = arg_36_0
			arg_37_0._tplGroup = arg_36_1
			arg_37_0._tplIdol = arg_36_2
			arg_37_0._tplFans = arg_36_3
			arg_37_0._event = arg_36_4
			arg_37_0.groups = {}

			local var_37_0 = arg_37_0:getRandomIdols()

			for iter_37_0 = 1, var_0_31 do
				tf = var_2_10006
				Instantiate = var_2_10008
				var_2_10006 = var_2_10006(var_2_10008(arg_37_0._tplGroup))
				SetParent = var_2_10007

				var_2_10007(var_2_10006, arg_37_0._containerTf)

				var_2_10007 = var_0_35(var_37_0[iter_37_0], var_2_10006, iter_37_0, arg_37_0._event)
				table = var_2_10008

				var_2_10008.insert(arg_37_0.groups, var_2_10007)
			end

			return
		end,
		receiveGift = function(arg_38_0, arg_38_1, arg_38_2)
			local var_38_0 = false

			for iter_38_0 = 1, #arg_38_0.groups do
				local var_38_1 = arg_38_0.groups[iter_38_0]

				if var_8.checkGifts(var_38_1, arg_38_1) then
					var_38_0 = true

					break
				end
			end

			if arg_38_2 then
				arg_38_2(var_38_0)
			end

			return
		end,
		getRandomIdols = function(arg_39_0)
			local var_39_0 = {}

			Clone = var_2_10002

			local var_39_1 = var_2_10002(var_0_10)

			for iter_39_0 = 1, var_0_31 do
				local var_39_2 = false

				if iter_39_0 == var_0_31 then
					var_39_2 = true
					ipairs = var_39_3

					for iter_39_1, iter_39_2 in var_39_3(var_0_11) do
						table = var_2_10013

						if var_2_10013.contains(var_39_0, iter_39_2) then
							var_39_2 = false
						end
					end
				end

				local var_39_3

				if var_39_2 then
					table = var_39_3
					var_39_3 = var_39_3.insert

					local var_39_4 = var_39_0

					iter_39_1 = var_0_11
					math = iter_39_2

					var_39_3(var_39_4, iter_39_1[iter_39_2.random(1, #var_0_11)])
				else
					table = var_39_3

					local var_39_5 = var_39_3.insert
					local var_39_6 = var_39_0

					table = iter_39_1
					iter_39_1 = iter_39_1.remove
					var_2_10013 = var_39_1
					math = var_2_10014

					var_39_5(var_39_6, iter_39_1(var_2_10013, var_2_10014.random(1, #var_39_1)))
				end
			end

			return var_39_0
		end,
		getApearTime = function(arg_40_0)
			if arg_40_0.runTime and arg_40_0.runTime > 0 then
				for iter_40_0 = 1, #var_0_9 do
					if arg_40_0.runTime < var_0_9[iter_40_0][1] then
						return var_0_9[iter_40_0][2]
					end
				end
			end

			return var_0_9[#var_0_9][2]
		end,
		start = function(arg_41_0)
			arg_41_0:reset()

			arg_41_0.createFansTime = nil
			arg_41_0.lastTime = var_0_6

			for iter_41_0 = 1, 3 do
				math = var_2_10005
				var_2_10005 = var_2_10005.random(1, #arg_41_0.groups)

				local var_41_0 = arg_41_0.groups[var_2_10005]
				local var_41_1 = var_6.createFans

				tf = var_2_10009
				instantiate = var_2_10011

				var_41_1(var_41_0, var_2_10009(var_2_10011(arg_41_0._tplFans)))
			end

			for iter_41_1 = 1, #arg_41_0.groups do
				local var_41_2 = arg_41_0.groups[iter_41_1]

				var_5.start(var_41_2)
			end

			return
		end,
		step = function(arg_42_0, arg_42_1)
			local var_42_0 = arg_42_0.lastTime

			Time = var_2_10003
			arg_42_0.lastTime = var_42_0 - var_2_10003.deltaTime

			local var_42_1 = arg_42_0
			local var_42_2 = arg_42_0.getApearTime(var_42_1)

			if not arg_42_0.createFansTime then
				local var_42_3 = arg_42_1 + var_42_2

				math = var_42_1
				arg_42_0.createFansTime = var_42_3 + var_42_1.random() * 1
			elseif arg_42_0.createFansTime < arg_42_1 then
				math = var_3

				local var_42_4 = var_3.random(1, #arg_42_0.groups)
				local var_42_5 = arg_42_0.groups[var_42_4]
				local var_42_6 = var_4.createFans

				tf = var_2_10007
				instantiate = var_2_10009

				var_42_6(var_42_5, var_2_10007(var_2_10009(arg_42_0._tplFans)))

				local var_42_7 = arg_42_1 + var_42_2

				math = var_5
				arg_42_0.createFansTime = var_42_7 + var_5.random() * 1
			end

			for iter_42_0 = 1, #arg_42_0.groups do
				local var_42_8 = arg_42_0.groups[iter_42_0]

				var_7.step(var_42_8, arg_42_1)
			end

			return
		end,
		reset = function(arg_43_0)
			for iter_43_0 = 1, #arg_43_0.groups do
				local var_43_0 = arg_43_0.groups[iter_43_0]

				var_5.reset(var_43_0)
			end

			return
		end,
		destroy = function(arg_44_0)
			for iter_44_0 = 1, #arg_44_0.groups do
				local var_44_0 = arg_44_0.groups[iter_44_0]

				var_5.destroy(var_44_0)
			end

			return
		end
	}

	var_5.Ctor(var_36_0)

	return var_5
end

function var_0_1.getUIName(arg_45_0)
	return "IdolMasterGameUI"
end

function var_0_1.getBGM(arg_46_0)
	return var_0_2
end

function var_0_1.didEnter(arg_47_0)
	arg_47_0:initEvent()
	arg_47_0:initData()
	arg_47_0:initUI()
	arg_47_0:initGameUI()
	arg_47_0:updateMenuUI()
	arg_47_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_48_0)
	arg_48_0:bind(var_0_12, function(arg_49_0, arg_49_1, arg_49_2)
		if arg_48_0.idolGroupUI then
			local var_49_0 = arg_48_0.idolGroupUI

			var_3.receiveGift(var_49_0, arg_49_1, arg_49_2)
		end

		return
	end)
	arg_48_0:bind(var_0_13, function(arg_50_0, arg_50_1, arg_50_2)
		if arg_48_0.gameStartFlag then
			if arg_50_1 == var_0_29 then
				local var_50_0 = arg_48_0

				var_3.loseHeart(var_50_0)
			elseif arg_50_1 == var_0_30 then
				local var_50_1 = arg_48_0

				var_3.addScore(var_50_1, 100)
			end
		end

		return
	end)

	return
end

function var_0_1.initData(arg_51_0)
	Application = var_1_10001

	local var_51_0

	if not var_1_10001.targetFrameRate then
		var_51_0 = 60
	end

	local var_51_1 = arg_51_0:GetMGHubData()

	arg_51_0.storylist = var_2.GetSimpleValue(var_51_1, "story")
	Timer = var_2
	arg_51_0.timer = var_2.New(function()
		local var_52_0 = arg_51_0

		var_0.onTimer(var_52_0)

		return
	end, 1 / var_51_0, -1)

	return
end

function var_0_1.initUI(arg_53_0)
	findTF = var_1_10001
	arg_53_0.sceneTf = var_1_10001(arg_53_0._tf, "scene")
	findTF = var_1
	arg_53_0.clickMask = var_1(arg_53_0._tf, "clickMask")
	findTF = var_1
	arg_53_0.countUI = var_1(arg_53_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_53_0 = var_3(arg_53_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_53_0.countAnimator = var_1(var_53_0, var_4(var_6))
	GetComponent = var_1
	findTF = var_53_0

	local var_53_1 = var_53_0(arg_53_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_53_0.countDft = var_1(var_53_1, var_4(var_6))

	local var_53_2 = arg_53_0.countDft

	var_1.SetTriggerEvent(var_53_2, function()
		return
	end)

	local var_53_3 = arg_53_0.countDft

	var_1.SetEndEvent(var_53_3, function()
		setActive = var_2_10000

		var_2_10000(arg_53_0.countUI, false)

		local var_55_0 = arg_53_0

		var_0.gameStart(var_55_0)

		return
	end)

	findTF = var_1
	arg_53_0.leaveUI = var_1(arg_53_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_53_4 = arg_53_0

	findTF = var_4

	local var_53_5 = var_4(arg_53_0.leaveUI, "ad/btnOk")

	local function var_53_6()
		local var_56_0 = arg_53_0

		var_0.resumeGame(var_56_0)

		local var_56_1 = arg_53_0

		var_0.onGameOver(var_56_1)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_53_4, var_53_5, var_53_6, var_6)

	onButton = var_1

	local var_53_7 = arg_53_0

	findTF = var_53_5

	local var_53_8 = var_53_5(arg_53_0.leaveUI, "ad/btnCancel")

	local function var_53_9()
		local var_57_0 = arg_53_0

		var_0.resumeGame(var_57_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_53_7, var_53_8, var_53_9, var_6)

	findTF = var_1
	arg_53_0.pauseUI = var_1(arg_53_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_53_10 = arg_53_0

	findTF = var_4

	local var_53_11 = var_4(arg_53_0.pauseUI, "ad/btnOk")

	local function var_53_12()
		setActive = var_2_10000

		var_2_10000(arg_53_0.pauseUI, false)

		local var_58_0 = arg_53_0

		var_0.resumeGame(var_58_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_53_10, var_53_11, var_53_12, var_6)

	findTF = var_1
	arg_53_0.settlementUI = var_1(arg_53_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_53_13 = arg_53_0

	findTF = var_4

	local var_53_14 = var_4(arg_53_0.settlementUI, "ad/btnOver")

	local function var_53_15()
		setActive = var_2_10000

		var_2_10000(arg_53_0.settlementUI, false)

		local var_59_0 = arg_53_0

		var_0.openMenuUI(var_59_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_53_13, var_53_14, var_53_15, var_6)

	findTF = var_1
	arg_53_0.menuUI = var_1(arg_53_0._tf, "pop/menuUI")
	GetComponent = var_1
	findTF = var_3

	local var_53_16 = var_3(arg_53_0.menuUI, "battList")

	typeof = var_4
	ScrollRect = var_6
	arg_53_0.battleScrollRect = var_1(var_53_16, var_4(var_6))
	arg_53_0.totalTimes = arg_53_0:getGameTotalTime()

	local var_53_17 = arg_53_0:getGameUsedTimes() - 4 < 0 and 0 or arg_53_0:getGameUsedTimes() - 4

	scrollTo = var_2

	var_2(arg_53_0.battleScrollRect, 0, 1 - var_53_17 / (arg_53_0.totalTimes - 4))

	onButton = var_2

	local var_53_18 = arg_53_0

	findTF = var_5

	local var_53_19 = var_5(arg_53_0.menuUI, "rightPanelBg/arrowUp")

	local function var_53_20()
		local var_60_0 = arg_53_0.battleScrollRect.normalizedPosition.y + 1 / (arg_53_0.totalTimes - 4)

		if 1 < var_60_0 then
			var_60_0 = 1
		end

		scrollTo = var_1

		var_1(arg_53_0.battleScrollRect, 0, var_60_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_53_18, var_53_19, var_53_20, var_7)

	onButton = var_2

	local var_53_21 = arg_53_0

	findTF = var_53_19

	local var_53_22 = var_53_19(arg_53_0.menuUI, "rightPanelBg/arrowDown")

	local function var_53_23()
		local var_61_0

		if arg_53_0.battleScrollRect.normalizedPosition.y - 1 / (arg_53_0.totalTimes - 4) < 0 then
			var_61_0 = 0
		end

		scrollTo = var_1

		var_1(arg_53_0.battleScrollRect, 0, var_61_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_53_21, var_53_22, var_53_23, var_7)

	onButton = var_2

	local var_53_24 = arg_53_0

	findTF = var_53_22

	local var_53_25 = var_53_22(arg_53_0.menuUI, "btnBack")

	local function var_53_26()
		local var_62_0 = arg_53_0

		var_0.closeView(var_62_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_53_24, var_53_25, var_53_26, var_7)

	onButton = var_2

	local var_53_27 = arg_53_0

	findTF = var_53_25

	local var_53_28 = var_53_25(arg_53_0.menuUI, "btnRule")

	local function var_53_29()
		pg = var_2_10000

		local var_63_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_63_1 = var_0.ShowMsgBox
		local var_63_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_63_2.type = var_2_10004
		pg = var_2_10004
		var_63_2.helps = var_2_10004.gametip.cowboy_tips.tip

		var_63_1(var_63_0, var_63_2)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_53_27, var_53_28, var_53_29, var_7)

	onButton = var_2

	local var_53_30 = arg_53_0

	findTF = var_53_28

	local var_53_31 = var_53_28(arg_53_0.menuUI, "btnStart")

	local function var_53_32()
		setActive = var_2_10000

		var_2_10000(arg_53_0.menuUI, false)

		local var_64_0 = arg_53_0

		var_0.readyStart(var_64_0)

		return
	end

	SFX_CANCEL = var_53_34

	var_2(var_53_30, var_53_31, var_53_32, var_53_34)

	findTF = var_2

	local var_53_33 = var_2(arg_53_0.menuUI, "tplBattleItem")

	arg_53_0.battleItems = {}

	for iter_53_0 = 1, arg_53_0.totalTimes do
		tf = var_53_34
		instantiate = var_1_10009

		local var_53_34 = var_53_34(var_1_10009(var_53_33))

		var_53_34.name = "battleItem_" .. iter_53_0
		setParent = var_8

		local var_53_35 = var_53_34

		findTF = var_11

		var_8(var_53_35, var_11(arg_53_0.menuUI, "battList/Viewport/Content"))

		local var_53_36 = iter_53_0

		GetSpriteFromAtlasAsync = var_1_10009

		var_1_10009("ui/minigameui/idolmasterui_atlas", "tx_" .. var_53_36, function(arg_65_0)
			setImageSprite = var_2_10001
			findTF = var_2_10003

			var_2_10001(var_2_10003(var_53_34, "state_open/icon"), arg_65_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_53_34, "state_clear/icon"), arg_65_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_53_34, "state_current/icon"), arg_65_0, true)

			return
		end)

		GetSpriteFromAtlasAsync = var_1_10009

		var_1_10009("ui/minigameui/idolmasterui_atlas", "battleDesc" .. var_53_36, function(arg_66_0)
			setImageSprite = var_2_10001
			findTF = var_2_10003

			var_2_10001(var_2_10003(var_53_34, "state_open/buttomDesc"), arg_66_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_53_34, "state_clear/buttomDesc"), arg_66_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_53_34, "state_current/buttomDesc"), arg_66_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_53_34, "state_closed/buttomDesc"), arg_66_0, true)

			return
		end)

		setActive = var_1_10009

		var_1_10009(var_53_34, true)

		table = var_1_10009

		var_1_10009.insert(arg_53_0.battleItems, var_53_34)
	end

	if not arg_53_0.handle then
		UpdateBeat = var_3
		arg_53_0.handle = var_3:CreateListener(arg_53_0.Update, arg_53_0)
	end

	UpdateBeat = var_3

	var_3:AddListener(arg_53_0.handle)

	return
end

function var_0_1.initGameUI(arg_67_0)
	findTF = var_1_10001
	arg_67_0.gameUI = var_1_10001(arg_67_0._tf, "ui/gameUI")
	findTF = var_1
	arg_67_0.textScore = var_1(arg_67_0.gameUI, "top/score")
	onButton = var_1

	local var_67_0 = arg_67_0

	findTF = var_4

	var_1(var_67_0, var_4(arg_67_0.gameUI, "topRight/btnStop"), function()
		local var_68_0 = arg_67_0

		var_0.stopGame(var_68_0)

		setActive = var_0

		var_0(arg_67_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_67_1 = arg_67_0

	findTF = var_4

	var_1(var_67_1, var_4(arg_67_0.gameUI, "btnLeave"), function()
		local var_69_0 = arg_67_0

		var_0.stopGame(var_69_0)

		setActive = var_0

		var_0(arg_67_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_67_0.gameTimeM = var_1(arg_67_0.gameUI, "topRight/time/m")
	findTF = var_1
	arg_67_0.gameTimeS = var_1(arg_67_0.gameUI, "topRight/time/s")
	arg_67_0.heartTfs = {}

	for iter_67_0 = 1, var_0_28 do
		table = var_67_2

		local var_67_2 = var_67_2.insert
		local var_67_3 = arg_67_0.heartTfs

		findTF = var_1_10008

		var_67_2(var_67_3, var_1_10008(arg_67_0.gameUI, "top/heart" .. iter_67_0 .. "/full"))
	end

	findTF = var_1
	arg_67_0.scoreTf = var_1(arg_67_0.gameUI, "top/score")

	local var_67_4 = var_0_34

	findTF = var_3

	local var_67_5 = var_3(arg_67_0._tf, "scene/gift")

	findTF = var_4
	arg_67_0.giftUI = var_67_4(var_67_5, var_4(arg_67_0._tf, "scene/jiujiuWorker"), arg_67_0)
	findTF = var_1

	local var_67_6 = var_1(arg_67_0._tf, "scene/group")

	findTF = var_2

	local var_67_7 = var_2(arg_67_0._tf, "scene/IdolContainer")

	findTF = var_3

	local var_67_8 = var_3(arg_67_0._tf, "scene/Idol")

	findTF = var_4

	local var_67_9 = var_4(arg_67_0._tf, "scene/fans")

	arg_67_0.idolGroupUI = var_0_36(var_67_7, var_67_6, var_67_8, var_67_9, arg_67_0)

	return
end

function var_0_1.Update(arg_70_0)
	arg_70_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_71_0)
	if arg_71_0.gameStop or arg_71_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.updateMenuUI(arg_72_0)
	local var_72_0 = arg_72_0:getGameUsedTimes()
	local var_72_1 = arg_72_0:getGameTimes()

	for iter_72_0 = 1, #arg_72_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_72_0.battleItems[iter_72_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_72_0.battleItems[iter_72_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_72_0.battleItems[iter_72_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_72_0.battleItems[iter_72_0], "state_current"), false)

		if iter_72_0 <= var_72_0 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_72_0.battleItems[iter_72_0], "state_clear"), true)
		elseif iter_72_0 == var_72_0 + 1 and 1 <= var_72_1 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_72_0.battleItems[iter_72_0], "state_current"), true)
		elseif var_72_0 < iter_72_0 and iter_72_0 <= var_72_0 + var_72_1 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_72_0.battleItems[iter_72_0], "state_open"), true)
		else
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_72_0.battleItems[iter_72_0], "state_closed"), true)
		end
	end

	arg_72_0.totalTimes = arg_72_0:getGameTotalTime()

	local var_72_2 = 1 - (arg_72_0:getGameUsedTimes() - 3 < 0 and 0 or arg_72_0:getGameUsedTimes() - 3) / (arg_72_0.totalTimes - 4)

	if 1 < var_72_2 then
		var_72_2 = 1
	end

	scrollTo = var_5

	var_5(arg_72_0.battleScrollRect, 0, var_72_2)

	setActive = var_5
	findTF = var_7

	var_5(var_7(arg_72_0.menuUI, "btnStart/tip"), var_72_1 > 0)
	arg_72_0:CheckGet()

	return
end

function var_0_1.CheckGet(arg_73_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_73_0.menuUI, "got"), false)

	if arg_73_0:getUltimate() then
		local var_73_0 = arg_73_0

		if arg_73_0.getUltimate(var_73_0) ~= 0 then
			setActive = var_1
			findTF = var_73_0

			var_1(var_73_0(arg_73_0.menuUI, "got"), true)
		end
	end

	if arg_73_0:getUltimate() == 0 then
		local var_73_1 = arg_73_0

		if arg_73_0.getGameTotalTime(var_73_1) > arg_73_0:getGameUsedTimes() then
			return
		end

		pg = var_73_1

		local var_73_2 = var_73_1.m02
		local var_73_3 = var_3.sendNotification

		GAME = var_6

		local var_73_4 = var_6.SEND_MINI_GAME_OP
		local var_73_5 = {
			hubid = arg_73_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_8
		var_73_5.cmd = var_8.CMD_ULTIMATE
		var_73_5.args1 = {}

		var_73_3(var_73_2, var_73_4, var_73_5)

		setActive = var_73_3
		findTF = var_73_2

		var_73_3(var_73_2(arg_73_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openMenuUI(arg_74_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_74_0._tf, "scene_front"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_74_0._tf, "scene_background"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_74_0._tf, "scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_74_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_74_0.menuUI, true)
	arg_74_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_75_0)
	setActive = var_1_10001

	var_1_10001(arg_75_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_75_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_75_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_75_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_75_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_76_0)
	setActive = var_1_10001

	var_1_10001(arg_76_0.countUI, true)

	local var_76_0 = arg_76_0.countAnimator

	var_1.Play(var_76_0, "count")

	pg = var_1

	local var_76_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_76_1, var_0_3)

	return
end

function var_0_1.gameStart(arg_77_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_77_0._tf, "scene_front"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_77_0._tf, "scene_background"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_77_0._tf, "scene"), true)

	setActive = var_1_10001

	var_1_10001(arg_77_0.gameUI, true)

	arg_77_0.gameStartFlag = true
	arg_77_0.scoreNum = 0
	arg_77_0.playerPosIndex = 2
	arg_77_0.gameStepTime = 0
	arg_77_0.heart = var_0_28
	arg_77_0.gameTime = var_0_6

	local var_77_0 = arg_77_0.idolGroupUI

	var_1.start(var_77_0)

	local var_77_1 = arg_77_0.giftUI

	var_1.start(var_77_1)
	arg_77_0:updateGameUI()
	arg_77_0:timerStart()

	return
end

function var_0_1.getGameTimes(arg_78_0)
	return arg_78_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_79_0)
	return arg_79_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_80_0)
	return arg_80_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_81_0)
	local var_81_0 = arg_81_0:GetMGHubData()

	return (var_1.getConfig(var_81_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_82_0, arg_82_1)
	return
end

function var_0_1.onTimer(arg_83_0)
	arg_83_0:gameStep()

	return
end

function var_0_1.gameStep(arg_84_0)
	local var_84_0 = arg_84_0.gameTime

	Time = var_1_10002
	arg_84_0.gameTime = var_84_0 - var_1_10002.deltaTime

	if arg_84_0.gameTime < 0 then
		arg_84_0.gameTime = 0
	end

	local var_84_1 = arg_84_0.gameStepTime

	Time = var_2
	arg_84_0.gameStepTime = var_84_1 + var_2.deltaTime

	if arg_84_0.idolGroupUI then
		local var_84_2 = arg_84_0.idolGroupUI

		var_1.step(var_84_2, arg_84_0.gameStepTime)
	end

	arg_84_0:updateGameUI()

	if arg_84_0.gameTime <= 0 then
		arg_84_0:onGameOver()

		return
	end

	return
end

function var_0_1.timerStart(arg_85_0)
	if not arg_85_0.timer.running then
		local var_85_0 = arg_85_0.timer

		var_1.Start(var_85_0)
	end

	return
end

function var_0_1.timerStop(arg_86_0)
	if arg_86_0.timer.running then
		local var_86_0 = arg_86_0.timer

		var_1.Stop(var_86_0)
	end

	return
end

function var_0_1.updateGameUI(arg_87_0)
	setText = var_1_10001

	var_1_10001(arg_87_0.textScore, arg_87_0.scoreNum)

	math = var_1_10001

	local var_87_0 = var_1_10001.floor

	math = var_3

	local var_87_1

	if var_87_0(var_3.ceil(arg_87_0.gameTime) / 60) < 10 then
		var_87_1 = "0" .. var_87_1
	end

	math = var_2

	local var_87_2 = var_2.floor

	math = var_4

	local var_87_3

	if var_87_2(var_4.ceil(arg_87_0.gameTime) % 60) < 10 then
		var_87_3 = "0" .. var_87_3
	end

	for iter_87_0 = 1, #arg_87_0.heartTfs do
		if iter_87_0 <= arg_87_0.heart then
			setActive = var_7

			var_7(arg_87_0.heartTfs[iter_87_0], true)
		else
			setActive = var_7

			var_7(arg_87_0.heartTfs[iter_87_0], false)
		end
	end

	setText = var_3

	var_3(arg_87_0.scoreTf, arg_87_0.scoreNum)

	setText = var_3

	var_3(arg_87_0.gameTimeM, var_87_1)

	setText = var_3

	var_3(arg_87_0.gameTimeS, var_87_3)

	return
end

function var_0_1.loseHeart(arg_88_0)
	if arg_88_0.heart <= 0 then
		return
	end

	arg_88_0.heart = arg_88_0.heart - 1

	arg_88_0:updateGameUI()

	if arg_88_0.heart <= 0 then
		arg_88_0.heart = 0

		arg_88_0:onGameOver()
	end

	return
end

function var_0_1.addScore(arg_89_0, arg_89_1)
	arg_89_0.scoreNum = arg_89_0.scoreNum + arg_89_1

	if arg_89_0.scoreNum < 0 then
		arg_89_0.scoreNum = 0
	end

	return
end

function var_0_1.onGameOver(arg_90_0)
	if arg_90_0.settlementFlag then
		return
	end

	arg_90_0:timerStop()

	arg_90_0.settlementFlag = true
	setActive = var_1

	var_1(arg_90_0.clickMask, true)

	LeanTween = var_1

	local var_90_0 = var_1.delayedCall

	go = var_3

	local var_90_1 = var_3(arg_90_0._tf)
	local var_90_2 = 2

	System = var_5

	var_90_0(var_90_1, var_90_2, var_5.Action(function()
		arg_90_0.settlementFlag = false

		local var_91_0 = arg_90_0

		var_91_0.gameStartFlag = false
		setActive = var_91_0

		var_91_0(arg_90_0.clickMask, false)

		local var_91_1 = arg_90_0

		var_0.showSettlement(var_91_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_92_0)
	setActive = var_1_10001

	var_1_10001(arg_92_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_92_0 = var_3(arg_92_0.settlementUI, "ad")

	typeof = var_4
	Animator = var_6

	local var_92_1 = var_1_10001(var_92_0, var_4(var_6))

	var_1.Play(var_92_1, "settlement", -1, 0)

	local var_92_2 = arg_92_0:GetMGData()
	local var_92_3 = var_2.GetRuntimeData(var_92_2, "elements")
	local var_92_4 = arg_92_0.scoreNum

	if var_92_3 then
		local var_92_5 = #var_92_3
		local var_92_6

		if not (0 < var_92_5) or not var_92_3[1] then
			var_92_6 = 0
		end

		setActive = var_5
		findTF = var_7

		var_5(var_7(arg_92_0.settlementUI, "ad/new"), var_92_6 < var_92_4)

		if var_92_6 <= var_92_4 then
			var_92_6 = var_92_4

			arg_92_0:StoreDataToServer({
				var_92_6
			})
		end

		findTF = var_5

		local var_92_7 = var_5(arg_92_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_92_8 = var_6(arg_92_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_92_7, var_92_6)

		setText = var_7

		var_7(var_92_8, var_92_4)

		if arg_92_0:getGameTimes() then
			local var_92_9 = arg_92_0:getGameTimes()

			if 0 < var_92_9 then
				local var_92_10 = arg_92_0:getGameUsedTimes() + 1

				pg = var_8

				local var_92_11 = var_8.NewStoryMgr.GetInstance()
				local var_92_12

				if not arg_92_0.storylist[var_92_10] or not arg_92_0.storylist[var_92_10][1] then
					var_92_12 = nil
				end

				if var_92_12 and not var_92_11:IsPlayed(var_92_12) then
					var_92_11:Play(var_92_12)
				end

				arg_92_0.sendSuccessFlag = true

				arg_92_0:SendSuccess(0)
			end
		end

		return
	end
end

function var_0_1.resumeGame(arg_93_0)
	arg_93_0.gameStop = false
	setActive = var_1

	var_1(arg_93_0.leaveUI, false)
	arg_93_0:changeSpeed(1)
	arg_93_0:timerStart()

	return
end

function var_0_1.stopGame(arg_94_0)
	arg_94_0.gameStop = true

	arg_94_0:timerStop()
	arg_94_0:changeSpeed(0)

	return
end

function var_0_1.onBackPressed(arg_95_0)
	if not arg_95_0.gameStartFlag then
		arg_95_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_95_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_95_0.pauseUI) then
			setActive = var_1

			var_1(arg_95_0.pauseUI, false)
		end

		arg_95_0:stopGame()

		setActive = var_1

		var_1(arg_95_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_96_0)
	if arg_96_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_96_0.handle)
	end

	if arg_96_0._tf then
		LeanTween = var_1

		local var_96_0 = var_1.isTweening

		go = var_1_10003

		if var_96_0(var_1_10003(arg_96_0._tf)) then
			LeanTween = var_1

			local var_96_1 = var_1.cancel

			go = var_3

			var_96_1(var_3(arg_96_0._tf))
		end
	end

	if arg_96_0.timer and arg_96_0.timer.running then
		local var_96_2 = arg_96_0.timer

		var_1.Stop(var_96_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_96_0.timer = nil

	return
end

return var_0_1

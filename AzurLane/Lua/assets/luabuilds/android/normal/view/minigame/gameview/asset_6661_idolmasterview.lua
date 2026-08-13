class = var_0_10000

local var_0_0 = "IdolMasterView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = {
	"idom-THEIDOLM@STER",
	"idom-GOMYWAY"
}
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_4 = 120
local var_0_5 = 100
local var_0_6 = 15
local var_0_7 = {
	{
		30,
		1
	},
	{
		60,
		1
	},
	{
		90,
		3
	},
	{
		120,
		4
	}
}
local var_0_8 = {
	"OUXIANGDASHIRICHANG1",
	"",
	"OUXIANGDASHIRICHANG2",
	"",
	"OUXIANGDASHIRICHANG3",
	"",
	"OUXIANGDASHIRICHANG4"
}
local var_0_9 = false
local var_0_10 = {
	{
		10700011,
		10700010
	},
	{
		10700021,
		10700020
	},
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
	}
}
local var_0_11 = {
	{
		10700061,
		10700060
	},
	{
		10700071,
		10700070
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
local var_0_18 = "event_bow"
local var_0_19 = "event_hello"
local var_0_20 = "event_stand"
local var_0_21 = "normal"
local var_0_22 = "work"
local var_0_23 = "wrong"
local var_0_24 = "end1"
local var_0_25 = "end2"
local var_0_26 = "gift"
local var_0_27 = "normal"
local var_0_28 = "walk"
local var_0_29 = 3
local var_0_30 = "type_fans_fail"
local var_0_31 = "type_fans_success"
local var_0_32 = 4
local var_0_33 = {}

Vector3 = var_0_10033
var_0_33[1] = var_0_10033(160, 160)
Vector3 = var_33
var_0_33[2] = var_33(160, -30)
Vector3 = var_33
var_0_33[3] = var_33(160, -210)
Vector3 = var_33
var_0_33[4] = var_33(160, -400)

local var_0_34 = 200
local var_0_35 = "是否继续游戏？"
local var_0_36 = "是否退出游戏?"
local var_0_37 = "本次得分 :"
local var_0_38 = "最高得分 :"
local var_0_39 = "分数 :"

local function var_0_40(arg_1_0, arg_1_1, arg_1_2)
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

				typeof = var_3
				SpineAnimUI = var_4

				local var_3_5 = var_3_4(var_3_3, var_3(var_4))

				arg_2_0.wokerSpine = {
					model = arg_3_0,
					anim = var_3_5,
					name = var_2_0
				}

				local var_3_6 = arg_2_0

				var_2.changeWorkerAction(var_3_6, var_0_21, 0, nil)

				return
			end)

			arg_2_0.selectedGifts = {}
			arg_2_0.gifts = {}
			arg_2_0.delegateGifts = {}

			for iter_2_0 = 1, #var_0_14 do
				local var_2_2 = iter_2_0

				findTF = var_2_10007
				var_2_10007 = var_2_10007(arg_2_0._giftTf, var_0_14[iter_2_0])
				table = var_8

				var_8.insert(arg_2_0.gifts, {
					tf = var_2_10007,
					index = iter_2_0
				})

				GetOrAddComponent = var_8

				local var_2_3 = var_8(var_2_10007, "EventTriggerListener")

				var_8.AddPointDownFunc(var_2_3, function(arg_4_0, arg_4_1)
					local var_4_0 = arg_2_0

					var_2.selectGift(var_4_0, var_2_2)

					return
				end)

				table = var_9

				var_9.insert(arg_2_0.delegateGifts, var_8)
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

						var_1.SetAction(var_6_1, var_0_21, 0)
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
				arg_7_0:changeWorkerAction(var_0_22, 1)
			else
				table = var_3

				var_3.remove(arg_7_0.selectedGifts, var_7_2)
			end

			if #arg_7_0.selectedGifts >= var_0_17 then
				local var_7_3 = arg_7_0._event
				local var_7_4 = var_3.emit
				local var_7_5 = var_0_12

				Clone = iter_7_2

				var_7_4(var_7_3, var_7_5, iter_7_2(arg_7_0.selectedGifts), function(arg_8_0, arg_8_1)
					if not arg_8_0 then
						local var_8_0 = arg_7_0

						var_2.changeWorkerAction(var_8_0, var_0_23, 1)
					else
						local var_8_1 = arg_7_0

						var_2.changeWorkerAction(var_8_1, var_0_21, 0, nil)
					end

					local var_8_2 = arg_7_0

					var_2.moveJiujiu(var_8_2, -1, arg_8_1)

					return
				end)

				arg_7_0.selectedGifts = {}
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
					findTF = var_7

					var_2_10006(var_7(arg_10_0.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive = var_2_10006
					findTF = var_7

					var_2_10006(var_7(arg_10_0.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(arg_11_0, arg_11_1, arg_11_2)
			if arg_11_1 == -1 then
				local var_11_0 = arg_11_0._workerTf

				Vector3 = var_2_10004
				var_11_0.localScale = var_2_10004.New(-1, 1, 1)

				local var_11_2

				if arg_11_2 and 0 < arg_11_2 then
					Clone = var_3

					local var_11_1 = var_3(var_0_33[arg_11_2])

					var_11_1.x = -100
					var_11_2 = arg_11_0._workerTf
					var_11_2.anchoredPosition = var_11_1
				else
					local var_11_3 = arg_11_0._workerTf

					Vector3 = var_11_2
					var_11_3.anchoredPosition = var_11_2.New(-290, 30, 0)
				end
			else
				local var_11_4 = arg_11_0.gifts[arg_11_1].tf
				local var_11_5 = arg_11_0._workerTf.parent

				var_4.x = var_4.InverseTransformPoint(var_11_5, var_11_4.position).x + 22
				var_4.y = var_4.y - 50
				arg_11_0._workerTf.anchoredPosition = var_4

				local var_11_6 = arg_11_0._workerTf

				Vector3 = var_6
				var_11_6.localScale = var_6.New(1, 1, 1)
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

local function var_0_41(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {
		Ctor = function(arg_14_0)
			arg_14_0._groupTf = arg_13_0
			arg_14_0._groupIndex = arg_13_1
			arg_14_0._groupTf.anchoredPosition = var_0_33[arg_13_1]
			arg_14_0._event = arg_13_2
			arg_14_0.modelData = {}
			SetActive = var_1

			var_1(arg_14_0._groupTf, true)

			arg_14_0.fans = {}
			arg_14_0.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			if arg_15_0.modelData.model then
				PoolMgr = var_3

				local var_15_0 = var_3.GetInstance()

				var_3.ReturnSpineChar(var_15_0, arg_15_0.modelData.id, arg_15_0.modelData.model)
			end

			Ship = var_3

			local var_15_1 = var_3.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			})
			local var_15_2 = var_3.getPrefab(var_15_1)

			PoolMgr = var_15_1

			local var_15_3 = var_15_1.GetInstance()

			var_5.GetSpineChar(var_15_3, var_15_2, true, function(arg_16_0)
				local var_16_0 = arg_16_0.transform

				Vector3 = var_3_10002
				var_16_0.localScale = var_3_10002.one

				local var_16_1 = arg_16_0.transform

				Vector3 = var_2
				var_16_1.localPosition = var_2.zero

				local var_16_2 = arg_16_0.transform
				local var_16_3 = var_1.SetParent

				findTF = var_3_10003

				var_16_3(var_16_2, var_3_10003(arg_15_0._groupTf, "idolPos"), false)

				local var_16_4 = arg_16_0
				local var_16_5 = arg_16_0.GetComponent

				typeof = var_3
				SpineAnimUI = var_4

				local var_16_6 = var_16_5(var_16_4, var_3(var_4))

				arg_15_0.modelData = {
					model = arg_16_0,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = var_16_6
				}

				local var_16_7 = arg_15_0

				var_2.changeCharAction(var_16_7, var_0_20, 0, nil)

				return
			end)

			return
		end,
		getFansAmount = function(arg_17_0)
			return #arg_17_0.fans
		end,
		changeCharAction = function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
			if arg_18_0.modelData.actionName == arg_18_1 then
				return
			end

			arg_18_0.modelData.actionName = arg_18_1

			local var_18_0 = arg_18_0.modelData.anim

			var_4.SetActionCallBack(var_18_0, nil)

			local var_18_1 = arg_18_0.modelData.anim

			var_4.SetAction(var_18_1, arg_18_1, 0)

			local var_18_2 = arg_18_0.modelData.anim

			var_4.SetActionCallBack(var_18_2, function(arg_19_0)
				if arg_19_0 == "finish" then
					if arg_18_2 == 1 then
						local var_19_0 = arg_18_0.modelData.anim

						var_1.SetActionCallBack(var_19_0, nil)

						local var_19_1 = arg_18_0.modelData.anim

						var_1.SetAction(var_19_1, var_0_20, 0)
					end

					if arg_18_3 then
						arg_18_3()
					end
				end

				return
			end)

			if arg_18_2 ~= 1 and arg_18_3 then
				arg_18_3()
			end

			return
		end,
		createFans = function(arg_20_0, arg_20_1)
			SetActive = var_2_10002

			var_2_10002(arg_20_1, true)

			SetParent = var_2_10002

			local var_20_0 = arg_20_1

			findTF = var_4

			var_2_10002(var_20_0, var_4(arg_20_0._groupTf, "fansPos"))

			local var_20_1 = #arg_20_0.fans
			local var_20_2

			if 0 < var_20_1 then
				var_20_2 = arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x + var_0_34
				math = var_4
				var_20_1.x = var_20_2 + var_4.random() * 200 + 22
				Vector3 = var_20_2
				arg_20_1.anchoredPosition = var_20_2.New(var_20_1.x, var_20_1.y, var_20_1.z)
			else
				Vector3 = var_20_1
				arg_20_1.anchoredPosition = var_20_1.New((#arg_20_0.fans + 1) * var_0_34 + 200, 0, 0)
			end

			setActive = var_20_1
			findTF = var_20_2

			var_20_1(var_20_2(arg_20_1, "wanted"), false)

			table = var_20_1

			local var_20_3 = var_20_1.insert
			local var_20_4 = arg_20_0.fans
			local var_20_5 = {
				tf = arg_20_1
			}

			math = var_5
			var_20_5.speed = var_5.random() * 50 + 200

			var_20_3(var_20_4, var_20_5)

			local var_20_6 = arg_20_0.fans[#arg_20_0.fans]
			local var_20_7 = "jiu-fan"

			math = var_20_5

			local var_20_8 = var_20_7 .. var_20_5.random(1, 4)

			PoolMgr = var_4

			local var_20_9 = var_4.GetInstance()

			var_4.GetSpineChar(var_20_9, var_20_8, true, function(arg_21_0)
				local var_21_0 = arg_21_0.transform

				Vector3 = var_3_10002
				var_21_0.localScale = var_3_10002.one

				local var_21_1 = arg_21_0.transform

				Vector3 = var_2
				var_21_1.localPosition = var_2.zero

				local var_21_2 = arg_21_0.transform
				local var_21_3 = var_1.SetParent

				findTF = var_3_10003

				var_21_3(var_21_2, var_3_10003(var_20_6.tf, "spinePos"), false)

				local var_21_4 = arg_21_0
				local var_21_5 = arg_21_0.GetComponent

				typeof = var_3
				SpineAnimUI = var_4

				local var_21_6 = var_21_5(var_21_4, var_3(var_4))

				var_20_6.modelData = {
					model = arg_21_0,
					anim = var_21_6,
					modelName = var_20_8
				}

				return
			end)

			return
		end,
		changeFansAction = function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
			if not arg_22_1.modelData or arg_22_1.modelData.actionName == arg_22_2 then
				return
			end

			arg_22_1.modelData.actionName = arg_22_2

			local var_22_0 = arg_22_1.modelData.anim

			var_5.SetActionCallBack(var_22_0, nil)

			local var_22_1 = arg_22_1.modelData.anim

			var_5.SetAction(var_22_1, arg_22_2, 0)

			local var_22_2 = arg_22_1.modelData.anim

			var_5.SetActionCallBack(var_22_2, function(arg_23_0)
				if arg_23_0 == "finish" then
					if arg_22_3 == 1 then
						local var_23_0 = arg_22_1.modelData.anim

						var_1.SetActionCallBack(var_23_0, nil)

						local var_23_1 = arg_22_1.modelData.anim

						var_1.SetAction(var_23_1, var_0_27, 0)
					end

					if arg_22_4 then
						arg_22_4()
					end
				end

				return
			end)

			if arg_22_3 ~= 1 and arg_22_4 then
				arg_22_4()
			end

			return
		end,
		getWantedGifts = function(arg_24_0)
			if #arg_24_0.fans > 0 and arg_24_0.fans[1].gifts and not arg_24_0.fans[1].leave then
				return arg_24_0.fans[1].gifts
			end

			return nil
		end,
		clearFans = function(arg_25_0)
			for iter_25_0 = 1, #arg_25_0.fans do
				PoolMgr = var_2_10005

				local var_25_0 = var_2_10005.GetInstance()

				var_2_10005.ReturnSpineChar(var_25_0, arg_25_0.fans[iter_25_0].modelData.modelName, arg_25_0.fans[iter_25_0].modelData.model)

				Destroy = var_2_10005

				var_2_10005(arg_25_0.fans[iter_25_0].tf)
			end

			arg_25_0.fans = {}

			return
		end,
		start = function(arg_26_0)
			return
		end,
		step = function(arg_27_0, arg_27_1)
			arg_27_0.stepTime = arg_27_1

			for iter_27_0 = #arg_27_0.fans, 1, -1 do
				local var_27_0 = arg_27_0.fans[iter_27_0].tf

				if var_6.tf.anchoredPosition.x > (iter_27_0 - 1) * var_0_34 then
					local var_27_1 = var_8.x
					local var_27_2 = var_6.speed

					Time = var_11
					var_8.x = var_27_1 - var_27_2 * var_11.deltaTime
					var_6.tf.anchoredPosition = var_8

					arg_27_0:changeFansAction(var_6, var_0_28, 0, nil)
				elseif iter_27_0 == 1 and not var_6.leave then
					if var_6.gifts == nil then
						var_6.gifts = arg_27_0:createWantedGifts()
						var_6.time = arg_27_1 + var_0_6
						LoadSprite = var_9

						local var_27_3 = var_9("ui/minigameui/idolmasterui_atlas", "pack" .. var_6.gifts[1])

						setImageSprite = var_10
						findTF = var_11

						var_10(var_11(var_6.tf, "score/pack"), var_27_3)
						arg_27_0:changeFansAction(var_6, var_0_26, 0, nil)
						arg_27_0:changeCharAction(var_0_19, 1, function()
							local var_28_0 = arg_27_0

							var_0.changeCharAction(var_28_0, var_0_20, 0, nil)

							return
						end)
					end
				elseif not var_6.leave then
					arg_27_0:changeFansAction(var_6, var_0_27, 0, nil)
				end
			end

			if #arg_27_0.fans > 0 then
				if arg_27_0.fans[1].time and arg_27_1 > var_2.time and not var_2.leave then
					var_2.leave = true

					arg_27_0:fanLeave(var_2, var_0_30, function()
						table = var_3_10000

						var_3_10000.remove(arg_27_0.fans, 1)

						return
					end)
				else
					arg_27_0:showFansWanted(var_2)
				end

				local var_27_4 = var_2.tf

				var_3.SetSiblingIndex(var_27_4, #arg_27_0.fans - 1)
			end

			return
		end,
		showFansWanted = function(arg_30_0, arg_30_1)
			if arg_30_1.leave then
				return
			end

			if not arg_30_1.time then
				return
			end

			math = var_2_10003

			local var_30_0 = var_2_10003.ceil(var_2 - arg_30_0.stepTime) < 0 and 0 or var_2 - arg_30_0.stepTime
			local var_30_1 = arg_30_1.gifts
			local var_30_2 = var_30_0 <= 5

			setActive = var_2_10006
			findTF = var_2_10007

			var_2_10006(var_2_10007(arg_30_1.tf, "wanted"), true)

			setActive = var_2_10006
			findTF = var_7

			var_2_10006(var_7(arg_30_1.tf, "wanted/bg1"), not var_30_2)

			setActive = var_2_10006
			findTF = var_7

			var_2_10006(var_7(arg_30_1.tf, "wanted/bgTime1"), not var_30_2)

			setActive = var_2_10006
			findTF = var_7

			var_2_10006(var_7(arg_30_1.tf, "wanted/time1"), not var_30_2)

			setActive = var_2_10006
			findTF = var_7

			var_2_10006(var_7(arg_30_1.tf, "wanted/bg2"), var_30_2)

			setActive = var_2_10006
			findTF = var_7

			var_2_10006(var_7(arg_30_1.tf, "wanted/bgTime2"), var_30_2)

			setActive = var_2_10006
			findTF = var_7

			var_2_10006(var_7(arg_30_1.tf, "wanted/time2"), var_30_2)

			if var_30_0 < 0 then
				var_30_0 = 0
			end

			setText = var_6
			findTF = var_7

			local var_30_3 = var_7(arg_30_1.tf, "wanted/time1")

			math = var_8

			local var_30_4 = var_8.abs

			math = var_9

			var_6(var_30_3, var_30_4(var_9.ceil(var_30_0)) .. "S")

			setText = var_6
			findTF = var_30_3

			local var_30_5 = var_30_3(arg_30_1.tf, "wanted/time2")

			math = var_8

			local var_30_6 = var_8.abs

			math = var_9

			var_6(var_30_5, var_30_6(var_9.ceil(var_30_0)) .. "S")

			for iter_30_0 = 1, #var_30_1 do
				LoadSprite = var_30_7

				local var_30_7 = var_30_7("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_30_1[iter_30_0])

				setImageSprite = var_11
				findTF = var_12

				var_11(var_12(arg_30_1.tf, "wanted/item" .. iter_30_0), var_30_7, true)
			end

			return
		end,
		checkGifts = function(arg_31_0, arg_31_1)
			if arg_31_0:getWantedGifts() then
				for iter_31_0 = 1, #arg_31_1 do
					table = var_2_10007

					if not var_2_10007.contains(var_2, arg_31_1[iter_31_0]) then
						return false
					end
				end

				return true
			end

			return false
		end,
		getGiftTime = function(arg_32_0)
			if #arg_32_0.fans > 0 and arg_32_0.fans[1] and arg_32_0.fans[1].time then
				return arg_32_0.fans[1].time
			end

			return nil
		end,
		finishGift = function(arg_33_0)
			if arg_33_0:getWantedGifts() then
				local var_33_0 = arg_33_0.fans[1]

				var_33_0.leave = true

				arg_33_0:fanLeave(var_33_0, var_0_31, function()
					table = var_3_10000

					var_3_10000.remove(arg_33_0.fans, 1)

					return
				end)
				arg_33_0:changeCharAction(var_0_18, 1, function()
					local var_35_0 = arg_33_0

					var_0.changeCharAction(var_35_0, var_0_20, 0, nil)

					return
				end)
			end

			return
		end,
		createWantedGifts = function(arg_36_0)
			Clone = var_2_10001

			local var_36_0 = var_2_10001(var_0_16)
			local var_36_1 = {}

			table = var_2_10003

			local var_36_2 = var_2_10003.insert
			local var_36_3 = var_36_1
			local var_36_4 = var_0_15

			math = var_2_10006

			var_36_2(var_36_3, var_36_4[var_2_10006.random(1, #var_0_15)])

			for iter_36_0 = 1, 2 do
				table = var_36_5

				local var_36_5 = var_36_5.remove
				local var_36_6 = var_36_0

				math = var_2_10009
				var_36_5 = var_36_5(var_36_6, var_2_10009.random(1, #var_36_0))
				table = var_36_6

				var_36_6.insert(var_36_1, var_36_5)
			end

			return var_36_1
		end,
		fanLeave = function(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
			setActive = var_2_10004
			findTF = var_2_10005

			var_2_10004(var_2_10005(arg_37_1.tf, "wanted"), false)

			local var_37_0

			if var_0_30 == arg_37_2 then
				var_37_0 = var_0_25
			elseif var_0_31 then
				var_37_0 = var_0_24
				setText = var_5
				findTF = var_6

				var_5(var_6(arg_37_1.tf, "score"), "+" .. var_0_5)

				setActive = var_5
				findTF = var_6

				var_5(var_6(arg_37_1.tf, "score"), true)
			end

			arg_37_0:changeFansAction(arg_37_1, var_37_0, 1, function()
				PoolMgr = var_3_10000

				local var_38_0 = var_3_10000.GetInstance()

				var_0.ReturnSpineChar(var_38_0, arg_37_1.modelData.modelName, arg_37_1.modelData.model)

				local var_38_1 = arg_37_0._event

				var_0.emit(var_38_1, var_0_13, arg_37_2)

				Destroy = var_0

				var_0(arg_37_1.tf)
				arg_37_3()

				return
			end)

			return
		end,
		reset = function(arg_39_0)
			arg_39_0:clearFans()

			arg_39_0.wantedData = {}

			return
		end,
		destroy = function(arg_40_0)
			if arg_40_0.modelData then
				PoolMgr = var_1

				local var_40_0 = var_1.GetInstance()

				var_1.ReturnSpineChar(var_40_0, arg_40_0.modelData.id, arg_40_0.modelData.model)
			end

			return
		end
	}

	var_3.Ctor(var_13_0)

	return var_3
end

local function var_0_42(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = {
		Ctor = function(arg_42_0)
			arg_42_0._containerTf = arg_41_0
			arg_42_0._tplGroup = arg_41_1
			arg_42_0._tplIdol = arg_41_2
			arg_42_0._tplFans = arg_41_3
			arg_42_0._event = arg_41_4
			arg_42_0.groups = {}

			for iter_42_0 = 1, var_0_32 do
				tf = var_2_10005
				Instantiate = var_2_10006
				var_2_10005 = var_2_10005(var_2_10006(arg_42_0._tplGroup))
				SetParent = var_2_10006

				var_2_10006(var_2_10005, arg_42_0._containerTf)

				var_2_10006 = var_0_41(var_2_10005, iter_42_0, arg_42_0._event)
				table = var_7

				var_7.insert(arg_42_0.groups, var_2_10006)
			end

			return
		end,
		createIdols = function(arg_43_0)
			local var_43_0 = arg_43_0:getRandomIdols()

			for iter_43_0 = 1, #arg_43_0.groups do
				local var_43_1 = arg_43_0.groups[iter_43_0]

				var_6.createIdol(var_43_1, var_43_0[iter_43_0][1], var_43_0[iter_43_0][2])
			end

			return
		end,
		receiveGift = function(arg_44_0, arg_44_1, arg_44_2)
			local var_44_0 = false
			local var_44_1
			local var_44_2

			for iter_44_0 = 1, #arg_44_0.groups do
				local var_44_3 = arg_44_0.groups[iter_44_0]

				if var_10.checkGifts(var_44_3, arg_44_1) then
					var_44_0 = true

					if not var_44_1 then
						var_44_1 = arg_44_0.groups[iter_44_0]
						var_44_2 = iter_44_0
					else
						local var_44_4 = var_44_1:getGiftTime()
						local var_44_5 = arg_44_0.groups[iter_44_0]

						if var_44_4 > var_11.getGiftTime(var_44_5) then
							var_44_1 = arg_44_0.groups[iter_44_0]
							var_44_2 = iter_44_0
						end
					end
				end
			end

			if var_44_1 then
				var_44_1:finishGift()
			end

			if arg_44_2 then
				arg_44_2(var_44_0, var_44_2)
			end

			return
		end,
		getRandomIdols = function(arg_45_0)
			local var_45_0 = {}

			Clone = var_2_10002

			local var_45_1 = var_2_10002(var_0_10)

			math = var_3

			if var_3.random() > 0.6 then
				Clone = var_3
				var_45_0 = var_3(var_0_11)
			end

			for iter_45_0 = #var_45_0 + 1, var_0_32 do
				table = var_2_10008
				var_2_10008 = var_2_10008.insert
				var_2_10009 = var_45_0
				table = var_2_10010
				var_2_10010 = var_2_10010.remove
				var_2_10011 = var_45_1
				math = var_2_10012

				var_2_10008(var_2_10009, var_2_10010(var_2_10011, var_2_10012.random(1, #var_45_1)))
			end

			local var_45_2 = {}

			for iter_45_1 = 1, var_0_32 do
				table = var_2_10009
				var_2_10009 = var_2_10009.insert

				local var_45_3 = var_45_2

				table = var_2_10011
				var_2_10011 = var_2_10011.remove

				local var_45_4 = var_45_0

				math = var_2_10013

				var_2_10009(var_45_3, var_2_10011(var_45_4, var_2_10013.random(1, #var_45_0)))
			end

			return var_45_2
		end,
		getApearTime = function(arg_46_0)
			if arg_46_0.lastTime and arg_46_0.lastTime > 0 then
				for iter_46_0 = 1, #var_0_7 do
					if arg_46_0.lastTime < var_0_7[iter_46_0][1] then
						return var_0_7[iter_46_0][2]
					end
				end
			end

			return var_0_7[#var_0_7][2]
		end,
		getFansAmount = function(arg_47_0)
			local var_47_0 = 0

			for iter_47_0 = 1, #arg_47_0.groups do
				local var_47_1 = arg_47_0.groups[iter_47_0]

				var_47_0 = var_47_0 + var_6.getFansAmount(var_47_1)
			end

			return var_47_0
		end,
		start = function(arg_48_0)
			arg_48_0:reset()

			arg_48_0.createFansTime = nil
			arg_48_0.lastTime = var_0_4

			for iter_48_0 = 1, 3 do
				math = var_2_10005
				var_2_10005 = var_2_10005.random(1, #arg_48_0.groups)

				local var_48_0 = arg_48_0.groups[var_2_10005]
				local var_48_1 = var_6.createFans

				tf = var_2_10008
				instantiate = var_2_10009

				var_48_1(var_48_0, var_2_10008(var_2_10009(arg_48_0._tplFans)))
			end

			for iter_48_1 = 1, #arg_48_0.groups do
				local var_48_2 = arg_48_0.groups[iter_48_1]

				var_5.start(var_48_2)
			end

			return
		end,
		step = function(arg_49_0, arg_49_1)
			local var_49_0 = arg_49_0.lastTime

			Time = var_2_10003
			arg_49_0.lastTime = var_49_0 - var_2_10003.deltaTime

			if not arg_49_0.createFansTime then
				local var_49_1 = arg_49_1 + arg_49_0:getApearTime()

				math = var_2_10004
				arg_49_0.createFansTime = var_49_1 + var_2_10004.random() * 1
			elseif arg_49_1 > arg_49_0.createFansTime and arg_49_0:getFansAmount() <= 10 then
				local var_49_2 = arg_49_0
				local var_49_3 = arg_49_0.getApearTime(var_49_2)

				math = var_49_2

				local var_49_4 = var_49_2.random(1, #arg_49_0.groups)
				local var_49_5 = arg_49_0.groups[var_49_4]
				local var_49_6 = var_4.createFans

				tf = var_2_10006
				instantiate = var_2_10007

				var_49_6(var_49_5, var_2_10006(var_2_10007(arg_49_0._tplFans)))

				local var_49_7 = arg_49_1 + var_49_3

				math = var_49_5
				arg_49_0.createFansTime = var_49_7 + var_49_5.random() * 1
			end

			for iter_49_0 = 1, #arg_49_0.groups do
				local var_49_8 = arg_49_0.groups[iter_49_0]

				var_6.step(var_49_8, arg_49_1)
			end

			return
		end,
		reset = function(arg_50_0)
			for iter_50_0 = 1, #arg_50_0.groups do
				local var_50_0 = arg_50_0.groups[iter_50_0]

				var_5.reset(var_50_0)
			end

			return
		end,
		destroy = function(arg_51_0)
			for iter_51_0 = 1, #arg_51_0.groups do
				local var_51_0 = arg_51_0.groups[iter_51_0]

				var_5.destroy(var_51_0)
			end

			return
		end
	}

	var_5.Ctor(var_41_0)

	return var_5
end

function var_0_1.getUIName(arg_52_0)
	return "IdolMasterGameUI"
end

function var_0_1.getBGM(arg_53_0)
	local var_53_0 = var_0_2

	math = var_1_10002

	return var_53_0[var_1_10002.random(1, #var_0_2)]
end

function var_0_1.didEnter(arg_54_0)
	arg_54_0:initEvent()
	arg_54_0:initData()
	arg_54_0:initUI()
	arg_54_0:initGameUI()
	arg_54_0:initTextTip()
	arg_54_0:updateMenuUI()
	arg_54_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_55_0)
	arg_55_0:bind(var_0_12, function(arg_56_0, arg_56_1, arg_56_2)
		if arg_55_0.idolGroupUI then
			local var_56_0 = arg_55_0.idolGroupUI

			var_3.receiveGift(var_56_0, arg_56_1, arg_56_2)
		end

		return
	end)
	arg_55_0:bind(var_0_13, function(arg_57_0, arg_57_1, arg_57_2)
		if arg_55_0.gameStartFlag then
			if arg_57_1 == var_0_30 then
				local var_57_0 = arg_55_0

				var_3.loseHeart(var_57_0)
			elseif arg_57_1 == var_0_31 then
				local var_57_1 = arg_55_0

				var_3.addScore(var_57_1, 100)
			end
		end

		return
	end)

	return
end

function var_0_1.initData(arg_58_0)
	Application = var_1_10001

	local var_58_0

	if not var_1_10001.targetFrameRate then
		var_58_0 = 60
	end

	Timer = var_1_10002
	arg_58_0.timer = var_1_10002.New(function()
		local var_59_0 = arg_58_0

		var_0.onTimer(var_59_0)

		return
	end, 1 / var_58_0, -1)

	return
end

function var_0_1.initUI(arg_60_0)
	findTF = var_1_10001
	arg_60_0.sceneTf = var_1_10001(arg_60_0._tf, "scene")
	findTF = var_1
	arg_60_0.clickMask = var_1(arg_60_0._tf, "clickMask")
	findTF = var_1
	arg_60_0.countUI = var_1(arg_60_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_2

	local var_60_0 = var_2(arg_60_0.countUI, "count")

	typeof = var_3
	Animator = var_4
	arg_60_0.countAnimator = var_1(var_60_0, var_3(var_4))
	GetComponent = var_1
	findTF = var_60_0

	local var_60_1 = var_60_0(arg_60_0.countUI, "count")

	typeof = var_3
	DftAniEvent = var_4
	arg_60_0.countDft = var_1(var_60_1, var_3(var_4))

	local var_60_2 = arg_60_0.countDft

	var_1.SetTriggerEvent(var_60_2, function()
		return
	end)

	local var_60_3 = arg_60_0.countDft

	var_1.SetEndEvent(var_60_3, function()
		setActive = var_2_10000

		var_2_10000(arg_60_0.countUI, false)

		local var_62_0 = arg_60_0

		var_0.gameStart(var_62_0)

		return
	end)

	findTF = var_1
	arg_60_0.leaveUI = var_1(arg_60_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_60_4 = arg_60_0

	findTF = var_3

	local var_60_5 = var_3(arg_60_0.leaveUI, "ad/btnOk")

	local function var_60_6()
		local var_63_0 = arg_60_0

		var_0.resumeGame(var_63_0)

		local var_63_1 = arg_60_0

		var_0.onGameOver(var_63_1)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_60_4, var_60_5, var_60_6, var_5)

	onButton = var_1

	local var_60_7 = arg_60_0

	findTF = var_60_5

	local var_60_8 = var_60_5(arg_60_0.leaveUI, "ad/btnCancel")

	local function var_60_9()
		local var_64_0 = arg_60_0

		var_0.resumeGame(var_64_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_60_7, var_60_8, var_60_9, var_5)

	findTF = var_1
	arg_60_0.pauseUI = var_1(arg_60_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_60_10 = arg_60_0

	findTF = var_3

	local var_60_11 = var_3(arg_60_0.pauseUI, "ad/btnOk")

	local function var_60_12()
		setActive = var_2_10000

		var_2_10000(arg_60_0.pauseUI, false)

		local var_65_0 = arg_60_0

		var_0.resumeGame(var_65_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_60_10, var_60_11, var_60_12, var_5)

	findTF = var_1
	arg_60_0.settlementUI = var_1(arg_60_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_60_13 = arg_60_0

	findTF = var_3

	local var_60_14 = var_3(arg_60_0.settlementUI, "ad/btnOver")

	local function var_60_15()
		setActive = var_2_10000

		var_2_10000(arg_60_0.settlementUI, false)

		local var_66_0 = arg_60_0

		var_0.openMenuUI(var_66_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_60_13, var_60_14, var_60_15, var_5)

	findTF = var_1
	arg_60_0.menuUI = var_1(arg_60_0._tf, "pop/menuUI")
	GetComponent = var_1
	findTF = var_2

	local var_60_16 = var_2(arg_60_0.menuUI, "battList")

	typeof = var_3
	ScrollRect = var_4
	arg_60_0.battleScrollRect = var_1(var_60_16, var_3(var_4))
	arg_60_0.totalTimes = arg_60_0:getGameTotalTime()

	local var_60_17, var_60_18

	if arg_60_0:getGameUsedTimes() - 4 < 0 then
		var_60_17 = 0
	else
		var_60_18 = arg_60_0
		var_60_17 = arg_60_0.getGameUsedTimes(var_60_18) - 4
	end

	scrollTo = var_60_18

	var_60_18(arg_60_0.battleScrollRect, 0, 1 - var_60_17 / (arg_60_0.totalTimes - 4))

	onButton = var_60_18

	local var_60_19 = arg_60_0

	findTF = var_4

	local var_60_20 = var_4(arg_60_0.menuUI, "rightPanelBg/arrowUp")

	local function var_60_21()
		local var_67_0 = arg_60_0.battleScrollRect.normalizedPosition.y + 1 / (arg_60_0.totalTimes - 4)

		if 1 < var_67_0 then
			var_67_0 = 1
		end

		scrollTo = var_1

		var_1(arg_60_0.battleScrollRect, 0, var_67_0)

		return
	end

	SFX_CANCEL = var_6

	var_60_18(var_60_19, var_60_20, var_60_21, var_6)

	onButton = var_60_18

	local var_60_22 = arg_60_0

	findTF = var_60_20

	local var_60_23 = var_60_20(arg_60_0.menuUI, "rightPanelBg/arrowDown")

	local function var_60_24()
		local var_68_0

		if arg_60_0.battleScrollRect.normalizedPosition.y - 1 / (arg_60_0.totalTimes - 4) < 0 then
			var_68_0 = 0
		end

		scrollTo = var_1

		var_1(arg_60_0.battleScrollRect, 0, var_68_0)

		return
	end

	SFX_CANCEL = var_6

	var_60_18(var_60_22, var_60_23, var_60_24, var_6)

	onButton = var_60_18

	local var_60_25 = arg_60_0

	findTF = var_60_23

	local var_60_26 = var_60_23(arg_60_0.menuUI, "btnBack")

	local function var_60_27()
		local var_69_0 = arg_60_0

		var_0.closeView(var_69_0)

		return
	end

	SFX_CANCEL = var_6

	var_60_18(var_60_25, var_60_26, var_60_27, var_6)

	onButton = var_60_18

	local var_60_28 = arg_60_0

	findTF = var_60_26

	local var_60_29 = var_60_26(arg_60_0.menuUI, "btnRule")

	local function var_60_30()
		pg = var_2_10000

		local var_70_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_70_1 = var_0.ShowMsgBox
		local var_70_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_70_2.type = var_2_10003
		pg = var_2_10003
		var_70_2.helps = var_2_10003.gametip.handshake_game_help.tip

		var_70_1(var_70_0, var_70_2)

		return
	end

	SFX_CANCEL = var_6

	var_60_18(var_60_28, var_60_29, var_60_30, var_6)

	onButton = var_60_18

	local var_60_31 = arg_60_0

	findTF = var_60_29

	local var_60_32 = var_60_29(arg_60_0.menuUI, "btnStart")

	local function var_60_33()
		local var_71_0 = arg_60_0

		if var_0.getGameUsedTimes(var_71_0) == 0 and not var_0_9 then
			var_0_9 = true
			setActive = var_0

			var_0(arg_60_0.helpUI, true)
		else
			setActive = var_0

			var_0(arg_60_0.menuUI, false)

			local var_71_1 = arg_60_0

			var_0.readyStart(var_71_1)
		end

		return
	end

	SFX_CANCEL = var_6

	var_60_18(var_60_31, var_60_32, var_60_33, var_6)

	findTF = var_60_18

	local var_60_34 = var_60_18(arg_60_0.menuUI, "tplBattleItem")

	arg_60_0.battleItems = {}

	for iter_60_0 = 1, arg_60_0.totalTimes do
		tf = var_1_10007
		instantiate = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008(var_60_34))
		var_1_10007.name = "battleItem_" .. iter_60_0
		setParent = var_1_10008

		local var_60_35 = var_1_10007

		findTF = var_1_10010

		var_1_10008(var_60_35, var_1_10010(arg_60_0.menuUI, "battList/Viewport/Content"))

		var_1_10008 = iter_60_0
		GetSpriteFromAtlasAsync = var_60_35

		var_60_35("ui/minigameui/idolmasterui_atlas", "tx_" .. var_1_10008, function(arg_72_0)
			setImageSprite = var_2_10001
			findTF = var_2_10002

			var_2_10001(var_2_10002(var_1_10007, "state_open/icon"), arg_72_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_clear/icon"), arg_72_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_current/icon"), arg_72_0, true)

			return
		end)

		GetSpriteFromAtlasAsync = var_60_35

		var_60_35("ui/minigameui/idolmasterui_atlas", "battleDesc" .. var_1_10008, function(arg_73_0)
			setImageSprite = var_2_10001
			findTF = var_2_10002

			var_2_10001(var_2_10002(var_1_10007, "state_open/buttomDesc"), arg_73_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_clear/buttomDesc"), arg_73_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_current/buttomDesc"), arg_73_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_closed/buttomDesc"), arg_73_0, true)

			return
		end)

		setActive = var_60_35

		var_60_35(var_1_10007, true)

		table = var_60_35

		var_60_35.insert(arg_60_0.battleItems, var_1_10007)
	end

	findTF = var_3
	arg_60_0.helpUI = var_3(arg_60_0._tf, "pop/HelpUI")
	onButton = var_3

	local var_60_36 = arg_60_0

	findTF = var_5

	local var_60_37 = var_5(arg_60_0.helpUI, "close")

	local function var_60_38()
		setActive = var_2_10000

		var_2_10000(arg_60_0.helpUI, false)

		setActive = var_2_10000

		var_2_10000(arg_60_0.menuUI, false)

		local var_74_0 = arg_60_0

		var_0.readyStart(var_74_0)

		return
	end

	SFX_CANCEL = var_7

	var_3(var_60_36, var_60_37, var_60_38, var_7)

	if not arg_60_0.handle then
		UpdateBeat = var_3
		arg_60_0.handle = var_3:CreateListener(arg_60_0.Update, arg_60_0)
	end

	UpdateBeat = var_3

	var_3:AddListener(arg_60_0.handle)

	return
end

function var_0_1.initGameUI(arg_75_0)
	findTF = var_1_10001
	arg_75_0.gameUI = var_1_10001(arg_75_0._tf, "ui/gameUI")
	findTF = var_1
	arg_75_0.textScore = var_1(arg_75_0.gameUI, "top/score")
	onButton = var_1

	local var_75_0 = arg_75_0

	findTF = var_3

	var_1(var_75_0, var_3(arg_75_0.gameUI, "topRight/btnStop"), function()
		local var_76_0 = arg_75_0

		var_0.stopGame(var_76_0)

		setActive = var_0

		var_0(arg_75_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_75_1 = arg_75_0

	findTF = var_3

	var_1(var_75_1, var_3(arg_75_0.gameUI, "btnLeave"), function()
		local var_77_0 = arg_75_0

		var_0.stopGame(var_77_0)

		setActive = var_0

		var_0(arg_75_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_75_0.gameTimeM = var_1(arg_75_0.gameUI, "topRight/time/m")
	findTF = var_1
	arg_75_0.gameTimeS = var_1(arg_75_0.gameUI, "topRight/time/s")
	arg_75_0.heartTfs = {}

	for iter_75_0 = 1, var_0_29 do
		table = var_75_2

		local var_75_2 = var_75_2.insert
		local var_75_3 = arg_75_0.heartTfs

		findTF = var_1_10007

		var_75_2(var_75_3, var_1_10007(arg_75_0.gameUI, "top/heart" .. iter_75_0 .. "/full"))
	end

	findTF = var_1
	arg_75_0.scoreTf = var_1(arg_75_0.gameUI, "top/score")

	local var_75_4 = var_0_40

	findTF = var_2

	local var_75_5 = var_2(arg_75_0._tf, "scene/gift")

	findTF = var_3
	arg_75_0.giftUI = var_75_4(var_75_5, var_3(arg_75_0._tf, "scene/jiujiuWorker"), arg_75_0)
	findTF = var_1

	local var_75_6 = var_1(arg_75_0._tf, "scene/group")

	findTF = var_2

	local var_75_7 = var_2(arg_75_0._tf, "scene/IdolContainer")

	findTF = var_3

	local var_75_8 = var_3(arg_75_0._tf, "scene/Idol")

	findTF = var_4

	local var_75_9 = var_4(arg_75_0._tf, "scene/fans")

	arg_75_0.idolGroupUI = var_0_42(var_75_7, var_75_6, var_75_8, var_75_9, arg_75_0)

	return
end

function var_0_1.initTextTip(arg_78_0)
	i18n = var_1_10001

	local var_78_0

	if not var_1_10001("idolmaster_game_tip1") then
		var_78_0 = var_0_35
	end

	var_0_35 = var_78_0
	i18n = var_78_0

	local var_78_1

	if not var_78_0("idolmaster_game_tip2") then
		var_78_1 = var_0_36
	end

	var_0_36 = var_78_1
	i18n = var_78_1

	local var_78_2

	if not var_78_1("idolmaster_game_tip3") then
		var_78_2 = var_0_37
	end

	var_0_37 = var_78_2
	i18n = var_78_2

	local var_78_3

	if not var_78_2("idolmaster_game_tip4") then
		var_78_3 = var_0_38
	end

	var_0_38 = var_78_3
	i18n = var_78_3

	local var_78_4

	if not var_78_3("idolmaster_game_tip5") then
		var_78_4 = var_0_39
	end

	var_0_39 = var_78_4
	setText = var_78_4
	findTF = var_2

	var_78_4(var_2(arg_78_0.settlementUI, "ad/currentTextDesc"), var_0_37)

	setText = var_78_4
	findTF = var_2

	var_78_4(var_2(arg_78_0.settlementUI, "ad/highTextDesc"), var_0_38)

	setText = var_78_4
	findTF = var_2

	var_78_4(var_2(arg_78_0.gameUI, "top/scoreImg/socre"), var_0_39)

	setText = var_78_4
	findTF = var_2

	var_78_4(var_2(arg_78_0.pauseUI, "ad/tip"), var_0_35)

	setText = var_78_4
	findTF = var_2

	var_78_4(var_2(arg_78_0.leaveUI, "ad/tip"), var_0_36)

	return
end

function var_0_1.Update(arg_79_0)
	arg_79_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_80_0)
	if arg_80_0.gameStop or arg_80_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.updateMenuUI(arg_81_0)
	local var_81_0 = arg_81_0:getGameUsedTimes()
	local var_81_1 = arg_81_0:getGameTimes()

	for iter_81_0 = 1, #arg_81_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_81_0.battleItems[iter_81_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_81_0.battleItems[iter_81_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_81_0.battleItems[iter_81_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_81_0.battleItems[iter_81_0], "state_current"), false)

		if iter_81_0 <= var_81_0 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_81_0.battleItems[iter_81_0], "state_clear"), true)
		elseif iter_81_0 == var_81_0 + 1 and 1 <= var_81_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_81_0.battleItems[iter_81_0], "state_current"), true)
		elseif var_81_0 < iter_81_0 and iter_81_0 <= var_81_0 + var_81_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_81_0.battleItems[iter_81_0], "state_open"), true)
		else
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_81_0.battleItems[iter_81_0], "state_closed"), true)
		end
	end

	arg_81_0.totalTimes = arg_81_0:getGameTotalTime()

	local var_81_2 = 1 - (arg_81_0:getGameUsedTimes() - 3 < 0 and 0 or arg_81_0:getGameUsedTimes() - 3) / (arg_81_0.totalTimes - 4)

	if 1 < var_81_2 then
		var_81_2 = 1
	end

	scrollTo = var_5

	var_5(arg_81_0.battleScrollRect, 0, var_81_2)

	setActive = var_5
	findTF = var_6

	var_5(var_6(arg_81_0.menuUI, "btnStart/tip"), var_81_1 > 0)
	arg_81_0:CheckGet()

	return
end

function var_0_1.CheckGet(arg_82_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_82_0.menuUI, "got"), false)

	if arg_82_0:getUltimate() then
		local var_82_0 = arg_82_0

		if arg_82_0.getUltimate(var_82_0) ~= 0 then
			setActive = var_1
			findTF = var_82_0

			var_1(var_82_0(arg_82_0.menuUI, "got"), true)
		end
	end

	if arg_82_0:getUltimate() == 0 then
		local var_82_1 = arg_82_0:getGameTotalTime()
		local var_82_2 = arg_82_0

		if var_82_1 > arg_82_0.getGameUsedTimes(var_82_2) then
			return
		end

		pg = var_82_2

		local var_82_3 = var_82_2.m02
		local var_82_4 = var_3.sendNotification

		GAME = var_1_10005

		local var_82_5 = var_1_10005.SEND_MINI_GAME_OP
		local var_82_6 = {
			hubid = arg_82_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_7
		var_82_6.cmd = var_7.CMD_ULTIMATE
		var_82_6.args1 = {}

		var_82_4(var_82_3, var_82_5, var_82_6)

		setActive = var_82_4
		findTF = var_82_3

		var_82_4(var_82_3(arg_82_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openMenuUI(arg_83_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_83_0._tf, "scene_front"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_83_0._tf, "scene_background"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_83_0._tf, "scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_83_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_83_0.menuUI, true)

	if arg_83_0.storyIndex and var_0_8[arg_83_0.storyIndex] ~= "" and arg_83_0:getGameUsedTimes() == arg_83_0.storyIndex then
		pg = var_1

		local var_83_0 = var_1.NewStoryMgr.GetInstance()

		var_1.Play(var_83_0, var_0_8[arg_83_0.storyIndex], function()
			return
		end, true)

		arg_83_0.storyIndex = nil
	end

	arg_83_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_85_0)
	setActive = var_1_10001

	var_1_10001(arg_85_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_85_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_85_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_85_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_85_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_86_0)
	setActive = var_1_10001

	var_1_10001(arg_86_0.countUI, true)

	local var_86_0 = arg_86_0.countAnimator

	var_1.Play(var_86_0, "count")

	pg = var_1

	local var_86_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_86_1, var_0_3)

	local var_86_2 = arg_86_0.idolGroupUI

	var_1.createIdols(var_86_2)

	return
end

function var_0_1.gameStart(arg_87_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_87_0._tf, "scene_front"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_87_0._tf, "scene_background"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_87_0._tf, "scene"), true)

	setActive = var_1_10001

	var_1_10001(arg_87_0.gameUI, true)

	arg_87_0.gameStartFlag = true
	arg_87_0.scoreNum = 0
	arg_87_0.playerPosIndex = 2
	arg_87_0.gameStepTime = 0
	arg_87_0.heart = var_0_29
	arg_87_0.gameTime = var_0_4

	local var_87_0 = arg_87_0.idolGroupUI

	var_1.start(var_87_0)

	local var_87_1 = arg_87_0.giftUI

	var_1.start(var_87_1)
	arg_87_0:updateGameUI()
	arg_87_0:timerStart()

	return
end

function var_0_1.getGameTimes(arg_88_0)
	return arg_88_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_89_0)
	return arg_89_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_90_0)
	return arg_90_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_91_0)
	local var_91_0 = arg_91_0:GetMGHubData()

	return (var_1.getConfig(var_91_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_92_0, arg_92_1)
	return
end

function var_0_1.onTimer(arg_93_0)
	arg_93_0:gameStep()

	return
end

function var_0_1.gameStep(arg_94_0)
	local var_94_0 = arg_94_0.gameTime

	Time = var_1_10002
	arg_94_0.gameTime = var_94_0 - var_1_10002.deltaTime

	if arg_94_0.gameTime < 0 then
		arg_94_0.gameTime = 0
	end

	local var_94_1 = arg_94_0.gameStepTime

	Time = var_2
	arg_94_0.gameStepTime = var_94_1 + var_2.deltaTime

	if arg_94_0.idolGroupUI then
		local var_94_2 = arg_94_0.idolGroupUI

		var_1.step(var_94_2, arg_94_0.gameStepTime)
	end

	arg_94_0:updateGameUI()

	if arg_94_0.gameTime <= 0 then
		arg_94_0:onGameOver()

		return
	end

	return
end

function var_0_1.timerStart(arg_95_0)
	if not arg_95_0.timer.running then
		local var_95_0 = arg_95_0.timer

		var_1.Start(var_95_0)
	end

	return
end

function var_0_1.timerStop(arg_96_0)
	if arg_96_0.timer.running then
		local var_96_0 = arg_96_0.timer

		var_1.Stop(var_96_0)
	end

	return
end

function var_0_1.updateGameUI(arg_97_0)
	setText = var_1_10001

	var_1_10001(arg_97_0.textScore, arg_97_0.scoreNum)

	math = var_1_10001

	local var_97_0 = var_1_10001.floor

	math = var_2

	local var_97_1

	if var_97_0(var_2.ceil(arg_97_0.gameTime) / 60) < 10 then
		var_97_1 = "0" .. var_97_1
	end

	math = var_2

	local var_97_2 = var_2.floor

	math = var_3

	local var_97_3

	if var_97_2(var_3.ceil(arg_97_0.gameTime) % 60) < 10 then
		var_97_3 = "0" .. var_97_3
	end

	for iter_97_0 = 1, #arg_97_0.heartTfs do
		if iter_97_0 <= arg_97_0.heart then
			setActive = var_7

			var_7(arg_97_0.heartTfs[iter_97_0], true)
		else
			setActive = var_7

			var_7(arg_97_0.heartTfs[iter_97_0], false)
		end
	end

	setText = var_3

	var_3(arg_97_0.scoreTf, arg_97_0.scoreNum)

	setText = var_3

	var_3(arg_97_0.gameTimeM, var_97_1)

	setText = var_3

	var_3(arg_97_0.gameTimeS, var_97_3)

	return
end

function var_0_1.loseHeart(arg_98_0)
	if arg_98_0.heart <= 0 then
		return
	end

	arg_98_0.heart = arg_98_0.heart - 1

	arg_98_0:updateGameUI()

	if arg_98_0.heart <= 0 then
		arg_98_0.heart = 0

		arg_98_0:onGameOver()
	end

	return
end

function var_0_1.addScore(arg_99_0, arg_99_1)
	arg_99_0.scoreNum = arg_99_0.scoreNum + arg_99_1

	if arg_99_0.scoreNum < 0 then
		arg_99_0.scoreNum = 0
	end

	return
end

function var_0_1.onGameOver(arg_100_0)
	if arg_100_0.settlementFlag then
		return
	end

	arg_100_0:timerStop()

	arg_100_0.settlementFlag = true
	setActive = var_1

	var_1(arg_100_0.clickMask, true)

	LeanTween = var_1

	local var_100_0 = var_1.delayedCall

	go = var_2

	local var_100_1 = var_2(arg_100_0._tf)
	local var_100_2 = 2

	System = var_1_10004

	var_100_0(var_100_1, var_100_2, var_1_10004.Action(function()
		arg_100_0.settlementFlag = false

		local var_101_0 = arg_100_0

		var_101_0.gameStartFlag = false
		setActive = var_101_0

		var_101_0(arg_100_0.clickMask, false)

		local var_101_1 = arg_100_0

		var_0.showSettlement(var_101_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_102_0)
	setActive = var_1_10001

	var_1_10001(arg_102_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_2

	local var_102_0 = var_2(arg_102_0.settlementUI, "ad")

	typeof = var_3
	Animator = var_4

	local var_102_1 = var_1_10001(var_102_0, var_3(var_4))

	var_1.Play(var_102_1, "settlement", -1, 0)

	local var_102_2 = arg_102_0:GetMGData()
	local var_102_3 = var_2.GetRuntimeData(var_102_2, "elements")
	local var_102_4 = arg_102_0.scoreNum

	if var_102_3 then
		local var_102_5 = #var_102_3
		local var_102_6

		if not (0 < var_102_5) or not var_102_3[1] then
			var_102_6 = 0
		end

		setActive = var_5
		findTF = var_6

		var_5(var_6(arg_102_0.settlementUI, "ad/new"), var_102_6 < var_102_4)

		if var_102_6 <= var_102_4 then
			var_102_6 = var_102_4

			arg_102_0:StoreDataToServer({
				var_102_6
			})
		end

		findTF = var_5

		local var_102_7 = var_5(arg_102_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_102_8 = var_6(arg_102_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_102_7, var_102_6)

		setText = var_7

		var_7(var_102_8, var_102_4)

		if arg_102_0:getGameTimes() and arg_102_0:getGameTimes() > 0 then
			arg_102_0.sendSuccessFlag = true
			arg_102_0.storyIndex = arg_102_0:getGameUsedTimes() + 1

			arg_102_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.resumeGame(arg_103_0)
	arg_103_0.gameStop = false
	setActive = var_1

	var_1(arg_103_0.leaveUI, false)
	arg_103_0:changeSpeed(1)
	arg_103_0:timerStart()

	return
end

function var_0_1.stopGame(arg_104_0)
	arg_104_0.gameStop = true

	arg_104_0:timerStop()
	arg_104_0:changeSpeed(0)

	return
end

function var_0_1.onBackPressed(arg_105_0)
	if not arg_105_0.gameStartFlag then
		arg_105_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_105_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_105_0.pauseUI) then
			setActive = var_1

			var_1(arg_105_0.pauseUI, false)
		end

		arg_105_0:stopGame()

		setActive = var_1

		var_1(arg_105_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_106_0)
	if arg_106_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_106_0.handle)
	end

	if arg_106_0._tf then
		LeanTween = var_1

		local var_106_0 = var_1.isTweening

		go = var_1_10002

		if var_106_0(var_1_10002(arg_106_0._tf)) then
			LeanTween = var_1

			local var_106_1 = var_1.cancel

			go = var_2

			var_106_1(var_2(arg_106_0._tf))
		end
	end

	if arg_106_0.timer and arg_106_0.timer.running then
		local var_106_2 = arg_106_0.timer

		var_1.Stop(var_106_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_106_0.timer = nil

	return
end

return var_0_1

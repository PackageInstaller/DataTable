local var_0_0 = class("IdolMasterView", import("..BaseMiniGameView"))
local var_0_1 = {
	"idom-THEIDOLM@STER",
	"idom-GOMYWAY"
}
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = 120
local var_0_4 = 100
local var_0_5 = 15
local var_0_6 = {
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
local var_0_7 = {
	"OUXIANGDASHIRICHANG1",
	"",
	"OUXIANGDASHIRICHANG2",
	"",
	"OUXIANGDASHIRICHANG3",
	"",
	"OUXIANGDASHIRICHANG4"
}
local var_0_8 = false
local var_0_9 = {
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
local var_0_10 = {
	{
		10700061,
		10700060
	},
	{
		10700071,
		10700070
	}
}
local var_0_11 = "EVENT_SEND_GIFT"
local var_0_12 = "EVENT_FANS_ACTION"
local var_0_13 = {
	1,
	2,
	3,
	4,
	5,
	6
}
local var_0_14 = {
	1,
	2
}
local var_0_15 = {
	3,
	4,
	5,
	6
}
local var_0_16 = 3
local var_0_17 = "event_bow"
local var_0_18 = "event_hello"
local var_0_19 = "event_stand"
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
local var_0_32 = {
	Vector3(160, 160),
	Vector3(160, -30),
	Vector3(160, -210),
	Vector3(160, -400)
}
local var_0_33 = 200
local var_0_34 = "是否继续游戏？"
local var_0_35 = "是否退出游戏?"
local var_0_36 = "本次得分 :"
local var_0_37 = "最高得分 :"
local var_0_38 = "分数 :"

local function var_0_39(arg_1_0, arg_1_1, arg_1_2)
	({
		Ctor = function(arg_2_0)
			arg_2_0._giftTf = arg_1_0
			arg_2_0._event = arg_1_2
			arg_2_0._workerTf = arg_1_1

			PoolMgr.GetInstance():GetSpineChar("jiu-work", true, function(arg_3_0)
				arg_3_0.transform.localScale = Vector3.one
				arg_3_0.transform.localPosition = Vector3.zero

				arg_3_0.transform:SetParent(arg_2_0._workerTf, false)

				arg_2_0.wokerSpine = {
					model = arg_3_0,
					anim = arg_3_0:GetComponent(typeof(SpineAnimUI)),
					name = var_0
				}

				arg_2_0:changeWorkerAction(var_0_20, 0, nil)

				return
			end)

			arg_2_0.selectedGifts = {}
			arg_2_0.gifts = {}
			arg_2_0.delegateGifts = {}

			for iter_2_0 = 1, #var_0_13 do
				local var_2_0 = iter_2_0
				local var_2_1 = findTF(arg_2_0._giftTf, var_0_13[iter_2_0])

				table.insert(arg_2_0.gifts, {
					tf = var_2_1,
					index = iter_2_0
				})

				local var_2_2 = GetOrAddComponent(var_2_1, "EventTriggerListener")

				var_2_2:AddPointDownFunc(function(arg_4_0, arg_4_1)
					arg_2_0:selectGift(var_2_0)

					return
				end)
				table.insert(arg_2_0.delegateGifts, var_2_2)
			end

			arg_2_0:updateSelected()

			return
		end,
		changeWorkerAction = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
			arg_5_0.wokerSpine.anim:SetActionCallBack(nil)
			arg_5_0.wokerSpine.anim:SetAction(arg_5_1, 0)
			arg_5_0.wokerSpine.anim:SetActionCallBack(function(arg_6_0)
				if arg_6_0 == "finish" then
					if arg_5_2 == 1 then
						arg_5_0.wokerSpine.anim:SetActionCallBack(nil)
						arg_5_0.wokerSpine.anim:SetAction(var_0_20, 0)
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
			if table.contains(var_0_14, arg_7_1) then
				for iter_7_0 = #arg_7_0.selectedGifts, 1, -1 do
					if table.contains(var_0_14, arg_7_0.selectedGifts[iter_7_0]) and arg_7_0.selectedGifts[iter_7_0] ~= arg_7_1 then
						table.remove(arg_7_0.selectedGifts, iter_7_0)
					end
				end
			elseif #arg_7_0.selectedGifts == 2 and not table.contains(arg_7_0.selectedGifts, arg_7_1) then
				local var_7_0 = false

				for iter_7_1 = 1, #arg_7_0.selectedGifts do
					if table.contains(var_0_14, arg_7_0.selectedGifts[iter_7_1]) then
						var_7_0 = true

						break
					end
				end

				if not var_7_0 then
					table.remove(arg_7_0.selectedGifts, 1)
				end
			end

			local var_7_1 = 0

			for iter_7_2 = 1, #arg_7_0.selectedGifts do
				if arg_7_0.selectedGifts[iter_7_2] == arg_7_1 then
					var_7_1 = iter_7_2
				end
			end

			if var_7_1 == 0 then
				table.insert(arg_7_0.selectedGifts, arg_7_1)
				arg_7_0:moveJiujiu(arg_7_1)
				arg_7_0:changeWorkerAction(var_0_21, 1)
			else
				table.remove(arg_7_0.selectedGifts, var_7_1)
			end

			if #arg_7_0.selectedGifts >= var_0_16 then
				arg_7_0._event:emit(var_0_11, Clone(arg_7_0.selectedGifts), function(arg_8_0, arg_8_1)
					if not arg_8_0 then
						arg_7_0:changeWorkerAction(var_0_22, 1)
					else
						arg_7_0:changeWorkerAction(var_0_20, 0, nil)
					end

					arg_7_0:moveJiujiu(-1, arg_8_1)

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
				if table.contains(arg_10_0.selectedGifts, arg_10_0.gifts[iter_10_0].index) then
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(arg_11_0, arg_11_1, arg_11_2)
			if arg_11_1 == -1 then
				arg_11_0._workerTf.localScale = Vector3.New(-1, 1, 1)

				if arg_11_2 and arg_11_2 > 0 then
					local var_11_0 = Clone(var_0_32[arg_11_2])

					var_11_0.x = -100
					arg_11_0._workerTf.anchoredPosition = var_11_0
				else
					arg_11_0._workerTf.anchoredPosition = Vector3.New(-290, 30, 0)
				end
			else
				local var_11_1 = arg_11_0._workerTf.parent:InverseTransformPoint(arg_11_0.gifts[arg_11_1].tf.position)

				var_11_1.x = var_11_1.x + 22
				var_11_1.y = var_11_1.y - 50
				arg_11_0._workerTf.anchoredPosition = var_11_1
				arg_11_0._workerTf.localScale = Vector3.New(1, 1, 1)
			end

			return
		end,
		destroy = function(arg_12_0)
			if arg_12_0.delegateGifts and #arg_12_0.delegateGifts > 0 then
				for iter_12_0 = 1, #arg_12_0.delegateGifts do
					ClearEventTrigger(arg_12_0.delegateGifts[iter_12_0])
				end

				arg_12_0.delegateGifts = {}
			end

			PoolMgr.GetInstance():ReturnSpineChar(arg_12_0.wokerSpine.name, arg_12_0.wokerSpine.model)

			return
		end
	}).Ctor({
		Ctor = function(arg_2_0)
			arg_2_0._giftTf = arg_1_0
			arg_2_0._event = arg_1_2
			arg_2_0._workerTf = arg_1_1

			PoolMgr.GetInstance():GetSpineChar("jiu-work", true, function(arg_3_0)
				arg_3_0.transform.localScale = Vector3.one
				arg_3_0.transform.localPosition = Vector3.zero

				arg_3_0.transform:SetParent(arg_2_0._workerTf, false)

				arg_2_0.wokerSpine = {
					model = arg_3_0,
					anim = arg_3_0:GetComponent(typeof(SpineAnimUI)),
					name = var_0
				}

				arg_2_0:changeWorkerAction(var_0_20, 0, nil)

				return
			end)

			arg_2_0.selectedGifts = {}
			arg_2_0.gifts = {}
			arg_2_0.delegateGifts = {}

			for iter_2_0 = 1, #var_0_13 do
				local var_2_0 = iter_2_0
				local var_2_1 = findTF(arg_2_0._giftTf, var_0_13[iter_2_0])

				table.insert(arg_2_0.gifts, {
					tf = var_2_1,
					index = iter_2_0
				})

				local var_2_2 = GetOrAddComponent(var_2_1, "EventTriggerListener")

				var_2_2:AddPointDownFunc(function(arg_4_0, arg_4_1)
					arg_2_0:selectGift(var_2_0)

					return
				end)
				table.insert(arg_2_0.delegateGifts, var_2_2)
			end

			arg_2_0:updateSelected()

			return
		end,
		changeWorkerAction = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
			arg_5_0.wokerSpine.anim:SetActionCallBack(nil)
			arg_5_0.wokerSpine.anim:SetAction(arg_5_1, 0)
			arg_5_0.wokerSpine.anim:SetActionCallBack(function(arg_6_0)
				if arg_6_0 == "finish" then
					if arg_5_2 == 1 then
						arg_5_0.wokerSpine.anim:SetActionCallBack(nil)
						arg_5_0.wokerSpine.anim:SetAction(var_0_20, 0)
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
			if table.contains(var_0_14, arg_7_1) then
				for iter_7_0 = #arg_7_0.selectedGifts, 1, -1 do
					if table.contains(var_0_14, arg_7_0.selectedGifts[iter_7_0]) and arg_7_0.selectedGifts[iter_7_0] ~= arg_7_1 then
						table.remove(arg_7_0.selectedGifts, iter_7_0)
					end
				end
			elseif #arg_7_0.selectedGifts == 2 and not table.contains(arg_7_0.selectedGifts, arg_7_1) then
				local var_7_0 = false

				for iter_7_1 = 1, #arg_7_0.selectedGifts do
					if table.contains(var_0_14, arg_7_0.selectedGifts[iter_7_1]) then
						var_7_0 = true

						break
					end
				end

				if not var_7_0 then
					table.remove(arg_7_0.selectedGifts, 1)
				end
			end

			local var_7_1 = 0

			for iter_7_2 = 1, #arg_7_0.selectedGifts do
				if arg_7_0.selectedGifts[iter_7_2] == arg_7_1 then
					var_7_1 = iter_7_2
				end
			end

			if var_7_1 == 0 then
				table.insert(arg_7_0.selectedGifts, arg_7_1)
				arg_7_0:moveJiujiu(arg_7_1)
				arg_7_0:changeWorkerAction(var_0_21, 1)
			else
				table.remove(arg_7_0.selectedGifts, var_7_1)
			end

			if #arg_7_0.selectedGifts >= var_0_16 then
				arg_7_0._event:emit(var_0_11, Clone(arg_7_0.selectedGifts), function(arg_8_0, arg_8_1)
					if not arg_8_0 then
						arg_7_0:changeWorkerAction(var_0_22, 1)
					else
						arg_7_0:changeWorkerAction(var_0_20, 0, nil)
					end

					arg_7_0:moveJiujiu(-1, arg_8_1)

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
				if table.contains(arg_10_0.selectedGifts, arg_10_0.gifts[iter_10_0].index) then
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(arg_11_0, arg_11_1, arg_11_2)
			if arg_11_1 == -1 then
				arg_11_0._workerTf.localScale = Vector3.New(-1, 1, 1)

				if arg_11_2 and arg_11_2 > 0 then
					local var_11_0 = Clone(var_0_32[arg_11_2])

					var_11_0.x = -100
					arg_11_0._workerTf.anchoredPosition = var_11_0
				else
					arg_11_0._workerTf.anchoredPosition = Vector3.New(-290, 30, 0)
				end
			else
				local var_11_1 = arg_11_0._workerTf.parent:InverseTransformPoint(arg_11_0.gifts[arg_11_1].tf.position)

				var_11_1.x = var_11_1.x + 22
				var_11_1.y = var_11_1.y - 50
				arg_11_0._workerTf.anchoredPosition = var_11_1
				arg_11_0._workerTf.localScale = Vector3.New(1, 1, 1)
			end

			return
		end,
		destroy = function(arg_12_0)
			if arg_12_0.delegateGifts and #arg_12_0.delegateGifts > 0 then
				for iter_12_0 = 1, #arg_12_0.delegateGifts do
					ClearEventTrigger(arg_12_0.delegateGifts[iter_12_0])
				end

				arg_12_0.delegateGifts = {}
			end

			PoolMgr.GetInstance():ReturnSpineChar(arg_12_0.wokerSpine.name, arg_12_0.wokerSpine.model)

			return
		end
	})

	return {
		Ctor = function(arg_2_0)
			arg_2_0._giftTf = arg_1_0
			arg_2_0._event = arg_1_2
			arg_2_0._workerTf = arg_1_1

			PoolMgr.GetInstance():GetSpineChar("jiu-work", true, function(arg_3_0)
				arg_3_0.transform.localScale = Vector3.one
				arg_3_0.transform.localPosition = Vector3.zero

				arg_3_0.transform:SetParent(arg_2_0._workerTf, false)

				arg_2_0.wokerSpine = {
					model = arg_3_0,
					anim = arg_3_0:GetComponent(typeof(SpineAnimUI)),
					name = var_0
				}

				arg_2_0:changeWorkerAction(var_0_20, 0, nil)

				return
			end)

			arg_2_0.selectedGifts = {}
			arg_2_0.gifts = {}
			arg_2_0.delegateGifts = {}

			for iter_2_0 = 1, #var_0_13 do
				local var_2_0 = iter_2_0
				local var_2_1 = findTF(arg_2_0._giftTf, var_0_13[iter_2_0])

				table.insert(arg_2_0.gifts, {
					tf = var_2_1,
					index = iter_2_0
				})

				local var_2_2 = GetOrAddComponent(var_2_1, "EventTriggerListener")

				var_2_2:AddPointDownFunc(function(arg_4_0, arg_4_1)
					arg_2_0:selectGift(var_2_0)

					return
				end)
				table.insert(arg_2_0.delegateGifts, var_2_2)
			end

			arg_2_0:updateSelected()

			return
		end,
		changeWorkerAction = function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
			arg_5_0.wokerSpine.anim:SetActionCallBack(nil)
			arg_5_0.wokerSpine.anim:SetAction(arg_5_1, 0)
			arg_5_0.wokerSpine.anim:SetActionCallBack(function(arg_6_0)
				if arg_6_0 == "finish" then
					if arg_5_2 == 1 then
						arg_5_0.wokerSpine.anim:SetActionCallBack(nil)
						arg_5_0.wokerSpine.anim:SetAction(var_0_20, 0)
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
			if table.contains(var_0_14, arg_7_1) then
				for iter_7_0 = #arg_7_0.selectedGifts, 1, -1 do
					if table.contains(var_0_14, arg_7_0.selectedGifts[iter_7_0]) and arg_7_0.selectedGifts[iter_7_0] ~= arg_7_1 then
						table.remove(arg_7_0.selectedGifts, iter_7_0)
					end
				end
			elseif #arg_7_0.selectedGifts == 2 and not table.contains(arg_7_0.selectedGifts, arg_7_1) then
				local var_7_0 = false

				for iter_7_1 = 1, #arg_7_0.selectedGifts do
					if table.contains(var_0_14, arg_7_0.selectedGifts[iter_7_1]) then
						var_7_0 = true

						break
					end
				end

				if not var_7_0 then
					table.remove(arg_7_0.selectedGifts, 1)
				end
			end

			local var_7_1 = 0

			for iter_7_2 = 1, #arg_7_0.selectedGifts do
				if arg_7_0.selectedGifts[iter_7_2] == arg_7_1 then
					var_7_1 = iter_7_2
				end
			end

			if var_7_1 == 0 then
				table.insert(arg_7_0.selectedGifts, arg_7_1)
				arg_7_0:moveJiujiu(arg_7_1)
				arg_7_0:changeWorkerAction(var_0_21, 1)
			else
				table.remove(arg_7_0.selectedGifts, var_7_1)
			end

			if #arg_7_0.selectedGifts >= var_0_16 then
				arg_7_0._event:emit(var_0_11, Clone(arg_7_0.selectedGifts), function(arg_8_0, arg_8_1)
					if not arg_8_0 then
						arg_7_0:changeWorkerAction(var_0_22, 1)
					else
						arg_7_0:changeWorkerAction(var_0_20, 0, nil)
					end

					arg_7_0:moveJiujiu(-1, arg_8_1)

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
				if table.contains(arg_10_0.selectedGifts, arg_10_0.gifts[iter_10_0].index) then
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(arg_11_0, arg_11_1, arg_11_2)
			if arg_11_1 == -1 then
				arg_11_0._workerTf.localScale = Vector3.New(-1, 1, 1)

				if arg_11_2 and arg_11_2 > 0 then
					local var_11_0 = Clone(var_0_32[arg_11_2])

					var_11_0.x = -100
					arg_11_0._workerTf.anchoredPosition = var_11_0
				else
					arg_11_0._workerTf.anchoredPosition = Vector3.New(-290, 30, 0)
				end
			else
				local var_11_1 = arg_11_0._workerTf.parent:InverseTransformPoint(arg_11_0.gifts[arg_11_1].tf.position)

				var_11_1.x = var_11_1.x + 22
				var_11_1.y = var_11_1.y - 50
				arg_11_0._workerTf.anchoredPosition = var_11_1
				arg_11_0._workerTf.localScale = Vector3.New(1, 1, 1)
			end

			return
		end,
		destroy = function(arg_12_0)
			if arg_12_0.delegateGifts and #arg_12_0.delegateGifts > 0 then
				for iter_12_0 = 1, #arg_12_0.delegateGifts do
					ClearEventTrigger(arg_12_0.delegateGifts[iter_12_0])
				end

				arg_12_0.delegateGifts = {}
			end

			PoolMgr.GetInstance():ReturnSpineChar(arg_12_0.wokerSpine.name, arg_12_0.wokerSpine.model)

			return
		end
	}
end

local function var_0_40(arg_13_0, arg_13_1, arg_13_2)
	({
		Ctor = function(arg_14_0)
			arg_14_0._groupTf = arg_13_0
			arg_14_0._groupIndex = arg_13_1
			arg_14_0._groupTf.anchoredPosition = var_0_32[arg_13_1]
			arg_14_0._event = arg_13_2
			arg_14_0.modelData = {}

			SetActive(arg_14_0._groupTf, true)

			arg_14_0.fans = {}
			arg_14_0.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			if arg_15_0.modelData.model then
				PoolMgr.GetInstance():ReturnSpineChar(arg_15_0.modelData.id, arg_15_0.modelData.model)
			end

			local var_15_0 = Ship.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			})

			PoolMgr.GetInstance():GetSpineChar(var_15_0:getPrefab(), true, function(arg_16_0)
				arg_16_0.transform.localScale = Vector3.one
				arg_16_0.transform.localPosition = Vector3.zero

				arg_16_0.transform:SetParent(findTF(arg_15_0._groupTf, "idolPos"), false)

				arg_15_0.modelData = {
					model = arg_16_0,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = arg_16_0:GetComponent(typeof(SpineAnimUI))
				}

				arg_15_0:changeCharAction(var_0_19, 0, nil)

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

			arg_18_0.modelData.anim:SetActionCallBack(nil)
			arg_18_0.modelData.anim:SetAction(arg_18_1, 0)
			arg_18_0.modelData.anim:SetActionCallBack(function(arg_19_0)
				if arg_19_0 == "finish" then
					if arg_18_2 == 1 then
						arg_18_0.modelData.anim:SetActionCallBack(nil)
						arg_18_0.modelData.anim:SetAction(var_0_19, 0)
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
			SetActive(arg_20_1, true)
			SetParent(arg_20_1, findTF(arg_20_0._groupTf, "fansPos"))

			if #arg_20_0.fans > 0 then
				arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x = arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x + var_0_33 + math.random() * 200 + 22
				arg_20_1.anchoredPosition = Vector3.New(arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x, arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.y, arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.z)
			else
				arg_20_1.anchoredPosition = Vector3.New((#arg_20_0.fans + 1) * var_0_33 + 200, 0, 0)
			end

			setActive(findTF(arg_20_1, "wanted"), false)
			table.insert(arg_20_0.fans, {
				tf = arg_20_1,
				speed = math.random() * 50 + 200
			})

			local var_20_0 = arg_20_0.fans[#arg_20_0.fans]

			PoolMgr.GetInstance():GetSpineChar("jiu-fan" .. math.random(1, 4), true, function(arg_21_0)
				arg_21_0.transform.localScale = Vector3.one
				arg_21_0.transform.localPosition = Vector3.zero

				arg_21_0.transform:SetParent(findTF(var_20_0.tf, "spinePos"), false)

				var_20_0.modelData = {
					model = arg_21_0,
					anim = arg_21_0:GetComponent(typeof(SpineAnimUI)),
					modelName = var_0
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

			arg_22_1.modelData.anim:SetActionCallBack(nil)
			arg_22_1.modelData.anim:SetAction(arg_22_2, 0)
			arg_22_1.modelData.anim:SetActionCallBack(function(arg_23_0)
				if arg_23_0 == "finish" then
					if arg_22_3 == 1 then
						arg_22_1.modelData.anim:SetActionCallBack(nil)
						arg_22_1.modelData.anim:SetAction(var_0_26, 0)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_25_0.fans[iter_25_0].modelData.modelName, arg_25_0.fans[iter_25_0].modelData.model)
				Destroy(arg_25_0.fans[iter_25_0].tf)
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
				if arg_27_0.fans[iter_27_0].tf.anchoredPosition.x > (iter_27_0 - 1) * var_0_33 then
					arg_27_0.fans[iter_27_0].tf.anchoredPosition.x = arg_27_0.fans[iter_27_0].tf.anchoredPosition.x - arg_27_0.fans[iter_27_0].speed * Time.deltaTime
					arg_27_0.fans[iter_27_0].tf.anchoredPosition = arg_27_0.fans[iter_27_0].tf.anchoredPosition

					arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_27, 0, nil)
				elseif iter_27_0 == 1 and not arg_27_0.fans[iter_27_0].leave then
					if arg_27_0.fans[iter_27_0].gifts == nil then
						arg_27_0.fans[iter_27_0].gifts = arg_27_0:createWantedGifts()
						arg_27_0.fans[iter_27_0].time = arg_27_1 + var_0_5

						setImageSprite(findTF(arg_27_0.fans[iter_27_0].tf, "score/pack"), (LoadSprite("ui/minigameui/idolmasterui_atlas", "pack" .. arg_27_0.fans[iter_27_0].gifts[1])))
						arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_25, 0, nil)
						arg_27_0:changeCharAction(var_0_18, 1, function()
							arg_27_0:changeCharAction(var_0_19, 0, nil)

							return
						end)
					end
				elseif not arg_27_0.fans[iter_27_0].leave then
					arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_26, 0, nil)
				end
			end

			if #arg_27_0.fans > 0 then
				local var_27_1 = arg_27_0.fans[1]

				if arg_27_0.fans[1].time and arg_27_1 > var_27_1.time and not var_27_1.leave then
					var_27_1.leave = true

					arg_27_0:fanLeave(var_27_1, var_0_29, function()
						table.remove(arg_27_0.fans, 1)

						return
					end)
				else
					arg_27_0:showFansWanted(var_27_1)
				end

				var_27_1.tf:SetSiblingIndex(#arg_27_0.fans - 1)
			end

			return
		end,
		showFansWanted = function(arg_30_0, arg_30_1)
			if arg_30_1.leave then
				return
			end

			local var_30_0 = arg_30_1.time

			if not arg_30_1.time then
				return
			end

			local var_30_1 = math.ceil(var_30_0 - arg_30_0.stepTime) < 0 and 0 or var_30_0 - arg_30_0.stepTime
			local var_30_2 = arg_30_1.gifts
			local var_30_3 = var_30_1 <= 5

			setActive(findTF(arg_30_1.tf, "wanted"), true)
			setActive(findTF(arg_30_1.tf, "wanted/bg1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bgTime1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/time1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bg2"), var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bgTime2"), var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/time2"), var_30_3)

			if var_30_1 < 0 then
				var_30_1 = 0
			end

			setText(findTF(arg_30_1.tf, "wanted/time1"), math.abs(math.ceil(var_30_1)) .. "S")
			setText(findTF(arg_30_1.tf, "wanted/time2"), math.abs(math.ceil(var_30_1)) .. "S")

			for iter_30_0 = 1, #var_30_2 do
				setImageSprite(findTF(arg_30_1.tf, "wanted/item" .. iter_30_0), LoadSprite("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_30_2[iter_30_0]), true)
			end

			return
		end,
		checkGifts = function(arg_31_0, arg_31_1)
			local var_31_0 = arg_31_0:getWantedGifts()

			if var_31_0 then
				for iter_31_0 = 1, #arg_31_1 do
					if not table.contains(var_31_0, arg_31_1[iter_31_0]) then
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
				arg_33_0.fans[1].leave = true

				arg_33_0:fanLeave(arg_33_0.fans[1], var_0_30, function()
					table.remove(arg_33_0.fans, 1)

					return
				end)
				arg_33_0:changeCharAction(var_0_17, 1, function()
					arg_33_0:changeCharAction(var_0_19, 0, nil)

					return
				end)
			end

			return
		end,
		createWantedGifts = function(arg_36_0)
			local var_36_0 = Clone(var_0_15)

			table.insert({}, var_0_14[math.random(1, #var_0_14)])

			for iter_36_0 = 1, 2 do
				table.insert({}, (table.remove(var_36_0, math.random(1, #var_36_0))))
			end

			return {}
		end,
		fanLeave = function(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
			setActive(findTF(arg_37_1.tf, "wanted"), false)

			local var_37_0

			if var_0_29 == arg_37_2 then
				var_37_0 = var_0_24
			elseif var_0_30 then
				var_37_0 = var_0_23

				setText(findTF(arg_37_1.tf, "score"), "+" .. var_0_4)
				setActive(findTF(arg_37_1.tf, "score"), true)
			end

			arg_37_0:changeFansAction(arg_37_1, var_37_0, 1, function()
				PoolMgr.GetInstance():ReturnSpineChar(arg_37_1.modelData.modelName, arg_37_1.modelData.model)
				arg_37_0._event:emit(var_0_12, arg_37_2)
				Destroy(arg_37_1.tf)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_40_0.modelData.id, arg_40_0.modelData.model)
			end

			return
		end
	}).Ctor({
		Ctor = function(arg_14_0)
			arg_14_0._groupTf = arg_13_0
			arg_14_0._groupIndex = arg_13_1
			arg_14_0._groupTf.anchoredPosition = var_0_32[arg_13_1]
			arg_14_0._event = arg_13_2
			arg_14_0.modelData = {}

			SetActive(arg_14_0._groupTf, true)

			arg_14_0.fans = {}
			arg_14_0.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			if arg_15_0.modelData.model then
				PoolMgr.GetInstance():ReturnSpineChar(arg_15_0.modelData.id, arg_15_0.modelData.model)
			end

			local var_15_0 = Ship.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			})

			PoolMgr.GetInstance():GetSpineChar(var_15_0:getPrefab(), true, function(arg_16_0)
				arg_16_0.transform.localScale = Vector3.one
				arg_16_0.transform.localPosition = Vector3.zero

				arg_16_0.transform:SetParent(findTF(arg_15_0._groupTf, "idolPos"), false)

				arg_15_0.modelData = {
					model = arg_16_0,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = arg_16_0:GetComponent(typeof(SpineAnimUI))
				}

				arg_15_0:changeCharAction(var_0_19, 0, nil)

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

			arg_18_0.modelData.anim:SetActionCallBack(nil)
			arg_18_0.modelData.anim:SetAction(arg_18_1, 0)
			arg_18_0.modelData.anim:SetActionCallBack(function(arg_19_0)
				if arg_19_0 == "finish" then
					if arg_18_2 == 1 then
						arg_18_0.modelData.anim:SetActionCallBack(nil)
						arg_18_0.modelData.anim:SetAction(var_0_19, 0)
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
			SetActive(arg_20_1, true)
			SetParent(arg_20_1, findTF(arg_20_0._groupTf, "fansPos"))

			if #arg_20_0.fans > 0 then
				arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x = arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x + var_0_33 + math.random() * 200 + 22
				arg_20_1.anchoredPosition = Vector3.New(arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x, arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.y, arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.z)
			else
				arg_20_1.anchoredPosition = Vector3.New((#arg_20_0.fans + 1) * var_0_33 + 200, 0, 0)
			end

			setActive(findTF(arg_20_1, "wanted"), false)
			table.insert(arg_20_0.fans, {
				tf = arg_20_1,
				speed = math.random() * 50 + 200
			})

			local var_20_0 = arg_20_0.fans[#arg_20_0.fans]

			PoolMgr.GetInstance():GetSpineChar("jiu-fan" .. math.random(1, 4), true, function(arg_21_0)
				arg_21_0.transform.localScale = Vector3.one
				arg_21_0.transform.localPosition = Vector3.zero

				arg_21_0.transform:SetParent(findTF(var_20_0.tf, "spinePos"), false)

				var_20_0.modelData = {
					model = arg_21_0,
					anim = arg_21_0:GetComponent(typeof(SpineAnimUI)),
					modelName = var_0
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

			arg_22_1.modelData.anim:SetActionCallBack(nil)
			arg_22_1.modelData.anim:SetAction(arg_22_2, 0)
			arg_22_1.modelData.anim:SetActionCallBack(function(arg_23_0)
				if arg_23_0 == "finish" then
					if arg_22_3 == 1 then
						arg_22_1.modelData.anim:SetActionCallBack(nil)
						arg_22_1.modelData.anim:SetAction(var_0_26, 0)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_25_0.fans[iter_25_0].modelData.modelName, arg_25_0.fans[iter_25_0].modelData.model)
				Destroy(arg_25_0.fans[iter_25_0].tf)
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
				if arg_27_0.fans[iter_27_0].tf.anchoredPosition.x > (iter_27_0 - 1) * var_0_33 then
					arg_27_0.fans[iter_27_0].tf.anchoredPosition.x = arg_27_0.fans[iter_27_0].tf.anchoredPosition.x - arg_27_0.fans[iter_27_0].speed * Time.deltaTime
					arg_27_0.fans[iter_27_0].tf.anchoredPosition = arg_27_0.fans[iter_27_0].tf.anchoredPosition

					arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_27, 0, nil)
				elseif iter_27_0 == 1 and not arg_27_0.fans[iter_27_0].leave then
					if arg_27_0.fans[iter_27_0].gifts == nil then
						arg_27_0.fans[iter_27_0].gifts = arg_27_0:createWantedGifts()
						arg_27_0.fans[iter_27_0].time = arg_27_1 + var_0_5

						setImageSprite(findTF(arg_27_0.fans[iter_27_0].tf, "score/pack"), (LoadSprite("ui/minigameui/idolmasterui_atlas", "pack" .. arg_27_0.fans[iter_27_0].gifts[1])))
						arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_25, 0, nil)
						arg_27_0:changeCharAction(var_0_18, 1, function()
							arg_27_0:changeCharAction(var_0_19, 0, nil)

							return
						end)
					end
				elseif not arg_27_0.fans[iter_27_0].leave then
					arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_26, 0, nil)
				end
			end

			if #arg_27_0.fans > 0 then
				local var_27_1 = arg_27_0.fans[1]

				if arg_27_0.fans[1].time and arg_27_1 > var_27_1.time and not var_27_1.leave then
					var_27_1.leave = true

					arg_27_0:fanLeave(var_27_1, var_0_29, function()
						table.remove(arg_27_0.fans, 1)

						return
					end)
				else
					arg_27_0:showFansWanted(var_27_1)
				end

				var_27_1.tf:SetSiblingIndex(#arg_27_0.fans - 1)
			end

			return
		end,
		showFansWanted = function(arg_30_0, arg_30_1)
			if arg_30_1.leave then
				return
			end

			local var_30_0 = arg_30_1.time

			if not arg_30_1.time then
				return
			end

			local var_30_1 = math.ceil(var_30_0 - arg_30_0.stepTime) < 0 and 0 or var_30_0 - arg_30_0.stepTime
			local var_30_2 = arg_30_1.gifts
			local var_30_3 = var_30_1 <= 5

			setActive(findTF(arg_30_1.tf, "wanted"), true)
			setActive(findTF(arg_30_1.tf, "wanted/bg1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bgTime1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/time1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bg2"), var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bgTime2"), var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/time2"), var_30_3)

			if var_30_1 < 0 then
				var_30_1 = 0
			end

			setText(findTF(arg_30_1.tf, "wanted/time1"), math.abs(math.ceil(var_30_1)) .. "S")
			setText(findTF(arg_30_1.tf, "wanted/time2"), math.abs(math.ceil(var_30_1)) .. "S")

			for iter_30_0 = 1, #var_30_2 do
				setImageSprite(findTF(arg_30_1.tf, "wanted/item" .. iter_30_0), LoadSprite("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_30_2[iter_30_0]), true)
			end

			return
		end,
		checkGifts = function(arg_31_0, arg_31_1)
			local var_31_0 = arg_31_0:getWantedGifts()

			if var_31_0 then
				for iter_31_0 = 1, #arg_31_1 do
					if not table.contains(var_31_0, arg_31_1[iter_31_0]) then
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
				arg_33_0.fans[1].leave = true

				arg_33_0:fanLeave(arg_33_0.fans[1], var_0_30, function()
					table.remove(arg_33_0.fans, 1)

					return
				end)
				arg_33_0:changeCharAction(var_0_17, 1, function()
					arg_33_0:changeCharAction(var_0_19, 0, nil)

					return
				end)
			end

			return
		end,
		createWantedGifts = function(arg_36_0)
			local var_36_0 = Clone(var_0_15)

			table.insert({}, var_0_14[math.random(1, #var_0_14)])

			for iter_36_0 = 1, 2 do
				table.insert({}, (table.remove(var_36_0, math.random(1, #var_36_0))))
			end

			return {}
		end,
		fanLeave = function(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
			setActive(findTF(arg_37_1.tf, "wanted"), false)

			local var_37_0

			if var_0_29 == arg_37_2 then
				var_37_0 = var_0_24
			elseif var_0_30 then
				var_37_0 = var_0_23

				setText(findTF(arg_37_1.tf, "score"), "+" .. var_0_4)
				setActive(findTF(arg_37_1.tf, "score"), true)
			end

			arg_37_0:changeFansAction(arg_37_1, var_37_0, 1, function()
				PoolMgr.GetInstance():ReturnSpineChar(arg_37_1.modelData.modelName, arg_37_1.modelData.model)
				arg_37_0._event:emit(var_0_12, arg_37_2)
				Destroy(arg_37_1.tf)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_40_0.modelData.id, arg_40_0.modelData.model)
			end

			return
		end
	})

	return {
		Ctor = function(arg_14_0)
			arg_14_0._groupTf = arg_13_0
			arg_14_0._groupIndex = arg_13_1
			arg_14_0._groupTf.anchoredPosition = var_0_32[arg_13_1]
			arg_14_0._event = arg_13_2
			arg_14_0.modelData = {}

			SetActive(arg_14_0._groupTf, true)

			arg_14_0.fans = {}
			arg_14_0.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			if arg_15_0.modelData.model then
				PoolMgr.GetInstance():ReturnSpineChar(arg_15_0.modelData.id, arg_15_0.modelData.model)
			end

			local var_15_0 = Ship.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			})

			PoolMgr.GetInstance():GetSpineChar(var_15_0:getPrefab(), true, function(arg_16_0)
				arg_16_0.transform.localScale = Vector3.one
				arg_16_0.transform.localPosition = Vector3.zero

				arg_16_0.transform:SetParent(findTF(arg_15_0._groupTf, "idolPos"), false)

				arg_15_0.modelData = {
					model = arg_16_0,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = arg_16_0:GetComponent(typeof(SpineAnimUI))
				}

				arg_15_0:changeCharAction(var_0_19, 0, nil)

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

			arg_18_0.modelData.anim:SetActionCallBack(nil)
			arg_18_0.modelData.anim:SetAction(arg_18_1, 0)
			arg_18_0.modelData.anim:SetActionCallBack(function(arg_19_0)
				if arg_19_0 == "finish" then
					if arg_18_2 == 1 then
						arg_18_0.modelData.anim:SetActionCallBack(nil)
						arg_18_0.modelData.anim:SetAction(var_0_19, 0)
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
			SetActive(arg_20_1, true)
			SetParent(arg_20_1, findTF(arg_20_0._groupTf, "fansPos"))

			if #arg_20_0.fans > 0 then
				arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x = arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x + var_0_33 + math.random() * 200 + 22
				arg_20_1.anchoredPosition = Vector3.New(arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.x, arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.y, arg_20_0.fans[#arg_20_0.fans].tf.anchoredPosition.z)
			else
				arg_20_1.anchoredPosition = Vector3.New((#arg_20_0.fans + 1) * var_0_33 + 200, 0, 0)
			end

			setActive(findTF(arg_20_1, "wanted"), false)
			table.insert(arg_20_0.fans, {
				tf = arg_20_1,
				speed = math.random() * 50 + 200
			})

			local var_20_0 = arg_20_0.fans[#arg_20_0.fans]

			PoolMgr.GetInstance():GetSpineChar("jiu-fan" .. math.random(1, 4), true, function(arg_21_0)
				arg_21_0.transform.localScale = Vector3.one
				arg_21_0.transform.localPosition = Vector3.zero

				arg_21_0.transform:SetParent(findTF(var_20_0.tf, "spinePos"), false)

				var_20_0.modelData = {
					model = arg_21_0,
					anim = arg_21_0:GetComponent(typeof(SpineAnimUI)),
					modelName = var_0
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

			arg_22_1.modelData.anim:SetActionCallBack(nil)
			arg_22_1.modelData.anim:SetAction(arg_22_2, 0)
			arg_22_1.modelData.anim:SetActionCallBack(function(arg_23_0)
				if arg_23_0 == "finish" then
					if arg_22_3 == 1 then
						arg_22_1.modelData.anim:SetActionCallBack(nil)
						arg_22_1.modelData.anim:SetAction(var_0_26, 0)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_25_0.fans[iter_25_0].modelData.modelName, arg_25_0.fans[iter_25_0].modelData.model)
				Destroy(arg_25_0.fans[iter_25_0].tf)
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
				if arg_27_0.fans[iter_27_0].tf.anchoredPosition.x > (iter_27_0 - 1) * var_0_33 then
					arg_27_0.fans[iter_27_0].tf.anchoredPosition.x = arg_27_0.fans[iter_27_0].tf.anchoredPosition.x - arg_27_0.fans[iter_27_0].speed * Time.deltaTime
					arg_27_0.fans[iter_27_0].tf.anchoredPosition = arg_27_0.fans[iter_27_0].tf.anchoredPosition

					arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_27, 0, nil)
				elseif iter_27_0 == 1 and not arg_27_0.fans[iter_27_0].leave then
					if arg_27_0.fans[iter_27_0].gifts == nil then
						arg_27_0.fans[iter_27_0].gifts = arg_27_0:createWantedGifts()
						arg_27_0.fans[iter_27_0].time = arg_27_1 + var_0_5

						setImageSprite(findTF(arg_27_0.fans[iter_27_0].tf, "score/pack"), (LoadSprite("ui/minigameui/idolmasterui_atlas", "pack" .. arg_27_0.fans[iter_27_0].gifts[1])))
						arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_25, 0, nil)
						arg_27_0:changeCharAction(var_0_18, 1, function()
							arg_27_0:changeCharAction(var_0_19, 0, nil)

							return
						end)
					end
				elseif not arg_27_0.fans[iter_27_0].leave then
					arg_27_0:changeFansAction(arg_27_0.fans[iter_27_0], var_0_26, 0, nil)
				end
			end

			if #arg_27_0.fans > 0 then
				local var_27_1 = arg_27_0.fans[1]

				if arg_27_0.fans[1].time and arg_27_1 > var_27_1.time and not var_27_1.leave then
					var_27_1.leave = true

					arg_27_0:fanLeave(var_27_1, var_0_29, function()
						table.remove(arg_27_0.fans, 1)

						return
					end)
				else
					arg_27_0:showFansWanted(var_27_1)
				end

				var_27_1.tf:SetSiblingIndex(#arg_27_0.fans - 1)
			end

			return
		end,
		showFansWanted = function(arg_30_0, arg_30_1)
			if arg_30_1.leave then
				return
			end

			local var_30_0 = arg_30_1.time

			if not arg_30_1.time then
				return
			end

			local var_30_1 = math.ceil(var_30_0 - arg_30_0.stepTime) < 0 and 0 or var_30_0 - arg_30_0.stepTime
			local var_30_2 = arg_30_1.gifts
			local var_30_3 = var_30_1 <= 5

			setActive(findTF(arg_30_1.tf, "wanted"), true)
			setActive(findTF(arg_30_1.tf, "wanted/bg1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bgTime1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/time1"), not var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bg2"), var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/bgTime2"), var_30_3)
			setActive(findTF(arg_30_1.tf, "wanted/time2"), var_30_3)

			if var_30_1 < 0 then
				var_30_1 = 0
			end

			setText(findTF(arg_30_1.tf, "wanted/time1"), math.abs(math.ceil(var_30_1)) .. "S")
			setText(findTF(arg_30_1.tf, "wanted/time2"), math.abs(math.ceil(var_30_1)) .. "S")

			for iter_30_0 = 1, #var_30_2 do
				setImageSprite(findTF(arg_30_1.tf, "wanted/item" .. iter_30_0), LoadSprite("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_30_2[iter_30_0]), true)
			end

			return
		end,
		checkGifts = function(arg_31_0, arg_31_1)
			local var_31_0 = arg_31_0:getWantedGifts()

			if var_31_0 then
				for iter_31_0 = 1, #arg_31_1 do
					if not table.contains(var_31_0, arg_31_1[iter_31_0]) then
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
				arg_33_0.fans[1].leave = true

				arg_33_0:fanLeave(arg_33_0.fans[1], var_0_30, function()
					table.remove(arg_33_0.fans, 1)

					return
				end)
				arg_33_0:changeCharAction(var_0_17, 1, function()
					arg_33_0:changeCharAction(var_0_19, 0, nil)

					return
				end)
			end

			return
		end,
		createWantedGifts = function(arg_36_0)
			local var_36_0 = Clone(var_0_15)

			table.insert({}, var_0_14[math.random(1, #var_0_14)])

			for iter_36_0 = 1, 2 do
				table.insert({}, (table.remove(var_36_0, math.random(1, #var_36_0))))
			end

			return {}
		end,
		fanLeave = function(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
			setActive(findTF(arg_37_1.tf, "wanted"), false)

			local var_37_0

			if var_0_29 == arg_37_2 then
				var_37_0 = var_0_24
			elseif var_0_30 then
				var_37_0 = var_0_23

				setText(findTF(arg_37_1.tf, "score"), "+" .. var_0_4)
				setActive(findTF(arg_37_1.tf, "score"), true)
			end

			arg_37_0:changeFansAction(arg_37_1, var_37_0, 1, function()
				PoolMgr.GetInstance():ReturnSpineChar(arg_37_1.modelData.modelName, arg_37_1.modelData.model)
				arg_37_0._event:emit(var_0_12, arg_37_2)
				Destroy(arg_37_1.tf)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_40_0.modelData.id, arg_40_0.modelData.model)
			end

			return
		end
	}
end

local function var_0_41(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	({
		Ctor = function(arg_42_0)
			arg_42_0._containerTf = arg_41_0
			arg_42_0._tplGroup = arg_41_1
			arg_42_0._tplIdol = arg_41_2
			arg_42_0._tplFans = arg_41_3
			arg_42_0._event = arg_41_4
			arg_42_0.groups = {}

			for iter_42_0 = 1, var_0_31 do
				local var_42_0 = tf(Instantiate(arg_42_0._tplGroup))

				SetParent(var_42_0, arg_42_0._containerTf)
				table.insert(arg_42_0.groups, (var_0_40(var_42_0, iter_42_0, arg_42_0._event)))
			end

			return
		end,
		createIdols = function(arg_43_0)
			local var_43_0 = arg_43_0:getRandomIdols()

			for iter_43_0 = 1, #arg_43_0.groups do
				arg_43_0.groups[iter_43_0]:createIdol(var_43_0[iter_43_0][1], var_43_0[iter_43_0][2])
			end

			return
		end,
		receiveGift = function(arg_44_0, arg_44_1, arg_44_2)
			local var_44_0 = false
			local var_44_1
			local var_44_2

			for iter_44_0 = 1, #arg_44_0.groups do
				if arg_44_0.groups[iter_44_0]:checkGifts(arg_44_1) then
					var_44_0 = true

					if not var_44_1 then
						var_44_1 = arg_44_0.groups[iter_44_0]
						var_44_2 = iter_44_0
					elseif var_44_1:getGiftTime() > arg_44_0.groups[iter_44_0]:getGiftTime() then
						var_44_1 = arg_44_0.groups[iter_44_0]
						var_44_2 = iter_44_0
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
			local var_45_1 = Clone(var_0_9)

			if math.random() > 0.6 then
				var_45_0 = Clone(var_0_10)
			end

			for iter_45_0 = #var_45_0 + 1, var_0_31 do
				table.insert(var_45_0, table.remove(var_45_1, math.random(1, #var_45_1)))
			end

			for iter_45_1 = 1, var_0_31 do
				table.insert({}, table.remove(var_45_0, math.random(1, #var_45_0)))
			end

			return {}
		end,
		getApearTime = function(arg_46_0)
			if arg_46_0.lastTime and arg_46_0.lastTime > 0 then
				for iter_46_0 = 1, #var_0_6 do
					if arg_46_0.lastTime < var_0_6[iter_46_0][1] then
						return var_0_6[iter_46_0][2]
					end
				end
			end

			return var_0_6[#var_0_6][2]
		end,
		getFansAmount = function(arg_47_0)
			local var_47_0 = 0

			for iter_47_0 = 1, #arg_47_0.groups do
				var_47_0 = var_47_0 + arg_47_0.groups[iter_47_0]:getFansAmount()
			end

			return var_47_0
		end,
		start = function(arg_48_0)
			arg_48_0:reset()

			arg_48_0.createFansTime = nil
			arg_48_0.lastTime = var_0_3

			for iter_48_0 = 1, 3 do
				arg_48_0.groups[math.random(1, #arg_48_0.groups)]:createFans(tf(instantiate(arg_48_0._tplFans)))
			end

			for iter_48_1 = 1, #arg_48_0.groups do
				arg_48_0.groups[iter_48_1]:start()
			end

			return
		end,
		step = function(arg_49_0, arg_49_1)
			arg_49_0.lastTime = arg_49_0.lastTime - Time.deltaTime

			if not arg_49_0.createFansTime then
				arg_49_0.createFansTime = arg_49_1 + arg_49_0:getApearTime() + math.random() * 1
			elseif arg_49_1 > arg_49_0.createFansTime and arg_49_0:getFansAmount() <= 10 then
				arg_49_0.groups[math.random(1, #arg_49_0.groups)]:createFans(tf(instantiate(arg_49_0._tplFans)))

				arg_49_0.createFansTime = arg_49_1 + arg_49_0:getApearTime() + math.random() * 1
			end

			for iter_49_0 = 1, #arg_49_0.groups do
				arg_49_0.groups[iter_49_0]:step(arg_49_1)
			end

			return
		end,
		reset = function(arg_50_0)
			for iter_50_0 = 1, #arg_50_0.groups do
				arg_50_0.groups[iter_50_0]:reset()
			end

			return
		end,
		destroy = function(arg_51_0)
			for iter_51_0 = 1, #arg_51_0.groups do
				arg_51_0.groups[iter_51_0]:destroy()
			end

			return
		end
	}).Ctor({
		Ctor = function(arg_42_0)
			arg_42_0._containerTf = arg_41_0
			arg_42_0._tplGroup = arg_41_1
			arg_42_0._tplIdol = arg_41_2
			arg_42_0._tplFans = arg_41_3
			arg_42_0._event = arg_41_4
			arg_42_0.groups = {}

			for iter_42_0 = 1, var_0_31 do
				local var_42_0 = tf(Instantiate(arg_42_0._tplGroup))

				SetParent(var_42_0, arg_42_0._containerTf)
				table.insert(arg_42_0.groups, (var_0_40(var_42_0, iter_42_0, arg_42_0._event)))
			end

			return
		end,
		createIdols = function(arg_43_0)
			local var_43_0 = arg_43_0:getRandomIdols()

			for iter_43_0 = 1, #arg_43_0.groups do
				arg_43_0.groups[iter_43_0]:createIdol(var_43_0[iter_43_0][1], var_43_0[iter_43_0][2])
			end

			return
		end,
		receiveGift = function(arg_44_0, arg_44_1, arg_44_2)
			local var_44_0 = false
			local var_44_1
			local var_44_2

			for iter_44_0 = 1, #arg_44_0.groups do
				if arg_44_0.groups[iter_44_0]:checkGifts(arg_44_1) then
					var_44_0 = true

					if not var_44_1 then
						var_44_1 = arg_44_0.groups[iter_44_0]
						var_44_2 = iter_44_0
					elseif var_44_1:getGiftTime() > arg_44_0.groups[iter_44_0]:getGiftTime() then
						var_44_1 = arg_44_0.groups[iter_44_0]
						var_44_2 = iter_44_0
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
			local var_45_1 = Clone(var_0_9)

			if math.random() > 0.6 then
				var_45_0 = Clone(var_0_10)
			end

			for iter_45_0 = #var_45_0 + 1, var_0_31 do
				table.insert(var_45_0, table.remove(var_45_1, math.random(1, #var_45_1)))
			end

			for iter_45_1 = 1, var_0_31 do
				table.insert({}, table.remove(var_45_0, math.random(1, #var_45_0)))
			end

			return {}
		end,
		getApearTime = function(arg_46_0)
			if arg_46_0.lastTime and arg_46_0.lastTime > 0 then
				for iter_46_0 = 1, #var_0_6 do
					if arg_46_0.lastTime < var_0_6[iter_46_0][1] then
						return var_0_6[iter_46_0][2]
					end
				end
			end

			return var_0_6[#var_0_6][2]
		end,
		getFansAmount = function(arg_47_0)
			local var_47_0 = 0

			for iter_47_0 = 1, #arg_47_0.groups do
				var_47_0 = var_47_0 + arg_47_0.groups[iter_47_0]:getFansAmount()
			end

			return var_47_0
		end,
		start = function(arg_48_0)
			arg_48_0:reset()

			arg_48_0.createFansTime = nil
			arg_48_0.lastTime = var_0_3

			for iter_48_0 = 1, 3 do
				arg_48_0.groups[math.random(1, #arg_48_0.groups)]:createFans(tf(instantiate(arg_48_0._tplFans)))
			end

			for iter_48_1 = 1, #arg_48_0.groups do
				arg_48_0.groups[iter_48_1]:start()
			end

			return
		end,
		step = function(arg_49_0, arg_49_1)
			arg_49_0.lastTime = arg_49_0.lastTime - Time.deltaTime

			if not arg_49_0.createFansTime then
				arg_49_0.createFansTime = arg_49_1 + arg_49_0:getApearTime() + math.random() * 1
			elseif arg_49_1 > arg_49_0.createFansTime and arg_49_0:getFansAmount() <= 10 then
				arg_49_0.groups[math.random(1, #arg_49_0.groups)]:createFans(tf(instantiate(arg_49_0._tplFans)))

				arg_49_0.createFansTime = arg_49_1 + arg_49_0:getApearTime() + math.random() * 1
			end

			for iter_49_0 = 1, #arg_49_0.groups do
				arg_49_0.groups[iter_49_0]:step(arg_49_1)
			end

			return
		end,
		reset = function(arg_50_0)
			for iter_50_0 = 1, #arg_50_0.groups do
				arg_50_0.groups[iter_50_0]:reset()
			end

			return
		end,
		destroy = function(arg_51_0)
			for iter_51_0 = 1, #arg_51_0.groups do
				arg_51_0.groups[iter_51_0]:destroy()
			end

			return
		end
	})

	return {
		Ctor = function(arg_42_0)
			arg_42_0._containerTf = arg_41_0
			arg_42_0._tplGroup = arg_41_1
			arg_42_0._tplIdol = arg_41_2
			arg_42_0._tplFans = arg_41_3
			arg_42_0._event = arg_41_4
			arg_42_0.groups = {}

			for iter_42_0 = 1, var_0_31 do
				local var_42_0 = tf(Instantiate(arg_42_0._tplGroup))

				SetParent(var_42_0, arg_42_0._containerTf)
				table.insert(arg_42_0.groups, (var_0_40(var_42_0, iter_42_0, arg_42_0._event)))
			end

			return
		end,
		createIdols = function(arg_43_0)
			local var_43_0 = arg_43_0:getRandomIdols()

			for iter_43_0 = 1, #arg_43_0.groups do
				arg_43_0.groups[iter_43_0]:createIdol(var_43_0[iter_43_0][1], var_43_0[iter_43_0][2])
			end

			return
		end,
		receiveGift = function(arg_44_0, arg_44_1, arg_44_2)
			local var_44_0 = false
			local var_44_1
			local var_44_2

			for iter_44_0 = 1, #arg_44_0.groups do
				if arg_44_0.groups[iter_44_0]:checkGifts(arg_44_1) then
					var_44_0 = true

					if not var_44_1 then
						var_44_1 = arg_44_0.groups[iter_44_0]
						var_44_2 = iter_44_0
					elseif var_44_1:getGiftTime() > arg_44_0.groups[iter_44_0]:getGiftTime() then
						var_44_1 = arg_44_0.groups[iter_44_0]
						var_44_2 = iter_44_0
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
			local var_45_1 = Clone(var_0_9)

			if math.random() > 0.6 then
				var_45_0 = Clone(var_0_10)
			end

			for iter_45_0 = #var_45_0 + 1, var_0_31 do
				table.insert(var_45_0, table.remove(var_45_1, math.random(1, #var_45_1)))
			end

			for iter_45_1 = 1, var_0_31 do
				table.insert({}, table.remove(var_45_0, math.random(1, #var_45_0)))
			end

			return {}
		end,
		getApearTime = function(arg_46_0)
			if arg_46_0.lastTime and arg_46_0.lastTime > 0 then
				for iter_46_0 = 1, #var_0_6 do
					if arg_46_0.lastTime < var_0_6[iter_46_0][1] then
						return var_0_6[iter_46_0][2]
					end
				end
			end

			return var_0_6[#var_0_6][2]
		end,
		getFansAmount = function(arg_47_0)
			local var_47_0 = 0

			for iter_47_0 = 1, #arg_47_0.groups do
				var_47_0 = var_47_0 + arg_47_0.groups[iter_47_0]:getFansAmount()
			end

			return var_47_0
		end,
		start = function(arg_48_0)
			arg_48_0:reset()

			arg_48_0.createFansTime = nil
			arg_48_0.lastTime = var_0_3

			for iter_48_0 = 1, 3 do
				arg_48_0.groups[math.random(1, #arg_48_0.groups)]:createFans(tf(instantiate(arg_48_0._tplFans)))
			end

			for iter_48_1 = 1, #arg_48_0.groups do
				arg_48_0.groups[iter_48_1]:start()
			end

			return
		end,
		step = function(arg_49_0, arg_49_1)
			arg_49_0.lastTime = arg_49_0.lastTime - Time.deltaTime

			if not arg_49_0.createFansTime then
				arg_49_0.createFansTime = arg_49_1 + arg_49_0:getApearTime() + math.random() * 1
			elseif arg_49_1 > arg_49_0.createFansTime and arg_49_0:getFansAmount() <= 10 then
				arg_49_0.groups[math.random(1, #arg_49_0.groups)]:createFans(tf(instantiate(arg_49_0._tplFans)))

				arg_49_0.createFansTime = arg_49_1 + arg_49_0:getApearTime() + math.random() * 1
			end

			for iter_49_0 = 1, #arg_49_0.groups do
				arg_49_0.groups[iter_49_0]:step(arg_49_1)
			end

			return
		end,
		reset = function(arg_50_0)
			for iter_50_0 = 1, #arg_50_0.groups do
				arg_50_0.groups[iter_50_0]:reset()
			end

			return
		end,
		destroy = function(arg_51_0)
			for iter_51_0 = 1, #arg_51_0.groups do
				arg_51_0.groups[iter_51_0]:destroy()
			end

			return
		end
	}
end

function var_0_0.getUIName(arg_52_0)
	return "IdolMasterGameUI"
end

function var_0_0.getBGM(arg_53_0)
	return var_0_1[math.random(1, #var_0_1)]
end

function var_0_0.didEnter(arg_54_0)
	arg_54_0:initEvent()
	arg_54_0:initData()
	arg_54_0:initUI()
	arg_54_0:initGameUI()
	arg_54_0:initTextTip()
	arg_54_0:updateMenuUI()
	arg_54_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_55_0)
	arg_55_0:bind(var_0_11, function(arg_56_0, arg_56_1, arg_56_2)
		if arg_55_0.idolGroupUI then
			arg_55_0.idolGroupUI:receiveGift(arg_56_1, arg_56_2)
		end

		return
	end)
	arg_55_0:bind(var_0_12, function(arg_57_0, arg_57_1, arg_57_2)
		if arg_55_0.gameStartFlag then
			if arg_57_1 == var_0_29 then
				arg_55_0:loseHeart()
			elseif arg_57_1 == var_0_30 then
				arg_55_0:addScore(100)
			end
		end

		return
	end)

	return
end

function var_0_0.initData(arg_58_0)
	local var_58_0 = Application.targetFrameRate or 60

	arg_58_0.timer = Timer.New(function()
		arg_58_0:onTimer()

		return
	end, 1 / var_58_0, -1)

	return
end

function var_0_0.initUI(arg_60_0)
	arg_60_0.sceneTf = findTF(arg_60_0._tf, "scene")
	arg_60_0.clickMask = findTF(arg_60_0._tf, "clickMask")
	arg_60_0.countUI = findTF(arg_60_0._tf, "pop/CountUI")
	arg_60_0.countAnimator = GetComponent(findTF(arg_60_0.countUI, "count"), typeof(Animator))
	arg_60_0.countDft = GetComponent(findTF(arg_60_0.countUI, "count"), typeof(DftAniEvent))

	arg_60_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_60_0.countDft:SetEndEvent(function()
		setActive(arg_60_0.countUI, false)
		arg_60_0:gameStart()

		return
	end)

	arg_60_0.leaveUI = findTF(arg_60_0._tf, "pop/LeaveUI")

	onButton(arg_60_0, findTF(arg_60_0.leaveUI, "ad/btnOk"), function()
		arg_60_0:resumeGame()
		arg_60_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_60_0, findTF(arg_60_0.leaveUI, "ad/btnCancel"), function()
		arg_60_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_60_0.pauseUI = findTF(arg_60_0._tf, "pop/pauseUI")

	onButton(arg_60_0, findTF(arg_60_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_60_0.pauseUI, false)
		arg_60_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_60_0.settlementUI = findTF(arg_60_0._tf, "pop/SettleMentUI")

	onButton(arg_60_0, findTF(arg_60_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_60_0.settlementUI, false)
		arg_60_0:openMenuUI()

		return
	end, SFX_CANCEL)

	arg_60_0.menuUI = findTF(arg_60_0._tf, "pop/menuUI")
	arg_60_0.battleScrollRect = GetComponent(findTF(arg_60_0.menuUI, "battList"), typeof(ScrollRect))
	arg_60_0.totalTimes = arg_60_0:getGameTotalTime()

	scrollTo(arg_60_0.battleScrollRect, 0, 1 - (arg_60_0:getGameUsedTimes() - 4 < 0 and 0 or arg_60_0:getGameUsedTimes() - 4) / (arg_60_0.totalTimes - 4))
	onButton(arg_60_0, findTF(arg_60_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_67_0 = arg_60_0.battleScrollRect.normalizedPosition.y + 1 / (arg_60_0.totalTimes - 4)

		if arg_60_0.battleScrollRect.normalizedPosition.y + 1 / (arg_60_0.totalTimes - 4) > 1 then
			var_67_0 = 1
		end

		scrollTo(arg_60_0.battleScrollRect, 0, var_67_0)

		return
	end, SFX_CANCEL)
	onButton(arg_60_0, findTF(arg_60_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_68_0 = arg_60_0.battleScrollRect.normalizedPosition.y - 1 / (arg_60_0.totalTimes - 4)

		if arg_60_0.battleScrollRect.normalizedPosition.y - 1 / (arg_60_0.totalTimes - 4) < 0 then
			var_68_0 = 0
		end

		scrollTo(arg_60_0.battleScrollRect, 0, var_68_0)

		return
	end, SFX_CANCEL)
	onButton(arg_60_0, findTF(arg_60_0.menuUI, "btnBack"), function()
		arg_60_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_60_0, findTF(arg_60_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.handshake_game_help.tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_60_0, findTF(arg_60_0.menuUI, "btnStart"), function()
		if arg_60_0:getGameUsedTimes() == 0 and not var_0_8 then
			var_0_8 = true

			setActive(arg_60_0.helpUI, true)
		else
			setActive(arg_60_0.menuUI, false)
			arg_60_0:readyStart()
		end

		return
	end, SFX_CANCEL)

	local var_60_0 = findTF(arg_60_0.menuUI, "tplBattleItem")

	arg_60_0.battleItems = {}

	for iter_60_0 = 1, arg_60_0.totalTimes do
		local var_60_1 = tf(instantiate(var_60_0))

		var_60_1.name = "battleItem_" .. iter_60_0

		setParent(var_60_1, findTF(arg_60_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/idolmasterui_atlas", "tx_" .. iter_60_0, function(arg_72_0)
			setImageSprite(findTF(var_60_1, "state_open/icon"), arg_72_0, true)
			setImageSprite(findTF(var_60_1, "state_clear/icon"), arg_72_0, true)
			setImageSprite(findTF(var_60_1, "state_current/icon"), arg_72_0, true)

			return
		end)
		GetSpriteFromAtlasAsync("ui/minigameui/idolmasterui_atlas", "battleDesc" .. iter_60_0, function(arg_73_0)
			setImageSprite(findTF(var_60_1, "state_open/buttomDesc"), arg_73_0, true)
			setImageSprite(findTF(var_60_1, "state_clear/buttomDesc"), arg_73_0, true)
			setImageSprite(findTF(var_60_1, "state_current/buttomDesc"), arg_73_0, true)
			setImageSprite(findTF(var_60_1, "state_closed/buttomDesc"), arg_73_0, true)

			return
		end)
		setActive(var_60_1, true)
		table.insert(arg_60_0.battleItems, var_60_1)
	end

	arg_60_0.helpUI = findTF(arg_60_0._tf, "pop/HelpUI")

	onButton(arg_60_0, findTF(arg_60_0.helpUI, "close"), function()
		setActive(arg_60_0.helpUI, false)
		setActive(arg_60_0.menuUI, false)
		arg_60_0:readyStart()

		return
	end, SFX_CANCEL)

	arg_60_0.handle = arg_60_0.handle or UpdateBeat:CreateListener(arg_60_0.Update, arg_60_0)

	UpdateBeat:AddListener(arg_60_0.handle)

	return
end

function var_0_0.initGameUI(arg_75_0)
	arg_75_0.gameUI = findTF(arg_75_0._tf, "ui/gameUI")
	arg_75_0.textScore = findTF(arg_75_0.gameUI, "top/score")

	onButton(arg_75_0, findTF(arg_75_0.gameUI, "topRight/btnStop"), function()
		arg_75_0:stopGame()
		setActive(arg_75_0.pauseUI, true)

		return
	end)
	onButton(arg_75_0, findTF(arg_75_0.gameUI, "btnLeave"), function()
		arg_75_0:stopGame()
		setActive(arg_75_0.leaveUI, true)

		return
	end)

	arg_75_0.gameTimeM = findTF(arg_75_0.gameUI, "topRight/time/m")
	arg_75_0.gameTimeS = findTF(arg_75_0.gameUI, "topRight/time/s")
	arg_75_0.heartTfs = {}

	for iter_75_0 = 1, var_0_28 do
		table.insert(arg_75_0.heartTfs, findTF(arg_75_0.gameUI, "top/heart" .. iter_75_0 .. "/full"))
	end

	arg_75_0.scoreTf = findTF(arg_75_0.gameUI, "top/score")
	arg_75_0.giftUI = var_0_39(findTF(arg_75_0._tf, "scene/gift"), findTF(arg_75_0._tf, "scene/jiujiuWorker"), arg_75_0)
	arg_75_0.idolGroupUI = var_0_41(findTF(arg_75_0._tf, "scene/IdolContainer"), findTF(arg_75_0._tf, "scene/group"), findTF(arg_75_0._tf, "scene/Idol"), findTF(arg_75_0._tf, "scene/fans"), arg_75_0)

	return
end

function var_0_0.initTextTip(arg_78_0)
	var_0_34 = i18n("idolmaster_game_tip1") or var_0_34
	var_0_35 = i18n("idolmaster_game_tip2") or var_0_35
	var_0_36 = i18n("idolmaster_game_tip3") or var_0_36
	var_0_37 = i18n("idolmaster_game_tip4") or var_0_37
	var_0_38 = i18n("idolmaster_game_tip5") or var_0_38

	setText(findTF(arg_78_0.settlementUI, "ad/currentTextDesc"), var_0_36)
	setText(findTF(arg_78_0.settlementUI, "ad/highTextDesc"), var_0_37)
	setText(findTF(arg_78_0.gameUI, "top/scoreImg/socre"), var_0_38)
	setText(findTF(arg_78_0.pauseUI, "ad/tip"), var_0_34)
	setText(findTF(arg_78_0.leaveUI, "ad/tip"), var_0_35)

	return
end

function var_0_0.Update(arg_79_0)
	arg_79_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_80_0)
	if arg_80_0.gameStop or arg_80_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.updateMenuUI(arg_81_0)
	local var_81_0 = arg_81_0:getGameUsedTimes()
	local var_81_1 = arg_81_0:getGameTimes()

	for iter_81_0 = 1, #arg_81_0.battleItems do
		setActive(findTF(arg_81_0.battleItems[iter_81_0], "state_open"), false)
		setActive(findTF(arg_81_0.battleItems[iter_81_0], "state_closed"), false)
		setActive(findTF(arg_81_0.battleItems[iter_81_0], "state_clear"), false)
		setActive(findTF(arg_81_0.battleItems[iter_81_0], "state_current"), false)

		if iter_81_0 <= var_81_0 then
			setActive(findTF(arg_81_0.battleItems[iter_81_0], "state_clear"), true)
		elseif iter_81_0 == var_81_0 + 1 and var_81_1 >= 1 then
			setActive(findTF(arg_81_0.battleItems[iter_81_0], "state_current"), true)
		elseif var_81_0 < iter_81_0 and iter_81_0 <= var_81_0 + var_81_1 then
			setActive(findTF(arg_81_0.battleItems[iter_81_0], "state_open"), true)
		else
			setActive(findTF(arg_81_0.battleItems[iter_81_0], "state_closed"), true)
		end
	end

	arg_81_0.totalTimes = arg_81_0:getGameTotalTime()

	local var_81_2 = 1 - (arg_81_0:getGameUsedTimes() - 3 < 0 and 0 or arg_81_0:getGameUsedTimes() - 3) / (arg_81_0.totalTimes - 4)

	if var_81_2 > 1 then
		var_81_2 = 1
	end

	scrollTo(arg_81_0.battleScrollRect, 0, var_81_2)
	setActive(findTF(arg_81_0.menuUI, "btnStart/tip"), var_81_1 > 0)
	arg_81_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_82_0)
	setActive(findTF(arg_82_0.menuUI, "got"), false)

	if arg_82_0:getUltimate() and arg_82_0:getUltimate() ~= 0 then
		setActive(findTF(arg_82_0.menuUI, "got"), true)
	end

	if arg_82_0:getUltimate() == 0 then
		if arg_82_0:getGameTotalTime() > arg_82_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_82_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_82_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openMenuUI(arg_83_0)
	setActive(findTF(arg_83_0._tf, "scene_front"), false)
	setActive(findTF(arg_83_0._tf, "scene_background"), false)
	setActive(findTF(arg_83_0._tf, "scene"), false)
	setActive(arg_83_0.gameUI, false)
	setActive(arg_83_0.menuUI, true)

	if arg_83_0.storyIndex and var_0_7[arg_83_0.storyIndex] ~= "" and arg_83_0:getGameUsedTimes() == arg_83_0.storyIndex then
		pg.NewStoryMgr.GetInstance():Play(var_0_7[arg_83_0.storyIndex], function()
			return
		end, true)

		arg_83_0.storyIndex = nil
	end

	arg_83_0:updateMenuUI()

	return
end

function var_0_0.clearUI(arg_85_0)
	setActive(arg_85_0.sceneTf, false)
	setActive(arg_85_0.settlementUI, false)
	setActive(arg_85_0.countUI, false)
	setActive(arg_85_0.menuUI, false)
	setActive(arg_85_0.gameUI, false)

	return
end

function var_0_0.readyStart(arg_86_0)
	setActive(arg_86_0.countUI, true)
	arg_86_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)
	arg_86_0.idolGroupUI:createIdols()

	return
end

function var_0_0.gameStart(arg_87_0)
	setActive(findTF(arg_87_0._tf, "scene_front"), true)
	setActive(findTF(arg_87_0._tf, "scene_background"), true)
	setActive(findTF(arg_87_0._tf, "scene"), true)
	setActive(arg_87_0.gameUI, true)

	arg_87_0.gameStartFlag = true
	arg_87_0.scoreNum = 0
	arg_87_0.playerPosIndex = 2
	arg_87_0.gameStepTime = 0
	arg_87_0.heart = var_0_28
	arg_87_0.gameTime = var_0_3

	arg_87_0.idolGroupUI:start()
	arg_87_0.giftUI:start()
	arg_87_0:updateGameUI()
	arg_87_0:timerStart()

	return
end

function var_0_0.getGameTimes(arg_88_0)
	return arg_88_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_89_0)
	return arg_89_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_90_0)
	return arg_90_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_91_0)
	return (arg_91_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_92_0, arg_92_1)
	return
end

function var_0_0.onTimer(arg_93_0)
	arg_93_0:gameStep()

	return
end

function var_0_0.gameStep(arg_94_0)
	arg_94_0.gameTime = arg_94_0.gameTime - Time.deltaTime

	if arg_94_0.gameTime < 0 then
		arg_94_0.gameTime = 0
	end

	arg_94_0.gameStepTime = arg_94_0.gameStepTime + Time.deltaTime

	if arg_94_0.idolGroupUI then
		arg_94_0.idolGroupUI:step(arg_94_0.gameStepTime)
	end

	arg_94_0:updateGameUI()

	if arg_94_0.gameTime <= 0 then
		arg_94_0:onGameOver()

		return
	end

	return
end

function var_0_0.timerStart(arg_95_0)
	if not arg_95_0.timer.running then
		arg_95_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_96_0)
	if arg_96_0.timer.running then
		arg_96_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_97_0)
	setText(arg_97_0.textScore, arg_97_0.scoreNum)

	local var_97_0 = math.floor(math.ceil(arg_97_0.gameTime) / 60)

	if var_97_0 < 10 then
		var_97_0 = "0" .. var_97_0
	end

	local var_97_1 = math.floor(math.ceil(arg_97_0.gameTime) % 60)

	if var_97_1 < 10 then
		var_97_1 = "0" .. var_97_1
	end

	for iter_97_0 = 1, #arg_97_0.heartTfs do
		if iter_97_0 <= arg_97_0.heart then
			setActive(arg_97_0.heartTfs[iter_97_0], true)
		else
			setActive(arg_97_0.heartTfs[iter_97_0], false)
		end
	end

	setText(arg_97_0.scoreTf, arg_97_0.scoreNum)
	setText(arg_97_0.gameTimeM, var_97_0)
	setText(arg_97_0.gameTimeS, var_97_1)

	return
end

function var_0_0.loseHeart(arg_98_0)
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

function var_0_0.addScore(arg_99_0, arg_99_1)
	arg_99_0.scoreNum = arg_99_0.scoreNum + arg_99_1

	if arg_99_0.scoreNum < 0 then
		arg_99_0.scoreNum = 0
	end

	return
end

function var_0_0.onGameOver(arg_100_0)
	if arg_100_0.settlementFlag then
		return
	end

	arg_100_0:timerStop()

	arg_100_0.settlementFlag = true

	setActive(arg_100_0.clickMask, true)
	LeanTween.delayedCall(go(arg_100_0._tf), 2, System.Action(function()
		arg_100_0.settlementFlag = false
		arg_100_0.gameStartFlag = false

		setActive(arg_100_0.clickMask, false)
		arg_100_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_102_0)
	setActive(arg_102_0.settlementUI, true)
	GetComponent(findTF(arg_102_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_102_0 = arg_102_0:GetMGData():GetRuntimeData("elements")
	local var_102_1 = arg_102_0.scoreNum

	if var_102_0 and #var_102_0 > 0 then
		local var_102_2 = var_102_0[1] or 0

		setActive(findTF(arg_102_0.settlementUI, "ad/new"), var_102_2 < var_102_1)

		if var_102_2 <= var_102_1 then
			var_102_2 = var_102_1

			arg_102_0:StoreDataToServer({
				var_102_1
			})
		end

		setText(findTF(arg_102_0.settlementUI, "ad/highText"), var_102_2)
		setText(findTF(arg_102_0.settlementUI, "ad/currentText"), var_102_1)

		if arg_102_0:getGameTimes() and arg_102_0:getGameTimes() > 0 then
			arg_102_0.sendSuccessFlag = true
			arg_102_0.storyIndex = arg_102_0:getGameUsedTimes() + 1

			arg_102_0:SendSuccess(0)
		end

		return
	end
end

function var_0_0.resumeGame(arg_103_0)
	arg_103_0.gameStop = false

	setActive(arg_103_0.leaveUI, false)
	arg_103_0:changeSpeed(1)
	arg_103_0:timerStart()

	return
end

function var_0_0.stopGame(arg_104_0)
	arg_104_0.gameStop = true

	arg_104_0:timerStop()
	arg_104_0:changeSpeed(0)

	return
end

function var_0_0.onBackPressed(arg_105_0)
	if not arg_105_0.gameStartFlag then
		arg_105_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_105_0.settlementFlag then
			return
		end

		if isActive(arg_105_0.pauseUI) then
			setActive(arg_105_0.pauseUI, false)
		end

		arg_105_0:stopGame()
		setActive(arg_105_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_106_0)
	if arg_106_0.handle then
		UpdateBeat:RemoveListener(arg_106_0.handle)
	end

	if arg_106_0._tf and LeanTween.isTweening(go(arg_106_0._tf)) then
		LeanTween.cancel(go(arg_106_0._tf))
	end

	if arg_106_0.timer and arg_106_0.timer.running then
		arg_106_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_106_0.timer = nil

	return
end

return var_0_0

local var_0_0 = class("IdolMasterView", import("..BaseMiniGameView"))
local var_0_1 = "backyard"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_5 = 60
local var_0_6 = 100
local var_0_7 = 10
local var_0_8 = {
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
local var_0_9 = {
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
local var_0_10 = {
	{
		10700011,
		10700010
	},
	{
		10700021,
		10700020
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
local var_0_18 = "stand2"
local var_0_19 = "normal"
local var_0_20 = "work"
local var_0_21 = "wrong"
local var_0_22 = "end1"
local var_0_23 = "end2"
local var_0_24 = "gift"
local var_0_25 = "normal"
local var_0_26 = "walk"
local var_0_27 = 3
local var_0_28 = "type_fans_fail"
local var_0_29 = "type_fans_success"
local var_0_30 = 4
local var_0_31 = {
	Vector3(160, 160),
	Vector3(160, -30),
	Vector3(160, -210),
	Vector3(160, -400)
}
local var_0_32 = 350

local function var_0_33(arg_1_0, arg_1_1, arg_1_2)
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
					model = arg_2_0.model,
					anim = arg_3_0:GetComponent(typeof(SpineAnimUI)),
					name = var_0
				}

				arg_2_0:changeWorkerAction(var_0_19, 0, nil)

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
						arg_5_0.wokerSpine.anim:SetAction(var_0_19, 0)
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
				arg_7_0:changeWorkerAction(var_0_20, 1)
			else
				table.remove(arg_7_0.selectedGifts, var_7_1)
			end

			if #arg_7_0.selectedGifts >= var_0_16 then
				arg_7_0._event:emit(var_0_11, Clone(arg_7_0.selectedGifts), function(arg_8_0)
					if not arg_8_0 then
						arg_7_0:changeWorkerAction(var_0_21, 1)
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
				if table.contains(arg_10_0.selectedGifts, arg_10_0.gifts[iter_10_0].index) then
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(arg_11_0, arg_11_1)
			if arg_11_1 == -1 then
				arg_11_0._workerTf.anchoredPosition = Vector3.New(-290, 30, 0)
				arg_11_0._workerTf.localScale = Vector3.New(-1, 1, 1)
			else
				local var_11_0 = arg_11_0._workerTf.parent:InverseTransformPoint(arg_11_0.gifts[arg_11_1].tf.position)

				var_11_0.x = var_11_0.x + 22
				var_11_0.y = var_11_0.y - 50
				arg_11_0._workerTf.anchoredPosition = var_11_0
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
					model = arg_2_0.model,
					anim = arg_3_0:GetComponent(typeof(SpineAnimUI)),
					name = var_0
				}

				arg_2_0:changeWorkerAction(var_0_19, 0, nil)

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
						arg_5_0.wokerSpine.anim:SetAction(var_0_19, 0)
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
				arg_7_0:changeWorkerAction(var_0_20, 1)
			else
				table.remove(arg_7_0.selectedGifts, var_7_1)
			end

			if #arg_7_0.selectedGifts >= var_0_16 then
				arg_7_0._event:emit(var_0_11, Clone(arg_7_0.selectedGifts), function(arg_8_0)
					if not arg_8_0 then
						arg_7_0:changeWorkerAction(var_0_21, 1)
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
				if table.contains(arg_10_0.selectedGifts, arg_10_0.gifts[iter_10_0].index) then
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(arg_11_0, arg_11_1)
			if arg_11_1 == -1 then
				arg_11_0._workerTf.anchoredPosition = Vector3.New(-290, 30, 0)
				arg_11_0._workerTf.localScale = Vector3.New(-1, 1, 1)
			else
				local var_11_0 = arg_11_0._workerTf.parent:InverseTransformPoint(arg_11_0.gifts[arg_11_1].tf.position)

				var_11_0.x = var_11_0.x + 22
				var_11_0.y = var_11_0.y - 50
				arg_11_0._workerTf.anchoredPosition = var_11_0
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
					model = arg_2_0.model,
					anim = arg_3_0:GetComponent(typeof(SpineAnimUI)),
					name = var_0
				}

				arg_2_0:changeWorkerAction(var_0_19, 0, nil)

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
						arg_5_0.wokerSpine.anim:SetAction(var_0_19, 0)
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
				arg_7_0:changeWorkerAction(var_0_20, 1)
			else
				table.remove(arg_7_0.selectedGifts, var_7_1)
			end

			if #arg_7_0.selectedGifts >= var_0_16 then
				arg_7_0._event:emit(var_0_11, Clone(arg_7_0.selectedGifts), function(arg_8_0)
					if not arg_8_0 then
						arg_7_0:changeWorkerAction(var_0_21, 1)
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
				if table.contains(arg_10_0.selectedGifts, arg_10_0.gifts[iter_10_0].index) then
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), true)
				else
					setActive(findTF(arg_10_0.gifts[iter_10_0].tf, "selected"), false)
				end
			end

			return
		end,
		moveJiujiu = function(arg_11_0, arg_11_1)
			if arg_11_1 == -1 then
				arg_11_0._workerTf.anchoredPosition = Vector3.New(-290, 30, 0)
				arg_11_0._workerTf.localScale = Vector3.New(-1, 1, 1)
			else
				local var_11_0 = arg_11_0._workerTf.parent:InverseTransformPoint(arg_11_0.gifts[arg_11_1].tf.position)

				var_11_0.x = var_11_0.x + 22
				var_11_0.y = var_11_0.y - 50
				arg_11_0._workerTf.anchoredPosition = var_11_0
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

local function var_0_34(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	({
		Ctor = function(arg_14_0)
			arg_14_0._groupTf = arg_13_1
			arg_14_0._groupIndex = arg_13_2
			arg_14_0._groupTf.anchoredPosition = var_0_31[arg_13_2]
			arg_14_0._event = arg_13_3
			arg_14_0.modelData = {}

			SetActive(arg_14_0._groupTf, true)
			arg_14_0:createIdol(arg_13_0[1], arg_13_0[2])

			arg_14_0.fans = {}
			arg_14_0.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			PoolMgr.GetInstance():GetSpineChar(Ship.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			}):getPrefab(), true, function(arg_16_0)
				arg_16_0.transform.localScale = Vector3.one
				arg_16_0.transform.localPosition = Vector3.zero

				arg_16_0.transform:SetParent(findTF(arg_15_0._groupTf, "idolPos"), false)

				arg_15_0.modelData = {
					model = arg_15_0.model,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = arg_16_0:GetComponent(typeof(SpineAnimUI))
				}

				arg_15_0:changeCharAction(var_0_18, 0, nil)

				return
			end)

			return
		end,
		changeCharAction = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
			if arg_17_0.modelData.actionName == arg_17_1 then
				return
			end

			arg_17_0.modelData.actionName = arg_17_1

			arg_17_0.modelData.anim:SetActionCallBack(nil)
			arg_17_0.modelData.anim:SetAction(arg_17_1, 0)
			arg_17_0.modelData.anim:SetActionCallBack(function(arg_18_0)
				if arg_18_0 == "finish" then
					if arg_17_2 == 1 then
						arg_17_0.modelData.anim:SetActionCallBack(nil)
						arg_17_0.modelData.anim:SetAction(var_0_18, 0)
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
			SetActive(arg_19_1, true)
			SetParent(arg_19_1, findTF(arg_19_0._groupTf, "fansPos"))

			if #arg_19_0.fans > 0 then
				arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x = arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x + var_0_32 + math.random() * 200 + 22
				arg_19_1.anchoredPosition = Vector3.New(arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x, arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.y, arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.z)
			else
				arg_19_1.anchoredPosition = Vector3.New((#arg_19_0.fans + 1) * var_0_32 + 200, 0, 0)
			end

			table.insert(arg_19_0.fans, {
				tf = arg_19_1,
				speed = math.random() + 2.5
			})

			local var_19_0 = arg_19_0.fans[#arg_19_0.fans]

			PoolMgr.GetInstance():GetSpineChar("jiu-fan" .. math.random(1, 4), true, function(arg_20_0)
				arg_20_0.transform.localScale = Vector3.one
				arg_20_0.transform.localPosition = Vector3.zero

				arg_20_0.transform:SetParent(findTF(var_19_0.tf, "spinePos"), false)

				var_19_0.modelData = {
					model = arg_20_0,
					anim = arg_20_0:GetComponent(typeof(SpineAnimUI)),
					modelName = var_0
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

			arg_21_1.modelData.anim:SetActionCallBack(nil)
			arg_21_1.modelData.anim:SetAction(arg_21_2, 0)
			arg_21_1.modelData.anim:SetActionCallBack(function(arg_22_0)
				if arg_22_0 == "finish" then
					if arg_21_3 == 1 then
						arg_21_1.modelData.anim:SetActionCallBack(nil)
						arg_21_1.modelData.anim:SetAction(var_0_25, 0)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_24_0.fans[iter_24_0].modelData.modelName, arg_24_0.fans[iter_24_0].modelData.model)
				Destroy(arg_24_0.fans[iter_24_0].tf)
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
				if arg_26_0.fans[iter_26_0].tf.anchoredPosition.x > (iter_26_0 - 1) * var_0_32 then
					arg_26_0.fans[iter_26_0].tf.anchoredPosition.x = arg_26_0.fans[iter_26_0].tf.anchoredPosition.x - arg_26_0.fans[iter_26_0].speed
					arg_26_0.fans[iter_26_0].tf.anchoredPosition = arg_26_0.fans[iter_26_0].tf.anchoredPosition

					arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_26, 0, nil)
				elseif iter_26_0 == 1 and not arg_26_0.fans[iter_26_0].leave then
					if arg_26_0.fans[iter_26_0].gifts == nil then
						arg_26_0.fans[iter_26_0].gifts = arg_26_0:createWantedGifts()
						arg_26_0.fans[iter_26_0].time = arg_26_1 + var_0_7

						setImageSprite(findTF(arg_26_0.fans[iter_26_0].tf, "score/pack"), (LoadSprite("ui/minigameui/idolmasterui_atlas", "pack" .. arg_26_0.fans[iter_26_0].gifts[1])))
						arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_24, 0, nil)
					end
				elseif not arg_26_0.fans[iter_26_0].leave then
					arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_25, 0, nil)
				end
			end

			if #arg_26_0.fans > 0 then
				local var_26_1 = arg_26_0.fans[1]

				if arg_26_0.fans[1].time and arg_26_1 > var_26_1.time and not var_26_1.leave then
					var_26_1.leave = true

					arg_26_0:fanLeave(var_26_1, var_0_28, function()
						table.remove(arg_26_0.fans, 1)

						return
					end)
				else
					arg_26_0:showFansWanted(var_26_1)
				end

				var_26_1.tf:SetSiblingIndex(#arg_26_0.fans - 1)
			end

			return
		end,
		showFansWanted = function(arg_28_0, arg_28_1)
			if arg_28_1.leave then
				return
			end

			local var_28_0 = arg_28_1.time

			if not arg_28_1.time then
				return
			end

			local var_28_1 = math.ceil(var_28_0 - arg_28_0.stepTime) < 0 and 0 or var_28_0 - arg_28_0.stepTime
			local var_28_2 = arg_28_1.gifts
			local var_28_3 = var_28_1 <= 5

			setActive(findTF(arg_28_1.tf, "wanted"), true)
			setActive(findTF(arg_28_1.tf, "wanted/bg1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bgTime1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/time1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bg2"), var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bgTime2"), var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/time1"), var_28_3)

			if var_28_1 < 0 then
				var_28_1 = 0
			end

			setText(findTF(arg_28_1.tf, "wanted/time1"), math.abs(math.ceil(var_28_1)) .. "S")
			setText(findTF(arg_28_1.tf, "wanted/time2"), math.abs(math.ceil(var_28_1)) .. "S")

			for iter_28_0 = 1, #var_28_2 do
				setImageSprite(findTF(arg_28_1.tf, "wanted/item" .. iter_28_0), (LoadSprite("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_28_2[iter_28_0])))
			end

			return
		end,
		checkGifts = function(arg_29_0, arg_29_1)
			local var_29_0 = arg_29_0:getWantedGifts()

			if var_29_0 then
				for iter_29_0 = 1, #arg_29_1 do
					if not table.contains(var_29_0, arg_29_1[iter_29_0]) then
						return false
					end
				end

				arg_29_0.fans[1].leave = true

				arg_29_0:fanLeave(arg_29_0.fans[1], var_0_29, function()
					table.remove(arg_29_0.fans, 1)

					return
				end)

				return true
			end

			return false
		end,
		createWantedGifts = function(arg_31_0)
			local var_31_0 = Clone(var_0_15)

			table.insert({}, var_0_14[math.random(1, #var_0_14)])

			for iter_31_0 = 1, 2 do
				table.insert({}, (table.remove(var_31_0, math.random(1, #var_31_0))))
			end

			return {}
		end,
		fanLeave = function(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
			setActive(findTF(arg_32_1.tf, "wanted"), false)

			local var_32_0

			if var_0_28 == arg_32_2 then
				var_32_0 = var_0_23
			elseif var_0_29 then
				var_32_0 = var_0_22

				setText(findTF(arg_32_1.tf, "score"), "+" .. var_0_6)
				setActive(findTF(arg_32_1.tf, "score"), true)
			end

			arg_32_0:changeFansAction(arg_32_1, var_32_0, 1, function()
				PoolMgr.GetInstance():ReturnSpineChar(arg_32_1.modelData.modelName, arg_32_1.modelData.model)
				arg_32_0._event:emit(var_0_12, arg_32_2)
				Destroy(arg_32_1.tf)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_35_0.modelData.id, arg_35_0.modelData.model)
			end

			return
		end
	}).Ctor({
		Ctor = function(arg_14_0)
			arg_14_0._groupTf = arg_13_1
			arg_14_0._groupIndex = arg_13_2
			arg_14_0._groupTf.anchoredPosition = var_0_31[arg_13_2]
			arg_14_0._event = arg_13_3
			arg_14_0.modelData = {}

			SetActive(arg_14_0._groupTf, true)
			arg_14_0:createIdol(arg_13_0[1], arg_13_0[2])

			arg_14_0.fans = {}
			arg_14_0.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			PoolMgr.GetInstance():GetSpineChar(Ship.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			}):getPrefab(), true, function(arg_16_0)
				arg_16_0.transform.localScale = Vector3.one
				arg_16_0.transform.localPosition = Vector3.zero

				arg_16_0.transform:SetParent(findTF(arg_15_0._groupTf, "idolPos"), false)

				arg_15_0.modelData = {
					model = arg_15_0.model,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = arg_16_0:GetComponent(typeof(SpineAnimUI))
				}

				arg_15_0:changeCharAction(var_0_18, 0, nil)

				return
			end)

			return
		end,
		changeCharAction = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
			if arg_17_0.modelData.actionName == arg_17_1 then
				return
			end

			arg_17_0.modelData.actionName = arg_17_1

			arg_17_0.modelData.anim:SetActionCallBack(nil)
			arg_17_0.modelData.anim:SetAction(arg_17_1, 0)
			arg_17_0.modelData.anim:SetActionCallBack(function(arg_18_0)
				if arg_18_0 == "finish" then
					if arg_17_2 == 1 then
						arg_17_0.modelData.anim:SetActionCallBack(nil)
						arg_17_0.modelData.anim:SetAction(var_0_18, 0)
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
			SetActive(arg_19_1, true)
			SetParent(arg_19_1, findTF(arg_19_0._groupTf, "fansPos"))

			if #arg_19_0.fans > 0 then
				arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x = arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x + var_0_32 + math.random() * 200 + 22
				arg_19_1.anchoredPosition = Vector3.New(arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x, arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.y, arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.z)
			else
				arg_19_1.anchoredPosition = Vector3.New((#arg_19_0.fans + 1) * var_0_32 + 200, 0, 0)
			end

			table.insert(arg_19_0.fans, {
				tf = arg_19_1,
				speed = math.random() + 2.5
			})

			local var_19_0 = arg_19_0.fans[#arg_19_0.fans]

			PoolMgr.GetInstance():GetSpineChar("jiu-fan" .. math.random(1, 4), true, function(arg_20_0)
				arg_20_0.transform.localScale = Vector3.one
				arg_20_0.transform.localPosition = Vector3.zero

				arg_20_0.transform:SetParent(findTF(var_19_0.tf, "spinePos"), false)

				var_19_0.modelData = {
					model = arg_20_0,
					anim = arg_20_0:GetComponent(typeof(SpineAnimUI)),
					modelName = var_0
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

			arg_21_1.modelData.anim:SetActionCallBack(nil)
			arg_21_1.modelData.anim:SetAction(arg_21_2, 0)
			arg_21_1.modelData.anim:SetActionCallBack(function(arg_22_0)
				if arg_22_0 == "finish" then
					if arg_21_3 == 1 then
						arg_21_1.modelData.anim:SetActionCallBack(nil)
						arg_21_1.modelData.anim:SetAction(var_0_25, 0)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_24_0.fans[iter_24_0].modelData.modelName, arg_24_0.fans[iter_24_0].modelData.model)
				Destroy(arg_24_0.fans[iter_24_0].tf)
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
				if arg_26_0.fans[iter_26_0].tf.anchoredPosition.x > (iter_26_0 - 1) * var_0_32 then
					arg_26_0.fans[iter_26_0].tf.anchoredPosition.x = arg_26_0.fans[iter_26_0].tf.anchoredPosition.x - arg_26_0.fans[iter_26_0].speed
					arg_26_0.fans[iter_26_0].tf.anchoredPosition = arg_26_0.fans[iter_26_0].tf.anchoredPosition

					arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_26, 0, nil)
				elseif iter_26_0 == 1 and not arg_26_0.fans[iter_26_0].leave then
					if arg_26_0.fans[iter_26_0].gifts == nil then
						arg_26_0.fans[iter_26_0].gifts = arg_26_0:createWantedGifts()
						arg_26_0.fans[iter_26_0].time = arg_26_1 + var_0_7

						setImageSprite(findTF(arg_26_0.fans[iter_26_0].tf, "score/pack"), (LoadSprite("ui/minigameui/idolmasterui_atlas", "pack" .. arg_26_0.fans[iter_26_0].gifts[1])))
						arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_24, 0, nil)
					end
				elseif not arg_26_0.fans[iter_26_0].leave then
					arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_25, 0, nil)
				end
			end

			if #arg_26_0.fans > 0 then
				local var_26_1 = arg_26_0.fans[1]

				if arg_26_0.fans[1].time and arg_26_1 > var_26_1.time and not var_26_1.leave then
					var_26_1.leave = true

					arg_26_0:fanLeave(var_26_1, var_0_28, function()
						table.remove(arg_26_0.fans, 1)

						return
					end)
				else
					arg_26_0:showFansWanted(var_26_1)
				end

				var_26_1.tf:SetSiblingIndex(#arg_26_0.fans - 1)
			end

			return
		end,
		showFansWanted = function(arg_28_0, arg_28_1)
			if arg_28_1.leave then
				return
			end

			local var_28_0 = arg_28_1.time

			if not arg_28_1.time then
				return
			end

			local var_28_1 = math.ceil(var_28_0 - arg_28_0.stepTime) < 0 and 0 or var_28_0 - arg_28_0.stepTime
			local var_28_2 = arg_28_1.gifts
			local var_28_3 = var_28_1 <= 5

			setActive(findTF(arg_28_1.tf, "wanted"), true)
			setActive(findTF(arg_28_1.tf, "wanted/bg1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bgTime1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/time1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bg2"), var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bgTime2"), var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/time1"), var_28_3)

			if var_28_1 < 0 then
				var_28_1 = 0
			end

			setText(findTF(arg_28_1.tf, "wanted/time1"), math.abs(math.ceil(var_28_1)) .. "S")
			setText(findTF(arg_28_1.tf, "wanted/time2"), math.abs(math.ceil(var_28_1)) .. "S")

			for iter_28_0 = 1, #var_28_2 do
				setImageSprite(findTF(arg_28_1.tf, "wanted/item" .. iter_28_0), (LoadSprite("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_28_2[iter_28_0])))
			end

			return
		end,
		checkGifts = function(arg_29_0, arg_29_1)
			local var_29_0 = arg_29_0:getWantedGifts()

			if var_29_0 then
				for iter_29_0 = 1, #arg_29_1 do
					if not table.contains(var_29_0, arg_29_1[iter_29_0]) then
						return false
					end
				end

				arg_29_0.fans[1].leave = true

				arg_29_0:fanLeave(arg_29_0.fans[1], var_0_29, function()
					table.remove(arg_29_0.fans, 1)

					return
				end)

				return true
			end

			return false
		end,
		createWantedGifts = function(arg_31_0)
			local var_31_0 = Clone(var_0_15)

			table.insert({}, var_0_14[math.random(1, #var_0_14)])

			for iter_31_0 = 1, 2 do
				table.insert({}, (table.remove(var_31_0, math.random(1, #var_31_0))))
			end

			return {}
		end,
		fanLeave = function(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
			setActive(findTF(arg_32_1.tf, "wanted"), false)

			local var_32_0

			if var_0_28 == arg_32_2 then
				var_32_0 = var_0_23
			elseif var_0_29 then
				var_32_0 = var_0_22

				setText(findTF(arg_32_1.tf, "score"), "+" .. var_0_6)
				setActive(findTF(arg_32_1.tf, "score"), true)
			end

			arg_32_0:changeFansAction(arg_32_1, var_32_0, 1, function()
				PoolMgr.GetInstance():ReturnSpineChar(arg_32_1.modelData.modelName, arg_32_1.modelData.model)
				arg_32_0._event:emit(var_0_12, arg_32_2)
				Destroy(arg_32_1.tf)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_35_0.modelData.id, arg_35_0.modelData.model)
			end

			return
		end
	})

	return {
		Ctor = function(arg_14_0)
			arg_14_0._groupTf = arg_13_1
			arg_14_0._groupIndex = arg_13_2
			arg_14_0._groupTf.anchoredPosition = var_0_31[arg_13_2]
			arg_14_0._event = arg_13_3
			arg_14_0.modelData = {}

			SetActive(arg_14_0._groupTf, true)
			arg_14_0:createIdol(arg_13_0[1], arg_13_0[2])

			arg_14_0.fans = {}
			arg_14_0.wantedData = {}

			return
		end,
		createIdol = function(arg_15_0, arg_15_1, arg_15_2)
			PoolMgr.GetInstance():GetSpineChar(Ship.New({
				configId = arg_15_1,
				skin_id = arg_15_2
			}):getPrefab(), true, function(arg_16_0)
				arg_16_0.transform.localScale = Vector3.one
				arg_16_0.transform.localPosition = Vector3.zero

				arg_16_0.transform:SetParent(findTF(arg_15_0._groupTf, "idolPos"), false)

				arg_15_0.modelData = {
					model = arg_15_0.model,
					id = arg_15_1,
					skinId = arg_15_2,
					anim = arg_16_0:GetComponent(typeof(SpineAnimUI))
				}

				arg_15_0:changeCharAction(var_0_18, 0, nil)

				return
			end)

			return
		end,
		changeCharAction = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
			if arg_17_0.modelData.actionName == arg_17_1 then
				return
			end

			arg_17_0.modelData.actionName = arg_17_1

			arg_17_0.modelData.anim:SetActionCallBack(nil)
			arg_17_0.modelData.anim:SetAction(arg_17_1, 0)
			arg_17_0.modelData.anim:SetActionCallBack(function(arg_18_0)
				if arg_18_0 == "finish" then
					if arg_17_2 == 1 then
						arg_17_0.modelData.anim:SetActionCallBack(nil)
						arg_17_0.modelData.anim:SetAction(var_0_18, 0)
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
			SetActive(arg_19_1, true)
			SetParent(arg_19_1, findTF(arg_19_0._groupTf, "fansPos"))

			if #arg_19_0.fans > 0 then
				arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x = arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x + var_0_32 + math.random() * 200 + 22
				arg_19_1.anchoredPosition = Vector3.New(arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.x, arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.y, arg_19_0.fans[#arg_19_0.fans].tf.anchoredPosition.z)
			else
				arg_19_1.anchoredPosition = Vector3.New((#arg_19_0.fans + 1) * var_0_32 + 200, 0, 0)
			end

			table.insert(arg_19_0.fans, {
				tf = arg_19_1,
				speed = math.random() + 2.5
			})

			local var_19_0 = arg_19_0.fans[#arg_19_0.fans]

			PoolMgr.GetInstance():GetSpineChar("jiu-fan" .. math.random(1, 4), true, function(arg_20_0)
				arg_20_0.transform.localScale = Vector3.one
				arg_20_0.transform.localPosition = Vector3.zero

				arg_20_0.transform:SetParent(findTF(var_19_0.tf, "spinePos"), false)

				var_19_0.modelData = {
					model = arg_20_0,
					anim = arg_20_0:GetComponent(typeof(SpineAnimUI)),
					modelName = var_0
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

			arg_21_1.modelData.anim:SetActionCallBack(nil)
			arg_21_1.modelData.anim:SetAction(arg_21_2, 0)
			arg_21_1.modelData.anim:SetActionCallBack(function(arg_22_0)
				if arg_22_0 == "finish" then
					if arg_21_3 == 1 then
						arg_21_1.modelData.anim:SetActionCallBack(nil)
						arg_21_1.modelData.anim:SetAction(var_0_25, 0)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_24_0.fans[iter_24_0].modelData.modelName, arg_24_0.fans[iter_24_0].modelData.model)
				Destroy(arg_24_0.fans[iter_24_0].tf)
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
				if arg_26_0.fans[iter_26_0].tf.anchoredPosition.x > (iter_26_0 - 1) * var_0_32 then
					arg_26_0.fans[iter_26_0].tf.anchoredPosition.x = arg_26_0.fans[iter_26_0].tf.anchoredPosition.x - arg_26_0.fans[iter_26_0].speed
					arg_26_0.fans[iter_26_0].tf.anchoredPosition = arg_26_0.fans[iter_26_0].tf.anchoredPosition

					arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_26, 0, nil)
				elseif iter_26_0 == 1 and not arg_26_0.fans[iter_26_0].leave then
					if arg_26_0.fans[iter_26_0].gifts == nil then
						arg_26_0.fans[iter_26_0].gifts = arg_26_0:createWantedGifts()
						arg_26_0.fans[iter_26_0].time = arg_26_1 + var_0_7

						setImageSprite(findTF(arg_26_0.fans[iter_26_0].tf, "score/pack"), (LoadSprite("ui/minigameui/idolmasterui_atlas", "pack" .. arg_26_0.fans[iter_26_0].gifts[1])))
						arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_24, 0, nil)
					end
				elseif not arg_26_0.fans[iter_26_0].leave then
					arg_26_0:changeFansAction(arg_26_0.fans[iter_26_0], var_0_25, 0, nil)
				end
			end

			if #arg_26_0.fans > 0 then
				local var_26_1 = arg_26_0.fans[1]

				if arg_26_0.fans[1].time and arg_26_1 > var_26_1.time and not var_26_1.leave then
					var_26_1.leave = true

					arg_26_0:fanLeave(var_26_1, var_0_28, function()
						table.remove(arg_26_0.fans, 1)

						return
					end)
				else
					arg_26_0:showFansWanted(var_26_1)
				end

				var_26_1.tf:SetSiblingIndex(#arg_26_0.fans - 1)
			end

			return
		end,
		showFansWanted = function(arg_28_0, arg_28_1)
			if arg_28_1.leave then
				return
			end

			local var_28_0 = arg_28_1.time

			if not arg_28_1.time then
				return
			end

			local var_28_1 = math.ceil(var_28_0 - arg_28_0.stepTime) < 0 and 0 or var_28_0 - arg_28_0.stepTime
			local var_28_2 = arg_28_1.gifts
			local var_28_3 = var_28_1 <= 5

			setActive(findTF(arg_28_1.tf, "wanted"), true)
			setActive(findTF(arg_28_1.tf, "wanted/bg1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bgTime1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/time1"), not var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bg2"), var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/bgTime2"), var_28_3)
			setActive(findTF(arg_28_1.tf, "wanted/time1"), var_28_3)

			if var_28_1 < 0 then
				var_28_1 = 0
			end

			setText(findTF(arg_28_1.tf, "wanted/time1"), math.abs(math.ceil(var_28_1)) .. "S")
			setText(findTF(arg_28_1.tf, "wanted/time2"), math.abs(math.ceil(var_28_1)) .. "S")

			for iter_28_0 = 1, #var_28_2 do
				setImageSprite(findTF(arg_28_1.tf, "wanted/item" .. iter_28_0), (LoadSprite("ui/minigameui/idolmasterui_atlas", "wantItem" .. var_28_2[iter_28_0])))
			end

			return
		end,
		checkGifts = function(arg_29_0, arg_29_1)
			local var_29_0 = arg_29_0:getWantedGifts()

			if var_29_0 then
				for iter_29_0 = 1, #arg_29_1 do
					if not table.contains(var_29_0, arg_29_1[iter_29_0]) then
						return false
					end
				end

				arg_29_0.fans[1].leave = true

				arg_29_0:fanLeave(arg_29_0.fans[1], var_0_29, function()
					table.remove(arg_29_0.fans, 1)

					return
				end)

				return true
			end

			return false
		end,
		createWantedGifts = function(arg_31_0)
			local var_31_0 = Clone(var_0_15)

			table.insert({}, var_0_14[math.random(1, #var_0_14)])

			for iter_31_0 = 1, 2 do
				table.insert({}, (table.remove(var_31_0, math.random(1, #var_31_0))))
			end

			return {}
		end,
		fanLeave = function(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
			setActive(findTF(arg_32_1.tf, "wanted"), false)

			local var_32_0

			if var_0_28 == arg_32_2 then
				var_32_0 = var_0_23
			elseif var_0_29 then
				var_32_0 = var_0_22

				setText(findTF(arg_32_1.tf, "score"), "+" .. var_0_6)
				setActive(findTF(arg_32_1.tf, "score"), true)
			end

			arg_32_0:changeFansAction(arg_32_1, var_32_0, 1, function()
				PoolMgr.GetInstance():ReturnSpineChar(arg_32_1.modelData.modelName, arg_32_1.modelData.model)
				arg_32_0._event:emit(var_0_12, arg_32_2)
				Destroy(arg_32_1.tf)
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
				PoolMgr.GetInstance():ReturnSpineChar(arg_35_0.modelData.id, arg_35_0.modelData.model)
			end

			return
		end
	}
end

local function var_0_35(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	({
		Ctor = function(arg_37_0)
			arg_37_0._containerTf = arg_36_0
			arg_37_0._tplGroup = arg_36_1
			arg_37_0._tplIdol = arg_36_2
			arg_37_0._tplFans = arg_36_3
			arg_37_0._event = arg_36_4
			arg_37_0.groups = {}

			local var_37_0 = arg_37_0:getRandomIdols()

			for iter_37_0 = 1, var_0_30 do
				local var_37_1 = tf(Instantiate(arg_37_0._tplGroup))

				SetParent(var_37_1, arg_37_0._containerTf)
				table.insert(arg_37_0.groups, (var_0_34(var_37_0[iter_37_0], var_37_1, iter_37_0, arg_37_0._event)))
			end

			return
		end,
		receiveGift = function(arg_38_0, arg_38_1, arg_38_2)
			local var_38_0 = false

			for iter_38_0 = 1, #arg_38_0.groups do
				if arg_38_0.groups[iter_38_0]:checkGifts(arg_38_1) then
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
			local var_39_0 = Clone(var_0_9)

			for iter_39_0 = 1, var_0_30 do
				local var_39_1 = false

				if iter_39_0 == var_0_30 then
					var_39_1 = true

					for iter_39_1, iter_39_2 in ipairs(var_0_10) do
						if table.contains({}, iter_39_2) then
							var_39_1 = false
						end
					end
				end

				if var_39_1 then
					table.insert({}, var_0_10[math.random(1, #var_0_10)])
				else
					table.insert({}, table.remove(var_39_0, math.random(1, #var_39_0)))
				end
			end

			return {}
		end,
		getApearTime = function(arg_40_0)
			if arg_40_0.runTime and arg_40_0.runTime > 0 then
				for iter_40_0 = 1, #var_0_8 do
					if arg_40_0.runTime < var_0_8[iter_40_0][1] then
						return var_0_8[iter_40_0][2]
					end
				end
			end

			return var_0_8[#var_0_8][2]
		end,
		start = function(arg_41_0)
			arg_41_0:reset()

			arg_41_0.createFansTime = nil
			arg_41_0.lastTime = var_0_5

			for iter_41_0 = 1, 3 do
				arg_41_0.groups[math.random(1, #arg_41_0.groups)]:createFans(tf(instantiate(arg_41_0._tplFans)))
			end

			for iter_41_1 = 1, #arg_41_0.groups do
				arg_41_0.groups[iter_41_1]:start()
			end

			return
		end,
		step = function(arg_42_0, arg_42_1)
			arg_42_0.lastTime = arg_42_0.lastTime - Time.deltaTime

			local var_42_0 = arg_42_0:getApearTime()

			if not arg_42_0.createFansTime then
				arg_42_0.createFansTime = arg_42_1 + var_42_0 + math.random() * 1
			elseif arg_42_1 > arg_42_0.createFansTime then
				arg_42_0.groups[math.random(1, #arg_42_0.groups)]:createFans(tf(instantiate(arg_42_0._tplFans)))

				arg_42_0.createFansTime = arg_42_1 + var_42_0 + math.random() * 1
			end

			for iter_42_0 = 1, #arg_42_0.groups do
				arg_42_0.groups[iter_42_0]:step(arg_42_1)
			end

			return
		end,
		reset = function(arg_43_0)
			for iter_43_0 = 1, #arg_43_0.groups do
				arg_43_0.groups[iter_43_0]:reset()
			end

			return
		end,
		destroy = function(arg_44_0)
			for iter_44_0 = 1, #arg_44_0.groups do
				arg_44_0.groups[iter_44_0]:destroy()
			end

			return
		end
	}).Ctor({
		Ctor = function(arg_37_0)
			arg_37_0._containerTf = arg_36_0
			arg_37_0._tplGroup = arg_36_1
			arg_37_0._tplIdol = arg_36_2
			arg_37_0._tplFans = arg_36_3
			arg_37_0._event = arg_36_4
			arg_37_0.groups = {}

			local var_37_0 = arg_37_0:getRandomIdols()

			for iter_37_0 = 1, var_0_30 do
				local var_37_1 = tf(Instantiate(arg_37_0._tplGroup))

				SetParent(var_37_1, arg_37_0._containerTf)
				table.insert(arg_37_0.groups, (var_0_34(var_37_0[iter_37_0], var_37_1, iter_37_0, arg_37_0._event)))
			end

			return
		end,
		receiveGift = function(arg_38_0, arg_38_1, arg_38_2)
			local var_38_0 = false

			for iter_38_0 = 1, #arg_38_0.groups do
				if arg_38_0.groups[iter_38_0]:checkGifts(arg_38_1) then
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
			local var_39_0 = Clone(var_0_9)

			for iter_39_0 = 1, var_0_30 do
				local var_39_1 = false

				if iter_39_0 == var_0_30 then
					var_39_1 = true

					for iter_39_1, iter_39_2 in ipairs(var_0_10) do
						if table.contains({}, iter_39_2) then
							var_39_1 = false
						end
					end
				end

				if var_39_1 then
					table.insert({}, var_0_10[math.random(1, #var_0_10)])
				else
					table.insert({}, table.remove(var_39_0, math.random(1, #var_39_0)))
				end
			end

			return {}
		end,
		getApearTime = function(arg_40_0)
			if arg_40_0.runTime and arg_40_0.runTime > 0 then
				for iter_40_0 = 1, #var_0_8 do
					if arg_40_0.runTime < var_0_8[iter_40_0][1] then
						return var_0_8[iter_40_0][2]
					end
				end
			end

			return var_0_8[#var_0_8][2]
		end,
		start = function(arg_41_0)
			arg_41_0:reset()

			arg_41_0.createFansTime = nil
			arg_41_0.lastTime = var_0_5

			for iter_41_0 = 1, 3 do
				arg_41_0.groups[math.random(1, #arg_41_0.groups)]:createFans(tf(instantiate(arg_41_0._tplFans)))
			end

			for iter_41_1 = 1, #arg_41_0.groups do
				arg_41_0.groups[iter_41_1]:start()
			end

			return
		end,
		step = function(arg_42_0, arg_42_1)
			arg_42_0.lastTime = arg_42_0.lastTime - Time.deltaTime

			local var_42_0 = arg_42_0:getApearTime()

			if not arg_42_0.createFansTime then
				arg_42_0.createFansTime = arg_42_1 + var_42_0 + math.random() * 1
			elseif arg_42_1 > arg_42_0.createFansTime then
				arg_42_0.groups[math.random(1, #arg_42_0.groups)]:createFans(tf(instantiate(arg_42_0._tplFans)))

				arg_42_0.createFansTime = arg_42_1 + var_42_0 + math.random() * 1
			end

			for iter_42_0 = 1, #arg_42_0.groups do
				arg_42_0.groups[iter_42_0]:step(arg_42_1)
			end

			return
		end,
		reset = function(arg_43_0)
			for iter_43_0 = 1, #arg_43_0.groups do
				arg_43_0.groups[iter_43_0]:reset()
			end

			return
		end,
		destroy = function(arg_44_0)
			for iter_44_0 = 1, #arg_44_0.groups do
				arg_44_0.groups[iter_44_0]:destroy()
			end

			return
		end
	})

	return {
		Ctor = function(arg_37_0)
			arg_37_0._containerTf = arg_36_0
			arg_37_0._tplGroup = arg_36_1
			arg_37_0._tplIdol = arg_36_2
			arg_37_0._tplFans = arg_36_3
			arg_37_0._event = arg_36_4
			arg_37_0.groups = {}

			local var_37_0 = arg_37_0:getRandomIdols()

			for iter_37_0 = 1, var_0_30 do
				local var_37_1 = tf(Instantiate(arg_37_0._tplGroup))

				SetParent(var_37_1, arg_37_0._containerTf)
				table.insert(arg_37_0.groups, (var_0_34(var_37_0[iter_37_0], var_37_1, iter_37_0, arg_37_0._event)))
			end

			return
		end,
		receiveGift = function(arg_38_0, arg_38_1, arg_38_2)
			local var_38_0 = false

			for iter_38_0 = 1, #arg_38_0.groups do
				if arg_38_0.groups[iter_38_0]:checkGifts(arg_38_1) then
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
			local var_39_0 = Clone(var_0_9)

			for iter_39_0 = 1, var_0_30 do
				local var_39_1 = false

				if iter_39_0 == var_0_30 then
					var_39_1 = true

					for iter_39_1, iter_39_2 in ipairs(var_0_10) do
						if table.contains({}, iter_39_2) then
							var_39_1 = false
						end
					end
				end

				if var_39_1 then
					table.insert({}, var_0_10[math.random(1, #var_0_10)])
				else
					table.insert({}, table.remove(var_39_0, math.random(1, #var_39_0)))
				end
			end

			return {}
		end,
		getApearTime = function(arg_40_0)
			if arg_40_0.runTime and arg_40_0.runTime > 0 then
				for iter_40_0 = 1, #var_0_8 do
					if arg_40_0.runTime < var_0_8[iter_40_0][1] then
						return var_0_8[iter_40_0][2]
					end
				end
			end

			return var_0_8[#var_0_8][2]
		end,
		start = function(arg_41_0)
			arg_41_0:reset()

			arg_41_0.createFansTime = nil
			arg_41_0.lastTime = var_0_5

			for iter_41_0 = 1, 3 do
				arg_41_0.groups[math.random(1, #arg_41_0.groups)]:createFans(tf(instantiate(arg_41_0._tplFans)))
			end

			for iter_41_1 = 1, #arg_41_0.groups do
				arg_41_0.groups[iter_41_1]:start()
			end

			return
		end,
		step = function(arg_42_0, arg_42_1)
			arg_42_0.lastTime = arg_42_0.lastTime - Time.deltaTime

			local var_42_0 = arg_42_0:getApearTime()

			if not arg_42_0.createFansTime then
				arg_42_0.createFansTime = arg_42_1 + var_42_0 + math.random() * 1
			elseif arg_42_1 > arg_42_0.createFansTime then
				arg_42_0.groups[math.random(1, #arg_42_0.groups)]:createFans(tf(instantiate(arg_42_0._tplFans)))

				arg_42_0.createFansTime = arg_42_1 + var_42_0 + math.random() * 1
			end

			for iter_42_0 = 1, #arg_42_0.groups do
				arg_42_0.groups[iter_42_0]:step(arg_42_1)
			end

			return
		end,
		reset = function(arg_43_0)
			for iter_43_0 = 1, #arg_43_0.groups do
				arg_43_0.groups[iter_43_0]:reset()
			end

			return
		end,
		destroy = function(arg_44_0)
			for iter_44_0 = 1, #arg_44_0.groups do
				arg_44_0.groups[iter_44_0]:destroy()
			end

			return
		end
	}
end

function var_0_0.getUIName(arg_45_0)
	return "IdolMasterGameUI"
end

function var_0_0.getBGM(arg_46_0)
	return var_0_1
end

function var_0_0.didEnter(arg_47_0)
	arg_47_0:initEvent()
	arg_47_0:initData()
	arg_47_0:initUI()
	arg_47_0:initGameUI()
	arg_47_0:updateMenuUI()
	arg_47_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_48_0)
	arg_48_0:bind(var_0_11, function(arg_49_0, arg_49_1, arg_49_2)
		if arg_48_0.idolGroupUI then
			arg_48_0.idolGroupUI:receiveGift(arg_49_1, arg_49_2)
		end

		return
	end)
	arg_48_0:bind(var_0_12, function(arg_50_0, arg_50_1, arg_50_2)
		if arg_48_0.gameStartFlag then
			if arg_50_1 == var_0_28 then
				arg_48_0:loseHeart()
			elseif arg_50_1 == var_0_29 then
				arg_48_0:addScore(100)
			end
		end

		return
	end)

	return
end

function var_0_0.initData(arg_51_0)
	local var_51_0 = Application.targetFrameRate or 60

	arg_51_0.storylist = arg_51_0:GetMGHubData():GetSimpleValue("story")
	arg_51_0.timer = Timer.New(function()
		arg_51_0:onTimer()

		return
	end, 1 / var_51_0, -1)

	return
end

function var_0_0.initUI(arg_53_0)
	arg_53_0.sceneTf = findTF(arg_53_0._tf, "scene")
	arg_53_0.clickMask = findTF(arg_53_0._tf, "clickMask")
	arg_53_0.countUI = findTF(arg_53_0._tf, "pop/CountUI")
	arg_53_0.countAnimator = GetComponent(findTF(arg_53_0.countUI, "count"), typeof(Animator))
	arg_53_0.countDft = GetComponent(findTF(arg_53_0.countUI, "count"), typeof(DftAniEvent))

	arg_53_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_53_0.countDft:SetEndEvent(function()
		setActive(arg_53_0.countUI, false)
		arg_53_0:gameStart()

		return
	end)

	arg_53_0.leaveUI = findTF(arg_53_0._tf, "pop/LeaveUI")

	onButton(arg_53_0, findTF(arg_53_0.leaveUI, "ad/btnOk"), function()
		arg_53_0:resumeGame()
		arg_53_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_53_0, findTF(arg_53_0.leaveUI, "ad/btnCancel"), function()
		arg_53_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_53_0.pauseUI = findTF(arg_53_0._tf, "pop/pauseUI")

	onButton(arg_53_0, findTF(arg_53_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_53_0.pauseUI, false)
		arg_53_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_53_0.settlementUI = findTF(arg_53_0._tf, "pop/SettleMentUI")

	onButton(arg_53_0, findTF(arg_53_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_53_0.settlementUI, false)
		arg_53_0:openMenuUI()

		return
	end, SFX_CANCEL)

	arg_53_0.menuUI = findTF(arg_53_0._tf, "pop/menuUI")
	arg_53_0.battleScrollRect = GetComponent(findTF(arg_53_0.menuUI, "battList"), typeof(ScrollRect))
	arg_53_0.totalTimes = arg_53_0:getGameTotalTime()

	scrollTo(arg_53_0.battleScrollRect, 0, 1 - (arg_53_0:getGameUsedTimes() - 4 < 0 and 0 or arg_53_0:getGameUsedTimes() - 4) / (arg_53_0.totalTimes - 4))
	onButton(arg_53_0, findTF(arg_53_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_60_0 = arg_53_0.battleScrollRect.normalizedPosition.y + 1 / (arg_53_0.totalTimes - 4)

		if arg_53_0.battleScrollRect.normalizedPosition.y + 1 / (arg_53_0.totalTimes - 4) > 1 then
			var_60_0 = 1
		end

		scrollTo(arg_53_0.battleScrollRect, 0, var_60_0)

		return
	end, SFX_CANCEL)
	onButton(arg_53_0, findTF(arg_53_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_61_0 = arg_53_0.battleScrollRect.normalizedPosition.y - 1 / (arg_53_0.totalTimes - 4)

		if arg_53_0.battleScrollRect.normalizedPosition.y - 1 / (arg_53_0.totalTimes - 4) < 0 then
			var_61_0 = 0
		end

		scrollTo(arg_53_0.battleScrollRect, 0, var_61_0)

		return
	end, SFX_CANCEL)
	onButton(arg_53_0, findTF(arg_53_0.menuUI, "btnBack"), function()
		arg_53_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_53_0, findTF(arg_53_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.cowboy_tips.tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_53_0, findTF(arg_53_0.menuUI, "btnStart"), function()
		setActive(arg_53_0.menuUI, false)
		arg_53_0:readyStart()

		return
	end, SFX_CANCEL)

	local var_53_0 = findTF(arg_53_0.menuUI, "tplBattleItem")

	arg_53_0.battleItems = {}

	for iter_53_0 = 1, arg_53_0.totalTimes do
		local var_53_1 = tf(instantiate(var_53_0))

		var_53_1.name = "battleItem_" .. iter_53_0

		setParent(var_53_1, findTF(arg_53_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/idolmasterui_atlas", "tx_" .. iter_53_0, function(arg_65_0)
			setImageSprite(findTF(var_53_1, "state_open/icon"), arg_65_0, true)
			setImageSprite(findTF(var_53_1, "state_clear/icon"), arg_65_0, true)
			setImageSprite(findTF(var_53_1, "state_current/icon"), arg_65_0, true)

			return
		end)
		GetSpriteFromAtlasAsync("ui/minigameui/idolmasterui_atlas", "battleDesc" .. iter_53_0, function(arg_66_0)
			setImageSprite(findTF(var_53_1, "state_open/buttomDesc"), arg_66_0, true)
			setImageSprite(findTF(var_53_1, "state_clear/buttomDesc"), arg_66_0, true)
			setImageSprite(findTF(var_53_1, "state_current/buttomDesc"), arg_66_0, true)
			setImageSprite(findTF(var_53_1, "state_closed/buttomDesc"), arg_66_0, true)

			return
		end)
		setActive(var_53_1, true)
		table.insert(arg_53_0.battleItems, var_53_1)
	end

	arg_53_0.handle = arg_53_0.handle or UpdateBeat:CreateListener(arg_53_0.Update, arg_53_0)

	UpdateBeat:AddListener(arg_53_0.handle)

	return
end

function var_0_0.initGameUI(arg_67_0)
	arg_67_0.gameUI = findTF(arg_67_0._tf, "ui/gameUI")
	arg_67_0.textScore = findTF(arg_67_0.gameUI, "top/score")

	onButton(arg_67_0, findTF(arg_67_0.gameUI, "topRight/btnStop"), function()
		arg_67_0:stopGame()
		setActive(arg_67_0.pauseUI, true)

		return
	end)
	onButton(arg_67_0, findTF(arg_67_0.gameUI, "btnLeave"), function()
		arg_67_0:stopGame()
		setActive(arg_67_0.leaveUI, true)

		return
	end)

	arg_67_0.gameTimeM = findTF(arg_67_0.gameUI, "topRight/time/m")
	arg_67_0.gameTimeS = findTF(arg_67_0.gameUI, "topRight/time/s")
	arg_67_0.heartTfs = {}

	for iter_67_0 = 1, var_0_27 do
		table.insert(arg_67_0.heartTfs, findTF(arg_67_0.gameUI, "top/heart" .. iter_67_0 .. "/full"))
	end

	arg_67_0.scoreTf = findTF(arg_67_0.gameUI, "top/score")
	arg_67_0.giftUI = var_0_33(findTF(arg_67_0._tf, "scene/gift"), findTF(arg_67_0._tf, "scene/jiujiuWorker"), arg_67_0)
	arg_67_0.idolGroupUI = var_0_35(findTF(arg_67_0._tf, "scene/IdolContainer"), findTF(arg_67_0._tf, "scene/group"), findTF(arg_67_0._tf, "scene/Idol"), findTF(arg_67_0._tf, "scene/fans"), arg_67_0)

	return
end

function var_0_0.Update(arg_70_0)
	arg_70_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_71_0)
	if arg_71_0.gameStop or arg_71_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.updateMenuUI(arg_72_0)
	local var_72_0 = arg_72_0:getGameUsedTimes()
	local var_72_1 = arg_72_0:getGameTimes()

	for iter_72_0 = 1, #arg_72_0.battleItems do
		setActive(findTF(arg_72_0.battleItems[iter_72_0], "state_open"), false)
		setActive(findTF(arg_72_0.battleItems[iter_72_0], "state_closed"), false)
		setActive(findTF(arg_72_0.battleItems[iter_72_0], "state_clear"), false)
		setActive(findTF(arg_72_0.battleItems[iter_72_0], "state_current"), false)

		if iter_72_0 <= var_72_0 then
			setActive(findTF(arg_72_0.battleItems[iter_72_0], "state_clear"), true)
		elseif iter_72_0 == var_72_0 + 1 and var_72_1 >= 1 then
			setActive(findTF(arg_72_0.battleItems[iter_72_0], "state_current"), true)
		elseif var_72_0 < iter_72_0 and iter_72_0 <= var_72_0 + var_72_1 then
			setActive(findTF(arg_72_0.battleItems[iter_72_0], "state_open"), true)
		else
			setActive(findTF(arg_72_0.battleItems[iter_72_0], "state_closed"), true)
		end
	end

	arg_72_0.totalTimes = arg_72_0:getGameTotalTime()

	local var_72_2 = 1 - (arg_72_0:getGameUsedTimes() - 3 < 0 and 0 or arg_72_0:getGameUsedTimes() - 3) / (arg_72_0.totalTimes - 4)

	if var_72_2 > 1 then
		var_72_2 = 1
	end

	scrollTo(arg_72_0.battleScrollRect, 0, var_72_2)
	setActive(findTF(arg_72_0.menuUI, "btnStart/tip"), var_72_1 > 0)
	arg_72_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_73_0)
	setActive(findTF(arg_73_0.menuUI, "got"), false)

	if arg_73_0:getUltimate() and arg_73_0:getUltimate() ~= 0 then
		setActive(findTF(arg_73_0.menuUI, "got"), true)
	end

	if arg_73_0:getUltimate() == 0 then
		if arg_73_0:getGameTotalTime() > arg_73_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_73_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_73_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openMenuUI(arg_74_0)
	setActive(findTF(arg_74_0._tf, "scene_front"), false)
	setActive(findTF(arg_74_0._tf, "scene_background"), false)
	setActive(findTF(arg_74_0._tf, "scene"), false)
	setActive(arg_74_0.gameUI, false)
	setActive(arg_74_0.menuUI, true)
	arg_74_0:updateMenuUI()

	return
end

function var_0_0.clearUI(arg_75_0)
	setActive(arg_75_0.sceneTf, false)
	setActive(arg_75_0.settlementUI, false)
	setActive(arg_75_0.countUI, false)
	setActive(arg_75_0.menuUI, false)
	setActive(arg_75_0.gameUI, false)

	return
end

function var_0_0.readyStart(arg_76_0)
	setActive(arg_76_0.countUI, true)
	arg_76_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	return
end

function var_0_0.gameStart(arg_77_0)
	setActive(findTF(arg_77_0._tf, "scene_front"), true)
	setActive(findTF(arg_77_0._tf, "scene_background"), true)
	setActive(findTF(arg_77_0._tf, "scene"), true)
	setActive(arg_77_0.gameUI, true)

	arg_77_0.gameStartFlag = true
	arg_77_0.scoreNum = 0
	arg_77_0.playerPosIndex = 2
	arg_77_0.gameStepTime = 0
	arg_77_0.heart = var_0_27
	arg_77_0.gameTime = var_0_5

	arg_77_0.idolGroupUI:start()
	arg_77_0.giftUI:start()
	arg_77_0:updateGameUI()
	arg_77_0:timerStart()

	return
end

function var_0_0.getGameTimes(arg_78_0)
	return arg_78_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_79_0)
	return arg_79_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_80_0)
	return arg_80_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_81_0)
	return (arg_81_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_82_0, arg_82_1)
	return
end

function var_0_0.onTimer(arg_83_0)
	arg_83_0:gameStep()

	return
end

function var_0_0.gameStep(arg_84_0)
	arg_84_0.gameTime = arg_84_0.gameTime - Time.deltaTime

	if arg_84_0.gameTime < 0 then
		arg_84_0.gameTime = 0
	end

	arg_84_0.gameStepTime = arg_84_0.gameStepTime + Time.deltaTime

	if arg_84_0.idolGroupUI then
		arg_84_0.idolGroupUI:step(arg_84_0.gameStepTime)
	end

	arg_84_0:updateGameUI()

	if arg_84_0.gameTime <= 0 then
		arg_84_0:onGameOver()

		return
	end

	return
end

function var_0_0.timerStart(arg_85_0)
	if not arg_85_0.timer.running then
		arg_85_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_86_0)
	if arg_86_0.timer.running then
		arg_86_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_87_0)
	setText(arg_87_0.textScore, arg_87_0.scoreNum)

	local var_87_0 = math.floor(math.ceil(arg_87_0.gameTime) / 60)

	if var_87_0 < 10 then
		var_87_0 = "0" .. var_87_0
	end

	local var_87_1 = math.floor(math.ceil(arg_87_0.gameTime) % 60)

	if var_87_1 < 10 then
		var_87_1 = "0" .. var_87_1
	end

	for iter_87_0 = 1, #arg_87_0.heartTfs do
		if iter_87_0 <= arg_87_0.heart then
			setActive(arg_87_0.heartTfs[iter_87_0], true)
		else
			setActive(arg_87_0.heartTfs[iter_87_0], false)
		end
	end

	setText(arg_87_0.scoreTf, arg_87_0.scoreNum)
	setText(arg_87_0.gameTimeM, var_87_0)
	setText(arg_87_0.gameTimeS, var_87_1)

	return
end

function var_0_0.loseHeart(arg_88_0)
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

function var_0_0.addScore(arg_89_0, arg_89_1)
	arg_89_0.scoreNum = arg_89_0.scoreNum + arg_89_1

	if arg_89_0.scoreNum < 0 then
		arg_89_0.scoreNum = 0
	end

	return
end

function var_0_0.onGameOver(arg_90_0)
	if arg_90_0.settlementFlag then
		return
	end

	arg_90_0:timerStop()

	arg_90_0.settlementFlag = true

	setActive(arg_90_0.clickMask, true)
	LeanTween.delayedCall(go(arg_90_0._tf), 2, System.Action(function()
		arg_90_0.settlementFlag = false
		arg_90_0.gameStartFlag = false

		setActive(arg_90_0.clickMask, false)
		arg_90_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_92_0)
	setActive(arg_92_0.settlementUI, true)
	GetComponent(findTF(arg_92_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_92_0 = arg_92_0:GetMGData():GetRuntimeData("elements")
	local var_92_1 = arg_92_0.scoreNum

	if var_92_0 and #var_92_0 > 0 then
		local var_92_2 = var_92_0[1] or 0

		setActive(findTF(arg_92_0.settlementUI, "ad/new"), var_92_2 < var_92_1)

		if var_92_2 <= var_92_1 then
			var_92_2 = var_92_1

			arg_92_0:StoreDataToServer({
				var_92_1
			})
		end

		setText(findTF(arg_92_0.settlementUI, "ad/highText"), var_92_2)
		setText(findTF(arg_92_0.settlementUI, "ad/currentText"), var_92_1)

		if arg_92_0:getGameTimes() and arg_92_0:getGameTimes() > 0 then
			local var_92_3 = arg_92_0:getGameUsedTimes() + 1
			local var_92_4 = pg.NewStoryMgr.GetInstance()

			if arg_92_0.storylist[var_92_3] then
				local var_92_5 = arg_92_0.storylist[var_92_3][1] or nil

				if var_92_5 and not var_92_4:IsPlayed(var_92_5) then
					var_92_4:Play(var_92_5)
				end

				arg_92_0.sendSuccessFlag = true

				arg_92_0:SendSuccess(0)

				return
			end
		end
	end
end

function var_0_0.resumeGame(arg_93_0)
	arg_93_0.gameStop = false

	setActive(arg_93_0.leaveUI, false)
	arg_93_0:changeSpeed(1)
	arg_93_0:timerStart()

	return
end

function var_0_0.stopGame(arg_94_0)
	arg_94_0.gameStop = true

	arg_94_0:timerStop()
	arg_94_0:changeSpeed(0)

	return
end

function var_0_0.onBackPressed(arg_95_0)
	if not arg_95_0.gameStartFlag then
		arg_95_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_95_0.settlementFlag then
			return
		end

		if isActive(arg_95_0.pauseUI) then
			setActive(arg_95_0.pauseUI, false)
		end

		arg_95_0:stopGame()
		setActive(arg_95_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_96_0)
	if arg_96_0.handle then
		UpdateBeat:RemoveListener(arg_96_0.handle)
	end

	if arg_96_0._tf and LeanTween.isTweening(go(arg_96_0._tf)) then
		LeanTween.cancel(go(arg_96_0._tf))
	end

	if arg_96_0.timer and arg_96_0.timer.running then
		arg_96_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_96_0.timer = nil

	return
end

return var_0_0

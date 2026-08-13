class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadScene")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._TF = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	local var_1_0 = arg_1_0._TF

	arg_1_0._sceneMask = var_4.Find(var_1_0, "sceneMask")

	local var_1_1 = arg_1_0._TF

	arg_1_0._tpl = var_4.Find(var_1_1, "tpl")

	function arg_1_0._eventCallback(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0

		var_3.onEventHandle(var_2_0, arg_2_0, arg_2_1, arg_2_2)

		return
	end

	CrossRoadRunningData = var_4
	arg_1_0._gameRunningData = var_4.New(arg_1_0._tpl, arg_1_0._sceneMask, arg_1_0._gameVo)
	CrossRoadCarMgr = var_4
	arg_1_0._carMgr = var_4.New(arg_1_0._sceneMask, arg_1_0._gameRunningData, arg_1_0._eventCallback)
	CrossRoadPlayerMgr = var_4
	arg_1_0._playerMgr = var_4.New(arg_1_0._tpl, arg_1_0._gameRunningData, arg_1_0._eventCallback)
	CrossRoadRoleMgr = var_4
	arg_1_0._roleMgr = var_4.New(arg_1_0._tpl, arg_1_0._gameRunningData, arg_1_0._eventCallback)
	CrossRoadItemMgr = var_4
	arg_1_0._itemMgr = var_4.New(arg_1_0._tpl, arg_1_0._gameRunningData, arg_1_0._eventCallback)
	CrossRoadColliderMgr = var_4
	arg_1_0._colliderMgr = var_4.New(arg_1_0._gameRunningData, arg_1_0._eventCallback, arg_1_0._playerMgr)

	arg_1_0:ShowContainer(false)

	return
end

function var_0_0.onEventHandle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	CrossRoadGameConst = var_1_10004

	local var_3_1

	if arg_3_1 == var_1_10004.GET_SCORE then
		local var_3_0 = arg_3_0._event

		var_3_1 = var_3_1.emit
		SimpleMGEvent = var_1_10006

		var_3_1(var_3_0, var_1_10006.ADD_SCORE, {
			score = arg_3_2[1]
		})
	else
		CrossRoadGameConst = var_3_1

		local var_3_3

		if arg_3_1 == var_3_1.HIT_ROLER then
			local var_3_2 = arg_3_0._event

			var_3_3 = var_3_3.emit
			CrossRoadGameView = var_1_10006

			var_3_3(var_3_2, var_1_10006.SUB_LIFE)
		else
			CrossRoadGameConst = var_3_3

			if arg_3_1 == var_3_3.NEW_ROUND then
				if 0 < arg_3_2 then
					local var_3_4 = arg_3_0._itemMgr

					var_4.MakeHongcha(var_3_4)
				end
			else
				CrossRoadGameConst = var_4

				if arg_3_1 == var_4.MAKE_BING_MIAN then
					local var_3_5 = arg_3_0._itemMgr

					var_4.MakeBingMain(var_3_5, arg_3_2)
				else
					CrossRoadGameConst = var_4

					if arg_3_1 == var_4.MAKE_XUAN_WO then
						local var_3_6 = arg_3_0._itemMgr

						var_4.MakeXuanWo(var_3_6, arg_3_2)
					else
						CrossRoadGameConst = var_4

						local var_3_8

						if arg_3_1 == var_4.GET_HONGCHA then
							local var_3_7 = arg_3_0._event

							var_3_8 = var_3_8.emit
							CrossRoadGameView = var_1_10006

							var_3_8(var_3_7, var_1_10006.ADD_LIFE)

							local var_3_9 = arg_3_0._itemMgr

							var_3_8.ClearHongcha(var_3_9)
						else
							CrossRoadGameConst = var_3_8

							if arg_3_1 == var_3_8.ADD_ROLE then
								local var_3_10 = arg_3_0._gameVo

								var_4.AddRoleCnt(var_3_10)
							else
								CrossRoadGameConst = var_4

								if arg_3_1 == var_4.DISPOSE_BIN then
									local var_3_11 = arg_3_0._itemMgr

									var_4.DisposeItemByIndex(var_3_11, arg_3_2)
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_0.Prepare(arg_4_0)
	local var_4_0 = arg_4_0._carMgr

	var_1.Prepare(var_4_0)

	local var_4_1 = arg_4_0._playerMgr

	var_1.Prepare(var_4_1)

	local var_4_2 = arg_4_0._roleMgr

	var_1.Prepare(var_4_2)

	setActive = var_1

	local var_4_3 = arg_4_0._gameRunningData

	var_1(var_2.GetHongChaTpl(var_4_3), false)

	return
end

function var_0_0.Start(arg_5_0)
	arg_5_0:ShowContainer(true)

	return
end

function var_0_0.Step(arg_6_0)
	local var_6_0 = arg_6_0._gameVo
	local var_6_1 = var_1.GetDeltaTime(var_6_0)
	local var_6_2 = arg_6_0._gameVo
	local var_6_3 = var_2.GetJoyStickData(var_6_2)
	local var_6_4 = arg_6_0._gameRunningData

	var_3.SetJoyData(var_6_4, var_6_3)

	local var_6_5 = arg_6_0._itemMgr

	var_3.Step(var_6_5, var_6_1)

	local var_6_6 = arg_6_0._carMgr

	var_3.Step(var_6_6, var_6_1)

	local var_6_7 = arg_6_0._playerMgr

	var_3.Step(var_6_7, var_6_1)

	local var_6_8 = arg_6_0._roleMgr

	var_3.Step(var_6_8, var_6_1)

	local var_6_9 = arg_6_0._colliderMgr

	var_3.Step(var_6_9, var_6_1)

	return
end

function var_0_0.Clear(arg_7_0)
	local var_7_0 = arg_7_0._gameRunningData

	var_1.Clear(var_7_0)

	local var_7_1 = arg_7_0._carMgr

	var_1.Clear(var_7_1)

	local var_7_2 = arg_7_0._playerMgr

	var_1.Clear(var_7_2)

	local var_7_3 = arg_7_0._roleMgr

	var_1.Clear(var_7_3)

	local var_7_4 = arg_7_0._colliderMgr

	var_1.Clear(var_7_4)

	local var_7_5 = arg_7_0._itemMgr

	var_1.Clear(var_7_5)

	return
end

function var_0_0.Dispose(arg_8_0)
	local var_8_0 = arg_8_0._gameRunningData

	var_1.Dispose(var_8_0)

	arg_8_0._gameRunningData = nil

	return
end

function var_0_0.Stop(arg_9_0)
	return
end

function var_0_0.ShowContainer(arg_10_0, arg_10_1)
	SetActive = var_1_10002

	var_1_10002(arg_10_0._sceneMask, arg_10_1)

	return
end

return var_0_0

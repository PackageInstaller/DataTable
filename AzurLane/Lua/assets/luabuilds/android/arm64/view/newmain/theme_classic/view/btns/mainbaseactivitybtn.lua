class = var_0_10000

local var_0_0 = var_0_10000("MainBaseActivityBtn")

var_0_0.UPDATED_TIP = "MainBaseActivityBtn::UPDATED_TIP"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.tpl = arg_1_1
	pg = var_1_10005

	var_1_10005.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0.hideSubImg = arg_1_4

	if arg_1_3 then
		arg_1_0._tf = arg_1_0.tpl
	end

	return
end

function var_0_0.GetLinkConfig(arg_2_0)
	local var_2_0 = arg_2_0:GetEventName()

	pg = var_1_10002

	local var_2_1

	if not var_1_10002.activity_link_button.get_id_list_by_name[var_2_0] then
		var_2_1 = {}
	end

	_ = var_1_10004

	if #var_1_10004.select(var_2_1, function(arg_3_0)
		local var_3_0 = var_0[arg_3_0].time

		type = var_2_10002

		if var_2_10002(var_3_0) == "table" and var_3_0[1] and var_3_0[1] == "default" then
			local var_3_1 = arg_2_0

			return var_2.InActTime(var_3_1, var_3_0[2])
		else
			pg = var_2

			local var_3_2 = var_2.TimeMgr.GetInstance()

			return var_2.inTime(var_3_2, var_3_0)
		end

		return
	end) > 0 then
		table = var_5

		local var_2_2 = var_5.sort
		local var_2_3 = var_4

		CompareFuncs = var_1_10008

		var_2_2(var_2_3, var_1_10008({
			function(arg_4_0)
				return var_0[arg_4_0].order
			end
		}))

		return var_2[var_4[1]]
	end

	return
end

function var_0_0.InActTime(arg_5_0, arg_5_1)
	if arg_5_1 or arg_5_0:GetActivityID() then
		getProxy = var_1_10003
		ActivityProxy = var_1_10005

		local var_5_0 = var_1_10003(var_1_10005)

		return var_3.getActivityById(var_5_0, var_2) and not var_3:isEnd()
	end

	return false
end

function var_0_0.InShowTime(arg_6_0)
	if arg_6_0:GetLinkConfig() ~= nil then
		arg_6_0.config = var_1

		return true
	else
		return false
	end

	return
end

function var_0_0.NewGameObject(arg_7_0)
	local var_7_0

	if not arg_7_0._tf then
		Object = var_7_0
		var_7_0 = var_7_0.Instantiate(arg_7_0.tpl, arg_7_0.tpl.parent).transform
	end

	return var_7_0
end

function var_0_0.Init(arg_8_0, arg_8_1)
	arg_8_0._tf = arg_8_0:NewGameObject()
	arg_8_0._tf.gameObject.name = arg_8_0.__cname

	local var_8_0 = arg_8_0._tf
	local var_8_1 = var_2.Find(var_8_0, "Image")
	local var_8_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_8_0.image = var_8_2(var_8_1, var_5(var_1_10007))

	local var_8_3 = arg_8_0._tf
	local var_8_4 = var_2.Find(var_8_3, "sub_Image")
	local var_8_5 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_8_0.subImage = var_8_5(var_8_4, var_5(var_1_10007))

	local var_8_6 = arg_8_0._tf
	local var_8_7 = var_2.Find(var_8_6, "Tip")
	local var_8_8 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_8_0.tipTr = var_8_8(var_8_7, var_5(var_1_10007))

	local var_8_9 = arg_8_0._tf
	local var_8_10 = var_2.Find(var_8_9, "Tip/Text")
	local var_8_11 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_8_0.tipTxt = var_8_11(var_8_10, var_5(var_1_10007))
	setActive = var_2

	var_2(arg_8_0._tf, true)

	arg_8_0.tipTxt.text = ""

	arg_8_0:InitTipImage()
	arg_8_0:UpdatePosition(arg_8_1)
	arg_8_0:InitSubImage()
	arg_8_0:InitImage(function()
		local var_9_0 = arg_8_0

		var_0.OnInit(var_9_0)

		local var_9_1 = arg_8_0

		var_0.Register(var_9_1)

		return
	end)

	return
end

function var_0_0.Register(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0._tf

	local function var_10_2()
		if arg_10_0.config.type <= 0 then
			local var_11_0 = arg_10_0

			var_0.CustomOnClick(var_11_0)
		else
			local var_11_1 = arg_10_0

			var_0.OnClick(var_11_1)
		end

		return
	end

	SFX_MAIN = var_1_10006

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10006)

	return
end

function var_0_0.OnClick(arg_12_0)
	var_0_0.Skip(arg_12_0, arg_12_0.config)

	return
end

function var_0_0.InitImage(arg_13_0, arg_13_1)
	if not arg_13_0.config.pic or var_2 == arg_13_0.imgName then
		arg_13_1()

		return
	end

	arg_13_0.imgName = var_2
	LoadSpriteAtlasAsync = var_1_10003

	var_1_10003(arg_13_0:ResPath() .. "/" .. var_2, "", function(arg_14_0)
		IsNil = var_2_10001

		if var_2_10001(arg_13_0.image) then
			return
		end

		arg_13_0.image.sprite = arg_14_0

		local var_14_0 = arg_13_0.image

		var_1.SetNativeSize(var_14_0)
		arg_13_1()

		return
	end)

	return
end

function var_0_0.InitSubImage(arg_15_0)
	if arg_15_0.hideSubImg then
		setActive = var_1

		var_1(arg_15_0.subImage.gameObject, false)

		return
	end

	local var_15_0 = arg_15_0.config.text_pic

	setActive = var_1_10002

	var_1_10002(arg_15_0.subImage.gameObject, var_15_0 ~= nil and var_15_0 ~= "")

	if not var_15_0 or var_15_0 == arg_15_0.subImgName then
		return
	end

	arg_15_0.subImgName = var_15_0
	GetImageSpriteFromAtlasAsync = var_1_10002

	var_1_10002(arg_15_0:ResPath() .. "/" .. var_15_0, "", arg_15_0.subImage, true)

	return
end

function var_0_0.GetTipImage(arg_16_0)
	return "tip"
end

function var_0_0.InitTipImage(arg_17_0)
	if not arg_17_0:GetTipImage() or var_1 == arg_17_0.tipImageName then
		return
	end

	arg_17_0.tipImageName = var_1
	GetImageSpriteFromAtlasAsync = var_1_10002

	var_1_10002("LinkButton/" .. var_1, "", arg_17_0.tipTr, true)

	return
end

function var_0_0.UpdatePosition(arg_18_0, arg_18_1)
	local var_18_0 = -20
	local var_18_1 = -150 - (arg_18_1 - 1) * (arg_18_0._tf.sizeDelta.y + var_18_0)
	local var_18_2 = arg_18_0._tf

	Vector2 = var_1_10005
	var_18_2.anchoredPosition = var_1_10005(arg_18_0._tf.anchoredPosition.x, var_18_1, 0)

	return
end

function var_0_0.Clear(arg_19_0)
	if arg_19_0._tf then
		setActive = var_1

		var_1(arg_19_0._tf, false)
	end

	return
end

function var_0_0.emit(arg_20_0, ...)
	local var_20_0 = arg_20_0.event

	var_1.emit(var_20_0, ...)

	return
end

function var_0_0.Dispose(arg_21_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_21_0)

	if arg_21_0._tf then
		Destroy = var_1

		var_1(arg_21_0._tf.gameObject)

		arg_21_0._tf = nil
	end

	return
end

function var_0_0.Skip(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.type

	GAMEUI_BANNER_1 = var_1_10003

	if var_22_0 == var_1_10003 then
		Application = var_22_0

		var_22_0.OpenURL(arg_22_1.param)
	else
		local var_22_1 = arg_22_1.type

		GAMEUI_BANNER_2 = var_1_10003

		if var_22_1 == var_1_10003 then
			var_1_10004 = arg_22_0

			local var_22_2 = arg_22_0.emit

			NewMainMediator = var_1_10005

			var_22_2(var_1_10004, var_1_10005.SKIP_SCENE, arg_22_1.param)
		else
			local var_22_3 = arg_22_1.type

			GAMEUI_BANNER_3 = var_1_10003

			if var_22_3 == var_1_10003 then
				var_1_10004 = arg_22_0

				local var_22_4 = arg_22_0.emit

				NewMainMediator = var_1_10005
				var_1_10005 = var_1_10005.SKIP_ACTIVITY
				tonumber = var_1_10006

				var_22_4(var_1_10004, var_1_10005, var_1_10006(arg_22_1.param))
			else
				local var_22_5 = arg_22_1.type

				GAMEUI_BANNER_4 = var_1_10003

				if var_22_5 == var_1_10003 then
					var_1_10004 = arg_22_0

					local var_22_6 = arg_22_0.emit

					NewMainMediator = var_1_10005

					var_22_6(var_1_10004, var_1_10005.SKIP_SHOP, arg_22_1.param)
				else
					local var_22_7 = arg_22_1.type

					GAMEUI_BANNER_5 = var_1_10003

					if var_22_7 == var_1_10003 then
						-- block empty
					else
						local var_22_8 = arg_22_1.type

						GAMEUI_BANNER_6 = var_1_10003

						if var_22_8 == var_1_10003 then
							var_1_10004 = arg_22_0

							local var_22_9 = arg_22_0.emit

							NewMainMediator = var_1_10005
							var_1_10005 = var_1_10005.GO_SCENE
							SCENE = var_1_10006

							var_22_9(var_1_10004, var_1_10005, var_1_10006.SELTECHNOLOGY)
						else
							local var_22_10 = arg_22_1.type

							GAMEUI_BANNER_7 = var_1_10003

							if var_22_10 == var_1_10003 then
								var_1_10004 = arg_22_0

								local var_22_11 = arg_22_0.emit

								NewMainMediator = var_1_10005

								var_22_11(var_1_10004, var_1_10005.GO_MINI_GAME, arg_22_1.param[1])
							else
								local var_22_12 = arg_22_1.type

								GAMEUI_BANNER_8 = var_1_10003

								if var_22_12 == var_1_10003 then
									getProxy = var_22_12
									GuildProxy = var_1_10004

									local var_22_13 = var_22_12(var_1_10004)

									if var_2.getRawData(var_22_13) then
										local var_22_14 = arg_22_0
										local var_22_15 = arg_22_0.emit

										NewMainMediator = var_1_10005
										var_1_10005 = var_1_10005.GO_SCENE
										SCENE = var_1_10006

										var_22_15(var_22_14, var_1_10005, var_1_10006.GUILD)
									else
										local var_22_16 = arg_22_0
										local var_22_17 = arg_22_0.emit

										NewMainMediator = var_1_10005
										var_1_10005 = var_1_10005.GO_SCENE
										SCENE = var_1_10006

										var_22_17(var_22_16, var_1_10005, var_1_10006.NEWGUILD)
									end
								else
									local var_22_18 = arg_22_1.type

									GAMEUI_BANNER_14 = var_1_10003

									if var_22_18 == var_1_10003 then
										local var_22_19 = arg_22_0
										local var_22_20 = arg_22_0.emit

										NewMainMediator = var_1_10005
										var_1_10005 = var_1_10005.OPEN_KINK_BUTTON_LAYER
										Context = var_1_10006

										local var_22_21 = var_1_10006.New
										local var_22_22 = {}

										_G = var_1_10009
										var_22_22.mediator = var_1_10009[arg_22_1.param.mediator]
										_G = var_9
										var_22_22.viewComponent = var_9[arg_22_1.param.view]

										var_22_20(var_22_19, var_1_10005, var_22_21(var_22_22))
									else
										local var_22_23 = arg_22_1.type

										GAMEUI_BANNER_15 = var_1_10003

										if var_22_23 == var_1_10003 then
											local var_22_24 = arg_22_0
											local var_22_25 = arg_22_0.emit

											NewMainMediator = var_1_10005

											var_22_25(var_22_24, var_1_10005.SKIP_INS)
										else
											local var_22_26 = arg_22_1.type

											GAMEUI_BANNER_16 = var_1_10003

											if var_22_26 == var_1_10003 then
												type = var_22_26

												if var_22_26(arg_22_1.param) == "table" then
													pg = var_2

													local var_22_27 = var_2.NewStoryMgr.GetInstance()

													arg_22_0.IsPlayeds = var_2.IsPlayed(var_22_27, arg_22_1.param[2])

													if not arg_22_0.IsPlayeds then
														pg = var_2

														local var_22_28 = var_2.NewStoryMgr.GetInstance()

														var_2.Play(var_22_28, arg_22_1.param[2], function()
															local var_23_0 = arg_22_0
															local var_23_1 = var_0.emit

															NewMainMediator = var_2_10003

															var_23_1(var_23_0, var_2_10003.SKIP_CORE_ACTIVITY, arg_22_1.param[1])

															return
														end)
													else
														local var_22_29 = arg_22_0
														local var_22_30 = arg_22_0.emit

														NewMainMediator = var_1_10005

														var_22_30(var_22_29, var_1_10005.SKIP_CORE_ACTIVITY, arg_22_1.param[1])
													end
												else
													local var_22_31 = arg_22_0
													local var_22_32 = arg_22_0.emit

													NewMainMediator = var_1_10005

													var_22_32(var_22_31, var_1_10005.SKIP_CORE_ACTIVITY, arg_22_1.param)
												end
											end
										end
									end
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

function var_0_0.ResPath(arg_24_0)
	return "LinkButton"
end

function var_0_0.GetActivityID(arg_25_0)
	assert = var_1_10001

	var_1_10001(false, "策划配置default类型 必须重写这个方法")

	return
end

function var_0_0.CustomOnClick(arg_26_0)
	assert = var_1_10001

	var_1_10001(false, "策划配置type = 0 这个按钮必须自己定义跳转行为")

	return
end

function var_0_0.GetEventName(arg_27_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

function var_0_0.OnInit(arg_28_0)
	return
end

return var_0_0

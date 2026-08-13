class = var_0_10000

local var_0_0 = "WSMapCell"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	cell = "table",
	map = "table",
	rtFog = "userdata",
	transform = "userdata",
	wsMapResource = "table",
	rtAttachments = "userdata",
	maskTimer = "table",
	maskUid = "number",
	wsTimer = "table",
	fogTimer = "table",
	fogUid = "number",
	rtMask = "userdata"
}
var_0_1.Listeners = {
	onUpdate = "Update",
	onUpdateFogImage = "UpdateFogImage"
}

function var_0_1.GetResName()
	return "world_cell"
end

function var_0_1.GetName(arg_2_0, arg_2_1)
	return "cell_" .. arg_2_0 .. "_" .. arg_2_1
end

function var_0_1.Setup(arg_3_0, arg_3_1, arg_3_2)
	assert = var_1_10003

	var_1_10003(arg_3_0.cell == nil)

	arg_3_0.map = arg_3_1
	arg_3_0.cell = arg_3_2

	local var_3_0 = arg_3_0.cell
	local var_3_1 = var_3.AddListener

	WorldMapCell = var_1_10005

	var_3_1(var_3_0, var_1_10005.EventUpdateInFov, arg_3_0.onUpdate)

	local var_3_2 = arg_3_0.cell
	local var_3_3 = var_3.AddListener

	WorldMapCell = var_5

	var_3_3(var_3_2, var_5.EventUpdateDiscovered, arg_3_0.onUpdate)

	local var_3_4 = arg_3_0.cell
	local var_3_5 = var_3.AddListener

	WorldMapCell = var_5

	var_3_5(var_3_4, var_5.EventUpdateFog, arg_3_0.onUpdate)

	local var_3_6 = arg_3_0.cell
	local var_3_7 = var_3.AddListener

	WorldMapCell = var_5

	var_3_7(var_3_6, var_5.EventUpdateFogImage, arg_3_0.onUpdateFogImage)
	arg_3_0:Init()

	return
end

function var_0_1.Dispose(arg_4_0)
	if arg_4_0.fogTimer then
		local var_4_0 = arg_4_0.wsTimer

		var_1.RemoveInMapTimer(var_4_0, arg_4_0.fogTimer)

		arg_4_0.fogTimer = nil
	end

	if arg_4_0.fogUid then
		local var_4_1 = arg_4_0.wsTimer

		var_1.RemoveInMapTween(var_4_1, arg_4_0.fogUid)

		arg_4_0.fogUid = nil
	end

	if arg_4_0.maskTimer then
		local var_4_2 = arg_4_0.wsTimer

		var_1.RemoveInMapTimer(var_4_2, arg_4_0.maskTimer)

		arg_4_0.maskTimer = nil
	end

	if arg_4_0.maskUid then
		local var_4_3 = arg_4_0.wsTimer

		var_1.RemoveInMapTween(var_4_3, arg_4_0.maskUid)

		arg_4_0.maskUid = nil
	end

	clearImageSprite = var_1

	local var_4_4 = arg_4_0.rtFog

	var_1(var_2.Find(var_4_4, "dark_fog"))

	clearImageSprite = var_1

	local var_4_5 = arg_4_0.rtFog

	var_1(var_2.Find(var_4_5, "sairen_fog"))

	setCanvasGroupAlpha = var_1

	var_1(arg_4_0.rtFog, 1)

	local var_4_6 = arg_4_0.cell
	local var_4_7 = var_1.RemoveListener

	WorldMapCell = var_3

	var_4_7(var_4_6, var_3.EventUpdateInFov, arg_4_0.onUpdate)

	local var_4_8 = arg_4_0.cell
	local var_4_9 = var_1.RemoveListener

	WorldMapCell = var_3

	var_4_9(var_4_8, var_3.EventUpdateDiscovered, arg_4_0.onUpdate)

	local var_4_10 = arg_4_0.cell
	local var_4_11 = var_1.RemoveListener

	WorldMapCell = var_3

	var_4_11(var_4_10, var_3.EventUpdateFog, arg_4_0.onUpdate)

	local var_4_12 = arg_4_0.cell
	local var_4_13 = var_1.RemoveListener

	WorldMapCell = var_3

	var_4_13(var_4_12, var_3.EventUpdateFogImage, arg_4_0.onUpdateFogImage)
	arg_4_0:Clear()

	return
end

local function var_0_2(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1.anchoredPosition

	Vector2 = var_1_10005
	arg_5_0.anchoredPosition = var_5_0 + var_1_10005((arg_5_2.column % 3 - 1) * -arg_5_3.x, (arg_5_2.row % 3 - 1) * arg_5_3.y)
	arg_5_0.localScale = arg_5_1.localScale
	setImageSprite = var_4

	local var_5_1 = arg_5_0

	getImageSprite = var_6

	var_4(var_5_1, var_6(arg_5_1), true)

	return
end

function var_0_1.Init(arg_6_0)
	local var_6_0 = arg_6_0.map.theme
	local var_6_1 = arg_6_0.cell
	local var_6_2 = arg_6_0.transform

	var_6_2.name = var_0_1.GetName(var_6_1.row, var_6_1.column)
	var_6_2.anchoredPosition = var_6_0:GetLinePosition(var_6_1.row, var_6_1.column)
	var_6_2.sizeDelta = var_6_0.cellSize

	local var_6_3 = var_6_2

	arg_6_0.rtAttachments = var_6_2.Find(var_6_3, "attachments")

	local var_6_4 = arg_6_0.rtAttachments

	Vector3 = var_6_3
	var_6_4.localEulerAngles = var_6_3(-var_6_0.angle, 0, 0)
	arg_6_0.rtMask = var_6_2:Find("mask")

	local var_6_5 = arg_6_0.rtMask
	local var_6_6 = var_6_0.cellSize

	Vector2 = var_6
	WorldConst = var_7

	local var_6_7 = var_7.LineCross * 2

	WorldConst = var_8
	var_6_5.sizeDelta = var_6_6 + var_6(var_6_7, var_8.LineCross * 2)
	arg_6_0.rtFog = var_6_2:Find("fog")

	local var_6_8 = arg_6_0.map.theme.cellSize + var_4.cellSpace
	local var_6_9 = var_0_2
	local var_6_10 = arg_6_0.rtFog
	local var_6_11 = var_7.Find(var_6_10, "dark_fog")
	local var_6_12 = arg_6_0.wsMapResource.rtDarkFog
	local var_6_13 = var_8.Find

	WorldConst = var_1_10010

	var_6_9(var_6_11, var_6_13(var_6_12, var_1_10010.Pos2FogRes(var_6_1.row, var_6_1.column)), var_6_1, var_6_8)

	local var_6_14 = var_0_2
	local var_6_15 = arg_6_0.rtFog
	local var_6_16 = var_7.Find(var_6_15, "sairen_fog")
	local var_6_17 = arg_6_0.wsMapResource.rtSairenFog
	local var_6_18 = var_8.Find

	WorldConst = var_10

	var_6_14(var_6_16, var_6_18(var_6_17, var_10.Pos2FogRes(var_6_1.row, var_6_1.column)), var_6_1, var_6_8)
	arg_6_0:Update()
	arg_6_0:UpdateFogImage()

	return
end

function var_0_1.Update(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.cell
	local var_7_1 = arg_7_0.map.centerCellFOV
	local var_7_2 = 0
	local var_7_3 = 0
	local var_7_4 = 0

	if var_7_1 then
		math = var_1_10007
		var_7_3 = var_1_10007.sqrt((var_7_1.row - var_7_0.row) * (var_7_1.row - var_7_0.row) + (var_7_1.column - var_7_0.column) * (var_7_1.column - var_7_0.column)) * 0.1
		var_7_4 = 0.2
	end

	if arg_7_1 ~= nil then
		WorldMapCell = var_1_10007

		if arg_7_1 ~= var_1_10007.EventUpdateInFov then
			WorldMapCell = var_1_10007

			if arg_7_1 == var_1_10007.EventUpdateFog then
				setActive = var_1_10007

				local var_7_5 = arg_7_0.rtAttachments
				local var_7_6

				if var_7_0:GetInFOV() then
					var_7_6 = not var_7_0:InFog()
				end

				var_1_10007(var_7_5, var_7_6)
			end

			if arg_7_1 ~= nil then
				WorldMapCell = var_1_10007

				if arg_7_1 == var_1_10007.EventUpdateFog then
					if arg_7_0.fogTimer then
						local var_7_7 = arg_7_0.wsTimer

						var_1_10007.RemoveInMapTimer(var_7_7, arg_7_0.fogTimer)

						arg_7_0.fogTimer = nil
					end

					if arg_7_0.fogUid then
						local var_7_8 = arg_7_0.wsTimer

						var_1_10007.RemoveInMapTween(var_7_8, arg_7_0.fogUid)

						arg_7_0.fogUid = nil
					end

					if var_7_0:InFog() then
						if arg_7_1 and 0 < var_7_3 then
							setCanvasGroupAlpha = var_1_10007

							var_1_10007(arg_7_0.rtFog, 0)

							local var_7_9 = arg_7_0.wsTimer

							arg_7_0.fogTimer = var_1_10007.AddInMapTimer(var_7_9, function()
								local var_8_0 = arg_7_0

								LeanTween = var_2_10001

								local var_8_1 = var_2_10001.alphaCanvas

								GetComponent = var_2_10002

								local var_8_2 = arg_7_0.rtFog

								typeof = var_2_10004
								CanvasGroup = var_2_10005
								var_8_0.fogUid = var_8_1(var_2_10002(var_8_2, var_2_10004(var_2_10005)), 1, var_7_4).uniqueId

								local var_8_3 = arg_7_0.wsTimer

								var_0.AddInMapTween(var_8_3, arg_7_0.fogUid)

								return
							end, var_7_3)

							local var_7_10 = arg_7_0.fogTimer

							var_1_10007.Start(var_7_10)
						else
							setCanvasGroupAlpha = var_1_10007

							var_1_10007(arg_7_0.rtFog, 1)
						end
					elseif arg_7_1 and 0 < var_7_3 then
						local var_7_11 = arg_7_0.wsTimer

						arg_7_0.fogTimer = var_1_10007.AddInMapTimer(var_7_11, function()
							local var_9_0 = arg_7_0

							LeanTween = var_2_10001

							local var_9_1 = var_2_10001.alphaCanvas

							GetComponent = var_2_10002

							local var_9_2 = arg_7_0.rtFog

							typeof = var_2_10004
							CanvasGroup = var_2_10005
							var_9_0.fogUid = var_9_1(var_2_10002(var_9_2, var_2_10004(var_2_10005)), 0, var_7_4).uniqueId

							local var_9_3 = arg_7_0.wsTimer

							var_0.AddInMapTween(var_9_3, arg_7_0.fogUid)

							return
						end, var_7_3)

						local var_7_12 = arg_7_0.fogTimer

						var_1_10007.Start(var_7_12)
					else
						setCanvasGroupAlpha = var_1_10007

						var_1_10007(arg_7_0.rtFog, 0)
					end
				end

				if arg_7_1 ~= nil then
					WorldMapCell = var_1_10007

					if arg_7_1 ~= var_1_10007.EventUpdateInFov then
						WorldMapCell = var_7

						if arg_7_1 == var_7.EventUpdateDiscovered then
							if arg_7_0.maskTimer then
								local var_7_13 = arg_7_0.wsTimer

								var_7.RemoveInMapTimer(var_7_13, arg_7_0.maskTimer)

								arg_7_0.maskTimer = nil
							end

							if arg_7_0.maskUid then
								local var_7_14 = arg_7_0.wsTimer

								var_7.RemoveInMapTween(var_7_14, arg_7_0.maskUid)

								arg_7_0.maskUid = nil
							end

							local var_7_15 = var_7_0

							if var_7_0.GetInFOV(var_7_15) then
								if arg_7_1 and 0 < var_7_3 then
									var_7_15 = arg_7_0.wsTimer
									arg_7_0.maskTimer = var_7.AddInMapTimer(var_7_15, function()
										local var_10_0 = arg_7_0

										LeanTween = var_2_10001
										var_10_0.maskUid = var_2_10001.alpha(arg_7_0.rtMask, 0, var_7_4).uniqueId

										local var_10_1 = arg_7_0.wsTimer

										var_0.AddInMapTween(var_10_1, arg_7_0.maskUid)

										return
									end, var_7_3)
									var_7_15 = arg_7_0.maskTimer

									var_7.Start(var_7_15)
								else
									setImageAlpha = var_7

									var_7(arg_7_0.rtMask, 0)
								end
							else
								local var_7_16 = var_7_0.discovered and 0.3 or 0.8

								if arg_7_1 and 0 < var_7_3 then
									local var_7_17 = arg_7_0.wsTimer

									arg_7_0.maskTimer = var_7_15.AddInMapTimer(var_7_17, function()
										local var_11_0 = arg_7_0

										LeanTween = var_2_10001
										var_11_0.maskUid = var_2_10001.alpha(arg_7_0.rtMask, var_7_16, var_7_4).uniqueId

										local var_11_1 = arg_7_0.wsTimer

										var_0.AddInMapTween(var_11_1, arg_7_0.maskUid)

										return
									end, var_7_3)

									local var_7_18 = arg_7_0.maskTimer

									var_7_15.Start(var_7_18)
								else
									setImageAlpha = var_7_15

									var_7_15(arg_7_0.rtMask, var_7_16)
								end
							end
						end

						return
					end
				end
			end
		end
	end
end

function var_0_1.UpdateFogImage(arg_12_0)
	local var_12_0 = arg_12_0.cell
	local var_12_1 = var_1.LookSairenFog(var_12_0)

	setImageAlpha = var_12_0

	local var_12_2 = arg_12_0.rtFog

	var_12_0(var_4.Find(var_12_2, "dark_fog"), var_12_1 and 0 or 1)

	setImageAlpha = var_12_0

	local var_12_3 = arg_12_0.rtFog

	var_12_0(var_4.Find(var_12_3, "sairen_fog"), var_12_1 and 1 or 0)

	return
end

function var_0_1.GetWorldPos(arg_13_0)
	Vector3 = var_1_10001

	local var_13_0 = var_1_10001.New(arg_13_0.transform.localPosition.x, arg_13_0.transform.localPosition.y, 0)
	local var_13_1 = arg_13_0.transform.parent

	return var_2.TransformPoint(var_13_1, var_13_0)
end

return var_0_1

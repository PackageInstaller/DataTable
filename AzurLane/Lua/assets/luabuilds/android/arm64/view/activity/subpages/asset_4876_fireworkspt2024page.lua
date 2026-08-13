class = var_0_10000

local var_0_0 = "FireworksPt2024Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".FireworksPtPage"))

var_0_1.ANIM_SHOW = {
	{
		70166,
		70167,
		70165,
		70168,
		70169
	},
	{
		70170,
		70172,
		70171,
		70173,
		70174
	},
	{
		70175,
		70176,
		70177,
		70178
	}
}

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.fireBtn

	local function var_1_2()
		pg = var_2_10000

		local var_2_0 = var_2_10000.m02
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.SPRING_FESTIVAL_BACKHILL_2024, {
			openFireworkLayer = true
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

function var_0_1.UpdateFrieworkPanel(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	arg_3_0.fireworkAct = var_2.getActivityById(var_3_0, arg_3_0.fireworkActID)
	assert = var_2

	local var_3_2

	if arg_3_0.fireworkAct then
		local var_3_1 = arg_3_0.fireworkAct

		var_3_2 = not var_4.isEnd(var_3_1)
	end

	var_2(var_3_2, "烟花活动(type92)已结束")

	local var_3_3 = arg_3_0.fireworkAct

	arg_3_0.unlockCount = var_2.getData1(var_3_3)

	local var_3_4 = arg_3_0.fireworkAct

	arg_3_0.unlockIds = var_2.getData1List(var_3_4)

	if #arg_3_0.fireworkPages < arg_3_1 or arg_3_1 < 1 then
		return
	end

	arg_3_0.pageIndex = arg_3_1
	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.fireworkPages) do
		setActive = var_1_10008
		var_1_10010 = iter_3_1
		tonumber = var_1_10011
		var_1_10011 = var_1_10011(iter_3_1.name) == arg_3_1

		var_1_10008(var_1_10010, var_1_10011)
	end

	ipairs = var_3

	for iter_3_2, iter_3_3 in var_3(arg_3_0.dots) do
		setActive = var_1_10008
		var_1_10010 = iter_3_3
		tonumber = var_1_10011
		var_1_10011 = var_1_10011(iter_3_3.name) == arg_3_1

		var_1_10008(var_1_10010, var_1_10011)
	end

	setButtonEnabled = var_3

	var_3(arg_3_0.nextPageBtn, arg_3_1 ~= var_2)

	setButtonEnabled = var_3

	var_3(arg_3_0.lastPageBtn, arg_3_1 ~= 1)

	setText = var_3

	var_3(arg_3_0.fireworkNumText, #arg_3_0.unlockIds .. "/" .. #arg_3_0.fireworkIds)

	getProxy = var_3
	PlayerProxy = var_5

	local var_3_5 = var_3(var_5)
	local var_3_6 = var_3.getRawData(var_3_5)

	arg_3_0.ptNum = var_3.getResource(var_3_6, arg_3_0.ptID)
	setText = var_4

	var_4(arg_3_0.ptText, arg_3_0.ptNum)

	local var_3_7 = arg_3_0:getAnimId()
	local var_3_8 = arg_3_0.unlockCount > 0 and arg_3_0.ptNum >= arg_3_0.ptConsume

	for iter_3_4 = #arg_3_0.fireworkPages, 1, -1 do
		eachChild = var_1_10010

		var_1_10010(arg_3_0.fireworkPages[iter_3_4], function(arg_4_0)
			tonumber = var_2_10001

			local var_4_0 = var_2_10001(arg_4_0.name)

			table = var_2_10002

			if var_2_10002.contains(arg_3_0.unlockIds, var_4_0) then
				setActive = var_2

				var_2(arg_4_0, false)
			else
				setActive = var_2

				var_2(arg_4_0, true)

				if var_3_8 and var_3_7 and var_4_0 == var_3_7 then
					local var_4_1 = arg_3_0

					var_2.playSwingAnim(var_4_1, arg_4_0)
				else
					local var_4_2 = arg_3_0

					var_2.stopSwingAnim(var_4_2, arg_4_0)
				end

				onButton = var_2

				local var_4_3 = arg_3_0
				local var_4_4 = arg_4_0

				local function var_4_5()
					local var_5_0 = arg_3_0

					var_0.OnUnlockClick(var_5_0, var_4_0)

					return
				end

				SFX_PANEL = var_2_10007

				var_2(var_4_3, var_4_4, var_4_5, var_2_10007)
			end

			return
		end)
	end

	return
end

function var_0_1.getAnimId(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(var_0_1.ANIM_SHOW[arg_6_0.pageIndex]) do
		table = var_1_10006

		if not var_1_10006.contains(arg_6_0.unlockIds, iter_6_1) then
			return iter_6_1
		end
	end

	return nil
end

function var_0_1.playSwingAnim(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:Find("pos/Image")
	local var_7_1 = var_2.GetComponent

	typeof = var_5
	Animation = var_1_10007

	local var_7_2 = var_7_1(var_7_0, var_5(var_1_10007))

	var_2.Play(var_7_2, "swing")

	return
end

function var_0_1.stopSwingAnim(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:Find("pos/Image")
	local var_8_1 = var_2.GetComponent

	typeof = var_5
	Animation = var_1_10007

	local var_8_2 = var_8_1(var_8_0, var_5(var_1_10007))

	var_2.Stop(var_8_2)

	return
end

return var_0_1

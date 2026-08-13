class = var_0_10000

local var_0_0 = var_0_10000("InstagramCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_2
	arg_1_0._go = arg_1_1
	tf = var_1_10003
	arg_1_0._tf = var_1_10003(arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.iconTF = var_3.Find(var_1_0, "head/icon")

	local var_1_1 = arg_1_0._tf

	arg_1_0.nameTxt = var_3.Find(var_1_1, "name")

	local var_1_2 = arg_1_0._tf

	arg_1_0.txt = var_3.Find(var_1_2, "Text")

	local var_1_3 = arg_1_0._tf

	arg_1_0.like = var_3.Find(var_1_3, "like/Text")

	local var_1_4 = arg_1_0._tf

	arg_1_0.tip = var_3.Find(var_1_4, "head/tip")

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_3.Find(var_1_5, "image")
	local var_1_7 = var_3.GetComponent

	typeof = var_6
	RawImage = var_1_10008
	arg_1_0.image = var_1_7(var_1_6, var_6(var_1_10008))
	arg_1_0.loading = false
	arg_1_0.needRefresh = false

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.instagram = arg_2_1
	defaultValue = var_1_10003
	arg_2_2 = var_1_10003(arg_2_2, true)
	setImageSprite = var_3

	local var_2_0 = arg_2_0.iconTF

	LoadSprite = var_6

	var_3(var_2_0, var_6("qicon/" .. arg_2_1:GetIcon()), false)

	setText = var_3

	var_3(arg_2_0.nameTxt, arg_2_1:GetName())
	arg_2_0:LoadImage()

	setText = var_3

	var_3(arg_2_0.txt, arg_2_1:GetContent())

	setText = var_3

	var_3(arg_2_0.like, arg_2_1:GetLikeCnt())
	arg_2_0:RemoveTimer()

	if arg_2_2 then
		arg_2_0:AddCommentTimer(arg_2_1)
	end

	setActive = var_3

	var_3(arg_2_0.tip, arg_2_1:ShouldShowTip())

	return
end

function var_0_0.LoadImage(arg_3_0)
	if arg_3_0.loading then
		arg_3_0.needRefresh = true

		return
	end

	arg_3_0.loading = true

	local var_3_0 = arg_3_0.view
	local var_3_1 = var_1.SetImageByUrl
	local var_3_2 = arg_3_0.instagram

	var_3_1(var_3_0, var_4.GetImage(var_3_2), arg_3_0.image, function()
		arg_3_0.loading = false

		if arg_3_0.needRefresh then
			arg_3_0.needRefresh = false

			local var_4_0 = arg_3_0

			var_0.LoadImage(var_4_0)
		end

		return
	end)

	return
end

function var_0_0.AddCommentTimer(arg_5_0, arg_5_1)
	if arg_5_1:GetFastestRefreshTime() then
		pg = var_1_10003

		local var_5_0 = var_1_10003.TimeMgr.GetInstance()
		local var_5_2

		if var_2 - var_3.GetServerTime(var_5_0) <= 0 then
			local var_5_1 = arg_5_0.view

			var_5_2 = var_5_2.emit
			InstagramMediator = var_1_10008

			var_5_2(var_5_1, var_1_10008.ON_COMMENT_LIST_UPDATE, arg_5_1.id)
		else
			Timer = var_5_2
			arg_5_0.timer = var_5_2.New(function()
				local var_6_0 = arg_5_0.view
				local var_6_1 = var_0.emit

				InstagramMediator = var_2_10003

				var_6_1(var_6_0, var_2_10003.ON_COMMENT_LIST_UPDATE, arg_5_1.id)

				return
			end, var_4, 1)

			local var_5_3 = arg_5_0.timer

			var_5.Start(var_5_3)
		end
	end

	return
end

function var_0_0.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		local var_7_0 = arg_7_0.timer

		var_1.Stop(var_7_0)

		arg_7_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveTimer()

	arg_8_0.loading = false
	arg_8_0.needRefresh = false

	return
end

return var_0_0

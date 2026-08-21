local var_0_0 = class("ActivityReforgeBattleResultItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.barGoList_ = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0.type_ = arg_4_1
	arg_4_0.barMinNum_ = arg_4_2
	arg_4_0.levelID_ = arg_4_3
	arg_4_0.curData_ = arg_4_4
	arg_4_0.allPlayerData_ = deepClone(arg_4_5)
	arg_4_0.rangeLength_ = arg_4_6
	arg_4_0.barNum_ = arg_4_0.barMinNum_
	arg_4_0.maxPalyerNum_ = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.allPlayerData_) do
		if iter_4_1 > arg_4_0.maxPalyerNum_ then
			arg_4_0.maxPalyerNum_ = iter_4_1
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.allPlayerData_) do
		if 100 * (iter_4_3 / arg_4_0.maxPalyerNum_) <= 1 then
			arg_4_0.allPlayerData_[iter_4_2] = 0
		end
	end

	for iter_4_4 = #arg_4_0.allPlayerData_, 1, -1 do
		if iter_4_4 > arg_4_0.barMinNum_ then
			if arg_4_0.allPlayerData_[iter_4_4] > 0 then
				arg_4_0.barNum_ = iter_4_4

				break
			end
		else
			break
		end
	end

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.type_ == 1 then
		local var_5_0 = manager.time:DescCTime(arg_5_0.curData_, "%M%S")
		local var_5_1 = var_5_0 % 100
		local var_5_2 = math.floor(var_5_0 / 100) % 100

		if var_5_1 < 10 then
			var_5_1 = "0" .. var_5_1
		end

		if var_5_2 < 10 then
			var_5_2 = "0" .. var_5_2
		end

		arg_5_0.numText_.text = var_5_2 .. ":" .. var_5_1
	else
		arg_5_0.numText_.text = arg_5_0.curData_
	end

	local var_5_3 = arg_5_0.barPanelTrans_.rect.width / arg_5_0.barNum_

	for iter_5_0 = 1, arg_5_0.barNum_ do
		if arg_5_0.barGoList_[iter_5_0] == nil then
			arg_5_0.barGoList_[iter_5_0] = Object.Instantiate(arg_5_0.barGo_, arg_5_0.barPanelTrans_)
		end

		local var_5_4 = arg_5_0.allPlayerData_[iter_5_0] / arg_5_0.maxPalyerNum_ * arg_5_0.barPanelTrans_.rect.height

		arg_5_0.barGoList_[iter_5_0].transform.sizeDelta = Vector2.New(var_5_3, var_5_4)

		local var_5_5 = (iter_5_0 - 1) * arg_5_0.barGoList_[iter_5_0].transform.rect.width

		arg_5_0.barGoList_[iter_5_0].transform.anchoredPosition = Vector3.New(var_5_5, arg_5_0.barGoList_[iter_5_0].transform.anchoredPosition.y, 0)
	end

	for iter_5_1, iter_5_2 in pairs(arg_5_0.barGoList_) do
		if iter_5_1 <= arg_5_0.barNum_ then
			SetActive(arg_5_0.barGoList_[iter_5_1], true)
		else
			SetActive(arg_5_0.barGoList_[iter_5_1], false)
		end
	end

	local var_5_6 = arg_5_0.curData_ / (arg_5_0.barNum_ * arg_5_0.rangeLength_)

	if var_5_6 > 1 then
		var_5_6 = 1
	end

	local var_5_7 = var_5_6 * arg_5_0.barPanelTrans_.rect.width

	arg_5_0.lineTrans_.transform.anchoredPosition = Vector3.New(var_5_7, 0, 0)

	local var_5_8 = ActivityReforgeData:GetBestFinishLevelServerData(arg_5_0.levelID_)
	local var_5_9 = 0

	if arg_5_0.type_ == 1 then
		local var_5_10 = var_5_8.minUseSeconds / (arg_5_0.barNum_ * arg_5_0.rangeLength_)

		if var_5_10 > 1 then
			var_5_10 = 1
		end

		var_5_9 = var_5_10 * arg_5_0.barPanelTrans_.rect.width
	elseif arg_5_0.type_ == 2 then
		local var_5_11 = var_5_8.minLosePoint / (arg_5_0.barNum_ * arg_5_0.rangeLength_)

		if var_5_11 > 1 then
			var_5_11 = 1
		end

		var_5_9 = var_5_11 * arg_5_0.barPanelTrans_.rect.width
	elseif arg_5_0.type_ == 3 then
		local var_5_12 = var_5_8.minUseGold / (arg_5_0.barNum_ * arg_5_0.rangeLength_)

		if var_5_12 > 1 then
			var_5_12 = 1
		end

		var_5_9 = var_5_12 * arg_5_0.barPanelTrans_.rect.width
	end

	arg_5_0.bestLineTrans_.transform.anchoredPosition = Vector3.New(var_5_9, 0, 0)
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.barGoList_) do
		Object.Destroy(iter_6_1)

		arg_6_0.barGoList_[iter_6_0] = nil
	end

	arg_6_0.barGoList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0

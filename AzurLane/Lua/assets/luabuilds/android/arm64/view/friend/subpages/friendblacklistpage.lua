class = var_0_10000

local var_0_0 = "FriendBlackListPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FriendBlackListUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.blackListPanel = var_1.Find(var_2_0, "blacklist_panel")

	local var_2_1 = arg_2_0._tf

	arg_2_0.blacklistTopTF = var_1.Find(var_2_1, "blacklist_view_top")

	return
end

function var_0_1.OnInit(arg_3_0)
	return
end

function var_0_1.UpdateData(arg_4_0, arg_4_1)
	arg_4_0.blackVOs = arg_4_1.blackVOs

	if not arg_4_0.isInit then
		arg_4_0.isInit = true

		arg_4_0:initBlackList()

		if not arg_4_0.blackVOs then
			local var_4_0 = arg_4_0
			local var_4_1 = arg_4_0.emit

			FriendMediator = var_1_10005

			var_4_1(var_4_0, var_1_10005.GET_BLACK_LIST)
		else
			arg_4_0:sortBlackList()
		end
	else
		local var_4_2

		if not arg_4_0.blackVOs then
			var_4_2 = {}
		end

		arg_4_0.blackVOs = var_4_2

		arg_4_0:sortBlackList()
	end

	return
end

function var_0_1.initBlackList(arg_5_0)
	arg_5_0.blackItems = {}

	local var_5_0 = arg_5_0.blackListPanel
	local var_5_1 = var_1.Find(var_5_0, "mask/view")

	arg_5_0.blackRect = var_1.GetComponent(var_5_1, "LScrollRect")

	function arg_5_0.blackRect.onInitItem(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.onInitItem(var_6_0, arg_6_0)

		return
	end

	function arg_5_0.blackRect.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.onUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	return
end

function var_0_1.onInitItem(arg_8_0, arg_8_1)
	FriendBlackListCard = var_1_10002

	local var_8_0 = var_1_10002.New(arg_8_1)

	onButton = var_1_10003

	var_1_10003(arg_8_0, var_8_0.btn, function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		i18n = var_2_10004
		var_9_2.content = var_2_10004("firend_relieve_blacklist_tip", var_8_0.friendVO.name)

		function var_9_2.onYes()
			local var_10_0 = arg_8_0
			local var_10_1 = var_0.emit

			FriendMediator = var_3_10003

			var_10_1(var_10_0, var_3_10003.RELIEVE_BLACKLIST, var_8_0.friendVO.id)

			return
		end

		var_9_1(var_9_0, var_9_2)

		return
	end)

	arg_8_0.blackItems[arg_8_1] = var_8_0

	return
end

function var_0_1.onUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if not arg_11_0.blackItems[arg_11_2] then
		arg_11_0:onInitItem(arg_11_2)

		var_11_0 = arg_11_0.blackItems[arg_11_2]
	end

	local var_11_1 = arg_11_0.blackVOs[arg_11_1 + 1]

	var_11_0:update(var_11_1)

	return
end

function var_0_1.sortBlackList(arg_12_0)
	table = var_1_10001

	var_1_10001.sort(arg_12_0.blackVOs, function(arg_13_0, arg_13_1)
		return arg_13_0.id < arg_13_1.id
	end)

	local var_12_0 = arg_12_0.blackRect

	var_1.SetTotalCount(var_12_0, #arg_12_0.blackVOs, -1)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	pairs = var_1_10001

	local var_14_0

	if not arg_14_0.blackItems then
		var_14_0 = {}
	end

	for iter_14_0, iter_14_1 in var_1_10001(var_14_0) do
		iter_14_1:dispose()
	end

	return
end

return var_0_1

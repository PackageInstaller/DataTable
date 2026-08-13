class = var_0_10000

local var_0_0 = "MainChatRoomView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.MainBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_1:Find("item")

	arg_1_0.items = {
		var_1_0
	}
	arg_1_0.tplInitPosY = var_1_0.anchoredPosition.y
	arg_1_0.MAX_COUNT = 4
	arg_1_0.enableBtn = arg_1_1:Find("enable")
	arg_1_0.disableBtn = arg_1_1:Find("disable")

	local var_1_1 = arg_1_1
	local var_1_2 = arg_1_1.GetComponent

	typeof = var_6
	Button = var_1_10007
	arg_1_0.btn = var_1_2(var_1_1, var_6(var_1_10007))

	local var_1_3 = arg_1_1:Find("empty")
	local var_1_4 = var_4.GetComponent

	typeof = var_6
	Text = var_1_10007
	arg_1_0.empty = var_1_4(var_1_3, var_6(var_1_10007))

	arg_1_0:RegisterEvent(arg_1_2)

	return
end

function var_0_1.RegisterEvent(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.bind

	GAME = var_1_10004

	var_2_1(var_2_0, var_1_10004.REMOVE_LAYERS, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.OnRemoveLayer(var_3_0, arg_3_1.context)

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.bind

	GAME = var_4

	var_2_3(var_2_2, var_4.ANY_CHAT_MSG_UPDATE, function(arg_4_0)
		local var_4_0 = arg_2_0

		var_1.OnUpdateChatMsg(var_4_0)

		return
	end)

	PlayerPrefs = var_2_3

	local var_2_4 = var_2_3.GetInt

	HIDE_CHAT_FLAG = var_2_2
	arg_2_0.hideChatFlag = var_2_4(var_2_2)
	onButton = var_2

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0._tf

	local function var_2_7()
		if not arg_2_0.hideChatFlag or arg_2_0.hideChatFlag ~= 1 then
			local var_5_0 = arg_2_0

			var_0.GoChatView(var_5_0)
		end

		return
	end

	SFX_MAIN = var_1_10006

	var_2(var_2_5, var_2_6, var_2_7, var_1_10006)

	onButton = var_2

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.enableBtn

	local function var_2_10()
		local var_6_0 = arg_2_0

		var_0.SwitchState(var_6_0)

		return
	end

	SFX_MAIN = var_1_10006

	var_2(var_2_8, var_2_9, var_2_10, var_1_10006)

	onButton = var_2

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.disableBtn

	local function var_2_13()
		local var_7_0 = arg_2_0

		var_0.SwitchState(var_7_0)

		return
	end

	SFX_MAIN = var_1_10006

	var_2(var_2_11, var_2_12, var_2_13, var_1_10006)
	arg_2_0:UpdateBtnState()

	return
end

function var_0_1.GoChatView(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.emit

	NewMainMediator = var_1_10003

	var_8_1(var_8_0, var_1_10003.OPEN_CHATVIEW)

	return
end

function var_0_1.SwitchState(arg_9_0)
	local var_9_0

	if arg_9_0.hideChatFlag then
		var_9_0 = arg_9_0.hideChatFlag == 1
	end

	local var_9_1 = var_9_0 and "show_chat_warning" or "hide_chat_warning"

	pg = var_1_10003

	local var_9_2 = var_1_10003.MsgboxMgr.GetInstance()
	local var_9_3 = var_3.ShowMsgBox
	local var_9_4 = {}

	i18n = var_1_10006
	var_9_4.content = var_1_10006(var_9_1)

	function var_9_4.onYes()
		local var_10_0 = var_9_0 and 0 or 1

		PlayerPrefs = var_2_10001

		local var_10_1 = var_2_10001.SetInt

		HIDE_CHAT_FLAG = var_2_10002

		var_10_1(var_2_10002, var_10_0)

		local var_10_2 = arg_9_0

		PlayerPrefs = var_2_10002

		local var_10_3 = var_2_10002.GetInt

		HIDE_CHAT_FLAG = var_3
		var_10_2.hideChatFlag = var_10_3(var_3)

		local var_10_4 = arg_9_0

		var_1.UpdateBtnState(var_10_4)

		return
	end

	var_9_3(var_9_2, var_9_4)

	return
end

function var_0_1.UpdateBtnState(arg_11_0)
	local var_11_0

	if arg_11_0.hideChatFlag then
		var_11_0 = arg_11_0.hideChatFlag == 1
	end

	setActive = var_1_10002

	var_1_10002(arg_11_0.enableBtn, var_11_0)

	setActive = var_1_10002

	var_1_10002(arg_11_0.disableBtn, not var_11_0)

	if var_11_0 then
		arg_11_0:Clear()
	end

	arg_11_0.btn.enabled = not var_11_0

	return
end

function var_0_1.OnRemoveLayer(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.mediator

	NotificationMediator = var_1_10003

	if var_12_0 == var_1_10003 then
		arg_12_0:Update()
	end

	return
end

function var_0_1.OnUpdateChatMsg(arg_13_0)
	arg_13_0:Update()

	return
end

function var_0_1.Init(arg_14_0)
	arg_14_0:Update()

	return
end

function var_0_1.Refresh(arg_15_0)
	arg_15_0:Update()

	return
end

function var_0_1.Update(arg_16_0)
	if arg_16_0.hideChatFlag and arg_16_0.hideChatFlag == 1 then
		return
	end

	getProxy = var_1
	ChatProxy = var_1_10002

	local var_16_0 = var_1(var_1_10002)
	local var_16_1 = var_1.GetAllTypeChatMessages(var_16_0, arg_16_0.MAX_COUNT)

	arg_16_0:UpdateMessages(var_16_1)

	return
end

function var_0_1.InstantiateMsgTpl(arg_17_0, arg_17_1)
	for iter_17_0 = #arg_17_0.items + 1, arg_17_1 do
		Object = var_1_10007
		var_1_10007 = var_1_10007.Instantiate(arg_17_0.items[1], arg_17_0.items[1].parent)
		table = var_8

		var_8.insert(arg_17_0.items, var_1_10007)
	end

	for iter_17_1 = #arg_17_0.items, arg_17_1 + 1, -1 do
		setActive = var_1_10007

		var_1_10007(arg_17_0.items[iter_17_1], false)
	end

	return
end

function var_0_1.UpdateMessages(arg_18_0, arg_18_1)
	arg_18_0:InstantiateMsgTpl(#arg_18_1)

	for iter_18_0 = 1, #arg_18_1 do
		local var_18_0 = arg_18_0.items[iter_18_0]
		local var_18_1 = arg_18_1[iter_18_0]
		local var_18_2 = var_18_0.sizeDelta.y + 14
		local var_18_3 = arg_18_0.tplInitPosY - (iter_18_0 - 1) * var_18_2

		Vector2 = var_10
		var_18_0.anchoredPosition = var_10(var_18_0.anchoredPosition.x, var_18_3)

		arg_18_0:UpdateMessage(var_18_0, var_18_1)
	end

	PLATFORM_CODE = var_2
	PLATFORM_JP = var_3

	local var_18_4 = var_2 == var_3 and #arg_18_1 <= 0 and "ログはありません" or ""

	arg_18_0.empty.text = var_18_4

	return
end

function var_0_1.UpdateMessage(arg_19_0, arg_19_1, arg_19_2)
	setActive = var_1_10003

	var_1_10003(arg_19_1, true)

	findTF = var_1_10003

	local var_19_0 = var_1_10003(arg_19_1, "channel")
	local var_19_1 = var_3.GetComponent(var_19_0, "Image")

	GetSpriteFromAtlas = var_19_0

	local var_19_2 = "channel"

	ChatConst = var_1_10006
	var_19_1.sprite = var_19_0(var_19_2, var_1_10006.GetChannelSprite(arg_19_2.type) .. "_1920")
	findTF = var_4

	local var_19_3 = var_4(arg_19_1, "text")
	local var_19_4 = var_4.GetComponent(var_19_3, "RichText")
	local var_19_5 = arg_19_2.type

	ChatConst = var_6

	if var_19_5 == var_6.ChannelPublic then
		var_19_4.supportRichText = true
		ChatProxy = var_5

		var_5.InjectPublic(var_19_4, arg_19_2, true)
	elseif arg_19_2:IsWorldBossNotify() then
		var_19_4.supportRichText = true

		local var_19_6 = arg_19_2.args.playerName
		local var_19_7 = arg_19_2.args.bossName

		GetPerceptualSize = var_7

		local var_19_8 = var_7(var_19_6 .. var_19_7) - 18
		local var_19_9

		if 0 < var_19_8 then
			GetPerceptualSize = var_19_9
			var_19_9 = var_19_9(var_19_7) - var_19_8
			shortenString = var_10
			var_19_7 = var_10(var_19_7, var_19_9)
		end

		i18n = var_19_9
		var_19_4.text = var_19_9("ad_4", arg_19_2.args.supportType, var_19_6, var_19_7, arg_19_2.args.level)
	else
		var_19_4.supportRichText = arg_19_2.emojiId ~= nil
		var_19_4.text = arg_19_0:MatchEmoji(var_19_4, arg_19_2)
	end

	return
end

function var_0_1.MatchEmoji(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = false
	local var_20_1 = arg_20_2.player.name .. ": " .. arg_20_2.content
	local var_20_2 = false

	string = var_6

	local var_20_3 = var_6.gmatch
	local var_20_4 = var_20_1

	ChatConst = var_1_10008

	for iter_20_0 in var_20_3(var_20_4, var_1_10008.EmojiIconCodeMatch) do
		table = var_1_10011
		var_1_10011 = var_1_10011.contains
		pg = var_1_10012
		var_1_10012 = var_1_10012.emoji_small_template.all
		tonumber = var_1_10013

		if var_1_10011(var_1_10012, var_1_10013(iter_20_0)) then
			var_20_2 = true
			pg = var_1_10011
			var_1_10011 = var_1_10011.emoji_small_template
			tonumber = var_1_10012
			var_1_10011 = var_1_10011[var_1_10012(iter_20_0)]
			LoadSprite = var_1_10012
			var_1_10012 = var_1_10012("emoji/" .. var_1_10011.pic .. "_small", nil)

			arg_20_1:AddSprite(iter_20_0, var_1_10012)
		end
	end

	if not arg_20_2.emojiId then
		if var_20_2 then
			shortenString = var_7

			if not var_7(var_20_1, 16) then
				::label_20_0::

				shortenString = var_7
				var_20_1 = var_7(var_20_1, 20)
			end

			string = var_7

			local var_20_5 = var_7.gsub
			local var_20_6 = var_20_1

			ChatConst = var_9

			return (var_20_5(var_20_6, var_9.EmojiIconCodeMatch, function(arg_21_0)
				table = var_2_10001

				local var_21_0 = var_2_10001.contains

				pg = var_2_10002

				local var_21_1 = var_2_10002.emoji_small_template.all

				tonumber = var_2_10003

				if var_21_0(var_21_1, var_2_10003(arg_21_0)) then
					string = var_1

					return var_1.format("<icon name=%s w=0.7 h=0.7/>", arg_21_0)
				end

				return
			end))
		end
	end
end

function var_0_1.Clear(arg_22_0)
	ipairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0.items) do
		setActive = var_1_10006

		var_1_10006(iter_22_1, false)
	end

	return
end

function var_0_1.GetDirection(arg_23_0)
	Vector2 = var_1_10001

	return var_1_10001(1, 0)
end

return var_0_1

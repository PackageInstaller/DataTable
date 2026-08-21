local var_0_0 = class("IdolTrainPtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = {
	"dafeng_idol",
	"tashigan_idol",
	"daiduo_idol",
	"daqinghuayu_idol",
	"baerdimo_idol",
	"luoen_idol",
	"guanghui_idol",
	"edu_idol"
}

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.skills = arg_1_0.bg:Find("skill")
	arg_1_0.skillBtns = {}

	eachChild(arg_1_0.skills, function(arg_2_0)
		table.insert(arg_1_0.skillBtns, arg_2_0)

		return
	end)

	arg_1_0.getGreyBtn = arg_1_0.bg:Find("get_grey_btn")
	arg_1_0.helpBtn = arg_1_0.bg:Find("help_btn")
	arg_1_0.idol1 = arg_1_0.bg:Find("idol1")
	arg_1_0.idol2 = arg_1_0.bg:Find("idol2")
	arg_1_0.buffInfoBox = arg_1_0._tf:Find("BuffInfoBox")
	arg_1_0.mask = arg_1_0.buffInfoBox:Find("mengban")
	arg_1_0.buffWindow = arg_1_0.buffInfoBox:Find("panel")
	arg_1_0.buffName = arg_1_0.buffWindow:Find("title/name")
	arg_1_0.titleLv = arg_1_0.buffWindow:Find("title/lv")
	arg_1_0.titleIcon = arg_1_0.buffWindow:Find("title/icon")
	arg_1_0.buffTip = arg_1_0.buffWindow:Find("content/tip")
	arg_1_0.desc = arg_1_0.buffWindow:Find("content/desc")
	arg_1_0.buffAwardTF = arg_1_0.buffWindow:Find("award_bg/award")
	arg_1_0.trainWindow = arg_1_0._tf:Find("IdolTrainWindow")
	arg_1_0.trainTitle = arg_1_0.trainWindow:Find("panel/title/Text")
	arg_1_0.trainBtn = arg_1_0.trainWindow:Find("panel/train_btn")
	arg_1_0.trainSkills = arg_1_0.trainWindow:Find("panel/skills")
	arg_1_0.trainSkillBtns = {}

	eachChild(arg_1_0.trainSkills, function(arg_3_0)
		table.insert(arg_1_0.trainSkillBtns, arg_3_0)

		return
	end)

	arg_1_0.info = arg_1_0.trainWindow:Find("panel/info")
	arg_1_0.curBuff = arg_1_0.info:Find("preview/current")
	arg_1_0.nextBuff = arg_1_0.info:Find("preview/next")
	arg_1_0.msgBox = arg_1_0._tf:Find("MsgBox")
	arg_1_0.msgIcon = arg_1_0.msgBox:Find("panel/title/icon")
	arg_1_0.msgContent = arg_1_0.msgBox:Find("panel/content")
	arg_1_0.msgBoxMask = arg_1_0.msgBox:Find("mengban")
	arg_1_0.cancelBtn = arg_1_0.msgBox:Find("panel/cancel_btn")
	arg_1_0.confirmBtn = arg_1_0.msgBox:Find("panel/confirm_btn")
	arg_1_0.tipPanel = arg_1_0._tf:Find("Tip")

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	var_0_0.super.OnFirstFlush(arg_4_0)
	removeOnButton(arg_4_0.getBtn)
	onButton(arg_4_0, arg_4_0.getBtn, function()
		local var_5_0 = arg_4_0.ptData:GetAward()

		if var_5_0.type == DROP_TYPE_RESOURCE and var_5_0.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_5_0.count) then
			table.insert({}, function(arg_6_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
					onYes = arg_6_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			local var_7_0, var_7_1 = arg_4_0.ptData:GetResProgress()

			arg_4_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_4_0.ptData:GetId(),
				arg1 = var_7_1
			})

			if arg_4_0.ptData:CanTrain() then
				arg_4_0:showTrianPanel()
			end

			arg_4_0:playIdolAni()

			return
		end)

		return
	end, SFX_PANEL)
	removeOnButton(arg_4_0.battleBtn)
	onButton(arg_4_0, arg_4_0.battleBtn, function()
		local var_8_0
		local var_8_1

		if arg_4_0.activity:getConfig("config_client") ~= "" then
			var_8_0 = arg_4_0.activity:getConfig("config_client").linkActID

			if var_8_0 then
				var_8_1 = getProxy(ActivityProxy):getActivityById(var_8_0)
			end
		end

		if not var_8_0 then
			arg_4_0:emit(ActivityMediator.BATTLE_OPERA)
		elseif var_8_1 and not var_8_1:isEnd() then
			arg_4_0:emit(ActivityMediator.BATTLE_OPERA)
		else
			arg_4_0:showTip(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	arg_4_0:hideBuffInfoBox()
	onButton(arg_4_0, arg_4_0.mask, function()
		arg_4_0:hideBuffInfoBox()

		return
	end, SFX_PANEL)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.skillBtns) do
		onButton(arg_4_0, iter_4_1, function()
			for iter_10_0, iter_10_1 in ipairs(arg_4_0.ptData:GetCurBuffInfos()) do
				if iter_4_0 == iter_10_1.group then
					arg_4_0:showBuffInfoBox(iter_10_1)
				end
			end

			return
		end, SFX_PANEL)
	end

	local var_4_0, var_4_1 = arg_4_0:getRandomName()

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(var_4_0, true, function(arg_11_0)
		pg.UIMgr.GetInstance():LoadingOff()

		arg_4_0.prefab1 = var_4_0
		arg_4_0.model1 = arg_11_0
		tf(arg_11_0).localScale = Vector3(1, 1, 1)

		arg_11_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_11_0, arg_4_0.idol1)

		return
	end)
	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(var_4_1, true, function(arg_12_0)
		pg.UIMgr.GetInstance():LoadingOff()

		arg_4_0.prefab2 = var_4_1
		arg_4_0.model2 = arg_12_0
		tf(arg_12_0).localScale = Vector3(1, 1, 1)

		arg_12_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_12_0, arg_4_0.idol2)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_13_0)
	local var_13_0 = arg_13_0.ptData:CanTrain()

	if var_13_0 and var_13_0 <= arg_13_0.ptData.level then
		arg_13_0:showTrianPanel()
	end

	local var_13_1, var_13_2, var_13_3 = arg_13_0.ptData:GetLevelProgress()
	local var_13_4, var_13_5, var_13_6 = arg_13_0.ptData:GetResProgress()

	setText(arg_13_0.step, setColorStr("PHASE  " .. var_13_1 .. "/", COLOR_WHITE) .. var_13_2)

	local var_13_7 = var_13_6 >= 1 and setColorStr(var_13_4 .. "/", COLOR_WHITE) or var_13_4 .. "/"

	setText(arg_13_0.progress, var_13_7 .. var_13_5)
	setSlider(arg_13_0.slider, 0, 1, var_13_6)

	local var_13_8 = arg_13_0.ptData:CanGetAward()
	local var_13_9 = arg_13_0.ptData:CanGetNextAward()
	local var_13_10 = arg_13_0.ptData:CanTrain()

	setActive(arg_13_0.battleBtn, arg_13_0.ptData:CanGetMorePt() and not var_13_8 and var_13_9)
	setActive(arg_13_0.getBtn, var_13_8)
	setActive(arg_13_0.getGreyBtn, not var_13_8)
	setActive(arg_13_0.gotBtn, not var_13_9 and not var_13_10)
	updateDrop(arg_13_0.awardTF, (arg_13_0.ptData:GetAward()))
	onButton(arg_13_0, arg_13_0.awardTF, function()
		arg_13_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.ptData:GetCurBuffInfos()) do
		setActive(arg_13_0.skillBtns[iter_13_1.group]:Find("lv1"), false)
		setActive(arg_13_0.skillBtns[iter_13_1.group]:Find("lv2"), false)
		setActive(arg_13_0.skillBtns[iter_13_1.group]:Find("lv3"), false)

		local var_13_11

		if iter_13_1.next then
			setActive(arg_13_0.skillBtns[iter_13_1.group]:Find("lv" .. iter_13_1.lv), true)
		else
			setActive(arg_13_0.skillBtns[iter_13_1.group]:Find("lv3"), true)

			var_13_11 = arg_13_0.skillBtns[iter_13_1.group]:Find("icon")
		end

		setImageSprite(var_13_11, LoadSprite(pg.benefit_buff_template[iter_13_1.id].icon))
	end

	onButton(arg_13_0, arg_13_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("practise_idol_help")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.showTrianPanel(arg_16_0)
	setActive(arg_16_0.trainWindow, true)
	setText(arg_16_0.trainTitle, i18n("upgrade_idol_tip"))

	local var_16_0 = arg_16_0.ptData:GetCurBuffInfos()

	arg_16_0.selectIndex = nil
	arg_16_0.selectBuffId = nil
	arg_16_0.selectBuffLv = nil
	arg_16_0.selectNewBuffId = nil

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.trainSkillBtns) do
		onButton(arg_16_0, iter_16_1, function()
			for iter_17_0, iter_17_1 in ipairs(var_16_0) do
				if iter_16_0 == iter_17_1.group then
					if iter_17_1.next then
						arg_16_0.selectIndex = iter_16_0
						arg_16_0.selectBuffId = iter_17_1.id
						arg_16_0.selectNewBuffId = iter_17_1.next
						arg_16_0.selectBuffLv = iter_17_1.lv
					else
						arg_16_0.selectIndex = nil
						arg_16_0.selectBuffId = nil
						arg_16_0.selectNewBuffId = nil
						arg_16_0.selectBuffLv = nil
					end
				end
			end

			arg_16_0:flushTrainPanel()

			return
		end, SFX_PANEL)
	end

	onButton(arg_16_0, arg_16_0.trainBtn, function()
		arg_16_0:showMsgBox()

		return
	end, SFX_PANEL)
	arg_16_0:flushTrainPanel()

	return
end

function var_0_0.hideTrianPanel(arg_19_0)
	setActive(arg_19_0.trainWindow, false)

	return
end

function var_0_0.flushTrainPanel(arg_20_0)
	local var_20_0 = arg_20_0.ptData:GetCurBuffInfos()

	if var_20_0 then
		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			setActive(arg_20_0.trainSkillBtns[iter_20_1.group]:Find("lv1"), false)
			setActive(arg_20_0.trainSkillBtns[iter_20_1.group]:Find("lv2"), false)
			setActive(arg_20_0.trainSkillBtns[iter_20_1.group]:Find("lv3"), false)

			local var_20_1

			if iter_20_1.next then
				setActive(arg_20_0.trainSkillBtns[iter_20_1.group]:Find("lv" .. iter_20_1.lv), true)
			else
				setActive(arg_20_0.trainSkillBtns[iter_20_1.group]:Find("lv3"), true)

				var_20_1 = arg_20_0.trainSkillBtns[iter_20_1.group]:Find("icon")
			end

			setImageSprite(var_20_1, LoadSprite(pg.benefit_buff_template[iter_20_1.id].icon))
			setText(arg_20_0.trainSkillBtns[iter_20_1.group]:Find("name"), shortenString(pg.benefit_buff_template[iter_20_1.id].name, 7))
		end
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.trainSkillBtns) do
		if iter_20_2 == arg_20_0.selectIndex then
			setActive(iter_20_3:Find("selected"), true)
			setActive(iter_20_3:Find("name"), true)
		else
			setActive(iter_20_3:Find("selected"), false)
			setActive(iter_20_3:Find("name"), false)
		end
	end

	if arg_20_0.selectIndex then
		setActive(arg_20_0.info, true)
		setActive(arg_20_0.trainBtn, true)
		setText(arg_20_0.curBuff, "Lv." .. arg_20_0.selectBuffLv .. pg.benefit_buff_template[arg_20_0.selectBuffId].desc)
		setText(arg_20_0.nextBuff, "Lv." .. arg_20_0.selectBuffLv + 1 .. pg.benefit_buff_template[arg_20_0.selectNewBuffId].desc)
	else
		setActive(arg_20_0.info, false)
		setActive(arg_20_0.trainBtn, false)
	end

	return
end

function var_0_0.showBuffInfoBox(arg_21_0, arg_21_1)
	setText(arg_21_0.buffName, pg.benefit_buff_template[arg_21_1.id].name)
	setText(arg_21_0.desc, pg.benefit_buff_template[arg_21_1.id].desc)
	setText(arg_21_0.buffTip, i18n("upgrade_introduce_tip", pg.benefit_buff_template[arg_21_1.id].name))
	setImageSprite(arg_21_0.titleIcon, LoadSprite(pg.benefit_buff_template[arg_21_1.id].icon))
	updateDrop(arg_21_0.buffAwardTF, arg_21_1.award)
	onButton(arg_21_0, arg_21_0.buffAwardTF, function()
		arg_21_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	if arg_21_1.next then
		setText(arg_21_0.titleLv, "Lv." .. arg_21_1.lv)
		setActive(arg_21_0.buffAwardTF:Find("icon_bg/got_mask"), false)
	else
		setText(arg_21_0.titleLv, "MAX")
		setActive(arg_21_0.buffAwardTF:Find("icon_bg/got_mask"), true)
		removeOnButton(arg_21_0.buffAwardTF)
	end

	setActive(arg_21_0.buffInfoBox, true)

	return
end

function var_0_0.hideBuffInfoBox(arg_23_0)
	setActive(arg_23_0.buffInfoBox, false)

	return
end

function var_0_0.OnDestroy(arg_24_0)
	if arg_24_0.prefab1 and arg_24_0.model1 then
		PoolMgr.GetInstance():ReturnSpineChar(arg_24_0.prefab1, arg_24_0.model1)

		arg_24_0.prefab1 = nil
		arg_24_0.model1 = nil
	end

	if arg_24_0.prefab2 and arg_24_0.model2 then
		PoolMgr.GetInstance():ReturnSpineChar(arg_24_0.prefab2, arg_24_0.model2)

		arg_24_0.prefab2 = nil
		arg_24_0.model2 = nil
	end

	return
end

function var_0_0.getRandomName(arg_25_0)
	local var_25_0 = math.random(#var_0_1)
	local var_25_1

	while var_25_1 == var_25_0 or not var_25_1 do
		var_25_1 = math.random(#var_0_1)
	end

	return var_0_1[var_25_0], var_0_1[var_25_1]
end

function var_0_0.playIdolAni(arg_26_0)
	if arg_26_0.model1 then
		arg_26_0.model1:GetComponent("SpineAnimUI"):SetAction("idol", 0)
	end

	if arg_26_0.model2 then
		arg_26_0.model2:GetComponent("SpineAnimUI"):SetAction("idol", 0)
	end

	return
end

function var_0_0.showMsgBox(arg_27_0)
	if arg_27_0.selectBuffId then
		setActive(arg_27_0.msgBox, true)
		setImageSprite(arg_27_0.msgIcon, LoadSprite(pg.benefit_buff_template[arg_27_0.selectBuffId].icon))
		setText(arg_27_0.msgContent, i18n("practise_idol_tip", pg.benefit_buff_template[arg_27_0.selectBuffId].name))
		onButton(arg_27_0, arg_27_0.msgBoxMask, function()
			arg_27_0:hideMsgBox()

			return
		end, SFX_PANEL)
		onButton(arg_27_0, arg_27_0.cancelBtn, function()
			arg_27_0:hideMsgBox()

			return
		end, SFX_PANEL)
		onButton(arg_27_0, arg_27_0.confirmBtn, function()
			arg_27_0:hideMsgBox()
			arg_27_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 3,
				activity_id = arg_27_0.ptData:GetId(),
				arg1 = arg_27_0.ptData:CanTrain(),
				arg2 = arg_27_0.selectNewBuffId,
				oldBuffId = arg_27_0.selectBuffId
			})
			arg_27_0:hideTrianPanel()
			arg_27_0:showTip(i18n("upgrade_complete_tip"))

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.hideMsgBox(arg_31_0)
	setActive(arg_31_0.msgBox, false)

	return
end

function var_0_0.showTip(arg_32_0, arg_32_1)
	local var_32_0 = cloneTplTo(arg_32_0.tipPanel, arg_32_0._tf)

	setActive(var_32_0, true)
	setText(var_32_0:Find("Text"), arg_32_1)

	var_32_0.transform.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(var_32_0, Vector3(1.8, 0.1, 1), 0.1):setUseEstimatedTime(true)
	LeanTween.scale(var_32_0, Vector3(1.1, 1.1, 1), 0.1):setDelay(0.1):setUseEstimatedTime(true)

	local var_32_1 = GetOrAddComponent(var_32_0, "CanvasGroup")

	Timer.New(function()
		if IsNil(var_32_0) then
			return
		end

		LeanTween.scale(var_32_0, Vector3(0.1, 1.5, 1), 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
			LeanTween.scale(var_32_0, Vector3.zero, 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
				Destroy(var_32_0)

				return
			end))

			return
		end))

		return
	end, 3):Start()

	return
end

return var_0_0

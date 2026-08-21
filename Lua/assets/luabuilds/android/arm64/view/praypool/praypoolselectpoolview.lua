local var_0_0 = class("PrayPoolSelectPoolView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "PrayPoolSelectPoolView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	return
end

function var_0_0.OnBackPress(arg_4_0)
	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.prayProxy = getProxy(PrayProxy)
	arg_5_0.poolToggleList = {}
	arg_5_0.selectedPoolType = nil

	return
end

function var_0_0.initUI(arg_6_0)
	arg_6_0.poolListContainer = arg_6_0._tf:Find("PoolList")
	arg_6_0.poolTpl = arg_6_0._tf:Find("PoolTpl")
	arg_6_0.preBtn = arg_6_0._tf:Find("PreBtn")
	arg_6_0.nextBtn = arg_6_0._tf:Find("NextBtn")
	arg_6_0.nextBtnCom = GetComponent(arg_6_0.nextBtn, "Button")
	arg_6_0.poolList = UIItemList.New(arg_6_0.poolListContainer, arg_6_0.poolTpl)

	arg_6_0.poolList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_7_1 + 1

			setImageSprite(arg_7_2:Find("PoolImg"), GetSpriteFromAtlas("ui/prayselectpoolpage_atlas", "pool" .. arg_7_1 + 1))
			onToggle(arg_6_0, arg_7_2, function(arg_8_0)
				if arg_8_0 then
					arg_6_0.nextBtnCom.interactable = true
					arg_6_0.selectedPoolType = var_7_0

					arg_6_0.prayProxy:setSelectedPoolNum(var_7_0)
				else
					arg_6_0.nextBtnCom.interactable = false
					arg_6_0.selectedPoolType = nil

					arg_6_0.prayProxy:setSelectedPoolNum(nil)
				end

				return
			end, SFX_PANEL)

			arg_6_0.poolToggleList[arg_7_1 + 1] = arg_7_2
		end

		return
	end)
	arg_6_0.poolList:align(#pg.activity_ship_create.all)

	arg_6_0.nextBtnCom.interactable = false

	onButton(arg_6_0, arg_6_0.preBtn, function()
		arg_6_0.prayProxy:updatePageState(PrayProxy.STATE_HOME)
		arg_6_0:emit(PrayPoolConst.SWITCH_TO_HOME_PAGE, PrayProxy.STATE_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.nextBtn, function()
		arg_6_0.prayProxy:updateSelectedPool(arg_6_0.selectedPoolType)
		arg_6_0.prayProxy:updatePageState(PrayProxy.STAGE_SELECT_SHIP)
		arg_6_0:emit(PrayPoolConst.SWITCH_TO_SELECT_SHIP_PAGE, PrayProxy.STAGE_SELECT_SHIP)

		return
	end, SFX_PANEL)
	arg_6_0:Show()

	return
end

function var_0_0.updateUI(arg_11_0)
	local var_11_0 = arg_11_0.prayProxy:getSelectedPoolType()

	if var_11_0 then
		triggerToggle(arg_11_0.poolToggleList[var_11_0], true)
	else
		return
	end

	return
end

return var_0_0

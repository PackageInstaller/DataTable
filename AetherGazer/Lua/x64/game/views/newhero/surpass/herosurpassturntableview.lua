local var_0_0 = class("HeroSurpassTurntableView", ReduxView)
local var_0_1 = math.sqrt
local var_0_2 = math.cos
local var_0_3 = math.pi
local var_0_4 = 180 / var_0_3
local var_0_5 = var_0_3 / 180
local var_0_6 = math.min
local var_0_7 = math.max
local var_0_8 = 30
local var_0_9 = 612
local var_0_10 = 30
local var_0_11 = 4

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
	arg_2_0:InitSurpassList()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.BeginDragFun)))
	arg_3_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.OnDragFun)))
	arg_3_0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.EndDragFun)))
end

function var_0_0.BeginDragFun(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.isCantMove then
		return
	end

	arg_4_0.beginMousePos = Input.mousePosition
end

function var_0_0.OnDragFun(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.isCantMove then
		return
	end

	local var_5_0 = Input.mousePosition
	local var_5_1 = 0

	if arg_5_0.beginMousePos.y - var_5_0.y > var_0_10 then
		var_5_1 = -1
	elseif arg_5_0.beginMousePos.y - var_5_0.y < -var_0_10 then
		var_5_1 = 1
	end

	if var_5_1 ~= 0 and arg_5_0.moveIndex ~= var_5_1 then
		arg_5_0:DragMove(var_5_1)
	end
end

function var_0_0.EndDragFun(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.moveIndex = nil
end

function var_0_0.DragMove(arg_7_0, arg_7_1)
	arg_7_0.moveIndex = arg_7_1

	local var_7_0 = arg_7_0.selectStarStage + arg_7_1

	arg_7_0:AddMoveTween(var_7_0)
end

function var_0_0.DelMoveTween(arg_8_0)
	if arg_8_0.moveTween then
		arg_8_0.moveTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_8_0.moveTween.id)

		arg_8_0.moveTween = nil
	end
end

function var_0_0.UpdateSurpassListShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.surpassList) do
		iter_9_1:GetTransform().localRotation = Quaternion.Euler(0, 0, -arg_9_1.z)

		local var_9_0 = 1
		local var_9_1 = iter_9_0 + (var_0_11 - arg_9_2)
		local var_9_2 = var_0_7(1, var_9_1)
		local var_9_3 = var_0_6(6, var_9_2)
		local var_9_4 = arg_9_0.surpassList[var_9_3] and arg_9_0.surpassList[var_9_3]:GetBeginAlpha() or 1
		local var_9_5 = Mathf.Lerp(arg_9_4[iter_9_0].alpha, var_9_4, arg_9_3)

		iter_9_1:ChangeAlpha(var_9_5)

		if arg_9_2 ~= iter_9_0 then
			local var_9_6 = arg_9_0.surpassList[var_9_3] and arg_9_0.surpassList[var_9_3]:GetBeginScale() or 1
			local var_9_7 = Vector3.one
			local var_9_8 = Mathf.Lerp(arg_9_4[iter_9_0].scale, var_9_6, arg_9_3)

			iter_9_1:SetScale(var_9_8)
		end
	end
end

function var_0_0.AddMoveTween(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 > 6 or arg_10_1 < arg_10_0.beginStar then
		return
	end

	local var_10_0 = Quaternion.Euler(arg_10_0.surpassnodeTrs_.localEulerAngles)
	local var_10_1 = Quaternion.Euler(0, 0, var_0_8 * arg_10_1 - var_0_11 * var_0_10)
	local var_10_2 = false
	local var_10_3 = false
	local var_10_4 = false

	arg_10_0:DelMoveTween()

	if arg_10_1 ~= arg_10_0.selectStarStage then
		arg_10_0.planNodeView:ShowView(false)
	elseif not arg_10_2 then
		arg_10_0.surpassList[arg_10_1]:PlaySelectAni(true)
		arg_10_0:SelectSurpassItem(arg_10_1, arg_10_2)

		var_10_3 = true
	end

	local var_10_5 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.surpassList) do
		var_10_5[iter_10_0] = {}
		var_10_5[iter_10_0].alpha = iter_10_1:GetAlpha()

		local var_10_6 = iter_10_1:GetScale()

		if var_10_6 and var_10_6.x > 1 then
			var_10_6 = Vector3.one
		end

		var_10_5[iter_10_0].scale = var_10_6
	end

	arg_10_0.moveTween = LeanTween.value(0, 1, 0.6):setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
		if arg_11_0 < 0.95 then
			arg_10_0.isCantMove = true
		else
			arg_10_0.isCantMove = false
		end

		if arg_11_0 > 0.45 and not var_10_2 then
			for iter_11_0, iter_11_1 in pairs(arg_10_0.surpassList) do
				if iter_11_0 ~= arg_10_1 then
					iter_11_1:PlayScaleAni(false)
				end
			end

			var_10_2 = true
		end

		if arg_11_0 > 0.7 and not var_10_3 then
			arg_10_0:SelectSurpassItem(arg_10_1, arg_10_2)

			var_10_3 = true
		end

		if arg_11_0 > 0.85 and not var_10_4 then
			arg_10_0.surpassList[arg_10_1]:PlayScaleAni(true)

			var_10_4 = true
		end

		arg_10_0.surpassnodeTrs_.localRotation = Quaternion.Lerp(var_10_0, var_10_1, arg_11_0)

		arg_10_0:UpdateSurpassListShow(arg_10_0.surpassnodeTrs_.localEulerAngles, arg_10_1, arg_11_0, var_10_5)

		arg_10_0.selectStarStage = arg_10_1
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_10_0.isCantMove = false

		if arg_10_0.moveTween then
			arg_10_0.moveTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			arg_10_0.moveTween = nil
		end

		if not arg_10_2 and not arg_10_0.planNodeView:GetSelectIndex() then
			arg_10_0.surpassList[arg_10_1]:PlaySelectAni(true)
		end

		arg_10_0.surpassnodeTrs_.localRotation = var_10_1

		arg_10_0:UpdateSurpassListShow(arg_10_0.surpassnodeTrs_.localEulerAngles, arg_10_1, 1, var_10_5)
	end)):setEase(LeanTweenType.easeOutQuad)
end

function var_0_0.SelectTargetStarStage(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:AddMoveTween(arg_13_1, arg_13_2)
end

function var_0_0.AgainPalyNowAni(arg_14_0)
	if arg_14_0.selectStarStage then
		arg_14_0:AddMoveTween(arg_14_0.selectStarStage, arg_14_0.planNodeView:GetSelectStar())
	end
end

function var_0_0.GetOtherPos(arg_15_0, arg_15_1)
	return var_0_1(arg_15_0.radius * arg_15_0.radius - arg_15_1 * arg_15_1)
end

function var_0_0.GetTargetAnglePos(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 * var_0_5

	local var_16_0 = arg_16_0.radius * var_0_2(arg_16_1)

	return arg_16_0:GetOtherPos(var_16_0), var_16_0
end

function var_0_0.InitSurpassList(arg_17_0)
	arg_17_0.radius = var_0_9
	arg_17_0.surpassList = {}

	for iter_17_0 = 1, 6 do
		local var_17_0 = arg_17_0["btnbigitem" .. iter_17_0 .. "Go_"]
		local var_17_1 = NewHeroSurpassItem.New(arg_17_0, var_17_0)

		var_17_1:SetClickCallBack(function()
			if arg_17_0.selectStarStage ~= iter_17_0 or arg_17_0.planNodeView:GetSelectIndex() then
				arg_17_0:SelectTargetStarStage(iter_17_0)
			end
		end)

		arg_17_0.surpassList[iter_17_0] = var_17_1
	end

	arg_17_0.planNodeView = HeroSurpassPlanNode.New(arg_17_0, arg_17_0.plannodeGo_)

	arg_17_0.planNodeView:SetClickCallBack(function(arg_19_0)
		arg_17_0.surpassList[arg_17_0.selectStarStage]:PlaySelectAni(false)
		arg_17_0:RefreshInfoView(arg_19_0)
	end)
end

function var_0_0.GetTargetSelectPlanStarID(arg_20_0)
	local var_20_0 = HeroStarCfg.get_id_list_by_star[arg_20_0.beginStar]

	return var_20_0 and var_20_0[2] or nil
end

function var_0_0.SelectSurpassItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.surpassList[arg_21_1]

	arg_21_0.planNodeView:RefreshUi(var_21_0:GetStarStage(), arg_21_0.heroInfo)

	if arg_21_1 == arg_21_0.beginStar and not arg_21_2 then
		arg_21_0.planNodeView:ShowAndNotCancelSelect()

		if arg_21_0.selectStarStage == arg_21_1 then
			arg_21_2 = arg_21_0.planNodeView:GetSelectStar()
		end

		if not arg_21_2 then
			arg_21_2 = arg_21_0:GetTargetSelectPlanStarID()
		end
	else
		arg_21_0.planNodeView:ShowView(true)
	end

	if arg_21_2 then
		arg_21_0.planNodeView:ClickPlanItemByStarID(arg_21_2)
		arg_21_0:RefreshInfoView(arg_21_2)
		arg_21_0.surpassList[arg_21_1]:PlaySelectAni(false)
	else
		local var_21_1 = var_21_0:GetStarIdList()
		local var_21_2 = var_21_1 and var_21_1[1] or nil

		arg_21_0:RefreshInfoView(var_21_2)
	end

	arg_21_0.selectStarStage = arg_21_1
end

function var_0_0.RefreshInfoView(arg_22_0, arg_22_1)
	if arg_22_1 and arg_22_0.infoViewRefreshCallback then
		arg_22_0.infoViewRefreshCallback(arg_22_1)
	end
end

function var_0_0.SetInfoShowCallBack(arg_23_0, arg_23_1)
	arg_23_0.infoViewRefreshCallback = arg_23_1
end

function var_0_0.SetHeroId(arg_24_0, arg_24_1)
	arg_24_0.isCantMove = false
	arg_24_0.heroID = arg_24_1
	arg_24_0.heroCfg = HeroCfg[arg_24_1]

	local var_24_0 = HeroStarCfg[arg_24_0.heroCfg.unlock_star].star

	arg_24_0:InitSurpassListShow(var_24_0)
	arg_24_0:RefreshSurpassData()
end

function var_0_0.InitSurpassListShow(arg_25_0, arg_25_1)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in pairs(arg_25_0.surpassList) do
		if iter_25_0 < arg_25_1 then
			iter_25_1:SetActive(false)
		else
			iter_25_1:SetActive(true)
			iter_25_1:SetStarStage(iter_25_0)

			var_25_0 = var_25_0 + 1
		end
	end

	arg_25_0.showNum = var_25_0
	arg_25_0.beginStar = arg_25_1
end

function var_0_0.RefreshSurpassData(arg_26_0)
	arg_26_0.heroInfo = arg_26_0.dataProxy:GetHeroData(arg_26_0.heroID)

	local var_26_0 = arg_26_0.heroInfo.star

	for iter_26_0, iter_26_1 in pairs(arg_26_0.surpassList) do
		iter_26_1:RefreshUI(arg_26_0.heroInfo)
	end

	local var_26_1 = SurpassTools.GetNextSurpassStarID(var_26_0)
	local var_26_2 = HeroStarCfg[var_26_1] or HeroStarCfg[var_26_0]

	if var_26_2.phase == 0 then
		arg_26_0:SelectTargetStarStage(var_26_2.star)
	else
		arg_26_0:SelectTargetStarStage(var_26_2.star, var_26_2.id)
	end
end

function var_0_0.SetDataProxy(arg_27_0, arg_27_1)
	arg_27_0.dataProxy = arg_27_1
end

function var_0_0.OnGoldChange(arg_28_0)
	if arg_28_0.surpassList and arg_28_0.surpassList[arg_28_0.selectStarStage] and arg_28_0.heroInfo then
		local var_28_0 = arg_28_0.surpassList[arg_28_0.selectStarStage]

		arg_28_0.planNodeView:RefreshUi(var_28_0:GetStarStage(), arg_28_0.heroInfo)
	end

	if arg_28_0.heroInfo then
		for iter_28_0, iter_28_1 in pairs(arg_28_0.surpassList or {}) do
			iter_28_1:RefreshUI(arg_28_0.heroInfo)
		end
	end
end

function var_0_0.Dispose(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0.surpassList or {}) do
		if iter_29_1 then
			iter_29_1:Dispose()
		end
	end

	arg_29_0.planNodeView:Dispose()
	arg_29_0:DelMoveTween()
	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0

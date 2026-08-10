local var_0_0 = class("SkuldTravelItemSelectItem", ReduxView)
local var_0_1 = "TextureConfig/EmptyDream/travel/item/"

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if not arg_3_0.lock_ then
			arg_3_0.selecthandler_(arg_3_0.itemid_)
		end
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.islockcontroller_ = ControllerUtil.GetController(arg_5_0.transform_, "islock")
	arg_5_0.selectcontroller_ = ControllerUtil.GetController(arg_5_0.transform_, "select")
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.itemid_ = arg_6_1
	arg_6_0.mapid_ = arg_6_2
	arg_6_0.poltid_ = SkuldTravelData:GetPlotIdByMapIdAndItemId(arg_6_0.mapid_, arg_6_0.itemid_)
	arg_6_0.itemimage_.sprite = pureGetSpriteWithoutAtlas(var_0_1 .. TravelSkuldItemCfg[arg_6_0.itemid_].icon)

	arg_6_0:RefreshLockStatu()
	arg_6_0:RefreshSelectStatu(arg_6_3)
	manager.redPoint:bindUIandKey(arg_6_0.transform_, RedPointConst.TRAVEL_SKULD_TRAVELITEM .. arg_6_0.poltid_)
end

function var_0_0.SetSelecthandler(arg_7_0, arg_7_1)
	arg_7_0.selecthandler_ = arg_7_1
end

function var_0_0.RefreshLockStatu(arg_8_0)
	arg_8_0.lock_ = false

	local var_8_0 = 1
	local var_8_1 = SkuldTravelData:GetAttrib()

	for iter_8_0, iter_8_1 in pairs(TravelSkuldItemCfg[arg_8_0.itemid_].unlock) do
		if iter_8_1 > var_8_1[iter_8_0] then
			arg_8_0.lock_ = true
		end

		if iter_8_1 > 0 then
			SetActive(arg_8_0["attribtext_" .. var_8_0].gameObject, true)

			arg_8_0["attribtext_" .. var_8_0].text = GetTips("TIP_NEED") .. SkuldTravelData:AttribIndexToString(iter_8_0) .. iter_8_1
			var_8_0 = var_8_0 + 1
		end
	end

	for iter_8_2 = var_8_0, 2 do
		SetActive(arg_8_0["attribtext_" .. iter_8_2].gameObject, false)
	end

	arg_8_0.islockcontroller_:SetSelectedState(arg_8_0.lock_ and "true" or "false")
end

function var_0_0.RefreshSelectStatu(arg_9_0, arg_9_1)
	arg_9_0.selectcontroller_:SetSelectedState(arg_9_1 == arg_9_0.itemid_ and "true" or "false")
end

function var_0_0.Dispose(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.transform_, RedPointConst.TRAVEL_SKULD_TRAVELITEM .. arg_10_0.poltid_)

	arg_10_0.selecthandler_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0

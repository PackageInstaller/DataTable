local ReturnerAwardWindow = class("ReturnerAwardWindow", import(".PtAwardWindow"))

local function var_0_1(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.UIlist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_1_0.resTitle = string.gsub(arg_1_0.resTitle, "：", "")

			setText(arg_2_2:Find("title/Text"), "PHASE " .. arg_2_1 + 1)
			setText(arg_2_2:Find("target/Text"), arg_1_2[arg_2_1 + 1])
			setText(arg_2_2:Find("target/title"), arg_1_0.resTitle)

			local var_2_0 = {
				type = arg_1_1[arg_2_1 + 1][1],
				id = arg_1_1[arg_2_1 + 1][2],
				count = arg_1_1[arg_2_1 + 1][3]
			}

			updateDrop(arg_2_2:Find("award"), var_2_0, {
				hideName = true
			})
			onButton(arg_1_0.binder, arg_2_2:Find("award"), function()
				arg_1_0.binder:emit(BaseUI.ON_DROP, var_2_0)

				return
			end, SFX_PANEL)
			setActive(arg_2_2:Find("award/mask"), table.contains(arg_1_3, arg_1_2[arg_2_1 + 1]))

			if arg_2_2:Find("target/icon") and arg_1_0.resIcon and arg_1_0.resIcon ~= "" then
				setActive(arg_2_2:Find("target/icon"), true)
				LoadImageSpriteAsync(arg_1_0.resIcon, arg_2_2:Find("target/icon"), false)
			else
				setActive(arg_2_2:Find("target/icon"), false)
			end
		end

		return
	end)
	arg_1_0.UIlist:align(#arg_1_1)

	return
end

function ReturnerAwardWindow:Show(arg_4_1)
	self.blur = arg_4_1.blur

	local var_4_0 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_4_1.resId
	}):getName()

	self.resTitle, self.cntTitle = i18n("pt_count", var_4_0), i18n("pt_total_count", var_4_0)
	self.cntTitle = string.gsub(self.cntTitle, "：", "")

	self:updateResIcon(arg_4_1.resId, arg_4_1.resIcon, arg_4_1.type)
	var_0_1(self, arg_4_1.dropList, arg_4_1.targets, arg_4_1.fetchList)

	self.totalTxt.text = arg_4_1.count
	self.totalTitleTxt.text = self.cntTitle

	setActive(self._tf, true)

	if self.blur then
		pg.UIMgr.GetInstance():BlurPanel(self._tf)
	end

	return
end

return ReturnerAwardWindow

local KillEnemyAwardWindow = class("KillEnemyAwardWindow", import(".PtAwardWindow"))

local function var_0_1(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.UIlist:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			setText(arg_2_2:Find("title/Text"), "PHASE " .. arg_2_1 + 1)
			setActive(arg_2_2:Find("target/Text"), false)
			setText(arg_2_2:Find("target/title"), arg_1_2[arg_2_1 + 1])
			setActive(arg_2_2:Find("target/icon"), false)

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
			setActive(arg_2_2:Find("award/mask"), arg_2_1 + 1 <= arg_1_3)
		end

		return
	end)
	arg_1_0.UIlist:align(#arg_1_1)

	return
end

function KillEnemyAwardWindow:Show(arg_4_1)
	var_0_1(self, arg_4_1.dropList, arg_4_1.descs, arg_4_1.finishedIndex)
	setActive(self.ptTF, false)
	setActive(self._tf, true)

	return
end

return KillEnemyAwardWindow

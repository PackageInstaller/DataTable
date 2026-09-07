local PtTaskAwardWindow = class("PtTaskAwardWindow", import(".TaskAwardWindow"))

local function var_0_1(arg_1_0)
	local var_1_0 = _.flatten(arg_1_0.tasklist)

	local function var_1_1(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_1_0.tasklist) do
			if type(iter_2_1) == "table" then
				for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
					if iter_2_3 == arg_2_0 then
						return iter_2_0
					end
				end
			elseif arg_2_0 == iter_2_1 then
				return iter_2_0
			end
		end

		return
	end

	local var_1_2 = getProxy(TaskProxy)
	local var_1_3

	for iter_1_0 = #var_1_0, 1, -1 do
		local var_1_4 = var_1_2:getFinishTaskById(var_1_0[iter_1_0])

		if var_1_4 and var_1_4:isReceive() then
			var_1_3 = var_1_0[iter_1_0]
		end
	end

	if not var_1_3 then
		local var_1_5 = arg_1_0.tasklist[math.min(arg_1_0.index, #arg_1_0.tasklist)]

		if var_1_5 then
			var_1_3 = var_1_5
		end
	end

	arg_1_0.UIlist:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = var_1_0[arg_3_1 + 1]
			local var_3_1 = var_1_2:getTaskById(var_1_0[arg_3_1 + 1]) or var_1_2:getFinishTaskById(var_3_0) or Task.New({
				id = var_3_0
			})
			local var_3_2 = GetPerceptualSize(arg_1_0.resTitle)

			if var_3_2 > 15 then
				GetComponent(arg_3_2:Find("target/Text"), typeof(Text)).fontSize = 26
				GetComponent(arg_3_2:Find("target/title"), typeof(Text)).fontSize = 26
			elseif var_3_2 > 12 then
				GetComponent(arg_3_2:Find("target/Text"), typeof(Text)).fontSize = 28
				GetComponent(arg_3_2:Find("target/title"), typeof(Text)).fontSize = 28
			elseif var_3_2 > 10 then
				GetComponent(arg_3_2:Find("target/Text"), typeof(Text)).fontSize = 30
				GetComponent(arg_3_2:Find("target/title"), typeof(Text)).fontSize = 30
			else
				GetComponent(arg_3_2:Find("target/Text"), typeof(Text)).fontSize = 32
				GetComponent(arg_3_2:Find("target/title"), typeof(Text)).fontSize = 32
			end

			setText(arg_3_2:Find("title/Text"), "PHASE " .. var_1_1(var_3_0))
			setText(arg_3_2:Find("target/Text"), var_3_1:getConfig("target_num"))

			if arg_3_2:Find("target/icon") then
				if arg_1_0.resIcon == "" then
					arg_1_0.resIcon = nil
				end

				if arg_1_0.resIcon then
					LoadImageSpriteAsync(arg_1_0.resIcon, arg_3_2:Find("target/icon"), false)
				end

				setActive(arg_3_2:Find("target/icon"), arg_1_0.resIcon)
				setActive(arg_3_2:Find("target/mark"), arg_1_0.resIcon)
			end

			setText(arg_3_2:Find("target/title"), arg_1_0.resTitle)

			local var_3_3 = var_3_1:getConfig("award_display")[1]
			local var_3_4 = {
				type = var_3_3[1],
				id = var_3_3[2],
				count = var_3_3[3]
			}

			updateDrop(arg_3_2:Find("award"), var_3_4)
			onButton(arg_1_0.binder, arg_3_2:Find("award"), function()
				arg_1_0.binder:emit(BaseUI.ON_DROP, var_3_4)

				return
			end, SFX_PANEL)

			local var_3_5 = var_1_3

			if var_1_3 then
				if var_3_0 >= var_1_3 then
					var_3_5 = false
				end

				local var_3_6

				do
					var_3_6 = var_3_1:isReceive() or true
				end
			end

			setActive(arg_3_2:Find("award/mask"), var_3_6)
		end

		return
	end)
	arg_1_0.UIlist:align(#var_1_0)

	return
end

function PtTaskAwardWindow:Show(arg_5_1)
	self.tasklist = arg_5_1.tasklist
	self.ptId = arg_5_1.ptId
	self.totalPt = arg_5_1.totalPt
	self.index = arg_5_1.index or 1
	self.resIcon = nil
	self.resTitle, self.cntTitle = i18n("target_get_tip"), i18n("pt_total_count", "")
	self.cntTitle = string.gsub(self.cntTitle, "：", "")

	self:updateResIcon(arg_5_1.ptId)
	var_0_1(self)

	self.totalTxt.text = self.totalPt
	self.totalTitleTxt.text = self.cntTitle

	Canvas.ForceUpdateCanvases()
	setActive(self._tf, true)

	return
end

return PtTaskAwardWindow

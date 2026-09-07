local SenrankaguraPtPage = class("SenrankaguraPtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = {
	1,
	9,
	19
}
local var_0_2 = {
	"normal1",
	"normal2",
	"normal3"
}
local var_0_3 = {
	"action1",
	"action2"
}
local var_0_4 = {
	"hudongye_leijiPT_yin",
	"hudongye_leijiPT_jin"
}
local var_0_6 = "ui-faguang2"
local var_0_7 = 0.2

function SenrankaguraPtPage:OnInit()
	SenrankaguraPtPage.super.OnInit(self)

	self.maskNode = self.bg:Find("mask")
	self.bgImgTf = self.bg:Find("bg_img")
	self.titleImgTf = self.bg:Find("title_img")
	self.role = self.maskNode:Find("role")
	self.title = self.maskNode:Find("title")
	self.spineAnim = GetComponent(self.role, "SpineAnimUI")

	return
end

function SenrankaguraPtPage:OnFirstFlush()
	SenrankaguraPtPage.super.OnFirstFlush(self)

	local var_2_0 = self:GetBeiBeiStage((self.ptData:GetLevelProgress()))

	self:SetBgImage(var_2_0)
	self.spineAnim:SetAction(var_0_2[var_2_0], 0)
	onButton(self, self.getBtn, function()
		local var_3_0 = {}
		local var_3_1 = self.ptData:GetAward()
		local var_3_2 = getProxy(PlayerProxy):getRawData()
		local var_3_3, var_3_4 = Task.StaticJudgeOverflow(var_3_2.gold, var_3_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_3_1.type,
				var_3_1.id,
				var_3_1.count
			}
		})

		if var_3_3 then
			table.insert(var_3_0, function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_3_4,
					onYes = arg_4_0
				})

				return
			end)
		end

		table.insert(var_3_0, function(arg_5_0)
			self:PlayAnim(arg_5_0)

			return
		end)
		seriesAsync(var_3_0, function()
			local var_6_0, var_6_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_6_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function SenrankaguraPtPage:OnUpdateFlush()
	SenrankaguraPtPage.super.OnUpdateFlush(self)

	return
end

function SenrankaguraPtPage:OnDestroy()
	if self.spineAnim then
		self.spineAnim:SetActionCallBack(nil)

		self.spineAnim = nil
	end

	return
end

function SenrankaguraPtPage:GetBeiBeiStage(arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(var_0_1) do
		if iter_9_1 <= arg_9_1 then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function SenrankaguraPtPage:PlayAnim(arg_10_1)
	if self.spineAnim then
		local var_10_0 = self.ptData:GetLevelProgress()
		local var_10_1 = self:GetBeiBeiStage(var_10_0)
		local var_10_2 = var_0_2[var_10_1]

		if self.playing then
			return
		end

		local var_10_3 = table.indexof(var_0_1, var_10_0)

		if var_10_3 and var_10_3 > 1 then
			self.spineAnim:SetAction(var_0_3[var_10_3 - 1], 0)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
			self.spineAnim:SetActionCallBack(function(arg_11_0)
				if arg_11_0 == "action" then
					self.playing = true
				end

				if arg_11_0 == "finish" then
					self.spineAnim:SetActionCallBack(nil)
					self.spineAnim:SetAction(var_10_2, 0)

					self.playing = false

					self:SetBgImage(var_10_1, var_0_7, arg_10_1)
				end

				return
			end)
		else
			arg_10_1()
		end
	end

	return
end

function SenrankaguraPtPage:SetBgImage(arg_12_1, arg_12_2, arg_12_3)
	arg_12_2 = arg_12_2 or 0

	for iter_12_0 = 1, 3 do
		local var_12_0 = findTF(self.titleImgTf, "img" .. iter_12_0)
		local var_12_1 = iter_12_0 == arg_12_1 and 1 or 0

		LeanTween.alpha(findTF(self.bgImgTf, "img" .. iter_12_0), iter_12_0 == arg_12_1 and 1 or 0, arg_12_2):setEase(LeanTweenType.easeOutQuad)
		LeanTween.alpha(var_12_0, var_12_1, arg_12_2):setEase(LeanTweenType.easeOutQuad)

		if arg_12_2 > 0 and arg_12_1 > 1 then
			setActive(self.bg:Find(var_0_4[arg_12_1 - 1]), true)

			if arg_12_3 then
				LeanTween.delayedCall(1, System.Action(arg_12_3))
			end
		end
	end

	return
end

return SenrankaguraPtPage

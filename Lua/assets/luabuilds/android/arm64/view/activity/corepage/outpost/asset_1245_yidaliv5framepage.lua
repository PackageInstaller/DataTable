local YidaliV5FramePage = class("YidaliV5FramePage", import("view.activity.CorePage.CoreNewFrameTemplatePage"))

function YidaliV5FramePage:OnInit()
	self.AD = self._tf:Find("AD")
	self.btnGroup = self.AD:Find("btnGroup")
	self.battleBtn = self.btnGroup:Find("battle_btn")
	self.getBtn = self.btnGroup:Find("get_btn")
	self.gotBtn = self.btnGroup:Find("got_btn")
	self.switcher = self.AD:Find("switcher")
	self.switchBtn = self.switcher:Find("switch_btn")
	self.phases = {
		self.switcher:Find("phase1"),
		self.switcher:Find("phase2")
	}
	self.pas2Img = self.phases[2]:Find("Image")
	self.barContent = self.pas2Img:Find("barContent")
	self.bar = self.barContent:Find("bar")
	self.cur = self.barContent:Find("step")
	self.target = self.barContent:Find("progress")
	self.gotTag = self.pas2Img:Find("award/got")
	self.phaseAnim = self.switcher:GetComponent(typeof(Animation))
	self.animClip1 = "anim_YidaliV5FramePage_switcher"
	self.animClip2 = "anim_YidaliV5FramePage_switcher2"

	return
end

function YidaliV5FramePage:InitBtnLocalText()
	setText(self.getBtn:Find("Text"), i18n("YidaliV5FramePage_get"))
	setText(self.gotBtn:Find("Text"), i18n("YidaliV5FramePage_got"))
	setText(self.battleBtn:Find("Text"), i18n("YidaliV5FramePage_go"))

	return
end

function YidaliV5FramePage:OnFirstFlush()
	self.phaseAnim.playAutomatically = false

	self:InitBtnLocalText()

	for iter_3_0, iter_3_1 in ipairs(self.phases) do
		setActive(iter_3_1, true)

		GetOrAddComponent(iter_3_1, typeof(CanvasGroup)).alpha = 0
	end

	YidaliV5FramePage.super.OnFirstFlush(self)

	return
end

function YidaliV5FramePage:OnUpdateFlush()
	YidaliV5FramePage.super.OnUpdateFlush(self)

	return
end

function YidaliV5FramePage:Switch(arg_5_1)
	self.isSwitching = true

	setToggleEnabled(self.switchBtn, false)

	local var_5_0
	local var_5_1

	if arg_5_1 then
		var_5_1 = self.phases[2]
		var_5_0 = self.phases[1]

		quickPlayAnimation(self.switcher, self.animClip1)
	else
		var_5_1 = self.phases[1]
		var_5_0 = self.phases[2]

		quickPlayAnimation(self.switcher, self.animClip2)
	end

	var_5_1:SetAsLastSibling()
	setCanvasGroupAlpha(GetOrAddComponent(var_5_0, typeof(CanvasGroup)), 0)
	setCanvasGroupAlpha(GetOrAddComponent(var_5_1, typeof(CanvasGroup)), 1)

	self.isSwitching = nil

	setToggleEnabled(self.switchBtn, true)

	return
end

return YidaliV5FramePage

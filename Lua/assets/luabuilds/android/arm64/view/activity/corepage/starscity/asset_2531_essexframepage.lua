local EssexFramePage = class("EssexFramePage", import("view.activity.CorePage.CoreNewFrameTemplatePage"))

function EssexFramePage:OnInit()
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
	self.gotTag = self.pas2Img:Find("got")
	self.animClip1 = "anim_EssexFramePage_switcher"
	self.animClip2 = "anim_EssexFramePage_switcher2"

	return
end

function EssexFramePage:OnFirstFlush()
	for iter_2_0, iter_2_1 in ipairs(self.phases) do
		setActive(iter_2_1, true)

		GetOrAddComponent(iter_2_1, typeof(CanvasGroup)).alpha = 0
	end

	EssexFramePage.super.OnFirstFlush(self)

	return
end

function EssexFramePage:OnUpdateFlush()
	EssexFramePage.super.OnUpdateFlush(self)

	local var_3_0 = self.activity.data1

	var_3_0 = self.avatarConfig.target < self.activity.data1 and self.avatarConfig.target or var_3_0

	setActive(self.cur, false)
	setText(self.target, var_3_0 .. "/" .. self.avatarConfig.target)

	return
end

function EssexFramePage:Switch(arg_4_1)
	self.isSwitching = true

	setToggleEnabled(self.switchBtn, false)

	local var_4_0
	local var_4_1

	if arg_4_1 then
		var_4_1 = self.phases[2]
		var_4_0 = self.phases[1]

		quickPlayAnimation(self.switcher, self.animClip1)
	else
		var_4_1 = self.phases[1]
		var_4_0 = self.phases[2]

		quickPlayAnimation(self.switcher, self.animClip2)
	end

	var_4_1:SetAsLastSibling()
	setCanvasGroupAlpha(GetOrAddComponent(var_4_0, typeof(CanvasGroup)), 0)
	setCanvasGroupAlpha(GetOrAddComponent(var_4_1, typeof(CanvasGroup)), 1)

	self.isSwitching = nil

	setToggleEnabled(self.switchBtn, true)

	return
end

return EssexFramePage

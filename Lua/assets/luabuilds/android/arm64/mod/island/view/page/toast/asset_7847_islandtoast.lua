local IslandToast = class("IslandToast", import("view.base.BaseSubView"))

IslandToast.TYPE_COMMON = 1
IslandToast.TYPE_STATE = 2

function IslandToast:getUIName()
	return "IslandToastUI"
end

function IslandToast:OnLoaded()
	self.container = self._tf:Find("content")
	self.tpl = self._tf:Find("new")
	self.hideTime = 3

	return
end

function IslandToast:OnInit()
	self.tasks = {}
	self.pools = {}

	return
end

function IslandToast:Show(arg_4_1)
	IslandToast.super.Show(self)
	table.insert(self.tasks, arg_4_1)
	self:SetUp()

	return
end

function IslandToast:SetUp()
	if #self.tasks == 1 then
		self:NextOne()
	end

	return
end

function IslandToast:NewTpl()
	local var_6_0

	if #self.pools == 0 then
		var_6_0 = cloneTplTo(self.tpl, self.container)
	else
		var_6_0 = table.remove(self.pools, #self.pools)

		setParent(var_6_0, self.container)
	end

	setActive(var_6_0, true)

	return var_6_0
end

function IslandToast:ReturnTpl(arg_7_1)
	setActive(arg_7_1, false)
	table.insert(self.pools, arg_7_1)

	return
end

function IslandToast:NextOne()
	if #self.tasks <= 0 then
		self:Hide()

		return
	end

	local var_8_0 = self.tasks[1]
	local var_8_1 = self:NewTpl()

	setActive(var_8_1, true)
	setText(var_8_1:Find("Text"), var_8_0.content)

	var_8_1:Find("icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/IslandUI_atlas", "notice_icon_" .. (var_8_0.type or IslandToast.TYPE_COMMON))

	self:AddTimer(var_8_1)

	return
end

function IslandToast:AddTimer(arg_9_1)
	self.timer = Timer.New(function()
		self.timer:Stop()
		self:ReturnTpl(arg_9_1)
		table.remove(self.tasks, 1)
		self:NextOne()

		return
	end, self.hideTime, 1)

	self.timer:Start()

	return
end

function IslandToast:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return IslandToast

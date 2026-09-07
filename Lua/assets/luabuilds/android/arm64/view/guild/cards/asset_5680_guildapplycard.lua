local GuildApplyCard = class("GuildApplyCard")

function GuildApplyCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = tf(arg_1_1)
	self.nameTF = self.tf:Find("bg/name_bg/Text"):GetComponent(typeof(Text))
	self.lvTF = self.tf:Find("bg/level/Text"):GetComponent(typeof(Text))
	self.lvLabelTF = self.tf:Find("bg/level"):GetComponent(typeof(Text))
	self.countTF = self.tf:Find("bg/count/Text"):GetComponent(typeof(Text))
	self.applyBtn = self.tf:Find("bg/apply_btn")
	self.flagName = self.tf:Find("bg/info/name"):GetComponent(typeof(Text))
	self.flagLabel = self.tf:Find("bg/info/label1"):GetComponent(typeof(Text))
	self.policy = self.tf:Find("bg/info/policy"):GetComponent(typeof(Text))
	self.policyLabel = self.tf:Find("bg/info/label2"):GetComponent(typeof(Text))
	self.iconTF = self.tf:Find("bg/icon"):GetComponent(typeof(Image))
	self.nameBG = self.tf:Find("bg/name_bg"):GetComponent(typeof(Image))
	self.print = self.tf:Find("bg/print"):GetComponent(typeof(Image))
	self.bg = self.tf:Find("bg"):GetComponent(typeof(Image))
	self.applyBg = self.applyBtn:GetComponent(typeof(Image))
	self.colorRed = Color(0.7529411764705882, 0.4392156862745098, 0.4627450980392157)
	self.colorBlue = Color(0.6274509803921569, 0.7058823529411765, 0.9764705882352941)

	return
end

function GuildApplyCard:Update(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0
	local var_2_1 = arg_2_1:getFaction()

	if var_2_1 == GuildConst.FACTION_TYPE_BLHX then
		var_2_0 = "blue"
	elseif var_2_1 == GuildConst.FACTION_TYPE_CSZZ then
		var_2_0 = "red"
	end

	self.bg.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "bar_" .. var_2_0)
	self.applyBg.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "apply_" .. var_2_0)
	self.iconTF.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "icon_" .. var_2_0)
	self.nameBG.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "name_" .. var_2_0)
	self.print.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "bar_bg_" .. var_2_0)

	local var_2_2

	if var_2_0 == "red" then
		var_2_2 = self.colorRed or self.colorBlue
	end

	self.lvTF.color = var_2_2
	self.lvLabelTF.color = var_2_2
	self.flagLabel.color = var_2_2
	self.policyLabel.color = var_2_2
	self.guildVO = arg_2_1
	self.nameTF.text = arg_2_1:getName()

	if arg_2_1.level <= 9 then
		self.lvTF.text = "0" .. arg_2_1.level or arg_2_1.level
	end

	self.countTF.text = arg_2_1.memberCount .. "/" .. arg_2_1:getMaxMember()
	self.flagName.text = arg_2_1:getCommader().name
	self.policy.text = arg_2_1:getPolicyName()

	return
end

function GuildApplyCard:Dispose()
	return
end

return GuildApplyCard

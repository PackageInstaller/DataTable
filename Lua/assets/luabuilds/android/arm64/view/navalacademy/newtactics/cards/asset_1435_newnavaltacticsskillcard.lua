local NewNavalTacticsSkillCard = class("NewNavalTacticsSkillCard")

function NewNavalTacticsSkillCard:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.icon = findTF(self._tf, "icon"):GetComponent(typeof(Image))
	self.descTxt = findTF(self._tf, "descView/desc"):GetComponent(typeof(Text))
	self.nextTxt = findTF(self._tf, "next"):GetComponent(typeof(Text))

	return
end

function NewNavalTacticsSkillCard:Enable()
	setActive(self._tf, true)

	return
end

function NewNavalTacticsSkillCard:Disable()
	setActive(self._tf, false)

	return
end

function NewNavalTacticsSkillCard:Update(arg_4_1, arg_4_2)
	changeToScrollText(self._tf:Find("name/Text"), (arg_4_1:GetName()))

	self.descTxt.text = arg_4_1:GetTacticsDesc()

	setText(self._tf:Find("name/level"), "Lv." .. arg_4_1.level .. ((arg_4_2 and arg_4_2 > 0 or nil) and ("  <color=#A9F548FF>+" .. arg_4_2 .. "</color>" or "")))

	self.nextTxt.text = arg_4_1:IsMaxLevel() and "MAX" or "<color=#A9F548FF>" .. arg_4_1.exp .. "</color>/" .. arg_4_1:GetNextLevelExp()

	LoadSpriteAsync("skillicon/" .. arg_4_1:GetIcon(), function(arg_5_0)
		self.icon.sprite = arg_5_0

		return
	end)

	return
end

function NewNavalTacticsSkillCard:Dispose()
	return
end

return NewNavalTacticsSkillCard

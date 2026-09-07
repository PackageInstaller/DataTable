local IslandBaseVisitorCard = class("IslandBaseVisitorCard")

function IslandBaseVisitorCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self.icon = arg_1_1.transform:Find("frame/icon"):GetComponent(typeof(Image))
	self.nameTxt = arg_1_1.transform:Find("name"):GetComponent(typeof(Text))
	self.levelTxt = arg_1_1.transform:Find("level"):GetComponent(typeof(Text))
	self.btn = arg_1_1.transform:Find("btn")
	self.btnTxt = arg_1_1.transform:Find("btn/Text"):GetComponent(typeof(Text))
	self.cardBtn = arg_1_1.transform:Find("frame/icon")

	return
end

function IslandBaseVisitorCard:Update(arg_2_1)
	self.player = arg_2_1

	local var_2_0 = self.icon

	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_2_1.icon
	}):getPrefab(), function(arg_3_0)
		var_2_0.sprite = arg_3_0

		return
	end)

	self.nameTxt.text = arg_2_1.name
	self.levelTxt.text = "LV." .. arg_2_1.level

	return
end

function IslandBaseVisitorCard:Dispose()
	return
end

return IslandBaseVisitorCard

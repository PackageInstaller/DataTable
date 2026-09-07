local DecodeGamePage = class("DecodeGamePage", import(".TemplatePage.SkinTemplatePage"))
local var_0_1

function DecodeGamePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.dayTF = self.bg:Find("Text"):GetComponent(typeof(Text))
	self.item = self.bg:Find("items/item")
	self.items = self.bg:Find("items")
	self.uilist = UIItemList.New(self.items, self.item)
	self.start = self._tf:Find("AD/start")
	self.itemIcon = self._tf:Find("AD/ring/icon")
	self.itemLock = self._tf:Find("AD/ring/lock")
	self.itemGot = self._tf:Find("AD/ring/got")
	self.itemProgressG = self._tf:Find("AD/ring/bar_g")
	self.itemProgressB = self._tf:Find("AD/ring/bar_b")
	self.red = self._tf:Find("AD/red")
	self.number1 = self._tf:Find("AD/1"):GetComponent(typeof(Image))
	self.number2 = self._tf:Find("AD/2"):GetComponent(typeof(Image))

	return
end

function DecodeGamePage:OnFirstFlush()
	DecodeGamePage.super.OnFirstFlush(self)

	var_0_1 = self.activity:getConfig("config_client").decodeGameId

	onButton(self, self.start, function()
		pg.m02:sendNotification(GAME.REQUEST_MINI_GAME, {
			type = MiniGameRequestCommand.REQUEST_HUB_DATA,
			callback = function()
				pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_1)

				return
			end
		})

		return
	end, SFX_PANEL)
	GetImageSpriteFromAtlasAsync("equips/" .. Equipment.New({
		id = DecodeGameConst.AWARD[2]
	}):getConfig("icon"), "", self.itemIcon)

	return
end

function DecodeGamePage:GetProgressColor()
	return "#E6F9FD", "#738285"
end

function DecodeGamePage:OnUpdateFlush()
	DecodeGamePage.super.OnUpdateFlush(self)

	self.dayTF.text = self.nday .. "/7"

	pg.m02:sendNotification(GAME.REQUEST_MINI_GAME, {
		type = MiniGameRequestCommand.REQUEST_HUB_DATA,
		callback = function()
			self:UpdateGameProgress()

			return
		end
	})

	return
end

function DecodeGamePage:UpdateGameProgress()
	local var_8_0 = getProxy(MiniGameProxy)
	local var_8_1 = DecodeGameModel.New()

	var_8_1:SetData((DecodeMiniGameView.GetData(var_8_0:GetHubByGameId(var_0_1), (var_8_0:GetMiniGameData(var_0_1)))))

	local var_8_2 = var_8_1:GetUnlockedCnt()

	if var_8_2 < DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN * DecodeGameConst.MAX_MAP_COUNT then
		setFillAmount(self.itemProgressB, var_8_2 * DecodeGameConst.PROGRESS2FILLAMOUMT)
	else
		setFillAmount(self.itemProgressB, 1)
	end

	local var_8_3 = {
		0.212,
		0.538,
		1
	}
	local var_8_4 = 0

	for iter_8_0, iter_8_1 in ipairs((var_8_1:GetPassWordProgress())) do
		if iter_8_1 then
			var_8_4 = var_8_4 + 1
		end
	end

	setFillAmount(self.itemProgressG, var_8_4 == 0 and 0 or var_8_3[var_8_4])

	local var_8_5 = var_8_1.isFinished

	setActive(self.itemLock, not var_8_1.isFinished)
	setActive(self.itemGot, var_8_5)
	self:UpdateCanUseCnt(var_8_1.canUseCnt)
	setActive(self.red, not var_8_5 and self:IsFinishAllTasks())

	return
end

function DecodeGamePage:IsFinishAllTasks()
	return _.all(self.taskGroup[#self.taskGroup], function(arg_10_0)
		return getProxy(TaskProxy):getFinishTaskById(arg_10_0) ~= nil
	end)
end

function DecodeGamePage:UpdateCanUseCnt(arg_11_1)
	local var_11_0 = math.floor(arg_11_1 / 10)
	local var_11_1 = arg_11_1 % 10

	self.number1.sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", var_11_0)
	self.number2.sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", var_11_1)
	tf(self.number1).localPosition = var_11_0 == 1 and Vector3(571, 221.6) or Vector3(551.7, 221.6)
	tf(self.number2).localPosition = var_11_1 == 1 and Vector3(644, 221.6) or Vector3(625.5, 221.6)

	return
end

return DecodeGamePage

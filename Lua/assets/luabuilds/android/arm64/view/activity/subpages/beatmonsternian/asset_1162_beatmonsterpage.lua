local BeatMonsterPage = class("BeatMonsterPage", import("....base.BaseActivityPage"))

function BeatMonsterPage:OnInit()
	self.bg = self._tf:Find("AD")

	return
end

function BeatMonsterPage:OnFirstFlush()
	return
end

function BeatMonsterPage:OnUpdateFlush()
	self:Show()

	local var_3_0 = self:PacketData(self.activity)

	if not self.controller then
		self.controller = BeatMonsterController.New()

		self.controller.mediator:SetUI(self._go)
		self.controller:SetUp(var_3_0, function(arg_4_0)
			self:emit(ActivityMainScene.LOCK_ACT_MAIN, arg_4_0)

			return
		end)
	else
		self.controller:NetData(var_3_0)
	end

	return
end

function BeatMonsterPage:PacketData(arg_5_1)
	local var_5_0 = arg_5_1:GetDataConfig("hp")

	return {
		hp = math.max(var_5_0 - arg_5_1.data3, 0),
		maxHp = var_5_0,
		leftCount = arg_5_1:GetCountForHitMonster(),
		storys = arg_5_1:GetDataConfig("story")
	}
end

function BeatMonsterPage:OnDestroy()
	self.controller:Dispose()

	return
end

return BeatMonsterPage

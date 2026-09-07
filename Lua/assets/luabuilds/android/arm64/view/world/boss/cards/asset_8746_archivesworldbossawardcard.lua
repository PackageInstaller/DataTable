local ArchivesWorldBossAwardCard = class("ArchivesWorldBossAwardCard")

function ArchivesWorldBossAwardCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.itemTF = self._tf:Find("item")
	self.itemMaskTF = self._tf:Find("item/mask")
	self.itemMaskGotTF = self._tf:Find("item/mask/Got")
	self.itemMaskLockTF = self._tf:Find("item/mask/Lock")
	self.pointText = self._tf:Find("point/text")
	self.lockTr = self._tf:Find("lock"):GetComponent(typeof(Text))
	self.gotTr = self._tf:Find("got"):GetComponent(typeof(Text))
	self.getTr = self._tf:Find("get"):GetComponent(typeof(Text))

	setText(self._tf:Find("point/label"), i18n("meta_pt_point"))

	return
end

function ArchivesWorldBossAwardCard:Update(arg_2_1, arg_2_2)
	self.dropInfo = {
		type = arg_2_1.itemInfo[1],
		id = arg_2_1.itemInfo[2],
		count = arg_2_1.itemInfo[3]
	}

	updateDrop(self.itemTF, self.dropInfo, {
		hideName = true
	})
	setText(self.pointText, arg_2_1.target)

	self.lockTr.text = ""
	self.getTr.text = ""
	self.gotTr.text = ""

	local var_2_0 = 0

	if arg_2_2 < arg_2_1.level + 1 then
		var_2_0 = 1
		self.gotTr.text = i18n("meta_award_got")
	elseif arg_2_1.count < arg_2_1.target then
		var_2_0 = 2
		self.lockTr.text = "T-" .. arg_2_2 .. " " .. calcFloor(arg_2_1.target / arg_2_1.unlockPTNum * 100) .. "%"
	else
		self.getTr.text = i18n("meta_award_get")
	end

	setActive(self.itemMaskTF, var_2_0 ~= 0)
	setActive(self.itemMaskGotTF, var_2_0 == 1)
	setActive(self.itemMaskLockTF, var_2_0 == 2)

	return
end

function ArchivesWorldBossAwardCard:Dispose()
	return
end

return ArchivesWorldBossAwardCard

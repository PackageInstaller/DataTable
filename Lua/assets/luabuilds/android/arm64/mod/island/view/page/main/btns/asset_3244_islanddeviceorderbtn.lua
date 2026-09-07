local IslandDeviceOrderBtn = class("IslandDeviceOrderBtn", import(".IslandDeviceBaseBtn"))

function IslandDeviceOrderBtn:Init()
	IslandDeviceOrderBtn.super.Init(self)

	self.normalTxt = self.unlockTF:Find("normal/Text"):GetComponent(typeof(Text))
	self.urgencyTxt = self.unlockTF:Find("urgency/Text"):GetComponent(typeof(Text))

	return
end

function IslandDeviceOrderBtn:FlushDataUI()
	local var_2_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()
	local var_2_1 = var_2_0:GetMaxFinishCount()

	self.normalTxt.text = var_2_1 - var_2_0:GetFinishCnt() .. "/" .. var_2_1
	self.urgencyTxt.text = var_2_0:GetLeftUrgentCnt() .. "/" .. var_2_0:GetMaxUrgentFinishCnt()

	return
end

return IslandDeviceOrderBtn

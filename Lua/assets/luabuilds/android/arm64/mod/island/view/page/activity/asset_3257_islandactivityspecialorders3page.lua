local IslandActivitySpecialOrderS3Page = class("IslandActivitySpecialOrderS3Page", import(".IslandActivitySpecialOrderPage"))

function IslandActivitySpecialOrderS3Page:getTabTipMapList()
	return {
		{
			"island_spoperation_btn_2605_2",
			"island_spoperation_tip_2605_3"
		},
		{
			"island_spoperation_btn_2605_1",
			"island_spoperation_tip_2605_2"
		},
		{
			"island_spoperation_btn_2605_3",
			"island_spoperation_tip_2605_1"
		}
	}
end

function IslandActivitySpecialOrderS3Page:getItemTipPrefix()
	return "island_spoperation_item_2605_"
end

function IslandActivitySpecialOrderS3Page:OnFirstFlush()
	IslandActivitySpecialOrderS3Page.super.OnFirstFlush(self)
	setActive(self.rtTitle:Find("level"), false)

	return
end

return IslandActivitySpecialOrderS3Page

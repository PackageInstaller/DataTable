local IslandActivitySpecialOrderS2Page = class("IslandActivitySpecialOrderS2Page", import(".IslandActivitySpecialOrderPage"))

function IslandActivitySpecialOrderS2Page:getTabTipMapList()
	return {
		{
			"island_spoperation_btn_2602_2",
			"island_spoperation_tip_2602_3"
		},
		{
			"island_spoperation_btn_2602_1",
			"island_spoperation_tip_2602_2"
		},
		{
			"island_spoperation_btn_2602_3",
			"island_spoperation_tip_2602_1"
		}
	}
end

function IslandActivitySpecialOrderS2Page:getItemTipPrefix()
	return "island_spoperation_item_2602_"
end

function IslandActivitySpecialOrderS2Page:OnFirstFlush()
	IslandActivitySpecialOrderS2Page.super.OnFirstFlush(self)
	setActive(self.rtTitle:Find("level"), false)

	return
end

return IslandActivitySpecialOrderS2Page

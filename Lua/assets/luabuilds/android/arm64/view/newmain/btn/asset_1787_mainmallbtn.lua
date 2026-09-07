local MainMallBtn = class("MainMallBtn", import(".MainBaseBtn"))

function MainMallBtn:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainMallBtn.super.Ctor(self, arg_1_1, arg_1_3)

	self.sellTag = findTF(arg_1_2, "sell")
	self.skinTag = findTF(arg_1_2, "skin")
	self.mallTip = findTF(arg_1_2, "tip")

	return
end

function MainMallBtn:OnClick()
	self:OpenMall()

	return
end

function MainMallBtn:OpenMall()
	self:emit(NewMainMediator.GO_SCENE, SCENE.NEW_SHOP)
	pg.m02:sendNotification(GAME.TRACK, TrackConst.GetTrackData(TrackConst.SYSTEM_SHOP, TrackConst.ACTION_ENTER_MAIN, isActive(self.sellTag) or isActive(self.skinTag) or isActive(self.mallTip)))
	PlayerPrefs.SetInt("Tec_Ship_Gift_Enter_Tag", 1)
	PlayerPrefs.Save()

	return
end

return MainMallBtn

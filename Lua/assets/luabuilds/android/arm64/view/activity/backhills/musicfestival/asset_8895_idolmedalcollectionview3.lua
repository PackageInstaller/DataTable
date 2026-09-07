local IdolMedalCollectionView3 = class("IdolMedalCollectionView3", import(".IdolMedalCollectionView2"))

function IdolMedalCollectionView3:GetContainerPositions()
	return {
		0,
		100
	}
end

function IdolMedalCollectionView3:GetActivityID()
	return ActivityConst.MUSIC_FESTIVAL_MEDALCOLLECTION_3
end

function IdolMedalCollectionView3:getUIName()
	return "IdolMedalCollectionUI3"
end

function IdolMedalCollectionView3:didEnter()
	local var_4_0 = math.random()

	setActive(self.bg:Find("1"), var_4_0 >= 0.5)
	setActive(self.bg:Find("2"), var_4_0 < 0.5)
	IdolMedalCollectionView3.super.didEnter(self)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.idol3rd_collection.tip
		})

		return
	end, SFX_PANEL)

	return
end

function IdolMedalCollectionView3:IsShowMainTip()
	return Activity.IsActivityReady(self)
end

return IdolMedalCollectionView3

local Dorm3dCollectAwardLayer = class("Dorm3dCollectAwardLayer", import("view.base.BaseUI"))

function Dorm3dCollectAwardLayer:getUIName()
	return "Dorm3dCollectAwardUI"
end

function Dorm3dCollectAwardLayer:preload(arg_2_1)
	GetSpriteFromAtlasAsync("dorm3dcollection/" .. pg.dorm3d_collection_template[self.contextData.itemId].icon, "", function(arg_3_0)
		self.iconSprite = arg_3_0

		arg_2_1()

		return
	end)

	return
end

function Dorm3dCollectAwardLayer:init()
	onButton(self, self._tf:Find("bg"), function()
		if self.isBlock then
			return
		end

		self:closeView()

		return
	end, SFX_CANCEL)

	self.isBlock = true

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function Dorm3dCollectAwardLayer:onBackPressed()
	if self.isBlock then
		return
	end

	Dorm3dCollectAwardLayer.super.onBackPressed(self)

	return
end

function Dorm3dCollectAwardLayer:didEnter()
	setText(self._tf:Find("panel/name/Text"), pg.dorm3d_collection_template[self.contextData.itemId].name)
	setText(self._tf:Find("panel/desc/content/desc"), pg.dorm3d_collection_template[self.contextData.itemId].desc)

	if pg.dorm3d_collection_template[self.contextData.itemId].award > 0 then
		setText(self._tf:Find("panel/favor/Text"), i18n("dorm3d_collect_favor_plus") .. pg.dorm3d_favor_trigger[pg.dorm3d_collection_template[self.contextData.itemId].award].num)
		setActive(self._tf:Find("panel/favor"), self.contextData.isNew)
	else
		setActive(self._tf:Find("panel/favor"), false)
	end

	setImageSprite(self._tf:Find("panel/icon"), self.iconSprite, true)
	LeanTween.delayedCall(1.5, System.Action(function()
		self.isBlock = false

		return
	end))

	return
end

function Dorm3dCollectAwardLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return Dorm3dCollectAwardLayer

local SkinAtlasBgView = class("SkinAtlasBgView")

function SkinAtlasBgView:Ctor(arg_1_1)
	self._tf = arg_1_1
	self._go = arg_1_1.gameObject
	self.isSpecialBg = false
	self.isloading = false

	return
end

function SkinAtlasBgView:getUIName()
	return self.__cname
end

function SkinAtlasBgView:Init(arg_3_1, arg_3_2, arg_3_3)
	self.ship = arg_3_1

	self:ClearSpecailBg()
	self:SetSpecailBg(self:getShipBgPrint(arg_3_2), arg_3_3)

	return
end

function SkinAtlasBgView:getShipBgPrint(arg_4_1)
	if not arg_4_1 then
		return self.ship:rarity2bgPrintForGet()
	else
		return self.ship:getShipBgPrint()
	end

	return
end

function SkinAtlasBgView:SetSpecailBg(arg_5_1, arg_5_2)
	self.isloading = true

	pg.DynamicBgMgr.GetInstance():LoadBg(self, arg_5_1, self._tf.parent, self._tf, function(arg_6_0)
		self.isSpecialBg = true
		self.isloading = false
		arg_6_0.transform.localPosition = Vector3(0, 0, 200)

		if arg_5_2 then
			arg_5_2()
		end

		return
	end, function()
		self.isloading = false

		if arg_5_2 then
			arg_5_2()
		end

		return
	end)

	return
end

function SkinAtlasBgView:ClearSpecailBg()
	if self.isSpecialBg then
		pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())

		self.isSpecialBg = false
	end

	return
end

function SkinAtlasBgView:IsLoading()
	return self.isloading
end

function SkinAtlasBgView:Clear()
	self:ClearSpecailBg()

	return
end

function SkinAtlasBgView:Dispose()
	self:Clear()

	return
end

return SkinAtlasBgView

local CryptolaliaCard = class("CryptolaliaCard")

function CryptolaliaCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.iconImg = self._tf:Find("icon"):GetComponent(typeof(Image))
	self.nameTxt = self._tf:Find("name"):GetComponent(typeof(Text))
	self.shipNameTxt = self._tf:Find("shipname"):GetComponent(typeof(Text))
	self.timeTxt = self._tf:Find("time"):GetComponent(typeof(Text))
	self.timeCG = self._tf:Find("time"):GetComponent(typeof(CanvasGroup))
	self.selected = self._tf:Find("selected")
	self.stateBtn = self._tf:Find("name/state"):GetComponent(typeof(Image))
	self.stateIcon = self._tf:Find("name/state/icon"):GetComponent(typeof(Image))

	return
end

function CryptolaliaCard:Update(arg_2_1, arg_2_2, arg_2_3)
	self.cryptolalia = arg_2_1

	local var_2_0 = arg_2_1:ShipIcon()

	PoolMgr.GetInstance():GetSprite("SquareIcon/" .. var_2_0, var_2_0, true, function(arg_3_0)
		if self.exited then
			return
		end

		self.iconImg.sprite = arg_3_0

		return
	end)

	local var_2_1 = self:GetColor(arg_2_3)

	self.nameTxt.text = setColorStr(arg_2_1:GetName(), var_2_1)

	local var_2_2 = arg_2_1:GetShipName()

	if utf8.len(var_2_2) >= 11 then
		var_2_2 = utf8.sub(var_2_2, 1, 11) .. "..."
	end

	self.shipNameTxt.text = setColorStr(var_2_2, var_2_1)
	self.timeCG.alpha = arg_2_3 and 1 or 0.7
	self.timeTxt.text = not arg_2_1:IsForever() and arg_2_1:IsLock() and setColorStr(arg_2_1:GetExpiredTimeStr(), var_2_1) or ""

	setActive(self.selected, arg_2_3)

	local var_2_3 = arg_2_1:IsLock()
	local var_2_4 = var_2_3 or not arg_2_1:IsDownloadAllRes()

	setActive(self.stateBtn, var_2_4)

	if var_2_4 then
		local var_2_5 = self:_GetColor(arg_2_3)

		self.stateBtn.color = var_2_5
		self.stateIcon.color = var_2_5
		self.stateIcon.sprite = GetSpriteFromAtlas("ui/CryptolaliaUI_atlas", var_2_3 and "list_panel_lock" or "list_panel_download")
	end

	return
end

function CryptolaliaCard:GetColor(arg_4_1)
	return arg_4_1 and "#C33A4A" or "#363737"
end

function CryptolaliaCard:_GetColor(arg_5_1)
	return arg_5_1 and Color.New(0.764, 0.227, 0.29) or Color.New(0.211, 0.215, 0.215)
end

function CryptolaliaCard:Dispose()
	self.exited = true

	return
end

return CryptolaliaCard

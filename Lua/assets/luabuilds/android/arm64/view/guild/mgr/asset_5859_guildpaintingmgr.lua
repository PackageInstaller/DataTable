pg = pg or {}
pg.GuildPaintingMgr = singletonClass("GuildPaintingMgr")

function pg.GuildPaintingMgr.Enter(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	return
end

function pg.GuildPaintingMgr:Update(arg_2_1, arg_2_2, arg_2_3)
	self.isShipPainting = arg_2_3

	self:Show()

	if self.name == arg_2_1 then
		return
	end

	self:Clear()

	if self.isShipPainting then
		setPaintingPrefabAsync(self._tf, arg_2_1, "chuanwu")
	else
		setGuildPaintingPrefabAsync(self._tf, arg_2_1, "chuanwu")
	end

	self.name = arg_2_1

	if arg_2_2 then
		self._tf.localPosition = arg_2_2
	end

	return
end

function pg.GuildPaintingMgr:Show()
	if not IsNil(self._tf) then
		setActive(self._tf, true)
	end

	return
end

function pg.GuildPaintingMgr:Hide()
	if not IsNil(self._tf) then
		setActive(self._tf, false)
	end

	return
end

function pg.GuildPaintingMgr:Clear()
	if self.name then
		if self.isShipPainting then
			retPaintingPrefab(self._tf, self.name)
		else
			retGuildPaintingPrefab(self._tf, self.name)
		end

		self.name = nil
	end

	return
end

function pg.GuildPaintingMgr:Exit()
	self:Clear()

	return
end

return

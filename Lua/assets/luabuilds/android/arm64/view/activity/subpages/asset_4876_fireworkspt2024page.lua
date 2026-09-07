local FireworksPt2024Page = class("FireworksPt2024Page", import(".FireworksPtPage"))

FireworksPt2024Page.ANIM_SHOW = {
	{
		70166,
		70167,
		70165,
		70168,
		70169
	},
	{
		70170,
		70172,
		70171,
		70173,
		70174
	},
	{
		70175,
		70176,
		70177,
		70178
	}
}

function FireworksPt2024Page:OnFirstFlush()
	FireworksPt2024Page.super.OnFirstFlush(self)
	onButton(self, self.fireBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SPRING_FESTIVAL_BACKHILL_2024, {
			openFireworkLayer = true
		})

		return
	end, SFX_PANEL)

	return
end

function FireworksPt2024Page:UpdateFrieworkPanel(arg_3_1)
	self.fireworkAct = getProxy(ActivityProxy):getActivityById(self.fireworkActID)

	assert(self.fireworkAct and not self.fireworkAct:isEnd(), "烟花活动(type92)已结束")

	self.unlockCount = self.fireworkAct:getData1()
	self.unlockIds = self.fireworkAct:getData1List()

	local var_3_0 = #self.fireworkPages

	if #self.fireworkPages < arg_3_1 or arg_3_1 < 1 then
		return
	end

	self.pageIndex = arg_3_1

	for iter_3_0, iter_3_1 in ipairs(self.fireworkPages) do
		setActive(iter_3_1, tonumber(iter_3_1.name) == arg_3_1)
	end

	for iter_3_2, iter_3_3 in ipairs(self.dots) do
		setActive(iter_3_3, tonumber(iter_3_3.name) == arg_3_1)
	end

	setButtonEnabled(self.nextPageBtn, arg_3_1 ~= var_3_0)
	setButtonEnabled(self.lastPageBtn, arg_3_1 ~= 1)
	setText(self.fireworkNumText, #self.unlockIds .. "/" .. #self.fireworkIds)

	self.ptNum = getProxy(PlayerProxy):getRawData():getResource(self.ptID)

	setText(self.ptText, self.ptNum)

	local var_3_1 = self:getAnimId()
	local var_3_2 = self.unlockCount > 0 and self.ptNum >= self.ptConsume

	for iter_3_4 = #self.fireworkPages, 1, -1 do
		eachChild(self.fireworkPages[iter_3_4], function(arg_4_0)
			local var_4_0 = tonumber(arg_4_0.name)

			if table.contains(self.unlockIds, var_4_0) then
				setActive(arg_4_0, false)
			else
				setActive(arg_4_0, true)

				if var_3_2 and var_3_1 and var_4_0 == var_3_1 then
					self:playSwingAnim(arg_4_0)
				else
					self:stopSwingAnim(arg_4_0)
				end

				onButton(self, arg_4_0, function()
					self:OnUnlockClick(var_4_0)

					return
				end, SFX_PANEL)
			end

			return
		end)
	end

	return
end

function FireworksPt2024Page:getAnimId()
	for iter_6_0, iter_6_1 in ipairs(FireworksPt2024Page.ANIM_SHOW[self.pageIndex]) do
		if not table.contains(self.unlockIds, iter_6_1) then
			return iter_6_1
		end
	end

	return nil
end

function FireworksPt2024Page:playSwingAnim(arg_7_1)
	arg_7_1:Find("pos/Image"):GetComponent(typeof(Animation)):Play("swing")

	return
end

function FireworksPt2024Page:stopSwingAnim(arg_8_1)
	arg_8_1:Find("pos/Image"):GetComponent(typeof(Animation)):Stop()

	return
end

return FireworksPt2024Page

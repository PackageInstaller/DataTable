local InstagramCard = class("InstagramCard")

function InstagramCard:Ctor(arg_1_1, arg_1_2)
	self.view = arg_1_2
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.iconTF = self._tf:Find("head/icon")
	self.nameTxt = self._tf:Find("name")
	self.txt = self._tf:Find("Text")
	self.like = self._tf:Find("like/Text")
	self.tip = self._tf:Find("head/tip")
	self.image = self._tf:Find("image"):GetComponent(typeof(RawImage))
	self.loading = false
	self.needRefresh = false

	return
end

function InstagramCard:Update(arg_2_1, arg_2_2)
	self.instagram = arg_2_1
	arg_2_2 = defaultValue(arg_2_2, true)

	setImageSprite(self.iconTF, LoadSprite("qicon/" .. arg_2_1:GetIcon()), false)
	setText(self.nameTxt, arg_2_1:GetName())
	self:LoadImage()
	setText(self.txt, arg_2_1:GetContent())
	setText(self.like, arg_2_1:GetLikeCnt())
	self:RemoveTimer()

	if arg_2_2 then
		self:AddCommentTimer(arg_2_1)
	end

	setActive(self.tip, arg_2_1:ShouldShowTip())

	return
end

function InstagramCard:LoadImage()
	if self.loading then
		self.needRefresh = true

		return
	end

	self.loading = true

	self.view:SetImageByUrl(self.instagram:GetImage(), self.image, function()
		self.loading = false

		if self.needRefresh then
			self.needRefresh = false

			self:LoadImage()
		end

		return
	end)

	return
end

function InstagramCard:AddCommentTimer(arg_5_1)
	local var_5_0 = arg_5_1:GetFastestRefreshTime()

	if var_5_0 then
		local var_5_1 = var_5_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_5_1 <= 0 then
			self.view:emit(InstagramMediator.ON_COMMENT_LIST_UPDATE, arg_5_1.id)
		else
			self.timer = Timer.New(function()
				self.view:emit(InstagramMediator.ON_COMMENT_LIST_UPDATE, arg_5_1.id)

				return
			end, var_5_1, 1)

			self.timer:Start()
		end
	end

	return
end

function InstagramCard:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function InstagramCard:Dispose()
	self:RemoveTimer()

	self.loading = false
	self.needRefresh = false

	return
end

return InstagramCard
